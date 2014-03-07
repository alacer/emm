<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== -->
  <!-- 5.0 6/14 tdc:  Added variables for file paths to enable Authoring package files -->
  <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
    <!-- 5.7 3/20 llk: need new variable to support local sites
 <xsl:variable name="newpath-dw-root-local-ls">/developerworks/cn/</xsl:variable>
 <xsl:variable name="newpath-dw-root-local-ls">../web/www.ibm.com/developerworks/</xsl:variable> -->
 <!-- these are the includes for the local site have to add them to ians 
 <xsl:variable name="newpath-dw-root-web-inc">/developerworks/cn/inc/</xsl:variable>
<xsl:variable name="newpath-dw-root-web-inc">../web/www.ibm.com/developerworks/cn/inc/</xsl:variable>
-->
 
    <!-- 5.7 2007-03-22 ibs Redo newpath variables to be under parameter control -->
   <!--  DR 2256 to provide local-url-base parameter.  -->
  <xsl:param name="local-url-base">..</xsl:param>

  <!-- New DR to combine author and dwmaster variable definitions into parameter control.  
    Current legitimate values of 'preview' or 'final'. Might also be 'CMA' some day  -->
  <xsl:param name="xform-type">final</xsl:param>

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
      <xsl:when test="$xform-type = 'final' ">/developerworks/cn/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/cn/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- 5.7 0326 egd Added this one from Leah's new stem for local sites. -->
    <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/cn/</xsl:when>
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
   <!-- 5.4 3/13 llk:  update path statement to developerworks/cn/i/ per China team request -->
   <!-- 5.7 llk:  03/20 added this variable for local sites that keep their own version of the images -->
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local-ls" />i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/rules/</xsl:variable>
    <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/buttons/cn/zh/</xsl:variable> 
  
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
  <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/cn/views/</xsl:variable>
  <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local-ls" />inc/</xsl:variable>
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
	<!-- v17 Enablement jpp 09/25/2011:  Added web-site-owner variable -->
    <xsl:variable name="web-site-owner">dw@cn.ibm.com</xsl:variable>
    <!-- 5.4 1/29/06 fjc add  -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Business perspectives</xsl:variable>
<!-- 5.4 1/29/06 fjc stop add  -->
<!-- 5.7 3/9 llk: update "skip to main menu text -->
  <xsl:variable name="main-content">跳转到主要内容</xsl:variable>


  <!-- v17 Enablement jpp 09/25/2011:  Removed preview stylesheet calls from this file -->
	<!-- In template match="/" -->
	<xsl:variable name="Attrib-javaworld">经许可，从<a href="http://www.javaworld.com/?IBMDev">JavaWorld 杂志</a> 重印. Web Publishing Inc.（一家 IDG 通信公司）版权所有。注册免费的<a href="http://www.javaworld.com/subscribe?IBMDev">JavaWorld 时事通讯</a>。</xsl:variable>
	<!-- In template name="/" -->
	<!-- 5.5 8/7 llk: updated stylesheet reference to 5.5 -->
	<!-- v17 Enablement jpp 09/25/2011:  Updated stylesheet reference to 7.0 -->
	<xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-7.0.xsl</xsl:variable>
	<!-- In template name="Abstract" and AbstractExtended -->
	<!-- In templates "articleJavaScripts",  "summaryJavaScripts", "dwsJavaScripts", "sidefileJavaScripts" -->
	<!-- 5.4 4/19 llk:  reference updated to omit redirect from www.ibm.com -->
	<xsl:variable name="browser-detection-js-url">/developerworks/js/dwcss14.js</xsl:variable>
	<!-- 5.4 4/19 llk:  reference updated to omit redirect from www.ibm.com -->
	<xsl:variable name="default-css-url">/developerworks/css/r1v14.css" </xsl:variable>
	<xsl:variable name="col-icon-subdirectory">/developerworks/cn/i/</xsl:variable>
	  <!-- 5.5 9/7/06 keb: Added subdirectory variable for processing journal icon gifs -->
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
   <!-- 5.7 3/9/07 llk: Added variable for journal sentence -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">本文来自于</xsl:variable>
  <xsl:variable name="from">来自</xsl:variable>
	<!-- In template name="AuthorBottom" -->
	<xsl:variable name="aboutTheAuthor">关于作者</xsl:variable>
	<xsl:variable name="aboutTheAuthors">作者简介</xsl:variable>
        <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
    <xsl:variable name="biography">作者简介</xsl:variable>
    <xsl:variable name="biographies">作者简介</xsl:variable>
	<!-- In template name="AuthorTop" -->
	<!-- 5.0 4/17 tdc:  company-name element replaces company attrib -->
	<!-- 5.4 02/20/06 tdc:  Removed job-co-errormsg (replaced with e002) -->
	<!-- 5.5 7/18 llk:  added translated by section per DR 1975 -->
  <xsl:variable name="translated-by">Translated by：</xsl:variable>
	<xsl:variable name="updated">更新 </xsl:variable>
  <xsl:variable name="translated">Translated：</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">发布日期：</xsl:variable>
  <xsl:variable name="published">最初发布</xsl:variable>
	<xsl:variable name="wwpublishdate"></xsl:variable>
  <xsl:variable name="linktoenglish-heading">原创语言：</xsl:variable>
  <xsl:variable name="linktoenglish">英文</xsl:variable>
  <xsl:variable name="daychar"> 日</xsl:variable>
	<xsl:variable name="monthchar"> 月</xsl:variable>
	<xsl:variable name="yearchar"> 年</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF：</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
