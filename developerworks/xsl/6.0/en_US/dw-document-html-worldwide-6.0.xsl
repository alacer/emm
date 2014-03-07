<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- The following global parameters describe what template output is passed back to the Maverick engine  -->
  <!-- 6.0 Maverick edtools and author package ishields 05/2009: template param should always have preview as the value -->
	 <xsl:param name="template" select=" '' "/>
	 <xsl:param name="transform-zone" select=" '' "/>
  <!-- Call main xsl file and locale-specific xsl files --> 
     <xsl:include href="../dw-document-html-6.0.xsl" />
    <xsl:include href="dw-translated-text-worldwide-6.0.xsl" />
  <!-- IBS 2012-02-06 Moved preview file includes to dw-document-html-sitename-6.0.xsl -->
  <!-- 6.0 Maverick edtools/author package ishields 05/2009:  Added the preview XSLs for each main preview content type -->
  <xsl:include href="dw-article-preview-worldwide-6.0.xsl"/>
  <xsl:include href="dw-sidefile-preview-worldwide-6.0.xsl"/>
  <xsl:include href="dw-dwtop-zoneoverview-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 xM R2.2 jpp-egd 05 23 11:  Removed reference to dw-dwtop-home-preview-worldwide-6.0 -->
  <!-- 6.0 xM R1 10/14/10 jpp: Added home hidef preview xsl -->
  <xsl:include href="dw-dwtop-home-hidef-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R2 10 28 09 egd:  added landing product preview xsl -->
  <xsl:include href="dw-landing-product-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R2 11 11 09 jpp:  added landing generic preview xsl -->
  <xsl:include href="dw-landing-generic-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R2 11 30 09 ibs:  added tutorial preview xsl -->
  <xsl:include href="dw-tutorial-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R3 07/14/10 jpp:  added landing generic pagegroup hidef preview xsl -->
  <xsl:include href="dw-landing-generic-pagegroup-hidef-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R3 07/23/10 jpp:  added landing generic pagegroup preview xsl -->
  <xsl:include href="dw-landing-generic-pagegroup-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R3 08/03/10 jpp:  added trial program pages preview xsl -->
  <xsl:include href="dw-trial-program-pages-preview-worldwide-6.0.xsl"/>
  <!-- 6.0 Maverick R3 08 13 10 egd:  added summary preview xsl -->
  <xsl:include href="dw-summary-preview-worldwide-6.0.xsl"/>
  <!-- xM r2.3 06 29 11 tdc:  added knowledge path preview xsl -->
  <xsl:include href="dw-knowledge-path-preview-worldwide-6.0.xsl"/>
</xsl:stylesheet>
