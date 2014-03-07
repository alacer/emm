<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Nov 21 2008 (jpp/egd):  PURPOSE:  This is the dw-home xsl for Maverick.  This XSL processes the templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
  <xsl:template match="dw-dwtop-home">
		 <!-- 6.0 Maverick edtools and author package ishields 05/2009: Declare template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
			<xsl:otherwise>
				<xsl:choose>
					<!-- Test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
					<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->	
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-home-preview" />
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
					<!-- Create page title and subtitle -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
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
					<!-- 6.0 llk add poll to top page for russia  (insert poll overlay here) -->
                   	<!-- Insert poll overlay   -->
					<xsl:when test="$template='pollid'">
						<xsl:call-template name="ModulePollsOverlay-v16"/>
					</xsl:when>
					<!-- Create spotlightModule  -->
					<xsl:when test="$template='spotlight'">
						<xsl:call-template name="SpotlightModule-v16"/>
					</xsl:when>
					<!-- 6.0 llk add poll to top page for russia (insert poll box here) -->
					<xsl:when test="$template='polltext'">
						<xsl:call-template name="ModulePollsText-v16"/>
					</xsl:when>
					<!-- Create highVisModule  -->
					<xsl:when test="$template='highVisModule'">
						<xsl:call-template name="HighVisModule-v16"/>
					</xsl:when>
				</xsl:choose>			  
			</xsl:otherwise>			
		</xsl:choose>	
    </xsl:template>	
</xsl:stylesheet>