<!-- 5.0 6/1 tdc:  Added pdf-related variables -->
<xsl:variable name="pdf-alt-letter">PDF 格式 - letter</xsl:variable>
<xsl:variable name="pdf-alt-a4">PDF 格式 - A4</xsl:variable>
  <!-- 5.10 keb 03/07/08:  Added common size PDF alt text -->
  <xsl:variable name="pdf-alt-common">PDF format - Fits A4 and Letter</xsl:variable>
<xsl:variable name="pdf-text-letter">PDF - letter</xsl:variable>
<xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <!-- 5.10 keb 03/07/08:  Added common size PDF text -->
  <xsl:variable name="pdf-text-common">PDF - Fits A4 and Letter</xsl:variable>
  <!-- 5.2 8/17/05 tdc:  Added pdf-page and pdf-pages -->
  <xsl:variable name="pdf-page">page</xsl:variable>
  <xsl:variable name="pdf-pages">pages</xsl:variable>

<!-- 5.0.1 7/18 llk:  In template name=Document options -->
  <!-- 5.0.1 9/6 llk: made this heading a translated string -->
  <xsl:variable name="options-discuss">讨论</xsl:variable>
<xsl:variable name="document-options-heading">文档选项</xsl:variable>
<xsl:variable name="sample-code">样例代码</xsl:variable>
	<!-- In template name="Download" -->
	<xsl:variable name="downloads-heading">下载</xsl:variable>
	<xsl:variable name="download-heading">下载</xsl:variable>
		<!-- 5.10 llk: add translation for note and notes -->
  <xsl:variable name="download-note-heading">注意：</xsl:variable>
  <xsl:variable name="download-notes-heading">注意：</xsl:variable>
	<xsl:variable name="also-available-heading">同时获得</xsl:variable>
	<xsl:variable name="download-heading-more">更多下载</xsl:variable>
	<xsl:variable name="download-filename-heading">名字</xsl:variable>
	<xsl:variable name="download-filedescription-heading">描述</xsl:variable>
	<xsl:variable name="download-filesize-heading">大小</xsl:variable>
	<xsl:variable name="download-method-heading">下载方法</xsl:variable>
	<xsl:variable name="download-method-link">关于下载方法的信息</xsl:variable>
            <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'图 ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'表 ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'清单 ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
		<!-- 5.10 llk: add variables for content labels -->
	<xsl:variable name="code-sample-label">代码示例： </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">zh_CN</xsl:variable>
	<xsl:variable name="demo-label">演示： </xsl:variable>
	<xsl:variable name="presentation-label">演讲稿： </xsl:variable>
	<xsl:variable name="product-documentation-label">产品文档： </xsl:variable>
	<xsl:variable name="specification-label">规范： </xsl:variable>
	<xsl:variable name="technical-article-label">技术文章： </xsl:variable>
	<xsl:variable name="whitepaper-label">白皮书： </xsl:variable>
