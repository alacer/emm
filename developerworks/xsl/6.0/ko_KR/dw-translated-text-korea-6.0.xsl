<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== -->
  <!-- 5.0 6/14 tdc:  Added variables for file paths to enable Authoring package files -->
  <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
    <!-- ibs 2012-02-06 FOP1.0 -->
    <!-- Absolute base path to images for document  (Used in CMA PDF processing) -->
    <xsl:param name="image-url-base"/>
    <!-- 5.7 3/20 llk: need new variable to support local sites
 <xsl:variable name="newpath-dw-root-local-ls">/developerworks/kr/</xsl:variable>
 <xsl:variable name="newpath-dw-root-local-ls">../web/www.ibm.com/developerworks/kr/</xsl:variable> -->
 <!-- these are the includes for the local site have to add them to ians 
 <xsl:variable name="newpath-dw-root-web-inc">/developerworks/kr/inc/</xsl:variable>
<xsl:variable name="newpath-dw-root-web-inc">../web/www.ibm.com/developerworks/kr/inc/</xsl:variable>
-->
   <!-- 5.7 2007-03-22 ibs Redo newpath variables to be under parameter control -->
   <!--  DR 2256 to provide local-url-base parameter.  -->
  <xsl:param name="local-url-base">..</xsl:param>

  <!-- New DR to combine author and dwmaster variable definitions into parameter control.  
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
      <xsl:when test="$xform-type = 'final' ">/developerworks/kr/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/kr/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- 5.7 0326 egd Added this one from Leah's new stem for local sites. -->
    <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/kr/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />../web/www.ibm.com/developerworks/kr/</xsl:when>
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
   <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local-ls" />inc/</xsl:variable>
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"/>i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/buttons/kr/ko/</xsl:variable> 
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
  <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/kr/views/</xsl:variable>
  <xsl:variable name="path-ibm-stats"><xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/</xsl:variable>
  <xsl:variable name="path-ibm-rc-images"> <xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/rc/images/</xsl:variable>
  <xsl:variable name="path-dw-js"><xsl:value-of select="$newpath-dw-root-web"/>js/</xsl:variable>
  <xsl:variable name="path-dw-email-js"><xsl:value-of select="$newpath-dw-root-web"/>email/</xsl:variable>
  <xsl:variable name="path-ibm-common-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>
  <xsl:variable name="path-ibm-common-stats"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/stats/</xsl:variable>
  <xsl:variable name="path-ibm-data-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/</xsl:variable>
  <xsl:variable name="path-ibm-survey-esites"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/survey/esites/</xsl:variable>
  <xsl:variable name="path-ibm-common-css"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>
  <!-- ================= END FILE PATH VARIABLES =================== -->
    <!-- ================= START GENERAL VARIABLES =================== -->
    <!-- 5.4 1/29/06 fjc add  -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Business perspectives</xsl:variable>
  <!-- 5.4 1/29/06 fjc stop add  -->
  <xsl:variable name="main-content">메인 컨텐츠로 가기</xsl:variable>

  <!-- IBS 2012-02-06 Moved preview file includes to dw-document-html-sitename-6.0.xsl -->
  	<!-- In template match="/" -->
	<xsl:variable name="Attrib-javaworld">Reprinted with permission from <a href="http://www.javaworld.com/?IBMDev">JavaWorld magazine</a>. Copyright IDG.net, an IDG Communications company.  Register for free <a href="http://www.javaworld.com/subscribe?IBMDev">JavaWorld email newsletters</a>.</xsl:variable>
	<!-- In template name="/" -->
	<!-- 5.5 8/7 llk: updated stylesheet reference to 5.5 -->
	<xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file:  dw-document-html-6.0.xsl</xsl:variable>
	<!-- In template name="Abstract" and AbstractExtended -->
	<!-- In templates "articleJavaScripts",  "summaryJavaScripts", "dwsJavaScripts", "sidefileJavaScripts" -->
	<!-- 5.4 4/19 llk:  reference updated to omit redirect from www.ibm.com -->
	<xsl:variable name="browser-detection-js-url">/developerworks/js/dwcss14.js</xsl:variable>
	<!-- 5.4 4/19 llk:  reference updated to omit redirect from www.ibm.com -->
	<xsl:variable name="default-css-url">/developerworks/kr/css/r1ss.css" </xsl:variable>
	<xsl:variable name="col-icon-subdirectory">/developerworks/kr/i/</xsl:variable>
	  <!-- 5.5 9/7/06 keb: Added subdirectory variable for processing journal icon gifs -->
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
     <!-- 5.7 3/9/07 llk: Added variable for journal sentence -->
     <!-- 5.9 8/20/07 llk: updated from text per korea input -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">이 컨텐츠는 다음 컨텐츠의 일부입니다：</xsl:variable>
  <xsl:variable name="from">에서 발췌</xsl:variable>
	<!-- In template name="AuthorBottom" -->
	<xsl:variable name="aboutTheAuthor">필자소개</xsl:variable>
	<xsl:variable name="aboutTheAuthors">필자소개</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
   <xsl:variable name="biography">Biography</xsl:variable>
  <xsl:variable name="biographies">Biographies</xsl:variable>
	<!-- In template name="AuthorTop" -->
	<!-- 5.0 4/17 tdc:  company-name element replaces company attrib -->
	<!-- 5.4 02/20/06 tdc:  Removed job-co-errormsg (replaced with e002) -->
	<!-- 5.5 7/18 llk:  added translated by section per DR 1975 -->
  <xsl:variable name="translated-by">옮긴이：</xsl:variable>
  <xsl:variable name="translated">번역 게재일：</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">기사 게재일：</xsl:variable>
  <xsl:variable name="published">발행일：</xsl:variable>
  <!-- end 6.0 Maverick beta -->
  <xsl:variable name="wwpublishdate">기사 게재일：</xsl:variable>
  <xsl:variable name="linktoenglish-heading">원문：</xsl:variable>
  <xsl:variable name="linktoenglish">보기</xsl:variable>
  <xsl:variable name="updated">수정：</xsl:variable>
	<xsl:variable name="daychar"> 일</xsl:variable>
	<xsl:variable name="monthchar"> 월</xsl:variable>
	<xsl:variable name="yearchar"> 년</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF：</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
