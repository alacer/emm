<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== -->
  <!-- 5.0 6/14 tdc:  Added variables for file paths to enable Authoring package files -->
  <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
    <!-- 5.7 3/20 llk: need new variable to support local sites
 <xsl:variable name="newpath-dw-root-local-ls">/developerworks/ru/</xsl:variable>
 <xsl:variable name="newpath-dw-root-local-ls">../web/www.ibm.com/developerworks/</xsl:variable> -->
 <!-- these are the includes for the local site have to add them to ians 
 <xsl:variable name="newpath-dw-root-web-inc">/developerworks/ru/inc/</xsl:variable>
<xsl:variable name="newpath-dw-root-web-inc">../web/www.ibm.com/developerworks/ru/inc/</xsl:variable>
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
      <xsl:when test="$xform-type = 'final' ">/developerworks/ru/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/ru/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- 5.7 0326 egd Added this one from Leah's new stem for local sites. -->
    <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/ru/</xsl:when>
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
  <!-- START COMMON INTERNAL AND AUTHOR PACKAGE FILE PATH VARIABLES< ################################## --> 
  <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local-ls" />inc/</xsl:variable>
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"/>i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local" />www.ibm.com/i/v14/buttons/ru/ru/</xsl:variable> 
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
  <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/ru/views/</xsl:variable>
  <xsl:variable name="path-ibm-stats">//stats.www.ibm.com/</xsl:variable>
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
  <!-- v17 Enablement jpp 09/16/2011:  Added web-site-owner variable -->
  <xsl:variable name="web-site-owner">developerWorks@ru.ibm.com</xsl:variable>
  <!-- 5.4 1/29/06 fjc add  -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Business perspectives</xsl:variable>
  <xsl:variable name="main-content">Перейти к тексту</xsl:variable>
 
  <!-- v17 Enablement jpp 09/16/2011:  Removed preview stylesheet calls from this file -->
	<!-- In template match="/" -->
	<xsl:variable name="Attrib-javaworld">Перепечатано с разрешения <a href="http://www.javaworld.com/?IBMDev">JavaWorld magazine</a>. Все права принадлежат IDG.net, an IDG Communications company.  Зарегистрируйтесь для бесплатного получения <a href="http://www.javaworld.com/subscribe?IBMDev">новостной рассылки JavaWorld</a>.
</xsl:variable>
	<!-- In template name="/" -->
	<!-- 5.5 8/7 llk: updated stylesheet reference to 5.5 -->
	<!-- v17 Enablement jpp 09/24/2011:  Updated stylesheet reference to 7.0 -->
	<xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-7.0.xsl</xsl:variable>
	<!-- In template name="Abstract" and AbstractExtended -->
	<!-- In templates "articleJavaScripts",  "summaryJavaScripts", "dwsJavaScripts", "sidefileJavaScripts" -->
<!-- 5.4 4/27  llk:  remove reference to server to avoid redirect to ibm.com -->
	<xsl:variable name="browser-detection-js-url">/developerworks/js/dwcss.js</xsl:variable>
	<!-- 5.4 4/27  llk:  remove reference to server to avoid redirect to ibm.com -->
	<xsl:variable name="default-css-url">/developerworks/css/r1v14.css</xsl:variable>
	<xsl:variable name="col-icon-subdirectory">/developerworks/ru/i/</xsl:variable>
	  <!-- 5.5 9/7/06 keb: Added subdirectory variable for processing journal icon gifs -->
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
    <!-- 5.7 3/9/07 llk: Added variable for journal sentence -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">Из журнала</xsl:variable>
  <xsl:variable name="from">Из журнала</xsl:variable>
	<!-- In template name="AuthorBottom" -->
	<xsl:variable name="aboutTheAuthor">Об авторе</xsl:variable>
	<xsl:variable name="aboutTheAuthors">Об авторах</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
   <xsl:variable name="biography">Biography</xsl:variable>
  <xsl:variable name="biographies">Biographies</xsl:variable>
    <!-- In template name="AuthorTop" -->
	<!-- 5.0 4/17 tdc:  company-name element replaces company attrib -->
	<!-- 5.4 02/20/06 tdc:  Removed job-co-errormsg (replaced with e002) -->
	<!-- 5.5 7/18 llk:  added translated by section per DR 1975 -->
  <xsl:variable name="translated-by">Перевод:</xsl:variable>
	<xsl:variable name="updated">Обновлено</xsl:variable>
	<xsl:variable name="translated">Translated:</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">Дата:</xsl:variable>
  <xsl:variable name="published">Опубликовано:</xsl:variable>
	<xsl:variable name="wwpublishdate"></xsl:variable>
  <xsl:variable name="linktoenglish-heading">Первоначально опубликовано:</xsl:variable>
  <xsl:variable name="linktoenglish">Английский</xsl:variable>
	<xsl:variable name="daychar"/>
	<xsl:variable name="monthchar"/>
	<xsl:variable name="yearchar"/>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF:</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
<!-- 5.0 6/1 tdc:  Added pdf-related variables -->
<xsl:variable name="pdf-alt-letter">Формат PDF - letter</xsl:variable>
<xsl:variable name="pdf-alt-a4">Формат PDF - A4</xsl:variable>
    <!-- 5.10 keb 03/07/08:  Added common size PDF alt text -->
  <xsl:variable name="pdf-alt-common">PDF format - Fits A4 and Letter</xsl:variable>
