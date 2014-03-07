<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <xsl:param name="local-url-base">..</xsl:param>
  <xsl:param name="xform-type">final</xsl:param>
  <xsl:variable name="newpath-dw-root-local">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/</xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">Error! invalid value '<xsl:value-of
            select="xform-type" />' for xform-type parameter.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "
      >http://www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-dw-root-web-inc">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/vn/inc/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />/web/www.ibm.com/developerworks/vn/inc/</xsl:when>
    </xsl:choose>
  </xsl:variable>
    <xsl:variable name="newpath-dw-root-local-ls">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">/developerworks/vn/</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base"
         />../web/www.ibm.com/developerworks/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-ibm-local">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' "><xsl:value-of select="$local-url-base" />/web/</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="newpath-protocol">
    <xsl:choose>
      <xsl:when test="$xform-type = 'final' ">//</xsl:when>
      <xsl:when test="$xform-type = 'preview' ">http://</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="path-dw-inc"><xsl:value-of select="$newpath-dw-root-local"/>inc/</xsl:variable>    
  <xsl:variable name="path-dw-images"><xsl:value-of select="$newpath-dw-root-local"/>i/</xsl:variable>
  <xsl:variable name="path-ibm-i"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/</xsl:variable>
  <xsl:variable name="path-v14-icons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/icons/</xsl:variable>
  <xsl:variable name="path-v14-t"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/t/</xsl:variable>
  <xsl:variable name="path-v14-rules"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/rules/</xsl:variable>
  <xsl:variable name="path-v14-bullets"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/bullets/</xsl:variable>
  <xsl:variable name="path-v14-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v14/buttons/</xsl:variable>
  <!-- 6.0 jpp 11/15/08 : Added path for v16 buttons -->
 <xsl:variable name="path-v16-buttons"><xsl:value-of select="$newpath-ibm-local"/>www.ibm.com/i/v16/buttons/</xsl:variable>
<xsl:variable name="path-dw-views">http://www.ibm.com/developerworks/vn/views/</xsl:variable>
  <xsl:variable name="path-ibm-stats"><xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/</xsl:variable>
  <xsl:variable name="path-ibm-rc-images"><xsl:value-of select="$newpath-protocol"/>stats.www.ibm.com/rc/images/</xsl:variable>
  <xsl:variable name="path-dw-js"><xsl:value-of select="$newpath-dw-root-web"/>js/</xsl:variable>
  <xsl:variable name="path-dw-email-js"><xsl:value-of select="$newpath-dw-root-web"/>email/</xsl:variable>
  <xsl:variable name="path-ibm-common-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>
  <xsl:variable name="path-ibm-common-stats"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/stats/</xsl:variable>
  <xsl:variable name="path-ibm-data-js"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/</xsl:variable>
  <xsl:variable name="path-ibm-survey-esites"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/data/js/survey/esites/</xsl:variable>
  <xsl:variable name="path-ibm-common-css"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/common/v14/</xsl:variable>  
  <xsl:variable name="path-dw-offers">http://www.ibm.com/developerworks/offers/</xsl:variable>
  <xsl:variable name="path-dw-techbriefings">techbriefings/</xsl:variable>
  <xsl:variable name="techbriefingBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-techbriefings"/></xsl:variable>
  <xsl:variable name="bctlTechnicalBriefings">Technical briefings</xsl:variable>
  <xsl:variable name="path-dw-businessperspectives">techbriefings/business.html</xsl:variable>
  <xsl:variable name="businessperspectivesBreadcrumb"><xsl:value-of select="$path-dw-offers"/><xsl:value-of select="$path-dw-businessperspectives"/></xsl:variable>
  <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="bctlBusinessPerspectives">Viễn cảnh Kinh doanh</xsl:variable>
  <xsl:variable name="main-content">chuyển đến nội dung chính</xsl:variable>
    <!-- ************************************* Nguyen translate end ************************************  -->
  
  <!-- v17 Enablement jpp 09/24/2011:  Added web-site-owner variable -->
  <xsl:variable name="web-site-owner">dwvn@vn.ibm.com</xsl:variable>
  <!-- v17 Enablement jpp 09/24/2011:  Removed preview stylesheet calls from this file --> 

  <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="Attrib-javaworld">Đăng lại với sự cho phép của <a href="http://www.javaworld.com/?IBMDev">tạp chí JavaWorld</a>. Bản quyền của IDG.net, một công ty của IDG Communications.  Đăng ký miễn phí <a href="http://www.javaworld.com/subscribe?IBMDev">bản tin JavaWorld qua thư điện tử</a>.
</xsl:variable>
    <!-- ************************************* Nguyen translate end ************************************  -->
  <!-- v17 Enablement jpp 09/24/2011:  Updated stylesheet reference to 7.0 -->
  <xsl:variable name="stylesheet-id">XSLT stylesheet used to transform this file:  dw-document-html-7.0.xsl</xsl:variable>

  <xsl:variable name="browser-detection-js-url">http://www.ibm.com/developerworks/js/dwcss.js</xsl:variable>
  <xsl:variable name="default-css-url">http://www.ibm.com/developerworks/css/r1ss.css</xsl:variable>
  <xsl:variable name="col-icon-subdirectory">/developerworks/vn/i/</xsl:variable>
  <xsl:variable name="journal-icon-subdirectory">/developerworks/i/</xsl:variable>
  <!-- ************************************* Nguyen translate begin ************************************  -->
  <!-- 6.0 Maverick R2 jpp-egd 06/12/09: Add variable for journal link introduction in articles/tutorials -->
  <xsl:variable name="journal-link-intro">Nội dung này nằm trong loạt bài về</xsl:variable>
  <xsl:variable name="from">Từ</xsl:variable>
  <xsl:variable name="aboutTheAuthor">Đôi nét về tác giả</xsl:variable>
  <xsl:variable name="aboutTheAuthors">Đôi nét về các tác giả</xsl:variable>
    <!-- Maverick 6.0 R3 egd 09 06 10:  Added AuthorBottom headings for summary pages -->
 <xsl:variable name="biography">Tiểu sử</xsl:variable>
  <xsl:variable name="biographies">Tiểu sử</xsl:variable>
  <xsl:variable name="translated-by">Dịch bởi: </xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08 START -->
  <xsl:variable name="date">Ngày:</xsl:variable>
  <xsl:variable name="published">Ngày đăng:</xsl:variable>
  <!-- end 6.0 Maverick beta -->
  <xsl:variable name="updated">Cập nhật </xsl:variable>
  <xsl:variable name="translated">Đã dịch:</xsl:variable>
  <xsl:variable name="wwpublishdate">Ngày đăng:</xsl:variable>
  <xsl:variable name="linktoenglish-heading">Bản gốc tiếng Anh</xsl:variable>
  <xsl:variable name="linktoenglish">tại đây</xsl:variable>
  <xsl:variable name="daychar"/>
  <xsl:variable name="monthchar"/>
  <xsl:variable name="yearchar"/>
    <!-- 6.0 Maverick beta jpp 06/18/08 START -->
  <xsl:variable name="pdf-heading">PDF:</xsl:variable>
  <xsl:variable name="pdf-common">A4 và Thư</xsl:variable>
  <!-- 6.0 Maverick beta jpp 06/18/08 END -->
  <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="pdf-alt-letter">PDF format - letter</xsl:variable>
  <xsl:variable name="pdf-alt-a4">PDF format - A4</xsl:variable>
  <xsl:variable name="pdf-alt-common">PDF format - Khổ giấy A4 và Thư</xsl:variable>
  <xsl:variable name="pdf-text-letter">PDF - Letter</xsl:variable>
  <xsl:variable name="pdf-text-a4">PDF - A4</xsl:variable>
  <xsl:variable name="pdf-text-common">PDF - Khổ giấy A4 và Thư</xsl:variable>
  <xsl:variable name="pdf-page">page</xsl:variable>
  <xsl:variable name="pdf-pages">pages</xsl:variable>
  <!-- ************************************* Nguyen translate begin ************************************  -->
