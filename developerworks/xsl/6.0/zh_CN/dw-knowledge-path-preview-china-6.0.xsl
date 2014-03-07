<?xml version="1.0" encoding="UTF-8"?>


<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml" 
xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo"> 
<xsl:template name="dw-knowledge-path-preview">
<!-- <#ftl encoding="UTF-8" /> -->
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>

<!-- <#if dw_output_map?exists><#assign dwarticle = dw_output_map /></#if> -->
<!-- <#if dw_xml_content_map?exists><#assign dwxmlcontent = dw_xml_content_map /></#if> -->
<!-- <#if dw_content_map?exists><#assign dwcontentmap = dw_content_map /></#if> -->
<!-- <#if dw_request_details?exists><#assign dwrequest = dw_request_details /></#if> -->

 <html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN" xml:lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title><xsl:apply-templates select=".">  
<xsl:with-param name="template">titletag</xsl:with-param>
</xsl:apply-templates></title>
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))'/>
<link rel="schema.DC" href="http://purl.org/DC/elements/1.0/"/>
<link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico"/>
  <meta name="Owner" content="dw@cn.ibm.com"/>
  <meta name="DC.Language" scheme="rfc1766" content="zh-CN"/>
  <meta name="IBM.Country" content="CN"/>
<meta name="Security" content="Public"/>
<meta name="IBM.SpecialPurpose" content="SP001"/>
<meta name="IBM.PageAttributes" content="sid=1003,1004"/>
<meta name="Source" content="v16 Template Generator"/>
<meta name="Robots" content="index,follow"/>
<xsl:element name="meta">
    <xsl:attribute name="name">Abstract</xsl:attribute>
    <xsl:attribute name="content">
            <xsl:apply-templates select="."><xsl:with-param name="template">abstract</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Description</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">abstract</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">Keywords</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">keywords</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Date</xsl:attribute>
    <xsl:attribute name="scheme">iso8601</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">dcDate</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Type</xsl:attribute>
    <xsl:attribute name="scheme">IBM_ContentClassTaxonomy</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">dcType</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Subject</xsl:attribute>
    <xsl:attribute name="scheme">IBM_SubjectTaxonomy</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">dcSubject</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:if test="boolean(.//content-area-primary/@name)">  
<xsl:choose>
<xsl:when test=".//content-area-primary/@name = 'aix' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCAIXCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'data' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIMTCN" />  
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'ibmi' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCIBICN" />  
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'lotus' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLOTCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'rational' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCRATCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'tivoli' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCTIVCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'websphere' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCWSPCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'architecture' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCARCCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'java' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCJVACN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'linux' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCLNXCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'power' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCMACCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'opensource' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCOSRCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'ibm' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSCNCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'webservices' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCSOACN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'web' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCDEVCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'xml' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCXMLCN" />
</xsl:when>
<xsl:when test=".//content-area-primary/@name = 'cloud' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCCLDCN" />
  </xsl:when>
<xsl:when test=".//content-area-primary/@name = 'industry' ">
<meta scheme="IBM_WTMCategory" name="IBM.WTMCategory" content="SOFDCINDCN" />
  </xsl:when>  
<xsl:otherwise>
  </xsl:otherwise>
</xsl:choose>
</xsl:if>
<xsl:comment>IBM.Industry meta tag goes here</xsl:comment>
<xsl:element name="meta">
    <xsl:attribute name="name">DC.Rights</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">dcRights</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">IBM.Effective</xsl:attribute>
    <xsl:attribute name="scheme">W3CDTF</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">ibmEffective</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>
<xsl:element name="meta">
    <xsl:attribute name="name">title</xsl:attribute>
    <xsl:attribute name="content">
        <xsl:apply-templates select="."><xsl:with-param name="template">titletag</xsl:with-param></xsl:apply-templates>
    </xsl:attribute>
</xsl:element>

<xsl:comment> HEADER_SCRIPTS_AND_CSS_INCLUDE </xsl:comment>
<link href="http://dw1.s81c.com/common/v16/css/all.css" media="all" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/screen-uas.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="//dw1.s81c.com/common/v16/css/cn/zh/screen-fonts.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/handheld.css" media="handheld" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/print.css" media="print" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/common/v16/css/overlay.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> dW-specific CSS </xsl:comment>
<link href="http://dw1.s81c.com/developerworks/css/dw-screen.css" media="screen,projection" rel="stylesheet" title="www" type="text/css" />
<link href="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.cluetip.css" media="screen,projection" rel="stylesheet"  title="www" type="text/css" />
<!-- xM Masthead/Footer -->
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf.css" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/css/dw-mf/dw-mf-minimal.css" rel="stylesheet" title="www" type="text/css"/>
<xsl:comment> KP-specific CSS and JS </xsl:comment>    
<link href="http://dw1.s81c.com/developerworks/css/kp/dw-kp.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/>
<link href="http://dw1.s81c.com/developerworks/css/kp/dw-kp-cn.css" media="screen,projection" rel="stylesheet" title="www" type="text/css"/> 
<script src="http://dw1.s81c.com/common/js/ibmcommon.js" type="text/javascript">//</script>

    
<xsl:apply-templates select=".">
    <xsl:with-param name="template">webFeedDiscovery</xsl:with-param>
</xsl:apply-templates>
<script language="javascript" src="http://dw1.s81c.com/developerworks/js/ajax1.js" type="text/javascript">//</script> 

</head>

<body id="ibm-com">
<div id="ibm-top" class="ibm-landing-page">

<xsl:comment> MASTHEAD_BEGIN </xsl:comment>
  <div class="ibm-access"><a href="#ibm-content">跳转到主要内容</a></div>
  <div id="ibm-masthead-dw">
    <div id="dw-masthead-top-row">
      <ul id="ibm-unav-home-dw">
        <li id="ibm-logo">
          <a href="http://www.ibm.com/cn/zh/"><img src="http://dw1.s81c.com/developerworks/i/mf/ibm-smlogo.gif" width="44" height="16" alt="IBM®" /></a>
        </li>
      </ul>
    </div>
    <div id="ibm-universal-nav-dw">
      <img src="http://dw1.s81c.com/developerworks/i/mf/dw-mast-orange-slim.jpg" width="930" height="75" alt="developerWorks®" />
    </div>
  </div>   <xsl:comment> MASTHEAD_END </xsl:comment>

<div id="ibm-pcon">

<xsl:comment> CONTENT_BEGIN </xsl:comment>
<div id="ibm-content">

<xsl:comment>Navigation_Trail_BEGIN </xsl:comment>
<xsl:if test="boolean(.//content-area-primary/@name)">
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">breadcrumb</xsl:with-param>
        <xsl:with-param name="transform-zone" select="//content-area-primary/@name"></xsl:with-param>
    </xsl:apply-templates>
</xsl:if>
<xsl:comment> Navigation_Trail_END </xsl:comment>

<xsl:comment> dW_Summary Area_START </xsl:comment>
<div id="dw-kp-summary">

    <div class="dw-content-head">
        <xsl:apply-templates select=".">
            <xsl:with-param name="template">title</xsl:with-param>
        </xsl:apply-templates>
    </div>

    <div class="ibm-container-body  kp-summary-container-body">
        <div class="ibm-column  ibm-first kp-summary-column-first">
            <div class="ibm-no-print" id="dw-tag-content">
                <p id="dw-kp-summary-info"><xsl:apply-templates select="."><xsl:with-param name="template">date</xsl:with-param></xsl:apply-templates><span                
                class="kp-bar">|</span><xsl:apply-templates select="."><xsl:with-param name="template">skillLevel</xsl:with-param></xsl:apply-templates><span id="ratingUIBar"    
                    class="kp-bar">|</span><span id="ratingUI">[Rating code here]</span><span class="kp-bar">|</span>
                    <!-- <span id="interestShow" class="ibm-no-print"></span> -->
            </p>
            </div>
        </div>
    </div> 
 </div>
<xsl:comment> dW_Summary_Area_END </xsl:comment>

<xsl:comment> CONTENT_BODY </xsl:comment>
<div id="ibm-content-body" class="kp-content-body">

<xsl:comment> MAIN_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-main" class="kp-content-main">
    
<xsl:comment> Track my progress widget </xsl:comment>
<div class="kp-track">
   <p class="ibm-ind-link">
       <a class="ibm-password-link" href="#" onclick="showSignIn();return false;">  <strong>登录</strong></a> 以保存进度 <!-- 07/13/11 Removed checkmark per Ami -->     
      (<a class="kp-learn-text" href="#learnMore" onclick="ibmCommon.Overlays.show('learnMore', this);return false;">了解更多</a>)
   </p>
</div>
<!-- Alternate signed in -->
<!-- 
<div class="kp-track2">
   <p class="ibm-ind-link kp-track3">
      <strong>Saving your progress</strong><img class="check-top" src="//www.ibm.com/i/v16/icons/confirm.gif" alt="Green checked checkmark" />
      <a class="kp-learn-text" href="javascript:void(0)">Learn more</a>
   </p>
</div> -->
    
<xsl:comment> MAIN_COLUMN_CONTENT_BEGIN </xsl:comment>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">kpSteps</xsl:with-param>
    </xsl:apply-templates>
<xsl:comment> MAIN_COLUMN_CONTENT_END </xsl:comment>

<xsl:comment> FEEDBACK_FORM_AND_RATINGS_AREA_BEGIN </xsl:comment>
<div class="ibm-container kp-form-container">
<div class="dw-kp-hide dw-kp-rate"><!-- rating script unhides this div if ratings unavailable -->
  <br />
</div>
<div class="dw-kp-rate">
    <br />
    <br />
      <h2 class="kp-rate-head">为此内容打分</h2><span id="interactiveRatingUI"></span>
    <br />
    <br />
</div>

<div class="ibm-alternate-rule-two kp-hr-fat"><hr /></div>

<div id="kp-container-how" class="ibm-container-body ibm-two-column ibm-alternate-four">
<div class="ibm-column ibm-list-container ibm-first kp-form-column">

<h2 class="kp-feedback-head">提供反馈</h2>
<p id="dw-kp-feedback-err" class="dw-kp-error-default"><strong>Error message here.</strong></p>
<!-- If not signed in only: start 
<div class="kp-feedback-signin-msg">   
   <img src="//dw1.s81c.com/i/v16/icons/key.gif" class="kp-key-bottom" border="0" alt="Sign in"/>
   <span>
      <a href="#" onclick="showSignIn();return false;"><strong class="kp-vert-align-middle">Sign in</strong></a>  to give us your feedback
   </span>
</div>
If not signed in only: end -->
 
<form id="dw-kp-feedback" action="[REPLACE]" class="ibm-row-form" enctype="multipart/form-data" method="post" name="feedback">
    
<p><span class="kp-form-step-head"><strong>1.</strong>&nbsp;</span><strong>您已经完成这个学习路线图了吗？</strong><br />
   <span class="ibm-input-group kp-form-entry">
     <input id="yes" name="tasks" type="radio" value="yes"/><label for="yes">是</label>&nbsp;&nbsp;&nbsp;
     <input id="no" name="tasks" type="radio" value="no"/><label for="no">否</label>&nbsp;&nbsp;&nbsp;
    </span>
</p>
   
<p><span class="kp-form-step-head"><strong>2.</strong>&nbsp;</span><strong>您学到了多少知识？</strong><br />  
   <span class="ibm-input-group kp-form-entry">
    <input id="alot" name="learned" type="radio" value="alot" /><label for="alot">很多</label>&nbsp;&nbsp;&nbsp;
     <input id="some" name="learned" type="radio" value="some" /><label for="some">一些</label>&nbsp;&nbsp;&nbsp;
     <input id="alittle" name="learned" type="radio" value="alittle" /><label for="alittle">一点点</label>&nbsp;&nbsp;&nbsp;
     <input id="nothing" name="learned" type="radio" value="nothing" /><label for="nothing">没有学到</label>
</span>
</p>

<p class="dw-kp-form-tell-us"><span class="kp-form-step-head"><strong>3.</strong>&nbsp;</span><strong>进一步帮助我们</strong>       
              <ul class="ibm-bullet-list ibm-no-links kp-form-entry kp-form-list">
                <li>您有什么喜欢或不喜欢的？</li>
                <li>我们如何能做得更好？</li>
                 </ul>
                     <span class="ibm-access"><label for="feedback">在下方输入您的评论</label></span>
<textarea name="kp-feedback" rows="7" cols="60" id="feedback" class="kp-form-textarea" >(Comments are here.)</textarea>
    
</p>
    
<p id="dw-kp-submit"><input class="ibm-btn-arrow-pri kp-form-submit" name="ibm-submit" value="提交" type="submit" /></p>
   
<!-- <p id="dw-kp-nonsubmit"><img src="http://dw1.s81c.com/developerworks/i/submit-gry.gif" alt="Disabled Submit button" /></p> -->

</form>


 </div>
<!-- Next Steps -->
<div id="dw-kp-next-steps" class="ibm-column ibm-list-container ibm-second kp-second">
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">kpNextSteps</xsl:with-param>
    </xsl:apply-templates>
</div>

</div>
</div>


<xsl:comment> FEEDBACK_FORM_AND_RATINGS_AREA_END </xsl:comment>

<xsl:comment>OVERLAY placeholder:  Update my interests</xsl:comment>
<xsl:comment>OVERLAY placeholder: Sign in</xsl:comment>
<xsl:comment>OVERLAY placeholder: Display name</xsl:comment>
<xsl:comment>OVERLAY placeholder: Learn more</xsl:comment>
<xsl:comment>OVERLAY placeholder: Feedback thank you</xsl:comment>
    
<!--
<xsl:comment> Rating_Meta_BEGIN </xsl:comment>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">ratingMeta</xsl:with-param>
    </xsl:apply-templates>
<xsl:comment> Rating_Meta_END </xsl:comment>
-->

</div>
<xsl:comment> MAIN_COLUMN_END</xsl:comment>

<xsl:comment> RIGHT_COLUMN_BEGIN </xsl:comment>
<div id="ibm-content-sidebar" class="kp-content-sidebar">

<xsl:comment> RIGHT_COLUMN_CONTENT_BEGIN </xsl:comment> 
<div class="ibm-container">
<h2>关于此学习路线图</h2>
<div class="ibm-container-body">
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">kpAbstract</xsl:with-param>
    </xsl:apply-templates>
    <div class="ibm-rule"><hr /></div>
    <xsl:apply-templates select=".">
        <xsl:with-param name="template">kpToc</xsl:with-param>
    </xsl:apply-templates>
 </div>
 </div>
 
 <div class="ibm-container">
    <h2>相关资源</h2>
    <div class="ibm-container-body">
       <xsl:apply-templates select=".">
          <xsl:with-param name="template">kpRelatedResources</xsl:with-param>
       </xsl:apply-templates>
   </div>
</div>
<xsl:comment> RELATED_RESOURCES_END </xsl:comment>

</div>
<xsl:comment> RIGHT_COLUMN_END </xsl:comment>

</div>
<xsl:comment> CONTENT_BODY_END </xsl:comment>

</div>
<xsl:comment> CONTENT_END </xsl:comment>

</div>
<xsl:comment> END_IBM-PCON </xsl:comment>

<xsl:comment> FOOTER_BEGIN </xsl:comment>
<div id="ibm-footer">
<!-- IBM footer container; disabled -->
</div>

<div id="ibm-page-tools-dw">

<div id="dw-footer-top-row" class="dw-mf-minimal"></div>

</div>

<div id="ibm-footer-module-dw" class="dw-mf-minimal"></div>
<xsl:comment> FOOTER_END </xsl:comment>

</div>
<xsl:comment> END_IBM-TOP </xsl:comment>
 
 <xsl:comment> SCRIPTS_INCLUDE_BEGIN </xsl:comment>    
<xsl:comment> JQuery start </xsl:comment>

<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/jquery.tools.min.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/jquery.jscroll.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/dw_v16.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/flash-detect.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/dw-mf/dwsi.js">//</script>

<script type="text/javascript" language="JavaScript">
jQuery.noConflict(); 
// Put all your code in your document ready area
jQuery(document).ready(function(jQuery) {
rBHash = null;
rBHash = new Object();
rBHash['viperLang'] = 'zh';
rBHash['urlLang'] = 'cn';

// si
initSI();
});
</script>

<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.dimensions-1.2.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.hoverIntent.minified.js">//</script>
<script type="text/javascript" language="JavaScript" src="http://dw1.s81c.com/developerworks/js/jquery/cluetip98/jquery.cluetip.js">//</script>

<xsl:comment> JQuery end </xsl:comment>

<div id="ibm-metrics">
<!-- <script src="http://dw1.s81c.com/common/stats/stats.js" type="text/javascript">//</script> -->
</div>

<script src="http://dw1.s81c.com/common/js/overlay.js" type="text/javascript"></script>
<!-- Rating_START -->
<script language="JavaScript" type="text/javascript">
  // <![CDATA[
 
  dwrating = {};
  dwrating.averageRatingText = '平均分为 {1} 星';
  dwrating.averageRatingPluralText = '平均分为 {1} 星';
  dwrating.wordRatingText = '个评分';
  dwrating.wordRatingsText = '个评分';
  dwrating.errorRatingText = '提交失败，请重试。';
  dwrating.unavailRatingText = '打分功能暂时不可用';
  dwrating.saving = '正在保存 ...'; 
  dwrating.ratingTexts =  ["5 星中的 1 星（差）", 
            "5 星中的 2 星（不喜欢）", 
            "5 星中的 3 星（还可以）", 
            "5 星中的 4 星（喜欢）", 
            "5 星中的 5 星（喜爱）"];
  dwrating.selectedRatingTexts = ["未选择星", 
            "选择了一星", 
            "选择了两星", 
            "选择了三星", 
            "选择了四星", 
            "选择了五星"]; 
  dwrating.youRatedText1 = '您打了 {1} 星，平均打分为 {2} 星。';
  dwrating.youRatedText2 = '您打了 {1} 星，平均打分为 {2} 星。';
  dwrating.youRatedText3 = '您打了 {1} 星，平均打分为 {2} 星。';            
  
// ]]>
</script>    
<script src="http://dw1.s81c.com/developerworks/js/artrating/dwrating.js" type="text/javascript">//</script>
<script src="http://dw1.s81c.com/developerworks/js/kpfeedback.js" type="text/javascript">//</script>  
<script src="http://dw1.s81c.com/developerworks/js/dw-mf/dwinterest.js" type="text/javascript">//</script>
<script language="Javascript" type="text/javascript">
   // <![CDATA[
      dwrating.createRatingUI('ratingUI', 'interactiveRatingUI');
   // ]]>
</script> 

<script language="Javascript" type="text/javascript">
   // <![CDATA[
	   // create rating widgets
      dwrating.createRatingUI('ratingUI', 'interactiveRatingUI');
	  
	  // create add-to-my-interest widget
	  var contentId = '';
			var contentAreas = '';
			var caArr = [];
			contentId = '301319';
			contentAreas = 'java,web,opensource';
			if(contentAreas != ''){caArr = contentAreas.split(',');}
			jQuery('interestShow').dwInterest(contentId,'kp',{'int_tops':[725,263,41,521,9,214],'int_prods':[], 'int_prod_fam':[],'int_cont_area':caArr},
'<div id="dw-interest-anon"><img id="kp-save-item" alt="" src="http://dw1.s81c.com/developerworks/i/updateinterests.gif" border="0"/>&nbsp;<a id="intAnonBtn" class="ibm-external-link kp-save" href="">Update My dW interests</a> (<a class="dw-kp-interests-text" href="#" onclick="showSignIn();return false;">Log in</a> | <a class="dw-kp-interests-text" href="">What\'s this?</a>) </div>',
'<div id="dw-interest-add"><img src="http://dw1.s81c.com/developerworks/i/addinterests.gif" alt="" /><a id="intSelectBtn" class="ibm-external-link" href="">Add to My dW interests</a> <a class="ibm-access" href="#dwmyinterestaddhelp">Skip to help for Add to My dW interests</a></div>',
'<div id="dw-interest-remove"><img src="http://dw1.s81c.com/i/v16/icons/confirm.gif" alt="Green checked checkmark" /><a id="intDeselectBtn" class="ibm-external-link" href="">Added to My dW interests</a> (<a class="dw-interest" href="https://www.ibm.com/developerworks/mydeveloperworks/profiles/html/myProfileView.do?lang=en">Edit</a>)</div>'
);
   // ]]>
</script>

</body>
</html>
</xsl:template>
</xsl:stylesheet>