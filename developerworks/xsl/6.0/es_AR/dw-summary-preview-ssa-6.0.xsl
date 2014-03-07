<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-summary-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwarticle = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_content_map?exists><#assign dwcontentmap = dw_content_map /></#if> -->
<!-- <#if dw_request_details?exists><#assign dwrequest = dw_request_details /></#if> -->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title><xsl:apply-templates select=".">  
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></title>
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
 <meta name="Owner" content="devworks@ar.ibm.com"/>
<meta name="DC.Language" scheme="rfc1766" content="en" />
<meta name="IBM.Country" content="ZZ" /> 
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
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCAIXAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'data' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIMTAR" />  
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLOTAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCRATAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'tivoli' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCTIVAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCWSPAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'architecture' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCARCAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'java' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCJVAAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'linux' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLNXAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'power' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCMACAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'opensource' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOSRAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'ibm' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSCNAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'webservices' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSOAAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'web' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCDEVAR" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'xml' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCXMLAR" />
  </xsl:when>
<xsl:otherwise>
  <meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOTHAR" />
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
<xsl:element name="meta">
<xsl:attribute name="name">title</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></xsl:attribute>
</xsl:element>

<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://www.ibm.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/ar/es/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://dw1.s81c.com/developerworks/css/dw-screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.cluetip.css" media="screen,projection" rel="stylesheet"  title="www" type="text/css" />
  <!-- xM Masthead/Footer -->
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
  <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
<script src="http://dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="http://dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->

<xsl:comment> dW functional JS </xsl:comment>
<script language="JavaScript" src="http://dw1.s81c.com/developerworks/js/urltactic.js" type="text/javascript">//</script>
<xsl:comment> Rating_START </xsl:comment>
<script language="JavaScript" src="http://dw1.s81c.com/developerworks/js/artrating/artrating.js" type="text/javascript">//</script>
<style type="text/css">
.metavalue {
  display: none;
}
</style>
<xsl:comment> Rating_END </xsl:comment>
<xsl:comment> RESERVED_HEADER_INCLUDE </xsl:comment>
<script language="javascript" src="http://dw1.s81c.com/developerworks/js/ajax1.js" type="text/javascript">//</script>
<!-- <script language="javascript" src="http://dw1.s81c.com/developerworks/js/search_counter-maverick.js" type="text/javascript">//</script>
<script language="javascript" src="http://dw1.s81c.com/developerworks/js/request_referer_capture-maverick.js" type="text/javascript">//</script>-->
<xsl:apply-templates select=".">
<xsl:with-param name="template">webFeedDiscovery</xsl:with-param>
</xsl:apply-templates>
<script language="JavaScript" type="text/javascript">
 <xsl:comment>
 setDefaultQuery('');
 //</xsl:comment>
</script>
<script language="JavaScript" type="text/javascript">
 <xsl:comment>
 function openNewWindow(url,tar,arg){window.open(url,tar,arg);}
 //</xsl:comment>
</script>
</head>

<body id="ibm-com">
<div id="ibm-top" class="ibm-landing-page">

  <!-- MASTHEAD_BEGIN -->
  <div class="ibm-access"><a href="#ibm-content">Ir a contenido principal</a></div>
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
  <!-- MASTHEAD_END -->

<div id="ibm-pcon">

<xsl:comment> CONTENT_BEGIN </xsl:comment>
<div id="ibm-content">

<xsl:comment> Navigation_Trail_BEGIN </xsl:comment>
<xsl:comment> <!-- <#if breadcrumb?exists>${breadcrumb}<#else>&nbsp;</#if> --> </xsl:comment>
<xsl:if test="boolean(.//content-area-primary/@name)">
<xsl:apply-templates select=".">
<xsl:with-param name="template">breadcrumb</xsl:with-param>
<xsl:with-param name="transform-zone" select="//content-area-primary/@name"></xsl:with-param>
</xsl:apply-templates>
</xsl:if>
<xsl:comment> Navigation_Trail_END </xsl:comment>

<xsl:comment> dW_Summary Area_START </xsl:comment>
<div id="dw-summary-article">

<div class="dw-content-head">
<xsl:apply-templates select=".">
<xsl:with-param name="template">title</xsl:with-param>
</xsl:apply-templates>
</div>

<div class="ibm-container-body ibm-two-column">

<div class="ibm-column ibm-first">
<xsl:if test="normalize-space(author-summary)"> 
<!-- <xsl:if test="boolean((.)='author-summary')"> -->
	<xsl:apply-templates select=".">
		<xsl:with-param name="template">authorList</xsl:with-param>
	</xsl:apply-templates>
	<p></p>
</xsl:if>
<xsl:if test="normalize-space(company-name)">
<xsl:apply-templates select=".">
	<xsl:with-param name="template">companyName</xsl:with-param>
