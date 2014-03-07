<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-zone-overview-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwzoneoverview = dw_output_map /></#if> -->
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
<meta name="Owner" content="dW Information/Raleigh/IBM"/>
<meta name="DC.Language" scheme="rfc1766" content="en"/>
<meta name="IBM.Country" content="ZZ"/>
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
<div id="ibm-top">

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

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment> 
<xsl:apply-templates select=".">
<xsl:with-param name="template">highVisModule</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> Spotlight_Start </xsl:comment>
<div class="ibm-container">
<h2>Spotlight</h2>
<div class="ibm-container-body dw-right-bullet-list">
<xsl:apply-templates select=".">
<xsl:with-param name="template">spotlight</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> New_site_feature </xsl:comment>
<!-- <#if sitefeature?exists>${sitefeature}</#if> -->
</div>
</div>
<xsl:comment> Spotlight_End </xsl:comment>
<!-- <#if myDownloads?exists>${myDownloads}</#if> -->
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
<xsl:when test=".//content-area-primary/@name = '' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/">developerWorks</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'aix' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/aix/">AIX and UNIX</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/newto/">New to AIX and UNIX</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/find/downloads/">Downloads &amp; products</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="https://www-304.ibm.com/jct03001c/services/learning/ites.wss/us/en?pageType=page&amp;c=a0000045">Training</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'data' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/data/">Information Mgmt</a>
</li>
<li><a href="http://www.ibm.com/developerworks/data/newto/">New to Information Mgmt</a></li>
<li><a href="http://www.ibm.com/developerworks/data/products/">Products</a></li>
<li><a href="http://www.ibm.com/developerworks/data/downloads/">Downloads</a></li>
<li><a href="http://www.ibm.com/developerworks/data/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/data/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/data/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/software/howtobuy/">How to buy</a></li>
<li><a href="http://www.ibm.com/software/data/services/">Services</a></li>
<li><a href="http://www.ibm.com/software/data/education/">Training</a></li>
<li><a href="http://www.ibm.com/software/data/support/">Support</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'ibmi' ">
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/ibmi/">IBM i</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/newto/">New to IBM i</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/find/downloads/">Downloads &amp; tools</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/library/">Technical library</a></li>
<li><a href="https://www.ibm.com/developerworks/ibmi/techupdates">Technology updates</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/services/">Services</a></li>
<li><a href="http://www.ibm.com/developerworks/ibmi/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www-304.ibm.com/jct03001c/services/learning/ites.wss/us/en?pageType=page&amp;c=a0000607">Training</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/lotus/">Lotus</a>
</li>
<li><a href="http://www.ibm.com/developerworks/lotus/newto/">New to Lotus</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/products/">Products</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/downloads/">Downloads</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/demos/">Live demos</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/software/howtobuy/">How to buy</a></li>
<li><a href="http://www.ibm.com/software/lotus/training/">Training</a></li>
<li><a href="http://www.ibm.com/software/lotus/support">Support</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/rational/">Rational</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/newto/">New to Rational</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/products/">Products</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/downloads/">Downloads</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/software/howtobuy/">How to buy</a></li>
<li><a href="http://www.ibm.com/software/rational/education/">Training</a></li>
<li><a href="http://www.ibm.com/software/swnews/swnews.nsf/featurestoriesFM?ReadForm&amp;Site=rationalnews">News</a></li>
<li><a href="http://www.ibm.com/software/rational/support/">Support</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'tivoli' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>

<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/tivoli">Tivoli</a></li>
<li><a href="http://www.ibm.com/developerworks/tivoli/newto/">New to Tivoli</a></li>
<li><a href="http://www.ibm.com/developerworks/tivoli/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/tivoli_forums.jsp">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/tivoli/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/software/howtobuy/">How to buy</a></li>
<li><a href="http://www14.software.ibm.com/webapp/download/home.jsp?pgel=lnav">Downloads</a></li>
<li><a href="http://www.ibm.com/software/products/us/en/tivoli?pgel=lnav">Products</a></li>
<li><a href="http://www.ibm.com/software/tivoli/services/">Services</a></li>
<li><a href="http://www-947.ibm.com/support/entry/portal/Overview/Software/Tivoli/Tivoli_brand_support_(general">Support</a></li>
<li><a href="http://www.ibm.com/software/tivoli/education/">Training</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/websphere">WebSphere</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/newto/">New to WebSphere</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/products/">Products</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/downloads/">Downloads</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/community/">Community &amp; forums</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/find/events/">Events</a></li>
</ul>
<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/software/howtobuy/">How to buy</a></li>
<li><a href="http://www.ibm.com/software/swnews/swnews.nsf/featurestoriesFM?ReadForm&amp;Site=wssoftware">News</a></li>
<li><a href="http://www.ibm.com/software/websphere/education/">Training</a></li>
<li><a href="http://www.ibm.com/developerworks/websphere/services/">Services</a></li>
<li><a href="http://www.ibm.com/software/websphere/support">Support</a></li>
</ul>
</div>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'java' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>

<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/java/">Java&#153; technology</a></li>
<li><a href="http://www.ibm.com/developerworks/java/newto/">New to Java programming</a></li>
<li><a href="http://www.ibm.com/developerworks/java/find/downloads/">Downloads &amp; products</a></li>
<li><a href="http://www.ibm.com/developerworks/java/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/java/find/standards/">Standards</a></li>
<li><a href="http://www.ibm.com/developerworks/java/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_jforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/java/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'linux' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>

<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/linux/">Linux</a></li>
<li><a href="http://www.ibm.com/developerworks/linux/newto/">New to Linux</a></li>
<li><a href="http://www.ibm.com/developerworks/linux/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/linux/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_lforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/linux/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'power' "> 
<!-- using t-pa-nav16-cell.ftl.no more power left nav, t-pa-nav16.ftl, but still have a power content area --> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/power/cell/">Cell/B.E. Resource Center</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'opensource' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>

<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/opensource/">Open source</a></li>
<li><a href="http://www.ibm.com/developerworks/opensource/newto/">New to Open source</a></li>
<li><a href="http://www.ibm.com/developerworks/opensource/find/projects/">Projects</a></li>
<li><a href="http://www.ibm.com/developerworks/opensource/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_osforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/opensource/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'webservices' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/webservices/">SOA and web services</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/newto/">New to SOA and web services</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/find/downloads/">Downloads &amp; products</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/standards/">Standards</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_wsforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'web' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/web/">Web development</a></li>
<li><a href="http://www.ibm.com/developerworks/web/newto/">New to Web development</a></li>
<li><a href="http://www.ibm.com/developerworks/web/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/web/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_waforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/web/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'xml' "> 
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/xml/">XML</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/newto/">New to XML</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/find/downloads/">Downloads &amp; products</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/find/projects/">Open source projects</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/standards/">Standards</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/library/">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/dw_xforums.jsp">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/xml/find/events/">Events</a></li>
</ul>
</div>
</xsl:when>
<xsl:otherwise>
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>
<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/">developerWorks</a></li>
</ul>
</div>
</xsl:otherwise>
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
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<xsl:comment> INCLUDES_FOR_SCRIPTS_AFTER_FOOTER </xsl:comment>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/aculo/prototypelt.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/dwspace/gadgetpopup.min.js">//</script>


</body>
</html>
</xsl:template>
</xsl:stylesheet>
