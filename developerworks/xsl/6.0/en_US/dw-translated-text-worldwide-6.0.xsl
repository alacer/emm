<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== --> 
    <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
    <!-- ibs 2012-02-06 FOP1.0 -->
    <!-- Absolute base path to images for document  (Used in CMA PDF processing) -->
    <xsl:param name="image-url-base"/>
   <!--  Provide local-url-base parameter.  -->
  <xsl:param name="local-url-base">..</xsl:param>
  <!-- Combine author and dwmaster variable definitions into parameter control.  
    Current legitimate values of 'preview' or 'final'. Might also be 'CMA' some day  -->
  <xsl:param name="xform-type">final</xsl:param>
    <!-- ibs 2012-02-06 FOP1.0 -->
     <xsl:variable name="nbsp" select=" '&#0160;' "/>
  <!--  For the first variable include otherwise clause and bail out if xform-type
    parameter not legitimate. Remaing vars will only be executed for valid xform-type.  -->
  <xsl:variable name="newpath-dw-root-local">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/</xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">Error! invalid value '<xsl:value-of
            select="xform-type" />' for xform-type parameter.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "
      >http://www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web-inc">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />../web/www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-ibm-local">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base" />/web/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-protocol">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' ">http://</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- START COMMON INTERMAL AND AUTHOR PACKAGE FILE PATH VARIABLES< ################################## --> 
  <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local"/>inc/</xsl:variable>    
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"/>i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/buttons/</xsl:variable>
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
  <!-- xM R2.2  egd 04 27 11:  Removed the old view path (www.ibm.com/developerworks/view/) since we're no longer using in any of the xsl files -->
  <xsl:variable name="path-dw-views"></xsl:variable>
  <xsl:variable name="path-ibm-stats"><xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/</xsl:variable>
  <xsl:variable name="path-ibm-rc-images"><xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/rc/images/</xsl:variable>
  <xsl:variable name="path-dw-js"><xsl:value-of select="$newpath-dw-root-web"/>js/</xsl:variable>
  <xsl:variable name="path-dw-email-js"><xsl:value-of select="$newpath-dw-root-web"/>email/</xsl:variable>
  <xsl:variable name="path-ibm-common-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>
  <xsl:variable name="path-ibm-common-stats"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/stats/</xsl:variable>
  <xsl:variable name="path-ibm-data-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/</xsl:variable>
  <xsl:variable name="path-ibm-survey-esites"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/survey/esites/</xsl:variable>
  <xsl:variable name="path-ibm-common-css"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>  
  <!-- ================= END FILE PATH VARIABLES =================== -->
  <!-- ================= START GENERAL VARIABLES =================== -->
    <!-- START EVENT  ##################################### -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Business perspectives</xsl:variable>
  <!-- END EVENT  ##################################### -->
  <xsl:variable name="main-content">skip to main content</xsl:variable>
  <!-- ================= END GENERAL VARIABLES =================== -->
 
  <!-- In template match="/" -->
  <xsl:variable name="Attrib-javaworld">Reprinted with permission from <a href="http://www.javaworld.com/?IBMDev">JavaWorld magazine</a>. Copyright IDG.net, an IDG Communications company.  Register for free <a href="http://www.javaworld.com/subscribe?IBMDev">JavaWorld email newsletters</a>.
