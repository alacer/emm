<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">

<!-- Embed XSL file with interior layouts -->
<xsl:import href="dw-home-layouts-preview-7.0.xsl"/>
<!-- Project Defiant jpp 10/06/11: Embedded dw-results-layouts-preview-7.0.xsl -->
<xsl:import href="dw-results-layouts-preview-7.0.xsl"/>

<xsl:param name="namespace">xmlns</xsl:param>
    
<xsl:template name="dw-content-preview">

<!-- META_HEAD_AREA_BEGIN -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>
<xsl:element name="html">
    <xsl:attribute name="{$namespace}">http://www.w3.org/1999/xhtml</xsl:attribute>
    <xsl:attribute name="lang">
        <xsl:call-template name="MetaLanguageCountry-v17">
            <xsl:with-param name="return">htmltag</xsl:with-param>
        </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="xml:lang">
        <xsl:call-template name="MetaLanguageCountry-v17">
            <xsl:with-param name="return">htmltag</xsl:with-param>
        </xsl:call-template>
    </xsl:attribute>
</xsl:element>
<head>
<xsl:element name="meta">
    <xsl:attribute name="http-equiv">Content-Type</xsl:attribute>
    <xsl:attribute name="content">text/html; charset=UTF-8</xsl:attribute>
</xsl:element>
<xsl:element name="title">
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">titletag</xsl:with-param>
    </xsl:apply-templates>
</xsl:element>
<xsl:element name="link">
    <xsl:attribute name="rel">schema.DC</xsl:attribute>
    <xsl:attribute name="href">http://purl.org/DC/elements/1.0/</xsl:attribute>
</xsl:element>
<xsl:element name="link">
    <xsl:attribute name="rel">SHORTCUT ICON</xsl:attribute>
    <xsl:attribute name="href">http://www.ibm.com/favicon.ico</xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Rights</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcRights</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Keywords</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">keywords</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
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
    <xsl:attribute name="name">Source</xsl:attribute>
    <xsl:attribute name="content">v17 Template Generator</xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Security</xsl:attribute>
    <xsl:attribute name="content">Public</xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Abstract</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">abstract</xsl:with-param>
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
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Subject</xsl:attribute>
    <xsl:attribute name="scheme">IBM_SubjectTaxonomy</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">dcSubject</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Owner</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">owner</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Language</xsl:attribute>
    <xsl:attribute name="scheme">rfc1766</xsl:attribute> 
    <xsl:attribute name="content">
        <xsl:call-template name="MetaLanguageCountry-v17">
            <xsl:with-param name="return">dclanguage</xsl:with-param>
        </xsl:call-template>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">IBM.SpecialPurpose</xsl:attribute>
    <xsl:attribute name="content">SP001</xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">IBM.Country</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:call-template name="MetaLanguageCountry-v17">
            <xsl:with-param name="return">ibmcountry</xsl:with-param>
        </xsl:call-template>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Robots</xsl:attribute>
    <xsl:attribute name="content">index,follow</xsl:attribute>
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
    <xsl:attribute name="name">Description</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">abstract</xsl:with-param>
        </xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<!-- IBM_WTMCategory meta tag is calculated in the master FTL file and is not created in the preview -->
<xsl:comment> HEADER_SCRIPTS_AND_CSS </xsl:comment>
<link href="http://1.www.s81c.com/common/v17/css/www.css" rel="stylesheet" title="www" type="text/css"/>
<script src="http://1.www.s81c.com/common/js/dojo/www.js" type="text/javascript">//</script>
<xsl:comment> dW-specific JS and CSS </xsl:comment>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/eventtarget.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/flash-detect.js">//</script>
<script type="text/javascript" src="http://dw1.s81c.com/developerworks/js/v17/dw-www.js">//</script>
<script type="text/javascript">
	dojo.addOnLoad(function(){
		rBHash = null;
		rBHash = new Object();
		rBHash['viperLang'] = 'en';
		rBHash['urlLang'] = 'en';

		dwsi.siInst = new dwweb.dynnav.dwsi();
		dwsi.siInst.initSI();
	});
