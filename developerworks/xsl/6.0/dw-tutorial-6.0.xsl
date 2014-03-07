<?xml version="1.0" encoding="UTF-8"?>
<!-- egd added these two lines from dw-article xsl -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- 09/16/09 (tdc):  PURPOSE:  This is the dw-tutorial xsl for the Maverick beta.  It
   is largely based on the dw-article-6.0.xsl file.  The Maveric application, using the
   tutorial  transform XML in memory, passes a variable to this XSL.  The XSL processes
   that variable by calling the main template that transforms that piece of the tutorial. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
   <!-- ========================================= -->
   <!-- Global variables and parameters -->
   <!-- ========================================= -->
   <!-- Passed from external application (Mav engine): START -->
   <xsl:param name="page-type" />
   <xsl:param name="page-name" select=" '' "/>
   <!-- Passed from external application (Mav engine): END -->
   <xsl:variable name="sectionCount" select="count(/dw-document/dw-tutorial/section)" />
   <xsl:variable name="downloadCount">
      <xsl:choose>
         <xsl:when
            test="/dw-document/dw-tutorial/target-content-file or /dw-document/dw-tutorial/target-content-page">
            <xsl:number value="1" />
         </xsl:when>
         <xsl:otherwise>
            <xsl:number value="0" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="resourceCount">
      <xsl:choose>
         <xsl:when test="/dw-document/dw-tutorial/resources">
            <xsl:number value="1" />
         </xsl:when>
         <xsl:otherwise>
            <xsl:number value="0" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="authorCount">
      <xsl:number value="1" />
   </xsl:variable>
   <xsl:variable name="pageCount">
      <xsl:value-of
         select="$sectionCount + $downloadCount + $resourceCount + $authorCount" />
   </xsl:variable>
   
    <!-- Begin processing. Get the param and call the right template to transform this
    section of the tutorial.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-tutorial">
	<!-- 6.0 Maverick edtools and author package ishields 05/2009: Declared template and transform parms -->
	<xsl:param name="template" />
    <xsl:param name="transform-zone" />
    <xsl:param name="page-name" select="$page-name" />   
    <xsl:param name="page-type" select="$page-type" />
    <xsl:param name="sectionFilename">
        <xsl:value-of select="substring-before($page-name, '.')" />
    </xsl:param>
    <xsl:param name="sectionNumber">
        <xsl:value-of select="substring-after($sectionFilename, 'section')" />
    </xsl:param>
    <xsl:param name="sectionIdentifier">     
      <xsl:choose>
        <xsl:when test="$page-name='index.html'">1</xsl:when>
        <xsl:otherwise>
	      <xsl:value-of select="$sectionNumber" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
      		
        <xsl:choose>
	   <!-- Test to see if there's an output name. if not, do nothing -->
	   <xsl:when test="not(normalize-space($template))" />
	   <xsl:otherwise>
	      <xsl:choose>
	      <!-- Test to see which variable the tempalte variable name matches and then call the
					   corresponding template that transforms that section of the tutorial -->

              <!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->	
             <!-- 6.0 Maverick R2 jpp/egd 12/01/09:  Uncommented to enable oXygen preview -->			
	         <xsl:when test="$template = 'preview' ">
                <xsl:for-each select=".">
                    <xsl:call-template name="dw-tutorial-preview" />
                </xsl:for-each>
             </xsl:when>					
		<!-- Create value for the title tag in head -->
		<xsl:when test="$template='titletag'">
			<xsl:call-template name="FullTitle"/>
		</xsl:when>
		<!-- Create value for the abstract and description meta tags in head -->
		<xsl:when test="$template='abstract'">
			<xsl:call-template name="FilterAbstract"/>
		</xsl:when>
		<!-- Create value for the keywords meta tag in head -->
		<xsl:when test="$template='keywords'">
			<xsl:call-template name="keywords"/>
		</xsl:when>
		<!-- Create value for the DC.Date meta tag -->
		<xsl:when test="$template='dcDate'">
			<xsl:call-template name="dcDate-v16"/>
		</xsl:when>
		<!-- Create value for the DC.Type meta tag -->
		<xsl:when test="$template='dcType'">
			<xsl:call-template name="dcType-v16"/>
		</xsl:when>
		<!-- Create value for the DC.Subject meta tag -->
		<xsl:when test="$template='dcSubject'">
			<xsl:call-template name="dcSubject-v16"/>
		</xsl:when>
		<!-- Create value for the DC.Rights meta tag -->
		<xsl:when test="$template='dcRights'">
			<xsl:call-template name="dcRights-v16"/>
		</xsl:when>
		<!-- Create value for the IBM.Effective meta tag -->
		<xsl:when test="$template='ibmEffective'">
			<xsl:call-template name="ibmEffective-v16"/>
		</xsl:when>
		<!-- 6.0 Maverick R2 fix egd 082909: Create url-tactic js variable in head -->
		<xsl:when test="$template='urltactic'">
			<xsl:call-template name="urlTactic-v16"/>
		</xsl:when>
		<!-- Create Web feed autodiscovery link rel -->
		<xsl:when test="$template='webFeedDiscovery'">
		    <!-- should be in common -->
		    <xsl:call-template name="webFeedDiscoveryTutorial-v16"/>
		</xsl:when>
		<!-- Create breadcrumbtrail test -->
		<xsl:when test="$template='breadcrumb'">
			<xsl:call-template name="Breadcrumb-v16">
			<!-- 6.0 Maverick edtools/author package ishields 05/2009: Added xsl with param for preview so could create bct from primary content area -->
			<xsl:with-param name="transform-zone" select="$transform-zone"/>
			</xsl:call-template>
		</xsl:when>
		<!-- Create page title and subtitle, if one -->
		<xsl:when test="$template='title'">
			<xsl:call-template name="Title-v16"/>
		</xsl:when>
		<!-- Create author list in Summary area -->
		<xsl:when test="$template='authorList'">
			<xsl:call-template name="AuthorTop"/>
		</xsl:when>					
		<!-- Create abstract text for summary area -->
		<xsl:when test="$template='abstractSummary'">
		    <!-- should be in common -->
			<xsl:call-template name="AbstractForDisplaySummaryAreaTutorial-v16"/>
		</xsl:when>
		<!-- Create series title text for summary area -->
		<xsl:when test="$template='seriesTitle'">
			<xsl:call-template name="SeriesTitleTutorial-v16"/>
		</xsl:when>
		<!-- 6.0 Maverick beta jpp 06/17/08: Create date published/updated text -->
		<xsl:when test="$template='date'">
		    <!-- should be in common -->
			<xsl:call-template name="DateSummaryTutorial-v16"/>
		</xsl:when>		
           <!-- Create skill level for summary area -->
		<xsl:when test="$template='skillLevel'">
			<xsl:call-template name="SkillLevel"/>
		</xsl:when>
		<!-- 6.0 Maverick beta jpp 06/18/08: Create pdf text -->
		<xsl:when test="$template='pdf'">
		    <!-- should be in common -->
			<xsl:call-template name="PDFSummaryTutorial-v16"/>
		</xsl:when>	
		<!-- 6.0 Maverick beta jpp 06/17/08: Create Table of Contents -->
		<xsl:when test="$template='toc'">
		       <xsl:call-template name="TableOfContentsTutorial-v16">
		          <xsl:with-param name="page-name" select="$page-name" />
                  <xsl:with-param name="page-type" select="$page-type" />
               </xsl:call-template>
	    </xsl:when>
	        <!-- Tutorials have:
	           * Unique pages, defined by section elements, each of which contain a title and a
	           docbody -->
	        <xsl:when test="$template='sectionTitle'">
	           <xsl:for-each select="section">
                  <xsl:if test="position() = $sectionIdentifier">
                     <xsl:apply-templates select="title" />
                  </xsl:if>
               </xsl:for-each>
            </xsl:when>
	        <xsl:when test="$template='docbody'">
	            <xsl:for-each select="section">
                  <xsl:if test="position() = $sectionIdentifier">
                     <xsl:apply-templates select="docbody" />
                  </xsl:if>
                </xsl:for-each>
		</xsl:when>
		<xsl:when test="$template='pageNavigator'">
		   <xsl:call-template name="PaginationController">
		              <xsl:with-param name="page-name" select="$page-name" />
                      <xsl:with-param name="page-type" select="$page-type" />
            </xsl:call-template>
		</xsl:when>
		<!-- Create downloads section  -->
		<xsl:when test="$template='downloads'">
			<xsl:call-template name="Download"/>
		</xsl:when>
		<!-- Create Resources section  -->
		<xsl:when test="$template='resources'">
			<xsl:call-template name="ResourcesSection"/>
		</xsl:when>
		<!-- Create AuthorBottom section  -->
		<xsl:when test="$template='authorBio'">
			<xsl:call-template name="AuthorBottom"/>
		</xsl:when>
		<!-- 6.0 Maverick beta jpp 06/19/08: Create metadata for rating function -->
		<xsl:when test="$template='ratingMeta'">
		    <!-- should be in common -->
			<xsl:call-template name="RatingMetaTutorial-v16"/>
		</xsl:when>
	         <!-- Create AuthorBottom section  -->
		<xsl:when test="$template='pageNavigator'">
			<xsl:call-template name="PageNavigator">
			   <xsl:with-param name="page-name" />
			   <xsl:with-param name="page-type" />
			</xsl:call-template>
		</xsl:when>
	     </xsl:choose>   
	   </xsl:otherwise>
	 </xsl:choose>
   </xsl:template>	
   <!-- Creates the abstract in the summary area  -->
    <!-- 6.0 Maverick R2 jpp 07/07/09: Updated to handle abstract-extended elements with paragraph tags and journal links -->
    <!-- should be in common -->
	<xsl:template name="AbstractForDisplaySummaryAreaTutorial-v16">
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
									<!-- should be in common -->
									<xsl:call-template name="JournalLinkTutorial-v16"/>
								</p>
							</xsl:for-each>
						</xsl:for-each>		
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="abstract-extended"/>
						<!-- should be in common -->
						<xsl:call-template name="JournalLinkTutorial-v16"/>	
					</xsl:otherwise>
				</xsl:choose>	
		  </xsl:when>
		  <xsl:otherwise>
			<xsl:value-of select="abstract"/>
			<!-- should be in common -->
			<xsl:call-template name="JournalLinkTutorial-v16"/>
		  </xsl:otherwise>
		</xsl:choose> 
    </xsl:template>    
    <!-- 6.0 Maverick R2 jpp 07/07/09: Created called template for Journal links -->
    <xsl:template name="JournalLinkTutorial-v16">
    	<!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add code to display journal links -->
		<xsl:variable name="journal-url">
		  <xsl:for-each select="key('journal-key', normalize-space(/dw-document/dw-tutorial/@journal))">
			<xsl:value-of select="@journal-url"/>
		  </xsl:for-each>
		</xsl:variable>    
		<xsl:choose>
		  <xsl:when test="normalize-space(/dw-document/dw-tutorial/@journal) !=''">
			  <xsl:choose>
				<xsl:when test="/dw-document//@local-site ='china'">
					<!-- 6.0 Maverick R2 jpp-egd 06/22/09: Add additional space to separate end of abstract from start of journal link -->
				    <xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
					<xsl:value-of select="normalize-space(/dw-document/dw-tutorial/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:text disable-output-escaping="yes">。</xsl:text>
				</xsl:when>
					<xsl:when test="/dw-document//@local-site ='korea' or /dw-document//@local-site='japan'">
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:value-of select="normalize-space(/dw-document/dw-tutorial/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes">.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- 6.0 Maverick R2 jpp-egd 06/22/09: Add additional space to separate end of abstract from start of journal link -->
				    <xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:value-of select="$journal-link-intro"/><xsl:text disable-output-escaping="yes"> </xsl:text>
					<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
					<xsl:value-of select="$journal-url"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
					<xsl:value-of select="normalize-space(/dw-document/dw-tutorial/@journal)"/>
					<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
					<xsl:text disable-output-escaping="yes">.</xsl:text>
				</xsl:otherwise>
			  </xsl:choose>
			</xsl:when>
		</xsl:choose>    
    </xsl:template>    
  <!-- 6.0 Maverick beta jpp 06/17/08: Create date published/updated text -->
  <!-- Future:  Need to handle local sites -->
  <!-- should be in common -->
  <xsl:template name="DateSummaryTutorial-v16">
	  <strong>
		  <xsl:value-of select="$date"/>
	  </strong>
	  <!-- Spacing -->
	  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
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
	<!-- 6.0 Maverick beta jpp 06/18/08 -->
	<!-- Create summary area text if a PDF version of the content is available -->
	<!-- Assumes that "common" (A4 and Letter) is the only allowable option -->
	<!-- should be in common -->
	<xsl:template name="PDFSummaryTutorial-v16">
	  <xsl:for-each select="/dw-document//pdf[@paperSize='common'][1]">
		  <br class="ibm-ind-link"/>
			  <strong>
				  <xsl:value-of select="$pdf-heading"/>
			  </strong>
		  <!-- Spacing -->
		  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp; ]]></xsl:text>
		  <!-- 6.0 Maverick R3 10/01/01 jpp: Check for and fix an invalid Boulder URL -->
	  		<xsl:variable name="non-production-server"> 
                    <!-- llk 2012-03-21 emergency fix for urls pointing to staging server.
                        -->
                    <xsl:choose>
                        <xsl:when test="contains(@url,'candor.rtp.raleigh.ibm.com')">
                            <xsl:value-of select="'candor.rtp.raleigh.ibm.com'"/>
                        </xsl:when>
                        <xsl:when test="contains(@url,'ltsbwass001.sby.ibm.com')">
                            <xsl:value-of select="'ltsbwass001.sby.ibm.com'"/>
                        </xsl:when>
                    </xsl:choose>
             </xsl:variable>
		  <xsl:element name="a">
		  	