<!-- 5.10 llk 02/04:  add social tagging as an include -->
	<xsl:variable name="socialtagging-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!-- -->]]></xsl:text>
	</xsl:variable>	
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">回页首</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">回页首</a></p>
  </xsl:variable>	
	<!-- 5.0 4/18 tdc:  Added adobe -->
	<xsl:variable name="download-get-adobe">
	   <xsl:text disable-output-escaping="yes"><![CDATA[Get Adobe&#174; Reader&#174;]]></xsl:text>
	</xsl:variable>
	<!-- 4.0 6/16 tdc:  download-path variable not used by worldwide; "en_us" doesn't work if inserted into path.  Kept here so xsl resolves. -->
	<xsl:variable name="download-path">cn</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/zh_CN/</xsl:variable>
	<xsl:variable name="product-doc-url">
		<a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=CN&amp;&amp;FNC=ICL&amp;">产品文档</a>
	</xsl:variable>
	<xsl:variable name="redbooks-url">
		<a href="http://www.redbooks.ibm.com/">IBM Redbooks</a>
	</xsl:variable>
	<xsl:variable name="tutorials-training-url">
		<a href="/developerworks/training/">精品教程</a>
	</xsl:variable>
	<xsl:variable name="drivers-downloads-url">
		<a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Support downloads</a>
	</xsl:variable>
	<!-- In template name="Footer" -->

	  <!-- 5.8 4/25 llk: updated the variable reference to a server side include -->
	<xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-footer14.inc" -->]]></xsl:text>
	</xsl:variable>
	<!-- in template name="generalBreadCrumbTrail"  -->
	<xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/cn/</xsl:variable>
	<xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/cn/</xsl:variable>
	<!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
	<xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
	    <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">技术主题</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/cn/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">软件下载</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/cn/downloads/</xsl:variable>
  <xsl:variable name="community-text">社区</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=zh</xsl:variable>
  <xsl:variable name="events-text">技术讲座</xsl:variable>
 <xsl:variable name="events-url">https://www.ibm.com/developerworks/community/groups/service/html/communityview?communityUuid=6d7f9e5d-5f89-4767-a006-a81b8d186370&amp;lang=zh</xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs; keep in english for china -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_cont_v3.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_pro_v3.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast_v3.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast2.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast3.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast4.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/authorrecogbadge_mast5.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
	<xsl:variable name="contributing-author-alt">developerWorks 投稿作者</xsl:variable>
    <xsl:variable name="professional-author-alt">developerWorks 专家作者</xsl:variable>
    <xsl:variable name="master-author-alt">developerWorks 大师作者</xsl:variable>
    <xsl:variable name="master2-author-alt">developerWorks 2 星大师作者</xsl:variable>
    <xsl:variable name="master3-author-alt">developerWorks 3 星大师作者</xsl:variable>
    <xsl:variable name="master4-author-alt">developerWorks 4 星大师作者</xsl:variable>
    <xsl:variable name="master5-author-alt">developerWorks 5 星大师作者</xsl:variable>
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
  <xsl:variable name="contributing-author-text">(An IBM developerWorks Contributing Author)</xsl:variable>  
  <xsl:variable name="professional-author-text">(An IBM developerWorks Professional Author)</xsl:variable>  
  <xsl:variable name="master-author-text">(An IBM developerWorks Master Author)</xsl:variable>  
  <xsl:variable name="master2-author-text">(An IBM developerWorks Master Author, Level 2)</xsl:variable>  
  <xsl:variable name="master3-author-text">(An IBM developerWorks Master Author, Level 3)</xsl:variable>  
  <xsl:variable name="master4-author-text">(An IBM developerWorks Master Author, Level 4)</xsl:variable>  
  <xsl:variable name="master5-author-text">(An IBM developerWorks Master Author, Level 5)</xsl:variable>    
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/cn/aix/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/cn/architecture/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/cn/data/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/cn/cloud/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/scenarios/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/cn/industry/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/cn/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/cn/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/cn/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/cn/lotus/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/cn/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/cn/power/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url">http://www.ibm.com/developerworks/cn/grid/</xsl:variable>
   <xsl:variable name="security-top-url">http://www.ibm.com/developerworks/cn/security/</xsl:variable>
   <xsl:variable name="autonomic-top-url">http://www.ibm.com/developerworks/cn/autonomic/</xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/cn/rational/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/cn/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/cn/web/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/cn/webservices/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/cn/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/cn/xml/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
    <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/cn/library/</xsl:variable>
  <xsl:variable name="dw-global-library-text">更多</xsl:variable>
  <xsl:variable name="technical-library">文档库</xsl:variable>      

	  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/cn/</xsl:variable>

	<!-- in template name="heading"  -->
	<xsl:variable name="figurechar"/> <!-- china site does not use, but need for xsl continuity -->
	<!-- In template name="IconLinks" -->
	<xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
	<xsl:variable name="icon-discuss-alt">讨论</xsl:variable>
	<xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
	<xsl:variable name="icon-code-download-alt">下载</xsl:variable>
	<xsl:variable name="icon-code-alt">代码</xsl:variable>
	<xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
	<xsl:variable name="Summary">总结</xsl:variable>
	<xsl:variable name="english-source-heading">英文原文</xsl:variable>
	<xsl:variable name="lang">cn</xsl:variable>
	<!-- In template name="Indicators" -->
	<xsl:variable name="level-text-heading">级别：</xsl:variable>
	<!-- In template name="Masthead" -->
	<xsl:variable name="topmast-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-topmast.inc" -->]]></xsl:text>
	</xsl:variable>
	<!-- In template name="LeftNav" -->
	<xsl:variable name="moreThisSeries">本系列的更多信息</xsl:variable>
	<xsl:variable name="left-nav-in-this-article">本文内容包括：</xsl:variable>
	<xsl:variable name="left-nav-in-this-tutorial">在本教程中：</xsl:variable>
	<!-- 5.0.1 7/28 llk:  added these so local sites can have their lefthand navs pulled into summary pages -->
		<!-- in template name="LeftNavSummaryInc" -->
	<xsl:variable name="left-nav-top">
		   <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14-top.inc" -->]]></xsl:text>
	</xsl:variable>
		<xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
   <!-- 5.5 9/7/06 llk: added architecture includes -->
     <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ar-nav14.inc" -->]]></xsl:text></xsl:variable>
	  <!-- 5.4 3/24 llk: added event left nav for aix content area -->
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-au-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-au-nav14.inc" -->]]></xsl:text>      </xsl:variable>
        
    <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ac-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ac-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-db2-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-dm-nav14.inc" -->]]></xsl:text></xsl:variable>

<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->

    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-gr-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-j-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-l-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-ls-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-os-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-pa-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-pa-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-r-nav14.inc" -->]]></xsl:text></xsl:variable>
<!--  5.2 10/03 fjc: add training inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-r-nav14-training.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.11 tivoli is moving from content area to pass through page for china dr 2965 -->
    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-t-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-t-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-wa-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-ws-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-ws-nav14.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.2 10/03 fjc: add training -->
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/d-ws-nav14-training.inc" -->]]></xsl:text></xsl:variable>

<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->

    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/t-x-nav14.inc" -->]]></xsl:text></xsl:variable>



	<!-- In template name="META" -->
	<xsl:variable name="owner-meta-url">dw@cn.ibm.com</xsl:variable>
	<xsl:variable name="dclanguage-content">zh-CN</xsl:variable>
	<xsl:variable name="ibmcountry-content">cn</xsl:variable>
	
  <!-- 5.8 04/30 egd:  Added variable for meta header inc -->  
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <!-- 5.8 04/30 egd:  Add variable for scripts header inc -->  
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>

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
	
	  <!-- In template name="ModeratorBottom -->
  <!-- 5.6 11/16/06 tdc:  Added aboutTheModerator, aboutTheModerators -->
  <xsl:variable name="aboutTheModerator">About the moderator</xsl:variable>
  <xsl:variable name="aboutTheModerators">About the moderators</xsl:variable>	
	
	<!-- 5.0 5/11 tdc:  Added variables for new PageNavigator template -->
