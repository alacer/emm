<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================
    This stylesheet is part of the dW PDF creation process. The variable 
    'prefs' is set elsewhere and contains the contents of an XML preferences 
    file which is customized for each local site. This stylesheet parses the
    contents of the XML preferences file to set variables that are used throughout
    the remainder of the processing.

    This version written 2 February 2011 by Ian Shields.
    Based on a version written 21 July  2005 by Frank Consiglio.
    Brought to you by your friends at developerWorks:
    ibm.com/developerWorks.
    =============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fox="http://xml.apache.org/fop/extensions"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" xmlns:xalan="http://xml.apache.org/xalan">
    <!-- 20110124 ibs DR 3467. File relocated in preparation for 6.0 PDF with FOP
                1.0. Preferences file will be custom per local site, so this file needs to
                be in the appropriate local site subdir of xsl dir.
            -->
    <!-- Images -->
    <xsl:variable name="ibm-logo-banner"
        select="$prefs/custom-content-files/ibm-logo-banner"/>
    <xsl:variable name="dw-logo" select="$prefs/custom-content-files/dw-logo"/>

    <!-- Page size -->
    <xsl:variable name="pageSize" select="$prefs/page-size"/>

    <!-- Fonts -->
    <!-- Heading and title fonts -->
    <!--<xsl:variable name="section-title-font" select="$prefs/fonts/section-title-font"/>-->
    <xsl:variable name="section-title-font-size"
        select="$prefs/fonts/section-title-font/@size"/>
    <!--<xsl:variable name="title-font" select="$prefs/fonts/title-font"/>-->
    <xsl:variable name="title-font-size" select="$prefs/fonts/title-font/@size"/>
    <!--<xsl:variable name="subtitle-font" select="$prefs/fonts/subtitle-font"/>-->
    <xsl:variable name="subtitle-font-size" select="$prefs/fonts/subtitle-font/@size"/>
    <!--  <xsl:variable name="major-heading-font" select="$prefs/fonts/major-heading-font"/>-->
    <xsl:variable name="major-heading-font-size"
        select="$prefs/fonts/major-heading-font/@size"/>
    <!--<xsl:variable name="heading-font" select="$prefs/fonts/heading-font"/>-->
    <xsl:variable name="heading-font-size" select="$prefs/fonts/heading-font/@size"/>
    <!--<xsl:variable name="header-font" select="$prefs/fonts/header-font"/>-->
    <xsl:variable name="header-font-size" select="$prefs/fonts/header-font/@size"/>
    <!--<xsl:variable name="footer-font" select="$prefs/fonts/footer-font"/>-->
    <xsl:variable name="footer-font-size" select="$prefs/fonts/footer-font/@size"/>

    <!-- Body fonts -->

    <xsl:variable name="default-font" select="normalize-space($prefs/fonts/default-font)"/>
    <xsl:variable name="default-font-italic"
        select="normalize-space($prefs/fonts/default-font-italic)"/>
    <xsl:variable name="monospace-font"
        select="normalize-space($prefs/fonts/monospace-font)"/>
    <xsl:variable name="monospace-font-italic"
        select="normalize-space($prefs/fonts/monospace-font-italic)"/>
    <xsl:variable name="default-font-bold"
        select="normalize-space($prefs/fonts/default-font-bold)"/>
    <xsl:variable name="default-font-italic-bold"
        select="normalize-space($prefs/fonts/default-font-italic-bold)"/>
    <xsl:variable name="monospace-font-bold"
        select="normalize-space($prefs/fonts/monospace-font-bold)"/>
    <xsl:variable name="monospace-font-italic-bold"
        select="normalize-space($prefs/fonts/monospace-font-italic-bold)"/>

    <xsl:variable name="default-font-color"
        select="normalize-space($prefs/fonts/default-font/@color)"/>
    <xsl:variable name="default-font-color-italic"
        select="normalize-space($prefs/fonts/default-font-italic/@color)"/>
    <xsl:variable name="monospace-font-color"
        select="normalize-space($prefs/fonts/monospace-font/@color)"/>
    <xsl:variable name="monospace-font-color-italic"
        select="normalize-space($prefs/fonts/monospace-font-italic/@color)"/>
    <xsl:variable name="default-font-color-bold"
        select="normalize-space($prefs/fonts/default-font-bold/@color)"/>
    <xsl:variable name="default-font-color-italic-bold"
        select="normalize-space($prefs/fonts/default-font-italic-bold/@color)"/>
    <xsl:variable name="monospace-font-color-bold"
        select="normalize-space($prefs/fonts/monospace-font-bold/@color)"/>
    <xsl:variable name="monospace-font-color-italic-bold"
        select="normalize-space($prefs/fonts/monospace-font-italic-bold/@color)"/>

    <xsl:variable name="default-font-size" select="$prefs/fonts/default-font/@size"/>

    <!--<xsl:variable name="pre-and-tt-text-font" select="$prefs/fonts/pre-and-tt-text-font"/>-->
    <xsl:variable name="pre-and-tt-text-font-size"
        select="$prefs/fonts/pre-and-tt-text-font/@size"/>
    <xsl:variable name="monospaced-font" select="$prefs/fonts/monospaced-font"/>
    <xsl:variable name="monospaced-font-size" select="$prefs/fonts/monospaced-font/@size"/>
    <xsl:variable name="sidebar-font-size" select="$prefs/fonts/sidebar-font/@size"/>
    <xsl:variable name="code-section-font-size"
        select="$prefs/fonts/code-section-font/@size"/>
    <xsl:variable name="code-inline-font-size"
        select="$prefs/fonts/code-inline-font/@size"/>
    <xsl:variable name="table-cell-font-size" select="$prefs/fonts/table-cell-font/@size"/>
    <!-- 2012-02-27 IBS Handle inline code in tables -->
    <!-- 2012-05-24 IBS Handle code sections and inline code in tables and sidebars -->
    <!-- For now use size computed programatically rather than adding additional things to
    prefs. Note that previous table-cell-monospaced-font didn't use the right prefs value
    anyway. Also note that setting value to empty string ('') will cause font size to not
    be explicitly set, so inheriting size of surrounding fo:block. -->
    <xsl:variable name="table-cell-monospaced-font" select=" '' "/>
    <xsl:variable name="table-cell-code-section-font">
        <!-- Set code section font in tables to be 1pt smaller than regular text in tables -->
        <xsl:variable name="table-cell-text-size">
            <xsl:call-template name="convert-measurement-units-and-round">
                <xsl:with-param name="in-value" select="$table-cell-font-size"/>
                <xsl:with-param name="to-units" select="$to-points"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($table-cell-text-size - 1, $to-points)"/>
    </xsl:variable>
    <xsl:variable name="sidebar-monospaced-font" select=" '' "/>
    <xsl:variable name="sidebar-code-section-font">
        <!-- Set code section font in tables to be 1pt smaller than regular text in
            sidebars. -->
        <xsl:variable name="sidebar-text-size">
            <xsl:call-template name="convert-measurement-units-and-round">
                <xsl:with-param name="in-value" select="$sidebar-font-size"/>
                <xsl:with-param name="to-units" select="$to-points"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($sidebar-text-size - 1, $to-points)"/>
    </xsl:variable>
    <!-- 2012-05-24 IBS end -->
    <!-- Spacing -->
    <xsl:variable name="table-cell-separator" select="$prefs/fonts/list-separator"/>
    <xsl:variable name="list-separator" select="$prefs/fonts/list-separator"/>
    <xsl:variable name="title-space-before" select="$prefs/fonts/title-space-before"/>
    <xsl:variable name="title-space-after" select="$prefs/fonts/title-space-after"/>
    <xsl:variable name="section-space-before" select="$prefs/fonts/section-space-before"/>
    <xsl:variable name="section-space-after" select="$prefs/fonts/section-space-after"/>
    <xsl:variable name="docbody-space-before" select="$prefs/fonts/docbody-space-before"/>
    <xsl:variable name="docbody-space-after" select="$prefs/fonts/docbody-space-after"/>
    <xsl:variable name="heading-space-before" select="$prefs/fonts/heading-space-before"/>
    <xsl:variable name="heading-space-after" select="$prefs/fonts/heading-space-after"/>
    <xsl:variable name="resource-space-before" select="$prefs/fonts/resource-space-before"/>
    <xsl:variable name="resource-space-after" select="$prefs/fonts/resource-space-after"/>
    <xsl:variable name="default-space-before" select="$prefs/fonts/default-space-before"/>
    <xsl:variable name="default-space-after" select="$prefs/fonts/default-space-after"/>
    <xsl:variable name="minimum-space-before" select="$prefs/fonts/minimum-space-before"/>
    <xsl:variable name="minimum-space-after" select="$prefs/fonts/minimum-space-after"/>
    <xsl:variable name="maximum-space-before" select="$prefs/fonts/maximum-space-before"/>
    <xsl:variable name="maximum-space-after" select="$prefs/fonts/maximum-space-after"/>

    <!-- Colors   -->
    <xsl:variable name="background-color" select="$prefs/colors/background-color"/>
    <!--<xsl:variable name="foreground-color" select="$prefs/colors/foreground-color"/>
    <xsl:variable name="title-color" select="$prefs/colors/title-color"/>
    <xsl:variable name="subtitle-color" select="$prefs/colors/subtitle-color"/>-->
    <xsl:variable name="series-color" select="$prefs/colors/series-color"/>
    <!-- <xsl:variable name="section-title-color" select="$prefs/colors/section-title-color"/>-->
    <xsl:variable name="internal-link-color" select="$prefs/colors/internal-link-color"/>
    <xsl:variable name="external-link-color" select="$prefs/colors/external-link-color"/>
    <xsl:variable name="table-th-color" select="$prefs/colors/table-th-color"/>
    <xsl:variable name="table-border-color" select="$prefs/colors/table-border-color"/>
    <xsl:variable name="table-caption-color" select="$prefs/colors/table-caption-color"/>
    <xsl:variable name="code-background-color"
        select="$prefs/colors/code-background-color"/>
    <xsl:variable name="sidebar-background-color"
        select="$prefs/colors/sidebar-background-color"/>
</xsl:stylesheet>
