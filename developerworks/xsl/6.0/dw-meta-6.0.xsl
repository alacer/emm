<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
<xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- Start:  template="META" -->
  <!-- ***NOT UPDATED for 6.0 -->
  <xsl:template name="Meta">
    <xsl:variable name="filteredabstract">
      <xsl:call-template name="FilterAbstract"/>
    </xsl:variable>
    <!-- 6.0 Maverick beta egd 06/14/08: commented out for beta since not creating the whole meta tag
    <xsl:text disable-output-escaping="yes">&lt;meta name="Abstract" content="</xsl:text> -->
    <!-- Sidefiles only:  Use title for meta abstract (no abstract element in dw-sidefile) -->
    <xsl:choose>
      <xsl:when test="dw-document/dw-sidefile">
        <xsl:value-of select="dw-document/dw-sidefile/title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$filteredabstract"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- 6.0 Maverick beta egd 06/14/08: commented out for beta since not creating the whole meta tag
    <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
    <xsl:text disable-output-escaping="yes">&lt;meta name="Description" content="</xsl:text>  -->
    <!-- Sidefiles only:  Use title for meta description (no abstract element in dw-sidefile) -->
    <xsl:choose>
      <xsl:when test="dw-document/dw-sidefile">
        <xsl:value-of select="dw-document/dw-sidefile/title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$filteredabstract"/>
      </xsl:otherwise>
    </xsl:choose>
     <!-- 6.0 Maverick beta egd 06/14/08: commented out for beta since not creating the whole meta tag
    <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text> -->
    <xsl:call-template name="keywords"/>
    <xsl:if test="not(/dw-document/dw-subscription-landing)">
      <xsl:variable name="dcdate">
        <xsl:choose>
          <xsl:when test="//date-updated">
            <xsl:value-of select="//date-updated/@year"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="//date-updated/@month"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="//date-updated/@day"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//date-published/@year"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="//date-published/@month"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="//date-published/@day"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:text disable-output-escaping="yes">&lt;meta name="DC.Date" scheme="iso8601" content="</xsl:text>
      <xsl:value-of select="$dcdate"/>
      <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
    </xsl:if>
    <xsl:text disable-output-escaping="yes">&lt;meta name="DC.Type" scheme="IBM_ContentClassTaxonomy" content="</xsl:text>
	   <xsl:choose>
			<xsl:when test="/dw-document//pagegroup">
				<xsl:for-each select="content/meta-information/meta-dctype">
					<xsl:choose>
						<xsl:when test="cma-defined-type!=''">
							<xsl:value-of select="cma-defined-type"/>
						</xsl:when> 
						<xsl:when test="((/dw-document/dw-landing-generic-pagegroup/pagegroup) and (cma-defined-type=''))">
							<xsl:text>CT801</xsl:text>
						</xsl:when>
						<xsl:when test="((/dw-document/dw-trial-program-pages/pagegroup) and (cma-defined-type=''))">
							<xsl:text>CT554</xsl:text>
						</xsl:when>						
				    </xsl:choose>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not(/dw-document/dw-landing-generic-pagegroup or /dw-document/dw-trial-program-pages)">
	    <xsl:choose>
			<xsl:when test="normalize-space(/dw-document//meta-dctype/cma-defined-type)!=''">
				<xsl:value-of select="/dw-document//meta-dctype/cma-defined-type"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="/dw-document/dw-article or /dw-document/dw-summary-long">
						<xsl:text>CT316</xsl:text>
					</xsl:when>
					<xsl:when test="(/dw-document/dw-landing-product/@page-type='product') or (/dw-document/dw-landing-product/@page-type='product-condensed')">
						<xsl:text>CT512</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-product/@page-type='product-family'">
						<xsl:text>CT509</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-tutorial">
						<xsl:text>CT321</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-chat">
						<xsl:text>CT916</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-demo">
						<xsl:text>CT551</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-event-tech-briefing">
						<xsl:text>CTA07</xsl:text>
					</xsl:when>
					<xsl:when test="(/dw-document/dw-summary-event-workshop-invite) or (/dw-document/dw-summary-event-workshop-result)">
						<xsl:text>CT320</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-podcast">
						<xsl:text>CTA18</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-presentation">
						<xsl:text>CT613</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-sample">
						<xsl:text>CT733</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-product/@page-type='integration'">
						<xsl:text>CT820</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-tutorial">
						<xsl:text>CT330</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-training">
						<xsl:text>CT329</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-generic">
						<xsl:text>CT801</xsl:text>
					</xsl:when> 
					<xsl:when test="/dw-document/dw-summary-registration">
						<xsl:text>CT102</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-download-general">
						<xsl:text>CT727</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-spec">
						<xsl:text>CT306</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-sidefile">
						<xsl:text>CTZZZ</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>CTZZZ</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
	<xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
    <xsl:text disable-output-escaping="yes">&lt;meta name="DC.Subject" scheme="IBM_SubjectTaxonomy" content="</xsl:text>
		<xsl:choose>
			 <xsl:when test="(/dw-document//content-area-primary/@name='autonomic') or (/dw-document//pagegroup/content-area-primary/@name='autonomic')">
				<xsl:text>TTD00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='architecture') or (/dw-document//pagegroup/content-area-primary/@name='architecture')">
				<xsl:text>TT200</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='aix') or (/dw-document//pagegroup/content-area-primary/@name='aix')">
				<xsl:text>SWG10</xsl:text>
			</xsl:when>
			<!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
			<xsl:when test="(/dw-document//content-area-primary/@name='data') or (/dw-document//pagegroup/content-area-primary/@name='data')">
				<xsl:text>BA.007H</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='grid') or (/dw-document//pagegroup/content-area-primary/@name='grid')">
				<xsl:text>TTE00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='ibm') or (/dw-document//pagegroup/content-area-primary/@name='ibm')">
				<xsl:text>SW700</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='java') or (/dw-document//pagegroup/content-area-primary/@name='java')">
				<xsl:text>TT300</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='linux') or (/dw-document//pagegroup/content-area-primary/@name='linux')">
				<xsl:text>SWGC0</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='lotus') or (/dw-document//pagegroup/content-area-primary/@name='lotus')">
				<xsl:text>BA.0080</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='none') or (/dw-document//pagegroup/content-area-primary/@name='none')">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='opensource') or (/dw-document//pagegroup/content-area-primary/@name='opensource')">
				<xsl:text>TT400</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='power') or (/dw-document//pagegroup/content-area-primary/@name='power')">
				<xsl:text>TT600</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='rational') or (/dw-document//pagegroup/content-area-primary/@name='rational')">
				<xsl:text>BA.007D</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='security') or (/dw-document//pagegroup/content-area-primary/@name='security')">
				<xsl:text>TTK00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='tivoli') or (/dw-document//pagegroup/content-area-primary/@name='tivoli')">
				<xsl:text>BA.0072</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='web') or (/dw-document//pagegroup/content-area-primary/@name='web')">
				<xsl:text>TTA00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='webservices') or (/dw-document//pagegroup/content-area-primary/@name='webservices')">
				<xsl:text>TT700</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='websphere') or (/dw-document//pagegroup/content-area-primary/@name='websphere')">
				<xsl:text>BA.007G</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='xml') or (/dw-document//pagegroup/content-area-primary/@name='xml')">
				<xsl:text>TTC00</xsl:text>
			</xsl:when>
		</xsl:choose>		
    <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
      <xsl:if test="not(/dw-document/dw-subscription-landing)">
      <xsl:variable name="copyrightyear">
        <xsl:value-of select="//date-published/@year"/>
      </xsl:variable>
      <xsl:text disable-output-escaping="yes">&lt;meta name="DC.Rights" content="Copyright (c) </xsl:text>
      <xsl:value-of select="$copyrightyear"/>
      <xsl:text disable-output-escaping="yes"> by IBM Corporation" /&gt;</xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="dw-document/dw-article">
        <xsl:text disable-output-escaping="yes"> &lt;meta name="Robots" content="index,follow" /&gt;</xsl:text>
      </xsl:when>
      <xsl:when test="dw-document/dw-sidefile">
        <xsl:text disable-output-escaping="yes"> &lt;meta name="Robots" content="noindex,nofollow" /&gt;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes"> &lt;meta name="Robots" content="index,follow" /&gt;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:variable name="effectivedate">
      <xsl:value-of select="//date-published/@year"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="//date-published/@month"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="//date-published/@day"/>
    </xsl:variable>
    <xsl:text disable-output-escaping="yes">&lt;meta name="IBM.Effective" scheme="W3CDTF" content="</xsl:text>
    <xsl:value-of select="$effectivedate"/>
    <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
    <xsl:variable name="lastupdated">
      <xsl:if test="//meta-last-updated">
        <xsl:value-of select="concat(//meta-last-updated/@day, //meta-last-updated/@month, //meta-last-updated/@year, //meta-last-updated/@initials)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:text disable-output-escaping="yes">&lt;meta name="Last update" content="</xsl:text>
    <xsl:value-of select="$lastupdated"/>
    <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
  </xsl:template>
  <!-- End:  template="META" -->
</xsl:stylesheet>