</script>
<link href="http://dw1.s81c.com/developerworks/css/v17/dw-landing-6.css" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/css/v17/dw-home-6.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>

<!-- Project Defiant jpp 10/31/11: Get leadspace style for content type, if needed -->
<xsl:comment> LEADSPACE_STYLES </xsl:comment>
<xsl:apply-templates select=".">
	<xsl:with-param name="template">leadspaceStyles</xsl:with-param>
</xsl:apply-templates>
</head>
<!-- META_HEAD_AREA_END -->

<body id="ibm-com">

<!-- Need to add conditional coding to support content types with left navigation (<div id="ibm-top">) -->
		<!-- <div id="ibm-top" class="ibm-landing-page dw-home-page"> -->
				<!-- <div id="ibm-top" class="ibm-landing-page"> -->
<xsl:choose>
	<xsl:when test="/dw-document//@layout='HomeStandard'">
		<xsl:element name="div">
			<xsl:attribute name="id">ibm-top</xsl:attribute>
			<xsl:attribute name="class">ibm-landing-page dw-home-page</xsl:attribute>
		</xsl:element>
	</xsl:when>
	<xsl:otherwise>
		<xsl:element name="div">
			<xsl:attribute name="id">ibm-top</xsl:attribute>
			<xsl:attribute name="class">ibm-landing-page</xsl:attribute>
		</xsl:element>
	</xsl:otherwise>
</xsl:choose>

<xsl:comment> MASTHEAD_BEGIN </xsl:comment>
<!-- PLACEHOLDER_MASTHEAD_BEGIN -->
<div id="ibm-masthead">
<div id="ibm-mast-options"><ul>
<li id="ibm-geo"><!-- <a href="http://www.ibm.com/planetwide/select/selector.html"><span class="ibm-access">Select a country/region: </span>Worldwide</a> --></li>
</ul></div>
<div id="ibm-universal-nav">
<ul id="ibm-unav-links">
<li id="ibm-home"><a href="http://www.ibm.com/us/en/">IBM®</a></li>
</ul>
<div id="ibm-search-module"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
</div>
</div>
<!-- PLACEHOLDER_MASTHEAD_END -->
<xsl:comment> MASTHEAD_END </xsl:comment>

<!-- Call Interior Layout file -->
<!-- Project Defiant jpp 10/12/11: Created variable and choice to select interior layout  -->
<xsl:variable name="layoutCall">
	<xsl:value-of select="/dw-document//@layout"/>
</xsl:variable>
<xsl:choose>
	<xsl:when test="$layoutCall='HomeStandard'"><xsl:call-template name="HomeStandard"/></xsl:when>
	<xsl:when test="$layoutCall='ResultsTrending'"><xsl:call-template name="ResultsTrending"/></xsl:when>
</xsl:choose>

<xsl:comment> FOOTER_BEGIN </xsl:comment>
<!-- PLACEHOLDER_FOOTER_BEGIN -->
<!-- <div id="ibm-footer-module"></div> -->
<div id="ibm-footer">
<h2 class="ibm-access">Footer links</h2>
<ul>
<li><a href="http://www.ibm.com/developerworks/">developerWorks Worldwide</a></li>
<li><a href="http://www.ibm.com/contact/us/en/">Contact</a></li>
<li><a href="http://www.ibm.com/privacy/us/en/">Privacy</a></li>
<li><a href="http://www.ibm.com/legal/us/en/">Terms of use</a></li>
<li><a href="http://www.ibm.com/accessibility/us/en/">Accessibility</a></li>
</ul>
</div>
<!-- PLACEHOLDER_FOOTER_END -->
<xsl:comment> FOOTER_END </xsl:comment>

<xsl:comment> END_IBM-TOP </xsl:comment>
<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>


<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

</body>
<xsl:text disable-output-escaping="yes"><![CDATA[</html>]]></xsl:text>
</xsl:template>
</xsl:stylesheet>