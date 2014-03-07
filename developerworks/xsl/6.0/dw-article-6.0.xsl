<?xml version="1.0" encoding="UTF-8"?>
<!-- egd added these two lines from dw-article xsl -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Jun 9 2008 (egd):  PURPOSE:  This is the dw-article xsl for the Maverick beta.  The Maveric application, using the article transform XML, passes a variable to this XSL.  The XSL processes that variable by calling the main template that transforms that piece of the article -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform this section of the article.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-article">
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declared template and transform parms -->
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
                    <xsl:call-template name="dw-article-preview" />
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
					<!-- 6.0 Maverick R2 fix egd 082909: Create url-tactic js variable in head -->
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
						<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added xsl with param for preview so could create bct from primary content area -->
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
					<!-- Create abstract text for summary area -->
					<xsl:when test="$template='abstractSummary'">
						<xsl:call-template name="AbstractForDisplaySummaryArea-v16"/>
					</xsl:when>
					<!-- Create series title text for summary area -->
					<xsl:when test="$template='seriesTitle'">
						<xsl:call-template name="SeriesTitle-v16"/>
					</xsl:when>
					<!-- 6.0 Maverick beta jpp 06/17/08: Create date published/updated text -->
					<xsl:when test="$template='date'">
						<xsl:call-template name="DateSummary-v16"/>
					</xsl:when>	
					<!-- 6.0 R2 llk 10/05/09  add date translated for local site content -->
						<xsl:when test="$template='translationDate'">
							<xsl:call-template name="TranslationDateSummary-v16"/>
						</xsl:when>								
                    <!-- Create skill level for summary area -->
					<xsl:when test="$template='skillLevel'">
						<xsl:call-template name="SkillLevel"/>
					</xsl:when>
					<!-- 6.0 R2 llk 10/01/09  link to english for local site content -->
					<xsl:when test="$template='linktoenglish'">
						<xsl:call-template name="LinkToEnglish-v16"/>
					</xsl:when>	
					<!-- 6.0 Maverick beta jpp 06/18/08: Create pdf text -->
					<xsl:when test="$template='pdf'">
						<xsl:call-template name="PDFSummary-v16"/>
					</xsl:when>	
					<!-- 6.0 Maverick beta jpp 06/17/08: Create Table of Contents -->
						<xsl:when test="$template='toc'">
					<xsl:call-template name="TableOfContents-v16"/>
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
					<!-- Create AuthorBottom section  -->
					<xsl:when test="$template='authorBio'">
						<xsl:call-template name="AuthorBottom"/>
					</xsl:when>
					<!-- 6.0 Maverick beta jpp 06/19/08: Create metadata for rating function -->
					<xsl:when test="$template='ratingMeta'">
						<xsl:call-template name="RatingMeta-v16"/>
					</xsl:when>
					<!-- 6.0 R2 Maverick llk 10/08/09: Create comments form for China article comments -->
			<xsl:when test="$template='cnComments'">
						<xsl:call-template name="cnComments-v16"/>
					</xsl:when>	
				</xsl:choose>   
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved AbstractFor DisplaySummaryArea-v16 template to dw-common --> 
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved cnComments-v16 template to dw-common -->	
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved JournalLink-v16 template to dw-common -->
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved DateSummary-v16 template to dw-common -->
	<!-- Maverick 6.0 R3 egd 08 26 10: Moved TranslationDateSummary-v16 to dw-common -->
	<!-- Maverick 6.0 R3 egd 08 26 10: Moved LinkToEnglish-v16 to dw-common -->	
	<!-- xM R2 egd 03 28 11:  Move PDFSummary-v16 to dw-common -->
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved RatingMeta-v16 template to dw-common -->
	<!-- Maverick 6.0 R3 egd 08 25 10: Moved SeriesTitle-v16 template to dw-common -->	
	<!-- xM R2 egd 03 28 11:  Moved TableOfContents-v16 to dw-common -->
	<!-- 6.0 Maverick R2 10 11 09 egd:  Moved template WebFeedDiscovery to common -->
</xsl:stylesheet>