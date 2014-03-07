<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================
    This stylesheet transforms dw-article or dw-tutorial document type to
    FO files for later processing into a PDF document by FOP.

    This version written 2011-01-26 by Ian Shields
    Brought to you by your friends at developerWorks:
    ibm.com/developerWorks.
    =============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">

    <xsl:key name="target-names"
        match="//a[@name != ''] | //title[@name != ''] |
        //caption[@name != ''] "
        use="@name"/>
    <xsl:key name="target-refnames"
        match="//container-heading[@refname != ''] |
        //heading[@refname != ''] | //title[@refname != ''] | //caption[@refname != '']  "
        use="@refname"/>
    <xsl:key name="target-downloads"
        match="//target-content-file[1]|//target-content-page[not(//target-content-file)][1]"
        use=" 'download' "/>
    <xsl:key name="target-resources"
        match="//resources[1] |
        //resource-list[not(//resources)][1]"
        use=" 'resources' "/>
    <xsl:key name="elements-by-id" match="*|text()" use="generate-id()"/>

    <xsl:variable name="dw-page-width">
        <xsl:choose>
            <xsl:when test="$pageSize='common' or $pageSize='a4' ">
                <xsl:value-of select=" '210mm' "/>
            </xsl:when>
            <xsl:when test="$pageSize='letter' ">
                <xsl:value-of select=" '8.5in' "/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Invalid page size <xsl:value-of
                        select="$pageSize"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dw-page-height">
        <xsl:choose>
            <xsl:when test="$pageSize='common' or $pageSize='letter' ">
                <xsl:value-of select=" '11in' "/>
            </xsl:when>
            <xsl:when test="$pageSize='a4' ">
                <xsl:value-of select=" '297mm' "/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Invalid page size <xsl:value-of
                        select="$pageSize"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dw-page-width-in-mm">
        <xsl:call-template name="convert-measurement-units">
            <xsl:with-param name="in-value" select="$dw-page-width"/>
            <xsl:with-param name="to-units" select=" $to-mm "/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="dw-page-margins-in-mm" select="25"/>
    <xsl:variable name="dw-page-center-column-width"
        select="$dw-page-width-in-mm - (2 *
        $dw-page-margins-in-mm)"> </xsl:variable>
    <xsl:variable name="dw-page-center-column-width-as-mm"
        select="concat($dw-page-center-column-width, 'mm' )"/>
    <xsl:variable name="dw-page-margins" select="concat($dw-page-margins-in-mm, 'mm')"> </xsl:variable>

    <!-- Allow PDF generation to include IBM and developerWorks logos in masthead    -->
    <xsl:variable name="path-dw-images-resolved">
        <xsl:call-template name="generate-correct-url-form">
            <xsl:with-param name="input-url" select="$path-dw-images"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- ============================================
    Processing for the anchor tag is complex.  First
    of all, if this is a named anchor, we write an empty
    <fo:block> with the appropriate id.  (In the special
    case that the next element is major heading, we ignore
    the element altogether and put the id on the major heading.)
    Next, if this is a regular anchor and the href
    starts with a hash mark (#), we create a link with
    an internal-destination.  Otherwise, we create a
    link with an external destination. 
    =============================================== -->
    <xsl:template match="a">
        <xsl:choose>
            <xsl:when test="@name != '' ">
                <xsl:choose>
                    <xsl:when
                        test="following-sibling::*[1]/self::heading[@type='major']
                        and  following-sibling::*[1]/@refname = '' "/>
                    <xsl:otherwise>
                        <fo:inline>
                            <xsl:attribute name="id">
                                <xsl:value-of select="@name"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="*|text()"/>
                        </fo:inline>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- 5.2 10/20 fjc  -->
            <xsl:when test="@href">
                <!-- 6.0 ibs 2010-03-25 DR 3361. Add tutorial support for internal links
                #download and #resources -->
                <xsl:variable name="internal-target-name">
                    <xsl:choose>
                        <xsl:when
                            test="(@href = 'resources.html') or (@href =
                            '#resources' or (@href = '#Resources' ))">
                            <xsl:value-of select=" 'resources' "/>
                        </xsl:when>
                        <xsl:when test="@href = 'authors.html'">
                            <xsl:value-of select=" 'author-bio' "/>
                        </xsl:when>
                        <xsl:when test="@href = 'index.html'">
                            <xsl:value-of select=" 'section1' "/>
                        </xsl:when>
                        <xsl:when
                            test="(@href = 'downloads.html') or  (@href =
                            '#download') ">
                            <xsl:value-of select=" 'download' "/>
                        </xsl:when>
                        <xsl:when test="@href = 'rating.html'">
                            <xsl:value-of select=" 'rating' "/>
                        </xsl:when>
                        <xsl:when test="starts-with(@href, '#')">
                            <xsl:value-of select="substring(@href, 2)"/>
                        </xsl:when>
                        <xsl:when
                            test="starts-with(@href, 'section') and contains(@href,
                            '.html')">
                            <xsl:choose>
                                <xsl:when test="contains(@href,'#')">
                                    <xsl:value-of select="substring-after(@href, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-before(@href,
                                        '.html')"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>
                <fo:basic-link>
                    <xsl:choose>
                        <xsl:when test="$internal-target-name != ''">
                            <xsl:attribute name="internal-destination">
                                <xsl:value-of select="$internal-target-name"/>
                            </xsl:attribute>
                            <xsl:attribute name="color">
                                <xsl:value-of select="$internal-link-color"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="external-destination">
                                <xsl:for-each select="@href">
                                    <xsl:call-template name="Fix-External-URL"/>
                                </xsl:for-each>
                            </xsl:attribute>
                            <xsl:attribute name="color">
                                <xsl:value-of select="$external-link-color"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="*|text()"/>
                </fo:basic-link>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">
                    <xsl:value-of
                        select="normalize-space(concat('Anchor missing both name
                        and href attributes &quot;',substring(normalize-space(.),1,25),
                        '&quot;'))"
                    />
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ======================================
        Abstract - Only use if no abstract-extended or 
        abstract-extended is empty 
        ======================================= -->
    <!-- New Feb 2011 ibs  -->
    <xsl:template match="abstract">
        <xsl:if
            test="not(/dw-document//abstract-extended) or
            (string-length(/dw-document//abstract-extended) = 0)">
            <fo:block margin="3mm" text-align="start">
                <xsl:call-template name="SetSpace">
                    <xsl:with-param name="font-or-space-size" select="'3mm'"/>
                </xsl:call-template>
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <!-- ======================================
        Abstract-extended
        ======================================= -->
    <!-- New Feb 2011 ibs  -->
    <xsl:template match="abstract-extended">
        <fo:block margin="3mm" text-align="start">
            <xsl:call-template name="SetSpace">
                <xsl:with-param name="font-or-space-size" select="'3mm'"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <!--<xsl:template match="abstract-extended">
        <fo:block margin="2mm" text-align="start">
            <xsl:call-template name="SetSpace">
                <xsl:with-param name="font-or-space-size" select="0"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>-->

    <!-- Figure out if this element is inside a list or table cell and adjust the
            spacing value down if so. Also standardize the value as points (without the
            'pt' suffix). -->
    <xsl:template name="AdjustSpaceForContainer">
        <xsl:param name="font-or-space-size"/>
        <xsl:variable name="modified-font-or-space-size">
            <xsl:choose>
                <xsl:when test="../self::ol|../self::ul|../self::resources">
                    <xsl:value-of select="$list-separator"/>
                </xsl:when>
                <xsl:when test="../self::th|../self::td">
                    <xsl:value-of select="$table-cell-separator"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$font-or-space-size"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="convert-measurement-units">
            <xsl:with-param name="in-value" select="$modified-font-or-space-size"/>
            <xsl:with-param name="to-units" select="$to-points"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="author" mode="author-link">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- Make it a link to about the author -->
        <fo:block text-align="start">
            <fo:basic-link color="{$internal-link-color}">
                <xsl:attribute name="internal-destination">
                    <xsl:text>author-bio</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates select="name|author-name"/>
                <!--<xsl:call-template name="AuthorName"/>-->
            </fo:basic-link>
            <xsl:if test="cma-defined">
                <xsl:call-template name="DisplayError">
                    <xsl:with-param name="error-number">e005</xsl:with-param>
                    <xsl:with-param name="display-format">pdf</xsl:with-param>
                </xsl:call-template>

            </xsl:if>
            <!-- Author Email -->
            <xsl:if
                test="normalize-space(@email) and
                normalize-space(@publish-email)!='no'">
                <xsl:text> (</xsl:text>
                <fo:basic-link color="{$external-link-color}">
                    <xsl:attribute name="external-destination">mailto:<xsl:value-of
                            select="@email"/></xsl:attribute>
                    <xsl:value-of select="@email"/>
                </fo:basic-link>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </fo:block>
        <!-- Author Title -->
        <fo:block text-align="start">
            <xsl:value-of select="@jobtitle"/>
        </fo:block>
        <!-- Author Company -->
        <fo:block space-after="{$default-space-after}" text-align="start">
            <xsl:value-of select="company-name"/>
        </fo:block>
    </xsl:template>


    <!-- ======================================
        About the Author  Template:  the name, and
        bio of all the authors. 
        ======================================= -->
    <xsl:template match="author">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- Author Name -->
        <fo:block text-align="start" keep-with-next.within-page="always">
            <xsl:call-template name="SetSpaceAfter">
                <xsl:with-param name="font-or-space-size" select="$default-font-size"/>
            </xsl:call-template>
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:apply-templates select="name|author-name"/>
        </fo:block>
        <!-- Author Bio -->
        <fo:block text-align="start">
            <xsl:call-template name="SetSpaceAfter">
                <xsl:with-param name="font-or-space-size"
                    select="$section-title-font-size"/>
            </xsl:call-template>
            <xsl:variable name="author-pic-width" select=" '68px' "/>
            <xsl:variable name="author-pic-width-as-mm">
                <xsl:call-template name="convert-measurement-units">
                    <xsl:with-param name="in-value" select="$author-pic-width"/>
                    <xsl:with-param name="to-units" select="$to-mm"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="bio-width"
                select="concat($dw-page-center-column-width -
                $author-pic-width-as-mm, 'mm')"/>
            <fo:table table-layout="fixed" width="{$dw-page-center-column-width-as-mm}">
                <fo:table-column column-width="{$author-pic-width}"/>
                <fo:table-column column-width="{$bio-width}"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:apply-templates select="img"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:apply-templates select="bio"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <xsl:if test="following-sibling::author">
            <fo:block space-after="{$maximum-space-after}">
                <xsl:call-template name="SetSpace">
                    <xsl:with-param name="font-or-space-size"
                        select="$section-title-font-size"/>
                </xsl:call-template>
                <fo:leader leader-pattern="rule" leader-length="100%"
                    keep-with-previous.within-page="always"/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <!-- ======================================
        author/author-name  Template:  return the name of 
        the author of the article or tutorial 
        ======================================= -->
    <xsl:template match="author/author-name">
        <!-- New IBM 2011-02-14 -->
        <xsl:variable name="suffix-comma">
	    <!-- 2012-05-22 ITO Fix: Adjusted the scope of this test from author-name/Suffix,
	         since we're already in author/author-name -->
            <xsl:if test="normalize-space(Suffix)!=''">
                <xsl:value-of select=" ', ' "/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="blank-separator" select=" ' ' "/>
        <xsl:value-of
            select="normalize-space(concat(Prefix, $blank-separator, GivenName,
            $blank-separator,MiddleName, $blank-separator, FamilyName, $suffix-comma,
            Suffix))"
        />
    </xsl:template>

    <!-- ======================================
        author/name  Template:  return the name of 
        the author of the article or tutorial 
        ======================================= -->
    <!-- New IBM 2011-02-14 -->
    <xsl:template match="author/name">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>

    <!--<xsl:template name="AuthorName">
        <!-\- Left as-is Feb 2011 ibs  -\->
        <xsl:choose>
            <xsl:when test="normalize-space(name)!=''">
                <xsl:value-of select="name"/>
            </xsl:when>
            <xsl:when test="author-name">
                <xsl:if test="normalize-space(author-name/Prefix)!=''">
                    <xsl:value-of select="author-name/Prefix"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:if test="normalize-space(author-name/GivenName)!=''">
                    <xsl:apply-templates select="author-name/GivenName"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:if test="normalize-space(author-name/MiddleName)!=''">
                    <xsl:apply-templates select="author-name/MiddleName"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:if test="normalize-space(author-name/FamilyName)!=''">
                    <xsl:apply-templates select="author-name/FamilyName"/>
                </xsl:if>
                <xsl:if test="normalize-space(author-name/Suffix)!=''">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="author-name/Suffix"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>-->

    <!-- ============================================
    Back Matter template
    ===============================================  -->
    <xsl:template name="BackMatter">
        <!-- Rewrite Feb 2011 ibs  Still needs work-->
        <xsl:if
            test="/dw-document//target-content-file or
            /dw-document//target-content-page">
            <fo:block break-before="page" space-after.optimum="{$default-space-after}"
                font-size="{$section-title-font-size}" text-align="start">
                <xsl:call-template name="set-font-attributes-family-weight-and-color">
                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                </xsl:call-template>
                <xsl:attribute name="id">
                    <xsl:text>download</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$downloads-heading"/>
            </fo:block>
            <xsl:call-template name="Downloads"/>
        </xsl:if>
        <!-- Resource -->
        <xsl:if test="/dw-document//resources">
            <fo:block break-before="page" space-after.optimum="{$default-space-after}"
                font-size="{$section-title-font-size}" text-align="start">
                <xsl:call-template name="set-font-attributes-family-weight-and-color">
                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                </xsl:call-template>
                <xsl:attribute name="id">
                    <xsl:text>resources</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$resource-list-heading"/>
            </fo:block>
            <xsl:apply-templates select="resources"/>
        </xsl:if>

        <!-- Old style resource-list -->
        <xsl:for-each select="/dw-document//resource-list">
            <fo:block break-before="page" space-after.optimum="{$default-space-after}"
                font-size="{$section-title-font-size}" text-align="start">
                <xsl:call-template name="set-font-attributes-family-weight-and-color">
                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                </xsl:call-template>
                <xsl:attribute name="id">
                    <xsl:text>resources</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$resource-list-heading"/>
            </fo:block>
            <xsl:apply-templates select="*"/>
        </xsl:for-each>

        <!-- About the author(s) -->
        <xsl:if test="normalize-space(/dw-document//author/bio)!=''">
            <fo:block break-before="page" font-size="{$section-title-font-size}"
                text-align="start" keep-with-next.within-page="always">
                <xsl:call-template name="set-font-attributes-family-weight-and-color">
                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                </xsl:call-template>
                <xsl:call-template name="SetSpace">
                    <xsl:with-param name="font-or-space-size"
                        select="$section-title-font-size"/>
                    <xsl:with-param name="check-sibling" select=" 'no' "/>
                </xsl:call-template>
                <xsl:attribute name="id">
                    <xsl:text>author-bio</xsl:text>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="count(//author) = 1">
                        <xsl:value-of select="$aboutTheAuthor"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$aboutTheAuthors"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
            <xsl:apply-templates select="author"/>
        </xsl:if>
        <!-- Trademarks -->
        <!-- Replaced with a link to trademark info for 6.0  -->
        <xsl:call-template name="CopyrightAndTrademarkInfo"/>
    </xsl:template>

    <!-- ============================================
    A blockquote is indented on both sides.
    =============================================== -->
    <xsl:template match="blockquote">
        <fo:block start-indent="1.25cm" end-indent="1.25cm">
            <xsl:call-template name="SetSpaceAfter"/>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    We handle a break element by inserting an 
    empty <fo:block>.
    =============================================== -->
    <xsl:template match="br">
        <fo:block> </fo:block>
    </xsl:template>

    <!--  =============================================== 
    Rewrite build-columns as recursive using known values from Ian's table-count-columns-in-row template
    =============================================== -->
    <xsl:template name="build-columns">
        <xsl:param name="counter" select="1"/>
        <xsl:param name="max-columns" select="0"/>
        <xsl:param name="table-width-value-export"/>
        <xsl:param name="default-column-width-in-percentage"/>
        <xsl:for-each select="(thead|tr|tfoot)[1]/*">
            <xsl:variable name="table-column-width-in" select="normalize-space(@width)"/>
            <xsl:variable name="colspan-value">
                <xsl:choose>
                    <xsl:when test="(@colspan > '1')">
                        <xsl:value-of select="@colspan"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>1</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:call-template name="process-col-width">
                <xsl:with-param name="colspan-value" select="$colspan-value"/>
                <xsl:with-param name="table-column-width-in"
                    select="$table-column-width-in"/>
                <xsl:with-param name="table-width-value-export"
                    select="$table-width-value-export"/>
                <xsl:with-param name="default-column-width-in-percentage"
                    select="$default-column-width-in-percentage"/>
            </xsl:call-template>
        </xsl:for-each>
        <!-- count number of columns in first row, if fewer than max columns, create delta number of additional columns using default column width -->
        <xsl:variable name="first-row-children" select="(thead|tr|tfoot)[1]/*"/>
        <xsl:variable name="first-row-columns"
            select="sum($first-row-children/@colspan) +
            count($first-row-children[not(@colspan) or (@colspan='')])"/>
        <xsl:if test="$first-row-columns &lt; $max-columns">
            <xsl:call-template name="process-additional-cols">
                <xsl:with-param name="colspan-value"
                    select="($max-columns -
                    $first-row-columns)"/>
                <xsl:with-param name="default-column-width-in-percentage"
                    select="$default-column-width-in-percentage"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="calculate-color-value">
        <!-- 
    The 17 standard colors are: aqua, black, blue, fuchsia, gray, grey, green, lime, maroon, navy, olive, purple, red, silver, teal, white, and yellow.
    
    aqua, #00FFFF 
    black, #000000
    blue, #0000FF
    fuchsia, #FF00FF 
    gray, #808080
    grey, #808080
    green, #008000
    lime, #00FF00
    maroon, #800000 
    navy, #000080
    olive, #808000
    purple, #800080
    red, #FF0000
    silver, #C0C0C0
    teal, #008080
    white, #FFFFFF
    yellow #FFFF00
    -->
    </xsl:template>

    <!-- ============================================
    List items inside unordered lists and resources or potentially any
    bulleted list. Have to use the correct Unicode character
    for the bullet.  Note that we add a non-breaking space 
    so that bullets line up under the low-order digit of ordered lists.
    This template is also called when formatting resources, or potentially
    any other order list items.
    =============================================== -->
    <xsl:template name="bulleted-item">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()" text-align="right">
                <fo:block>
                    <xsl:value-of select="concat( '&#8226;', $nbsp)"/>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="self::forum-url">
                            <!--Forum URL. Put in link and appropriate translated text
                                string.-->
                            <xsl:if test="normalize-space(@url) !='' ">
                                <fo:basic-link color="{$external-link-color}">
                                    <xsl:attribute name="external-destination">
                                        <xsl:call-template
                                            name="generate-correct-url-form">
                                            <xsl:with-param name="input-url" select="@url"
                                            />
                                        </xsl:call-template>
                                    </xsl:attribute>
                                    <xsl:value-of select="$pdfResource-list-forum-text"/>
                                </fo:basic-link>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="*|text()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!--<xsl:apply-templates select="."/>-->
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- ==============================================
    For the caption,  FOP doesn't support table-caption.
    We add a row then a column of full width to the end of the table. 
    ================================================= -->
    <!-- llk - number-columns-spanned attribute is now set to max-columns -->
    <xsl:template match="caption">
        <xsl:param name="max-columns"/>
        <fo:table-row>
            <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
                padding-after="3pt" background-color="{$table-caption-color}"
                border-style="solid" border-color="{$table-caption-color}"
                border-width="1pt" start-indent="0">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="$max-columns"/>
                </xsl:attribute>
                <!--<fo:block color="{$background-color}" font-family="{$table-cell-font}"-->
                <fo:block color="{$background-color}" font-size="{$table-cell-font-size}">
                    <xsl:apply-templates select="*|text()"/>
                    <xsl:if test="normalize-space(@refname)">
                        <fo:inline>
                            <xsl:attribute name="id">
                                <xsl:value-of select="@refname"/>
                            </xsl:attribute>
                        </fo:inline>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <!-- ============================================
    We're handling <center> as a block element; if
    you use it, it creates a new paragraph that's 
    centered on the page. 
    =============================================== -->
    <xsl:template match="center">
        <fo:block text-align="center">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
  Code Template - 
  =============================================== -->
    <xsl:template match="code">
        <!-- 2012-05-24 IBS Fix assorted code fonts size issues for inline and code
            sections. Basic idea now is to use same size as containing block except for:
            - inline code in body and code section in body controlled by prefs
            - inline code in tables and sidebars same as regular code
            - code sections in tables and sidebars 1pt smaller than regular code.
            See calculations in dw-variables-pdf-6.0 
        -->
        <!-- Rewrite Feb 2011 ibs  -->
        <xsl:variable name="my-parent" select=".."/>
        <xsl:variable name="actual-code-font-size">
            <xsl:choose>
                <xsl:when test="@type='inline' ">
                    <xsl:choose>
                        <xsl:when test="ancestor::table">
                            <xsl:value-of select="$table-cell-monospaced-font"/>
                        </xsl:when>
                        <xsl:when test="ancestor::sidebar">
                            <xsl:value-of select="$sidebar-monospaced-font"/>
                        </xsl:when>
                        <xsl:when
                            test="ancestor::p|ancestor::li|ancestor::dl|ancestor::pre">
                            <xsl:value-of select="$code-inline-font-size"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select=" '' "/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <!-- @type='section' -->
                    <xsl:choose>
                        <xsl:when test="ancestor::table">
                            <xsl:value-of select="$table-cell-code-section-font"/>
                        </xsl:when>
                        <xsl:when test="ancestor::sidebar">
                            <xsl:value-of select="$sidebar-code-section-font"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$code-section-font-size"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='inline'">
                <!-- 2012-02-27 IBS Handle inline code in tables -->
                <!--
                <xsl:choose>
                    <!-\- IBS 2011-05-24 <xsl:when test="parent::docbody|parent::td|parent::th">-\->
                    <xsl:when test="parent::docbody">
                        <!-\- Code is not part of another block, so put it in a block of
                            its own -\->
                        <fo:block space-after="{$default-space-after}">
                            <fo:inline font-size="{$actual-inline-font-size}"
                                background-color="{$code-background-color}">
                                <xsl:call-template
                                    name="set-font-attributes-family-weight-and-color"/>
                                <xsl:apply-templates select="*|text()"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>-->
                <!--  IBS 2011-05-24 <fo:inline font-size="{$code-inline-font-size}"-->
                <fo:inline background-color="{$code-background-color}">
                    <xsl:if test="normalize-space($actual-code-font-size) != '' ">
                        <xsl:attribute name="font-size">
                            <xsl:value-of select="$actual-code-font-size"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
                    <xsl:apply-templates select="*|text()"/>
                </fo:inline>
                <!--  </xsl:otherwise>
                </xsl:choose>-->
            </xsl:when>
            <xsl:when test="@type='section'">
                <xsl:apply-templates select="heading"/>
                <xsl:variable name="text-content1">
                    <xsl:apply-templates select="*[not(self::heading)]|text()"
                        mode="no-escaping"/>
                </xsl:variable>
                <xsl:variable name="line-count">
                    <xsl:call-template name="CalculateCodeLineCount">
                        <xsl:with-param name="code-to-check">
                            <xsl:value-of select="$text-content1"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>

                <!-- widows and orphans don't seem to work too well. Need to investigate
                    whether they're really supported here. -->
                <fo:block space-before="{$minimum-space-before}"
                    space-after="{$minimum-space-after}" white-space-collapse="false"
                    white-space-treatment="ignore-if-before-linefeed" wrap-option="wrap"
                    linefeed-treatment="preserve"
                    background-color="{$code-background-color}"
                    border-color="{$table-border-color}" border-width="1"
                    border-style="solid" orphans="10" widows="10">
                    <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
                    <xsl:if test="normalize-space($actual-code-font-size) != '' ">
                        <xsl:attribute name="font-size">
                            <xsl:value-of select="$actual-code-font-size"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="$line-count &lt; 20">
                        <xsl:attribute name="keep-together.within-column"
                            >always</xsl:attribute>
                    </xsl:if>
                    <!-- Process code section. We are missing <pre> elements around code,
                        so this will strip extraneous leading blank lines and any trailing
                    white space. -->
                    <xsl:call-template name="FixCodeSectionWhiteSpace"/>
                </fo:block>
                <fo:block space-after="0.5cm"/>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline font-size="{$code-inline-font-size}">
                    <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
                    <xsl:apply-templates select="*|text()"/>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- this template sets the xpath for processing the default column width -->
    <xsl:template name="column-default-width-setup">
        <xsl:param name="table-width-value-export"/>
        <xsl:param name="max-columns"/>
        <xsl:for-each select="*[self::thead or self::tr or self::tfoot][1]">
            <xsl:call-template name="column-default-width">
                <xsl:with-param name="table-width-value-export"
                    select="$table-width-value-export"/>
                <xsl:with-param name="max-columns" select="$max-columns"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <!-- this template defines column default width -->
    <xsl:template name="column-default-width">
        <xsl:param name="table-width-value-export" select="0"/>
        <xsl:param name="max-columns" select="0"/>
        <xsl:param name="columns-with-default"
            select="sum(*[(@width='') or
            (not(@width))]/@colspan) + count(*[(@width='') or (not(@width))][not(@colspan)
            or (@colspan='')])"/>
        <xsl:param name="columns-with-width"
            select="sum(*[(@width!='')]/@colspan) +
            count(*[(@width!='')][not(@colspan) or (@colspan='')])"/>
        <!-- now find the explicit value that is assigned to the widths (in percentage) -->
        <xsl:variable name="explicit-percentage-width">
            <xsl:choose>
                <xsl:when test="$columns-with-width > 0">
                    <xsl:for-each select="*[normalize-space(@width) != ''][1]">
                        <xsl:call-template name="explicit-width-in-percentage">
                            <xsl:with-param name="table-width-value-export"
                                select="$table-width-value-export"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of
            select="(100 - $explicit-percentage-width) div
            $columns-with-default"
        />
    </xsl:template>

    <xsl:template name="CopyrightAndTrademarkInfo">
        <fo:list-block provisional-label-separation="0pt"
            space-after="{$default-space-after}" keep-together.within-column="always">
            <xsl:attribute name="id">
                <xsl:text>trademarks</xsl:text>
            </xsl:attribute>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block/>
                </fo:list-item-label>
                <fo:list-item-body>
                    <!-- llk - remove start-indent="0"; added to fo:table instead -->
                    <!--<fo:block text-align="start" start-indent="0">-->
                    <fo:block text-align="start">
                        <!-- llk 2-24-2012 - nls-enable the url -->
                        <fo:basic-link color="{$external-link-color}">
                            <xsl:attribute name="external-destination">
                                <xsl:value-of select="$dcRights-v16-url"/>
                            </xsl:attribute>
                            <xsl:value-of select="$dcRights-v16"/>
                        </fo:basic-link>
                        <fo:block>
                            <!-- llk 2-24-2012 - nls-enable the url --> (<xsl:value-of
                                select="$dcRights-v16-url-printed"/>) </fo:block>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block/>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>
                        <!-- llk - url must be unique per site -->
                        <fo:basic-link color="{$external-link-color}">
                            <xsl:attribute name="external-destination">
                                <xsl:value-of select="$pdfTrademarks-url"/>
                            </xsl:attribute>
                            <xsl:value-of select="$pdfTrademarks"/>
                        </fo:basic-link>
                        <fo:block>
                            <!-- llk 2-24-2012 - nls-enable the url --> (<xsl:value-of
                                select="$pdfTrademarks-url-printed"/>) </fo:block>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- ============================================
        Layout master set defines the page masters (first, right, left, etc) 
        and what sequence they should be generated in. 
        =============================================== -->
    <xsl:template name="CreateLayoutMasterSet">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- ============================================
            Define the page layouts. 
            =============================================== -->
        <fo:layout-master-set>
            <fo:simple-page-master master-name="first" page-height="{$dw-page-height}"
                page-width="{$dw-page-width}" margin-left="{$dw-page-margins}"
                margin-right="{$dw-page-margins}" margin-top="4mm" margin-bottom="1cm">
                <fo:region-body margin-top="4.0cm" margin-bottom="2.0cm"/>
                <fo:region-before region-name="masthead" extent="4.0cm"/>
                <fo:region-after region-name="region-bottom-first" extent="1.5cm"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="left" page-height="{$dw-page-height}"
                page-width="{$dw-page-width}" margin-left="{$dw-page-margins}"
                margin-right="{$dw-page-margins}" margin-top="1cm" margin-bottom="1cm">
                <fo:region-body margin-top="1.5cm" margin-bottom="1.5cm"/>
                <fo:region-before region-name="rb-left" extent="3.0cm"/>
                <fo:region-after region-name="region-bottom" extent="1.0cm"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="right" page-height="{$dw-page-height}"
                page-width="{$dw-page-width}" margin-left="{$dw-page-margins}"
                margin-right="{$dw-page-margins}" margin-top="1cm" margin-bottom="1cm">
                <fo:region-body margin-top="1.5cm" margin-bottom="1.5cm"/>
                <fo:region-before region-name="rb-right" extent="3.0cm"/>
                <fo:region-after region-name="region-bottom" extent="1.0cm"/>
            </fo:simple-page-master>

            <!-- ============================================
                Now we define how we use the page layouts.  One
                is for the first page, one is for the even-
                numbered pages, and one is for odd-numbered pages.
                =============================================== -->
            <fo:page-sequence-master master-name="standard">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="first"
                        page-position="first"/>
                    <fo:conditional-page-master-reference master-reference="left"
                        odd-or-even="even"/>
                    <fo:conditional-page-master-reference master-reference="right"
                        odd-or-even="odd"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
        </fo:layout-master-set>
    </xsl:template>
    <xsl:template name="CreateStandardFooterInfo">
        <fo:table table-layout="fixed" width="{$dw-page-center-column-width-as-mm}">
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="50%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block text-align="start">
                            <xsl:variable name="series-title-text">
                                <xsl:apply-templates select="//series-title"
                                    mode="no-escaping"/>
                            </xsl:variable>
                            <xsl:if
                                test="normalize-space($series-title-text) !=
                                ''">
                                <xsl:value-of select="normalize-space($series-title-text)"/>
                                <xsl:text>: </xsl:text>
                            </xsl:if>
                            <xsl:apply-templates select="/dw-document/*/title"
                                mode="no-escaping"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="end">
                            <xsl:value-of select="$page"/>
                            <xsl:text> </xsl:text>
                            <fo:page-number/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="$of"/>
                            <xsl:text> </xsl:text>
                            <fo:page-number-citation ref-id="TheVeryLastPage"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="CreateStaticContent">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- ============================================
            We define the static content for the headers
            and footers of the various page layouts first.
            ============================================== -->
        <!-- Top of first page has a masthead -->
        <fo:static-content flow-name="masthead">
            <fo:block start-indent="0pt" space-before="5pt" space-after="0pt">
                <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
                <xsl:variable name="url-ibm-logo-banner">
                    <xsl:choose>
                        <xsl:when test="starts-with($ibm-logo-banner, '//')">
                            <xsl:value-of select="concat('http:', $ibm-logo-banner)"/>
                        </xsl:when>
                        <xsl:when test="starts-with($ibm-logo-banner, '/')">
                            <xsl:value-of
                                select="concat('http://www.ibm.com',
                                $ibm-logo-banner)"
                            />
                        </xsl:when>
                        <xsl:when test="contains($ibm-logo-banner, '//')">
                            <xsl:value-of select="$ibm-logo-banner"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('http://www.ibm.com/developerworks/i/',
                                $ibm-logo-banner)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <fo:external-graphic scaling="uniform" content-height="12mm"
                    content-width="25mm" src="{$url-ibm-logo-banner}">
                    <xsl:attribute name="fox:alt-text">
                        <xsl:value-of select=" 'IBM®' "/>
                    </xsl:attribute>

                </fo:external-graphic>
            </fo:block>
            <fo:block>
                <fo:leader leader-pattern="rule" start-indent="0pt" rule-thickness=".5mm"
                    leader-length="100%" space-before="0pt" space-after="0pt"/>
            </fo:block>
            <fo:block text-align="right" space-before="0pt" space-after="0pt">
                <xsl:variable name="url-dw-logo">
                    <xsl:choose>
                        <xsl:when test="starts-with($dw-logo, '//')">
                            <xsl:value-of select="concat('http:', $dw-logo)"/>
                        </xsl:when>
                        <xsl:when test="starts-with($dw-logo, '/')">
                            <xsl:value-of
                                select="concat('http://www.ibm.com',
                                $dw-logo)"
                            />
                        </xsl:when>
                        <xsl:when test="contains($dw-logo, '//')">
                            <xsl:value-of select="$dw-logo"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('http://www.ibm.com/developerworks/i/',
                                $dw-logo)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <fo:external-graphic scaling="uniform" content-height="12mm"
                    content-width="75mm" src="{$url-dw-logo}">
                    <xsl:attribute name="fox:alt-text">
                        <xsl:value-of select=" 'IBM®' "/>
                    </xsl:attribute>
                </fo:external-graphic>
            </fo:block>
        </fo:static-content>

        <!-- Top of odd numbered page -->

        <fo:static-content flow-name="rb-right" font-size="{$header-font-size}">
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <fo:table table-layout="fixed" width="{$dw-page-center-column-width-as-mm}">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <!-- llk 2-25-2012 added language specific site url -->
                            <fo:block text-align="left">
                                <xsl:value-of select="$developerworks-top-url-pdf"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block text-align="right">
                                <xsl:text>developerWorks®</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:static-content>

        <!-- Top of even numbered page -->
        <fo:static-content flow-name="rb-left">
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <fo:table table-layout="fixed" width="{$dw-page-center-column-width-as-mm}">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block text-align="left">
                                <xsl:text>developerWorks®</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <!-- llk 2-25-2012 added language specific site url -->
                            <fo:block text-align="right">
                                <xsl:value-of select="$developerworks-top-url-pdf"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:static-content>

        <!-- Bottom of first page -->
        <fo:static-content flow-name="region-bottom-first" font-size="{$footer-font-size}">
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <fo:block-container absolute-position="absolute" bottom="0">
                <!-- llk - add start-indent="0" to fo:table  -->
                <fo:table table-layout="fixed"
                    width="{$dw-page-center-column-width-as-mm}" start-indent="0">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block text-align="start">
                                    <fo:basic-link color="{$external-link-color}">
                                        <!-- llk 2-25-2012 - added language specific copyright reference -->
                                        <xsl:attribute name="external-destination">
                                            <xsl:value-of select="$dcRights-v16-url"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="$dcRights-v16"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block text-align="end">
                                    <fo:basic-link color="{$external-link-color}">
                                        <!-- llk 2-25-2012 - added language specific trademarks url -->
                                        <xsl:attribute name="external-destination">
                                            <xsl:value-of select="$pdfTrademarks-url"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="$pdfTrademarks"/>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
                <xsl:call-template name="CreateStandardFooterInfo"/>
            </fo:block-container>
        </fo:static-content>

        <!-- Bottom of all pages other than first -->

        <fo:static-content flow-name="region-bottom" font-size="{$footer-font-size}">
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <fo:block-container absolute-position="absolute" bottom="0">
                <xsl:call-template name="CreateStandardFooterInfo"/>
            </fo:block-container>
        </fo:static-content>
        <!-- End of Static (page header & footer) -->
    </xsl:template>

    <xsl:template match="date-translated">
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block>
            <xsl:value-of select="concat($translated, ' ')"/>
            <xsl:call-template name="FormatDate"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="date-published">
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block>
            <xsl:value-of select="concat($date, ' ')"/>
            <xsl:call-template name="FormatDate"/>
        </fo:block>
        <fo:block>
            <xsl:if test="//date-updated">
                <xsl:for-each select="//date-updated">
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="concat($updated, ' ')"/>
                    <xsl:call-template name="FormatDate"/>
                    <xsl:text>)</xsl:text>
                </xsl:for-each>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    We handle each <dd> element as an indented block
    beneath the defined term.  If the following 
    element is another <dd>, that means it's another
    definition for the same term.  In that case, 
    we don't put as much vertical space after the 
    block. 
    =============================================== -->
    <xsl:template match="dd">
        <fo:block start-indent="1cm">
            <xsl:call-template name="SetSpaceAfter">
                <xsl:with-param name="font-or-space-size" select="$list-separator"/>
            </xsl:call-template>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    We don't do anything with the <dl> element, we
    just handle the elements it contains. 
    =============================================== -->
    <xsl:template match="dl">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ===============================================
	Docbody Template
	================================================ -->
    <xsl:template match="docbody">
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block font-family="{$default-font}" font-size="{$default-font-size}">
            <xsl:call-template name="SetSpace"/>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
  5.5 08/08/06 fjc add download table
   Download table template 
   ================================================ -->
    <!-- 5.12 3/12 ddh DR# :  Added the proportional-column-width(N) function to support longer file names  -->
    <xsl:template name="Downloads">
        <xsl:if test="//target-content-file">
            <fo:block space-after.optimum="{$heading-space-after}">
                <fo:table table-layout="fixed" border="1pt solid #efefef"
                    width="{$dw-page-center-column-width-as-mm}">
                    <fo:table-column column-number="1"
                        column-width="proportional-column-width(40)"/>
                    <fo:table-column column-number="2"
                        column-width="proportional-column-width(35)"/>
                    <fo:table-column column-number="3"
                        column-width="proportional-column-width(12)"/>
                    <fo:table-column column-number="4"
                        column-width="proportional-column-width(13)"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell padding-start="3pt" padding-end="3pt"
                                padding-before="3pt" padding-after="3pt"
                                background-color="{$prefs/colors/table-th-color}"
                                border-style="solid"
                                border-color="{$prefs/colors/table-th-color}"
                                border-width="1pt">
                                <fo:block text-align="left">
                                    <xsl:value-of
                                        select="$download-filedescription-heading"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-start="3pt" padding-end="3pt"
                                padding-before="3pt" padding-after="3pt"
                                background-color="{$prefs/colors/table-th-color}"
                                border-style="solid"
                                border-color="{$prefs/colors/table-th-color}"
                                border-width="1pt">
                                <fo:block text-align="left">
                                    <xsl:value-of select="$download-filename-heading"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-start="3pt" padding-end="3pt"
                                padding-before="3pt" padding-after="3pt"
                                background-color="{$prefs/colors/table-th-color}"
                                border-style="solid"
                                border-color="{$prefs/colors/table-th-color}"
                                border-width="1pt">
                                <fo:block text-align="left">
                                    <xsl:value-of select="$download-filesize-heading"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-start="3pt" padding-end="3pt"
                                padding-before="3pt" padding-after="3pt"
                                background-color="{$prefs/colors/table-th-color}"
                                border-style="solid"
                                border-color="{$prefs/colors/table-th-color}"
                                border-width="1pt">
                                <fo:block text-align="left">
                                    <xsl:value-of select="$download-method-heading"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:apply-templates select="target-content-file"/>
                    </fo:table-body>
                </fo:table>
            </fo:block>
            <fo:block start-indent="5pt" space-after.optimum="{$default-space-after}"
                font-size="{$table-cell-font-size}">
                <!-- llk - url must be unique per site -->
                <fo:basic-link color="{$external-link-color}">
                    <xsl:attribute name="external-destination">
                        <xsl:value-of select="$download-method-link-url"/>
                    </xsl:attribute>
                    <xsl:value-of select="$download-method-link"/>
                </fo:basic-link>
            </fo:block>
        </xsl:if>
        <xsl:if test="/dw-document//target-content-page">
            <xsl:if test="/dw-document//target-content-file">
                <fo:block space-after.optimum="{$default-space-after}"
                    font-size="{$heading-font-size}" font-weight="bold" text-align="start">
                    <xsl:value-of select="$download-heading-more"/>
                </fo:block>
            </xsl:if>
            <fo:list-block provisional-distance-between-starts="1cm"
                provisional-label-separation="0.50cm">
                <xsl:for-each select="/dw-document//target-content-page">
                    <fo:list-item>
                        <fo:list-item-label start-indent="5mm" end-indent="label-end()">
                            <fo:block>&#8226;</fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block space-after="{$resource-space-after}"
                                font-size="{$table-cell-font-size}">
                                <xsl:value-of select="@target-content-type"/>
                                <xsl:text>: </xsl:text>
                                <fo:basic-link color="{$external-link-color}">
                                    <xsl:attribute name="external-destination">
                                        <xsl:value-of select="@url-target-page"/>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="@link-text"/>
                                </fo:basic-link>
                                <!-- 5.9 08/27/07 tdc:  Add superscript for note (DR 2182) -->
                                <xsl:if test="normalize-space(note)!=''">
                                    <fo:inline vertical-align="super" font-size="75%">
                                        <xsl:value-of
                                            select="count(preceding::note[not(normalize-space(.)='')])+1"
                                        />
                                    </fo:inline>
                                </xsl:if>
                                <!-- End superscript -->
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </xsl:for-each>
            </fo:list-block>
        </xsl:if>
        <!-- 5.9 08/27/07 tdc:  Add Notes for tcf|tcp.  Conditional processing here instead of content-type templates so they don't have to be updated (DR 2182) -->
        <xsl:if
            test="normalize-space(target-content-file/note)!='' or
            normalize-space(target-content-page/note)!=''">
            <xsl:for-each
                select="target-content-file/note[not(normalize-space(.)='')] |
                target-content-page/note[not(normalize-space(.)='')]">
                <!-- Det. the ordered list number value by the position of the note (see how ol numbering is done in match="ol/li" template) -->
                <xsl:variable name="value-attr">
                    <xsl:number value="position()"/>
                </xsl:variable>
                <xsl:if test="position()=1">
                    <fo:block space-after.optimum="{$default-space-after}"
                        font-size="{$heading-font-size}" font-weight="bold"
                        text-align="start">
                        <xsl:choose>
                            <xsl:when
                                test="count(//target-content-file/note[not(normalize-space(.)='')]
                                | //target-content-page/note[not(normalize-space(.)='')])
                                > 1">
                                <xsl:value-of select="$download-notes-heading"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$download-note-heading"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                </xsl:if>
                <fo:list-block provisional-distance-between-starts="1cm"
                    provisional-label-separation="0.50cm">
                    <fo:list-item>
                        <fo:list-item-label start-indent="5mm" end-indent="label-end()">
                            <fo:block font-size="{$table-cell-font-size}">
                                <xsl:number value="$value-attr" format="1. "/>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block space-after="{$resource-space-after}"
                                font-size="{$table-cell-font-size}">
                                <xsl:apply-templates select="."/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:for-each>
        </xsl:if>
        <!-- End Notes section -->
    </xsl:template>

    <!-- ============================================
    A definition term is rendered in bold.  We 
    specify keep-with-next here, although it doesn't
    always work with FOP.
    =============================================== -->
    <xsl:template match="dt">
        <fo:block font-weight="bold" keep-with-next="always">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="dw-document/dw-article|dw-document/dw-tutorial">
        <!-- Rewrite Feb 2011 ibs  -->
        <xsl:choose>
            <xsl:when test="pdf or ($xform-type = 'preview')">
                <!-- 2012-02-27 IBS Only generate FO if xml has a pdf element -->
                <!-- 2012-03-21 ITO Generate FO if xml has a pdf element or if we're in
                    preview mode. Supercedes previous comment -->
                <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
                    xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">
                    <xsl:call-template name="CreateLayoutMasterSet"/>
                    <xsl:call-template name="generate-bookmarks"/>
                    <fo:page-sequence master-reference="standard">
                        <xsl:call-template name="CreateStaticContent"/>
                        <fo:flow flow-name="xsl-region-body"
                            font-size="{$default-font-size}" font-style="normal"
                            font-weight="400">
                            <xsl:call-template
                                name="set-font-attributes-family-weight-and-color"/>
                            <xsl:call-template name="FrontMatter"/>
                            <xsl:apply-templates select="docbody|section"/>
                            <!-- ============================================
                        This one line of code processes everything that goes at the
                        end of the document.  The Resources, Info about the author
                        =============================================== -->
                            <xsl:call-template name="BackMatter"/>
                            <!-- ============================================
                        We put an ID at the end of the document so we
                        can do "Page x of y" numbering.
                        =============================================== -->
                            <fo:block id="TheVeryLastPage" font-size="0pt"
                                line-height="0pt" space-after="0pt"/>
                        </fo:flow>
                    </fo:page-sequence>
                </fo:root>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes"><xsl:value-of
                        select="normalize-space('PDF
                        element not present in file. No PDF
                        generated.')"
                    />.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/dw-document/*/title">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- Document title (and series-title) -->
        <fo:block space-before="{$title-space-before}" space-after="{$title-space-after}"
            font-size="{$title-font-size}" text-align="start">
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:apply-templates select="//series-title"/>
            <xsl:apply-templates select="*[not(self::alttoc)]|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
  trademark Template - a single resource
  =============================================== -->
    <xsl:template match="dw-document//trademarks">
        <xsl:for-each select="trademark">
            <fo:block space-after="{$minimum-space-after}" text-align="start">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:for-each>
    </xsl:template>

    <!-- ============================================
	The XML <em> and <i> elements are rendered as light gray and italic (if possible).
	=============================================== -->
    <!-- Rewrite Feb 2011 ibs  -->
    <xsl:template match="em|i">
        <fo:inline>
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <xsl:template name="explicit-width-in-percentage">
        <xsl:param name="table-width-value-export" select="0"/>
        <xsl:variable name="percent-to-add">
            <xsl:choose>
                <xsl:when test="contains(@width, '%')">
                    <xsl:value-of select="normalize-space(substring-before(@width, '%')) "
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="raw-width-in-mm">
                        <xsl:call-template name="convert-measurement-units">
                            <xsl:with-param name="in-value"
                                select="normalize-space(@width)"/>
                            <xsl:with-param name="to-units" select=" $to-mm "/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of
                        select="(($raw-width-in-mm div
                        $table-width-value-export) * 100)"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="percent-lower-down">
            <xsl:choose>
                <xsl:when test="following-sibling::*[normalize-space(@width) != '']">
                    <xsl:for-each
                        select="following-sibling::*[normalize-space(@width) !=
                        ''][1]">
                        <xsl:call-template name="explicit-width-in-percentage">
                            <xsl:with-param name="table-width-value-export"
                                select="$table-width-value-export"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="round($percent-to-add + $percent-lower-down)"/>

    </xsl:template>

    <!-- ============================================
        Clean up certain well-know ancient issues.
    =============================================== -->
    <xsl:template name="Fix-External-URL">
        <!-- 5.2 10/29/05 tdc:  Change www-105., www-106., & www-136. to www -->
        <xsl:variable name="url-with-corrections">
            <xsl:choose>
                <!-- 6.0 Maverick R3 2010-12-09 ibs: Updated anchor href code to check for and fix an invalid Boulder URL -->
                <!-- If href has an invalid Boulder URL -->
                <xsl:when test="contains(.,'//download.boulder.ibm.com/ibmdl/pub/')">
                    <xsl:call-template name="ReplaceSubstring">
                        <xsl:with-param name="original" select="."/>
                        <xsl:with-param name="substring"
                            select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
                        <xsl:with-param name="replacement"
                            select="'//public.dhe.ibm.com/'"/>
                    </xsl:call-template>
                </xsl:when>
                <!-- 6.0 Maverick R3 2010-12-09 ibs: Reversed order of
                                           remaining when and otherwise to eliminate negative logic. -->
                <xsl:when
                    test="contains(.,'www-105') or
                    contains(.,'www-106') or                     contains(.,'www-136')">
                    <!-- Change the href value - it's invalid -->
                    <xsl:variable name="bad-server-href">
                        <xsl:choose>
                            <xsl:when test="contains(.,'www-105')">
                                <xsl:text>www-105</xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(.,'www-106')">
                                <xsl:text>www-106</xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(.,'www-136')">
                                <xsl:text>www-136</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:call-template name="ReplaceSubstring">
                        <xsl:with-param name="original" select="."/>
                        <xsl:with-param name="substring" select="$bad-server-href"/>
                        <xsl:with-param name="replacement" select="'www'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Don't change the href value - it's valid -->
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="generate-correct-url-form">
            <xsl:with-param name="input-url" select="$url-with-corrections"/>
        </xsl:call-template>
    </xsl:template>

    <!-- ============================================
        Forum URL. Put in link and appropriate translated text string.
        =============================================== -->
    <xsl:template match="forum-url">
        <xsl:call-template name="bulleted-item"/>
    </xsl:template>

    <xsl:template name="FrontMatter">
        <fo:block>
            <fo:inline id="TableOfContents"/>
        </fo:block>
        <xsl:apply-templates select="title"/>
        <xsl:apply-templates select="subtitle"/>
        <fo:table table-layout="fixed" width="{$dw-page-center-column-width-as-mm}">
            <fo:table-column column-width="60%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:apply-templates select="author" mode="author-link"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="end">
                            <xsl:apply-templates select="//@skill-level"/>
                            <xsl:apply-templates select="date-published"/>
                            <xsl:apply-templates select="date-translated"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>

        <fo:block-container border-style="solid" border-width="1pt"
            space-before="{$default-space-before}">
            <xsl:apply-templates select="abstract-extended|abstract"/>
            <!--  <fo:block margin="2mm">-->
            <xsl:apply-templates select="series/series-url"/>
            <!-- </fo:block>-->
        </fo:block-container>
    </xsl:template>

    <!-- =====================================================
        generate Bookmarks template
        ======================================================= -->
    <!-- Rewrite Feb 2011 ibs  -->
    <!-- Note bookmark contents are pretty limited. Cannot use superscript or subscript.
        White space is not handled well, so we just use our mode="no-escaping" templates
        to extract the plain text without any decoration (bold, italic, super, sub, etc).
    -->
    <xsl:template name="generate-bookmarks">
        <fo:bookmark-tree>
            <fo:bookmark internal-destination="TableOfContents">
                <fo:bookmark-title>
                    <xsl:value-of select="$pdfTableOfContents"/>
                </fo:bookmark-title>
            </fo:bookmark>
            <xsl:choose>
                <xsl:when test="/dw-document/dw-article">
                    <xsl:apply-templates select="//heading[@type='major'] "
                        mode="generate-bookmarks"/>
                </xsl:when>
                <xsl:when test="/dw-document/dw-tutorial">
                    <xsl:apply-templates select="//dw-tutorial/section/title"
                        mode="generate-bookmarks"/>
                </xsl:when>
            </xsl:choose>
            <xsl:if
                test="/dw-document//target-content-file or
                /dw-document//target-content-page">
                <fo:bookmark>
                    <xsl:attribute name="internal-destination">
                        <xsl:text>download</xsl:text>
                    </xsl:attribute>
                    <fo:bookmark-title>
                        <xsl:value-of select="$downloads-heading"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <!--  Put the resources  link into bookmark -->
            <xsl:if test="/dw-document//resources|/dw-document//resource-list">
                <fo:bookmark>
                    <xsl:attribute name="internal-destination">
                        <xsl:text>resources</xsl:text>
                    </xsl:attribute>
                    <fo:bookmark-title>
                        <xsl:value-of select="$resource-list-heading"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="normalize-space(/dw-document//author/bio)!=''">
                <fo:bookmark>
                    <xsl:attribute name="internal-destination">
                        <xsl:text>author-bio</xsl:text>
                    </xsl:attribute>
                    <fo:bookmark-title>
                        <xsl:choose>
                            <xsl:when test="count(//author) = 1">
                                <xsl:value-of select="$aboutTheAuthor"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$aboutTheAuthors"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
            <xsl:if test="/dw-document//trademarks">
                <fo:bookmark>
                    <xsl:attribute name="internal-destination">
                        <xsl:text>trademarks</xsl:text>
                    </xsl:attribute>
                    <fo:bookmark-title>
                        <xsl:value-of select="$pdfTrademarks"/>
                    </fo:bookmark-title>
                </fo:bookmark>
            </xsl:if>
        </fo:bookmark-tree>
    </xsl:template>

    <xsl:template name="GenerateHeadingId">
        <xsl:variable name="myType" select="@type"/>
        <!-- 2012-02-27 IBS Updated to add unique id if our generated name is already used in XML -->
        <xsl:variable name="this-anchor">
            <xsl:choose>
                <xsl:when test="@refname and (normalize-space(@refname) != '')">
                    <xsl:value-of select="normalize-space(@refname)"/>
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1]/self::a[@name != '']">
                    <!-- We didn't have a refname but we immediately follow a named anchor -->
                    <xsl:value-of select="normalize-space(preceding-sibling::*[1]/@name)"
                    />
                </xsl:when>
                <xsl:when test="self::title and ../self::section">
                    <!-- 2012-02-27 IBS Correct erroneous code that always generated the same name -->
                    <xsl:value-of select=" 'section-' "/>
                    <xsl:number count="//section/title" level="any"/>
                </xsl:when>
                <xsl:when test="@type = 'major'">
                    <xsl:value-of select=" 'head-' "/>
                    <xsl:number count="heading[@type=$myType]" format="1" level="any"/>
                </xsl:when>
                <xsl:when test="@type = 'minor'">
                    <xsl:value-of select=" 'head-' "/>
                    <xsl:number count="heading[@type='major']" format="1." level="any"/>
                    <xsl:number count="heading[@type=$myType]" format="1" level="any"
                        from="heading[@type='major']"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@type"/>
                    <xsl:number count="heading[@type=$myType]" format="1" level="any"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="target-key"
            select="key('target-names', $this-anchor) |
            key('target-refnames', $this-anchor) | key('target-downloads',
            $this-anchor) | key('target-resources', $this-anchor)"/>
        <xsl:variable name="target-key-count" select="count($target-key)"/>
        <xsl:value-of select="$this-anchor"/>
        <xsl:if
            test="($target-key-count != 0) and not(@refname and
            (normalize-space(@refname) != ''))">
            <!-- 2012-02-27 IBS If we generated a refname adn it's not unique, add a uniqueness suffix -->
            <xsl:value-of select="concat('-',generate-id())"/>
        </xsl:if>
    </xsl:template>

    <!-- ibs 2010-12-10 (from dw-common-6.0 2010-07-22) Generate automatic part of heading 
    text for listings, tables and figures. Specify add-space="yes" to add a trailing period and 
    space. 
    Default is to generate for the current heading context, unless for-heading specifies
    a different heading (e.g. for target of xref or link).
-->
    <!-- ============================================
   heading - this is a special one.  Major headings are bookmark
   links and the section and heading positions are used for the ID
    ============================================== -->
    <xsl:template match="heading">
        <fo:block space-after.optimum="{$heading-space-after}" keep-with-next="always">
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:attribute name="id">
                <xsl:call-template name="GenerateHeadingId"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@type='major'">
                    <xsl:attribute name="font-size">
                        <xsl:value-of select="$major-heading-font-size"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="font-size">
                        <xsl:value-of select="$heading-font-size"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@type='sidebar' ">
                    <xsl:attribute name="space-before.optimum">
                        <xsl:value-of select="0"/>
                    </xsl:attribute>
                    <!-- llk sidebars in html rendering are not centered -->
                    <!--<xsl:attribute name="text-align">
                        <xsl:value-of select=" 'center' "/>
                    </xsl:attribute>-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="space-before.optimum">
                        <xsl:value-of select="$heading-space-before"/>
                    </xsl:attribute>
                    <xsl:attribute name="text-align">
                        <xsl:value-of select=" 'start' "/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:call-template name="heading-auto">
                <xsl:with-param name="add-space" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="heading[@type='major'] " mode="generate-bookmarks">
        <fo:bookmark>
            <xsl:attribute name="internal-destination">
                <xsl:call-template name="GenerateHeadingId"/>
            </xsl:attribute>
            <fo:bookmark-title>
                <xsl:variable name="head-text">
                    <xsl:apply-templates mode="no-escaping"/>
                </xsl:variable>
                <xsl:value-of select="normalize-space($head-text)"/>
            </fo:bookmark-title>
            <xsl:variable name="major-headings-so-far"
                select="count(.|preceding::heading[@type='major'])"/>
            <xsl:apply-templates
                select="../heading[@type='minor'][count(preceding::heading[@type='major'])
                = $major-headings-so-far ]"
                mode="generate-bookmarks"/>
        </fo:bookmark>
    </xsl:template>

    <xsl:template match="heading[@type='minor'] " mode="generate-bookmarks">
        <fo:bookmark>
            <xsl:attribute name="internal-destination">
                <xsl:call-template name="GenerateHeadingId"/>
            </xsl:attribute>
            <fo:bookmark-title>
                <xsl:variable name="head-text">
                    <xsl:apply-templates mode="no-escaping"/>
                </xsl:variable>
                <xsl:value-of select="normalize-space($head-text)"/>
            </fo:bookmark-title>
        </fo:bookmark>
    </xsl:template>

    <!-- RFE 14215 01/15/13 jmh: incorporate Ian S enhancement to support text headings -->
    <xsl:template name="heading-auto">
        <xsl:param name="for-heading" select="."/>
        <xsl:param name="add-space" select="'no'"/>
        <xsl:param name="quote-text" select=" 'no' "/>
        <xsl:variable name="is-text-heading" select="$for-heading/@type = 'major' or $for-heading/@type = 'minor' 
            or $for-heading/@type = 'sidebar' or $for-heading[self::title and
            parent::section] "></xsl:variable>
        <xsl:if
            test="(/dw-document/*/@auto-number='yes') and ($for-heading/@type =
            'figure'  or $for-heading/@type = 'code' or $for-heading/@type = 'table' 
            or $is-text-heading) ">
            <xsl:variable name="heading-number"
                select="count($for-heading|$for-heading/preceding::heading[@type =
                $for-heading/@type])"/>
            <xsl:variable name="end-space">
                <xsl:if test="$add-space = 'yes'">
                    <xsl:value-of select=" '. '"/>
                </xsl:if>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$for-heading/@type = 'figure' ">
                    <xsl:value-of
                        select="normalize-space(concat($heading-figure-lead,
                        $heading-number, $heading-figure-trail))"
                    />
                </xsl:when>
                <xsl:when test="$for-heading/@type = 'code' ">
                    <xsl:value-of
                        select="normalize-space(concat($heading-code-lead,
                        $heading-number, $heading-code-trail))"
                    />
                </xsl:when>
                <xsl:when test="$for-heading/@type = 'table' ">
                    <xsl:value-of
                        select="normalize-space(concat($heading-table-lead,
                        $heading-number, $heading-table-trail))"
                    />
                </xsl:when>
                <xsl:when
                    test="$is-text-heading">
                    <xsl:if test="$quote-text = 'yes' ">
                        <xsl:apply-templates select="$for-heading/text()|$for-heading/*"/>
                    </xsl:if>
                </xsl:when>
            </xsl:choose>
            <xsl:if
                test="$add-space = 'yes' and ($for-heading/@type ='figure' 
                or $for-heading/@type = 'code' or $for-heading/@type = 'table' ) ">
                <xsl:value-of select=" '. ' "/>
            </xsl:if>
        </xsl:if>
    </xsl:template>


    <!-- 5.12 ibs/ddh 02/19/2010: DR #002932 Code to add missing author photo -->
    <!-- ============================================
    For the <img> element, we use the src attribute
    as it comes from HTML, except that we add any necessary
    protocol info for protocol-independent URLS and similarly
    fix up one referring to /developerworks. (5.12 ibs 2010-03-25 added P-I URLs 
    and /developerworks - completion of DR #002932)
    We also check for any width and height attributes. 
   =============================================== -->
    <xsl:template match="img">
        <xsl:param name="scaling-factor" select="0.72"/>
        <fo:inline>
            <fo:external-graphic src="{@src}">
                <xsl:if test="not(ancestor::figure)">
                    <xsl:attribute name="alignment-adjust">middle</xsl:attribute>
                </xsl:if>
                <!-- 2012-02-27 IBS Align inline (or non-figure) images with center of
                    text. -->
                <xsl:if test="not(ancestor::figure)">
                    <xsl:attribute name="alignment-baseline">middle</xsl:attribute>
                </xsl:if>
                <xsl:if test="@alt != ''">
                    <xsl:attribute name="fox:alt-text">
                        <xsl:value-of select="normalize-space(@alt)"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="src">
                    <xsl:choose>
                        <xsl:when test="starts-with(@src, '/developerworks/') ">
                            <xsl:value-of select="concat('http://www.ibm.com', @src)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@src, '//') ">
                            <xsl:value-of select="concat('http:', @src)"/>
                        </xsl:when>
                        <xsl:when test="contains(@src,':/')">
                            <!-- Must have a protocol -->
                            <xsl:value-of select="@src"/>
                        </xsl:when>
                        <xsl:when
                            test="($image-url-base != '') and not(starts-with(@src,
                            '/' ))">
                            <xsl:choose>
                                <xsl:when
                                    test="(substring($image-url-base,
                                    string-length($image-url-base)) = '/') or
                                    (substring($image-url-base,
                                    string-length($image-url-base)) = '\')">
                                    <xsl:value-of select="concat($image-url-base, @src)"/>
                                </xsl:when>
                                <xsl:when test="contains($image-url-base, '\')">
                                    <xsl:value-of
                                        select="concat($image-url-base, '\',
                                        @src)"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="concat($image-url-base, '/',
                                        @src)"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@src"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:if test="@width">
                    <xsl:variable name="width-px">
                        <xsl:choose>
                            <xsl:when test="contains(@width, 'px')">
                                <xsl:value-of
                                    select="normalize-space(substring-before(@width,
                                    'px'))"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@width"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:attribute name="content-width">
                        <xsl:value-of
                            select="concat(round($width-px * $scaling-factor),
                            'px')"
                        />
                    </xsl:attribute>
                    <xsl:attribute name="width">
                        <xsl:value-of
                            select="concat(round($width-px * $scaling-factor),
                            'px')"
                        />
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@height">
                    <xsl:variable name="height-px">
                        <xsl:choose>
                            <xsl:when test="contains(@height, 'px')">
                                <xsl:value-of
                                    select="normalize-space(substring-before(@height,
                                    'px'))"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@height"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:attribute name="height">
                        <xsl:value-of
                            select="concat(round($height-px * $scaling-factor),
                            'px')"
                        />
                    </xsl:attribute>
                    <xsl:attribute name="content-height">
                        <xsl:value-of
                            select="concat(round($height-px * $scaling-factor),
                            'px')"
                        />
                    </xsl:attribute>
                </xsl:if>
            </fo:external-graphic>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    unordered or ordered lists. Special handling if one is immediate child
    of another unordered or ordered list.
    ===============================================  -->
    <xsl:template match="ol|ul">
        <fo:list-block>
            <xsl:call-template name="SetListAttributes"/>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="self::ol or self::ul or self::dl">
                        <!-- When another list is a direct child of an ordered or
                            unordered list. Make an empty label and put this list in the
                            body of the list-item. -->
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()"
                                text-align="right">
                                <fo:block/>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <xsl:apply-templates select="."/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <!-- ============================================
    When we handle items in an ordered list, we need
    to check if the list has a start attribute.  If
    it does, we change the starting number accordingly.
    Once we've figured out where to start counting,
    we check the type attribute to see what format
    the numbers should use.  
    =============================================== -->
    <xsl:template match="ol/li">
        <fo:list-item>
            <fo:list-item-label end-indent="label-end()" text-align="right">
                <fo:block space-before="{$default-space-before}">
                    <xsl:variable name="value-attr">
                        <xsl:choose>
                            <xsl:when test="../@start">
                                <xsl:number
                                    value="count(preceding-sibling::li) +
                                    ../@start"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:number value="1 + count(preceding-sibling::li)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="../@type='i'">
                            <xsl:number value="$value-attr" format="i. "/>
                        </xsl:when>
                        <xsl:when test="../@type='I'">
                            <xsl:number value="$value-attr" format="I. "/>
                        </xsl:when>
                        <xsl:when test="../@type='a'">
                            <xsl:number value="$value-attr" format="a. "/>
                        </xsl:when>
                        <xsl:when test="../@type='A'">
                            <xsl:number value="$value-attr" format="A. "/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:number value="$value-attr" format="1. "/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- ============================================
    Your basic paragraph.
    =============================================== -->
    <xsl:template match="p">
        <!-- 5.0 8/01 tdc:  Added space-after attribute -->
        <!--  <fo:block font-family="{$default-font}"> -->
        <fo:block>
            <xsl:attribute name="space-after">
                <xsl:choose>
                    <xsl:when test="parent::li">
                        <xsl:value-of select="$minimum-space-after"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$default-space-after"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    Preformatted text is rendered in a monospaced
    font.  We also have to set the wrap-option
    and white-space-collapse properties.  
    =============================================== -->
    <xsl:template match="pre">
        <fo:block white-space-collapse="false" wrap-option="no-wrap">
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <xsl:template name="process-additional-cols">
        <xsl:param name="counter" select="1"/>
        <xsl:param name="colspan-value"/>
        <xsl:param name="default-column-width-in-percentage"/>
        <xsl:variable name="proportional-column-lead-in"
            >proportional-column-width(</xsl:variable>
        <xsl:variable name="proportional-column-end">)</xsl:variable>
        <fo:table-column>
            <xsl:attribute name="column-width">
                <xsl:value-of
                    select="concat($proportional-column-lead-in,
                    round(normalize-space(substring-before($default-column-width-in-percentage,
                    '%'))), $proportional-column-end)"
                />
            </xsl:attribute>
        </fo:table-column>
        <xsl:if test="$counter &lt; $colspan-value">
            <xsl:call-template name="process-additional-cols">
                <xsl:with-param name="counter" select="$counter +1"/>
                <xsl:with-param name="colspan-value" select="$colspan-value"/>
                <xsl:with-param name="default-column-width-in-percentage"
                    select="$default-column-width-in-percentage"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="process-col-width">
        <xsl:param name="counter" select="1"/>
        <xsl:param name="colspan-value"/>
        <xsl:param name="table-column-width-in"/>
        <xsl:param name="default-column-width-in-percentage"/>
        <xsl:param name="table-width-value-export"/>
        <xsl:variable name="proportional-column-lead-in"
            >proportional-column-width(</xsl:variable>
        <xsl:variable name="proportional-column-end">)</xsl:variable>
        <fo:table-column>
            <xsl:attribute name="column-width">
                <xsl:choose>
                    <xsl:when test="normalize-space(@width)!=''">
                        <!-- known width is either in percentage or units -->
                        <xsl:choose>
                            <xsl:when test="contains($table-column-width-in, '%')">
                                <xsl:variable name="raw-table-column-percentage-width"
                                    select="(normalize-space(substring-before($table-column-width-in,
                                    '%')))"/>
                                <xsl:value-of
                                    select="concat($proportional-column-lead-in,
                                    round($raw-table-column-percentage-width div
                                    $colspan-value), $proportional-column-end)"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="absolute-column-width">
                                    <xsl:call-template name="convert-measurement-units">
                                        <xsl:with-param name="in-value"
                                            select="$table-column-width-in"/>
                                        <xsl:with-param name="to-units"
                                            select="
                                            $to-mm "
                                        />
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:variable name="number-absolute-column-width"
                                    select="number(concat('0',
                                    normalize-space($absolute-column-width))) "/>
                                <xsl:variable name="number-table-width-value-export"
                                    select="number(concat('0',normalize-space($table-width-value-export)))"/>
                                <xsl:variable name="raw-table-column-units-percentage"
                                    select="($number-absolute-column-width div
                                    $number-table-width-value-export) * 100"/>
                                <xsl:value-of
                                    select="concat($proportional-column-lead-in,
                                    round($raw-table-column-units-percentage div
                                    $colspan-value), $proportional-column-end)"
                                />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <!-- otherwise select default column width in percentage -->
                    <xsl:otherwise>
                        <xsl:value-of
                            select="concat($proportional-column-lead-in,
                            round(normalize-space(substring-before($default-column-width-in-percentage,
                            '%'))), $proportional-column-end)"/>
                        <!--<xsl:value-of select="$default-column-width-in-percentage"/>-->
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </fo:table-column>
        <xsl:if test="$counter &lt; $colspan-value">
            <xsl:call-template name="process-col-width">
                <xsl:with-param name="counter" select="$counter +1"/>
                <xsl:with-param name="colspan-value" select="$colspan-value"/>
                <xsl:with-param name="table-column-width-in"
                    select="$table-column-width-in"/>
                <xsl:with-param name="table-width-value-export"
                    select="$table-width-value-export"/>
                <xsl:with-param name="default-column-width-in-percentage"
                    select="$default-column-width-in-percentage"/>
            </xsl:call-template>

        </xsl:if>
    </xsl:template>

    <!-- ============================================
        Resource block template - process all resources or all of one type
        (Learn, Discuss, etc).
        =============================================== -->
    <xsl:template name="Process-resource-block">
        <xsl:param name="do-forum-url" select=" 'no' "/>
        <xsl:param name="resource-block"/>
        <xsl:param name="block-header"/>
        <!-- New Mar 2011 ibs  -->
        <xsl:if test="$block-header != '' ">
            <fo:block font-size="{$heading-font-size}" text-align="start">
                <xsl:call-template name="set-font-attributes-family-weight-and-color">
                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                </xsl:call-template>
                <xsl:call-template name="SetSpace">
                    <xsl:with-param name="font-or-space-size" select="$heading-font-size"/>
                    <xsl:with-param name="check-sibling" select=" 'no' "/>
                </xsl:call-template>
                <xsl:value-of select="$block-header"/>
            </fo:block>
        </xsl:if>
        <fo:list-block space-after.minimum="0" space-after.optimum="0"
            provisional-distance-between-starts="1cm"
            provisional-label-separation="0.25cm">
            <xsl:if test="$do-forum-url = 'yes'">
                <xsl:for-each select="//forum-url[normalize-space(@url) != '']">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </xsl:if>
            <xsl:for-each select="$resource-block">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <!-- ============================================
  resource Template - a single resource
  =============================================== -->
    <xsl:template match="resource">
        <xsl:call-template name="bulleted-item"/>
    </xsl:template>

    <!-- ============================================
        Resource template - a unordered list of resources
        =============================================== -->
    <xsl:template match="resources">
        <xsl:variable name="num-resources">
            <xsl:value-of select="count(resource)"/>
        </xsl:variable>
        <!-- Note that forum URL is inlcuded in the Discuss category if multiple
            categories. Otherwise just included as a resource.  -->
        <xsl:variable name="num-categories"
            select="number(boolean(resource[@resource-category='Learn'])) +
            number(boolean(resource[normalize-space(@resource-category)=normalize-space('Get
            products and technologies')])) +
            number(boolean(/dw-document//forum-url[normalize-space(@url)!=''] |
            resource[@resource-category='Discuss']))"/>
        <xsl:choose>
            <!-- Subcategorize if there are > 3 resource elements and at least 2 diff. subcat's coded -->
            <xsl:when test="$num-resources &gt; 3 and  $num-categories &gt; 2">
                <xsl:if test="resource[@resource-category='Learn']">
                    <xsl:call-template name="Process-resource-block">
                        <xsl:with-param name="block-header" select="$resources-learn"/>
                        <xsl:with-param name="resource-block"
                            select="resource[@resource-category='Learn']"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if
                    test="resource[normalize-space(@resource-category)=normalize-space('Get
                    products and technologies')]">
                    <xsl:call-template name="Process-resource-block">
                        <xsl:with-param name="block-header" select="$resources-get"/>
                        <xsl:with-param name="resource-block"
                            select="resource[normalize-space(@resource-category)=normalize-space('Get
                            products and technologies')]"
                        />
                    </xsl:call-template>
                </xsl:if>
                <xsl:if
                    test="resource[@resource-category='Discuss'] or
                    (normalize-space(//forum-url/@url)!='') ">
                    <xsl:call-template name="Process-resource-block">
                        <xsl:with-param name="block-header" select="$resources-discuss"/>
                        <xsl:with-param name="resource-block"
                            select="
                            resource[@resource-category='Discuss']"/>
                        <xsl:with-param name="do-forum-url" select=" 'yes' "/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="Process-resource-block">
                    <xsl:with-param name="resource-block" select="resource"/>
                    <xsl:with-param name="do-forum-url" select=" 'yes' "/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ===========================================
        Section Template
        ============================================= -->
    <xsl:template match="section">
        <xsl:apply-templates select="title"/>
        <xsl:apply-templates select="docbody"/>
        <xsl:if test="following-sibling::section">
            <fo:block>
                <xsl:call-template name="SetSpace">
                    <xsl:with-param name="font-or-space-size" select="$default-font-size"
                    />
                </xsl:call-template>
                <fo:leader leader-pattern="rule" leader-length="100%"/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="section/title" mode="generate-bookmarks">
        <fo:bookmark>
            <xsl:attribute name="internal-destination">
                <xsl:call-template name="GenerateHeadingId"/>
            </xsl:attribute>
            <fo:bookmark-title>
                <xsl:variable name="head-text">
                    <xsl:choose>
                        <xsl:when test="alttoc != ''">
                            <xsl:apply-templates select="alttoc" mode="no-escaping"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="*[not(self::alttoc)]|text()"
                                mode="no-escaping"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="normalize-space($head-text)"/>
            </fo:bookmark-title>
            <xsl:apply-templates
                select="following-sibling::docbody[1]/heading[@type='major']"
                mode="generate-bookmarks"/>
        </fo:bookmark>
    </xsl:template>

    <!-- ===========================================
        Section Title Template
        ============================================= -->
    <xsl:template match="section/title">
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block font-size="{$section-title-font-size}" font-weight="bold"
            text-align="start">
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:call-template name="SetSpace">
                <xsl:with-param name="font-or-space-size"
                    select="$section-title-font-size"/>
                <xsl:with-param name="check-sibling" select=" 'no' "/>
            </xsl:call-template>
            <xsl:attribute name="id">
                <xsl:call-template name="GenerateHeadingId"/>
            </xsl:attribute>
            <xsl:value-of select="$pdfSection"/>
            <xsl:text> </xsl:text>
            <xsl:number count="section" level="single" format="1"/>
            <xsl:text>. </xsl:text>
            <xsl:comment>Section heading test</xsl:comment>
            <xsl:apply-templates select="*[not(self::alttoc)]|text()" mode="no-escaping"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="series/series-url">
      <!-- Add check for content, Sep 2012 ITO -->
      <xsl:if test="normalize-space(.) != ''">
        <!-- series-view -->
        <fo:block margin="2mm">
            <xsl:call-template name="SetSpaceBefore">
                <xsl:with-param name="font-or-space-size" select="$default-font-size"/>
            </xsl:call-template>

            <fo:basic-link color="{$external-link-color}">
                <xsl:attribute name="external-destination">
                    <xsl:call-template name="Fix-External-URL"/>
                </xsl:attribute>
                <xsl:value-of select="$series-view"/>
            </fo:basic-link>
        </fo:block>
      </xsl:if>
    </xsl:template>

    <xsl:template match="series-title">
      <!-- Add check for content, Sep 2012 ITO -->

      <!-- TODO: Do entity handling on the series title (ITO)
      <xsl:variable name="series-title-text">
        <xsl:apply-templates select="text" mode="no-escaping"/>
      </xsl:variable>-->
      <!-- Actually, this is not needed because the template
           itself is called with no-escaping; entities work in 
	   here with node() below -->

      <xsl:if test="normalize-space(.) != ''">

        <!-- Rewrite Feb 2011 ibs  -->
        <fo:inline color="{$series-color}">
            <xsl:apply-templates select="node()"/> 
            <xsl:text>: </xsl:text>
        </fo:inline>
      </xsl:if>
    </xsl:template>

    <xsl:template name="set-font-attributes-family-weight-and-color">
        <xsl:param name="isHeading" select=" 'no' "/>
        <xsl:variable name="isMonoSpace"
            select="($isHeading = 'no') and
            (ancestor-or-self::code|ancestor-or-self::pre|ancestor-or-self::tt)"/>
        <xsl:variable name="isItalic" select="ancestor-or-self::em|ancestor-or-self::i"/>
        <xsl:variable name="isBold"
            select="($isHeading = 'yes' ) or
            (ancestor-or-self::strong|ancestor-or-self::b|ancestor-or-self::title|ancestor-or-self::subtitle|ancestor-or-self::heading)"/>
        <xsl:choose>
            <xsl:when test="$isMonoSpace">
                <!-- Monospace font -->
                <xsl:choose>
                    <xsl:when test="$isItalic and $isBold">
                        <!-- mono-italic-bold -->
                        <xsl:if test="$monospace-font-italic-bold">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$monospace-font-italic-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$monospace-font-color-italic-bold">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$monospace-font-color-italic-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="font-weight">
                            <xsl:value-of select=" 'bold' "/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$isItalic">
                        <!-- mono-italic-regular -->
                        <xsl:if test="$monospace-font-italic">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$monospace-font-italic"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$monospace-font-color-italic">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$monospace-font-color-italic"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="$isBold">
                        <!-- mono-regular-bold -->
                        <xsl:if test="$monospace-font-bold">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$monospace-font-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="font-weight">
                            <xsl:value-of select=" 'bold' "/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- mono-regular-regular -->
                        <xsl:if test="$monospace-font">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$monospace-font"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$monospace-font-color">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$monospace-font-color"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- default font -->
                <xsl:choose>
                    <xsl:when test="$isItalic and $isBold">
                        <!-- default-italic-bold -->
                        <xsl:if test="$default-font-italic-bold">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$default-font-italic-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$default-font-color-italic-bold">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$default-font-color-italic-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="$isItalic">
                        <!-- default-italic-regular -->
                        <xsl:if test="$default-font-italic">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$default-font-italic"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$default-font-color-italic">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$default-font-color-italic"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="$isBold">
                        <!-- default-regular-bold -->
                        <xsl:if test="$default-font-bold">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$default-font-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$default-font-color-bold">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$default-font-color-bold"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="font-weight">
                            <xsl:value-of select=" 'bold' "/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- default-regular-regular -->
                        <xsl:if test="$default-font">
                            <xsl:attribute name="font-family">
                                <xsl:value-of select="$default-font"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$default-font-color">
                            <xsl:attribute name="color">
                                <xsl:value-of select="$default-font-color"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================
    Process either and ordered or unordered list. This is a service 
    routine that avoids duplication of code in the match="ol|ul" template
    when one of these lists is a direct child of another such list.
    =============================================== -->
    <xsl:template name="SetListAttributes">
        <xsl:if test="not(ancestor::ol|ancestor::ul)">
            <!-- What is specified here at top-level lists will be
                inherited by children, so don't bother to repeat it. -->
            <xsl:attribute name="provisional-distance-between-starts">
                <xsl:value-of select=" '1cm' "/>
            </xsl:attribute>
            <xsl:attribute name="provisional-label-separation">
                <xsl:value-of select=" '0.25cm' "/>
            </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="SetSpaceAfter"/>
    </xsl:template>

    <xsl:template name="SetSpace">
        <xsl:param name="font-or-space-size" select="$default-font-size"/>
        <xsl:param name="check-sibling" select=" 'yes' "/>
        <xsl:call-template name="SetSpaceBefore">
            <xsl:with-param name="font-or-space-size" select="$font-or-space-size"/>
            <xsl:with-param name="check-sibling" select="$check-sibling"/>
        </xsl:call-template>
        <xsl:call-template name="SetSpaceAfter">
            <xsl:with-param name="font-or-space-size" select="$font-or-space-size"/>
            <xsl:with-param name="check-sibling" select="$check-sibling"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="SetSpaceAfter">
        <xsl:param name="check-sibling" select=" 'yes' "/>
        <xsl:param name="font-or-space-size" select="$default-font-size"/>
        <xsl:variable name="adjusted-font-or-space-size">
            <xsl:call-template name="AdjustSpaceForContainer">
                <xsl:with-param name="font-or-space-size" select="$font-or-space-size"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="spacer-font-size">
            <xsl:choose>
                <xsl:when test="following-sibling::* or ($check-sibling = 'no' )">
                    <xsl:value-of select="$adjusted-font-or-space-size"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Last element inside some container, (list, table cell, sidebar
                        or whatever), so allow the container to handle the following space
                    -->
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="space-variation"
            select="round($spacer-font-size *
            0.5)"/>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="concat($spacer-font-size, 'pt')"/>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of
                select="concat($spacer-font-size - $space-variation,
                'pt')"
            />
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of
                select="concat($spacer-font-size + $space-variation,
                'pt')"
            />
        </xsl:attribute>
    </xsl:template>

    <xsl:template name="SetSpaceBefore">
        <xsl:param name="check-sibling" select=" 'yes' "/>
        <xsl:param name="font-or-space-size" select="$default-font-size"/>
        <xsl:variable name="adjusted-font-or-space-size">
            <xsl:call-template name="AdjustSpaceForContainer">
                <xsl:with-param name="font-or-space-size" select="$font-or-space-size"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="spacer-font-size">
            <xsl:choose>
                <xsl:when test="preceding-sibling::* or ($check-sibling = 'no' )">
                    <xsl:value-of select="$adjusted-font-or-space-size"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- First element inside some container, (list, table cell, sidebar
                        or whatever), so allow the container to handle the preceding space
                    -->
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="space-variation"
            select="round($spacer-font-size *
            0.5)"/>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="concat($spacer-font-size, 'pt')"/>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of
                select="concat($spacer-font-size - $space-variation,
                'pt')"
            />
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">
            <xsl:value-of
                select="concat($spacer-font-size + $space-variation,
                'pt')"
            />
        </xsl:attribute>
    </xsl:template>

    <!-- =================================
        Sidebar template. 
        ==================================== -->
    <xsl:template match="sidebar">
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block text-align="left" font-size="{$sidebar-font-size}"
            background-color="{$sidebar-background-color}" margin-left="50mm">
            <xsl:call-template name="SetSpace"/>
            <!-- Leave a shaded border around the text.  -->
            <fo:block margin="2mm">
                <xsl:apply-templates select="*|text()"/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="//@skill-level">
        <!-- Rewrite Feb 2011 ibs  -->
        <!-- Skill Level -->
        <fo:block space-after="{$default-space-after}">
            <xsl:value-of select="$pdfSkillLevel"/>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="SkillLevelText"/>
        </fo:block>
    </xsl:template>
    
    <!-- =================================
     Sidebar-custom template. 
     ==================================== -->
    <!-- 06/12/12 JMH add support for sidebar-custom element -->
    <xsl:template match="sidebar-custom">
        <xsl:choose>
            <xsl:when test="@type='knowledge-path'">
                <xsl:if
                    test="normalize-space(related-resource/text) and normalize-space(related-resource/url)">
                    <fo:block text-align="left" font-size="{$sidebar-font-size}"
                        background-color="{$sidebar-background-color}" margin-left="50mm"
                        space-before.optimum="{$default-space-before}"
                        space-before.minimum="6pt" space-before.maximum="18pt">
                        <xsl:call-template name="SetSpace"/>
                        <fo:block margin="2mm">
                            <fo:block space-after="2pt" font-size="{$heading-font-size}"
                                text-align="start">
                                <xsl:call-template
                                    name="set-font-attributes-family-weight-and-color">
                                    <xsl:with-param name="isHeading" select=" 'yes' "/>
                                </xsl:call-template>
                                <xsl:value-of select="$knowledge-path-heading"/>
                            </fo:block>
                            <xsl:choose>
                                <xsl:when test="count(related-resource) > 1">
                                    <fo:block>
                                        <xsl:value-of select="$knowledge-path-text-multiple"/>
                                    </fo:block>
                                    <fo:list-block>
                                        <xsl:for-each select="related-resource">
                                            <fo:list-item>
                                                <fo:list-item-label end-indent="label-end()"
                                                 text-align="right">
                                                 <fo:block>
                                                 <xsl:value-of
                                                 select="concat( '&#8226;', $nbsp)"/>
                                                 </fo:block>
                                                </fo:list-item-label>
                                                <fo:list-item-body start-indent="body-start()">
                                                 <fo:block>
                                                 <fo:basic-link>
                                                 <xsl:attribute name="external-destination">
                                                 <xsl:value-of select="url">
                                                 </xsl:value-of>
                                                 </xsl:attribute>
                                                 <xsl:attribute name="color">
                                                 <xsl:value-of select="$external-link-color"/>
                                                 </xsl:attribute>
                                                 <xsl:variable name="related-resource-text">
                                                 <xsl:apply-templates select="text" mode="no-escaping"/>
                                                 </xsl:variable>
                                                 <xsl:value-of select="normalize-space($related-resource-text)"/>
                                                 </fo:basic-link>
                                                 </fo:block>
                                                </fo:list-item-body>
                                            </fo:list-item>
                                        </xsl:for-each>
                                    </fo:list-block>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:block>
                                        <xsl:value-of select="concat($knowledge-path-text, ' ')"/>
                                        <fo:basic-link>
                                            <xsl:attribute name="external-destination">
                                                <xsl:value-of select="related-resource/url">
                                                </xsl:value-of>
                                            </xsl:attribute>
                                            <xsl:attribute name="color">
                                                <xsl:value-of select="$external-link-color"/>
                                            </xsl:attribute>
                                            <xsl:variable name="related-resource-text">
                                                <xsl:apply-templates
                                                 select="related-resource/text"
                                                 mode="no-escaping"/>
                                            </xsl:variable>
                                            <xsl:value-of select="normalize-space($related-resource-text)"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:block>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================
    The <small> element is rendered with a relative
    font size.  That means putting one <small>
    element inside another creates really small 
    text.  
    =============================================== -->
    <xsl:template match="small">
        <fo:inline font-size="80%">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    For strikethrough text, we use the text-decoration
    property.  
    =============================================== -->
    <xsl:template match="strike">
        <fo:inline text-decoration="line-through">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    Strongly emphasized text and bold text are simply rendered
    in bold. Unless ancestor is a heading, caption or title.
    =============================================== -->
    <!-- Rewrite Feb 2011 ibs  -->

    <xsl:template match="strong|b">
        <xsl:choose>
            <xsl:when test="ancestor::heading|ancestor::title|ancestor::caption">
                <xsl:apply-templates select="*|text()"/>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
                    <xsl:apply-templates select="*|text()"/>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================
    For subscript text, we use the vertical-align
    property and decrease the font size.  
    =============================================== -->
    <xsl:template match="sub">
        <fo:inline vertical-align="sub" font-size="75%">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="subtitle">
        <!-- Subtitle -->
        <!-- Rewrite Feb 2011 ibs  -->
        <fo:block space-after="{$maximum-space-after}" font-size="{$subtitle-font-size}"
            text-align="start">
            <xsl:call-template name="set-font-attributes-family-weight-and-color">
                <xsl:with-param name="isHeading" select=" 'yes' "/>
            </xsl:call-template>
            <xsl:apply-templates select="*|text()"/>

        </fo:block>
    </xsl:template>

    <!-- ============================================
    Superscript text changes the vertical-align
    property also, and uses a smaller font.
    =============================================== -->
    <xsl:template match="sup">
        <fo:inline vertical-align="super" font-size="75%">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>
    <!-- ============================================
    Tables are a hassle.  The main problem we have
    is converting the td elements into some 
    number of <fo:table-column> elements.  We do 
    this recursively with a named template called build-columns.
    Once we've processed the cols attribute, we 
    invoke all of the templates for the children 
    of this element. 
    
    This template really doesn't do anything.. it sorts rows by # of th's and td's and then counts the number of th's in row of position (1)
        =============================================== -->
    <!-- llk removed max_rows template -->

    <!-- ============================================
    This template generates an <fo:table-column>
    element for each th of
    the HTML <table> tag.  The template processes
    the first counter, then invokes itself with the 
    rest of the count. 
    
    Rewrite as recursive template column 1-n
    =============================================== -->
    <!-- llk removed build-columns-old template -->

    <!-- here is the table code for Leah -->
    <xsl:template match="table" name="table">

        <xsl:variable name="table-nest-level"
            select="count(ancestor::*[name() = 'ul' or
            name() = 'ol'  or name() = 'dl'])"/>
        <xsl:variable name="nested-table-indent-amount" select="(12.7*$table-nest-level)"/>
        <xsl:variable name="modified-dw-page-center-column-width"
            select="$dw-page-center-column-width - $nested-table-indent-amount"/>
        <!-- Assume all tables must have at least one tr, thead or tfoot -->
        <xsl:if test="thead|tr|tfoot">
            <xsl:variable name="max-columns">
                <xsl:call-template name="table-count-columns"/>
            </xsl:variable>
            <xsl:variable name="table-width-value">
                <xsl:variable name="table-width-requested">
                    <xsl:choose>
                        <!-- if width is not null, grab the width value and normalize spacing.  this is the width of table defined in xml -->
                        <xsl:when test="normalize-space(@width)!=''">
                            <xsl:variable name="table-width-in"
                                select="normalize-space(@width)"/>
                            <xsl:choose>
                                <xsl:when test="contains($table-width-in, '%')">
                                    <xsl:value-of
                                        select="ceiling($modified-dw-page-center-column-width
                                        *
                                        normalize-space(substring-before($table-width-in,
                                        '%'))) div 100"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <!-- if table width is not in percentage, call this template from xslt-utilities
                                        where the "in-value" parameter of this template is the table width value, including units, 
                                        the request is to convert this into mm units "$to-mm"  -->

                                    <xsl:call-template name="convert-measurement-units">
                                        <xsl:with-param name="in-value"
                                            select="$table-width-in"/>
                                        <xsl:with-param name="to-units"
                                            select="
                                            $to-mm "
                                        />
                                    </xsl:call-template>


                                </xsl:otherwise>
                            </xsl:choose>
                            <!-- if you do not have a table width defined, assume, the table is going to be the width of the center column -->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$modified-dw-page-center-column-width"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                    <!-- Putting this choice here allows for oversize absolute widths plus
                        percentages over 100%  or for tables with negative width or less
                        than 25mm in width -->
                    <xsl:when
                        test="($table-width-requested &gt;
                        $modified-dw-page-center-column-width) or ($table-width-requested
                        &lt; 25)">
                        <xsl:value-of select="$modified-dw-page-center-column-width"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$table-width-requested"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <!-- lk added new variable to append mm to end of the table width values -->
            <xsl:variable name="pdf-table-final-width">
                <xsl:value-of select="concat($table-width-value, $to-mm)"/>
            </xsl:variable>
            <!-- need to find the default width of columns to set up underlying table structure -->
            <xsl:variable name="column-default-width">
                <xsl:call-template name="column-default-width-setup">
                    <xsl:with-param name="table-width-value-export"
                        select="$table-width-value"/>
                    <xsl:with-param name="max-columns" select="$max-columns"/>
                </xsl:call-template>
            </xsl:variable>


            <!-- lk added new variable to append mm to end of table width values -->
            <!-- <fo:table table-layout="fixed" border="1pt solid #efefef" width="{$pdf-table-final-width}"> -->
            <!-- llk - add start-indent="0" to fo:table layout for appropriate indentation of nested tables -->
            <!-- llk added keep.together of 5, need to talk to ian about this setting -->
            <fo:table table-layout="fixed" border="1pt solid #efefef"
                space-after.optimum="{$default-space-after}"
                margin-bottom="{$default-space-after}" keep-together.within-page="5">
                <xsl:attribute name="width">
                    <xsl:value-of select="concat($table-width-value, $to-mm)"/>
                </xsl:attribute>



                <xsl:call-template name="build-columns">
                    <xsl:with-param name="table-width-value-export"
                        select="$table-width-value"/>
                    <xsl:with-param name="max-columns" select="$max-columns"/>
                    <xsl:with-param name="default-column-width-in-percentage"
                        select="concat($column-default-width, '%')"/>
                </xsl:call-template>

                <fo:table-body>
                    <xsl:apply-templates select="caption">
                        <xsl:with-param name="max-columns" select="$max-columns"/>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="tr"/>
                    <xsl:apply-templates select="tfoot"/>
                </fo:table-body>
            </fo:table>

        </xsl:if>
    </xsl:template>

    <xsl:template name="table-count-columns">
        <xsl:for-each select="*[self::thead or self::tr or self::tfoot][1]">
            <xsl:call-template name="table-count-columns-in-row"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="table-count-columns-in-row">
        <xsl:param name="max-columns" select="0"/>
        <!-- Add the colspans that are not empty or missing and then add 1 for each
            missing or empty one -->
        <xsl:variable name="row-columns"
            select="sum(*/@colspan) +
            count(*[not(@colspan) or (@colspan='')])"/>
        <!-- See which row index I am -->
        <xsl:variable name="my-index"
            select="count(preceding-sibling::*[self::thead or
            self::tr or self::tfoot])"/>
        <!-- Figure the number of rowspans that include this row and affect only one
            column -->
        <xsl:variable name="multi-row-single-column"
            select="count(preceding-sibling::*/*/@rowspan[((../@colspan = 0) or
            not(../@colspan)) and (. &gt; ($my-index -
            count(../../preceding-sibling::*[self::thead or self::tr or
            self::tfoot])))])"/>
        <!-- Count the number of columns that are due to spanned rows that also span
            columns -->
        <xsl:variable name="multi-row-multi-column"
            select="sum(preceding-sibling::*/*/@colspan[(. != 0) and
            (../@rowspan &gt; ($my-index -
            count(../../preceding-sibling::*[self::thead or self::tr or self::tfoot])))])"/>
        <!-- Add all the column bits that make up the total columns in this row  -->
        <xsl:variable name="columns-this-row"
            select="$row-columns +
            $multi-row-multi-column + $multi-row-single-column"/>
        <!--  Convenience variable for debugger -->
        <xsl:variable name="max-columns-so-far"
            select="$max-columns +
            ($columns-this-row &gt; $max-columns) * ($columns-this-row -
            $max-columns)"/>
        <xsl:choose>
            <!-- If more rows in table, then process the next one by recursion -->
            <xsl:when test="following-sibling::*[self::thead or self::tr or self::tfoot]">
                <xsl:for-each
                    select="following-sibling::*[self::thead or self::tr or
                    self::tfoot][1]">
                    <xsl:call-template name="table-count-columns-in-row">
                        <xsl:with-param name="max-columns" select="$max-columns-so-far"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <!-- Otherwise return the largest column count found -->
                <xsl:value-of select="$max-columns-so-far"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="target-content-file">
        <xsl:variable name="link-type">
            <xsl:choose>
                <xsl:when test="@link-method-ftp='yes'">FTP</xsl:when>
                <xsl:when test="@link-method-http='yes'">HTTP</xsl:when>
                <xsl:otherwise>FTP</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:table-row>
            <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
                padding-after="3pt">
                <fo:block font-size="{$table-cell-font-size}">
                    <xsl:value-of select="@file-description"/>
                    <!-- 5.9 08/27/07 tdc:  Add superscript for note (DR 2182)-->
                    <xsl:if test="normalize-space(note)!=''">
                        <!-- Choose statement to count notes within a single page in a landing pagegroup -->
                        <xsl:choose>
                            <xsl:when test="/dw-document/dw-landing-generic-pagegroup">
                                <fo:inline vertical-align="super" font-size="75%">
                                    <xsl:value-of
                                        select="count(preceding-sibling::target-content-file/note[not(normalize-space(.)='')])
                                        + 1"
                                    />
                                </fo:inline>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:inline vertical-align="super" font-size="75%">
                                    <xsl:value-of
                                        select="count(preceding::note[not(normalize-space(.)='')])+1"
                                    />
                                </fo:inline>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <!-- End superscript -->
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
                padding-after="3pt">
                <fo:block font-size="{$table-cell-font-size}">
                    <xsl:value-of select="@filename"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
                padding-after="3pt">
                <fo:block font-size="{$table-cell-font-size}">
                    <xsl:value-of select="@size"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
                padding-after="3pt">
                <fo:block font-size="{$table-cell-font-size}">
                    <fo:basic-link>
                        <!-- 2010-12-09 ibs: Boolean variable to control wrapping of URL for
						              license display -->
                        <xsl:variable name="need-license-display"
                            select="@show-license='yes' or
                            (not(@show-license) and
                            normalize-space(@target-content-type) = 'Code sample')"/>
                        <xsl:choose>
                            <xsl:when test="@link-method-ftp='yes'">
                                <xsl:attribute name="external-destination">
                                    <!-- 5.2 10/29/05 tdc:  Change www-105., www-106., & www-136. to www -->
                                    <xsl:choose>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Add license display to downloads
									              when needed -->
                                        <!-- A LINK LIKE THIS IS CREATED 
                                                                                                                      http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=300029&filename=samples.zip&method=ftp -->
                                        <xsl:when test="$need-license-display">
                                            <xsl:value-of
                                             select="concat('http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=',
                                             //id/@cma-id, '&amp;filename=', @filename,
                                             '&amp;method=ftp&amp;locale=')"/>
                                            <!-- Will need , $license-locale-value for local site PDFs
           									                if we ever get there -->
                                        </xsl:when>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Fix url-ftp value if invalid Boulder URL is found -->
                                        <xsl:when
                                            test="contains(@url-ftp,'//download.boulder.ibm.com/ibmdl/pub/')">
                                            <xsl:call-template name="ReplaceSubstring">
                                             <xsl:with-param name="original"
                                             select="@url-ftp"/>
                                             <xsl:with-param name="substring"
                                             select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
                                             <xsl:with-param name="replacement"
                                             select="'//public.dhe.ibm.com/'"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Reversed order of
                                                                                                                           remaining when and otherwise to eliminate negative logic. -->
                                        <xsl:when
                                            test="contains(@url-ftp ,'www-105')
                                            or contains(@url-ftp,'www-106') or
                                            contains(@url-ftp,'www-136')">
                                            <!-- Change the href value - it's invalid -->
                                            <xsl:variable name="bad-server-href">
                                             <xsl:choose>
                                             <xsl:when test="contains(@url-ftp,'www-105')">
                                             <xsl:text>www-105</xsl:text>
                                             </xsl:when>
                                             <xsl:when test="contains(@url-ftp,'www-106')">
                                             <xsl:text>www-106</xsl:text>
                                             </xsl:when>
                                             <xsl:when test="contains(@url-ftp,'www-136')">
                                             <xsl:text>www-136</xsl:text>
                                             </xsl:when>
                                             </xsl:choose>
                                            </xsl:variable>
                                            <xsl:call-template name="ReplaceSubstring">
                                             <xsl:with-param name="original"
                                             select="@url-ftp"/>
                                             <xsl:with-param name="substring"
                                             select="$bad-server-href"/>
                                             <xsl:with-param name="replacement"
                                             select="'www'"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <!-- Don't change the href value - it's valid -->
                                        <xsl:otherwise>
                                            <xsl:value-of select="@url-ftp"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:when test="@link-method-http='yes'">
                                <xsl:attribute name="external-destination">
                                    <!-- 5.2 10/29/05 tdc:  Change www-105., www-106., & www-136. to www -->
                                    <xsl:choose>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Add license
                                            display to downloads when needed -->
                                        <!-- A LINK LIKE THIS IS CREATED  
                                            http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=300029&filename=samples.zip&method=http
                                        -->
                                        <xsl:when test="$need-license-display">
                                            <xsl:value-of
                                             select="concat('http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=',
                                             //id/@cma-id, '&amp;filename=', @filename,
                                             '&amp;method=http&amp;locale=')"/>
                                            <!-- Will need , $license-locale-value for local site PDFs
           									                if we ever get there -->
                                        </xsl:when>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Fix url-http value if invalid Boulder URL is found -->
                                        <xsl:when
                                            test="contains(@url-http,'//download.boulder.ibm.com/ibmdl/pub/')">
                                            <xsl:call-template name="ReplaceSubstring">
                                             <xsl:with-param name="original"
                                             select="@url-http"/>
                                             <xsl:with-param name="substring"
                                             select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
                                             <xsl:with-param name="replacement"
                                             select="'//public.dhe.ibm.com/'"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <!-- 6.0 Maverick R3 2010-12-09 ibs: Reversed order of
                                                                                                                           remaining when and otherwise to eliminate negative logic. -->
                                        <xsl:when
                                            test="contains(@url-http ,'www-105')
                                            or contains(@url-http,'www-106') or
                                            contains(@url-http,'www-136')">
                                            <!-- Change the href value - it's invalid -->
                                            <xsl:variable name="bad-server-href">
                                             <xsl:choose>
                                             <xsl:when
                                             test="contains(@url-http,'www-105')">
                                             <xsl:text>www-105</xsl:text>
                                             </xsl:when>
                                             <xsl:when
                                             test="contains(@url-http,'www-106')">
                                             <xsl:text>www-106</xsl:text>
                                             </xsl:when>
                                             <xsl:when
                                             test="contains(@url-http,'www-136')">
                                             <xsl:text>www-136</xsl:text>
                                             </xsl:when>
                                             </xsl:choose>
                                            </xsl:variable>
                                            <xsl:call-template name="ReplaceSubstring">
                                             <xsl:with-param name="original"
                                             select="@url-http"/>
                                             <xsl:with-param name="substring"
                                             select="$bad-server-href"/>
                                             <xsl:with-param name="replacement"
                                             select="'www'"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <!-- Don't change the href value - it's valid -->
                                        <xsl:otherwise>
                                            <xsl:value-of select="@url-http"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="color">
                            <xsl:value-of select="$external-link-color"/>
                        </xsl:attribute>
                        <xsl:value-of select="$link-type"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>

    </xsl:template>

    <!-- ============================================
    For a table cell, we put everything inside a
    <fo:table-cell> element.  We set the padding
    property correctly, then we set the border 
    style.  For the border style, we look to see if
    any of the ancestor elements we care about 
    specified a solid border.  Next, we check for the 
    rowspan, colspan, and align attributes.  Notice 
    that for align, we check this element, then go
    up the ancestor chain until we find the <table>
    element or we find something that specifies the 
    alignment. 
    =============================================== -->
    <xsl:template match="td">
        <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
            padding-after="3pt" start-indent="0">
            <xsl:if test="@colspan">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="border-bottom-style">
                <xsl:text>solid</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="border-bottom-color">
                <xsl:value-of select="$table-border-color"/>
            </xsl:attribute>
            <xsl:attribute name="border-bottom-width">
                <xsl:text>1pt</xsl:text>
            </xsl:attribute>
            <xsl:variable name="align">
                <!-- llk add right alignment for class='ibm-numeric' -->
                <xsl:choose>
                    <xsl:when test="@class='ibm-numeric'">
                        <xsl:text>right</xsl:text>
                    </xsl:when>
                    <xsl:when test="@align">
                        <xsl:choose>
                            <xsl:when test="@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="ancestor::tr[@align]">
                        <xsl:choose>
                            <xsl:when test="ancestor::tr/@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::tr/@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::tr/@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="ancestor::thead">
                        <xsl:text>center</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::table[@align]">
                        <xsl:choose>
                            <xsl:when test="ancestor::table/@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::table/@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::table/@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>start</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <fo:block font-size="{$table-cell-font-size}" text-align="{$align}">
                <xsl:apply-templates select="*|text()"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <!-- ============================================
    If there's a <th> element, we process it just 
    like a normal <td>, except the font-weight is 
    always bold and the text-align is always center. 
    =============================================== -->
    <xsl:template match="th">
        <fo:table-cell padding-start="3pt" padding-end="3pt" padding-before="3pt"
            padding-after="3pt" background-color="{$table-th-color}" start-indent="0">
            <xsl:if test="@colspan">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if
                test="@border='1' or ancestor::tr[@border='1'] or
                ancestor::thead[@border='1'] or
                ancestor::table[@border='1']">
                <xsl:attribute name="border-style">
                    <xsl:text>solid</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="border-color">
                    <xsl:value-of select="$table-border-color"/>
                </xsl:attribute>
                <xsl:attribute name="border-width">
                    <xsl:text>1pt</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:variable name="align">
                <xsl:choose>
                    <xsl:when test="@class='ibm-numeric'">
                        <xsl:text>right</xsl:text>
                    </xsl:when>
                    <xsl:when test="@align">
                        <xsl:choose>
                            <xsl:when test="@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="ancestor::tr[@align]">
                        <xsl:choose>
                            <xsl:when test="ancestor::tr/@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::tr/@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::tr/@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="ancestor::thead">
                        <xsl:text>center</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::table[@align]">
                        <xsl:choose>
                            <xsl:when test="ancestor::table/@align='center'">
                                <xsl:text>center</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::table/@align='right'">
                                <xsl:text>end</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::table/@align='justify'">
                                <xsl:text>justify</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>start</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>start</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <fo:block font-weight="bold" font-size="{$table-cell-font-size}"
                text-align="{$align}">
                <xsl:apply-templates select="*|text()"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <!-- ============================================
    For an HTML table row, we create an XSL-FO table
    row, then invoke the templates for everything 
    inside it. 
    =============================================== -->
    <xsl:template match="thead">
        <!-- Might want to make bold or do somethign else here -->
        <fo:table-row>
            <xsl:apply-templates select="th|td"/>
        </fo:table-row>
    </xsl:template>

    <!-- ============================================
    Process <thead> & <tfoot>
    ============================================== -->
    <xsl:template match="tr|tfoot">
        <fo:table-row>
            <xsl:apply-templates select="th|td"/>
        </fo:table-row>
    </xsl:template>

    <!-- ============================================
    Teletype text is rendered in a monospaced font.
    =============================================== -->
    <xsl:template match="tt">
        <fo:inline>
            <xsl:call-template name="set-font-attributes-family-weight-and-color"/>
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>
    <!-- ============================================
    For underlined text, we use the text-decoration
    property.
    =============================================== -->
    <xsl:template match="u">
        <fo:inline text-decoration="underline">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>
    <!-- ============================================
    List items inside unordered lists.
    =============================================== -->
    <xsl:template match="ul/li">
        <xsl:call-template name="bulleted-item"/>
    </xsl:template>

    <!-- ibs 2010-12-10 (from dw-common-6.0 2010-07-27) Add no-escaping mode form of xref for
     correct computation of code line lengths. -->
    <xsl:template match="xref" mode="no-escaping">
        <xsl:call-template name="xref"/>
    </xsl:template>

    <!-- ibs 2010-12-10 based on dw-common-6.0 2010-07-27) Process xref element to generate text
    to refer to a figure, listing or table. For example "Figure 5". -->
    <xsl:template match="xref" name="xref">
        <xsl:choose>
            <xsl:when test="/dw-document/*/@auto-number='yes' ">
                <!-- Strip leading # if present -->
                <xsl:variable name="this-name">
                    <xsl:choose>
                        <xsl:when test="starts-with(@href, '#')">
                            <xsl:value-of select="substring(@href, 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@href"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="this-xref" select="."/>
                <!-- Test that there is a matching name or refname somewhere in the document and
            complain if not -->
                <xsl:variable name="target-key"
                    select="key('target-names', $this-name) |
                    key('target-refnames', $this-name) | key('target-downloads',
                    $this-name) | key('target-resources', $this-name)"/>
                <xsl:variable name="target-key-count" select="count($target-key)"/>
                <xsl:choose>
                    <xsl:when test="$target-key-count = 0">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat('MATCHING HEADING
                                NOT FOUND! No matching
                                anchor was found for anchor &lt;a href=&quot;',
                                @href, '&quot;&gt;'))"
                            />
                        </xsl:message>
                    </xsl:when>
                    <xsl:when test="$target-key-count != 1">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat( 'MULTIPLE ANCHOR
                                MATCHES FOUND! ',
                                count($target-key) , ' possible targets for &lt;a
                                href=&quot;', @href, '> &quot;&gt;'))"
                            />
                        </xsl:message>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@link='yes'">
                        <fo:basic-link>
                            <xsl:attribute name="internal-destination">
                                <xsl:value-of select="$this-name"/>
                            </xsl:attribute>
                            <xsl:attribute name="color">
                                <xsl:value-of select="$internal-link-color"/>
                            </xsl:attribute>
                            <xsl:call-template name="heading-auto">
                                <xsl:with-param name="for-heading" select="$target-key"/>
                                <xsl:with-param name="quote-text" select=" 'yes' "/>
                            </xsl:call-template>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="heading-auto">
                            <xsl:with-param name="for-heading" select="$target-key"/>
                            <xsl:with-param name="quote-text" select=" 'yes' "/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">
                    <xsl:value-of
                        select="normalize-space(concat('Cannot use &lt;xref&gt;
                        element without auto-number=&quot;yes&quot; attribute on ',
                        local-name(/dw-document/*[1])))"
                    />
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