<!-- In template name="PageNavigator" -->
	<xsl:variable name="page">第</xsl:variable>
   <xsl:variable name="of">页，共</xsl:variable>
	<xsl:variable name="pageofendtext">页</xsl:variable>	
	<!-- 5.4 3/14 llk: add variables to enable translation of this text -->
      <xsl:variable name="previoustext">前一页</xsl:variable>
   <xsl:variable name="nexttext">后一页</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">前一页</xsl:variable>
  <xsl:variable name="next">后一页</xsl:variable>
	<!-- In template name="RelatedContents" -->
	<xsl:variable name="related-content-heading">相关内容：</xsl:variable>
	
	  <!-- In template name RelatedLinks -->
  <!-- 5.0.1 9/6 llk: added because headings need to be translated -->
  <xsl:variable name="left-nav-related-links-heading">相关链接：</xsl:variable>
<!-- 5.3  1/5/06  llk:  updated this translated string -->
  <xsl:variable name="left-nav-related-links-techlib">技术文档库</xsl:variable>

	
	<!-- In template name="Subscriptions" -->
	<xsl:variable name="subscriptions-heading">订阅：</xsl:variable>
	<xsl:variable name="dw-newsletter-text">dW 工具包订阅</xsl:variable>
	<xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/cn/newsletter/</xsl:variable>
	<!-- 5.5 8/28 llk: updated with translated text per china request -->
	<xsl:variable name="rational-edge-text">Rational Edge 电子月刊中文版</xsl:variable>
	   <!-- 9/28/05 egd:  Switched URL from subscribe to main Edge page -->
  <!-- 5.4 3/13 llk: update location of rational edge url to reflect the chinese version -->
  <xsl:variable name="rational-edge-url">/developerworks/cn/rational/rationaledge/</xsl:variable>
	<!-- In template name="Resources" and "TableofContents" -->
	<xsl:variable name="resource-list-heading">参考资料 </xsl:variable>
	<!-- In template name="resourcelist/ul" -->
	<!-- 5.0 5/13 tdc:  Changed "article" to "content"; removed the text referring to Discuss link at top of page. -->
<!-- 5.4 3/13 llk: update the English text to Chinese per China team request -->
	<xsl:variable name="resource-list-forum-text"><xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">参与论坛讨论</a>。]]></xsl:text></xsl:variable>
    <!-- In template "resources" -->
    <xsl:variable name="resources-learn">学习</xsl:variable>
    <xsl:variable name="resources-get">获得产品和技术</xsl:variable>
    <xsl:variable name="resources-discuss">讨论</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">开发此方面的技能</xsl:variable>
  <xsl:variable name="knowledge-path-text">本内容是一套渐进的学习路线图的一部分，用来帮助您提升自己的技能。请参考</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">本内容是一套渐进的学习路线图的一部分，用来帮助您提升自己的技能。请参考：</xsl:variable> 
	<!-- In template name="SkillLevel" -->
	<xsl:variable name="level-1-text">初级</xsl:variable>
	<xsl:variable name="level-2-text">初级</xsl:variable>
	<xsl:variable name="level-3-text">中级</xsl:variable>
	<xsl:variable name="level-4-text">高级</xsl:variable>
	<xsl:variable name="level-5-text">高级</xsl:variable>
	<!-- In template name="TableOfContents" -->
	<xsl:variable name="tableofcontents-heading">内容：</xsl:variable>
	<xsl:variable name="ratethisarticle-heading">对本文的评价</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">内容</xsl:variable>
  <xsl:variable name="inline-comments-heading">评论</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
	<xsl:variable name="ratethistutorial-heading">对本教程的评价</xsl:variable>
	<!-- In file "dw-ratingsform-4.1.xsl  -->
		<!-- 5.4 4/27 llk:  update reference from www-128 to www -->
	<xsl:variable name="domino-ratings-post-url">https://www.ibm.com/developerworks/secure/cnratings.jsp</xsl:variable>
	<xsl:variable name="method">GET</xsl:variable>
	<xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/cn/thankyou/</xsl:variable>
	<!-- 5.0 4/13 tdc:  Added ratings-intro-text -->
	<xsl:variable name="ratings-intro-text">请填写此表，以便我们更好地为您提供服务。</xsl:variable>
	<xsl:variable name="ratings-question-text">您对这篇文章的看法如何？</xsl:variable>
	<xsl:variable name="ratings-value5-text">真棒！(5)</xsl:variable>
	<xsl:variable name="ratings-value4-text">好文章 (4)</xsl:variable>
	<xsl:variable name="ratings-value3-text">一般；尚可 (3)</xsl:variable>
	<xsl:variable name="ratings-value2-text">需提高 (2)</xsl:variable>
	<xsl:variable name="ratings-value1-text">太差！ (1)</xsl:variable>
	<xsl:variable name="ratings-value5-width">21%</xsl:variable>
	<xsl:variable name="ratings-value4-width">17%</xsl:variable>
	<xsl:variable name="ratings-value3-width">24%</xsl:variable>
	<xsl:variable name="ratings-value2-width">17%</xsl:variable>
	<xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <xsl:variable name="comments-noforum-text">评论？</xsl:variable>
	<xsl:variable name="comments-withforum-text">将您的建议发给我们或者通过参加讨论与其他人分享您的想法.</xsl:variable>
	<xsl:variable name="submit-feedback-text">反馈意见</xsl:variable>
	<!-- 5.4 4/18 llk:  added site id for jsp ratings database -->
	<xsl:variable name="site_id">10</xsl:variable>
	
	<!-- in template name="ContentAreaName" -->
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
	      <!-- 5.5 9/7 llk: add for Architecture content area -->
    <xsl:variable name="contentarea-ui-name-ar">Architecture</xsl:variable>