<!-- 5.0 6/1 tdc:  Added pdf-related variables -->
<xsl:variable name="pdf-alt-letter">PDF 형식-레터</xsl:variable>
<xsl:variable name="pdf-alt-a4">PDF 형식-A4</xsl:variable>
    <!-- 5.10 keb 03/07/08:  Added common size PDF alt text -->
  <xsl:variable name="pdf-alt-common">PDF format - Fits A4 and Letter</xsl:variable>
<xsl:variable name="pdf-text-letter">PDF - 레터</xsl:variable>
<xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <!-- 5.10 keb 03/07/08:  Added common size PDF text -->
  <xsl:variable name="pdf-text-common">PDF - Fits A4 and Letter</xsl:variable>
  <!-- 5.2 8/17/05 tdc:  Added pdf-page and pdf-pages -->
  <xsl:variable name="pdf-page">페이지</xsl:variable>
  <xsl:variable name="pdf-pages">페이지</xsl:variable>

<!-- 5.0.1 7/18 llk:  In template name=Document options -->
  <!-- 5.0.1 9/6 llk: made this heading a translated string -->
  <xsl:variable name="options-discuss">토론</xsl:variable>
<xsl:variable name="document-options-heading">문서 옵션</xsl:variable>
<xsl:variable name="sample-code">샘플 코드</xsl:variable>

	<!-- In template name="Download" -->
	<xsl:variable name="downloads-heading">다운로드 하십시오</xsl:variable>
	<xsl:variable name="download-heading">다운로드 하십시오</xsl:variable>
		<!-- 5.4 4/21 tdc:  Added download-note-heading and download-notes-heading -->
  <xsl:variable name="download-note-heading">참고</xsl:variable>
  <xsl:variable name="download-notes-heading">참고</xsl:variable>
	<xsl:variable name="also-available-heading">또한 가능합니다</xsl:variable>
	<xsl:variable name="download-heading-more">더 많은 다운로드</xsl:variable>
	<xsl:variable name="download-filename-heading">이름</xsl:variable>
	<xsl:variable name="download-filedescription-heading">설명</xsl:variable>
	<xsl:variable name="download-filesize-heading">크기</xsl:variable>
	<xsl:variable name="download-method-heading">다운로드 방식</xsl:variable>
	<!-- 12/13/2011 - llk - added url to enable pdf localization -->
    <xsl:variable name="download-method-link-url">http://www.ibm.com/developerworks/library/whichmethod.html</xsl:variable>
	<xsl:variable name="download-method-link">다운로드 방식에 대한 정보</xsl:variable>
     <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'그림 ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'표 ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'리스트 ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
	  	<!-- 5.10 llk: add variables for content labels -->
	<xsl:variable name="code-sample-label">코드 샘플： </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">ko_KR</xsl:variable>
	<xsl:variable name="demo-label">데모： </xsl:variable>
	<xsl:variable name="presentation-label">프레젠테이션： </xsl:variable>
	<xsl:variable name="product-documentation-label">제품 문서화： </xsl:variable>
	<xsl:variable name="specification-label">스펙： </xsl:variable>
	<xsl:variable name="technical-article-label">Technical article： </xsl:variable>
	<xsl:variable name="whitepaper-label">백서： </xsl:variable>
