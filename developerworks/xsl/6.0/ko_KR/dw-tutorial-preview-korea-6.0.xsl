<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" exclude-result-prefixes="xsl fo">

    <xsl:template name="dw-tutorial-preview">
        <xsl:choose>
            <xsl:when test="element-available('redirect:write' )">
                <xsl:variable name="this-content" select="." />
                <xsl:for-each select="//section">
                    <xsl:variable name="preview-page-name">
                        <xsl:choose>
                            <xsl:when test="position() = 1">
                                <xsl:value-of select=" 'index.html' " />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="concat('section', position(),
                      '.html')"
                                 />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <redirect:write select="string($preview-page-name)">
                        <xsl:for-each select="$this-content">
                            <xsl:call-template name="dw-tutorial-preview-one-page">
                                <xsl:with-param name="preview-page-name"
                                    select=" $preview-page-name" />
                                <xsl:with-param name="preview-page-type"
                                    select=" 'section' " />
                            </xsl:call-template>
                        </xsl:for-each>
                    </redirect:write>
                </xsl:for-each>
                <!-- downloads resources bio -->
                <xsl:if
                    test="/dw-document/dw-tutorial/target-content-file or /dw-document/dw-tutorial/target-content-page">
                    <xsl:variable name="preview-page-name" select=" 'downloads.html' " />
                    <redirect:write select="string($preview-page-name)">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type"
                                select=" 'downloads' " />
                        </xsl:call-template>
                    </redirect:write>
                </xsl:if>
                <xsl:if test="/dw-document/dw-tutorial/resources">
                    <xsl:variable name="preview-page-name" select=" 'resources.html' " />
                    <redirect:write select="string($preview-page-name)">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type"
                                select=" 'resources' " />
                        </xsl:call-template>
                    </redirect:write>
                </xsl:if>
                <xsl:variable name="preview-page-name" select=" 'authors.html' " />
                <redirect:write select="string($preview-page-name)">
                    <xsl:call-template name="dw-tutorial-preview-one-page">
                        <xsl:with-param name="preview-page-name"
                            select=" $preview-page-name" />
                        <xsl:with-param name="preview-page-type" select=" 'authorBio' " />
                    </xsl:call-template>
                </redirect:write>
            </xsl:when>
            <xsl:when test=" normalize-space($page-name) != ''  ">
                <xsl:variable name="preview-page-name"
                    select="normalize-space($page-name)" />
                <xsl:choose>
                    <xsl:when
                        test="($page-name = 'index.html') or 
                            starts-with($page-name, 'section')">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type" select=" 'section' "
                             />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test=" $page-name = 'downloads.html' ">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type"
                                select=" 'downloads' " />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test=" $page-name = 'resources.html' ">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type"
                                select=" 'resources' " />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test=" $page-name = 'authors.html' ">
                        <xsl:call-template name="dw-tutorial-preview-one-page">
                            <xsl:with-param name="preview-page-name"
                                select=" $preview-page-name" />
                            <xsl:with-param name="preview-page-type"
                                select=" 'authorBio' " />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">Invalid page name <xsl:value-of
                                select="$page-name" /></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Xalan redirect:write not available and no
                    page name specified</xsl:message>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

<xsl:template name="dw-tutorial-preview-one-page">
    <xsl:param name="preview-page-name"></xsl:param>
   <xsl:param name="preview-page-type"></xsl:param>
    <xsl:param name="header-trailer" select=" 'yes' "></xsl:param>
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!--<#ftl encoding="UTF-8" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
-->
<!--<#if dw_output_map?exists><#assign dwarticle = dw_output_map /></#if>
<#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if>
-->
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<!-- TUTORIAL start: diff variable needed for unique title per page -->
<title><xsl:apply-templates select=".">  
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></title>
<!-- TUTORIAL end: diff variable needed for unique title per page -->
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
    <meta name="Owner" content="https://www.ibm.com/developerworks/secure/feedback.jsp?domain=dwkorea"/>
    <meta name="DC.Language" scheme="rfc1766" content="ko"/>
    <meta name="IBM.Country" content="KR"/>
<meta name="IBM.SpecialPurpose" content="SP001"/>
<meta name="IBM.PageAttributes" content="sid=1003"/>
<meta name="Source" content="v16 Template Generator"/>
<meta name="Robots" content="index,follow"/>
    <xsl:element name="meta">