<!-- 5.4 3/24 llk: add for AIX content area -->
   <xsl:variable name="contentarea-ui-name-au">AIX and UNIX</xsl:variable>
    <!-- 5.4 3/24 llk: updated identifier for autonomic computing -->
	<xsl:variable name="contentarea-ui-name-ac">Autonomic computing</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Blogs</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-community">Community</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Downloads</xsl:variable>
	<xsl:variable name="contentarea-ui-name-gr">Grid computing</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
	<xsl:variable name="contentarea-ui-name-j">Java technology</xsl:variable>
	<xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
	<xsl:variable name="contentarea-ui-name-os">Open source</xsl:variable>
	<!-- 4.0 5/27 tdc:  Updated name from Web services to SOA and Web services -->
	<xsl:variable name="contentarea-ui-name-ws">SOA and web services</xsl:variable>
	<xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
<!-- 5.10 11/07 llk: remove components as a content area  dr 2558 -->
	<xsl:variable name="contentarea-ui-name-s">Security</xsl:variable>
	<xsl:variable name="contentarea-ui-name-wa">Web development</xsl:variable>
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
	<!-- 4.0 6/22 tdc:  Changed Scenarios to Sample IT projects per note from Jack P. -->
	<xsl:variable name="contentarea-ui-name-i">Sample IT projects</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
	<!-- 5.4 02/15/06 tdc:  Changed DB2 to Information Management -->
	<xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
	<!-- 5.10 2/15 llk: remove IBM Systems as a content area -->
	<xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
	<xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
	<xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	<xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
	<!-- 5.10 2/18 llk: update power architecture name -->
<xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
	<!-- in template name="TechLibView" -->
	<!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
	<xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/cn/views/data/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/cn/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/cn/views/industry/libraryview.jsp</xsl:variable>
	  <!-- 5.5 9/8/06 llk: added view for architecture content area -->
   <xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/cn/views/architecture/libraryview.jsp</xsl:variable>
  <!-- 5.5.1 10/18 llk: updated view subdirectory to reflect /systems instead of /eserver -->