<xsl:variable name="pdf-text-letter">PDF - Letter</xsl:variable>
<xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <!-- 5.10 keb 03/07/08:  Added common size PDF text -->
  <xsl:variable name="pdf-text-common">PDF - Fits A4 and Letter</xsl:variable>
  <!-- 5.2 8/17/05 tdc:  Added pdf-page and pdf-pages -->
  <!-- 5.5 8/30 llk: added translation text -->
  <xsl:variable name="pdf-page">страницы</xsl:variable>
  <xsl:variable name="pdf-pages">страница</xsl:variable>

<!-- 5.0.1 7/18 llk:  In template name=Document options -->
  <xsl:variable name="options-discuss">Обсудить</xsl:variable>
<xsl:variable name="document-options-heading">Опции документа</xsl:variable>
<xsl:variable name="sample-code">Исходные тексты примера</xsl:variable>


	<!-- In template name="Download" -->
	<!-- 5.4 llk:  this text string changed per Dmitry request -->
	<xsl:variable name="downloads-heading">Загрузка</xsl:variable>
	<xsl:variable name="download-heading">Загрузка</xsl:variable>
		<!-- 5.4 4/21 tdc:  Added download-note-heading and download-notes-heading -->
		  <!-- 5.5 8/30 llk: added translation text -->
  <xsl:variable name="download-note-heading">Заметка</xsl:variable>
  <xsl:variable name="download-notes-heading">Заметка</xsl:variable>
	<xsl:variable name="also-available-heading">Также доступны</xsl:variable>
	<xsl:variable name="download-heading-more">Другие файлы для загрузки</xsl:variable>
	<xsl:variable name="download-filename-heading">Имя</xsl:variable>
	<xsl:variable name="download-filedescription-heading">Описание</xsl:variable>
	<xsl:variable name="download-filesize-heading">Размер</xsl:variable>
	<xsl:variable name="download-method-heading">Метод загрузки</xsl:variable>
	<xsl:variable name="download-method-link">Информация о методах загрузки</xsl:variable>
	<!-- 5.10 llk: add variables for content labels -->
      <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'Рисунок ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'Таблица ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'Листинг ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
    
    
    
	<xsl:variable name="code-sample-label">Образец кода: </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">ru_RU</xsl:variable>
	<xsl:variable name="demo-label">Демо: </xsl:variable>
	<xsl:variable name="presentation-label">Презентация: </xsl:variable>
	<xsl:variable name="product-documentation-label">Документация продукта: </xsl:variable>
	<xsl:variable name="specification-label">Спецификация: </xsl:variable>
	<xsl:variable name="technical-article-label">Техническая статья: </xsl:variable>
	<xsl:variable name="whitepaper-label">Оффициальный документ: </xsl:variable>
