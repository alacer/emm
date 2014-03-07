<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>

<!-- ResultsTrending LAYOUT -->
<!-- ResultsTrending LAYOUT -->
<!-- ResultsTrending LAYOUT -->  
<xsl:template name="ResultsTrending">

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
	
	<xsl:comment> INTERIOR_4_2_BEGIN </xsl:comment>
	<div class="ibm-columns">
	
	<xsl:comment> FEATURED_LINKS </xsl:comment>
	<div class="ibm-col-6-4">
		<xsl:apply-templates select=".">
			<xsl:with-param name="template">featuredResults</xsl:with-param>
		</xsl:apply-templates>
	</div>
	
	<!-- <xsl:comment> DYNAMIC_RELATED_MODULES </xsl:comment>
	<div class="ibm-col-6-2">

	</div> -->
	
	<xsl:comment> INTERIOR_4_2_END </xsl:comment>	
	</div>
	
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
