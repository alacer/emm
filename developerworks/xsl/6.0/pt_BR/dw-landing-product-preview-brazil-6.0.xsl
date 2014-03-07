<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-landing-product-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwzoneoverview = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_content_map?exists><#assign dwcontentmap = dw_content_map /></#if> -->
<!-- <#if dw_request_details?exists><#assign dwrequest = dw_request_details /></#if> -->

  <html xmlns="http://www.w3.org/1999/xhtml" lang="pt-BR" xml:lang="pt-BR">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title><xsl:apply-templates select=".">
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></title>
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
  <meta name="Owner" content="dWbr@br.ibm.com"/>
  <meta name="DC.Language" scheme="rfc1766" content="pt-BR" />
  <meta name="IBM.Country" content="BR" />
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
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCAIXBR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'data' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIMTBR" />  
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLOTBR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCRATBR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'tivoli' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCTIVBR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCWSPBR" />
  </xsl:when>
<xsl:otherwise>
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
<xsl:apply-templates select=".">
<xsl:with-param name="template">webFeedDiscovery</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://www.ibm.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/br/pt/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://www.ibm.com/developerworks/css/dw-screen-landing.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://www.ibm.com/developerworks/css/dw-local-site.css" rel="stylesheet" type="text/css"/>
  <!-- xM Masthead/Footer -->
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
  
  <script src="//dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="//dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->
 <xsl:comment> Dynamic tabs script </xsl:comment>
 <script type="text/javascript" src="//dw1.s81c.com/common/js/dyntabs.js" >//</script>
<xsl:comment>dW functional JS</xsl:comment>
<script language="JavaScript" src="//dw1.s81c.com/developerworks/js/urltactic.js" type="text/javascript">//</script>
<xsl:comment> RESERVED_HEADER_INCLUDE </xsl:comment>
<xsl:comment>****Currently only has overlay**** </xsl:comment>
<link href="//www.ibm.com/common/v16/css/overlay.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<script language="JavaScript" type="text/javascript"> 
 <xsl:comment>
setDefaultQuery('<xsl:apply-templates select="."><xsl:with-param name="template">urltactic</xsl:with-param></xsl:apply-templates>'); 
//</xsl:comment>
</script>
</head>

<body id="ibm-com">
<div id="ibm-top">

  <xsl:comment> MASTHEAD_BEGIN </xsl:comment>
  <div class="ibm-access"><a href="#ibm-content">Avançar para a área de conteúdo</a></div>
  <div id="ibm-masthead-dw">
    <div id="dw-masthead-top-row">
      <ul id="ibm-unav-home-dw">
        <li id="ibm-logo">
          <a href="http://www.ibm.com/br/pt/"><img src="http://dw1.s81c.com/developerworks/i/mf/ibm-smlogo.gif" width="44" height="16" alt="IBM®" /></a>
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

<div class="ibm-content-head">

<xsl:comment> TITLE_BEGIN includes bct </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">title</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> TITLE_END </xsl:comment>
</div>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">abstractProduct</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">feature</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">tabbedModule</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">moduleDocbody</xsl:with-param>
</xsl:apply-templates>
<!-- <#if jiveForums?exists>${jiveForums}</#if> -->
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">cmaSiteStylesheetId</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment> 

<xsl:apply-templates select=".">
<xsl:with-param name="template">highVisModule</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">spotlight</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">moduleRightDocbody</xsl:with-param>
</xsl:apply-templates>
<!-- <#if specialOffers?exists>${specialOffers}</#if> -->
<xsl:comment> RIGHT_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> RIGHT_COLUMN_END </xsl:comment>

<xsl:comment> CONTENT_BODY_END </xsl:comment>
</div>

</div>
<xsl:comment> CONTENT_END </xsl:comment>

