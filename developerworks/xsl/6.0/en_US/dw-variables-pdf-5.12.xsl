<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================
    This stylesheet transforms dw-tutorial document type to
    FO files for later processing into a PDF document.

    This version written 21 July  2005 by Frank Consiglio.
    Brought to you by your friends at developerWorks:
    ibm.com/developerWorks.
    =============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions" xmlns:redirect="http://xml.apache.org/xalan/redirect" extension-element-prefixes="redirect" xmlns:xalan="http://xml.apache.org/xalan">
            <!-- 20110124 ibs DR 3467. File relocated in preparation for 6.0 PDF with FOP
                1.0. Preferences file will be custom per local site, so this file needs to
                be in the appropriate local site subdir of xsl dir.
            -->
	<xsl:param name="preferencesFile" select="'dw-pdf-preferences-5.12.xml'"/>
	<!--  The Preferences file holds the fonts, font sizes and spacing, among other things -->
	<xsl:variable name="prefs" select="document($preferencesFile)/preferences"/>
	<!-- Images -->
	<xsl:variable name="ibm-logo-banner" select="$prefs/custom-content-files/ibm-logo-banner"/>
	<xsl:variable name="dw-logo" select="$prefs/custom-content-files/dw-logo"/>
	<!-- Fonts -->
	<xsl:variable name="default-font" select="$prefs/fonts/default-body-font"/>
	<xsl:variable name="default-font-size" select="$prefs/fonts/default-body-font/@size"/>
	<xsl:variable name="title-font" select="$prefs/fonts/title-font"/>
	<xsl:variable name="title-font-size" select="$prefs/fonts/title-font/@size"/>
	<xsl:variable name="header-font" select="$prefs/fonts/header-font"/>
	<xsl:variable name="header-font-size" select="$prefs/fonts/header-font/@size"/>
	<xsl:variable name="footer-font" select="$prefs/fonts/footer-font"/>
	<xsl:variable name="footer-font-size" select="$prefs/fonts/footer-font/@size"/>
	<xsl:variable name="major-heading-font" select="$prefs/fonts/major-heading-font"/>
	<xsl:variable name="major-heading-font-size" select="$prefs/fonts/major-heading-font/@size"/>
	<xsl:variable name="heading-font" select="$prefs/fonts/heading-font"/>
	<xsl:variable name="heading-font-size" select="$prefs/fonts/heading-font/@size"/>
	<xsl:variable name="text-font" select="$prefs/fonts/text-font"/>
	<xsl:variable name="text-font-size" select="$prefs/fonts/text-font/@size"/>
	<xsl:variable name="monospaced-font" select="$prefs/fonts/monospaced-font"/>
	<xsl:variable name="monospaced-font-size" select="$prefs/fonts/monospaced-font/@size"/>
	<xsl:variable name="masthead-font" select="$prefs/fonts/masthead-font"/>
	<xsl:variable name="masthead-font-size" select="$prefs/fonts/masthead-font/@size"/>
	<xsl:variable name="subtitle-font" select="$prefs/fonts/subtitle-font"/>
	<xsl:variable name="subtitle-font-size" select="$prefs/fonts/subtitle-font/@size"/>
	<xsl:variable name="section-title-font" select="$prefs/fonts/section-title-font"/>
	<xsl:variable name="section-title-font-size" select="$prefs/fonts/section-title-font/@size"/>
	<xsl:variable name="sidebar-font" select="$prefs/fonts/sidebar-font"/>
	<xsl:variable name="sidebar-font-size" select="$prefs/fonts/sidebar-font/@size"/>
	<xsl:variable name="table-cell-font" select="$prefs/fonts/table-cell-font"/>
	<xsl:variable name="table-cell-font-size" select="$prefs/fonts/table-cell-font/@size"/>
	<xsl:variable name="code-font" select="$prefs/fonts/code-font"/>
	<xsl:variable name="code-font-size" select="$prefs/fonts/code-font/@size"/>
	<!-- Spacing -->
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
	<!-- tables -->
	<xsl:variable name="section-width" select="$prefs/tables/section-width"/>
	<!-- 5.2 08/25 fjc: make code block width variable  -->
	<xsl:variable name="default-code-width" select="$prefs/tables/code-width"/>
	<xsl:variable name="default-table-width" select="$prefs/tables/table-width"/>
	<xsl:variable name="default-sidebar-width" select="$prefs/tables/sidebar-width"/>
	<xsl:variable name="table-column-width" select="$prefs/tables/table-column-width"/>
	<xsl:variable name="header-width-a" select="$prefs/tables/header-width-a"/>
	<xsl:variable name="header-width-b" select="$prefs/tables/header-width-b"/>
	<xsl:variable name="footer-width-a" select="$prefs/tables/footer-width-a"/>
	<xsl:variable name="footer-width-b" select="$prefs/tables/footer-width-b"/>
	<xsl:variable name="masthead-width" select="$prefs/tables/masthead-width"/>
	<xsl:variable name="masthead-height" select="$prefs/tables/masthead-height"/>
	<!-- Colors   -->
	<xsl:variable name="background-color" select="$prefs/colors/background-color"/>
	<xsl:variable name="foreground-color" select="$prefs/colors/foreground-color"/>
	<xsl:variable name="title-color" select="$prefs/colors/title-color"/>
	<xsl:variable name="subtitle-color" select="$prefs/colors/subtitle-color"/>
	<xsl:variable name="series-color" select="$prefs/colors/series-color"/>
	<xsl:variable name="section-title-color" select="$prefs/colors/section-title-color"/>
	<xsl:variable name="internal-link-color" select="$prefs/colors/internal-link-color"/>
	<xsl:variable name="external-link-color" select="$prefs/colors/external-link-color"/>
	<xsl:variable name="table-th-color" select="$prefs/colors/table-th-color"/>
	<xsl:variable name="table-border-color" select="$prefs/colors/table-border-color"/>
	<xsl:variable name="table-caption-color" select="$prefs/colors/table-caption-color"/>
	<xsl:variable name="code-background-color" select="$prefs/colors/code-background-color"/>
	<xsl:variable name="sidebar-background-color" select="$prefs/colors/sidebar-background-color"/>
</xsl:stylesheet>
