<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" exclude-result-prefixes="xsl fo">
 
<xsl:template name="dw-landing-generic-pagegroup-hidef-preview">

    <xsl:choose>
        <xsl:when test="element-available('redirect:write' )">
            <xsl:variable name="this-content" select="." />
				
            <xsl:for-each select="//page-hidef/pageinfo/@primary-nav-url">
                <xsl:if test="not(../../@output='no')">
                    <!-- Create preview-page-name variable for primary tab pages -->
                    <xsl:variable name="preview-page-name">
                        <!-- Determine page name -->
                        <xsl:choose>
                            <!-- When value is a simple page name, use it -->
                            <xsl:when test="not(contains(.,'/'))">
		  <xsl:value-of select="." />
                            </xsl:when>
                            <!-- 09/10/10 jpp:  Added when condition -->
                            <!-- When URL ends with a slash, assume index.html -->
                            <xsl:when test="(substring(.,string-length(.)) = '/')">
		  <xsl:text>index.html</xsl:text>
                            </xsl:when>
                            <!-- Otherwise, extract page name from relative or fully-qualified path -->
                            <xsl:otherwise>
                                <xsl:call-template name="substring-after-last">
                                    <xsl:with-param name="input" select="." />
                                    <xsl:with-param name="substr" select=" '/' " />
                                </xsl:call-template>
                            </xsl:otherwise>			
                        </xsl:choose>
                    </xsl:variable>
                    <redirect:write select="string($preview-page-name)">
                        <xsl:for-each select="$this-content">
                            <xsl:call-template name="dw-landing-generic-pagegroup-hidef-preview-one-page">
                                <xsl:with-param name="preview-page-name" select="$preview-page-name" />
                                <!-- <xsl:with-param name="preview-page-type" select=" 'section' " /> -->
                            </xsl:call-template>
                        </xsl:for-each>
                    </redirect:write>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//subpage-hidef/subpageinfo/@secondary-nav-url">
                <xsl:if test="not(../../@output='no')">
                    <!-- Create preview-page-name variable for secondary tab pages -->
                    <xsl:variable name="preview-page-name">
                        <!-- Determine page name -->
                        <xsl:choose>
                            <!-- When value is a simple page name, use it -->
                            <xsl:when test="not(contains(.,'/'))">
		  <xsl:value-of select="." />
                            </xsl:when>
                            <!-- 09/10/10 jpp:  Added when condition -->
                            <!-- When URL ends with a slash, assume index.html -->
                            <xsl:when test="(substring(.,string-length(.)) = '/')">
		  <xsl:text>index.html</xsl:text>
                            </xsl:when>
                            <!-- Otherwise, extract page name from relative or fully-qualified path -->
                            <xsl:otherwise>
                                <xsl:call-template name="substring-after-last">
                                    <xsl:with-param name="input" select="." />
                                    <xsl:with-param name="substr" select=" '/' " />
                                </xsl:call-template>
                            </xsl:otherwise>			
                        </xsl:choose>
                    </xsl:variable>
                    <redirect:write select="string($preview-page-name)">
                        <xsl:for-each select="$this-content">
                            <xsl:call-template name="dw-landing-generic-pagegroup-hidef-preview-one-page">
                                <xsl:with-param name="preview-page-name" select=" $preview-page-name" />
                                <!-- <xsl:with-param name="preview-page-type" select=" 'section' " /> -->
                            </xsl:call-template>
                        </xsl:for-each>
                    </redirect:write>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>      
        <xsl:otherwise>
            <xsl:message terminate="yes">Xalan redirect:write not available and no page name specified</xsl:message>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- XSLT Cookbook, Mangano S., Recipe 2.4.  Finding Substrings from the End of a String -->
<xsl:template name="substring-after-last">
    <xsl:param name="input" />
    <xsl:param name="substr" />
    <xsl:variable name="temp" select="substring-after($input, $substr)" />
    <xsl:choose>
        <xsl:when test="$substr and contains($temp, $substr)">
            <xsl:call-template name="substring-after-last">
                <xsl:with-param name="input" select="$temp" />
                <xsl:with-param name="substr" select="$substr" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$temp" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- START_INDIVIDUAL_PAGE_OUTPUT -->
<xsl:template name="dw-landing-generic-pagegroup-hidef-preview-one-page">
    <xsl:param name="preview-page-name" />
    <!-- <xsl:param name="preview-page-type"></xsl:param> -->
    <!-- <xsl:param name="header-trailer" select=" 'yes' "></xsl:param> -->

