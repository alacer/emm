<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- PURPOSE:  This is the main dw-document that includes needed xsl files and ww translated text.  Local sites have their own dw-document that imports this dw-document and includes their translated text file -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- Include needed files and declare keys -->
  <xsl:key name="column-icons" match="column-info" use="@col-name"/>
  <xsl:key name="journal-key" match="journal-info" use="normalize-space(@journal-name)"/>
  <!-- Start:  Subordinate stylesheets -->
  <!-- General includes for all doc types:  -->
  <xsl:include href="dw-entities-7.0.xsl"/>
  <xsl:include href="xslt-utilities-7.0.xsl"/>
  <xsl:include href="dw-common-7.0.xsl"/>
  <xsl:include href="dw-home-7.0.xsl"/>
  <!-- Project Defiant jpp 10/10/11: Added include for dw-results XSL -->
  <xsl:include href="dw-results-7.0.xsl"/>
  <!-- Begin processing.  -->
  <xsl:template match="/">
	 <xsl:apply-templates select="*" /> 
  </xsl:template>
  <xsl:template match="dw-document">
        <xsl:choose>
            <xsl:when test="$xform-type='preview' ">
                <xsl:apply-templates select="*">
                    <xsl:with-param name="template" select="$xform-type" />
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*">
                    <xsl:with-param name="template" select="$template" />
                    <xsl:with-param name="transform-zone" select="$transform-zone" />
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  
</xsl:stylesheet>
