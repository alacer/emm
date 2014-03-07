<?xml version="1.0" encoding="UTF-8"?>
<!-- egd added these two lines from dw-article xsl -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Jun 9 2008 (egd):  PURPOSE:  This is the dw-article xsl for the Maverick beta.  The Maveric application, using the article transform XML, passes a variable to this XSL.  The XSL processes that variable by calling the main template that transforms that piece of the article -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the article.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-sidefile">
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declare template and transform parms -->
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
			<xsl:otherwise>
				<xsl:choose>
					<!-- Test to see which variable the tempalte variable name matches and then call the corresponding template that transforms that section of the article -->
					<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->	
					<xsl:when test="$template = 'preview' ">
                        <xsl:for-each select=".">
                            <xsl:call-template name="dw-sidefile-preview" />
                        </xsl:for-each>
                    </xsl:when>					
					<!-- Create value for the title tag in head -->
					<xsl:when test="$template='titletag'">
						<xsl:call-template name="FullTitle"/>
					</xsl:when>
					<!-- Create value for the abstract and description meta tags in head -->
					<xsl:when test="$template='abstract'">
						<xsl:call-template name="AbstractSidefile-v16"/>
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
					<!-- Create breadcrumbtrail test -->
					<xsl:when test="$template='breadcrumb'">
						<xsl:call-template name="Breadcrumb-v16">
						<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added xsl with param for preview so could create bct from primary content area -->
						<xsl:with-param name="transform-zone" select="$transform-zone"/>
						</xsl:call-template>
					</xsl:when>
					<!-- Create page title and subtitle, if one -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when>
					<!-- Create docbody  -->
					<xsl:when test="$template='docbody'">
						<xsl:apply-templates select="docbody"/>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	<!-- xM R2 egd 03 28 11:  Moved AbstractSidefile-v16 to dw-common -->
</xsl:stylesheet>
