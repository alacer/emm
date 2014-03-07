<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-home-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwhome = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>developerWorks : IBM's resource for developers and IT professionals</title>
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
<xsl:comment> ASK EDITORIAL TO REWRITE ABSTRACT </xsl:comment>
<meta name="Abstract" content="On developerWorks, IBM’s resource for developers and IT professionals, access tools, code, training, forums, blogs, community, standards, IT samples, downloads and how-to documentation for Rational, WebSphere, Information Management, Lotus, Tivoli, AIX and UNIX, architecture, and Web development, plus open source development and cross-platform, open standards technologies including Java, Linux, XML, SOA and Web services, Autonomic computing, Multicore acceleration."/>
<meta name="Description" content="On developerWorks, IBM’s resource for developers and IT professionals, access tools, code, training, forums, blogs, community, standards, IT samples, downloads and how-to documentation for Rational, WebSphere, Information Management, Lotus, Tivoli, AIX and UNIX, architecture, and Web development, plus open source development and cross-platform, open standards technologies including Java, Linux, XML, SOA and Web services, Autonomic computing, Multicore acceleration."/>
<meta name="Keywords" content="Rational, WebSphere, DB2, Informix, Information Management, IBM Systems, Lotus, Tivoli, Autonomic computing, Grid computing, Java, XML, Linux, open source, Web architecture, SOA, Web services, Wireless, Power Architecture, Multicore acceleration, tutorials, training, online courses, how-to, tips, tools, code, education, forums, blogs, articles, events, Webcasts, technical briefings, downloads, best practices, developer, programmer, system administrator, architect, computer programming resources, developer resources, software development, application development, free programming training, free programming tutorials, programming how to, components, objects, on-demand business, Software Development Platform"/>
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
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCHPGZZ" />
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
<div id="ibm-masthead">
<div id="ibm-logo"><a href="http://www.ibm.com/"><img height="50" src="http://dw1.s81c.com/i/v16/t/ibm-logo.gif" width="110" alt="IBM®" /></a></div>
<ul id="ibm-geo"><li id="ibm-country" class="ibm-first">Country/region</li><li id="ibm-change-country">[ <a href="http://www.ibm.com/developerworks/country/">select</a> ]</li></ul>
  <form id="ibm-search-form" action="http://www.ibm.com/developerworks/search/searchResults.jsp" method="get" name="form1"><input type="hidden" name="searchType" value="1"/><input type="hidden" name="searchSite" value="dW"/><p>
<span id="ibm-search-scope">
<label for="sn"><img src="http://dw1.s81c.com/i/c.gif" width="1" height="1" alt="Search in:"/></label>
<select name="searchScope" id="sn">
<option value="dW" selected="selected">All of dW</option>
<option value="dW">-----------------</option>
<option value="aixunix">&nbsp;AIX and UNIX</option>
<option value="db2">&nbsp;Information Mgmt</option>
<option value="lotus">&nbsp;Lotus</option>
<option value="rdd">&nbsp;Rational</option>
<option value="tivoli">&nbsp;Tivoli</option>  
<option value="WSDD">&nbsp;WebSphere</option>
<option value="dW">-----------------</option> 
<option value="archZ">&nbsp;Architecture</option>
<option value="javaZ">&nbsp;Java technology</option> 
<option value="linuxZ">&nbsp;Linux</option> 
<option value="paZ">&nbsp;Multicore resources</option>
<option value="opensrcZ">&nbsp;Open source</option>
<option value="webservZ">&nbsp;SOA/Web services</option>
<option value="webarchZ">&nbsp;Web development</option>  
<option value="xmlZ">&nbsp;XML</option>
<option value="dW">-----------------</option>
<option value="forums">&nbsp;dW forums</option> 
<option value="dW">-----------------</option>
<option value="aW">alphaWorks</option>
<option value="dW">-----------------</option>
<option value="all">All of IBM</option>
</select>
</span>