<xsl:attribute name="href">
				<xsl:choose>
						<xsl:when test="$non-production-server != ''"> <!-- llk 2012-03-21
                        added this xsl:when clause -->
                        <!-- Emergency fix to make all staging server PDF URLs relative -->
                        <!-- Defect 14299 jmh 01/15/13 -->
                            <xsl:call-template name="emergency-strip-path-from-url">
                                <xsl:with-param name="url" select="substring-after(@url, $non-production-server)"/>
                            </xsl:call-template>
                        
                    </xsl:when>
					<xsl:when test="contains(@url,'//download.boulder.ibm.com/ibmdl/pub/')">
						<xsl:call-template name="ReplaceSubstring">
							<xsl:with-param name="original" select="@url" />
							<xsl:with-param name="substring" select="'//download.boulder.ibm.com/ibmdl/pub/'" />
							<xsl:with-param name="replacement" select="'//public.dhe.ibm.com/'" />
						</xsl:call-template>
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:value-of select="@url"/>
					</xsl:otherwise>
				</xsl:choose>
			  </xsl:attribute>			  
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
	<!-- 6.0 Maverick beta jpp 06/19/08 -->
	<!-- RatingMeta-v16 template creates metadata for rating function -->
	<!-- should be in common -->
	<xsl:template name="RatingMetaTutorial-v16">
		<xsl:comment>Rating_Meta_BEGIN</xsl:comment>
		<xsl:variable name="titleinput">
			<xsl:call-template name="FullTitle"/>
		</xsl:variable>
		<!-- 6.0 Maverick edtools and author package ishields 05/2009: Needed fully qualified URL for preview  -->
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
		<!-- Create Tutorial ID meta value -->
        <xsl:variable name="id">
            <xsl:choose>
				<!-- 6.0 Maverick R3 02/05/10 jpp:  Changed db2 to data in content area test -->
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
			<!-- Maverick 6.0 R2 jpp/egd 12/01/09:  Had to change from TutorialID to ArticleID to match development code -->
			<xsl:value-of select="concat('ArticleID=',$id)"/>
		</div>
		<!-- Create TutorialTitle meta value -->
        <div class="metavalue">
			<xsl:value-of select="concat('TutorialTitle=',$titleinput)"/>
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
        <xsl:for-each select="//author">
			<xsl:variable name="author-email" select="@email" />
            <xsl:variable name="author-email-cc" select="@email-cc" />
            <xsl:variable name="author-number" select="position()" />
            <div class="metavalue">
				<xsl:value-of select="concat('author',$author-number,'-email=')" /><xsl:value-of select="@email" />
            </div>
            <div class="metavalue">
				<xsl:value-of select="concat('author',$author-number,'-email-cc=')" /><xsl:value-of select="@email-cc" />
            </div>
        </xsl:for-each>
		<!-- Create url meta value -->
        <!-- 6.0 Maverick R3 04/21/10 jpp:  Fixed script definition to resolve Appscan issue -->
		<!-- xM R2 (R2.2) jpp 04/27/11:  Refined script below based on update from Michael Chan -->
        <xsl:text disable-output-escaping="yes"><![CDATA[<script language="javascript" type="text/javascript">document.write('<div class="metavalue">url='+location.href.replace(/</g,  '%3C')+'</div>');</script>]]></xsl:text>
		<xsl:comment>Rating_Meta_END</xsl:comment>
	</xsl:template>
	<!-- SeriesTitle-v16 template creates the series-title text in the summary area  -->
	<xsl:template name="SeriesTitleTutorial-v16">
		<!-- 6.0 R1P2 jpp 02/18/09:  Commented out code below that returns the Series name prefixed with a heading -->
		<!-- <xsl:if test="normalize-space(/dw-document/dw-article/series/series-title)!=''"> -->
			<!-- <xsl:text disable-output-escaping="yes"><![CDATA[<p><strong>]]></xsl:text>
			<xsl:value-of select="$series"/><xsl:text>:</xsl:text>
			<xsl:text disable-output-escaping="yes"><![CDATA[</strong>&nbsp;&nbsp;]]></xsl:text> -->
			<!-- Maverick 6.0 beta egd 06/23/08: Added code to remove Part info from Series title for summary area -->
			<!-- <xsl:choose>
                <xsl:when test="contains(/dw-document//series/series-title, ', Part')">
                    <xsl:value-of select="substring-before(/dw-document//series/series-title, ', Part')"/>
                </xsl:when>
                <xsl:when test="contains(/dw-document//series/series-title, '，第')">
                    <xsl:value-of select="substring-before(/dw-document//series/series-title, '，第')"/>
                </xsl:when>
                <xsl:when test="contains(/dw-document//series/series-title, ', Часть')">
                    <xsl:value-of select="substring-before(/dw-document//series/series-title, ', Часть')"/>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select="/dw-document//series/series-title"/>
                </xsl:otherwise>
            </xsl:choose>
		</xsl:if> -->
	    <!-- 6.0 R1P2 jpp 02/18/09:  Modified series information to return just a link to view more content -->
	    <!-- If series title and series url are present, display link to more content in series -->
		<xsl:if test="(normalize-space(/dw-document/dw-tutorial/series/series-title)!='') and
		   (normalize-space(/dw-document/dw-tutorial/series/series-url)!='')">
			<xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
				<xsl:value-of select="/dw-document/dw-tutorial/series/series-url"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
				<xsl:value-of select="$series-view" />
			<xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
		</xsl:if>
	</xsl:template>
       <!-- TABLE OF CONTENTS: START -->
      <xsl:template name="TableOfContentsTutorial-v16">
        <xsl:param name="page-name" />
         <xsl:param name="page-type" />
      <div class="ibm-container">
         <h2>
            <xsl:value-of select="$toc-heading" />
         </h2>
         <div class="ibm-container-body">
            <img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="1" height="1" alt="" />
            <ul class="ibm-bullet-list">
               <!-- Start:  Build links to unique sections (section elements) -->
               <xsl:for-each select="section">
                  <xsl:call-template name="SectionsTableOfContents">
                     <xsl:with-param name="page-name" select="$page-name" />
                     <xsl:with-param name="page-type" select="$page-type" />
                  </xsl:call-template>
               </xsl:for-each>
               <!-- Start:  Build links to the standard sections (downloads,
                  resources, authors -->
               <xsl:if test="(//target-content-file or //target-content-page)">
                  <li>
                     <xsl:choose>
                        <xsl:when test="not($page-name = 'downloads.html')">
                           <a href="downloads.html" class="ibm-feature-link">
         		      <xsl:choose>
         		         <xsl:when test="count(//target-content-file) > 1">
         			   <xsl:value-of select="$downloads-heading" />
         		         </xsl:when>
         		         <xsl:otherwise>
         			   <xsl:value-of select="$download-heading" />
         		         </xsl:otherwise>
         		      </xsl:choose>
	                    </a>
                        </xsl:when>
                        <xsl:otherwise>
                           <strong>
                           <xsl:choose>                              
         		         <xsl:when test="count(//target-content-file) > 1">
         			   <xsl:value-of select="$downloads-heading" />
         		         </xsl:when>
         		         <xsl:otherwise>
         			   <xsl:value-of select="$download-heading" />
         		         </xsl:otherwise>
                           </xsl:choose>
                           </strong>
                        </xsl:otherwise>
                     </xsl:choose>                     
                  </li>
               </xsl:if>
               <xsl:if test="//resource-list | //resources">
                  <li>
                     <xsl:choose>
                        <xsl:when test="not($page-name = 'resources.html')">
                           <a href="resources.html" class="ibm-feature-link">
		              <xsl:value-of select="$resource-list-heading" />
                           </a>
                        </xsl:when>
                        <xsl:otherwise>
                           <strong><xsl:value-of select="$resource-list-heading" /></strong>
                        </xsl:otherwise>
                     </xsl:choose>
                  </li>
               </xsl:if>
               <xsl:if test="//author/bio/.!=''">
                  <li>
                     <xsl:choose>
                        <xsl:when test="not($page-name = 'authors.html')">
                           <a href="authors.html" class="ibm-feature-link">
                              <xsl:choose>
			        <xsl:when test="count(//author) = 1">
				  <xsl:value-of select="$aboutTheAuthor" />
			        </xsl:when>
		                <xsl:otherwise>
			           <xsl:value-of select="$aboutTheAuthors" />
			        </xsl:otherwise>
		             </xsl:choose>                              
                           </a>
                        </xsl:when>
                        <xsl:otherwise>
                           <strong>
                           <xsl:choose>
			        <xsl:when test="count(//author) = 1">
				  <xsl:value-of select="$aboutTheAuthor" />
			        </xsl:when>
		                <xsl:otherwise>
			           <xsl:value-of select="$aboutTheAuthors" />
			        </xsl:otherwise>
                           </xsl:choose>
                           </strong>
                        </xsl:otherwise>
                     </xsl:choose>
                  </li>
               </xsl:if>
               <!-- Insert link to inline comments section 
               <li>
                  <a href="#icomments" class="ibm-feature-link">
		     <xsl:value-of select="$inline-comments-heading" />
	          </a>
               </li>
               -->
            </ul>
            <!-- Basic_TOC_pagination_control_Start -->
           <div class="ibm-rule"><hr /></div> 
               <xsl:call-template name="PaginationController">
               <xsl:with-param name="page-name" select="$page-name" />
               <xsl:with-param name="page-type" select="$page-type" />
            </xsl:call-template>
        </div>
      </div>
      <!-- TABLE OF CONTENTS: END -->
      </xsl:template>
   <!-- ========================================= -->
   <!-- name="SectionsTableOfContents" -->
   <!-- ========================================= -->
   <xsl:template name="SectionsTableOfContents">
      <xsl:param name="page-name" />
      <xsl:param name="page-type" />
      <!-- Start:  Build each section TOC link -->
      <li>
         <xsl:choose>
            <xsl:when test=". = ../section[1]">
                 <xsl:choose>
                       <xsl:when test="not($page-name = 'index.html')">
                           <xsl:choose>
                               <xsl:when test="normalize-space(title/alttoc) = '' or not(title/alttoc)">                        
                                  <a href="index.html" class="ibm-feature-link"><xsl:apply-templates select="title/*|title/text()" /></a>
                               </xsl:when>
                               <xsl:otherwise>
                                 <a href="index.html" class="ibm-feature-link"><xsl:apply-templates select="title/alttoc/*|title/alttoc/text()" /></a>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:choose>
                               <xsl:when test="normalize-space(title/alttoc) = '' or not(title/alttoc)">                        
                                  <strong>
                                     <xsl:apply-templates select="title/*|title/text()" />
                                  </strong>
                               </xsl:when>
                               <xsl:otherwise>
                                <strong>
                                 <xsl:apply-templates select="title/alttoc/*|title/alttoc/text()" />
                                </strong>
                               </xsl:otherwise>
                           </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>               
            </xsl:when>
          <xsl:otherwise>
          <xsl:variable name="section-href">
             <xsl:value-of select="concat('section',position(),'.html')"/>
          </xsl:variable>
             <xsl:choose>
                <xsl:when test="not($page-name = $section-href)">
                   <xsl:choose>
                     <xsl:when test="normalize-space(title/alttoc) = '' or not(title/alttoc)">                        
                         <a href="{$section-href}" class="ibm-feature-link"><xsl:apply-templates select="title/*|title/text()" /></a>
                     </xsl:when>
                     <xsl:otherwise>
                         <a href="{$section-href}" class="ibm-feature-link"><xsl:apply-templates select="title/alttoc/*|title/alttoc/text()" /></a>
                     </xsl:otherwise>
                   </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:choose>
                     <xsl:when test="normalize-space(title/alttoc) = '' or not(title/alttoc)">
                        <strong>
                            <xsl:apply-templates select="title/*|title/text()" />
                         </strong>
                     </xsl:when>
                     <xsl:otherwise>
                        <strong>
                         <xsl:apply-templates select="title/alttoc/*|title/alttoc/text()" />
                        </strong>
                     </xsl:otherwise>
                   </xsl:choose>
                </xsl:otherwise>
                </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </li>
      <!-- End:  Build each section TOC link -->
   </xsl:template>
	
	<!-- webFeedAutoDiscovery-v16 template creates the link rel for one or more web feeds --> 
	<!-- should be in common -->
	<xsl:template name="webFeedDiscoveryTutorial-v16">
	<!-- Include link rel tag if web-feed-autodiscovery element(s) are specified  -->
	<xsl:if test="normalize-space(/dw-document//web-feed-autodiscovery/@feed-type)!='' or (/dw-document/dw-trial-program-pages/pagegroup//content/meta-information/web-feed-autodiscovery/@feed-type)!='' or (/dw-document/dw-landing-generic-pagegroup/pagegroup//content/meta-information/web-feed-autodiscovery/@feed-type)!=''">
		<xsl:choose>
			<xsl:when test="/dw-document//pagegroup">
				<xsl:for-each select="content/meta-information/web-feed-autodiscovery">
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
   <!-- ========================================= -->
   <!-- name="PaginationController" -->
   <!-- ========================================= -->
   <xsl:template name="PaginationController">
      <xsl:param name="page-name" />
      <xsl:param name="page-type" /> 
      <xsl:param name="sectionFilename">
             <xsl:value-of select="substring-before($page-name, '.')" />
          </xsl:param>
      <xsl:param name="sectionNumber">
             <xsl:value-of select="substring-after($sectionFilename, 'section')" />
      </xsl:param>
          <xsl:choose>
           <xsl:when test="$page-type='section'">
            <xsl:choose>
               <xsl:when test="$page-name='index.html'">
                  <xsl:call-template name="PageNavigator">
                     <xsl:with-param name="page-type" select="$page-type" />
                     <xsl:with-param name="thisPageNumber">1</xsl:with-param>
                     <xsl:with-param name="page-name" select="$page-name" />
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="PageNavigator">
                     <xsl:with-param name="page-type" select="$page-type" />
                     <xsl:with-param name="thisPageNumber">
                        <xsl:value-of select="$sectionNumber" />
                     </xsl:with-param>
                     <xsl:with-param name="page-name" select="$page-name" />
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="$page-type='downloads'">
            <xsl:call-template name="PageNavigator">
               <xsl:with-param name="page-type" select="$page-type" />
               <xsl:with-param name="thisPageNumber">
                  <xsl:value-of select="$sectionCount + $downloadCount" />
               </xsl:with-param>
               <xsl:with-param name="page-name" select="$page-name" />
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$page-type='resources'">
            <xsl:call-template name="PageNavigator">
               <xsl:with-param name="page-type" select="$page-type" />
               <xsl:with-param name="thisPageNumber">
                  <xsl:value-of select="$sectionCount + $downloadCount + $resourceCount"
                   />
               </xsl:with-param>
               <xsl:with-param name="page-name" select="$page-name" />
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$page-type='authorBio'">
            <xsl:call-template name="PageNavigator">
               <xsl:with-param name="page-type" select="$page-type" />
               <xsl:with-param name="thisPageNumber">
                  <xsl:value-of
                     select="$sectionCount + $downloadCount + $resourceCount + $authorCount" />
               </xsl:with-param>
               <xsl:with-param name="page-name" select="$page-name" />
            </xsl:call-template>
         </xsl:when>
          </xsl:choose>
       </xsl:template>
   
   <!-- ========================================= -->
   <!-- name="PageNavigator" -->
   <!-- ========================================= -->
   <xsl:template name="PageNavigator">
      <xsl:param name="page-type" />
      <xsl:param name="page-name" />
      <xsl:param name="thisPageNumber" />
      <xsl:variable name="previousPageUrl">
         <xsl:choose>
            <xsl:when test="$page-type='section'">
               <xsl:choose>
                  <xsl:when test="$page-name = 'section2.html'">
                     <xsl:text>index.html</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="concat('section',$thisPageNumber - 1,'.html')" />
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:when test="$page-type='downloads'">
               <xsl:value-of select="concat('section',$sectionCount,'.html')" />
            </xsl:when>
            <xsl:when test="$page-type='resources'">
               <xsl:choose>
                  <xsl:when test="$downloadCount = 1">
                     <xsl:text>downloads.html</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="concat('section',$sectionCount,'.html')" />
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:when test="$page-type='authorBio'">
               <xsl:choose>
                  <xsl:when test="$resourceCount = 1">
                     <xsl:text>resources.html</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:choose>
                        <xsl:when test="$downloadCount = 1">
                           <xsl:text>downloads.html</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="concat('section',$sectionCount,'.html')"
                            />
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="nextPageUrl">
         <xsl:choose>
            <xsl:when test="$page-type='section'">
               <xsl:choose>
                  <!-- When this is the last section -->
                  <xsl:when test="$sectionCount - $thisPageNumber = 0">
                     <xsl:choose>
                        <xsl:when test="$downloadCount=1">
                           <xsl:text>downloads.html</xsl:text>
                        </xsl:when>
                        <xsl:when test="$resourceCount=1">
                           <xsl:text>resources.html</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:text>authors.html</xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <!-- When this is a section, but not the last section -->
                  <xsl:otherwise>
                     <xsl:value-of select="concat('section',$thisPageNumber + 1,'.html')"
                      />
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <!-- When this isn't a section -->
            <xsl:when test="$page-type='downloads'">
               <xsl:choose>
                  <xsl:when test="$resourceCount=1">
                     <xsl:text>resources.html</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text>authors.html</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:when test="$page-type='resources'">
               <xsl:text>authors.html</xsl:text>
            </xsl:when>
            <xsl:when test="$page-type='authorBio'">
               <xsl:text>#</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <!-- Next/Previous links: START -->
      <p class="ibm-table-navigation">
         <span class="ibm-secondary-navigation">
            <strong>
               <xsl:value-of select="$thisPageNumber" />
            <!-- Maverick 6.0 R3 jpp/egd 06 07 10:  Added xsl text to create blank space before and after of -->
            </strong><xsl:text> </xsl:text><xsl:value-of select="$of" /><xsl:text> </xsl:text><strong>
               <xsl:value-of select="$pageCount" />
            </strong>
            <span class="ibm-table-navigation-links">
            	<!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->
               <xsl:if test="$page-name != 'index.html' or $page-type !='section'"> |
                 <a class="ibm-back-em-link" href="{$previousPageUrl}"><xsl:value-of select="$previous" /> </a></xsl:if>
               <xsl:if test="$page-name != 'authors.html'"> |
                 <a class="ibm-forward-em-link" href="{$nextPageUrl}"><xsl:value-of select="$next" /> </a></xsl:if>
            </span>
         </span>
      </p>
      <!-- Next/Previous links: END -->
   </xsl:template>
   
    
   <!-- ========================================= -->
  <!-- match="section/title" -->
  <!-- ========================================= -->
  <xsl:template match="section/title">
    <p>
      <span class="atitle">
        <!-- 5.9 08/20/07 tdc:  Replace value-of with apply-templates to text and elements[that are not in alttoc]  (DR 2438) -->
        <xsl:apply-templates select="*[not(alttoc/*|text())] | text()" />
        <!-- <xsl:apply-templates select="*|text()"/> -->
      </span>
    </p>
  </xsl:template>
  
  
</xsl:stylesheet>
