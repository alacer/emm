<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== -->
    <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
   <!--  Provide local-url-base parameter.  -->
  <xsl:param name="local-url-base">..</xsl:param>
  <!-- Combine author and dwmaster variable definitions into parameter control.  
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
        <xsl:message terminate="yes">Erro! Valor inválido '<xsl:value-of
          select="xform-type" />' para o parâmetro xform-type.</xsl:message>
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
      <xsl:when test="$xform-type = 'final' ">/developerworks/br/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/br/inc/</xsl:when>
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
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/buttons/br/pt/</xsl:variable>
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
  <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/br/views/</xsl:variable>
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
  <!-- v17 Enablement jpp 09/25/2011:  Added web-site-owner variable -->
  <xsl:variable name="web-site-owner">dWbr@br.ibm.com</xsl:variable>
    <!-- START EVENT  ##################################### -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Briefings técnicos</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <xsl:variable name="bctlBusinessPerspectives">Perspectivas de negócios</xsl:variable>
  <xsl:variable name="main-content">ir para o conteúdo principal</xsl:variable>
 
  <!-- ================= END GENERAL VARIABLES =================== -->
<!-- v17 Enablement jpp 09/25/2011:  Removed preview stylesheet calls from this file -->     
  <!-- In template match="/" -->
  <xsl:variable name="Attrib-javaworld">Reimpresso com a permissão da revista <a href="http://www.javaworld.com/?IBMDev">JavaWorld</a>. Copyright IDG.net, uma empresa IDG Communications. Registre-se gratuitamente para receber <a href="http://www.javaworld.com/subscribe?IBMDev">newsletters do JavaWorld por e-mail</a>.
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/14/08: for beta, changed from dw-document ref to dw-article because we moved dw-document contents there -->
   <!-- v17 Enablement jpp 09/25/2011:  Updated stylesheet reference to 7.0 -->
  <xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-7.0.xsl</xsl:variable>
  <xsl:variable name="browser-detection-js-url">http://www-128.ibm.com/developerworks/js/dwcss.js</xsl:variable>
  <xsl:variable name="default-css-url">http://www-128.ibm.com/developerworks/css/r1ss.css</xsl:variable>
  <xsl:variable name="col-icon-subdirectory">/developerworks/br/i/</xsl:variable>
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">This content is part of the</xsl:variable>
  <xsl:variable name="from">De</xsl:variable>
  <xsl:variable name="aboutTheAuthor">Sobre o autor</xsl:variable>
  <xsl:variable name="aboutTheAuthors">Sobre os autores</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
    <xsl:variable name="biography">Biografia</xsl:variable>
  <xsl:variable name="biographies">Biografias</xsl:variable>
  <xsl:variable name="translated-by">Traduzido por:</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">Data:</xsl:variable>
  <xsl:variable name="published">Publicado em:</xsl:variable>
  <xsl:variable name="updated">Atualizado </xsl:variable>
  <xsl:variable name="translated">Translated:</xsl:variable>
  <xsl:variable name="wwpublishdate"></xsl:variable>
  <xsl:variable name="linktoenglish-heading">Também disponível em : </xsl:variable>
  <xsl:variable name="linktoenglish">Inglês</xsl:variable>
  <xsl:variable name="daychar"/>
  <xsl:variable name="monthchar"/>
  <xsl:variable name="yearchar"/>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF:</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
  <xsl:variable name="pdf-alt-letter">Formato do PDF - carta</xsl:variable>
  <xsl:variable name="pdf-alt-a4">Formato do PDF - A4</xsl:variable>
  <xsl:variable name="pdf-alt-common">Formato do PDF - Ajusta-se a A4 e Carta</xsl:variable>
  <xsl:variable name="pdf-text-letter">PDF - Carta</xsl:variable>
  <xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <xsl:variable name="pdf-text-common">PDF - Ajusta-se a A4 e Carta</xsl:variable>
  <xsl:variable name="pdf-page">página</xsl:variable>
  <xsl:variable name="pdf-pages">páginas</xsl:variable> 
 
  <!-- In template name=Document options -->
  <xsl:variable name="document-options-heading">Opções de documento</xsl:variable>
  <!-- In template name="Download" -->
  <xsl:variable name="options-discuss">Discutir</xsl:variable>
  <xsl:variable name="sample-code">Código de amostra</xsl:variable>
  <xsl:variable name="download-heading">Download</xsl:variable>
  <xsl:variable name="downloads-heading">Downloads</xsl:variable>
  <xsl:variable name="download-note-heading">Nota</xsl:variable>
  <xsl:variable name="download-notes-heading">Notas</xsl:variable>
  <xsl:variable name="also-available-heading">Também disponível</xsl:variable>
  <xsl:variable name="download-heading-more">Mais downloads</xsl:variable>
  <xsl:variable name="download-filename-heading">Nome</xsl:variable>
  <xsl:variable name="download-filedescription-heading">Descrição</xsl:variable>
  <xsl:variable name="download-filesize-heading">Tamanho</xsl:variable>
  <xsl:variable name="download-method-heading">Método de download</xsl:variable>
  <xsl:variable name="download-method-link">Informações sobre métodos de download</xsl:variable>
         <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'Figura ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'Tablela ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'Lista ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
  <!-- Variables for content labels -->
  <xsl:variable name="code-sample-label">Código de amostra: </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">pt_BR</xsl:variable>
  <xsl:variable name="demo-label">Demo: </xsl:variable>
  <xsl:variable name="presentation-label">Apresentação: </xsl:variable>
  <xsl:variable name="product-documentation-label">Documentação do produto: </xsl:variable>
  <xsl:variable name="specification-label">Especificação: </xsl:variable>
  <xsl:variable name="technical-article-label">Artigo técnico: </xsl:variable>
  <xsl:variable name="whitepaper-label">Whitepaper: </xsl:variable> 
  
	<!-- Social tagging include -->
	<xsl:variable name="socialtagging-inc">
	<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">Voltar para parte superior</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Voltar para parte superior</a></p>
  </xsl:variable>	
  <!-- Adobe variable -->
  <xsl:variable name="download-get-adobe">
    <xsl:text disable-output-escaping="yes"><![CDATA[Obtenha o Adobe&#174; Reader&#174;]]></xsl:text>
  </xsl:variable>
  <!-- download-path variable not used by worldwide; "en_us" doesn't work if inserted into path.  Kept here so xsl resolves. -->
  <xsl:variable name="download-path">en_us</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/pt_BR/</xsl:variable>
    <xsl:variable name="product-doc-url">
      <a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;">Documentação do produto</a>
  </xsl:variable>
  <xsl:variable name="redbooks-url">
    <a href="http://www.redbooks.ibm.com/">Redbooks IBM</a>
  </xsl:variable>
  <xsl:variable name="tutorials-training-url">
    <a href="/developerworks/training/">Tutoriais e treinamento</a>
  </xsl:variable>
  <xsl:variable name="drivers-downloads-url">
    <a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Downloads de suporte</a>
  </xsl:variable>
  <!-- In template name="Footer" -->
  <!-- Variable reference to a server side include -->
  <xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-footer.inc" -->]]></xsl:text>
  </xsl:variable>
  <!-- Updated for MAVERICK -->
  <!-- in template name="BreadCrumb"  -->
  
  <xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
  <xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/br/</xsl:variable>
  <!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
  <xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
      <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">Itens Técnicos</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/br/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">Downloads e Trials</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/br/downloads/</xsl:variable>
  <xsl:variable name="community-text">Comunidade</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=pt_br</xsl:variable>
  <xsl:variable name="events-text"></xsl:variable>
 <xsl:variable name="events-url"></xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_cont_BR.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_prof_BR.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast_BR.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast2_BR.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast3_BR.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast4_BR.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast5_BR.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
	 <xsl:variable name="contributing-author-alt">nível de autor Contribuidor do developerWorks</xsl:variable>
    <xsl:variable name="professional-author-alt">nível de autor Profissional do developerWorks</xsl:variable>
    <xsl:variable name="master-author-alt">nível de autor Master do developerWorks</xsl:variable>
    <xsl:variable name="master2-author-alt">nível de autor Master 2 do developerWorks</xsl:variable>
    <xsl:variable name="master3-author-alt">nível de autor Master 3 do developerWorks</xsl:variable>
    <xsl:variable name="master4-author-alt">nível de autor Master 4 do developerWorks</xsl:variable>
    <xsl:variable name="master5-author-alt">nível de autor Master 5 do developerWorks</xsl:variable> 
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup --> 
     <xsl:variable name="contributing-author-text">(Um autor Contribuidor do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="professional-author-text">(Um autor Profissional do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master-author-text">(Um autor Master do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master2-author-text">(Um Autor Master Nível 2 do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master3-author-text">(Um Autor Master Nível 3 do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master4-author-text">(Um Autor Master Nível 4 do IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master5-author-text">(Um Autor Master Nível 5 do IBM developerWorks)</xsl:variable>  
 <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/br/data/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/br/cloud/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/br/industry/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/br/java/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/br/linux/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/br/lotus/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/br/opensource/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url"></xsl:variable>
   <xsl:variable name="security-top-url"></xsl:variable>
   <xsl:variable name="autonomic-top-url"></xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/br/rational/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/br/tivoli/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/br/websphere/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/br/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
    <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/br/library/</xsl:variable>
    <xsl:variable name="dw-global-library-text">Mais</xsl:variable>
  <xsl:variable name="technical-library">Biblioteca técnica</xsl:variable>      
  <!-- no longer have www-130, but left this b/c variables not updated in code -->
  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/br/</xsl:variable>
  <!-- in template name="heading"  -->
  <xsl:variable name="figurechar"/>
  <!-- WW site does not use, but need for xsl continuity -->
  <!-- In template name="IconLinks" -->
  <xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
  <xsl:variable name="icon-discuss-alt">Discutir</xsl:variable>
  <xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
  <xsl:variable name="icon-code-download-alt">Download</xsl:variable>
  <xsl:variable name="icon-code-alt">Código</xsl:variable>
  <xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
  <xsl:variable name="Summary">Resumo</xsl:variable>
  <xsl:variable name="english-source-heading"/>
  <!-- lang value.. used in email to friend for dbcs -->
  <xsl:variable name="lang">br</xsl:variable>
  <!-- In template name="Indicators" -->
  <xsl:variable name="level-text-heading">Nível: </xsl:variable>
  <!-- In template name="Masthead" -->
  <!-- topmast-inc in the WW translated text has been TEMPORARILY redefined to have a value of the include for s-topmast14. -->
  <xsl:variable name="topmast-inc">
  <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-topmast.inc" -->]]></xsl:text>
   </xsl:variable>
  <!-- In template name="LeftNav" -->
  <!-- 6.0 Maverick beta egd 06/14/08: Not using for Maverick data, created series and seriesview for series title in Summary area -->
  <xsl:variable name="moreThisSeries">Mais nesta série</xsl:variable>
  <xsl:variable name="left-nav-in-this-article">Neste artigo:</xsl:variable>
  <xsl:variable name="left-nav-in-this-tutorial">Neste tutorial:</xsl:variable>
 
   <!-- In template name="LeftNavSummary" -->
   <xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14-top.inc" -->]]></xsl:text></xsl:variable>
   <xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
   <!-- In template name="LeftNavSummaryInc" -->
   <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text>      </xsl:variable>
  <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
<!--  some left nav inc-->
  <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <!-- In template name="META" -->
  <xsl:variable name="owner-meta-url"> https://www-136.ibm.com/developerworks/secure/feedback.jsp?domain=dwbrazil</xsl:variable>
  <xsl:variable name="dclanguage-content">pt-BR</xsl:variable>
  <xsl:variable name="ibmcountry-content">BR</xsl:variable>
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>
  <!-- In template name="ModeratorBottom -->
  <xsl:variable name="aboutTheModerator">Sobre o moderador</xsl:variable>
  <xsl:variable name="aboutTheModerators">Sobre os moderadores</xsl:variable>
  <!-- In template name="MonthName" -->
  <xsl:variable name="month-1-text">Jan</xsl:variable>
  <xsl:variable name="month-2-text">Fev</xsl:variable>
  <xsl:variable name="month-3-text">Mar</xsl:variable>
  <xsl:variable name="month-4-text">Abr</xsl:variable>
  <xsl:variable name="month-5-text">Mai</xsl:variable>
  <xsl:variable name="month-6-text">Jun</xsl:variable>
  <xsl:variable name="month-7-text">Jul</xsl:variable>
  <xsl:variable name="month-8-text">Ago</xsl:variable>
  <xsl:variable name="month-9-text">Set</xsl:variable>
  <xsl:variable name="month-10-text">Out</xsl:variable>
  <xsl:variable name="month-11-text">Nov</xsl:variable>
  <xsl:variable name="month-12-text">Dez</xsl:variable>
  <!-- In template name="PageNavigator" -->
  <xsl:variable name="page">Página</xsl:variable>
  <xsl:variable name="of">de</xsl:variable>
  <xsl:variable name="pageofendtext"></xsl:variable>
  <xsl:variable name="previoustext">Ir para a página anterior</xsl:variable>
  <xsl:variable name="nexttext">Ir para a próxima página</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">Anterior</xsl:variable>
  <xsl:variable name="next">Próximo</xsl:variable>
  <xsl:variable name="related-content-heading">Conteúdo relacionado: </xsl:variable>
  <xsl:variable name="left-nav-related-links-heading">Links relacionados</xsl:variable>
  <xsl:variable name="left-nav-related-links-techlib">biblioteca técnica</xsl:variable>
  <xsl:variable name="subscriptions-heading">Assinaturas:</xsl:variable>
  <xsl:variable name="dw-newsletter-text">Newsletters do dW</xsl:variable>
  <xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/newsletter/</xsl:variable>
  <xsl:variable name="rational-edge-text">O Rational Edge</xsl:variable>
  <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
  <xsl:variable name="resource-list-heading">Recursos</xsl:variable> 
 
  <!-- In template name="resourcelist/ul" -->
  <xsl:variable name="resource-list-forum-text">
   <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[">Participar do fórum de discussão</a>.]]></xsl:text></xsl:variable>
  <!-- In template "resources" -->
  <xsl:variable name="resources-learn">Aprender</xsl:variable>
  <xsl:variable name="resources-get">Obter produtos e tecnologias</xsl:variable>
  <xsl:variable name="resources-discuss">Discutir</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">Desenvolver habilidades sobre este tema</xsl:variable>
  <xsl:variable name="knowledge-path-text">Este conteúdo é parte de um guia progressivo de capacitação para o aprimoramento de suas habilidades.  Consulte</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">Este conteúdo é parte de um guia de capacitação para o aprimoramento de suas habilidades.  Consulte: </xsl:variable>
  <xsl:variable name="level-1-text">Introdutório</xsl:variable>
  <xsl:variable name="level-2-text">Introdutório</xsl:variable>
  <xsl:variable name="level-3-text">Intermediário</xsl:variable>
  <xsl:variable name="level-4-text">Avançado</xsl:variable>
  <xsl:variable name="level-5-text">Avançado</xsl:variable>
  <xsl:variable name="tableofcontents-heading">Conteúdo:</xsl:variable>
  <xsl:variable name="ratethisarticle-heading">Avalie esta página</xsl:variable>
  
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">Índice</xsl:variable>
  <xsl:variable name="inline-comments-heading">Comentários</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
  <!-- Ratings -->
  <xsl:variable name="ratethistutorial-heading">Avalie este tutorial</xsl:variable>
   <xsl:variable name="domino-ratings-post-url">http://www.alphaworks.ibm.com/developerworks/ratings.nsf/RateArticle?CreateDocument</xsl:variable>
  <xsl:variable name="method">POST</xsl:variable>
  <xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/br/thankyou/feedback-thankyou.html</xsl:variable>
  <xsl:variable name="ratings-intro-text">Reserve um momento para preencher este formulário para ajudar-nos a atendê-lo melhor.</xsl:variable>
  <xsl:variable name="ratings-question-text">Este conteúdo foi útil para mim:</xsl:variable>
  <xsl:variable name="ratings-value5-text">Concordo plenamente (5)</xsl:variable>
  <xsl:variable name="ratings-value4-text">Concordo (4)</xsl:variable>
  <xsl:variable name="ratings-value3-text">Neutro (3)</xsl:variable>
  <xsl:variable name="ratings-value2-text">Discordo (2)</xsl:variable>
  <xsl:variable name="ratings-value1-text">Discordo plenamente (1)</xsl:variable>  
  <xsl:variable name="ratings-value5-width">21%</xsl:variable>
  <xsl:variable name="ratings-value4-width">17%</xsl:variable>
  <xsl:variable name="ratings-value3-width">24%</xsl:variable>
  <xsl:variable name="ratings-value2-width">17%</xsl:variable>
  <xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <xsl:variable name="comments-noforum-text">Comentários?</xsl:variable>
  <xsl:variable name="comments-withforum-text">Envie-nos seus comentários ou clique em Discutir para compartilhar
    seus comentários com outras pessoas.</xsl:variable>
  <xsl:variable name="submit-feedback-text">Enviar feedback</xsl:variable>
 
  <xsl:variable name="site_id">80</xsl:variable>
  <!-- in template name="ContentAreaName" and "ContentAreaNameExtended"-->
  <!-- 6.0 Maverick beta egd 06/12/08: Using contentarea-ui-names unchanged to create part of bct -->
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ar">Arquitetura</xsl:variable>
  <xsl:variable name="contentarea-ui-name-au">AIX e UNIX</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ac">Computação autônoma</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Blogs</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-community">Community</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Downloads</xsl:variable>
  <xsl:variable name="contentarea-ui-name-gr">Computação em Grade</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
  <xsl:variable name="contentarea-ui-name-j">Tecnologia Java</xsl:variable>
  <xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
  <xsl:variable name="contentarea-ui-name-os">Software livre</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ws">SOA e serviços da web</xsl:variable>
  <xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
  <xsl:variable name="contentarea-ui-name-s">Segurança</xsl:variable>
  <xsl:variable name="contentarea-ui-name-wa">Desenvolvimento da Web</xsl:variable>
  <xsl:variable name="contentarea-ui-name-i">Projetos de TI de amostra</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
  <xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
  <xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
  <xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
  <xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
  <xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
  <xsl:variable name="contentarea-ui-name-pa">Aceleração multicore</xsl:variable>  
  

  <!-- in template name="TechLibView" -->
  <!-- 6.0 Maverick beta egd 06/12/08: Using techlibview unchanged to create part of bct -->
   <!-- 5.11 10/29/2008 llk:  replace db2 with data DR #2993 -->
  <xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/br/views/data/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/br/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/br/views/industry/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/br/views/architecture/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-s"></xsl:variable>
  <xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/br/views/ibm/articles.jsp</xsl:variable>
  <xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/br/views/lotus/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/br/views/rational/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/br/views/tivoli/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/br/views/websphere/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-au">http://www.ibm.com/developerworks/br/views/aix/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/br/views/autonomic/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/br/views/grid/libraryview.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/br/views/java/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/br/views/linux/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/br/views/opensource/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/br/views/power/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/br/views/webservices/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/br/views/web/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/br/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">Próximas etapas</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">Atividades neste sentido</xsl:variable>
  <xsl:variable name="kp-discuss-link">Discutir este guia de capacitação</xsl:variable>
     <xsl:variable name="kp-resource-type-ui-download">Download</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">Ouça</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">Pratique</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">Leia</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">Acompanhe</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">Marcador de verificação em cinza ( não verificado )</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">Marcador de verificação em verde</xsl:variable>
  <xsl:variable name="kp-next-step-ui-buy">Comprar</xsl:variable>
   <xsl:variable name="kp-next-step-ui-download">Download</xsl:variable>
  <xsl:variable name="kp-next-step-ui-follow">Siga</xsl:variable>
  <xsl:variable name="kp-next-step-ui-join">Participe</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">Ouça</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">Pratique</xsl:variable>
   <xsl:variable name="kp-next-step-ui-read">Leia</xsl:variable>
  <xsl:variable name="kp-next-step-ui-watch">Acompanhe</xsl:variable>
  <xsl:variable name="kp-next-step-ui-discuss">Discuta</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">Inscreva-se</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">Registre-se</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">Enviar</xsl:variable> 
  <!-- KP variables: End -->
  <!-- In template name="ProductsLandingURL" -->
  <xsl:variable name="products-landing-au">
    <xsl:value-of select="$developerworks-top-url"/>aix/products/</xsl:variable>
  <xsl:variable name="products-landing-db2">
    <xsl:value-of select="$developerworks-top-url"/>data/products/</xsl:variable>
   <xsl:variable name="products-landing-lo">
    <xsl:value-of select="$developerworks-top-url"/>lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r">
    <xsl:value-of select="$developerworks-secondary-url"/>rational/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv">
    <xsl:value-of select="$developerworks-top-url"/>tivoli/products/</xsl:variable>
  <xsl:variable name="products-landing-web">
    <xsl:value-of select="$developerworks-top-url"/>websphere/products/</xsl:variable>
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
  
  <xsl:variable name="support-search-text-intro">Para uma seleção abrangente de documentos de resolução de problemas,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">procure na base de conhecimento de suporte técnico da IBM</xsl:variable> 
  <xsl:variable name="summary-inThisChat">Neste bate-papo</xsl:variable>
  <xsl:variable name="summary-inThisDemo">Nesta demo</xsl:variable>
  <xsl:variable name="summary-inThisTutorial">Neste tutorial</xsl:variable>
  <xsl:variable name="summary-inThisLongdoc">Neste artigo</xsl:variable>
  <xsl:variable name="summary-inThisPresentation">Nesta apresentação</xsl:variable>
  <xsl:variable name="summary-inThisSample">Nesta amostra</xsl:variable>
  <xsl:variable name="summary-inThisCourse">Neste curso</xsl:variable>
  <xsl:variable name="summary-objectives">Objetivos</xsl:variable>
  <xsl:variable name="summary-prerequisities">Pré-requisitos</xsl:variable>
  <xsl:variable name="summary-systemRequirements">Requisitos do sistema</xsl:variable>
  <xsl:variable name="summary-duration">Duração</xsl:variable>
  <xsl:variable name="summary-audience">Público-alvo</xsl:variable>
  <xsl:variable name="summary-languages">Idiomas</xsl:variable>
  <xsl:variable name="summary-formats">Formatos</xsl:variable>
  <xsl:variable name="summary-minor-heading">Título menor do resumo</xsl:variable>
  <xsl:variable name="summary-getTheArticle">Obter o artigo</xsl:variable>
  <xsl:variable name="summary-getTheWhitepaper">Obter o whitepaper</xsl:variable>
  <xsl:variable name="summary-getThePresentation">Obter a apresentação</xsl:variable>
  <xsl:variable name="summary-getTheDemo">Obter a demo</xsl:variable>
  <xsl:variable name="summary-linktotheContent">Link para o conteúdo</xsl:variable>
  <xsl:variable name="summary-getTheDownload">Obter o download</xsl:variable>
  <xsl:variable name="summary-getTheDownloads">Obter os downloads</xsl:variable>
  <xsl:variable name="summary-getTheSample">Obter a amostra</xsl:variable>
  <xsl:variable name="summary-rateThisContent">Avaliar este conteúdo</xsl:variable>
  <xsl:variable name="summary-getTheSpecification">Obter a especificação</xsl:variable>
  <xsl:variable name="summary-contributors">Contribuidores: </xsl:variable>
  <xsl:variable name="summary-aboutTheInstructor">Sobre o instrutor</xsl:variable>
  <xsl:variable name="summary-aboutTheInstructors">Sobre os instrutores</xsl:variable>
  <xsl:variable name="summary-viewSchedules">Visualizar programações e inscrever-se</xsl:variable>
  <xsl:variable name="summary-viewSchedule">Visualizar programação e inscrever-se</xsl:variable>
  <xsl:variable name="summary-aboutThisCourse">Sobre este curso</xsl:variable>
  <xsl:variable name="summary-webBasedTraining">Treinamento baseado na Web</xsl:variable>
  <xsl:variable name="summary-instructorLedTraining">Treinamento conduzido por instrutor</xsl:variable>
  <xsl:variable name="summary-classroomTraining">Treinamento em sala de aula</xsl:variable>
  <xsl:variable name="summary-courseType">Tipo de Curso:</xsl:variable>
  <xsl:variable name="summary-courseNumber">Número do Curso:</xsl:variable>
  <xsl:variable name="summary-scheduleCourse">Curso</xsl:variable>
  <xsl:variable name="summary-scheduleCenter">Centro de Educação</xsl:variable>
  <xsl:variable name="summary-classroomCourse">Curso em sala de aula</xsl:variable>
  <xsl:variable name="summary-onlineInstructorLedCourse">Curso conduzido por instrutor on-line</xsl:variable>
  <xsl:variable name="summary-webBasedCourse">Curso baseado na Web</xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere1">Para ofertas particulares deste curso, entre em contato no </xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere2">. Estudantes estagiários da IBM devem inscrever-se através do Global Campus.</xsl:variable>  
  <xsl:variable name="summary-plural">s</xsl:variable>
  <!-- SUMMARY DOC SECTION HEADINGS END -->
  <!-- other summary variables -->
  <xsl:variable name="summary-register">Registre-se agora ou efetue login utilizando seu ID e senha IBM</xsl:variable>
  <xsl:variable name="summary-view">Visualizar a demo</xsl:variable>
  <xsl:variable name="summary-websphereTraining">Treinamento e Capacitação Técnica IBM WebSphere</xsl:variable>
  
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/br/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
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
  
  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>
  <xsl:variable name="more-link-text">Mais</xsl:variable>
  <xsl:variable name="product-about-product-heading">Sobre o produto</xsl:variable>
  <xsl:variable name="product-technical-library-heading">Procurar na biblioteca técnica</xsl:variable>
  <xsl:variable name="technical-library-search-text">Digite a palavra-chave ou deixe o campo em branco para visualizar
    a biblioteca técnica inteira:</xsl:variable>
  <xsl:variable name="product-information-heading">Informações do produto</xsl:variable>
  <xsl:variable name="product-related-products">Produtos relacionados:</xsl:variable>
  <xsl:variable name="product-downloads-heading">Downloads, CDs, DVDs</xsl:variable>
  <xsl:variable name="product-learning-resources-heading">Recursos de aprendizado</xsl:variable>
  <xsl:variable name="product-support-heading">Suporte</xsl:variable>
  <xsl:variable name="product-community-heading">Comunidade</xsl:variable>
  <xsl:variable name="more-product-information-heading">Mais informações do produto</xsl:variable>
  <xsl:variable name="spotlight-heading">Destaque</xsl:variable>
  <xsl:variable name="latest-content-heading">Conteúdo mais recente</xsl:variable>
  <xsl:variable name="more-content-link-text">Mais conteúdo</xsl:variable>
  <xsl:variable name="editors-picks-heading">Seleções do editor</xsl:variable>
  <xsl:variable name="products-heading">Produtos</xsl:variable>
  <xsl:variable name="pdfTableOfContents">Índice</xsl:variable>
  <xsl:variable name="pdfSection">Seção</xsl:variable>
  <xsl:variable name="pdfSkillLevel">Nível de Habilidade</xsl:variable>
  <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. Todos os direitos reservados.</xsl:variable> -->
  <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
    exists-->
  <xsl:variable name="dcRights-v16"><xsl:text>&#169; Copyright&#160;</xsl:text>
    <xsl:text>IBM Corporation&#160;</xsl:text>
    <xsl:value-of select="//date-published/@year"/>
    <xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
      <xsl:text>,&#160;</xsl:text>
      <xsl:value-of select="//date-updated/@year" />
    </xsl:if> <xsl:text>. All rights reserved.</xsl:text></xsl:variable>
  <xsl:variable name="pdfTrademarks">Marcas Registradas</xsl:variable>
  <xsl:variable name="pdfResource-list-forum-text">Participar do fórum de discussão para este conteúdo.</xsl:variable>
  <xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">Assinar podcasts do developerWorks</xsl:text></xsl:variable>
  <xsl:variable name="podcast-about-url">/developerworks/podcast/about.html#subscribe</xsl:variable>
  <xsl:variable name="summary-inThisPodcast">Neste podcast</xsl:variable>
  <xsl:variable name="summary-podcastCredits">Créditos do podcast</xsl:variable>
  <xsl:variable name="summary-podcast-not-familiar">Não está familiarizado com o podcasting? <a href=" /developerworks/podcast/about.html">Saiba mais.</a></xsl:variable>
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[Para fazer download e sincronizar os arquivos automaticamente para reprodução em seu computador ou seu reprodutor de áudio portátil
(por exemplo, iPod), será necessário utilizar um cliente de podcast. O <a href="http://www.ipodder.org/" target="_blank">iPodder</a>
é um cliente de software livre que está disponível para Mac&#174; OS X, Windows&#174; e Linux. Você também pode utilizar
o <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, o <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>
ou qualquer uma das muitas alternativas disponíveis na Web.]]></xsl:text></xsl:variable>
  <xsl:variable name="summary-getThePodcast">Obter o podcast</xsl:variable>
  <xsl:variable name="summary-getTheAgenda">Obter a agenda</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">Obter as agendas</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">Obter a agenda e a apresentação</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">Obter a agenda e as apresentações</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">Obter as agendas e as apresentações</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">Obter as agendas e a apresentação</xsl:variable>
  <xsl:variable name="summary-getThePresentations">Obter as apresentações</xsl:variable>
  <xsl:variable name="summary-getTheWorkshopMaterials">Obter os materiais de workshop</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Tipo: </xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Briefing técnico</xsl:variable>
  <xsl:variable name="summary-inThisEvent">Neste evento</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">Neste workshop</xsl:variable>
  <xsl:variable name="summary-hostedBy">Hospedado por: </xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Empresas representadas</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Empresa representada</xsl:variable>
  <xsl:variable name="common-trademarks-text">Outros nomes de empresas, produtos e serviços podem ser
    marcas registradas ou marcas de serviço de terceiros.</xsl:variable>
  <xsl:variable name="copyright-statement"></xsl:variable>
  <xsl:variable name="aboutTheContributor">Sobre o contribuidor</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">O Javascript é necessário para exibir o texto de registro.</xsl:variable>
  <xsl:variable name="aboutTheContributors">Sobre os contribuidores</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">Atualmente, não há eventos planejados. Verifique aqui para saber se há atualizações.</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">Selecione o local e o registro</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">Tipo: Briefing de Negócios</xsl:variable>
  <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Tipo:</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType -->   
  <xsl:variable name="summary-briefingTechType">developerWorks Live! briefing</xsl:variable>
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[Para visualizar
as demos incluídas neste tutorial, o JavaScript deve ser ativado em seu navegador e o Macromedia Flash Player 6 ou superior deve estar instalado. Você pode fazer download do Flash Player mais recente no endereço <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text></xsl:variable>
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
<!-- 6.0 Maverick R2 11 30 09: Added e006; articles and tut's now have a larger max image width of 580px -->
<xsl:variable name="e006">XML error: The image is not displayed because the width is greater than the maximum of 580 pixels. Please decrease the image width.</xsl:variable> 
    <xsl:variable name="e999">An error has occurred, but no error number was passed to the DisplayError template.  Contact the schema/stylesheet team.</xsl:variable>
<!-- End error message text variables -->
<!-- Variables for Trial Program Pages -->
  <xsl:variable name="ready-to-buy">Pronto para comprar?</xsl:variable>
  <xsl:variable name="buy">Comprar</xsl:variable>
  <xsl:variable name="online">on-line</xsl:variable>
  <xsl:variable name="try-online-register">Registre-se para sua avaliação agora.</xsl:variable>
  <xsl:variable name="download-operatingsystem-heading">Sistema operacional</xsl:variable>
  <xsl:variable name="download-version-heading">Versão</xsl:variable>

<!-- End variables for Trial Program Pages -->
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
  <xsl:variable name="series">Série</xsl:variable>
  <xsl:variable name="series-view">Visualizar mais conteúdo nesta série</xsl:variable>
<!-- End Maverick Series Summary area variables -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
  <xsl:variable name="form-search-in">Procurar em:</xsl:variable>
  <xsl:variable name="form-product-support">Suporte ao produto</xsl:variable>
  <xsl:variable name="form-faqs">FAQs</xsl:variable>
  <xsl:variable name="form-product-doc">Documentação do produto</xsl:variable>
  <xsl:variable name="form-product-site">Site do produto</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
  <xsl:variable name="show-descriptions-text">Mostrar descrições</xsl:variable>
  <xsl:variable name="hide-descriptions-text">Ocultar Descrições</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
<!-- End Maverick Landing Page variables -->
  <xsl:variable name="codeTableSummaryAttribute">Esta tabela contém uma lista de códigos.</xsl:variable>
  <xsl:variable name="downloadTableSummaryAttribute">Esta tabela contém downloads para este documento.</xsl:variable>
  <xsl:variable name="errorTableSummaryAttribute">Esta tabela contém uma mensagem de erro.</xsl:variable>   
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