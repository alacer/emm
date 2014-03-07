// DeveloperWorksXML class
//
// This sample class is designed to validate and transform 
// articles and tutorials for IBM developerWorks.
// The four possible arguments are:
//   xmlfile schemafile xslfile and outputfile. Defaults are:
//   xmlfile="index.xml"
//   schemafile = "../schema/dwVersion/dw-document-" + dwVersion + ".xsd"
//   xslfile = "../xsl/dwVersion/dw-document-html-" + dwVersion + ".xsl"
//   outputfile = "index.html"
//   where dwVersion is currently 6.0
// The default usage assumes the dw author template standard
// directory layout.
// See the "Author guidelines" tab at 
// http://www.ibm.com/developerworks/aboutdw/
// for more information on how to use this program.
// © Copyright IBM Corporation 2004, 2007. All rights reserved.

import java.lang.System;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.DocumentFragment;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.InputSource;

import javax.xml.XMLConstants;

import javax.xml.namespace.NamespaceContext;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.transform.sax.SAXTransformerFactory;

import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.dom.DOMSource;

import javax.xml.xpath.XPathFactory; // import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathConstants;

public class DeveloperWorksXML {

	private static final String dwVersion = "6.0";

	// XMLErrorHandler handles parsing errors. It extends DefaultHandler.
	// See
	// http://xml.apache.org/xerces2-j/javadocs/api/org/xml/sax/helpers/DefaultHandler.html
	private class XMLErrorHandler extends DefaultHandler {
		public boolean validationError = false;
		public SAXParseException saxParseException = null;

		public void error(SAXParseException exception) throws SAXException {
			validationError = true;
			saxParseException = exception;
		}

		public void fatalError(SAXParseException exception) throws SAXException {
			validationError = true;
			saxParseException = exception;
		}

		public void warning(SAXParseException exception) throws SAXException {
			// validationError=true;
			// saxParseException=exception;
		}
	}

	private class MyXSLNamespaceContext implements NamespaceContext {
		public String getNamespaceURI(String prefix) {
			if (prefix.equals("xsl"))
				return "http://www.w3.org/1999/XSL/Transform";
			else
				return XMLConstants.NULL_NS_URI;
		}

		public String getPrefix(String namespace) {
			if (namespace.equals("http://www.w3.org/1999/XSL/Transform"))
				return "xsl";
			else
				return null;
		}

		public Iterator<String> getPrefixes(String namespace) {
			return null;
		}
	}

	private DocumentBuilderFactory createDocBuilderFactory(boolean validating) {
		DocumentBuilderFactory docFactory = null;
		// System.setProperty("javax.xml.parsers.DocumentBuilderFactory",
		// "org.apache.xerces.jaxp.DocumentBuilderFactoryImpl");
		try {
			docFactory = DocumentBuilderFactory.newInstance();
			docFactory.setNamespaceAware(true);
			docFactory.setCoalescing(true);
			docFactory.setValidating(validating);
		} catch (FactoryConfigurationError fce) {
			System.out.println(fce.getMessage());
			System.out.println("Try adding xml-apis.jar and xercesImpl.jar to");
			System.out
					.println("your classpath (See http://xml.apache.org/xerces2-j/)");
		}
		return docFactory;
	}

	private XPath createXPath() {
		XPathFactory factory = XPathFactory.newInstance();
		return factory.newXPath();
	}

	private Element getDoctypeNode(Document domdoc) {
		XPath xpath = createXPath();
		Object result = null;
		try {
			result = xpath.evaluate("/dw-document//*", domdoc,
					XPathConstants.NODE);
                        /* KP beta start */
                        if (result == null) {
                                result = xpath.evaluate("/*", domdoc,
				        	XPathConstants.NODE);
                        }
                        /* KP beta end */
		} catch (XPathExpressionException xpe) {
			System.out.println("XPathExpressionException " + xpe.getMessage());
		}
		return (Element) result;
	}