<xsl:attribute name="name">Abstract</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">abstract</xsl:with-param>
    <xsl:with-param name="page-name" select="$preview-page-name"/>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!--<meta name="Abstract" content="<#if dwarticle.abstract?exists>${dwarticle.abstract}</#if>"/>-->
<xsl:element name="meta">
<xsl:attribute name="name">Description</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">abstract</xsl:with-param>
    <xsl:with-param name="page-name" select="$preview-page-name"/>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!--<meta name="Description" content="<#if dwarticle.abstract?exists>${dwarticle.abstract}</#if>"/>-->
<xsl:element name="meta">
<xsl:attribute name="name">Keywords</xsl:attribute>
<xsl:attribute name="content"><xsl:apply-templates select=".">
<xsl:with-param name="template">keywords</xsl:with-param>
    <xsl:with-param name="page-name" select="$preview-page-name"/>
</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!--<meta name="Keywords" content="<#if dwarticle.keywords?exists>${dwarticle.keywords}</#if>"/>-->
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
<!--<meta name="DC.Date" scheme="iso8601" content="<#if dwarticle.dcDate?exists>${dwarticle.dcDate}</#if>"/>
<meta name="DC.Type" scheme="IBM_ContentClassTaxonomy" content="<#if dwarticle.dcType?exists>${dwarticle.dcType}</#if>"/>
<meta name="DC.Subject" scheme="IBM_SubjectTaxonomy" content="<#if dwarticle.dcSubject?exists>${dwarticle.dcSubject}</#if>"/>
-->
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

<!--    <meta name="DC.Rights" content="<#if dwarticle.dcRights?exists>${dwarticle.dcRights}</#if>"/>
<meta name="IBM.Effective" scheme="W3CDTF" content="<#if dwarticle.ibmEffective?exists>${dwarticle.ibmEffective}</#if>"/>
-->
    <!-- HEADER_SCRIPTS_AND_CSS_INCLUDE -->
<link href="http://www.ibm.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/kr/ko/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://www.ibm.com/developerworks/css/dw-screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://www.ibm.com/developerworks/js/jquery/cluetip98/jquery.cluetip.css" media="screen,projection" rel="stylesheet"  title="www" type="text/css" />
    <link href="http://www.ibm.com/developerworks/css/dw-local-site.css" rel="stylesheet" type="text/css"/>
    <!-- xM Masthead/Footer -->
    <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
    <link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
    
<script src="//dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="//dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->

<xsl:comment> dW functional JS </xsl:comment>
<script language="JavaScript" src="//dw1.s81c.com/developerworks/js/urltactic.js" type="text/javascript">//</script>
<xsl:comment> Rating_START </xsl:comment>
<script language="JavaScript" src="//dw1.s81c.com/developerworks/js/artrating/artrating.js" type="text/javascript">//</script>
<style type="text/css">
.metavalue {
  display: none;
}
</style>
<xsl:comment> Rating_END </xsl:comment>

<!-- RESERVED_HEADER_INCLUDE -->
<script language="javascript" src="//dw1.s81c.com/developerworks/js/ajax1.js" type="text/javascript">//</script>
<script language="javascript" src="//dw1.s81c.com/developerworks/js/search_counter-maverick.js" type="text/javascript">//</script>
<script language="javascript" src="//dw1.s81c.com/developerworks/js/request_referer_capture-maverick.js" type="text/javascript">//</script>
<!--<#include "/inc/s-reserved-head1.ftl">-->
<xsl:apply-templates select=".">
<xsl:with-param name="template">webFeedDiscovery</xsl:with-param>
</xsl:apply-templates>
 <!--   <#if dwarticle.webFeedDiscovery?exists>${dwarticle.webFeedDiscovery}</#if>-->
  
<script language="JavaScript" type="text/javascript">
<xsl:comment>
 setDefaultQuery('');
 //</xsl:comment>
 <!--
 setDefaultQuery('<#if dwarticle.urltactic?exists>${dwarticle.urltactic}</#if>');
 //-->
</script>
<script language="JavaScript" type="text/javascript">
 <xsl:comment>
 function openNewWindow(url,tar,arg){window.open(url,tar,arg);}
 //</xsl:comment>
<!--
 function openNewWindow(url,tar,arg){window.open(url,tar,arg);}
 //-->
</script>
</head>