<!-- 5.10 llk 02/04:  add social tagging as an include -->
	<xsl:variable name="socialtagging-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>	
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">В начало</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">В начало</a></p>
  </xsl:variable>	
	<xsl:variable name="download-get-adobe">
	   <xsl:text disable-output-escaping="yes"><![CDATA[Загрузить Adobe&#174; Reader&#174;]]></xsl:text>
	</xsl:variable>
	<xsl:variable name="download-path">ru</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/ru_RU/</xsl:variable>
	  <xsl:variable name="product-doc-url">
    <a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;">Product documentation</a>
  </xsl:variable>
  <xsl:variable name="redbooks-url">
    <a href="http://www.redbooks.ibm.com/">IBM Redbooks</a>
  </xsl:variable>
  <xsl:variable name="tutorials-training-url">
    <a href="/developerworks/training/">Tutorials and training</a>u
  </xsl:variable>
  <xsl:variable name="drivers-downloads-url">
    <a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Support downloads</a>
  </xsl:variable>

	  <!-- 5.8 4/25 llk: updated the variable reference to a server side include -->
	<xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-footer14.inc" -->]]></xsl:text>
	</xsl:variable>
	<!-- in template name="generalBreadCrumbTrail"  -->
	<xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/ru/</xsl:variable>
	<xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/ru/</xsl:variable>
	<!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
	<xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
	    <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">Технические материалы</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/ru/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">Пробное ПО</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/downloads/</xsl:variable>
  <xsl:variable name="community-text">Сообщество</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=ru</xsl:variable>
  <xsl:variable name="events-text"></xsl:variable>
 <xsl:variable name="events-url"></xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_cont_RU.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_prof_RU.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast_RU.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast2_RU.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast3_RU.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast4_RU.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast5_RU.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
	 <xsl:variable name="contributing-author-alt">developerWorks Contributing author level</xsl:variable>
    <xsl:variable name="professional-author-alt">developerWorks Professional author level</xsl:variable>
    <xsl:variable name="master-author-alt">developerWorks Master author level</xsl:variable>
    <xsl:variable name="master2-author-alt">developerWorks Master author level 2</xsl:variable>
    <xsl:variable name="master3-author-alt">developerWorks Master author level 3</xsl:variable>
    <xsl:variable name="master4-author-alt">developerWorks Master author level 4</xsl:variable>
    <xsl:variable name="master5-author-alt">developerWorks Master author level 5</xsl:variable> 
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
  <xsl:variable name="contributing-author-text">(Участник developerWorks)</xsl:variable>  
  <xsl:variable name="professional-author-text">(Специалист developerWorks)</xsl:variable>  
  <xsl:variable name="master-author-text">(Эксперт developerWorks)</xsl:variable>  
  <xsl:variable name="master2-author-text">(Опытный эксперт developerWorks)</xsl:variable>  
  <xsl:variable name="master3-author-text">(Признанный эксперт developerWorks)</xsl:variable>  
  <xsl:variable name="master4-author-text">(Старший эксперт developerWorks)</xsl:variable>  
  <xsl:variable name="master5-author-text">(Гуру developerWorks)</xsl:variable>     
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/ru/aix/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/ru/architecture/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/ru/data/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/ru/cloud/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/scenarios/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/ru/industry/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/ru/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/ru/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/ru/lotus/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/ru/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/ru/power/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url">http://www.ibm.com/developerworks/ru/grid/</xsl:variable>
   <xsl:variable name="security-top-url"></xsl:variable>
   <xsl:variable name="autonomic-top-url">http://www.ibm.com/developerworks/ru/autonomic/</xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/ru/rational/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/ru/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/ru/web/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/ru/webservices/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/ru/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/ru/xml/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
    <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/ru/library/</xsl:variable>
  <xsl:variable name="dw-global-library-text">Еще</xsl:variable>
  <xsl:variable name="technical-library">Статьи</xsl:variable>      
	  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/ru/</xsl:variable>

	<!-- in template name="heading"  -->
	<xsl:variable name="figurechar"/> <!-- WW site does not use, but need for xsl continuity -->
	<!-- In template name="IconLinks" -->
	<xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
	<xsl:variable name="icon-discuss-alt">Обсудить</xsl:variable>
	<xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
	<xsl:variable name="icon-code-download-alt">Загрузка</xsl:variable>
	<xsl:variable name="icon-code-alt">Код</xsl:variable>
	<xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
	<xsl:variable name="Summary">Краткое содержание</xsl:variable>
	<!-- 5.7 3/22 llk: update link to english text per Victor Mitin input -->
	<xsl:variable name="english-source-heading">оригинал статьи</xsl:variable>
	<xsl:variable name="lang">ru</xsl:variable>
	<!-- In template name="Indicators" -->
	<xsl:variable name="level-text-heading">Уровень сложности: </xsl:variable>
	<!-- In template name="Masthead" -->
	<xsl:variable name="topmast-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-topmast14.inc" -->]]></xsl:text>
	</xsl:variable>
	
	<!-- In template name="LeftNav" -->
  <xsl:variable name="moreThisSeries">Другие статьи  серии</xsl:variable>
	<xsl:variable name="left-nav-in-this-article">В этой статье:</xsl:variable>
	<!-- 5.0 05/09 tdc:  Added left-nav-in-this-tutorial -->
	<xsl:variable name="left-nav-in-this-tutorial">В этом учебном пособии:</xsl:variable>

		<!-- in template name="LeftNavSummary" -->
	<xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14-top.inc" -->]]></xsl:text></xsl:variable>
	<xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
   <!-- 5.5 9/7/06 llk: added architecture includes -->
     <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ar-nav14-library.inc" -->]]></xsl:text></xsl:variable>
	  <!-- 5.4 3/24 llk: added event left nav for aix content area -->
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-au-nav14-library.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-au-nav14-library.inc" -->]]></xsl:text>      </xsl:variable>

    <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ac-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/inc/t-ac-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-db2-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-db2-nav14-library.inc" -->]]></xsl:text></xsl:variable>

<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
<!-- 5.10  2/18 llk: remove option for systems; no longer valid content area -->
    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-gr-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-j-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-l-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-ls-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-os-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-pa-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!--  5.2 10/03 fjc: add training inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-r-nav14-library.inc" -->]]></xsl:text></xsl:variable>


    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-tv-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-tv-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-wa-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-ws-nav14-library.inc" -->]]></xsl:text></xsl:variable>

    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-w-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-w-nav14-library.inc" -->]]></xsl:text></xsl:variable>
<!-- 5.2 10/03 fjc: add training -->
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/d-w-nav14-library.inc" -->]]></xsl:text></xsl:variable>


<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
<!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/t-x-nav14-library.inc" -->]]></xsl:text></xsl:variable>


	<!-- In template name="META" -->
	<xsl:variable name="owner-meta-url">developerWorks@ru.ibm.com</xsl:variable>
	<xsl:variable name="dclanguage-content">ru</xsl:variable>
	<xsl:variable name="ibmcountry-content">RU</xsl:variable>
	
  <!-- 5.8 04/30 egd:  Added variable for meta header inc -->  
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <!-- 5.8 04/30 egd:  Add variable for scripts header inc -->  
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>

 <!-- In template name="ModeratorBottom -->
  <!-- 5.6 11/16/06 tdc:  Added aboutTheModerator, aboutTheModerators -->
  <xsl:variable name="aboutTheModerator">About the moderator</xsl:variable>
  <xsl:variable name="aboutTheModerators">About the moderators</xsl:variable>	
	<!-- In template name="MonthName" -->
	<xsl:variable name="month-1-text">01</xsl:variable>
	<xsl:variable name="month-2-text">02</xsl:variable>
	<xsl:variable name="month-3-text">03</xsl:variable>