<label for="q"><img alt="Search for:" height="1" width="1" src="http://dw1.s81c.com/i/c.gif" /></label><input type="text" name="query" maxlength="100" id="q"/><input type="submit" id="ibm-search" class="ibm-btn-search" name="Search" value="Search" /></p></form>
<div id="ibm-site-name">
<xsl:comment> IBM site name container </xsl:comment>
</div>
<div id="ibm-universal-nav">
<ul><li id="ibm-unav-home" class="ibm-first"><a href="http://www.ibm.com/">Home</a></li><li id="ibm-unav-solutions"><a href="http://www.ibm.com/businesssolutions/">Business solutions</a></li><li id="ibm-unav-services"><a href="http://www.ibm.com/technologyservices/">IT services</a></li><li id="ibm-unav-products"><a href="http://www.ibm.com/products/">Products</a></li><li id="ibm-unav-support"><a href="http://www.ibm.com/support/">Support &amp; downloads</a></li><li id="ibm-unav-myibm"><a href="http://www.ibm.com/account/">My IBM</a></li></ul>
</div>
</div>

<xsl:comment> MASTHEAD_END </xsl:comment>

<div id="ibm-pcon">

<xsl:comment> CONTENT_BEGIN </xsl:comment>
<div id="ibm-content">

<xsl:comment> TITLE_BEGIN </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">title</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> TITLE_END </xsl:comment>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main">

<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
<xsl:comment> <!-- <#if dwhome.dateUpdated?exists>${dwhome.dateUpdated}</#if> --> </xsl:comment>
<xsl:apply-templates select=".">
<xsl:with-param name="template">feature</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">tabbedModule</xsl:with-param>
</xsl:apply-templates>
<xsl:apply-templates select=".">
<xsl:with-param name="template">moduleDocbody</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment>

<xsl:comment> SIGN-IN_MODULE_START </xsl:comment>
<!--<#if10 userWiID?exists>
	<xsl:comment> Authenticated user </xsl:comment>
	<#if100 dispName?exists>
		<xsl:comment> Authenticated user with display name </xsl:comment>
		<div class="ibm-container">
		<h2>My developerWorks</h2>
		<div class="ibm-container-body">
		<div id="dw-signin"><p>Welcome <strong>${dispName}</strong></p>
		<div class="ibm-rule"><hr /></div>
		<ul class="ibm-link-list ibm-alternate dw-signin-links">
		<li class="ibm-first"><xsl:element name="a">
<xsl:attribute name="href"><#if dw_auth_router_url?exists>${dw_auth_router_url}</#if>?m=chpro&amp;d= <#if pageUrl?exists>${pageUrl}</#if> </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Edit your profile
</xsl:element></li>
		<li><xsl:element name="a">
<xsl:attribute name="href"><#if dw_auth_router_url?exists>${dw_auth_router_url}</#if>?m=signout&amp;d= <#if pageUrl?exists>${pageUrl}</#if> </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Sign out
</xsl:element></li>
		</ul>
		<div class="ibm-rule"><hr /></div>
		<p>If you are not ${dispName} please click <xsl:element name="a">
<xsl:attribute name="href"><#if dw_auth_router_url?exists>${dw_auth_router_url}</#if>?m=signout&amp;d= <#if pageUrl?exists>${pageUrl}</#if> </xsl:attribute>here
</xsl:element></p>
		</div>
		</div>
		</div>
	<#else100>
		<xsl:comment> Authenticated user without display name</xsl:comment>
		<div class="ibm-container">
		<h2>My developerWorks</h2>
		<div class="ibm-container-body">
		<div id="dw-signin"><p>Welcome <strong>guest</strong></p>
		<div class="ibm-rule"><hr /></div>
		<ul class="ibm-link-list ibm-alternate dw-signin-links">
		<li class="ibm-first"><xsl:element name="a">
