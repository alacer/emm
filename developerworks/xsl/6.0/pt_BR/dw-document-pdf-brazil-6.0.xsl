<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">

    <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>

    <!--  The Preferences file holds the fonts, font sizes and spacing, among other things -->
    <xsl:param name="preferencesFile" select="'dw-pdf-preferences-brazil-6.0.xml'"/>
    <!-- Assign the contents of the preferences file to the prefs variable. -->
    <xsl:variable name="prefs" select="document($preferencesFile)/preferences"/>

    <xsl:param name="dw-xml-file-name"/>
    <!-- Start:  Subordinate stylesheets -->
    <xsl:include href="dw-translated-text-brazil-6.0.xsl"/>
    <xsl:include href="../dw-entities-pdf-6.0.xsl"/>
    <xsl:include href="../xslt-utilities-6.0.xsl"/>
    <xsl:include href="../dw-variables-pdf-6.0.xsl"/>
    <xsl:include href="../dw-common-pdf-6.0.xsl"/>
    <!-- End:  Subordinate stylesheets -->
    <!-- START COMMON CODE FOR  CONTENT TYPES -->
    <xsl:template match="/">
        <xsl:if test="dw-document/dw-article | dw-document/dw-tutorial">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
