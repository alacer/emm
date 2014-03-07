<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-sidefile-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwsidefile = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_content_map?exists><#assign dwcontentmap = dw_content_map /></#if> -->
<!-- <#if dw_request_details?exists><#assign dwrequest = dw_request_details /></#if> -->

  <html xmlns="http://www.w3.org/1999/xhtml" lang="ja-JP" xml:lang="ja-JP">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title><xsl:apply-templates select=".">
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></title>
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
  <meta name="Owner" content="https://www.ibm.com/developerworks/secure/feedback.jsp?domain=dwjapan"/>
  <meta name="DC.Language" scheme="rfc1766" content="ja-JP"/>
  <meta name="IBM.Country" content="JP"/>
<meta name="Security" content="Public"/>
<meta name="IBM.SpecialPurpose" content="SP001"/>
<meta name="IBM.PageAttributes" content="sid=1003"/>
<meta name="Source" content="v16 Template Generator"/>
<meta name="Robots" content="index,follow"/>
<xsl:element name="meta">
<xsl:attribute name="name">Abstract</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">abstract</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">Description</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">abstract</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">Keywords</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">keywords</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">DC.Date</xsl:attribute>
<xsl:attribute name="scheme">iso8601</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">dcDate</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">DC.Type</xsl:attribute>
<xsl:attribute name="scheme">IBM_ContentClassTaxonomy</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">dcType</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">DC.Subject</xsl:attribute>
<xsl:attribute name="scheme">IBM_SubjectTaxonomy</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">dcSubject</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:if test="boolean(.//content-area-primary/@name)">
  
  <xsl:choose>
    <xsl:when test=".//content-area-primary/@name = 'aix' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCAIXJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'data' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIMTJP" />  
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'lotus' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLOTJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'rational' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCRATJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'tivoli' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCTIVJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'websphere' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCWSPJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'architecture' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCARCJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'java' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCJVAJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'linux' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLNXJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'power' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCMACJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'opensource' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOSRJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'ibm' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSCNJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'webservices' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSOAJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'web' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCDEVJP" />
    </xsl:when>
    <xsl:when test=".//content-area-primary/@name = 'xml' ">
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCXMLJP" />
    </xsl:when>
    <xsl:otherwise>
      <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOTHJP" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:if> 
<xsl:element name="meta">
<xsl:attribute name="name">DC.Rights</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">dcRights</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:element name="meta">
<xsl:attribute name="name">IBM.Effective</xsl:attribute>
<xsl:attribute name="scheme">W3CDTF</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">ibmEffective</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://www.ibm.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://www.ibm.com/common/v16/css/jp/ja/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://www.ibm.com/developerworks/css/dw-screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://www.ibm.com/developerworks/css/dw-local-site.css" rel="stylesheet" type="text/css"/>
<link href="http://www.ibm.com/developerworks/css/dw-screen-sidefile.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/> 
  <!-- xM Masthead/Footer -->
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
  <script src="//dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="//dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->
<xsl:comment> RESERVED_HEADER_INCLUDE </xsl:comment>


<script language="JavaScript" type="text/javascript">
 <xsl:comment>
 function openNewWindow(url,tar,arg){window.open(url,tar,arg);}
 //</xsl:comment>
</script>
</head>

<body id="ibm-com">
<div id="ibm-top" class="ibm-landing-page">

  <xsl:comment> MASTHEAD_BEGIN </xsl:comment>
  <!-- MASTHEAD_BEGIN -->
  <div class="ibm-access"><a href="#ibm-content">本文へジャンプ</a></div>
  <div id="ibm-masthead-dw">
    <div id="dw-masthead-top-row">
      <ul id="ibm-unav-home-dw">
        <li id="ibm-logo">
          <a href="http://www.ibm.com/jp/ja/"><img src="http://dw1.s81c.com/developerworks/i/mf/ibm-smlogo.gif" width="44" height="16" alt="IBM®" /></a>
        </li>
      </ul>
    </div>
    <div id="ibm-universal-nav-dw">
      <img src="http://dw1.s81c.com/developerworks/i/mf/dw-mast-orange-slim.jpg" width="930" height="75" alt="developerWorks®" />
    </div>
  </div>
  <!-- MASTHEAD_END -->
  <xsl:comment> MASTHEAD_END </xsl:comment>
<div id="ibm-pcon">

<xsl:comment> CONTENT_BEGIN </xsl:comment>
<div id="ibm-content">

<xsl:comment> Navigation_Trail_BEGIN </xsl:comment>
<xsl:comment> <!-- <#if breadcrumb?exists>${breadcrumb}<#else>&nbsp;</#if> --> </xsl:comment>
<xsl:if test="boolean(.//content-area-primary/@name)">
<!-- <#if200 dwrequest.zone == "default_zone"> -->
 <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone" select="//content-area-primary/@name"></xsl:with-param>
</xsl:apply-templates>
<!-- 
  <#elseif200 dwrequest.zone == "aix">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">aix</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "data">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">data</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "lotus">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">lotus</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "rational">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">rational</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "tivoli">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">tivoli</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "websphere">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">websphere</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "architecture">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">architecture</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "java">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">java</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "linux">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">linux</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "power">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">power</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "opensource">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">opensource</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "webservices">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">webservices</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "web">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">web</xsl:with-param>
</xsl:apply-templates>
  <#elseif200 dwrequest.zone == "xml">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone">xml</xsl:with-param>
</xsl:apply-templates>
  <#else200>
    &nbsp;
  </#if200> -->
</xsl:if>
<xsl:comment> Navigation_Trail_END </xsl:comment>

<xsl:comment> dW_Summary Area_START </xsl:comment>
<div id="dw-summary-article">

<div class="dw-content-head">
<xsl:apply-templates select=".">
<xsl:with-param name="template">title</xsl:with-param>
</xsl:apply-templates>
</div>

</div>
<xsl:comment> dW_Summary_Area_END </xsl:comment>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

<xsl:comment> Reserved center 1 include_Begin </xsl:comment>


<xsl:comment> MAIN_COLUMN_CONTAINER_BEGIN </xsl:comment>
<div class="ibm-container">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">docbody</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> MAIN_COLUMN_CONTAINER_END </xsl:comment>

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>

<xsl:comment> CONTENT_BODY_END </xsl:comment>
</div>

</div>
<xsl:comment> CONTENT_END </xsl:comment>

 <xsl:comment> END_IBM-PCON </xsl:comment>
</div>

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
 
 <xsl:comment> SCRIPTS_INCLUDE_BEGIN </xsl:comment>


<div id="ibm-metrics">
<!-- <script src="//dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