<xsl:attribute name="href"><#if dw_auth_router_url?exists>${dw_auth_router_url}</#if>?m=auth&d= <#if pageUrl?exists>${pageUrl}</#if> </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Create a screen name
</xsl:element></li>
		<li><xsl:element name="a">
<xsl:attribute name="href"><#if dw_auth_router_url?exists>${dw_auth_router_url}</#if>?m=signout&d= <#if pageUrl?exists>${pageUrl}</#if> </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Sign out
</xsl:element></li>
		</ul>
		</div>
		</div>
		</div>
	</#if100>
<#else10>-->
	<xsl:comment> Anonymous user </xsl:comment>
	<div class="ibm-container">
	<h2>My developerWorks</h2>
	<div class="ibm-container-body">
	<div id="dw-signin"><p>Welcome <strong>guest</strong></p>
	<div class="ibm-rule"><hr /></div>
	<ul class="ibm-link-list ibm-alternate dw-signin-links">
	<li class="ibm-first"><xsl:element name="a">
<xsl:attribute name="href">""?m=loginpage&amp;d= "" </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Sign in
</xsl:element></li>
	<li><xsl:element name="a">
<xsl:attribute name="href">""?m=reg&amp;d= "" </xsl:attribute>
<xsl:attribute name="class">ibm-forward-link</xsl:attribute>Register (free)
</xsl:element></li>
	</ul>
	</div>
	</div>
	</div>
<!-- </#if10> -->
<xsl:comment> SIGN-IN_MODULE_END </xsl:comment>
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
<xsl:comment> egd 10 29 08 across the site from prototype source </xsl:comment>
<div class="ibm-container ibm-show-hide">
<h2><a>My developerWorks community</a></h2>
<div class="ibm-container-body">
<p>Interact, share, communicate with developers worldwide.</p>
<div class="ibm-rule"><hr /></div>
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/homepage/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">My Home</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/profiles/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Profiles</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/groups/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Groups</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/blogs/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Blogs</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/bookmarks/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Bookmarks</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks/activities/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Activities</a></li>
<li><a href="http://www.ibm.com/developerworks/spaces/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Spaces</a></li>
<li><a href="http://www.ibm.com/developerworks/forums/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Forums</a></li>
<li><a href="http://www.ibm.com/developerworks/wikis/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Wikis</a></li>
<li><a href="http://www.ibm.com/developerworks/podcast/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Podcasts</a></li>
<li><a href="http://www.ibm.com/developerworks/exchange/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Exchange</a></li>
</ul>
<div class="ibm-rule"><hr /></div>
<p class="ibm-ind-link"><a class="ibm-forward-link" href="http://www.ibm.com/developerworks/mydeveloperworks/?S_TACT=105AGX01&amp;S_CMP=HP">My developerWorks overview</a></p>
</div>
<h2><a>Technical events</a></h2>
<div class="ibm-container-body">
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/offers/techbriefings?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Technical briefings</a></li>
<li><a href="http://www.ibm.com/developerworks/offers/techbriefings/events.html?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Technical events and webcasts</a></li>
</ul>
</div>
<h2><a>Technical library and training</a></h2>
<div class="ibm-container-body">
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/library/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Technical library</a></li>
<li><a href="http://www.ibm.com/developerworks/training/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Tutorials and training</a></li>
<li><a href="http://www.ibm.com/developerworks/dwbooks/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">developerWorks books: IBM Press books for developers</a></li>
</ul>
</div>
<h2><a>Downloads and demos</a></h2>
<div class="ibm-container-body">
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/downloads/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Trial downloads</a></li>
<li><a href="http://www.ibm.com/developerworks/offers/lp/demos/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Demos</a></li>
<li><a href="http://www.ibm.com/developerworks/offers/ekits/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">e-Kits</a></li>
</ul>
</div>
<h2><a>Software products</a></h2>
<div class="ibm-container-body">
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/products/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">A-Z software product index for developers</a></li>
<li><a href="http://www.ibm.com/developerworks/products/newto/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">New to IBM Software</a></li>
</ul>
</div>
<h2><a>Sample IT projects</a></h2>
<div class="ibm-container-body">
<p>Study complete development solutions using multiple technologies and products</p>
<div class="ibm-rule"><hr /></div>
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/scenarios/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Featured projects</a></li>
<li><a href="http://www.ibm.com/developerworks/scenarios/recent-projects.html?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Recent projects</a></li>
<li><a href="http://www.ibm.com/developerworks/scenarios/archived-projects.html?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Archived projects</a></li>
</ul>
</div>
<h2><a>Feeds and syndication</a></h2>
<div class="ibm-container-body">
<p>Import or export developerWorks content at your convenience.</p>
<div class="ibm-rule"><hr /></div>
<ul class="ibm-bullet-list">
<li><a href="http://www.ibm.com/developerworks/rss/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">RSS feeds</a></li>
<li><a href="http://www.ibm.com/developerworks/rss/atomfeeds.html?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Atom feeds</a></li>
<li><a href="http://www.ibm.com/developerworks/views/rss/customfeed.jsp?S_TACT=105AGX28&amp;S_CMP=DLMAIN" class="ibm-feature-link">Build your own feeds</a></li>
<li><a href="http://www.ibm.com/developerworks/dwgizmos/?S_TACT=105AGX01&amp;S_CMP=HP" class="ibm-feature-link">Export dW content</a></li>
</ul>
</div>
<h2><a>Newsletters</a></h2>
<div class="ibm-container-body">
<p>developerWorks has a variety of newsletters to fit your interests.</p>
<div class="ibm-rule"><hr /></div>
<p class="ibm-ind-link"><a class="ibm-forward-link" href="https://www.ibm.com/developerworks/newsletter/?S_TACT=105AGX01&amp;S_CMP=HP">Newsletters</a></p>
</div>
</div>
<xsl:apply-templates select=".">
<xsl:with-param name="template">highVisModule</xsl:with-param>
</xsl:apply-templates>
<xsl:comment> RIGHT_COLUMN_CONTENT_END </xsl:comment>

