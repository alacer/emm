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
 <xsl:variable name="newpath-dw-root-local-ls">/developerworks/jp/</xsl:variable>
 <xsl:variable name="newpath-dw-root-local-ls">../web/www.ibm.com/developerworks/</xsl:variable> -->
 <!-- these are the includes for the local site have to add them to ians 
 <xsl:variable name="newpath-dw-root-web-inc">/developerworks/jp/inc/</xsl:variable>
<xsl:variable name="newpath-dw-root-web-inc">../web/www.ibm.com/developerworks/jp/inc/</xsl:variable>
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
      <xsl:when test="$xform-type = 'final' ">/developerworks/jp/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/jp/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>

  <!-- 5.7 0326 egd Added this one from Leah's new stem for local sites. -->
    <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/jp/</xsl:when>
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
    <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local-ls" />inc/</xsl:variable>
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"/>i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/buttons/jp/ja/</xsl:variable>
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
   <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/jp/views/</xsl:variable>
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
  <!-- 5.4 1/29/06 fjc add  -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Business perspectives</xsl:variable>
<!-- 5.4 1/29/06 fjc stop add  -->
  <xsl:variable name="main-content">本文へスキップ</xsl:variable>
  <!-- ================= END GENERAL VARIABLES =================== -->

  <!-- In template match="/" -->
  <xsl:variable name="Attrib-javaworld"><a href="http://www.javaworld.com/?IBMDev">JavaWorld マガジン</a>から許可を得て掲載。 Copyright IDG.net, an IDG Communications company.  無料の<a href="http://www.javaworld.com/subscribe?IBMDev">JavaWorld 電子メール　ニュースレター</a>への登録。
</xsl:variable>
  <xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-6.0.xsl</xsl:variable>
  <!-- In template name="Abstract" and AbstractExtended -->
  <xsl:variable name="browser-detection-js-url">/developerworks/js/dwcss.js</xsl:variable>
  	<!-- 5.4 4/19 llk:  reference updated to omit redirect from www.ibm.com -->
  <xsl:variable name="default-css-url">/developerworks/css/r1v14.css</xsl:variable>
  <xsl:variable name="col-icon-subdirectory">/developerworks/jp/i/</xsl:variable>
    <!-- 5.5 9/7/06 keb: Added subdirectory variable for processing journal icon gifs -->
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
     <!-- 5.7 3/9/07 llk: Added variable for journal sentence -->
     <!-- 5.9 8/30/07 llk: added from translation per japan team input -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">のコンテンツの一部</xsl:variable>
  <xsl:variable name="from">より</xsl:variable>
  <!-- In template name="AuthorBottom" -->
  <xsl:variable name="aboutTheAuthor">著者について</xsl:variable>
  <xsl:variable name="aboutTheAuthors">著者について</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
<xsl:variable name="biography">経歴</xsl:variable>
  <xsl:variable name="biographies">経歴</xsl:variable>
  <!-- In template name="AuthorTop" -->
  <!-- 5.0 4/17 tdc:  company-name element replaces company attrib -->
  <!-- 5.4 02/20/06 tdc:  Removed job-co-errormsg (replaced with e002) -->
  <!-- 5.5 7/18 llk:  added translated by section per DR 1975 -->
  <xsl:variable name="translated-by">翻訳：</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">日付：</xsl:variable>
  <xsl:variable name="published">公開：</xsl:variable>
  <!-- end 6.0 Maverick beta -->
  <xsl:variable name="updated">更新 </xsl:variable>
  <xsl:variable name="translated">Translated：</xsl:variable>
<xsl:variable name="wwpublishdate"></xsl:variable>
  <xsl:variable name="linktoenglish-heading">この記事の原文：</xsl:variable>
  <xsl:variable name="linktoenglish">英語</xsl:variable>
  <xsl:variable name="daychar">日</xsl:variable>
  <xsl:variable name="monthchar">月</xsl:variable>
  <xsl:variable name="yearchar">年</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF：</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
  <!-- In template name="BundleComponents" -->
  <!-- 5.2 8/22/05 tdc:  Removed dWS variables:   bundle-components-1-text, bundle-components-2a-text, bundle-components-2b-text, installed-together-text, view-components-text, view-download-text, component-note-text-1, component-note-text-2, components-bundle-text -->
  <!-- 5.0 6/1 tdc:  Added pdf-related variables -->
  <xsl:variable name="pdf-alt-letter">PDFフォーマット - レターサイズ</xsl:variable>
  <xsl:variable name="pdf-alt-a4">PDFフォーマット - A4サイズ4</xsl:variable>
    <!-- 5.10 keb 03/07/08:  Added common size PDF alt text -->
  <xsl:variable name="pdf-alt-common">PDF format - Fits A4 and Letter</xsl:variable>
  <xsl:variable name="pdf-text-letter">PDF - レターサイズ</xsl:variable>
  <xsl:variable name="pdf-text-a4">PDF - A4サイズ</xsl:variable>
  <!-- 5.10 keb 03/07/08:  Added common size PDF text -->
  <xsl:variable name="pdf-text-common">PDF - Fits A4 and Letter</xsl:variable>
  <!-- 5.2 8/17/05 tdc:  Added pdf-page and pdf-pages -->
  <xsl:variable name="pdf-page">ページ</xsl:variable>
  <xsl:variable name="pdf-pages">ページ</xsl:variable>
  
  <!-- 5.0.1 7/18 llk:  In template name=Document options -->