	private void transformXML(Document domdoc, Element docTypeNode,
			String systemId, String xslUrl, String outputHtml)
			throws TransformerException, TransformerConfigurationException,
			FileNotFoundException, IOException {

		// The javax.xml.transform.TransformerFactory system property
		// determines the class to instantiate --
		// org.apache.xalan.transformer.TransformerImpl.
		TransformerFactory transformerFactory = TransformerFactory
				.newInstance();
		Transformer stylesheet = null;
		DocumentBuilderFactory docFactory = null;
		Document fragmentDoc = null;
		String localSite = null;
		if (xslUrl != null) {
			XPath xpath = createXPath();
			{
				try {
					localSite = docTypeNode.getAttribute("local-site");
					Object result = xpath.evaluate("./id", docTypeNode,
							XPathConstants.NODE);
					Element idElement = (Element) result;
					if (idElement == null) {
						idElement = domdoc.createElement("id");
						idElement.setAttribute("domino-uid", "");
						idElement.setAttribute("content-id", "");
						idElement.setAttribute("original", "yes");
						idElement.setAttribute("cma-id", "12345");
						docTypeNode.insertBefore(idElement, docTypeNode
								.getFirstChild());
					} else {
						if (idElement.getAttribute("cma-id").equals("0")
								|| idElement.getAttribute("cma-id").equals("")) {
							idElement.setAttribute("cma-id", "12345");
						}
					}
				} catch (XPathExpressionException xpe) {
					System.out.println("XPathExpressionException "
							+ xpe.getMessage());
				}
			}
			docFactory = createDocBuilderFactory(false);
			if (docFactory != null) {
				try {
					// Parse the stylesheet and also use the factory while
					// we have it to create a doc that we will need later
					DocumentBuilder docBuilder = docFactory
							.newDocumentBuilder();
					Document xslDOM = docBuilder.parse(new InputSource(xslUrl));
					String xslDir = (new File(xslUrl)).getParentFile().getCanonicalPath() + File.separatorChar;
					String xslFileName = (new File(xslUrl)).getName();
					if (xslFileName.indexOf(localSite) < 0) {
                                            int periodPlace = xslFileName.lastIndexOf(".");
                 		            int hyphenPlace = 1 + xslFileName.lastIndexOf("-");
                                            String translatedTextFile = null;
					    if ((hyphenPlace > 0) && (periodPlace > hyphenPlace)) {
                                                 translatedTextFile = "dw-translated-text-"
						     + localSite + "-" + 
						     xslFileName.substring(hyphenPlace, periodPlace) + 
							 ".xsl";
					    } else {
                                                 translatedTextFile = "dw-translated-text-"
         					    + localSite + "-" + dwVersion + ".xsl";
					    }
					try {
						xpath.setNamespaceContext(new MyXSLNamespaceContext());
						Object result = xpath.evaluate("//xsl:include[starts-with(@href, 'dw-translated-text')]", xslDOM,
								XPathConstants.NODE);
						if (result != null) {
							Element translatedTextElement = (Element) result;
							translatedTextElement.setAttribute("href",
									translatedTextFile);
									}
					} catch (XPathExpressionException xpe) {
						System.out.println("XPathExpressionException "
								+ xpe.getMessage());
					}
					}
					DOMSource xslDOMSource = new DOMSource(xslDOM, xslDir);
					stylesheet = transformerFactory.newTransformer(xslDOMSource); 
					fragmentDoc = docBuilder.newDocument();

				} catch (NoClassDefFoundError nce) {
					System.out.println("Missing class " + nce.getMessage());
					System.out.println("Try adding xml-apis.jar and xercesImpl.jar to");
					System.out.println("your classpath (See http://xml.apache.org/xerces2-j/)");
				} catch (java.io.IOException ioe) {
					System.out.println("IOException " + ioe.getMessage());
				} catch (SAXException e) {
					System.out.println("SAXException " + e.getMessage());
				} catch (ParserConfigurationException e) {
					System.out.println("ParserConfigurationException "
							+ e.getMessage());
				}
			}
		}

		StreamResult streamOut = new StreamResult(new FileOutputStream(
				outputHtml));
		streamOut.setSystemId(outputHtml);

		SAXTransformerFactory saxFactory = null;
		try {
			TransformerFactory tfactory = TransformerFactory.newInstance();
			saxFactory = (SAXTransformerFactory) tfactory;
		} catch (TransformerFactoryConfigurationError pfe) {
			System.out.println("Transformer factory configuration error "
					+ pfe.getMessage());
		}
		if ((saxFactory != null) && (stylesheet != null)
				&& (fragmentDoc != null)) {
			Transformer transformer = stylesheet;
			// Set the output format
			transformer.setOutputProperty(OutputKeys.METHOD, "xml");
			transformer.setParameter("xform-type", "preview");
			DocumentFragment domResult = fragmentDoc.createDocumentFragment();
			// Transformer extensions don't work if SystemId is not specified.
			transformer.transform(new DOMSource(domdoc, systemId),
					new DOMResult(domResult));
			// Serialize output to streamOut stream
			Transformer serializer = saxFactory.newTransformer();
			serializer.setOutputProperties(stylesheet.getOutputProperties());
			serializer.transform(new DOMSource(domResult), streamOut);
		}

		// Close output file
		if (streamOut != null) {
			java.io.OutputStream outputStream = streamOut.getOutputStream(); // Java
			// 1.4.2
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (java.io.IOException ioe) {
				System.out.println("IOException " + ioe.getMessage());
			}
		}
	}

