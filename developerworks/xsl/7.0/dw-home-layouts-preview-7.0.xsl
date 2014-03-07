<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>

<!-- HomeStandard LAYOUT -->
<!-- HomeStandard LAYOUT -->
<!-- HomeStandard LAYOUT -->  
<xsl:template name="HomeStandard">

	<xsl:comment> LEADSPACE_BEGIN </xsl:comment>
	<xsl:apply-templates select=".">
		<xsl:with-param name="template">leadspace</xsl:with-param>
	</xsl:apply-templates>
	<xsl:comment> LEADSPACE_END </xsl:comment>
	
	<div id="ibm-pcon">
	
	<xsl:comment> BEGIN_IBM-CONTENT </xsl:comment>	
	<div id="ibm-content">
	
	<xsl:comment> BEGIN_IBM-CONTENT-BODY </xsl:comment>
	<div id="ibm-content-body">
	
	<xsl:comment> BEGIN_IBM-CONTENT-MAIN </xsl:comment>
	<div id="ibm-content-main">
	
	<xsl:comment> INTERIOR_2_2_2_BEGIN </xsl:comment>
	<div class="ibm-columns">
	
	<xsl:comment> TOPICS_COLUMN </xsl:comment>
	<div class="ibm-col-6-2">
		<!-- Process dynamic module heading -->
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">trending_1_dynamicHeading</xsl:with-param>
		</xsl:call-template>
	</div>
	
	<xsl:comment> DOWNLOADS_COLUMN </xsl:comment>
	<div class="ibm-col-6-2">
		<!-- Process dynamic module heading -->
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">downloads_1_dynamicHeading</xsl:with-param>
		</xsl:call-template>		
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">downloads_1_dynamicLinkBlock</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">downloads_1_dynamicForwardLink</xsl:with-param>
		</xsl:call-template>
	</div>
	
	<xsl:comment> COMMUNITY_COLUMN </xsl:comment>
	<div class="ibm-col-6-2">
		<!-- Process dynamic module heading -->
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">community_1_dynamicHeading</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">community_1_dynamicLinkBlock</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ModuleDynamic-v17">
			<xsl:with-param name="componentRequestName">community_1_dynamicForwardLink</xsl:with-param>
		</xsl:call-template>
	</div>	
	
	<xsl:comment> INTERIOR_2_2_2_END </xsl:comment>	
	</div>
	
	<xsl:comment> PROMOTION_AREA_BEGIN </xsl:comment>
	<xsl:apply-templates select=".">
		<xsl:with-param name="template">modulePromotion</xsl:with-param>
	</xsl:apply-templates>
	<xsl:comment> PROMOTION_AREA_END </xsl:comment>
	
	</div>
	<xsl:comment> END_IBM-CONTENT-MAIN </xsl:comment>
	
	<xsl:comment> END_IBM-CONTENT-BODY </xsl:comment>
	</div>
	
	<xsl:comment> END_IBM-CONTENT </xsl:comment>
	</div>
	
	<xsl:comment> END_IBM-PCON </xsl:comment>
	</div>
	
	<xsl:apply-templates select=".">
		<xsl:with-param name="template">cmaSiteStylesheetId</xsl:with-param>
	</xsl:apply-templates>	

</xsl:template>

</xsl:stylesheet>