<xsl:variable name="document-options-heading">Lựa chọn tài liệu</xsl:variable>
  <xsl:variable name="options-discuss">Thảo luận</xsl:variable>
  <xsl:variable name="sample-code">Mã ví dụ</xsl:variable>
  <xsl:variable name="download-heading">Tải về</xsl:variable>
  <xsl:variable name="downloads-heading">Các tải về</xsl:variable>
  <xsl:variable name="download-note-heading">Ghi chú</xsl:variable>
  <xsl:variable name="download-notes-heading">Các ghi chú</xsl:variable>
  <xsl:variable name="also-available-heading">Cũng sẵn có tại</xsl:variable>
  <xsl:variable name="download-heading-more">Tải về thêm</xsl:variable>
  <xsl:variable name="download-filename-heading">Tên</xsl:variable>
  <xsl:variable name="download-filedescription-heading">Mô tả</xsl:variable>
  <xsl:variable name="download-filesize-heading">Kích thước</xsl:variable>
  <xsl:variable name="download-method-heading">Phương thức tải</xsl:variable>
  <xsl:variable name="download-method-link">Thông tin về phương thức tải</xsl:variable>
     <!-- ibs 2010-07-22 Add following variables to translated-text for each language.
    heading-figure-lead goes before the figure number and heading-figure-trail
    follows it (if some language requires it). Same for code and table variants.    