</xsl:apply-templates>
</xsl:if>
<xsl:if test="normalize-space(host)">
<xsl:apply-templates select=".">
	<xsl:with-param name="template">host</xsl:with-param>
</xsl:apply-templates>
</xsl:if>
<xsl:apply-templates select=".">
	<xsl:with-param name="template">summaryType</xsl:with-param>
</xsl:apply-templates>


 <p><strong>Resumen:</strong>&nbsp; <xsl:apply-templates select=".">
<xsl:with-param name="template">abstractSummary</xsl:with-param>
</xsl:apply-templates></p>
    <xsl:variable name="seriesTitleText">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">seriesTitle</xsl:with-param>
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:if test="normalize-space($seriesTitleText)">
<p class="ibm-no-print"><xsl:apply-templates select=".">
<xsl:with-param name="template">seriesTitle</xsl:with-param>
</xsl:apply-templates></p>
 </xsl:if>
<!-- Commented out for maintenance -->
<!-- <p class="ibm-no-print"><div id="dw-tag-this" class="ibm-no-print"><a class="ibm-external-link" onclick="jQuery.launchTagThisWindow(); return false;" href="#">Tag this!</a></div> -->
<!--<div id="interestShow" class="ibm-no-print"></div>-->
<!-- </p> -->
</div>

<div class="ibm-column ibm-second">

<p class="leading">
    <xsl:apply-templates select=".">
<xsl:with-param name="template">date</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">translationDate</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">skillLevel</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">linktoenglish</xsl:with-param>
</xsl:apply-templates>

<!-- <#if current_page_views?exists><#if (current_page_views == "0")><#elseif current_page_views == "1"><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><strong>Activity:</strong>&nbsp; ${current_page_views} view<#else><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><strong>Activity:</strong>&nbsp; ${current_page_views} views</#if></#if> -->
  <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><strong>Comentario:</strong> &nbsp; <span id="nCmts"><img alt="" src="//dw1.s81c.com/developerworks/i/circle-preloader.gif" height="12" width="50" /><img alt="" src="//dw1.s81c.com/i/c.gif" height="14" width="1" /></span>
<xsl:comment> Rating_Area_Begin </xsl:comment>

<xsl:comment> Ensure that div id is based on input id and ends with -widget </xsl:comment>	
<input id="art-rating" name="ratinga" type="hidden" value="0"/><xsl:text disable-output-escaping="yes"><![CDATA[<div id="art-rating-widget">]]></xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
<script language="JavaScript" type="text/javascript">
// <![CDATA[
   // widget div id and article id as args
   window.artRating.init('art-rating-widget');
// ]]>
</script>
<xsl:comment> Rating_Area_End </xsl:comment>
</p>
</div>

</div>
</div>
<xsl:comment> dW_Summary_Area_END </xsl:comment>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

 <!--Related_Searches_Area_Begin -->
<xsl:comment> Related_Searches_Area_Begin </xsl:comment>
<!-- <script type="text/javascript" language="javascript">
	     capture_referrer();
</script>

<div id="dw-related-searches-article" style="display:none">
<div class="ibm-container ibm-alternate-two">
<div class="ibm-container-body">

<xsl:comment>  START : HTML FOR ARTICLE SEARCH </xsl:comment>
  <xsl:text disable-output-escaping="yes"><![CDATA[<div id="article_results" style="display:block">]]></xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
<xsl:comment>  END : HTML FOR ARTICLE SEARCH </xsl:comment>

</div>
</div>
</div> -->
<xsl:comment> Related_Searches_Area_End </xsl:comment>

<xsl:comment> MAIN_COLUMN_CONTAINER_BEGIN </xsl:comment>
<div class="ibm-container">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">registrationView</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">downloadLink</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">abstractBody</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">docbody</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">downloads</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">resources</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">authorBio</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

<xsl:comment> INLINE_COMMENTS_START </xsl:comment>
  <p class="ibm-no-print"><span class="atitle"><a name="icomments">Comentario</a></span></p>
<div id="dw-icomments-container" class="ibm-no-print">
<div class="ibm-alternate-rule"><hr /></div>
<div class="ibm-alternate-rule"><hr /></div>
<xsl:comment> Comment_Script </xsl:comment>
<a id="comments" href="comments"></a>
  <script language="JavaScript" type="text/javascript">
  // <![CDATA[