<body id="ibm-com">
<div id="ibm-top" class="ibm-landing-page">

    <!-- MASTHEAD_BEGIN -->
    <div class="ibm-access"><a href="#ibm-content">메인 컨텐츠로 가기</a></div>
    <div id="ibm-masthead-dw">
        <div id="dw-masthead-top-row">
            <ul id="ibm-unav-home-dw">
                <li id="ibm-logo">
                    <a href="http://www.ibm.com/kr/ko/"><img src="http://dw1.s81c.com/developerworks/i/mf/ibm-smlogo.gif" width="44" height="16" alt="IBM®" /></a>
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
<xsl:with-param name="transform-zone" select="//content-area-primary/@name"/>
</xsl:apply-templates>
</xsl:if>
<xsl:comment> Navigation_Trail_END </xsl:comment>

<xsl:comment> dW_Summary Area_START </xsl:comment>
<div id="dw-summary-article">

<div class="dw-content-head">
<xsl:apply-templates select=".">
<xsl:with-param name="template">title</xsl:with-param>
</xsl:apply-templates>
<!--<#if dwarticle.title?exists>${dwarticle.title}</#if>-->
</div>

<div class="ibm-container-body ibm-two-column">

<div class="ibm-column ibm-first">
<xsl:apply-templates select=".">
<xsl:with-param name="template">authorList</xsl:with-param>
</xsl:apply-templates>
<!--<#if dwarticle.authorList?exists>${dwarticle.authorList}</#if>-->
<p></p>
    <p><strong>요약：</strong>&nbsp; <xsl:apply-templates select=".">
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
<!-- <p class="ibm-no-print"><div id="dw-tag-this" class="ibm-no-print"><a class="ibm-external-link" onclick="jQuery.launchTagThisWindow(); return false;" href="#">Tag this!</a></div><div id="interestShow" class="ibm-no-print"></div></p> -->
</div>

<div class="ibm-column ibm-second">
<p class="leading"><xsl:apply-templates select=".">
<xsl:with-param name="template">date</xsl:with-param>
</xsl:apply-templates><!--<#if dwarticle.date?exists>${dwarticle.date}</#if>-->
<xsl:apply-templates select=".">
<xsl:with-param name="template">skillLevel</xsl:with-param>
</xsl:apply-templates>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">linktoenglish</xsl:with-param>
    </xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">pdf</xsl:with-param>
</xsl:apply-templates>
 <!--   <#if dwarticle.pdf?exists>${dwarticle.pdf}</#if>-->
<!--<#if current_page_views?exists><#if (current_page_views == "0")><#elseif current_page_views == "1"><br /><strong>Activity:</strong>&nbsp; ${current_page_views} view<#else><br /><strong>Activity:</strong>&nbsp; ${current_page_views} views</#if></#if>
-->
    <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><strong>의견</strong> &nbsp; <span id="nCmts"><img alt="" src="//dw1.s81c.com/developerworks/i/circle-preloader.gif" height="12" width="50" /><img alt="" src="//dw1.s81c.com/i/c.gif" height="14" width="1" /></span>
    <xsl:comment> Rating_Area_Begin </xsl:comment> 
<xsl:comment> Ensure that div id is based on input id and ends with -widget </xsl:comment>
<input id="art-rating" name="ratinga" type="hidden" value="0"/><xsl:text disable-output-escaping="yes"><![CDATA[<div id="art-rating-widget">]]></xsl:text><xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
<script language="JavaScript" type="text/javascript">
// <![CDATA[
   // widget div id and tutorial id as args
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

<xsl:comment> Related_Searches_Area_And_Overlays_Begin </xsl:comment>
<script type="text/javascript" language="javascript">
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
</div>
<xsl:comment> Related_Searches_Area_End </xsl:comment>



<xsl:comment> MAIN_COLUMN_CONTAINER_BEGIN </xsl:comment>
<div class="ibm-container">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<!-- TUTORIAL start: Choose the component that goes in the body -->
<!--
  <#if dw.type?exists>
   <#if dw.type == "section">
      <#if dw.sectionTitle?exists>${dw.sectionTitle}</#if>
       <#if dw.docbody?exists>${dw.docbody}</#if>
    <#elseif dw.type == "downloads">
       <#if dw.downloads?exists>${dw.downloads}</#if>
    <#elseif dw.type == "resources">
       <#if dw.resources?exists>${dw.resources}</#if>
    <#elseif dw.type == "authorBio">
        <#if dw.authorBio?exists>${dw.authorBio}</#if>
   <#else>
      Error!  Either page-type, sectionTitle, docbody, downloads, resources, or authorBio
      don't exist.
    </#if>
  </#if>-->