	private Document validateXML(String schemaUrl, String xmlDocumentUrl) {
		Document domdoc = null;
		DocumentBuilderFactory docFactory = createDocBuilderFactory(schemaUrl != null);
		if (docFactory != null) {
			try {
				if (schemaUrl != null) {
					docFactory
							.setAttribute(
									"http://java.sun.com/xml/jaxp/properties/schemaLanguage",
									"http://www.w3.org/2001/XMLSchema");
					docFactory
							.setAttribute(
									"http://java.sun.com/xml/jaxp/properties/schemaSource",
									schemaUrl);
				}
				DocumentBuilder builder = docFactory.newDocumentBuilder();
				XMLErrorHandler handler = new XMLErrorHandler();
				builder.setErrorHandler(handler);
				domdoc = builder.parse(new InputSource(xmlDocumentUrl));
				if (handler.validationError) {
					System.out.println("handler found error");

					domdoc = null;
					// Ooops. Document has errors, so tell the user about
					// them (well, at least the first one).
					// Give location (line,col) plus error message
					System.out.println("XML Document has Error: "
							+ handler.validationError + " at line "
							+ handler.saxParseException.getLineNumber()
							+ " column "
							+ handler.saxParseException.getColumnNumber());
					System.out.println(handler.saxParseException.getMessage());
				} else {
				}
			} catch (NoClassDefFoundError nce) {
				System.out.println("Missing class " + nce.getMessage());
				System.out
						.println("Try adding xml-apis.jar and xercesImpl.jar to");
				System.out
						.println("your classpath (See http://xml.apache.org/xerces2-j/)");
			} catch (java.io.IOException ioe) {
				System.out.println("IOException " + ioe.getMessage());
			} catch (SAXException e) {
				System.out.println("XML Document has Error: ");
				System.out.println("SAXException " + e.getMessage());
				domdoc = null;
			} catch (ParserConfigurationException e) {
				System.out.println("ParserConfigurationException "
						+ e.getMessage());
			}
		}
		return domdoc; // Null if did not pass schema check
	}

