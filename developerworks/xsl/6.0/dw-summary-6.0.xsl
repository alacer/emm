<?xml version="1.0" encoding="UTF-8"?>
<!-- egd added these two lines from dw-article xsl -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Aug 13 2010 (egd):  PURPOSE:  This is the dw-summary xsl for Maverick.  The Maveric application, using the summary transform generator xsl, passes a variable to this XSL.  The XSL processes that variable by calling the main template that transforms that piece of the summary -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the article.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-summary">
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declared template and transform parms -->
		<xsl:param name="template"/>
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
			<xsl:otherwise>
				<xsl:choose>			
					<!-- Test to see which variable the tempalte variable name matches and then call the corresponding template that transforms that section of the summary -->
					<!-- Processing for oXygen preview -->					
					<xsl:when test="$template = 'preview' ">
						<xsl:for-each select=".">
							<xsl:call-template name="dw-summary-preview" />
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
					<!-- Create breadcrumbtrail test -->
					<xsl:when test="$template='breadcrumb'">
						<xsl:call-template name="Breadcrumb-v16">
							<!-- Create xsl with param for oXygen preview so can create bct from primary content area -->
							<xsl:with-param name="transform-zone" select="$transform-zone"/>
						</xsl:call-template>
					</xsl:when>
					<!-- Create page title and subtitle, if one -->
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when>
					<!-- Create author list in Summary area -->
					<xsl:when test="$template='authorList'">
						<xsl:call-template name="AuthorTop"/>
					</xsl:when>
					<!-- Create Contributors list for summary spec -->
					<xsl:when test="$template='companyName'">
						<xsl:call-template name="CompanyName"/>
					</xsl:when>
					<!-- Create Host list for summary workshop results -->
					<xsl:when test="$template='host'">
						<xsl:call-template name="Host"/>
					</xsl:when>	
					<!-- Create Summary type for summary briefing-->
					<xsl:when test="$template='summaryType'">
						<xsl:call-template name="SummaryType-v16"/>
					</xsl:when>	
					<!-- *** EGD NEED TO CREATE TYPE FOR BRIEFINGS -->				
					<!-- Create abstract text for summary area -->
					<xsl:when test="$template='abstractSummary'">
						<xsl:call-template name="AbstractForDisplaySummaryArea-v16"/>
					</xsl:when>
					<!-- Create series title text for summary area -->
					<xsl:when test="$template='seriesTitle'">
						<xsl:call-template name="SeriesTitle-v16"/>
					</xsl:when>	
						<!-- Create date published/updated text -->
					<xsl:when test="$template='date'">
						<xsl:call-template name="DateSummary-v16"/>
					</xsl:when>						
					<!-- Create date translated for local site content.  -->
						<xsl:when test="$template='translationDate'">
							<xsl:call-template name="TranslationDateSummary-v16"/>
						</xsl:when>
                    <!-- Create skill level for summary area -->
					<xsl:when test="$template='skillLevel'">
						<xsl:call-template name="SkillLevel"/>
					</xsl:when>
					<!-- Create link to english for local site content -->
					<xsl:when test="$template='linktoenglish'">
						<xsl:call-template name="LinkToEnglish-v16"/>
					</xsl:when>
					<!-- Create links to download table, registration, or view URL -->
					<!-- Create Registration or View link  -->
					<xsl:when test="$template='registrationView'">
						<xsl:call-template name="RegistrationViewLink-v16"/>
					</xsl:when>
					<!-- Create link to Download table  -->
					<xsl:when test="$template='downloadLink'">
						<xsl:call-template name="DownloadLink-v16"/>
					</xsl:when>
					<!-- Create value for the abstract and description meta tags in head -->
					<xsl:when test="$template='abstractBody'">
						<xsl:call-template name="AbstractForDisplay"/>
					</xsl:when>				
					<!-- Create docbody  -->
					<xsl:when test="$template='docbody'">
						<xsl:apply-templates select="docbody"/>
					</xsl:when>
					<!-- Create downloads section  -->
					<xsl:when test="$template='downloads'">
						<xsl:call-template name="Download"/>
					</xsl:when>
					<!-- Create Resources section  -->
					<xsl:when test="$template='resources'">
						<xsl:call-template name="ResourcesSection"/>
					</xsl:when>
					<!-- Create Customized logo for summary briefing  -->
					<xsl:when test="$template='customizedLogo'">
						<xsl:call-template name="CustomizedLogo"/>
					</xsl:when>
					<!-- Create AuthorBottom section  -->
					<xsl:when test="$template='authorBio'">
						<xsl:call-template name="AuthorBottom"/>
					</xsl:when>
					<!-- Create metadata for rating function -->
					<xsl:when test="$template='ratingMeta'">
						<xsl:call-template name="RatingMeta-v16"/>
					</xsl:when>
					<!-- Create comments form for China article comments -->
					<xsl:when test="$template='cnComments'">
						<xsl:call-template name="cnComments-v16"/>
					</xsl:when>
					<!-- Create right-column modules -->
					<xsl:when test="$template='moduleRightDocbody'">
						<xsl:call-template name="ModuleRightDocbody-v16"/>
					</xsl:when>
				</xsl:choose>   
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
</xsl:stylesheet>