<!-- 5.10 2/18 llk: remove reference to IBM Systems views; IBM Systems no longer valid content area -->
		<!-- 5.4 3/13 llk: add variable, techlibview-s, which points to the Chinese security article view -->
	<xsl:variable name="techlibview-s">http://www.ibm.com/developerworks/cn/views/security/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/views/ibm/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/cn/views/lotus/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/cn/views/rational/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/views/tivoli/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/cn/views/websphere/libraryview.jsp</xsl:variable>
		<!-- 5.4 3/24 llk:  added for AIX content area -->
  <!-- Maverick r3 4/25 - updated aix library url per Sunny request -->
  <xsl:variable name="techlibview-au">http://www.ibm.com/developerworks/cn/views/aix/libraryview.jsp</xsl:variable>
  <!-- 5.4 3/24 llk:  updated identifier for autonomic computing -->
	<xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/views/autonomic/library.jsp</xsl:variable>
	<xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/cn/views/grid/libraryview.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/cn/ibmi/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/cn/views/java/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/cn/views/linux/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/cn/views/opensource/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/views/power/library.jsp</xsl:variable>
	<!-- 5.5 9/12 llk: add china web views and workplace views -->
	<xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/cn/views/webservices/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/cn/views/web/libraryview.jsp</xsl:variable>
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	<xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/cn/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">后续步骤</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">本路线图中的活动</xsl:variable>
  <xsl:variable name="kp-discuss-link">讨论这个学习路线图</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-download">下载</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">收听</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">实践</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">阅读</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">观看</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">灰色未选中的复选项</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">绿色选中的复选项</xsl:variable>
  <xsl:variable name="kp-next-step-ui-buy">购买</xsl:variable>
  <xsl:variable name="kp-next-step-ui-download">下载</xsl:variable>
  <xsl:variable name="kp-next-step-ui-follow">关注</xsl:variable>
  <xsl:variable name="kp-next-step-ui-join">参加</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">收听</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">实践</xsl:variable>
  <xsl:variable name="kp-next-step-ui-read">阅读</xsl:variable>
  <xsl:variable name="kp-next-step-ui-watch">观看</xsl:variable>
  <xsl:variable name="kp-next-step-ui-discuss">讨论</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">报名参加</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">注册</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">提交</xsl:variable> 
  <!-- KP variables: End -->
	  <!-- 5.1 08/02/2005 jpp:  Added variables for product landing page URLs for the ProductsLandingURL template -->
  <!-- In template name="ProductsLandingURL" -->
      <!-- 5.4 3/24 llk: added for AIX content area -->
    <xsl:variable name="products-landing-au">
    <xsl:value-of select="$developerworks-top-url"/>aix/products/</xsl:variable>
    <!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
  <xsl:variable name="products-landing-db2">
    <xsl:value-of select="$developerworks-top-url"/>data/products/</xsl:variable>
    <!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
  <xsl:variable name="products-landing-lo">
    <xsl:value-of select="$developerworks-top-url"/>lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r">
    <xsl:value-of select="$developerworks-secondary-url"/>rational/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv">
    <xsl:value-of select="$developerworks-top-url"/>tivoli/products/</xsl:variable>
  <!-- 5.5 06/08/2006 jpp-egd:  Updated WebSphere product page URL -->
  <xsl:variable name="products-landing-web">
    <xsl:value-of select="$developerworks-top-url"/>websphere/products/</xsl:variable>
  <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
    <!-- 5.6 12/03/2006 egd: Added variable for  tech library section support search statement <DR 1976) -->
  <xsl:variable name="support-search-url">http://www.ibm.com/support/cn/</xsl:variable>
   <xsl:variable name="support-search-text-intro">如需查找更详尽的故障处理文档，</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">请访问 IBM 技术支持知识库。</xsl:variable> 
	<!-- SUMMARY DOC SECTION HEADINGS -->
		<!-- 5.6 11/16/06 tdc:  Added summary-inThisChat -->
  <xsl:variable name="summary-inThisChat">In this chat</xsl:variable>
	 <!-- 5.5 08/14 fjc add inthisdemo -->  
	 <!-- 5.10 3/14 llk: add translation string -->
  <xsl:variable name="summary-inThisDemo">在本演示中</xsl:variable>
	<xsl:variable name="summary-inThisTutorial">在本教程中</xsl:variable>
	<xsl:variable name="summary-inThisLongdoc">本文内容包括</xsl:variable>
	<xsl:variable name="summary-inThisPresentation">在此演示文稿中</xsl:variable>
	<xsl:variable name="summary-inThisSample">在该示例中</xsl:variable>
	<xsl:variable name="summary-inThisCourse">在本课程中</xsl:variable>
	<xsl:variable name="summary-objectives">目标</xsl:variable>
	<xsl:variable name="summary-prerequisities">预备知识</xsl:variable>
	<xsl:variable name="summary-systemRequirements">系统需求</xsl:variable>
	<xsl:variable name="summary-duration">学习时间</xsl:variable>
	<xsl:variable name="summary-audience">学习对象</xsl:variable>
	<xsl:variable name="summary-languages">语言</xsl:variable>
	<xsl:variable name="summary-formats">格式</xsl:variable>
	<xsl:variable name="summary-minor-heading">Summary minor heading</xsl:variable>
	<xsl:variable name="summary-getTheArticle">获得本文</xsl:variable>
	<!-- 5.0 6/2 fjc add whitepaper -->
	<xsl:variable name="summary-getTheWhitepaper">获得白皮书</xsl:variable>
	<xsl:variable name="summary-getThePresentation">获得演示文稿</xsl:variable>
	<xsl:variable name="summary-getTheDemo">获得演示</xsl:variable>
	<!-- 5.4 4/21 llk: add link to article for china translated articles -->
    <xsl:variable name="summary-linktotheContent">Link to the content</xsl:variable>
	<!-- 5.3 12/12/05 tdc:  Added summary-getTheDownload -->
	<!-- 5.10 3/14 llk: update translation string per china request -->
  <xsl:variable name="summary-getTheDownload">获取下载</xsl:variable>
  <xsl:variable name="summary-getTheDownloads">获取下载</xsl:variable>
	<xsl:variable name="summary-getTheSample">获得示例</xsl:variable>
	<xsl:variable name="summary-rateThisContent">对此内容的评价</xsl:variable>
	<xsl:variable name="summary-getTheSpecification">获得规范</xsl:variable>
	<xsl:variable name="summary-contributors">投稿者：</xsl:variable>
	<xsl:variable name="summary-aboutTheInstructor">关于讲师</xsl:variable>
	<xsl:variable name="summary-aboutTheInstructors">关于讲师们</xsl:variable>
	<xsl:variable name="summary-viewSchedules">查看课程表和注册信息</xsl:variable>
	<xsl:variable name="summary-viewSchedule">查看课程表和注册信息</xsl:variable>	
	<xsl:variable name="summary-aboutThisCourse">关于本课程</xsl:variable>
	<xsl:variable name="summary-webBasedTraining">基于 Web 的培训</xsl:variable>
	<xsl:variable name="summary-instructorLedTraining">讲师指导的培训</xsl:variable>
	<xsl:variable name="summary-classroomTraining">课堂培训</xsl:variable>
	<xsl:variable name="summary-courseType">课程类型：</xsl:variable>
	<xsl:variable name="summary-courseNumber">课程编号：</xsl:variable>
	<xsl:variable name="summary-scheduleCourse">课程</xsl:variable>
	<xsl:variable name="summary-scheduleCenter">教育中心</xsl:variable>
	<xsl:variable name="summary-classroomCourse">课堂讲授的课程</xsl:variable>
	<xsl:variable name="summary-onlineInstructorLedCourse">在线讲师讲授的课程</xsl:variable>
	<xsl:variable name="summary-webBasedCourse">基于 Web 的课程</xsl:variable>
	<xsl:variable name="summary-enrollmentWebsphere1">要获得本课程的相关资料，请与我们联系。</xsl:variable>
	<xsl:variable name="summary-enrollmentWebsphere2">IBM 内部学员应该通过 Global Campus 注册。</xsl:variable>
	<xsl:variable name="summary-plural">s</xsl:variable>
	
	<!-- SUMMARY DOC SECTION HEADINGS END -->
	<xsl:variable name="summary-register">现在注册或者使用您的 IBM ID 和密码登录</xsl:variable>
	 <!--5.10 0227 egd add view demo statement for demo summary-->
   <xsl:variable name="summary-view">查看演示</xsl:variable>
  <xsl:variable name="summary-websphereTraining">IBM WebSphere 培训与技术讲座</xsl:variable>
	  	<!-- 5.0.1 9/19 llk need this to be local site specific in the summary pagse -->
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
	<xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/cn/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
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


  <!-- in template name="FullTitle"  -->
  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>

	  <!-- 5.1 7/22 jpp/egd:  BEGIN Added variables for landing-product work -->
  <!-- in template name="TopStory"  -->
  <!-- 5.7 3/12 llk: update the more text string -->
  <xsl:variable name="more-link-text">更多</xsl:variable>
    <!-- 5.11 08/18/08  llk: Add chinese translations per jet and sunny's request DR2824 -->
  <!-- in template name="AboutProduct" -->
  <xsl:variable name="product-about-product-heading">关于产品</xsl:variable>
  <!-- in template name="ProductTechnicalLibrary"  -->
  <xsl:variable name="product-technical-library-heading">搜索产品技术文档库</xsl:variable>
  <xsl:variable name="technical-library-search-text">请输入搜索关键字，不输入关键字则可以查看所有技术文档：</xsl:variable>
  <!-- in template name="ProductInformation"  -->
  <xsl:variable name="product-information-heading">产品信息</xsl:variable>
  <xsl:variable name="product-related-products">相关产品：</xsl:variable>
  <!-- in template name="ProductDownloads"  -->
  <xsl:variable name="product-downloads-heading">下载资源</xsl:variable>
  <!-- in template name="ProductLearningResources"  -->
  <xsl:variable name="product-learning-resources-heading">学习资源</xsl:variable>
  <!-- in template name="ProductSupport"  -->
  <xsl:variable name="product-support-heading">技术支持</xsl:variable>
  <!-- in template name="ProductCommunity"  -->
  <xsl:variable name="product-community-heading">开发者社区</xsl:variable>
  <!-- in template name="MoreProductInformation"  -->
  <xsl:variable name="more-product-information-heading">更多相关产品信息</xsl:variable>
  <!-- in template name="Spotlight"  -->
  <!-- 5.10 3/14 llk:  add translation string -->
  <xsl:variable name="spotlight-heading">热点链接</xsl:variable>
  <!-- in template name="LatestContent"  -->
