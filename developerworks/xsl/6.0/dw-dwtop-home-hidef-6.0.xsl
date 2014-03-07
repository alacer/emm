<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Oct 14, 2010 (egd/jpp):  PURPOSE:  This is the dw-dwtop-home-hidef XSL for Maverick. This XSL processes the XML templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
  <xsl:template match="dw-dwtop-home-hidef">
		<!-- Declare template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
            <!-- Otherwise, test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- Processing for preview option -->	
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-dwtop-home-hidef-preview" />
                        </xsl:for-each>
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
					<!-- Create feature  -->
					<!-- 6.0 xM R1 12/16/10 jpp: Changed to FeaturedContentModule-v16 template -->	
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
					<!-- RIGHT COLUMN MODULES -->
                   	<!-- Insert poll overlay (Local site use only)  -->
					<xsl:when test="$template='pollid'">
						<xsl:call-template name="ModulePollsOverlay-v16"/>
					</xsl:when>
					<!-- Create spotlightModule  -->
					<xsl:when test="$template='spotlight'">
						<xsl:call-template name="SpotlightModule-v16"/>
					</xsl:when>
					<!-- Create poll (Local site use only) -->
					<xsl:when test="$template='polltext'">
						<xsl:call-template name="ModulePollsText-v16"/>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="HighVisModule-v16"/>
					</xsl:when>
					<!-- 6.0 xM R1 12/14/10 jpp:  Added call for moduleRightDocbody template -->
					<!-- Process generic right column modules and/or includes  -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="ModuleRightDocbody-v16"/>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>
</xsl:stylesheet>