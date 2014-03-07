<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- ================= START FILE PATH VARIABLES =================== -->
  <!-- 5.0 6/14 tdc:  Added variables for file paths to enable Authoring package files -->
  <!-- ** -->
  <!-- START NEW FILE PATHS ################################## -->
  <!-- 5.6 10/27 llk:  added new variable  for ian's scripts -->
  <!-- 5.7 3/20 llk: need new variable to support local sites
 <xsl:variable name="newpath-dw-root-local-ls">/developerworks/ssa/</xsl:variable>
 <xsl:variable name="newpath-dw-root-local-ls">../web/www.ibm.com/developerworks/</xsl:variable> -->

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
        <xsl:message terminate="yes">Error! valor no válido &quot;<xsl:value-of
            select="xform-type"/>&apos; para parámetro del tipo XForm.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' ">/web/www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web-inc">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/ssa/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
        />/web/www.ibm.com/developerworks/ssa/inc</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- 5.7 0326 egd Added this one from Leah's new stem for local sites. -->
  <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/ssa/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
        />/web/www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-ibm-local">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
        />/web/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-protocol">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' ">http://</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <!-- START COMMON INTERMAL AND AUTHOR PACKAGE FILE PATH VARIABLES< ################################## -->
  <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local"
    />inc/</xsl:variable>
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"
    />i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v14/buttons/ar/es/</xsl:variable>
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
  <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"
    />www.ibm.com/i/v16/buttons/</xsl:variable>
  <xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/ssa/views/</xsl:variable>
  <xsl:variable name="path-ibm-stats"><xsl:value-of select="$newpath-protocol"
    />stats.www.ibm.com/</xsl:variable>
  <xsl:variable name="path-ibm-rc-images"><xsl:value-of select="$newpath-protocol"
    />stats.www.ibm.com/rc/images/</xsl:variable>
  <xsl:variable name="path-dw-js"><xsl:value-of select="$newpath-dw-root-web"/>js/</xsl:variable>
  <xsl:variable name="path-dw-email-js"><xsl:value-of select="$newpath-dw-root-web"
    />email/</xsl:variable>
  <xsl:variable name="path-ibm-common-js"><xsl:value-of select="$newpath-protocol"
    />www.ibm.com/common/v14/</xsl:variable>
  <xsl:variable name="path-ibm-common-stats"><xsl:value-of select="$newpath-protocol"
    />www.ibm.com/common/stats/</xsl:variable>
  <xsl:variable name="path-ibm-data-js"><xsl:value-of select="$newpath-protocol"
    />www.ibm.com/data/js/</xsl:variable>
  <xsl:variable name="path-ibm-survey-esites"><xsl:value-of select="$newpath-protocol"
    />www.ibm.com/data/js/survey/esites/</xsl:variable>
  <xsl:variable name="path-ibm-common-css"><xsl:value-of select="$newpath-protocol"
    />www.ibm.com/common/v14/</xsl:variable>
  <!-- ================= END FILE PATH VARIABLES =================== -->
  <!-- ================= START GENERAL VARIABLES =================== -->
  <!-- v17 Enablement jpp 09/24/2011:  Added web-site-owner variable -->
  <xsl:variable name="web-site-owner">devworks@ar.ibm.com</xsl:variable>
  <!-- START EVENT  ##################################### -->
  <!-- 5.5 6/12/06 fjc add  -->
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb">
    <xsl:value-of select="$path-dw-offers"/>
    <xsl:value-of select="$path-dw-techbriefings"/>
  </xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">información técnica</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb">
    <xsl:value-of select="$path-dw-offers"/>
    <xsl:value-of select="$path-dw-businessperspectives"/>
  </xsl:variable>
  <!-- ********************************************* begin translating strings ********************************************** -->
  <xsl:variable name="bctlBusinessPerspectives">Perspectivas de negocios</xsl:variable>
  <xsl:variable name="main-content">ir al contenido principal</xsl:variable>
  <!-- ********************************************* end translating strings ********************************************** -->
  <!-- v17 Enablement jpp 09/24/2011:  Removed preview stylesheet calls from this file -->
  
  <!-- ********************************************* begin translating strings ********************************************** -->
  <xsl:variable name="Attrib-javaworld">Reimpreso con el permiso de <a
      href="http://www.javaworld.com/?IBMDev">JavaWorld magazine</a>. Derechos de autor IDG net, una
    empresa IDG Communications Registrese gratis <a href="http://www.javaworld.com/subscribe?IBMDev"
      >JavaWorld email newsletters</a>.</xsl:variable>
  <!-- ********************************************* end translating strings ********************************************** -->
  <!-- v17 Enablement jpp 09/24/2011:  Updated stylesheet reference to 7.0 -->
  <xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file: dw-document-html-7.0.xsl</xsl:variable>
  <xsl:variable name="browser-detection-js-url">/developerworks/js/dwcss.js</xsl:variable>
  <xsl:variable name="default-css-url">/developerworks/css/r1ss.css</xsl:variable>
  <xsl:variable name="col-icon-subdirectory">/developerworks/ssa/i/</xsl:variable>
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">This content is part of the</xsl:variable>
  <xsl:variable name="from">De</xsl:variable>
  <xsl:variable name="aboutTheAuthor">Sobre el autor</xsl:variable>
  <xsl:variable name="aboutTheAuthors">Sobre los autores</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
   <xsl:variable name="biography">Biography</xsl:variable>
  <xsl:variable name="biographies">Biographies</xsl:variable>
  <xsl:variable name="translated-by">Traducido por:</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">Fecha:</xsl:variable>
  <xsl:variable name="published">Publicado el:</xsl:variable>
  <!-- end 6.0 Maverick beta -->
  <xsl:variable name="updated">Actualizado</xsl:variable>
  <xsl:variable name="translated">Translated:</xsl:variable>
  <xsl:variable name="wwpublishdate"/>
  <xsl:variable name="linktoenglish-heading">Creado originalmente en:</xsl:variable>
  <xsl:variable name="linktoenglish">ingles</xsl:variable>
  <xsl:variable name="daychar"/>
  <xsl:variable name="monthchar"/>
  <xsl:variable name="yearchar"/>
  <!-- ************************************* end translating strings ************************************  -->
  <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF:</xsl:variable>
  <xsl:variable name="pdf-common">A4 and Letter</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
  <xsl:variable name="pdf-alt-letter"> PDF - formato carta</xsl:variable>
  <xsl:variable name="pdf-alt-a4">PDF -formato A4</xsl:variable>
  <xsl:variable name="pdf-alt-common">PDF - formato A4 y Carta</xsl:variable>
  <xsl:variable name="pdf-text-letter">PDF - Carta</xsl:variable>
  <xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <xsl:variable name="pdf-text-common">PDF - Compatible con A4 y Carta</xsl:variable>
  <xsl:variable name="pdf-page">página</xsl:variable>
  <xsl:variable name="pdf-pages">páginas</xsl:variable>

  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="document-options-heading">Opciones de documento</xsl:variable>
  <xsl:variable name="options-discuss">Comentar</xsl:variable>
  <xsl:variable name="sample-code">Código de ejemplo</xsl:variable>
  <xsl:variable name="download-heading">Descargar</xsl:variable>
  <xsl:variable name="downloads-heading">Descargas</xsl:variable>
  <xsl:variable name="download-note-heading">Nota</xsl:variable>
  <xsl:variable name="download-notes-heading">Notas</xsl:variable>
  <xsl:variable name="also-available-heading">También disponible</xsl:variable>
  <xsl:variable name="download-heading-more">Más descargas</xsl:variable>
  <xsl:variable name="download-filename-heading">Nombre</xsl:variable>
  <xsl:variable name="download-filedescription-heading">Descripción</xsl:variable>
  <xsl:variable name="download-filesize-heading">tamaño</xsl:variable>
  <xsl:variable name="download-method-heading">Metodo de descarga</xsl:variable>
  <xsl:variable name="download-method-link">Información sobre métodos de descarga </xsl:variable>
         <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'Figura ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'Tabla ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'Listado ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/>
  <xsl:variable name="code-sample-label">Código de ejemplo: </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">es_AR</xsl:variable>
  <xsl:variable name="demo-label">Demo: </xsl:variable>
  <xsl:variable name="presentation-label">presentación: </xsl:variable>
  <xsl:variable name="product-documentation-label">La documentación del producto </xsl:variable>
  <xsl:variable name="specification-label">Especificacion: </xsl:variable>
  <xsl:variable name="technical-article-label">Artículo técnico: </xsl:variable>
  <xsl:variable name="whitepaper-label">Hoja blanca: </xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->

  <xsl:variable name="socialtagging-inc">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
  </xsl:variable>
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">Volver arriba</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Volver arriba</a></p>
  </xsl:variable>	

  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="download-get-adobe">
    <xsl:text disable-output-escaping="yes"><![CDATA[Get Adobe&#174; Reader&#174;]]></xsl:text>
  </xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="download-path">en_us</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/es_AR/</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="product-doc-url">
    <a
      href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;"
      >Product documentation</a>
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
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-footer.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="developerworks-top-url-nonportal"
    >http://www.ibm.com/developerworks/ssa/</xsl:variable>
    <!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
  <xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
    <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
  <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">Temas Técnicos</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/ssa/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">Descargas</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/ssa/downloads/</xsl:variable>
  <xsl:variable name="community-text">Comunidad</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/?lang=es</xsl:variable>
  <xsl:variable name="events-text"></xsl:variable>
 <xsl:variable name="events-url"></xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_cont_ES.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_prof_ES.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast_ES.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast2_ES.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast3_ES.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast4_ES.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast5_ES.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
<xsl:variable name="contributing-author-alt">Nivel de autor contribuyente en developerWorks</xsl:variable>
<xsl:variable name="professional-author-alt">Nivel de autor profesional en developerWorks</xsl:variable>
<xsl:variable name="master-author-alt">Nivel de autor Master en developerWorks</xsl:variable>
<xsl:variable name="master2-author-alt">Nivel 2 de autor Master en developerWorks</xsl:variable>
<xsl:variable name="master3-author-alt">Nivel 3 de autor Master en developerWorks</xsl:variable>
<xsl:variable name="master4-author-alt">Nivel 4 de autor Master en developerWorks</xsl:variable>
<xsl:variable name="master5-author-alt">Nivel 5 de autor Master en developerWorks</xsl:variable> 
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
  <xsl:variable name="contributing-author-text">(Autor contribuyente de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="professional-author-text">(Autor profecional de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master-author-text">(Autor Master de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master2-author-text">(Autor Master, Nivel 2 de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master3-author-text">(Autor Master, Nivel 3 de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master4-author-text">(Autor Master, Nivel 4 de IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master5-author-text">(Autor Master, Nivel 5 de IBM developerWorks)</xsl:variable>    
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
  <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
  <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
  <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
  <xsl:variable name="grid-top-url"/>
  <xsl:variable name="security-top-url"/>
  <xsl:variable name="autonomic-top-url"/>
  <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
  <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
  <!-- end zone top URLs for Maverick -->
       <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/ssa/library/</xsl:variable>
    <xsl:variable name="dw-global-library-text">Más contenido</xsl:variable>
  <xsl:variable name="technical-library">Biblioteca técnica</xsl:variable>
  <xsl:variable name="developerworks-secondary-url"
    >http://www.ibm.com/developerworks/ssa/</xsl:variable>
  <xsl:variable name="figurechar"/>
  <xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
  <xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
  <xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="icon-discuss-alt">Comentar</xsl:variable>
  <xsl:variable name="icon-code-download-alt">Descarga</xsl:variable>
  <xsl:variable name="icon-code-alt">Código</xsl:variable>
  <xsl:variable name="Summary">Resumen</xsl:variable>
  <xsl:variable name="level-text-heading">Nivel: </xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="english-source-heading"/>
  <xsl:variable name="lang">es</xsl:variable>
  <xsl:variable name="topmast-inc">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-topmast.inc" -->]]></xsl:text>
  </xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="moreThisSeries">Más de esta serie</xsl:variable>
  <xsl:variable name="left-nav-in-this-article">En este artículo:</xsl:variable>
  <xsl:variable name="left-nav-in-this-tutorial">En este tutorial:</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="left-nav-top">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14-top.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-rlinks">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14-rlinks.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-architecture">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-architecture">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-aix">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-aix">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-autonomic">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-autonomic">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-db2">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-db2">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-grid">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-grid">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-ibm">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-java">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-java">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-linux">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-linux">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-lotus">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-lotus">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-opensource">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-opensource">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-power">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-power">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-rational">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-rational">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>

  <!--  5.2 10/03 fjc: add training inc-->
  <xsl:variable name="left-nav-training-rational">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-security">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-tivoli">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-tivoli">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-web">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-web">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-webservices-summary-spec">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-webservices">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-webservices">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-websphere">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-websphere">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <!-- 5.2 10/03 fjc: add training -->
  <xsl:variable name="left-nav-training-websphere">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-xml">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="left-nav-events-xml">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-nav14.inc" -->]]></xsl:text>
  </xsl:variable>

  <xsl:variable name="owner-meta-url">
    https://www-136.ibm.com/developerworks/secure/feedback.jsp?domain=dwssa</xsl:variable>
  <xsl:variable name="dclanguage-content">en-AR</xsl:variable>
  <xsl:variable name="ibmcountry-content">AR</xsl:variable>

  <xsl:variable name="server-s-header-meta">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text>
    <xsl:copy-of select="$newpath-dw-root-web-inc"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="server-s-header-scripts">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text>
    <xsl:copy-of select="$newpath-dw-root-web-inc"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text>
  </xsl:variable>

  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="aboutTheModerator">Acerca del moderador</xsl:variable>
  <xsl:variable name="aboutTheModerators">Acerca de los moderadores</xsl:variable>
  <xsl:variable name="month-1-text">01</xsl:variable>
  <xsl:variable name="month-2-text">02</xsl:variable>
  <xsl:variable name="month-3-text">03</xsl:variable>
  <xsl:variable name="month-4-text">04</xsl:variable>
  <xsl:variable name="month-5-text">05</xsl:variable>
  <xsl:variable name="month-6-text">06</xsl:variable>
  <xsl:variable name="month-7-text">07</xsl:variable>
  <xsl:variable name="month-8-text">08</xsl:variable>
  <xsl:variable name="month-9-text">09</xsl:variable>
  <xsl:variable name="month-10-text">10</xsl:variable>
  <xsl:variable name="month-11-text">11</xsl:variable>
  <xsl:variable name="month-12-text">12</xsl:variable>
  <xsl:variable name="page">Pagina</xsl:variable>
  <xsl:variable name="of">de</xsl:variable>
  <xsl:variable name="pageofendtext"/>
  <xsl:variable name="previoustext">Ir a la página anterior</xsl:variable>
  <xsl:variable name="nexttext">Ir a la página siguiente</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">Anterior</xsl:variable>
  <xsl:variable name="next">Siguiente</xsl:variable>
  <xsl:variable name="related-content-heading">Contenido Relacionado:</xsl:variable>
  <xsl:variable name="left-nav-related-links-heading">Contenido Relacionado:</xsl:variable>
  <xsl:variable name="left-nav-related-links-techlib">biblioteca técnica</xsl:variable>
  <xsl:variable name="subscriptions-heading">Suscripciones:</xsl:variable>
  <xsl:variable name="dw-newsletter-text">Boletines dW</xsl:variable>
  <xsl:variable name="dw-newsletter-url"
    >http://www.ibm.com/developerworks/newsletter/</xsl:variable>
  <xsl:variable name="rational-edge-text">The Rational Edge</xsl:variable>
  <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>
  <xsl:variable name="resource-list-heading">Recursos</xsl:variable>
  <xsl:variable name="resource-list-forum-text">
    <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
    <xsl:value-of select="/dw-document//forum-url/@url"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[">Participar en el foro de debate</a>.]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="resources-learn">Aprender</xsl:variable>
  <xsl:variable name="resources-get">Obtener los productos y tecnologías</xsl:variable>
  <xsl:variable name="resources-discuss">Comentar</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">Desarrolle habilidades de este tema</xsl:variable>
  <xsl:variable name="knowledge-path-text">Este contenido es parte de un knowledge path progresivo para avanzar en sus habilidades. Vea</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">Este contenido es parte de knowledge paths progresivo para avanzar en sus habilidades. Vea:</xsl:variable>
  <xsl:variable name="level-1-text">Introductoria</xsl:variable>
  <xsl:variable name="level-2-text">Introductoria</xsl:variable>
  <xsl:variable name="level-3-text">Intermediaria</xsl:variable>
  <xsl:variable name="level-4-text">Avanzada</xsl:variable>
  <xsl:variable name="level-5-text">Avanzada</xsl:variable>
  <xsl:variable name="tableofcontents-heading">Contenido:</xsl:variable>
  <xsl:variable name="ratethisarticle-heading">Evalúe esta pagina</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">Tabla de contenidos</xsl:variable>
  <xsl:variable name="inline-comments-heading">Comentarios</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
  <xsl:variable name="ratethistutorial-heading">Evalúe este tutorial</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="domino-ratings-post-url"
    >http://www.alphaworks.ibm.com/developerworks/ratings.nsf/RateArticle?CreateDocument</xsl:variable>
  <xsl:variable name="method">POST</xsl:variable>
  <xsl:variable name="ratings-thankyou-url"
    >http://www.ibm.com/developerworks/ssa/thankyou/feedback-thankyou.html</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="ratings-intro-text">Por favor, complete este formulario para ayudarnos a
    servirle mejor.</xsl:variable>
  <xsl:variable name="ratings-question-text">Este contenido es útil para mí:</xsl:variable>
  <xsl:variable name="ratings-value5-text">Sumamente de acuerdo (5)</xsl:variable>
  <xsl:variable name="ratings-value4-text">De acuerdo (4)</xsl:variable>
  <xsl:variable name="ratings-value3-text">Neutro (3)</xsl:variable>
  <xsl:variable name="ratings-value2-text">En desacuerdo (2)</xsl:variable>
  <xsl:variable name="ratings-value1-text">Totalmente en desacuerdo (1)</xsl:variable>

  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="ratings-value5-width">21%</xsl:variable>
  <xsl:variable name="ratings-value4-width">17%</xsl:variable>
  <xsl:variable name="ratings-value3-width">24%</xsl:variable>
  <xsl:variable name="ratings-value2-width">17%</xsl:variable>
  <xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="comments-noforum-text">Comentario?</xsl:variable>
  <xsl:variable name="comments-withforum-text">Envíanos tus comentarios o haga clic en Discutir para
    compartir sus comentarios con los demás.</xsl:variable>
  <xsl:variable name="submit-feedback-text">Enviar comentarios</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="site_id">90</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ar">Arquitetura</xsl:variable>
  <xsl:variable name="contentarea-ui-name-au">AIX and UNIX</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ac">Computación autonómica</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Blogs</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-community">Community</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Downloads</xsl:variable>
  <xsl:variable name="contentarea-ui-name-gr">Computación grid</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
  <xsl:variable name="contentarea-ui-name-j">tecnologia Java</xsl:variable>
  <xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
  <xsl:variable name="contentarea-ui-name-os">Fuentes abiertas</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ws">SOA y servicios web </xsl:variable>
  <xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
  <xsl:variable name="contentarea-ui-name-s">Seguridad</xsl:variable>
  <xsl:variable name="contentarea-ui-name-wa">Desarrollo web</xsl:variable>
  <xsl:variable name="contentarea-ui-name-i">Ejemplo de proyectos de TI</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
  <xsl:variable name="contentarea-ui-name-db2">Information mgmt</xsl:variable>
  <xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
  <xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
  <xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
  <xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
  <xsl:variable name="contentarea-ui-name-pa">Multicore acceleration</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="techlibview-db2"
    >http://www.ibm.com/developerworks/ssa/views/data/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/ssa/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/ssa/views/industry/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ar"
    >http://www.ibm.com/developerworks/ssa/views/architecture/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-s"/>
  <xsl:variable name="techlibview-i"
    >http://www.ibm.com/developerworks/ssa/views/ibm/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-lo"
    >http://www.ibm.com/developerworks/ssa/views/lotus/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-r"
    >http://www.ibm.com/developerworks/ssa/views/rational/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-tiv"
    >http://www.ibm.com/developerworks/ssa/views/tivoli/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-web"
    >http://www.ibm.com/developerworks/ssa/views/websphere/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-au"
    >http://www.ibm.com/developerworks/ssa/views/aix/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ac"
    >http://www.ibm.com/developerworks/ssa/views/autonomic/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-gr"
    >http://www.ibm.com/developerworks/ssa/views/grid/libraryview.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable>
  <xsl:variable name="techlibview-j"
    >http://www.ibm.com/developerworks/ssa/views/java/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-l"
    >http://www.ibm.com/developerworks/ssa/views/linux/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-os"
    >http://www.ibm.com/developerworks/ssa/views/opensource/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-pa"
    >http://www.ibm.com/developerworks/ssa/views/power/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ws"
    >http://www.ibm.com/developerworks/ssa/views/webservices/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-wa"
    >http://www.ibm.com/developerworks/ssa/views/web/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-x"
    >http://www.ibm.com/developerworks/ssa/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">Siguientes pasos</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">Actividades en este path</xsl:variable>
  <xsl:variable name="kp-discuss-link">Discuta este knowledge path</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-download">Descargar</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">Escuchar</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">Practicar</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">Leer</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">Ver</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">Marca gris completa</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">Marca verde completa</xsl:variable>
   <xsl:variable name="kp-next-step-ui-buy">Comprar</xsl:variable>
   <xsl:variable name="kp-next-step-ui-download">Descargar</xsl:variable>
   <xsl:variable name="kp-next-step-ui-follow">Seguir</xsl:variable>
   <xsl:variable name="kp-next-step-ui-join">Unirse</xsl:variable>
  <xsl:variable name="kp-next-step-ui-listen">Escuchar</xsl:variable>
  <xsl:variable name="kp-next-step-ui-practice">Practicar</xsl:variable>
  <xsl:variable name="kp-next-step-ui-read">Leer</xsl:variable>
   <xsl:variable name="kp-next-step-ui-watch">Ver</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-discuss">Discutir</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">Enlistarse</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">Registrarse</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">Enviar</xsl:variable> 
  <!-- KP variables: End -->
  <xsl:variable name="products-landing-au"><xsl:value-of select="$developerworks-top-url"
    />aix/products/</xsl:variable>
  <xsl:variable name="products-landing-db2"><xsl:value-of select="$developerworks-top-url"
    />data/products/</xsl:variable>
  <xsl:variable name="products-landing-lo"><xsl:value-of select="$developerworks-top-url"
    />lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r"><xsl:value-of select="$developerworks-secondary-url"
    />rational/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv"><xsl:value-of select="$developerworks-top-url"
    />tivoli/products/</xsl:variable>
  <xsl:variable name="products-landing-web"><xsl:value-of select="$developerworks-top-url"
    />websphere/products/</xsl:variable>
  <xsl:variable name="support-search-url"
    >http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>

  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="support-search-text-intro">Para una completa selección de documentos de
    solución de problemas,</xsl:variable>
  <xsl:variable name="support-search-text-anchor-link">busque en la base de conocimiento tecnologico
    de la base de suporte de IBM</xsl:variable>
  <xsl:variable name="summary-inThisChat">En este chat</xsl:variable>
  <xsl:variable name="summary-inThisDemo">En este demo</xsl:variable>
  <xsl:variable name="summary-inThisTutorial">En este tutorial</xsl:variable>
  <xsl:variable name="summary-inThisLongdoc">En este articulo</xsl:variable>
  <xsl:variable name="summary-inThisPresentation">En esta presentación</xsl:variable>
  <xsl:variable name="summary-inThisSample">En este ejemplo</xsl:variable>
  <xsl:variable name="summary-inThisCourse">En este curso</xsl:variable>
  <xsl:variable name="summary-objectives">Objetivo</xsl:variable>
  <xsl:variable name="summary-prerequisities">Requisitos previos</xsl:variable>
  <xsl:variable name="summary-systemRequirements">Requisitos del sistema</xsl:variable>
  <xsl:variable name="summary-duration">Duración</xsl:variable>
  <xsl:variable name="summary-audience">Público</xsl:variable>
  <xsl:variable name="summary-languages">Idioma</xsl:variable>
  <xsl:variable name="summary-formats">Formato</xsl:variable>
  <xsl:variable name="summary-minor-heading">Resumen del encabezado</xsl:variable>
  <xsl:variable name="summary-getTheArticle">Obtener el articulo</xsl:variable>
  <xsl:variable name="summary-getTheWhitepaper">Obtener la hoja blanca</xsl:variable>
  <xsl:variable name="summary-getThePresentation">Obtener la presentacion</xsl:variable>
  <xsl:variable name="summary-getTheDemo">Obtener el demo</xsl:variable>
  <xsl:variable name="summary-linktotheContent">Enlace al contenido</xsl:variable>
  <xsl:variable name="summary-getTheDownload">Obtener la descarga</xsl:variable>
  <xsl:variable name="summary-getTheDownloads">Obtener las descargas</xsl:variable>
  <xsl:variable name="summary-getTheSample">Obtener el ejemplo</xsl:variable>
  <xsl:variable name="summary-rateThisContent">Evaluar el contenido</xsl:variable>
  <xsl:variable name="summary-getTheSpecification">Obtener la especificacion</xsl:variable>
  <xsl:variable name="summary-contributors">contribuyente: </xsl:variable>
  <xsl:variable name="summary-aboutTheInstructor"> Sobre el instructor </xsl:variable>
  <xsl:variable name="summary-aboutTheInstructors">Acerca de los instructores</xsl:variable>
  <xsl:variable name="summary-viewSchedules"> Ver horarios y registrarse</xsl:variable>
  <xsl:variable name="summary-viewSchedule"> Ver horarios y registrarse</xsl:variable>
  <xsl:variable name="summary-aboutThisCourse">Acerca de este curso</xsl:variable>
  <xsl:variable name="summary-webBasedTraining">La formación basada en la Web</xsl:variable>
  <xsl:variable name="summary-instructorLedTraining">Instructor de formación</xsl:variable>
  <xsl:variable name="summary-classroomTraining">Entrenamiento en sala de aula</xsl:variable>
  <xsl:variable name="summary-courseType">Tipo de curso:</xsl:variable>
  <xsl:variable name="summary-courseNumber">Número de curso: </xsl:variable>
  <xsl:variable name="summary-scheduleCourse">Course</xsl:variable>
  <xsl:variable name="summary-scheduleCenter">Education Center</xsl:variable>
  <xsl:variable name="summary-classroomCourse">Classroom course</xsl:variable>
  <xsl:variable name="summary-onlineInstructorLedCourse">On-line instructor led
    course</xsl:variable>
  <xsl:variable name="summary-webBasedCourse">Web based course</xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere1">Para las ofertas privadas de este curso, ponerse
    en contacto con nosotros en el </xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere2">. Estudiantes internos de IBM deben registrarse
    a través de Global Campus.</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="summary-plural">s</xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->
  <xsl:variable name="summary-register">Regístrese ahora o entre usando su ID y contraseña
    IBM</xsl:variable>
  <xsl:variable name="summary-view">Vea la demostración</xsl:variable>
  <xsl:variable name="summary-websphereTraining">IBM WebSphere Training and Technical
    Enablement</xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="backlink_include">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-backlink.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="rnav-ratings-link-include">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/ssa/inc/s-rating-content.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="urltactic-script">
    <xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text>
    <xsl:value-of select="$newpath-dw-root-web"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[js/urltactic.js" type="text/javascript"></script><script language="JavaScript" type="text/javascript">
 <!--
 setDefaultQuery(']]></xsl:text>
    <xsl:value-of select="/dw-document//tactic-code-urltactic"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[');
 //-->
</script>
]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="delicious-script">
    <xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="http://del.icio.us/js/playtagger" type="text/javascript"></script>]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="delicious-metrics-script">
    <xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text>
    <xsl:value-of select="$newpath-dw-root-web"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[js/delicious-playtagger-metrics.js" type="text/javascript"></script>]]></xsl:text>
  </xsl:variable>
  <!-- ************************************* begin translating strings ************************************  -->

  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>
  <xsl:variable name="more-link-text">Más</xsl:variable>
  <xsl:variable name="product-about-product-heading">Acerca del producto</xsl:variable>
  <xsl:variable name="product-technical-library-heading">Busqueda en la biblioteca
    técnica</xsl:variable>
  <xsl:variable name="technical-library-search-text">Escribe una palabra clave o deje en blanco para
    ver toda la biblioteca técnica:</xsl:variable>
  <xsl:variable name="product-information-heading">Información del Producto</xsl:variable>
  <xsl:variable name="product-related-products">Contenidos relacionados:</xsl:variable>
  <xsl:variable name="product-downloads-heading">Descargas, CDs, DVDs</xsl:variable>
  <xsl:variable name="product-learning-resources-heading">Recursos de aprendizaje</xsl:variable>
  <xsl:variable name="product-support-heading">Suporte</xsl:variable>
  <xsl:variable name="product-community-heading">Comunidad</xsl:variable>
  <xsl:variable name="more-product-information-heading"> Más información sobre el producto </xsl:variable>
  <xsl:variable name="spotlight-heading">Spotlight</xsl:variable>
  <xsl:variable name="latest-content-heading">Contenido más reciente</xsl:variable>
  <xsl:variable name="more-content-link-text">Más contenido</xsl:variable>
  <xsl:variable name="editors-picks-heading">Elección del Editor</xsl:variable>
  <xsl:variable name="products-heading">Productos</xsl:variable>
  <xsl:variable name="pdfTableOfContents">Tabla de contenidos</xsl:variable>
  <xsl:variable name="pdfSection">Sección</xsl:variable>
  <xsl:variable name="pdfSkillLevel">Nivel de dificultad</xsl:variable>
  <!--  <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2008. Todos los derechos reservados..</xsl:variable>  -->
  <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
  <xsl:variable name="dcRights-v16">
    <xsl:text>&#169; Copyright&#160;</xsl:text>
    <xsl:text>IBM Corporation&#160;</xsl:text>
    <xsl:value-of select="//date-published/@year"/>
    <xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
      <xsl:text>,&#160;</xsl:text>
      <xsl:value-of select="//date-updated/@year"/>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="pdfTrademarks">Marcas</xsl:variable>
  <xsl:variable name="pdfResource-list-forum-text">Participar en el foro de debate para este
    contenido.</xsl:variable>
  <xsl:variable name="download-subscribe-podcasts">
    <xsl:text disable-output-escaping="yes">Suscríbete a developerWorks podcasts</xsl:text>
  </xsl:variable>
  <xsl:variable name="podcast-about-url">/developerworks/podcast/about.html#subscribe</xsl:variable>
  <xsl:variable name="summary-inThisPodcast">En este podcast</xsl:variable>
  <xsl:variable name="summary-podcastCredits">Créditos de podcast</xsl:variable>
  <xsl:variable name="summary-podcast-not-familiar">No familiarizado con el podcasting? <a
      href=" /developerworks/podcast/about.html">Learn more.</a></xsl:variable>
  <xsl:variable name="summary-podcast-system-requirements">
    <xsl:text disable-output-escaping="yes"><![CDATA[Para descargar y sincronizar automáticamente los archivos para reproducir en su ordenador portátil o su reproductor de audio (por ejemplo, el iPod), tendrás que utilizar un cliente de podcast.  <a href="http://www.ipodder.org/" target="_blank"> iPodder </ a> es un cliente libre, de código abierto cliente que está disponible para Mac ® OS X, Windows ® y Linux.  Usted también puede utilizar <a href="http://www.apple.com/itunes/" target="_blank"> iTunes </ a>, <a href = "http://www.feeddemon.com/" target = "_blank"> FeedDemon </ a>, o cualquier número alternativo disponible en la web]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="summary-getThePodcast">Obtener el podcast</xsl:variable>
  <xsl:variable name="summary-getTheAgenda">Obtener la agenda</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">Obtener las agendas</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">Obtener la agenda y la
    presentación</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">Obtener la agenda y las
    presentaciones</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">Obtener la agenda y las
    presentaciones</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">Obtener la agenda y las
    presentaciones</xsl:variable>
  <xsl:variable name="summary-getThePresentations">Obtener la presentación</xsl:variable>
  <xsl:variable name="summary-getTheWorkshopMaterials">Obtener los materiales del
    taller</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Tipo: </xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Información técnica</xsl:variable>
  <xsl:variable name="summary-inThisEvent">En este evento</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">En este taller</xsl:variable>
  <xsl:variable name="summary-hostedBy">Organizado por: </xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Empresas representadas</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Empresas representadas</xsl:variable>
  <xsl:variable name="common-trademarks-text">Otras compañías, productos o nombres de servicios
    pueden ser marcas comerciales o marcas de servicio de los demás</xsl:variable>
  <xsl:variable name="copyright-statement"/>
  <xsl:variable name="aboutTheContributor">Acerca del contribuyente</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">Se necesita Javascript para mostrar el registro de
    texto.</xsl:variable>
  <xsl:variable name="aboutTheContributors">Acerca del los contribuyentes</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">Actualmente, no hay eventos programados. Chequear
    aquí para actualizaciones..</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">Seleccione la ubicación y registro</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">Tipo: Presentación de información de
  negocios</xsl:variable>
   <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Tipo:</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType --> 
   <xsl:variable name="summary-briefingTechType">Información developerWorks Live! </xsl:variable>
  <xsl:variable name="flash-requirement">
    <xsl:text disable-output-escaping="yes"><![CDATA[Para ver los demos incluidos en este tutorial, JavaScript debe estar habilitado en su navegador y Macromedia Flash Player 6 o superior debe estar instalado. Usted puede descargar la última versión de Flash Player en <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text>
  </xsl:variable>
  <!-- ************************************* end translating strings ************************************  -->
  <xsl:variable name="max-code-line-length" select="90"/>
  <xsl:variable name="code-ruler"
    select=" '-------10--------20--------30--------40--------50--------60--------70--------80--------90-------100'     "/>
  <xsl:variable name="list-indent-chars" select="5"/>
  <xsl:variable name="tab-stop-width" select="8"/>
  <!-- Add 5.10 variables end -->
  <!-- 5.4 02/20/06 tdc:  Start error message text variables -->
  <xsl:variable name="e001">|-------- XML error: La línea anterior es más larga que 90 caracteres
    ---------|</xsl:variable>
  <xsl:variable name="e002">error XML: Por favor, introduzca un valor para el atributo del autor del
    elemento, o el nombre de la empresa elemento, o ambos.</xsl:variable>
  <xsl:variable name="e003">|-------- XML error: La imagen no se muestra porque la anchura es mayor
    que el máximo de 572 píxeles. Por favor, disminuir el ancho de la imagen..</xsl:variable>
  <xsl:variable name="e004">|-------- XML error: La imagen no se muestra porque la anchura es mayor
    que el máximo de 500 píxeles. Por favor, disminuir el ancho de la imagen..</xsl:variable>
  <!-- 5.5.1 10/13/06 tdc:  New e005 warning message for cma-defined author info -->
  <xsl:variable name="e005">Advertencia: El &lt;cma-defined&gt; fue ingresado en lugar del
    subelemento de autor relacionados y atributos. Usted puede mantener el subelemento
    &lt;cma-defined&gt; y asignar otro autor a través de la CMA, o sustituir el subelemento
    &lt;cma-defined&gt; por un autor estandar y sus subelementos y
    atributos..</xsl:variable>
    <!-- 6.0 Maverick R2 11 30 09: Added e006; articles and tut's now have a larger max image width of 580px -->
<xsl:variable name="e006">XML error: The image is not displayed because the width is greater than the maximum of 580 pixels. Please decrease the image width.</xsl:variable> 
  <xsl:variable name="e999">Se ha producido un error, pero no el número de error se pasó a la
    plantilla DisplayError. Póngase en contacto con el schema / equipo de estilos.</xsl:variable>
  <!-- End error message text variables -->
  <!-- 5.5 08/24/06 jpp-egd:  Start variables for Trial Program Pages -->
  <xsl:variable name="ready-to-buy">Listo para comprar</xsl:variable>
  <xsl:variable name="buy">Comprar</xsl:variable>
  <xsl:variable name="online">online</xsl:variable>
  <xsl:variable name="try-online-register">Regístrese para su periodo de evaluación.</xsl:variable>
  <xsl:variable name="download-operatingsystem-heading">Sistema operativo</xsl:variable>
  <xsl:variable name="download-version-heading">Versión</xsl:variable>
  <!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
  <!-- in template named SeriesTitle -->
   <xsl:variable name="series">Series</xsl:variable>
  <xsl:variable name="series-view">Ver más contenido de esta serie</xsl:variable>
  <!-- End Maverick Series Summary area variables -->
  <!-- Start Maverick Landing Page Variables -->
  <!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
  <xsl:variable name="form-search-in">Buscar en:</xsl:variable>
  <xsl:variable name="form-product-support">Soporte de producto</xsl:variable>
  <xsl:variable name="form-faqs">FAQs</xsl:variable>
  <xsl:variable name="form-product-doc">Documentación de producto</xsl:variable>
  <xsl:variable name="form-product-site">Sitio del producto</xsl:variable>
  <!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
  <xsl:variable name="ajax-dwhome-popular-forums">
    <xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text>
  </xsl:variable>
  <!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
  <!-- 6.0 Maverick llk - added additional variables for local site use -->
  <xsl:variable name="publish-schedule"/>
  <xsl:variable name="show-descriptions-text">Mostrar descripciones</xsl:variable>
  <xsl:variable name="hide-descriptions-text">Esconder descripciones</xsl:variable>
  <xsl:variable name="try-together-text">Try together</xsl:variable>
  <xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
  <!-- End Maverick Landing Page variables -->
  <!-- End variables for Trial Program Pages -->
  <xsl:variable name="codeTableSummaryAttribute">Esta tabla contiene una lista de códigos.</xsl:variable>
  <xsl:variable name="downloadTableSummaryAttribute">Esta tabla contiene descargas para este documento.</xsl:variable>
  <xsl:variable name="errorTableSummaryAttribute">Esta tabla contiene un mensaje de error.</xsl:variable> 
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