<!-- TUTORIAL end: Choose the component that goes in the body -->
<xsl:choose>
    <xsl:when test="$preview-page-type = 'section' ">
            <xsl:apply-templates select=".">
                <xsl:with-param name="template">sectionTitle</xsl:with-param>
                <xsl:with-param name="page-name" select="$preview-page-name"></xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates select=".">
                <xsl:with-param name="template">docbody</xsl:with-param>
                <xsl:with-param name="page-name" select="$preview-page-name"></xsl:with-param>
                <xsl:with-param name="page-type" select="$preview-page-type"></xsl:with-param>
            </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="$preview-page-type = 'downloads' ">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">downloads</xsl:with-param>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="$preview-page-type = 'resources' ">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">resources</xsl:with-param>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="$preview-page-type = 'authorBio' ">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">authorBio</xsl:with-param>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
        <xsl:message terminate="yes">Error!  Either page-type, sectionTitle, docbody, downloads, resources, or authorBio
      does not exist.</xsl:message>
    </xsl:otherwise>
</xsl:choose>
    
<!-- TUTORIAL start: page navigator -->
<xsl:apply-templates select=".">
<xsl:with-param name="template">pageNavigator</xsl:with-param>
    <xsl:with-param name="page-name" select="$preview-page-name"></xsl:with-param>
    <xsl:with-param name="page-type" select="$preview-page-type"></xsl:with-param>
</xsl:apply-templates>
<!--<#if dw.pageNavigator?exists>${dw.pageNavigator}</#if>-->
<!-- TUTORIAL end: page navigator -->   
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

<xsl:comment> INLINE_COMMENTS_START </xsl:comment>
    <p class="ibm-no-print"><span class="atitle"><a name="icomments">의견</a></span></p>
<div id="dw-icomments-container" class="ibm-no-print">
<div class="ibm-alternate-rule"><hr /></div>
<div class="ibm-alternate-rule"><hr /></div>
<xsl:comment> Comment_Script </xsl:comment>
<a id="comments" href="comments"></a>
    <script language="JavaScript" type="text/javascript">
        // <![CDATA[
dwc = {};
dwc.cmts = '의견';
dwc.signIn = '로그인';
dwc.addCmts = '의견 추가';
dwc.addCmt = '의견 추가';
dwc.viewOrAddCmts = '의견 보기 또는 추가';
dwc.reportInapprCont = '부적절한 의견 보고';
dwc.reportInapprContLink = 'http://www.ibm.com/developerworks/forums/forum.jspa?forumID=1833';
dwc.postingCmt = '의견 게시 중';
dwc.noCmt = '이 기사에 대한 의견이 없습니다.';
dwc.netwkErr = '의견을 가져오는 중에 문제가 발생했습니다. 나중에 페이지를 새로 고치십시오.';
dwc.addACmt = '의견 추가';
dwc.instructCmt = '별표(<span class="ibm-required">*</span>)가 표시된 필드는 이 트랜잭션을 완료하기 위한 필수 필드입니다.';
dwc.cmt = '의견:';
dwc.btnPost = '의견 올리기';
dwc.btnPostAnon = '익명으로 의견 올리기';
dwc.btnClrCmt = '의견 지우기';
dwc.btnCancel = '취소';
dwc.showRecent = '최근 {1}개의 의견 보기'; // {1} is the count to be substituted
dwc.showNext = '다음 {1}개의 의견 보기'; // {1} is the count to be substituted
dwc.showAllCmts = '모든 의견 보기';
dwc.enterCmt = '의견을 남겨 주십시오.';
dwc.loginErr = '로그인 상태를 확인할 수 없습니다. 나중에 다시 시도하십시오.';
dwc.postErr = '지금 코멘트를 게시할 수 없습니다. 잠시 후 다시 시도해주시기 바랍니다.';
dwc.postBy = '{2} {1}님'; // {1} is the author to be substituted; {2} is the date
dwc.siteId = 20;
dwc.lang = 'ko_KR';
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
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">위로</a></p>
    <p><a href="http://www.ibm.com/developerworks/kr/ibm/trademarks/">등록 상표</a> &nbsp;|&nbsp; <a href="http://www.ibm.com/developerworks/kr/mydw_terms/">My developerWorks 이용약관</a></p>
    
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
<!-- TUTORIAL start: Tutorial toc must include page navigator -->
<xsl:apply-templates select=".">
<xsl:with-param name="template">toc</xsl:with-param>
    <xsl:with-param name="page-name" select="$preview-page-name"></xsl:with-param>
    <xsl:with-param name="page-type" select="$preview-page-type"></xsl:with-param>
