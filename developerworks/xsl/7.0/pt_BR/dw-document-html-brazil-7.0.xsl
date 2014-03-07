<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
    <!-- The following global parameters describe what template output is passed back to the Maverick engine  -->
	<xsl:param name="template" select=" 'preview' "/>
	<xsl:param name="transform-zone" select=" '' "/>
    <!-- Call main xsl file and locale-specific xsl files --> 
	<!-- v17 Enablement jpp 09/24/2011:  Updated dw-document file name to 7.0 -->
    <xsl:include href="../dw-document-html-7.0.xsl" />
    <xsl:include href="dw-translated-text-brazil-7.0.xsl" />
	<!-- v17 Enablement jpp 09/24/2011:  Added preview stylesheet call to this file -->
	<!-- Preview stylesheet -->
	<xsl:include href="../dw-content-preview-7.0.xsl"/> 
</xsl:stylesheet>
