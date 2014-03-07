<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Dec 16, 2009 (jpp):  PURPOSE:  This is the dw-landing-generic-pagegroup-hidef XSL for Maverick. This XSL processes the templates for this content type -->
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
  <xsl:template match="dw-landing-generic-pagegroup-hidef">
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
                            <xsl:call-template name="dw-landing-generic-pagegroup-hidef-preview" />
                        </xsl:for-each>
                    </xsl:when>
					<!-- 6.0 Maverick R3 jpp 07/14/10: Passing local landing-page-name parameter in each page-specific template call to correctly render both preview and final output -->
					<!-- xM R2 (R2.2) jpp 05/03/11:  Modified the following when tests to call PagegroupPageSelector template - titletag, abstract, keywords, dcType, webFeedDiscovery,
leadspace, tabbedNav, pageTitleHidef, contentSpaceNav, abstractLanding, moduleDocbodyHidef, highVisModule, moduleRightDocbody, hidefFooterModule -->
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
					<!-- Create leadspace area for high definition pages  -->
					<xsl:when test="$template='leadspace'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'LeadspaceHidefOptions-v16' " />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$template='tabbedNav'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'TabbedNav-v16' " />
						</xsl:call-template>
					</xsl:when>					
					<!-- Create page title  -->
					<xsl:when test="$template='pageTitleHidef'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'PageTitleHidef-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create content space navigation  -->
					<xsl:when test="$template='contentSpaceNav'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'PagegroupContentSpaceNavigation-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create visible abstract for page  -->
					<xsl:when test="$template='abstractLanding'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'AbstractLandingHidefBuild-v16' " />
						</xsl:call-template>
					</xsl:when>
                   	<!-- Create docbody  -->
					<xsl:when test="$template='moduleDocbodyHidef'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'ModuleDocbodyHidef-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create comments for CMA ID, Site ID, and Stylesheet used for transform  -->
					<xsl:when test="$template='cmaSiteStylesheetId'">
						<xsl:call-template name="cmaSiteStylesheetId-v16"/>
					</xsl:when>
					<!-- Create dW wordmark (default='yes') -->
					<!-- xM R2 (R2.1) jpp 04/11/11: Removed when test for dW wordmark.  Wordmark is no longer used -->
					<!-- xM R2.2 egd 04 25 11:  Removed the call-template for BrandImage -->
					<!-- Contact module use (yes/no) -->
					<xsl:when test="$template='contactModuleUse'">
						<xsl:call-template name="ContactModuleUse-v16"/>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'HighVisModuleHidef-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create right-column content  -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'ModuleRightDocbodyHidefBuild-v16' " />
						</xsl:call-template>
					</xsl:when>
					<!-- Create hi-def footer module  -->
					<xsl:when test="$template='hidefFooterModule'">
						<xsl:call-template name="PagegroupPageSelector-v16">
							<xsl:with-param name="landing-page-name" select="$landing-page-name" />
							<xsl:with-param name="landing-template-name" select=" 'HidefFooterModule-v16' " />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>
    <!-- xM R2 egd 03 28 11:  Moved AbstractLandingHidef-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved AbstractLandingHidefBuild-v16 to dw-common -->

	<!-- 6.0 Maverick R3 03/19/10 jpp: Added dWWordmark template -->
	<!-- 6.0 Maverick R3 05/03/10 llk:  add variable to enable local sites -->
	
	<!-- xM R2 (R2.1) jpp 04/11/11: Removed dWWordmark template.  Wordmark is no longer used -->
    
    <!-- xM R2 egd 03 28 11:  Moved HidefFooterModule-v16 to dw-common --> 
    <!-- xM R2 egd 03 28 11:  Moved HidefFooterModuleOptions-v16 to dw-common --> 
    <!-- xM R2 egd 03 28 11:  Moved HidefFooterModuleSections-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved LeadspaceHidef-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved LeadspaceHidefBuild-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved LeadspaceHidefOptions-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved ModuleDocbodyHidef-v16 to dw-common -->
	<!-- xM R2 egd 03 28 11:  Moved ModuleDocbodyHidefOptions-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved ModuleMultipleContainerBodyHidef-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved ModuleSingleContainerBodyHidef-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved PagegroupContentSpaceNavigation-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved PagegroupContentSpaceNavigationBuild-v16 to dw-common -->
    <!-- xM R2 egd 03 28 11:  Moved PagegroupContentSpaceNavigationLinkList-v16 to dw-common -->   
</xsl:stylesheet>