<xsl:variable name="document-options-heading">ページオプション</xsl:variable>
  
  <!-- In template name="Download" -->
    <!-- 5.0.1 9/6 llk: made this heading a translated string -->
  <xsl:variable name="options-discuss">議論する</xsl:variable>
  <!-- 5.0 7/13 tdc:  made Sample code a variable -->
  <xsl:variable name="sample-code">ダウンロード</xsl:variable>
  <!-- 4.0 6/1 tdc:  Old "Description" heading now named "Filename"; new filedescription variable added. -->
  <!-- 5.0 7/13 tdc:  Changed download-heading value to Download -->
  <xsl:variable name="download-heading">ダウンロード</xsl:variable>
  <!-- 5.0 7/13 tdc:  Added plural heading for multiple downloads -->
  <xsl:variable name="downloads-heading">ダウンロード</xsl:variable>
    <!-- 5.4 4/21 tdc:  Added download-note-heading and download-notes-heading -->
  <xsl:variable name="download-note-heading">注</xsl:variable>
  <xsl:variable name="download-notes-heading">注</xsl:variable>
  <!-- 4.0 6/6 tdc:  Added also available heading -->
  <xsl:variable name="also-available-heading">もまた利用可能</xsl:variable>
  <!-- 4.0 6/4 tdc:  Added download-heading-more -->
  <xsl:variable name="download-heading-more">その他のダウンロード</xsl:variable>
  <!-- 4.0 6/7 tdc:  Renamed File name to Name -->
  <xsl:variable name="download-filename-heading">ファイル名</xsl:variable>
  <!-- 4.0 6/7 tdc:  Removed File type heading -->
  <xsl:variable name="download-filedescription-heading">内容</xsl:variable>
  <!-- 4.0 6/7 tdc:  Renamed File size to Size -->
  <xsl:variable name="download-filesize-heading">サイズ</xsl:variable>
  <xsl:variable name="download-method-heading">ダウンロード形式</xsl:variable>
  <!-- 12/13/2011 - llk - added url to enable pdf localization -->
    <xsl:variable name="download-method-link-url">http://www.ibm.com/developerworks/library/whichmethod.html</xsl:variable>
  <!-- 4.0 6/7 tdc:  Removed alt text for ftp, http, download director download icons, which were removed themselves -->
  <!-- 4.0 6/7 tdc:  Changed from "Which download method should I choose?" -->
  <xsl:variable name="download-method-link">ダウンロード形式について</xsl:variable>
         <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'図 ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'表 ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'リスト ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
    
    	<!-- 5.10 llk: add variables for content labels -->
	<xsl:variable name="code-sample-label">コードサンプル： </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">ja_JP</xsl:variable>
	<xsl:variable name="demo-label">デモ： </xsl:variable>
	<xsl:variable name="presentation-label">プレゼンテーション： </xsl:variable>
	<xsl:variable name="product-documentation-label">製品資料： </xsl:variable>
	<xsl:variable name="specification-label">仕様書： </xsl:variable>
	<xsl:variable name="technical-article-label">技術記事： </xsl:variable>
	<xsl:variable name="whitepaper-label">ホワイトペーパー： </xsl:variable>