<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dw = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_content_map?exists><#assign dwcontentmap = dw_content_map /></#if> -->
<!-- <#if dw_request_details?exists><#assign dwrequest = dw_request_details /></#if> -->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<!-- JPP FIX 071410 -->
<title>
<xsl:apply-templates select=".">
    <xsl:with-param name="template">titletag</xsl:with-param>
    <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
</title>
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
<!-- <meta name="Abstract" content="<#if dw.abstract?exists>${dw.abstract}</#if>"/> -->
<!-- JPP FIX 071410 -->
<xsl:element name="meta">
	<xsl:attribute name="name">Abstract</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
	<xsl:with-param name="template">abstract</xsl:with-param>
		<xsl:with-param name="landing-page-name" select="$preview-page-name"/>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!-- <meta name="Description" content="<#if dw.abstract?exists>${dw.abstract}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">Description</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
	<xsl:with-param name="template">abstract</xsl:with-param>
		<xsl:with-param name="landing-page-name" select="$preview-page-name"/>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!-- <meta name="Keywords" content="<#if dw.keywords?exists>${dw.keywords}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">Keywords</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
	<xsl:with-param name="template">keywords</xsl:with-param>
		<xsl:with-param name="landing-page-name" select="$preview-page-name"/>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!-- <meta name="DC.Date" scheme="iso8601" content="<#if dw.dcDate?exists>${dw.dcDate}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">DC.Date</xsl:attribute>
	<xsl:attribute name="scheme">iso8601</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
		<xsl:with-param name="template">dcDate</xsl:with-param>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!-- <meta name="DC.Type" scheme="IBM_ContentClassTaxonomy" content="<#if dw.dcType?exists>${dw.dcType}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">DC.Type</xsl:attribute>
	<xsl:attribute name="scheme">IBM_ContentClassTaxonomy</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
		<xsl:with-param name="template">dcType</xsl:with-param>
	               <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>
<!-- <meta name="DC.Subject" scheme="IBM_SubjectTaxonomy" content="<#if dw.dcSubject?exists>${dw.dcSubject}</#if>"/> -->
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
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCAIXZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'data' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIMTZZ" />  
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLOTZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCRATZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'tivoli' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCTIVZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCWSPZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'architecture' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCARCZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'java' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCJVAZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'linux' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLNXZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'power' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCMACZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'opensource' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOSRZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'ibm' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSCNZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'webservices' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSOAZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'web' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCDEVZZ" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'xml' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCXMLZZ" />
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'none' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOTHZZ" />
</xsl:when>
<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:if>
<!-- Industry meta tag not displayed; sourced from CMA -->
<!-- <meta name="DC.Rights" content="<#if dw.dcRights?exists>${dw.dcRights}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">DC.Rights</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
	<xsl:with-param name="template">dcRights</xsl:with-param>
		</xsl:apply-templates></xsl:attribute>
	</xsl:element>
<!-- <meta name="IBM.Effective" scheme="W3CDTF" content="<#if dw.ibmEffective?exists>${dw.ibmEffective}</#if>"/> -->
<xsl:element name="meta">
	<xsl:attribute name="name">IBM.Effective</xsl:attribute>
	<xsl:attribute name="scheme">W3CDTF</xsl:attribute>
	<xsl:attribute name="content"><xsl:apply-templates select=".">
		<xsl:with-param name="template">ibmEffective</xsl:with-param>
	</xsl:apply-templates></xsl:attribute>
</xsl:element>

<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://dw1.s81c.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/zz/en/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://dw1.s81c.com/developerworks/css/dw-screen-hi-def-landing.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<!-- xM Masthead/Footer -->
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
<script src="http://dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>
<!-- <script src="http://dw1.s81c.com/common/js/dynamicnav.js" type="text/javascript">//</script> -->
<script src="http://dw1.s81c.com/ibm/ideasfromibm/us/js/AC_RunActiveContent.js" type="text/javascript">//</script>
<script src="http://dw1.s81c.com/common/js/flash-detect.js" type="text/javascript">//</script>
<script src="http://dw1.s81c.com/common/stats/sacdcflash2.js" type="text/javascript">//</script> 
<xsl:comment> dW functional JS </xsl:comment>
<script src="http://dw1.s81c.com/developerworks/js/urltactic.js" type="text/javascript">//</script>
<xsl:comment> RESERVED_HEADER_INCLUDE </xsl:comment>
<link href="http://dw1.s81c.com/common/v16/css/overlay.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<!-- <#if dw.webFeedDiscovery?exists>${dw.webFeedDiscovery}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">webFeedDiscovery</xsl:with-param>
                <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates> 
    
