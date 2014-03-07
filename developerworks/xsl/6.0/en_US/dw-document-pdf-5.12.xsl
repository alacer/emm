<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:redirect="http://xml.apache.org/xalan/redirect" extension-element-prefixes="redirect" exclude-result-prefixes="xsl fo">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
	<!--  5.7 2007-03-22 ibs - DR 2257 to provide dw-xml-file-name parameter.  -->
    <xsl:param name="dw-xml-file-name"></xsl:param>
    <!-- Maverick 6.0 R3 ibs - DR3467.  Parm needed for 6.0 PDF PDF with FOP 1.0 -->
    <xsl:param name="page-name"></xsl:param>
	<!-- Start:  Subordinate stylesheets -->
    <!-- 20110124 ibs DR 3467. File relocated in preparation for 6.0 PDF with FOP 1.0  
           Use 6.0 translated text file -->
<xsl:include href="dw-translated-text-worldwide-6.0.xsl"/>
<!--<xsl:include href="dw-translated-text-vietnam-5.12.xsl"/>-->
<!--<xsl:include href="dw-translated-text-ssa-5.12.xsl"/>-->
<!-- <xsl:include href="dw-translated-text-brazil-5.12.xsl"/> -->
<!--<xsl:include href="dw-translated-text-china-5.12.xsl"/>-->
<!--<xsl:include href="dw-translated-text-korea-5.12.xsl"/>-->
<!-- <xsl:include href="dw-translated-text-russia-5.12.xsl"/> -->
<!--<xsl:include href="dw-translated-text-japan-5.12.xsl"/>-->
    <!-- 20110124 ibs DR 3467. File relocated in preparation for 6.0 PDF with FOP 1.0  
           Some includes now in parent directory. Also use xslt-utilities-6.0.xsl -->
	<xsl:include href="../dw-entities-pdf-5.12.xsl"/>
	<xsl:include href="../xslt-utilities-6.0.xsl"/>
	<xsl:include href="dw-variables-pdf-5.12.xsl"/>
	<xsl:include href="../dw-common-pdf-5.12.xsl"/>
	<xsl:include href="../dw-article-pdf-5.12.xsl"/>
	<xsl:include href="../dw-tutorial-pdf-5.12.xsl"/>
	<!-- End:  Subordinate stylesheets -->
	<!-- START COMMON CODE FOR  CONTENT TYPES -->
	<xsl:template match="/">
	<xsl:apply-templates select="dw-document/dw-article |
									 dw-document/dw-tutorial"/>
	</xsl:template>
</xsl:stylesheet>
