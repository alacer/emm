<?xml version="1.0" encoding="UTF-8"?>
<!-- THIS STYLESHEET CONTAINS XSL VARIABLES, THE CONTENT OF WHICH
        DUPLICATES SSI FILES USED BY ARTICLES AND TUTORIALS.  IF THE
        CORRESPONDING SSI FILES ARE UPDATED, THESE VARIABLE DEFINITIONS
        MUST BE UPDATED AND AN ANNOUNCEMENT MADE TO ALL WHO MAY HAVE
        THIS FILE ON THEIR LOCAL MACHINES (EDITORS, AUTHORS, CMA TEAM AT 
        A MINIMUM).
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>
<!-- 6.0 Maverick beta egd 06/16/08:  Updated code for back-to-top link -->
  <!-- 6.0 Maverick R3 llk 5/11/10  removed extranneous hypen -->
  <xsl:variable name="ssi-s-backlink-module">
     <p class="ibm-ind-link ibm-back-to-top ibm-no-print">
      <a class="ibm-anchor-up-link" href="#ibm-pcon">Voltar para parte superior</a> 
    </p>
  </xsl:variable>
<!-- s-backlink-rule.inc -->
<xsl:variable name="ssi-s-backlink-rule">
<div class="ibm-alternate-rule"><hr /></div>
  <p class="ibm-ind-link ibm-back-to-top"><a class="ibm-anchor-up-link" href="#ibm-pcon">Voltar para parte superior</a></p>
</xsl:variable>
<!-- Maverick beta egd commented out the current back-to-top code
Spacer 
	<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
Separator rule 
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	<td><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/v14/rules/blue_rule.gif" width="100%"/></td>
	</tr>
	</table>
BACK_LINK
	<table align="right" cellpadding="0" cellspacing="0" class="no-print">
	<tr align="right">
	<td>
	<table cellspacing="0" cellpadding="0" border="0">
	<tr>
	<td valign="middle">
	<img alt="" border="0" height="16" src="{$newpath-ibm-local}www.ibm.com/i/v14/icons/u_bold.gif" width="16"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
	</td>
	<td align="right" valign="top">
	<a class="fbox" href="#main"><strong>Back to top</strong></a>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
	<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
BACK_LINK_END -->

<!-- s-backlink.inc -->
<xsl:variable name="ssi-s-backlink">
<!-- BACK_LINK -->
<table align="right" cellpadding="0" cellspacing="0">
<tr align="right">
<td>
<table cellspacing="0" cellpadding="0" border="0">
<tr>
<td valign="middle">
<img alt="" border="0" height="16" src="{$newpath-ibm-local}www.ibm.com/i/v14/icons/u_bold.gif" width="16"/>
<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
</td>
<td align="right" valign="top">
  <a class="fbox" href="#main"><strong>Voltar para parte superior</strong></a>
</td>
</tr>
</table>
</td>
</tr>
</table>
<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<!-- BACK_LINK_END -->
</xsl:variable>
<!-- s-doc-options-linktoenglish.inc" -->
<xsl:variable name="ssi-s-doc-options-linktoenglish">
<xsl:if test="/dw-document//link-to-english">
<xsl:choose>
	<xsl:when test="/dw-document//link-to-english=''">
	 </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="original_version_url">
       <xsl:value-of select="/dw-document//link-to-english"/>
      </xsl:variable>

<tr valign="top"><td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td><td width="16"><img src="{$newpath-ibm-local}www.ibm.com/i/v14/icons/fw_bold.gif" height="16" width="16" vspace="3" alt="Link to english
" /></td><td width="122"><p><a class="smallplainlink" href="{$original_version_url}" onmouseover="linkQueryAppend(this)"><strong>Link to english</strong></a></p></td></tr>
                    </xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:variable>
<!-- s-doc-options-email.inc" -->
<xsl:variable name="ssi-s-doc-options-email">
<!-- document.write statement now uses variable for paths -->
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" type="text/javascript">
<!--
document.write('<tr valign="top"><td width="8"><img src="]]></xsl:text><xsl:value-of select="$newpath-ibm-local"/><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td><td width="16"><img src="]]></xsl:text>
  <xsl:value-of select="$newpath-ibm-local"/><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/v14/icons/em.gif" height="16" width="16" vspace="3" alt="Enviar esta página por e-mail" /></td><td width="122"><p><a class="smallplainlink" href="javascript:document.email.submit()"><strong>Enviar esta página por e-mail</strong></a></p></td></tr>');
//-->
</script>]]></xsl:text>
<noscript><tr valign="top">
<td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td>
<td width="16"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" height="16" width="16" alt="" /></td>
  <td width="122" class="small"><p><span class="ast">Opções de documento que necessitam de JavaScript não são exibidas</span></p></td>