<!-- 5.10 llk 02/04:  add social tagging as an include -->
<!-- 5.10 llk 3/04 : renamed include file to follow standard naming convention -->
	<xsl:variable name="socialtagging-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>	
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">上に戻る</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">上に戻る</a></p>
  </xsl:variable>	

  <!-- 5.0 4/18 tdc:  Added adobe -->
  <xsl:variable name="download-get-adobe">
    <xsl:text disable-output-escaping="yes"><![CDATA[Adobe&#174; Reader&#174; が必要]]></xsl:text>
  </xsl:variable>
  <!-- 4.0 6/16 tdc:  download-path variable not used by worldwide; "en_us" doesn't work if inserted into path.  Kept here so xsl resolves. -->
  <xsl:variable name="download-path">en_us</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/ja_JP/</xsl:variable>
  <!-- 5.2 8/22/05 tdc:  Removed variables for dWS download files: dws-declined-url,  dws-form-action-url,  dws-form-license-title, availability-heading, my-dws-heading, content-notification-url, dws-download-text-1, dws-download-text-2, dws-additional-license-text, dws-download-text-3, zip-text, learn-about-dws-url, browse-catalog-url, purchase-subscription-url, dws-more-about-text, dws-support-heading, help-subscription-url, discussion-forums-url, migration-station-url, product-doc-url -->
  <xsl:variable name="product-doc-url">
    <a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;">Product documentation</a>
  </xsl:variable>
  <xsl:variable name="redbooks-url">
    <a href="http://www.redbooks.ibm.com/">IBM Redbooks</a>
  </xsl:variable>
  <xsl:variable name="tutorials-training-url">
    <a href="/developerworks/training/">チュートリアルとトレーニング</a>
  </xsl:variable>
  <xsl:variable name="drivers-downloads-url">
    <a href="http://www-1.ibm.com/support/us/all_download_drivers.html">ダウンロードのサポート</a>
  </xsl:variable>
  <!-- In template name="Footer" -->
  <!-- 5.2 9/14 jpp:  Removed different footers for brand content areas; all content types use s-footer14 include -->
	  <!-- 5.8 4/25 llk: updated the variable reference to a server side include -->
	<xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-footer14.inc" -->]]></xsl:text>
	</xsl:variable>
  
  <!-- in template name="generalBreadCrumbTrail"  -->

  <xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/jp/</xsl:variable>
    <!-- 12/13/2011 - llk - added top url for pdfs -->
    <xsl:variable name="developerworks-top-url-pdf">ibm.com/developerWorks/jp/</xsl:variable>
    <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">テクニカル・トピックス</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/jp/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">ソフトウェア評価版</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/jp/downloads/</xsl:variable>
  <xsl:variable name="community-text">コミュニティー</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=ja</xsl:variable>
  <xsl:variable name="events-text">イベント</xsl:variable>
 <xsl:variable name="events-url">http://www.ibm.com/developerworks/events/</xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs; keep in english for japan -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_cont_v3.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_pro_v3.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast_v3.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast2.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast3.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast4.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast5.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
	 <xsl:variable name="contributing-author-alt">developerWorks 貢献著者レベル</xsl:variable>
    <xsl:variable name="professional-author-alt">developerWorks プロフェッショナル著者レベル</xsl:variable>
    <xsl:variable name="master-author-alt">developerWorks マスター著者レベル</xsl:variable>
    <xsl:variable name="master2-author-alt">developerWorks マスター著者レベル 2</xsl:variable>
    <xsl:variable name="master3-author-alt">developerWorks マスター著者レベル 3</xsl:variable>
    <xsl:variable name="master4-author-alt">developerWorks マスター著者レベル 4</xsl:variable>
    <xsl:variable name="master5-author-alt">developerWorks マスター著者レベル 5</xsl:variable> 
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
  <xsl:variable name="contributing-author-text">(An IBM developerWorks Contributing Author)</xsl:variable>  
  <xsl:variable name="professional-author-text">(An IBM developerWorks Professional Author)</xsl:variable>  
  <xsl:variable name="master-author-text">(An IBM developerWorks Master Author)</xsl:variable>  
  <xsl:variable name="master2-author-text">(An IBM developerWorks Master Author, Level 2)</xsl:variable>  
  <xsl:variable name="master3-author-text">(An IBM developerWorks Master Author, Level 3)</xsl:variable>  
  <xsl:variable name="master4-author-text">(An IBM developerWorks Master Author, Level 4)</xsl:variable>  
  <xsl:variable name="master5-author-text">(An IBM developerWorks Master Author, Level 5)</xsl:variable>  
  <xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/jp/</xsl:variable>
  <!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
  <xsl:variable name="developerworks-top-heading">developerWorks 日本語版</xsl:variable>
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <!-- Mobile & Agile 02/28/12 jmh: add variable for agile content area top url -->
   <xsl:variable
       name="agile-top-url">http://www.ibm.com/developerworks/jp/views/global/libraryview.jsp</xsl:variable>
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/aix/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area top url -->
   <xsl:variable name="analytics-top-url">http://www.ibm.com/developerworks/analytics/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/jp/architecture/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/jp/data/</xsl:variable>
   <!-- Big data 01/15/13 jmh: add variable for bigdata content area top url -->
   <xsl:variable name="bigdata-top-url">http://www.ibm.com/developerworks/bigdata/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area top url -->
   <xsl:variable name="bpm-top-url">http://www.ibm.com/developerworks/bpm/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/jp/cloud/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce content area top url -->
   <xsl:variable name="commerce-top-url">http://www.ibm.com/developerworks/commerce/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/scenarios/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/jp/industry/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/jp/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/jp/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/jp/lotus/</xsl:variable>
   <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area top url -->
   <xsl:variable
       name="mobile-top-url">http://www.ibm.com/developerworks/jp/views/mobile/libraryview.jsp</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/jp/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/jp/power/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url">http://www.ibm.com/developerworks/jp/grid/</xsl:variable>
   <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security content area top url -->
   <xsl:variable name="security-top-url">http://www.ibm.com/developerworks/security/</xsl:variable>
   <xsl:variable name="autonomic-top-url">http://www.ibm.com/developerworks/jp/autonomic/</xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/jp/rational/</xsl:variable>
   <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area top url -->
   <xsl:variable name="smc-top-url">http://www.ibm.com/developerworks/servicemanagement/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/jp/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/jp/web/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/jp/webservices/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/jp/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/jp/xml/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
	<!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/jp/library/</xsl:variable>
    <xsl:variable name="dw-global-library-text">新着記事一覧</xsl:variable>
  <xsl:variable name="technical-library">技術文書一覧</xsl:variable>      
  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/jp/</xsl:variable>
  <!-- in template name="heading"  -->
    <!-- 5.8 llk 4/25: removed figure character per Japan request -->
  <xsl:variable name="figurechar"></xsl:variable>
  <!-- WW site does not use, but need for xsl continuity -->
  <!-- In template name="IconLinks" -->
  <xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
  <xsl:variable name="icon-discuss-alt">議論する</xsl:variable>
  <xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
  <xsl:variable name="icon-code-download-alt">ダウンロード</xsl:variable>
  <xsl:variable name="icon-code-alt">コード</xsl:variable>
  <xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
  <xsl:variable name="Summary">概要</xsl:variable>
  <xsl:variable name="english-source-heading"/>
  <!-- 5/31 lk - added lang value.. used in email to friend for dbcs -->
  <xsl:variable name="lang">ja</xsl:variable>
  <!-- In template name="Indicators" -->
  <xsl:variable name="level-text-heading">レベル：</xsl:variable>
  <!-- In template name="Masthead" -->
  <!-- 4.0 5/26 tdc:  Changed dw-topmast to s-topmast -->
  <!-- 5.2 9/22/05 tdc:  topmast-inc in the WW translated text has been TEMPORARILY redefined to have a value of the include for s-topmast14. -->
  <!-- 5.2 9/28/05 fjc:  there was a space before the #include that needed to be eliminated -->
<xsl:variable name="topmast-inc">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-topmast14.inc" -->]]></xsl:text>
    </xsl:variable>
  <!-- In template name="LeftNav" -->
  <xsl:variable name="moreThisSeries">このシリーズの一覧</xsl:variable>
  <xsl:variable name="left-nav-in-this-article">目次：</xsl:variable>
  <!-- 5.0 05/09 tdc:  Added left-nav-in-this-tutorial -->
  <xsl:variable name="left-nav-in-this-tutorial">このチュートリアルについて：</xsl:variable>
    <!-- 5.0.1 9/6 llk:  lefthand navs need to be local site specific -->
  <!-- In template name="LeftNavSummary" -->
    <xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-nav14-top.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
  <!-- 5.0.1 9/6 llk:  lefthand navs need to be local site specific -->
  <!-- In template name="LeftNavSummaryInc" -->
   <!-- 5.2 09/28 fjc:  Event left nav needed for all -->
      <!-- 5.11 18/08 llk: added architecture includes from jp site -->
     <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <!-- 5.4 3/24 llk: added library and event left nav for aix content area -->
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-au-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-au-nav14-library.inc" -->]]></xsl:text>      </xsl:variable>
  <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ac-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ac-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        
    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-dm-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-dm-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!--  5.2 10/03 fjc: add training inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-tv-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-tv-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.2 10/03 fjc: add training -->
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>

  <!-- In template name="META" -->
  <xsl:variable name="owner-meta-url"> https://www.ibm.com/developerworks/secure/feedback.jsp?domain=dwjapan</xsl:variable>
  <xsl:variable name="dclanguage-content">ja</xsl:variable>
  <xsl:variable name="ibmcountry-content">JP</xsl:variable>
  
  <!-- 5.8 04/30 egd:  Added variable for meta header inc -->  
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <!-- 5.8 04/30 egd:  Add variable for scripts header inc -->  
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>
 
  
  <!-- In template name="ModeratorBottom -->
  <!-- 5.6 11/16/06 tdc:  Added aboutTheModerator, aboutTheModerators -->
  <xsl:variable name="aboutTheModerator">About the moderator</xsl:variable>
  <xsl:variable name="aboutTheModerators">About the moderators</xsl:variable>  
  <!-- 6.0 Maverick llk 5/9 - remove prepended 0 infront of month value per koh's request -->
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
  <!-- In template name="PageNavigator" -->
  <xsl:variable name="page">ページ</xsl:variable>
  <xsl:variable name="of"> / </xsl:variable>
  <!-- 5.0.1 llk: added for chinese/taiwan page ordering -->
  <xsl:variable name="pageofendtext"></xsl:variable>	
  	<!-- 5.4 3/14 llk: add variables to enable translation of this text -->
      <xsl:variable name="previoustext">前のページに移動</xsl:variable>
   <xsl:variable name="nexttext">次のページに移動</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">前へ</xsl:variable>
  <xsl:variable name="next">次へ</xsl:variable>
  <!-- 4.0 6/6 tdc:  template name is now RelatedContents, not articleRelatedContents -->
  <!-- In template name="RelatedContents" -->
  <xsl:variable name="related-content-heading">関連コンテンツ：</xsl:variable>
    <!-- In template name RelatedLinks -->
  <!-- 5.0.1 9/6 llk: added because headings need to be translated -->
  <!-- 5.2 9/22/05 tdc:  Removed colon after Related links -->
  <xsl:variable name="left-nav-related-links-heading">関連リンク</xsl:variable>
  <xsl:variable name="left-nav-related-links-techlib">記事一覧</xsl:variable>
  <!-- In template name="Subscriptions" -->
  <xsl:variable name="subscriptions-heading"/>
  <!-- 4.1 12/08 tdc:  Removed dws link text/url per SL/KB -->
  <xsl:variable name="dw-newsletter-text">dW Japan ニュースレター</xsl:variable>
  <xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/jp/newsletter/news_samp.html</xsl:variable>
  <!-- 4.0 6/7 tdc:  Added variables for Rational Edge subscription (design request #37) -->
  <xsl:variable name="rational-edge-text">The Rational Edge</xsl:variable>
   <!-- 9/28/05 egd:  Switched URL from subscribe to main Edge page -->
  <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
  <!-- In template name="Resources" and "TableofContents" -->
  <xsl:variable name="resource-list-heading">参考文献</xsl:variable>
  <!-- In template name="resourcelist/ul" -->
  <xsl:variable name="resource-list-forum-text">
  <!-- 9/07/05 tdc:  Replaced call to forumwindow with plain link; changed link wording -->
    <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">ディスカッション・フォーラムに参加してください</a>。]]></xsl:text></xsl:variable>
  <!-- In template "resources" -->
  <xsl:variable name="resources-learn">学ぶために </xsl:variable>
  <xsl:variable name="resources-get">製品や技術を入手するために </xsl:variable>
  <xsl:variable name="resources-discuss">議論するために </xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">このトピックに関するスキルを磨いてください</xsl:variable>
  <xsl:variable name="knowledge-path-text">このコンテンツは、皆さんのスキルを漸進的に磨いていくための Knowledge Path の一部です。次のリンクをご参照ください。</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">このコンテンツは、皆さんのスキルを漸進的に磨いていくための Knowledge Path の一部です。次のリンクをご参照ください： </xsl:variable>
  <!-- In template name="SkillLevel" -->
  <!-- 5.8 llk 4/25: updated skill translation per Japan request -->
  <xsl:variable name="level-1-text">初級</xsl:variable>
  <xsl:variable name="level-2-text">初級</xsl:variable>
  <xsl:variable name="level-3-text">中級</xsl:variable>
  <xsl:variable name="level-4-text">上級</xsl:variable>
  <xsl:variable name="level-5-text">上級</xsl:variable>
  <!-- In template name="TableOfContents" -->
  <xsl:variable name="tableofcontents-heading">目次：</xsl:variable>
  <xsl:variable name="ratethisarticle-heading">記事の評価</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">目次</xsl:variable>
  <xsl:variable name="inline-comments-heading">コメント</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
  <!-- 5.0 05/09 tdc:  Added ratethistutorial-heading -->
  <xsl:variable name="ratethistutorial-heading">チュートリアルの評価</xsl:variable>
  <!-- In file "dw-ratingsform-4.1.xsl  -->
  <xsl:variable name="domino-ratings-post-url" />
  <xsl:variable name="method">POST</xsl:variable>
  <xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/jp/thankyou/</xsl:variable>
  <xsl:variable name="ratings-intro-text">サイト改善のため、ご意見をお寄せください。こちらのフォームからお願いいたします。</xsl:variable>
  <xsl:variable name="ratings-question-text">この記事は役に立った。</xsl:variable>
  <xsl:variable name="ratings-value5-text">とても役に立った (5)</xsl:variable>
  <xsl:variable name="ratings-value4-text">役に立った (4)</xsl:variable>
  <xsl:variable name="ratings-value3-text">どちらでもない (3)</xsl:variable>
  <xsl:variable name="ratings-value2-text">役に立たなかった (2)</xsl:variable>
  <xsl:variable name="ratings-value1-text">全く役に立たなかった (1)</xsl:variable>
  <xsl:variable name="ratings-value5-width">21%</xsl:variable>
  <xsl:variable name="ratings-value4-width">17%</xsl:variable>
  <xsl:variable name="ratings-value3-width">24%</xsl:variable>
  <xsl:variable name="ratings-value2-width">17%</xsl:variable>
  <xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <xsl:variable name="comments-noforum-text">お気軽にご意見・ご感想をお寄せください。</xsl:variable>
  <!-- 5.10 11/07 llk: update translation per japan request -->
  <xsl:variable name="comments-withforum-text">コメントする、もしくは、フォーラムで議論する</xsl:variable>
  <xsl:variable name="submit-feedback-text">フィードバックを送信する</xsl:variable>
  <!-- 5.4 4/18 llk:  added site id for jsp ratings database -->
<xsl:variable name="site_id">60</xsl:variable>
  <!-- in template name="ContentAreaName" -->
  <!-- Mobile & Agile 02/28/12 jmh: add variable for agile content area name -->
  <xsl:variable name="contentarea-ui-name-agile">Agile transformation</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics content area name -->
  <xsl:variable name="contentarea-ui-name-analytics">Business analytics</xsl:variable>
        <!-- 5.5 9/7 llk: add for Architecture content area -->
    <xsl:variable name="contentarea-ui-name-ar">Architecture</xsl:variable>
    <!-- 5.4 3/24 llk: add for AIX content area -->
    <xsl:variable name="contentarea-ui-name-au">AIX and UNIX</xsl:variable>
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
  <!-- 5.4 3/24 llk: updated identifier for autonomic computing -->
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
  <xsl:variable name="contentarea-ui-name-downloads">ダウンロード</xsl:variable>
  <xsl:variable name="contentarea-ui-name-gr">Grid computing</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm content area name -->
  <xsl:variable name="contentarea-ui-name-bpm">Business process management</xsl:variable>
  <xsl:variable name="contentarea-ui-name-j">Java technology</xsl:variable>
  <xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
  <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile content area name -->
  <xsl:variable name="contentarea-ui-name-mobile">Mobile development</xsl:variable>
  <xsl:variable name="contentarea-ui-name-os">Open source</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ws">SOA and web services</xsl:variable>
  <xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
  <xsl:variable name="contentarea-ui-name-co">Components</xsl:variable>
  <xsl:variable name="contentarea-ui-name-s">Security</xsl:variable>
  <xsl:variable name="contentarea-ui-name-wa">Web development</xsl:variable>
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
  <xsl:variable name="contentarea-ui-name-i">Sample IT projects</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
  <xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
	<!-- 5.10 2/15 llk: remove IBM Systems as a content area -->
  <xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
  <xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc content area name -->
  <!-- 07/10/12 jmh: change variable value to Service management  -->
 <!-- 01/15/13 jmh: change variable value to Tivoli (service management)  -->
  <xsl:variable name="contentarea-ui-name-smc">Tivoli (service management)</xsl:variable>
  <xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
  <xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	<!-- 5.10 2/18 llk: update power architecture name -->
<xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
  <!-- in template name="TechLibView" -->
  <!-- Mobile & Agile 02/28/12 jmh: add variable for agile tech library view url -->
  <xsl:variable
      name="techlibview-agile">http://www.ibm.com/developerworks/jp/views/global/libraryview.jsp</xsl:variable>
  <!-- Mobile & Agile 02/28/12 jmh: add variable for mobile tech library view url -->
  <xsl:variable name="techlibview-mobile">http://www.ibm.com/developerworks/jp/views/mobile/libraryview.jsp</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for analytics tech library view url -->
  <xsl:variable name="techlibview-analytics">http://www.ibm.com/developerworks/analytics/library/</xsl:variable>
  <!-- Big data 01/15/13 jmh: add variable for bigdata tech library view url -->
  <xsl:variable name="techlibview-bigdata">http://www.ibm.com/developerworks/bigdata/library/</xsl:variable>
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for commerce tech library view url -->
  <xsl:variable name="techlibview-commerce">http://www.ibm.com/developerworks/commerce/library/</xsl:variable>
  <!-- 5.11 llk - updated for db2 launch -->
  <!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
  <xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/jp/views/data/libraryview.jsp</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for bpm tech library view url -->
  <xsl:variable name="techlibview-bpm">http://www.ibm.com/developerworks/bpm/library/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/jp/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/jp/views/industry/libraryview.jsp</xsl:variable>
    <!-- 5.11 8/08 llk: added japanese view for architecture content area -->
   <xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/jp/views/architecture/libraryview.jsp</xsl:variable>
  <!-- 5.5.1 10/18 llk: updated view subdirectory to reflect /systems instead of /eserver -->
<!-- 5.10 2/18 llk: remove reference to IBM Systems views; IBM Systems no longer valid content area -->
    <!-- 5.4 3/13 llk: added variable, techlibview-s, for China's use only -->
  <!-- BA-Commerce-Security 04/26/12 jmh: add variable for security tech library view url -->
  <xsl:variable name="techlibview-s">http://www.ibm.com/developerworks/security/library/</xsl:variable>
  <!--5.10 11/9 llk: update with japan jsp view links -->
  <xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/jp/views/ibm/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/jp/views/lotus/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/jp/views/rational/libraryview.jsp</xsl:variable>
  <!-- BPM & SMC zones 02/17/12 jmh: add variable for smc tech library view url -->
  <xsl:variable name="techlibview-smc">http://www.ibm.com/developerworks/servicemanagement/library/</xsl:variable>
  <xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/jp/views/tivoli/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/jp/views/websphere/libraryview.jsp</xsl:variable>
    <!-- 5.4 3/24 llk:  added for AIX content area -->
   <xsl:variable name="techlibview-au">http://www-06.ibm.com/systems/jp/p/library/</xsl:variable>
  <!-- 5.4 3/24 llk:  updated identifier for autonomic computing -->
  <!-- 5.10 11/9 llk: update with links to jp jsp views -->
  <xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/jp/autonomic/index.html</xsl:variable>
  <xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/jp/grid/index.html</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/jp/views/java/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/jp/views/linux/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/jp/views/opensource/libraryview.jsp</xsl:variable>
  <!-- 5.11 08/08 llk: update link to point to the japan version of power views -->
  <xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/jp/views/power/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/jp/views/webservices/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/jp/views/web/libraryview.jsp</xsl:variable>
  <!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
  <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
  <!-- 5.11 08/08 llk: update the link to xml library view -->
  <xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/jp/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">次のステップ</xsl:variable>
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">このコンテンツでのアクティビティー</xsl:variable>
  <xsl:variable name="kp-discuss-link">この Knowledge path をディスカッションする</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-download">ダウンロード</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">聴く</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">演習</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">読む</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">見る</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">項目は未完了とマークされています - 完了にするにはマークをクリックしてください</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">項目は完了とマークされています - 未完了にするにはマークをクリックしてください</xsl:variable>
  <xsl:variable name="kp-next-step-ui-buy">購入する</xsl:variable>
  <xsl:variable name="kp-next-step-ui-download">ダウンロード</xsl:variable>
  <xsl:variable name="kp-next-step-ui-follow">フォローする</xsl:variable>
  <xsl:variable name="kp-next-step-ui-join">参加する</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">聴く</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">演習</xsl:variable>
  <xsl:variable name="kp-next-step-ui-read">読む</xsl:variable>
  <xsl:variable name="kp-next-step-ui-watch">見る</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-discuss">議論する</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">申し込む</xsl:variable> 
   <xsl:variable name="kp-next-step-ui-register">登録する</xsl:variable> 
  <xsl:variable name="kp-sign-in">サインイン</xsl:variable> 
  <!-- KP variables: End -->
  <!-- 5.1 08/02/2005 jpp:  Added variables for product landing page URLs for the ProductsLandingURL template -->
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
    <!-- 5.6 12/03/2006 egd: Added variable for  tech library section support search statement (dr 1976)-->
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
   <xsl:variable name="support-search-text-intro">For a comprehensive selection of troubleshooting documents,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">search the IBM technical support knowledge base</xsl:variable> 
  <!-- SUMMARY DOC SECTION HEADINGS -->
  <!-- 5.6 11/16/06 tdc:  Added summary-inThisChat -->
  <xsl:variable name="summary-inThisChat">このチャットでは</xsl:variable>
   <!-- 5.5 08/14 fjc add inthisdemo -->  
  <xsl:variable name="summary-inThisDemo">このデモでは</xsl:variable>
  <xsl:variable name="summary-inThisTutorial">このチュートリアルでは</xsl:variable>
  <xsl:variable name="summary-inThisLongdoc">目次</xsl:variable>
  <xsl:variable name="summary-inThisPresentation">このプレゼンテーションでは</xsl:variable>
  <xsl:variable name="summary-inThisSample">このサンプルでは</xsl:variable>
  <xsl:variable name="summary-inThisCourse">このコースでは</xsl:variable>
  <xsl:variable name="summary-objectives">目的</xsl:variable>
  <xsl:variable name="summary-prerequisities">前提条件</xsl:variable>
  <!-- 5.2 9/22/05 tdc:  Changed R in "Requirements" to lower case -->
  <xsl:variable name="summary-systemRequirements">システム要件</xsl:variable>
  <xsl:variable name="summary-duration">所要時間</xsl:variable>
  <xsl:variable name="summary-audience">対象</xsl:variable>
  <xsl:variable name="summary-languages">Languages</xsl:variable>
  <xsl:variable name="summary-formats">フォーマット</xsl:variable>
  <xsl:variable name="summary-minor-heading">Summary minor heading</xsl:variable>
  <xsl:variable name="summary-getTheArticle">記事を入手する</xsl:variable>
  <!-- 5.0 6/2 fjc add whitepaper -->
  <xsl:variable name="summary-getTheWhitepaper">ホワイトペーパーを入手する</xsl:variable>
  <xsl:variable name="summary-getThePresentation">プレゼンテーションを見る</xsl:variable>
  <xsl:variable name="summary-getTheDemo">デモを見る</xsl:variable>
   <!-- 5.4 4/21 llk: add link to article for korea translated articles -->
    <xsl:variable name="summary-linktotheContent">コンテンツへのリンク</xsl:variable>
  <!-- 5.3 12/12/05 tdc:  Added summary-getTheDownload -->
  <xsl:variable name="summary-getTheDownload">ダウンロードする</xsl:variable>
  <!-- 5.3 12/07/05 tdc:  Added summary-getTheDownloads -->
  <xsl:variable name="summary-getTheDownloads">ダウンロードする</xsl:variable>
  <xsl:variable name="summary-getTheSample">サンプルを見る</xsl:variable>
  <xsl:variable name="summary-rateThisContent">この記事を評価する</xsl:variable>
  <xsl:variable name="summary-getTheSpecification">詳細を見る</xsl:variable>
  <xsl:variable name="summary-contributors">投稿者：</xsl:variable>
  <xsl:variable name="summary-aboutTheInstructor">インストラクターについて</xsl:variable>
  <xsl:variable name="summary-aboutTheInstructors">インストラクターについて</xsl:variable>
  <xsl:variable name="summary-viewSchedules">スケジュールを確認して登録する</xsl:variable>
  <xsl:variable name="summary-viewSchedule">スケジュールを確認して登録する</xsl:variable>
  <xsl:variable name="summary-aboutThisCourse">このコースについて</xsl:variable>
  <xsl:variable name="summary-webBasedTraining">ウェブベースの研修</xsl:variable>
  <xsl:variable name="summary-instructorLedTraining">インストラクター付の研修</xsl:variable>
  <xsl:variable name="summary-classroomTraining">クラスルーム研修</xsl:variable>
  <xsl:variable name="summary-courseType">コースの種類：</xsl:variable>
  <xsl:variable name="summary-courseNumber">コース番号：</xsl:variable>
  <!-- 5.0 5/17 tdc:  Added back summary-scheduleCourse -->
  <xsl:variable name="summary-scheduleCourse">コース</xsl:variable>
  <!-- 5.0 5/17 tdc:  Added back summary-scheduleCenter -->
  <xsl:variable name="summary-scheduleCenter">エデュケーション・センター</xsl:variable>
  <!-- 5.0 5/17 tdc:  Added back summary-classroomCourse -->
  <xsl:variable name="summary-classroomCourse">クラスルームコース</xsl:variable>
  <!-- 5.0 5/17 tdc:  Added back summary-onlineInstructorLedCourse -->
  <xsl:variable name="summary-onlineInstructorLedCourse">オンラインのインストラクター付コース</xsl:variable>
  <!-- 5.0 5/17 tdc:  Added back summary-webBasedCourse -->
  <xsl:variable name="summary-webBasedCourse">ウェブベースのコース</xsl:variable>
  <!-- 5.0 5/25 fjc:  Added websphere enrollment string-->
  <xsl:variable name="summary-enrollmentWebsphere1">For private offerings of this course, please contact us at </xsl:variable>
  <!-- 5.2 09/28 fjc: Added a period to the sentence  -->
  <xsl:variable name="summary-enrollmentWebsphere2">. IBM internal students should enroll via Global Campus.</xsl:variable>
  <!-- 5.0 6/2 fjc add plural-->
  <xsl:variable name="summary-plural">s</xsl:variable>
  <!-- SUMMARY DOC SECTION HEADINGS END -->
  <xsl:variable name="summary-register">全文を読む</xsl:variable>
   <!--5.10 0227 egd add view demo statement for demo summary-->
  <xsl:variable name="summary-view">デモを見る</xsl:variable>
  <xsl:variable name="summary-websphereTraining">IBM WebSphere Training and Technical Enablement</xsl:variable>
    	<!-- 5.0.1 9/19 llk need this to be local site specific in the summary pagse -->
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
	<!-- 5.0.1 9/19 llk this needs to be local site specific include -->
	<xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/jp/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
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
  <!-- 5.1 7/22 jpp/egd:  BEGIN Added variables for landing-product work -->
  <!-- 5.2 9/14 jpp Added text to be prepended to landing-product titles -->
  <!-- in template name="FullTitle"  -->
  <!-- 5.10 11/2007 llk: add japan to full site title -->
  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>
  <!-- in template name="TopStory"  -->
  <xsl:variable name="more-link-text">全文</xsl:variable>
    <!-- 5.5 09/07/06 jpp-egd: Add product-about-product-heading variable -->
  <!-- in template name="AboutProduct" -->
  <xsl:variable name="product-about-product-heading">製品について</xsl:variable>
  <!-- in template name="ProductTechnicalLibrary"  -->
  <xsl:variable name="product-technical-library-heading">技術文書一覧を検索する</xsl:variable>
  <xsl:variable name="technical-library-search-text">キーワードを入力するか、技術文書全体を閲覧したい場合は、入力項目をブランクのままにしておきます：</xsl:variable>
  <!-- in template name="ProductInformation"  -->
  <xsl:variable name="product-information-heading">製品情報</xsl:variable>
  <xsl:variable name="product-related-products">関連製品：</xsl:variable>
  <!-- in template name="ProductDownloads"  -->
  <xsl:variable name="product-downloads-heading">ダウンロード、CD、DVD</xsl:variable>
  <!-- in template name="ProductLearningResources"  -->
  <xsl:variable name="product-learning-resources-heading">リソース</xsl:variable>
  <!-- in template name="ProductSupport"  -->
  <xsl:variable name="product-support-heading">サポート</xsl:variable>
  <!-- in template name="ProductCommunity"  -->
  <xsl:variable name="product-community-heading">コミュニティ</xsl:variable>
  <!-- in template name="MoreProductInformation"  -->
  <xsl:variable name="more-product-information-heading">その他の製品情報</xsl:variable>
  <!-- in template name="Spotlight"  -->
  <xsl:variable name="spotlight-heading">スポットライト</xsl:variable>
  <!-- in template name="LatestContent"  -->
  <xsl:variable name="latest-content-heading">最新のコンテンツ</xsl:variable>
  <xsl:variable name="more-content-link-text">その他のコンテンツ</xsl:variable>
  <!-- in template name="EditorsPicks"  -->
  <xsl:variable name="editors-picks-heading">編集者のお勧め</xsl:variable>
  <!-- in template name="BreadCrumbTitle"  -->
  <xsl:variable name="products-heading">製品</xsl:variable>
  <!-- END 5.1 7/22 jpp/egd:  Added variables for landing-product work -->
  <!-- PDF document stylesheet strings -->
  <!-- 5.0 7/31 tdc:  Added for tutorial PDFs (from Frank's xsl) -->
  <xsl:variable name="pdfTableOfContents">目次</xsl:variable>
  <xsl:variable name="pdfSection">セクション</xsl:variable>
  <xsl:variable name="pdfSkillLevel">スキルレベル</xsl:variable>
  <!-- 5.4 4/18/06 fjc.  change copyright -->
  <!-- <xsl:variable name="pdfCopyrightNotice">Copyright IBM Corporation 2009. すべてにおいてIBM が著作権を有しています。無断転載禁止。</xsl:variable> -->
    <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
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
  <xsl:variable name="pdfTrademarks">商標</xsl:variable>
  <!-- llk 12/13/2011 - added trademark url to localize pdf creation -->
    <xsl:variable name="pdfTrademarks-url">http://www.ibm.com/developerworks/jp/ibm/trademarks/</xsl:variable>
  <xsl:variable name="pdfTrademarks-url-printed">www.ibm.com/developerworks/jp/ibm/trademarks/</xsl:variable>
  <!-- 5.2 8/31 fjc:  Added for tutorial PDFs -->
  <xsl:variable name="pdfResource-list-forum-text">ディスカッション・フォーラムに参加してください。</xsl:variable>
    <!-- 5.2 09/20 fjc:  subscribe to podcast -->
	<xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">developerWorks podcast を購読する</xsl:text></xsl:variable>
	<!-- 5.10 11/07 llk: add about url due to fact that this content is now translated -->
	<xsl:variable name="podcast-about-url">/developerworks/jp/podcast/about.html</xsl:variable>
  <!-- 5.2 09/20 fjc: in this podcast-->
  <xsl:variable name="summary-inThisPodcast">内容</xsl:variable>
   <!-- 5.2 09/20 fjc: about the podcast contributors -->
  <xsl:variable name="summary-podcastCredits">ポッドキャスト・クレジット</xsl:variable>
   <!-- 5.2 09/20 fjc:  for podcast -->
  <xsl:variable name="summary-podcast-not-familiar">ポッドキャストについての詳細は、
<a href=" /developerworks/jp/podcast/about.html">こちらをご参照ください。</a></xsl:variable>
  <!-- 5.2 09/20 fjc:  for podcast -->
  <!-- 5.2 10/13 fjc:  change text -->
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[自動的にファイルをダウンロードして、コンピューターや iPod などのポータブル・オーディオ・プレイヤー上で起動させるには、ポッドキャスト・クライアントが必要です。 <a href="http://www.ipodder.org/" target="_blank">iPodder</a> は無料の、 Mac&#174; OS X, Windows&#174; そして Linux 上で利用できるオープンソース・クライアントです。<a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a> や、ウェブ上で利用できる代替手段も使用できます。]]></xsl:text></xsl:variable>
  <!-- 5.2 10/17 fjc: get the podcast-->
  <xsl:variable name="summary-getThePodcast">ポッドキャストを聞く</xsl:variable>
  <!-- 5.5 07/14/06 fjc:  need more agenda/ presentation strings-->
 <!-- 5.5.1 10/12/06 fjc: still  need more agenda/ presentation strings-->
   <xsl:variable name="summary-getTheAgenda">課題を得る</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">課題を得る</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">課題とプレゼンテーションを得る</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">課題とプレゼンテーションを得る</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">課題とプレゼンテーションを得る</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">課題とプレゼンテーションを得る</xsl:variable>
  <xsl:variable name="summary-getThePresentations">プレゼンテーションを得る</xsl:variable>
  <!-- 5.5.1 10/12/06 fjc: END still  need more agenda/ presentation strings-->
  <xsl:variable name="summary-getTheWorkshopMaterials">ワークショップの資料を得る</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">タイプ：</xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">テクニカル・ブリーフィング</xsl:variable>
  <xsl:variable name="summary-inThisEvent">このイベントでは</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">このワークショップでは</xsl:variable>
  <xsl:variable name="summary-hostedBy">主催：</xsl:variable>
  <xsl:variable name="summary-attendedByPlural">企業代表</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">企業代表</xsl:variable>
  <!-- 5.10 9/25/07 llk: added Japanese text for this string -->
<xsl:variable name="common-trademarks-text">他の会社名、製品名およびサービス名等はそれぞれ各社の商標です。</xsl:variable>
    	<!-- 5.5 6/26 llk: added  statement per China Legal request-->
<xsl:variable name="copyright-statement"></xsl:variable>
 <!-- 5.3 12/14 tdc:  Added aboutTheContributor and aboutTheContributors -->
   <xsl:variable name="aboutTheContributor">貢献者について</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">登録テキストを表示するために Java スクリプトが必要です。</xsl:variable>
  <xsl:variable name="aboutTheContributors">貢献者について</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">現在、スケジュールされたイベントはございません。更新を確認するためにここへお戻りください。</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">場所を選択して登録してください</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">タイプ: ビジネス・ブリーフィング</xsl:variable>
  <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">タイプ：</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType --> 
   
  <!-- 5.7 0325 egd Changed to reflect new briefing name -->
 <xsl:variable name="summary-briefingTechType">developerWorks Live! ブリーフィング</xsl:variable>
    <!-- 5.4 1/31/06 Flash required -->
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[To view the demos included in this tutorial, JavaScript must be enabled in your browser and Macromedia Flash Player 6 or higher must be installed. You can download the latest Flash Player at <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text></xsl:variable>
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
<xsl:variable name="series">Series</xsl:variable>
  <xsl:variable name="series-view">このシリーズの他の記事を見る</xsl:variable>
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
<!-- 6.0 Maverick llk - 05/09 - null out publish schedule text per koh request; make into text field instead -->
<xsl:variable name="publish-schedule"></xsl:variable>
<xsl:variable name="show-descriptions-text">概要の表示</xsl:variable>
<xsl:variable name="hide-descriptions-text">概要の非表示</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url">//www.ibm.com/software/jp/data/</xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url">//www.ibm.com/software/jp/lotus/</xsl:variable>
  <xsl:variable name="ibm-rational-software-url">//www.ibm.com/software/jp/rational/</xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url">//www.ibm.com/software/jp/tivoli/</xsl:variable>
  <xsl:variable name="ibm-websphere-software-url">//www.ibm.com/software/jp/websphere/</xsl:variable>
 
<!-- End Maverick Landing Page variables -->
  <xsl:variable name="codeTableSummaryAttribute">This table contains a code listing.</xsl:variable>
  <xsl:variable name="downloadTableSummaryAttribute">This table contains downloads for this document.</xsl:variable>
  <xsl:variable name="errorTableSummaryAttribute">This table contains an error message.</xsl:variable> 
  
</xsl:stylesheet>