</xsl:variable>
  <!-- 6.0 Maverick 6.0 jpp-egd 06/11/08: for 6.0, changed back to dw-document-html-6.0 for transform file since this file includes all the files and  is common among all sites -->
  <xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-6.0.xsl</xsl:variable>
  <xsl:variable name="browser-detection-js-url">http://www-128.ibm.com/developerworks/js/dwcss.js</xsl:variable>
  <xsl:variable name="default-css-url">http://www-128.ibm.com/developerworks/css/r1ss.css</xsl:variable>
  <xsl:variable name="col-icon-subdirectory">/developerworks/i/</xsl:variable>
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">This content is part of the</xsl:variable>
  <xsl:variable name="from">From</xsl:variable>
  <!-- In template name="AuthorBottom" -->
   <xsl:variable name="aboutTheAuthor">About the author</xsl:variable>
  <xsl:variable name="aboutTheAuthors">About the authors</xsl:variable>
  <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
   <xsl:variable name="biography">Biography</xsl:variable>
  <xsl:variable name="biographies">Biographies</xsl:variable>
  <!-- In template name="AuthorTop" -->
  <xsl:variable name="translated-by">Translated by: </xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">Date:</xsl:variable>
  <xsl:variable name="published">Published</xsl:variable>
  <!-- end 6.0 Maverick beta -->
  <xsl:variable name="updated">Updated </xsl:variable>
  <xsl:variable name="translated"></xsl:variable>
  <xsl:variable name="wwpublishdate"></xsl:variable>
  <xsl:variable name="linktoenglish-heading"></xsl:variable>
  <xsl:variable name="linktoenglish"></xsl:variable>
  <xsl:variable name="daychar"/>
  <xsl:variable name="monthchar"/>
  <xsl:variable name="yearchar"/>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF:</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
  <xsl:variable name="pdf-alt-letter">PDF format - letter</xsl:variable>
  <xsl:variable name="pdf-alt-a4">PDF format - A4</xsl:variable>
  <xsl:variable name="pdf-alt-common">PDF format - Fits A4 and Letter</xsl:variable>
  <xsl:variable name="pdf-text-letter">PDF - Letter</xsl:variable>
  <xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <xsl:variable name="pdf-text-common">PDF - Fits A4 and Letter</xsl:variable>
  <xsl:variable name="pdf-page">page</xsl:variable>
  <xsl:variable name="pdf-pages">pages</xsl:variable>  
  <!-- In template name=Document options -->
  <xsl:variable name="document-options-heading">Document options</xsl:variable>
  <!-- In template name="Download" -->
  <xsl:variable name="options-discuss">Discuss</xsl:variable>
  <xsl:variable name="sample-code">Sample code</xsl:variable>
  <xsl:variable name="download-heading">Download</xsl:variable>
  <xsl:variable name="downloads-heading">Downloads</xsl:variable>
  <xsl:variable name="download-note-heading">Note</xsl:variable>
  <xsl:variable name="download-notes-heading">Notes</xsl:variable>
  <xsl:variable name="also-available-heading">Also available</xsl:variable>
  <xsl:variable name="download-heading-more">More downloads</xsl:variable>
  <xsl:variable name="download-filename-heading">Name</xsl:variable>
  <xsl:variable name="download-filedescription-heading">Description</xsl:variable>
  <xsl:variable name="download-filesize-heading">Size</xsl:variable>
  <xsl:variable name="download-method-heading">Download method</xsl:variable>
 	<!-- 12/13/2011 - llk - added url to enable pdf localization -->
    <xsl:variable name="download-method-link-url">http://www.ibm.com/developerworks/library/whichmethod.html</xsl:variable>
   <xsl:variable name="download-method-link">Information about download methods</xsl:variable>
   <!-- Variables for content labels -->
	<xsl:variable name="code-sample-label">Code sample: </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value"></xsl:variable>
	<xsl:variable name="demo-label">Demo: </xsl:variable>
	<xsl:variable name="presentation-label">Presentation: </xsl:variable>
	<xsl:variable name="product-documentation-label">Product documentation: </xsl:variable>
	<xsl:variable name="specification-label">Specification: </xsl:variable>
	<xsl:variable name="technical-article-label">Technical article: </xsl:variable>
	<xsl:variable name="whitepaper-label">Whitepaper: </xsl:variable>
	<!-- Social tagging include -->
	<xsl:variable name="socialtagging-inc">
	<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>
  <!-- Adobe variable -->
  <xsl:variable name="download-get-adobe">
    <xsl:text disable-output-escaping="yes"><![CDATA[Get Adobe&#174; Reader&#174;]]></xsl:text>
  </xsl:variable>
  <!-- download-path variable not used by worldwide; "en_us" doesn't work if inserted into path.  Kept here so xsl resolves. -->
  <xsl:variable name="download-path">en_us</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/en_US/</xsl:variable>
    <xsl:variable name="product-doc-url">
    <a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;">Product documentation</a>
  </xsl:variable>
  <xsl:variable name="redbooks-url">
    <a href="http://www.redbooks.ibm.com/">IBM Redbooks</a>
  </xsl:variable>
  <xsl:variable name="tutorials-training-url">
    <a href="/developerworks/training/">Tutorials and training</a>
  </xsl:variable>
  <xsl:variable name="drivers-downloads-url">
    <a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Support downloads</a>
  </xsl:variable>
  <!-- In template name="Footer" -->
  <!-- Variable reference to a server side include -->
  <xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-footer14.inc" -->]]></xsl:text>
  </xsl:variable>
  <!-- Updated for MAVERICK -->
  <!-- in template name="BreadCrumb"  -->
  <xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/</xsl:variable>
       <!-- 12/13/2011 - llk - added top url for pdfs -->
    <xsl:variable name="developerworks-top-url-pdf">ibm.com/developerWorks/</xsl:variable>
  <xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/</xsl:variable>
  <xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
  <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">Technical topics</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">Evaluation software</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/downloads/</xsl:variable>
  <xsl:variable name="community-text">Community</xsl:variable>
 <xsl:variable name="community-url">http://www.ibm.com/developerworks/community/</xsl:variable>
  <xsl:variable name="events-text">Events</xsl:variable>
 <xsl:variable name="events-url">http://www.ibm.com/developerworks/events/</xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs -->
    <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_cont_v3.jpg</xsl:variable>
    <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_pro_v3.jpg</xsl:variable>
    <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast_v3.jpg</xsl:variable>
    <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast2.jpg</xsl:variable>
    <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast3.jpg</xsl:variable>
    <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast4.jpg</xsl:variable>
    <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast5.jpg</xsl:variable>
 <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
	 <xsl:variable name="contributing-author-alt">developerWorks Contributing author level</xsl:variable>
    <xsl:variable name="professional-author-alt">developerWorks Professional author level</xsl:variable>
    <xsl:variable name="master-author-alt">developerWorks Master author level</xsl:variable>
    <xsl:variable name="master2-author-alt">developerWorks Master author level 2</xsl:variable>
    <xsl:variable name="master3-author-alt">developerWorks Master author level 3</xsl:variable>
    <xsl:variable name="master4-author-alt">developerWorks Master author level 4</xsl:variable>
    <xsl:variable name="master5-author-alt">developerWorks Master author level 5</xsl:variable> 
 <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
   <xsl:variable name="contributing-author-text">(An IBM developerWorks Contributing Author)</xsl:variable>  
    <xsl:variable name="professional-author-text">(An IBM developerWorks Professional Author)</xsl:variable>  
    <xsl:variable name="master-author-text">(An IBM developerWorks Master Author)</xsl:variable>  
    <xsl:variable name="master2-author-text">(An IBM developerWorks Master Author, Level 2)</xsl:variable>  
    <xsl:variable name="master3-author-text">(An IBM developerWorks Master Author, Level 3)</xsl:variable>  
    <xsl:variable name="master4-author-text">(An IBM developerWorks Master Author, Level 4)</xsl:variable>  
    <xsl:variable name="master5-author-text">(An IBM developerWorks Master Author, Level 5)</xsl:variable>    
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <!-- Mobile & Agile 02/28/12 jmh: add variable for agile content area top url -->
   <!-- Big data (misc cleanup) 01/15/13 jmh: remove /connect from agile content area top url -->
   <xsl:variable name="agile-top-url">http://www.ibm.com/developerworks/agile/</xsl:variable>
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/aix/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area top url -->
   <xsl:variable name="analytics-top-url">http://www.ibm.com/developerworks/analytics/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/architecture/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/data/</xsl:variable>
   <!-- Big data 01/15/13 jmh: add variable for bigdata content area top url -->
   <xsl:variable name="bigdata-top-url">http://www.ibm.com/developerworks/bigdata/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area top url -->
   <xsl:variable name="bpm-top-url">http://www.ibm.com/developerworks/bpm/</xsl:variable>
   <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
    <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/cloud/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce content area top url -->
   <xsl:variable name="commerce-top-url">http://www.ibm.com/developerworks/commerce/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/scenarios/</xsl:variable>
    <!-- xM R2 egd 03 10 11:  Create variable for the ibm i zone URL -->
    <!-- xM R2 egd 04 05 11:  Update for change in ibm i URL -->
   <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/ibmi/</xsl:variable>
    <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
    <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/industry/</xsl:variable>
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/lotus/</xsl:variable>
   <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area top url -->
   <!-- Mobile update 04/09/12 jmh: remove connect from mobile content area top url -->
   <xsl:variable name="mobile-top-url">http://www.ibm.com/developerworks/mobile/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/power/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url"></xsl:variable>   
    <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security content area top url -->
   <xsl:variable name="security-top-url">http://www.ibm.com/developerworks/security/</xsl:variable>
   <xsl:variable name="autonomic-top-url"></xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/rational/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area top url -->
   <xsl:variable name="smc-top-url">http://www.ibm.com/developerworks/servicemanagement/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/web/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/webservices/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/xml/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
      <!-- 6.0 Maverick R3 egd 04 22 10:  Added variables for global library url and text on dW home tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/library/</xsl:variable>
    <xsl:variable name="dw-global-library-text">More content</xsl:variable>
  <xsl:variable name="technical-library">Technical library</xsl:variable>      
  <!-- no longer have www-130, but left this b/c variables not updated in code -->
  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/</xsl:variable>
  <!-- in template name="heading"  -->
  <xsl:variable name="figurechar"/>
  <!-- WW site does not use, but need for xsl continuity -->
  <!-- In template name="IconLinks" -->
  <xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
  <xsl:variable name="icon-discuss-alt">Discuss</xsl:variable>
  <xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
  <xsl:variable name="icon-code-download-alt">Download</xsl:variable>
  <xsl:variable name="icon-code-alt">Code</xsl:variable>
  <xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
  <xsl:variable name="Summary">Summary</xsl:variable>
  <xsl:variable name="english-source-heading"/>
  <!-- lang value.. used in email to friend for dbcs -->
  <xsl:variable name="lang"/>
  <!-- In template name="Indicators" -->
  <xsl:variable name="level-text-heading">Level: </xsl:variable>
  <!-- In template name="Masthead" -->
  <!-- topmast-inc in the WW translated text has been TEMPORARILY redefined to have a value of the include for s-topmast14. -->
  <xsl:variable name="topmast-inc">
  <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-topmast14.inc" -->]]></xsl:text>
   </xsl:variable>
  <!-- In template name="LeftNav" -->
  <!-- 6.0 Maverick beta egd 06/14/08: Not using for Maverick data, created series and seriesview for series title in Summary area -->
  <xsl:variable name="moreThisSeries">More in this series</xsl:variable>
  <!-- End Not using for Maverick series title -->
  <xsl:variable name="left-nav-in-this-article">In this article:</xsl:variable>
  <xsl:variable name="left-nav-in-this-tutorial">In this tutorial:</xsl:variable>
   <!-- In template name="LeftNavSummary" -->
   <xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-nav14-top.inc" -->]]></xsl:text></xsl:variable>
   <xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
   <!-- In template name="LeftNavSummaryInc" -->
   <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ar-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-au-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-au-nav14-events.inc" -->]]></xsl:text>      </xsl:variable>
  <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ac-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ac-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-dm-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-dm-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-gr-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-j-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-l-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-ls-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-os-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-pa-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-r-nav14-events.inc" -->]]></xsl:text></xsl:variable>
<!--  some left nav inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-r-nav14-training.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-tv-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-tv-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-wa-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ws-nav14-standards.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ws-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-w-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-w-nav14-events.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/d-w-nav14-training.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-x-nav14-events.inc" -->]]></xsl:text></xsl:variable>
  <!-- In template name="META" -->
  <xsl:variable name="owner-meta-url"> https://www-136.ibm.com/developerworks/secure/feedback.jsp?domain=</xsl:variable>
  <xsl:variable name="dclanguage-content">en-us</xsl:variable>
  <xsl:variable name="ibmcountry-content">zz</xsl:variable>
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>
  <!-- In template name="ModeratorBottom -->
   <xsl:variable name="aboutTheModerator">About the moderator</xsl:variable>
  <xsl:variable name="aboutTheModerators">About the moderators</xsl:variable>
  <!-- In template name="MonthName" -->
  <xsl:variable name="month-1-text">Jan</xsl:variable>
  <xsl:variable name="month-2-text">Feb</xsl:variable>
  <xsl:variable name="month-3-text">Mar</xsl:variable>
  <xsl:variable name="month-4-text">Apr</xsl:variable>
  <xsl:variable name="month-5-text">May</xsl:variable>
  <xsl:variable name="month-6-text">Jun</xsl:variable>
  <xsl:variable name="month-7-text">Jul</xsl:variable>
  <xsl:variable name="month-8-text">Aug</xsl:variable>
  <xsl:variable name="month-9-text">Sep</xsl:variable>
  <xsl:variable name="month-10-text">Oct</xsl:variable>
  <xsl:variable name="month-11-text">Nov</xsl:variable>
  <xsl:variable name="month-12-text">Dec</xsl:variable>
  <!-- In template name="PageNavigator" -->
  <xsl:variable name="page">Page</xsl:variable>
  <xsl:variable name="of">of</xsl:variable>
  <xsl:variable name="pageofendtext"></xsl:variable>	
   <xsl:variable name="previoustext">Go to the previous page</xsl:variable>
   <xsl:variable name="nexttext">Go to the next page</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">Previous</xsl:variable>
  <xsl:variable name="next">Next</xsl:variable>
  <!-- In template name="RelatedContents" -->
  <xsl:variable name="related-content-heading">Related content:</xsl:variable>
  <!-- In template name RelatedLinks -->
  <xsl:variable name="left-nav-related-links-heading">Related links</xsl:variable>
  <xsl:variable name="left-nav-related-links-techlib">technical library</xsl:variable>
  <!-- In template name="Subscriptions" -->
  <xsl:variable name="subscriptions-heading">Subscriptions:</xsl:variable>
  <xsl:variable name="dw-newsletter-text">dW newsletters</xsl:variable>
  <xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/newsletter/</xsl:variable>
  <xsl:variable name="rational-edge-text">The Rational Edge</xsl:variable>
  <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
  <!-- In template name="Resources" and "TableofContents" -->
   <xsl:variable name="resource-list-heading">Resources</xsl:variable>
  <!-- In template name="resourcelist/ul" -->
  <xsl:variable name="resource-list-forum-text">
   <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">Participate in the discussion forum</a>.]]></xsl:text></xsl:variable>
  <!-- In template "resources" -->
  <xsl:variable name="resources-learn">Learn</xsl:variable>
  <xsl:variable name="resources-get">Get products and technologies</xsl:variable>
  <xsl:variable name="resources-discuss">Discuss</xsl:variable>
  
  <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">Develop skills on this topic</xsl:variable>
  <xsl:variable name="knowledge-path-text">This content is part of a progressive knowledge path for advancing your skills.  See</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">This content is part of progressive knowledge paths for advancing your skills.  See:</xsl:variable>
  
  <!-- In template name="SkillLevel" -->
  <xsl:variable name="level-1-text">Introductory</xsl:variable>
  <xsl:variable name="level-2-text">Introductory</xsl:variable>
  <xsl:variable name="level-3-text">Intermediate</xsl:variable>
  <xsl:variable name="level-4-text">Advanced</xsl:variable>
  <xsl:variable name="level-5-text">Advanced</xsl:variable>
  <!-- In template name="TableOfContents" -->
  <xsl:variable name="tableofcontents-heading">Contents:</xsl:variable>
  <xsl:variable name="ratethisarticle-heading">Rate this page</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">Table of contents</xsl:variable>
  <xsl:variable name="inline-comments-heading">Comments</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
  <!-- Ratings -->
  <xsl:variable name="ratethistutorial-heading">Rate this tutorial</xsl:variable>
   <xsl:variable name="domino-ratings-post-url">http://www.alphaworks.ibm.com/developerworks/ratings.nsf/RateArticle?CreateDocument</xsl:variable>
  <xsl:variable name="method">POST</xsl:variable>
  <xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/thankyou/feedback-thankyou.html</xsl:variable>
   <xsl:variable name="ratings-intro-text">Please take a moment to complete this form to help us better serve you.</xsl:variable>
  <xsl:variable name="ratings-question-text">This content was helpful to me:</xsl:variable>
  <xsl:variable name="ratings-value5-text">Strongly agree (5)</xsl:variable>
  <xsl:variable name="ratings-value4-text">Agree (4)</xsl:variable>
  <xsl:variable name="ratings-value3-text">Neutral (3)</xsl:variable>
  <xsl:variable name="ratings-value2-text">Disagree (2)</xsl:variable>
  <xsl:variable name="ratings-value1-text">Strongly disagree (1)</xsl:variable>
  <xsl:variable name="ratings-value5-width">21%</xsl:variable>
  <xsl:variable name="ratings-value4-width">17%</xsl:variable>
  <xsl:variable name="ratings-value3-width">24%</xsl:variable>
  <xsl:variable name="ratings-value2-width">17%</xsl:variable>
  <xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <xsl:variable name="comments-noforum-text">Comments?</xsl:variable>
  <xsl:variable name="comments-withforum-text">Send us your comments or click Discuss to share your comments with others.</xsl:variable>
  <xsl:variable name="submit-feedback-text">Submit feedback</xsl:variable>
  <xsl:variable name="site_id">1</xsl:variable>
  <!-- in template name="ContentAreaName" and "ContentAreaNameExtended"-->
  <!-- 6.0 Maverick beta egd 06/12/08: Using contentarea-ui-names unchanged to create part of bct -->
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <!-- Mobile & Agile 02/28/12 jmh: add variable for agile content area name -->
  <xsl:variable name="contentarea-ui-name-agile">Agile transformation</xsl:variable>
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area name -->
  <xsl:variable name="contentarea-ui-name-analytics">Business analytics</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ar">Architecture</xsl:variable>
  <xsl:variable name="contentarea-ui-name-au">AIX and UNIX</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ac">Autonomic computing</xsl:variable>
  <!-- Big data 01/15/13 jmh: add variable for bigdata content area name -->
  <xsl:variable name="contentarea-ui-name-bigdata">Big data</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Blogs</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce content area name -->
  <xsl:variable name="contentarea-ui-name-commerce">Commerce</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-community">Community</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Downloads</xsl:variable>
  <xsl:variable name="contentarea-ui-name-gr">Grid computing</xsl:variable>
  <xsl:variable name="contentarea-ui-name-j">Java technology</xsl:variable>
  <xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
  <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area name -->
  <xsl:variable name="contentarea-ui-name-mobile">Mobile development</xsl:variable>
  <xsl:variable name="contentarea-ui-name-os">Open source</xsl:variable>
  <!-- Maverick 6.0 R3 egd 10 03 10:  Change W to w in Web per editorial team request -->
  <xsl:variable name="contentarea-ui-name-ws">SOA and web services</xsl:variable>
  <xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
  <xsl:variable name="contentarea-ui-name-s">Security</xsl:variable>
  <xsl:variable name="contentarea-ui-name-wa">Web development</xsl:variable>
  <xsl:variable name="contentarea-ui-name-i">Sample IT projects</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area name -->
  <xsl:variable name="contentarea-ui-name-bpm">Business process management</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
  <xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
  <xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
  <xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
 <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area name -->
 <!-- 07/10/12 jmh: change variable value to Service management  -->
 <!-- 01/15/13 jmh: change variable value to Tivoli (service management)  -->
  <xsl:variable name="contentarea-ui-name-smc">Tivoli (service management)</xsl:variable>
  <xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
  <xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
  <xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
  <!-- in template name="TechLibView" -->
  <!-- 6.0 Maverick beta egd 06/12/08: Using techlibview unchanged to create part of bct -->
   <!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
   <!-- xM R2.2 egd 04 27:  Changes all techlibview-xxx variable URLs to the new, short view URLs (www.ibm.com/developerworks/contentareaname/library/) -->
  <!-- Mobile & Agile 02/28/12 jmh: add variable for agile tech library view url -->
  <xsl:variable name="techlibview-agile">http://www.ibm.com/developerworks/agile/library/</xsl:variable>
  <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile tech library view url -->
  <xsl:variable name="techlibview-mobile">http://www.ibm.com/developerworks/mobile/library/</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics tech library view url -->
  <xsl:variable name="techlibview-analytics">http://www.ibm.com/developerworks/analytics/library/</xsl:variable>
  <!-- Big data 01/15/13 jmh: add variable for bigdata tech library view url -->
  <xsl:variable name="techlibview-bigdata">http://www.ibm.com/developerworks/bigdata/library/</xsl:variable>  
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce tech library view url -->
  <xsl:variable name="techlibview-commerce">http://www.ibm.com/developerworks/commerce/library/</xsl:variable>
  <xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/data/library/</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm tech library view url -->
  <xsl:variable name="techlibview-bpm">http://www.ibm.com/developerworks/bpm/library/</xsl:variable>
   <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/cloud/library/</xsl:variable>
   <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/industry/library/</xsl:variable>
  <!-- xM R2.2  egd 04 27 11:  Removed the library view URL for architecture since we no longer have a view -->
  <xsl:variable name="techlibview-ar"></xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security tech library view url -->
  <xsl:variable name="techlibview-s">http://www.ibm.com/developerworks/security/library/</xsl:variable>
  <!-- xM R2.2  egd 04 27 11:  Removed the article library view URL for ibm since we no longer have a view -->
  <xsl:variable name="techlibview-i"></xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/lotus/library/</xsl:variable>
  <xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/rational/library/</xsl:variable>
 <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc tech library view url -->
  <xsl:variable name="techlibview-smc">http://www.ibm.com/developerworks/servicemanagement/library/</xsl:variable>	
  <xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/tivoli/library/</xsl:variable>
  <xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/websphere/library/</xsl:variable>
  <xsl:variable name="techlibview-au">http://www.ibm.com/developerworks/aix/library/</xsl:variable>
   <!-- xM R2.2  egd 04 27 11:  Removed the library view URL for autonomic since we no longer have a view -->
  <xsl:variable name="techlibview-ac"></xsl:variable>
   <!-- xM R2.2  egd 04 27 11:  Removed the library view URL for grid since we no longer have a view -->
  <xsl:variable name="techlibview-gr"></xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/java/library/</xsl:variable>
  <xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/linux/library/</xsl:variable>
  <xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/opensource/library/</xsl:variable>
  <xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/power/library/</xsl:variable>
  <xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/webservices/library/</xsl:variable>
  <xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/web/library/</xsl:variable>
  <xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/xml/library/</xsl:variable>
  <!-- In template name="ProductsLandingURL" -->
   <!--  04/26/12 jmh: removed unneeded products-landing entries for Agile, Mobile, SMC   -->
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics product landing page url -->
  <xsl:variable name="products-landing-analytics">
   <xsl:value-of select="$developerworks-top-url"/>analytics/products/</xsl:variable>
  <xsl:variable name="products-landing-au">
    <xsl:value-of select="$developerworks-top-url"/>aix/products/</xsl:variable>
  <!-- Big data 01/15/13 jmh: add variable for bigdata product landing page url -->
  <xsl:variable name="products-landing-bigdata">
   <xsl:value-of select="$developerworks-top-url"/>bigdata/products/</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm product landing page url -->
  <xsl:variable name="products-landing-bpm">
    <xsl:value-of select="$developerworks-top-url"/>bpm/products/</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce product landing page url -->
  <xsl:variable name="products-landing-commerce">
   <xsl:value-of select="$developerworks-top-url"/>commerce/products/</xsl:variable>
  <xsl:variable name="products-landing-db2">
    <xsl:value-of select="$developerworks-top-url"/>data/products/</xsl:variable>
   <xsl:variable name="products-landing-lo">
    <xsl:value-of select="$developerworks-top-url"/>lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r">
    <xsl:value-of select="$developerworks-secondary-url"/>rational/products/</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security product landing page url -->
  <xsl:variable name="products-landing-security">
   <xsl:value-of select="$developerworks-top-url"/>security/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv">
    <xsl:value-of select="$developerworks-top-url"/>tivoli/products/</xsl:variable>
  <xsl:variable name="products-landing-web">
    <xsl:value-of select="$developerworks-top-url"/>websphere/products/</xsl:variable>
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
   <xsl:variable name="support-search-text-intro">For a comprehensive selection of troubleshooting documents,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">search the IBM technical support knowledge base</xsl:variable> 
  <!-- SUMMARY DOC SECTION HEADINGS -->
  <xsl:variable name="summary-inThisChat">In this chat</xsl:variable>
   <xsl:variable name="summary-inThisDemo">In this demo</xsl:variable>
  <xsl:variable name="summary-inThisTutorial">In this tutorial</xsl:variable>
  <xsl:variable name="summary-inThisLongdoc">In this article</xsl:variable>
  <xsl:variable name="summary-inThisPresentation">In this presentation</xsl:variable>
  <xsl:variable name="summary-inThisSample">In this sample</xsl:variable>
  <xsl:variable name="summary-inThisCourse">In this course</xsl:variable>
  <xsl:variable name="summary-objectives">Objectives</xsl:variable>
  <xsl:variable name="summary-prerequisities">Prerequisites</xsl:variable>
  <xsl:variable name="summary-systemRequirements">System requirements</xsl:variable>
  <xsl:variable name="summary-duration">Duration</xsl:variable>
  <xsl:variable name="summary-audience">Audience</xsl:variable>
  <xsl:variable name="summary-languages">Languages</xsl:variable>
  <xsl:variable name="summary-formats">Formats</xsl:variable>
  <xsl:variable name="summary-minor-heading">Summary minor heading</xsl:variable>
  <xsl:variable name="summary-getTheArticle">Get the article</xsl:variable>
  <xsl:variable name="summary-getTheWhitepaper">Get the whitepaper</xsl:variable>
  <xsl:variable name="summary-getThePresentation">Get the presentation</xsl:variable>
  <xsl:variable name="summary-getTheDemo">Get the demo</xsl:variable>
  <xsl:variable name="summary-linktotheContent">Link to the content</xsl:variable>
  <xsl:variable name="summary-getTheDownload">Get the download</xsl:variable>
  <xsl:variable name="summary-getTheDownloads">Get the downloads</xsl:variable>
  <xsl:variable name="summary-getTheSample">Get the sample</xsl:variable>
  <xsl:variable name="summary-rateThisContent">Rate this content</xsl:variable>
  <xsl:variable name="summary-getTheSpecification">Get the specification</xsl:variable>
  <xsl:variable name="summary-contributors">Contributors: </xsl:variable>
  <xsl:variable name="summary-aboutTheInstructor">About the instructor</xsl:variable>
  <xsl:variable name="summary-aboutTheInstructors">About the instructors</xsl:variable>
  <xsl:variable name="summary-viewSchedules">View schedules and enroll</xsl:variable>
  <xsl:variable name="summary-viewSchedule">View schedule and enroll</xsl:variable>
  <xsl:variable name="summary-aboutThisCourse">About this course</xsl:variable>
  <xsl:variable name="summary-webBasedTraining">Web-based training</xsl:variable>
  <xsl:variable name="summary-instructorLedTraining">Instructor led training</xsl:variable>
  <xsl:variable name="summary-classroomTraining">Classroom training</xsl:variable>
  <xsl:variable name="summary-courseType">Course Type:</xsl:variable>
  <xsl:variable name="summary-courseNumber">Course Number:</xsl:variable>
  <xsl:variable name="summary-scheduleCourse">Course</xsl:variable>
  <xsl:variable name="summary-scheduleCenter">Education Center</xsl:variable>
  <xsl:variable name="summary-classroomCourse">Classroom course</xsl:variable>
  <xsl:variable name="summary-onlineInstructorLedCourse">On-line instructor led course</xsl:variable>
  <xsl:variable name="summary-webBasedCourse">Web based course</xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere1">For private offerings of this course, please contact us at </xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere2">. IBM internal students should enroll via Global Campus.</xsl:variable>
  <xsl:variable name="summary-plural">s</xsl:variable>
  <!-- SUMMARY DOC SECTION HEADINGS END -->
  <!-- other summary variables -->
   <!-- Maverick 6.0 R3 09 18 10 egd:  Removed period from summary-register and summary-view -->
  <xsl:variable name="summary-register">Register now or sign in using your IBM ID and password</xsl:variable>
  <xsl:variable name="summary-view">View the demo</xsl:variable>
  <xsl:variable name="summary-websphereTraining">IBM WebSphere Training and Technical Enablement</xsl:variable>
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
  <!-- Variables for landing-generic work -->
   <xsl:variable name="urltactic-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/urltactic.js" type="text/javascript"></script><script language="JavaScript" type="text/javascript">
 <!--
 setDefaultQuery(']]></xsl:text><xsl:value-of select="/dw-document//tactic-code-urltactic"/><xsl:text disable-output-escaping="yes"><![CDATA[');
 //-->
</script>
]]></xsl:text></xsl:variable>
    <!-- delicious and delicious dw metrics scripts -->
    <xsl:variable name="delicious-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="http://del.icio.us/js/playtagger" type="text/javascript"></script>]]></xsl:text></xsl:variable>
    <xsl:variable name="delicious-metrics-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/delicious-playtagger-metrics.js" type="text/javascript"></script>]]></xsl:text></xsl:variable>
  <!-- END variables for landing-product work -->
  <!-- BEGIN Added variables for landing-product work -->
  <!-- in template name="FullTitle"  -->
  <xsl:variable name="ibm-developerworks-text">IBM developerWorks : </xsl:variable>
  <!-- in template name="TopStory"  -->
  <xsl:variable name="more-link-text">More</xsl:variable>
  <!-- in template name="AboutProduct" -->
  <xsl:variable name="product-about-product-heading">About the product</xsl:variable>
  <!-- in template name="ProductTechnicalLibrary"  -->
  <xsl:variable name="product-technical-library-heading">Search technical library</xsl:variable>
  <xsl:variable name="technical-library-search-text">Enter keyword or leave blank to view entire technical library:</xsl:variable>
  <!-- in template name="ProductInformation"  -->
  <xsl:variable name="product-information-heading">Product information</xsl:variable>
  <xsl:variable name="product-related-products">Related products:</xsl:variable>
  <!-- in template name="ProductDownloads"  -->
  <xsl:variable name="product-downloads-heading">Downloads, CDs, DVDs</xsl:variable>
  <!-- in template name="ProductLearningResources"  -->
  <xsl:variable name="product-learning-resources-heading">Learning resources</xsl:variable>
  <!-- in template name="ProductSupport"  -->
  <xsl:variable name="product-support-heading">Support</xsl:variable>
  <!-- in template name="ProductCommunity"  -->
  <xsl:variable name="product-community-heading">Community</xsl:variable>
  <!-- in template name="MoreProductInformation"  -->
  <xsl:variable name="more-product-information-heading">More product information</xsl:variable>
  <!-- in template name="Spotlight"  -->
  <xsl:variable name="spotlight-heading">Spotlight</xsl:variable>
  <!-- in template name="LatestContent"  -->
  <xsl:variable name="latest-content-heading">Latest content</xsl:variable>
  <xsl:variable name="more-content-link-text">More content</xsl:variable>
  <!-- in template name="EditorsPicks"  -->
  <xsl:variable name="editors-picks-heading">Editor's picks</xsl:variable>
  <!-- in template name="BreadCrumbTitle"  -->
  <xsl:variable name="products-heading">Products</xsl:variable>
  <!-- END variables for landing-product work -->
  <!-- PDF document stylesheet strings -->
  <xsl:variable name="pdfTableOfContents">Table of Contents</xsl:variable>
  <xsl:variable name="pdfSection">Section</xsl:variable>
  <xsl:variable name="pdfSkillLevel">Skill Level</xsl:variable>
  <!-- 5.11 12/03/08 egd:  removed the 1994, text until early Jan when we rewrite this -->
   <!-- 5.12 3/12/09 ddh DR#3168:  removed copyright for 2008 -->
  <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. All rights reserved.</xsl:variable>  -->
   <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists -->
  <xsl:variable name="dcRights-v16"><xsl:text>&#169; Copyright&#160;</xsl:text>
	 <xsl:text>IBM Corporation&#160;</xsl:text>
          <xsl:value-of select="//date-published/@year"/>
		<xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="//date-updated/@year" />
		</xsl:if></xsl:variable> 
  <!-- llk 12/13/2011 - added copyright url to localize pdf creation -->
    <xsl:variable name="dcRights-v16-url">http://www.ibm.com/legal/copytrade.shtml</xsl:variable>
 <!-- llk 2/24/2012 - added copyright url to localize pdf creation -->
    <xsl:variable name="dcRights-v16-url-printed">www.ibm.com/legal/copytrade.shtml</xsl:variable> 
  <xsl:variable name="pdfTrademarks">Trademarks</xsl:variable>
   <!-- llk 12/13/2011 - added trademark url to localize pdf creation -->
    <xsl:variable name="pdfTrademarks-url">http://www.ibm.com/developerworks/ibm/trademarks/</xsl:variable>
   <xsl:variable name="pdfTrademarks-url-printed">www.ibm.com/developerworks/ibm/trademarks/</xsl:variable>
  <xsl:variable name="pdfResource-list-forum-text">Participate in the discussion forum for this content.</xsl:variable>
  <!-- podcast -->
  <xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">Subscribe to developerWorks podcasts</xsl:text></xsl:variable>
  <xsl:variable name="podcast-about-url">/developerworks/podcast/about.html#subscribe</xsl:variable>
  <xsl:variable name="summary-inThisPodcast">In this podcast</xsl:variable>
  <xsl:variable name="summary-podcastCredits">Podcast credits</xsl:variable>
  <xsl:variable name="summary-podcast-not-familiar">Not familiar with podcasting? <a href=" /developerworks/podcast/about.html">Learn more.</a></xsl:variable>
   <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[To automatically download and synchronize files to play on your computer or your portable audio player (for example, iPod), you'll need to use a podcast client. <a href="http://www.ipodder.org/" target="_blank">iPodder</a> is a free, open-source client that is available for Mac&#174; OS X, Windows&#174;, and Linux. You can also use <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>, or any number of alternatives available on the Web.]]></xsl:text></xsl:variable>
  <xsl:variable name="summary-getThePodcast">Get the podcast</xsl:variable>
  
  <!-- Agenda/ presentation strings-->
  <xsl:variable name="summary-getTheAgenda">Get the agenda</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">Get the agendas</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">Get the agenda and presentation</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">Get the agenda and presentations</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">Get the agendas and presentations</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">Get the agendas and presentation</xsl:variable>
  <xsl:variable name="summary-getThePresentations">Get the presentations</xsl:variable>
  <xsl:variable name="summary-getTheWorkshopMaterials">Get the workshop materials</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Type: </xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Technical briefing</xsl:variable>
  <xsl:variable name="summary-inThisEvent">In this event</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">In this workshop</xsl:variable>
  <xsl:variable name="summary-hostedBy">Hosted by: </xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Companies represented</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Company represented</xsl:variable>
  
  <!-- Common-trademarks-text and copyright variables -->
  <xsl:variable name="common-trademarks-text">Other company, product, or service names may be 
  trademarks or service marks of others.</xsl:variable>
  <xsl:variable name="copyright-statement"></xsl:variable>
 <!-- aboutTheContributor and aboutTheContributors -->
  <xsl:variable name="aboutTheContributor">About the contributor</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">Javascript is required to display the registration text.</xsl:variable>
  <xsl:variable name="aboutTheContributors">About the contributors</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">Currently, there are no events scheduled. Check back here for updates.</xsl:variable>
  <!-- Maverick 6.0 R3 09 18 10 egd:  Removed period from summary-briefingLinkText -->
  <xsl:variable name="summary-briefingLinkText">Select location and register</xsl:variable> 
  <xsl:variable name="summary-briefingBusinessType">Type: Business Briefing</xsl:variable>
  <!-- Maverick 6.0 R3 egd 09 11 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Type:</xsl:variable>  
  <!-- Maverick 6.0 R3 egd 09 11 10:  Removed Type: and following spacing from summary-briefingTechType -->
  <xsl:variable name="summary-briefingTechType">developerWorks Live! briefing</xsl:variable>
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[To view the demos included in this tutorial, JavaScript must be enabled in your browser and Macromedia Flash Player 6 or higher must be installed. You can download the latest Flash Player at <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text></xsl:variable>
  <!-- xM R2.2 egd 05 18 11:  Added variable for the code table summary attribute -->
  <xsl:variable name="codeTableSummaryAttribute">This table contains a code listing.</xsl:variable>
  <!-- xM R2.2 egd 05 18 11:  Added variable for the download table summary attribute -->
   <xsl:variable name="downloadTableSummaryAttribute">This table contains downloads for this document.</xsl:variable>
  <!-- xM R2.2 egd 05 18 11:  Added variable for the error table summary attribute -->
   <xsl:variable name="errorTableSummaryAttribute">This table contains an error message.</xsl:variable> 
   <!-- Variables for line checking algorithms -->
  <xsl:variable name="max-code-line-length" select="90" />
  <xsl:variable name="code-ruler" select="
'-------10--------20--------30--------40--------50--------60--------70--------80--------90-------100'
    "></xsl:variable>
  <xsl:variable name="list-indent-chars" select="5" />
  <xsl:variable name="tab-stop-width" select="8" />
  
  <!-- Error message text variables -->
  <xsl:variable name="e001">|-------- XML error:  The previous line is longer than the max of 90 characters ---------|</xsl:variable>
  <xsl:variable name="e002">XML error:  Please enter a value for the author element's jobtitle attribute, or the company-name element, or both.</xsl:variable>
  <xsl:variable name="e003">XML error:  The image is not displayed because the width is greater than the maximum of 572 pixels.  Please decrease the image width.</xsl:variable>
  <xsl:variable name="e004">XML error:  The image is not displayed because the width is greater than the maximum of 500 pixels.  Please decrease the image width.</xsl:variable>
   <xsl:variable name="e005">Warning:  The &lt;cma-defined&gt; subelement was entered instead of the standard author-related subelements and attributes.  You may keep the &lt;cma-defined&gt; subelement and assign author information using the CMA, or, replace the &lt;cma-defined&gt; subelement with the standard author-related subelements and attributes.</xsl:variable>
  <!-- 6.0 Maverick R2 11 30 09:  Added e006; articles and tut's now have a larger max image width of 580px -->
  <xsl:variable name="e006">XML error:  The image is not displayed because the width is greater than the maximum of 580 pixels.  Please decrease the image width.</xsl:variable>
  <xsl:variable name="e999">An error has occurred, but no error number was passed to the DisplayError template.  Contact the schema/stylesheet team.</xsl:variable>
<!-- End error message text variables -->
<!-- Variables for Trial Program Pages -->
<xsl:variable name="ready-to-buy">Ready to buy?</xsl:variable>
<xsl:variable name="buy">Buy</xsl:variable>
<xsl:variable name="online">online</xsl:variable>
<xsl:variable name="try-online-register">Register for your trial now.</xsl:variable>
<xsl:variable name="download-operatingsystem-heading">Operating system</xsl:variable>
<xsl:variable name="download-version-heading">Version</xsl:variable>
<!-- End variables for Trial Program Pages -->
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
<xsl:variable name="series">Series</xsl:variable>
<!-- 6.0 R1P2 jpp 02/18/09: Modified text for series-view variable -->
<xsl:variable name="series-view">View more content in this series</xsl:variable>
<!-- End Maverick Series Summary area variables -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
<xsl:variable name="form-search-in">Search in:</xsl:variable>
<xsl:variable name="form-product-support">Product support</xsl:variable>
<xsl:variable name="form-faqs">FAQs</xsl:variable>
<xsl:variable name="form-product-doc">Product documentation</xsl:variable>
<xsl:variable name="form-product-site">Product site</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
<xsl:variable name="show-descriptions-text">Show descriptions</xsl:variable>
<xsl:variable name="hide-descriptions-text">Hide descriptions</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
<!-- End Maverick Landing Page variables -->
 <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants. -->
  <xsl:variable name="heading-figure-lead" select="'Figure ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'Table ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'Listing ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
   <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
		<!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
		<xsl:variable name="ssi-s-backlink-module">
			<p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">Back to top</a></p>
		</xsl:variable>
		<!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
		<xsl:variable name="ssi-s-backlink-rule">
			<div class="ibm-alternate-rule"><hr /></div>
			<p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Back to top</a></p>
		</xsl:variable><!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
<!-- KP variables: Start -->
<!-- In template KnowledgePathNextSteps -->
<xsl:variable name="heading-kp-next-steps">Next steps</xsl:variable>
<!-- In template KnowledgePathTableOfContents -->
<xsl:variable name="heading-kp-toc">Activities in this path</xsl:variable>
<xsl:variable name="kp-discuss-link">Discuss this knowledge path</xsl:variable>
<xsl:variable name="kp-resource-type-ui-download">Download</xsl:variable>
<!-- 08/31/11 tdc: Added discuss -->
 <xsl:variable name="kp-next-step-ui-discuss">Discuss</xsl:variable>
 <!-- 08/31/11 tdc: Added enroll -->
  <xsl:variable name="kp-next-step-ui-enroll">Enroll</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">Listen</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">Practice</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">Read</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">Watch</xsl:variable>
  <!-- 09/21/11 tdc:  Updated kp-unchecked-checkmark definition for kp R2 -->
  <xsl:variable name="kp-unchecked-checkmark">Item marked not complete - Click to mark complete</xsl:variable>
  <!-- 09/21/11 tdc:  Updated kp-checked-checkmark definition for kp R2 -->
  <xsl:variable name="kp-checked-checkmark">Item marked complete - Click to mark not complete</xsl:variable>
   <xsl:variable name="kp-next-step-ui-buy">Buy</xsl:variable>
   <xsl:variable name="kp-next-step-ui-download">Download</xsl:variable>
   <xsl:variable name="kp-next-step-ui-follow">Follow</xsl:variable>
   <xsl:variable name="kp-next-step-ui-join">Join</xsl:variable>
   <xsl:variable name="kp-next-step-ui-listen">Listen</xsl:variable>
   <xsl:variable name="kp-next-step-ui-practice">Practice</xsl:variable>
   <xsl:variable name="kp-next-step-ui-read">Read</xsl:variable>
   <!-- 08/31/11 tdc: Added register -->
   <xsl:variable name="kp-next-step-ui-register">Register</xsl:variable>
   <xsl:variable name="kp-next-step-ui-watch">Watch</xsl:variable> 
  <xsl:variable name="kp-sign-in">Sign in</xsl:variable> 
<!-- KP variables: End -->
	</xsl:stylesheet>