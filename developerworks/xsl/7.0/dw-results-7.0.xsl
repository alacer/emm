<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!-- OCT 10, 2011 (egd/jpp):  PURPOSE:  This is the dw-results XSL for Maverick. This XSL processes the XML templates for this content type -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
	<!-- Begin processing. Get the param and call the right template to transform this section of the page.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-results">
		<!-- Declare template and transform parms -->
		<xsl:param name="template"/>
		<xsl:param name="transform-zone"/>
		<xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))"/>
			<!-- Otherwise, test to see which variable the template variable name matches and then call the corresponding template that transforms that section of the page -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- Processing for preview option -->
					<xsl:when test="$template = 'preview' ">
						<xsl:for-each select=".">
							<xsl:call-template name="dw-content-preview"/>
						</xsl:for-each>
					</xsl:when>
					<!-- Create value for the html tag in head -->
					<xsl:when test="$template='htmltag'">
						<xsl:call-template name="MetaLanguageCountry-v17">
							<xsl:with-param name="return">htmltag</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the title tag in head -->
					<xsl:when test="$template='titletag'">
						<xsl:call-template name="FullTitle-v17"/>
					</xsl:when>
					<!-- Create value for the DC.Rights meta tag -->
					<xsl:when test="$template='dcRights'">
						<xsl:call-template name="dcRights-v17"/>
					</xsl:when>
					<!-- Create value for the keywords meta tag in head -->
					<xsl:when test="$template='keywords'">
						<xsl:call-template name="keywords-v17"/>
					</xsl:when>
					<!-- Create value for the DC.Date meta tag -->
					<xsl:when test="$template='dcDate'">
						<xsl:call-template name="dcDate-v17"/>
					</xsl:when>
					<!-- Create value for the abstract and description meta tags in head -->
					<xsl:when test="$template='abstract'">
						<xsl:call-template name="FilterAbstract-v17"/>
					</xsl:when>
					<!-- Create value for the IBM.Effective meta tag -->
					<xsl:when test="$template='ibmEffective'">
						<xsl:call-template name="ibmEffective-v17"/>
					</xsl:when>
					<!-- Create value for the DC.Subject meta tag -->
					<xsl:when test="$template='dcSubject'">
						<xsl:call-template name="dcSubject-v17"/>
					</xsl:when>
					<!-- Create value for the Owner meta tag -->
					<xsl:when test="$template='owner'">
						<xsl:call-template name="Owner-v17"/>
					</xsl:when>
					<!-- Create value for the DC.Language meta tag -->
					<xsl:when test="$template='dcLanguage'">
						<xsl:call-template name="MetaLanguageCountry-v17">
							<xsl:with-param name="return">dclanguage</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the ibmCountry meta tag -->
					<xsl:when test="$template='ibmCountry'">
						<xsl:call-template name="MetaLanguageCountry-v17">
							<xsl:with-param name="return">ibmcountry</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<!-- Create value for the DC.Type meta tag -->
					<xsl:when test="$template='dcType'">
						<xsl:call-template name="dcType-v17"/>
					</xsl:when>
					<!-- Project Defiant jpp 10/28/11: Added leadspaceStyles variable and call for LeadspaceStyles-v17 template -->
					<!-- Create leadspace styles  -->
					<xsl:when test="$template='leadspaceStyles'">
						<xsl:call-template name="LeadspaceStyles-v17"/>
					</xsl:when>
					<!-- Project Defiant jpp 11/27/11: Added leadspace variable and call for LeadspaceTitleArea-v17 template -->
					<!-- Create leadspace  -->
					<xsl:when test="$template='leadspace'">
						<xsl:call-template name="LeadspaceTitleArea-v17"/>
					</xsl:when>
					<!-- Project Defiant jpp 10/28/11: Added leadspaceTerm variable -->
					<!-- Create value for results term in leadspace -->
					<xsl:when test="$template='leadspaceTerm'">
						<xsl:call-template name="FullTitle-v17">
							<xsl:with-param name="return">leadspaceterm</xsl:with-param>
						</xsl:call-template>	
					</xsl:when>
					<!-- Create featured results area for editorial content -->
					<xsl:when test="$template='featuredResults'">
						<xsl:call-template name="FeaturedResultsArea-v17"/>
					</xsl:when>
					<!-- Create comments for CMA ID, Site ID, and Stylesheet used for transform  -->
					<xsl:when test="$template='cmaSiteStylesheetId'">
						<xsl:call-template name="cmaSiteStylesheetId-v17"/>
					</xsl:when>
					<!-- Insert poll overlay (Local site use only)  -->
					<!-- <xsl:when test="$template='pollid'">
						<xsl:call-template name="ModulePollsOverlay-v17"/>
					</xsl:when> -->
					<!-- Create poll (Local site use only) -->
					<!-- <xsl:when test="$template='polltext'">
						<xsl:call-template name="ModulePollsText-v17"/>
					</xsl:when> -->
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>