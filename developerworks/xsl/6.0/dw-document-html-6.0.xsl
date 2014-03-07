<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- PURPOSE:  This is the main dw-document that includes needed xsl files and ww translated text.  Local sites have their own dw-document that imports this dw-document and includes their translated text file -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- Include needed files and declare keys -->
  <xsl:key name="column-icons" match="column-info" use="@col-name"/>
  <!-- 5.11 09/08/08 tdc:  journal-name may have extra whitespace, so use normalize-space  (DR 2667). -->
  <xsl:key name="journal-key" match="journal-info" use="normalize-space(@journal-name)"/>
  <!-- Start:  Subordinate stylesheets -->
  <!-- General includes for all doc types:  -->
  <xsl:include href="dw-entities-6.0.xsl"/>
<!-- xM R2.2 egd 05 10 2011:  Removed include for dw-meta xsl file since it is no longer used for 6.0 -->
  <xsl:include href="xslt-utilities-6.0.xsl"/>
  <xsl:include href="dw-common-6.0.xsl"/>
  <!-- 6.0 Phase 2 021008 jpp/egd: Uncommented article xsl and added sidefile xsl -->
  <xsl:include href="dw-article-6.0.xsl"/>
  <xsl:include href="dw-sidefile-6.0.xsl"/>
  <!-- 6.0 xM R2.2 05 23 11 egd:  Removed include for dw-dwtop-home-6.0 xsl -->
  <!-- 6.0 xM R1 10/14/10 jpp: Added include for home hidef -->
  <xsl:include href="dw-dwtop-home-hidef-6.0.xsl"/>
  <xsl:include href="dw-dwtop-zoneoverview-6.0.xsl"/>
    <!-- xM r2.3 06/30/2011 tdc:  Added knowledge path -->
  <xsl:include href="dw-knowledge-path-6.0.xsl"/>
  <!-- 6.0 Maverick R2 09/30/2009 jpp:  Added generic landing -->
  <xsl:include href="dw-landing-generic-6.0.xsl"/>
  <!-- 6.0 Maverick R3 07/23/2010 jpp:  Added landing pagegroup -->
  <xsl:include href="dw-landing-generic-pagegroup-6.0.xsl"/>
  <!-- 6.0 Maverick R3 08/03/2010 jpp:  Added trial program pages -->
  <xsl:include href="dw-trial-program-pages-6.0.xsl"/>
  <!-- 6.0 Maverick R3 12/16/2009 jpp:  Added landing pagegroup hidef -->
  <xsl:include href="dw-landing-generic-pagegroup-hidef-6.0.xsl"/>
  <!-- 6.0 Maverick R2 08 21 2009 egd:  Added product landing -->
  <xsl:include href="dw-landing-product-6.0.xsl"/>
  <!-- 6.0 Maverick R3 08 13 10 egd:  Added summary -->
  <xsl:include href="dw-summary-6.0.xsl"/>
  <!-- 6.0 Maverick R2 10/05/2009 tdc:  Added tutorial -->
  <xsl:include href="dw-tutorial-6.0.xsl"/>
  <!-- Begin processing.  -->
  <xsl:template match="/">
        <!-- IBS 2012-03-21 BEGIN Check all refnames and such for duplicates. If publication
            date is March 2012 or later, or if preview, then terminate. -->
         <xsl:variable name="dup-names">
            <xsl:call-template name="check-duplicate-names">
                <xsl:with-param name="type" select=" 'check' "/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$dup-names != ''">
            <xsl:call-template name="check-duplicate-names">
                <xsl:with-param name="type" select=" 'message' "/>
            </xsl:call-template>
            <xsl:if test="((//date-published/@year=2012 and
                //date-published/@month&gt;=03) or
                (//date-published/@year&gt;2012) or  ($xform-type='preview'))">
            <xsl:message terminate="yes">Fix errors and try again.</xsl:message>
             </xsl:if>   
        </xsl:if>
        <!-- IBS 2012-03-21 END. Check all refnames and such for duplicates. -->
        <xsl:apply-templates select="*"/>
    </xsl:template>
  <!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing to create previews or finals -->
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