</div>
<xsl:comment> RIGHT_COLUMN_END </xsl:comment>

<xsl:comment> CONTENT_BODY_END </xsl:comment>
</div>

</div>
<xsl:comment> CONTENT_END </xsl:comment>
 
 <xsl:comment> LEFT_NAVIGATION_BEGIN </xsl:comment>
<div id="ibm-navigation">
<h2 class="ibm-access">Content navigation</h2>

<ul id="ibm-primary-links">
<li id="ibm-overview"><a href="http://www.ibm.com/developerworks/">developerWorks&#174;</a></li>
<li><a href="http://www.ibm.com/developerworks/aix/">AIX and UNIX</a></li>
<li><a href="http://www.ibm.com/developerworks/data/">Information Mgmt</a></li>
<li><a href="http://www.ibm.com/developerworks/lotus/">Lotus</a></li>
<li><a href="http://www.ibm.com/developerworks/rational/">Rational</a></li>
<li><a href="http://www.ibm.com/developerworks/tivoli/">Tivoli</a></li>
<li><a class="dw-separator" href="http://www.ibm.com/developerworks/websphere/">WebSphere</a></li>
<li><a href="http://www.ibm.com/developerworks/java/">Java&#153; technology</a></li>
<li><a href="http://www.ibm.com/developerworks/linux/">Linux</a></li>
<li><a href="http://www.ibm.com/developerworks/opensource/">Open source</a></li>
<li><a href="http://www.ibm.com/developerworks/webservices/">SOA and Web services</a></li>
<li><a href="http://www.ibm.com/developerworks/web/">Web development</a></li>
<li><a class="dw-separator" href="http://www.ibm.com/developerworks/xml/">XML</a></li>
<li><a href="http://www.ibm.com/developerworks/cloud/">Cloud computing</a></li>
<li><a class="dw-separator" href="http://www.ibm.com/developerworks/industry/">Industries</a></li>
<li><a href="http://www.ibm.com/developerworks/mydeveloperworks">My developerWorks</a></li>
<li><a href="http://www.ibm.com/developerworks/aboutdw/">About us</a></li>
<li><a href="https://www.ibm.com/developerworks/secure/myideas.jsp?start=true&amp;domain=">Submit article proposals</a></li>
<li><a href="https://www.ibm.com/developerworks/secure/feedback.jsp">Feedback</a></li>
</ul>