<!-- 5.5 7/5 llk: updated typo in April's text -->
	<xsl:variable name="month-4-text">04</xsl:variable>
	<xsl:variable name="month-5-text">05</xsl:variable>
	<xsl:variable name="month-6-text">06</xsl:variable>
	<xsl:variable name="month-7-text">07</xsl:variable>
	<xsl:variable name="month-8-text">08</xsl:variable>
	<xsl:variable name="month-9-text">09</xsl:variable>
	<xsl:variable name="month-10-text">10</xsl:variable>
	<xsl:variable name="month-11-text">11</xsl:variable>
	<xsl:variable name="month-12-text">12</xsl:variable>
	
	<!-- In template name="PageNavigator" -->
	<xsl:variable name="page">Страница</xsl:variable>
    	<xsl:variable name="of">из</xsl:variable>
    	<xsl:variable name="pageofendtext"></xsl:variable>
    		<!-- 5.4 3/14 llk: add variables to enable translation of this text -->
    <xsl:variable name="previoustext">На предыдущую страницу</xsl:variable>
   <xsl:variable name="nexttext">На предыдущую страницу</xsl:variable>	
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">предыдущая</xsl:variable>
  <xsl:variable name="next">следующая</xsl:variable>
	<!-- In template name="RelatedContents" -->
	<xsl:variable name="related-content-heading">Дополнительные материалы:</xsl:variable>
	  <!-- 5.0.1 9/6 llk: added because headings need to be translated -->
  <xsl:variable name="left-nav-related-links-heading">Ссылки по теме:</xsl:variable>
    <!-- 5.4 3/28 llk:  update text for "technical library -->
  <xsl:variable name="left-nav-related-links-techlib">техническая библиотека</xsl:variable>

	<!-- In template name="Subscriptions" -->
	<xsl:variable name="subscriptions-heading">Subscriptions:</xsl:variable>
	<xsl:variable name="dw-newsletter-text">Hовостная рассылка dW</xsl:variable>
	<xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/newsletter/</xsl:variable>
	<xsl:variable name="rational-edge-text">the Rational Edge</xsl:variable>
		<!-- 5.6 llk: updated link to rational-edge-url -->
	<xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
	<!-- In template name="Resources" and "TableofContents" -->
	<xsl:variable name="resource-list-heading">Ресурсы</xsl:variable>
	<!-- In template name="resourcelist/ul" -->
	<!-- 5.6 llk: update from forum window javascript -->
		<xsl:variable name="resource-list-forum-text"><xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">Примите участие в обсуждении материала на форуме</a>.]]></xsl:text></xsl:variable>
    <!-- In template "resources" -->
    <xsl:variable name="resources-learn">Научиться</xsl:variable>
    <!-- 5.3 llk:  11/21 - update the resources-get text -->
    <xsl:variable name="resources-get">Получить продукты и технологии</xsl:variable>
    <xsl:variable name="resources-discuss">Обсудить</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">Развить навыки по этой теме</xsl:variable>
  <xsl:variable name="knowledge-path-text">Этот материал — часть knowledge path для развития ваших навыков. Смотри</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">Этот материал — часть knowledge path для развития ваших навыков. Смотри:</xsl:variable>
	<!-- In template name="SkillLevel" -->
	<xsl:variable name="level-1-text">простой</xsl:variable>
	<xsl:variable name="level-2-text">простой</xsl:variable>
	<xsl:variable name="level-3-text">средний</xsl:variable>
	<xsl:variable name="level-4-text">сложный</xsl:variable>
	<xsl:variable name="level-5-text">сложный</xsl:variable>
	<!-- In template name="TableOfContents" -->
	<xsl:variable name="tableofcontents-heading">Содержание:</xsl:variable>
	<xsl:variable name="ratethisarticle-heading">Выскажите мнение об этой странице</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">Содержание</xsl:variable>
  <xsl:variable name="inline-comments-heading">Комментарии</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
	<!-- 5.0 05/09 tdc:  Added ratethistutorial-heading -->
	<xsl:variable name="ratethistutorial-heading">Выскажите мнение об этом учебном пособии</xsl:variable>
	<!-- In file "dw-ratingsform-4.1.xsl  -->
	<xsl:variable name="domino-ratings-post-url"></xsl:variable>
	<xsl:variable name="method">POST</xsl:variable>
	<xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/ru/thankyou/</xsl:variable>
	<xsl:variable name="ratings-intro-text">Пожалуйста, найдите минутку и заполните форму, чтобы повысить уровень сервиса.</xsl:variable>
	<xsl:variable name="ratings-question-text">Этот материал был полезен для меня:</xsl:variable>
	<xsl:variable name="ratings-value5-text">Абсолютно согласен (5)</xsl:variable>
	<xsl:variable name="ratings-value4-text">Согласен (4)</xsl:variable>
	<xsl:variable name="ratings-value3-text">Нейтрален (3)</xsl:variable>
	<xsl:variable name="ratings-value2-text">Не согласен (2)</xsl:variable>
	<xsl:variable name="ratings-value1-text">Абсолютно не согласен (1)</xsl:variable>
	<xsl:variable name="ratings-value5-width">21%</xsl:variable>
	<xsl:variable name="ratings-value4-width">17%</xsl:variable>
	<xsl:variable name="ratings-value3-width">24%</xsl:variable>
	<xsl:variable name="ratings-value2-width">17%</xsl:variable>
	<xsl:variable name="ratings-value1-width">21%</xsl:variable>
	<xsl:variable name="comments-noforum-text">Комментарии?</xsl:variable>
	<!-- 5.5 8/30 llk: added translation text -->
	<xsl:variable name="comments-withforum-text">Пришлите нам свои комментарии или нажмите Обсудить, чтобы поделиться своим мнением с другими</xsl:variable>
	<xsl:variable name="submit-feedback-text">Послать отзыв</xsl:variable>
		<!-- 5.4 4/18 llk:  added site id for jsp ratings database -->
	<xsl:variable name="site_id">40</xsl:variable>
	<!-- in template name="ContentAreaName" -->
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
	      <!-- 5.5 9/7 llk: add for Architecture content area -->
    <xsl:variable name="contentarea-ui-name-ar">Architecture</xsl:variable>
	  <!-- 5.4 3/24 llk: add for AIX content area -->
    <xsl:variable name="contentarea-ui-name-au">AIX и UNIX</xsl:variable>
  <!-- 5.4 3/24 llk: updated identifier for autonomic computing -->
	<xsl:variable name="contentarea-ui-name-ac">Автономные вычисления</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Блоги</xsl:variable>
  <xsl:variable name="contentarea-ui-name-community">Сообщество</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Загрузить (EN)</xsl:variable>
	<xsl:variable name="contentarea-ui-name-gr">Grid-системы</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
	<xsl:variable name="contentarea-ui-name-j">Технология Java</xsl:variable>
	<xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
	<xsl:variable name="contentarea-ui-name-os">Open source</xsl:variable>
	<!-- 5.3 llk:  11/21 - update the ws UI name text -->
	<xsl:variable name="contentarea-ui-name-ws">SOA и web-сервисы</xsl:variable>
	<xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
	<!-- 5.10 11/07 llk: remove components as a content area  dr 2558 -->
	<xsl:variable name="contentarea-ui-name-s">Security</xsl:variable>
	<xsl:variable name="contentarea-ui-name-wa">Web-архитектура</xsl:variable>
	<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
	<xsl:variable name="contentarea-ui-name-i">Sample IT projects</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Облачные вычисления</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
		<!-- 5.4 02/15/06 tdc:  Changed DB2 to Information Management -->
	<xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
	<!-- 5.10 2/15 llk: remove IBM Systems as a content area -->
	<xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
	<xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
	<xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
	<xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
	  <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	  <!-- 5.10 2/18 llk: update power architecture name -->
	<xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
	<xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/views/architecture/libraryview.jsp</xsl:variable>
	<!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
	<xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/ru/views/data/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/ru/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/ru/views/industry/libraryview.jsp</xsl:variable>
 <!-- 5.5.1 10/18 llk: updated view subdirectory to reflect /systems instead of /eserver -->
