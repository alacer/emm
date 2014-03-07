<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Aug 5, 2009 (egd/jpp):  PURPOSE:  This is the dw-landing-product xsl for Maverick. This XSL processes the templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
  <xsl:template match="dw-landing-product">
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declared template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
			<xsl:otherwise>
				<xsl:choose>
                <!-- Test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
					<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->
					<!-- 6.0	Maverick R2 10 28 09 egd:  Uncommented preview code -->
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-landing-product-preview" />
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
					<!-- Create breadcrumb and page title -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when>
					<!-- Create page title and subtitle
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when> -->
					<!-- Create product description   -->
					<xsl:when test="$template='abstractProduct'">
						<xsl:call-template name="AbstractProduct-v16"/> 
					</xsl:when>
					<!-- Create feature  -->
					<xsl:when test="$template='feature'">
						<xsl:call-template name="FeaturedContentModule-v16"/>
					</xsl:when>	
					<!-- Create tabbedModule  -->
					<xsl:when test="$template='tabbedModule'">
						<xsl:call-template name="TabbedModule-v16"/>
					</xsl:when>	
                   	<!-- Create docbody  -->
					<xsl:when test="$template='moduleDocbody'">
						<xsl:call-template name="ModuleDocbody-v16"/>
					</xsl:when>
					<!-- Create comments for CMA ID, Site ID, and Stylesheet used for transform  -->
					<xsl:when test="$template='cmaSiteStylesheetId'">
						<xsl:call-template name="cmaSiteStylesheetId-v16"/>
					</xsl:when>
					<!-- xM R2.2 egd 04 25 11:  Removed the call-template for BrandImage -->
					<!-- 6.0 Maverick R2 10 11 09 egd:  Added contact module use -->
					<!-- Contact module use (yes/no) -->
					<xsl:when test="$template='contactModuleUse'">
						<xsl:call-template name="ContactModuleUse-v16"/>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="HighVisModule-v16"/>
					</xsl:when>
					<!-- Create spotlightModule  -->
					<xsl:when test="$template='spotlight'">
						<xsl:call-template name="SpotlightModule-v16"/>
					</xsl:when>
					<!-- xM R2 (R2.3) jpp/egd 07/29/11: Corrected comment -->
					<!-- Create moduleRightDocbody  -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="ModuleRightDocbody-v16"/>
					</xsl:when>
					<!-- xM R2 (R2.3) jpp/egd 07/29/11: Added call to RSSHeading-v16 -->
					<!-- Create RSS module heading  -->
					<xsl:when test="$template='rssHeading'">
						<xsl:call-template name="RSSHeading-v16"/>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>
    <!-- xM R2 egd 03 28 11:  Moved AbstractProduct-v16 to dw-common -->
</xsl:stylesheet>