<div id="ibm-secondary-navigation">
<h2>Related links</h2>
<ul id="ibm-related-links">
<li><a href="http://www.ibm.com/isv/">ISV resources</a></li>
<li><a href="http://www.ibm.com/alphaworks/">alphaWorks (emerging technologies)</a></li>
<li><a href="http://www.ibm.com/developerworks/university/academicinitiative/">IBM Academic Initiative</a></li>
<li><a href="http://www.ibm.com/developerworks/university/students/">IBM Student Portal</a></li>
<li><a href="http://www.ibm.com/partnerworld/vic/">IBM Virtual Innovation Center (Bus. Partners)</a></li>
<li><a href="http://www.ibm.com/redbooks">IBM Redbooks</a></li>
<li><a href="http://www.ibm.com/ibmpress/">IBM Press books</a></li>
<li><a href="http://www.ibm.com/community/">IBM communities</a></li>
</ul>
<h2>Local sites</h2>
<ul>
<li><a href="http://www.ibm.com/developerworks/cn/">developerWorks <span style="white-space: nowrap;">中国</span></a></li>
<li><a href="http://www.ibm.com/developerworks/jp/">developerWorks <span style="white-space: nowrap;">Japan</span></a></li>
<li><a href="http://www.ibm.com/developerworks/kr/">developerWorks <span style="white-space: nowrap;">한국 </span></a></li>
<li><a href="http://www.ibm.com/developerworks/ru/">developerWorks <span style="white-space: nowrap;">Россия</span></a></li>
<li><a href="http://www.ibm.com/developerworks/br/">developerWorks <span style="white-space: nowrap;">Brasil</span></a></li>
<li><a href="http://www.ibm.com/developerworks/ssa/">developerWorks <span style="white-space: nowrap;">en español</span></a></li>
<li><a href="http://www.ibm.com/developerworks/vn/">developerWorks <span style="white-space: nowrap;">Việt Nam</span></a></li>
</ul>
</div>

</div>
<xsl:comment> LEFT_NAVIGATION_END </xsl:comment>

 <xsl:comment> END_IBM-PCON </xsl:comment>
</div>

<xsl:comment> SPECIAL_OFFERS_BEGIN </xsl:comment>
<!-- <#if specialOffers?exists>${specialOffers}</#if> -->
<xsl:comment> SPECIAL_OFFERS_END </xsl:comment>

<xsl:comment> FOOTER_BEGIN </xsl:comment>
<div id="ibm-page-tools">
<xsl:comment> IBM page tools container </xsl:comment>
</div>
<div id="ibm-footer">
<ul>
<li class="ibm-first"><a href="http://www.ibm.com/ibm/">About IBM</a></li>
<li><a href="http://www.ibm.com/privacy/">Privacy</a></li>
<li><a href="http://www.ibm.com/contact/">Contact</a></li>
<li><a href="http://www.ibm.com/legal/">Terms of use</a></li>
</ul>
</div>

<xsl:comment> FOOTER_END </xsl:comment>

 <xsl:comment> END_IBM-TOP </xsl:comment>
</div>

<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<xsl:comment> INCLUDES_FOR_SCRIPTS_AFTER_FOOTER </xsl:comment>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/aculo/prototypelt.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/dwspace/gadgetpopup.min.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://static.delicious.com/js/playtagger.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/portal/js/dwspace/dwdeli.js">//</script>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