</tr>
</noscript>
</xsl:variable>
<xsl:variable name="ssi-s-doc-options-printcss">
<!-- document.write statement now uses variable for paths -->
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" type="text/javascript">
<!--
document.write('<tr valign="top"><td width="8"><img src="]]></xsl:text><xsl:value-of select="$newpath-ibm-local"/><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td><td width="16"><img alt="Configurar orientação da impressora para o modo paisagem" height="16" src="]]></xsl:text>
  <xsl:value-of select="$newpath-ibm-local"/><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/i/v14/icons/printer.gif" width="16" vspace="3" /></td><td width="122"><p><strong><a class="smallplainlink" href="javascript:print()">Imprimir esta página</a></strong></p></td></tr>');
//-->
</script>
<noscript></noscript>]]></xsl:text>
</xsl:variable>
<!-- s-doc-options-default.inc -->
<xsl:variable name="ssi-s-doc-options-default">
<xsl:value-of select="$ssi-s-doc-options-printcss"/>
<xsl:value-of select="$ssi-s-doc-options-email"/>
</xsl:variable>
<!-- s-footer14.inc -->
<!-- footer is now pulled in via server side include -->
<xsl:variable name="ssi-s-footer14">
</xsl:variable>
<!-- s-header-art-tut-styles.inc -->
<xsl:variable name="ssi-s-header-art-tut-styles">
<!-- Alternate code font style -->
<style type="text/css">
pre.section {margin-top: 0; margin-bottom: 0; font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; font-size: 11px}
.boldcode {font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; font-size: 11px; font-weight: bold} .rboldcode {font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; font-size: 11px; font-weight: bold; color: #ff0000}
.gboldcode {font-family: Andale Mono, Lucida Console, Monaco, fixed, monospace; font-size: 11px; font-weight: bold; color: #ff6600}
.bboldcode {font-family: Andale Mono, Lucida  Console, Monaco, fixed, monospace; font-size: 11px; font-weight: bold; color: #3c5f84}
</style>
<!-- Heading styles -->
<style type="text/css">
.atitle { font-family:arial,sans-serif; font-size:18px; }
</style>
</xsl:variable>
<!-- s-header-content.inc -->
<xsl:variable name="ssi-s-header-content">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</xsl:variable>
  <!-- s-header-meta.inc -->
  <xsl:variable name="ssi-s-header-meta">
    <meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.icra.org/ratingsv02.html" l gen true r (cz 1 lz 1 nz 1 oz 1 vz 1) "http://www.rsac.org/ratingsv01.html" l gen true r (n 0 s 0 v 0 l 0) "http://www.classify.org/safesurf/" l gen true r (SS~~000 1))' />
    <link rel="schema.DC" href="http://purl.org/DC/elements/1.0/" />
    <link rel="SHORTCUT ICON" href="http://www.ibm.com/favicon.ico" />
    <meta name="Owner" content="https://www.ibm.com/developerworks/secure/feedbook.jsp?domain=dwbrazil" />
    <meta name="DC.Language" scheme="rfc1766" content="pt-BR" />
    <meta name="IBM.Country" content="BR" />
    <meta name="Security" content="Public" />
    <!-- 5.8 0421 egd: Added IBM.Special.Purpose meta tag and the meta tag to suppress the WI login in the masthead -->
    <meta name="IBM.SpecialPurpose" content="SP001" />
    <meta name="IBM.PageAttributes" content="sid=1003"/>
  </xsl:variable>
<!-- s-header-scripts.inc -->
<xsl:variable name="ssi-s-header-scripts">
<!-- STYLESHEETS/SCRIPTS -->
<!-- Pull header scripts for preview from ssi includes and for final, pull from server include -->
<!-- for tables -->
<link rel="stylesheet" type="text/css" media="screen,print" href="{$newpath-protocol}www.ibm.com/common/v14/table.css" /> 
<!-- end for tables -->
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text>
<xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/dwcss14.js" type="text/javascript"></script>]]></xsl:text>
<link rel="stylesheet" type="text/css" href="{$newpath-protocol}www.ibm.com/common/v14/main.css" />
<link rel="stylesheet" type="text/css" media="all" href="{$newpath-protocol}www.ibm.com/common/v14/screen.css" />
<link rel="stylesheet" type="text/css" media="print" href="{$newpath-protocol}www.ibm.com/common/v14/print.css" />
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]>
</xsl:text><xsl:value-of select="$newpath-ibm-local"/><xsl:text disable-output-escaping="yes"><![CDATA[www.ibm.com/common/v14/detection.js" type="text/javascript"></script>]]></xsl:text>
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/dropdown.js" type="text/javascript"></script>]]></xsl:text>
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[email/grabtitle.js" type="text/javascript"></script>]]></xsl:text>
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[email/emailfriend2.js" type="text/javascript"></script>]]></xsl:text>
<xsl:text disable-output-escaping="yes"><![CDATA[<script language="JavaScript" src="]]></xsl:text><xsl:value-of select="$newpath-dw-root-web"/><xsl:text disable-output-escaping="yes"><![CDATA[js/dwplugin.js" type="text/javascript"></script>]]></xsl:text>
</xsl:variable>
<!-- s-nav14-rlinks.inc NOT NEEDED -->
<!-- s-nav14-top.inc -->
<xsl:variable name="ssi-s-nav14-top">
<table border="0" cellpadding="0" cellspacing="0" width="150">
<tr>
<td class="left-nav-spacer"><a class="left-nav-overview" href="http://www.ibm.com/developerworks/br/">&nbsp;</a></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="150">
<tr>
<td class="left-nav-overview" colspan="2"><a class="left-nav-overview" href="http://www.ibm.com/developerworks/br/">developerWorks Brasil</a></td>
</tr>
</table>
</xsl:variable>
<!-- s-nav14.inc NOT NEEDED -->
<!-- s-rating-form-tutorial.inc -->
<xsl:variable name="ssi-s-rating-form-tutorial">
<table border="0" cellpadding="0" cellspacing="0" class="v14-gray-table-border" width="443">
<tr>
<td width="425">
<table cellspacing="0" cellpadding="0" border="0" width="100%">
<tr>
  <td colspan="2"><p>Reserve um instante para completar este formulário para nos ajudar a servi-lo melhor.</p></td>
</tr>
<tr valign="top">
<td width="132"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="132"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Goal">As informações o ajudaram a alcançar seu objetivo?</label></p>
</td>
<td width="293"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="293"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
  <td><input type="radio" name="goal" id="goal-yes" value="Yes" /><label for="goal-yes">Sim</label></td>
  <td><input type="radio" name="goal" id="goal-no" value="No" /><label for="goal-no">Não</label></td>
  <td><input type="radio" name="goal" id="goal-undecided" value="Don't know" /><label for="goal-undecided">Não sei</label></td>
</tr>
</table>
</td>
</tr>
<!-- Spacer -->
<tr><td colspan="2"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="12" alt="" /></td></tr>
<tr valign="top">
<td width="132"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="132"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Comments">Faça comentários para ajudar a melhorar esta página:</label></p>
</td>
<td width="293"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="293"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td><textarea name="Comments" id="Comments" wrap="virtual" rows="5" cols="35" class="iform">&nbsp;</textarea></td>
</tr>
</table>
</td>
</tr>
<!-- Spacer -->
<tr><td colspan="2"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="12" alt="" /></td></tr>
<tr valign="top">
<td width="132"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="132"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Rating">Quão úteis são as informações?</label></p>
</td>
<td width="293"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="293"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating1" value="1" /><label for="Rating1">1</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating2" value="2" /><label for="Rating2">2</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating3" value="3" /><label for="Rating3">3</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating4" value="4" /><label for="Rating4">4</label></td>
<td width="61" align="left"><input type="radio" name="Rating" id="Rating5" value="5" /><label for="Rating5">5</label></td>
</tr>
<tr>
  <td width="58" align="left"><span class="greytext">Não</span><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><span class="greytext">são úteis</span></td>
<td width="58" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
<td width="58" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
<td width="58" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
  <td width="61" align="left"><span class="greytext">Extremamente<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>úteis</span></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" width="443" class="v14-gray-table-border">
<!-- Spacer -->
<tr><td colspan="2"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="8" alt="" /></td></tr>
<tr>
<td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt="" /></td>
<td colspan="2"><input type="image" src="{$newpath-ibm-local}www.ibm.com/i/v14/buttons/submit.gif" border="0" width="120" height="21" alt="Submit" /></td>
</tr>
<tr><td colspan="2"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="8" alt="" /></td></tr>
</table>
</xsl:variable>
<!-- s-rating-form.inc -->
<xsl:variable name="ssi-s-rating-form">
<table border="0" cellpadding="0" cellspacing="0" class="v14-gray-table-border" width="100%">
<tr>
<td width="100%">
<table cellspacing="0" cellpadding="0" border="0" width="100%">
<tr>
  <td colspan="3"><p>Reserve um instante para completar este formulário para nos ajudar a servi-lo melhor.</p></td>
</tr>
<tr valign="top">
<td width="140"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="140"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Goal">As informações o ajudaram a alcançar seu objetivo?</label></p>
</td>
<td width="303"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="303"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
  <td><input type="radio" name="goal" id="goal-yes" value="Yes" /><label for="goal-yes">Sim</label></td>
  <td><input type="radio" name="goal" id="goal-no" value="No" /><label for="goal-no">Não</label></td>
  <td><input type="radio" name="goal" id="goal-undecided" value="Don't know" /><label for="goal-undecided">Não sei</label></td>
</tr>
</table>
</td>
<td width="100%">&nbsp;</td>
</tr>
<!-- Spacer -->
<tr><td colspan="3"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="12" alt="" /></td></tr>
<tr valign="top">
<td width="140"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="140"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Comments">Faça comentários para ajudar a melhorar esta página:</label></p>
</td>
<td width="303"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="303"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td><textarea name="Comments" id="Comments" wrap="virtual" rows="5" cols="35" class="iform">&nbsp;</textarea></td>
</tr>
</table>
</td>
<td width="100%">&nbsp;</td>
</tr>
<!-- Spacer -->
<tr><td colspan="3"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="12" alt="" /></td></tr>
<tr valign="top">
<td width="140"><img alt="" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="140"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
  <p><label for="Rating">Quão úteis são as informações?</label></p>
</td>
<td width="303"><img alt="" height="6" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="303"/><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating1" value="1" /><label for="Rating1">1</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating2" value="2" /><label for="Rating2">2</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating3" value="3" /><label for="Rating3">3</label></td>
<td width="58" align="left"><input type="radio" name="Rating" id="Rating4" value="4" /><label for="Rating4">4</label></td>
<td width="61" align="left"><input type="radio" name="Rating" id="Rating5" value="5" /><label for="Rating5">5</label></td>
</tr>
<tr>
  <td width="60" align="left"><span class="greytext">Não</span><xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text><span class="greytext"> são úteis</span></td>
  <td width="60" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
  <td width="60" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
  <td width="60" align="left"><img alt="" width="1" height="1" src="{$newpath-ibm-local}www.ibm.com/i/c.gif" /></td>
  <td width="63" align="left"><span class="greytext">Extremamente<xsl:text disable-output-escaping="yes"><![CDATA[<br />]]></xsl:text>úteis</span></td>
</tr></table>
</td>
<td width="100%">&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="v14-gray-table-border">
<!-- Spacer -->
<tr><td colspan="3"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="8" alt="" /></td></tr>
<tr>
<td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt="" /></td>
<td colspan="3"><input type="image" src="{$newpath-ibm-local}www.ibm.com/i/v14/buttons/submit.gif" border="0" width="120" height="21" alt="Submit" /></td>
</tr>
<tr><td colspan="3"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="8" alt="" /></td></tr>
</table>
</xsl:variable>
<!-- s-rating-page.inc -->
<xsl:variable name="ssi-s-rating-page">
<table border="0" cellpadding="0" cellspacing="0" width="150">
  <tr><td class="v14-header-2-small">Classificar esta página</td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="v14-gray-table-border">
<tr>
<td width="150" class="no-padding">
<table border="0" cellpadding="0" cellspacing="0" width="143">
<tr valign="top">
<td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td>
<td><img src="{$newpath-ibm-local}www.ibm.com/i/v14/icons/d_bold.gif" height="16" width="16" border="0" vspace="3" alt=""/></td>
  <td width="125"><p><a class="smallplainlink" href="#rate"><strong>Ajude-nos a melhorar este conteúdo</strong></a></p></td>
</tr>
</table>
</td>
</tr>
</table>
</xsl:variable>
<!-- s-rating-tutorial.inc -->
<xsl:variable name="ssi-s-rating-tutorial">
<table border="0" cellpadding="0" cellspacing="0" width="150">
  <tr><td class="v14-header-2-small">Classificar este tutorial</td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="v14-gray-table-border">
<tr>
<td width="150" class="no-padding">
<table border="0" cellpadding="0" cellspacing="0" width="143">
<tr valign="top">
<td width="8"><img src="{$newpath-ibm-local}www.ibm.com/i/c.gif" width="8" height="1" alt=""/></td>
<td><img src="{$newpath-ibm-local}www.ibm.com/i/v14/icons/d_bold.gif" height="16" width="16" border="0" vspace="3" alt=""/></td>
  <td width="125"><p><a class="smallplainlink" href="rating.html"><strong>Ajude-nos a melhorar este conteúdo</strong></a></p></td>
</tr>
</table>
</td>
</tr>
</table>
</xsl:variable>
<!-- s-site-identifier.inc -->
<xsl:variable name="ssi-s-site-identifier">
<td width="192" class="no-print"><a href="{$developerworks-top-url}"><img src="{$newpath-dw-root-local}i/dw.gif" width="192" height="18" border="0" alt="developerWorks" /></a></td>
</xsl:variable>
</xsl:stylesheet>
