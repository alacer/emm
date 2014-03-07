<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- The following global parameters describe what template output is passed back to the Maverick engine  -->
	 <xsl:param name="template" select=" 'preview' "/>
	 <xsl:param name="transform-zone" select=" '' "/>
  <!-- Call main xsl file and locale-specific xsl files --> 
     <xsl:include href="../dw-document-html-6.0.xsl" />
    <xsl:include href="dw-translated-text-china-6.0.xsl" />
  <!-- IBS 2012-02-06 Moved preview file includes to dw-document-html-sitename-6.0.xsl -->
  <xsl:template name="dw-home-preview"><xsl:message>Content type not yet supported</xsl:message></xsl:template>
  <xsl:template name="dw-zone-overview-preview"><xsl:message>Content type not yet supported</xsl:message></xsl:template>
  <xsl:template name="dw-dwtop-home-hidef-preview"><xsl:message>Content type not yet supported</xsl:message></xsl:template>
  <xsl:include href="dw-landing-product-preview-china-6.0.xsl"/>
  <xsl:include href="dw-landing-generic-preview-china-6.0.xsl"/>
  <xsl:include href="dw-tutorial-preview-china-6.0.xsl"/>  
  <xsl:include href="dw-article-preview-china-6.0.xsl"/>
  <xsl:include href="dw-sidefile-preview-china-6.0.xsl"/>
  <xsl:include href="dw-landing-generic-pagegroup-preview-china-6.0.xsl"/>
  <xsl:include href="dw-trial-program-pages-preview-china-6.0.xsl"/>
  <xsl:include href="dw-knowledge-path-preview-china-6.0.xsl"/>
  <xsl:template name="dw-landing-generic-pagegroup-hidef-preview"><xsl:message>Content type not yet supported</xsl:message></xsl:template>
    <!-- 6.0 Maverick R3 09 21 10 llk:  added summary preview xsl -->  
<xsl:include href="dw-summary-preview-china-6.0.xsl"/>
  <!-- End of preview additions  -->
</xsl:stylesheet>
