<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Sep 22, 2009 (egd/jpp):  PURPOSE:  This is the dw-landing-generic XSL for Maverick. This XSL processes the templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
  <xsl:template match="dw-landing-generic">
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declared template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
            <!-- Otherwise, test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->	
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-landing-generic-preview" />
                        </xsl:for-each>
                    </xsl:when>		
					<!-- Create value for the title tag in head -->
					<xsl:when test="$template='titletag'">
						<xsl:call-template name="FullTitle"/>
					</xsl:when>
					<!-- Create value for the abstract and description meta tags in head -->
					<xsl:when test="$template='abstract'">
						<xsl:call-template name="FilterAbstract"/>
					</xsl:when>
					<!-- Create value for the keywords meta tag in head -->
					<xsl:when test="$template='keywords'">
						<xsl:call-template name="keywords"/>
					</xsl:when>
					<!-- Create value for the DC.Date meta tag -->
					<xsl:when test="$template='dcDate'">
						<xsl:call-template name="dcDate-v16"/>
					</xsl:when>
					<!-- Create value for the DC.Type meta tag -->
					<xsl:when test="$template='dcType'">
						<xsl:call-template name="dcType-v16"/>
					</xsl:when>
					<!-- Create value for the DC.Subject meta tag -->
					<xsl:when test="$template='dcSubject'">
						<xsl:call-template name="dcSubject-v16"/>
					</xsl:when>
					<!-- Create value for the DC.Rights meta tag -->
					<xsl:when test="$template='dcRights'">
						<xsl:call-template name="dcRights-v16"/>
					</xsl:when>
					<!-- Create value for the IBM.Effective meta tag -->
					<xsl:when test="$template='ibmEffective'">
						<xsl:call-template name="ibmEffective-v16"/>
					</xsl:when>
					<!-- Create url-tactic js variable in head -->
					<xsl:when test="$template='urltactic'">
						<xsl:call-template name="urlTactic-v16"/>
					</xsl:when>
					<!-- Create Web feed autodiscovery link rel -->
					<xsl:when test="$template='webFeedDiscovery'">
						<xsl:call-template name="webFeedDiscovery-v16"/>
					</xsl:when>
					<!-- Create breadcrumb trail and page title -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when>
					<!-- Create feature  -->
					<xsl:when test="$template='feature'">
						<xsl:call-template name="FeaturedContentModule-v16"/>
					</xsl:when>
					<!-- Create content space navigation  -->
					<xsl:when test="$template='contentSpaceNav'">
						<xsl:call-template name="ContentSpaceNavigation-v16"/>
					</xsl:when>	
					<!-- Create product description   -->
					<xsl:when test="$template='abstractLanding'">
						<xsl:call-template name="AbstractLanding-v16"/> 
					</xsl:when>
					<!-- Create tabbedModule  -->
					<xsl:when test="$template='tabbedModule'">
						<xsl:call-template name="TabbedModule-v16"/>
					</xsl:when>	
                   	<!-- Create docbody  -->
					<xsl:when test="$template='moduleDocbody'">
						<xsl:call-template name="ModuleDocbody-v16"/>
					</xsl:when>
					<!-- 6.0 Maverick R2 10/13/09 09 jpp:  Added when test and template call to create Downloads table for landing generic page -->
					<!-- Create downloads table  -->
					<xsl:when test="$template='downloads'">
						<xsl:call-template name="DownloadsLanding-v16"/>
					</xsl:when>
					<!-- Create comments for CMA ID, Site ID, and Stylesheet used for transform  -->
					<xsl:when test="$template='cmaSiteStylesheetId'">
						<xsl:call-template name="cmaSiteStylesheetId-v16"/>
					</xsl:when>
					<!-- xM R2.2 egd 04 25 11:  Removed the call-template for BrandImage -->
					<!-- Contact module use (yes/no) -->
					<xsl:when test="$template='contactModuleUse'">
						<xsl:call-template name="ContactModuleUse-v16"/>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="HighVisModule-v16"/>
					</xsl:when>
					<!-- 6.0 Maverick R2 10/13/09 jpp: Commented out call to Spotlight template for landing generic -->
					<!-- Create spotlightModule -->
					<!-- <xsl:when test="$template='spotlight'">
						<xsl:call-template name="SpotlightModule-v16"/>
					</xsl:when>  -->
					<!-- Create highVisModule  -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="ModuleRightDocbody-v16"/>
					</xsl:when>
					<!-- Request left navigation -->
					<xsl:when test="$template='zoneLeftNav'">
						<xsl:call-template name="ZoneLeftNav-v16"/>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>
    <!-- xM R2 egd 03 28 11:  Moved AbstractLanding-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved ContentSpaceNavigation-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved ContentSpaceNavigationLinkList-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved DownloadsLanding-v16 to dw-common -->	
	<!-- 6.0 Maverick R3 jpp 07/27/10:  Moved LandingBreadcrumbSubLevel-v16 template into dw-common from dw-landing-generic -->
	<!-- xM R2 egd 03 28 11:  Moved ModuleBTTLink-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved ZoneLeftNav-v16 to dw-common -->
</xsl:stylesheet>