<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
  <!-- br tags in CDATA; XALAN removes space before slash otherwise -->
  <!-- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA -->
  <!--  Show error, don't terminate, if anchor name or refname not found (word/writer auth pkg won't always have matches across tutorial pages, but still need to transform so editors can fix. -->
    <!-- Added keys to speed up search for internal link targets (including standard #resources and #download targets)  -->
      <xsl:key name="target-names"
        match="//a[@name != ''] | //title[@name != ''] | //caption[@name != ''] "
        use="@name" />
    <xsl:key name="target-refnames"
        match="//container-heading[@refname != ''] | //heading[@refname != ''] | //title[@refname != ''] | //caption[@refname != '']  "
        use="@refname" />
    <xsl:key name="target-downloads"
        match="//target-content-file[1]|//target-content-page[not(//target-content-file)][1]"
        use=" 'download' " />
    <xsl:key name="target-resources"
        match="//resources[1] | //resource-list[not(//resources)][1]"
        use=" 'resources' " />
    <xsl:variable name="ibm-c-dot-gif">
        <xsl:call-template name="generate-correct-url-form">
            <xsl:with-param name="input-url" select=" '//www.ibm.com/i/c.gif' " />
        </xsl:call-template>
    </xsl:variable>
   <!-- USED FOR 7.0 -->
    <xsl:template name="generate-correct-url-form">
        <xsl:param name="input-url" />
        <xsl:variable name="url-prefix">
            <!-- <xsl:choose>
                <xsl:when test="$xform-type='preview' and starts-with($input-url, '//')">
                    <xsl:value-of select="'http:'" />
                </xsl:when>
                <xsl:when
                    test="$xform-type='preview' and starts-with($input-url,
                        '/developerworks')">
                    <xsl:value-of select="'http://www.ibm.com' " />
                </xsl:when>
            </xsl:choose> -->
			<!-- v17 Enablement jpp 09/16/2011: Replaced xform-type var check with template var check -->
            <xsl:choose>
                <xsl:when test="$template='preview' and starts-with($input-url, '//')">
                    <xsl:value-of select="'http:'" />
                </xsl:when>
                <xsl:when
                    test="$template='preview' and starts-with($input-url,
                        '/developerworks')">
                    <xsl:value-of select="'http://www.ibm.com' " />
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="concat($url-prefix, $input-url)" />
    </xsl:template>
    <!--NOT USED FOR 7.0 -->
   <!-- Rewrite of match="a" to copy everything except href -->
  <xsl:template match="a">
    <xsl:element name="a">
		<xsl:apply-templates select="@href" />      
			<xsl:for-each select="@*[local-name() != 'href' ]">
				<xsl:copy>
					<xsl:apply-templates />
				</xsl:copy>
		    </xsl:for-each>
		<xsl:apply-templates select=" *|text() " />    
	</xsl:element>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
   <!--  - New match="a/@href" template handles link targets. external link processing
           logic is unchanged from prior handling. Internal links are now checked for both
           existence and uniqueness, with a message issued if not.
           - Internal links on same html page no longer include the page (e.g.
           section2.html).
           - page names for context and for link target are determined using a named
           template "find-page-name".
    -->
    <xsl:template match="a/@href">
        <xsl:choose>
            <!-- if the <a> has an href starting with # then it is an internal link -->
            <xsl:when test="starts-with(., '#') ">
                <!-- save all the stuff in variables -->
                <xsl:variable name="this-href" select="." />
                <xsl:variable name="this-anchor" select="substring(., 2)" />
                <!-- Test that there is a matching name or refname somewhere in the document and stop if not -->
                <xsl:variable name="target-key"
                    select="key('target-names', $this-anchor) |
                key('target-refnames', $this-anchor) | key('target-downloads',
                $this-anchor) | key('target-resources', $this-anchor)" />
                <xsl:variable name="target-key-count" select="count($target-key)" />
                <xsl:choose>
                    <xsl:when test="$target-key-count = 0">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat('MATCHING ANCHOR NOT FOUND!
                                No matching anchor was found for anchor &lt;a href=&quot;', 
                                $this-href, '&quot;&gt;'))"
                             />
                        </xsl:message>
                    </xsl:when>
                    <xsl:when test="$target-key-count != 1">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat( 'MULTIPLE ANCHOR MATCHES FOUND! ',  
                                count($target-key) , ' possible targets for &lt;a
                                href=&quot;', $this-href, '> &quot;&gt;'))"
                                                             />
                        </xsl:message>
                    </xsl:when>
                </xsl:choose>
                <xsl:variable name="this-page">
                    <xsl:call-template name="find-page-name" />
                </xsl:variable>
                <xsl:variable name="target-page">
                    <xsl:choose>
                        <xsl:when test="$target-key">
                            <xsl:call-template name="find-page-name">
                                <xsl:with-param name="this-element" select="$target-key" />
                            </xsl:call-template>
                         </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$this-page"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                    <xsl:attribute name="href">
                        <xsl:choose>
                            <xsl:when
                                test="//dw-tutorial and $target-key/ancestor::section and ($target-key[self::title])">
                                <!-- When target is title of a tutorial page, just go to the
                                    page. -->
                                <xsl:value-of select="$target-page" />
                            </xsl:when>
                            <xsl:when
                                test="$this-href = '#resources' or $this-href = '#download' ">
                                <!--  Special case for our standard links. Link to page
                                    if the target page is not empty, or link to standard
                                    link name otherwise. -->
                                <xsl:choose>
                                    <xsl:when test="$target-page != '' ">                                
                                        <xsl:value-of select="$target-page" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$this-href"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="string($this-page) = string($target-page)">
                                <!-- Go directly to target if on this page -->
                                <xsl:value-of select="." />
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Otherwise go to the target on the other page -->
                                <xsl:value-of select="concat($target-page, .)" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <!-- this is a normal link -->
                <xsl:variable name="bad-server-href">
                    <xsl:choose>
                        <xsl:when test="contains(.,'www-105')">
                            <xsl:text>www-105</xsl:text>
                        </xsl:when>
                        <xsl:when test="contains(.,'www-106')">
                            <xsl:text>www-106</xsl:text>
                        </xsl:when>
                        <xsl:when test="contains(.,'www-130')">
                            <xsl:text>www-130</xsl:text>
                        </xsl:when>
                        <xsl:when test="contains(.,'www-136')">
                            <xsl:text>www-136</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>
                <xsl:attribute name="href">
                    <xsl:choose>
                        <!-- It's an href with an invalid value -->
                        <xsl:when test="$bad-server-href != '' ">
                             <xsl:call-template name="ReplaceSubstring">
                                <xsl:with-param name="original" select="." />
                                <xsl:with-param name="substring" select="$bad-server-href" />
                                <xsl:with-param name="replacement" select="'www'" />
                            </xsl:call-template>
                       </xsl:when>
						<!-- If href has an invalid Boulder URL -->
						<xsl:when test="contains(.,'//download.boulder.ibm.com/ibmdl/pub/')">
                            <xsl:call-template name="ReplaceSubstring">
                                <xsl:with-param name="original" select="." />
                                <xsl:with-param name="substring" select="'//download.boulder.ibm.com/ibmdl/pub/'" />
								<xsl:with-param name="replacement" select="'//public.dhe.ibm.com/'" />
							</xsl:call-template>
						</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  <!-- NOT USED FOR 7.0 --> 
  <!--  - New named template "find-page-name" determines the HTML page name on which
           an element (passed as this-element parameter) belongs. Default is to determine
           page for the current context element. If dw content is single page content,
           then answer an empty string ('').
           2010-03-25 Multi-page is supported for tutorials only at this time.
     -->
    <xsl:template name="find-page-name">
        <xsl:param name="this-element" select="." />
        <xsl:choose>
             <xsl:when test="//dw-tutorial">
                <xsl:variable name="page-level-element"
                    select="$this-element/ancestor-or-self::*[parent::*/parent::dw-document]" />
                <xsl:choose>
                    <xsl:when test="$page-level-element[self::section]">
                        <xsl:choose>
                            <xsl:when
                                test="$page-level-element/preceding-sibling::section">
                                <xsl:value-of
                                    select=" concat('section' , 1 +                    
                                    count($page-level-element/preceding-sibling::section), '.html' )"
                                 />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select=" 'index.html' " />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$page-level-element[self::author]">
                        <xsl:value-of select=" 'authors.html' " />
                    </xsl:when>
                    <xsl:when
                        test="$page-level-element[self::resources or self::resource-list]">
                        <xsl:value-of select=" 'resources.html' " />
                    </xsl:when>
                    <xsl:when
                        test="$page-level-element[self::target-content-file or                
                        self::target-content-page ]">
                        <xsl:value-of select=" 'downloads.html' " />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            <xsl:value-of
                                select="normalize-space(concat('Cannot find page for ', 
                                local-name($this-element)))"
                             />
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- Return an empty page value for all other (single-page) content types -->
                <xsl:value-of select=" '' " />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   <!-- NOT USED FOR 7.0 -->
    <xsl:template name="AbstractForDisplay">
        <xsl:choose>
            <xsl:when test="normalize-space(//dw-summary//abstract-extended)">
                <xsl:for-each select="//dw-summary//abstract-extended">
                    <!-- We want to handle blocks that may be either mixed content or paragraphs or
            code sections and mixed content needs to be gathered together and wrapped with a
            <p> element. Idea is to step through block elements (<p> and <code
            type="section>) and gather any stray preceding siblings (i.e. mixed content)
            into paragraphs, and then process the block itself. Finally we gather any
            stuff after the last block into a paragraph. Needless to say, if any of these
            things don't happen to exist, we don't generate anything."
        -->
                    <xsl:variable name="total-block-count"
                        select="count(p|code[@type='section'])"/>
                    <xsl:for-each select="p|code[@type='section']">
                        <!-- Get position of this block -->
                        <xsl:variable name="block-element-pos" select="position()"/>
                        <!-- Keep track of this block node -->
                        <xsl:variable name="block-node" select="."/>
                        <!-- Get the mixed elements before this block -->
                        <xsl:variable name="this-block"
                            select="$block-node/preceding-sibling::node()[
                        count(preceding-sibling::p|preceding-sibling::code[@type='section'] )                       
                        = ($block-element-pos -1)] "/>
                        <!-- Figure out exactly what TEXT is in this block less markup for bold,
                italic, anchors, etc. This is the literal text (including special chars,
                trademarks, etc. -->
                        <xsl:variable name="this-block-text">
                            <xsl:apply-templates select="$this-block" mode="no-escaping"/>
                        </xsl:variable>
                        <!-- Now insert <p> and process the mixed content -->
                        <xsl:if test="normalize-space($this-block-text) != '' ">
                            <!-- Process the block if it is not empty-->
                            <xsl:element name="p">
                                <xsl:for-each select="$this-block">
                                    <xsl:apply-templates select="."/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:if>
                        <!-- Process this block -->
                        <xsl:apply-templates select="$block-node"/>
                        <!-- If it's the last block, then process any following mixed content -->
                        <xsl:if test="$block-element-pos = $total-block-count">
                            <xsl:variable name="last-block"
                                select="$block-node/following-sibling::*|
                                $block-node/following-sibling::text()"/>
                            <!-- Get text including special chars to see if it is empty -->
                            <xsl:variable name="last-block-text">
                                <xsl:apply-templates select="$last-block"
                                    mode="no-escaping"/>
                            </xsl:variable>
                            <xsl:if test="normalize-space($last-block-text) != '' ">
                                <!-- Process the block if not empty-->
                                <xsl:element name="p">
                                    <xsl:for-each select="$last-block">
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:if>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="$total-block-count = 0">
                        <xsl:element name="p">
                            <xsl:apply-templates/>
                        </xsl:element>

                    </xsl:if>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="//dw-summary//abstract"/>
                </p>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template> 
    <!-- NOT USED FOR 7.0 -->
	<!-- Creates the abstract in the summary area  -->
	<xsl:template name="AbstractForDisplaySummaryArea-v16">
		<xsl:choose>
			<xsl:when test="/dw-document/dw-summary">
				<xsl:value-of select="abstract"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="normalize-space(/dw-document//abstract-extended)!=''">
						<xsl:choose> 
							<!-- If abstract-extended contains p tags, put journal link inside last paragraph -->
							<xsl:when test="(/dw-document//abstract-extended/p)">
								<xsl:for-each select="/dw-document//abstract-extended">
									<xsl:copy-of select="p[last()]/preceding-sibling::node()"/>
									<xsl:for-each select="p[last()]">
										<p>
											<xsl:apply-templates select="p[last()]/*|text()|node()"/>
											<xsl:call-template name="JournalLink-v16"/>
										</p>
									</xsl:for-each>
								</xsl:for-each>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="abstract-extended"/>
								<xsl:call-template name="JournalLink-v16"/>	
							</xsl:otherwise>
						</xsl:choose>	
				    </xsl:when>
				    <xsl:otherwise>
						<xsl:value-of select="abstract"/>
						<xsl:call-template name="JournalLink-v16"/>
				  </xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
     <xsl:template name="AbstractLanding-v16">		
		<xsl:if test="//@content-space-navigation='none' and normalize-space(//abstract-extended)">
			<xsl:choose>
				<xsl:when test="//featured-content-module">
					<div class="ibm-container ibm-portrait-module ibm-alternate-two"><div class="ibm-container-body">
						<xsl:apply-templates select="//abstract-extended"/>
					</div></div>
				</xsl:when>
				<xsl:otherwise>
					<div class="ibm-container ibm-portrait-module ibm-alternate-two ibm-alternate-six"><div class="ibm-container-body">
						<xsl:apply-templates select="//abstract-extended"/>
					</div></div>	
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>			
    </xsl:template>    
    <!-- xM R2 (R2.2) jpp 05/03/11:  Removed AbstractLandingHidef-v16 template; Now pointing directly to AbstractLandingHidefBuild-v16 -->
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="AbstractLandingHidefBuild-v16">
		<xsl:for-each select="following::content[1]/abstract-extended">
			<!-- If there is no anchor link list and abstract-extended contains content, process it; otherwise, abstract-extended appears at the bottom of the anchor link list -->
			<xsl:if test="normalize-space(.) and not(../../@content-space-secondary-navigation = 'anchor-link-list') and not(../../@content-space-secondary-navigation = 'anchor-link-list-two-column') and not(../../@content-space-secondary-navigation = 'anchor-link-list-three-column')">
				<xsl:choose>
					<!-- If visible abstract is not at top of center column, do nothing here; abstract-extended will be processed within a module container -->
					<xsl:when test="@position = 'left'"></xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- Process abstract-extended with or without a frame (default is yes) -->
							<xsl:when test="@frame = 'no'">
								<xsl:apply-templates select="."/>
							</xsl:when>
							<xsl:otherwise>
								<div class="ibm-container ibm-portrait-module ibm-alternate-two"><div class="ibm-container-body">
									<xsl:apply-templates select="."/>
								</div></div>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
    </xsl:template> 
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="AbstractProduct-v16">
		<xsl:choose>
			<xsl:when test="normalize-space(abstract-special-chars)">
				<div class="product-description">
					<p>
					<!-- Need apply templates to process special characters allowed in the product abstract -->
					<xsl:apply-templates select="descendant-or-self::abstract-special-chars" />		
					</p>
				</div>
			</xsl:when>
			<xsl:otherwise />
		</xsl:choose>
    </xsl:template>  
    <!-- NOT USED FOR 7.0 -->
    <!-- Template that creates meta abstract and description values for article sidefiles -->
	<xsl:template name="AbstractSidefile-v16">
		<xsl:value-of select="//title"/>
	</xsl:template> 
  <!-- NOT USED FOR 7.0 -->
   <xsl:template name="Attribution">
 <xsl:choose>
     <xsl:when test="/dw-document//attribution !=''">
                  <p>
        <xsl:apply-templates select="/dw-document//attribution"/>
                  </p>
      </xsl:when>
      <xsl:otherwise />
  </xsl:choose>
  </xsl:template>
   <!-- NOT USED FOR 7.0 -->
   <xsl:template name="AuthorBottom">
		<xsl:if test="normalize-space(//author-summary/bio)">
			<xsl:call-template name="AuthorBottomHeading-v16">
				<xsl:with-param name="heading-singular">
					<xsl:value-of select="$biography" />
				</xsl:with-param>
				<xsl:with-param name="heading-plural">
					<xsl:value-of select="$biographies" />
				</xsl:with-param>
				<xsl:with-param name="authorcount" select="//author-summary/bio" />
			</xsl:call-template>
			<div class="ibm-container ibm-portrait-module ibm-alternate-two">	 
				<xsl:for-each select="//author-summary">
					<xsl:call-template name="AuthorBottomModules-v16"/>
			    </xsl:for-each>
			</div>
		</xsl:if>
		<xsl:if test="//author">
			<xsl:call-template name="AuthorBottomHeading-v16">
				<xsl:with-param name="heading-singular">
					<xsl:value-of select="$aboutTheAuthor" />
				</xsl:with-param>
				<xsl:with-param name="heading-plural">
					<xsl:value-of select="$aboutTheAuthors" />
				</xsl:with-param>
				<xsl:with-param name="authorcount" select="//author" />
			</xsl:call-template>
			<div class="ibm-container ibm-portrait-module ibm-alternate-two">	 
				<xsl:for-each select="//author">
					<xsl:call-template name="AuthorBottomModules-v16" />
				</xsl:for-each>
			</div>
		</xsl:if>		
  </xsl:template>  
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="AuthorBottomAuthorBadge-v16">
	<xsl:param name="badge-url" />
	<xsl:param name="badge-url-alt" />
	<xsl:element name="a">
		<xsl:attribute name="name">
			<xsl:text>author</xsl:text>
			<xsl:value-of select="position()"/>
		</xsl:attribute>	
			<!-- Added this to get a separate ending anchor tag. Otherwise, the tage is ended as part of the a name tag and the text of the bio is blue when you mouseover it. -->
			<xsl:text> </xsl:text>		
	</xsl:element>
	<xsl:element name="img">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="(./img/@src)!=''">	
					<xsl:text>dw-author-level-img</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>dw-author-level-img-alt</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="src">
			<xsl:value-of select="$badge-url" />
		</xsl:attribute>
		<xsl:attribute name="width">
			<xsl:text>187</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="height">
			<xsl:text>30</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="alt">
			<xsl:value-of select="$badge-url-alt" />
		</xsl:attribute>
	</xsl:element>
</xsl:template>
<!-- NOT USED FOR 7.0 -->	
<xsl:template name="AuthorBottomHeading-v16">
	<xsl:param name="heading-singular" />
	<xsl:param name="heading-plural" />
	<xsl:param name="authorcount" />
	<xsl:choose>
		<xsl:when test="count($authorcount) = 0"></xsl:when>
		<xsl:otherwise>
	<p>
	<xsl:element name="a">
		<xsl:attribute name="name">
			<xsl:text>author</xsl:text>
		</xsl:attribute>		
	<xsl:element name="span">
		<xsl:attribute name="class">
			<xsl:text>atitle</xsl:text>	
		</xsl:attribute>
			<xsl:choose>
				<xsl:when test="count($authorcount) = 1">
					<xsl:value-of select="$heading-singular"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$heading-plural"/>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:element>
	</xsl:element>
    </p>
    </xsl:otherwise>
	</xsl:choose>   
</xsl:template>
<!-- NOT USED FOR 7.0 -->
<xsl:template name="AuthorBottomModules-v16">
		<xsl:if test="normalize-space(./bio)"> 
			<div class="ibm-container-body">
            <xsl:if test="(./img/@src)!=''"> 
				<xsl:element name="img">
					<xsl:attribute name="src">
						<xsl:value-of select="./img/@src"/>
					</xsl:attribute>
					<xsl:attribute name="class">
						<xsl:text>dw-author-img</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:text>64</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="height">
						<xsl:text>80</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="alt">
						<xsl:choose>
							<xsl:when test="not(normalize-space(./img/@alt))">
							<xsl:choose>
								<xsl:when test="name">
									<xsl:apply-templates select="name"/>
								</xsl:when>
								<xsl:when test="author-name">
									<xsl:if test="normalize-space(author-name/Prefix) !=''">
										<xsl:value-of select="author-name/Prefix"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="author-name/GivenName"/>
									<xsl:text> </xsl:text>
									<xsl:if test="normalize-space(author-name/MiddleName) !=''">
										<xsl:apply-templates select="author-name/MiddleName"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="author-name/FamilyName"/>
									<xsl:if test="normalize-space(author-name/Suffix) !=''">
										<xsl:text>, </xsl:text>
										<xsl:value-of select="author-name/Suffix"/>
									</xsl:if>
								</xsl:when>
								<xsl:when test="contributor-name">
									<xsl:if test="normalize-space(contributor-name/Prefix) !=''">
										<xsl:value-of select="contributor-name/Prefix"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="contributor-name/GivenName"/>
									<xsl:text> </xsl:text>
									<xsl:if test="normalize-space(contributor-name/MiddleName) !=''">
										<xsl:apply-templates select="contributor-name/MiddleName"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="contributor-name/FamilyName"/>
									<xsl:if test="normalize-space(contributor-name/Suffix) !=''">
										<xsl:text>, </xsl:text>
										<xsl:value-of select="contributor-name/Suffix"/>
									</xsl:if>
								</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="./img/@alt"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>				
			</xsl:element>				
		</xsl:if> 			
		<xsl:choose>
			<xsl:when test="./author-level ='none'" />
				<xsl:when test="./author-level ='contributing-author'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$contributing-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$contributing-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='professional-author'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$professional-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$professional-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='master-author'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$master-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$master-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='master-author-2'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$master2-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$master2-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='master-author-3'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$master3-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$master3-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='master-author-4'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$master4-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$master4-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="./author-level ='master-author-5'">
					<xsl:call-template name="AuthorBottomAuthorBadge-v16">
						<xsl:with-param name="badge-url">
							<xsl:value-of select="$master5-author-url" />
						</xsl:with-param>
						<xsl:with-param name="badge-url-alt">
							<xsl:value-of select="$master5-author-alt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
          <p>
          <!-- If there is no author badge or if none is specified for author badge, put the a name tag here -->
          <xsl:if test="not (normalize-space(./author-level)) or ./author-level='none'">           
            <xsl:element name="a">
				<xsl:attribute name="name">
					<xsl:text>author</xsl:text>
					<xsl:value-of select="position()"/>
				</xsl:attribute>
				<!-- Added this to get a separate ending anchor tag. Otherwise, the tag is ended as part of the a name tag and the text of the bio is blue when you mouseover it. -->
				<xsl:text> </xsl:text>				
            </xsl:element>
		  </xsl:if>
			<xsl:apply-templates select="./bio"/> 
          </p>
	  </div>
	  </xsl:if>
</xsl:template>
<!-- NOT USED FOR 7.0 -->
 <xsl:template name="AuthorTop">
    <!--  Made xpath for author test fully qualified so each tutorial/section could use  -->
    <xsl:for-each select="(/dw-document//author) | (/dw-document//author-summary)"> 
		<!-- Show warning, if cma-defined present -->
		<xsl:choose>
			<xsl:when test="cma-defined">
			   <xsl:call-template name="DisplayError">
					<xsl:with-param name="error-number">e005</xsl:with-param>
					<xsl:with-param name="display-format">table</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>			
				<div class="author">
					<!-- If there is no bio (summary pages only), create the author name.  When there is no bio, there is no cluetip popup, and the author is not part of the AuthorBottom author information. Note:  Coded this way because of the schema definition for author-sumary, but, in reality, you can't have an author in CMA without a bio and company name -->
					<xsl:if test="not(normalize-space(./bio))">
						<xsl:call-template name="AuthorTopAuthorName-v16" />
					</xsl:if>
					<!-- If there is a bio, create the anchor tag around the author name -->
					<xsl:if test="normalize-space(./bio)"> 
						<xsl:element name="a">
							<xsl:attribute name="class">
								<xsl:text>dwauthor</xsl:text>
							</xsl:attribute>						
							<xsl:attribute name="rel">
								<xsl:text>#authortip</xsl:text>
								<xsl:value-of select="position()"/>							
							</xsl:attribute>
							<xsl:attribute name="href">
								<xsl:choose>
									<xsl:when test="//dw-tutorial/author">
										<xsl:text>authors.html#author</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>#author</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="position()"/>
							</xsl:attribute>
							<xsl:call-template name="AuthorTopAuthorName-v16" />
						</xsl:element>
					</xsl:if>	
					<xsl:choose>
						<xsl:when test="/dw-document//@local-site='worldwide' or /dw-document//@local-site='china' or /dw-document//@local-site='japan'">
							<xsl:if test="normalize-space(@email) and normalize-space(@email)!='' and normalize-space(@publish-email)!='no'">
								<xsl:text> </xsl:text>
								<xsl:text>(</xsl:text>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:text>mailto:</xsl:text>
										<xsl:value-of select="@email"/>
										<xsl:text>?subject=</xsl:text>
										<xsl:value-of select="/dw-document//title"/>
										<xsl:if test="@email-cc !=''">
										<xsl:text>&amp;cc=</xsl:text>
										<xsl:value-of select="@email-cc"/>
										</xsl:if>
									</xsl:attribute>
									<xsl:value-of select="@email"/>	
								</xsl:element>	
								<xsl:text>)</xsl:text>				
							</xsl:if>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
					<xsl:if test="@jobtitle='' and company-name=''">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:call-template name="DisplayError">
							<xsl:with-param name="error-number">e002</xsl:with-param>
							<xsl:with-param name="display-format">table</xsl:with-param>          
						</xsl:call-template>
						 <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						 <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
					</xsl:if>
					<xsl:if test="@jobtitle!=''">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="@jobtitle"/>
						<xsl:if test="company-name!=''">, </xsl:if>
					</xsl:if>
					<xsl:if test="company-name">
						<xsl:value-of select="company-name"/>
					</xsl:if>			
				</div>
			</xsl:otherwise>      
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="not(normalize-space(./bio))" />
			<xsl:otherwise>
				<xsl:element name="div">
					<xsl:attribute name="id">
						<xsl:text>authortip</xsl:text>
						<xsl:value-of select="position()"/>
					</xsl:attribute>
					<xsl:attribute name="class">
						<xsl:text>dwauthor-onload-state ibm-no-print</xsl:text>
					</xsl:attribute>
					<xsl:if test="normalize-space(./img/@src)">
						<div class="position">
							<xsl:element name="img">
								<xsl:attribute name="src">
									<xsl:value-of select="./img/@src" />
								</xsl:attribute>
								<xsl:attribute name="width">
									<xsl:text>64</xsl:text>
								</xsl:attribute>
								<xsl:attribute name="height">
									<xsl:text>80</xsl:text>
								</xsl:attribute>
								<xsl:attribute name="alt">
									<xsl:value-of select="./img/@alt"/>
								</xsl:attribute>
							</xsl:element>					
						</div>			
					</xsl:if> 
					<xsl:apply-templates select="./bio"/>
					<xsl:choose>
						<xsl:when test="./author-level ='contributing-author'">
							<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
							<xsl:value-of select="$contributing-author-text"/>
						</xsl:when>
					<xsl:when test="./author-level ='professional-author'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$professional-author-text"/>
					</xsl:when>
					<xsl:when test="./author-level ='master-author'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$master-author-text"/>
					</xsl:when>
					<xsl:when test="./author-level ='master-author-2'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$master2-author-text"/>
					</xsl:when>
					<xsl:when test="./author-level ='master-author-3'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$master3-author-text"/>
					</xsl:when>
					<xsl:when test="./author-level ='master-author-4'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$master4-author-text"/>
					</xsl:when>
					<xsl:when test="./author-level ='master-author-5'">
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<xsl:value-of select="$master5-author-text"/>
					</xsl:when>			
					<xsl:otherwise/>
				</xsl:choose>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:for-each>
</xsl:template>
<!-- NOT USED FOR 7.0 -->
<xsl:template name="AuthorTopAuthorName-v16">					
	<xsl:choose>
		<xsl:when test="name">
			<xsl:apply-templates select="name"/>
		</xsl:when>
		<xsl:when test="author-name">
			<xsl:if test="normalize-space(author-name/Prefix) !=''">
				<xsl:value-of select="author-name/Prefix"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="author-name/GivenName"/>
			<xsl:text> </xsl:text>
			<xsl:if test="normalize-space(author-name/MiddleName) !=''">
				<xsl:apply-templates select="author-name/MiddleName"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="author-name/FamilyName"/>
			<xsl:if test="normalize-space(author-name/Suffix) !=''">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="author-name/Suffix"/>
			</xsl:if>
		</xsl:when>
		<xsl:when test="contributor-name">
			<xsl:if test="normalize-space(contributor-name/Prefix) !=''">
				<xsl:value-of select="contributor-name/Prefix"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="contributor-name/GivenName"/>
			<xsl:text> </xsl:text>
			<xsl:if test="normalize-space(contributor-name/MiddleName) !=''">
				<xsl:apply-templates select="contributor-name/MiddleName"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="contributor-name/FamilyName"/>
			<xsl:if test="normalize-space(contributor-name/Suffix) !=''">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="contributor-name/Suffix"/>
			</xsl:if>
		</xsl:when>
	</xsl:choose>
  </xsl:template>	
  <!-- BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB -->
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="b">
    <xsl:choose>
	  <xsl:when test="string-length(normalize-space(.)) = 0">
        <xsl:apply-templates />
      </xsl:when>
      <xsl:when test="ancestor::code">
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:when>
      <xsl:otherwise>
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
<!-- ****VERIFY IF THIS IS NEEDED only for the author bio. if so, need to clean those up and eliminate this as part of migration -->  
<xsl:template match="author/bio//a | author-summary/bio//a | contributor-summary/bio//a | instructor/bio//a">
<!-- Determine the email-cc value of the element that contains the bio -->
  <xsl:variable name="ancestor-email-cc">
     <xsl:choose>
     <!-- Variable value should be nothing if there's already a 'cc=' present -->
     <xsl:when test="contains(@href,'cc=')" />
     <xsl:when test="ancestor::author"><xsl:value-of select="ancestor::author[1]/@email-cc" /></xsl:when>
     <xsl:when test="ancestor::author-summary"><xsl:value-of select="ancestor::author-summary[1]/@email-cc" /></xsl:when>
     <xsl:when test="ancestor::contributor-summary"><xsl:value-of select="ancestor::contributor-summary[1]/@email-cc" /></xsl:when>
     <xsl:when test="ancestor::instructor"><xsl:value-of select="ancestor::instructor[1]/@email-cc" /></xsl:when>
     <!-- Output nothing -->
     <xsl:otherwise />
     </xsl:choose>     
  </xsl:variable>
<xsl:choose>
  <!-- The anchor is fine; or, there is no email-cc value to add.  Copy it as-is to the output tree -->
  <xsl:when test="not(contains(@href, 'mailto')) or
                             contains(@href, 'cc=') or
                             (ancestor::author[1]/@email-cc='' or ancestor::author-summary[1]/@email-cc='' or ancestor::contributor-summary[1]/@email-cc='' or ancestor::instructor[1]/@email-cc='')">
     <a>
        <xsl:copy-of select="@*" />
        <xsl:apply-templates />
     </a>
  </xsl:when>
  <!-- We need to rebuild the mailto, adding "cc" (from email-cc) -->
  <xsl:otherwise>
  <xsl:variable name="delimeter">  
       <xsl:choose>
        <xsl:when test="contains(@href,'?')">&amp;</xsl:when>
        <xsl:otherwise>?</xsl:otherwise>
      </xsl:choose>    
  </xsl:variable>
  <xsl:variable name="last-attribute-value"><xsl:value-of select='@*[last()]' /></xsl:variable>
  <a>
     <xsl:for-each select="@*">
        <xsl:choose>
          <xsl:when test="@*[not(last())]">             
                <xsl:attribute name="{name(.)}"><xsl:copy/></xsl:attribute>           
          </xsl:when>
          <xsl:otherwise>
             <xsl:attribute name="{name(.)}">
                <xsl:value-of select="concat($last-attribute-value,$delimeter,'cc=',$ancestor-email-cc)" /></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
     </xsl:for-each>          
        <xsl:apply-templates />
     </a>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>
<!-- xM R2.2 egd 04 26 11:  Removed template BrandImage as we should no longer using brand images on our pages per Software -->
<!-- xM R2.2 egd 04 26 11:  Removed template BrandImageLinkURL as we should no longer using brand images on our pages per Software -->
<!-- xM R2.2 egd 04 26 11:  Removed template BrandImageURL as we should no longer using brand images on our pages per Software -->
<!-- NOT USED FOR 7.0 -->
<!-- Breadcrumb-v16 template. Creates article, tutorial, kp, or summary breadcrumb trail based on the zone name passed to this xsl. 
  	  Creates the zone overview breadcrumb trail based on the content type (rool element of the content type) -->
	<xsl:template name="Breadcrumb-v16">
	    <xsl:param name="transform-zone"></xsl:param>
		<xsl:choose>
			<!-- Test to see if there's a zone name. if not, do nothing -->
			<xsl:when test="not(normalize-space($transform-zone))">
				<div id="ibm-content-head">
					<ul id="ibm-navigation-trail">
					  <li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>
					  <xsl:call-template name="SummaryBreadcrumbSubLevel-v16"/>					  
					</ul>					
				</div>
			</xsl:when>
			<!-- If zone name, then create the article bct for that zone -->
			<xsl:otherwise>
			    <!-- KP needs css class to adjust bc placement  -->		             
				<xsl:element name="div">
				                         <xsl:attribute name="id">ibm-content-head</xsl:attribute>
				                            <xsl:if test="//dw-knowledge-path">
				                                <xsl:attribute name="class">kp-content-head</xsl:attribute>
				                            </xsl:if>				             
					<ul id="ibm-navigation-trail">
						<li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>
						<xsl:choose>
							<xsl:when test="((//dw-summary/@local-site='worldwide') and (//dw-summary/@summary-content-type='workshop' or //dw-summary/@summary-content-type='briefing'))">
								<li>
									<xsl:element name="a">
										<xsl:attribute name="href">
											<xsl:value-of select="$events-url" />
										</xsl:attribute>
											<xsl:value-of select="$events-text" />									
									</xsl:element>	
								</li>
							</xsl:when>
							<xsl:when test="/dw-document//content-area-primary/@name='none'">
							</xsl:when>	
							<xsl:otherwise>
								<li>
									<xsl:element name="a">
										<xsl:attribute name="href">
											<xsl:value-of select="$technical-topics-url" />
										</xsl:attribute>
											<xsl:value-of select="$technical-topics-text" />									
									</xsl:element>
								</li>								
							</xsl:otherwise>			
						</xsl:choose>
						<xsl:choose>
							<!-- Create breadcrumb trail based on the value passed in transform-zone -->
							<xsl:when test="($transform-zone)='autonomic'">
								<li><a href="{$autonomic-top-url}"><xsl:value-of select="$contentarea-ui-name-ac" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-ac}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='grid'">
								<li><a href="{$grid-top-url}"><xsl:value-of select="$contentarea-ui-name-gr" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-gr}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='security'">
								<li><a href="{$security-top-url}"><xsl:value-of select="$contentarea-ui-name-s" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-s}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='aix'">
								<li><a href="{$aix-top-url}"><xsl:value-of select="$contentarea-ui-name-au" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-au}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='architecture'">
								<li><a href="{$architecture-top-url}"><xsl:value-of select="$contentarea-ui-name-ar" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-ar}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='cloud'">
								<li><a href="{$cloud-top-url}"><xsl:value-of select="$contentarea-ui-name-cl" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-cl}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='data'">
								<li><a href="{$db2-top-url}"><xsl:value-of select="$contentarea-ui-name-db2" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-db2}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='ibm'">
								<li><a href="{$ibm-top-url}"><xsl:value-of select="$contentarea-ui-name-i" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-i}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='ibmi'">
								<li><a href="{$ibmi-top-url}"><xsl:value-of select="$contentarea-ui-name-ibmi" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-ibmi}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='industry'">
								<li><a href="{$industry-top-url}"><xsl:value-of select="$contentarea-ui-name-in" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-in}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='java'">
								<li><a href="{$java-top-url}"><xsl:value-of select="$contentarea-ui-name-j" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-j}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='linux'">
								<li><a href="{$linux-top-url}"><xsl:value-of select="$contentarea-ui-name-l" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-l}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='lotus'">
								<li><a href="{$lotus-top-url}"><xsl:value-of select="$contentarea-ui-name-lo" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-lo}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='opensource'">
								<li><a href="{$opensource-top-url}"><xsl:value-of select="$contentarea-ui-name-os" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-os}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='power'">
								<li><a href="{$power-top-url}"><xsl:value-of select="$contentarea-ui-name-pa" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-pa}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='rational'">
								<li><a href="{$rational-top-url}"><xsl:value-of select="$contentarea-ui-name-r" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-r}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='tivoli'">
								<li><a href="{$tivoli-top-url}"><xsl:value-of select="$contentarea-ui-name-tiv" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-tiv}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='web'">
								<li><a href="{$web-top-url}"><xsl:value-of select="$contentarea-ui-name-wa" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-wa}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='webservices'">
								<li><a href="{$webservices-top-url}"><xsl:value-of select="$contentarea-ui-name-ws" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-ws}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='websphere'">
								<li><a href="{$websphere-top-url}"><xsl:value-of select="$contentarea-ui-name-web" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-web}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<xsl:when test="($transform-zone)='xml'">
								<li><a href="{$xml-top-url}"><xsl:value-of select="$contentarea-ui-name-x" /></a></li>
								<xsl:if test="//dw-article or //dw-tutorial or //dw-knowledge-path">
									<li><a href="{$techlibview-x}"><xsl:value-of select="$technical-library" /></a></li>
								</xsl:if>
							</xsl:when>
							<!-- Create breadcrumb trail when none is passed for transform-zone -->
							<xsl:when test="($transform-zone)='none'" /> 
							<!-- Create default breadcrumb trail based on primary content area in xml -->
							<xsl:when test="($transform-zone)='default'">
								<xsl:choose>
									<xsl:when test="/dw-document//content-area-primary/@name='aix'">
										<li><a href="{$aix-top-url}"><xsl:value-of select="$contentarea-ui-name-au" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-au}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='architecture'">
										<li><a href="{$architecture-top-url}"><xsl:value-of select="$contentarea-ui-name-ar" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-ar}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='autonomic'">
										<li><a href="{$autonomic-top-url}"><xsl:value-of select="$contentarea-ui-name-ac" /></a></li>
											<xsl:if test="//dw-article or //dw-tutorial">
												<li><a href="{$techlibview-ac}"><xsl:value-of select="$technical-library" /></a></li>
											</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='grid'">
										<li><a href="{$grid-top-url}"><xsl:value-of select="$contentarea-ui-name-gr" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-gr}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='security'">
										<li><a href="{$security-top-url}"><xsl:value-of select="$contentarea-ui-name-s" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">								
											<li><a href="{$techlibview-s}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='cloud'">
										<li><a href="{$cloud-top-url}"><xsl:value-of select="$contentarea-ui-name-cl" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-cl}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='data'">
										<li><a href="{$db2-top-url}"><xsl:value-of select="$contentarea-ui-name-db2" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-db2}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='ibmi'">
										<li><a href="{$ibmi-top-url}"><xsl:value-of select="$contentarea-ui-name-ibmi" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-ibmi}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='industry'">
										<li><a href="{$industry-top-url}"><xsl:value-of select="$contentarea-ui-name-in" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-in}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='java'">
										<li><a href="{$java-top-url}"><xsl:value-of select="$contentarea-ui-name-j" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-j}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='linux'">
										<li><a href="{$linux-top-url}"><xsl:value-of select="$contentarea-ui-name-l" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-l}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='lotus'">
										<li><a href="{$lotus-top-url}"><xsl:value-of select="$contentarea-ui-name-lo" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-lo}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='opensource'">
										<li><a href="{$opensource-top-url}"><xsl:value-of select="$contentarea-ui-name-os" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-os}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='power'">
										<li><a href="{$power-top-url}"><xsl:value-of select="$contentarea-ui-name-pa" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-pa}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='rational'">
										<li><a href="{$rational-top-url}"><xsl:value-of select="$contentarea-ui-name-r" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-r}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='tivoli'">
										<li><a href="{$tivoli-top-url}"><xsl:value-of select="$contentarea-ui-name-tiv" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-tiv}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='web'">
										<li><a href="{$web-top-url}"><xsl:value-of select="$contentarea-ui-name-wa" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-wa}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='webservices'">
										<li><a href="{$webservices-top-url}"><xsl:value-of select="$contentarea-ui-name-ws" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-ws}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='websphere'">
										<li><a href="{$websphere-top-url}"><xsl:value-of select="$contentarea-ui-name-web" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-web}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/dw-document//content-area-primary/@name='xml'">
										<li><a href="{$xml-top-url}"><xsl:value-of select="$contentarea-ui-name-x" /></a></li>
										<xsl:if test="//dw-article or //dw-tutorial">
											<li><a href="{$techlibview-x}"><xsl:value-of select="$technical-library" /></a></li>
										</xsl:if>
									</xsl:when>
									<!-- do none if it is primary content area, think you forgot it :-) -->
								</xsl:choose>						
							</xsl:when>
						</xsl:choose>
						 <!-- Added call to Summary BreadcrumbSubLevel-v16 for summaries with subnav or subnavSublevel -->
						<xsl:call-template name="SummaryBreadcrumbSubLevel-v16"/>						
					</ul>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  <!-- CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC -->
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="caption">
    <caption>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates select="*|text()"/>
    </caption>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
<xsl:template name="CheckNumChar">
<!-- CheckNumChar is a recursive template used to iteratively address text chunks betw all line feeds
       within the context node. It will detect if the length
       of text strings before line feeds exceeds a limit, and call an error routine if necessary.
       **In future, the limit should be passed to the template instead of being hard coded.**
       Line feed char's are not nodes, so we can't 'match' them; we can only detect them.  -->
   <xsl:param name="characters">
      <xsl:apply-templates select="." />   
   </xsl:param>
   <xsl:param name="stripped-characters">
   <!-- $stripped-characters is same as $characters, but with beginning line feeds (if any) removed -->
      <xsl:choose>
        <xsl:when test="starts-with($characters,'&#10;')">
           <xsl:copy-of select="substring-after($characters,'&#10;')" />
        </xsl:when>
        <xsl:otherwise>
           <xsl:copy-of select="$characters" />
        </xsl:otherwise>
      </xsl:choose>
   </xsl:param>
       <xsl:choose>
       <!-- The text may exceed the limit, but we don't know yet if the chunks between line feeds exceed the limit (i.e. = error) -->
       <xsl:when test="string-length($stripped-characters) &gt; 90">
            <xsl:if test="starts-with($characters,'&#10;')">
               <!-- If we stripped off a beginning line feed, we have to add it back upon output -->
               <xsl:copy-of select="'&#10;'" />
            <!-- If the text length before the next line feed exceeds the limit, call error routine -->
            </xsl:if>
            <!-- Next, output the text before the next line feed -->
            <xsl:copy-of select="substring-before($stripped-characters,'&#10;')" />
            <!-- Then add the line feed back -->
            <xsl:copy-of select="'&#10;'" />
            <xsl:if test="string-length(substring-before($stripped-characters,'&#10;')) &gt; 90">
               <xsl:call-template name="DisplayError">
                  <xsl:with-param name="error-number">e001</xsl:with-param>
                  <xsl:with-param name="display-format">inline</xsl:with-param>
               </xsl:call-template>
               <xsl:copy-of select="'&#10;'" />
            </xsl:if>
            <!-- If there are char's after the line feed (i.e., this check keeps us from having an infinite loop):
                   * Recursively call this template again
                   * We override the previous value of $characters with all text past the text & line feed we just handled -->
            <xsl:if test="substring-after($stripped-characters,'&#10;') !=''">
               <xsl:call-template name="CheckNumChar">
                 <xsl:with-param name="characters" select="substring-after($stripped-characters,'&#10;')" />
               </xsl:call-template>
            </xsl:if>
      </xsl:when>      
      <xsl:otherwise>
         <!-- The length is below the limit, so output the original text chunk -->
         <xsl:copy-of select="$characters" />         
      </xsl:otherwise>      
   </xsl:choose>
</xsl:template>
<!-- v17 Enablement jpp 09/15/2011: REPLACED cmaSiteStylesheetId-v16 template with cmaSiteStylesheetId-v17 -->
<!-- USED FOR 7.0 -->
<xsl:template name="cmaSiteStylesheetId-v17">
	<!-- Add comment for CMA ID for this content -->
	<xsl:choose>
        <xsl:when test="/dw-document//id/@cma-id !=''">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- CMA ID: ]]></xsl:text>
                    <xsl:value-of select="/dw-document//id/@cma-id"/>
		 <xsl:text disable-output-escaping="yes"><![CDATA[ --> ]]></xsl:text>
        </xsl:when>
        <xsl:otherwise>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- CMA ID: undefined --> ]]></xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <!-- Add comment for Site ID of this content -->
    <!-- v17 Enablement jpp 09/24/2011: Modified local site path for all sites to enable local-site attribute to be moved -->
    <!-- v17 Enablement jpp 09/15/2011: Modified local site path for all sites -->
    <xsl:choose>
        <xsl:when test="//@local-site ='worldwide'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 1 --> ]]></xsl:text>
        </xsl:when>
    	<xsl:when test="//@local-site ='china'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 10 --> ]]></xsl:text>
        </xsl:when>
        <xsl:when test="//@local-site ='korea'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 20 --> ]]></xsl:text>
        </xsl:when>
        <xsl:when test="//@local-site ='russia'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 40 --> ]]></xsl:text>
        </xsl:when>
        <xsl:when test="//@local-site ='japan'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 60 --> ]]></xsl:text>
        </xsl:when>  
        <xsl:when test="//@local-site ='vietnam'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 70 --> ]]></xsl:text>
        </xsl:when>
        <xsl:when test="//@local-site ='ssa'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 90 --> ]]></xsl:text>
         </xsl:when>
        <xsl:when test="//@local-site ='brazil'">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: 80 --> ]]></xsl:text>
        </xsl:when>
        <xsl:otherwise>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Site ID: undefined --> ]]></xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <!-- Add comment for Stylesheet used to transform this content -->
   <xsl:text disable-output-escaping="yes"><![CDATA[<!-- ]]></xsl:text><xsl:value-of select="$stylesheet-id"/><xsl:text disable-output-escaping="yes"><![CDATA[ --> ]]></xsl:text>
</xsl:template>
<!--NOT USED FOR 7.0 -->
 <xsl:template match="code">
 <xsl:choose>
   <xsl:when test="@type='inline' or not(@type)">
      <code>
        <xsl:apply-templates/>
      </code>
   </xsl:when>
   <xsl:when test="@type='section'">
	  <xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
		<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
      </xsl:if>
      <xsl:apply-templates select="heading"/>
	  <xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
		<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
      </xsl:if>
      <xsl:variable name="tableWidth">
      <xsl:choose>
        <!-- Width value not present, or width attribute not present -->
        <xsl:when test="normalize-space(@width)='' or not(@width)">
          <xsl:text>100%</xsl:text></xsl:when>
        <!-- Width expressed as percentage -->
        <xsl:when test="contains(@width, '%')">
           <xsl:value-of select="@width" />
        </xsl:when>
        <!-- Width not expressed as percentage (pixels) -->
        <xsl:when test="not(contains(@width, '%'))">
            <xsl:choose>
              <!-- Width equal to or less than 600 px -->
              <xsl:when test="@width&lt;=600">
                 <xsl:value-of select="@width" />
              </xsl:when>
              <!-- Width greater than 600 px -->
              <xsl:when test="@width&gt;600">
                 <xsl:text>600</xsl:text></xsl:when>
            </xsl:choose>
         </xsl:when>
      </xsl:choose>
      </xsl:variable>
      <!--  Unless it's a sidefile (DR 2335), check line lengths  -->
      <xsl:choose>
        <!-- Correct problem when code not immediate child of docbody (e.g. in list) -->
        <xsl:when test="/*/dw-sidefile">
           <table border="0" cellspacing="0" summary="{$codeTableSummaryAttribute}" cellpadding="0" width="{$tableWidth}"><tr><td class="code-outline"><pre class="displaycode"><xsl:for-each select="node()"><xsl:if test="not(self::heading)"><xsl:apply-templates select="." /></xsl:if></xsl:for-each></pre></td></tr></table>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="text-content1">
           <xsl:apply-templates select="*[not(self::heading)]|text()" mode="no-escaping" />
          </xsl:variable>
          <xsl:variable name="line-length-check">
            <xsl:call-template name="CheckCodeSectionLineLength">
              <xsl:with-param name="code-to-check" >
                <xsl:value-of select="$text-content1" />
              </xsl:with-param>
              <xsl:with-param name="max-code-line-length" select="$max-code-line-length" />
              <xsl:with-param name="indent-chars" select="5*count(ancestor::*[name() = 'ul' or name() = 'ol'])" />
              <xsl:with-param name="check-type" select=" 'calculate' " />
            </xsl:call-template>
          </xsl:variable>
		  <xsl:choose>
			  <xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
				  <table border="0" cellspacing="0" cellpadding="0" width="95%" class="dw-landing-code-table" summary="{$codeTableSummaryAttribute}"><tr><td class="code-outline">
					  <pre class="displaycode">
					  <xsl:for-each select="node()">
						  <xsl:if test="not(self::heading)">
							  <xsl:apply-templates  select="."/>
						  </xsl:if>					
					  </xsl:for-each>
					  </pre>
			      </td></tr></table>
			  </xsl:when>
			  <xsl:otherwise>
				  <table border="0" cellspacing="0" summary="{$codeTableSummaryAttribute}" cellpadding="0" width="{$tableWidth}"><tr><td class="code-outline">
					<xsl:choose>
						<xsl:when test="(ancestor::table or ancestor::ul or ancestor::ol or ancestor::dl)">
							<xsl:text disable-output-escaping="yes"><![CDATA[<pre class="displaycodeliquid">]]></xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="yes"><![CDATA[<pre class="displaycode">]]></xsl:text>
						</xsl:otherwise>
					</xsl:choose>            
				    <xsl:choose>
						<xsl:when test="($line-length-check &gt; $max-code-line-length) and
						    ((//date-published/@year=2009 and //date-published/@month&gt;=07) or
						    (//date-published/@year&gt;2009) or
						    ($xform-type='preview'))">
							<xsl:call-template name="CheckCodeSectionLineLength">
								<xsl:with-param name="code-to-check" >
									<xsl:value-of select="$text-content1"   />
								</xsl:with-param>
							    <xsl:with-param name="max-code-line-length" select="$max-code-line-length" />
								<xsl:with-param name="indent-chars" select="5*count(ancestor::*[name() = 'ul' or name() = 'ol'])" />
							    <!-- This will put out error messages if published  June 2006 or later.  -->
								<xsl:with-param name="check-type" select=" 'error-message' " /> 
							</xsl:call-template>
						</xsl:when>
					    <xsl:otherwise>
							<xsl:for-each select="node()">
								<xsl:if test="not(self::heading)">
									<xsl:apply-templates  select="."/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text disable-output-escaping="yes"><![CDATA[</pre>]]></xsl:text>
					</td></tr></table>
			  </xsl:otherwise>
			</xsl:choose>
			<!-- Do not add break if code section is within a generic landing page -->
			<xsl:if test="not(/dw-document/dw-landing-generic)">
				<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
			</xsl:if>
		  </xsl:otherwise>
		</xsl:choose>	
    </xsl:when>
    </xsl:choose>
 </xsl:template>  
 <!-- NOT USED FOR 7.0 -->
  <!--  Checks line lengths in codes sections. Code to be checked is obtained by applying templates with a parameter to omit generation of elements such as <strong>, <span>, etc, but to include special characters such as Æ,è,ÿ, etc, generated by templates. -->
  <xsl:template name="CheckCodeSectionLineLength">
    <xsl:param name="code-to-check" /> 
    <!--<xsl:param name="code-to-output" />--> 
    <xsl:param name="indent-chars" select="0" />
    <xsl:param name="check-type" select=" 'calculate' " />
     <xsl:choose>
      <xsl:when test="contains($code-to-check, '&#10;') ">
         <xsl:variable name="line-length">
          <xsl:call-template name="CalculateCodeLineLength">
            <xsl:with-param name="code-to-check"
              select="substring-before(string($code-to-check), '&#10;' )" />
            <xsl:with-param name="indent-chars" select="$indent-chars" />
           </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="($check-type = 'calculate') and 
            ($line-length &gt; $max-code-line-length)">
            <xsl:value-of select="$line-length"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$check-type = 'error-message' ">
              <xsl:value-of select="substring-before($code-to-check,
                '&#10;' )" />
              <xsl:text>&#10;</xsl:text>
               <xsl:if test="$line-length &gt; $max-code-line-length">
 <span 
style="margin-top: 0; margin-bottom: 0; 
font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; 
font-size: 11px; 
color: #ff0000"><xsl:value-of select="concat( '|', substring(substring($code-ruler, 1,
$max-code-line-length - 2), 1+$indent-chars), '|')"/></span>
                 <xsl:value-of select="'&#10;'"/>
                 <xsl:call-template name="DisplayError">
                     <xsl:with-param name="error-number">e001</xsl:with-param>
                     <xsl:with-param name="display-format">inline</xsl:with-param>
                  </xsl:call-template>
                 <xsl:value-of select="'&#10;'"/>
               </xsl:if>
            </xsl:if>
            <xsl:call-template name="CheckCodeSectionLineLength">
              <xsl:with-param name="code-to-check" select="substring-after($code-to-check,
                '&#10;' )" />
              <xsl:with-param name="indent-chars" select="$indent-chars" />
              <xsl:with-param name="check-type" select="$check-type" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="string-length($code-to-check) &gt; 0">
          <xsl:variable name="line-length">
            <xsl:call-template name="CalculateCodeLineLength">
              <xsl:with-param name="code-to-check" select="$code-to-check" />
             <xsl:with-param name="indent-chars" select="$indent-chars" />
             </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$check-type = 'calculate'">
              <xsl:value-of select="$line-length"/>
            </xsl:when>
            <xsl:when test="$check-type = 'error-message'">
              <xsl:value-of select="$code-to-check" />
              <xsl:if test="$line-length &gt; $max-code-line-length">
                <span 
style="margin-top: 0; margin-bottom: 0; 
font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; 
font-size: 11px; 
color: #ff0000"><xsl:value-of select="'&#10;'"/>
                  <xsl:value-of select="concat( '|', substring(substring($code-ruler, 1,
$max-code-line-length - 2), 1+$indent-chars), '|')"/></span>
                 <xsl:value-of select="'&#10;'"/>
                 <xsl:call-template name="DisplayError">
                   <xsl:with-param name="error-number">e001</xsl:with-param>
                   <xsl:with-param name="display-format">inline</xsl:with-param>
                 </xsl:call-template>
                 <xsl:value-of select="'&#10;'"/>
               </xsl:if>
             </xsl:when>
          </xsl:choose>
        </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="CalculateCodeLineLength">
    <xsl:param name="code-to-check" />
    <xsl:param name="indent-chars" select="0" />
     <xsl:choose>
        <xsl:when test="not(contains($code-to-check, '&#09;' ))">
          <xsl:value-of select="$indent-chars + string-length($code-to-check)"/>
        </xsl:when>
       <xsl:otherwise>
         <xsl:call-template name="CalculateCodeLineLength">
            <xsl:with-param name="code-to-check" select="substring-after($code-to-check,
              '&#09;' )"  />
            <xsl:with-param name="indent-chars" select="($tab-stop-width * floor(($indent-chars +
              string-length(substring-before($code-to-check, '&#09;')) + $tab-stop-width) div
              $tab-stop-width))" />
         </xsl:call-template>
       </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="CompanyName">
    <!-- COMPANY NAME-->
   <xsl:if test="/dw-document/dw-summary/company-name !=''">
      <p>
		  <xsl:element name="strong">
			<xsl:value-of select="$summary-contributors"/>
		  </xsl:element>
		  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
        <xsl:for-each select="/dw-document/dw-summary/company-name">
          <xsl:if test="position() > 1">
            <xsl:text disable-output-escaping="yes"><![CDATA[, ]]></xsl:text>
          </xsl:if>
          <xsl:apply-templates select="."/>
        </xsl:for-each>
	      </p>
    </xsl:if>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ContactModuleUse-v16">
		<xsl:if test="/dw-document/dw-landing-generic">
			<xsl:if test="//contact-module-include = 'yes'">
				<xsl:text>yes</xsl:text>
			</xsl:if>
		</xsl:if>
		
		<xsl:if test="/dw-document/dw-landing-generic-pagegroup-hidef">
			<xsl:if test="//contact-module-include = 'yes'">
				<xsl:text>yes</xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="/dw-document/dw-landing-product">
			<xsl:text>yes</xsl:text>
		</xsl:if>
		<xsl:if test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
			<xsl:if test="following::content[1]/contact-module-include = 'yes'">
				<xsl:text>yes</xsl:text>
			</xsl:if>
		</xsl:if>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="container-html-body">
    <xsl:apply-templates select="a | b | blockquote | br | code | dl | em | figure | forward-link | forward-link-list | heading | i | img | include | ol | p | sidebar | span | strong | sub | sup | table | twisty-section | ul"/>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="container-html-body-hidef">
    <xsl:apply-templates select="a | b | blockquote | br | code | dl | em | figure | forward-link | forward-link-list | heading | i | img | include | ol | p | sidebar | span | strong | sub | sup | table | ul"/>
  </xsl:template>   
  <!-- NOT USED FOR 7.0 -->
  <!--Template returns correct content area from extended content area list -->
  <xsl:template name="ContentAreaExtendedName">
    <xsl:param name="contentarea"/>
    <xsl:choose>
	  <!-- v17 Maintenance jpp 04/25/2012:  Added test for Agile transformation content area -->
      <xsl:when test="$contentarea = 'agile' ">
        <xsl:copy-of select="$contentarea-ui-name-ag"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'aix' ">
        <xsl:copy-of select="$contentarea-ui-name-au"/>
      </xsl:when>
      <!-- v17 Maintenance jmh 05/18/2012:  Added test for Business analytics content area -->
      <xsl:when test="$contentarea = 'analytics' ">
        <xsl:copy-of select="$contentarea-ui-name-ba"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'architecture' ">
        <xsl:copy-of select="$contentarea-ui-name-ar"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'autonomic' ">
        <xsl:copy-of select="$contentarea-ui-name-ac"/>
      </xsl:when>
	  <!-- v17 Maintenance jpp 04/25/2012:  Added test for Business process management content area -->
      <xsl:when test="$contentarea = 'bpm' ">
        <xsl:copy-of select="$contentarea-ui-name-bpm"/>
      </xsl:when>
      <!-- v17 Maintenance jmh 05/18/2012:  Added test for Commerce content area -->
      <xsl:when test="$contentarea = 'commerce' ">
        <xsl:copy-of select="$contentarea-ui-name-co"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'grid' ">
        <xsl:copy-of select="$contentarea-ui-name-gr"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'java' ">
        <xsl:copy-of select="$contentarea-ui-name-j"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'linux' ">
        <xsl:copy-of select="$contentarea-ui-name-l"/>
      </xsl:when>
	  <!-- v17 Maintenance jpp 04/25/2012:  Added test for Mobile development content area -->
      <xsl:when test="$contentarea = 'mobile' ">
        <xsl:copy-of select="$contentarea-ui-name-mo"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'opensource' ">
        <xsl:copy-of select="$contentarea-ui-name-os"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'webservices' ">
        <xsl:copy-of select="$contentarea-ui-name-ws"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'xml' ">
        <xsl:copy-of select="$contentarea-ui-name-x"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'security' ">
        <xsl:copy-of select="$contentarea-ui-name-s"/>
      </xsl:when>
      <!-- v17 Maintenance jmh 05/18/2012:  Added test for Service Management Connect content area -->
      <xsl:when test="$contentarea = 'servicemanagement' ">
        <xsl:copy-of select="$contentarea-ui-name-smc"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'web' ">
        <xsl:copy-of select="$contentarea-ui-name-wa"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'ibm' ">
        <xsl:copy-of select="$contentarea-ui-name-i"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'ibmi' ">
        <xsl:copy-of select="$contentarea-ui-name-ibmi"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'data' ">
        <xsl:copy-of select="$contentarea-ui-name-db2"/>
      </xsl:when>
       <xsl:when test="$contentarea= 'lotus' ">
        <xsl:copy-of select="$contentarea-ui-name-lo"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'rational' ">
        <xsl:copy-of select="$contentarea-ui-name-r"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'tivoli' ">
        <xsl:copy-of select="$contentarea-ui-name-tiv"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'websphere' ">
        <xsl:copy-of select="$contentarea-ui-name-web"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'power' ">
        <xsl:copy-of select="$contentarea-ui-name-pa"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'cloud' ">
        <xsl:copy-of select="$contentarea-ui-name-cl"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'industry' ">
        <xsl:copy-of select="$contentarea-ui-name-in"/>
      </xsl:when> 
      <xsl:when test="$contentarea= 'alphaworks' ">
        <xsl:copy-of select="$contentarea-ui-name-aw"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'blogs' ">
        <xsl:copy-of select="$contentarea-ui-name-blogs"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'community' ">
        <xsl:copy-of select="$contentarea-ui-name-community"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'downloads' ">
        <xsl:copy-of select="$contentarea-ui-name-downloads"/>
      </xsl:when>
    </xsl:choose>
	</xsl:template>  
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ContentAreaInputName">
    <xsl:param name="contentarea"/>
    <xsl:choose>
      <xsl:when test="$contentarea = 'architecture' ">
        <xsl:value-of select="$contentarea-ui-name-ar"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'aix' ">
        <xsl:value-of select="$contentarea-ui-name-au"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'autonomic' ">
        <xsl:value-of select="$contentarea-ui-name-ac"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'data' ">
        <xsl:value-of select="$contentarea-ui-name-db2"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'grid' ">
        <xsl:value-of select="$contentarea-ui-name-gr"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'ibm' ">
        <xsl:value-of select="$contentarea-ui-name-i"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'ibmi' ">
        <xsl:value-of select="$contentarea-ui-name-ibmi"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'java' ">
        <xsl:value-of select="$contentarea-ui-name-j"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'linux' ">
        <xsl:value-of select="$contentarea-ui-name-l"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'lotus' ">
        <xsl:value-of select="$contentarea-ui-name-lo"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'opensource' ">
        <xsl:value-of select="$contentarea-ui-name-os"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'power' ">
        <xsl:value-of select="$contentarea-ui-name-pa"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'rational' ">
        <xsl:value-of select="$contentarea-ui-name-r"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'security' ">
        <xsl:value-of select="$contentarea-ui-name-s"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'tivoli' ">
        <xsl:value-of select="$contentarea-ui-name-tiv"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'web' ">
        <xsl:value-of select="$contentarea-ui-name-wa"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'webservices' ">
        <xsl:value-of select="$contentarea-ui-name-ws"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'websphere' ">
        <xsl:value-of select="$contentarea-ui-name-web"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'xml' ">
        <xsl:value-of select="$contentarea-ui-name-x"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'cloud' ">
        <xsl:copy-of select="$contentarea-ui-name-cl"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'industry' ">
        <xsl:copy-of select="$contentarea-ui-name-in"/>
      </xsl:when> 
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!--  ContentAreaMetaKeyword; works with keywords template for Search, allowing search to include secondary content areas within those search scopes with this and naming code in search app -->
  <xsl:template name="ContentAreaMetaKeyword">
    <xsl:param name="contentarea"/>
    <xsl:choose>
      <xsl:when test="$contentarea = 'architecture'">, tttarca</xsl:when>
      <xsl:when test="$contentarea = 'aix'">, dddauca</xsl:when>
      <xsl:when test="$contentarea = 'autonomic'">, tttacca</xsl:when>
      <xsl:when test="$contentarea = 'data'">, ddddmca</xsl:when>
       <xsl:when test="$contentarea = 'grid'">, tttgrca</xsl:when>
      <xsl:when test="$contentarea = 'ibm'">, ddditca</xsl:when>
      <xsl:when test="$contentarea = 'ibmi'">, dddibmica</xsl:when>
      <xsl:when test="$contentarea = 'java'">, tttjca</xsl:when>
      <xsl:when test="$contentarea = 'linux'">, tttlca</xsl:when>
      <xsl:when test="$contentarea = 'lotus'">, dddlsca</xsl:when>
      <xsl:when test="$contentarea = 'opensource'">, tttosca</xsl:when>
      <xsl:when test="$contentarea = 'power'">, tttpaca</xsl:when>
      <xsl:when test="$contentarea = 'rational'">, dddrca</xsl:when>
      <xsl:when test="$contentarea = 'tivoli'">, dddtdvca</xsl:when>
      <xsl:when test="$contentarea = 'web'">, tttwaca</xsl:when>
      <xsl:when test="$contentarea = 'webservices'">, tttwsca</xsl:when>
      <xsl:when test="$contentarea = 'websphere'">, dddwca</xsl:when>
      <xsl:when test="$contentarea = 'xml'">, tttxca</xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ContentAreaName">
    <xsl:param name="contentarea"/>
    <xsl:choose>
      <xsl:when test="$contentarea = 'aix' ">
        <xsl:copy-of select="$contentarea-ui-name-au"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'architecture' ">
        <xsl:copy-of select="$contentarea-ui-name-ar"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'autonomic' ">
        <xsl:copy-of select="$contentarea-ui-name-ac"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'grid' ">
        <xsl:copy-of select="$contentarea-ui-name-gr"/>
      </xsl:when>
      <xsl:when test="$contentarea = 'java' ">
        <xsl:copy-of select="$contentarea-ui-name-j"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'linux' ">
        <xsl:copy-of select="$contentarea-ui-name-l"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'opensource' ">
        <xsl:copy-of select="$contentarea-ui-name-os"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'webservices' ">
        <xsl:copy-of select="$contentarea-ui-name-ws"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'xml' ">
        <xsl:copy-of select="$contentarea-ui-name-x"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'security' ">
        <xsl:copy-of select="$contentarea-ui-name-s"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'web' ">
        <xsl:copy-of select="$contentarea-ui-name-wa"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'ibm' ">
        <xsl:copy-of select="$contentarea-ui-name-i"/>
      </xsl:when> 
      <xsl:when test="$contentarea= 'ibmi' ">
        <xsl:copy-of select="$contentarea-ui-name-ibmi"/>
      </xsl:when>     
      <xsl:when test="$contentarea= 'data' ">
        <xsl:copy-of select="$contentarea-ui-name-db2"/>
      </xsl:when>
       <xsl:when test="$contentarea= 'lotus' ">
        <xsl:copy-of select="$contentarea-ui-name-lo"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'rational' ">
        <xsl:copy-of select="$contentarea-ui-name-r"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'tivoli' ">
        <xsl:copy-of select="$contentarea-ui-name-tiv"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'websphere' ">
        <xsl:copy-of select="$contentarea-ui-name-web"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'power' ">
        <xsl:copy-of select="$contentarea-ui-name-pa"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'cloud' ">
        <xsl:copy-of select="$contentarea-ui-name-cl"/>
      </xsl:when>
      <xsl:when test="$contentarea= 'industry' ">
        <xsl:copy-of select="$contentarea-ui-name-in"/>
      </xsl:when> 
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ContentSpaceNavigation-v16">
		<!-- Determine column layout -->
		<xsl:variable name="columns">
			<xsl:choose>
				<xsl:when test="//@content-space-navigation='none'">0</xsl:when>
				<xsl:when test="count(//module//container-heading) = 1">0</xsl:when>				
				<xsl:when test="//@content-space-navigation='anchor-link-list-three-column' and (count(//module//container-heading) > 2)">3</xsl:when>
				<xsl:when test="//@content-space-navigation='anchor-link-list-two-column' and (count(//module//container-heading) > 1)">2</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Process anchor-link-list selection -->
		<xsl:choose>
		    <xsl:when test="$columns = 0">
				<!-- If no content space navigation or page introduction, but there is a tabbed module and subtitle, insert spacing for readability -->
				<xsl:if test="not(normalize-space(//abstract-extended))">
					<xsl:if test="(//module-tabbed) and normalize-space(//subtitle)">
						<div class="ibm-container ibm-alternate"><div class="ibm-container-body"><xsl:comment>Empty</xsl:comment></div></div>
					</xsl:if>
				</xsl:if>
				<xsl:if test="not(//@content-space-navigation='none') and normalize-space(//abstract-extended)">				
					<xsl:choose>
						<xsl:when test="//featured-content-module">
							<div class="ibm-container ibm-portrait-module ibm-alternate-two"><div class="ibm-container-body">
								<xsl:apply-templates select="//abstract-extended"/>
							</div></div>
						</xsl:when>
						<xsl:otherwise>
							<div class="ibm-container ibm-portrait-module ibm-alternate-two ibm-alternate-six"><div class="ibm-container-body">
								<xsl:apply-templates select="//abstract-extended"/>
							</div></div>	
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>				
		    </xsl:when>
		    <xsl:otherwise>
				<xsl:comment>ANCHOR_LINK_LIST_BEGIN</xsl:comment>
				<div>
				<xsl:choose>
					<xsl:when test="//featured-content-module">
						<xsl:attribute name="class">ibm-container</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-container ibm-alternate-six</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<div class="ibm-tab-section ibm-text">
				<h2 class="ibm-access">Page navigation</h2>
				<div>
					<xsl:choose>
						<xsl:when test="$columns = 3">
							<xsl:attribute name="class">ibm-tabs ibm-three-column</xsl:attribute>
						</xsl:when>
						<xsl:when test="$columns = 2">
							<xsl:attribute name="class">ibm-tabs ibm-two-column</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">ibm-tabs</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<!-- Build first column -->
					<div class="ibm-column ibm-first">
						<xsl:call-template name="ContentSpaceNavigationLinkList-v16">
							<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
							<xsl:with-param name="column-active">1</xsl:with-param>
						</xsl:call-template>			
					</div>
					<!-- Build second column -->
					<xsl:if test="$columns > 1">
						<div class="ibm-column ibm-second">
							<xsl:call-template name="ContentSpaceNavigationLinkList-v16">
								<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
								<xsl:with-param name="column-active">2</xsl:with-param>
							</xsl:call-template>
						</div>					
					</xsl:if>
					<!-- Build third column -->
					<xsl:if test="$columns > 2">
						<div class="ibm-column ibm-third">
							<xsl:call-template name="ContentSpaceNavigationLinkList-v16">
								<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
								<xsl:with-param name="column-active">3</xsl:with-param>
							</xsl:call-template>
						</div>					
					</xsl:if>
				</div>
				<!-- Create page abstract -->
				<xsl:if test="normalize-space(//abstract-extended)">
					<div class="ibm-rule"><hr /></div>
				</xsl:if>
				</div>
				<div class="ibm-container-body">
				<xsl:if test="normalize-space(//abstract-extended)">					
					<xsl:apply-templates select="//abstract-extended"/>					
				</xsl:if>
				<xsl:if test="not(normalize-space(//abstract-extended))">
					<xsl:comment>Empty</xsl:comment>
				</xsl:if>
				</div>
				</div>
				<xsl:comment>ANCHOR_LINK_LIST_END</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <xsl:template name="ContentSpaceNavigationLinkList-v16">
    	<xsl:param name="column-total"/>
		<xsl:param name="column-active"/>
		<!-- Calculate the number of headings for each column layout -->
		<xsl:variable name="container-headings-total">
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
					<xsl:value-of select="count(descendant::module//container-heading) + 1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(descendant::module//container-heading)"/>
				</xsl:otherwise>
			</xsl:choose>			
		</xsl:variable>
		<xsl:variable name="container-headings-half">
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
					<xsl:value-of select="ceiling((count(descendant::module//container-heading) + 1) div 2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ceiling(count(descendant::module//container-heading) div 2)"/>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>
		<xsl:variable name="container-headings-third">
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
					<xsl:value-of select="ceiling((count(descendant::module//container-heading) + 1) div 3)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ceiling(count(descendant::module//container-heading) div 3)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Build link list -->
		<ul class="ibm-link-list">
		  <xsl:for-each select="descendant::module//container-heading">
			<xsl:variable name="newid">
				<xsl:choose>
					<xsl:when test="normalize-space(@refname)">
						<xsl:value-of select="concat('#', @refname)"/>
					</xsl:when>
					<xsl:otherwise>
					<!-- Create an 8-character unique id -->
					<xsl:variable name="baseid">
						<!-- Start with 6 uppercase characters from the container-heading text; replace any spaces with the character 'Z' -->
						<xsl:value-of select="translate(translate(substring(.,1,6),' ','Z'),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
					</xsl:variable>
					<!-- Append the number of preceding nodes plus the current node; If the number is > 100, only use 5 characters from the container-heading text -->
					<xsl:choose>
						<xsl:when test="(1 + count(preceding::*)) > 100">
							<xsl:text>#</xsl:text>
							<xsl:value-of select="substring($baseid,1,5)"/>
							<xsl:value-of select="1 + count(preceding::*)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>#</xsl:text>
							<xsl:value-of select="$baseid"/>
							<xsl:value-of select="1 + count(preceding::*)"/>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!-- Build link list -->
			<xsl:choose>
				<xsl:when test="$column-total = 3">
					<xsl:choose>
						<xsl:when test="$column-active = 1">
							<xsl:if test="position() &lt;= $container-headings-third">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 2">
							<xsl:if test="(position() > $container-headings-third) and (position() &lt;= $container-headings-third * 2)">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 3">
							<xsl:if test="position() > $container-headings-third * 2">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="position() = last()">
								<xsl:if test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
									<li>
										<a class="ibm-anchor-down-em-link" href="#download">
											<xsl:value-of select="$downloads-heading"/>
										</a>
									</li>
								</xsl:if>
							</xsl:if>							
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$column-total = 2">
					<xsl:choose>
						<xsl:when test="$column-active = 1">
							<xsl:if test="position() &lt;= $container-headings-half">
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 2">
							<xsl:if test="position() > $container-headings-half">
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="position() = last()">
								<xsl:if test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
									<li>
										<a class="ibm-anchor-down-em-link" href="#download">
											<xsl:value-of select="$downloads-heading"/>
										</a>
									</li>
								</xsl:if>
							</xsl:if>							
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a class="ibm-anchor-down-em-link" href="{$newid}">
							<xsl:choose>
								<xsl:when test="normalize-space(@alttoc)">
									<xsl:value-of select="./@alttoc"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="."/>
									</xsl:otherwise>
							</xsl:choose>
						</a>
					</li>
					<!-- Added if test to create anchor link list reference if page has download table (1-column) -->
					<xsl:if test="position() = last()">
						<xsl:if test="/dw-document/dw-landing-generic/target-content-file/@filename!=''">
							<li>
								<a class="ibm-anchor-down-em-link" href="#download">
									<xsl:value-of select="$downloads-heading"/>
								</a>
							</li>
						</xsl:if>
					</xsl:if>					
				</xsl:otherwise>	
			</xsl:choose>
		  </xsl:for-each>
		</ul>
    </xsl:template>
	<!-- NOT USED FOR 7.0 -->
	<!-- Comments box used only for China due to government censorship -->
	 <xsl:template name="cnComments-v16">
		<xsl:if test="/dw-document//@local-site ='china'">
			<xsl:variable name="cntitleinput">
				<xsl:call-template name="FullTitle-v17"/>
			</xsl:variable>
			<xsl:variable name="contentareaforinput">
				<xsl:call-template name="ContentAreaInputName">
					<xsl:with-param name="contentarea">
						<xsl:value-of select="content-area-primary/@name"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="count(content-area-secondary) > 0">
					<xsl:text>, </xsl:text>
					<xsl:for-each select="content-area-secondary">
						<xsl:if test="position()!=1">, </xsl:if>
						<xsl:call-template name="ContentAreaInputName">
							<xsl:with-param name="contentarea">
								<xsl:value-of select="@name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>
			</xsl:variable>
			<div class="ibm-alternate-rule"><hr /></div>
			<xsl:text disable-output-escaping="yes"><![CDATA[
				<script type="text/javascript">//
function setSubject(fel) {
	if (!document.getElementById || !document.createElement) return;
	var sub = 'Standards query';
	var toel = document.getElementById('to');
	if (toel && toel.options) {
		var i = (toel.selectedIndex) ? toel.selectedIndex : 0;
		sub += ': ' + toel.options[i].text;
	}
	var inel = document.createElement('input');
	if (!inel) return;
	inel.setAttribute('type', 'hidden');
	inel.name = 'subject';
	inel.value = sub;
	if (fel.appendChild) fel.appendChild(inel);
}
//></script>
			<form action="https://www.ibm.com/developerworks/secure/cnratings.jsp" method="GET" id="comments-form">
				<input value="]]></xsl:text><xsl:value-of select="$cntitleinput"/><xsl:text disable-output-escaping="yes"><![CDATA[" name="ArticleTitle" type="hidden"/>
				<input value="]]></xsl:text><xsl:value-of select="$contentareaforinput"/><xsl:text disable-output-escaping="yes"><![CDATA[" name="Zone" type="hidden"/>
				<input value="http://www.ibm.com/developerworks/cn/thankyou/" name="RedirectURL" type="hidden"/>
				<input value="china" name="localsite" type="hidden"/>
				<script language="javascript">document.write('<input type="hidden" name="url" value="'+location.href+'" />');</script>
				<p><label for="cmts">请提供帮助改进此页的意见：</label></p>
				
				<p><textarea id="cmts" cols="70" rows="7" name="Comments"></textarea></p>
				
				<div class="ibm-rule"><hr /></div>
				<div class="ibm-buttons-row">
					<p><input value="提交" type="submit" name="ibm-submit" class="ibm-btn-arrow-pri"/><span class="ibm-sep">&nbsp;</span>
					<input class="ibm-btn-cancel-sec" onClick="document.getElementById('comments-form').reset()" name="ibm-cancel" type="button" value="取消"/> </p></div>
				
			</form>]]></xsl:text>
		</xsl:if>
	</xsl:template> 
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="CustomizedLogo">
    <xsl:if test="//dw-summary//customized-logo/img">
    	<xsl:apply-templates select="//customized-logo/img"/>
	</xsl:if> 
  </xsl:template>
  <!-- DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD -->
<!-- NOT USED FOR 7.0 -->
  <xsl:template name="DateSummary-v16">
	  <strong>
		  <xsl:value-of select="$date"/>
	  </strong>
	  <!-- Spacing -->
	       <xsl:choose>
		  <xsl:when test="/dw-document//@local-site='china'">
		      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
		  </xsl:when>
          <xsl:otherwise>      
	  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
          </xsl:otherwise>
      </xsl:choose>
	  <xsl:choose>
		  <xsl:when test="/dw-document//@local-site='worldwide'">
			  <xsl:choose>
			      <!-- If content has been updated, display updated date as current date -->
				  <xsl:when test="//date-updated">
					  <xsl:variable name="monthname">
						  <xsl:call-template name="MonthName">
							  <xsl:with-param name="month">
								  <xsl:value-of select="//date-updated/@month"/>
                              </xsl:with-param>
                          </xsl:call-template>
                      </xsl:variable>
                      <xsl:if test="//date-updated/@day">
						  <xsl:value-of select="//date-updated/@day"/>
                          <xsl:text> </xsl:text>
                      </xsl:if>
					  <xsl:value-of select="$monthname"/>
					  <xsl:text disable-output-escaping="no">  </xsl:text>
					  <xsl:value-of select="//date-updated/@year"/>
					  <!-- Display published date in parentheses -->
					  <xsl:text> (</xsl:text>
					  <xsl:value-of select="$published"/>
                      <xsl:text> </xsl:text>
					  <xsl:variable name="publishedMonthName">
						  <xsl:call-template name="MonthName">
							  <xsl:with-param name="month">
								  <xsl:value-of select="//date-published/@month"/>
                              </xsl:with-param>
                          </xsl:call-template>
                      </xsl:variable>
                      <xsl:if test="//date-published/@day">
						  <xsl:value-of select="//date-published/@day"/>
                          <xsl:text> </xsl:text>
                      </xsl:if>
					  <xsl:value-of select="$publishedMonthName"/>
					  <xsl:text disable-output-escaping="no"> </xsl:text>
					  <xsl:value-of select="//date-published/@year"/>
					  <xsl:text>)</xsl:text>
				  </xsl:when>
				  <xsl:otherwise>
					  <xsl:variable name="publishedMonthName">
						  <xsl:call-template name="MonthName">
							  <xsl:with-param name="month">
								  <xsl:value-of select="//date-published/@month"/>
                              </xsl:with-param>
                          </xsl:call-template>
                      </xsl:variable>
                      <xsl:if test="//date-published/@day">
						  <xsl:value-of select="//date-published/@day"/>
                          <xsl:text> </xsl:text>
                      </xsl:if>
					  <xsl:value-of select="$publishedMonthName"/>
					  <xsl:text disable-output-escaping="no"> </xsl:text>
					  <xsl:value-of select="//date-published/@year"/>
				  </xsl:otherwise>
			  </xsl:choose>
	  </xsl:when>
	  	<xsl:when test="/dw-document//@local-site='russia'">
	  		<xsl:choose>
	  			<!-- If content has been updated, display updated date as current date -->
	  			<xsl:when test="//date-updated">
	  				<xsl:variable name="monthname">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-updated/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-updated/@day">
	  					<xsl:value-of select="//date-updated/@day"/>
	  					<xsl:text>.</xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$monthname"/>
	  				<xsl:text disable-output-escaping="no">.</xsl:text>
	  				<xsl:value-of select="//date-updated/@year"/>
	  				<!-- Display published date in parentheses -->
	  				<xsl:text> (</xsl:text>
	  				<xsl:value-of select="$published"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>.</xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">.</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:text>)</xsl:text>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>.</xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">.</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:when>
	  	<xsl:when test="/dw-document//@local-site='ssa'">
	  		<xsl:choose>
	  			<!-- If content has been updated, display updated date as current date -->
	  			<xsl:when test="//date-updated">
	  				<xsl:if test="//date-updated/@day">
	  					<xsl:value-of select="//date-updated/@day"/>
	  					<xsl:text>-</xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="monthname">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-updated/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$monthname"/>
	  				<xsl:text disable-output-escaping="no">-</xsl:text>
	  				<xsl:value-of select="//date-updated/@year"/>
	  				<!-- Display published date in parentheses -->
	  				<xsl:text> (</xsl:text>
	  				<xsl:value-of select="$published"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>-</xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">-</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:text>)</xsl:text>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>-</xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">-</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:when>
	  	<xsl:when test="/dw-document//@local-site='brazil'">
	  		<xsl:choose>
	  			<!-- If content has been updated, display updated date as current date -->
	  			<xsl:when test="//date-updated">
	  				<xsl:if test="//date-updated/@day">
	  					<xsl:value-of select="//date-updated/@day"/>
	  					<xsl:text>/</xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="monthname">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-updated/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$monthname"/>
	  				<xsl:text disable-output-escaping="no">/</xsl:text>
	  				<xsl:value-of select="//date-updated/@year"/>
	  				<!-- Display published date in parentheses -->
	  				<xsl:text> (</xsl:text>
	  				<xsl:value-of select="$published"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>/</xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">/</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:text>)</xsl:text>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text>/</xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no">/</xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:when>
	  	<xsl:when test="/dw-document//@local-site='vietnam'">
	  		<xsl:choose>
	  			<!-- If content has been updated, display updated date as current date -->
	  			<xsl:when test="//date-updated">
	  				<xsl:if test="//date-updated/@day">
	  					<xsl:value-of select="//date-updated/@day"/>
	  					<xsl:text> </xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="monthname">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-updated/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$monthname"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:value-of select="//date-updated/@year"/>
	  				<!-- Display published date in parentheses -->
	  				<xsl:text> (</xsl:text>
	  				<xsl:value-of select="$published"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text> </xsl:text>
	  				</xsl:if>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:text>)</xsl:text>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:text> </xsl:text>
	  				</xsl:if>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<xsl:choose>
	  			<!-- If content has been updated, display updated date as current date -->
	  			<xsl:when test="//date-updated">
	  				<xsl:value-of select="//date-updated/@year"/>
	  				<xsl:copy-of select="$yearchar"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:variable name="monthname">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-updated/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$monthname"/>
	  				<xsl:copy-of select="$monthchar"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:if test="//date-updated/@day">
	  					<xsl:value-of select="//date-updated/@day"/>
	  					<xsl:copy-of select="$daychar"/>
	  				</xsl:if>
	  				<!-- Display published date in parentheses -->
	  				<xsl:text> (</xsl:text>
	  				<xsl:value-of select="$published"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:copy-of select="$yearchar"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:copy-of select="$monthchar"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:copy-of select="$daychar"/>
	  				</xsl:if>
	  				<xsl:text>)</xsl:text>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<xsl:value-of select="//date-published/@year"/>
	  				<xsl:copy-of select="$yearchar"/>
	  				<xsl:text> </xsl:text>
	  				<xsl:variable name="publishedMonthName">
	  					<xsl:call-template name="MonthName">
	  						<xsl:with-param name="month">
	  							<xsl:value-of select="//date-published/@month"/>
	  						</xsl:with-param>
	  					</xsl:call-template>
	  				</xsl:variable>
	  				<xsl:value-of select="$publishedMonthName"/>
	  				<xsl:copy-of select="$monthchar"/>
	  				<xsl:text disable-output-escaping="no"> </xsl:text>
	  				<xsl:if test="//date-published/@day">
	  					<xsl:value-of select="//date-published/@day"/>
	  					<xsl:copy-of select="$daychar"/>
	  				</xsl:if>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:otherwise>
	  </xsl:choose>   
  </xsl:template>
    <!-- v17 Enablement jpp 09/13/2011:  REPLACED dcDate-v16 template with dcDate-v17 -->
	<!-- USED FOR 7.0 -->
  	<!-- dcDate-v17 template that creates value for DC.Date meta tag -->
	<xsl:template name="dcDate-v17">
	    <xsl:variable name="dcdate">
			<xsl:choose>
			    <xsl:when test="//date-updated">
					<xsl:value-of select="//date-updated/@year"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="//date-updated/@month"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="//date-updated/@day"/>
				</xsl:when>
			    <xsl:otherwise>
					<xsl:value-of select="//date-published/@year"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="//date-published/@month"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="//date-published/@day"/>
			   </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$dcdate"/>
	</xsl:template>
    <!-- v17 Enablement jpp 09/13/2011:  REPLACED dcRights template with dcRights-v17 -->
	<!-- USED FOR 7.0 -->
	<!-- dcRights-v17 template generates value for DC.Rights meta tag -->
	<xsl:template name="dcRights-v17">
	    <xsl:text>&#169; Copyright&nbsp;</xsl:text>
        <xsl:text>IBM Corporation&nbsp;</xsl:text>
		<xsl:value-of select="//date-published/@year"/>
		<xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
			<xsl:text>,&nbsp;</xsl:text>
			<xsl:value-of select="//date-updated/@year" />
		</xsl:if>
    </xsl:template>
    <!-- v17 Enablement jpp 09/13/2011:  REPLACED dcSubject-v16 template with dcSubject-v17 -->
	<!-- USED FOR 7.0 -->
	<!-- dcSubject-v17 template that creates value for DC.Subject meta tag -->
	<xsl:template name="dcSubject-v17">
		<xsl:choose>
			<xsl:when test="/dw-document/dw-home">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>
			<!-- Project Defiant jpp 10/10/11: Added xsl:when test for dw-results -->
			<xsl:when test="/dw-document/dw-results">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>		
			<!-- <xsl:when test="(/dw-document//content-area-primary/@name='autonomic') or (/dw-document//pagegroup/content-area-primary/@name='autonomic')">
				<xsl:text>TTD00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='architecture') or (/dw-document//pagegroup/content-area-primary/@name='architecture')">
				<xsl:text>TT200</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='aix') or (/dw-document//pagegroup/content-area-primary/@name='aix')">
				<xsl:text>SWG10</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='cloud') or (/dw-document//pagegroup/content-area-primary/@name='cloud')">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='industry') or (/dw-document//pagegroup/content-area-primary/@name='industry')">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='data') or (/dw-document//pagegroup/content-area-primary/@name='data')">
				<xsl:text>BA.007H</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='grid') or (/dw-document//pagegroup/content-area-primary/@name='grid')">
				<xsl:text>TTE00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='ibm') or (/dw-document//pagegroup/content-area-primary/@name='ibm')">
				<xsl:text>SW700</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='ibmi') or (/dw-document//pagegroup/content-area-primary/@name='ibmi')">
				<xsl:text>SSAVDK</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='java') or (/dw-document//pagegroup/content-area-primary/@name='java')">
				<xsl:text>TT300</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='linux') or (/dw-document//pagegroup/content-area-primary/@name='linux')">
				<xsl:text>SWGC0</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='lotus') or (/dw-document//pagegroup/content-area-primary/@name='lotus')">
				<xsl:text>BA.0080</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='none') or (/dw-document//pagegroup/content-area-primary/@name='none')">
				<xsl:text>ZZ999</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='opensource') or (/dw-document//pagegroup/content-area-primary/@name='opensource')">
				<xsl:text>TT400</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='power') or (/dw-document//pagegroup/content-area-primary/@name='power')">
				<xsl:text>TT600</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='rational') or (/dw-document//pagegroup/content-area-primary/@name='rational')">
				<xsl:text>BA.007D</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='security') or (/dw-document//pagegroup/content-area-primary/@name='security')">
				<xsl:text>TTK00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='tivoli') or (/dw-document//pagegroup/content-area-primary/@name='tivoli')">
				<xsl:text>BA.0072</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='web') or (/dw-document//pagegroup/content-area-primary/@name='web')">
				<xsl:text>TTA00</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='webservices') or (/dw-document//pagegroup/content-area-primary/@name='webservices')">
				<xsl:text>TT700</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='websphere') or (/dw-document//pagegroup/content-area-primary/@name='websphere')">
				<xsl:text>BA.007G</xsl:text>
			</xsl:when>
			<xsl:when test="(/dw-document//content-area-primary/@name='xml') or (/dw-document//pagegroup/content-area-primary/@name='xml')">
				<xsl:text>TTC00</xsl:text>
			</xsl:when> -->
		</xsl:choose>
	</xsl:template>
    <!-- v17 Enablement jpp 09/14/2011:  REPLACED dcType-v16 template with dcType-v17 -->
	<!-- USED FOR 7.0 -->
	<!-- dcType-v17 template that creates value for DC.Type meta tag -->
	<xsl:template name="dcType-v17">
		<xsl:param name="landing-page-name" />
		<xsl:if test="/dw-document/dw-home">
				<xsl:text>CT900</xsl:text>
		</xsl:if>
		<!-- Project Defiant jpp 10/10/11: Added xsl:when test for dw-results -->
		<xsl:if test="/dw-document/dw-results">
				<!-- Project Defiant jpp 02/27/12: Updated text for dw-results -->
				<xsl:text>CT301</xsl:text>
		</xsl:if>
		<!-- v17 Enablement jpp 09/14/2011:  LEAVE placeholder xsl:choice to handle future multi-page templates -->
	   	<!-- <xsl:choose>
			<xsl:when test="/dw-document//pagegroup">
				<xsl:choose>
					<xsl:when test="normalize-space(following::content[1]/meta-information/meta-dctype/cma-defined-type)">
						<xsl:value-of select="following::content[1]/meta-information/meta-dctype/cma-defined-type"/>
					</xsl:when>
					<xsl:when test="not(normalize-space(following::content[1]/meta-information/meta-dctype/cma-defined-type)) and /dw-document/dw-landing-generic-pagegroup">
						<xsl:text>CT801</xsl:text>
					</xsl:when>
					<xsl:when test="not(normalize-space(following::content[1]/meta-information/meta-dctype/cma-defined-type)) and /dw-document/dw-trial-program-pages">
						<xsl:text>CT554</xsl:text>
					</xsl:when>		
				</xsl:choose>
			</xsl:when>
			<xsl:when test="/dw-document//pagegroup-hidef">
				<xsl:choose>
					<xsl:when test="(normalize-space(following::content[1]/meta-information/meta-dctype/cma-defined-type))">
						<xsl:value-of select="following::content[1]/meta-information/meta-dctype/cma-defined-type"/>
					</xsl:when> 
					<xsl:when test="not(normalize-space(following::content[1]/meta-information/meta-dctype/cma-defined-type))">
						<xsl:text>CT300</xsl:text>
					</xsl:when>		
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not(/dw-document/dw-landing-generic-pagegroup or /dw-document/dw-trial-program-pages or /dw-document/dw-landing-generic-pagegroup-hidef)">
	    <xsl:choose>
			<xsl:when test="/dw-document/dw-dwtop-home or /dw-document/dw-dwtop-home-hidef">
				<xsl:text>CT900</xsl:text>
			</xsl:when>
			<xsl:when test="/dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='aix' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='ibmi' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='architecture' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='autonomic' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='grid' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='security' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='java' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='linux' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='power' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='opensource' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='webservices' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='web' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='xml'">
				<xsl:text>CT300</xsl:text>
			</xsl:when> 
			<xsl:when
				    	    test="/dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='db2' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='data' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='lotus' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='rational' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='tivoli' or /dw-document/dw-dwtop-zoneoverview/content-area-primary/@name='websphere'">
				<xsl:text>CT505</xsl:text>
			</xsl:when>
			<xsl:when test="normalize-space(/dw-document//meta-dctype/cma-defined-type)!=''">
				<xsl:value-of select="/dw-document//meta-dctype/cma-defined-type"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="/dw-document/dw-article or /dw-document/dw-summary-long or /dw-document/dw-summary/@summary-content-type='longdoc'">
						<xsl:text>CT316</xsl:text>
					</xsl:when>
					<xsl:when test="(/dw-document/dw-landing-product/@page-type='product') or (/dw-document/dw-landing-product/@page-type='product-condensed')">
						<xsl:text>CT512</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-product/@page-type='product-family'">
						<xsl:text>CT509</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-tutorial">
						<xsl:text>CT321</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-chat or /dw-document/dw-summary/@summary-content-type='chat'">
						<xsl:text>CT916</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-demo or /dw-document/dw-summary/@summary-content-type='demo'">
						<xsl:text>CT551</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-event-tech-briefing or /dw-document/dw-summary/@summary-content-type='briefing'">
						<xsl:text>CTA07</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-event-workshop-invite or /dw-document/dw-summary-event-workshop-result or /dw-document/dw-summary/@summary-content-type='workshop'">
						<xsl:text>CT320</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-podcast">
						<xsl:text>CTA18</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-presentation or /dw-document/dw-summary/@summary-content-type='presentation'">
						<xsl:text>CT613</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-sample or /dw-document/dw-summary/@summary-content-type='sample'">
						<xsl:text>CT733</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-product/@page-type='integration'">
						<xsl:text>CT820</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-tutorial">
						<xsl:text>CT330</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-training">
						<xsl:text>CT329</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-landing-generic">
						<xsl:text>CT801</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-registration or /dw-document/dw-summary/@summary-content-type='registration'">
						<xsl:text>CT102</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-download-general or /dw-document/dw-summary/@summary-content-type='download'">
						<xsl:text>CT727</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-summary-spec or /dw-document/dw-summary/@summary-content-type='specification'">
						<xsl:text>CT306</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-sidefile">
						<xsl:text>CTZZZ</xsl:text>
					</xsl:when>
					<xsl:when test="/dw-document/dw-knowledge-path">
						<xsl:text>CT323</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>CTZZZ</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if> -->
	</xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-blockquote" match="blockquote">
    <blockquote>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
   <!-- Need to accound for <br> when calculating line lengths -->
  <xsl:template match="br" mode="no-escaping">
        <!--  convert <br> in code to new line when calculating chunk lengths  -->
        <xsl:value-of select=" '&#0010;'  "/>
    </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-br" match="br">
    <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-dd" match="dd">
    <dd>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </dd>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-dl" match="dl">
    <dl>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </dl>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-i" match="i">
    <xsl:choose>
      <xsl:when test="string-length(normalize-space(.)) = 0">
           <xsl:apply-templates />
      </xsl:when>
      <xsl:otherwise>
     <em>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </em>
      </xsl:otherwise>
</xsl:choose>
 </xsl:template>
 <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-li" match="li">
    <li>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-ol" match="ol">
    <ol>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-pre" match="pre">
    <pre>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-sub" match="sub">
    <xsl:choose>
      <xsl:when test="string-length(normalize-space(.)) = 0">
           <xsl:apply-templates />
       </xsl:when>
      <xsl:otherwise>
     <sub>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </sub>
      </xsl:otherwise>
</xsl:choose>
 </xsl:template>
 <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-sup" match="sup">
    <xsl:choose>
      <xsl:when test="string-length(normalize-space(.)) = 0">
           <xsl:apply-templates />
      </xsl:when>
      <xsl:otherwise>
    <sup>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </sup>
      </xsl:otherwise>
</xsl:choose>
  </xsl:template>	
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Default-ul" match="ul">
	<xsl:choose>
		<xsl:when test="/dw-document/dw-landing-generic/module/container-html/container-html-body">
			<ul class="ibm-bullet-list ibm-no-links" xsl:exclude-result-prefixes="xsl fo">
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:when>		
		<xsl:when test="ancestor::container-html-body or ancestor::container-html-body-hidef">
			<ul class="ibm-bullet-list ibm-no-links" xsl:exclude-result-prefixes="xsl fo">
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:when>
		<xsl:when test="ancestor::twisty-html-body">
			<ul class="ibm-bullet-list" xsl:exclude-result-prefixes="xsl fo">
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:when>
		<xsl:when test="ancestor::selected-tab-container">
			<ul class="ibm-bullet-list" xsl:exclude-result-prefixes="xsl fo">
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:when>
		<xsl:when test="ancestor::panel-html-body">
			<ul class="ibm-bullet-list ibm-no-links" xsl:exclude-result-prefixes="xsl fo">
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:when>
		<xsl:otherwise>
			<ul>
				<xsl:for-each select="@*">
					<xsl:copy/>
				</xsl:for-each>
				<xsl:apply-templates/>
			</ul>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template> 
  <!-- NOT USED FOR 7.0 -->
   <xsl:template name="DetectLineFeed">
   <xsl:choose>
      <xsl:when test="contains(., '&#10;')">
      <!-- If a line feed is present (ASCII decimal &#10;), this is a text node:
             * It might begin with a line feed
             * It might have one or more line feeds within it
             * Therefore, we call CheckNumChar (a recursive template) to iteratively
                address text chunks betw all line feeds.  Pass it the max length it 
                should check for. -->
         <xsl:call-template name="CheckNumChar" />
      </xsl:when>
      <xsl:otherwise>
         <!-- If a line feed is not present, this is an element node.
                * Element nodes within code section lines should not span physical lines (i.e., shouldn't contain &#10;) though schema allows it). -->
         <xsl:apply-templates select="."/>
         <!-- Since any line feed is outside the element node's value, we have to add one -->
         <xsl:if test="not(contains(following-sibling::node()[1],'&#10;'))"><xsl:copy-of select="'&#10;'"/></xsl:if>
         <!-- Now check to see if the element node value's length blows the limit and call DisplayError if necessary -->
         <xsl:if test="string-length(.) &gt; 90">
            <xsl:copy-of select="'&#10;'" />
            <xsl:call-template name="DisplayError">
               <xsl:with-param name="error-number">e001</xsl:with-param>
               <xsl:with-param name="display-format">inline</xsl:with-param>
            </xsl:call-template>
            <xsl:copy-of select="'&#10;'"/>
         </xsl:if>
      </xsl:otherwise>
 </xsl:choose>                  
 </xsl:template> 
 <!-- NOT USED FOR 7.0 -->
  <!-- DisplayError for general XSL error handling -->
  <xsl:template name="DisplayError">
  <xsl:param name="error-number" />
  <xsl:param name="display-format" />
  <!-- Assign error text variable based on error number -->
  <xsl:variable name="error-text">
  <xsl:choose>
    <xsl:when test="$error-number = 'e001'"><xsl:value-of select="$e001" /></xsl:when>
    <xsl:when test="$error-number = 'e002'"><xsl:value-of select="$e002" /></xsl:when>
    <xsl:when test="$error-number = 'e003'"><xsl:value-of select="$e003" /></xsl:when>
    <xsl:when test="$error-number = 'e004'"><xsl:value-of select="$e004" /></xsl:when>
    <xsl:when test="$error-number = 'e005'"><xsl:value-of select="$e005" /></xsl:when>
    <xsl:when test="$error-number = 'e006'"><xsl:value-of select="$e006" /></xsl:when>
    <xsl:otherwise><xsl:value-of select="$e999" /></xsl:otherwise>
  </xsl:choose>
  </xsl:variable>
  <!-- Display the error text per the passed format -->
  <xsl:choose>
    <xsl:when test="$display-format = 'inline'">
       <xsl:choose>
       <!-- Special case:  I have to match the code section font for error e001 -->
        <xsl:when test="$error-number = 'e001'">       
         <span style="margin-top: 0; margin-bottom: 0; font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; font-size: 11px; color: #ff0000"><xsl:value-of select="$error-text" /></span>
        </xsl:when>
        <xsl:otherwise><span style="color: #ff0000"><xsl:value-of select="$error-text" /></span></xsl:otherwise>
      </xsl:choose>       
    </xsl:when>
    <xsl:when test="$display-format = 'table'">
       <table border="1" summary="{$errorTableSummaryAttribute}" ><tr><td style="color: #ff0000"><xsl:value-of select="$error-text" /></td></tr></table>
    </xsl:when>
  </xsl:choose>
   <!--  Choose block to display errors on console and terminate
     on final transform with long line length for publication date 2008 and later -->
    <xsl:choose>
      <xsl:when test="($xform-type = 'final' ) and ($error-number = 'e001') and
        (//date-published/@year &gt;= 2008)">
        <xsl:message terminate="yes"><xsl:value-of select="$error-text" /></xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="no"><xsl:value-of select="$error-text" /></xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="div | object | param | embed">
    <xsl:element name="{name()}">
      <xsl:for-each select="@*">
        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates select="*|text()|comment()|processing-instruction()"/>
    </xsl:element>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="docbody">
    <xsl:apply-templates select="a | b | blockquote | br | code | dl | figure | heading | i | img | include | ol | p | pre | sidebar | sidebar-custom | table | sub | sup | ul | text()"/>
     <xsl:call-template name="cmaSiteStylesheetId-v17"/></xsl:template>
     <!--NOT USED FOR 7.0 -->
    <xsl:template match="p">
		<xsl:choose>
			<!-- if the paragraph tag is empty, do nothing -->
			<xsl:when test="not(normalize-space(.))" />
			<xsl:otherwise>    
				<p>
				<xsl:apply-templates select="*|text()"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>    
    </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- local sites now display translated or English license agreements on downloads in same manner as ww -->
 <xsl:template name="Download">
	<xsl:variable name="downloadTableWidth">
      <xsl:choose>
        <xsl:when test="not(/dw-document/dw-tutorial)">
          <xsl:text disable-output-escaping="yes">100%</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text disable-output-escaping="yes">70%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
	<!-- IF TARGET-CONTENT-FILE -->
    <xsl:if test="target-content-file/@filename!='' or following::content[1]/target-content-file/@filename!=''">
    <!-- begin download table -->
	  <!-- Test to NOT include br tag for landing generic pages -->
	  <xsl:if test="not(/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages)">
		<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
	  </xsl:if>
      <xsl:if test=". = ../dw-article">
        <xsl:copy-of select="$ssi-s-backlink-rule"/>
      </xsl:if> 
          <!-- Remove download table heading for landing pages -->
	  <xsl:choose>
		  <xsl:when test="//dw-landing-generic-pagegroup | //dw-trial-program-pages">
		  </xsl:when>
		  <xsl:when test="../dw-landing-generic">
		  </xsl:when>
      <xsl:otherwise>
      <p>
        <xsl:choose>
          <xsl:when test=". = ../dw-article or . = ../dw-tutorial or . = ../dw-summary">
            <xsl:text disable-output-escaping="yes"><![CDATA[<span class="atitle">]]></xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text disable-output-escaping="yes"><![CDATA[<span class="smalltitle">]]></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <a name="download">
          <xsl:choose>
            <xsl:when test=". = ../dw-summary-podcast">
              <xsl:value-of select="$summary-getThePodcast"/>
            </xsl:when>
            <xsl:when test=". = ../dw-summary-event-workshop-invite">
              <xsl:value-of select="$summary-getTheWorkshopMaterials"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="count(target-content-file) > 1">
                  <xsl:value-of select="$downloads-heading"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$download-heading"/>
</xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </a>
        <xsl:text disable-output-escaping="yes"><![CDATA[</span>]]></xsl:text>
      </p>
     </xsl:otherwise>
    </xsl:choose>
      <table border="0" cellpadding="0" cellspacing="0" class="ibm-data-table" summary="{$downloadTableSummaryAttribute}" width="{$downloadTableWidth}">
        <tr>
          <!-- Description -->
          <xsl:if test="//target-content-file/@file-description !=''">
            <th scope="col">
              <xsl:value-of select="$download-filedescription-heading"/>
            </th>
          </xsl:if>          
         <th scope="col">
            <xsl:value-of select="$download-filename-heading"/>
          </th>
         <th scope="col">
            <xsl:value-of select="$download-filesize-heading"/>
          </th>
          <th scope="col">
            <xsl:value-of select="$download-method-heading"/>
          </th>
        </tr>
        <!-- CONTENT -->
		<xsl:for-each select="target-content-file | following::content[1]/target-content-file">
          <tr>
            <xsl:choose>
            <xsl:when test="@file-description !=''">
             <td scope="row" class="tb-row">
                <xsl:value-of select="@file-description"/>
                   <xsl:if test="normalize-space(note)!=''">
                   <!-- Count notes within a single page in a landing pagegroup -->
                   <xsl:choose>
						<xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
							<sup><xsl:value-of select="count(preceding-sibling::target-content-file/note[not(normalize-space(.)='')]) + 1" /></sup>
						</xsl:when>
						<xsl:otherwise>
							<sup><xsl:value-of select="count(preceding::note[not(normalize-space(.)='')])+1"  /></sup>
						</xsl:otherwise>
					</xsl:choose>
                   </xsl:if>
              </td>
            </xsl:when>
            <!-- On a landing generic pagegroup page/subpage, if this file-description is null but other t-c-f elements' file-description 
			attrib isn't null, add a blank td for this one -->
            <!-- Bad expression in xsl:when test throws Xalan error.  Parens added to correct parsing. -->
            <xsl:when test="(dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages) and 
                (@file-description ='') and (../target-content-file/@file-description !='')">
               <td class="tb-row">
                <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="1" height="1" alt=""/>
              </td>
            </xsl:when>
            <!-- If this file-description is null but other t-c-f elements' file-description attrib isn't null, add a blank td for this one -->
            <xsl:when test="@file-description ='' and /dw-document//target-content-file/@file-description !=''">
               <td class="tb-row">
                <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="1" height="1" alt=""/>
              </td>
            </xsl:when>
            <!-- Otherwise, don't add a cell -->
            <xsl:otherwise />
            </xsl:choose>
            <td nowrap="nowrap">
                <xsl:if test="@file-type = 'mp3'">
                <xsl:text disable-output-escaping="yes"><![CDATA[<img src="]]></xsl:text><xsl:value-of select="$newpath-ibm-local" /><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/v16/icons/aud.gif" height="16" width="16" alt="" align="middle" border="0" />]]></xsl:text>
              </xsl:if>
              <xsl:if test=" @file-type = 'avi' or   @file-type = 'mpg' or @file-type = 'mpeg'  or  @file-type = 'mov' or  @file-type = 'qt'  or  @file-type = 'rm'  or  @file-type = 'swf'  or  @file-type = 'wmv' ">
                <xsl:text disable-output-escaping="yes"><![CDATA[<img src="]]></xsl:text><xsl:value-of select="$newpath-ibm-local" /><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/v16/icons/video.gif" height="16" width="16" alt="" align="middle" border="0" />]]></xsl:text>
              </xsl:if>
              <xsl:value-of select="@filename"/>
            </td>
            <td nowrap="nowrap">
              <xsl:value-of select="@size"/>
            </td>
            <td nowrap="nowrap">
              <xsl:if test="@link-method-ftp = 'yes'">
               <!-- all downloads use license agreement now -->
                    <xsl:choose>
                      <!-- Only files with @content-type of 'Code sample' should have license display servlet-style URL -->
                      <xsl:when test="normalize-space(@target-content-type) = 'Code sample'">
                        <!-- A LINK LIKE THIS IS CREATED 
                       /developerworks/apps/download/index.jsp?contentid=300029&filename=samples.zip&method=ftp -->
                        <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=]]></xsl:text>
                        <xsl:value-of select="//id/@cma-id"/>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&amp;filename=]]></xsl:text>
                        <xsl:value-of select="@filename"/>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&amp;method=ftp&amp;locale=]]></xsl:text>
                        <xsl:value-of select="$license-locale-value" />
                        <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>FTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- NOT A CODE SAMPLE DOWNLOAD, THEREFORE NO LICENSE -->
                        <!-- Add onclick and onkeypress attributes to PDF links so PDF requests are captured by SurfAid -->
                        <!-- Add file-type=mp3 to get SA metrics -->
                        <xsl:choose>
                          <xsl:when test="@file-type= 'pdf' or @file-type='mp3'">
                            <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
                            <xsl:value-of select="@url-ftp"/>
                            <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>FTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
                            <xsl:value-of select="@url-ftp"/>
                            <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>FTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                 
                <!-- If http or dd too, then add a vertical bar after the ftp link -->
                <xsl:if test="@link-method-http = 'yes' or @link-method-dd = 'yes'">
                  <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/>|<img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/>
                </xsl:if>
              </xsl:if>     
              <xsl:if test="@link-method-http = 'yes'">
                <!-- all downloads use license agreement now -->
						<xsl:choose>
						  <!-- Only files with @content-type of 'Code sample' should have license display servlet-style URL -->
						  <xsl:when test="normalize-space(@target-content-type) = 'Code sample'">
						  <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=]]></xsl:text>
                          <xsl:value-of select="//id/@cma-id"/>
                          <xsl:text disable-output-escaping="yes"><![CDATA[&amp;filename=]]></xsl:text>
                          <xsl:value-of select="@filename"/>
                          <xsl:text disable-output-escaping="yes"><![CDATA[&amp;method=http&amp;locale=]]></xsl:text>
						    <xsl:value-of select="$license-locale-value" />
                          <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>HTTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                      </xsl:when>
                        <!-- NOT A CODE SAMPLE DOWNLOAD, THEREFORE NO LICENSE -->
                          <xsl:when test="@file-type= 'pdf' or @file-type='mp3'">
                            <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
							<xsl:choose>
								<xsl:when test="contains(@url-http,'//download.boulder.ibm.com/ibmdl/pub/')">
									<xsl:call-template name="ReplaceSubstring">
										<xsl:with-param name="original" select="@url-http" />
										<xsl:with-param name="substring" select="'//download.boulder.ibm.com/ibmdl/pub/'" />
										<xsl:with-param name="replacement" select="'//public.dhe.ibm.com/'" />
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@url-http"/>
								</xsl:otherwise>
							</xsl:choose>                            
                            <!-- <xsl:value-of select="@url-http"/> -->                            
                            <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>HTTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:choose>
                              <xsl:when test="//@local-site = 'worldwide'">
                            <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
								<xsl:choose>
									<xsl:when test="contains(@url-http,'//download.boulder.ibm.com/ibmdl/pub/')">
										<xsl:call-template name="ReplaceSubstring">
											<xsl:with-param name="original" select="@url-http" />
											<xsl:with-param name="substring" select="'//download.boulder.ibm.com/ibmdl/pub/'" />
											<xsl:with-param name="replacement" select="'//public.dhe.ibm.com/'" />
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@url-http"/>
									</xsl:otherwise>
								</xsl:choose> 
                            <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>HTTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
								<xsl:choose>
									<xsl:when test="contains(@url-http,'//download.boulder.ibm.com/ibmdl/pub/')">
										<xsl:call-template name="ReplaceSubstring">
											<xsl:with-param name="original" select="@url-http" />
											<xsl:with-param name="substring" select="'//download.boulder.ibm.com/ibmdl/pub/'" />
											<xsl:with-param name="replacement" select="'//public.dhe.ibm.com/'" />
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@url-http"/>
									</xsl:otherwise>
								</xsl:choose> 
                                <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>HTTP<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text> 
                              </xsl:otherwise>
						              </xsl:choose>
                          </xsl:otherwise>
                        </xsl:choose>
                    
                <xsl:if test="@link-method-dd = 'yes'">
                  <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/>
                  <xsl:text>|</xsl:text>
                  <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/>
                </xsl:if>
              </xsl:if>
              <xsl:if test="@link-method-dd = 'yes'">
                <xsl:choose>
                  <!-- Only worldwide site files with @content-type of 'Code sample' should have license display servlet-style URL -->
                  <!--  local sites now display license agreement -->
                  <xsl:when test="(normalize-space(@target-content-type) = 'Code sample')">
                    <!-- A LINK LIKE THIS IS CREATED FOR WORLDWIDE FILES 
                       /developerworks/apps/download/index.jsp?contentid=300029&filename=samples.zip&method=dd -->
                           <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="http://www.ibm.com/developerworks/apps/download/index.jsp?contentid=]]></xsl:text>
                    <xsl:value-of select="//id/@cma-id"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[&amp;filename=]]></xsl:text>
                    <xsl:value-of select="@filename"/>
                    <!-- Added locale parm (sourced from @local-site) per Devin -->
                    <xsl:text disable-output-escaping="yes"><![CDATA[&amp;method=dd&amp;locale=]]></xsl:text>
                    <xsl:value-of select="$license-locale-value" />
                    <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>Download Director<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- NOT A CODE SAMPLE DOWNLOAD, THEREFORE NO LICENSE -->
                    <xsl:text disable-output-escaping="yes"><![CDATA[<a class="fbox" href="]]></xsl:text>
                    <xsl:value-of select="@url-download-director"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>Download Director<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </table>
      
	  <p>
		    <xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
			  <xsl:attribute name="class">ibm-ind-link dw-landing-dltable-linklist</xsl:attribute>
		    </xsl:if>
			<xsl:choose>
              <xsl:when test="//@local-site ='korea'">
                <a class="ibm-forward-link" href="/developerworks/kr/library/whichmethod.html">
                  <xsl:value-of select="$download-method-link"/>
                </a>
              </xsl:when>
              <xsl:when test="//@local-site ='china'">
                 <a class="ibm-forward-link" href="/developerworks/cn/whichmethod.html">
                  <xsl:value-of select="$download-method-link"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
				 <xsl:choose>
						<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
							<a class="ibm-forward-link dw-landing-dltable-link" href="/developerworks/library/whichmethod.html">
								<xsl:value-of select="$download-method-link"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="ibm-forward-link" href="/developerworks/library/whichmethod.html">
								<xsl:value-of select="$download-method-link"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          <!-- Only one link to Adobe if at least one file-type = pdf -->
          <xsl:if test="target-content-file/@file-type='pdf' or following::content[1]/target-content-file/@file-type='pdf'">	  
			  <xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
					<a class="ibm-external-link dw-landing-dltable-link" href="http://www.adobe.com/products/acrobat/readstep2.html">
							<xsl:value-of select="$download-get-adobe" disable-output-escaping="yes"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="ibm-external-link" href="http://www.adobe.com/products/acrobat/readstep2.html">
							<xsl:value-of select="$download-get-adobe" disable-output-escaping="yes"/>
						</a>
				</xsl:otherwise>
			  </xsl:choose>
          </xsl:if>
        </p>
    </xsl:if>
    <!-- end download table -->
    <!-- IF TARGET CONTENT PAGE -->
		<xsl:if test="target-content-page/@link-text!=''">
			<xsl:choose>
				<!-- If there's a download table, use the More downloads heading -->
				<xsl:when test="target-content-file/@filename!=''">
					<p>
						<strong>
							<xsl:value-of select="$download-heading-more"/>
						</strong>
					</p>
					</xsl:when>
					<!-- If there's not a download table, use the Downloads heading -->
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
						<p>
							<a name="download"/>
							<span class="atitle">
								<xsl:value-of select="$download-heading"/>
							</span>
						</p>
					</xsl:otherwise>
				</xsl:choose>
				<ul>	
				<xsl:for-each select="target-content-page">
					<xsl:variable name="content-label">
						<xsl:choose>
							<xsl:when test="normalize-space(@target-content-type) = 'Code sample'">
							<xsl:value-of select="$code-sample-label"/>
							</xsl:when>
							<xsl:when test="@target-content-type = 'Demo'">
							<xsl:value-of select="$demo-label"/>
							</xsl:when>
							<xsl:when test="@target-content-type = 'Presentation'">
							<xsl:value-of select="$presentation-label"/>
							</xsl:when>
							<xsl:when test="normalize-space(@target-content-type) = 'Product documentation'">
							<xsl:value-of select="$product-documentation-label"/>
							</xsl:when>
							<xsl:when test="@target-content-type = 'Specification'">
							<xsl:value-of select="$specification-label"/>
							</xsl:when>
							<xsl:when test="normalize-space(@target-content-type) = 'Technical article'">
							<xsl:value-of select="$technical-article-label"/>
							</xsl:when>
							<xsl:when test="@target-content-type = 'Whitepaper'">
							<xsl:value-of select="$whitepaper-label"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<li>
						<xsl:value-of select="$content-label"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
							<xsl:value-of select="@url-target-page"/>
							<xsl:choose>
								<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">
									<xsl:choose>
										<xsl:when test="@tactic='yes'">		
											<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
										</xsl:otherwise>
									</xsl:choose>  
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								</xsl:otherwise>	
							</xsl:choose> 
							<xsl:value-of select="@link-text"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text> 
						<xsl:if test="normalize-space(note)!=''">
							<sup>
								<xsl:value-of select="count(preceding::note[not(normalize-space(.)='')])+1"/>
							</sup>
						</xsl:if>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>
		<!-- Conditional processing here instead of content-type templates so they don't have to be updated -->
		<xsl:if test="normalize-space(target-content-file/note)!='' or normalize-space(target-content-page/note)!='' or following::content[1]/target-content-file/note!=''">
			<xsl:for-each select="target-content-file/note[not(normalize-space(.)='')] | target-content-page/note[not(normalize-space(.)='')] | following::content[1]/target-content-file/note[not(normalize-space(.)='')]">
				<xsl:if test="position()=1">
					<p>
						<xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
							<xsl:attribute name="class">dw-landing-dltable-note</xsl:attribute>
						</xsl:if>
						<strong>
							<xsl:choose>
								<xsl:when test="count(//target-content-file/note[not(normalize-space(.)='')] | //target-content-page/note[not(normalize-space(.)='')] | following::content[1]/target-content-file/note[not(normalize-space(.)='')]) > 1">
									<xsl:value-of select="$download-notes-heading"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$download-note-heading"/>
								</xsl:otherwise>
							</xsl:choose>
						</strong>
					</p>
					<xsl:choose>
						<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
							<xsl:text disable-output-escaping="yes"><![CDATA[<ol class="dw-landing-dltable-notelist">]]></xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="yes"><![CDATA[<ol>]]></xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<li>
					<xsl:apply-templates select="."/>
				</li>
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes"><![CDATA[</ol>]]></xsl:text>
		</xsl:if>
		<xsl:if test=". = ../dw-article or . = ../dw-summary">
      <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
    </xsl:if>
	</xsl:template>	
	<!-- NOT USED FOR 7.0 -->
	<xsl:template name="DownloadsLanding-v16">
		<xsl:if test="normalize-space(//target-content-file/@filename)">
			<div class="ibm-container">
				<a name="download"><h2><xsl:value-of select="$downloads-heading"/></h2></a>
			<div class="ibm-container-body ibm-inner-data-table">
				<xsl:call-template name="Download"/>
				<xsl:copy-of select="$ssi-s-backlink-rule"/>
			</div>
			</div>
		</xsl:if>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
	<xsl:template name="DownloadsLandingPagegroup-v16">
		<xsl:if test="normalize-space(following::content[1]/target-content-file/@filename)">
			<div class="ibm-container">
				<a name="download"><h2><xsl:value-of select="$downloads-heading"/></h2></a>
			<div class="ibm-container-body ibm-inner-data-table">
				<xsl:call-template name="Download"/>
				<xsl:copy-of select="$ssi-s-backlink-rule"/>
			</div>
			</div>
		</xsl:if>
    </xsl:template>
    <!--NOT USED FOR 7.0 -->
  <xsl:template match="dt">
    <dt>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <strong>
        <xsl:apply-templates select="*|text()"/>
      </strong>
    </dt>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="DownloadLink-v16">
	<xsl:choose>
		<xsl:when test="normalize-space(//dw-summary//get-download-link-text)">
			<p class="ibm-ind-link">
				<xsl:element name="a">
					<xsl:attribute name="class">
						<xsl:text>ibm-anchor-down-em-link</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="href">													
						<xsl:text>#download</xsl:text>
					</xsl:attribute>
					<xsl:element name="strong">
						<xsl:apply-templates select="get-download-link-text" />
					</xsl:element>
				</xsl:element>
			</p>					
		</xsl:when>
		<xsl:when test="//dw-summary[@summary-content-type='briefing']">
			<xsl:if test="(//target-content-file[@target-content-type='Agenda']) | (//target-content-file[@target-content-type='Presentation'])">
				<p class="ibm-ind-link">
					<xsl:element name="a">
						<xsl:attribute name="class">
							<xsl:text>ibm-anchor-down-em-link</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="href">													
							<xsl:text>#download</xsl:text>
						</xsl:attribute>
						<xsl:element name="strong">
							<xsl:choose>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])=1 and count(//target-content-file[@target-content-type='Presentation'])=1 ">
									<xsl:copy-of select="$summary-getTheAgendaAndPresentation"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])>1 and count(//target-content-file[@target-content-type='Presentation'])>1 ">
									<xsl:copy-of select="$summary-getTheAgendasAndPresentations"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])>1 and count(//target-content-file[@target-content-type='Presentation'])=1 ">
									<xsl:copy-of select="$summary-getTheAgendasAndPresentation"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])=1 and count(//target-content-file[@target-content-type='Presentation'])>1 ">
									<xsl:copy-of select="$summary-getTheAgendaAndPresentations"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])=1 and not(//target-content-file[@target-content-type='Presentation'])">
									<xsl:copy-of select="$summary-getTheAgenda"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Presentation'])=1 and not(//target-content-file[@target-content-type='Agenda'])">
									<xsl:copy-of select="$summary-getThePresentation"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Agenda'])>1 and not(//target-content-file[@target-content-type='Presentation'])">
									<xsl:copy-of select="$summary-getTheAgendas"/>
								</xsl:when>
								<xsl:when test="count(//target-content-file[@target-content-type='Presentation'])>1 and not(//target-content-file[@target-content-type='Agenda'])">
									<xsl:copy-of select="$summary-getThePresentations"/>
								</xsl:when>
							</xsl:choose>
						</xsl:element>				
					</xsl:element>
				</p>					
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="normalize-space(//target-content-file/@filename)">
				<p class="ibm-ind-link">
					<xsl:element name="a">
						<xsl:attribute name="class">
							<xsl:text>ibm-anchor-down-em-link</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:text>#download</xsl:text>
						</xsl:attribute>
						<xsl:element name="strong">
							<xsl:choose>
								<xsl:when test="count(target-content-file) > 1">
									<xsl:copy-of select="$summary-getTheDownloads"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$summary-getTheDownload"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
				</p>	
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  <!-- EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE -->
  <!-- FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF -->
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process featured content module -->
    <xsl:template name="FeaturedContentModule-v16">
		<xsl:for-each select="/dw-document/dw-dwtop-home/featured-content-module | /dw-document/dw-dwtop-zoneoverview/featured-content-module | /dw-document/dw-landing-generic/featured-content-module | /dw-document/dw-landing-product/featured-content-module | following::content[1]/featured-content-module">		
			<xsl:choose>
				<!-- When feature is a leadspace image -->
				<xsl:when test="leadspace">
					<!-- Do not process if this is a multicolumn leadspace; processed within Title-v16 -->
					<xsl:if test="not(leadspace/@multicolumn='yes')"> 
					<div id="ibm-leadspace">
						<a href="{leadspace/target-url}">
							<xsl:text disable-output-escaping="yes"><![CDATA[<img alt="]]></xsl:text>
							<xsl:value-of select="leadspace/image-alt"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[" width="530" height="]]></xsl:text>
							<xsl:choose>
								<xsl:when test="normalize-space(leadspace/height)">
									<xsl:value-of select="leadspace/height"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>160</xsl:text>								
								</xsl:otherwise>
							</xsl:choose>	
							<!-- Set variable to process background image for preview -->
							<xsl:variable name="leadspace-image-url">
								<xsl:call-template name="generate-correct-url-form">
									<xsl:with-param name="input-url" select="leadspace/image-url" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:text disable-output-escaping="yes"><![CDATA[" border="0" src="]]></xsl:text>
								<xsl:value-of select="$leadspace-image-url"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
						</a>
					</div>
					</xsl:if>
				</xsl:when>
				<!-- When feature is a leadspace-decorative image -->
				<xsl:when test="leadspace-decorative">
					<!-- Do not process if this is a multicolumn leadspace; processed within Title-v16 -->
					<xsl:if test="not(leadspace-decorative/@multicolumn='yes')"> 
					<div id="ibm-leadspace">
						<xsl:text disable-output-escaping="yes"><![CDATA[<img alt="]]></xsl:text>
							<xsl:if test="normalize-space(leadspace-decorative/image-alt)">
								<xsl:value-of select="leadspace-decorative/image-alt"/>
							</xsl:if>
						<xsl:text disable-output-escaping="yes"><![CDATA[" width="530" height="]]></xsl:text>
						<!-- Process optional height setting, if present -->
						<xsl:choose>
							<xsl:when test="normalize-space(leadspace-decorative/height)">
								<xsl:value-of select="leadspace-decorative/height"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>160</xsl:text>								
							</xsl:otherwise>
						</xsl:choose>
						<!-- Set variable to process background image for preview -->
						<xsl:variable name="leadspace-decorative-image-url">
							<xsl:call-template name="generate-correct-url-form">
								<xsl:with-param name="input-url" select="leadspace-decorative/image-url" />
							</xsl:call-template>
						</xsl:variable>							
						<xsl:text disable-output-escaping="yes"><![CDATA[" src="]]></xsl:text>
							<xsl:value-of select="$leadspace-decorative-image-url"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
					</div>
					</xsl:if>
				</xsl:when>
				<!-- When feature is a split leadspace with two linked images -->				
				<xsl:when test="leadspace-split">
					<!-- Variable returns the target URL for the first image in the correct display format (preview or production) -->
					<xsl:variable name="first-split-image-url">
						<xsl:call-template name="generate-correct-url-form">
							<xsl:with-param name="input-url" select="leadspace-split/image-first-url" />
						</xsl:call-template>
					</xsl:variable>
					<!-- Variable returns the target URL for the second image in the correct display format (preview or production) -->
					<xsl:variable name="second-split-image-url">
						<xsl:call-template name="generate-correct-url-form">
							<xsl:with-param name="input-url" select="leadspace-split/image-second-url" />
						</xsl:call-template>
					</xsl:variable>
					<!-- Create split leadspace module -->
					<div id="ibm-leadspace" class="dw-leadspace-split">
						<!-- Build first image for split leadspace -->
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="leadspace-split/image-first-target-url"/>
							</xsl:attribute>							
							<xsl:element name="img">
								<xsl:attribute name="class">dw-leadspace-split-img-first</xsl:attribute>
								<xsl:attribute name="src">
									<xsl:value-of select="$first-split-image-url"/>
								</xsl:attribute>
								<xsl:attribute name="alt">
									<xsl:value-of select="leadspace-split/image-first-alt"/>
								</xsl:attribute>
								<!-- Specifies required width for leadspace image -->
								<xsl:attribute name="width">260</xsl:attribute>
								<xsl:attribute name="height">
									<!-- Process optional height setting, if present -->
									<xsl:choose>
										<xsl:when test="normalize-space(leadspace-split/height)">
											<xsl:value-of select="leadspace-split/height"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>150</xsl:text>								
										</xsl:otherwise>
									</xsl:choose>	
								</xsl:attribute>
								<xsl:attribute name="border">0</xsl:attribute>
							</xsl:element>
						</xsl:element>
						<!-- Build second image for split leadspace -->
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="leadspace-split/image-second-target-url"/>
							</xsl:attribute>							
							<xsl:element name="img">
								<xsl:attribute name="class">dw-leadspace-split-img</xsl:attribute>
								<xsl:attribute name="src">
									<xsl:value-of select="$second-split-image-url"/>
								</xsl:attribute>
								<xsl:attribute name="alt">
									<xsl:value-of select="leadspace-split/image-second-alt"/>
								</xsl:attribute>
								<!-- Specifies required width for leadspace image -->
								<xsl:attribute name="width">260</xsl:attribute>
								<xsl:attribute name="height">
									<!-- Process optional height setting, if present -->
									<xsl:choose>
										<xsl:when test="normalize-space(leadspace-split/height)">
											<xsl:value-of select="leadspace-split/height"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>150</xsl:text>								
										</xsl:otherwise>
									</xsl:choose>	
								</xsl:attribute>
								<xsl:attribute name="border">0</xsl:attribute>
							</xsl:element>
						</xsl:element>
					</div>
				</xsl:when>				
				<xsl:when test="image-text-combination">
					<div class="ibm-container ibm-alternate-two ibm-alternate-six">
						<!-- Create body container with specified background color; white background is default -->
						<xsl:choose>
							<xsl:when test="normalize-space(image-text-combination/background-color)">
									<xsl:choose> 
								        <!-- Check to see if background color is prefixed with a # sign -->
										<xsl:when test="contains(image-text-combination/background-color,'#')">
										  	<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body" style="background:]]></xsl:text>										   
											<xsl:value-of select="image-text-combination/background-color" />
										</xsl:when>
										<!-- If there is no # sign, add one -->										
										<xsl:otherwise>
										  	<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body" style="background:#]]></xsl:text>
										    <xsl:value-of select="image-text-combination/background-color" />
										</xsl:otherwise>
									</xsl:choose>
								<xsl:text disable-output-escaping="yes"><![CDATA[ !important;">]]></xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Process image  -->
						<xsl:choose>
							<xsl:when test="//dw-document/dw-landing-generic">
								<xsl:text disable-output-escaping="yes"><![CDATA[<img class="dw-feature-image" alt="]]></xsl:text>
									<xsl:if test="normalize-space(image-text-combination/image-alt)">
										<xsl:value-of select="image-text-combination/image-alt"/>
									</xsl:if>
								<xsl:text disable-output-escaping="yes"><![CDATA[" width="170" height="]]></xsl:text>
								<!-- Process optional height setting, if present -->
								<xsl:choose>
									<xsl:when test="normalize-space(image-text-combination/height)">
										<xsl:value-of select="image-text-combination/height"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>120</xsl:text>								
									</xsl:otherwise>
								</xsl:choose>	
								<!-- Set variable to process background image for preview -->
								<xsl:variable name="combo-image-url">
									<xsl:call-template name="generate-correct-url-form">
										<xsl:with-param name="input-url" select="image-text-combination/image-url" />
									</xsl:call-template>
								</xsl:variable>
								<xsl:text disable-output-escaping="yes"><![CDATA[" border="0" src="]]></xsl:text>								
									<xsl:value-of select="$combo-image-url"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
								<!-- Process clickable heading, abstract, and call-to-action link -->
								<h3 class="dw-feature-heading">
									<a href="{image-text-combination/target-url}" class="ibm-feature-link dw-feature-link">
										<xsl:value-of select="image-text-combination/feature-heading" />
									</a>
								</h3>
								<p>
									<xsl:apply-templates select="image-text-combination/feature-abstract"/>
									<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;]]></xsl:text>
									<a href="{image-text-combination/target-url}">
										<xsl:choose>
											<xsl:when test="normalize-space(image-text-combination/call-to-action-text)">
												<xsl:value-of select="image-text-combination/call-to-action-text" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$more-link-text" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&gt;]]></xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="yes"><![CDATA[<img class="dw-feature-image" alt="" width="170" height="120" border="0" src="]]></xsl:text>
									<xsl:value-of select="image-text-combination/image-url"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
								<!-- Process clickable heading, abstract, and More link -->
								<h3 class="dw-feature-heading">
									<a href="{image-text-combination/target-url}" class="ibm-feature-link dw-feature-link">
										<xsl:value-of select="image-text-combination/feature-heading" />
									</a>
								</h3>
								<p>
									<xsl:apply-templates select="image-text-combination/feature-abstract"/>
									<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;]]></xsl:text>
									<a href="{image-text-combination/target-url}">
										<xsl:value-of select="$more-link-text" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&gt;]]></xsl:text>
									</a>
								</p>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Close divs -->
						<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
					</div>				
				</xsl:when>
				<!-- When feature selection is image-text-combination-static -->
				<xsl:when test="image-text-combination-static">				
					<div class="ibm-container ibm-alternate-two ibm-alternate-six">
						<!-- Create body container with specified background color; white background is default -->
						<xsl:choose>
							<xsl:when test="normalize-space(image-text-combination-static/background-color)">
									<xsl:choose> 
								        <!-- Check to see if background color is prefixed with a # sign -->
										<xsl:when test="contains(image-text-combination-static/background-color,'#')">
										  	<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body" style="background:]]></xsl:text>										   
											<xsl:value-of select="image-text-combination-static/background-color" />
										</xsl:when>
										<!-- If there is no # sign, add one -->										
										<xsl:otherwise>
										  	<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body" style="background:#]]></xsl:text>
										    <xsl:value-of select="image-text-combination-static/background-color" />
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text disable-output-escaping="yes"><![CDATA[ !important;">]]></xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Process image  -->
						<xsl:text disable-output-escaping="yes"><![CDATA[<img class="dw-feature-image" alt="]]></xsl:text>
							<xsl:if test="normalize-space(image-text-combination-static/image-alt)">
								<xsl:value-of select="image-text-combination-static/image-alt"/>
							</xsl:if>
						<xsl:text disable-output-escaping="yes"><![CDATA[" width="170" height="]]></xsl:text>
						<!-- Process optional height setting, if present -->
						<xsl:choose>
							<xsl:when test="normalize-space(image-text-combination-static/height)">
								<xsl:value-of select="image-text-combination-static/height"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>120</xsl:text>								
							</xsl:otherwise>
						</xsl:choose>		
						<!-- Set variable to process background image for preview -->
						<xsl:variable name="combo-static-image-url">
							<xsl:call-template name="generate-correct-url-form">
								<xsl:with-param name="input-url" select="image-text-combination-static/image-url" />
							</xsl:call-template>
						</xsl:variable>					
						<xsl:text disable-output-escaping="yes"><![CDATA[" src="]]></xsl:text>								
							<xsl:value-of select="$combo-static-image-url"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
						<!-- Process static heading and abstract -->
						<h3 class="dw-feature-heading">
							<xsl:value-of select="image-text-combination-static/feature-heading" />
						</h3>
						<p>
							<xsl:value-of select="image-text-combination-static/feature-abstract"/>
						</p>
						<!-- Close divs -->
						<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
					</div>
				</xsl:when>
				<xsl:when test="image-list-combination">
					<div class="ibm-container ibm-alternate">
						<!-- Create body container with specified background color; white background is default -->
						<xsl:choose>
							<xsl:when test="normalize-space(image-list-combination/background-color)">
								<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body ibm-alternate-five ibm-two-column" style="background:]]></xsl:text>
									<xsl:value-of select="image-list-combination/background-color" />
								<xsl:text disable-output-escaping="yes"><![CDATA[ !important;"><div class="ibm-column ibm-first">]]></xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body ibm-alternate-five ibm-two-column"><div class="ibm-column ibm-first">]]></xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Process image  -->
					  <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					  <xsl:value-of select="image-list-combination/target-url"/>
					  <xsl:text disable-output-escaping="yes"><![CDATA["><img width="165" height="120" border="0" src="]]></xsl:text>
					  <xsl:value-of select="image-list-combination/image-url"/>
					  <xsl:text disable-output-escaping="yes"><![CDATA[" alt="]]></xsl:text>
					  <xsl:value-of select="image-list-combination/image-alt"/>
					  <xsl:text disable-output-escaping="yes"><![CDATA[" /></a></div>]]></xsl:text>
					  <!-- Process the link section -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-second">]]></xsl:text>
				<xsl:for-each select="image-list-combination/link-section">
						<xsl:call-template name="ModuleLinkList-v16"/>
				</xsl:for-each>	
						<!-- Close divs -->
						<xsl:text disable-output-escaping="yes"><![CDATA[<p align="right" class="ibm-ind-link"><a href="]]></xsl:text><xsl:value-of select="/dw-document//rss-link/url"/><xsl:text disable-output-escaping="yes"><![CDATA["><img alt="RSS feed" src="//www.ibm.com/i/v16/icons/rss.gif"/></a></p></div></div>]]></xsl:text>
					</div>				
				</xsl:when>
			</xsl:choose>		
		</xsl:for-each>
		<xsl:for-each select="/dw-document/dw-dwtop-home-hidef/featured-content-module">
			<!-- Set variable to process background image for preview -->
			<xsl:variable name="home-hidef-background-image-url">
				<xsl:call-template name="generate-correct-url-form">
					<xsl:with-param name="input-url" select="image-text-combination/image-url" />
				</xsl:call-template>
			</xsl:variable>
			<!-- Create div for leadspace/feature area -->
			<xsl:element name="div">
				<xsl:attribute name="id">ibm-content-head</xsl:attribute>
				<xsl:attribute name="class">ibm-leadspace-overlay</xsl:attribute>
				<!-- Calls background image -->
				<xsl:attribute name="style">
					<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
						<xsl:value-of select="$home-hidef-background-image-url"/>
					<xsl:text disable-output-escaping="yes">');</xsl:text>				
				</xsl:attribute>
				<!-- Default height for background image is 160 (pixels); modify the style for the background image if another height is specified -->
				<xsl:choose>
					<xsl:when test="image-text-combination/height">
						<!-- Note:  The ibm.com standard for Hi-Definition landing pages allows use of this inline style for resizing the background image; Ignore WebKing violation -->
						<style type="text/css">
							<xsl:text>div.ibm-landing-page .ibm-leadspace-overlay {min-height:</xsl:text>
								<xsl:value-of select="image-text-combination/height"/>
							<xsl:text>px;}</xsl:text>
							<xsl:text>* html div.ibm-landing-page .ibm-leadspace-overlay {height:</xsl:text>
								<xsl:value-of select="image-text-combination/height"/>
							<xsl:text>px;}</xsl:text>
						</style>
					</xsl:when>
					<xsl:otherwise>
						<style type="text/css">
							<xsl:text>div.ibm-landing-page .ibm-leadspace-overlay {min-height:160px;}* html div.ibm-landing-page .ibm-leadspace-overlay {height:160px;}</xsl:text>
						</style>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Create hidden h1 for web accessibility -->
				<xsl:element name="h1">
					<xsl:attribute name="class">ibm-access</xsl:attribute>
					<xsl:value-of select="/dw-document/dw-dwtop-home-hidef/title"/>
				</xsl:element>
				<!-- Create feature heading -->
				<xsl:element name="h2">
					<xsl:attribute name="class">dw-leadspace-overlay-heading</xsl:attribute>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="image-text-combination/target-url"/>
						</xsl:attribute>
						<xsl:value-of select="image-text-combination/feature-heading"/>
					</xsl:element>
				</xsl:element>
				<!-- Create feature description -->
				<xsl:element name="p">
					<xsl:attribute name="class">dw-leadspace-overlay-body</xsl:attribute>
					<xsl:apply-templates select="image-text-combination/feature-abstract"/>
				</xsl:element>				
			</xsl:element>
		</xsl:for-each>	
    </xsl:template>
    <!-- Project Defiant jpp 10/12/11: Added FeaturedResultsArea-v17 template -->
    <!-- USED FOR 7.0 -->
	<xsl:template name="FeaturedResultsArea-v17">
		<xsl:if test="/dw-document/dw-results">
			<xsl:for-each select="//module/container-results">
				<xsl:choose>
					<xsl:when test="featured-results">
						<xsl:if test="normalize-space(featured-results/link-list-categorized/link-list-item/text) and normalize-space(featured-results/link-list-categorized/link-list-item/url)">
							<!-- Display module heading -->
							<xsl:element name="h2">
								<xsl:attribute name="class">ibm-rule</xsl:attribute>
								<xsl:value-of select="$featured-results-heading"/>
							</xsl:element>
							<xsl:element name="ul">
								<xsl:attribute name="class">ibm-link-list</xsl:attribute>
								<!-- Process module list items -->
								<xsl:for-each select="featured-results/link-list-categorized/link-list-item">
									<xsl:element name="li">
										<xsl:element name="a">
											<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<!-- Build categorized link text -->
											<!-- If a category has been specified for the link, prefix the link text with the selected category -->
											<xsl:if test="not(@list-item-category='none')">
												<!-- Get link category text -->
												<xsl:variable name="linkCategory">
													<xsl:call-template name="ListItemCategory-v17">
														<xsl:with-param name="category" select="@list-item-category"/>
													</xsl:call-template>
												</xsl:variable>
												<xsl:value-of select="$linkCategory"/><xsl:text>: </xsl:text>
											</xsl:if>
											<xsl:apply-templates select="text"/>								
										</xsl:element>
									</xsl:element>
								</xsl:for-each>
							</xsl:element>
						</xsl:if>
					</xsl:when>
				</xsl:choose>			
			</xsl:for-each>
		</xsl:if>
	</xsl:template>    
    <!--NOT USED FOR 7.0 -->
   <xsl:template match="figure">   
    <xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
		<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:choose>
      <xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
		<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>		
	  </xsl:when>
      <xsl:when test="ancestor::li and (
                                                       ((//date-published/@year&gt;=2006 and //date-published/@month&gt;=06) or (//date-published/@year&gt;2006))
                                                       or
                                                       ((//date-updated/@year&gt;=2006 and //date-updated/@month&gt;=06) or (//date-updated/@year&gt;2006))
                                                       )">
            <xsl:text disable-output-escaping="yes"><![CDATA[<br /><br />]]></xsl:text>
      </xsl:when>
      <xsl:otherwise><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text></xsl:otherwise>
    </xsl:choose>   
  </xsl:template>
  <!-- v17 Enablement jpp 09/13/2011:  REPLACED FilterAbstract template with FilterAbstract-v17 -->
  <!-- USED FOR 7.0 -->
  <xsl:template name="FilterAbstract-v17">
    <xsl:param name="landing-page-name" />
    <xsl:variable name="doublequote">"</xsl:variable>
    <xsl:variable name="singlequote">'</xsl:variable>
    <xsl:variable name="newline">
      <xsl:text>
</xsl:text>
    </xsl:variable>
    <xsl:choose>
        <xsl:when test="//abstract!=''">
            <xsl:value-of select="translate(normalize-space(//abstract),$doublequote,$singlequote)"/>
        </xsl:when>
        <xsl:when test="//abstract=''">
            <xsl:value-of select="translate(normalize-space(//abstract-extended),$doublequote,$singlequote)"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="translate(normalize-space(//abstract-extended),$doublequote,$singlequote)"/>
        </xsl:otherwise>
    </xsl:choose> 
    <!-- v17 Enablement jpp 09/14/2011:  LEAVE placeholder xsl:choice to handle future multi-page templates -->
    <!-- <xsl:choose>
        <xsl:when test="/dw-document/dw-landing/@layout=">            
            <xsl:value-of select="translate(normalize-space(following::content[1]/meta-information/abstract),$doublequote,$singlequote)"/>                  
        </xsl:when>    
        <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="//abstract!=''">
                  <xsl:value-of select="translate(normalize-space(//abstract),$doublequote,$singlequote)"/>
              </xsl:when>
              <xsl:when test="//abstract=''">
                  <xsl:value-of select="translate(normalize-space(//abstract-extended),$doublequote,$singlequote)"/>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:value-of select="translate(normalize-space(//abstract-extended),$doublequote,$singlequote)"/>
              </xsl:otherwise>
            </xsl:choose>        
        </xsl:otherwise>      
    </xsl:choose> -->
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="forward-link-list">
	    <xsl:element name="ul">
			<xsl:attribute name="class">ibm-link-list</xsl:attribute>
			<xsl:for-each select="forward-link">
				<xsl:element name="li">
					<xsl:element name="a">
						<!-- Apply link style -->
						<xsl:attribute name="class">
							<xsl:choose>
								<!-- If the forward-link-list does not have a style defined, check the forward link itself -->
								<xsl:when test="not(normalize-space(../@link-style))">
									<xsl:choose>
										<xsl:when test="normalize-space(@link-style)">
											<xsl:call-template name="ForwardLinkIcon">
												<xsl:with-param name="style" select="@link-style"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>ibm-forward-link</xsl:otherwise>											
									</xsl:choose>
								</xsl:when>
								<!-- If the forward-link-list has a style defined, use it unless the forward link specifies a style -->
								<xsl:when test="normalize-space(../@link-style)">
									<xsl:choose>
										<xsl:when test="not(normalize-space(@link-style))">
											<xsl:call-template name="ForwardLinkIcon">
												<xsl:with-param name="style" select="../@link-style"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="ForwardLinkIcon">
												<xsl:with-param name="style" select="@link-style"/>
											</xsl:call-template>
										</xsl:otherwise>											
									</xsl:choose>									
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:value-of select="url"/>				
						</xsl:attribute>
						<!-- If a tactic code is requested, add onmouseover attribute to link -->
						<xsl:if test="@tactic='yes'">
							<xsl:attribute name="onmouseover">linkQueryAppend(this)</xsl:attribute>
						</xsl:if>
						<xsl:choose>
							<!-- Determine whether link text is strong or normal -->
							<xsl:when test="@link-style='arrow-bolded'">
								<strong><xsl:apply-templates select="text"/></strong>
							</xsl:when>
							<xsl:when test="../@link-style='arrow-bolded' and not(normalize-space(@link-style))">
								<strong><xsl:apply-templates select="text"/></strong>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="text"/>
							</xsl:otherwise>
						</xsl:choose>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>	    
	    </xsl:element>  
  </xsl:template>
 <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ForwardLinkIcon">
        <xsl:param name="style"/>
		<xsl:choose>
			<xsl:when test="$style = 'arrow-normal' ">ibm-forward-link</xsl:when>
			<xsl:when test="$style = 'arrow-bolded' ">ibm-forward-em-link</xsl:when>
			<xsl:when test="$style = 'audio' ">ibm-audio-link</xsl:when>
			<xsl:when test="$style = 'blogs' ">ibm-blog</xsl:when>
			<xsl:when test="$style = 'communities' ">ibm-community</xsl:when>
			<xsl:when test="$style = 'delicious' ">ibm-delicious-link</xsl:when>
			<xsl:when test="$style = 'digg' ">ibm-digg-link</xsl:when>
			<xsl:when test="$style = 'discuss' ">ibm-chat-link</xsl:when>
			<xsl:when test="$style = 'email' ">ibm-email-link</xsl:when>
			<xsl:when test="$style = 'facebook' ">ibm-facebook-link</xsl:when>
			<xsl:when test="$style = 'information' ">ibm-information-link</xsl:when>
			<xsl:when test="$style = 'linkedin' ">ibm-linkedin-link</xsl:when>
			<xsl:when test="$style = 'lotus-symphony-document' ">ibm-symp-doc</xsl:when>
			<xsl:when test="$style = 'pdf' ">ibm-pdf-link</xsl:when>
			<xsl:when test="$style = 'rss' ">ibm-rss-link</xsl:when>
			<xsl:when test="$style = 'secure-web-connection' ">ibm-secure-link</xsl:when>
			<xsl:when test="$style = 'stumbleupon' ">ibm-stumbleupon</xsl:when>
			<xsl:when test="$style = 'twitter' ">ibm-twitter-link</xsl:when>
			<xsl:when test="$style = 'user-group' ">ibm-usergroup</xsl:when>
			<xsl:when test="$style = 'video' ">ibm-video-link</xsl:when>
			<xsl:when test="$style = 'youtube' ">ibm-youtube</xsl:when>
		</xsl:choose>
  </xsl:template>
  <!-- v17 Enablement jpp 09/13/2011:  REPLACED FullTitle template with FullTitle-v17 -->    
  <!-- USED FOR 7.0 -->
  <xsl:template name="FullTitle-v17">
      <xsl:param name="pageType" />
      <xsl:param name="escapeQuotes" select="false()"/>
      <xsl:param name="landing-page-name" />
      <!-- Project Defiant jpp 10/28/11: Added return parameter -->
      <xsl:param name="return" />
      <xsl:choose>
        <!-- Project Defiant jpp 10/10/11: Modified xsl:when test to select //title for title tag text -->
		<xsl:when test="/dw-document/dw-home">
            <xsl:copy-of select="$ibm-developerworks-text"/>
            <xsl:value-of select="//title"/>
		</xsl:when>
        <!-- Project Defiant jpp 10/28/11: Added xsl:choose block to capture results term when return parameter contains leadspaceterm value -->
        <!-- Project Defiant jpp 10/10/11: Added xsl:when test for dw-results content type -->
		<xsl:when test="/dw-document/dw-results">
			<xsl:choose>
				<xsl:when test="$return='leadspaceterm'">
					<xsl:value-of select="//title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$ibm-developerworks-text"/>
					<xsl:value-of select="//title"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
      <!-- <xsl:when test="/dw-document/dw-dwtop-zoneoverview">
            <xsl:copy-of select="$ibm-developerworks-text"/>
            <xsl:value-of select="//title-tag"/>
        </xsl:when>
        <xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
			<xsl:value-of select="following::content[1]/meta-information/title-tag"/>
        </xsl:when>
        <xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
			<xsl:value-of select="following::content[1]/meta-information/title-tag"/>
        </xsl:when>
        <xsl:otherwise>            
            <xsl:if test="string-length(//series/series-title) &gt; 0">
                <xsl:choose>
                    <xsl:when test="$escapeQuotes and 
                       contains(//series/series-title, '&quot;')">
                        <xsl:call-template name="ReplaceSubstring">
                            <xsl:with-param name="original" select="//series/series-title"/>
                            <xsl:with-param name="substring" select="'&quot;'"/>
                            <xsl:with-param name="replacement" select="'\&quot;'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="//series/series-title"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:if test="string-length(//title) &gt; 0">
                <xsl:choose>
                    <xsl:when test="(/dw-document/dw-landing-product) or (/dw-document/dw-landing-generic)">
                        <xsl:copy-of select="$ibm-developerworks-text"/>
                        <xsl:value-of select="//title"/>
                    </xsl:when>
                    <xsl:when test="$escapeQuotes and 
                       contains(//title, '&quot;')">
                        <xsl:call-template name="ReplaceSubstring">
                            <xsl:with-param name="original" select="//title"/>
                            <xsl:with-param name="substring" select="'&quot;'"/>
                            <xsl:with-param name="replacement" select="'\&quot;'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="//title"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
           <xsl:if test="/dw-document/dw-tutorial">
               <xsl:choose>
                 <xsl:when test="$pageType = 'section'">
                     <xsl:text>: </xsl:text><xsl:value-of select="title" />
                 </xsl:when>
                  <xsl:when test="$pageType = 'downloads'">
                     <xsl:text>: </xsl:text><xsl:value-of select="$downloads-heading" />
                  </xsl:when>
                  <xsl:when test="$pageType = 'resources'">
                     <xsl:text>: </xsl:text><xsl:value-of select="$resource-list-heading" />
                  </xsl:when>
                  <xsl:when test="$pageType = 'authors'">
                     <xsl:text>: </xsl:text>
                     <xsl:choose>
                        <xsl:when test="count(//author) = 1">
                           <xsl:value-of select="$aboutTheAuthor"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="$aboutTheAuthors"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:when test="$pageType = 'rating'">
                     <xsl:text>: </xsl:text><xsl:value-of select="$ratethistutorial-heading"/>
                 </xsl:when>
                 <xsl:otherwise />
               </xsl:choose>
           </xsl:if>      
        </xsl:otherwise> -->
      </xsl:choose> 
  </xsl:template>
  <!-- GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG -->
  <!-- HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH -->
  <!--NOT USED FOR 7.0 -->
   <xsl:template match="heading">
    <!-- Test for back-to-top-link value of immediately preceding major heading -->
    <xsl:choose>
      <xsl:when test="(/dw-document/dw-article or /dw-document/dw-tutorial) and
                        (@type='major' and . != ../heading[1]) and
                        ((not(string(preceding-sibling::heading[@type='major'][1]/@back-to-top)) or
                           preceding-sibling::heading[@type='major'][1]/@back-to-top = 'yes'))">
         <xsl:copy-of select="$ssi-s-backlink-rule"/>
      </xsl:when>
      <!-- back-to-top link for landing generic pagegroup handled in the definition of container-heading -->
    </xsl:choose>
    <xsl:variable name="newid">
      <xsl:choose>
        <xsl:when test="@refname != ''">
          <xsl:value-of select="@refname"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="generate-id()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- Tutorials have different fonts for major & minor -->
    <xsl:choose>
      <xsl:when test="@type='major'">
        <xsl:choose>
          <xsl:when test="/dw-document/dw-tutorial">
            <p>
              <a name="{$newid}">
                <span class="smalltitle">
                  <xsl:apply-templates select="*|text()" />
                </span>
              </a>
            </p>
          </xsl:when>
          <xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">  
			<h3>
				<a name="{$newid}"><xsl:apply-templates select="*|text()" /></a>
			</h3>
          </xsl:when>
          <xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
				<xsl:choose>
					<!-- When a refname has been assigned for the heading, use it -->
					<xsl:when test="normalize-space(@refname)">
						<h2><a name="{@refname}"><xsl:apply-templates select="*|text()" /></a></h2>
					</xsl:when>
					<!-- When a refname has not been assigned and the page has an anchor link list, assign a refname -->
					<xsl:when test="not(normalize-space(@refname)) and (ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list') or (ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list-two-column') or ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list-three-column'">
						<xsl:call-template name="ModuleInlineHeading-v16"/>
					</xsl:when>
					<xsl:otherwise><h2><xsl:apply-templates select="*|text()" /></h2></xsl:otherwise>
				</xsl:choose>				
          </xsl:when>
          <xsl:otherwise>
            <p>
              <a name="{$newid}">
                <span class="atitle">
                  <xsl:apply-templates select="*|text()" />
                </span>
              </a>
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@type='minor'">
        <xsl:choose>
          <xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">   
			<h3>
				<a name="{$newid}"><xsl:apply-templates select="*|text()" /></a>
			</h3>
          </xsl:when>
          <xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
				<xsl:choose>
					<!-- When a refname has been assigned for the heading, use it -->
					<xsl:when test="normalize-space(@refname)">
						<a name="{@refname}"><h3><xsl:apply-templates select="*|text()" /></h3></a>
					</xsl:when>
					<xsl:otherwise><h3><xsl:apply-templates select="*|text()" /></h3></xsl:otherwise>
				</xsl:choose>	
          </xsl:when>
          <xsl:when test="/dw-document//dw-tutorial">
            <p>
              <a name="{$newid}">
                <strong>
                  <xsl:apply-templates select="*|text()" />
                </strong>
              </a>
            </p>
          </xsl:when>          
          <xsl:otherwise>
            <p>
              <a name="{$newid}">
                <span class="smalltitle">
                  <xsl:apply-templates select="*|text()" />
                </span>
              </a>
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="(@type='code') or (@type='figure') or (@type='sidebar') or (@type='table')">
	    <xsl:choose>
			<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
				<xsl:choose>
					<xsl:when test="@type='sidebar'">
						<h3>
						  <a name="{$newid}">
							  <strong>
								  <xsl:apply-templates select="*|text()" />
			                  </strong>
			              </a>
						</h3>
					</xsl:when>
					<xsl:when test="@type='table'">
						<p>
						  <a name="{$newid}">
							  <strong>
								  <xsl:apply-templates select="*|text()" />
			                  </strong>
			              </a>
						</p>
					</xsl:when>
					<xsl:otherwise>
					  <xsl:if test="normalize-space(.)">
						  <xsl:if test="@type='figure'">
							  <xsl:copy-of select="$figurechar"/>
						  </xsl:if>						  
							  <a name="{$newid}">
								  <strong>
									  <xsl:apply-templates select="*|text()" />
								  </strong>
							  </a>
					  </xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(@type='sidebar')">
					  <!-- f ancestor is <li>, and date-published is => 06/2006, add two break tags -->
					  <xsl:choose>
						  <xsl:when test="(ancestor::li) and (
                                                       ((//date-published/@year&gt;=2006 and //date-published/@month&gt;=06) or (//date-published/@year&gt;2006))
                                                       or
                                                       ((//date-updated/@year&gt;=2006 and //date-updated/@month&gt;=06) or (//date-updated/@year&gt;2006))
                                                                  )"><xsl:text disable-output-escaping="yes"><![CDATA[<br /><br />]]></xsl:text></xsl:when>
						  <xsl:otherwise><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text></xsl:otherwise>
					  </xsl:choose>
				</xsl:if>
		        <xsl:choose>
					  <xsl:when test=". !=''">
						  <xsl:if test="@type='figure'">
							  <xsl:copy-of select="$figurechar"/>
						  </xsl:if>
						  <a name="{$newid}">
							  <strong>
								  <!-- Insert automatically generated
                                            heading part (e.g."Table 4. ") if appropriate -->
                                        <xsl:call-template name="heading-auto">
                                            <xsl:with-param name="add-space"
                                             select=" 'yes' " />
                                        </xsl:call-template>
								  <xsl:apply-templates select="*|text()" />
			                  </strong>
			              </a>
			              <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
		              </xsl:when>
		              <xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
      </xsl:when>
      <xsl:when test="@type='hidef'">
        <xsl:choose>
          <xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
				<xsl:choose>
					<!-- When a refname has been assigned for the heading, use it -->
					<xsl:when test="normalize-space(@refname)">
						<a name="{@refname}"><h2 class="dw-hd-heading"><xsl:apply-templates select="*|text()" /></h2></a>
					</xsl:when>
					<!-- When a refname has not been assigned and the page has an anchor link list, assign a refname -->
					<xsl:when test="not(normalize-space(@refname)) and (ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list') or (ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list-two-column') or ancestor::page-hidef/@content-space-secondary-navigation='anchor-link-list-three-column'">
						<xsl:call-template name="ModuleInlineHeading-v16"/>
					</xsl:when>
					<xsl:otherwise><h2 class="dw-hd-heading"><xsl:apply-templates select="*|text()" /></h2></xsl:otherwise>
				</xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@type='kp-step'">
          <xsl:variable name="heading-number" select="count(.|./preceding::heading[@type = ./@type])" />
          <h2 class="kp-h2">
              <a name="{$newid}">
                    <xsl:value-of select="$heading-number"/><xsl:text>.  </xsl:text><xsl:apply-templates select="*|text()" />                
              </a>
          </h2>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 --> 
   <!-- ibs 2010-07-22 Generate automatic part of heading text for listings,
    tables and figures. Specify add-space="yes" to add a trailing period and space.
    Default is to generate for the current heading context, unless for-heading specifies
    a different heading (e.g. for target of xref or link).
-->
    <xsl:template name="heading-auto">
        <xsl:param name="for-heading" select="." />
        <xsl:param name="add-space" select="'no'" />        
        <xsl:if
            test="(/dw-document/*/@auto-number='yes') and ($for-heading/@type = 'figure'
            or $for-heading/@type = 'code' or $for-heading/@type = 'table' ) ">
            <xsl:variable name="heading-number"
                select="count($for-heading|$for-heading/preceding::heading[@type = $for-heading/@type])" />
            <xsl:variable name="end-space">
                <xsl:if test="$add-space = 'yes'">
                    <xsl:value-of select=" '. '" />
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
            </xsl:choose>
            <xsl:if test="$add-space = 'yes'">
                <xsl:value-of select="'. '" />
            </xsl:if>
        </xsl:if>
    </xsl:template>    
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="HidefFooterModule-v16">
		<xsl:for-each select="following::content[1]/module-hidef-footer">
			<xsl:choose>
				<xsl:when test="hidef-footer-include">
					<xsl:call-template name="IncludeFile-v16"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="HidefFooterModuleOptions-v16"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
    </xsl:template>     
  <!-- NOT USED FOR 7.0 -->
    <xsl:template name="HidefFooterModuleOptions-v16">
		<xsl:choose>
			<!-- Process a three-column hidef footer module with section images -->
			<xsl:when test="count(image-text-section) = 3">
				<xsl:element name="div">
					<xsl:attribute name="id">ibm-footer-module</xsl:attribute>
					<xsl:attribute name="class">ibm-related-information ibm-alternate ibm-portrait-module ibm-thumbnail</xsl:attribute>
					<xsl:choose>
						<xsl:when test="normalize-space(background-image-url)">
							<xsl:attribute name="style">
								<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
									<xsl:value-of select="background-image-url"/>
							    <xsl:text disable-output-escaping="yes">')</xsl:text>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="style">
								<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
									<xsl:text>//www.ibm.com/developerworks/i/hidef-footer-bkgd.jpg</xsl:text>
							    <xsl:text disable-output-escaping="yes">')</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<div class="ibm-three-column">
						<xsl:for-each select="image-text-section">
							<xsl:choose>
								<xsl:when test="position() = 1">
									<div class="ibm-column ibm-first">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
								<xsl:when test="position() = 2">
									<div class="ibm-column ibm-second">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
								<xsl:when test="position() = last()">
									<div class="ibm-column ibm-third">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
							</xsl:choose>							
						</xsl:for-each>
					</div>
				</xsl:element>
			</xsl:when>
			<!-- Process a three-column hidef footer module without section images -->
			<xsl:when test="count(text-section) = 3">			
				<xsl:element name="div">
					<xsl:attribute name="id">ibm-footer-module</xsl:attribute>
					<xsl:attribute name="class">ibm-related-information ibm-alternate</xsl:attribute>
					<xsl:choose>
						<xsl:when test="normalize-space(background-image-url)">
							<xsl:attribute name="style">
								<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
									<xsl:value-of select="background-image-url"/>
							    <xsl:text disable-output-escaping="yes">')</xsl:text>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="style">
								<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
									<xsl:text>//www.ibm.com/developerworks/i/hidef-footer-bkgd.jpg</xsl:text>
							    <xsl:text disable-output-escaping="yes">')</xsl:text>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<div class="ibm-three-column">
						<xsl:for-each select="text-section">
							<xsl:choose>
								<xsl:when test="position() = 1">
									<div class="ibm-column ibm-first">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
								<xsl:when test="position() = 2">
									<div class="ibm-column ibm-second">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
								<xsl:when test="position() = last()">
									<div class="ibm-column ibm-third">
										<xsl:call-template name="HidefFooterModuleSections-v16"/>
									</div>									
								</xsl:when>
							</xsl:choose>							
						</xsl:for-each>
					</div>
				</xsl:element>
			</xsl:when>
			<!-- FUTURE -->
			<xsl:when test="count(hidef-footer-section) = 5"></xsl:when>
		</xsl:choose>    
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="HidefFooterModuleSections-v16">
		<!-- If this is an image-text hidef footer section, add the image -->
		<xsl:variable name="hidef-footer-image-url">
			<xsl:call-template name="generate-correct-url-form">
				<xsl:with-param name="input-url" select="image-url" />
			</xsl:call-template>
		</xsl:variable>		
		<xsl:if test="image-url">
			<img src="{$hidef-footer-image-url}" width="50" height="50" alt="" />
		</xsl:if>
		<xsl:choose>
			<!-- Heading is a link -->
			<xsl:when test="section-heading/url">
				<h2>
					<a href="{section-heading/url}" class="ibm-feature-link">
						<xsl:value-of select="section-heading/text"/>
					</a>							
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<h2>
					<xsl:value-of select="section-heading/text"/>
				</h2>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Insert call-to-action text -->
		<p>
			<xsl:apply-templates select="call-to-action-text"/>
		</p>
		<!-- Add section-forward-link if defined -->
		<xsl:if test="normalize-space(section-forward-link/text) and normalize-space(section-forward-link/url)">
			<p class="ibm-ind-link">
				<a href="{section-forward-link/url}" class="ibm-forward-link">
					<xsl:value-of select="section-forward-link/text"/>
				</a>
			</p>
		</xsl:if>									
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <xsl:template name="HighVisModule-v16">
		<xsl:choose>
			<xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
				<xsl:for-each select="following::content[1]/module-high-visibility">
					<xsl:call-template name="HighVisModuleBody-v16"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="//module-high-visibility">
					<xsl:call-template name="HighVisModuleBody-v16"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process body of hi-vis modules for all landing page/pagegroup templates -->
    <xsl:template name="HighVisModuleBody-v16">
            <xsl:variable name="gcuf-image-block-url">
                <xsl:call-template name="generate-correct-url-form">
                    <xsl:with-param name="input-url" select="image-block-url" />
                 </xsl:call-template>
            </xsl:variable>
			<!-- Process frame depending on whether or not module has heading -->
			<xsl:choose>
				<xsl:when test="normalize-space(container-heading)">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container">]]></xsl:text>
					<h2>
						<xsl:value-of select="container-heading" />
					</h2>
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container ibm-alternate-three">]]></xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>					
				</xsl:otherwise>
			</xsl:choose>
			<!-- Process image -->
			<xsl:choose>
				<xsl:when test="image-block-url/@clickable='yes'">
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="image-block-link/url"/>
						</xsl:attribute>
						<xsl:text disable-output-escaping="yes"><![CDATA[<img src="]]></xsl:text>			
							<xsl:value-of select="$gcuf-image-block-url" />			
						<xsl:text disable-output-escaping="yes"><![CDATA[" alt="]]></xsl:text>
							<xsl:value-of select="image-block-alt" />
						<xsl:text disable-output-escaping="yes"><![CDATA[" width="168" height="64" border="0" />]]></xsl:text>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes"><![CDATA[<img src="]]></xsl:text>			
						<xsl:value-of select="$gcuf-image-block-url" />			
					<xsl:text disable-output-escaping="yes"><![CDATA[" alt="]]></xsl:text>
						<xsl:value-of select="image-block-alt" />
					<xsl:text disable-output-escaping="yes"><![CDATA[" width="168" height="64" />]]></xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Check for subheading -->
			<xsl:if test="normalize-space(image-block-heading)">
				<h2>
					<xsl:value-of select="image-block-heading" />
				</h2>
			</xsl:if>
			<!-- Call to action text -->
			<xsl:if test="normalize-space(call-to-action-text)">
			<p>
				<xsl:apply-templates select="call-to-action-text" />
			</p>
			</xsl:if>
			<!-- Rule -->
			<xsl:if test="normalize-space(call-to-action-text) and normalize-space(image-block-link)">
				<div class="ibm-rule"><hr /></div>
			</xsl:if>
			<xsl:choose>
			    <!-- Create bold arrow and link if module does not have call-to-action text -->
				<xsl:when test="not(normalize-space(call-to-action-text))">
					<p class="ibm-ind-link">
						<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
							<xsl:value-of select="image-block-link/url"  />	
								<xsl:choose>
									<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
										<xsl:choose>
											<xsl:when test="image-block-link/@tactic='yes'">		
												<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
									</xsl:otherwise>	
								</xsl:choose>
							<strong><xsl:value-of select="image-block-link/text" /></strong>
						<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<p class="ibm-ind-link">
						<!-- <a class="ibm-forward-link" href="{image-block-link/url}"> -->
							<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-link" href="]]></xsl:text>
								<xsl:value-of select="image-block-link/url"  />	
									<xsl:choose>
										<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
											<xsl:choose>
												<xsl:when test="image-block-link/@tactic='yes'">		
													<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
										</xsl:otherwise>	
									</xsl:choose>	
								<xsl:value-of select="image-block-link/text" />
						<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					</p>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="HighVisModuleHidef-v16">
    	<xsl:for-each select="following::content[1]/module-high-visibility">
			<xsl:call-template name="HighVisModuleBody-v16"/>
		</xsl:for-each>
    </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="Host">
    <xsl:if test="host/. !=''">
      <p>
        <span>
          <xsl:element name="strong">
			  <xsl:value-of select="$summary-hostedBy"/>
		  </xsl:element>
		  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
          <xsl:for-each select="/dw-document//host/company-name">
            <xsl:if test="position() > 1">
              <xsl:text disable-output-escaping="yes"><![CDATA[, ]]></xsl:text>
            </xsl:if>
            <xsl:apply-templates select="."/>
          </xsl:for-each>
         </span>
      </p>
   </xsl:if>
  </xsl:template>
  <!-- I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I -->
  <!-- v17 Enablement jpp 09/13/2011:  REPLACED ibmEffective-v16 template with ibmEffective-v17 -->
  <!-- USED FOR 7.0 -->
  <!-- ibmEffective-v17 template that creates value for IBM.Effective meta tag -->	
  <xsl:template name="ibmEffective-v17">
		<xsl:variable name="effectivedate">
		    <xsl:value-of select="//date-published/@year"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="//date-published/@month"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="//date-published/@day"/>
		</xsl:variable>
		<xsl:value-of select="normalize-space($effectivedate)"/>
  </xsl:template>
	<!--NOT USED FOR 7.0 -->
  <xsl:template match="img">
 <!-- 580 max width for both articles and tutorials -->
  <xsl:choose>
	  <!-- exclude sidefile from 580 width -->
       <xsl:when test="not(//dw-sidefile) and @width&gt;580"><xsl:call-template name="DisplayError"><xsl:with-param name="error-number">e006</xsl:with-param><xsl:with-param name="display-format" >table</xsl:with-param></xsl:call-template></xsl:when>
       <xsl:otherwise>
    <img>
      <xsl:choose>
        <xsl:when test="ancestor::author and not(@align!='')">
          <xsl:for-each select="@*">
            <xsl:copy/>
          </xsl:for-each>
          <xsl:attribute name="align">left</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="@*">
            <xsl:copy/>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </img>
    </xsl:otherwise>
  </xsl:choose>  
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <!-- Process include element within landing pages -->
  <xsl:template match="include">
		<xsl:call-template name="IncludeFile-v16"></xsl:call-template>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="IncludeFile-v16">
	<xsl:choose>
		<!-- If this is a hidef footer module include file call, process include -->
		<xsl:when test="name() = 'featured-content-module-hidef'">
			<div>
				<xsl:attribute name="id">INCFC00<xsl:value-of select="position()"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="rich-media/include/@relative-url"/>','<xsl:text>#INCFC00</xsl:text><xsl:value-of select="position()"/>');</script>
		</xsl:when>
		<!-- If this is a top-right-include file call, process include -->
		<xsl:when test="name() = 'top-right-include'">
			<!-- Create a div container for the include file contents; give the div a unique id based on location and position -->
			<div>
				<xsl:attribute name="id">INCTR00<xsl:value-of select="position()"/></xsl:attribute>
				<!-- Required to prevent self-closing div tag -->
				<xsl:text> </xsl:text>
			</div>
			<!-- Build jQuery call to include file -->
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="include/@relative-url"/>','<xsl:text>#INCTR00</xsl:text><xsl:value-of select="position()"/>');</script>
		</xsl:when>
		<!-- If this is a bottom-right-include file call, process include -->
		<xsl:when test="name() = 'bottom-right-include'">
			<div>
				<xsl:attribute name="id">INCBR00<xsl:value-of select="position()"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="include/@relative-url"/>','<xsl:text>#INCBR00</xsl:text><xsl:value-of select="position()"/>');</script>
		</xsl:when>
		<!-- If this is a hidef footer module include file call, process include -->
		<xsl:when test="name() = 'module-hidef-footer'">
			<div>
				<xsl:attribute name="id">INCHF00<xsl:value-of select="position()"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="hidef-footer-include/include/@relative-url"/>','<xsl:text>#INCHF00</xsl:text><xsl:value-of select="position()"/>');</script>
		</xsl:when>
		<xsl:when test="ancestor::container-html-body-hidef">
			<div>
				<!-- Note: Purpose of substring value is to create a different id for each include -->
				<xsl:attribute name="id">INCCN<xsl:value-of select="substring(count(preceding::*),1,3)"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="@relative-url"/>','<xsl:text>#INCCN</xsl:text><xsl:value-of select="substring(count(preceding::*),1,3)"/>');</script>		
		</xsl:when>	
		<xsl:when test="parent::module or ancestor::container-html-body">
			<div>
				<!-- Note: Purpose of substring value is to create a different id for each include -->
				<xsl:attribute name="id">INCCN<xsl:value-of select="substring(count(preceding::*),1,3)"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="@relative-url"/>','<xsl:text>#INCCN</xsl:text><xsl:value-of select="substring(count(preceding::*),1,3)"/>');</script>		
		</xsl:when>		
		
		<!-- Otherwise, assume include call is from the center column and process -->
		<xsl:otherwise>
			<div>
				<xsl:attribute name="id">INCCN00<xsl:value-of select="position()"/></xsl:attribute>
				<xsl:text> </xsl:text>
			</div>
			<script language="JavaScript" type="text/javascript">jQuery.getInc('<xsl:value-of select="@relative-url"/>','<xsl:text>#INCCN00</xsl:text><xsl:value-of select="position()"/>');</script>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template> 
  <!-- JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ -->
   <!-- NOT USED FOR 7.0 -->
    <xsl:template name="JournalLink-v16">
		<xsl:variable name="journal-url">
		  <xsl:for-each select="key('journal-key', normalize-space(/dw-document/dw-article/@journal))">
			<xsl:value-of select="@journal-url"/>
		  </xsl:for-each>
		</xsl:variable>    
		<xsl:choose>
		  <xsl:when test="normalize-space(/dw-document/dw-article/@journal) !=''">
			  <xsl:choose>
				<xsl:when test="/dw-document//@local-site ='china'"> 
				   <xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
					<xsl:value-of select="normalize-space(/dw-document/dw-article/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:text disable-output-escaping="yes">。</xsl:text>
				</xsl:when>
					<xsl:when test="/dw-document//@local-site ='korea' or /dw-document//@local-site='japan'">
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:value-of select="normalize-space(/dw-document/dw-article/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes">.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				   <xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
					<xsl:value-of select="normalize-space(/dw-document/dw-article/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:text disable-output-escaping="yes">.</xsl:text>
				</xsl:otherwise>
			  </xsl:choose>
			</xsl:when>
		</xsl:choose>    
    </xsl:template>
  <!-- KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK -->
  <!-- v17 Enablement jpp 09/13/2011:  REPLACED keywords template with keywords-v17 -->
  <!-- USED FOR 7.0 -->
  <xsl:template name="keywords-v17">
	<xsl:param name="landing-page-name" />
	<xsl:value-of select="/dw-document//keywords/@content"/>
	<!-- v17 Enablement jpp 09/14/2011:  LEAVE placeholder xsl:choice to handle future multi-page templates -->
    <!-- <xsl:choose>
		<xsl:when test="/dw-document/dw-landing/@layout=">
			<xsl:value-of select="following::content[1]/meta-information/keywords"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="/dw-document//keywords/@content"/>
        </xsl:otherwise>
    </xsl:choose> -->
    <xsl:call-template name="ContentAreaMetaKeyword">
      <xsl:with-param name="contentarea">
        <xsl:value-of select="//content-area-primary/@name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:for-each select="//content-area-secondary">
      <xsl:call-template name="ContentAreaMetaKeyword">
        <xsl:with-param name="contentarea">
          <xsl:value-of select="./@name"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:for-each select="/dw-document//dw-article/@journal">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="."/>    
    </xsl:for-each>
  </xsl:template>
  <!-- LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL -->
 <!-- NOT USED FOR 7.0 -->
  <!-- Processes bct if there are secondary content areas or subnavigation areas in the bct -->
  <xsl:template name="LandingBreadcrumbSubLevel-v16">
		<xsl:choose>
			<!-- Process bct with secondary content areas -->
			<xsl:when test="not(//content-area-primary/@name = 'none') and normalize-space(//content-area-secondary/@name)">
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="$developerworks-top-url"/> 
							<xsl:value-of select="//content-area-primary/@name"/>
							<!-- Ending slash for folder -->
							<xsl:text>/</xsl:text>				
						</xsl:attribute>
						<xsl:call-template name="ContentAreaName">
							<xsl:with-param name="contentarea">
								<xsl:value-of select="//content-area-primary/@name"/>
							</xsl:with-param>
						</xsl:call-template>
					</a>
					<!-- Use a bar to separate the links -->
					<xsl:text> </xsl:text><span class="dwbctbar">|</span><xsl:text> </xsl:text> 
					<!-- Create links for secondary content areas -->
					<xsl:for-each select="/dw-document//content-area-secondary">
						<!-- Limit the number of secondary content areas to three -->
						<xsl:if test="position() &lt; 4">
							<a>	
								<xsl:attribute name="href">
									<xsl:value-of select="$developerworks-top-url"/> 
									<xsl:value-of select="@name"/>
									<!-- Ending slash for folder -->
									<xsl:text>/</xsl:text>								
								</xsl:attribute>
								<xsl:call-template name="ContentAreaName">
									<xsl:with-param name="contentarea">
										<xsl:value-of select="@name"/>
									</xsl:with-param>
								</xsl:call-template>
							</a>
							<!-- Add a bar separator unless this is the last secondary content area link -->
							<xsl:choose>
								<xsl:when test="count(//content-area-secondary) > 3">
									<xsl:if test="position() &lt; 3">
										<xsl:text> </xsl:text><span class="dwbctbar">|</span><xsl:text> </xsl:text> 
									</xsl:if>
								</xsl:when>
								<xsl:when test="count(//content-area-secondary) &lt; 4">
									<xsl:if test="not(position() = last())">
										<xsl:text> </xsl:text><span class="dwbctbar">|</span><xsl:text> </xsl:text> 
									</xsl:if>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
				</li>
			</xsl:when>
			<!-- Process bct with subnav link -->
			<xsl:when test="normalize-space(//content-area-subnav/text) and normalize-space(//content-area-subnav/url)">
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="//content-area-subnav/url"/>
						</xsl:attribute>
						<xsl:value-of select="//content-area-subnav/text"/>
					</a>		
				</li>
				<!-- If there is also a sublevel link, add it to the end of the navigation trail -->
				<xsl:if test="normalize-space(//content-area-subnav-sublevel)">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="//content-area-subnav-sublevel/url"/>
							</xsl:attribute>
							<xsl:value-of select="//content-area-subnav-sublevel/text"/>
						</a>		
					</li>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
    </xsl:template>
	<!-- xM R2 (R2.2) jpp 05/03/11:  Removed LeadspaceHidef-v16 template; Now pointing directly to LeadspaceHidefOptions-v16 -->
	<!-- NOT USED FOR 7.0 -->
     <xsl:template name="LeadspaceHidefBuild-v16">
    	<xsl:element name="div">
			<xsl:attribute name="id">ibm-content-head</xsl:attribute>
			<!-- Determine text color -->
			<xsl:choose>
				<xsl:when test="@overlay-text-color='black'">
					<xsl:attribute name="class">ibm-leadspace-overlay ibm-alternate</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">ibm-leadspace-overlay</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Sets the background image height -->
			<!-- Set variable to process background image for preview -->
			<xsl:variable name="hidef-background-image-url">
				<xsl:call-template name="generate-correct-url-form">
					<xsl:with-param name="input-url" select="image-url" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:attribute name="style">
				<xsl:text disable-output-escaping="yes">background-image: url('</xsl:text>
					<xsl:value-of select="$hidef-background-image-url"/>					
				<xsl:text disable-output-escaping="yes">');</xsl:text>
			</xsl:attribute>
			<!-- If the height specified for the background image is not 280 (pixels), reset the style for the background image to the correct height -->
			<!-- Note:  The ibm.com standard for Hi-Definition landing pages allows use of this inline style for resizing the backgroud image; Ignore WebKing violation --> 
			<xsl:if test="normalize-space(height) and not(height = 280)">
				<style type="text/css">
					<xsl:text>div.ibm-landing-page .ibm-leadspace-overlay {min-height:</xsl:text>
						<xsl:value-of select="height"/>
					<xsl:text>px;}</xsl:text>
					<xsl:text>* html div.ibm-landing-page .ibm-leadspace-overlay {height:</xsl:text>
						<xsl:value-of select="height"/>
					<xsl:text>px;}</xsl:text>
				</style>
			</xsl:if>
			<!-- Build navigation trail -->
			<ul id="ibm-navigation-trail">
				<li class="ibm-first">
					<a href="{overlay-navigation-link-first/url}"><xsl:value-of select="overlay-navigation-link-first/text"/></a>
				</li>
				<xsl:if test="normalize-space(overlay-navigation-link-second/text) and normalize-space(overlay-navigation-link-second/url)">
					<li>
						<a href="{overlay-navigation-link-second/url}"><xsl:value-of select="overlay-navigation-link-second/text"/></a>
					</li>
				</xsl:if>
				<xsl:if test="normalize-space(overlay-navigation-link-third/text) and normalize-space(overlay-navigation-link-third/url)">
					<li>
						<a href="{overlay-navigation-link-third/url}"><xsl:value-of select="overlay-navigation-link-third/text"/></a>
					</li>
				</xsl:if>
			</ul>
			<!-- Create overlay features, if any (heading, subtitle, and call-to-action links) -->
			<xsl:choose>
				<xsl:when test="normalize-space(overlay-heading) and (@overlay-text-color='black')">
					<p class="dw-leadspace-overlay-heading dw-alternate"><xsl:value-of select="overlay-heading"/></p>
				</xsl:when>
				<xsl:when test="normalize-space(overlay-heading) and not(@overlay-text-color='black')">
					<p class="dw-leadspace-overlay-heading"><xsl:value-of select="overlay-heading"/></p>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="normalize-space(overlay-subtitle)">
				<p><em><xsl:value-of select="overlay-subtitle"/></em></p>
			</xsl:if>
			<xsl:for-each select="overlay-forward-link">
				<xsl:if test="normalize-space(text) and normalize-space(url)">
					<p class="ibm-ind-link"><a href="{url}" class="ibm-forward-em-link"><xsl:value-of select="text"/></a></p>
				</xsl:if>
			</xsl:for-each>
			<!-- Build accessibility text if leadspace image has text -->
			<xsl:if test="normalize-space(image-alt)">
				<p class="ibm-access"><xsl:value-of select="image-alt"/></p>
			</xsl:if>
		</xsl:element>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="LeadspaceHidefOptions-v16">
		<xsl:for-each select="following::content[1]">
			<xsl:choose>
				<!-- When an individual page has a rich-media leadspace defined, process it -->						
				<xsl:when test="featured-content-module-hidef/rich-media">
					<xsl:for-each select="featured-content-module-hidef">
						<xsl:call-template name="IncludeFile-v16"/>
					</xsl:for-each>
				</xsl:when>
				<!-- When an individual page has a non-rich-media leadspace defined, process it -->
				<xsl:when test="featured-content-module-hidef/leadspace-overlay">
					<xsl:for-each select="featured-content-module-hidef/leadspace-overlay">
						<xsl:call-template name="LeadspaceHidefBuild-v16"/>						
					</xsl:for-each>
				</xsl:when>
				<!-- Otherwise, use the leadspace defined for the pagegroup for this page -->
				<xsl:otherwise>
					<xsl:for-each select="//pagegroup-hidef/featured-content-module-hidef">
						<xsl:choose>
							<!-- If this is an include request, process it -->
							<xsl:when test="normalize-space(rich-media/include/@relative-url)">
								<xsl:call-template name="IncludeFile-v16"/>
							</xsl:when>
							<!-- Otherwise, build the leadspace -->
							<xsl:otherwise>
								<xsl:for-each select="//pagegroup-hidef/featured-content-module-hidef/leadspace-overlay">
									<xsl:call-template name="LeadspaceHidefBuild-v16"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
    </xsl:template> 
    <!-- Project Defiant jpp 10/28/11: Added LeadspaceStyles-v17 template -->
	<!-- USED FOR 7.0 -->
    <xsl:template name="LeadspaceStyles-v17">
		<xsl:choose>
			<xsl:when test="/dw-document/dw-home">
				<!-- v17 Project Defiant Update jpp 07/03/12: Updated if test to create styles for HomeStandardAlt layout -->				
				<xsl:if test="(//@layout='HomeStandard' or //@layout='HomeStandardAlt') and normalize-space(/dw-document/dw-home/leadspace-module/leadspace-home)">
					<!-- Project Defiant jpp 11/22/11: Created leadspace styles for home page leadspace area -->
					<xsl:element name="style">
						<xsl:attribute name="type"><xsl:text>text/css</xsl:text></xsl:attribute>
						<xsl:for-each select="/dw-document/dw-home/leadspace-module/leadspace-home/leadspace-feature">
							<!-- Set variable to process background image for preview -->
							<xsl:variable name="leadspace-background-image-url">
								<xsl:call-template name="generate-correct-url-form">
									<xsl:with-param name="input-url" select="background-image-url" />
								</xsl:call-template>
							</xsl:variable>
							<!-- Set variable to process thumbnail image for preview -->
							<xsl:variable name="leadspace-thumbnail-image-url">
								<xsl:call-template name="generate-correct-url-form">
									<xsl:with-param name="input-url" select="thumbnail-image-url" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:choose>
								<!-- Create styles for first leadspace feature -->
								<xsl:when test="position()=1">						
									<xsl:text>.dw-home-page #ibm-lead-1 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-background-image-url"/>
									<xsl:text>) repeat-x 50% 0px; }</xsl:text>
									<xsl:text>.dw-home-page #ibm-leadspace-head .ibm-lead-thumb-1 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-thumbnail-image-url"/>
									<xsl:text>) no-repeat 0px 0px; }</xsl:text>
								</xsl:when>
								<xsl:when test="position()=2">					
									<xsl:text>.dw-home-page #ibm-lead-2 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-background-image-url"/>
									<xsl:text>) repeat-x 50% 0px; }</xsl:text>
									<xsl:text>.dw-home-page #ibm-leadspace-head .ibm-lead-thumb-2 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-thumbnail-image-url"/>
									<xsl:text>) no-repeat 0px 0px; }</xsl:text>
								</xsl:when>
								<xsl:when test="position()=3">					
									<xsl:text>.dw-home-page #ibm-lead-3 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-background-image-url"/>
									<xsl:text>) repeat-x 50% 0px; }</xsl:text>
									<xsl:text>.dw-home-page #ibm-leadspace-head .ibm-lead-thumb-3 { background: url(</xsl:text>
										<xsl:value-of select="$leadspace-thumbnail-image-url"/>
									<xsl:text>) no-repeat 0px 0px; }</xsl:text>
								</xsl:when>			
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:when test="/dw-document/dw-results">
				<xsl:if test="//@layout='ResultsTrending'">
					<xsl:element name="style">
						<xsl:attribute name="type"><xsl:text>text/css</xsl:text></xsl:attribute>
						<!-- Standard background style for Trending Results leadspace -->
						<xsl:text>#ibm-leadspace-head #ibm-leadspace-body {background: url(</xsl:text>
						<xsl:call-template name="generate-correct-url-form">
							<xsl:with-param name="input-url" select="$results-trending-bg-image"/>
						</xsl:call-template>						
						<xsl:text>) no-repeat;}</xsl:text>
					</xsl:element>
				</xsl:if>			
			</xsl:when>
		</xsl:choose>
    </xsl:template>    
	<!-- v17 Enablement jpp 09/16/2011:  Added LeadspaceTitleArea-v17 template -->
	<!-- USED FOR 7.0 -->
     <xsl:template name="LeadspaceTitleArea-v17">
		<!-- Project Defiant jpp 10/12/11: Made xsl:for-each selection more generic to handle other content types -->
		<xsl:for-each select="/dw-document//leadspace-module">		
			<xsl:choose>
				<!-- When leadspace-module type is leadspace-home -->
				<xsl:when test="leadspace-home">
					<!-- Process only if content type is dw-home -->
					<xsl:if test="/dw-document/dw-home">
						<xsl:choose>
							<!-- Project Defiant jpp 11/02/11: Retaining "static image" selection as future option -->
							<xsl:when test="normalize-space(leadspace-home/page-title)">
								<xsl:element name="div">
									<xsl:attribute name="id">ibm-leadspace-head</xsl:attribute>
									<xsl:attribute name="class">ibm-alternate</xsl:attribute>
									<xsl:element name="div">
										<xsl:attribute name="id">ibm-leadspace-body</xsl:attribute>								
										<!-- Set variable to process background image for preview -->
										<xsl:variable name="leadspace-background-image">
											<xsl:call-template name="generate-correct-url-form">
												<xsl:with-param name="input-url" select="leadspace-home/background-image-url" />
											</xsl:call-template>
										</xsl:variable>
										<!-- Create inline style for background image -->
										<xsl:attribute name="style">
											<xsl:text disable-output-escaping="yes">background: url('</xsl:text>
											<xsl:value-of select="$leadspace-background-image"/>
											<xsl:text disable-output-escaping="yes">') no-repeat;</xsl:text>
										</xsl:attribute>					
										<!-- Create page title -->
										<h1>
											<xsl:apply-templates select="leadspace-home/page-title"/>
										</h1>
										<!-- Create optional page subtitle -->
										<xsl:if test="leadspace-home/page-subtitle">
											<p>
												<em>
													<xsl:apply-templates select="leadspace-home/page-subtitle"/>
												</em>
											</p>
										</xsl:if>
									</xsl:element>
								</xsl:element>
							</xsl:when>
							<!-- Project Defiant jpp 11/23/11: Added condition to process multileafed version of leadspace -->
							<xsl:otherwise>
								<xsl:element name="div">
									<xsl:attribute name="id">ibm-leadspace-head</xsl:attribute>
									<xsl:attribute name="class">ibm-container</xsl:attribute>
									<xsl:element name="div">
										<xsl:attribute name="id">ibm-leadspace-body</xsl:attribute>
										<xsl:attribute name="class">ibm-container-body</xsl:attribute>
											<!-- Process each leadspace feature -->
											<xsl:for-each select="leadspace-home/leadspace-feature">																						
												<xsl:element name="div">
													<xsl:attribute name="id">
														<xsl:value-of select="concat('ibm-lead-',position())"/>
													</xsl:attribute>
													<xsl:attribute name="class">ibm-columns</xsl:attribute>
													<xsl:element name="div">
														<xsl:attribute name="class">ibm-col-1-1</xsl:attribute>
														<!-- Project Defiant jpp 01/31/12: Added if tests to select correct heading for leadspace feature -->
														<xsl:if test="position()=1">
															<h1>
																<a href="{feature-target-url}">
																	<xsl:value-of select="feature-heading"/>
																</a>
															</h1>
														</xsl:if>
														<xsl:if test="not(position()=1)">
															<h2>
																<a href="{feature-target-url}">
																	<xsl:value-of select="feature-heading"/>
																</a>
															</h2>
														</xsl:if>
														<p>
															<em><xsl:apply-templates select="feature-abstract"/></em><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
															<!-- Process content area if specified -->
															<xsl:if test="normalize-space(feature-content-area) and (feature-content-area != 'dwhome') and (feature-content-area != 'none') and (feature-content-area != 'alphaworks')">
																<xsl:element name="a">
																	<xsl:attribute name="href">
																		<xsl:value-of select="$developerworks-top-url"/> 
																		<xsl:value-of select="feature-content-area"/>
																		<xsl:text>/</xsl:text>
																	</xsl:attribute>
																	<xsl:text>[</xsl:text>
																	<xsl:call-template name="ContentAreaExtendedName">
																		<xsl:with-param name="contentarea">
																			<xsl:value-of select="feature-content-area"/>
																		</xsl:with-param>
																	</xsl:call-template>
																	<xsl:text>]</xsl:text>													
																</xsl:element>
															</xsl:if>
														</p>													
													</xsl:element>
												</xsl:element>
											</xsl:for-each>								
									</xsl:element>
								</xsl:element>
							</xsl:otherwise>							
						</xsl:choose>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<!-- Project Defiant jpp 11/27/11: Updated template to process leadspace area for ResultsTrending content type/layout -->
		<!-- Process only if content type is dw-results -->		
		<xsl:if test="/dw-document/dw-results">
			<xsl:element name="div">
				<xsl:attribute name="id">ibm-leadspace-head</xsl:attribute>
				<xsl:attribute name="class">ibm-alternate</xsl:attribute>
				<xsl:element name="div">
					<xsl:attribute name="id">ibm-leadspace-body</xsl:attribute>
					<!-- Create navigation trail -->					
					<ul id="ibm-navigation-trail">
					  <li><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>		  
					</ul>		
					<!-- Create page title -->
					<xsl:element name="h1">
						<xsl:attribute name="class">dw-results-title</xsl:attribute>
						<xsl:value-of select="$learnabout"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text><span class="dw-results-title-symbol">&gt;</span><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
							<span class="dw-results-title-term">
								<!-- Return search term from page title -->
								<xsl:call-template name="FullTitle-v17">
									<xsl:with-param name="return">leadspaceterm</xsl:with-param>
								</xsl:call-template>
							</span>		
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
    </xsl:template>    
	<!-- NOT USED FOR 7.0 -->
	<xsl:template name="LinkToEnglish-v16">
		<xsl:if test="/dw-document//link-to-english">
			<xsl:choose>
				<xsl:when test="/dw-document//link-to-english=''">
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="original_version_url">
						<xsl:value-of select="/dw-document//link-to-english"/>
					</xsl:variable>
					<br class="ibm-ind-link"/><strong><xsl:value-of select="$linktoenglish-heading"/></strong>
				          <xsl:choose>
		  <xsl:when test="/dw-document//@local-site='china'">
		      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
		  </xsl:when>
          <xsl:otherwise>      
	  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
          </xsl:otherwise>
				          </xsl:choose>
					<a href="{$original_version_url}" onmouseover="linkQueryAppend(this)">
						<xsl:value-of select="$linktoenglish"/>
					</a>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- Project Defiant jpp 10/12/11: Added ListItemCategory-v17 template -->
	<!-- USED FOR 7.0 -->
	<xsl:template name="ListItemCategory-v17">
		<xsl:param name="category"/>
		<xsl:choose>
			<xsl:when test="$category='article'"><xsl:value-of select="$category-article"/></xsl:when>
			<xsl:when test="$category='audio'"><xsl:value-of select="$category-audio"/></xsl:when>
			<xsl:when test="$category='blog'"><xsl:value-of select="$category-blog"/></xsl:when>
			<xsl:when test="$category='briefing'"><xsl:value-of select="$category-briefing"/></xsl:when>
			<xsl:when test="$category='champion'"><xsl:value-of select="$category-champion"/></xsl:when>
			<xsl:when test="$category='demo'"><xsl:value-of select="$category-demo"/></xsl:when>
			<xsl:when test="$category='download'"><xsl:value-of select="$category-download"/></xsl:when>
			<xsl:when test="$category='forum'"><xsl:value-of select="$category-forum"/></xsl:when>
			<xsl:when test="$category='group'"><xsl:value-of select="$category-group"/></xsl:when>
			<xsl:when test="$category='knowledge-path'"><xsl:value-of select="$category-knowledge-path"/></xsl:when>
			<xsl:when test="$category='tutorial'"><xsl:value-of select="$category-tutorial"/></xsl:when>
			<xsl:when test="$category='video'"><xsl:value-of select="$category-video"/></xsl:when>
			<xsl:when test="$category='wiki'"><xsl:value-of select="$category-wiki"/></xsl:when>
		</xsl:choose>
	</xsl:template>	
  <!-- MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM -->
    <!-- v17 Enablement jpp 09/14/2011:  Added MetaLanguageCountry-v17 template -->
    <!-- USED FOR 7.0 -->
    <!-- Processes module heading -->
    <xsl:template name="MetaLanguageCountry-v17">
		<xsl:param name="return"/>
		<xsl:choose>
			<xsl:when test="$return='htmltag'">
				<xsl:choose>
					<!-- v17 Enablement jpp 01/27/2012:  Corrected output for worldwide test -->
					<xsl:when test="//@local-site='worldwide'">en</xsl:when>
					<xsl:when test="//@local-site='brazil'">pt-BR</xsl:when>
					<xsl:when test="//@local-site='china'">zh-CN</xsl:when>
					<xsl:when test="//@local-site='japan'">ja-JP</xsl:when>
					<xsl:when test="//@local-site='korea'">ko-KR</xsl:when>
					<xsl:when test="//@local-site='russia'">ru-RU</xsl:when>
					<xsl:when test="//@local-site='ssa'">es-ZZ</xsl:when>
					<xsl:when test="//@local-site='vietnam'">en-VN</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$return='dclanguage'">
				<xsl:choose>
					<xsl:when test="//@local-site='worldwide'">en</xsl:when>
					<xsl:when test="//@local-site='brazil'">pt-BR</xsl:when>
					<xsl:when test="//@local-site='china'">zh-CN</xsl:when>
					<xsl:when test="//@local-site='japan'">ja-JP</xsl:when>
					<xsl:when test="//@local-site='korea'">ko-KR</xsl:when>
					<xsl:when test="//@local-site='russia'">ru-RU</xsl:when>
					<xsl:when test="//@local-site='ssa'">es</xsl:when>
					<xsl:when test="//@local-site='vietnam'">en-VN</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$return='ibmcountry'">
				<xsl:choose>
					<xsl:when test="//@local-site='worldwide'">ZZ</xsl:when>
					<xsl:when test="//@local-site='brazil'">BR</xsl:when>
					<xsl:when test="//@local-site='china'">CN</xsl:when>
					<xsl:when test="//@local-site='japan'">JP</xsl:when>
					<xsl:when test="//@local-site='korea'">KR</xsl:when>
					<xsl:when test="//@local-site='russia'">RU</xsl:when>
					<xsl:when test="//@local-site='ssa'">ZZ</xsl:when>
					<xsl:when test="//@local-site='vietnam'">VN</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Processes module heading -->
    <xsl:template name="ModuleBTTLink-v16">
		<xsl:choose>
			<xsl:when test="container-heading/@back-to-top='yes'">
				<xsl:copy-of select="$ssi-s-backlink-module" />
			</xsl:when>
		</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process link sections for module with side-by-side containers -->
    <xsl:template name="ModuleContainerBody-v16">
		<xsl:for-each select="container-body/link-section">
				<xsl:choose>
					<!-- Process link block -->
					<xsl:when test="normalize-space(link-block)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkBlock-v16"/>
					</xsl:when>
					<!-- Process link list -->
					<xsl:when test="normalize-space(link-list)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkList-v16"/>
					</xsl:when>
				</xsl:choose>
		</xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process link sections for container single module -->
    <xsl:template name="ModuleContainerColumn-v16">
			<xsl:for-each select="container-column/link-section">
				<xsl:choose>
					<!-- Process link block -->
					<xsl:when test="normalize-space(link-block)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkBlock-v16"/>
					</xsl:when>
					<!-- Process link list -->
					<xsl:when test="normalize-space(link-list)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkList-v16"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
    </xsl:template> 
    <!-- NOT USED FOR 7.0 -->   
    <!-- Template to process link sections for module with multiple interior columns -->
    <xsl:template name="ModuleContainerColumnMultiple-v16">
			<xsl:for-each select="link-section">
				<xsl:choose>
					<!-- Process link block -->
					<xsl:when test="normalize-space(link-block)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkBlock-v16"/>
					</xsl:when>
					<!-- Process link list -->
					<xsl:when test="normalize-space(link-list)">
						<!-- Process request for separator -->
						<xsl:if test="not(position() = 1) and (@separator='yes')">
							<div class="ibm-rule"><hr /></div>
						</xsl:if>
						<xsl:call-template name="ModuleLinkList-v16"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process forward link area at top or bottom of module -->
    <xsl:template name="ModuleContainerForwardLink-v16">
		<!-- Process link block forward link -->
    	<xsl:if test="normalize-space(container-forward-link)">
			<div class="ibm-rule"><hr /></div>
			<p class="ibm-ind-link">
				<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
					<xsl:value-of select="container-forward-link/url"  />	
					<xsl:choose>
						<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
							<xsl:choose>
								<xsl:when test="container-forward-link/@tactic='yes'">		
									<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
						</xsl:otherwise>	
					</xsl:choose>
					<xsl:value-of select="container-forward-link/text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
				<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
</p>
		</xsl:if>
	</xsl:template>
	<!--NOT USED FOR 7.0 -->
    <!--  Template for container link-block-heading -->
    <xsl:template match="link-block-heading">
        <xsl:if test="normalize-space()">
            <h3>
                <xsl:choose>
                    <!-- Heading is a link -->
                    <xsl:when test="normalize-space(url)">
                        <xsl:variable name="link-target-url">
                            <xsl:call-template name="generate-correct-url-form">
                                <xsl:with-param name="input-url"
                                    select="url" />
                            </xsl:call-template>
                        </xsl:variable>
                        <a href="{$link-target-url}" class="ibm-feature-link">
                            <xsl:value-of select="text" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="text" />
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </xsl:if>
    </xsl:template>  
    <!--NOT USED FOR 7.0 -->  
    <!--  Template for container link-block-image-url -->
    <xsl:template match="link-block-image-url">
        <xsl:param name="size" />
        <xsl:if test="normalize-space()">
            <xsl:variable name="dimensions">
                <xsl:choose>
                    <xsl:when test="$size='small' ">
                        <xsl:value-of select="50" />
                    </xsl:when>
                    <xsl:when test="$size='large' ">
                        <xsl:value-of select="70" />
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="link-image-url">
                <xsl:call-template name="generate-correct-url-form">
                    <xsl:with-param name="input-url" select="." />
                </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
				<xsl:when test="$size='small'">
					<img src="{$link-image-url}" width="{$dimensions}" height="{$dimensions}" alt="" />
				</xsl:when>
				<xsl:otherwise>
					<img class="dw-image-space" src="{$link-image-url}" width="{$dimensions}" height="{$dimensions}" alt="" />
				</xsl:otherwise>
			</xsl:choose>            
        </xsl:if>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->    
    <!-- (Rewrite) Template to process container link block for module -->
    <xsl:template name="ModuleContainerLinkBlock-v16">
        <xsl:for-each select="container-link-block">
            <xsl:variable name="link-block-image-size">
                <xsl:choose>
                    <xsl:when test="@position='bottom' ">
                        <xsl:value-of select=" 'small' " />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select=" 'large' " />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="list-class">
				<xsl:if test="normalize-space(link-block-image-url)">
					<xsl:choose>
						<xsl:when test="@position ='bottom'">
							<xsl:text>ibm-portrait-module-list ibm-thumbnail</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>ibm-portrait-module-list ibm-alternate-thumbnail</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
            </xsl:variable>
            <xsl:choose>
				<xsl:when test="normalize-space(link-block-image-url) and (following-sibling::container-column)">
                    <ul class="{$list-class}">
                        <li>
                            <xsl:apply-templates select="link-block-image-url">
                                <xsl:with-param name="size" select="$link-block-image-size" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="link-block-heading" />
                            <!-- Process container link block abstract (Required) -->
                            <xsl:apply-templates select="link-block-abstract" />
                        </li>
                    </ul>
				</xsl:when>
				<xsl:when test="normalize-space(link-block-image-url) and (parent::show-hide-panel)">
                    <ul class="{$list-class}">
                        <li>
                            <xsl:apply-templates select="link-block-image-url">
                                <xsl:with-param name="size" select="$link-block-image-size" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="link-block-heading" />
                            <!-- Process container link block abstract (Required) -->
                            <xsl:apply-templates select="link-block-abstract" />
                        </li>
                    </ul>
				</xsl:when>
				<xsl:otherwise>
                    <xsl:apply-templates select="link-block-image-url">
                        <xsl:with-param name="size" select="$link-block-image-size" />
                    </xsl:apply-templates>
                    <xsl:apply-templates select="link-block-heading" />
                    <!-- Process container link block abstract (Required) -->
                    <xsl:apply-templates select="link-block-abstract" />
				</xsl:otherwise>
			</xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process container link block that contains a form -->
	<xsl:template name="ModuleContainerLinkBlockForm-v16">
		<xsl:for-each select="container-link-block/form">
			<xsl:choose>
				<!-- Custom form -->
				<xsl:when test="normalize-space(@custom-form-name)">
					<xsl:call-template name="ModuleFormCustom-v16"/>
				</xsl:when>
				<!-- Pulldown form -->
				<xsl:when test="normalize-space(pulldown-form)">
					<!-- Process optional form heading -->
					<xsl:if test="normalize-space(form-heading)">
						<h3>
							<xsl:value-of select="form-heading" />
						</h3>
					</xsl:if>
					<!-- Create form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<form action="]]></xsl:text>
						<xsl:value-of select="form-action"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" method="get"]]></xsl:text>
					<xsl:if test="normalize-space(form-id)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ id="]]></xsl:text>
						<xsl:value-of select="form-id"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:if test="normalize-space(form-name)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ name="]]></xsl:text>
						<xsl:value-of select="form-name"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:text disable-output-escaping="yes"><![CDATA[ onsubmit="return ibmCommonDropdown(this)">]]></xsl:text>
					<!-- Create accessibility text/label for form -->
					<div class="ibm-access">
						<label for="{pulldown-form/select-id}"><xsl:value-of select="form-accessibility-heading" /></label>
					</div>
					<!-- Create any form input tags -->
					<xsl:call-template name="ModuleFormInputs-v16"/>
					<!-- Process form options and form button -->
					<xsl:call-template name="ModuleFormOptions-v16"/>
					<!-- End form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[</form>]]></xsl:text>
				</xsl:when>
				<!-- Search form -->
				<xsl:when test="normalize-space(search-form)">
					<!-- Create form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<form action="]]></xsl:text>
						<xsl:value-of select="form-action"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" method="get"]]></xsl:text>
					<xsl:if test="normalize-space(form-id)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ id="]]></xsl:text>
						<xsl:value-of select="form-id"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:if test="normalize-space(form-name)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ name="]]></xsl:text>
						<xsl:value-of select="form-name"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
					<!-- Create any form input tags -->
					<xsl:call-template name="ModuleFormInputs-v16"/>
							<p>
								<!-- Create accessibility label and descriptive text for search form -->
								<xsl:text disable-output-escaping="yes"><![CDATA[<label for="]]></xsl:text>
									<xsl:value-of select="translate(form-accessibility-heading,' ','')"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								<!-- If there is descriptive text for the form, process it -->
								<xsl:if test="normalize-space(form-heading)">
									<strong>
										<xsl:value-of select="form-heading"/>
									</strong>
								</xsl:if>
								<!-- If there is no descriptive text for the form, wrap label around a c.gif -->	
								<xsl:if test="not(normalize-space(form-heading))">
                             <!-- Use convenience variable for
                                 //www.ibm.com/i/c.gif and remove CDATA -->
                            <img src="{$ibm-c-dot-gif}" width="1" height="1" alt="{$form-search-in}"/>
                            	</xsl:if>
								<!-- Close label tag -->
								<xsl:text disable-output-escaping="yes"><![CDATA[</label>]]></xsl:text>
								<!-- If there is descriptive text for the form, add spacing between text and input field -->
								<xsl:if test="normalize-space(form-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;&nbsp; ]]></xsl:text>
								</xsl:if>
								<!-- Create search text input field -->
								<xsl:text disable-output-escaping="yes"><![CDATA[<input id="]]></xsl:text>
									<xsl:value-of select="translate(form-accessibility-heading,' ','')"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[" name="]]></xsl:text>
									<xsl:value-of select="search-form/input-field/name"/>									
								<xsl:text disable-output-escaping="yes"><![CDATA[" type="]]></xsl:text>
									<xsl:value-of select="search-form/input-field/type"/>	
								<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>									
								<xsl:if test="normalize-space(search-form/input-field/value)">
									<xsl:text disable-output-escaping="yes"><![CDATA[ " value="]]></xsl:text>
										<xsl:value-of select="search-form/input-field/value"/>
									<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>		
								</xsl:if>
								<xsl:text disable-output-escaping="yes"><![CDATA[ maxlength="100" size="30" />]]></xsl:text>
								<!-- Create search form button -->
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
								<xsl:text disable-output-escaping="yes"><![CDATA[<input src="//www.ibm.com/i/v16/buttons/short-btn.gif" type="image" class="ibm-btn-view"]]></xsl:text>
								<xsl:text disable-output-escaping="yes"><![CDATA[ name="]]></xsl:text>
									<xsl:value-of select="search-form/input-button-name"/>									
								<xsl:text disable-output-escaping="yes"><![CDATA[" value="]]></xsl:text>
									<xsl:value-of select="search-form/input-button-value"/>	
								<xsl:text disable-output-escaping="yes"><![CDATA[" alt="Search" />]]></xsl:text>									
							</p>
					<!-- End form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[</form>]]></xsl:text>		
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- Master template to process generic center-column modules -->
	<xsl:template name="ModuleDocbody-v16">
		<xsl:for-each select="/dw-document/dw-dwtop-home/module | /dw-document/dw-dwtop-home-hidef/module | /dw-document/dw-dwtop-zoneoverview/module | /dw-document/dw-landing-generic/module | /dw-document/dw-landing-product/module | following::content[1]/module">
			<xsl:choose>
			    <!-- Process module with a single container -->
				<xsl:when test="container-single">
					<xsl:for-each select="container-single">
						<!-- Create module frame and body -->
						<xsl:choose>
						    <!-- When module does not have a container column -->
							<xsl:when test="not(container-column)">
								<xsl:choose>
									<!-- Case: module has heading -->
									<xsl:when test="normalize-space(container-heading)">
										<div class="ibm-container ibm-portrait-module">
											<xsl:choose>
												<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
													<xsl:call-template name="ModuleHeading-v16"/>
												</xsl:when>
												<xsl:otherwise>
													<h2>
														<xsl:value-of select="container-heading" />
													</h2>
												</xsl:otherwise>
											</xsl:choose>
										<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:when>
									<!-- Case: module has container-level image and forward link but no heading -->
									<xsl:when test="not(normalize-space(container-heading)) and normalize-space(container-link-block/link-block-image-url) and (container-forward-link)">
										<div class="ibm-container ibm-portrait-module ibm-alternate-two ibm-alternate-six">
											<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:when>
									<!-- Case: module has no heading and no forward link -->
									<xsl:otherwise>
										<div class="ibm-container ibm-portrait-module ibm-alternate-two">
											<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<!-- When module has a container column -->
							<xsl:when test="(container-column)">
								<div class="ibm-container">
									<xsl:if test="normalize-space(container-heading)">
										<xsl:choose>
											<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
												<xsl:call-template name="ModuleHeading-v16"/>
											</xsl:when>
											<xsl:otherwise>
												<h2>
													<xsl:value-of select="container-heading" />
												</h2>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
									<xsl:call-template name="ModuleSingleContainerBody-v16"/>
								</div>
							</xsl:when>							
						</xsl:choose>
					</xsl:for-each>
                </xsl:when>
			    <!-- Process module with multiple containers -->
				<xsl:when test="container">
					<div class="ibm-two-column">	
						<xsl:call-template name="ModuleMultipleContainerBody-v16"/>
					</div>
				</xsl:when>		
				<xsl:when test="container-single-show-hide">
				<xsl:for-each select="container-single-show-hide">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container ibm-simple-show-hide">]]></xsl:text>
							<xsl:choose>
								<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
									<xsl:call-template name="ModuleHeading-v16"/>
								</xsl:when>
								<xsl:otherwise>
									<h2>
										<xsl:value-of select="container-heading" />
									</h2>
								</xsl:otherwise>
							</xsl:choose>
						<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>
							<xsl:choose>
								<xsl:when test="@show-date='no'">
										<p class="ibm-show-hide-controls"><a href="#show"><xsl:value-of select="$show-descriptions-text"/></a> | <a class="ibm-active" href="#hide"><xsl:value-of select="$hide-descriptions-text"/></a></p>
								</xsl:when>							
								<xsl:otherwise>									
									<xsl:if test="@show-date='yes'">
										<p class="ibm-show-hide-controls"><strong>
										<xsl:call-template name="ModuleShowHideDate-v16" /> 
										</strong>									
										<!-- Spacer for date -->
										<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text><a href="#show"><xsl:value-of select="$show-descriptions-text"/></a> | <a class="ibm-active" href="#hide"><xsl:value-of select="$hide-descriptions-text"/></a></p> 
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>						
							<!-- Process bulleted list -->
							<ul class="ibm-bullet-list">
								<xsl:for-each select="link-list/link-list-item"> 
									<li>	
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
										<strong><xsl:value-of select="text"/></strong>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>

										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
 										<div class="ibm-hideable dw-show-hide-spacer">
											<p><xsl:value-of select="abstract-text" /></p>
										</div>						
									</li>
								</xsl:for-each>	
							</ul>
							<xsl:if test="normalize-space(more-featured-content)">
								<div class="ibm-rule"><hr /></div>
									<div class="ibm-three-column">										
										<div class="ibm-column ibm-first">
											<p class="ibm-ind-link"><a class="ibm-forward-link" href="{more-featured-content/url}">
											<xsl:value-of select="more-featured-content/text" /></a>
											</p>								
										</div>
										<div class="ibm-column ibm-second">
											<xsl:choose>
												<xsl:when test="normalize-space(rss-link)">
													<p class="ibm-ind-link"><a class="ibm-rss-link" href="{rss-link/url}">
													<xsl:value-of select="rss-link/text" /></a>
													</p>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
												</xsl:otherwise>
											</xsl:choose>	
										</div>
										<!-- no gizmos so insert a blank in the third column, leaving the third column in case there is a gizmo -->
										<div class="ibm-column ibm-third dw-tab-third-column">
											<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
										</div>										
									</div>
								</xsl:if>		
						<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
				</xsl:for-each>
				</xsl:when>
				<xsl:when test="container-single-show-hide-multipanel">		
					<!-- Create overall div for a show hide multipanel module -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container ibm-show-hide">]]></xsl:text>
							<xsl:for-each select="container-single-show-hide-multipanel/show-hide-panel">
								<!-- Create show hide panel heading -->
								<xsl:choose>
									<xsl:when test="position() = 1">
										<h2><a><xsl:apply-templates select="panel-heading" /></a></h2>
									</xsl:when> 									
									<xsl:otherwise>
										<h2><a class="ibm-show-hide-link" href="#"><xsl:apply-templates select="panel-heading" /></a></h2>					
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="panel-html-body">
										<div>
											<!-- If module contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
											<xsl:choose>
												<xsl:when test="descendant::table">
													<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="class">ibm-container-body</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:apply-templates select="panel-html-body"/>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="ModuleSingleContainerBody-v16" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
					<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
				</xsl:when>
				<xsl:when test="container-html">
					<xsl:for-each select="container-html">
						<xsl:if test="/dw-document/dw-landing-generic | /dw-document/dw-landing-product | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
							<!-- Create module frame and body -->
							<div class="ibm-container">
								<xsl:call-template name="ModuleHeading-v16"/>
								<div>
									<!-- If module contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
									<xsl:choose>
										<xsl:when test="descendant::table">
											<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">ibm-container-body</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:apply-templates select="container-html-body"/>
									<!-- Create back-to-top link if requested -->
									<xsl:call-template name="ModuleBTTLink-v16"/>
								</div>
							</div>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>		
				<xsl:when test="include">
					<xsl:for-each select="include">
						<xsl:call-template name="IncludeFile-v16"/>
					</xsl:for-each>	
				</xsl:when>	
	
			</xsl:choose>
		</xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="ModuleDocbodyHidef-v16">
    	<xsl:if test="not(../../@output='no')">
			<xsl:for-each select="following::content[1]/module">
				<xsl:call-template name="ModuleDocbodyHidefOptions-v16"/>
			</xsl:for-each>
		</xsl:if>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
	<!-- Template to control structure of center-column modules on high-definition landing pages -->
	<xsl:template name="ModuleDocbodyHidefOptions-v16">
		<xsl:choose>
			<!-- Process module with multiple "side-by-side" containers -->
			<xsl:when test="container">
				<xsl:choose>
					<!-- If either of the module containers specifies an orientation of 'offset-split', then create a 1/3-2/3 module layout -->
					<xsl:when test="(container/@module-orientation='offset-split')">
						<div class="ibm-two-column ibm-alternate-five">	
							<xsl:call-template name="ModuleMultipleContainerBodyHidef-v16"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div class="ibm-two-column">	
							<xsl:call-template name="ModuleMultipleContainerBodyHidef-v16"/>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- Process hi-def module with single, unframed container and no heading -->
			<xsl:when test="container-html/container-html-body-hidef">
				<xsl:choose>
					<xsl:when test="descendant::table | descendant::include">
						<xsl:apply-templates select="container-html/container-html-body-hidef"/>
					</xsl:when>
					<xsl:otherwise>
						<div class="ibm-container ibm-alternate">
							<div class="ibm-container-body">
								<xsl:apply-templates select="container-html/container-html-body-hidef"/>
							</div>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="container-html/container-html-body">
				<xsl:for-each select="container-html">
					<!-- Create module frame and body -->
					<div class="ibm-container">
						<xsl:call-template name="ModuleHeading-v16"/>
						<div>
							<!-- If module contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
							<xsl:choose>
								<xsl:when test="descendant::table">
									<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">ibm-container-body</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:apply-templates select="container-html-body"/>
							<!-- Create back-to-top link if requested -->
							<xsl:call-template name="ModuleBTTLink-v16"/>
						</div>
					</div>
				</xsl:for-each>
			</xsl:when>
			<!-- Process standard module with single container -->
			<xsl:when test="container-single | container-single-show-hide | container-single-show-hide-multipanel">
				<xsl:call-template name="ModuleSingleContainerBodyHidef-v16"/>
			</xsl:when>	
			<xsl:when test="include">
				<xsl:for-each select="include">
					<xsl:call-template name="IncludeFile-v16"/>
				</xsl:for-each>	
			</xsl:when>						
			
		</xsl:choose>
	</xsl:template>
	<!-- v17 Enablement jpp 09/17/2011: Added ModuleDynamic-v17 template -->
	<!-- USED FOR 7.0 -->
    <!--  Template to process dynamic content modules -->
	<xsl:template name="ModuleDynamic-v17">
		<!-- Parameter stores the name of the dynamic module request passed as a variable (ex. trending_1_dynamicHeading) -->
		<xsl:param name="componentRequestName"/>
		<!-- Parse incoming request name to determine dynamic module type (trending, downloads, community, etc.) -->
		<xsl:variable name="type">
			<xsl:value-of select="substring-before($componentRequestName,'_')"/>
		</xsl:variable>
		<!-- Parse incoming request name to determine dynamic module id -->
		<xsl:variable name="id">
			<xsl:value-of select="substring-before((substring-after($componentRequestName,'_')),'_')"/>
		</xsl:variable>
		<!-- Parse incoming request name to determine specific component to retrieve -->
		<xsl:variable name="instruction">
			<xsl:value-of select="substring-after((substring-after($componentRequestName,'_')),'_')"/>
		</xsl:variable>
		<!-- Process dynamic module request -->
		<xsl:choose>
			<xsl:when test="$instruction='dynamicType'">
				<xsl:value-of select="$type"/>
			</xsl:when>
			<xsl:when test="$instruction='dynamicId'">
				<xsl:value-of select="$id"/>
			</xsl:when>
			<xsl:when test="$instruction='dynamicHeading'">
				<xsl:for-each select="/dw-document//module/container-dynamic/*[local-name()=$type and @id=$id]">
					<xsl:call-template name="ModuleDynamicHeading-v17"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$instruction='dynamicLinkBlock'">
				<xsl:for-each select="/dw-document//module/container-dynamic/*[local-name()=$type and @id=$id]">
					<xsl:call-template name="ModuleDynamicLinkBlock-v17"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$instruction='dynamicForwardLink'">
				<xsl:for-each select="/dw-document//module/container-dynamic/*[local-name()=$type and @id=$id]">
					<xsl:call-template name="ModuleDynamicForwardLink-v17"/>
				</xsl:for-each>
			</xsl:when>
			<!-- v17 Enablement jpp 09/27/2011: Shortened instruction name -->
			<xsl:when test="$instruction='dynamicOutputVar'">
				<xsl:value-of select="$type"/><xsl:text>_</xsl:text><xsl:value-of select="$id"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- v17 Enablement jpp 09/18/2011: Added ModuleDynamicHeading-v17 template -->
	<!-- USED FOR 7.0 -->
    <!--  Template to process dynamic content modules -->    
	<xsl:template name="ModuleDynamicHeading-v17">
		<!-- Project Defiant jpp 10/13/11: Added ibm-rule class to heading -->
		<xsl:element name="h2">
			<xsl:attribute name="class">ibm-rule</xsl:attribute>
			<xsl:apply-templates select="container-heading"/>
		</xsl:element>
	</xsl:template>
	<!-- v17 Enablement jpp 09/18/2011: Added ModuleDynamicLinkBlock-v17 template -->
	<!-- USED FOR 7.0 -->
    <!--  Template to process dynamic content modules -->
	<xsl:template name="ModuleDynamicLinkBlock-v17">
        <xsl:for-each select="container-dynamic-link-block">
            <ul class="ibm-portrait-module-list">
                <li>                    
                    <xsl:variable name="output-link-block-image-url">
                        <xsl:call-template name="generate-correct-url-form">
                            <xsl:with-param name="input-url" select="link-block-image-url" />
                        </xsl:call-template>
                    </xsl:variable>
                    <!-- Portrait module image --> 
					<img src="{$output-link-block-image-url}" width="60" height="45" alt="" />						
					<!-- Portrait module heading (linked or unlinked) -->
					<xsl:if test="normalize-space(link-block-heading)">
						<h3>
							<xsl:choose>
								<xsl:when test="normalize-space(link-block-heading/url)">
									<a href="{link-block-heading/url}">
										<xsl:value-of select="link-block-heading/text" />
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="link-block-heading/text" />
								</xsl:otherwise>
							</xsl:choose>
						</h3>
					</xsl:if>
                    <!-- Process container link block abstract -->
                    <p><xsl:apply-templates select="link-block-abstract" /></p>
                </li>
            </ul>
        </xsl:for-each>
    </xsl:template>
	<!-- v17 Enablement jpp 09/18/2011: Added ModuleDynamicForwardLink-v17 template -->
	<!-- USED FOR 7.0 -->
    <!--  Template to process dynamic content modules -->
	<xsl:template name="ModuleDynamicForwardLink-v17">
		<xsl:for-each select="container-forward-link">
			<xsl:element name="p">
				<xsl:attribute name="class">ibm-ind-link</xsl:attribute>
				<xsl:element name="a">
					<xsl:attribute name="class">ibm-forward-em-link</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="url"/>
					</xsl:attribute>
					<xsl:apply-templates select="text"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- v17 Enablement jpp 09/17/2011: Added ModuleDynamicList-v17 template -->
	<!-- USED FOR 7.0 -->
    <!--  Template creates a list of dynamic content modules in the XML file for back-end processing -->
	<xsl:template name="ModuleDynamicList-v17">
		<xsl:for-each select="/dw-document//module/container-dynamic/*">
			<!-- Get dynamic module type: element name -->
			<xsl:value-of select="local-name()"/>
			<!-- Append underscore separator -->
			<xsl:text >_</xsl:text>
			<!-- Append module id value -->
			<xsl:value-of select="@id"/>
			<!-- Append comma if this is not the last value in the comma-separated list -->
			<xsl:if test="not(position()=last())">
				<xsl:text >,</xsl:text>
			</xsl:if> 
		</xsl:for-each>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!--  Template to process custom forms -->
	<xsl:template name="ModuleFormCustom-v16">
		<xsl:choose>
			<!-- Custom form:  WebSphere Support form on zone overview page -->
			<xsl:when test="@custom-form-name='d-w-form-supportsearch-zoneoverview'">
					<!-- Process optional form heading -->
					<xsl:if test="normalize-space(form-heading)">
						<h3>
							<xsl:value-of select="form-heading" />
						</h3>
					</xsl:if>
					<!-- Create form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<form action="]]></xsl:text>
						<xsl:value-of select="form-action"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" method="get"]]></xsl:text>
					<xsl:if test="normalize-space(form-id)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ id="]]></xsl:text>
						<xsl:value-of select="form-id"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:if test="normalize-space(form-name)">
						<xsl:text disable-output-escaping="yes"><![CDATA[ name="]]></xsl:text>
						<xsl:value-of select="form-name"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
					</xsl:if>
					<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
					<!-- Create accessibility text/label for form -->
					<div class="ibm-access">
						<label for="{pulldown-form/select-id}"><xsl:value-of select="form-accessibility-heading" /></label>
					</div>
					<!-- Create radio button group -->
					<p>
						<span class="ibm-input-group">
							<input id="productsupport" name="category" type="radio" checked="checked" value="10"/>
							<label for="productsupport"><xsl:value-of select="$form-product-support"/></label>
							<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;&nbsp; ]]></xsl:text>
							<input id="faqs" name="category" type="radio" value="30"/>
							<label for="faqs"><xsl:value-of select="$form-faqs"/></label>
							<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;&nbsp; ]]></xsl:text>
							<input id="productdoc" name="category" type="radio" value="15"/>
							<label for="productdoc"><xsl:value-of select="$form-product-doc"/></label>
							<xsl:text disable-output-escaping="yes"><![CDATA[ &nbsp;&nbsp; ]]></xsl:text>
							<input id="productsite" name="category" type="radio" value="25"/>
							<label for="productsite"><xsl:value-of select="$form-product-site"/></label>
						</span>
					</p>
					<!-- Process form options -->
					<p>
					<xsl:for-each select="pulldown-form">
						<!-- Create select/options portion of form -->
						<select id="{select-id}" name="{select-name}">
						<xsl:for-each select="option">
							<xsl:text disable-output-escaping="yes"><![CDATA[<option value="]]></xsl:text>
								<xsl:value-of select="value"/>
							<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
							<!-- Is option selected? -->
							<xsl:if test="@selected='yes'">
								<xsl:text disable-output-escaping="yes"><![CDATA[ selected="selected"]]></xsl:text>
							</xsl:if>
							<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>			
							<!-- Is option indented? -->
							<xsl:if test="@indent='yes'">
								<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&nbsp;&nbsp;]]></xsl:text>
							</xsl:if>
							<xsl:value-of select="text"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</option>]]></xsl:text>
						</xsl:for-each>
						</select>
					</xsl:for-each>
					<!-- Create form button -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					<input src="{$path-v16-buttons}short-btn.gif" value="Go" name="ibm-go" class="ibm-btn-go" type="image" alt="Submit" />
					<xsl:text disable-output-escaping="yes"><![CDATA[<br />&nbsp; ]]></xsl:text>
					</p>
					<!-- End form tag -->
					<xsl:text disable-output-escaping="yes"><![CDATA[</form>]]></xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- Template to process container link block that contains a form -->
	<xsl:template name="ModuleFormInputs-v16">
		<xsl:for-each select="form-input">
			<xsl:text disable-output-escaping="yes"><![CDATA[<input type="]]></xsl:text>
				<xsl:value-of select="type"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[" name="]]></xsl:text>
				<xsl:value-of select="name"/>
			<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
				<xsl:if test="normalize-space(value)">
					<xsl:text disable-output-escaping="yes"><![CDATA[ value="]]></xsl:text>
					<xsl:value-of select="value"/>
					<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
				</xsl:if>
				<xsl:text disable-output-escaping="yes"><![CDATA[ />]]></xsl:text>
			</xsl:for-each>
	</xsl:template>	
	<!-- NOT USED FOR 7.0 -->
    <!--  Template to process container link block that contains a form -->
	<xsl:template name="ModuleFormOptions-v16">
		<xsl:choose>
			<!-- Create select/options tags for a pulldown form -->
			<xsl:when test="pulldown-form">
				<xsl:for-each select="pulldown-form">
					<p>
					<!-- Create select/options portion of form -->
					<select id="{select-id}" name="{select-name}">
					<xsl:for-each select="option">
						<xsl:text disable-output-escaping="yes"><![CDATA[<option value="]]></xsl:text>
							<xsl:value-of select="value"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["]]></xsl:text>
						<!-- Is option selected? -->
						<xsl:if test="@selected='yes'">
							<xsl:text disable-output-escaping="yes"><![CDATA[ selected="selected"]]></xsl:text>
						</xsl:if>
						<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>			
						<!-- Is option indented? -->
						<xsl:if test="@indent='yes'">
							<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&nbsp;&nbsp;]]></xsl:text>
						</xsl:if>
						<xsl:value-of select="text"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[</option>]]></xsl:text>
					</xsl:for-each>
					</select>
					<!-- If this is a generic pulldown form, create form Go button -->
					<xsl:if test="not(normalize-space(../@custom-form-name))">
						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
						<input src="{$path-v16-buttons}short-btn.gif" value="Go" name="ibm-go" class="ibm-btn-go" type="image" alt="Submit" />
					</xsl:if>
					</p>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- Processes module heading -->
    <xsl:template name="ModuleHeading-v16">
		<xsl:variable name="newid">
			<xsl:choose>
				<xsl:when test="normalize-space(container-heading/@refname)">
					<xsl:value-of select="container-heading/@refname"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- Create an 8-character unique id -->
					<xsl:variable name="baseid">
					    <!-- Start with 6 uppercase characters from the container-heading text; replace any spaces with the character 'Z' -->
						<xsl:value-of select="translate(translate(substring(container-heading,1,6),' ','Z'),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
					</xsl:variable>
					<!-- Append the number of preceding nodes to the generated node id -->
					<xsl:choose>
						<!-- When count greater than 1000, only use 4 characters from container-heading text -->
						<xsl:when test="(1 + count(preceding::*)) > 1000">
							<xsl:value-of select="substring($baseid,1,4)"/>
							<xsl:value-of select="1 + count(preceding::*)"/>
						</xsl:when>
						<!-- When count greater than 100, only use 5 characters from container-heading text -->
						<xsl:when test="(1 + count(preceding::*)) > 100">
							<xsl:value-of select="substring($baseid,1,5)"/>
							<xsl:value-of select="1 + count(preceding::*)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$baseid"/>
							<xsl:value-of select="1 + count(preceding::*)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<h2>
			<a name="{$newid}">
				<xsl:apply-templates select="container-heading"/>
			</a>
		</h2>
    </xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- When a pagegroup page has an anchor link list, this template assigns refnames to major headings that are not container headings, if refnames are not defined -->
    <xsl:template name="ModuleInlineHeading-v16">
		<xsl:variable name="newid">
			<!-- Create an 8-character unique id -->
			<xsl:variable name="baseid">
				<!-- Start with 6 uppercase characters from the container-heading text; replace any spaces with the character 'Z' -->
				<xsl:value-of select="translate(translate(substring(.,1,6),' ','Z'),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
			</xsl:variable>
			<!-- Append the number of preceding nodes to the generated node id -->
			<xsl:choose>
				<!-- When count greater than 1000, only use 4 characters from container-heading text -->
				<xsl:when test="(1 + count(preceding::*)) > 1000">
					<xsl:value-of select="substring($baseid,1,4)"/>
					<xsl:value-of select="1 + count(preceding::*)"/>
				</xsl:when>
				<!-- When count greater than 100, only use 5 characters from container-heading text -->
				<xsl:when test="(1 + count(preceding::*)) > 100">
					<xsl:value-of select="substring($baseid,1,5)"/>
					<xsl:value-of select="1 + count(preceding::*)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$baseid"/>
					<xsl:value-of select="1 + count(preceding::*)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		<xsl:choose>
			<xsl:when test="@type='hidef'">				
				<h2 class="dw-hd-heading">
					<a name="{$newid}"><xsl:apply-templates select="*|text()" /></a>
				</h2>				
			</xsl:when>
			<xsl:otherwise>				
				<h2>
					<a name="{$newid}"><xsl:apply-templates select="*|text()" /></a>
				</h2>				
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>	
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process link block within a module section -->
    <xsl:template name="ModuleLinkBlock-v16">
		<xsl:for-each select="link-block">
			<!-- For side-by-side containers: if container has only one link section and an image, process image here using larger size -->
			<xsl:if test="(ancestor::container-body) and (count(../../link-section)=1) and normalize-space(link-block-image-url)">
                <xsl:apply-templates select="link-block-image-url">
                    <xsl:with-param name="size" select="'large'" />
                </xsl:apply-templates>
			</xsl:if>			
			<!-- Process link block heading -->
            <xsl:apply-templates select="link-block-heading"/>
			<!-- Process link block content -->
			<xsl:choose>
			    <!-- For side-by-side containers: if container has only one link section and an image, image was processed above; just process content here -->
				<xsl:when test="(ancestor::container-body) and (count(../../link-section)=1)">
					<xsl:apply-templates select="link-block-abstract" />
				</xsl:when>
				<!-- For other link blocks with images, process link block using smaller image size -->			
				<xsl:when test="normalize-space(link-block-image-url)">
					<ul class="ibm-portrait-module-list ibm-thumbnail">
						<li>
                            <xsl:apply-templates select="link-block-image-url">
                                <xsl:with-param name="size"
                                    select="'small'" />
                                </xsl:apply-templates>
							<xsl:apply-templates select="link-block-abstract" />							
						</li>
					</ul>
				</xsl:when>
				<!-- For link blocks without images, process content -->
				<xsl:otherwise>
					<xsl:apply-templates select="link-block-abstract" />
				</xsl:otherwise>
			</xsl:choose>
			<!-- Process link block forward link content -->
			<xsl:if test="normalize-space(link-block-forward-link)">
				<p class="ibm-ind-link">
					<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
						<xsl:value-of select="link-block-forward-link/url"  />	
							<xsl:choose>
								<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
									<xsl:choose>
										<xsl:when test="link-block-forward-link/@tactic='yes'">		
											<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
										</xsl:otherwise>
									</xsl:choose>										
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								</xsl:otherwise>	
							</xsl:choose>					
						<xsl:value-of select="link-block-forward-link/text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
				</p>
			</xsl:if>
		</xsl:for-each>
    </xsl:template>  
    <!-- NOT USED FOR 7.0 -->  
    <!-- Template to process link list within a module section -->
    <xsl:template name="ModuleLinkList-v16">
		<xsl:for-each select="link-list">
			<!-- Process link list heading -->
			<xsl:if test="normalize-space(link-list-heading)">
				<xsl:choose>
					<xsl:when test="normalize-space(link-list-heading/url)">
						<h3>
							<a href="{link-list-heading/url}" class="ibm-feature-link">
								<xsl:value-of select="link-list-heading/text"/>
							</a>							
						</h3>
					</xsl:when>
					<!-- 6.0 Defiant R1 11/21/11 jpp: Added xsl:when selection to process the highlight attribute on an unlinked link list heading -->
					<xsl:when test="link-list-heading/@highlight='yes'">
						<h3>
							<span class="ibm-important">
								<xsl:value-of select="link-list-heading/text"/>
							</span>
						</h3>
					</xsl:when>					
					<xsl:otherwise>
						<h3>
							<xsl:value-of select="link-list-heading/text"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<!-- Process link list content -->
			<xsl:choose>
				<!-- Arrow lists -->
				<xsl:when test="@style='arrow'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>
									<xsl:when test="@link-style = 'emphasized'">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text> 
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:for-each>	
					</ul>
				</xsl:when>
				<!-- First arrow bolded lists -->
				<xsl:when test="@style='first-arrow-bolded'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>							
									<xsl:when test="position() = 1">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>
						</li>
						</xsl:for-each>	
					</ul>
				</xsl:when>	
				<!-- Icon/Arrow combination lists -->
				<xsl:when test="@style='icon-arrow-combination'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<!-- If link style is unemphasized, output a normal arrow and normal text -->
								<xsl:choose>
									<xsl:when test="@link-style = 'unemphasized'">
										<a>
											<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:when>
									<!-- If link style is emphasized, output a bold arrow and bolded text -->
									<xsl:when test="@link-style = 'emphasized'">
										<a>
											<xsl:attribute name="class">ibm-forward-em-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<strong><xsl:value-of select="text"/></strong>
										</a>
									</xsl:when>
									<!-- If link style is NOT specified, output a normal arrow with normal text -->
									<xsl:when test="not(normalize-space(@link-style))">
										<a>
											<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:when>
									<!-- Otherwise, assume link style references an icon and output the icon with normal text -->
									<xsl:otherwise>
										<a>
											<xsl:attribute name="class">
												<xsl:call-template name="ForwardLinkIcon">
													<xsl:with-param name="style" select="@link-style"/>
												</xsl:call-template>
											</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<!-- Processes new indicator for Japanese pages (comes at the end of the link text on all maverick list items)  -->
							<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')">
								<xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text>
							</xsl:if>
						</xsl:for-each>	
					</ul>
				</xsl:when>				
				<!-- Ordered lists -->
				<xsl:when test="@style='ordered'">
					<ol class="ibm-bullet-list">
						<xsl:for-each select="link-list-item"> 
							<li>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
									<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
							<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							</li>
						</xsl:for-each>	
					</ol>
				</xsl:when>
				<!-- Bulleted lists -->
				<xsl:otherwise>
					<ul class="ibm-bullet-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>
									<xsl:when test="@link-style = 'emphasized'">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:for-each>	
					</ul>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process body for module with side-by-side containers -->
	<xsl:template name="ModuleMultipleContainerBody-v16">
		<xsl:for-each select="container">
			<!-- Create container frame based on position of container inside module -->
			<xsl:if test="position() = 1">
				<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-first">]]></xsl:text>
			</xsl:if>
			<xsl:if test="position() = 2">
				<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-second">]]></xsl:text>
			</xsl:if>
			<!-- Add classes to the frame based on container characteristics -->
			<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container]]></xsl:text>
			<!-- If container does not have heading, add class to close top of module -->
			<xsl:if test="not(normalize-space(container-heading))">
				<xsl:text disable-output-escaping="yes"><![CDATA[ ibm-alternate-two]]></xsl:text>
			</xsl:if>
			<!-- If container has forward link and no heading, add additional class to change top of module -->
			<xsl:if test="normalize-space(container-forward-link) and not(normalize-space(container-heading))">
				<xsl:text disable-output-escaping="yes"><![CDATA[ ibm-alternate-six]]></xsl:text>
			</xsl:if>
			<!-- If container has an image and only one link section, add portrait module class to display larger image -->
			<xsl:if test="normalize-space(container-body/link-section/link-block/link-block-image-url) and (count(container-body/link-section) =1)">
				<xsl:text disable-output-escaping="yes"><![CDATA[ ibm-portrait-module]]></xsl:text>
			</xsl:if>
			<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
			<!-- Create module heading if coded -->
			<xsl:if test="normalize-space(container-heading)">
				<xsl:choose>
					<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
						<xsl:call-template name="ModuleHeading-v16"/>
					</xsl:when>
					<xsl:otherwise>
						<h2>
							<xsl:value-of select="container-heading" />
						</h2>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<!-- Create container body -->
			<div class="ibm-container-body">	
			<!-- Process container body -->
			<xsl:call-template name="ModuleContainerBody-v16"/>
			<!-- Process container forward link -->
			<xsl:call-template name="ModuleContainerForwardLink-v16"/>
			<!-- Close container body -->
			</div>
			<!-- Close container frame -->
			<xsl:text disable-output-escaping="yes"><![CDATA[</div></div>]]></xsl:text>
		</xsl:for-each>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
	<!-- Template to process body for hidef module with side-by-side containers -->
	<xsl:template name="ModuleMultipleContainerBodyHidef-v16">
		<xsl:for-each select="container">
			<xsl:element name="div">
				<!-- Add classes based on container position -->
				<xsl:if test="position()=1"><xsl:attribute name="class">ibm-column ibm-first</xsl:attribute></xsl:if>
				<xsl:if test="position()=2"><xsl:attribute name="class">ibm-column ibm-second</xsl:attribute></xsl:if>
				<!-- Create frame based on container characteristics -->
				<xsl:element name="div">
					<xsl:choose>
						<!-- Container has no frame and no container-heading -->
						<xsl:when test="@frame='no' and not(normalize-space(container-heading))"><xsl:attribute name="class">ibm-container ibm-alternate</xsl:attribute></xsl:when>
						<!-- Container has frame but no container heading -->
						<xsl:when test="not(@frame='no') and not(normalize-space(container-heading))"><xsl:attribute name="class">ibm-container ibm-alternate-two</xsl:attribute></xsl:when>
						<!-- Otherwise, create frame for container heading -->
						<xsl:otherwise><xsl:attribute name="class">ibm-container</xsl:attribute></xsl:otherwise>
					</xsl:choose>
					<!-- Create container heading if coded -->
					<xsl:if test="normalize-space(container-heading)">
						<xsl:call-template name="ModuleHeading-v16"/>
					</xsl:if>
					<!-- Create container body div -->
					<xsl:element name="div"><xsl:attribute name="class">ibm-container-body</xsl:attribute>
						<!-- Process hidef abstract if defined -->
						<xsl:if test="preceding::abstract-extended[1]/@position='left'">
							<xsl:if test=".=(../../module[1]/container[1])">
								<div id="dw-hd-intro">
									<xsl:apply-templates select="preceding::abstract-extended[1]"/>
								</div>
							</xsl:if>
						</xsl:if>
						<!-- Process container body -->						
						<xsl:choose>
							<!-- FUTURE -->
							<xsl:when test="container-body">
							</xsl:when>
							<xsl:when test="container-html-body">
								<xsl:apply-templates select="container-html-body"/>
							</xsl:when>
						</xsl:choose>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>	
	</xsl:template>	
    <!-- NOT USED FOR 7.0 -->
	<xsl:template name="ModulePollsOverlay-v16">
		<xsl:choose>
		<xsl:when test="(/dw-document//poll-id !='')">
			<xsl:value-of select="poll-id" />
        </xsl:when>
<xsl:otherwise />
</xsl:choose>		
</xsl:template>	
    <!-- NOT USED FOR 7.0 -->
	<xsl:template name="ModulePollsText-v16">
		<xsl:if test="(/dw-document//poll-id !='')">
			<xsl:value-of select="poll-id/@lead-in-text" />
        </xsl:if>
	</xsl:template>
	<!-- v17 Enablement jpp 09/20/2011: Added ModulePromotion-v17 template -->
	<!-- USED FOR 7.0 -->
    <!-- Template to process promotion tile area -->
	<xsl:template name="ModulePromotion-v17">
		<!-- Process a three-column promption module with section images -->
		<xsl:for-each select="/dw-document//module-promotion">
			<xsl:if test="normalize-space(image-text-section[1]/image-url) and normalize-space(image-text-section[2]/image-url) and normalize-space(image-text-section[3]/image-url)">
				<div>
					<!-- Project Defiant jpp 02/08/12: Added dw-promotion class -->
					<xsl:attribute name="class">ibm-columns dw-promotion</xsl:attribute>
					<xsl:for-each select="image-text-section">
						<div>
							<xsl:attribute name="class">ibm-col-6-2</xsl:attribute>
							<ul class="ibm-portrait-module-list">
								<li>                    
									<xsl:variable name="output-image-url">
										<xsl:call-template name="generate-correct-url-form">
											<xsl:with-param name="input-url" select="image-url" />
										</xsl:call-template>
									</xsl:variable>
									<!-- Promotion tile/image --> 
									<img src="{$output-image-url}" width="60" height="45" alt="" />						
									<!-- Promotion heading (linked or unlinked) -->
									<xsl:if test="normalize-space(section-heading)">
										<h4>
											<xsl:choose>
												<xsl:when test="normalize-space(section-heading/url)">
													<a href="{section-heading/url}">
														<xsl:value-of select="section-heading/text" />
													</a>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="section-heading/text" />
												</xsl:otherwise>
											</xsl:choose>
										</h4>
									</xsl:if>
									<!-- Process call-to-action abstract -->
									<p><xsl:apply-templates select="call-to-action-text" /></p>
								</li>
							</ul>
						</div>
					</xsl:for-each>					
				</div>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- Template to process generic right column modules -->
    <xsl:template name="ModuleRightDocbody-v16">
		<xsl:if test="/dw-document/dw-landing-generic or /dw-document/dw-landing-product">
			<xsl:for-each select="//top-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="/dw-document/dw-summary">
			<xsl:for-each select="//top-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="/dw-document/dw-dwtop-home-hidef">
			<xsl:for-each select="//top-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:for-each select="//right-box">
		  <div class="ibm-container">
			  <!-- Create module heading -->
			  <h2>
				  <xsl:value-of select="heading" />
			  </h2>
			  <!-- Create module body -->
			  
				<xsl:choose>
					<!-- Support legacy code (bullets only) -->
					<xsl:when test="right-box-section/page-section-link">
						<div class="ibm-container-body dw-right-bullet-list">
							<ul class="ibm-bullet-list">	
								<!-- Process list contents -->
								<xsl:for-each select="right-box-section/page-section-link">
									<xsl:if test="normalize-space(text) and normalize-space(url)">
										<li>
											<a class="ibm-feature-link" href="{url}">
												<xsl:value-of select="text"/>
											</a>
										</li>
									</xsl:if>
								</xsl:for-each>	 
							</ul>  
						</div>
					</xsl:when>
					<xsl:when test="right-box-section/right-link-list">
						<xsl:choose>
							<xsl:when test="count(right-box-section/right-link-list/right-link-list-item) &lt; 7">
								<xsl:call-template name="ModuleRightLinkList-v16"/>
							</xsl:when>
							<!-- Per ibm.com standard, if right column box has more than six links, use bullets -->
							<xsl:otherwise>
								<div class="ibm-container-body dw-right-bullet-list">
									<ul class="ibm-bullet-list">	
										<!-- Process list contents -->
										<xsl:for-each select="right-box-section/right-link-list/right-link-list-item">
											<xsl:if test="normalize-space(text) and normalize-space(url)">
												<li>
													<a class="ibm-feature-link" href="{url}">
														<xsl:value-of select="text"/>
													</a>
												</li>
											</xsl:if>
										</xsl:for-each>	 
									</ul>  
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
	      </div>
	    </xsl:for-each>
		<xsl:if test="/dw-document/dw-landing-generic or /dw-document/dw-landing-product">
			<xsl:for-each select="//bottom-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="/dw-document/dw-summary">
			<xsl:for-each select="//bottom-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="/dw-document/dw-dwtop-home-hidef">
			<xsl:for-each select="//bottom-right-include">
				<xsl:call-template name="IncludeFile-v16"/>
			</xsl:for-each>
		</xsl:if>
    </xsl:template>    
    <!-- xM R2 (R2.2) jpp 05/03/11:  Removed ModuleRightDocbodyHidef-v16 template; Now pointing directly to ModuleRightDocbodyHidefBuild-v16 -->
    <!-- NOT USED FOR 7.0 --> 	
    <xsl:template name="ModuleRightDocbodyHidefBuild-v16">
		<xsl:for-each select="following::content[1]/top-right-include">
			<xsl:call-template name="IncludeFile-v16"/>
		</xsl:for-each>
		<xsl:for-each select="following::content[1]/right-box">
			<div class="ibm-container">
				<h2>
					<xsl:value-of select="heading" />
				</h2>
				
				<!-- Create module body -->
				<xsl:choose>
					<!-- Support legacy code (bullets only) -->
					<xsl:when test="right-box-section/page-section-link">
						<div class="ibm-container-body dw-right-bullet-list">
							<ul class="ibm-bullet-list">	
								<!-- Process list contents -->
								<xsl:for-each select="right-box-section/page-section-link">
									<xsl:if test="normalize-space(text) and normalize-space(url)">
										<li>
											<a class="ibm-feature-link" href="{url}">
												<xsl:value-of select="text"/>
											</a>
										</li>
									</xsl:if>
								</xsl:for-each>	 
							</ul>  
						</div>
					</xsl:when>
					<xsl:when test="right-box-section/right-link-list">
						<xsl:choose>
							<xsl:when test="count(right-box-section/right-link-list/right-link-list-item) &lt; 7">
								<xsl:call-template name="ModuleRightLinkList-v16"/>
							</xsl:when>
							<!-- Per ibm.com standard, if right column box has more than six links, use bullets -->
							<xsl:otherwise>
								<div class="ibm-container-body dw-right-bullet-list">
									<ul class="ibm-bullet-list">	
										<!-- Process list contents -->
										<xsl:for-each select="right-box-section/right-link-list/right-link-list-item">
											<xsl:if test="normalize-space(text) and normalize-space(url)">
												<li>
													<a class="ibm-feature-link" href="{url}">
														<xsl:value-of select="text"/>
													</a>
												</li>
											</xsl:if>
										</xsl:for-each>	 
									</ul>  
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</div>
		</xsl:for-each>
		<xsl:for-each select="following::content[1]/bottom-right-include">
			<xsl:call-template name="IncludeFile-v16"/>
		</xsl:for-each>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process right-box links (bullets, arrows, and icons) -->
    <xsl:template name="ModuleRightLinkList-v16">
		<xsl:for-each select="right-box-section/right-link-list">
			<!-- Process right link list content -->
			<xsl:choose>
				<!-- Arrow lists -->
				<xsl:when test="@style='arrow'">
					<div class="ibm-container-body">
						<xsl:element name="ul">
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@horizontal-rules='yes'">
										<xsl:text>ibm-link-list</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>ibm-link-list ibm-alternate</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:for-each select="right-link-list-item">
								<xsl:element name="li">
									<xsl:if test="(../@horizontal-rules='yes') and position()=1">
										<xsl:attribute name="class">ibm-first</xsl:attribute>
									</xsl:if>	
									<xsl:element name="a">
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="@link-style = 'emphasized'">
													<xsl:text>ibm-forward-em-link</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>ibm-forward-link</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:attribute name="href">
											<xsl:value-of select="url"/>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</div>
				</xsl:when>
				<!-- First arrow bolded lists -->
				<xsl:when test="@style='first-arrow-bolded'">
					<div class="ibm-container-body">
						<xsl:element name="ul">
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@horizontal-rules='yes'">
										<xsl:text>ibm-link-list</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>ibm-link-list ibm-alternate</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:for-each select="right-link-list-item">
								<xsl:element name="li">
									<xsl:if test="(../@horizontal-rules='yes') and position()=1">
										<xsl:attribute name="class">ibm-first</xsl:attribute>
									</xsl:if>	
									<xsl:element name="a">
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="(../@style = 'first-arrow-bolded') and position()=1">
													<xsl:text>ibm-forward-em-link</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>ibm-forward-link</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:attribute name="href">
											<xsl:value-of select="url"/>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</div>
				</xsl:when>		
				<!-- Icon/Arrow combination lists -->
				<xsl:when test="@style='icon-arrow-combination'">
					<div class="ibm-container-body">
						<xsl:element name="ul">
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@horizontal-rules='yes'">
										<xsl:text>ibm-link-list</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>ibm-link-list ibm-alternate</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:for-each select="right-link-list-item">
								<xsl:element name="li">
									<xsl:if test="(../@horizontal-rules='yes') and position()=1">
										<xsl:attribute name="class">ibm-first</xsl:attribute>
									</xsl:if>
									<xsl:choose>
										<!-- If link style is unemphasized, output a normal arrow and normal text -->
										<xsl:when test="@link-style = 'unemphasized'">
											<a>
												<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
												<xsl:attribute name="href">
													<xsl:value-of select="url"/>
												</xsl:attribute>
												<xsl:value-of select="text"/>
											</a>
										</xsl:when>
										<!-- If link style is emphasized, output a bold arrow and bolded text -->
										<xsl:when test="@link-style = 'emphasized'">
											<a>
												<xsl:attribute name="class">ibm-forward-em-link</xsl:attribute>
												<xsl:attribute name="href">
													<xsl:value-of select="url"/>
												</xsl:attribute>
												<strong><xsl:value-of select="text"/></strong>
											</a>
										</xsl:when>
										<!-- If link style is NOT specified, output a normal arrow with normal text -->
										<xsl:when test="not(normalize-space(@link-style))">
											<a>
												<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
												<xsl:attribute name="href">
													<xsl:value-of select="url"/>
												</xsl:attribute>
												<xsl:value-of select="text"/>
											</a>
										</xsl:when>
										<!-- Otherwise, assume link style references an icon and output icon with normal text -->
										<xsl:otherwise>
											<a>
												<xsl:attribute name="class">
													<xsl:call-template name="ForwardLinkIcon">
														<xsl:with-param name="style" select="@link-style"/>
													</xsl:call-template>
												</xsl:attribute>
												<xsl:attribute name="href">
													<xsl:value-of select="url"/>
												</xsl:attribute>
												<xsl:value-of select="text"/>
											</a>
										</xsl:otherwise>
									</xsl:choose>									
								</xsl:element>
							</xsl:for-each>							
						</xsl:element>
					</div>
				</xsl:when>				
				<!-- Bulleted lists -->
				<xsl:otherwise>
					<div class="ibm-container-body dw-right-bullet-list">
						<ul class="ibm-bullet-list">
							<xsl:for-each select="right-link-list-item"> 
								<li>
									<a class="ibm-feature-link" href="{url}">
										<xsl:choose>
											<xsl:when test="@link-style = 'emphasized'">
												<strong><xsl:value-of select="text"/></strong>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="text"/>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:for-each>	
						</ul>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
    </xsl:template>    
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to determine date on simple show hide module -->
    <xsl:template name="ModuleShowHideDate-v16">
		<xsl:choose>
			<xsl:when test="//@local-site='worldwide'">
				<xsl:choose>
					<!-- When the module has date-update-module -->
					<xsl:when test="date-updated-module">
						<xsl:variable name="monthname">
							<xsl:call-template name="MonthName">
								<xsl:with-param name="month">
									<xsl:value-of select="date-updated-module/@month"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="date-updated-module/@day">
						<xsl:value-of select="date-updated-module/@day"/>
						<xsl:text>  </xsl:text>
						</xsl:if>
						<xsl:value-of select="$monthname"/>
						<xsl:text>  </xsl:text>
						<xsl:value-of select="date-updated-module/@year"/>
					</xsl:when>
					<!-- When the content has date updated  -->
					<xsl:when test="//date-updated">
						<xsl:variable name="monthname">
							<xsl:call-template name="MonthName">
								<xsl:with-param name="month">
									<xsl:value-of select="//date-updated/@month"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="//date-updated/@day">
						<xsl:value-of select="//date-updated/@day"/>
						<xsl:text>  </xsl:text>
						</xsl:if>
						<xsl:value-of select="$monthname"/>
						<xsl:text disable-output-escaping="no">  </xsl:text>
						<xsl:value-of select="//date-updated/@year"/>
					</xsl:when>
					<!-- when the content only has a publish date -->
					<xsl:otherwise>
						<xsl:variable name="monthname">
							<xsl:call-template name="MonthName">
								<xsl:with-param name="month">
									<xsl:value-of select="//date-published/@month"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="//date-published/@day">
						<xsl:value-of select="//date-published/@day"/>
						<xsl:text>  </xsl:text>
						</xsl:if>
						<xsl:value-of select="$monthname"/>
						<xsl:text disable-output-escaping="no">  </xsl:text>
						<xsl:value-of select="//date-published/@year"/>
					</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
		  <xsl:when test="//@local-site='japan' or //@local-site='china' or //@local-site='korea'">
		    <xsl:choose>
		      <!-- When the module has date-update-module -->
		      <xsl:when test="date-updated-module">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="date-updated-module/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:value-of select="date-updated-module/@year"/><xsl:copy-of select="$yearchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
		        <xsl:if test="date-updated-module/@day">
		          <xsl:text disable-output-escaping="no"> </xsl:text>
		          <xsl:value-of select="date-updated-module/@day"/><xsl:copy-of select="$daychar"/>
		        </xsl:if>
		      </xsl:when>
		      <!-- When the content has date updated  -->
		      <xsl:when test="//date-updated">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-updated/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
		        <xsl:if test="//date-updated/@day">
		          <xsl:text disable-output-escaping="no"> </xsl:text>
		          <xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
		        </xsl:if>
		      </xsl:when>
		      <!-- when the content only has a publish date -->
		      <xsl:otherwise>
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-published/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:value-of select="//date-published/@year"/><xsl:copy-of select="$yearchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
		        <xsl:if test="//date-published/@day">
		          <xsl:text disable-output-escaping="no"> </xsl:text>
		          <xsl:value-of select="//date-published/@day"/><xsl:copy-of select="$daychar"/>
		        </xsl:if>
		      </xsl:otherwise>
		    </xsl:choose>			
		  </xsl:when>
		  <xsl:when test="//@local-site='vietnam'">
		    <xsl:choose>
		      <!-- When the module has date-update-module -->
		      <xsl:when test="date-updated-module">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="date-updated-module/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="date-updated-module/@day">
		          <xsl:value-of select="date-updated-module/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text> </xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="date-updated-module/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:when>
		      <!-- When the content has date updated  -->
		      <xsl:when test="//date-updated">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-updated/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:if test="//date-updated/@day">
		          <xsl:value-of select="//date-updated/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text> </xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="//date-updated/@year"/>
		        <xsl:copy-of select="$yearchar"/>
			      </xsl:when>
		      <!-- when the content only has a publish date -->
		      <xsl:otherwise>
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-published/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:if test="//date-published/@day">
		          <xsl:value-of select="//date-published/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text> </xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:value-of select="//date-published/@year"/>
		        <xsl:copy-of select="$yearchar"/>
			      </xsl:otherwise>
		    </xsl:choose>			
		  </xsl:when>
		  <xsl:when test="//@local-site='russia'">
		    <xsl:choose>
		      <!-- When the module has date-update-module -->
		      <xsl:when test="date-updated-module">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="date-updated-module/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:if test="date-updated-module/@day">
		          <xsl:value-of select="date-updated-module/@day"/>
		          <xsl:text>.</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:text disable-output-escaping="no">.</xsl:text>
		        <xsl:value-of select="date-updated-module/@year"/>
		      </xsl:when>
		      <!-- When the content has date updated  -->
		      <xsl:when test="//date-updated">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-updated/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:if test="//date-updated/@day">
		          <xsl:value-of select="//date-updated/@day"/>
		          <xsl:text>.</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:text disable-output-escaping="no">.</xsl:text>
		        <xsl:value-of select="//date-updated/@year"/>
		      </xsl:when>
		      <!-- when the content only has a publish date -->
		      <xsl:otherwise>
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-published/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:if test="//date-published/@day">
		          <xsl:value-of select="//date-published/@day"/>
		          <xsl:text>.</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:text disable-output-escaping="no">.</xsl:text>
		        <xsl:value-of select="//date-published/@year"/>
		      </xsl:otherwise>
		    </xsl:choose>			
		  </xsl:when>
		  <xsl:when test="//@local-site='ssa'">
		    <xsl:choose>
		      <!-- When the module has date-update-module -->
		      <xsl:when test="date-updated-module">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="date-updated-module/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="date-updated-module/@day">
		          <xsl:value-of select="date-updated-module/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>-</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">-</xsl:text>
		        <xsl:value-of select="date-updated-module/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:when>
		      <!-- When the content has date updated  -->
		      <xsl:when test="//date-updated">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-updated/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="//date-updated/@day">
		          <xsl:value-of select="//date-updated/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>-</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">-</xsl:text>
		        <xsl:value-of select="//date-updated/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:when>
		      <!-- when the content only has a publish date -->
		      <xsl:otherwise>
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-published/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="//date-published/@day">
		          <xsl:value-of select="//date-published/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>-</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">-</xsl:text>
		        <xsl:value-of select="//date-published/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:otherwise>
		    </xsl:choose>			
		  </xsl:when>	
		  <!-- Leah -->
		  <xsl:when test="//@local-site='brazil'">
		    <xsl:choose>
		      <!-- When the module has date-update-module -->
		      <xsl:when test="date-updated-module">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="date-updated-module/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="date-updated-module/@day">
		          <xsl:value-of select="date-updated-module/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>/</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">/</xsl:text>
		        <xsl:value-of select="date-updated-module/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:when>
		      <!-- When the content has date updated  -->
		      <xsl:when test="//date-updated">
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-updated/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="//date-updated/@day">
		          <xsl:value-of select="//date-updated/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>/</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">/</xsl:text>
		        <xsl:value-of select="//date-updated/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:when>
		      <!-- when the content only has a publish date -->
		      <xsl:otherwise>
		        <xsl:variable name="monthname">
		          <xsl:call-template name="MonthName">
		            <xsl:with-param name="month">
		              <xsl:value-of select="//date-published/@month"/>
		            </xsl:with-param>
		          </xsl:call-template>
		        </xsl:variable>
		        <xsl:text disable-output-escaping="no"> </xsl:text>
		        <xsl:if test="//date-published/@day">
		          <xsl:value-of select="//date-published/@day"/>
		          <xsl:copy-of select="$daychar"/>
		          <xsl:text>/</xsl:text>
		        </xsl:if>
		        <xsl:value-of select="$monthname"/>
		        <xsl:copy-of select="$monthchar"/>
		        <xsl:text disable-output-escaping="no">/</xsl:text>
		        <xsl:value-of select="//date-published/@year"/>
		        <xsl:copy-of select="$yearchar"/>
		      </xsl:otherwise>
		    </xsl:choose>			
		  </xsl:when>		  		  
		</xsl:choose>    
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    <!-- Template to process body content for container single module -->
	<xsl:template name="ModuleSingleContainerBody-v16">
		<xsl:choose>
		    <!-- When multiple columns -->
			<xsl:when test="count(container-column) > 1">			
				<!-- Select container column frame -->
				<xsl:if test="count(container-column) = 2">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body ibm-two-column">]]></xsl:text>
				</xsl:if>
				<xsl:if test="count(container-column) = 3">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body ibm-three-column">]]></xsl:text>
				</xsl:if>
				<!-- Process container link block, unless it's at the bottom of the module -->
				<xsl:if test="(container-link-block) and not(container-link-block/@position='bottom')">
					<xsl:choose>
						<xsl:when test="container-link-block/form">
							<xsl:call-template name="ModuleContainerLinkBlockForm-v16"/>
							<xsl:if test="container-column">
								<div class="ibm-rule"><hr /></div>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
							<xsl:if test="container-column">
								<div class="ibm-rule"><hr /></div>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>				
				<!-- Process each container column -->
				<xsl:for-each select="container-column">
					<xsl:choose>
						<xsl:when test="position() = 1">
						    <!-- If any column contains a heading, use ibm-list-container class on all columns for extra padding -->
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-first">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-first">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
						<xsl:when test="position() = 2">
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-second">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-second">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
						<xsl:when test="position() = 3">
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-third">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-third">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>				
				<!-- Process container link block if it's at the bottom of the module -->
				<xsl:if test="(container-link-block) and (container-link-block/@position='bottom')">								
					<!-- If container link block contains a form, create it; otherwise process container link block normally -->
					<xsl:choose>
						<xsl:when test="container-link-block/form">
							<xsl:if test="container-column">
								<div class="ibm-rule"><hr /></div>
							</xsl:if>
							<xsl:call-template name="ModuleContainerLinkBlockForm-v16"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="container-column">
								<div class="ibm-rule"><hr /></div>
							</xsl:if>
							<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- Process container forward link -->
				<xsl:call-template name="ModuleContainerForwardLink-v16"/>
				<!-- Close div -->
				<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
			</xsl:when>
		    <!-- When one or no columns -->
			<xsl:otherwise>
				<div class="ibm-container-body">
					<!-- Process container link block, unless it's at the bottom of the module -->
					<xsl:if test="(container-link-block) and not(container-link-block/@position='bottom')">
						<!--If container link block contains a form, create it; otherwise process container link block normally -->
						<xsl:choose>
							<xsl:when test="container-link-block/form">
								<xsl:call-template name="ModuleContainerLinkBlockForm-v16"/>
								<!-- If container link block is followed by a container column, then add a separator -->
								<xsl:if test="container-column">
									<div class="ibm-rule"><hr /></div>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
								<!-- If container link block is followed by a container column, then add a separator -->
								<xsl:if test="container-column">
									<div class="ibm-rule"><hr /></div>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!-- Process container column -->
					<xsl:if test="container-column">
						<xsl:call-template name="ModuleContainerColumn-v16"/>
					</xsl:if>
					<!-- Process container link block if it's at the bottom of the module -->
					<xsl:if test="(container-link-block) and (container-link-block/@position='bottom')">
						<!-- If container link block contains a form, create it; otherwise process container link block normally -->
						<xsl:choose>
							<xsl:when test="container-link-block/form">
								<xsl:if test="container-column">
									<div class="ibm-rule"><hr /></div>
								</xsl:if>
								<xsl:call-template name="ModuleContainerLinkBlockForm-v16"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="container-column">
									<div class="ibm-rule"><hr /></div>
								</xsl:if>
								<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>					
					<!-- Process container forward link -->
					<xsl:call-template name="ModuleContainerForwardLink-v16"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
    	<xsl:template name="ModuleSingleContainerBodyHidef-v16">
			<xsl:choose>
			    <!-- Process module with a single container -->
				<xsl:when test="container-single">
					<xsl:for-each select="container-single">
						<!-- Create module frame and body -->
						<xsl:choose>
						    <!-- When module does not have a container column -->
							<xsl:when test="not(container-column)">
								<xsl:choose>
									<!-- Case: module has heading -->
									<xsl:when test="normalize-space(container-heading)">
										<div class="ibm-container ibm-portrait-module">
											<xsl:call-template name="ModuleHeading-v16"/>
											<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:when>
									<!-- Case: module has container-level image and forward link but no heading -->
									<xsl:when test="not(normalize-space(container-heading)) and normalize-space(container-link-block/link-block-image-url) and (container-forward-link)">
										<div class="ibm-container ibm-portrait-module ibm-alternate-two ibm-alternate-six">
											<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:when>
									<!-- Case: module has no heading and no forward link -->
									<xsl:otherwise>
										<div class="ibm-container ibm-portrait-module ibm-alternate-two">
											<xsl:call-template name="ModuleSingleContainerBody-v16"/>
										</div>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<!-- When module has a container column -->
							<xsl:when test="(container-column)">
								<div class="ibm-container">
									<xsl:if test="normalize-space(container-heading)">
										<xsl:call-template name="ModuleHeading-v16"/>
									</xsl:if>
									<xsl:call-template name="ModuleSingleContainerBody-v16"/>
								</div>
							</xsl:when>							
						</xsl:choose>
					</xsl:for-each>
                </xsl:when>
				<xsl:when test="container-single-show-hide">
				<xsl:for-each select="container-single-show-hide">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container ibm-simple-show-hide">]]></xsl:text>
						<xsl:call-template name="ModuleHeading-v16"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body">]]></xsl:text>
							<xsl:choose>
								<xsl:when test="@show-date='no'">
										<p class="ibm-show-hide-controls"><a href="#show"><xsl:value-of select="$show-descriptions-text"/></a> | <a class="ibm-active" href="#hide"><xsl:value-of select="$hide-descriptions-text"/></a></p>
								</xsl:when>							
								<xsl:otherwise>									
									<xsl:if test="@show-date='yes'">
										<p class="ibm-show-hide-controls"><strong>
										<xsl:call-template name="ModuleShowHideDate-v16" /> 
										</strong>									
										<!-- Spacer for date -->
										<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text><a href="#show"><xsl:value-of select="$show-descriptions-text"/></a> | <a class="ibm-active" href="#hide"><xsl:value-of select="$hide-descriptions-text"/></a></p> 
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>						
							<!-- Process bulleted list -->
							<ul class="ibm-bullet-list">
								<xsl:for-each select="link-list/link-list-item"> 
									<li>	
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
										<strong><xsl:value-of select="text"/></strong>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
										<div class="ibm-hideable dw-show-hide-spacer">
											<p><xsl:value-of select="abstract-text" /></p>
										</div>						
									</li>
								</xsl:for-each>	
							</ul>
							<!-- Check for more-featured-content --> 					
							<xsl:if test="normalize-space(more-featured-content)">
								<div class="ibm-rule"><hr /></div>
									<div class="ibm-three-column">										
										<div class="ibm-column ibm-first">
											<p class="ibm-ind-link"><a class="ibm-forward-link" href="{more-featured-content/url}">
											<xsl:value-of select="more-featured-content/text" /></a>
											</p>								
										</div>
										<div class="ibm-column ibm-second">
											<xsl:choose>
												<xsl:when test="normalize-space(rss-link)">
													<p class="ibm-ind-link"><a class="ibm-rss-link" href="{rss-link/url}">
													<xsl:value-of select="rss-link/text" /></a>
													</p>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
												</xsl:otherwise>
											</xsl:choose>	
										</div>
										<!-- no gizmos so insert a blank in the third column, leaving the third column in case there is a gizmo -->
										<div class="ibm-column ibm-third dw-tab-third-column">
											<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
										</div>										
									</div>
								</xsl:if>		
						<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
				</xsl:for-each>
				</xsl:when>
				<xsl:when test="container-single-show-hide-multipanel">	
					<!-- Create overall div for a show hide multipanel module -->
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container ibm-show-hide">]]></xsl:text>
							<xsl:for-each select="container-single-show-hide-multipanel/show-hide-panel">
								<!-- Create show hide panel heading -->
								<xsl:choose>
									<xsl:when test="position() = 1">
										<h2><a><xsl:value-of select="panel-heading" /></a></h2>
									</xsl:when> 									
									<xsl:otherwise>
										<h2><a class="ibm-show-hide-link" href="#"><xsl:value-of select="panel-heading" /></a></h2>					
									</xsl:otherwise>
								</xsl:choose>
								<xsl:call-template name="ModuleSingleContainerBody-v16" />
							</xsl:for-each>
					<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
				</xsl:when>	
			</xsl:choose>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->    
    <!-- Template to process body of standard module tab -->
	<xsl:template name="ModuleTabContainerBody-v16">
		<xsl:choose>
		    <!-- When multiple columns -->
			<xsl:when test="count(module-tab-container/container-column) > 1">
				<!-- Select container column frame -->
				<xsl:if test="count(module-tab-container/container-column) = 2">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-two-column">]]></xsl:text>
				</xsl:if>
				<xsl:if test="count(module-tab-container/container-column) = 3">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-three-column">]]></xsl:text>
				</xsl:if>		
				<!-- Process each container column -->
				<xsl:for-each select="module-tab-container/container-column">
					<xsl:choose>
						<xsl:when test="position() = 1">
						    <!-- If any column contains a heading, use ibm-list-container class on all columns for extra padding -->
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-first">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-first">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
						<xsl:when test="position() = 2">
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-second">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-second">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
						<xsl:when test="position() = 3">
							<xsl:choose>
								<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-list-container ibm-third dw-tab-third-column">]]></xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-third dw-tab-third-column">]]></xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
							<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>				
				<!-- Process container link block if it's at the bottom of the module -->
				<xsl:if test="(module-tab-container/container-link-block) and (module-tab-container/container-link-block/@position='bottom')">
					<xsl:for-each select="module-tab-container">
						<div class="ibm-rule"><hr /></div>
						<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
					</xsl:for-each>	
				</xsl:if>
				<!-- Process container forward link for tab -->
				<xsl:for-each select="module-tab-container">
					<xsl:if test="container-forward-link">
						<div class="ibm-rule"><hr /></div>
						<p class="ibm-ind-link">
							<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
								<xsl:value-of select="container-forward-link/url"  />	
									<xsl:choose>
										<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
											<xsl:choose>
												<xsl:when test="container-forward-link/@tactic='yes'">		
													<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
										</xsl:otherwise>	
									</xsl:choose>
								<xsl:value-of select="container-forward-link/text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
							<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
						</p>
					</xsl:if>
				</xsl:for-each>
				<!-- Close div -->
				<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
			</xsl:when>
		    <!-- When one column -->
			<xsl:otherwise>
				
					<!-- Process container column -->
					<xsl:for-each select="module-tab-container">
						<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-list-container">]]></xsl:text>
							<xsl:call-template name="ModuleContainerColumn-v16"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
					</xsl:for-each>
					<!-- Process container link block if it's at the bottom of the module -->
					<xsl:if test="(module-tab-container/container-link-block) and (module-tab-container/container-link-block/@position='bottom')">
						<div class="ibm-rule"><hr /></div>
						<xsl:call-template name="ModuleContainerLinkBlock-v16"/>	
					</xsl:if>
					<!-- Process container forward link for tab -->
					<xsl:for-each select="module-tab-container">
						<xsl:if test="container-forward-link">
							<div class="ibm-rule"><hr /></div>
							<p class="ibm-ind-link">
									<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
										<xsl:value-of select="container-forward-link/url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="container-forward-link/@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
									<xsl:value-of select="container-forward-link/text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
								<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>

							</p>
						</xsl:if>
					</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
<xsl:choose>
		<xsl:when test="position() = 1">
		<xsl:choose>
		<xsl:when test="(/dw-document//rss-link/url !='') and (/dw-document//@local-site!='worldwide')" >
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first">			
					  <xsl:choose>
					    <xsl:when test="(/dw-document//more-featured-content/url !='')">					    
					  	 <p class="ibm-ind-link"><a class="ibm-forward-link" href="{/dw-document//more-featured-content/url}"><xsl:value-of select="/dw-document//more-featured-content/text"/></a></p>
					    </xsl:when>
					    <xsl:otherwise>&nbsp;</xsl:otherwise>
					  </xsl:choose>
</div>
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-third dw-tab-third-column"><p align="right" class="ibm-ind-link"><a href="{/dw-document//rss-link/url}"><img alt="RSS feed" src="//www.ibm.com/i/v16/icons/rss.gif"/></a></p>
					</div>
					</div>
				</xsl:when>
				<xsl:otherwise />
	</xsl:choose>
	</xsl:when>
	<xsl:otherwise/>
	</xsl:choose>	
    </xsl:template>   
    <!-- NOT USED FOR 7.0 --> 
    <!-- Template to process custom module tab -->
	<xsl:template name="ModuleTabCustom-v16">
		<xsl:choose>
			<!-- Using JQuery ajax mode, call custom tab content for Most Popular forums tab on dW worldwide home page -->
			<xsl:when test="@custom-tab-name='s-dwhome-popular-forums'">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text disable-output-escaping="yes"><![CDATA[<li class="ibm-last-tab"><a href="]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes"><![CDATA[<li><a href="]]></xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$ajax-dwhome-popular-forums" />
				<xsl:text disable-output-escaping="yes"><![CDATA[" title="tab]]></xsl:text>	
				<xsl:choose>
					<xsl:when test="position() = last()">				
							<xsl:value-of select="last()" />
					</xsl:when>
					<xsl:otherwise>
							<xsl:value-of select="position()" />
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
				<xsl:value-of select="module-tab-name" />
				<xsl:text disable-output-escaping="yes"><![CDATA[</a></li>]]></xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <!-- Template to process body of module tab with show/hide feature -->
    <xsl:template name="ModuleTabShowHide-v16">
		<xsl:for-each select="module-tab-show-hide">
			<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-simple-show-hide dw-tab-simple-show-hide">]]></xsl:text>
			<p class="ibm-show-hide-controls">
			<!-- Display content date for worldwide pages -->
			<xsl:choose>
				<!-- dW landing generic; do not display date -->
				<xsl:when test="//dw-landing-generic"/>
				<xsl:when test="//dw-landing-product">
					<xsl:choose>
						<xsl:when test="not(@show-date='no')"> 
							<strong><xsl:call-template name="ModuleShowHideDate-v16" /></strong>									
							<!-- Spacer for date -->
							<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text></xsl:when>
						<xsl:otherwise />
					</xsl:choose> 
				</xsl:when>
				<!-- dW home page -->
				<xsl:when test="(//dw-dwtop-home/@local-site='worldwide' or //dw-dwtop-home-hidef/@local-site='worldwide') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-updated/@day">
						<xsl:value-of select="//date-updated/@day"/>
						<xsl:text> </xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">  </xsl:text>
					<xsl:value-of select="//date-updated/@year"/>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
				<xsl:when test="(//dw-dwtop-home/@local-site='china' or //dw-dwtop-home-hidef/@local-site='china') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-updated/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
				<xsl:when test="(//dw-dwtop-home/@local-site='russia' or //dw-dwtop-home-hidef/@local-site='russia') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-updated/@day">
						<xsl:value-of select="//date-updated/@day"/>
						<xsl:text>.</xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">.</xsl:text>
					<xsl:value-of select="//date-updated/@year"/>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
			  <xsl:when test="(//dw-dwtop-home/@local-site='korea' or //dw-dwtop-home-hidef/@local-site='korea') and (//date-updated)">
			    <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-updated/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
			      <xsl:if test="//date-updated/@day">
			        <xsl:text disable-output-escaping="no"> </xsl:text>
			        <xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
			      </xsl:if>
			    </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>	
				<xsl:when test="(//dw-dwtop-home/@local-site='japan' or //dw-dwtop-home-hidef/@local-site='japan') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-updated/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
			  <!-- added code to show date updated on microsites top pages -->			 
			  <xsl:when test="(//dw-dwtop-home/@local-site='vietnam' or //dw-dwtop-home-hidef/@local-site='vietnam') and (//date-updated)">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-updated/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-updated/@day">
			      <xsl:value-of select="//date-updated/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text> </xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:value-of select="//date-updated/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			      </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="(//dw-dwtop-home/@local-site='ssa' or //dw-dwtop-home-hidef/@local-site='ssa') and (//date-updated)">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-updated/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-updated/@day">
			      <xsl:value-of select="//date-updated/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text>-</xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no">-</xsl:text>
			    <xsl:value-of select="//date-updated/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			    </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="(//dw-dwtop-home/@local-site='brazil' or //dw-dwtop-home-hidef/@local-site='brazil') and (//date-updated)">
			  <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-updated/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:if test="//date-updated/@day">
			        <xsl:value-of select="//date-updated/@day"/>
			        <xsl:copy-of select="$daychar"/>
			        <xsl:text>/</xsl:text>
			      </xsl:if>
			      <xsl:value-of select="$monthname"/>
			      <xsl:copy-of select="$monthchar"/>
			      <xsl:text disable-output-escaping="no">/</xsl:text>
			      <xsl:value-of select="//date-updated/@year"/>
			      <xsl:copy-of select="$yearchar"/>
			    </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
				<!-- dW zone overview pages -->
				<xsl:when test="(//dw-dwtop-zoneoverview/@local-site='worldwide') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-updated/@day">
						<xsl:value-of select="//date-updated/@day"/>
						<xsl:text> </xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">  </xsl:text>
					<xsl:value-of select="//date-updated/@year"/>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
				<xsl:when test="(//dw-dwtop-zoneoverview/@local-site='russia') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-updated/@day">
						<xsl:value-of select="//date-updated/@day"/>
						<xsl:text>.</xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">.</xsl:text>
					<xsl:value-of select="//date-updated/@year"/>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
				<xsl:when test="(//dw-dwtop-zoneoverview/@local-site='china') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-updated/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
			  <xsl:when test="(//dw-dwtop-zoneoverview/@local-site='korea') and (//date-updated)">
			    <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-updated/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
			      <xsl:if test="//date-updated/@day">
			        <xsl:text disable-output-escaping="no"> </xsl:text>
			        <xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
			      </xsl:if>
			    </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
				<xsl:when test="(//dw-dwtop-zoneoverview/@local-site='japan') and (//date-updated)">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-updated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-updated/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-updated/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-updated/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					</strong>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
				</xsl:when>
			  <xsl:when test="(//dw-dwtop-zoneoverview/@local-site='vietnam') and (//date-updated)">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-updated/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-updated/@day">
			      <xsl:value-of select="//date-updated/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text> </xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:value-of select="//date-updated/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			      </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="(//dw-dwtop-zoneoverview/@local-site='ssa') and (//date-updated)">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-updated/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-updated/@day">
			      <xsl:value-of select="//date-updated/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text>-</xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no">-</xsl:text>
			    <xsl:value-of select="//date-updated/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			      </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="(//dw-dwtop-zoneoverview/@local-site='brazil') and (//date-updated)">
			    <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-updated/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:if test="//date-updated/@day">
			        <xsl:value-of select="//date-updated/@day"/>
			        <xsl:copy-of select="$daychar"/>
			        <xsl:text>/</xsl:text>
			      </xsl:if>
			      <xsl:value-of select="$monthname"/>
			      <xsl:copy-of select="$monthchar"/>
			      <xsl:text disable-output-escaping="no">/</xsl:text>
			      <xsl:value-of select="//date-updated/@year"/>
			      <xsl:copy-of select="$yearchar"/>
			      <!-- Spacer for date -->
			      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			    </strong>
			  </xsl:when>
				<xsl:when test="/dw-document//@local-site='worldwide'">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-published/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-published/@day">
						<xsl:value-of select="//date-published/@day"/>
						<xsl:text> </xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">  </xsl:text>
					<xsl:value-of select="//date-published/@year"/>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
					</strong>
				</xsl:when>
				<xsl:when test="/dw-document//@local-site='russia'">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-published/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="//date-published/@day">
						<xsl:value-of select="//date-published/@day"/>
						<xsl:text>.</xsl:text>
				    </xsl:if>
				    <xsl:value-of select="$monthname"/>
					<xsl:text disable-output-escaping="no">.</xsl:text>
					<xsl:value-of select="//date-published/@year"/><xsl:copy-of select="$yearchar"/>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
					</strong>
				</xsl:when>
					<xsl:when test="/dw-document//@local-site='china'">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-published/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-published/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-published/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-published/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					<!-- Spacer for date -->
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
					</strong>
					</xsl:when>
			  <xsl:when test="/dw-document//@local-site='korea'">
			    <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-published/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:value-of select="//date-published/@year"/><xsl:copy-of select="$yearchar"/>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
			      <xsl:if test="//date-published/@day">
			        <xsl:text disable-output-escaping="no"> </xsl:text>
			        <xsl:value-of select="//date-published/@day"/><xsl:copy-of select="$daychar"/>
			      </xsl:if>
			      <!-- Spacer for date -->
			      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			    </strong>
			  </xsl:when>
					<xsl:when test="/dw-document//@local-site='japan'">
					<strong>
					<xsl:variable name="monthname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-published/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="//date-published/@year"/><xsl:copy-of select="$yearchar"/>
					<xsl:text disable-output-escaping="no"> </xsl:text>
				    <xsl:value-of select="$monthname"/><xsl:copy-of select="$monthchar"/>
					<xsl:if test="//date-published/@day">
					<xsl:text disable-output-escaping="no"> </xsl:text>
						<xsl:value-of select="//date-published/@day"/><xsl:copy-of select="$daychar"/>
				    </xsl:if>
					<!-- Spacer for date -->
					</strong>
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
					</xsl:when>
			  <xsl:when test="/dw-document//@local-site='vietnam'">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-published/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-published/@day">
			      <xsl:value-of select="//date-published/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text> </xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:value-of select="//date-published/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			      </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="/dw-document//@local-site='ssa'">
			    <strong>
			    <xsl:variable name="monthname">
			      <xsl:call-template name="MonthName">
			        <xsl:with-param name="month">
			          <xsl:value-of select="//date-published/@month"/>
			        </xsl:with-param>
			      </xsl:call-template>
			    </xsl:variable>
			    <xsl:text disable-output-escaping="no"> </xsl:text>
			    <xsl:if test="//date-published/@day">
			      <xsl:value-of select="//date-published/@day"/>
			      <xsl:copy-of select="$daychar"/>
			      <xsl:text>-</xsl:text>
			    </xsl:if>
			    <xsl:value-of select="$monthname"/>
			    <xsl:copy-of select="$monthchar"/>
			    <xsl:text disable-output-escaping="no">-</xsl:text>
			    <xsl:value-of select="//date-published/@year"/>
			    <xsl:copy-of select="$yearchar"/>
			      </strong>
			    <!-- Spacer for date -->
			    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			  </xsl:when>
			  <xsl:when test="/dw-document//@local-site='brazil'">
			    <strong>
			      <xsl:variable name="monthname">
			        <xsl:call-template name="MonthName">
			          <xsl:with-param name="month">
			            <xsl:value-of select="//date-published/@month"/>
			          </xsl:with-param>
			        </xsl:call-template>
			      </xsl:variable>
			      <xsl:text disable-output-escaping="no"> </xsl:text>
			      <xsl:if test="//date-published/@day">
			        <xsl:value-of select="//date-published/@day"/>
			        <xsl:copy-of select="$daychar"/>
			        <xsl:text>/</xsl:text>
			      </xsl:if>
			      <xsl:value-of select="$monthname"/>
			      <xsl:copy-of select="$monthchar"/>
			      <xsl:text disable-output-escaping="no">/</xsl:text>
			      <xsl:value-of select="//date-published/@year"/>
			      <xsl:copy-of select="$yearchar"/>
			      </strong>
			      <!-- Spacer for date -->
			      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&mdash;&nbsp;]]></xsl:text>
			    
			  </xsl:when>
				<xsl:otherwise />
			</xsl:choose>
			<a href="#show"><xsl:value-of select="$show-descriptions-text"/></a> | <a class="ibm-active" href="#hide"><xsl:value-of select="$hide-descriptions-text"/></a>			
			</p>
			<!-- Process bulleted list and other features -->
			<ul class="ibm-bullet-list">
				<xsl:for-each select="link-list/link-list-item"> 
					<li>
						<!-- If this is a "Try together" highlight, preface heading -->
						<xsl:if test="normalize-space(related-text)">
						    <xsl:choose>
						        <xsl:when test="/dw-document//@local-site='china'"></xsl:when>
						        <xsl:otherwise>
							<strong><xsl:value-of select="$try-together-text"/></strong><xsl:text> - </xsl:text>
						    </xsl:otherwise>
						    </xsl:choose>
						</xsl:if>
							<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
							<xsl:value-of select="url"  />	
							<xsl:choose>
								<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
									<xsl:choose>
										<xsl:when test="@tactic='yes'">		
											<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								</xsl:otherwise>	
							</xsl:choose>
							<strong><xsl:value-of select="text"/></strong>
						<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
						<!-- If this is a "Try together" highlight, process second link -->
                        <xsl:if test="normalize-space(related-text)">
							<xsl:text disable-output-escaping="yes"> <![CDATA[&#43;]]> </xsl:text>
							<a class="ibm-feature-link" href="{related-url}">
								<strong><xsl:value-of select="related-text"/></strong>
							</a>
						</xsl:if>
						<!-- Process content area if specified -->
						<xsl:if test="normalize-space(content-area) and (content-area != 'alphaworks') and (content-area != 'dwhome')">
							<xsl:text> (</xsl:text>
							<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
								<xsl:value-of select="$developerworks-top-url"/> 
								<xsl:value-of select="content-area"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[/">]]></xsl:text>
								<xsl:call-template name="ContentAreaExtendedName">
									<xsl:with-param name="contentarea">
										<xsl:value-of select="content-area"/>
									</xsl:with-param>
								</xsl:call-template>
							<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:if test="normalize-space(content-area) and (content-area = 'alphaworks')">
							<xsl:text> (</xsl:text>
							<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
								<xsl:value-of select="$alphaworks-top-url"/> 
								<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
								<xsl:call-template name="ContentAreaExtendedName">
									<xsl:with-param name="contentarea">
										<xsl:value-of select="content-area"/>
									</xsl:with-param>
								</xsl:call-template>
							<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							<xsl:text>)</xsl:text>
						</xsl:if>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
						<!-- Process hidden abstract and abstract for accessibility -->
						<div class="ibm-hideable dw-show-hide-spacer">
							<p>
								<xsl:apply-templates select="abstract-text" />
							</p>
						</div>
					</li>
				</xsl:for-each>	
			</ul>
			<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
			<!-- Process more featured content, rss, and dw gizmos links -->
			<xsl:choose>
				<!-- Worldwide dW home -->
				<xsl:when test="//dw-dwtop-home/@local-site='worldwide' or //dw-dwtop-home-hidef/@local-site='worldwide'">
					<div class="ibm-rule"><hr /></div>
					<div class="ibm-three-column">
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-column ibm-first">			
						<p class="ibm-ind-link"><a class="ibm-forward-link" href="]]></xsl:text>
							<xsl:value-of select="$dw-global-library-url"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
							<xsl:value-of select="$dw-global-library-text"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[</a></p>
					</div>]]></xsl:text>
					<!-- <div class="ibm-column ibm-first"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div> -->
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-third dw-tab-third-column">
						<xsl:text disable-output-escaping="yes"><![CDATA[<div id="ppg" onmouseover="if (!Feeder.inited) Feeder.init('ppg',']]></xsl:text>
						<xsl:value-of select="//content-area-primary/@name"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[');Feeder.showPopup()" class="dwfwte" title="]]></xsl:text>
						<xsl:value-of select="$dw-gizmo-alt-text"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["></div>]]></xsl:text>
					<!-- Close divs -->
					</div>
					</div>
				</xsl:when>
				<xsl:when test="//dw-dwtop-home/@local-site='korea' or //dw-dwtop-home-hidef/@local-site='korea'">
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					  <div class="ibm-column ibm-third dw-tab-third-column"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					  </div>
					</div>
				</xsl:when>
				<xsl:when test="//dw-dwtop-home/@local-site='brazil' or //dw-dwtop-home/@local-site='vietnam' or //dw-dwtop-home/@local-site='ssa' or //dw-dwtop-home-hidef/@local-site='brazil' or //dw-dwtop-home-hidef/@local-site='vietnam' or //dw-dwtop-home-hidef/@local-site='ssa'">
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first">
					<xsl:choose>
					<xsl:when test="../more-featured-content/url !=''">
					<p class="ibm-ind-link"><a class="ibm-forward-link" href="{../more-featured-content/url}"><xsl:value-of select="/dw-document//more-featured-content/text"/></a></p>
					</xsl:when>
					<xsl:otherwise>
					<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					</xsl:otherwise>
					</xsl:choose>
					</div>
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-third dw-tab-third-column"><p align="right" class="ibm-ind-link"><a href="{../rss-link/url}"><img alt="RSS feed" src="//www.ibm.com/i/v16/icons/rss.gif"/></a></p>
					<!-- Close divs -->
					</div>
					</div>
				</xsl:when>
				
				<xsl:when test="(//dw-dwtop-home or //dw-dwtop-home-hidef) and (/dw-document//rss-link/url !='')" >
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					  <xsl:if test="/dw-document//@local-site='japan'">
					    <xsl:choose>
					      <xsl:when test="/dw-document//publish-schedule!=''">
					   <p><xsl:value-of select="/dw-document//publish-schedule"/></p>
					      </xsl:when>
					    <xsl:otherwise/>
					  </xsl:choose>   
					  </xsl:if>
					  </div>
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-third dw-tab-third-column"><p align="right" class="ibm-ind-link"><a href="{../rss-link/url}"><img alt="RSS feed" src="//www.ibm.com/i/v16/icons/rss.gif"/></a></p>
					<!-- Close divs -->
					</div>
					</div>
				</xsl:when>
				<!-- Worldwide Zone overview pages -->
				<xsl:when test="//dw-dwtop-zoneoverview/@local-site='worldwide'">
					<div class="ibm-rule"><hr /></div>
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first">
						<p class="ibm-ind-link"><a class="ibm-forward-link" href="{../more-featured-content/url}">
							<xsl:value-of select="../more-featured-content/text" />
						</a></p>
					</div>
					<div class="ibm-column ibm-second">
						<p class="ibm-ind-link"><a class="ibm-rss-link" href="{../rss-link/url}">
							<xsl:value-of select="../rss-link/text" />
						</a></p>
					</div>
					<div class="ibm-column ibm-third dw-tab-third-column">
						<xsl:text disable-output-escaping="yes"><![CDATA[<div id="ppg" onmouseover="if (!Feeder.inited) Feeder.init('ppg',']]></xsl:text>
						<xsl:value-of select="//content-area-primary/@name"/>
						<xsl:text disable-output-escaping="yes"><![CDATA[');Feeder.showPopup()" class="dwfwte" title="]]></xsl:text>
						<xsl:value-of select="$dw-gizmo-alt-text"/>
						<xsl:text disable-output-escaping="yes"><![CDATA["></div>]]></xsl:text>
					<!-- Close divs -->
					</div>
					</div>
				</xsl:when>
				<xsl:when test="//dw-landing-product/@local-site='worldwide'">
				<xsl:if test="normalize-space(../more-featured-content)">
					<div class="ibm-rule"><hr /></div>
					<div class="ibm-three-column">
					<div class="ibm-column ibm-first">
						<p class="ibm-ind-link"><a class="ibm-forward-link" href="{../more-featured-content/url}">
							<xsl:value-of select="../more-featured-content/text" />
						</a></p>
					</div>
					<div class="ibm-column ibm-second">
						<xsl:choose>
												<xsl:when test="normalize-space(../rss-link)">
													<p class="ibm-ind-link"><a class="ibm-rss-link" href="{../rss-link/url}">
													<xsl:value-of select="../rss-link/text" /></a>
													</p>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
												</xsl:otherwise>
											</xsl:choose>
					</div>
					<div class="ibm-column ibm-third dw-tab-third-column">
						<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
					<!-- Close divs -->
					</div>
					</div>
					</xsl:if>
				</xsl:when>
				<xsl:when test="(//dw-dwtop-zoneoverview) and (/dw-document//rss-link/url !='')" >
				  <div class="ibm-rule"><hr /></div>
					<div class="ibm-three-column">
					 <div class="ibm-column ibm-first">		
					    <xsl:choose>
					      <xsl:when test="(/dw-document//more-featured-content/url !='')">					    
					        <p class="ibm-ind-link"><a class="ibm-forward-link" href="{/dw-document//more-featured-content/url}"><xsl:value-of select="/dw-document//more-featured-content/text"/></a></p>
					      </xsl:when>
					      <xsl:otherwise>&nbsp;</xsl:otherwise>
					    </xsl:choose>
						<xsl:if test="/dw-document//@local-site='japan'">
					      <xsl:choose>
					        <xsl:when test="/dw-document//publish-schedule!=''">
					          <p><xsl:value-of select="/dw-document//publish-schedule"/></p>
					        </xsl:when>
					        <xsl:otherwise/>
					      </xsl:choose>   
					    </xsl:if>		  
</div>
					<div class="ibm-column ibm-second"><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></div>
					<div class="ibm-column ibm-third dw-tab-third-column"><p align="right" class="ibm-ind-link"><a href="{../rss-link/url}"><img alt="RSS feed" src="//www.ibm.com/i/v16/icons/rss.gif"/></a></p>
					<!-- Close divs -->
					</div>
					</div>
				</xsl:when>
			</xsl:choose>				
		</xsl:for-each>
	</xsl:template>   
  <xsl:template name="MonthName">
    <xsl:param name="month"/>
    <xsl:choose>
      <xsl:when test="not(number($month))">
        <xsl:value-of select="$month"/>
      </xsl:when>
      <xsl:when test="$month = '01' ">
        <xsl:value-of select="$month-1-text"/>
      </xsl:when>
      <xsl:when test="$month = '02' ">
        <xsl:value-of select="$month-2-text"/>
      </xsl:when>
      <xsl:when test="$month = '03' ">
        <xsl:value-of select="$month-3-text"/>
      </xsl:when>
      <xsl:when test="$month = '04' ">
        <xsl:value-of select="$month-4-text"/>
      </xsl:when>
      <xsl:when test="$month = '05' ">
        <xsl:value-of select="$month-5-text"/>
      </xsl:when>
      <xsl:when test="$month = '06' ">
        <xsl:value-of select="$month-6-text"/>
      </xsl:when>
      <xsl:when test="$month = '07' ">
        <xsl:value-of select="$month-7-text"/>
      </xsl:when>
      <xsl:when test="$month = '08' ">
        <xsl:value-of select="$month-8-text"/>
      </xsl:when>
      <xsl:when test="$month = '09' ">
        <xsl:value-of select="$month-9-text"/>
      </xsl:when>
      <xsl:when test="$month = '10' ">
        <xsl:value-of select="$month-10-text"/>
      </xsl:when>
      <xsl:when test="$month = '11' ">
        <xsl:value-of select="$month-11-text"/>
      </xsl:when>
      <xsl:when test="$month = '12' ">
        <xsl:value-of select="$month-12-text"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO -->
  <!-- v17 Enablement jpp 09/13/2011:  Added Owner-v17 template -->
  <!-- USED FOR 7.0 -->
  <xsl:template name="Owner-v17">
		<xsl:value-of select="$web-site-owner"/>
  </xsl:template>  
  <!-- PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP -->   
<!-- xM R2.2 egd 04 26 11:  Removed template PageEndBTTLink as we should no longer  be using this template to create back-to-top links -->
<!-- NOT USED FOR 7.0 -->
  <xsl:template name="PagegroupContentSpaceNavigation-v16">
		<xsl:if test="(../../@content-space-secondary-navigation = 'anchor-link-list') or (../../@content-space-secondary-navigation = 'anchor-link-list-two-column') or (../../@content-space-secondary-navigation = 'anchor-link-list-three-column')">
			<div class="ibm-container ibm-alternate-six">
				<xsl:call-template name="PagegroupContentSpaceNavigationBuild-v16"/>
			</div>
		</xsl:if>	
  </xsl:template>  
  <!-- NOT USED FOR 7.0 -->
  <!-- The call to this template is suppressed if the pagegroup page body contains only one module -->		
    <xsl:template name="PagegroupContentSpaceNavigationBuild-v16">
		<!-- When inline navigation is requested, determine number of columns in link list; future option is content link list -->
		<xsl:variable name="columns">
			<xsl:choose>
				<!-- Anchor link list (one column) -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list'">1</xsl:when>
				<!-- When two-column anchor link list is selected, ensure list has at least two items -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list-two-column'">
					<xsl:choose>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">2</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- When three-column anchor link list is selected, ensure list has at least three items; if not build two-column link list -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list-three-column'">
					<xsl:choose>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 2)">3</xsl:when>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">2</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>			
		</xsl:variable>
		<xsl:comment>ANCHOR_LINK_LIST_BEGIN</xsl:comment>
		<div class="ibm-tab-section ibm-text">
		<h2 class="ibm-access">Page navigation</h2>
			<div>
				<xsl:choose>
					<xsl:when test="$columns = 3">
						<xsl:attribute name="class">ibm-tabs ibm-three-column</xsl:attribute>
					</xsl:when>
					<xsl:when test="$columns = 2">
						<xsl:attribute name="class">ibm-tabs ibm-two-column</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-tabs</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Build first column -->
				<div class="ibm-column ibm-first">
					<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
						<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
						<xsl:with-param name="column-active">1</xsl:with-param>
					</xsl:call-template>			
				</div>
				<!-- Build second column -->
				<xsl:if test="$columns > 1">
					<div class="ibm-column ibm-second">
						<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
							<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
							<xsl:with-param name="column-active">2</xsl:with-param>
						</xsl:call-template>
					</div>					
				</xsl:if>
				<!-- Build third column -->
				<xsl:if test="$columns > 2">
					<div class="ibm-column ibm-third">
						<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
							<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
							<xsl:with-param name="column-active">3</xsl:with-param>
						</xsl:call-template>
					</div>					
				</xsl:if>
			</div>
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
					<!-- Check for page abstract and create rule if needed -->
					<xsl:if test="normalize-space(following::content[1]/abstract-extended)">
						<div class="ibm-rule"><hr /></div>
					</xsl:if>
				</xsl:when>
				<xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
					<div class="ibm-rule"><hr /></div>
				</xsl:when>
			</xsl:choose>
			</div>
			<!-- Check for page abstract and insert if available -->
			<xsl:if test="normalize-space(following::content[1]/abstract-extended)">
				<div class="ibm-container-body">				
					<xsl:apply-templates select="following::content[1]/abstract-extended"/>
				</div>
			</xsl:if>
			<!-- Do not include empty div when there is a selected-tab-container -->
			<xsl:if test="not(normalize-space(following::content[1]/abstract-extended)) and not(normalize-space(following::content[1]/selected-tab-container))">
				<div class="ibm-container-body">				
					<xsl:comment>Empty</xsl:comment>
				</div>
			</xsl:if>
		<xsl:comment>ANCHOR_LINK_LIST_END</xsl:comment>		
    </xsl:template>    
	<!-- NOT USED FOR 7.0 -->    
	<xsl:template name="PagegroupContentSpaceNavigationLinkList-v16">    
    	<xsl:param name="column-total"/>
		<xsl:param name="column-active"/>
		<!-- Calculate the number of headings for each column layout -->
		<xsl:variable name="container-headings-half">
			<xsl:choose>
				<xsl:when test="following::content[1]/target-content-file/@filename!=''">
					<xsl:value-of select="ceiling((count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) + 1) div 2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ceiling((count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major'])) div 2)"/>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>
		<xsl:variable name="container-headings-third">
			<xsl:choose>
				<xsl:when test="following::content[1]/target-content-file/@filename!=''">
					<xsl:value-of select="ceiling((count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) + 1) div 3)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ceiling((count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major'])) div 3)"/>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>
		<!-- Build link list -->
		<ul class="ibm-link-list">
			<!-- Check for both major headings and container-headings on the page within a center column module -->
			<xsl:for-each select="following::content[1]//heading[@type='major'] | following::content[1]//container-heading[ancestor::module] | following::content[1]//heading[@type='hidef']">
				<!-- Get or create a unique id for the inline link that matches the major heading or container-heading -->
				<xsl:variable name="newid">
					<xsl:choose>
						<xsl:when test="normalize-space(@refname)">
							<xsl:value-of select="concat('#', @refname)"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- Create an 8-character unique id -->
							<xsl:variable name="baseid">
								<!-- Start with 6 uppercase characters from the container-heading text; replace any spaces with the character 'Z' -->
								<xsl:value-of select="translate(translate(substring(.,1,6),' ','Z'),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
							</xsl:variable>
							<!-- Append the number of preceding nodes plus the current node -->
							<xsl:choose>
								<!-- When count greater than 1000, only use 4 characters from container-heading text -->
								<xsl:when test="(1 + count(preceding::*)) > 1000">
									<xsl:text>#</xsl:text>
									<xsl:value-of select="substring($baseid,1,4)"/>
									<xsl:value-of select="1 + count(preceding::*)"/>
								</xsl:when>
								<!-- When count greater than 100, only use 5 characters from container-heading text -->
								<xsl:when test="(1 + count(preceding::*)) > 100">
									<xsl:text>#</xsl:text>
									<xsl:value-of select="substring($baseid,1,5)"/>
									<xsl:value-of select="1 + count(preceding::*)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>#</xsl:text>
									<xsl:value-of select="$baseid"/>
									<xsl:value-of select="1 + count(preceding::*)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- Build link list -->
				<xsl:choose>
				<xsl:when test="$column-total = 3">
					<xsl:choose>
						<xsl:when test="$column-active = 1">
							<xsl:if test="position() &lt;= $container-headings-third">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="*|text()" />
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 2">
							<xsl:if test="(position() > $container-headings-third) and (position() &lt;= $container-headings-third * 2)">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="*|text()" />
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 3">
							<xsl:if test="position() > $container-headings-third * 2">  
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="*|text()" />
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="position() = last()">							
								<xsl:if test="../../../target-content-file/@filename!=''">
									<li>
										<a class="ibm-anchor-down-em-link" href="#download">
											<xsl:value-of select="$downloads-heading"/>
										</a>
									</li>
								</xsl:if>
							</xsl:if>							
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$column-total = 2">
					<xsl:choose>
						<xsl:when test="$column-active = 1">
							<xsl:if test="position() &lt;= $container-headings-half">
								<li>								
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="*|text()" />
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$column-active = 2">
							<xsl:if test="position() > $container-headings-half">
								<li>
									<a class="ibm-anchor-down-em-link" href="{$newid}">
										<xsl:choose>
											<xsl:when test="normalize-space(@alttoc)">
												<xsl:value-of select="./@alttoc"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="*|text()" />
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="position() = last()">							
								<xsl:if test="../../../target-content-file/@filename!=''">
									<li>
										<a class="ibm-anchor-down-em-link" href="#download">
											<xsl:value-of select="$downloads-heading"/>
										</a>
									</li>
								</xsl:if>
							</xsl:if>							
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a class="ibm-anchor-down-em-link" href="{$newid}">
							<xsl:choose>
								<xsl:when test="normalize-space(@alttoc)">
									<xsl:value-of select="./@alttoc"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="*|text()" />
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</li>
					<xsl:if test="position() = last()">
						<xsl:if test="../../../target-content-file/@filename!=''">
							<li>
								<a class="ibm-anchor-down-em-link" href="#download">
									<xsl:value-of select="$downloads-heading"/>
								</a>
							</li>
						</xsl:if>
					</xsl:if>					
				</xsl:otherwise>	
				</xsl:choose>
			</xsl:for-each>
		</ul>
    </xsl:template> 
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to create page title for high-definition landing pagegroup -->
  <xsl:template name="PageTitleHidef-v16">
		<xsl:param name="landing-page-name" />
		<xsl:if test="/dw-document/dw-landing-generic-pagegroup-hidef">
			<xsl:choose>
				<xsl:when test="following::content[1]/page-title-hidef/@display = 'no'">
					<div class="ibm-access"><h1><xsl:value-of select="(normalize-space(following::content[1]/page-title-hidef))"/></h1></div>
				</xsl:when>
				<xsl:otherwise>
					<div class="ibm-container ibm-alternate">
					<div class="ibm-container-body">
						<h1 class="dw-hd-heading dw-hd-heading-overlay">
							<xsl:value-of select="(normalize-space(following::content[1]/page-title-hidef))"/>  
						</h1>
					</div>
					</div>
				</xsl:otherwise>
			</xsl:choose>
        </xsl:if>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="PagegroupOverview-v16">
		<xsl:choose>
			<xsl:when test="normalize-space(following::content[1]/overview)">
				<xsl:apply-templates select="following::content[1]/overview"/>
			</xsl:when>
			<xsl:when test="normalize-space(following::content[1]/overview-module)">
				<xsl:for-each select="following::content[1]/overview-module">
					<xsl:if test="normalize-space(container-link-block/link-block-abstract)">
						<xsl:call-template name="PagegroupOverviewModule-v16"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="normalize-space(//pagegroup-overview)">
				<xsl:apply-templates select="//pagegroup-overview"/>
			</xsl:when>
			<xsl:when test="normalize-space(//pagegroup-overview-module)">
				<xsl:for-each select="//pagegroup-overview-module">
					<xsl:if test="normalize-space(container-link-block/link-block-abstract)">
						<xsl:call-template name="PagegroupOverviewModule-v16"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="PagegroupOverviewModule-v16">
		<div class="ibm-container ibm-alternate-two">
			<div>
				<!-- Apply correct classes based on number of content columns -->
				<xsl:choose>
					<xsl:when test="count(container-column) = 1">
						<xsl:attribute name="class">ibm-container-body</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(container-column) = 2">
						<xsl:attribute name="class">ibm-container-body ibm-two-column</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(container-column) = 3">
						<xsl:attribute name="class">ibm-container-body ibm-three-column</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-container-body</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Process container link block -->
				<xsl:call-template name="ModuleContainerLinkBlock-v16"/>
				<!-- Process container columns -->
				<xsl:if test="container-column">
					<xsl:for-each select="container-column">
						<xsl:choose>
							<xsl:when test="count(container-column) = 1">							
								<xsl:call-template name="ModuleContainerColumn-v16"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="position() = 1">
									<div>
										<!-- If any column contains a heading, use ibm-list-container class on all columns for extra padding -->
										<xsl:choose>
											<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
												<xsl:attribute name="class">ibm-column ibm-list-container ibm-first</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="class">ibm-column ibm-first</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
									</div>
									</xsl:when>
									<xsl:when test="position() = 2">
									<div>
										<xsl:choose>
											<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
												<xsl:attribute name="class">ibm-column ibm-list-container ibm-second</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="class">ibm-column ibm-second</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
									</div>
									</xsl:when>
									<xsl:when test="position() = 3">
									<div>
										<xsl:choose>
											<xsl:when test="(../container-column/link-section/link-list/link-list-heading) or (../container-column/link-section/link-block/link-block-heading)">
												<xsl:attribute name="class">ibm-column ibm-list-container ibm-third</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="class">ibm-column ibm-third</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:call-template name="ModuleContainerColumnMultiple-v16"/>
									</div>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="normalize-space(container-forward-link)">
				<p class="ibm-ind-link">
					<a class="ibm-forward-link" href="{container-forward-link/url}">
						<xsl:apply-templates select="container-forward-link/text"/>
					</a>
				</p>
				</xsl:if>
			</div>
		</div>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process individual page requests within a pagegroup --> 
  <xsl:template name="PagegroupPageSelector-v16">
		<xsl:param name="landing-page-name"/>
		<xsl:param name="landing-template-name"/>
		<xsl:choose>
			<xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages | /dw-document/dw-landing-generic-pagegroup-hidef">
				<xsl:for-each select="//page/pageinfo/@primary-nav-url | //page-hidef/pageinfo/@primary-nav-url">
					<xsl:choose>
						<xsl:when test="contains(.,concat('/',$landing-page-name))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@output='no')">							
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some page templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:when test="contains(.,$landing-page-name) and (string-length(.) = string-length($landing-page-name))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@output='no')">							
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some page templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
						<xsl:when test="($landing-page-name='index.html') and ((substring(.,string-length(.)) = '/') or not(substring(.,string-length(.)-4) = '.html'))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@output='no')">
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some page templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<xsl:for-each select="//subpage/subpageinfo/@secondary-nav-url | //subpage-hidef/subpageinfo/@secondary-nav-url">
					<xsl:choose>
						<xsl:when test="contains(.,concat('/',$landing-page-name))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@persistent='no')">							
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some subpage templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:when test="contains(.,$landing-page-name) and (string-length(.) = string-length($landing-page-name))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@persistent='no')">
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some subpage templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
						<xsl:when test="($landing-page-name='index.html') and ((substring(.,string-length(.)) = '/') or not(substring(.,string-length(.)-4) = '.html'))">
							<!-- If this tab does not reference a page outside the pagegroup, process it -->
							<xsl:if test="not(../../@persistent='no')">
								<xsl:call-template name="PagegroupTemplateSelector-v16">
									<xsl:with-param name="landing-template-name" select="$landing-template-name" />
									<!-- Required by some subpage templates -->
									<xsl:with-param name="landing-page-name" select="$landing-page-name" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>			
       </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="PagegroupTemplateSelector-v16">
		<xsl:param name="landing-template-name"/>
		<xsl:param name="landing-page-name"/>
		<xsl:choose>
			<xsl:when test="$landing-template-name = 'FullTitle-v17' ">
				<xsl:call-template name="FullTitle-v17"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'FilterAbstract-v17' ">
				<xsl:call-template name="FilterAbstract-v17"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'keywords-v17' ">
				<xsl:call-template name="keywords-v17"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'dcType-v17' ">
				<xsl:call-template name="dcType-v17"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'webFeedDiscovery-v16' ">
				<xsl:call-template name="webFeedDiscovery-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'LeadspaceHidefOptions-v16' ">
				<xsl:call-template name="LeadspaceHidefOptions-v16"/>
			</xsl:when>			
			<xsl:when test="$landing-template-name = 'Title-v16' ">
				<xsl:call-template name="Title-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'FeaturedContentModule-v16' ">
				<xsl:call-template name="FeaturedContentModule-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'PagegroupOverview-v16' ">
				<xsl:call-template name="PagegroupOverview-v16"/>
			</xsl:when>				
			<xsl:when test="$landing-template-name = 'TabbedNav-v16' ">
				<xsl:call-template name="TabbedNav-v16">
					<!-- Page name is required by the subpage template -->
					<xsl:with-param name="landing-page-name" select="$landing-page-name" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'PageTitleHidef-v16' ">
				<xsl:call-template name="PageTitleHidef-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'PagegroupContentSpaceNavigation-v16' ">
				<xsl:call-template name="PagegroupContentSpaceNavigation-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'AbstractLandingHidefBuild-v16' ">
				<xsl:call-template name="AbstractLandingHidefBuild-v16"/>
			</xsl:when>			
			<xsl:when test="$landing-template-name = 'ModuleDocbody-v16' ">
				<xsl:call-template name="ModuleDocbody-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'ModuleDocbodyHidef-v16' ">
				<xsl:call-template name="ModuleDocbodyHidef-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'DownloadsLandingPagegroup-v16' ">
				<xsl:call-template name="DownloadsLandingPagegroup-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'ContactModuleUse-v16' ">
				<xsl:call-template name="ContactModuleUse-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'ReadyToBuy-v16' ">
				<xsl:call-template name="ReadyToBuy-v16"/>
			</xsl:when>			
			<xsl:when test="$landing-template-name = 'HighVisModule-v16' ">
				<xsl:call-template name="HighVisModule-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'HighVisModuleHidef-v16' ">
				<xsl:call-template name="HighVisModuleHidef-v16"/>
			</xsl:when>			
			<xsl:when test="$landing-template-name = 'ModuleRightDocbodyHidefBuild-v16' ">
				<xsl:call-template name="ModuleRightDocbodyHidefBuild-v16"/>
			</xsl:when>
			<xsl:when test="$landing-template-name = 'HidefFooterModule-v16' ">
				<xsl:call-template name="HidefFooterModule-v16"/>
			</xsl:when>																	
		</xsl:choose>
  </xsl:template>  
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="panel-html-body">
    <xsl:apply-templates select="a | br | em | figure | forward-link-list | heading | img | ol | p | strong | span | sub | sup | table | twisty-section | ul"/>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
	<xsl:template name="PDFSummary-v16">
		<xsl:for-each select="/dw-document//pdf[@paperSize='common'][1]">
			<br class="ibm-ind-link"/>
			<strong>
				<xsl:value-of select="$pdf-heading"/>
			</strong>
			<!-- Spacing -->
			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
			<!-- 6.0 Maverick R3 10/01/01 jpp: Check for and fix an invalid Boulder URL -->
			<xsl:element name="a">
				<!-- xM Fix Pack 09/21/11 jpp: Added onclick attribute to invoke PDF tracking script -->
				<xsl:if test="@track='yes'">
					<xsl:attribute name="onclick">
						<xsl:text>ibmStats.event({'ibmEV':'download','ibmEvAction':'</xsl:text>
						<xsl:choose>
							<xsl:when test="contains(@url,'//download.boulder.ibm.com/ibmdl/pub/')">
								<xsl:call-template name="ReplaceSubstring">
									<xsl:with-param name="original" select="@url"/>
									<xsl:with-param name="substring"
										select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
									<xsl:with-param name="replacement"
										select="'//public.dhe.ibm.com/'"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@url"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>'});</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<!-- xM Fix Pack 09/21/11 jpp: Added xsl:choose statement to Process PDF tracking attribute on pdf element -->
				<xsl:choose>
					<xsl:when test="@track='yes'">
						<xsl:attribute name="href">
							<xsl:text>https://www.ibm.com/developerworks/dwwi/DWAuthRouter?m=auth&amp;lang=en_US&amp;d=</xsl:text>
							<xsl:choose>
								<xsl:when
									test="contains(@url,'//download.boulder.ibm.com/ibmdl/pub/')">
									<xsl:call-template name="ReplaceSubstring">
										<xsl:with-param name="original" select="@url"/>
										<xsl:with-param name="substring"
											select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
										<xsl:with-param name="replacement"
											select="'//public.dhe.ibm.com/'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@url"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">
							<xsl:choose>
								<xsl:when
									test="contains(@url,'//download.boulder.ibm.com/ibmdl/pub/')">
									<xsl:call-template name="ReplaceSubstring">
										<xsl:with-param name="original" select="@url"/>
										<xsl:with-param name="substring"
											select="'//download.boulder.ibm.com/ibmdl/pub/'"/>
										<xsl:with-param name="replacement"
											select="'//public.dhe.ibm.com/'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@url"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$pdf-common"/>
			</xsl:element>
			<xsl:if test="normalize-space(@size)">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@size"/>
				<xsl:if test="normalize-space(@pages)">
					<xsl:text> | </xsl:text>
					<xsl:choose>
						<xsl:when test="@pages = '1'">
							<xsl:value-of select="@pages"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$pdf-page"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@pages"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$pdf-pages"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<a href="http://www.adobe.com/products/acrobat/readstep2.html" class="ibm-external-link">
				<xsl:value-of select="$download-get-adobe" disable-output-escaping="yes"/>
			</a>
		</xsl:for-each>
	</xsl:template> 
  <!-- NOT USED FOR 7.0 -->
  <!-- ProcessList template for creating lists for things like Resources, etc. -->
  <xsl:template name="ProcessList">
    <xsl:choose>
      <xsl:when test="ul or ol">
        <li>
          <xsl:apply-templates select="*|text()"/>
          <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
         </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <xsl:apply-templates select="*|text()"/>
             <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
            <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
        </li>
      </xsl:otherwise> 
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ProductsLandingURL">
    <xsl:param name="products-landing-url"/>
    <xsl:choose>
       <xsl:when test="content-area-primary/@name='aix'">
       <xsl:value-of select="$products-landing-au"/>
      </xsl:when>
      <xsl:when test="content-area-primary/@name='data'">
        <xsl:value-of select="$products-landing-db2"/>
      </xsl:when>
      <xsl:when test="content-area-primary/@name='lotus'">
        <xsl:value-of select="$products-landing-lo"/>
      </xsl:when>
      <xsl:when test="content-area-primary/@name='rational'">
        <xsl:value-of select="$products-landing-r"/>
      </xsl:when>
      <xsl:when test="content-area-primary/@name='tivoli'">
        <xsl:value-of select="$products-landing-tiv"/>
      </xsl:when>
      <xsl:when test="content-area-primary/@name='websphere'">
        <xsl:value-of select="$products-landing-web"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR -->
	<!-- NOT USED FOR 7.0 -->
	<!-- Template creates metadata for rating function -->
	<xsl:template name="RatingMeta-v16">
		<xsl:comment>Rating_Meta_BEGIN</xsl:comment>
		<xsl:variable name="titleinput">
			<xsl:call-template name="FullTitle-v17"/>
		</xsl:variable>
		<div class="metavalue">static.content.url=http://www.ibm.com/developerworks/js/artrating/</div>
		<!-- Create SITE_ID meta value -->
		<div class="metavalue">
			<xsl:value-of select="concat('SITE_ID=',$site_id)"/>
		</div>
		<!-- Create ZONE meta values -->
        <xsl:variable name="contentareaforinput">
			<xsl:call-template name="ContentAreaInputName">
				<xsl:with-param name="contentarea">
					<xsl:value-of select="content-area-primary/@name"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="count(content-area-secondary) > 0">
                <xsl:text>, </xsl:text>
                <xsl:for-each select="content-area-secondary">
					<xsl:if test="position()!=1">, </xsl:if>
						<xsl:call-template name="ContentAreaInputName">
							<xsl:with-param name="contentarea">
								<xsl:value-of select="@name"/>
							</xsl:with-param>
						</xsl:call-template>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
		<div class="metavalue">
			<xsl:value-of select="concat('Zone=',$contentareaforinput)"/>
		</div>
		<!-- Create ArticleID meta value -->
        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="/dw-document//content-area-primary/@name = 'data' or /dw-document//content-area-primary/@name = 'websphere'">
                  <xsl:choose>
                    <xsl:when test="/dw-document//id/@cma-id !=''">
                      <xsl:value-of select="/dw-document//id/@cma-id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="/dw-document//id/@content-id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- For all non-data and non-websphere content... -->
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="/dw-document//id/@cma-id !=''">
                      <xsl:value-of select="/dw-document//id/@cma-id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="/dw-document//id/@domino-uid"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div class="metavalue">
			<xsl:value-of select="concat('ArticleID=',$id)"/>
		</div>
		<!-- Create ArticleTitle meta value -->
        <div class="metavalue">
			<xsl:choose>
				<xsl:when test="//dw-article">
					<xsl:value-of select="concat('ArticleTitle=',$titleinput)"/>
				</xsl:when>
				<xsl:when test="//dw-summary">
					<xsl:value-of select="concat('SummaryTitle=',$titleinput)"/>
				</xsl:when>
			</xsl:choose>			
		</div>
		<!-- Create publish-date meta value -->
        <xsl:variable name="publish-month">
               <xsl:choose>
                  <xsl:when test="//date-updated/@month != ''">
                     <xsl:value-of select="//date-updated/@month" />
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="//date-published/@month" />
                  </xsl:otherwise>
                </xsl:choose>
        </xsl:variable>
        <xsl:variable name="publish-day">
               <xsl:choose>
                  <xsl:when test="//date-updated/@day != ''">
                     <xsl:value-of select="//date-updated/@day" />
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="//date-published/@day" />
                  </xsl:otherwise>
                </xsl:choose>
        </xsl:variable>
        <xsl:variable name="publish-year">
               <xsl:choose>
                  <xsl:when test="//date-updated/@year != ''">
                     <xsl:value-of select="//date-updated/@year" />
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="//date-published/@year" />
                  </xsl:otherwise>
                </xsl:choose>
        </xsl:variable>     
        <xsl:variable name="publish-date" select="concat($publish-month,$publish-day,$publish-year)" />
        <div class="metavalue">
			<xsl:value-of select="concat('publish-date=',$publish-date)"/>
		</div>
		<!-- Create author meta values -->
		<!-- Maverick 6.0 R3 09 20 10 egd:  Update to support author-summary element meta -->
		<!-- lk 09/13/2011 remove author email per jp request -->
		<!--  <xsl:for-each select="//author | //author-summary">
			<xsl:variable name="author-email" select="@email" />
            <xsl:variable name="author-email-cc" select="@email-cc" />
            <xsl:variable name="author-number" select="position()" />
            <div class="metavalue">
				<xsl:value-of select="concat('author',$author-number,'-email=')" /><xsl:value-of select="@email" />
            </div>
            <div class="metavalue">
				<xsl:value-of select="concat('author',$author-number,'-email-cc=')" /><xsl:value-of select="@email-cc" />
            </div>
        </xsl:for-each> -->
		<!-- Create url meta value -->
        <xsl:text disable-output-escaping="yes"><![CDATA[<script language="javascript" type="text/javascript">document.write('<div class="metavalue">url='+location.href.replace(/</g,  '%3C')+'</div>');</script>]]></xsl:text>
		<xsl:comment>Rating_Meta_END</xsl:comment>
	</xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ReadyToBuy-v16">
		<xsl:if test="normalize-space(following::content[1]/ready-to-buy/text) and normalize-space(following::content[1]/ready-to-buy/url)">
			<div class="ibm-container">
				<!-- Create module heading -->
				<h2>
					<xsl:value-of select="$ready-to-buy" />
				</h2>			
				<!-- Create module body -->
				<div class="ibm-container-body dw-right-bullet-list">
					<ul class="ibm-bullet-list">	
						<!-- Process list contents -->
						<xsl:for-each select="following::content[1]/ready-to-buy">
							<xsl:if test="normalize-space(text) and normalize-space(url)">						  
								<li>
									<a>
										<xsl:attribute name="class">ibm-feature-link</xsl:attribute>
										<xsl:attribute name="href">
											<xsl:value-of select="url"  />
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</a>
								</li>
							</xsl:if>
						</xsl:for-each>	 
					</ul>  
				</div>
			</div>
		</xsl:if>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process registration or view links for summary briefing, demo, and registration -->
  <xsl:template name="RegistrationViewLink-v16"> 
	<xsl:choose>
				<xsl:when test="//dw-summary[@summary-content-type='briefing']">
		  <!-- All briefings should have registration URLs, but added if test since technically registration-enrollment-url is not required for 6.0 -->
		  <xsl:if test="normalize-space(//registration-enrollment-url)">
			<!-- Javascript variable for the registration text -->
			<xsl:text disable-output-escaping="yes"><![CDATA[<script type="text/javascript" language="JavaScript">
			<!-- 
			var notFoundText="]]></xsl:text>
				<xsl:value-of select="$summary-briefingNotFound"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[";
			//-->
			</script><noscript></noscript>]]></xsl:text>
			<!-- Javascript variable for the registration URL -->
			<xsl:text disable-output-escaping="yes"><![CDATA[<script type="text/javascript" language="JavaScript">
			<!-- 
			var registrationURL="]]></xsl:text>
				<xsl:value-of select="registration-enrollment-url"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[";
			//-->
			</script><noscript></noscript>]]></xsl:text>
			<!-- Javascript AJAX file  and make AJAX call-->
			<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="/developerworks/js/getview16.js" type="text/javascript"></script><noscript></noscript>]]></xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" type="text/javascript">
			<!-- 
			getView(registrationURL);
			//-->
			</script><noscript></noscript>]]></xsl:text>
		<div id="view-contents">
			<p class="ibm-ind-link">
				<xsl:element name="a">
					<xsl:attribute name="class">
						<xsl:text>ibm-forward-em-link</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="//registration-enrollment-url"/>
					</xsl:attribute>
						<xsl:element name="strong">
							<xsl:value-of select="$summary-briefingLinkText"/>
						</xsl:element>				
				</xsl:element>
			</p>
			</div>
		   </xsl:if>
		</xsl:when>			
		<xsl:when test="//dw-summary[@summary-content-type='demo']">
		<!-- All demos should have either a registration URL or a View URL, but added if test since technically neither is required for 6.0 -->
		<xsl:if test="normalize-space(//registration-enrollment-url) or normalize-space(//view-content-url)">
		<p class="ibm-ind-link">
			<xsl:element name="a">
				<xsl:attribute name="class">
					<xsl:text>ibm-forward-em-link</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="//registration-enrollment-url!=''">													
							<xsl:value-of select="//registration-enrollment-url"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="//view-content-url"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
					<xsl:element name="strong">
						<xsl:choose>
							<xsl:when test="//registration-enrollment-url!=''">
								<xsl:value-of select="$summary-register"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$summary-view"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>				
				</xsl:element>
			</p>
		</xsl:if>
	</xsl:when>
	<xsl:when test="//dw-summary[@summary-content-type='registration']">
		<!-- All registrations should have registration URLs, but added if test since technically registration-enrollment-url is not required for 6.0 -->
		<xsl:if test="normalize-space(//registration-enrollment-url)">
		<p class="ibm-ind-link">
			<xsl:element name="a">
				<xsl:attribute name="class">
					<xsl:text>ibm-forward-em-link</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:value-of select="//registration-enrollment-url"/>
				</xsl:attribute>
					<xsl:element name="strong">
						<xsl:value-of select="$summary-register"/>
					</xsl:element>				
				</xsl:element>
			</p>
			</xsl:if> 
		</xsl:when>
	</xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 --> 
  <xsl:template match="resources">
    <xsl:variable name="num-resources">
      <xsl:value-of select="count(resource)"/>
    </xsl:variable>
    <!-- Count number of each category of resources -->
    <xsl:variable name="num-resources-learn">
      <xsl:value-of select="count(resource[@resource-category='Learn'])"/>
    </xsl:variable>
    <xsl:variable name="num-resources-get">
        <xsl:value-of select="count(resource[normalize-space(@resource-category) = 'Get products and technologies'])"/>
    </xsl:variable>
    <xsl:variable name="num-resources-discuss">
      <xsl:value-of select="count(resource[@resource-category='Discuss'])"/>
    </xsl:variable>
    <xsl:choose>
      <!-- Subcategorize if > 3 resource elements and at least 2 diff. subcat's coded -->
      <xsl:when test="$num-resources &gt; 3 and
                                $num-resources - $num-resources-learn != 0 and
                                $num-resources - $num-resources-get != 0 and
                                $num-resources - $num-resources-discuss !=0">
        <xsl:if test="resource[@resource-category='Learn']">
        <p>
          <strong>
            <xsl:value-of select="$resources-learn"/>
          </strong>
         </p>
          <ul>
            <xsl:for-each select="resource[@resource-category='Learn']">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </ul>
        </xsl:if>        
        <xsl:if test="resource[normalize-space(@resource-category) = 'Get products and technologies']">
        <p>
          <strong>
            <xsl:value-of select="$resources-get"/>
          </strong>
        </p>
          <ul>
            <xsl:for-each select="resource[normalize-space(@resource-category) = 'Get products and technologies']">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </ul>
        </xsl:if>
        <xsl:if test="resource[@resource-category='Discuss'] or /dw-document//forum-url/@url !=''">
        <p> 
          <strong>
            <xsl:value-of select="$resources-discuss"/>
          </strong>
        </p>
          <ul>
            <xsl:if test="/dw-document//forum-url/@url !=''">
              <li>
                <xsl:copy-of select="$resource-list-forum-text"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
                  <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
              </li>
            </xsl:if>
            <xsl:for-each select="resource[@resource-category='Discuss']">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </xsl:when>
      <!-- If 3 or fewer resource elements, don't subcategorize -->
      <xsl:otherwise>
        <ul>
          <xsl:if test="/dw-document//forum-url/@url !=''">
            <li>
              <xsl:copy-of select="$resource-list-forum-text"/>
              <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
              <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
            </li>
          </xsl:if>
          <xsl:for-each select="resource">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="resource">
  <!-- List processing now done by generic template, ProcessList -->
  <xsl:call-template name="ProcessList"/>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="resource-list/heading | resource/heading">
    <strong>
      <xsl:value-of select="."/>
    </strong>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="resource-list/ul">
    <ul>
      <xsl:if test=". = /dw-document//resource-list/ul[1] and /dw-document//forum-url/@url !=''">
        <li>
          <xsl:copy-of select="$resource-list-forum-text"/>
          <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
          <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
        </li>
      </xsl:if>      
      <xsl:for-each select="li">
            <li>
              <xsl:apply-templates select="*|text()"/>
              <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
			 <xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
			 </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="ResourcesSection">
  <xsl:if test="normalize-space(resource-list/*) !='' or normalize-space(resources/resource/@resource-category) !=''">    
      <p>
        <a name="resources">
          <span class="atitle">
            <xsl:value-of select="$resource-list-heading"/>
          </span>
        </a>
      </p>
      <xsl:choose>
      	<xsl:when test="resource-list">
        <xsl:apply-templates select="resource-list"/>
        </xsl:when>
        <xsl:when test="resources">
        <xsl:apply-templates select="resources"/>
        </xsl:when>
      </xsl:choose> 
         <xsl:if test="/dw-document/dw-tutorial">		                            
		<xsl:comment>START RESERVED FOR FUTURE USE FILES - RESOURCES SECTION</xsl:comment>
        <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text>
        <xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-reserved-resources1-tutorial.inc"-->]]></xsl:text>
        <xsl:comment>END RESERVED FOR FUTURE USE INCLUDE FILES - RESOURCES SECTION</xsl:comment>
      </xsl:if> 
   </xsl:if>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="RSSHeading-v16">
	  <xsl:for-each select="//right-box-feed">
		  <xsl:value-of select="heading"/>
	  </xsl:for-each>  
  </xsl:template> 
  <!-- SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS -->
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="selected-tab-container">
    <xsl:apply-templates select="a | b | blockquote | br | code | dl | em | figure | forward-link | forward-link-list | heading | i | img | include | ol | p | sidebar | span | strong | sub | sup | table | twisty-section | ul"/>
  </xsl:template>
	<!-- NOT USED FOR 7.0 -->
	<!-- Template creates the series-title text in the summary area  -->
	<xsl:template name="SeriesTitle-v16">
		<xsl:if test="(normalize-space(/dw-document//series/series-title)!='') and (normalize-space(/dw-document//series/series-url)!='')">
			<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
				<xsl:value-of select="/dw-document//series/series-url"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
				<xsl:value-of select="$series-view" />
			<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- NOT USED FOR 7.0 -->
    <xsl:template match="sidebar">
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic | /dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
					<div class="ibm-cross-links">
						<xsl:apply-templates select="a | strong | b | br | dl | em | heading | i | ol | p | sub | sup | ul | specialCharacters | text()"/>
					</div>
				</xsl:when>
				<xsl:when test="heading!=''">
					<div class="ibm-container ibm-alt-header dw-container-sidebar">
					<xsl:if test="heading/@refname!=''">
					<xsl:text disable-output-escaping="yes"><![CDATA[<a name="]]></xsl:text><xsl:value-of select="heading/@refname" /><xsl:text disable-output-escaping="yes"><![CDATA["></a>]]></xsl:text>
					</xsl:if>
					<xsl:text disable-output-escaping="yes"><![CDATA[<h2>]]></xsl:text><xsl:value-of select="heading" /><xsl:text disable-output-escaping="yes"><![CDATA[</h2>]]></xsl:text>
					<div class="ibm-container-body">
					<xsl:apply-templates select="a | strong | b | br | code | dl | i | include | ol | p | sub | sup | ul | specialCharacters | text()"/> 
					</div> 
					</div>
				</xsl:when>
				<xsl:otherwise>
					<div class="ibm-container dw-container-sidebar ibm-alternate-two">
					<div class="ibm-container-body">
					<xsl:apply-templates select="a | strong | b | br | code | dl | i | include | ol | p | sub | sup | ul | specialCharacters | text()"/> 
					</div>
					</div>  
				</xsl:otherwise>
			</xsl:choose> 
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template match="sidebar-custom">
	   <!-- Ensure the custom sidebar has at least one related-resource coded before creating module -->
		<xsl:if test="normalize-space(related-resource/text) and normalize-space(related-resource/url)">
			<xsl:element name="div">
				<xsl:attribute name="class">ibm-container dw-container-sidebar</xsl:attribute>
				<h2><xsl:value-of select="$knowledge-path-heading"/></h2>				
				<xsl:element name="div">
					<xsl:attribute name="class">ibm-container-body dw-sidebar-custom</xsl:attribute>
						<xsl:choose>
							<!-- Process knowledge-path sidebar -->
							<xsl:when test="@type='knowledge-path'">
								<xsl:choose>								
									<xsl:when test="count(related-resource) > 1">
										<xsl:element name="p">
											<xsl:value-of select="$knowledge-path-text-multiple"/>
										</xsl:element>
										<xsl:element name="ul">
											<xsl:attribute name="class">ibm-bullet-list</xsl:attribute>
											<xsl:for-each select="related-resource">											
												<xsl:element name="li">
													<xsl:element name="a">
														<xsl:attribute name="class">ibm-feature-link</xsl:attribute>
														<xsl:attribute name="href">
												<!-- llk 10/25/2011 - added generate-correct-url formatting -->
												<xsl:call-template
												name="generate-correct-url-form">
												<xsl:with-param name="input-url" select="url"/>
												</xsl:call-template>
														</xsl:attribute>
														<xsl:apply-templates select="text"/>
													</xsl:element>
												</xsl:element>											
											</xsl:for-each>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:element name="p">
											<xsl:value-of select="$knowledge-path-text"/>
												<xsl:text> </xsl:text>
												<xsl:element name="a">
													<xsl:attribute name="href">
												<!-- llk 10/25/2011 - added generate-correct-url formatting -->
												<xsl:call-template
												name="generate-correct-url-form">
												<xsl:with-param name="input-url" select="related-resource/url"/>
												</xsl:call-template>
													</xsl:attribute>
													<xsl:value-of select="related-resource/text"/>
												</xsl:element>
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>							
							</xsl:when>
						</xsl:choose>			
				</xsl:element>		
			</xsl:element>
		</xsl:if>  
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="SkillLevel">
    <xsl:if test="/dw-document//@skill-level">
        <xsl:if test="not(//dw-knowledge-path)">
           <xsl:text disable-output-escaping="yes"><![CDATA[<br /><strong>]]></xsl:text>
        </xsl:if>
		<xsl:value-of select="$level-text-heading"/>
        <xsl:if test="not(//dw-knowledge-path)">
           <xsl:text disable-output-escaping="yes"><![CDATA[</strong>&nbsp;]]></xsl:text>
        </xsl:if>
        <xsl:call-template name="SkillLevelText"/>
    </xsl:if>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="SkillLevelText">
    <xsl:choose>
      <xsl:when test="/dw-document//@skill-level = '1' ">
        <xsl:value-of select="$level-1-text"/>
      </xsl:when>
      <xsl:when test="/dw-document//@skill-level = '2' ">
        <xsl:value-of select="$level-2-text"/>
      </xsl:when>
      <xsl:when test="/dw-document//@skill-level = '3' ">
        <xsl:value-of select="$level-3-text"/>
      </xsl:when>
      <xsl:when test="/dw-document//@skill-level = '4' ">
        <xsl:value-of select="$level-4-text"/>
      </xsl:when>
      <xsl:when test="/dw-document//@skill-level = '5' ">
        <xsl:value-of select="$level-5-text"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="span">
    <span>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates select="*|text()"/>
    </span>
  </xsl:template>
   <!-- NOT USED FOR 7.0 -->
    <xsl:template name="SpotlightModule-v16">
		<xsl:if test="module-spotlight">
			<!-- For product and generic landing, create the module container, heading, and module container body -->
			<xsl:if test="//dw-landing-product or //dw-landing-generic">
				<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container">]]></xsl:text>
					<!-- Create module heading and div container -->
					<h2><xsl:value-of select="$spotlight-heading" /></h2>
					<xsl:text disable-output-escaping="yes"><![CDATA[<div class="ibm-container-body dw-right-bullet-list">]]></xsl:text>
			</xsl:if>
				<!-- Create module body -->						  
				<ul class="ibm-bullet-list">					
					  <!-- Process list contents -->
					  <xsl:for-each select="module-spotlight/right-box-section/page-section-link">
						  <xsl:if test="normalize-space(text) and normalize-space(url)">
							  <li>
								<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
									<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
								  <xsl:value-of select="text"/>
							  <xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							  </li>
						  </xsl:if>
					  </xsl:for-each>	 
				  </ul>  
			<!-- For product and generic landing, process the ending divs for the module container and container body -->
			<xsl:if test="//dw-landing-product or //dw-landing-generic">						
				<xsl:text disable-output-escaping="yes"><![CDATA[</div></div>]]></xsl:text>
	    </xsl:if>
		</xsl:if>
    </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="strong">
    <xsl:choose>
	  <xsl:when test="string-length(normalize-space(.)) = 0">
        <xsl:apply-templates />
      </xsl:when>
      <xsl:when test="ancestor::code">
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:when>
      <xsl:otherwise>
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
    <xsl:template name="SummaryBreadcrumbSubLevel-v16">
		<xsl:choose>
			<!-- Process bct with subnav link -->
			<xsl:when test="normalize-space(//content-area-subnav/text) and normalize-space(//content-area-subnav/url)">
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="//content-area-subnav/url"/>
						</xsl:attribute>
						<xsl:value-of select="//content-area-subnav/text"/>
					</a>		
				</li>
				<!-- If there is also a sublevel link, add it to the end of the navigation trail -->
				<xsl:if test="normalize-space(//content-area-subnav-sublevel)">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="//content-area-subnav-sublevel/url"/>
							</xsl:attribute>
							<xsl:value-of select="//content-area-subnav-sublevel/text"/>
						</a>		
					</li>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template name="SummaryType-v16">
	  <xsl:if test="//dw-summary/@summary-content-type='briefing'">
      <p>
        <span>
			<xsl:element name="strong">
				 <xsl:value-of select="$summary-type-label"/>
			</xsl:element>
			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
            <xsl:value-of select="$summary-briefingTechType" />
         </span>
      </p>
   </xsl:if>   
  </xsl:template>
  <!-- TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT -->
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process tabbed module -->
    <xsl:template name="TabbedModule-v16">
		<xsl:if test="module-tabbed">
			<div class="ibm-container ibm-graphic-tabs ibm-dyn-tabs ibm-alternate-two">
			<div class="ibm-tab-section">
			<!-- Module description for accessibility -->
			<h2 class="ibm-access"><xsl:value-of select="//module-tabbed/accessibility-text" /></h2>
			<!-- Build tabs -->
			<ul class="ibm-tabs">
			<xsl:for-each select="//module-tabbed/module-tab">
				<xsl:choose>
					<xsl:when test="normalize-space(@custom-tab-name)">
						<xsl:call-template name="ModuleTabCustom-v16"/>
					</xsl:when>
					<xsl:when test="position() = 1">
						<xsl:text disable-output-escaping="yes"><![CDATA[<li class="ibm-first-tab ibm-highlight-tab"><a href="#tab1">]]></xsl:text>
							<xsl:value-of select="module-tab-name" />
						<xsl:text disable-output-escaping="yes"><![CDATA[</a><span class="ibm-access">- selected tab,</span></li>]]></xsl:text>
					</xsl:when>
					<xsl:when test="position() = last()">
						<xsl:text disable-output-escaping="yes"><![CDATA[<li class="ibm-last-tab"><a href="#tab]]></xsl:text>
							<xsl:value-of select="last()" />
						<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
							<xsl:value-of select="module-tab-name" />
						<xsl:text disable-output-escaping="yes"><![CDATA[</a></li>]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes"><![CDATA[<li><a href="#tab]]></xsl:text>
							<xsl:value-of select="position()" />
						<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
							<xsl:value-of select="module-tab-name" />
						<xsl:text disable-output-escaping="yes"><![CDATA[</a></li>]]></xsl:text>
					</xsl:otherwise>
				</xsl:choose>			
			</xsl:for-each>
			</ul>
			</div>
			<!-- Process individual tab and content -->
			<div class="ibm-container-body">
			<xsl:for-each select="//module-tabbed/module-tab">
				<xsl:text disable-output-escaping="yes"><![CDATA[<div id="tab]]></xsl:text>
				<xsl:value-of select="position()" />
				<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
				<xsl:choose>
					<!-- Tab contains a show/hide module -->
					<xsl:when test="module-tab-show-hide">
						<xsl:call-template name="ModuleTabShowHide-v16"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ModuleTabContainerBody-v16"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
			</xsl:for-each>
			<!-- Close divs -->
			</div>
			</div>
		</xsl:if>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
	<!-- Template to build tabbed landing pagegroup navigation -->
    <xsl:template name="TabbedNav-v16">
		<xsl:param name="landing-page-name" />
		<xsl:choose>
			<xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
				<xsl:choose>
					<!-- Create graphical tabs -->
					<xsl:when test="(//pagegroup/@content-space-primary-navigation='graphical-tabs')">
						<!-- If this is a page vs. a subpage, process primary tab navigation only -->
						<xsl:if test="parent::pageinfo">
							<xsl:comment>GRAPHIC_TABS_START</xsl:comment>							
							<div>
								<xsl:choose>
									<xsl:when test="(../../@content-space-secondary-navigation = 'anchor-link-list') or (../../@content-space-secondary-navigation = 'anchor-link-list-two-column') or (../../@content-space-secondary-navigation = 'anchor-link-list-three-column') and (count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">
										<xsl:attribute name="class">ibm-container ibm-graphic-tabs ibm-combo-tabs</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">ibm-container ibm-graphic-tabs</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<!-- Create primary tabs -->							
								<xsl:call-template name="TabbedNavPrimary-v16">
									<xsl:with-param name="tabPosition">
										<xsl:value-of select="../../@tab-position"/>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Build content space navigation, if requested -->
								<xsl:if test="(../../@content-space-secondary-navigation = 'anchor-link-list') or (../../@content-space-secondary-navigation = 'anchor-link-list-two-column') or (../../@content-space-secondary-navigation = 'anchor-link-list-three-column') and (count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">
									<xsl:call-template name="PagegroupContentSpaceNavigationBuild-v16"/>
								</xsl:if>
								<!-- Create content under selected tab in framed area -->								
								<div>
									<!-- If frame contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
									<xsl:choose>
										<xsl:when test="following::content[1]/selected-tab-container/table">
											<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">ibm-container-body</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:apply-templates select="following::content[1]/selected-tab-container"/>
								</div>
							</div>
							<xsl:comment>GRAPHIC_TABS_END</xsl:comment>
						</xsl:if>
						<!-- If this is a subpage, process primary and secondary tab navigation -->
						<xsl:if test="parent::subpageinfo">
							<xsl:comment>GRAPHIC_TABS_START</xsl:comment>
							<div class="ibm-container ibm-graphic-tabs ibm-combo-tabs">
								<!-- Create primary tabs -->
								<xsl:call-template name="TabbedNavPrimary-v16">
									<xsl:with-param name="tabPosition">
										<xsl:value-of select="../../../@tab-position"/>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Create secondary tabs -->
								<xsl:call-template name="TabbedNavSecondary-v16">
									<xsl:with-param name="landing-page-name" select="$landing-page-name"/>
								</xsl:call-template>
								<!-- Create content under selected tab in framed area -->								
								<div>
									<!-- If frame contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
									<xsl:choose>
										<xsl:when test="following::content[1]/selected-tab-container/table">
											<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">ibm-container-body</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:apply-templates select="following::content[1]/selected-tab-container"/>
								</div>
							</div>
							<xsl:comment>GRAPHIC_TABS_END</xsl:comment>
						</xsl:if>
					</xsl:when>
					<!-- Create text tabs -->
					<xsl:when test="(//pagegroup/@content-space-primary-navigation='text-tabs')">
						<!-- If this is a page vs. a subpage, process primary tab navigation only -->
						<xsl:if test="parent::pageinfo">
							<xsl:comment>TEXT_TABS_START</xsl:comment>							
							<div class="ibm-container">
								<!-- Create primary text tabs (and content space navigation, if requested) -->
								<xsl:call-template name="TabbedNavPrimaryText-v16">
									<xsl:with-param name="landing-page-name" select="$landing-page-name"/>
								</xsl:call-template>
								<!-- Create content under selected tab in framed area -->								
								<div>
									<!-- If frame contains a table, add ibm-inner-data-table class to format table correctly within boxed frame -->
									<xsl:choose>
										<xsl:when test="following::content[1]/selected-tab-container/table">
											<xsl:attribute name="class">ibm-container-body ibm-inner-data-table</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">ibm-container-body</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:apply-templates select="following::content[1]/selected-tab-container"/>
								</div>
							</div>
							<xsl:comment>TEXT_TABS_END</xsl:comment>
						</xsl:if>
					</xsl:when>
				</xsl:choose>	
			</xsl:when>
			<xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef">
			  <!-- 6.0 Defiant R1 11/21/11 jpp: Added xsl:choose selection to check tabs attribute on pagegroup-hidef element -->
              <xsl:choose>
				<!-- When tabs attribute on pagegroup-hidef element is set to "no", remove tabs and adjust spacing; allows a single high definition landing page to be created -->
				<xsl:when test="//pagegroup-hidef/@tabs='no'">
						<div class="dw-landing-pagegroup-notabs">
							<xsl:comment>NO TABS</xsl:comment>
						</div>
				</xsl:when>
				<!-- Otherwise, process tabs for the pagegroup -->
				<xsl:otherwise>			
					<!-- If this is a page vs. a subpage, process primary tab navigation only -->
					<xsl:if test="parent::pageinfo">
						<xsl:comment>GRAPHIC_TABS_START</xsl:comment>
						<div id="ibm-landing-page-tabs" class="ibm-container ibm-graphic-tabs">
							<xsl:call-template name="TabbedNavPrimary-v16">
								<xsl:with-param name="tabPosition">
									<xsl:value-of select="../../@tab-position"/>
								</xsl:with-param>
							</xsl:call-template>
						</div>
						<xsl:comment>GRAPHIC_TABS_END</xsl:comment>
					</xsl:if>
					<!-- If this is a subpage, process primary and secondary tab navigation -->
					<xsl:if test="parent::subpageinfo">
						<xsl:comment>GRAPHIC_TABS_START</xsl:comment>
						<div id="ibm-landing-page-tabs" class="ibm-container ibm-graphic-tabs ibm-combo-tabs">
							<xsl:call-template name="TabbedNavPrimary-v16">
								<xsl:with-param name="tabPosition">
									<xsl:value-of select="../../../@tab-position"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="TabbedNavSecondary-v16">
								<xsl:with-param name="landing-page-name" select="$landing-page-name"/>
							</xsl:call-template>
						</div>
						<xsl:comment>GRAPHIC_TABS_END</xsl:comment>
					</xsl:if>
				</xsl:otherwise>
			  </xsl:choose>
			</xsl:when>
		</xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!--Template to build primary tab code for landing pagegroup navigation -->
  <xsl:template name="TabbedNavPrimary-v16">
		<xsl:param name="tabPosition"/>
		<!-- Tabs are constructed left to right in order of the page elements in the XML; limit is five tabs -->
		<div class="ibm-tab-section">
		<xsl:choose>
			<xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef"><p class="ibm-access">Tab navigation</p></xsl:when>
			<xsl:otherwise><h2 class="ibm-access">Tab navigation</h2></xsl:otherwise>
		</xsl:choose>		
		<ul class="ibm-tabs">		
		<xsl:choose>
			<!-- When highlighted tab is the first tab, process primary tab code -->
			<xsl:when test="$tabPosition = 1">
			    <!-- Create first tab - selected -->
                <xsl:call-template name="TabSelected-v16"><xsl:with-param name="tabValue" select="1" /></xsl:call-template>
				<!-- Process second tab - unselected -->
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="2" /></xsl:call-template>
                <!-- Process third tab if one exists - unselected -->
                <xsl:if test="//page-hidef[3] or //page[3]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="3" /></xsl:call-template>
                </xsl:if>
                <!-- Process fourth tab if one exists - unselected -->
                <xsl:if test="//page-hidef[4] or //page[4]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="4" /></xsl:call-template>
                </xsl:if>
                <!-- Process fifth tab if one exists - unselected; limit is five tabs -->
                <xsl:if test="//page-hidef[5] or //page[5]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="5" /></xsl:call-template>
                </xsl:if>
			</xsl:when>
			<!-- When highlighted tab is the second tab, process primary tab code -->
			<xsl:when test="$tabPosition = 2">
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="1" /></xsl:call-template>
                <xsl:call-template name="TabSelected-v16"><xsl:with-param name="tabValue" select="2" /></xsl:call-template>
                <xsl:if test="//page-hidef[3] or //page[3]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="3" /></xsl:call-template>
                </xsl:if>
                <xsl:if test="//page-hidef[4] or //page[4]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="4" /></xsl:call-template>
                </xsl:if>
                <xsl:if test="//page-hidef[5] or //page[5]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="5" /></xsl:call-template>
                </xsl:if>
			</xsl:when>
			<!-- When highlighted tab is the third tab, process primary tab code -->
			<xsl:when test="$tabPosition = 3">
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="1" /></xsl:call-template>
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="2" /></xsl:call-template>
 				<xsl:call-template name="TabSelected-v16"><xsl:with-param name="tabValue" select="3" /></xsl:call-template>
                <xsl:if test="//page-hidef[4] or //page[4]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="4" /></xsl:call-template>
                </xsl:if>
                <xsl:if test="//page-hidef[5] or //page[5]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="5" /></xsl:call-template>
                </xsl:if>
			</xsl:when>
			<!-- When highlighted tab is the fourth tab, process primary tab code -->
			<xsl:when test="$tabPosition = 4">
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="1" /></xsl:call-template>
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="2" /></xsl:call-template>
 				<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="3" /></xsl:call-template>					
 				<xsl:call-template name="TabSelected-v16"><xsl:with-param name="tabValue" select="4" /></xsl:call-template>
                <xsl:if test="//page-hidef[5] or //page[5]">
					<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="5" /></xsl:call-template>
                </xsl:if>
			</xsl:when>
			<!-- When highlighted tab is the fifth tab, process primary tab code -->
			<xsl:when test="$tabPosition = 5">
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="1" /></xsl:call-template>
                <xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="2" /></xsl:call-template>
 				<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="3" /></xsl:call-template>					
 				<xsl:call-template name="TabUnselected-v16"><xsl:with-param name="tabValue" select="4" /></xsl:call-template>
				<xsl:call-template name="TabSelected-v16"><xsl:with-param name="tabValue" select="5" /></xsl:call-template>
			</xsl:when>
		</xsl:choose>
		</ul>
		</div>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
	<!-- Template to build primary text tab code for landing pagegroup navigation -->
    <xsl:template name="TabbedNavPrimaryText-v16">
		<!-- Important!  Do not remove landing-page-name parameter.  Needed here for standard pagegroup pages to correctly process secondary tabs -->
		<xsl:param name="landing-page-name" />
		<!-- Tabs are constructed left to right in order of the page elements in the XML -->
		<div class="ibm-tab-section ibm-text">
			<h2 class="ibm-access">Tab navigation</h2>
			<ul class="ibm-tabs">
				<!-- Entry point xpath is: page/pageinfo/@primary-nav-url -->
				<xsl:for-each select="(../../../page)">
					<xsl:choose>
						<!-- If this is the first text tab and selected, process -->
						<xsl:when test="position() = 1">
							<xsl:choose>
								<!-- If this tab has no output (links out of the pagegroup), process link as unselected -->
								<xsl:when test="@output = 'no'">
									<li class="ibm-first-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>										
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,$landing-page-name) and (string-length(pageinfo/@primary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)) = '/') or not(substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)-4) = '.html'))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is the first text tab and unselected, process -->
								<xsl:otherwise>
									<li class="ibm-first-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>										
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>
						<!-- If this is the last text tab and selected, process -->						
						</xsl:when>
						<xsl:when test="position() = last()">
							<xsl:choose>
								<!-- If this tab has no output (links out of the pagegroup), process link as unselected -->
								<xsl:when test="@output = 'no'">
									<li class="ibm-last-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>										
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,$landing-page-name) and (string-length(pageinfo/@primary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)) = '/') or not(substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)-4) = '.html'))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is the last text tab and unselected, process -->
								<xsl:otherwise>
									<li class="ibm-last-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:when>
						<!-- If this is a middle text tab and selected, process -->
						<xsl:otherwise>
							<xsl:choose>
								<!-- If this tab has no output (links out of the pagegroup), process link as unselected -->
								<xsl:when test="@output = 'no'">
									<li class="ibm-last-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>										
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(pageinfo/@primary-nav-url,$landing-page-name) and (string-length(pageinfo/@primary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)) = '/') or not(substring(pageinfo/@primary-nav-url,string-length(pageinfo/@primary-nav-url)-4) = '.html'))">
									<li class="ibm-highlight-tab">
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-access">- selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is a middle text tab and unselected, process -->
								<xsl:otherwise>
									<li>
										<a href="{pageinfo/@primary-nav-url}">
											<xsl:value-of select="pageinfo/@primary-nav-name"/>
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</ul>
			<!-- Build content space navigation, if requested -->
			<xsl:call-template name="TabbedNavSecondaryText-v16"/>
			<!-- Rule provides correct spacing between text tabs and content in the framed container below the tabs -->
			<div class="ibm-rule"><hr /></div>
		</div>
    </xsl:template>
    <!-- NOT USED FOR 7.0 -->
	<!-- Template to build secondary tab code for landing pagegroup navigation -->
    <xsl:template name="TabbedNavSecondary-v16">
		<!-- Important! Do not remove landing-page-name parameter.  Needed here for standard/trial pagegroup pages to correctly process secondary tabs -->
		<xsl:param name="landing-page-name" />
		<!-- Tabs are constructed left to right in order of the page elements in the XML; limit is five tabs -->
		<div class="ibm-tab-section ibm-text">
			<xsl:choose>
				<xsl:when test="/dw-document/dw-landing-generic-pagegroup-hidef"><p class="ibm-access">Tab navigation</p></xsl:when>
				<xsl:otherwise><h2 class="ibm-access">Tab navigation</h2></xsl:otherwise>
			</xsl:choose>
			<ul class="ibm-tabs">
				<xsl:for-each select="(../../../subpage-hidef) | (../../../subpage)">
					<xsl:choose>
						<!-- If this is the first text tab and selected, process -->
						<xsl:when test="position() = 1">
							<xsl:choose>
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,$landing-page-name) and (string-length(subpageinfo/@secondary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)) = '/') or not(substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)-4) = '.html'))">
									<li class="ibm-first-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is the first text tab and unselected, process -->
								<xsl:otherwise>
									<li class="ibm-first-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:when>
						<xsl:when test="position() = last()">
							<xsl:choose>
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,$landing-page-name) and (string-length(subpageinfo/@secondary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)) = '/') or not(substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)-4) = '.html'))">
									<li class="ibm-last-tab ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is the first text tab and unselected, process -->
								<xsl:otherwise>
									<li class="ibm-last-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<!-- If this is middle text tab and selected, process -->
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,concat('/',$landing-page-name))">
									<li class="ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<xsl:when test="contains(subpageinfo/@secondary-nav-url,$landing-page-name) and (string-length(subpageinfo/@secondary-nav-url) = string-length($landing-page-name))">
									<li class="ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- Test to catch a URL that ends with a slash or does not end with .html; assume this is a folder name, which maps to a page name of index.html -->
								<xsl:when test="($landing-page-name='index.html') and ((substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)) = '/') or not(substring(subpageinfo/@secondary-nav-url,string-length(subpageinfo/@secondary-nav-url)-4) = '.html'))">
									<li class="ibm-highlight-tab">
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-access"> - selected tab,</span><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:when>
								<!-- If this is middle text tab and unselected, process -->
								<xsl:otherwise>
									<li>
										<a href="{subpageinfo/@secondary-nav-url}">
											<xsl:value-of select="subpageinfo/@secondary-nav-name"/>
										</a><span class="ibm-sep"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
									</li>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</ul>
			<!-- If a standard/trial pagegroup page, add rule between end of tabs and contents in tab frame -->
			<xsl:if test="ancestor::subpage">
				<div class="ibm-rule"><hr /></div>
			</xsl:if>
		</div>
  </xsl:template>  
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process secondary navigation under text tabs -->
  <xsl:template name="TabbedNavSecondaryText-v16">
		<!-- When inline navigation is requested, determine number of columns in link list; future option is content link list -->
		<xsl:variable name="columns">
			<xsl:choose>
				<!-- Anchor link list (one column) -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list'">1</xsl:when>
				<!-- When two-column anchor link list is selected, ensure list has at least two items; if not build one-column link list -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list-two-column'">
					<xsl:choose>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">2</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- When three-column anchor link list is selected, ensure list has at least three items; if not build two-column link list -->
				<xsl:when test="../../@content-space-secondary-navigation='anchor-link-list-three-column'">
					<xsl:choose>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 2)">3</xsl:when>
						<xsl:when test="(count(following::content[1]/module//container-heading) + count(following::content[1]/module//heading[@type='major']) > 1)">2</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>			
		</xsl:variable>
		<!-- ANCHOR LINK LIST -->
		<xsl:if test="(../../@content-space-secondary-navigation = 'anchor-link-list') or (../../@content-space-secondary-navigation = 'anchor-link-list-two-column') or (../../@content-space-secondary-navigation = 'anchor-link-list-three-column')">		
			<xsl:comment>ANCHOR_LINK_LIST_BEGIN</xsl:comment>
			<h2 class="ibm-access">Page navigation</h2>
			<div>
				<xsl:choose>
					<xsl:when test="$columns = 3">
						<xsl:attribute name="class">ibm-tabs ibm-three-column ibm-inner-list</xsl:attribute>
					</xsl:when>
					<xsl:when test="$columns = 2">
						<xsl:attribute name="class">ibm-tabs ibm-two-column ibm-inner-list</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-tabs ibm-inner-list</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Build first column -->
				<div class="ibm-column ibm-first">
					<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
						<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
						<xsl:with-param name="column-active">1</xsl:with-param>
					</xsl:call-template>			
				</div>
				<!-- Build second column -->
				<xsl:if test="$columns > 1">
					<div class="ibm-column ibm-second">
						<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
							<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
							<xsl:with-param name="column-active">2</xsl:with-param>
						</xsl:call-template>
					</div>					
				</xsl:if>
				<!-- Build third column -->
				<xsl:if test="$columns > 2">
					<div class="ibm-column ibm-third">
						<xsl:call-template name="PagegroupContentSpaceNavigationLinkList-v16">
							<xsl:with-param name="column-total"><xsl:value-of select="$columns"/></xsl:with-param>
							<xsl:with-param name="column-active">3</xsl:with-param>
						</xsl:call-template>
					</div>					
				</xsl:if>
			</div>
			<xsl:comment>ANCHOR_LINK_LIST_END</xsl:comment>
		</xsl:if>
  </xsl:template> 
  <!-- NOT USED FOR 7.0 --> 
  <!-- Template to build primary tab code for landing pagegroup navigation -->
  <xsl:template name="TabSelected-v16">
		<xsl:param name="tabValue"/>
		<xsl:param name="tabSelectedName">
			<xsl:choose>
				<!-- If this is a self-contained page, check pageinfo element -->
				<xsl:when test="//page-hidef[$tabValue]/pageinfo">
					<xsl:value-of select="//page-hidef[$tabValue]/pageinfo/@primary-nav-name" />                  
				</xsl:when>
				<xsl:when test="//page[$tabValue]/pageinfo">
					<xsl:value-of select="//page[$tabValue]/pageinfo/@primary-nav-name" />                  
				</xsl:when>             
				<!-- Otherwise, get name from the subpage element -->
				<xsl:when test="//page[$tabValue]/subpage[1]/subpageinfo/@primary-nav-name">
					<xsl:value-of select="//page[$tabValue]/subpage[1]/subpageinfo/@primary-nav-name" />                  
				</xsl:when>
				<xsl:otherwise>              
					<xsl:value-of select="//page-hidef[$tabValue]/subpage-hidef[1]/subpageinfo/@primary-nav-name" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="tabSelectedURL">
			<xsl:choose>
				<!-- If this is a self-contained page, check pageinfo element -->
				<xsl:when test="//page-hidef[$tabValue]/pageinfo">
					<xsl:value-of select="//page-hidef[$tabValue]/pageinfo/@primary-nav-url" />                  
				</xsl:when>
				<xsl:when test="//page[$tabValue]/pageinfo">
					<xsl:value-of select="//page[$tabValue]/pageinfo/@primary-nav-url" />                  
				</xsl:when>              
				<!-- Otherwise, get URL from the first subpage element; graphical tab and first subpage share same URL -->
				<xsl:when test="//page[$tabValue]/subpage[1]/subpageinfo/@secondary-nav-url">
					<xsl:value-of select="//page[$tabValue]/subpage[1]/subpageinfo/@secondary-nav-url" />                  
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//page-hidef[$tabValue]/subpage-hidef[1]/subpageinfo/@secondary-nav-url" />
				</xsl:otherwise>
          </xsl:choose>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="$tabValue = 1">
				<li class="ibm-first-tab ibm-highlight-tab">
					<a href="{$tabSelectedURL}">
						<xsl:value-of select="$tabSelectedName"/>
					</a><span class="ibm-access">- selected tab,</span>
				</li>
			</xsl:when>
			<xsl:when test="$tabValue = count(//page-hidef)">
				<li class="ibm-last-tab ibm-highlight-tab">
					<a href="{$tabSelectedURL}">
						<xsl:value-of select="$tabSelectedName"/>
					</a><span class="ibm-access">- selected tab,</span>
				</li>
			</xsl:when>
			<xsl:when test="$tabValue = count(//page)">
				<li class="ibm-last-tab ibm-highlight-tab">
					<a href="{$tabSelectedURL}">
						<xsl:value-of select="$tabSelectedName"/>
					</a><span class="ibm-access">- selected tab,</span>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li class="ibm-highlight-tab">
					<a href="{$tabSelectedURL}">
						<xsl:value-of select="$tabSelectedName"/>
					</a><span class="ibm-access">- selected tab,</span>
				</li>
			</xsl:otherwise>
		</xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to build primary tab code for landing pagegroup navigation -->
  <xsl:template name="TabUnselected-v16">
		<xsl:param name="tabValue"/>
		<xsl:param name="tabUnselectedName">
			<xsl:choose>
				<!-- If this is a self-contained page, check pageinfo element -->
				<xsl:when test="//page-hidef[$tabValue]/pageinfo">
					<xsl:value-of select="//page-hidef[$tabValue]/pageinfo/@primary-nav-name" />                  
				</xsl:when>
				<xsl:when test="//page[$tabValue]/pageinfo">
					<xsl:value-of select="//page[$tabValue]/pageinfo/@primary-nav-name" />                  
				</xsl:when>             
				<!-- Otherwise, get name from the subpage element -->
				<xsl:when test="//page[$tabValue]/subpage[1]/subpageinfo/@primary-nav-name">
					<xsl:value-of select="//page[$tabValue]/subpage[1]/subpageinfo/@primary-nav-name" />                  
				</xsl:when>              
				<xsl:otherwise>              
					<xsl:value-of select="//page-hidef[$tabValue]/subpage-hidef[1]/subpageinfo/@primary-nav-name" />
				</xsl:otherwise>
			</xsl:choose>		
		</xsl:param>
		<xsl:param name="tabUnselectedURL">
			<xsl:choose>
				<!-- If this is a self-contained page, check pageinfo element -->
				<xsl:when test="//page-hidef[$tabValue]/pageinfo">
					<xsl:value-of select="//page-hidef[$tabValue]/pageinfo/@primary-nav-url" />                  
				</xsl:when>              
				<xsl:when test="//page[$tabValue]/pageinfo">
					<xsl:value-of select="//page[$tabValue]/pageinfo/@primary-nav-url" />                  
				</xsl:when>              
				<!-- Otherwise, get URL from the first subpage element; graphical tab and first subpage share same URL -->
				<xsl:when test="//page[$tabValue]/subpage[1]/subpageinfo/@secondary-nav-url">
					<xsl:value-of select="//page[$tabValue]/subpage[1]/subpageinfo/@secondary-nav-url" />                  
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//page-hidef[$tabValue]/subpage-hidef[1]/subpageinfo/@secondary-nav-url" />
				</xsl:otherwise>
          </xsl:choose>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="$tabValue = 1">
				<li class="ibm-first-tab">
					<a href="{$tabUnselectedURL}">
						<xsl:value-of select="$tabUnselectedName"/>
					</a>
				</li>
			</xsl:when>
			<xsl:when test="$tabValue = count(//page-hidef)">
				<li class="ibm-last-tab">
					<a href="{$tabUnselectedURL}">
						<xsl:value-of select="$tabUnselectedName"/>
					</a>
				</li>
			</xsl:when>
			<xsl:when test="$tabValue = count(//page)">
				<li class="ibm-last-tab">
					<a href="{$tabUnselectedURL}">
						<xsl:value-of select="$tabUnselectedName"/>
					</a>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<a href="{$tabUnselectedURL}">
						<xsl:value-of select="$tabUnselectedName"/>
					</a>
				</li>
			</xsl:otherwise>
		</xsl:choose>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="table">
    <xsl:if test="ancestor::li and not(preceding-sibling::heading[1]) and (
                                                       ((//date-published/@year&gt;=2006 and //date-published/@month&gt;=06) or (//date-published/@year&gt;2006))
                                                       or
                                                       ((//date-updated/@year&gt;=2006 and //date-updated/@month&gt;=06) or (//date-updated/@year&gt;2006))
                                                       )"><xsl:text disable-output-escaping="yes"><![CDATA[<br /><br />]]></xsl:text></xsl:if>
    <table>
      <xsl:for-each select="@border | @cellpadding | @cellspacing | @class | @cols | @summary | @width">
        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates select="*"/>
    </table>
    <xsl:if test="ancestor::li and (
                                               ((//date-published/@year&gt;=2006 and //date-published/@month&gt;=06) or (//date-published/@year&gt;2006))
                                               or
                                               ((//date-updated/@year&gt;=2006 and //date-updated/@month&gt;=06) or (//date-updated/@year&gt;2006))
                                              )"><xsl:text disable-output-escaping="yes"><![CDATA[<br /><br />]]></xsl:text></xsl:if>    
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="td">
    <td>
      <xsl:for-each select="@bgcolor | @headers | @height | @width | @class | @style | @colspan | @rowspan | @align | @valign">
        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates select="*|text()"/>
    </td>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="th">
    <th>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </th>
  </xsl:template>
  <!--NOT USED FOR 7.0 -->
  <xsl:template match="caption">
    <caption>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </caption>
  </xsl:template> 
<!--NOT USED FOR 7.0 -->
  <xsl:template match="em">
    <xsl:choose>
	   <xsl:when test="string-length(normalize-space(.)) = 0">
           <xsl:apply-templates />
      </xsl:when>
      <xsl:otherwise>
		  <em>
			  <xsl:for-each select="@*">
				<xsl:copy/>
			  </xsl:for-each>
			  <xsl:apply-templates/>
		 </em>
      </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to create title and subtitle in summary area -->
  <xsl:template name="Title-v16">
	  <xsl:choose>
		  <!-- Process home page title/subtitle -->
		  <xsl:when test="/dw-document/dw-dwtop-home">
			  <div id="ibm-content-head" class="ibm-content-subtitle ibm-content-expand">
			  <h1 class="dwtop">
				  <xsl:value-of select="/dw-document/dw-dwtop-home/title" />
			  </h1>
			  <p><em>
			  	  <xsl:apply-templates select="/dw-document/dw-dwtop-home/subtitle"/>
			  </em></p>
			  </div>
		  </xsl:when>
		  <!-- Process zone overview page title/subtitle -->
		  <xsl:when test="/dw-document/dw-dwtop-zoneoverview">
			  <xsl:choose>
				  <xsl:when test="normalize-space(/dw-document/dw-dwtop-zoneoverview/subtitle)">
					  <div id="ibm-content-head" class="ibm-content-subtitle ibm-content-expand dwwordmark">
						  <ul id="ibm-navigation-trail">
						    <li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>
						    <li>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$technical-topics-url" />
									</xsl:attribute>
										<xsl:value-of select="$technical-topics-text" />									
								</xsl:element>	
							</li>					    
						  </ul>
						  <h1>
							  <xsl:value-of select="/dw-document/dw-dwtop-zoneoverview/title" />
						  </h1>
						  <p>
							  <em>
								  <xsl:apply-templates select="/dw-document/dw-dwtop-zoneoverview/subtitle"/>
							  </em>
						  </p>
					  </div>
				  </xsl:when>
				  <xsl:otherwise>
					  <!-- Remove ibm-content-subtitle class -->
					  <div id="ibm-content-head" class="ibm-content-expand dwwordmark">				    
						  <ul id="ibm-navigation-trail">
						    <li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>
						    <li>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$technical-topics-url" />
									</xsl:attribute>
										<xsl:value-of select="$technical-topics-text" />									
								</xsl:element>	
							</li>		
						  </ul>
						  <h1>
							  <xsl:value-of select="/dw-document/dw-dwtop-zoneoverview/title" />
						  </h1>
					  </div>
				  </xsl:otherwise>
			  </xsl:choose>
		  </xsl:when>
		  <!-- Process landing generic bct/title/subtitle -->
		  <xsl:when test="/dw-document/dw-landing-generic">
			<div>
				<xsl:choose>
					<!-- If landing page calls for a multicolumn leadspace image, title area is updated with a new class -->
				    <xsl:when test="//featured-content-module/leadspace/@multicolumn = 'yes'">
						<xsl:attribute name="class">ibm-content-head ibm-content-expand</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-content-head</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Create correct div based on whether or not there is a subtitle -->
				<div>
					<xsl:choose>
						<xsl:when test="normalize-space(//subtitle)">
							<xsl:attribute name="class">ibm-content-subtitle ibm-content-expand dwwordmark</xsl:attribute>
							<xsl:attribute name="id">ibm-content-head</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">ibm-content-expand dwwordmark</xsl:attribute>
							<xsl:attribute name="id">ibm-content-head</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<ul id="ibm-navigation-trail">
						<li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading"/></a></li>
						<xsl:if test="not(//content-area-primary/@name = 'none')">
						<li>
							<xsl:element name="a">
								<xsl:attribute name="href">
									<xsl:value-of select="$technical-topics-url" />
								</xsl:attribute>
									<xsl:value-of select="$technical-topics-text" />									
							</xsl:element>							
						</li>
						</xsl:if>
						<!-- Create standard bct if there is a primary content area and no secondary content areas -->
						<xsl:if test="not(//content-area-primary/@name = 'none') and not(normalize-space(//content-area-secondary/@name))">
							<li>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="$developerworks-top-url"/> 
										<xsl:value-of select="//content-area-primary/@name"/>
										<!-- Ending slash for folder -->
										<xsl:text>/</xsl:text>								
									</xsl:attribute>
									<xsl:call-template name="ContentAreaName">
										<xsl:with-param name="contentarea">
											<xsl:value-of select="//content-area-primary/@name"/>
										</xsl:with-param>
									</xsl:call-template>
								</a>
							</li>
						</xsl:if>
						<xsl:call-template name="LandingBreadcrumbSubLevel-v16"/>
					</ul>
					<h1>
						<xsl:value-of select="//title"/>
					</h1>
					<xsl:if test="normalize-space(//subtitle)">
						<p>
							<em>
								<xsl:apply-templates select="//subtitle"/>
							</em>
						</p>
					</xsl:if>	
				</div>
				<!-- Create div for a multicolumn leadspace image if required -->				
				<xsl:choose>
					<xsl:when test="//featured-content-module/leadspace-decorative/@multicolumn='yes'">
						<xsl:comment>FEATURE_BEGIN</xsl:comment>
						<div id="ibm-leadspace">	
							<!-- Set variable to process background image for preview -->
							<xsl:variable name="leadspace-decorative-wideimage-url">
								<xsl:call-template name="generate-correct-url-form">
									<xsl:with-param name="input-url" select="//featured-content-module/leadspace-decorative/image-url" />
								</xsl:call-template>
							</xsl:variable>					
							<img>
								<xsl:attribute name="src">
									<xsl:value-of select="$leadspace-decorative-wideimage-url"/>
								</xsl:attribute>
								<xsl:attribute name="width">710</xsl:attribute>
								<xsl:choose>
									<xsl:when test="normalize-space(//featured-content-module/leadspace-decorative/height)">
										<xsl:attribute name="height">
											<xsl:value-of select="//featured-content-module/leadspace-decorative/height"/>
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="width">200</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name="alt">
									<xsl:value-of select="//featured-content-module/leadspace-decorative/image-alt" />
								</xsl:attribute>
							</img>
						</div>
						<xsl:comment>FEATURE_END</xsl:comment>
					</xsl:when>
					<xsl:when test="//featured-content-module/leadspace/@multicolumn='yes'">
						<xsl:comment>FEATURE_BEGIN</xsl:comment>
						<div id="ibm-leadspace">	
							<!-- Set variable to process background image for preview -->
							<xsl:variable name="leadspace-wideimage-url">
								<xsl:call-template name="generate-correct-url-form">
									<xsl:with-param name="input-url" select="//featured-content-module/leadspace/image-url" />
								</xsl:call-template>
							</xsl:variable>						
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="//featured-content-module/leadspace/target-url"/>
								</xsl:attribute>
								<img>
									<xsl:attribute name="src">
										<xsl:value-of select="$leadspace-wideimage-url"/>
									</xsl:attribute>
									<xsl:attribute name="width">710</xsl:attribute>
									<xsl:choose>
										<xsl:when test="normalize-space(//featured-content-module/leadspace/height)">
											<xsl:attribute name="height">
												<xsl:value-of select="//featured-content-module/leadspace/height"/>
											</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="height">200</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:attribute name="border">0</xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:value-of select="//featured-content-module/leadspace/image-alt" />
									</xsl:attribute>									
								</img>
							</a>
						</div>
						<xsl:comment>FEATURE_END</xsl:comment>
					</xsl:when>
				</xsl:choose>
			</div>
		 </xsl:when>		
		 <!-- Process bct/title/subtitle -->
		  <xsl:when test="/dw-document/dw-landing-generic-pagegroup | /dw-document/dw-trial-program-pages">
			<div>
				<xsl:choose>
					<!-- If landing page calls for a multicolumn leadspace image, title area is updated with a new class -->
				    <xsl:when test="following::content[1]/featured-content-module/leadspace/@multicolumn = 'yes'">
						<xsl:attribute name="class">ibm-content-head ibm-content-expand</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">ibm-content-head</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Create correct div based on whether or not there is a pagegroup or page-level subtitle -->
				<div>
					<xsl:choose>
						<xsl:when test="normalize-space(//subtitle) or normalize-space(following::content[1]/page-subtitle)">
							<xsl:attribute name="class">ibm-content-subtitle ibm-content-expand dwwordmark</xsl:attribute>
							<xsl:attribute name="id">ibm-content-head</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">ibm-content-expand dwwordmark</xsl:attribute>
							<xsl:attribute name="id">ibm-content-head</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<ul id="ibm-navigation-trail">
						<li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading"/></a></li>
						<xsl:if test="//dw-landing-generic-pagegroup and not(//content-area-primary/@name = 'none')">
							<li>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$technical-topics-url" />
									</xsl:attribute>
										<xsl:value-of select="$technical-topics-text" />																		
								</xsl:element>
							</li>							
						</xsl:if>
						<xsl:if test="//dw-trial-program-pages">
							<li>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$evaluation-software-url" />
									</xsl:attribute>
										<xsl:value-of select="$evaluation-software-text" />									
								</xsl:element>
							</li>
						</xsl:if>
						<!-- Create standard bct if there is a primary content area and no secondary content areas -->
						<xsl:if test="not(//content-area-primary/@name = 'none') and not(normalize-space(//content-area-secondary/@name))">
							<li>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="$developerworks-top-url"/> 
										<xsl:value-of select="//content-area-primary/@name"/>
										<!-- Ending slash for folder -->
										<xsl:text>/</xsl:text>						
									</xsl:attribute>
									<xsl:call-template name="ContentAreaName">
										<xsl:with-param name="contentarea">
											<xsl:value-of select="//content-area-primary/@name"/>
										</xsl:with-param>
									</xsl:call-template>
								</a>
							</li>
						</xsl:if>
						<xsl:call-template name="LandingBreadcrumbSubLevel-v16"/>
					</ul>
					<h1>
						<xsl:value-of select="//title"/>
					</h1>
					<!-- Process either the page-specific subtitle or pagegroup subtitle, if defined -->
					<xsl:choose>
						<xsl:when test="normalize-space(following::content[1]/page-subtitle)">
							<p>
								<em>
									<xsl:apply-templates select="following::content[1]/page-subtitle"/>
								</em>
							</p>
						</xsl:when>
						<xsl:when test="normalize-space(//subtitle)">
							<p>
								<em>
									<xsl:apply-templates select="//subtitle"/>
								</em>
							</p>
						</xsl:when>
					</xsl:choose>	
				</div>
				<!-- Create div for a multicolumn leadspace image if required -->								
				<xsl:choose>
					<xsl:when test="following::content[1]/featured-content-module/leadspace-decorative/@multicolumn = 'yes'">
						<xsl:comment>FEATURE_BEGIN</xsl:comment>
						<div id="ibm-leadspace">
							<img>
								<xsl:attribute name="src">
									<xsl:value-of select="following::content[1]/featured-content-module/leadspace-decorative/image-url"/>
								</xsl:attribute>
								<xsl:attribute name="width">710</xsl:attribute>
								<xsl:choose>
									<xsl:when test="normalize-space(following::content[1]/featured-content-module/leadspace-decorative/height)">
										<xsl:attribute name="height">
											<xsl:value-of select="following::content[1]/featured-content-module/leadspace-decorative/height"/>
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="width">200</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name="alt">
									<xsl:value-of select="following::content[1]/featured-content-module/leadspace-decorative/image-alt" />
								</xsl:attribute>
							</img>
						</div>
						<xsl:comment>FEATURE_END</xsl:comment>
					</xsl:when>					
					<xsl:when test="following::content[1]/featured-content-module/leadspace/@multicolumn = 'yes'">
						<xsl:comment>FEATURE_BEGIN</xsl:comment>
						<div id="ibm-leadspace">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="following::content[1]/featured-content-module/leadspace/target-url"/>
								</xsl:attribute>
								<img>
									<xsl:attribute name="src">
										<xsl:value-of select="following::content[1]/featured-content-module/leadspace/image-url"/>
									</xsl:attribute>
									<xsl:attribute name="width">710</xsl:attribute>
									<xsl:choose>
										<xsl:when test="normalize-space(following::content[1]/featured-content-module/leadspace/height)">
											<xsl:attribute name="height">
												<xsl:value-of select="following::content[1]/featured-content-module/leadspace/height"/>
											</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="height">200</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:attribute name="border">0</xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:value-of select="following::content[1]/featured-content-module/leadspace/image-alt" />
									</xsl:attribute>									
								</img>
							</a>
						</div>
						<xsl:comment>FEATURE_END</xsl:comment>
					</xsl:when>
				</xsl:choose>
			</div>
		 </xsl:when>		
				  <xsl:when test="/dw-document/dw-landing-product">
					<xsl:choose>
						<xsl:when test="normalize-space(//abstract-special-chars)">
							  <xsl:text disable-output-escaping="yes"><![CDATA[<div id="ibm-content-head" class="ibm-content-subtitle ibm-content-expand dwwordmark">]]></xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="yes"><![CDATA[<div id="ibm-content-head" class="ibm-content-expand dwwordmark">]]></xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					      <ul id="ibm-navigation-trail">
						    <li class="ibm-first"><a href="{$developerworks-top-url}"><xsl:value-of select="$developerworks-top-heading" /></a></li>
						    <li>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$technical-topics-url" />
									</xsl:attribute>
										<xsl:value-of select="$technical-topics-text" />									
								</xsl:element>							
							</li>
							<li>
								<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
									<xsl:value-of select="$developerworks-top-url"/>
									<xsl:value-of select="/dw-document//content-area-primary/@name"/>
								<xsl:text disable-output-escaping="yes"><![CDATA[/">]]></xsl:text>
								<xsl:call-template name="ContentAreaName">
									<xsl:with-param name="contentarea">
										<xsl:value-of select="/dw-document//content-area-primary/@name"/>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							</li>
							<li>	
								<xsl:variable name="products-breadcrumb-url">
									<xsl:call-template name="ProductsLandingURL">
										<xsl:with-param name="product-landing-url">
										<xsl:value-of select="/dw-document//content-area-primary/@name"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="normalize-space($products-breadcrumb-url)">
									<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
									  <xsl:value-of disable-output-escaping="yes" select="$products-breadcrumb-url"/>
								 	  <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
									  <xsl:value-of disable-output-escaping="yes" select="$products-heading"/>
									  <xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
								</xsl:if>
							</li>
							</ul>
							<h1>
							  <xsl:value-of select="/dw-document/dw-landing-product/title" />
						  </h1>
					  <xsl:text disable-output-escaping="yes"><![CDATA[</div>]]></xsl:text>
				  </xsl:when>
		  <!-- Process article title/subtitle -->
		  <xsl:otherwise>
			  <xsl:if test="normalize-space(/dw-document//title) !=''">
				  <h1>
				  <xsl:if test="normalize-space(/dw-document//series/series-title) !=''">
						  <xsl:value-of select="/dw-document//series/series-title"/><xsl:text>: </xsl:text>
					  </xsl:if>
<xsl:value-of select="/dw-document//title"/></h1>
			  </xsl:if>
			  <xsl:choose>
				  <xsl:when test="normalize-space(/dw-document//subtitle) !=''">
				      <xsl:choose>
				           <xsl:when test="/dw-document/dw-knowledge-path">
				                <p class="kp-subtitle"><strong><xsl:value-of select="/dw-document//subtitle"/></strong></p>
				           </xsl:when>
				          <xsl:otherwise>
				              <p><em><xsl:value-of select="/dw-document//subtitle"/></em></p>
				          </xsl:otherwise>
				      </xsl:choose>					  
				  </xsl:when>
				  <xsl:otherwise>
					  <p></p>
				  </xsl:otherwise>
			  </xsl:choose>
		  </xsl:otherwise>
	  </xsl:choose>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  	<xsl:template name="TableOfContents-v16">
      <div class="ibm-container">
      <h2>
		  <xsl:value-of select="$toc-heading"/>
	  </h2>
	  <div class="ibm-container-body">
      <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="1" height="1" alt="" />
		<ul class="ibm-bullet-list">
		<!-- Start:  Get docbody heading refids and build each TOC link -->
        <xsl:for-each select="//heading">
          <xsl:variable name="newid">
            <xsl:choose>
              <xsl:when test="@refname != ''">
                <xsl:value-of select="concat('#', @refname)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('#', generate-id())"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="toctext">
            <xsl:choose>
              <xsl:when test="@alttoc != ''">
                <xsl:value-of select="@alttoc"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:if test="@type='major'">
			  <li>
				  <a href="{$newid}" class="ibm-feature-link">
					  <xsl:value-of select="$toctext"/>
                </a>
              </li>
          </xsl:if>
        </xsl:for-each>
        <!-- End:  Get docbody heading refids and build each TOC link -->
        <!-- Start:  Build links to the standard sections -->
		  <xsl:if test="(//target-content-file or //target-content-page)">
			  <li>
				  <a href="#download" class="ibm-feature-link">
					<xsl:choose>
					  <xsl:when test="count(//target-content-file) > 1">
						<xsl:value-of select="$downloads-heading"/>
					  </xsl:when>
					  <xsl:otherwise>
						<xsl:value-of select="$download-heading"/>
					  </xsl:otherwise>
					</xsl:choose>
				  </a>
			  </li>
          </xsl:if>
          <xsl:if test="//resource-list | //resources">
			  <li>
				  <a href="#resources" class="ibm-feature-link">
					  <xsl:value-of select="$resource-list-heading"/>
				  </a>
			  </li>
          </xsl:if>
          <xsl:if test="//author/bio/.!=''">
			  <li>
				  <a href="#author" class="ibm-feature-link">
					<xsl:choose>
					  <xsl:when test="count(//author) = 1">
						<xsl:value-of select="$aboutTheAuthor"/>
					  </xsl:when>
					  <xsl:otherwise>
						<xsl:value-of select="$aboutTheAuthors"/>
					  </xsl:otherwise>
					</xsl:choose>
				  </a>
			  </li>
          </xsl:if>
          <!-- Insert link to inline comments section -->
		  <li>
			  <a href="#icomments" class="ibm-feature-link">
				  <xsl:value-of select="$inline-comments-heading"/>
			  </a>
		  </li>
		</ul>
	  </div>
	  </div>
	</xsl:template>
	<!--NOT USED FOR 7.0 -->
  <xsl:template match="tr">
    <tr>
      <xsl:for-each select="@*">
        <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates select="*"/>
    </tr>
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->		
	<xsl:template name="TranslationDateSummary-v16">
		<xsl:choose>
			<xsl:when test="/dw-document//@local-site='worldwide'">
			</xsl:when>
			<xsl:when test="/dw-document//@local-site='russia'">
				<xsl:if test="//date-translated">
					<xsl:variable name="monthtranslatedname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-translated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:text disable-output-escaping="yes"><![CDATA[<br class="ibm-ind-link"/>]]></xsl:text>
					<strong><xsl:value-of select="$translated"/></strong><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
  					<xsl:if test="//date-translated/@day">
						<xsl:value-of select="//date-translated/@day"/>
						<xsl:copy-of select="$daychar"/>
						<xsl:text>.</xsl:text>
					</xsl:if>
					<xsl:value-of select="$monthtranslatedname"/>
					<xsl:copy-of select="$monthchar"/>
					<xsl:text>.</xsl:text>
					<xsl:value-of select="//date-translated/@year"/>
					<xsl:copy-of select="$yearchar"/>
				</xsl:if>
			</xsl:when>

			<xsl:when test="/dw-document//@local-site='vietnam'">
				<xsl:if test="//date-translated">
					<xsl:variable name="monthtranslatedname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-translated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:text disable-output-escaping="yes"><![CDATA[<br class="ibm-ind-link"/>]]></xsl:text>
					<strong><xsl:value-of select="$translated"/></strong><xsl:text
disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
					<xsl:text> </xsl:text>
					<xsl:if test="//date-translated/@day">
						<xsl:value-of select="//date-translated/@day"/>
						<xsl:copy-of select="$daychar"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$monthtranslatedname"/>
					<xsl:copy-of select="$monthchar"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="//date-translated/@year"/>
					<xsl:copy-of select="$yearchar"/>
				</xsl:if>
			</xsl:when>
			
			<xsl:when test="/dw-document//@local-site='ssa'">
				<xsl:if test="//date-translated">
					<xsl:variable name="monthtranslatedname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-translated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:text disable-output-escaping="yes"><![CDATA[<br class="ibm-ind-link"/>]]></xsl:text>
					<strong><xsl:value-of select="$translated"/></strong><xsl:text
disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
					<xsl:text> </xsl:text>
					<xsl:if test="//date-translated/@day">
						<xsl:value-of select="//date-translated/@day"/>
						<xsl:copy-of select="$daychar"/>
						<xsl:text>-</xsl:text>
					</xsl:if>
					<xsl:value-of select="$monthtranslatedname"/>
					<xsl:copy-of select="$monthchar"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="//date-translated/@year"/>
					<xsl:copy-of select="$yearchar"/>
				</xsl:if>
			</xsl:when>
			
			<xsl:when test="/dw-document//@local-site='brazil'">
				<xsl:if test="//date-translated">
					<xsl:variable name="monthtranslatedname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-translated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:text disable-output-escaping="yes"><![CDATA[<br class="ibm-ind-link"/>]]></xsl:text>
					<strong><xsl:value-of select="$translated"/></strong><xsl:text
disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
					<xsl:text> </xsl:text>
					<xsl:if test="//date-translated/@day">
						<xsl:value-of select="//date-translated/@day"/>
						<xsl:copy-of select="$daychar"/>
						<xsl:text>/</xsl:text>
					</xsl:if>
					<xsl:value-of select="$monthtranslatedname"/>
					<xsl:copy-of select="$monthchar"/>
					<xsl:text>/</xsl:text>
					<xsl:value-of select="//date-translated/@year"/>
					<xsl:copy-of select="$yearchar"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="//date-translated">
					<xsl:text disable-output-escaping="yes"><![CDATA[<br class="ibm-ind-link"/>]]></xsl:text><strong><xsl:value-of select="$translated"/></strong>
	       <xsl:choose>
		  <xsl:when test="/dw-document//@local-site='china'">
		      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
		  </xsl:when>
          <xsl:otherwise>      
	  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
          </xsl:otherwise>
      </xsl:choose>
					
					<xsl:value-of select="//date-translated/@year"/>
					<xsl:copy-of select="$yearchar"/>
					<xsl:text>  </xsl:text>
					<xsl:variable name="monthtranslatedname">
						<xsl:call-template name="MonthName">
							<xsl:with-param name="month">
								<xsl:value-of select="//date-translated/@month"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$monthtranslatedname"/>
					<xsl:copy-of select="$monthchar"/>
					<xsl:text>  </xsl:text>
					<xsl:if test="//date-translated/@day">
						<xsl:value-of select="//date-translated/@day"/>
						<xsl:copy-of select="$daychar"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <xsl:template match="twisty-section">  
	<xsl:element name="ul">
		<xsl:attribute name="class">ibm-twisty</xsl:attribute>
		<!-- Process each twisty -->
		<xsl:for-each select="twisty">
			<xsl:element name="li">
				<xsl:element name="a">
					<xsl:attribute name="class">ibm-twisty-trigger</xsl:attribute>
					<xsl:attribute name="href">#toggle</xsl:attribute>
					<img alt="+ Expand" src="{$ibm-c-dot-gif}" />
				</xsl:element>
				<!-- Process twisty heading -->
				<span class="ibm-twisty-head">
					<strong>
						<xsl:apply-templates select="twisty-heading" />
					</strong>
				</span>
				<!-- Process twisty body types -->
				<xsl:element name="div">
				    <xsl:attribute name="class">ibm-twisty-body</xsl:attribute>
					<xsl:choose>
						<!-- When twisty body has columns -->
						<xsl:when test="twisty-abstract | twisty-column">
							<xsl:if test="normalize-space(twisty-abstract)">
								<xsl:apply-templates select="twisty-abstract" />								
							</xsl:if>
                            <xsl:call-template name="TwistyBodyColumns-v16"/>
						</xsl:when>
						<!-- When twisty body contains free-form HTML tags -->
						<xsl:when test="twisty-html-body">
							<xsl:apply-templates select="twisty-html-body" />
						</xsl:when>
						<!-- When twisty body contains a second level of twisty sections -->
						<xsl:when test="twisty-level-two">							
							<xsl:element name="ul">
								<xsl:attribute name="class">ibm-twisty</xsl:attribute>
								<!-- Process each second-level twisty -->
								<xsl:for-each select="twisty-level-two">
									<xsl:element name="li">
										<xsl:element name="a">
											<xsl:attribute name="class">ibm-twisty-trigger</xsl:attribute>
											<xsl:attribute name="href">#toggle</xsl:attribute>
											<img alt="+ Expand" src="{$ibm-c-dot-gif}" />
										</xsl:element>
										<!-- Process second-level twisty heading -->
										<span class="ibm-twisty-head">
											<strong>
												<xsl:apply-templates select="twisty-heading" />
											</strong>
										</span>
										<!-- Process second-level twisty body types -->
										<xsl:element name="div">
											<xsl:attribute name="class">ibm-twisty-body</xsl:attribute>
											<xsl:choose>
												<!-- When twisty body has columns -->
												<xsl:when test="twisty-abstract | twisty-column">
													<xsl:if test="normalize-space(twisty-abstract)">
														<xsl:apply-templates select="twisty-abstract" />								
													</xsl:if>
													<xsl:call-template name="TwistyBodyColumns-v16"/>
												</xsl:when>
												<!-- When twisty body contains free-form HTML tags -->
												<xsl:when test="twisty-html-body">
													<xsl:apply-templates select="twisty-html-body" />
												</xsl:when>
												<!-- When twisty body contains a third level of twisty sections -->
												<xsl:when test="twisty-level-three">
													<xsl:element name="ul">
														<xsl:attribute name="class">ibm-twisty</xsl:attribute>
														<!-- Process each third-level twisty -->
														<xsl:for-each select="twisty-level-three">
															<xsl:element name="li">
																<xsl:element name="a">
																	<xsl:attribute name="class">ibm-twisty-trigger</xsl:attribute>
																	<xsl:attribute name="href">#toggle</xsl:attribute>
																	<img alt="+ Expand" src="{$ibm-c-dot-gif}" />
																</xsl:element>
																<!-- Process third-level twisty heading -->
																<span class="ibm-twisty-head">
																	<strong>
																		<xsl:apply-templates select="twisty-heading" />
																	</strong>
																</span>
																<!-- Process third-level twisty body -->
																<xsl:element name="div">
																	<xsl:attribute name="class">ibm-twisty-body</xsl:attribute>
																	<xsl:apply-templates select="twisty-html-body" />
																</xsl:element>
															</xsl:element>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>	
											</xsl:choose>
										</xsl:element>
									</xsl:element>
								</xsl:for-each>
							</xsl:element>
						</xsl:when>
					</xsl:choose>
				</xsl:element>
			</xsl:element>			
		</xsl:for-each>
	</xsl:element>	
  </xsl:template>
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process column content within twisty sections -->
  <xsl:template name="TwistyBodyColumns-v16">
	<xsl:element name="div">
		<!-- Select container column class -->
		<xsl:if test="count(twisty-column) = 2">
			<xsl:attribute name="class">ibm-two-column</xsl:attribute>
		</xsl:if>
		<xsl:if test="count(twisty-column) = 3">
			<xsl:attribute name="class">ibm-three-column</xsl:attribute>
		</xsl:if>
		<!-- Process content in each twisty column -->		
		<xsl:for-each select="twisty-column">
			<xsl:element name="div">
				<xsl:if test="position() = 1">
					<xsl:attribute name="class">ibm-column ibm-first</xsl:attribute>
				</xsl:if>
				<xsl:if test="position() = 2">
					<xsl:attribute name="class">ibm-column ibm-second</xsl:attribute>
				</xsl:if>
				<xsl:if test="position() = 3">
					<xsl:attribute name="class">ibm-column ibm-third</xsl:attribute>
				</xsl:if>
				<xsl:for-each select="forward-link-list | link-list">
					<xsl:if test="name(.)='forward-link-list'">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="name(.)='link-list'">
						<xsl:call-template name="TwistyLinkList-v16"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>		
	</xsl:element>  
  </xsl:template>  
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to process link lists within a twisty column -->
  <xsl:template name="TwistyLinkList-v16">
			<!-- Process link list heading -->
			<xsl:if test="normalize-space(link-list-heading)">
				<xsl:choose>
					<xsl:when test="normalize-space(link-list-heading/url)">
						<h3>
							<a href="{link-list-heading/url}" class="ibm-feature-link">
								<xsl:value-of select="link-list-heading/text"/>
							</a>							
						</h3>
					</xsl:when>
					<xsl:otherwise>
						<h3>
							<xsl:value-of select="link-list-heading/text"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<!-- Process link list content -->
			<xsl:choose>
				<!-- Arrow lists -->
				<xsl:when test="@style='arrow'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>
									<xsl:when test="@link-style = 'emphasized'">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text> 
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:for-each>	
					</ul>
				</xsl:when>
				<!-- First arrow bolded lists -->
				<xsl:when test="@style='first-arrow-bolded'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>							
									<xsl:when test="position() = 1">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-em-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-forward-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>								    
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:for-each>	
					</ul>
				</xsl:when>
				<!-- Ordered lists -->
				<xsl:when test="@style='ordered'">
					<ol class="ibm-bullet-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
								<xsl:value-of select="url"  />	
								<xsl:choose>
									<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
										<xsl:choose>
											<xsl:when test="@tactic='yes'">		
												<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
									</xsl:otherwise>	
								</xsl:choose>
								<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
								<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
							</li>
						</xsl:for-each>	
					</ol>
				</xsl:when>
				<!-- Icon/Arrow combination lists -->
				<xsl:when test="@style='icon-arrow-combination'">
					<ul class="ibm-link-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<!-- If link style is unemphasized, output a normal arrow and normal text -->
								<xsl:choose>
									<xsl:when test="@link-style = 'unemphasized'">
										<a>
											<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:when>
									<!-- If link style is emphasized, output a bold arrow and bolded text -->
									<xsl:when test="@link-style = 'emphasized'">
										<a>
											<xsl:attribute name="class">ibm-forward-em-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<strong><xsl:value-of select="text"/></strong>
										</a>
									</xsl:when>
									<!-- If link style is NOT specified, output a normal arrow with normal text -->
									<xsl:when test="not(normalize-space(@link-style))">
										<a>
											<xsl:attribute name="class">ibm-forward-link</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:when>
									<!-- Otherwise, assume link style references an icon and output the icon with normal text -->
									<xsl:otherwise>
										<a>
											<xsl:attribute name="class">
												<xsl:call-template name="ForwardLinkIcon">
													<xsl:with-param name="style" select="@link-style"/>
												</xsl:call-template>
											</xsl:attribute>
											<xsl:attribute name="href">
												<xsl:value-of select="url"/>
											</xsl:attribute>
											<xsl:value-of select="text"/>
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<!-- Processes new indicator for Japanese pages (comes at the end of the link text on all maverick list items)  -->
							<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')">
								<xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text>
							</xsl:if>
						</xsl:for-each>	
					</ul>
				</xsl:when>	
				<!-- Bulleted lists -->
				<xsl:otherwise>
					<ul class="ibm-bullet-list">
						<xsl:for-each select="link-list-item"> 
							<li>
								<xsl:choose>
									<xsl:when test="@link-style = 'emphasized'">
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<strong><xsl:value-of select="text"/></strong>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes"><![CDATA[<a class="ibm-feature-link" href="]]></xsl:text>
										<xsl:value-of select="url"  />	
										<xsl:choose>
											<xsl:when test="normalize-space(/dw-document//tactic-code-urltactic)!=''">									
												<xsl:choose>
													<xsl:when test="@tactic='yes'">		
														<xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="linkQueryAppend(this)">]]></xsl:text>   
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
											</xsl:otherwise>	
										</xsl:choose>
											<xsl:value-of select="text"/>
	<xsl:if test="(/dw-document//@local-site='japan') and (@new='yes')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="ibm-important"><strong>&nbsp;New !</strong></span>]]></xsl:text></xsl:if>
										<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
									</xsl:otherwise>
								</xsl:choose>

							</li>
						</xsl:for-each>	
					</ul>
				</xsl:otherwise>
			</xsl:choose>
  </xsl:template>
  <!-- UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU -->
  <!-- NOT USED FOR 7.0 -->
  <!-- Template to place tactic code specified in tactic-code-urltactic element for SetDefaultQuery -->
	<xsl:template name="urlTactic-v16">
		<xsl:if test="normalize-space(/dw-document//tactic-code-urltactic) or (/dw-document/dw-trial-program-pages/pagegroup/tactic-code-urltactic)!=''">
			<xsl:value-of select="/dw-document//tactic-code-urltactic"/>
		</xsl:if>
		<xsl:if test="not(normalize-space(/dw-document//tactic-code-urltactic))">
			<xsl:text>defaultHere</xsl:text>
		</xsl:if>
	</xsl:template>
  <!-- VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV -->
  <!-- WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW -->
  <!-- NOT USED FOR 7.0 -->
  	<!-- Template creates the link rel for one or more web feeds --> 
	<xsl:template name="webFeedDiscovery-v16">
		<xsl:param name="landing-page-name" />
		<!-- Include link rel tag if web-feed-autodiscovery element(s) are specified  -->
		<xsl:if test="normalize-space(/dw-document//web-feed-autodiscovery/@feed-type)!='' or (/dw-document/dw-trial-program-pages/pagegroup//content/meta-information/web-feed-autodiscovery/@feed-type)!='' or (/dw-document/dw-landing-generic-pagegroup/pagegroup//content/meta-information/web-feed-autodiscovery/@feed-type)!=''">
		<xsl:choose>
			<xsl:when test="/dw-document//pagegroup">
				<xsl:if test="normalize-space(following::content[1]/meta-information/web-feed-autodiscovery/@feed-url)">
					<xsl:text disable-output-escaping="yes"><![CDATA[<link rel="alternate" type="]]></xsl:text>
					<xsl:choose>
						<xsl:when test="following::content[1]/meta-information/web-feed-autodiscovery/@feed-type = 'rss'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/rss+xml" title="]]></xsl:text>
						</xsl:when>
						<xsl:when test="following::content[1]/meta-information/web-feed-autodiscovery/@feed-type = 'atom'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/atom+xml" title="]]></xsl:text>
						</xsl:when>
					</xsl:choose> 
					<xsl:value-of select="following::content[1]/meta-information/web-feed-autodiscovery/@feed-title"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" href="]]></xsl:text>
					<xsl:value-of select="following::content[1]/meta-information/web-feed-autodiscovery/@feed-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="/dw-document//pagegroup-hidef">
				<xsl:if test="normalize-space(following::content[1]/meta-information/web-feed-autodiscovery/@feed-url)">
					<xsl:text disable-output-escaping="yes"><![CDATA[<link rel="alternate" type="]]></xsl:text>
					<xsl:choose>
						<xsl:when test="following::content[1]/meta-information/web-feed-autodiscovery/@feed-type = 'rss'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/rss+xml" title="]]></xsl:text>
						</xsl:when>
						<xsl:when test="following::content[1]/meta-information/web-feed-autodiscovery/@feed-type = 'atom'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/atom+xml" title="]]></xsl:text>
						</xsl:when>
					</xsl:choose> 
					<xsl:value-of select="following::content[1]/meta-information/web-feed-autodiscovery/@feed-title"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" href="]]></xsl:text>
					<xsl:value-of select="following::content[1]/meta-information/web-feed-autodiscovery/@feed-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
				</xsl:if>
			</xsl:when> 
			<xsl:otherwise>
				<xsl:for-each select="/dw-document//web-feed-autodiscovery">
					<xsl:text disable-output-escaping="yes"><![CDATA[<link rel="alternate" type="]]></xsl:text>
					<xsl:choose>
						<xsl:when test="@feed-type = 'rss'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/rss+xml" title="]]></xsl:text>
						</xsl:when>
						<xsl:when test="@feed-type = 'atom'">
							<xsl:text disable-output-escaping="yes"><![CDATA[application/atom+xml" title="]]></xsl:text>
						</xsl:when>
					</xsl:choose> 
					<xsl:value-of select="@feed-title"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" href="]]></xsl:text>
					<xsl:value-of select="@feed-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[" />]]></xsl:text>
				</xsl:for-each> 				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	</xsl:template>
 <!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->	
 <!-- NOT USED FOR 7.0 -->
 <!-- Add no-escaping mode form of xref for correct computation of code line
    lengths. 
-->
    <xsl:template match="xref" mode="no-escaping">
        <xsl:call-template name="xref" />
     </xsl:template>
    
<!-- iProcess xref element to generate text to refer to a figure, listing
    or table. For example "Figure 5".
-->
    <xsl:template match="xref" name="xref">
        <xsl:choose>
            <xsl:when test="/dw-document/*/@auto-number='yes' ">
                <!-- Strip leading # if present -->
                <xsl:variable name="this-name">
                    <xsl:choose>
                        <xsl:when test="starts-with(@href, '#')">
                            <xsl:value-of select="substring(@href, 2)" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@href" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="this-xref" select="." />
                <!-- Test that there is a matching name or refname somewhere in the document and
            complain if not -->
                <xsl:variable name="target-key"
                    select="key('target-names', $this-name) |
                key('target-refnames', $this-name) | key('target-downloads',
                $this-name) | key('target-resources', $this-name)" />
                <xsl:variable name="target-key-count" select="count($target-key)" />
                <xsl:choose>
                    <xsl:when test="$target-key-count = 0">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat('MATCHING HEADING NOT FOUND!
                                No matching anchor was found for xref &lt;xref href=&quot;', 
                                @href, '&quot;&gt;'))"
                             />
                        </xsl:message>
                    </xsl:when>
                    <xsl:when test="$target-key-count != 1">
                        <xsl:message>
                            <xsl:value-of
                                select="normalize-space(concat( 'MULTIPLE ANCHOR MATCHES FOUND! ',  
                                count($target-key) , ' possible targets for &lt;a
                                href=&quot;', @href, '> &quot;&gt;'))"
                             />
                        </xsl:message>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@link='yes'">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('#',$this-name)" />
                            </xsl:attribute>
                            <xsl:call-template name="heading-auto">
                                <xsl:with-param name="for-heading" select="$target-key" />
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="heading-auto">
                            <xsl:with-param name="for-heading" select="$target-key" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
              
             </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">
                    <xsl:value-of
                        select="normalize-space(concat('Cannot use &lt;xref&gt; element without
                    auto-number=&quot;yes&quot; attribute on ',
                    local-name(/dw-document/*[1])))"
                     />
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ -->
    <!-- NOT USED FOR 7.0 -->
    <xsl:template name="ZoneLeftNav-v16">
		<xsl:choose>
			<xsl:when test="not(normalize-space(//left-nav-include))">
				<xsl:value-of select="$zoneleftnav-path" /><xsl:text disable-output-escaping="yes">s-nav16.ftl</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<!-- Parse the left-nav-include element to build left navigation include file name with correct extension; also convert old nav14 includes to nav16 .ftl includes -->
				<xsl:variable name="leftNavName">
					<xsl:value-of select="substring-before(//left-nav-include,'.')"/>
				</xsl:variable>
				<xsl:variable name="leftNavZone">
					<xsl:value-of select="substring-before($leftNavName,'nav')"/>
				</xsl:variable>
				<xsl:variable name="leftNavArea">
					<xsl:if test="contains($leftNavName,'14')">
						<xsl:value-of select="substring-after($leftNavName,'14')"/>
					</xsl:if>
					<xsl:if test="contains($leftNavName,'16')">
						<xsl:value-of select="substring-after($leftNavName,'16')"/>
					</xsl:if>
				</xsl:variable>
				<xsl:value-of select="$zoneleftnav-path" />
				<xsl:value-of select="$leftNavZone"/><xsl:text>nav16</xsl:text><xsl:value-of select="$leftNavArea"/><xsl:text>.ftl</xsl:text>
			</xsl:otherwise>
		</xsl:choose>	  	
    </xsl:template> 
</xsl:stylesheet>