<script type="text/javascript"> 
 <xsl:comment>
setDefaultQuery('<xsl:apply-templates select="."><xsl:with-param name="template">urltactic</xsl:with-param></xsl:apply-templates>'); 
//</xsl:comment>
</script>

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
<!-- <#if dw.leadspace?exists>${dw.leadspace}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">leadspace</xsl:with-param>
                <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
<xsl:comment> LEADSPACE_END </xsl:comment>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body" class="ibm-tab-navigation">

<xsl:comment> TABBED_NAVIGATION_BEGIN </xsl:comment>
<!-- <#if dw.tabbedNav?exists>${dw.tabbedNav}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">tabbedNav</xsl:with-param>
                <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
<xsl:comment> TABBED_NAVIGATION_END </xsl:comment>

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<!-- Choose components for main body area -->
<!-- <#if dw.type?exists>
   <#if dw.type == "section">
		<#if dw.pageTitleHidef?exists>${dw.pageTitleHidef}</#if>
		<#if dw.contentSpaceNav?exists>${dw.contentSpaceNav}</#if>
		<#if dw.abstractLanding?exists>${dw.abstractLanding}</#if>
		<#if dw.moduleDocbodyHidef?exists>${dw.moduleDocbodyHidef}</#if>
  </#if>
</#if> -->
<!-- <xsl:if test="$preview-page-type = 'section' "> -->
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">pageTitleHidef</xsl:with-param>
        <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">contentSpaceNav</xsl:with-param>
        <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">abstractLanding</xsl:with-param>
        <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">moduleDocbodyHidef</xsl:with-param>
        <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
    </xsl:apply-templates>
<!-- </xsl:if> -->
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

<xsl:comment> Overlays </xsl:comment>
<!-- <#include "/inc/en_US/s-reserved-overlay-landing.ftl"> -->

<!-- <#if dw.cmaSiteStylesheetId?exists>${dw.cmaSiteStylesheetId}</#if> -->
<xsl:apply-templates select=".">
    <xsl:with-param name="template">cmaSiteStylesheetId</xsl:with-param>
</xsl:apply-templates>
</div>
<xsl:comment> MAIN_COLUMN_END </xsl:comment>

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment>
<div id="ibm-contact-module">
<!--IBM contact module-->
<!-- <#if dw.contactModuleUse?exists><#if dw.contactModuleUse == "yes"><#if contact?exists>${contact}</#if></#if></#if> -->
</div>
<!-- <#if dw.highVisModule?exists>${dw.highVisModule}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">highVisModule</xsl:with-param>
                <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
<!-- Top and bottom Include file calls will not display -->
<!-- <#if dw.moduleRightDocbody?exists>${dw.moduleRightDocbody}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">moduleRightDocbody</xsl:with-param>
               <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
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

<xsl:comment> HI-DEF_FOOTER_MODULE_BEGIN </xsl:comment>
<!-- <#if dw.hidefFooterModule?exists>${dw.hidefFooterModule}</#if> -->
<xsl:apply-templates select=".">
	<xsl:with-param name="template">hidefFooterModule</xsl:with-param>
               <xsl:with-param name="landing-page-name" select="$preview-page-name"></xsl:with-param>
</xsl:apply-templates>
<xsl:comment> HI-DEF_FOOTER_MODULE_END </xsl:comment>

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

<!-- <#include "/inc/en_US/s-metrics.ftl"> -->

<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<xsl:comment> INCLUDES_FOR_SCRIPTS_AFTER_FOOTER </xsl:comment>
<!-- <#include "/inc/en_US/s-reserved-bottom-landing.ftl"> -->
<!-- <#include "/inc/en_US/s-reserved-bottom-scripts-landing-hidef.ftl"> -->
<xsl:comment> INCLUDES_AFTER_FOOTER_END </xsl:comment>

</body>
</html>

</xsl:template>
<!-- END_INDIVIDUAL_PAGE_OUTPUT -->

</xsl:stylesheet>