	public static void main(String[] argv) throws TransformerException,
			TransformerConfigurationException, FileNotFoundException,
			IOException {
		String minLevel = "1.4";
		String sysVersion = System.getProperty("java.specification.version");
		System.out.println("Using Java runtime version "
				+ System.getProperty("java.runtime.version") + " from "
				+ System.getProperty("java.vm.vendor"));

		if (minLevel.compareTo(sysVersion) <= 0) {
			String xmlDocumentUrl;
			String schemaUrl = null;
			String transformUrl = null;
			String outputFile;
			if (argv.length >= 1) {
				xmlDocumentUrl = argv[0];
			} else {
				xmlDocumentUrl = "index.xml";
			}
			if (argv.length == 1) {
				schemaUrl = "../schema/" + dwVersion + "/dw-document-"
						+ dwVersion + ".xsd";
				transformUrl = "../xsl/" + dwVersion + "/dw-document-html-"
						+ dwVersion + ".xsl";
			}
			if (argv.length == 2) {
				if (argv[1].toLowerCase().endsWith(".xsd")) {
					schemaUrl = argv[1];
				} else if (argv[1].toLowerCase().endsWith(".xsl")) {
					transformUrl = argv[1];
				}
			}
			if (argv.length >= 3) {
				schemaUrl = argv[1];
				transformUrl = argv[2];
			}
			if (argv.length >= 4) {
				outputFile = argv[3];
			} else {
				String s1 = xmlDocumentUrl /* xfile.getCanonicalPath() */;
				int periodPlace = s1.lastIndexOf(".");
				if (periodPlace > 0) {
					outputFile = s1.substring(0, periodPlace) + ".html";
				} else {
					outputFile = s1 + ".html";
				}
			}
			boolean filesExist = true;
			File xfile = new File(xmlDocumentUrl);
			filesExist = filesExist && xfile.exists() && xfile.canRead();
			if ((!xfile.exists()) || (!xfile.canRead())) {
				System.out.println("Input file\n  " + xmlDocumentUrl
						+ "\ndoes not exist or cannot be read.");
				filesExist = false;
			}
			File sfile = null;
			if (schemaUrl != null) {
				sfile = new File(schemaUrl);
				if ((!sfile.exists()) || (!sfile.canRead())) {
					System.out.println("Schema file\n  " + schemaUrl
							+ "\ndoes not exist or cannot be read.");
					filesExist = false;
				}
			}
			File tfile = null;
			if (transformUrl != null) {
				tfile = new File(transformUrl);
				if ((!tfile.exists()) || (!tfile.canRead())) {
					System.out.println("XSLT file\n  " + transformUrl
							+ "\ndoes not exist or cannot be read.");
					filesExist = false;
				}
			}
			if (filesExist) {
				DeveloperWorksXML dwxml = new DeveloperWorksXML();
				Document domdoc = dwxml.validateXML(schemaUrl, xmlDocumentUrl);
				if (domdoc != null) {
					Element docTypeNode = dwxml.getDoctypeNode(domdoc);
					if (schemaUrl != null) {
						System.out.println("Input file\n  "
								+ xfile.getCanonicalPath());
                        /* KP beta start */
                        if ( docTypeNode.getLocalName() == "kp") {
						System.out.println("is a valid "
								+ "dw-kp-beta"
								+ " using schema\n  "
								+ sfile.getCanonicalPath() + "\n");
                        } else {
                        /* KP beta end */
						System.out.println("is a valid "
								+ docTypeNode.getLocalName() + " for site "
								+ docTypeNode.getAttribute("local-site")
								+ " using schema\n  "
								+ sfile.getCanonicalPath() + "\n");
                                                
                        /* KP beta start */
                        } 
                        /* KP beta end */
					}
					if (transformUrl != null) {
						System.out
								.println("Transforming for developerWorks"
										+ ".\nUsing stylesheet\n  "
										+ tfile.getCanonicalPath() + "\n");
						dwxml.transformXML(domdoc, docTypeNode, xmlDocumentUrl,
								transformUrl, outputFile);
						File ofile = new File(outputFile);
						if (ofile.exists() && ofile.canRead()) {
							System.out.println("Output file is\n  "
									+ ofile.getCanonicalPath());
						} else {
							System.out
									.println("Transformation failure creating\n  "
											+ outputFile);
						}
					}
				} else {
					System.out
							.println("Transforming bypassed because of validation errors");
				}
			}
		} else {
			System.out
					.println("This program requires Java 5.0 or higher. You are using "
							+ sysVersion
							+ " from "
							+ System.getProperty("java.vm.vendor"));
		}
	}
}