</xsl:apply-templates>
<!-- TUTORIAL end: Tutorial toc must include page navigator -->
<!--<#if nextSteps?exists>${nextSteps}</#if>
<#if community?exists>${community}</#if>-->
<!-- Tagging_Start -->
<!-- 
    <div id="dw-tag-cloud-container" class="ibm-container dw-hidetag"><h2>Tags</h2>
<div id="dw-tag-help"><a class="dwauthor" rel="#tagtip" id="dwtagtip"><img alt="Help" height="16" width="16" align="top" src="//dw1.s81c.com/developerworks/i/help_icon.gif"/></a></div>
<div id="tagtip" class="dwauthor-onload-state ibm-no-print">Use the <strong>search field</strong> to find all types of content in My developerWorks with that tag.<p>Use the <strong>slider bar</strong> to see more or fewer tags.</p><p><strong>Popular tags</strong> shows the top tags for this particular content zone (for example, Java technology, Linux, WebSphere).</p><p><strong>My tags</strong> shows your tags for this particular content zone (for example, Java technology, Linux, WebSphere).</p></div>
<div class="ibm-access">Use the search field to find all types of content in My developerWorks with that tag.  <em>Popular tags</em> shows the top tags for this particular content zone (for example, Java technology, Linux, WebSphere).  <em>My tags</em> shows your tags for this particular content zone (for example, Java technology, Linux, WebSphere).</div>
<div class="ibm-container-body">
<div class="dw-tag-search"><form action="//www.ibm.com/developerworks/mydeveloperworks/bookmarks/html?lang=en" method="get" id="actualtagform" onsubmit="popupform(this, 'join')">
<p><label for="tagfield"><strong>Search all tags</strong></label><input id="tagfield" name="tag" type="text" maxlength="20" size="17" />&nbsp;<input src="//dw1.s81c.com/i/v16/buttons/short-btn.gif" type="image" class="ibm-btn-view" alt="submit search" title="submit search" value="Search" /></p></form></div>
<div class="ibm-rule"><hr/></div>
<div id="dw-tag-select">
<div id="dw-tag-select-popular"><p><strong>Popular tutorial tags</strong>&nbsp;|&nbsp;<br /><a id="a-my" href="javascript:;">My tutorial tags</a><a href="#dw-tag-access" class="ibm-access">Skip to tags list</a></p></div>
<div id="dw-tag-select-my" class="dw-hidetag"><p><a id="a-popular" href="javascript:;">Popular tutorial tags</a>&nbsp;|&nbsp;<br /><strong>My tutorial tags</strong></p><a href="#dw-tag-access" class="ibm-access">Skip to tags list</a></div>
<div id="dw-tag-cloud"></div>  
</div>   
</div>
</div> -->
<!-- Tagging_End -->
<!-- Dig_Deeper -->
<!--<#if zoneNavigation?exists>${zoneNavigation}</#if>-->
<!-- High_Visibility_Offer -->
<!--<#if offer?exists>${offer}</#if>-->
<!-- Special_Offers -->
<!--<#if specialOffers?exists>${specialOffers}</#if>-->
<!-- RIGHT_COLUMN_CONTENT_END -->

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
    
    <div id="ibm-footer-module-dw" class="dw-mf-minimal"></div><xsl:comment> FOOTER_END </xsl:comment>

 <xsl:comment> END_IBM-TOP </xsl:comment>
</div>
 
 <xsl:comment> SCRIPTS_INCLUDE_BEGIN </xsl:comment>
<xsl:comment> JQuery start </xsl:comment>
<script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.dimensions-1.2.js">//</script>
<script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.hoverIntent.minified.js">//</script>
<script type="text/javascript" language="JavaScript" src="//dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.cluetip.js">//</script>
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
		closeText: '<img src="//dw1.s81c.com/developerworks/js/jquery/cluetip98/i/x.gif" alt="Close" />',
		arrows: false,
		dropShadow: true,
		cluetipClass: 'dwbasic'
		});   	
	});
 </script>
 <xsl:comment> JQuery end </xsl:comment>

<xsl:comment> SCRIPTS_INCLUDE_END </xsl:comment>

<div id="ibm-metrics">
<script src="//dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script>
</div>

</body>
</html>

</xsl:template>


</xsl:stylesheet>
