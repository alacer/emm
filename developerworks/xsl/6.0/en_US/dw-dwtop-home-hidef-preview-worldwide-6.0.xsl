<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
    
<xsl:template name="dw-dwtop-home-hidef-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dw = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>developerWorks : IBM's resource for developers and IT professionals</title>
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
<meta name="Owner" content="developerWorks Content/Raleigh/IBM"/>
<meta name="DC.Language" scheme="rfc1766" content="en"/>
<meta name="IBM.Country" content="ZZ"/>
<meta name="Security" content="Public"/>
<meta name="IBM.SpecialPurpose" content="SP001"/>
<meta name="IBM.PageAttributes" content="sid=1003"/>
<meta name="Source" content="v16 Template Generator"/>
<meta name="Robots" content="index,follow"/>
<meta name="Abstract" content="On developerWorks, IBM's resource for developers and IT professionals, access tools, code, training, forums, blogs, community, standards, IT samples, downloads and how-to documentation for Rational, WebSphere, Information Management, Lotus, Tivoli, AIX and UNIX, architecture, and Web development, plus open source development and cross-platform, open standards technologies including Java, Linux, XML, SOA and Web services, Autonomic computing, Multicore acceleration."/>
<meta name="Description" content="On developerWorks, IBM's resource for developers and IT professionals, access tools, code, training, forums, blogs, community, standards, IT samples, downloads and how-to documentation for Rational, WebSphere, Information Management, Lotus, Tivoli, AIX and UNIX, architecture, and Web development, plus open source development and cross-platform, open standards technologies including Java, Linux, XML, SOA and Web services, Autonomic computing, Multicore acceleration."/>
<meta name="Keywords" content="Rational, WebSphere, DB2, Informix, Information Management, IBM Systems, Lotus, Tivoli, Autonomic computing, Grid computing, Java, XML, Linux, open source, Web architecture, SOA, Web services, Wireless, Power Architecture, Multicore acceleration, tutorials, training, online courses, how-to, tips, tools, code, education, forums, blogs, articles, events, Webcasts, technical briefings, downloads, best practices, developer, programmer, system administrator, architect, computer programming resources, developer resources, software development, application development, free programming training, free programming tutorials, programming how to, components, objects, on-demand business, Software Development Platform"/>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Date</xsl:attribute>
    <xsl:attribute name="scheme">iso8601</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcDate</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Type</xsl:attribute>
    <xsl:attribute name="scheme">IBM_ContentClassTaxonomy</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcType</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Subject</xsl:attribute>
    <xsl:attribute name="scheme">IBM_SubjectTaxonomy</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcSubject</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCHPGZZ" />
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Rights</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcRights</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">IBM.Effective</xsl:attribute>
    <xsl:attribute name="scheme">W3CDTF</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">ibmEffective</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://dw1.s81c.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/zz/en/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://dw1.s81c.com/developerworks/css/dw-screen-landing.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<!-- xM Masthead/Footer -->
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
<script src="http://dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="http://dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->
<xsl:comment> Dynamic tabs script </xsl:comment>
<script type="text/javascript" src="http://dw1.s81c.com/common/js/dyntabs.js" >//</script>
<xsl:comment> RESERVED_HEADER_INCLUDE </xsl:comment>    
</head>

<body id="ibm-com">
<div id="ibm-top" class="ibm-landing-page">

<xsl:comment> MASTHEAD_BEGIN </xsl:comment>
<div class="ibm-access"><a href="#ibm-content">Skip to main content</a></div>
<div id="ibm-masthead-dw">
	<div id="dw-masthead-top-row">
		<ul id="ibm-unav-home-dw">
			<li id="ibm-logo">
				<a href="http://www.ibm.com/us/en/"><img src="http://dw1.s81c.com/developerworks/i/mf/ibm-smlogo.gif" width="44" height="16" alt="IBM®" /></a>
			</li>
		</ul>
	</div>
	<div id="ibm-universal-nav-dw">
		<img src="http://dw1.s81c.com/developerworks/i/mf/dw-mast-orange-slim.jpg" width="930" height="75" alt="developerWorks®" />
	</div>
</div>
<xsl:comment> MASTHEAD_END </xsl:comment>

<div id="ibm-pcon">

<xsl:comment> CONTENT_BEGIN </xsl:comment>
<div id="ibm-content">
    
<xsl:comment> LEADSPACE_BEGIN </xsl:comment>
<!-- <#if dw.feature?exists>${dw.feature}</#if> -->
<xsl:apply-templates select=".">
    <xsl:with-param name="template">feature</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> LEADSPACE_END </xsl:comment> 
    
<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
	<xsl:with-param name="template">tabbedModule</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
	<xsl:with-param name="template">moduleDocbody</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>    

<xsl:apply-templates select=".">
    <xsl:with-param name="template">cmaSiteStylesheetId</xsl:with-param>
</xsl:apply-templates>

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment>

<xsl:comment> Spotlight_Start </xsl:comment>
<div class="ibm-container">
<h2>Spotlight</h2>
<div class="ibm-container-body dw-right-bullet-list">
<xsl:apply-templates select=".">
<xsl:with-param name="template">spotlight</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> New_site_feature  </xsl:comment>
<!-- <#if sitefeature?exists>${sitefeature}</#if> -->
</div>
</div>
<xsl:comment> Spotlight_End </xsl:comment>
<xsl:apply-templates select=".">
    <xsl:with-param name="template">highVisModule</xsl:with-param>
</xsl:apply-templates>
<!-- Generic right column modules and top and bottom includes -->
<xsl:apply-templates select=".">
    <xsl:with-param name="template">moduleRightDocbody</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> RIGHT_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> RIGHT_COLUMN_END </xsl:comment>

<xsl:comment> CONTENT_BODY_END </xsl:comment>
</div>

</div>
<xsl:comment> CONTENT_END </xsl:comment>

<xsl:comment> END_IBM-PCON </xsl:comment>
</div>
    
<xsl:comment> SPECIAL_OFFERS_BEGIN </xsl:comment>
<!-- <#if specialOffers?exists>${specialOffers}</#if> -->
<xsl:comment> SPECIAL_OFFERS_END </xsl:comment>

<xsl:comment> FOOTER_BEGIN </xsl:comment>
<div id="ibm-footer">
<!-- IBM footer container; disabled -->
</div>

<div id="ibm-page-tools-dw">

<div id="dw-footer-top-row" class="dw-mf-minimal"></div>

</div>

<div id="ibm-footer-module-dw" class="dw-mf-minimal"></div>
<xsl:comment> FOOTER_END </xsl:comment>

<xsl:comment> END_IBM-TOP </xsl:comment>
</div>

<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<xsl:comment> INCLUDES_FOR_SCRIPTS_AFTER_FOOTER </xsl:comment>
<!-- <script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/aculo/prototypelt.js">//</script> -->
<!-- <script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/dwspace/gadgetpopup.min.js">//</script> -->
<!-- <script type="text/javascript" language="JavaScript" src="//static.delicious.com/js/playtagger.js"></script> -->
<!-- <script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/portal/js/dwspace/dwdeli.js"></script> -->
<xsl:comment> INCLUDES_AFTER_FOOTER_END </xsl:comment>

</body>
</html>
</xsl:template>
</xsl:stylesheet>