dwc = {};
dwc.cmts = 'comentarios';
dwc.signIn = 'Regístrese';
dwc.addCmts = 'Agregar comentarios';
dwc.addCmt = 'Agregar comentario ';
dwc.viewOrAddCmts = 'Ver o agregar comentario';
dwc.reportInapprCont = 'Reportar contenido inapropiado';
dwc.reportInapprContLink = 'http://www.ibm.com/developerworks/forums/forum.jspa?forumID=1836';
dwc.postingCmt = 'postear comentario';
dwc.noCmt = 'No hay comentarios en este artículo';
dwc.netwkErr = 'Hay un problema para salvar los comentarios. Por favor inténtelo luego';
dwc.addACmt = 'Agregar un comentario';
dwc.instructCmt = 'El archivo indicado con un asterisco (<span class="ibm-required">*</span>)es requerido para completar esta transacción.';
dwc.cmt = 'Comentario:';
dwc.btnPost = 'Postear ';
dwc.btnPostAnon = 'Postear anónimamente';
dwc.btnClrCmt = 'Borrar comentario';
dwc.btnCancel = 'Cancelar';
dwc.showRecent = 'Mostrar {1} los comentarios más recientes'; // {1} is the count to be substituted
dwc.showNext = 'Mostrar {1} el siguiente comentarios'; // {1} is the count to be substituted
dwc.showAllCmts = 'Mostrar todos los comentarios';
dwc.enterCmt = 'Por favor entre un comentario.';
dwc.loginErr = 'Su estatus de registro en el sistema no puede verificarse. Por favor inténtelo nuevamente más tarde.';
dwc.postErr = 'Su comentario no se puede postear en este momento. Por favor intente nuevamente luego.';
dwc.postBy = 'Posteado por <strong>{1}</strong> el {2}'; // {1} is the author to be substituted {2} is the date
dwc.siteId = 90;
dwc.lang = 'es_AR';
// ]]>
  </script>
<script language="JavaScript" src="//dw1.s81c.com/developerworks/js/insertcomment.js" type="text/javascript">//</script>
<xsl:text disable-output-escaping="yes"><![CDATA[<div id="threadShow">]]></xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
<script language="JavaScript" type="text/javascript">
// <![CDATA[
jQuery('threadShow').insertComment('95%',5,'nCmts','icomments');
// ]]>
</script>
  </div>
<xsl:comment> INLINE_COMMENTS_END </xsl:comment>
  
  <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Volver arriba</a></p>
  <p><a href="http://www.ibm.com/developerworks/ssa/ibm/trademarks/">Marcas</a> &nbsp;|&nbsp; <a href="http://www.ibm.com/developerworks/ssa/mydw_terms/">Términos y condiciones de My developerWorks</a></p>
  
</div>
<xsl:comment> MAIN_COLUMN_CONTAINER_END </xsl:comment>

<xsl:comment> Rating_Meta_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">ratingMeta</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> Rating_Meta_END </xsl:comment>

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment> 
<!-- <xsl:apply-templates select=".">
<xsl:with-param name="template">toc</xsl:with-param>
</xsl:apply-templates> -->
<!-- <#if nextSteps?exists>${nextSteps}</#if> -->
<!-- <#if community?exists>${community}</#if> -->
<!-- <xsl:comment> CustomizedLogo for summary briefing </xsl:comment> -->
<xsl:apply-templates select=".">
<xsl:with-param name="template">customizedLogo</xsl:with-param>
</xsl:apply-templates>
<!-- <xsl:comment> Dig_Deeper </xsl:comment> -->
<!-- <#if zoneNavigation?exists>${zoneNavigation}</#if> -->
<!-- Top and bottom Include file calls will not display -->
<xsl:apply-templates select=".">
<xsl:with-param name="template">moduleRightDocbody</xsl:with-param>
</xsl:apply-templates>
<!-- <#if specialOffers?exists>${specialOffers}</#if> -->
<xsl:comment> High_Visibility_Offer </xsl:comment>
<!-- <#if offer?exists>${offer}</#if> -->
<xsl:comment> Special_Offers </xsl:comment>
<!-- <#if specialOffers?exists>${specialOffers}</#if> -->
<xsl:comment> RIGHT_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> RIGHT_COLUMN_END </xsl:comment>

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
<xsl:comment> JQuery start </xsl:comment>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.dimensions-1.2.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.hoverIntent.minified.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.cluetip.js">//</script>
<script type="text/javascript" language="JavaScript">
	jQuery.noConflict();     
	// Put all your code in your document ready area
	jQuery(document).ready(function(jQuery) {
	// Do jQuery stuff using jQuery 
	jQuery('a.dwauthor').cluetip({
		local: true,
		showTitle: false,
		positionBy: 'bottomTop',
		sticky: true,	
		mouseOutClose: true,
		closeText: '<img src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/i/x.gif" alt="Close" />',
		arrows: false,
		dropShadow: true,
		cluetipClass: 'dwbasic'
		});   	
	});
 </script>
 <xsl:comment> JQuery end </xsl:comment>

<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