<xsl:comment> LEFT_NAVIGATION_BEGIN </xsl:comment>
<xsl:choose>
<xsl:when test=".//content-area-primary/@name = 'data' "> 
  <div id="ibm-navigation">
    <h2 class="ibm-access">Navegación por el Contenido</h2>
    
    <ul id="ibm-primary-links">
      <li id="ibm-overview"><a href="http://www.ibm.com/developerworks/br/data/">Information
        Mgmt</a></li>
      
      <li><a href="http://www.ibm.com/developerworks/br/data/newto/">Introdução a
        Information Mgmt</a></li>
      <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/data/products/">Produtos</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/data/downloads/">Downloads</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/views/data/libraryview.jsp">Biblioteca técnica</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/data/training/">Treinamentos e certificações</a></li>
      <li><a href="http://www.ibm.com/developerworks/data/support/">Suporte (Inglês)</a></li>
    </ul>
  </div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' "> 
  <div id="ibm-navigation">
    <h2 class="ibm-access">Navegación por el Contenido</h2>
    
    <ul id="ibm-primary-links">
      <li id="ibm-overview"><a href="http://www.ibm.com/developerworks/br/lotus/">Lotus</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/lotus/newto/">Introdução a Lotus</a></li>
      <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/lotus/products/">Produtos</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/lotus/downloads/">Downloads</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/views/lotus/libraryview.jsp">Biblioteca técnica</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/lotus/training/">Treinamentos e certificações</a></li>
      <li><a href="http://www.ibm.com/developerworks/lotus/support/">Suporte (Inglês)</a></li>
    </ul> 
    
  </div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' "> 
  <div id="ibm-navigation">
    <h2 class="ibm-access">Navegación por el Contenido</h2>
    
    <ul id="ibm-primary-links">
      <li id="ibm-overview"><a
        href="http://www.ibm.com/developerworks/br/rational/">Rational</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/rational/newto/">Introdução a Rational</a></li>
      <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/rational/products/">Produtos</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/rational/downloads/">Downloads</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/views/rational/libraryview.jsp">Biblioteca técnica</a></li>
      <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/rational/training/">Treinamentos e certificações</a></li>
      <li><a href="http://www.ibm.com/developerworks/rational/support/">Suporte (Inglês)</a></li>
      
    </ul> 
  </div>
  </xsl:when>
  <xsl:when test=".//content-area-primary/@name = 'tivoli' "> 
    <div id="ibm-navigation">
      <h2 class="ibm-access">Navegación por el Contenido</h2>
      <ul id="ibm-primary-links">
        <li id="ibm-overview"><a href="http://www.ibm.com/developerworks/br/tivoli/">Tivoli</a></li>
        <li><a href="http://www.ibm.com/developerworks/br/tivoli/newto/">Introdução a Tivoli</a></li>
        <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/tivoli/products/">Produtos</a></li>
        <li><a href="http://www.ibm.com/developerworks/br/tivoli/downloads/">Downloads</a></li>
        <li><a href="http://www.ibm.com/developerworks/br/views/tivoli/libraryview.jsp">Biblioteca técnica</a></li>
        <li><a href="http://www.ibm.com/developerworks/br/tivoli/training/">Treinamentos e certificações</a></li>
        <li><a href="http://www.ibm.com/developerworks/tivoli/support/">Suporte (Inglês)</a></li>
      </ul>
    </div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' "> 
  <div id="ibm-navigation">
    <h2 class="ibm-access">Navegación por el Contenido</h2>
    
    <ul id="ibm-primary-links">
      <li id="ibm-overview"><a
        href="http://www.ibm.com/developerworks/br/websphere/">WebSphere</a></li>
      
      <li><a href="http://www.ibm.com/developerworks/br/websphere/newto/">Introdução a WebSphere</a></li>
      <li><a class="ibm-is-active" href="http://www.ibm.com/developerworks/br/websphere/products/">Produtos</a></li>
      <li><a href="http://www.ibm.com/software/br/how_to_buy.shtml">Como comprar</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/websphere/downloads/">Downloads</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/views/websphere/libraryview.jsp">Biblioteca técnica</a></li>
      <li><a href="http://www.ibm.com/developerworks/br/websphere/training/">Treinamentos e certificações</a></li>
      <li><a href="http://www.ibm.com/developerworks/websphere/support/">Suporte (US)</a></li>
      <li><a href="http://www.ibm.com/software/br/sw-services/websphere/">Serviços</a></li>    
    </ul> 
    
  </div>
</xsl:when>

</xsl:choose>
<xsl:comment> LEFT_NAVIGATION_END </xsl:comment> 

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

<div id="ibm-metrics">
<!-- <script src="//dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<xsl:comment> INCLUDES_FOR_SCRIPTS_AFTER_FOOTER </xsl:comment>
<script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/portal/js/aculo/prototypelt.js">//</script>
<script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/portal/js/dwspace/gadgetpopup.min.js">//</script>


</body>
</html>
</xsl:template>
</xsl:stylesheet>
