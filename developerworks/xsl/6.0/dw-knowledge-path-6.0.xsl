<?xml version="1.0" encoding="UTF-8"?>
<!-- egd added these two lines from dw-article xsl -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<!-- Jun 28 2011 (tdc):  PURPOSE:  This is the dw-knowledge-path xsl for Maverick.  The Maverick application, using the knowledge path transform XML, passes a variable to this XSL.  The XSL processes that variable by calling the main template that transforms that piece of the knowledge path -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
 <!-- Begin processing. Get the param and call the right template to transform the knowledge path.  The Maverick app picks up the results of the transform from the data stream -->
	<xsl:template match="dw-knowledge-path">		
		<xsl:param name="template" />
        <xsl:param name="transform-zone" />   		
        <xsl:choose>
			<!-- Test to see if there's an output name. if not, do nothing -->
			<xsl:when test="not(normalize-space($template))" />
			<xsl:otherwise>
				<xsl:choose>
				<!-- Test to see which variable the tempalte variable name matches and then call the corresponding template that transforms that section of the article -->
                <!-- 6.0 Maverick edtools/author package ishields 05/2009: Added processing for preview -->					
			    <xsl:when test="$template = 'preview' ">
                   <xsl:for-each select=".">
                       <xsl:call-template name="dw-knowledge-path-preview" />
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
					<!-- Create value for the DC.Subject meta tag (WE'VE BEEN TOLD TO USE CT323 FOR ALL) -->
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
					<!-- Create Web feed autodiscovery link rel -->
					<xsl:when test="$template='webFeedDiscovery'">
						<xsl:call-template name="webFeedDiscovery-v16"/>
					</xsl:when>
					<!-- Create breadcrumbtrail test -->
					<xsl:when test="$template='breadcrumb'">
						<xsl:call-template name="Breadcrumb-v16">
							<xsl:with-param name="transform-zone" select="$transform-zone"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$template='title'">
						<xsl:call-template name="Title-v16"/>
					</xsl:when>						
					<xsl:when test="$template='kpAbstract'">
					    <p>
						<xsl:call-template name="AbstractForDisplaySummaryArea-v16"/>
					    </p>
					</xsl:when>
					<!-- No series yet -->
					<xsl:when test="$template='date'">
						<xsl:call-template name="DateSummary-v16"/>
					</xsl:when>	
					<xsl:when test="$template='translationDate'">
						<xsl:call-template name="TranslationDateSummary-v16"/>
					</xsl:when>								
                                                    <xsl:when test="$template='skillLevel'">
						<xsl:call-template name="SkillLevel"/>
					</xsl:when>
				       <xsl:when test="$template='kpSteps'">
						<xsl:call-template name="KnowledgePathSteps"/>
				        </xsl:when>
				             <xsl:when test="$template='kpNextSteps'">
						<xsl:call-template name="KnowledgePathNextSteps"/>
					</xsl:when>
					<xsl:when test="$template='kpToc'">
					   <xsl:call-template name="KnowledgePathTableOfContents"/>
					</xsl:when>
					<xsl:when test="$template='kpRelatedResources'">
					    <xsl:call-template name="KnowledgePathRelatedResources"/>
					</xsl:when>
				           <xsl:when test="$template='ratingMeta'">
						<xsl:call-template name="RatingMeta-v16"/>
					</xsl:when>						
				</xsl:choose>   
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
             <!-- KP-specific templates -->
	<xsl:template name="KnowledgePathSteps">
	   <xsl:for-each select="/dw-document/dw-knowledge-path/kp-steps/kp-step">
	        <!-- Create the heading -->
	        <xsl:apply-templates select="heading" />
	        <!-- Create the abstract -->
	        <p><xsl:apply-templates select="kp-step-abstract/*|kp-step-abstract/text()|kp-step-abstract/node()" /></p>
	        <!-- Create each resource -->
	        <xsl:for-each select="kp-resources/kp-resource">
	            <xsl:call-template name="KnowledgePathResource">
	               <!-- <xsl:with-param name="kpResourceStatus">0</xsl:with-param> -->
	            </xsl:call-template>
	         </xsl:for-each>	        
	    </xsl:for-each>	    
	</xsl:template>
	
	<xsl:template name="KnowledgePathResource">
	<!-- Set kpResourceStatus upon transformation
	<xsl:param name="kpResourceStatus" /> -->
	            <!-- 09/14/11 tdc: Added var for resource id -->
	            <xsl:variable name="resource-id">
	               <xsl:value-of select="@kp-resource-id" />	               
	            </xsl:variable>
	            <xsl:variable name="resource-icon">
	                <xsl:choose>
	                    <xsl:when test="@kp-resource-type = 'Download'">http://dw1.s81c.com/i/v16/icons/dn.gif</xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Listen'">http://dw1.s81c.com/i/v16/icons/aud.gif</xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Practice'">http://dw1.s81c.com/developerworks/i/icon_practice.gif</xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Read'">
	                        <xsl:choose>
	                            <xsl:when test="contains(kp-resource-url, '.pdf') or contains(kp-resource-url, '.PDF')">http://dw1.s81c.com/i/v16/icons/pdf.gif</xsl:when>
	                            <xsl:otherwise>http://dw1.s81c.com/i/v16/icons/blog_ic.gif</xsl:otherwise>
	                        </xsl:choose>
	                    </xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Watch'">http://dw1.s81c.com/i/v16/icons/video.gif</xsl:when>
	                    <!-- If an invalid type is entered, use plain right arrow icon.  Schema will flag it, though.  -->
	                    <xsl:otherwise>ibm-forward-link</xsl:otherwise>
	                </xsl:choose>
	            </xsl:variable>
	            <xsl:variable name="resource-icon-alt">
	            <!-- Currently, these alt values are null so they're not redundant per web checklist 1.1a, html example #9 -->
	               <xsl:choose>
						<xsl:when test="@kp-resource-type = 'Download'"></xsl:when>
						<xsl:when test="@kp-resource-type = 'Listen'"></xsl:when>
						<xsl:when test="@kp-resource-type = 'Practice'"></xsl:when>
						<xsl:when test="@kp-resource-type = 'Read'"></xsl:when>
						<xsl:when test="@kp-resource-type = 'Watch'"></xsl:when>
						<xsl:otherwise></xsl:otherwise>
				   </xsl:choose>
	            </xsl:variable>
	                            
	            <xsl:variable name="resource-link">
	                <!-- <xsl:choose>
	                    <xsl:when test="contains(kp-resource-url, '//')">
	                        <xsl:value-of select="kp-resource-url"/>
	                    </xsl:when>
	                    <xsl:otherwise>
	                        <xsl:value-of select="concat('//', kp-resource-url)" />
	                    </xsl:otherwise>	                
	                </xsl:choose> -->
	                <xsl:choose>
	                    <xsl:when test="kp-resource-url/@eld = 'yes'">	                    
	                        <xsl:value-of select="kp-resource-url"/>
	                    </xsl:when>
	                    <xsl:otherwise>	                        
	                        <xsl:value-of select="concat('//',substring-after(kp-resource-url, '//'))" />
	                    </xsl:otherwise>	                
	                </xsl:choose>
	            </xsl:variable>
			        	<!-- llk - 08-20-2011 set the translated kp-resource-title-ui -->
	        	<xsl:variable name="kp-resource-title-ui">
	                 <xsl:choose>
	                    <xsl:when test="@kp-resource-type = 'Download'"><xsl:value-of select="$kp-resource-type-ui-download"/></xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Listen'"><xsl:value-of select="$kp-resource-type-ui-listen"/></xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Practice'"><xsl:value-of select="$kp-resource-type-ui-practice"/></xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Read'"><xsl:value-of select="$kp-resource-type-ui-read"/></xsl:when>
	                    <xsl:when test="@kp-resource-type = 'Watch'"><xsl:value-of select="$kp-resource-type-ui-watch"/></xsl:when>
	                </xsl:choose>
	            </xsl:variable>
	            <!-- Build the first div (icon + resource text/link) -->
	            <div class="resource">
	               <img class="dw-kp-resource-icon" alt="{$resource-icon-alt}" src="{$resource-icon}" />
	                <p>
	                   <xsl:element name="a">
	                      <!-- <xsl:attribute name="target">new</xsl:attribute> -->
	                      <xsl:attribute name="id"><xsl:value-of select="$resource-id" /></xsl:attribute>
	                      <!-- 09/06/11 tdc:  Removed onclick attrib; the progressevents.js inserts it if dw-kp-signin class present -->
	                      <!-- <xsl:attribute name="onclick"><xsl:text>progressEvent(this.id);</xsl:text></xsl:attribute> -->
	                      <!-- 09/06/11 tdc:  Added choose clause; dw-kp-signin class needed as trigger for progressevents.js -->
	                      <xsl:choose>
	                         <xsl:when test="@kp-resource-registration = '1'">
	                            <xsl:attribute name="class">kp-resource-link dw-kp-signin</xsl:attribute>
	                         </xsl:when>
	                         <xsl:otherwise>
	                            <xsl:attribute name="class">kp-resource-link</xsl:attribute>
	                         </xsl:otherwise>
	                      </xsl:choose>
	                      <!-- llk 08-20-2011 called the translated text variable rather than the actual hardcoded resource type -->
	                      <xsl:attribute name="href"><xsl:value-of select="$resource-link" /></xsl:attribute>
	                   	<!-- llk - 08-20-2011 call the kp-resource-title-ui variable -->
	                      <strong><xsl:value-of select="$kp-resource-title-ui"/><xsl:text>:  </xsl:text></strong><xsl:apply-templates select="kp-resource-title" />
	                      <xsl:if test="kp-resource-note !=''">
	                          <span class="ibm-item-note"><xsl:text>(</xsl:text><xsl:apply-templates
	                                       select="kp-resource-note" /><xsl:text>)</xsl:text></span>
	                      </xsl:if>	                      
	                   </xsl:element>                     
	                      <xsl:if test="@kp-resource-registration = '1'">
	                             <xsl:element name="a">
	                                <!-- 09/21/11 tdc:  Added id attrib for JS -->
	                                <xsl:attribute name="id"><xsl:value-of select="concat($resource-id,'_key')" /></xsl:attribute>
	                                <xsl:attribute name="href"><xsl:value-of select="$resource-link" /></xsl:attribute>
	                                <!-- 09/21/11 tdc:  Removed onclick attrib per Peter (handled in JS instead) -->
	                                <!-- 
	                                <xsl:attribute name="onclick">
	                                   <xsl:text>showSignIn(function(){window.location.href='</xsl:text>
	                                   <xsl:value-of select="$resource-link" />
	                                   <xsl:text>'});return false;</xsl:text>
	                                </xsl:attribute> -->
	                                <xsl:element name="img">
	                                   <xsl:attribute name="alt"><xsl:value-of select="$kp-sign-in" /></xsl:attribute>
	                                   <xsl:attribute name="border">0</xsl:attribute>
	                                   <xsl:attribute name="src">//dw1.s81c.com/i/v16/icons/key.gif</xsl:attribute>
	                                   <xsl:attribute name="class">kp-key</xsl:attribute>
	                                </xsl:element>	                                
	                             </xsl:element>
	                      </xsl:if>	
	                      <!-- <xsl:choose> -->
	                      <!-- llk - 08-20-2011 - need alt values translated for both checkmark images -->
	                      <!-- 09/14/11 tdc:  rebuilt img element -->
	                      <xsl:element name="img">
	                         <xsl:attribute name="id"><xsl:value-of select="concat($resource-id,'_check')" /></xsl:attribute>
	                         <xsl:attribute name="class">check</xsl:attribute>
	                         <xsl:attribute name="alt"><xsl:value-of select="$kp-unchecked-checkmark" /></xsl:attribute>
	                         <xsl:attribute name="src">//dw1.s81c.com/developerworks/i/kp/confirm-grey.gif</xsl:attribute>
	                      </xsl:element>	                                                         
	                   </p>	                   
	            </div>
	         </xsl:template> 
	            
	<xsl:template name="KnowledgePathNextSteps">
		<h2 class="kp-next-steps-head">
			<a name="nextsteps">
				<xsl:value-of select="$heading-kp-next-steps"/>
			</a>
		</h2>
		<ul class="ibm-link-list">
			<xsl:for-each select="/dw-document/dw-knowledge-path/kp-next-steps/kp-next-step">
				<xsl:variable name="next-step-anchor-class">
					<xsl:choose>
						<xsl:when test="@kp-next-step-type = 'Buy'">ibm-forward-em-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Download'"
							>ibm-download-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Follow'">kp-blog-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Join'">kp-join-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Listen'">ibm-audio-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Practice'">dw-practice-link</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Read'">
							<xsl:choose>
								<xsl:when test="contains(kp-next-step-url, '.pdf') or contains(kp-next-step-url, '.PDF')"
									>ibm-pdf-link</xsl:when>
								<xsl:otherwise>ibm-blog</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Watch'">ibm-video-link</xsl:when>
						<!-- If Discuss, Enroll, Register, use bold arrow -->
						<xsl:otherwise>ibm-forward-em-link kp-forward-em-link</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- llk 08-20-2011 - added translated text strings for these headings -->
				<xsl:variable name="kp-next-step-type-ui">
					<xsl:choose>
						<xsl:when test="@kp-next-step-type = 'Buy'">
							<xsl:value-of select="$kp-next-step-ui-buy"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Download'">
							<xsl:value-of select="$kp-next-step-ui-download"/>
						</xsl:when>
					          <!-- 08/31/11 tdc: Added Discuss -->
					          <xsl:when test="@kp-next-step-type = 'Discuss'">
							<xsl:value-of select="$kp-next-step-ui-discuss"/>
					          </xsl:when>
					          <!-- 08/31/11 tdc: Added Enroll -->
					          <xsl:when test="@kp-next-step-type = 'Enroll'">
							<xsl:value-of select="$kp-next-step-ui-enroll"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Follow'">
							<xsl:value-of select="$kp-next-step-ui-follow"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Join'">
							<xsl:value-of select="$kp-next-step-ui-join"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Listen'">
							<xsl:value-of select="$kp-next-step-ui-listen"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Practice'">
							<xsl:value-of select="$kp-next-step-ui-practice"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Read'">
							<xsl:value-of select="$kp-next-step-ui-read"/>
						</xsl:when>
					           <!-- 08/31/11 tdc: Added Register -->
					          <xsl:when test="@kp-next-step-type = 'Register'">
							<xsl:value-of select="$kp-next-step-ui-register"/>
						</xsl:when>
						<xsl:when test="@kp-next-step-type = 'Watch'">
							<xsl:value-of select="$kp-next-step-ui-watch"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="next-step-link">
					<xsl:choose>
						<xsl:when test="contains(kp-next-step-url,'//')">
							<!-- 08/31/11 tdc: Changed kp-resource-url to kp-next-step-url -->
							<xsl:value-of select="kp-next-step-url"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('//',kp-next-step-url)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:element name="li">
					<xsl:element name="a">
						<xsl:attribute name="class">
							<xsl:value-of
								select="concat($next-step-anchor-class,' kp-next-step-link')"/>
						</xsl:attribute>
						<xsl:attribute name="href">
						          <!-- 08/31/11 tdc: Call generate-correct-url-form instead of $next-step-link for preview urls -->
							<xsl:call-template name="generate-correct-url-form">
								<xsl:with-param name="input-url" select="$next-step-link"/>
							</xsl:call-template>
							<!-- <xsl:value-of select="$next-step-link"/>-->
						</xsl:attribute>
					          <!-- 08/31/11 tdc: Removed target attribute per John Holtman -->
						<!-- <xsl:attribute name="target">newstep</xsl:attribute> -->
						<strong class="kp-nextstep-action">
							<!-- llk - 08-20-2011 added the next step translated ui rather than hardcoded -->
							<xsl:value-of select="$kp-next-step-type-ui"/>
							<xsl:text>:  </xsl:text>
						</strong>
						<span class="kp-nextstep-normal">
							<xsl:apply-templates select="kp-next-step-title"/>
						</span>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</ul>
	</xsl:template>
             <xsl:template name="KnowledgePathTableOfContents">
                <xsl:variable name="discuss-link"><xsl:value-of select="kp-discuss-url" /></xsl:variable>
                 <h2 class="kp-about-h2"><xsl:value-of select="$heading-kp-toc" /></h2>
                 <ol class="dw-rcol-steps kp-toc">
                     <xsl:for-each select="/dw-document/dw-knowledge-path/kp-steps/kp-step/heading">
                         <xsl:variable name="kpnewid">
                            <xsl:choose>
                               <xsl:when test="@refname != ''">
                                  <xsl:value-of select="concat('#', @refname)"/>
                               </xsl:when>
                               <xsl:otherwise>
                                  <xsl:value-of select="concat('#', generate-id())"/>
                               </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="kptoctext">
                           <xsl:choose>
                              <xsl:when test="@alttoc != ''">
                                 <xsl:value-of select="@alttoc"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:value-of select="."/>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:variable>
                        <li>
	              <a href="{$kpnewid}">
	                 <xsl:value-of select="$kptoctext"/>
                           </a>
                        </li>
                     </xsl:for-each>
                 </ol>
                 <!-- xM r2.3 6.0 08/30/11 tdc:  Don't show HR nor optional discuss link if kp-discuss-url not in xml  -->		
                 <xsl:if test="normalize-space(kp-discuss-url) != ''">
                    <div class="ibm-rule"><hr /></div>
                       <ul class="ibm-link-list ibm-alternate">
                          <li><a class="dw-kp-discuss" href="{$discuss-link}"><xsl:value-of select="$kp-discuss-link" /></a></li>
                      </ul>
                </xsl:if>
             </xsl:template>
             
             <xsl:template name="KnowledgePathRelatedResources">
                 <ul class="ibm-link-list ibm-alternate">
                     <xsl:for-each select="/dw-document/dw-knowledge-path/kp-related-resources/kp-related-resource">
                         <xsl:variable name="related-resource-anchor-class">
	                <xsl:choose>
	                    <xsl:when test="@kp-related-resource-type = 'discuss'">ibm-chat-link</xsl:when>
	                    <xsl:when test="@kp-related-resource-type = 'other'">
	                        <xsl:choose>
	                            <xsl:when test="contains(kp-related-resource-url, '.pdf') or contains(kp-related-resource-url, '.PDF')">ibm-pdf-link</xsl:when>
	                            <xsl:otherwise>ibm-forward-link</xsl:otherwise>
	                        </xsl:choose>
	                    </xsl:when>	                    
	                </xsl:choose>
                         </xsl:variable>
                         <li>
                             <a class="{$related-resource-anchor-class}" href="{kp-related-resource-url}">
                                 <xsl:value-of select="kp-related-resource-title"/>
                             </a>
                         </li>
                      </xsl:for-each>                         
                 </ul>
             </xsl:template>                 
                 
</xsl:stylesheet>