-->
  <xsl:variable name="heading-figure-lead" select="'Hình ' "/>
    <xsl:variable name="heading-figure-trail" select=" '' "/>
    <xsl:variable name="heading-table-lead" select="'Bảng ' "/>
    <xsl:variable name="heading-table-trail" select=" '' "/>
    <xsl:variable name="heading-code-lead" select="'Liệt kê ' "/>
    <xsl:variable name="heading-code-trail" select=" '' "/> 
    
	<xsl:variable name="code-sample-label">Mã ví dụ: </xsl:variable>
  <!-- dr 3253 Maverick R2 - license displays for all code sample downloads now regardless of local site value -->
  <xsl:variable name="license-locale-value">en_VN</xsl:variable>
	<xsl:variable name="demo-label">Trình diễn: </xsl:variable>
	<xsl:variable name="presentation-label">Trình chiếu: </xsl:variable>
	<xsl:variable name="product-documentation-label">Tài liệu về sản phẩm: </xsl:variable>
	<xsl:variable name="specification-label">Đặc tả: </xsl:variable>
	<xsl:variable name="technical-article-label">Bài báo kỹ thuật: </xsl:variable>
	<xsl:variable name="whitepaper-label">Sách trắng: </xsl:variable>
  <!-- ************************************* Nguyen translate end ************************************  -->

	<xsl:variable name="socialtagging-inc">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-reserved-social-tagging.inc" -->]]></xsl:text>
	</xsl:variable>	
  <!-- xM R2.2 egd 05 10 11:  Moved the ssi-s-backlink-module and ssi-s-backlink-rule variables from dw-ssi-worldwide xsl to here as we no longer plan to use the ssi xsl -->
  <!-- 6.0 Maverick R2 10/05/09 jpp: Added new variable for back to top link in landing page modules -->
  <xsl:variable name="ssi-s-backlink-module">
    <p class="ibm-ind-link ibm-back-to-top ibm-no-print"><a class="ibm-anchor-up-link" href="#ibm-pcon">Về đầu trang</a></p>
  </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <xsl:variable name="ssi-s-backlink-rule">
    <div class="ibm-alternate-rule"><hr /></div>
    <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Về đầu trang</a></p>
  </xsl:variable>	
  <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="download-get-adobe">
    <xsl:text disable-output-escaping="yes"><![CDATA[Tải Adobe&#174; Reader&#174;]]></xsl:text>
  </xsl:variable>
    <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="download-path">en_us</xsl:variable>
  <!-- 6.0 Maverick R3 04/27/10 llk: added zoneleftnav-path variable to address local site processing of ZoneLeftNav-v16 in generic landing page processing -->
  <xsl:variable name="zoneleftnav-path">/inc/en_VN/</xsl:variable>
  <xsl:variable name="product-doc-url">
    <a href="http://www.elink.ibmlink.ibm.com/public/applications/publications/cgibin/pbi.cgi?CTY=US&amp;&amp;FNC=ICL&amp;">Tài liệu về sản phẩm</a>
  </xsl:variable>
    <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="redbooks-url">
    <a href="http://www.redbooks.ibm.com/">Sách đỏ của IBM</a>
  </xsl:variable>
  <xsl:variable name="tutorials-training-url">
    <a href="/developerworks/training/">Bài học và đào tạo</a>
  </xsl:variable>
  <xsl:variable name="drivers-downloads-url">
    <a href="http://www-1.ibm.com/support/us/all_download_drivers.html">Hỗ trợ tải về</a>
  </xsl:variable>
    <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="footer-inc-default">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-footer.inc" -->]]></xsl:text>
  </xsl:variable>
  <xsl:variable name="developerworks-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
  <xsl:variable name="developerworks-top-url-nonportal">http://www.ibm.com/developerworks/vn/</xsl:variable>
      <!-- ************************************* Nguyen translate begin ************************************  -->
<!-- Maverick 6.0 R3 egd 01 20 10:  Updated top heading for xM release -->
  <xsl:variable name="developerworks-top-heading">developerWorks</xsl:variable>
  <!-- Maverick 6.0 R3 egd 01 18 11:  Added text and URLs for top xM navigation -->
    <!-- in template name="Breadcrumb-v16" and template name="Title-v16" -->
  <xsl:variable name="technical-topics-text">Các chủ đề kỹ thuật</xsl:variable>
 <xsl:variable name="technical-topics-url">http://www.ibm.com/developerworks/vn/topics/</xsl:variable>
  <xsl:variable name="evaluation-software-text">Đánh giá phần mềm</xsl:variable>
 <xsl:variable name="evaluation-software-url">http://www.ibm.com/developerworks/downloads/</xsl:variable>
  <xsl:variable name="community-text">Cộng đồng</xsl:variable>
 <xsl:variable name="community-url">https://www.ibm.com/developerworks/community/groups/service/html/allcommunities?lang=en</xsl:variable>
  <xsl:variable name="events-text"></xsl:variable>
 <xsl:variable name="events-url"></xsl:variable>   
  <!-- Maverick 6.0 R2 egd 03 14 10: Author badge URLs -->
  <xsl:variable name="contributing-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_cont_VN.jpg</xsl:variable>
  <xsl:variable name="professional-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_prof_VN.jpg</xsl:variable>
  <xsl:variable name="master-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast_VN.jpg</xsl:variable>
  <xsl:variable name="master2-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast2_VN.jpg</xsl:variable>
  <xsl:variable name="master3-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast3_VN.jpg</xsl:variable>
  <xsl:variable name="master4-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast4_VN.jpg</xsl:variable>
  <xsl:variable name="master5-author-url"><xsl:value-of select="$newpath-protocol"/>www.ibm.com/developerworks/i/ARbadge_mast5_VN.jpg</xsl:variable>
    <!-- Maverick 6.0 R3 egd 08 22 10:  Author badge alt attribute values -->
		 <xsl:variable name="contributing-author-alt">Cấp độ đóng góp cho developerWorks của tác giả</xsl:variable>
    <xsl:variable name="professional-author-alt">Tác giả chuyên nghiệp của developerWorks</xsl:variable>
    <xsl:variable name="master-author-alt">Tác giả chuyên gia của developerWorks</xsl:variable>
    <xsl:variable name="master2-author-alt">Tác giả chuyên gia mức 2 của developerWorks</xsl:variable>
    <xsl:variable name="master3-author-alt">Tác giả chuyên gia mức 3 của developerWorks</xsl:variable>
    <xsl:variable name="master4-author-alt">Tác giả chuyên gia mức 4 của developerWorks</xsl:variable>
    <xsl:variable name="master5-author-alt">Tác giả chuyên gia mức 5 của developerWorks</xsl:variable> 
  <!-- Maverick 6.0 R2 egd 0314 10 Author badge statement for jquery popup -->   
  <xsl:variable name="contributing-author-text">(Tác giả đóng góp cho IBM developerWorks)</xsl:variable>  
  <xsl:variable name="professional-author-text">(Tác giả chuyên nghiệp của IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master-author-text">(Tác giả của IBM developerWorks)</xsl:variable>  
  <xsl:variable name="master2-author-text">(Tác giả của IBM developerWorks, cấp 2)</xsl:variable>  
  <xsl:variable name="master3-author-text">(Tác giả của IBM developerWorks, cấp 3)</xsl:variable>  
  <xsl:variable name="master4-author-text">(Tác giả của IBM developerWorks, cấp 4)</xsl:variable>  
  <xsl:variable name="master5-author-text">(Tác giả của IBM developerWorks, cấp 5)</xsl:variable>    
  <xsl:variable name="icon-discuss-alt">Thảo luận</xsl:variable>
  <xsl:variable name="icon-code-download-alt">Tải về</xsl:variable>
  <xsl:variable name="icon-code-alt">Mã</xsl:variable>
  <xsl:variable name="Summary">Tóm tắt</xsl:variable>
   <xsl:variable name="level-text-heading">Mức độ: </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/12/08: Updated for MAVERICK to include zone top URLs -->
   <xsl:variable name="aix-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="architecture-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <!-- 5.11 12/14/08 egd: Confirmed url had been changed from db2 to data -->
   <xsl:variable name="db2-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Cloud content area top url -->
  <xsl:variable name="cloud-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="ibm-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Added variable for Industries content area top url -->
  <xsl:variable name="industry-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
  <xsl:variable name="ibmi-top-url">http://www.ibm.com/developerworks/systems/ibmi/</xsl:variable> 
   <xsl:variable name="java-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="linux-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="lotus-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="opensource-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="power-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <!-- 6.0 llk DR 3127 - add grid, security, autonomic support -->
   <xsl:variable name="grid-top-url"></xsl:variable>
   <xsl:variable name="security-top-url"></xsl:variable>
   <xsl:variable name="autonomic-top-url"></xsl:variable>
   <xsl:variable name="rational-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="tivoli-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="web-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="webservices-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="websphere-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <xsl:variable name="xml-top-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
   <!-- 6.0 jpp 10/30/08 : Added for Maverick R1 - alphaWorks -->
   <xsl:variable name="alphaworks-top-url">http://www.ibm.com/alphaworks/</xsl:variable>
   <!-- end zone top URLs for Maverick -->
      <!-- 6.0 Maverick R3 egd 04 23 10:  Added variables for global library url and text for dW home and local sites tabbed module, featured content -->
   <!-- begin global library variables -->
   <xsl:variable name="dw-global-library-url">http://www.ibm.com/developerworks/vn/library/</xsl:variable>
  <xsl:variable name="dw-global-library-text">Thêm nội dung</xsl:variable>
  <xsl:variable name="technical-library">Thư viện Kỹ thuật</xsl:variable>      
  <xsl:variable name="developerworks-secondary-url">http://www.ibm.com/developerworks/vn/</xsl:variable>
  <xsl:variable name="figurechar"/>
  <xsl:variable name="icon-discuss-gif">/developerworks/i/icon-discuss.gif</xsl:variable>
  <xsl:variable name="icon-code-gif">/developerworks/i/icon-code.gif</xsl:variable>
  <xsl:variable name="icon-pdf-gif">/developerworks/i/icon-pdf.gif</xsl:variable>
  <xsl:variable name="english-source-heading"/>
  <xsl:variable name="lang">vn</xsl:variable>
<xsl:variable name="topmast-inc">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-topmast.inc" -->]]></xsl:text>
    </xsl:variable>
  <!-- 6.0 Maverick beta egd 06/14/08: Not using for Maverick data, created series and seriesview for series title in Summary area -->

  <!-- End Not using for Maverick series title -->
  <xsl:variable name="moreThisSeries">Đọc thêm trong loạt bài này</xsl:variable>
  <xsl:variable name="left-nav-in-this-article">Trong bài báo này:</xsl:variable>
  <xsl:variable name="left-nav-in-this-tutorial">Trong bài học này:</xsl:variable>
      <!-- ************************************* Nguyen translate end ************************************  -->
    <xsl:variable name="left-nav-top"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14-top.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-rlinks"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14-rlinks.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
     <xsl:variable name="left-nav-events-architecture"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
  <xsl:variable name="left-nav-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-aix"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text>      </xsl:variable>
  <xsl:variable name="left-nav-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="left-nav-events-autonomic"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-db2"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-grid"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-ibm"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-java"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-linux"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-lotus"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-opensource"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-power"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
<!--  5.2 10/03 fjc: add training inc-->
    <xsl:variable name="left-nav-training-rational"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-security"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-tivoli"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-web"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices-summary-spec"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-webservices"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-training-websphere"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>
    <xsl:variable name="left-nav-events-xml"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-nav14.inc" -->]]></xsl:text></xsl:variable>

  <xsl:variable name="owner-meta-url"> https://www.ibm.com/developerworks/secure/feedback.jsp?domain=</xsl:variable>
  <xsl:variable name="dclanguage-content">en-VN</xsl:variable>
  <xsl:variable name="ibmcountry-content">VN</xsl:variable>
  
  <xsl:variable name="server-s-header-meta"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-meta.inc" -->]]></xsl:text></xsl:variable>        
  <xsl:variable name="server-s-header-scripts"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="]]></xsl:text><xsl:copy-of select="$newpath-dw-root-web-inc"/><xsl:text disable-output-escaping="yes"><![CDATA[s-header-scripts.inc" -->]]></xsl:text></xsl:variable>
  
      <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="aboutTheModerator">Đôi nét về người quản trị nội dung</xsl:variable>
  <xsl:variable name="aboutTheModerators">Đôi nét về những người quản trị nội dung</xsl:variable>
  
  <xsl:variable name="month-1-text">01</xsl:variable>
  <xsl:variable name="month-2-text">02</xsl:variable>
  <xsl:variable name="month-3-text">03</xsl:variable>
  <xsl:variable name="month-4-text">04</xsl:variable>
  <xsl:variable name="month-5-text">05</xsl:variable>
  <xsl:variable name="month-6-text">06</xsl:variable>
  <xsl:variable name="month-7-text">07</xsl:variable>
  <xsl:variable name="month-8-text">08</xsl:variable>
  <xsl:variable name="month-9-text">09</xsl:variable>
  <xsl:variable name="month-10-text">10</xsl:variable>
  <xsl:variable name="month-11-text">11</xsl:variable>
  <xsl:variable name="month-12-text">12</xsl:variable>
  <xsl:variable name="page">Trang</xsl:variable>
  <xsl:variable name="of">của</xsl:variable>
  <xsl:variable name="pageofendtext"></xsl:variable>	
      <xsl:variable name="previoustext">Trở về trang trước</xsl:variable>
   <xsl:variable name="nexttext">Đến trang tiếp theo</xsl:variable>
  <!-- 6.0 R3 llk 4/26/10 add variables for Previous / Next -->  
  <xsl:variable name="previous">Trang trước</xsl:variable>
  <xsl:variable name="next">Trang sau</xsl:variable>
  <xsl:variable name="related-content-heading">Nội dung có liên quan:</xsl:variable>
  <xsl:variable name="left-nav-related-links-heading">Các đường dẫn có liên quan</xsl:variable>
  <xsl:variable name="left-nav-related-links-techlib">thư viện kỹ thuật</xsl:variable>
  <xsl:variable name="subscriptions-heading">Đăng ký dài hạn:</xsl:variable>
  <xsl:variable name="dw-newsletter-text">bản tin dW</xsl:variable>
        <!-- ************************************* Nguyen translate end ************************************  -->

  <xsl:variable name="dw-newsletter-url">http://www.ibm.com/developerworks/newsletter/</xsl:variable>
  <xsl:variable name="rational-edge-url">/developerworks/rational/rationaledge/</xsl:variable>

      <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="rational-edge-text">The Rational Edge</xsl:variable>
  <xsl:variable name="resource-list-heading">Tài nguyên</xsl:variable>
  <xsl:variable name="resource-list-forum-text">
    <xsl:text disable-output-escaping="yes"><![CDATA[<a href="]]></xsl:text>
                    <xsl:value-of select="/dw-document//forum-url/@url"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[">Tham gia diễn đàn thảo luận</a>.]]></xsl:text></xsl:variable>
  <xsl:variable name="resources-learn">Học tập</xsl:variable>
  <xsl:variable name="resources-get">Lấy sản phẩm và công nghệ</xsl:variable>
  <xsl:variable name="resources-discuss">Thảo luận</xsl:variable>
   <!-- xM R2 (R2.3) jpp 08/02/11: Added variables for sidebar-custom template -->
  <!-- In template name="sidebar-custom" -->
  <xsl:variable name="knowledge-path-heading">Develop skills on this topic</xsl:variable>
  <xsl:variable name="knowledge-path-text">This content is part of a progressive knowledge path for advancing your skills.  See</xsl:variable>
  <xsl:variable name="knowledge-path-text-multiple">This content is part of progressive knowledge paths for advancing your skills.  See:</xsl:variable>
  <xsl:variable name="level-1-text">Nhập môn</xsl:variable>
  <xsl:variable name="level-2-text">Nhập môn</xsl:variable>
  <xsl:variable name="level-3-text">Trung bình</xsl:variable>
  <xsl:variable name="level-4-text">Nâng cao</xsl:variable>
  <xsl:variable name="level-5-text">Nâng cao</xsl:variable>
  <xsl:variable name="tableofcontents-heading">Nội dung:</xsl:variable>
  <xsl:variable name="ratethisarticle-heading">Chấm điểm trang này</xsl:variable>
  <xsl:variable name="ratethistutorial-heading">Chấm điểm bài học này</xsl:variable>
    <!-- 6.0 Maverick beta jpp 06/17/08: In template name="TableOfContents"  -->
  <xsl:variable name="toc-heading">Mục lục</xsl:variable>
  <xsl:variable name="inline-comments-heading">Bình luận</xsl:variable>
  <!-- End 6.0 Maverick TableofContents -->
  <xsl:variable name="domino-ratings-post-url">http://www.alphaworks.ibm.com/developerworks/ratings.nsf/RateArticle?CreateDocument</xsl:variable>
  <xsl:variable name="method">POST</xsl:variable>
  <xsl:variable name="ratings-thankyou-url">http://www.ibm.com/developerworks/vn/thankyou/feedback-thankyou.html</xsl:variable>
  
      <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="ratings-intro-text">Làm ơn bớt chút thời gian hoàn thành bản điều tra này để chúng tôi phục vụ được tốt hơn.</xsl:variable>
  <xsl:variable name="ratings-question-text">Nội dung này có ích với tôi:</xsl:variable>
  <xsl:variable name="ratings-value5-text">Rất đồng ý (5)</xsl:variable>
  <xsl:variable name="ratings-value4-text">Đồng ý (4)</xsl:variable>
  <xsl:variable name="ratings-value3-text">Bình thường (3)</xsl:variable>
  <xsl:variable name="ratings-value2-text">Không đồng ý (2)</xsl:variable>
  <xsl:variable name="ratings-value1-text">Rất không đồng ý (1)</xsl:variable>
  <xsl:variable name="ratings-value5-width">21%</xsl:variable>
  <xsl:variable name="ratings-value4-width">17%</xsl:variable>
  <xsl:variable name="ratings-value3-width">24%</xsl:variable>
  <xsl:variable name="ratings-value2-width">17%</xsl:variable>
  <xsl:variable name="ratings-value1-width">21%</xsl:variable>
  <xsl:variable name="comments-noforum-text">Góp ý kiến?</xsl:variable>
  <xsl:variable name="comments-withforum-text">Gửi góp ý cho chúng tôi hoặc chọn mục Thảo luận để chia sẻ nhận xét với những người khác.</xsl:variable>
  <xsl:variable name="submit-feedback-text">Gửi góp ý</xsl:variable>
      <!-- ************************************* Nguyen translate end ************************************  -->
<xsl:variable name="site_id">70</xsl:variable>
      <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="contentarea-ui-name-aw">alphaWorks</xsl:variable>
    <xsl:variable name="contentarea-ui-name-ar">Kiến trúc</xsl:variable>
    <xsl:variable name="contentarea-ui-name-au">AIX và UNIX</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ac">Tính toán tự trị</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-blogs">Blogs</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-community">Community</xsl:variable>
  <!-- 6.0 jpp 10/30/08 : Added variable to cover content area in the extended content area week -->
  <xsl:variable name="contentarea-ui-name-downloads">Downloads</xsl:variable>
  <xsl:variable name="contentarea-ui-name-gr">Tính toán lưới</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the name of the new zone IBM i -->
  <xsl:variable name="contentarea-ui-name-ibmi">IBM i</xsl:variable>  
  <xsl:variable name="contentarea-ui-name-j">Công nghệ Java</xsl:variable>
  <xsl:variable name="contentarea-ui-name-l">Linux</xsl:variable>
  <xsl:variable name="contentarea-ui-name-os">Nguồn mở</xsl:variable>
  <xsl:variable name="contentarea-ui-name-ws">SOA và dịch vụ Web</xsl:variable>
  <xsl:variable name="contentarea-ui-name-x">XML</xsl:variable>
  <xsl:variable name="contentarea-ui-name-s">An ninh</xsl:variable>
  <xsl:variable name="contentarea-ui-name-wa">Phát triển Web</xsl:variable>
  <xsl:variable name="contentarea-ui-name-i">Các dự án IT mẫu</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Cloud -->
  <xsl:variable name="contentarea-ui-name-cl">Cloud computing</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding UI content area name for Industries -->
  <xsl:variable name="contentarea-ui-name-in">Industries</xsl:variable>
  <xsl:variable name="contentarea-ui-name-db2">Information Management</xsl:variable>
  <xsl:variable name="contentarea-ui-name-lo">Lotus</xsl:variable>
  <xsl:variable name="contentarea-ui-name-r">Rational</xsl:variable>
  <xsl:variable name="contentarea-ui-name-tiv">Tivoli</xsl:variable>
  <xsl:variable name="contentarea-ui-name-web">WebSphere</xsl:variable>
	<xsl:variable name="contentarea-ui-name-pa">Tăng tốc đa lõi</xsl:variable>
      <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="techlibview-db2">http://www.ibm.com/developerworks/vn/views/data/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Cloud technical library view -->
  <xsl:variable name="techlibview-cl">http://www.ibm.com/developerworks/vn/views/cloud/libraryview.jsp</xsl:variable>
  <!-- Maverick 6.0 R3 jpp/egd/llk 04 14 10:  Adding URL for Industries technical library view -->
  <xsl:variable name="techlibview-in">http://www.ibm.com/developerworks/vn/views/industry/libraryview.jsp</xsl:variable>
   <xsl:variable name="techlibview-ar">http://www.ibm.com/developerworks/vn/views/architecture/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-s"></xsl:variable>
  <xsl:variable name="techlibview-i">http://www.ibm.com/developerworks/vn/views/ibm/articles.jsp</xsl:variable>
  <xsl:variable name="techlibview-lo">http://www.ibm.com/developerworks/vn/views/lotus/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-r">http://www.ibm.com/developerworks/vn/views/rational/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-tiv">http://www.ibm.com/developerworks/vn/views/tivoli/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-web">http://www.ibm.com/developerworks/vn/views/websphere/libraryview.jsp</xsl:variable>
   <xsl:variable name="techlibview-au">http://www.ibm.com/developerworks/vn/views/aix/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ac">http://www.ibm.com/developerworks/vn/views/autonomic/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-gr">http://www.ibm.com/developerworks/vn/views/grid/libraryview.jsp</xsl:variable>
  <!-- xM R2 egd 03 09 11:  Create variable for the library view URL of the new zone IBM i -->
  <xsl:variable name="techlibview-ibmi">http://www.ibm.com/developerworks/ibmi/library/</xsl:variable> 
  <xsl:variable name="techlibview-j">http://www.ibm.com/developerworks/vn/views/java/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-l">http://www.ibm.com/developerworks/vn/views/linux/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-os">http://www.ibm.com/developerworks/vn/views/opensource/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-pa">http://www.ibm.com/developerworks/vn/views/power/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-ws">http://www.ibm.com/developerworks/vn/views/webservices/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-wa">http://www.ibm.com/developerworks/vn/views/web/libraryview.jsp</xsl:variable>
  <xsl:variable name="techlibview-x">http://www.ibm.com/developerworks/vn/views/xml/libraryview.jsp</xsl:variable>
  <!-- xM r2.3 6.0 08/09/11 tdc:  Added knowledge path variables  -->	
  <!-- KP variables: Start -->
  <!-- In template KnowledgePathNextSteps -->
  <xsl:variable name="heading-kp-next-steps">Next steps</xsl:variable>
  
  <!-- In template KnowledgePathTableOfContents -->
  <xsl:variable name="heading-kp-toc">Activities in this path</xsl:variable>
  <xsl:variable name="kp-discuss-link">Discuss this knowledge path</xsl:variable>
       <xsl:variable name="kp-resource-type-ui-download">Download</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-listen">Listen</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-practice">Practice</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-read">Read</xsl:variable>
  <xsl:variable name="kp-resource-type-ui-watch">Watch</xsl:variable>
  <xsl:variable name="kp-unchecked-checkmark">Gray unchecked checkmark</xsl:variable>
  <xsl:variable name="kp-checked-checkmark">Green checked checkmark</xsl:variable>
   <xsl:variable name="kp-next-step-ui-buy">Buy</xsl:variable>
   <xsl:variable name="kp-next-step-ui-download">Download</xsl:variable>
   <xsl:variable name="kp-next-step-ui-follow">Follow</xsl:variable>
   <xsl:variable name="kp-next-step-ui-join">Join</xsl:variable>
   <xsl:variable name="kp-next-step-ui-listen">Listen</xsl:variable>
   <xsl:variable name="kp-next-step-ui-practice">Practice</xsl:variable>
   <xsl:variable name="kp-next-step-ui-read">Read</xsl:variable>
   <xsl:variable name="kp-next-step-ui-watch">Watch</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-discuss">Discuss</xsl:variable>
  <xsl:variable name="kp-next-step-ui-enroll">Enroll</xsl:variable> 
  <xsl:variable name="kp-next-step-ui-register">Register</xsl:variable> 
  
  <xsl:variable name="kp-sign-in">Sign in</xsl:variable> 
  <!-- KP variables: End -->
    <xsl:variable name="products-landing-au">
    <xsl:value-of select="$developerworks-top-url"/>aix/products/</xsl:variable>
  <xsl:variable name="products-landing-db2">
    <xsl:value-of select="$developerworks-top-url"/>data/products/</xsl:variable>
  <xsl:variable name="products-landing-lo">
    <xsl:value-of select="$developerworks-top-url"/>lotus/products/</xsl:variable>
  <xsl:variable name="products-landing-r">
    <xsl:value-of select="$developerworks-secondary-url"/>rational/products/</xsl:variable>
  <xsl:variable name="products-landing-tiv">
    <xsl:value-of select="$developerworks-top-url"/>tivoli/products/</xsl:variable>
  <xsl:variable name="products-landing-web">
    <xsl:value-of select="$developerworks-top-url"/>websphere/products/</xsl:variable>
  <xsl:variable name="support-search-url">http://www-950.ibm.com/search/SupportSearchWeb/SupportSearch?pageCode=SPS</xsl:variable>
      <!-- ************************************* Nguyen translate begin ************************************  -->
   <xsl:variable name="support-search-text-intro">Để hiểu được ý nghĩa các mục của tài liệu xử lý lỗi,</xsl:variable>  
  <xsl:variable name="support-search-text-anchor-link">tìm trong cơ sở tri thức hỗ trợ kỹ thuật của IBM</xsl:variable> 
  <xsl:variable name="summary-inThisChat">Trong phiên phím đàm này</xsl:variable>
  <xsl:variable name="summary-inThisDemo">Trong trình diễn này</xsl:variable>
  <xsl:variable name="summary-inThisTutorial">Trong bài học này</xsl:variable>
  <xsl:variable name="summary-inThisLongdoc">Trong bài báo này</xsl:variable>
  <xsl:variable name="summary-inThisPresentation">Trong bài trình chiếu này</xsl:variable>
  <xsl:variable name="summary-inThisSample">Trong bài mẫu này</xsl:variable>
  <xsl:variable name="summary-inThisCourse">Trong bài giảng này</xsl:variable>
  <xsl:variable name="summary-objectives">Mục đích</xsl:variable>
  <xsl:variable name="summary-prerequisities">Yêu cầu tiên quyết</xsl:variable>
  <xsl:variable name="summary-systemRequirements">Yêu cầu hệ thống</xsl:variable>
  <xsl:variable name="summary-duration">Thời gian</xsl:variable>
  <xsl:variable name="summary-audience">Đối tượng</xsl:variable>
  <xsl:variable name="summary-languages">Ngôn ngữ</xsl:variable>
  <xsl:variable name="summary-formats">Định dạng</xsl:variable>
  <xsl:variable name="summary-minor-heading">Tiêu đề tóm tắt con</xsl:variable>
  <xsl:variable name="summary-getTheArticle">Lấy bài báo</xsl:variable>
  <xsl:variable name="summary-getTheWhitepaper">Lấy sách trắng</xsl:variable>
  <xsl:variable name="summary-getThePresentation">Lấy bài trình chiếu</xsl:variable>
  <xsl:variable name="summary-getTheDemo">Lấy bài trình diễn</xsl:variable>
    <xsl:variable name="summary-linktotheContent">Kết nối với nội dung</xsl:variable>
  <xsl:variable name="summary-getTheDownload">Lấy bản tải về</xsl:variable>
  <xsl:variable name="summary-getTheDownloads">Lấy các bản tải về</xsl:variable>
  <xsl:variable name="summary-getTheSample">Lấy ví dụ mẫu</xsl:variable>
  <xsl:variable name="summary-rateThisContent">Chấm điểm nội dung</xsl:variable>
  <xsl:variable name="summary-getTheSpecification">Lấy các đặc tả</xsl:variable>
  <xsl:variable name="summary-contributors">Người đóng góp: </xsl:variable>
  <xsl:variable name="summary-aboutTheInstructor">Vài nét về giảng viên</xsl:variable>
  <xsl:variable name="summary-aboutTheInstructors">Vài nét về các giảng viên</xsl:variable>
  <xsl:variable name="summary-viewSchedules">Xem lịch và đăng ký học</xsl:variable>
  <xsl:variable name="summary-viewSchedule">Xem lịch và đăng ký học</xsl:variable>
  <xsl:variable name="summary-aboutThisCourse">Về bài học này</xsl:variable>
  <xsl:variable name="summary-webBasedTraining">Bài giảng dựa trên Web</xsl:variable>
  <xsl:variable name="summary-instructorLedTraining">Bài giảng với giảng viên</xsl:variable>
  <xsl:variable name="summary-classroomTraining">Bài giảng trên lớp</xsl:variable>
  <xsl:variable name="summary-courseType">Kiểu bài giảng:</xsl:variable>
  <xsl:variable name="summary-courseNumber">Mã số bài giảng:</xsl:variable>
  <xsl:variable name="summary-scheduleCourse">Bài giảng</xsl:variable>
  <xsl:variable name="summary-scheduleCenter">Trung tâm Đào tạo</xsl:variable>
  <xsl:variable name="summary-classroomCourse">Bài giảng trên lớp</xsl:variable>
  <xsl:variable name="summary-onlineInstructorLedCourse">Bài giảng trực tuyến có hướng dẫn</xsl:variable>
  <xsl:variable name="summary-webBasedCourse">Bài giảng dựa trên Web</xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere1">Nếu muốn dạy tư bài giảng này, làm ơn tiếp xúc với chúng tôi tại </xsl:variable>
  <xsl:variable name="summary-enrollmentWebsphere2">. Học viên là người IBM sẽ đăng ký qua Global Campus.</xsl:variable>
  <!-- 5.0 6/2 fjc add plural-->
  <xsl:variable name="summary-plural">s</xsl:variable>
  <xsl:variable name="summary-register">Đăng ký bây giờ hoặc sử dụng IBM ID và mật khẩu của bạn để đăng nhập</xsl:variable>
  <xsl:variable name="summary-view">Xem trình diễn</xsl:variable>
  <xsl:variable name="summary-websphereTraining">Hỗ trợ kỹ thuật và đào tạo IBM WebSphere</xsl:variable>
      <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="backlink_include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-backlink.inc" -->]]></xsl:text></xsl:variable>
	<xsl:variable name="rnav-ratings-link-include"><xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/developerworks/vn/inc/s-rating-content.inc" -->]]></xsl:text></xsl:variable>
        <xsl:variable name="urltactic-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/urltactic.js" type="text/javascript"></script><script language="JavaScript" type="text/javascript">
 <!--
 setDefaultQuery(']]></xsl:text><xsl:value-of select="/dw-document//tactic-code-urltactic"/><xsl:text disable-output-escaping="yes"><![CDATA[');
 //-->
</script>
]]></xsl:text></xsl:variable>
    <xsl:variable name="delicious-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="http://del.icio.us/js/playtagger" type="text/javascript"></script>]]></xsl:text></xsl:variable>
    <xsl:variable name="delicious-metrics-script"><xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/delicious-playtagger-metrics.js" type="text/javascript"></script>]]></xsl:text></xsl:variable>
      <!-- ************************************* Nguyen translate begin ************************************  -->
  <xsl:variable name="ibm-developerworks-text">developerWorks : </xsl:variable>
  <xsl:variable name="more-link-text">Thêm</xsl:variable>
  <xsl:variable name="product-about-product-heading">Về sản phẩm</xsl:variable>
  <xsl:variable name="product-technical-library-heading">Tìm trong thư viện kỹ thuật</xsl:variable>
  <xsl:variable name="technical-library-search-text">Nhập từ khóa hoặc để trống để xem toàn bộ thư viện kỹ thuật:</xsl:variable>
  <xsl:variable name="product-information-heading">Thông tin về sản phẩm</xsl:variable>
  <xsl:variable name="product-related-products">Các sản phẩm có liên quan:</xsl:variable>
  <xsl:variable name="product-downloads-heading">Tải về, CDs, DVDs</xsl:variable>
  <xsl:variable name="product-learning-resources-heading">Tài nguyên học tập</xsl:variable>
  <xsl:variable name="product-support-heading">Hỗ trợ</xsl:variable>
  <xsl:variable name="product-community-heading">Cộng đồng</xsl:variable>
  <xsl:variable name="more-product-information-heading">Thêm thông tin về sản phẩm</xsl:variable>
  <xsl:variable name="spotlight-heading">Điểm nổi bật</xsl:variable>
  <xsl:variable name="latest-content-heading">Nội dung cuối cùng</xsl:variable>
  <xsl:variable name="more-content-link-text">Thêm nội dung</xsl:variable>
  <xsl:variable name="editors-picks-heading">Chọn lựa của Biên tập viên</xsl:variable>
  <xsl:variable name="products-heading">Các sản phẩm</xsl:variable>
  <xsl:variable name="pdfTableOfContents">Mục lục</xsl:variable>
  <xsl:variable name="pdfSection">Đoạn</xsl:variable>
  <xsl:variable name="pdfSkillLevel">Mức độ kỹ năng</xsl:variable>
  <!-- <xsl:variable name="pdfCopyrightNotice">© Copyright IBM Corporation 2009. All rights reserved.</xsl:variable>  -->
    <!-- 5.12 3/12/09 egd/ddh DR#3168: updated copyright to display published date and updated date if 
   exists-->
 <xsl:variable name="dcRights-v16"><xsl:text>&#169; Copyright&#160;</xsl:text>
	 <xsl:text>IBM Corporation&#160;</xsl:text>
          <xsl:value-of select="//date-published/@year"/>
		<xsl:if test="//date-updated/@year!='' and //date-updated/@year &gt; //date-published/@year">
			<xsl:text>,&#160;</xsl:text>
			<xsl:value-of select="//date-updated/@year" />
		</xsl:if></xsl:variable>
  <xsl:variable name="pdfTrademarks">Nhẫn hiệu đăng ký</xsl:variable>
  <xsl:variable name="pdfResource-list-forum-text">Tham gia diễn đàn để thảo luận nội dung này.</xsl:variable>
	<xsl:variable name="download-subscribe-podcasts"><xsl:text disable-output-escaping="yes">Đăng ký podcasts của developerWorks</xsl:text></xsl:variable>
	<xsl:variable name="podcast-about-url">/developerworks/podcast/about.html#subscribe</xsl:variable>
  <xsl:variable name="summary-inThisPodcast">Trong podcast này</xsl:variable>
  <xsl:variable name="summary-podcastCredits">Các tín chỉ của Podcast</xsl:variable>
  <xsl:variable name="summary-podcast-not-familiar">Chưa quen với podcasting? <a href=" /developerworks/podcast/about.html">Xem thêm.</a></xsl:variable>
  <xsl:variable name="summary-podcast-system-requirements"><xsl:text disable-output-escaping="yes"><![CDATA[Để tải về tự động và đồng bộ các tệp để có thể chạy được trên máy tính  hay máy nghe nhạc của bạn (ví dụ máy iPod), bạn phải sử dụng chương trình podcast trên máy khách. <a href="http://www.ipodder.org/" target="_blank">iPodder</a> là miễn phí, mã nguồn mở cho các hệ Mac&#174; OS X, Windows&#174;, và Linux. Bạn cũng có thể sử dụng <a href="http://www.apple.com/itunes/" target="_blank">iTunes</a>, <a href="http://www.feeddemon.com/" target="_blank">FeedDemon</a>, hay bất cứ lựa chọn sẵn có nào khác trên Web.]]></xsl:text></xsl:variable>
  <xsl:variable name="summary-getThePodcast">Lấy về podcast</xsl:variable>
  <xsl:variable name="summary-getTheAgenda">Lấy về lịch biểu</xsl:variable>
  <xsl:variable name="summary-getTheAgendas">Lấy về các lịch biểu</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentation">Lấy lịch biểu và trình chiếu</xsl:variable>
  <xsl:variable name="summary-getTheAgendaAndPresentations">Lấy lịch biểu và các trình chiếu</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentations">Lấy các lịch biểu và các trình chiếu</xsl:variable>
  <xsl:variable name="summary-getTheAgendasAndPresentation">Lấy các lịch biểu và trình chiếu</xsl:variable>
  <xsl:variable name="summary-getThePresentations">Lấy các trình chiếu</xsl:variable>
  <xsl:variable name="summary-getTheWorkshopMaterials">Lấy tài liệu hội thảo</xsl:variable>
  <xsl:variable name="summary-eventTypeOfBriefing">Kiểu: </xsl:variable>
  <xsl:variable name="summary-eventTechnicalbriefing">Chuyên đề kỹ thuật</xsl:variable>
  <xsl:variable name="summary-inThisEvent">Trong sự kiện này</xsl:variable>
  <xsl:variable name="summary-inThisWorkshop">Trong hội thảo này</xsl:variable>
  <xsl:variable name="summary-hostedBy">Chủ trì bởi: </xsl:variable>
  <xsl:variable name="summary-attendedByPlural">Các công ty trình bày</xsl:variable>
  <xsl:variable name="summary-attendedBySingular">Công ty trình bày</xsl:variable>
<xsl:variable name="common-trademarks-text">Tên của công ty, sản phẩm hay dịch vụ có thể là 
  nhãn hiệu đăng ký hoặc nhãn hiệu dịch vụ của người khác.</xsl:variable>
<!-- 5.5 6/26 llk: added copyright statement per China Legal request-->
<xsl:variable name="copyright-statement"></xsl:variable>
  <xsl:variable name="aboutTheContributor">Về bên đóng góp</xsl:variable>
  <xsl:variable name="summary-eventNoScriptText">Cần Javascript để hiển thị thông báo về đăng ký.</xsl:variable>
  <xsl:variable name="aboutTheContributors">Về các bên đóng góp</xsl:variable>
  <xsl:variable name="summary-briefingNotFound">Hiện thời chưa có lịch của các sự kiện. Mời quay lại sau.</xsl:variable>
  <xsl:variable name="summary-briefingLinkText">Chọn địa điểm và đăng ký</xsl:variable>
  <xsl:variable name="summary-briefingBusinessType">Kiểu: Chuyên đề Kinh doanh</xsl:variable>
  <!-- Maverick 6.0 R3 llk 09 21 10:  Added variable for summary type label -->
  <xsl:variable name="summary-type-label">Kiểu:</xsl:variable>  
  <!-- Maverick 6.0 R3 llk 09 21 10:  Removed Type: and following spacing from summary-briefingTechType -->  
    <xsl:variable name="summary-briefingTechType">Chuyên đề developerWorks trực tiếp</xsl:variable>
  <xsl:variable name="flash-requirement"><xsl:text disable-output-escaping="yes"><![CDATA[Để xem trình diễn kèm theo bài học này, trình duyệt của bạn phải hỗ trợ JavaScript và có cài đặt của Macromedia Flash Player 6 hoặc cao hơn. Bạn có thể tải về bản Flash Player sau cùng tại <a href="http://www.macromedia.com/go/getflashplayer/" target="_blank">http://www.macromedia.com/go/getflashplayer/</a>. ]]></xsl:text></xsl:variable>
      <!-- ************************************* Nguyen translate end ************************************  -->
  <xsl:variable name="max-code-line-length" select="90" />
  <xsl:variable name="code-ruler" select="
'-------10--------20--------30--------40--------50--------60--------70--------80--------90-------100'
    "></xsl:variable>
  <xsl:variable name="list-indent-chars" select="5" />
  <xsl:variable name="tab-stop-width" select="8" />
<!-- Add 5.10 variables end -->
    <!-- 5.4 02/20/06 tdc:  Start error message text variables -->
  <xsl:variable name="e001">|-------- XML error:  The previous line is longer than the max of 90 characters ---------|</xsl:variable>
  <xsl:variable name="e002">XML error:  Please enter a value for the author element's jobtitle attribute, or the company-name element, or both.</xsl:variable>
  <xsl:variable name="e003">XML error:  The image is not displayed because the width is greater than the maximum of 572 pixels.  Please decrease the image width.</xsl:variable>
  <xsl:variable name="e004">XML error:  The image is not displayed because the width is greater than the maximum of 500 pixels.  Please decrease the image width.</xsl:variable>
   <!-- 5.5.1 10/13/06 tdc:  New e005 warning message for cma-defined author info -->
  <xsl:variable name="e005">Warning:  The &lt;cma-defined&gt; subelement was entered instead of the standard author-related subelements and attributes.  You may keep the &lt;cma-defined&gt; subelement and assign author information using the CMA, or, replace the &lt;cma-defined&gt; subelement with the standard author-related subelements and attributes.</xsl:variable>
<!-- 6.0 Maverick R2 11 30 09: Added e006; articles and tut's now have a larger max image width of 580px -->
<xsl:variable name="e006">XML error: The image is not displayed because the width is greater than the maximum of 580 pixels. Please decrease the image width.</xsl:variable> 
    <xsl:variable name="e999">An error has occurred, but no error number was passed to the DisplayError template.  Contact the schema/stylesheet team.</xsl:variable>
<!-- End error message text variables -->
      <!-- ************************************* Nguyen translate begin ************************************  -->
<xsl:variable name="ready-to-buy">Sẵn sàng mua?</xsl:variable>
<xsl:variable name="buy">Mua</xsl:variable>
<xsl:variable name="online">trực tuyến</xsl:variable>
<xsl:variable name="try-online-register">Đăng ký bản dùng thử bây giờ.</xsl:variable>
<xsl:variable name="download-operatingsystem-heading">Hệ điều hành</xsl:variable>
<xsl:variable name="download-version-heading">Phiên bản</xsl:variable>
<!-- 6.0 Maverick beta egd 06/14/08: Added variables need for Series title in Summary area -->
<!-- in template named SeriesTitle -->
<xsl:variable name="series">Series</xsl:variable>
  <xsl:variable name="series-view">Xem thêm bài trong loạt bài này</xsl:variable>
<!-- End Maverick Series Summary area variables -->
<!-- Start Maverick Landing Page Variables -->
<!-- 6.0 Maverick R1 jpp 11/14/08: Added variables for forms -->
<xsl:variable name="form-search-in">Search in:</xsl:variable>
<xsl:variable name="form-product-support">Product support</xsl:variable>
<xsl:variable name="form-faqs">FAQs</xsl:variable>
<xsl:variable name="form-product-doc">Product documentation</xsl:variable>
<xsl:variable name="form-product-site">Product site</xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/18/08: Updated variable for JQuery ajax mode call -->
<xsl:variable name="ajax-dwhome-popular-forums"><xsl:text disable-output-escaping="yes"><![CDATA[/developerworks/maverick/jsp/jiveforums.jsp?zone=default_zone&siteid=1]]></xsl:text></xsl:variable>
<!-- 6.0 Maverick R1 jpp 12/17/08: Added additional variables -->
<!-- 6.0 Maverick llk - added additional variables for local site use -->
<xsl:variable name="publish-schedule"></xsl:variable>
  <xsl:variable name="show-descriptions-text">Hiện tóm tắt</xsl:variable>
  <xsl:variable name="hide-descriptions-text">Ẩn tóm tắt</xsl:variable>
<xsl:variable name="try-together-text">Try together</xsl:variable>
<xsl:variable name="dw-gizmo-alt-text">Add content to your personalized page</xsl:variable>
  <!-- 6.0 Maverick llk - added to support making the brand image hot on Japanese product overview and landing pages -->
  <xsl:variable name="ibm-data-software-url"></xsl:variable>   
  <xsl:variable name="ibm-lotus-software-url"></xsl:variable>
  <xsl:variable name="ibm-rational-software-url"></xsl:variable>
  <xsl:variable name="ibm-tivoli-software-url"></xsl:variable>
  <xsl:variable name="ibm-websphere-software-url"></xsl:variable>
<!-- End Maverick Landing Page variables -->
<xsl:variable name="codeTableSummaryAttribute">This table contains a code listing.</xsl:variable>
<xsl:variable name="downloadTableSummaryAttribute">This table contains downloads for this document.</xsl:variable>
<xsl:variable name="errorTableSummaryAttribute">This table contains an error message.</xsl:variable>
<!-- Project Defiant jpp 10/12/11: Added variable section and featured results variables -->
<!-- Results page variables: Start -->
	<xsl:variable name="featured-results-heading">Featured</xsl:variable>
	<xsl:variable name="category-article">Article</xsl:variable>
	<xsl:variable name="category-audio">Audio</xsl:variable>
	<xsl:variable name="category-blog">Blog</xsl:variable>
	<xsl:variable name="category-briefing">Briefing</xsl:variable>
	<xsl:variable name="category-champion">IBM Champion</xsl:variable>
	<xsl:variable name="category-demo">Demo</xsl:variable>
	<xsl:variable name="category-download">Download</xsl:variable>
	<xsl:variable name="category-forum">Forum</xsl:variable>
	<xsl:variable name="category-group">Group</xsl:variable>
	<xsl:variable name="category-knowledge-path">Knowledge Path</xsl:variable>
	<xsl:variable name="category-tutorial">Tutorial</xsl:variable>
	<xsl:variable name="category-video">Video</xsl:variable>
	<xsl:variable name="category-wiki">Wiki</xsl:variable>
	<!-- Project Defiant jpp 11/02/11: Added results-trending-bg-image variable -->
	<xsl:variable name="results-trending-bg-image">//dw1.s81c.com/developerworks/i/dw-results-trending-leadspace.jpg</xsl:variable>
	<!-- Project Defiant jpp 11/27/11: Added learnabout variable -->
	<xsl:variable name="learnabout">Learn about</xsl:variable>
<!-- Results page variables: End -->	 
</xsl:stylesheet>