<!-- 5.10 llk 02/04:  add social tagging as an include -->
<!-- 5.10 llk 3/04 : renamed include file to follow standard naming convention -->
	<xsl:variable name="socialtagging-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>	
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">위로</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">위로</a></p>
  </xsl:variable>	
	<!-- 5.0 4/18 tdc:  Added adobe -->
	<xsl:variable name="download-get-adobe">
	   <xsl:text disable-output-escaping="yes"><![CDATA[Get Adobe&#174; Reader&#174;]]></xsl:text>
	</xsl:variable>
	<!-- 4.0 6/16 tdc:  download-path variable not used by worldwide; "en_us" doesn't work if inserted into path.  Kept here so xsl resolves. -->
	<xsl:variable name="download-path">kr</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/ko_KR/</xsl:variable>
	<xsl:variable name="product-doc-url">
		<a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=kr&amp;&amp;FNC=ICL&amp;">Product documentation</a>
	</xsl:variable>
	<xsl:variable name="redbooks-url">
		<a href="http://www.redbooks.ibm.com/">IBM Redbooks</a>
	</xsl:variable>
	<xsl:variable name="tutorials-training-url">
		<a href="/developerworks/training/">튜토리얼 및 교육</a>
	</xsl:variable>
	<xsl:variable name="drivers-downloads-url">
		<a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Support downloads</a>
	</xsl:variable>

	  <!-- 5.8 4/25 llk: updated the variable reference to a server side include -->
	<xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-footer14.inc" -->]]></xsl:text>
	</xsl:variable>
	<!-- in template name="generalBreadCrumbTrail"  -->
	<xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/kr/</xsl:variable>
	<!-- 12/13/2011 - llk - added top url for pdfs -->
    <xsl:variable name="developerworks-top-url-pdf">ibm.com/developerWorks/kr/</xsl:variable>
	<xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/kr/</xsl:variable>
	<!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
	<xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
	    <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">기술 토픽</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/kr/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">다운로드</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/downloads/</xsl:variable>
  <xsl:variable name="community-text">커뮤니티</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=ko</xsl:variable>
  <xsl:variable name="events-text">행사
                및 세미나</xsl:variable>
 <xsl:variable name="events-url">https://www.ibm.com/developerworks/community/blogs/9e635b49-09e9-4c23-8999-a4d461aeace2/tags/event?lang=ko</xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs; remains in english for korea -->
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
   <xsl:variable name="agile-top-url">http://www.ibm.com/developerworks/connect/agile/</xsl:variable>
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/kr/aix/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area top url -->
   <xsl:variable name="analytics-top-url">http://www.ibm.com/developerworks/analytics/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/kr/architecture/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/kr/data/</xsl:variable>
   <!-- Big data 01/15/13 jmh: add variable for bigdata content area top url -->
   <xsl:variable name="bigdata-top-url">http://www.ibm.com/developerworks/bigdata/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area top url -->
   <xsl:variable name="bpm-top-url">http://www.ibm.com/developerworks/bpm/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/kr/cloud/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce content area top url -->
   <xsl:variable name="commerce-top-url">http://www.ibm.com/developerworks/commerce/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/kr/scenarios/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/kr/industry/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/kr/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/kr/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/kr/lotus/</xsl:variable>
   <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area top url -->
   <!-- Mobile update 04/09/12 jmh: remove connect from mobile content area top url -->
   <xsl:variable name="mobile-top-url">http://www.ibm.com/developerworks/mobile/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/kr/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/kr/power/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url">http://www.ibm.com/developerworks/kr/grid/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security content area top url -->
   <xsl:variable name="security-top-url">http://www.ibm.com/developerworks/security/</xsl:variable>
   <xsl:variable name="autonomic-top-url">http://www.ibm.com/developerworks/kr/autonomic/</xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/kr/rational/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area top url -->
   <xsl:variable name="smc-top-url">http://www.ibm.com/developerworks/servicemanagement/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/kr/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/kr/web/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/kr/webservices/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/kr/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/kr/xml/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
    <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/kr/library/</xsl:variable>
    <xsl:variable name="dw-global-library-text">新着記事一覧</xsl:variable>
  <xsl:variable name="technical-library">기술자료</xsl:variable>      
	<xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/kr/</xsl:variable>

	<!-- in template name="heading"  -->
	<xsl:variable name="figurechar"/> <!-- korea site does not use, but need for xsl continuity -->
	<!-- In template name="IconLinks" -->
	<xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
	<xsl:variable name="icon-discuss-alt">토론</xsl:variable>
	<xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
	<xsl:variable name="icon-code-download-alt">다운로드</xsl:variable>
	<xsl:variable name="icon-code-alt">코드</xsl:variable>
	<xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
	<xsl:variable name="Summary">요약</xsl:variable>
	<xsl:variable name="english-source-heading">영어원문</xsl:variable>
	<xsl:variable name="lang">kr</xsl:variable>
	<!-- In template name="Indicators" -->
  <xsl:variable name="level-text-heading">난이도：</xsl:variable>
	<!-- In template name="Masthead" -->
	<xsl:variable name="topmast-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-topmast14.inc" -->]]></xsl:text>
	</xsl:variable>
	
	<!-- In template name="LeftNav" -->
	<!-- 5/11 08/08 llk: update text string per sungkyun's request -->
  <xsl:variable name="moreThisSeries">이 연재 자세히 보기：</xsl:variable>
  <xsl:variable name="left-nav-in-this-article">이 기사 내에서：</xsl:variable>
  <xsl:variable name="left-nav-in-this-tutorial">이 튜토리얼 내에서：</xsl:variable>
	
	
	<!-- 5.0.1 7/28 llk:  added these so local sites can have their lefthand navs pulled into summary pages -->
	<!-- 5.4 2/22 llk:  updated all lefthand nav include references -->
  <!-- In template name="LeftNavSummary" -->
    <xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14-top.inc" -->]]></xsl:text>
</xsl:variable>
    <xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14-rlinks.inc" -->]]></xsl:text>
</xsl:variable>
  <!-- 5.0.1 9/6 llk:  lefthand navs need to be local site specific -->
  <!-- In template name="LeftNavSummaryInc" -->
     <!-- 5.5 9/7/06 llk: added architecture includes -->
     <!-- 5.10 02/19 llk:  architecture now contains library view -->
     <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ar-nav14.inc" -->]]></xsl:text></xsl:variable>
      <!-- 5.4 3/24 llk: added event left nav for aix content area -->
        <!-- 5.10 02/19 llk:  aix now contains library view -->
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-au-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-au-nav14.inc" -->]]></xsl:text>      </xsl:variable>
        
    <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ac-nav14-library.inc" -->]]></xsl:text>
</xsl:variable>
    <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ac-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-db2-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-db2-nav14.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->

    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-gr-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-j-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-l-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-ls-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-os-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-pa-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-r-nav14.inc" -->]]></xsl:text></xsl:variable>
