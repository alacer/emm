<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================
    This stylesheet transforms dw-article document type to
    FO files for later processing into a PDF document by FOP.

    This version written 12 Oct  2006 by Frank Consiglio.
    Brought to you by your friends at developerWorks:
    ibm.com/developerWorks.
    =============================================== -->
<!-- 20110124 ibs DR 3467. File relocated to 6.0 tree in preparation for 6.0 PDF with FOP -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions" xmlns:redirect="http://xml.apache.org/xalan/redirect" extension-element-prefixes="redirect" xmlns:xalan="http://xml.apache.org/xalan">
	<!-- ============================================
    =============================================== -->
	<xsl:template match="dw-document/dw-article">
		<!-- to create one single PDF to fit A4 and Ltr printers comment this code and uncomment out the below 	-->
		<!-- 5.7 3/23: llk add condition so pdf is not created for local sites -->
		<xsl:choose>
			<xsl:when test="/dw-document//@local-site='worldwide'">
		  <!--  5.11 11.10.08 ibs/ddh - DR 2941: Fix PDF generation if no pdf element asks for
		     them and DR 2857:  Remove a4 and letter code from the schemas and stylesheets.  -->
		<!-- to create one single PDF to fit A4 and Ltr printers comment this code and uncomment out the below -->	
		<!-- 5.10 keb 03/07/08:  Adding common size PDF -->
        <redirect:write file="{$dw-xml-file-name}pdf.fo">
			<xsl:call-template name="PageLayout">
				<xsl:with-param name="pageSize">common</xsl:with-param>
			</xsl:call-template>
		</redirect:write>
		</xsl:when>
		<xsl:otherwise />
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