<xsl:variable name="latest-content-heading">最新内容</xsl:variable>
  <xsl:variable name="more-content-link-text">更多产品信息</xsl:variable>
  <!-- in template name="EditorsPicks"  -->
  <xsl:variable name="editors-picks-heading">编辑推荐</xsl:variable>
  <!-- in template name="BreadCrumbTitle"  -->
  <xsl:variable name="products-heading">产品</xsl:variable>
  <!-- END 5.1 7/22 jpp/egd:  Added variables for landing-product work -->
  <!-- PDF document stylesheet strings -->
  <!-- 5.0 7/31 tdc:  Added for tutorial PDFs (from Frank's xsl) -->
  <xsl:variable name="pdfTableOfContents">本文内容包括</xsl:variable>
  <xsl:variable name="pdfSection">Section</xsl:variable>
  <xsl:variable name="pdfSkillLevel">Skill Level</xsl:variable>
  <!-- 5.4 4/18/06 fjc.  change copyright -->
  <!-- 5.11 12/03/08 egd:  removed the 1994, text until early Jan when we rewrite this -->
   <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. All rights reserved.</xsl:variable> --> 
     <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
  <xsl:variable name="dcRights-v16"><xsl:text>&#169; Copyright&#160;</xsl:text>
	 <xsl:text>IBM Corporation&#160;</xsl:text>
          <xsl:value-of select="//date-published/@year"/>
		<xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="//date-updated/@year" />
		</xsl:if></xsl:variable>
  <xsl:variable name="pdfTrademarks">Trademarks</xsl:variable>
  <!-- 5.2 8/31 fjc:  Added for tutorial PDFs -->
  <xsl:variable name="pdfResource-list-forum-text">Participate in the discussion forum for this content.</xsl:variable>

	  <!-- 5.2 09/20 fjc:  subscribe to podcast -->
	<xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">订阅 developerWorks Podcast</xsl:text></xsl:variable>
			<!-- 5.10 11/07 llk: add about url due to fact that this content is now translated -->
	<xsl:variable name="podcast-about-url">/developerworks/cn/podcast/about.html</xsl:variable>
  <!-- 5.2 09/20 fjc: in this podcast-->
  <xsl:variable name="summary-inThisPodcast">Podcast 内容简介</xsl:variable>
   <!-- 5.2 09/20 fjc: about the podcast contributors -->
  <xsl:variable name="summary-podcastCredits">关于主持人</xsl:variable>
   <!-- 5.2 09/20 fjc:  for podcast -->
  <xsl:variable name="summary-podcast-not-familiar">Podcast 是什么？ <a href="/developerworks/cn/podcast/about.html">了解更多</a>。</xsl:variable>
  <!-- 5.2 09/20 fjc:  for podcast -->
  <!-- 5.2 10/13 fjc:  change text -->
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[如需下载，并同步 Podcast 音频文件到您的计算机或移动音频播放设备（如 iPod），您需要使用 Podcast 客户端软件。<a href="http://www.ipodder.org/" target="_blank">iPodder</a> 是一个免费的开放源码 Podcast 客户端软件，并且支持 Mac&#174; OS X，Windwos&#174; 以及 Linux&#174; 操作系统平台。你也可以使用 <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>、<a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>，或其他可选择的 Podcast 客户端软件。]]></xsl:text></xsl:variable>
  <!-- 5.2 10/17 fjc: get the podcast-->
<!-- 5.3 12/15/05 fc:  added variables for event summary pages -->
  <xsl:variable name="summary-getThePodcast">获取 Podcast</xsl:variable>
  <!-- 5.5 07/14/06 fjc:  need more agenda/ presentation strings-->
 <!-- 5.5.1 10/12/06 fjc: still  need more agenda/ presentation strings-->
   <xsl:variable name="summary-getTheAgenda">下载日程信息</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">下载日程信息</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">下载日程信息与幻灯片</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">下载日程信息与幻灯片</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">下载日程信息与幻灯片</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">下载日程信息与幻灯片</xsl:variable>
  <xsl:variable name="summary-getThePresentations">下载幻灯片</xsl:variable>
  <!-- 5.5 8/7 llk: remove extra summary-getThePresentation from this file -->  
   <xsl:variable name="summary-getTheWorkshopMaterials">下载研习会材料</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">类型：</xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">技术讲座</xsl:variable>
  <xsl:variable name="summary-inThisEvent">活动简介</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">活动简介</xsl:variable>
  <xsl:variable name="summary-hostedBy">主办：</xsl:variable>
  <xsl:variable name="summary-attendedByPlural">参与的公司</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">参与的公司</xsl:variable>
    <!-- 5.3 12/07/05 tdc:  Added common-trademarks-text -->
    <!-- 5.4 1/30 llk:  updated text to simplified chinese."-->
<xsl:variable name="common-trademarks-text">其他公司、产品或服务的名称可能是其他公司的商标或服务标志。</xsl:variable>
  	<!-- 5.5 6/26 llk: added copyright statement per China Legal request-->
  	<!-- 5.5 8/7 llk: copyright text approved and added per China Legan request -->
  	<!-- 5.5 9/12 llk: removed paragraph tags in order to bring more inline with trademark text -->
<xsl:variable name="copyright-statement">IBM 公司保留在 developerWorks 网站上发表的内容的著作权。未经IBM公司或原始作者的书面明确许可，请勿转载。如果您希望转载，请通过 <a href="https://www.ibm.com/developerworks/secure/reprintreq.jsp?domain=dwchina">提交转载请求表单</a> 联系我们的编辑团队。</xsl:variable>
  <!-- 5.3 12/14 tdc:  Added aboutTheContributor and aboutTheContributors -->
  <xsl:variable name="aboutTheContributor">关于赞助商</xsl:variable>
  <xsl:variable name="aboutTheContributors">关于赞助商</xsl:variable>
    <!-- lk add these values to each translated text file 5.4 -->
  <xsl:variable name="summary-briefingNotFound">目前尚没有举办本活动的安排，请过一段时间之后再来查看。</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">选择地点注册参加</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">类型：业务讲座</xsl:variable>
    <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">类型：</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType --> 
    <!-- 5.7 0325 egd Changed to reflect new briefing name -->
  <xsl:variable name="summary-briefingTechType">developerWorks Live! 技术讲座</xsl:variable>
    <!-- 5.4 1/31/06 Flash required -->
  <!-- 5.10 3/14 llk:  add translation string -->
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[要查看本教程中所包括的演示，您需要在浏览器中启用 JavaScript 并安装 Macromedia Flash Player 6 或更高版本。您可以通过链接 <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>下载最新的 Flash Player。]]></xsl:text></xsl:variable>
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
<!-- add these values to each translated text file 5.4 -->
<!-- 5.11 08/08 llk - add translation per China request BEGIN DR 2887  -->
<xsl:variable name="ready-to-buy">准备购买？</xsl:variable>
<xsl:variable name="buy">在线购买</xsl:variable>
<xsl:variable name="online" />
<xsl:variable name="try-online-register">现在注册或者使用您的 IBM ID 和密码登录，在线试用。</xsl:variable>
<xsl:variable name="download-operatingsystem-heading">操作系统</xsl:variable>
<xsl:variable name="download-version-heading">版本</xsl:variable>
<!-- 5.11 08/08 llk - add translation per China request END DR 2887  -->
<!-- End variables for Trial Program Pages -->
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
  <xsl:variable name="series">系列</xsl:variable>
  <xsl:variable name="series-view">查看本系列更多内容</xsl:variable>
<!-- End Maverick Series Summary area variables -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
  <xsl:variable name="form-search-in">搜索：</xsl:variable>
  <xsl:variable name="form-product-support">产品支持</xsl:variable>
  <xsl:variable name="form-faqs">FAQs</xsl:variable>
  <xsl:variable name="form-product-doc">产品文档</xsl:variable>
  <xsl:variable name="form-product-site">产品网站</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
  <xsl:variable name="show-descriptions-text">显示说明</xsl:variable>
  <xsl:variable name="hide-descriptions-text">隐藏说明</xsl:variable>
<xsl:variable name="try-together-text"></xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
  <xsl:variable name="codeTableSummaryAttribute">This table contains a code listing.</xsl:variable>
  <xsl:variable name="downloadTableSummaryAttribute">This table contains downloads for this document.</xsl:variable>
  <xsl:variable name="errorTableSummaryAttribute">This table contains an error message.</xsl:variable> 
  <!-- Project Defiant jpp 10/12/11: Added variable section and featured results variables -->
<!-- Results page variables: Start -->
	<xsl:variable name="featured-results-heading">Featured</xsl:variable>
	<xsl:variable name="category-article">Article</xsl:variable>
	<xsl:variable name="category-audio">Audio</xsl:variable>
	<xsl:variable name="category-blog">Blog</xsl:variable>
	<xsl:variable name="category-briefing">Briefing</xsl:variable>
	<xsl:variable name="category-champion">IBM Champion</xsl:variable>
	<xsl:variable name="category-demo">Demo</xsl:variable>
	<xsl:variable name="category-download">Download</xsl:variable>
	<xsl:variable name="category-forum">Forum</xsl:variable>
	<xsl:variable name="category-group">Group</xsl:variable>
	<xsl:variable name="category-knowledge-path">Knowledge Path</xsl:variable>
	<xsl:variable name="category-tutorial">Tutorial</xsl:variable>
	<xsl:variable name="category-video">Video</xsl:variable>
	<xsl:variable name="category-wiki">Wiki</xsl:variable>
	<!-- Project Defiant jpp 11/02/11: Added results-trending-bg-image variable -->
	<xsl:variable name="results-trending-bg-image">//dw1.s81c.com/developerworks/i/dw-results-trending-leadspace.jpg</xsl:variable>
	<!-- Project Defiant jpp 11/27/11: Added learnabout variable -->
	<xsl:variable name="learnabout">Learn about</xsl:variable>
<!-- Results page variables: End -->
</xsl:stylesheet>