<!--  5.2 10/03 fjc: add training inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-t-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-t-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-wa-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-ws-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-ws-nav14.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.2 10/03 fjc: add training -->
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->


    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/t-x-nav14.inc" -->]]></xsl:text></xsl:variable>

	
	<!-- In template name="META" -->
	<xsl:variable name="owner-meta-url">dwkorea@kr.ibm.com</xsl:variable>
	<xsl:variable name="dclanguage-content">ko</xsl:variable>
	<xsl:variable name="ibmcountry-content">kr</xsl:variable>
	
  <!-- 5.8 04/30 egd:  Added variable for meta header inc -->  
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <!-- 5.8 04/30 egd:  Add variable for scripts header inc -->  
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>

		
  <!-- In template name="ModeratorBottom -->
  <!-- 5.6 11/16/06 tdc:  Added aboutTheModerator, aboutTheModerators -->
  <xsl:variable name="aboutTheModerator">About the moderator</xsl:variable>
  <xsl:variable name="aboutTheModerators">About the moderators</xsl:variable>	
  
	<!-- In template name="MonthName" -->
	<xsl:variable name="month-1-text">1</xsl:variable>
	<xsl:variable name="month-2-text">2</xsl:variable>
	<xsl:variable name="month-3-text">3</xsl:variable>
	<xsl:variable name="month-4-text">4</xsl:variable>
	<xsl:variable name="month-5-text">5</xsl:variable>
	<xsl:variable name="month-6-text">6</xsl:variable>
	<xsl:variable name="month-7-text">7</xsl:variable>
	<xsl:variable name="month-8-text">8</xsl:variable>
	<xsl:variable name="month-9-text">9</xsl:variable>
	<xsl:variable name="month-10-text">10</xsl:variable>
	<xsl:variable name="month-11-text">11</xsl:variable>
	<xsl:variable name="month-12-text">12</xsl:variable>
	
	<!-- 5.0 5/11 tdc:  Added variables for new PageNavigator template -->
	<!-- 5.0.1 8/17  llk:  added pageofendtext for Taiwan page navigator; -->
	<!-- In template name="PageNavigator" -->
	<xsl:variable name="page">페이지</xsl:variable>
    <xsl:variable name="of">중</xsl:variable>
    	<xsl:variable name="pageofendtext">페이지</xsl:variable>	
	<!-- 5.4 3/14 llk: add variables to enable translation of this text -->
      <xsl:variable name="previoustext">Go to the previous page</xsl:variable>
   <xsl:variable name="nexttext">Go to the next page</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">이전</xsl:variable>
  <xsl:variable name="next">다음</xsl:variable>	
	<!-- In template name="RelatedContents" -->
  <xsl:variable name="related-content-heading">관련자료：</xsl:variable>
  <xsl:variable name="left-nav-related-links-heading">관련 링크：</xsl:variable>
     <xsl:variable name="left-nav-related-links-techlib">기술자료</xsl:variable>

	<!-- In template name="Subscriptions" -->
  <xsl:variable name="subscriptions-heading">Subscriptions：</xsl:variable>
	<xsl:variable name="dw-newsletter-text">dW newsletters</xsl:variable>
	<xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/newsletter/</xsl:variable>
	<xsl:variable name="rational-edge-text">The Rational Edge</xsl:variable>
	<!-- 9/28/05 egd:  Switched URL from subscribe to main Edge page -->
    <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
	<!-- In template name="Resources" and "TableofContents" -->
	<xsl:variable name="resource-list-heading">참고자료</xsl:variable>
	<!-- In template name="resourcelist/ul" -->
	<!-- 5.0 5/13 tdc:  Changed "article" to "content"; removed the text referring to Discuss link at top of page. -->
	<xsl:variable name="resource-list-forum-text"><xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <!-- 5.4 2/24 llk : add per hyun jin -->
                    <xsl:text disable-output-escaping="yes"><![CDATA[">포럼에 참여하기</a>.]]></xsl:text></xsl:variable>
    <!-- In template "resources" -->
    <xsl:variable name="resources-learn">교육</xsl:variable>
    <xsl:variable name="resources-get">제품 및 기술</xsl:variable>
    <xsl:variable name="resources-discuss">토론</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">이 주제에 대한 기술 개발하기</xsl:variable>
  <xsl:variable name="knowledge-path-text">이 컨텐츠는 독자의 기술을 향상시키기 위한 진보적인 지식 경로의 일부입니다. (컨텐츠 이름 및 링크) 참조</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">이 컨텐츠는 독자의 기술을 향상시키기 위한 진보적인 지식 경로의 일부입니다. (컨텐츠 이름 및 링크) 참조：</xsl:variable>
	<!-- In template name="SkillLevel" -->
	<xsl:variable name="level-1-text">초급</xsl:variable>
	<xsl:variable name="level-2-text">초급</xsl:variable>
	<xsl:variable name="level-3-text">중급</xsl:variable>
	<xsl:variable name="level-4-text">고급</xsl:variable>
	<xsl:variable name="level-5-text">고급</xsl:variable>
	<!-- In template name="TableOfContents" -->
  <xsl:variable name="tableofcontents-heading">목차：</xsl:variable>
	<xsl:variable name="ratethisarticle-heading">기사에 대한 평가</xsl:variable>
	<xsl:variable name="ratethistutorial-heading">튜토리얼 평가</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">목차</xsl:variable>
  <xsl:variable name="inline-comments-heading">의견</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
	<!-- In file "dw-ratingsform-4.1.xsl  -->
	<xsl:variable name="domino-ratings-post-url">http://www.alphaworks.ibm.com/developerworks/ratings.nsf/RateArticle?CreateDocument</xsl:variable>
	<xsl:variable name="method">POST</xsl:variable>
	<xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/kr/thankyou/</xsl:variable>
	<!-- 5.0 4/13 tdc:  Added ratings-intro-text -->
	<xsl:variable name="ratings-intro-text">보다 낳은 서비스를 제공하기 위함이오니 잠시 짬을 내어 이 양식을 제출하여 주십시오.</xsl:variable>
	<xsl:variable name="ratings-question-text">이 기사에 대하여 어떻게 생각하십니까?</xsl:variable>
	<xsl:variable name="ratings-value5-text">매우 만족   (5)</xsl:variable>
	<xsl:variable name="ratings-value4-text">만족 (4)</xsl:variable>
	<xsl:variable name="ratings-value3-text">보통 (3)</xsl:variable>
	<xsl:variable name="ratings-value2-text">불만족 (2)</xsl:variable>
	<xsl:variable name="ratings-value1-text">매우 불만족 (1)</xsl:variable>
	<xsl:variable name="ratings-value5-width">22%</xsl:variable>
	<xsl:variable name="ratings-value4-width">18%</xsl:variable>
	<xsl:variable name="ratings-value3-width">18%</xsl:variable>
	<xsl:variable name="ratings-value2-width">18%</xsl:variable>
	<xsl:variable name="ratings-value1-width">24%</xsl:variable>
	<xsl:variable name="comments-noforum-text">의견</xsl:variable>
	<xsl:variable name="comments-withforum-text">귀하의 의견을 보내주세요. 혹은 토론 버튼을 눌러 귀하의 의견을 다른 개발자들과 공유해 주세요.</xsl:variable>
	<xsl:variable name="submit-feedback-text">의견보내기</xsl:variable>
		<!-- 5.4 4/18 llk:  added site id for jsp ratings database -->
	<xsl:variable name="site_id">20</xsl:variable>
	<!-- in template name="ContentAreaName" -->
  <!-- Mobile & Agile 02/28/12 jmh: add variable for agile content area name -->
  <xsl:variable name="contentarea-ui-name-agile">Agile transformation</xsl:variable>
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area name -->
  <xsl:variable name="contentarea-ui-name-analytics">Business analytics</xsl:variable>
      <!-- 5.5 9/7 llk: add for Architecture content area -->
    <xsl:variable name="contentarea-ui-name-ar">Architecture</xsl:variable>
	<!-- 5.4 2/1 llk:  text changed per hyun jin -->
	 <!-- 5.11 08/08 llk: translated AIX content area per korea request  DR 2863 -->
    <xsl:variable name="contentarea-ui-name-au">AIX와 UNIX</xsl:variable>
    <!-- 5.4 3/24 llk: updated identifier for autonomic computing -->
	<xsl:variable name="contentarea-ui-name-ac">자율 컴퓨팅</xsl:variable>
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
	<xsl:variable name="contentarea-ui-name-gr">그리드 컴퓨팅</xsl:variable>
  	<!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  	<xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>
  	<!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area name -->
  	<xsl:variable name="contentarea-ui-name-bpm">Business process management</xsl:variable>
	<xsl:variable name="contentarea-ui-name-j">자바</xsl:variable>
	<xsl:variable name="contentarea-ui-name-l">리눅스</xsl:variable>
  	<!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area name -->
  	<xsl:variable name="contentarea-ui-name-mobile">Mobile development</xsl:variable>
	<!-- 5.4 2/1 llk:  text changed per hyun jin -->
	<xsl:variable name="contentarea-ui-name-os">오픈 소스</xsl:variable>
	<!-- 5.4 2/1 llk:  text changed per hyun jin -->
	<xsl:variable name="contentarea-ui-name-ws">SOA와 웹서비스</xsl:variable>
	<xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
	<!-- 5.10 11/07 llk: remove components as a content area  dr 2558 -->
	<xsl:variable name="contentarea-ui-name-s">Security</xsl:variable>
		<!-- 5.7 3/8 llk:  text changed per sungkyun -->
	<xsl:variable name="contentarea-ui-name-wa">웹 개발</xsl:variable>
	<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
	<!-- 4.0 6/22 tdc:  Changed Scenarios to Sample IT projects per note from Jack P. -->
	<xsl:variable name="contentarea-ui-name-i">Sample IT projects</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">클라우드 컴퓨팅</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
	<!-- 5.4 02/15/06 tdc:  Changed DB2 to Information Management -->
	<xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
	<!-- 5.10 2/15 llk: remove IBM Systems as a content area -->
	<xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
	<xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
  	<!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area name -->
 <!-- 01/15/13 jmh: change variable value to Tivoli (service management)  -->
  <xsl:variable name="contentarea-ui-name-smc">Tivoli (service management)</xsl:variable>
	<xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
	<xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
	<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	<!-- 5.4 2/1 llk: text changed per hyun jin -->
	<!-- 5.10 2/18 llk:  update name of power architecture content area -->
	<xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
	<!-- in template name="TechLibView" -->
		<!-- 5.4 2/1 llk: updated with korean article views -->
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
			  <!-- 5.4 3/24 llk:  added for AIX content area -->
   <xsl:variable name="techlibview-au"></xsl:variable>
<!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->	
	<xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/kr/views/data/libraryview.jsp</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm tech library view url -->
  <xsl:variable name="techlibview-bpm">http://www.ibm.com/developerworks/bpm/library/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/kr/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/kr/views/industry/libraryview.jsp</xsl:variable>
<!-- 5.5.1 10/18 llk: updated view subdirectory to reflect /systems instead of /eserver -->
<!-- 5.10 2/18 llk: remove reference to IBM Systems views; IBM Systems no longer valid content area -->
		<!-- 5.4 3/13 llk: added variable, techlibview-s, for China's use only -->
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security tech library view url -->
  <xsl:variable name="techlibview-s">http://www.ibm.com/developerworks/security/library/</xsl:variable>
	<xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/views/ibm/articles.jsp</xsl:variable>
	<xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/kr/views/lotus/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/kr/views/rational/libraryview.jsp</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc tech library view url -->
  <xsl:variable name="techlibview-smc">http://www.ibm.com/developerworks/servicemanagement/library/</xsl:variable>
  <xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/kr/views/tivoli/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/kr/views/websphere/libraryview.jsp</xsl:variable>
	  <!-- 5.5 9/8/06 llk: added view for architecture content area -->
   <xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/views/architecture/library.jsp</xsl:variable>
	<!-- 5.4 3/24 llk:  updated identifier for autonomic computing -->
  <xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/kr/views/autonomic/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/kr/views/grid/libraryview.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/kr/views/java/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/kr/views/linux/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/kr/views/opensource/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/kr/views/power/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/kr/views/webservices/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/kr/views/web/libraryview.jsp</xsl:variable>
	<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
     <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
  <xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/kr/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">다음 단계</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">공부할 내용</xsl:variable>
  <xsl:variable name="kp-discuss-link">토론하기</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-download">다운로드</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">듣기</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">연습</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">읽기</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">보기</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">미완료-완료 표시를 하시려면 클릭하세요</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">완료-미완료 표시를 하시려면 클릭하세요</xsl:variable>
  <xsl:variable name="kp-next-step-ui-buy">구매</xsl:variable>
  <xsl:variable name="kp-next-step-ui-download">다운로드</xsl:variable>
  <xsl:variable name="kp-next-step-ui-follow">수행</xsl:variable>
  <xsl:variable name="kp-next-step-ui-join">가입</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">듣기</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">연습</xsl:variable>
  <xsl:variable name="kp-next-step-ui-read">읽기</xsl:variable>
  <xsl:variable name="kp-next-step-ui-watch">보기</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-discuss">토론</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">등록</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">가입</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">제출</xsl:variable> 
  <!-- KP variables: End -->
	  <!-- In template name="ProductsLandingURL" -->
  <!--  04/26/12 jmh: removed unneeded products-landing entries for Agile, Mobile, SMC   -->
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics product landing page url -->
  <xsl:variable name="products-landing-analytics">
   <xsl:value-of select="$developerworks-top-url"/>analytics/products/</xsl:variable>
    <!-- 5.4 3/24 llk: added for AIX content area -->
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
    <!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->	
  <xsl:variable name="products-landing-db2">
    <xsl:value-of select="$developerworks-top-url"/>data/products/</xsl:variable>
    <!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
  <xsl:variable name="products-landing-lo">
    <xsl:value-of select="$developerworks-top-url"/>lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r">
    <xsl:value-of select="$developerworks-secondary-url"/>rational/products/</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security product landing page url -->
  <xsl:variable name="products-landing-security">
   <xsl:value-of select="$developerworks-top-url"/>security/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv">
    <xsl:value-of select="$developerworks-top-url"/>tivoli/products/</xsl:variable>
  <!-- 5.5 06/08/2006 jpp-egd:  Updated WebSphere product page URL -->
  <xsl:variable name="products-landing-web">
    <xsl:value-of select="$developerworks-top-url"/>websphere/products/</xsl:variable>
 <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
    <!-- 5.6 12/03/2006 egd: Added variable for  tech library section support search statement (dr 1976) -->
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
   <xsl:variable name="support-search-text-intro">For a comprehensive selection of troubleshooting documents,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">search the IBM technical support knowledge base</xsl:variable> 
	<!-- SUMMARY DOC SECTION HEADINGS -->
		<!-- 5.6 11/16/06 tdc:  Added summary-inThisChat -->
  <xsl:variable name="summary-inThisChat">In this chat</xsl:variable>
	 <!-- 5.5 08/14 fjc add inthisdemo -->  
  <xsl:variable name="summary-inThisDemo">In this demo</xsl:variable>
	<xsl:variable name="summary-inThisTutorial">이 튜토리얼 내에서</xsl:variable>
	<xsl:variable name="summary-inThisLongdoc">이 기사 내에서</xsl:variable>
	<xsl:variable name="summary-inThisPresentation">이 프리젠테이션 내에서</xsl:variable>
	<xsl:variable name="summary-inThisSample">이 샘플 내에서</xsl:variable>
	<xsl:variable name="summary-inThisCourse">이 코스 내에서</xsl:variable>
	<xsl:variable name="summary-objectives">목표</xsl:variable>
	<xsl:variable name="summary-prerequisities">선수조건</xsl:variable>
	<xsl:variable name="summary-systemRequirements">시스템 필요조건</xsl:variable>
	<xsl:variable name="summary-duration">기간</xsl:variable>
	<xsl:variable name="summary-audience">대상</xsl:variable>
	<xsl:variable name="summary-languages">언어</xsl:variable>
	<xsl:variable name="summary-formats">포맷</xsl:variable>
	<xsl:variable name="summary-minor-heading">Summary minor heading</xsl:variable>
	<xsl:variable name="summary-getTheArticle">기사 얻기</xsl:variable>
	<!-- 5.0 6/2 fjc add whitepaper -->
	<xsl:variable name="summary-getTheWhitepaper">백서 얻기</xsl:variable>
	<xsl:variable name="summary-getThePresentation">프리젠테이션 얻기</xsl:variable>
	<xsl:variable name="summary-getTheDemo">데모 얻기</xsl:variable>
		  <!-- 5.4 4/21 llk: add link to article for korea translated articles -->
    <xsl:variable name="summary-linktotheContent">원문보기</xsl:variable>
	<!-- 5.3 12/12/05 tdc:  Added summary-getTheDownload -->
  <xsl:variable name="summary-getTheDownload">다운로드 받기</xsl:variable>
	<!-- 5.3 12/07/05 tdc:  Added summary-getTheDownloads -->
  <xsl:variable name="summary-getTheDownloads">다운로드 받기</xsl:variable>
	<xsl:variable name="summary-getTheSample">샘플 얻기</xsl:variable>
	<xsl:variable name="summary-rateThisContent">컨텐츠 평가</xsl:variable>
	<xsl:variable name="summary-getTheSpecification">스팩</xsl:variable>
  <xsl:variable name="summary-contributors">필자：</xsl:variable>
	<xsl:variable name="summary-aboutTheInstructor">강사</xsl:variable>
	<xsl:variable name="summary-aboutTheInstructors">강사</xsl:variable>
	<xsl:variable name="summary-viewSchedules">스케줄 확인 및 등록</xsl:variable>
	<xsl:variable name="summary-viewSchedule">스케줄 확인 및 등록</xsl:variable>	
	<xsl:variable name="summary-aboutThisCourse">이 코스에 관해서</xsl:variable>
	<xsl:variable name="summary-webBasedTraining">웹교육</xsl:variable>
	<xsl:variable name="summary-instructorLedTraining">강사가 진행하는 교육</xsl:variable>
	<xsl:variable name="summary-classroomTraining">강의실 교육</xsl:variable>
  <xsl:variable name="summary-courseType">코스 타입：</xsl:variable>
  <xsl:variable name="summary-courseNumber">코스 번호：</xsl:variable>
	<xsl:variable name="summary-scheduleCourse">코스</xsl:variable>
	<xsl:variable name="summary-scheduleCenter">교육 센터</xsl:variable>
	<xsl:variable name="summary-classroomCourse">강의 코스</xsl:variable>
	<xsl:variable name="summary-onlineInstructorLedCourse">온라인 강사 교육</xsl:variable>
	<xsl:variable name="summary-webBasedCourse">웹강의</xsl:variable>
	<xsl:variable name="summary-enrollmentWebsphere1">이 코스에 관한 의견이나 제안이 있다면 연락해 주십시오. </xsl:variable>
	<xsl:variable name="summary-enrollmentWebsphere2">IBM 내부 교육생은 글로벌 캠퍼스를 통해 등록해 주십시오.</xsl:variable>
	<xsl:variable name="summary-plural">s</xsl:variable>
	
	<!-- SUMMARY DOC SECTION HEADINGS END -->
	<!-- 5.5 lk 7/31 update registration text to reflect no registration for tutorials -->
	<xsl:variable name="summary-register">튜토리얼 보러가기</xsl:variable>
	 <!--5.10 0227 egd add view demo statement for demo summary-->
  <xsl:variable name="summary-view">View the demo</xsl:variable>
	<xsl:variable name="summary-websphereTraining">IBM WebSphere Training and Technical Enablement</xsl:variable>
	<!-- 5.0.1 9/19 llk need this to be local site specific in the summary pagse -->
	<xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
	<xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/kr/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
  <!-- 5.3 12/15/05 jpp/egd:  BEGIN variables for landing-generic work -->
        <xsl:variable name="urltactic-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/urltactic.js" type="text/javascript"></script><script language="JavaScript" type="text/javascript">
 <!--
 setDefaultQuery(']]></xsl:text><xsl:value-of select="/dw-document//tactic-code-urltactic"/><xsl:text disable-output-escaping="yes"><![CDATA[');
 //-->
</script>
]]></xsl:text></xsl:variable>
<!-- 5.6 12/12/06 egd Add delicious and delicious dw metrics scripts -->
    <xsl:variable name="delicious-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="http://del.icio.us/js/playtagger" type="text/javascript"></script>]]></xsl:text></xsl:variable>
    <xsl:variable name="delicious-metrics-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/delicious-playtagger-metrics.js" type="text/javascript"></script>]]></xsl:text></xsl:variable>
  <!-- 5.3 12/15/05 jpp/egd:  END variables for landing-product work -->

  <!-- 5.2 9/14 jpp Added text to be prepended to landing-product titles -->
  <!-- in template name="FullTitle"  -->
  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>

	  <!-- in template name="TopStory"  -->
  <xsl:variable name="more-link-text">More</xsl:variable>
    <!-- 5.5 09/07/06 jpp-egd: Add product-about-product-heading variable -->
  <!-- in template name="AboutProduct" -->
  <xsl:variable name="product-about-product-heading">About the product</xsl:variable>
  <!-- in template name="ProductTechnicalLibrary"  -->
  <xsl:variable name="product-technical-library-heading">Search technical library</xsl:variable>
  <xsl:variable name="technical-library-search-text">Enter keyword or leave blank to view entire technical library：</xsl:variable>
  <!-- in template name="ProductInformation"  -->
  <xsl:variable name="product-information-heading">Product information</xsl:variable>
  <xsl:variable name="product-related-products">Related products：</xsl:variable>
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
  <!-- END 5.1 7/22 jpp/egd:  Added variables for landing-product work -->
  <!-- PDF document stylesheet strings -->
  <!-- 5.0 7/31 tdc:  Added for tutorial PDFs (from Frank's xsl) -->
  <xsl:variable name="pdfTableOfContents">컨텐츠 양식</xsl:variable>
  <xsl:variable name="pdfSection">섹션</xsl:variable>
  <xsl:variable name="pdfSkillLevel">기술등급</xsl:variable>
    <!-- 5.4 4/18/06 fjc.  change copyright -->
    <!-- 5.11 12/03/08 egd:  removed the 1994, text until early Jan when we rewrite this -->
   <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. All rights reserved.</xsl:variable> --> 
     <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
 <xsl:variable name="dcRights-v16"><xsl:text>&#169; 저작권&#160;</xsl:text>
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
  <xsl:variable name="pdfTrademarks">트레이드 마크</xsl:variable>
        <!-- llk 12/13/2011 - added trademark url to localize pdf creation -->
    <xsl:variable name="pdfTrademarks-url">http://www.ibm.com/developerworks/kr/ibm/trademarks/</xsl:variable>
<xsl:variable name="pdfTrademarks-url-printed">www.ibm.com/developerworks/kr/ibm/trademarks/</xsl:variable>
  <!-- 5.2 8/31 fjc:  Added for tutorial PDFs -->
  <xsl:variable name="pdfResource-list-forum-text">이 내용과 연관된 토론 포럼에 참여하기</xsl:variable>

	  <!-- 5.2 09/20 fjc:  subscribe to podcast -->
	<xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">Subscribe to developerWorks podcasts</xsl:text></xsl:variable>
			<!-- 5.10 11/07 llk: add about url due to fact that this content is now translated -->
	<xsl:variable name="podcast-about-url">/developerworks/podcast/about.html#subscribe</xsl:variable>
  <!-- 5.2 09/20 fjc: in this podcast-->
  <xsl:variable name="summary-inThisPodcast">In this podcast</xsl:variable>
   <!-- 5.2 09/20 fjc: about the podcast contributors -->
  <xsl:variable name="summary-podcastCredits">Podcast credits</xsl:variable>
   <!-- 5.2 09/20 fjc:  for podcast -->
  <xsl:variable name="summary-podcast-not-familiar">Not familiar with podcasting? <a href=" /developerworks/podcast/about.html">Learn more.</a></xsl:variable>
  <!-- 5.2 09/20 fjc:  for podcast -->
  <!-- 5.2 10/13 fjc:  change text -->
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[To automatically download and synchronize files to play on your computer or your portable audio player (for example, iPod), you'll need to use a podcast client. <a href="http://www.ipodder.org/" target="_blank">iPodder</a> is a free, open-source client that is available for Mac&#174; OS X, Windows&#174;, and Linux. You can also use <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>, or any number of alternatives available on the Web.]]></xsl:text></xsl:variable>
  <!-- 5.2 10/17 fjc: get the podcast-->
<!-- 5.3 12/15/05 fc:  added variables for event summary pages -->
  <xsl:variable name="summary-getThePodcast">Get the podcast</xsl:variable>
  <!-- 5.5 07/14/06 fjc:  need more agenda/ presentation strings-->
<!-- 5.5.1 10/12/06 fjc: still  need more agenda/ presentation strings-->
  <xsl:variable name="summary-getTheAgenda">Get the agenda</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">Get the agendas</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">Get the agenda and presentation</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">Get the agenda and presentations</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">Get the agendas and presentations</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">Get the agendas and presentation</xsl:variable>
  <xsl:variable name="summary-getThePresentations">Get the presentations</xsl:variable>
  <!-- 5.5.1 10/12/06 fjc: END still  need more agenda/ presentation strings-->
  <!-- 5.5 8/7 llk: remove extra summary-getThePresentation from this file -->
<xsl:variable name="summary-getTheWorkshopMaterials">Get the workshop materials</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Type：</xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Technical briefing</xsl:variable>
  <xsl:variable name="summary-inThisEvent">In this event</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">In this workshop</xsl:variable>
  <xsl:variable name="summary-hostedBy">Hosted by：</xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Companies represented</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Company represented</xsl:variable>	
  <!-- 5.3 12/07/05 tdc:  Added common-trademarks-text -->
<xsl:variable name="common-trademarks-text">기타 회사, 제품, 및 서비스명은 다른 상표나 서비스 마크일 수 있습니다.</xsl:variable>
  	<!-- 5.5 8/21 llk: added copyright statement text per Korea request-->
  	<!-- 5.5 9/12 llk: removed paragraph tags in order to bring more inline with trademark text -->
  <xsl:variable name="copyright-statement">developerWorks 콘텐트를 다른 사이트에 전재하기：<br />developerWorks 콘텐트에 대한 저작권은 IBM에 있습니다. IBM의 서면 허가나 원본 저자의 허락이 없이는 전재를 금합니다. 저희 콘텐트를 전재하시려면 <a href="mailto:dwkorea@kr.ibm.com">IBM developerWorks 담당자</a> 에게 문의하십시오. </xsl:variable>
  <!-- 5.3 12/14 tdc:  Added aboutTheContributor and aboutTheContributors -->
  <xsl:variable name="aboutTheContributor">필자소개</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">Javascript is required to display the registration text.</xsl:variable>
  <xsl:variable name="aboutTheContributors">필자소개</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">Currently, there are no events scheduled. Check back here for updates.</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">Select location and register</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">Type: Business Briefing</xsl:variable>
    <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Type：</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType --> 
  
  <!-- 5.7 0325 egd Changed to reflect new briefing name -->
  <xsl:variable name="summary-briefingTechType">developerWorks Live! briefing</xsl:variable>
  <!-- 5.4 1/31/06 Flash required -->
  <!-- 5.10 1/7/08 llk: translate flash requirement statement -->
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[튜토리얼 내 데모를 보기 위하여, 브라우저에서 자바스크립트를 사용할수 있어야 하며, 마크로미디어 플래시 플레이어 6 또는 그이상 버전이 설치되어 있어야 합니다. 
최신 플래시 플레이어를 다음링크에서 다운로드 받으십시오. (<a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>) ]]></xsl:text></xsl:variable>
   <!--  5.10 keb/ian 03/07/08: Added variables for revised line checking algorithms for DR2576 -->
  <!-- Add 5.10 variables start -->
  <xsl:variable name="max-code-line-length" select="90" />
  <xsl:variable name="code-ruler" select="
'-------10--------20--------30--------40--------50--------60--------70--------80--------90-------100'
    "></xsl:variable>
  <xsl:variable name="list-indent-chars" select="5" />
  <xsl:variable name="tab-stop-width" select="8" />
<!-- Add 5.10 variables end -->

    <!-- 5.4 02/20/06 tdc:  Start error message text variables -->
  <xsl:variable name="e001">|-------- XML error:  The previous line is longer than the max of 90 characters ---------|</xsl:variable>
  <xsl:variable name="e002">XML error:  Please enter a value for the author element's jobtitle attribute, or the company-name element, or both.</xsl:variable>
  <xsl:variable name="e003">XML error:  The image is not displayed because the width is greater than the maximum of 572 pixels.  Please decrease the image width.</xsl:variable>
  <xsl:variable name="e004">XML error:  The image is not displayed because the width is greater than the maximum of 500 pixels.  Please decrease the image width.</xsl:variable>
      <!-- 5.5.1 10/13/06 tdc:  New e005 warning message for cma-defined author info -->
  <xsl:variable name="e005">Warning:  The &lt;cma-defined&gt; subelement was entered instead of the standard author-related subelements and attributes.  You may keep the &lt;cma-defined&gt; subelement and assign author information using the CMA, or, replace the &lt;cma-defined&gt; subelement with the standard author-related subelements and attributes.</xsl:variable>
<!-- 6.0 Maverick R2 11 30 09: Added e006; articles and tut's now have a larger max image width of 580px -->
<xsl:variable name="e006">XML error: The image is not displayed because the width is greater than the maximum of 580 pixels. Please decrease the image width.</xsl:variable> 
    <xsl:variable name="e999">An error has occurred, but no error number was passed to the DisplayError template.  Contact the schema/stylesheet team.</xsl:variable>
<!-- End error message text variables -->
<!-- 5.5 08/24/06 jpp-egd:  Start variables for Trial Program Pages -->
<xsl:variable name="ready-to-buy">Ready to buy?</xsl:variable>
<xsl:variable name="buy">Buy</xsl:variable>
<xsl:variable name="online">online</xsl:variable>
<xsl:variable name="try-online-register">Register for your trial now.</xsl:variable>
<xsl:variable name="download-operatingsystem-heading">Operating system</xsl:variable>
<xsl:variable name="download-version-heading">Version</xsl:variable>
<!-- End variables for Trial Program Pages -->
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
  <xsl:variable name="series">시리즈</xsl:variable>
  <xsl:variable name="series-view">이 연재 자세히 보기</xsl:variable>
<!-- End Maverick Series Summary area variables -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
  <xsl:variable name="form-search-in">Search in：</xsl:variable>
<xsl:variable name="form-product-support">Product support</xsl:variable>
<xsl:variable name="form-faqs">FAQs</xsl:variable>
<xsl:variable name="form-product-doc">Product documentation</xsl:variable>
<xsl:variable name="form-product-site">Product site</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
  <xsl:variable name="show-descriptions-text">설명 보기</xsl:variable>
  <xsl:variable name="hide-descriptions-text">설명 감추기</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
<!-- End Maverick Landing Page variables -->
  <xsl:variable name="codeTableSummaryAttribute">This table contains a code listing.</xsl:variable>
  <xsl:variable name="downloadTableSummaryAttribute">This table contains downloads for this document.</xsl:variable>
  <xsl:variable name="errorTableSummaryAttribute">This table contains an error message.</xsl:variable> 
</xsl:stylesheet>
