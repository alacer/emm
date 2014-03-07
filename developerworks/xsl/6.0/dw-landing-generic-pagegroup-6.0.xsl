<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Jul 16, 2010 (jpp):  PURPOSE:  This is the dw-landing-generic-pagegroup XSL for Maverick. This XSL processes the templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
   <!-- ========================================= -->
   <!-- Global variables and parameters -->
   <!-- ========================================= -->
   <!-- Passed from external application (Mav engine): START -->
   <!-- The following parms are declared in dw-tutorial-6.0.xsl and are shown here for reference only -->
   <!-- <xsl:param name="page-type" select=" '' "/> -->
   <!-- <xsl:param name="page-name" select=" '' "/> -->
   <!-- Passed from external application (Mav engine): END -->
   
 <!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
  <xsl:template match="dw-landing-generic-pagegroup">
		<!-- 6.0 Maverick R3 edtools and author package jpp/ishields 07/14/10: Declared template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />
		<xsl:param name="landing-page-name" select="$page-name" />  
		<!-- <xsl:param name="page-type" select="$page-type" />  -->
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
            <!-- Otherwise, test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- 6.0 Maverick R3 edtools/author package jpp/ishields 07/14/10: Added processing for preview -->
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-landing-generic-pagegroup-preview" />
                        </xsl:for-each>
                    </xsl:when>
					<!-- Create value for the title tag in head -->
					<xsl:when test="$template='titletag'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'FullTitle' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the abstract and description meta tags in head -->
					<xsl:when test="$template='abstract'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'FilterAbstract' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the keywords meta tag in head -->
					<xsl:when test="$template='keywords'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'keywords' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the DC.Date meta tag -->
					<xsl:when test="$template='dcDate'">
						<xsl:call-template name="dcDate-v16"/>
					</xsl:when>
					<!-- Create value for the DC.Type meta tag -->
					<xsl:when test="$template='dcType'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'dcType-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the DC.Subject meta tag -->
					<!-- Does not require a page-specific parameter to process result -->
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
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'webFeedDiscovery-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create breadcrumb trail and page title -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'Title-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create leadspace area for pagegroup pages  -->
					<xsl:when test="$template='feature'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'FeaturedContentModule-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create overview area for pagegroup pages -->
					<xsl:when test="$template='overview'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'PagegroupOverview-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create primary and secondary tabbed navigation, plus content space navigation -->
					<xsl:when test="$template='tabbedNav'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'TabbedNav-v16' " />
						</xsl:call-template>
					</xsl:when>
                   	<!-- Create docbody  -->
					<xsl:when test="$template='moduleDocbody'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'ModuleDocbody-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create downloads table  -->					
					<xsl:when test="$template='downloads'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'DownloadsLandingPagegroup-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create comments for CMA ID, Site ID, and Stylesheet used for transform  -->
					<xsl:when test="$template='cmaSiteStylesheetId'">
						<xsl:call-template name="cmaSiteStylesheetId-v16"/>
					</xsl:when>
					<!-- xM R2.2 egd 04 25 11:  Removed the call-template for BrandImage -->
					<!-- Contact module use (yes/no) -->
					<xsl:when test="$template='contactModuleUse'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'ContactModuleUse-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'HighVisModule-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create right-column content  -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'ModuleRightDocbodyHidefBuild-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Request left navigation -->
					<xsl:when test="$template='zoneLeftNav'">
						<xsl:call-template name="ZoneLeftNav-v16"/>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>
   
</xsl:stylesheet>