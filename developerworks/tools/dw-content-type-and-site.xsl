<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="no" omit-xml-declaration="yes" encoding="UTF-8" />

    <xsl:template match="/dw-document">
        <xsl:variable name="content-type" select="*[1]" />
        <xsl:text>content-type=</xsl:text><xsl:value-of select="name($content-type)"/>
        <xsl:text>&#10;local-site=</xsl:text><xsl:value-of
            select="$content-type/@local-site"/><xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="/kp">
        <xsl:variable name="content-type" select="'dw-kp-beta'" />
        <xsl:text>content-type=</xsl:text><xsl:value-of select="$content-type"/>
        <xsl:text>&#10;local-site=worldwide</xsl:text><xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