<!-- 5.10 2/18 llk: remove reference to IBM Systems views; IBM Systems no longer valid content area -->
	<!-- 5.4 3/13 llk: added variable, techlibview-s, for China's use only -->
	<xsl:variable name="techlibview-s"></xsl:variable>
	<xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/views/ibm/articles.jsp</xsl:variable>
	<xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/ru/views/lotus/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/ru/views/rational/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/views/tivoli/library.jsp</xsl:variable>
	<xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/ru/views/websphere/libraryview.jsp</xsl:variable>
		  <!-- 5.4 3/24 llk:  added for AIX content area -->
   <xsl:variable name="techlibview-au">http://www.ibm.com/developerworks/ru/views/aix/libraryview.jsp</xsl:variable>
  <!-- 5.4 3/24 llk:  updated identifier for autonomic computing -->
	<xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/views/autonomic/library.jsp</xsl:variable>
	<xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/views/grid/library.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/ru/views/java/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/ru/views/linux/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/ru/views/opensource/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/views/power/library.jsp</xsl:variable>
	<xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/ru/views/webservices/libraryview.jsp</xsl:variable>
	<xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/views/web/library.jsp</xsl:variable>
	 <!-- 5.10 11/07 llk: remove workplace as a content area  dr 2558 -->
	<!-- 5.10 11/07 llk: remove wireless as a content area  dr 2558 -->
	<xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/ru/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">Следующие шаги</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">События в этой knowledge path</xsl:variable>
  <xsl:variable name="kp-discuss-link">Обсудить эту knowledge path</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-download">Загрузить</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">Слушать</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">Практиковаться</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">Читать</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">Смотреть</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">Серая не отмеченная галочка</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">Зеленая отмеченная галочка</xsl:variable>
  <xsl:variable name="kp-next-step-ui-buy">Купить</xsl:variable>
  <xsl:variable name="kp-next-step-ui-download">Загрузить</xsl:variable>
  <xsl:variable name="kp-next-step-ui-follow">Добавить</xsl:variable>
  <xsl:variable name="kp-next-step-ui-join">Присоединиться</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">Слушать</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">Практиковаться</xsl:variable>
  <xsl:variable name="kp-next-step-ui-read">Читать</xsl:variable>
  <xsl:variable name="kp-next-step-ui-watch">Смотреть</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-discuss">Обсудить</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">Записаться</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">Зарегистрироваться</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">Войдите</xsl:variable> 
  <!-- KP variables: End -->
	  <!-- 5.1 08/02/2005 jpp:  Added variables for product landing page URLs for the ProductsLandingURL template -->
  <!-- In template name="ProductsLandingURL" -->
     <!-- 5.4 3/24 llk: added for AIX content area -->
    <xsl:variable name="products-landing-au">
    <xsl:value-of select="$developerworks-top-url"/>aix/products/</xsl:variable>
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
    <!-- 5.6 12/03/2006 egd: Added variable for  tech library section support search statement (DR 1976) -->
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
   <xsl:variable name="support-search-text-intro">For a comprehensive selection of troubleshooting documents,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">search the IBM technical support knowledge base</xsl:variable> 
	<!-- SUMMARY DOC SECTION HEADINGS -->
	<!-- 5.6 11/16/06 tdc:  Added summary-inThisChat -->
  <xsl:variable name="summary-inThisChat">In this chat</xsl:variable>
	 <!-- 5.5 08/14 fjc add inthisdemo -->  
  <xsl:variable name="summary-inThisDemo">In this demo</xsl:variable>
	<xsl:variable name="summary-inThisTutorial">В этом учебном пособии</xsl:variable>
	<xsl:variable name="summary-inThisLongdoc">В этой статье</xsl:variable>
	<xsl:variable name="summary-inThisPresentation">В этой презентации</xsl:variable>
	<xsl:variable name="summary-inThisSample">В этом примере</xsl:variable>
	<xsl:variable name="summary-inThisCourse">В этом курсе</xsl:variable>
	<xsl:variable name="summary-objectives">Цели</xsl:variable>
	<xsl:variable name="summary-prerequisities">Требуемый опыт</xsl:variable>
	<xsl:variable name="summary-systemRequirements">Системные требования</xsl:variable>
	<xsl:variable name="summary-duration">Продолжительность</xsl:variable>
	<xsl:variable name="summary-audience">Целевая аудитория</xsl:variable>
	<xsl:variable name="summary-languages">Языки</xsl:variable>
	<xsl:variable name="summary-formats">Форматы</xsl:variable>
	<xsl:variable name="summary-minor-heading">Summary minor heading</xsl:variable>
	<xsl:variable name="summary-getTheArticle">Получить статью</xsl:variable>
	<xsl:variable name="summary-getTheWhitepaper">Получить официальный документ</xsl:variable>
	<xsl:variable name="summary-getThePresentation">Получить презентацию</xsl:variable>
	<xsl:variable name="summary-getTheDemo">Получить демо</xsl:variable>
	 <!-- 5.4 4/21 llk: add link to article for rusia translated articles -->
	 <!-- 5.5 8/30 llk: added translation text -->
     <xsl:variable name="summary-linktotheContent">Ссылка на содержимое</xsl:variable>
	<!-- 5.3 12/12/05 tdc:  Added summary-getTheDownload -->
  <xsl:variable name="summary-getTheDownload">Загрузка</xsl:variable>
	<!-- 5.3 12/07/05 tdc:  Added summary-getTheDownloads -->
  <xsl:variable name="summary-getTheDownloads">Загрузки</xsl:variable>
	<xsl:variable name="summary-getTheSample">Получить пример</xsl:variable>
	<xsl:variable name="summary-rateThisContent">Выскажите мнение о содержании</xsl:variable>
	<xsl:variable name="summary-getTheSpecification">Получить спецификацию</xsl:variable>
	<xsl:variable name="summary-contributors">Участники: </xsl:variable>
	<xsl:variable name="summary-aboutTheInstructor">Об инструкторе</xsl:variable>
	<xsl:variable name="summary-aboutTheInstructors">Об инструкторах</xsl:variable>
	<xsl:variable name="summary-viewSchedules">Посмотреть расписания и записаться</xsl:variable>
	<xsl:variable name="summary-viewSchedule">Посмотреть расписание и записаться</xsl:variable>	
	<xsl:variable name="summary-aboutThisCourse">Об этом курсе</xsl:variable>
	<xsl:variable name="summary-webBasedTraining">Web-тренинг</xsl:variable>
	<xsl:variable name="summary-instructorLedTraining">Тренинг под руководством инструктора</xsl:variable>
	<xsl:variable name="summary-classroomTraining">Тренинг в классе</xsl:variable>
	<xsl:variable name="summary-courseType">Тип курса:</xsl:variable>
	<xsl:variable name="summary-courseNumber">Номер курса:</xsl:variable>
	<xsl:variable name="summary-scheduleCourse">Курс</xsl:variable>
	<xsl:variable name="summary-scheduleCenter">Центр обучения</xsl:variable>
	<xsl:variable name="summary-classroomCourse">Курс в классе</xsl:variable>
	<!-- 5.0 5/17 tdc:  Added back summary-onlineInstructorLedCourse -->
	<xsl:variable name="summary-onlineInstructorLedCourse">Онлайновый курс под руководством инструктора</xsl:variable>
	<!-- 5.0 5/17 tdc:  Added back summary-webBasedCourse -->
	<xsl:variable name="summary-webBasedCourse">Web-курс</xsl:variable>
	<!-- 5.0 5/25 fjc:  Added websphere enrollment string-->
	<xsl:variable name="summary-enrollmentWebsphere1">For private offerings of this course, please contact us at </xsl:variable>
	<xsl:variable name="summary-enrollmentWebsphere2"> IBM internal students should enroll via Global Campus.</xsl:variable>
	<!-- 5.0 6/2 fjc add plural-->
	<xsl:variable name="summary-plural">s</xsl:variable>
	  <!-- 5.1 7/22 jpp/egd:  BEGIN Added variables for landing-product work -->
  <!-- in template name="TopStory"  -->
  <!-- 5.5 8/30 llk: added translation text -->
  <xsl:variable name="more-link-text">Еще</xsl:variable>
    <!-- 5.5 09/07/06 jpp-egd: Add product-about-product-heading variable -->
  <!-- in template name="AboutProduct" -->
  <xsl:variable name="product-about-product-heading">About the product</xsl:variable>
  <!-- in template name="ProductTechnicalLibrary"  -->
  <xsl:variable name="product-technical-library-heading">Поиск в технической библиотеке</xsl:variable>
  <xsl:variable name="technical-library-search-text">Введите ключевое слово или оставьте незаполненным, чтобы просмотреть всю библиотеку:</xsl:variable>
  <!-- in template name="ProductInformation"  -->
  <xsl:variable name="product-information-heading">Информация о продукте</xsl:variable>
  <xsl:variable name="product-related-products">Связанные продукты:</xsl:variable>
  <!-- in template name="ProductDownloads"  -->
  <xsl:variable name="product-downloads-heading">Загрузки, CD диски, DVD диски</xsl:variable>
  <!-- in template name="ProductLearningResources"  -->
  <xsl:variable name="product-learning-resources-heading">Ресурсы для обучения</xsl:variable>
  <!-- in template name="ProductSupport"  -->
  <xsl:variable name="product-support-heading">Поддержка</xsl:variable>
  <!-- in template name="ProductCommunity"  -->
  <xsl:variable name="product-community-heading">Сообщество</xsl:variable>
  <!-- in template name="MoreProductInformation"  -->
  <xsl:variable name="more-product-information-heading">Больше информации о продукте</xsl:variable>
  <!-- in template name="Spotlight"  -->
  <!-- Maverick R3 - 05/05/10 llk update variable text per russia request -->
  <xsl:variable name="spotlight-heading">Самое интересное</xsl:variable>
  <!-- in template name="LatestContent"  -->
  <xsl:variable name="latest-content-heading">Последние материалы</xsl:variable>
  <xsl:variable name="more-content-link-text">Больше материалов</xsl:variable>
  <!-- in template name="EditorsPicks"  -->
  <xsl:variable name="editors-picks-heading">Выбор редактора</xsl:variable>
  <!-- in template name="BreadCrumbTitle"  -->
  <xsl:variable name="products-heading">Продукты</xsl:variable>
  <!-- END 5.1 7/22 jpp/egd:  Added variables for landing-product work -->

	<!-- SUMMARY DOC SECTION HEADINGS END -->
	<!-- 5.5 7/6 llk: update text for registration to indicate this is direct link to tutorials (no registration) -->
	<xsl:variable name="summary-register">Перейти к учебному пособию</xsl:variable>
	 <!--5.10 0227 egd add view demo statement for demo summary-->
  <xsl:variable name="summary-view">View the demo</xsl:variable>
	<xsl:variable name="summary-websphereTraining">IBM WebSphere Training and Technical Enablement</xsl:variable>
	  	<!-- 5.0.1 9/19 llk need this to be local site specific in the summary pagse -->
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
	<xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ru/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>

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

	  <!-- 5.0 7/31 tdc:  Added for tutorial PDFs (from Frank's xsl) -->
	  <!-- 5.5 8/30 llk: added translation text -->
  <xsl:variable name="pdfTableOfContents">Содержание</xsl:variable>
  <xsl:variable name="pdfSection">Раздел</xsl:variable>
  <xsl:variable name="pdfSkillLevel">уровень сложности</xsl:variable>
  <!-- 5.4 4/18/06 fjc.  change copyright -->
  <!-- 5.11 12/03/08 egd:  removed the 1994, text until early Jan when we rewrite this -->
  <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. All rights reserved.</xsl:variable>  -->
  <!-- 5.5 8/30 llk: added translation text -->
     <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
  <xsl:variable name="dcRights-v16"><xsl:text>&#169; Copyright&#160;</xsl:text>
	 <xsl:text>IBM Corporation&#160;</xsl:text>
          <xsl:value-of select="//date-published/@year"/>
		<xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="//date-updated/@year" />
		</xsl:if></xsl:variable>
  <!-- 5.5 8/30 llk: added translation text -->
    <xsl:variable name="pdfTrademarks">Торговые марки</xsl:variable>
  <!-- 5.2 8/31 fjc:  Added for tutorial PDFs -->
  <xsl:variable name="pdfResource-list-forum-text">Участвуйте в обсуждении данного материала на форуме.</xsl:variable>
  <!-- 5.2 09/20 fjc:  subscribe to podcast -->
  <xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">Подпишитесь на подкасты developerWorks</xsl:text></xsl:variable>
  			<!-- 5.10 11/07 llk: add about url due to fact that this content is now translated -->
	<xsl:variable name="podcast-about-url">/developerworks/ru/podcast/about.html#subscribe</xsl:variable>

<xsl:variable name="summary-inThisPodcast">В данном подкасте</xsl:variable>
<xsl:variable name="summary-podcastCredits">Список участников подкаста</xsl:variable>
<xsl:variable name="summary-podcast-not-familiar">Незнакомы с подкастингом? <a href=" /developerworks/ru/podcast/about.html">Узнайте больше.</a></xsl:variable>
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[Вам необходимо использовать подкаст-клиент, чтобы автоматически загрузить и синхронизировать файлы для воспроизвеления на Вашем компьютере или мобильном аудиоплеере (например, iPod). <a href="http://www.ipodder.org/" target="_blank">iPodder</a> - бесплатный клиент с открытым исходным кодом, поддерживаемый платформами Mac&#174; OS X, Windows&#174;, и Linux. Вы также можете использовать <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>, или любой другой альтернативный из множества доступных в сети.]]></xsl:text></xsl:variable>
  <xsl:variable name="summary-getThePodcast">Загрузить подкаст</xsl:variable>

  <!-- 5.5 07/14/06 fjc:  need more agenda/ presentation strings-->
  <!-- 5.5 8/30 llk: added translation text -->
  <!-- 5.5.1 10/12/06 fjc: still  need more agenda/ presentation strings-->
  <xsl:variable name="summary-getTheAgenda">Загрузить расписание</xsl:variable>
<xsl:variable name="summary-getTheAgendas">Загрузить расписания</xsl:variable>
<xsl:variable name="summary-getTheAgendaAndPresentation">Загрузить расписание и презентацию</xsl:variable>
<xsl:variable name="summary-getTheAgendaAndPresentations">Загрузить расписание и презентации</xsl:variable>
<xsl:variable name="summary-getTheAgendasAndPresentations">Загрузить расписания и презентации</xsl:variable>
<xsl:variable name="summary-getTheAgendasAndPresentation">Загрузить расписания и презентацию</xsl:variable>
<xsl:variable name="summary-getThePresentations">Загрузить презентации</xsl:variable>
  <!-- 5.5.1 10/12/06 fjc: END still  need more agenda/ presentation strings-->
  <!-- 5.5 8/7 llk: remove extra summary-getThePresentation from this file -->
    <xsl:variable name="summary-getTheWorkshopMaterials">Получите материалы семинара</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Тип: </xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Семинар</xsl:variable>
  <xsl:variable name="summary-inThisEvent">На этом мероприятии</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">На этом семинаре</xsl:variable>
  <xsl:variable name="summary-hostedBy">Размещение: </xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Представленные компании</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Представленная компания</xsl:variable>
  <!-- 5.3 12/07/05 tdc:  Added common-trademarks-text -->
 <!-- 5.4 2/23 llk: updated trademark text with russian text -->
<xsl:variable name="common-trademarks-text">Другая компания, продукт или название услуги могут быть торговыми марками или знаками обслуживания, принадлежащими иным физическим или юридическим лицам.</xsl:variable>
	<!-- 5.5 6/26 llk: added copyright statement per China Legal request-->
<xsl:variable name="copyright-statement">IBM обладает всеми авторскими правами касательно информации, расположенной на developerWorks. Использование информации приведенной на этом ресурсе без явного письменного разрешения от IBM или первоначального автора запрещены. Если Вы желаете использовать информацию с developerWorks, пожалуйста воспользуйтесь регистрационной формой для того, чтобы связаться с нами<a href ="https://www.ibm.com/developerworks/secure/reprintreq.jsp?domain=dwrussia"> запрос на использование материалов developerWorks Россия</a>.</xsl:variable>
  <!-- 5.3 12/14 tdc:  Added aboutTheContributor and aboutTheContributors -->
  <!-- 5.11 8/08 llk: added russian translation as requested by russian team  BEGIN   DR 2893-->
  <xsl:variable name="aboutTheContributor">О докладчике</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">Для отображения текста регистрации должен быть разрешен Javascript.</xsl:variable>
  <xsl:variable name="aboutTheContributors">О докладчиках</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">На данный момент не запланировано ни одного мероприятия. Вернитесь за обновлениями позже.</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">Выберите местонахождение и зарегистрируйтесь</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">Тип: Бизнес-брифинг</xsl:variable>
  <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Тип:</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType -->   
  <!-- 5.7 0325 egd Changed to reflect new briefing name -->
  <xsl:variable name="summary-briefingTechType">Брифинг developerWorks Live!</xsl:variable>
  <!-- 5.4 1/31/06 Flash required -->
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[Для просмотра демонстраций, содержащихся в руководстве, в вашем браузере должен быть разрешен JavaScript и установлен Macromedia Flash Player 6 или более поздней версии. Вы можете загрузить Flash Player последней версии на странице <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text></xsl:variable>
  <!-- 5.11 8/08 llk: added russian translation as requested by russian team  END   DR 2893-->
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
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
  <xsl:variable name="series">Серии</xsl:variable>
  <xsl:variable name="series-view">Больше статей из этой серии</xsl:variable>
<!-- End variables for Trial Program Pages -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
  <xsl:variable name="form-search-in">Поиск в:</xsl:variable>
  <xsl:variable name="form-product-support">Техническая поддержка продукта</xsl:variable>
<xsl:variable name="form-faqs">FAQs</xsl:variable>
  <xsl:variable name="form-product-doc">Документация на продукт</xsl:variable>
  <xsl:variable name="form-product-site">Сайт продукта</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
  <xsl:variable name="show-descriptions-text">Показать описание</xsl:variable>
  <xsl:variable name="hide-descriptions-text">Скрыть описание</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
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
