<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
 <!-- 20110124 ibs DR 3467. File relocated to 6.0 tree in preparation for 6.0 PDF with FOP -->
 <!-- 5.9 0816 egd: Added mdash for PDFs -->
    
<!-- ibs 2011-07-06 
        Previously these templates contained coding like:
        <xsl:text disable-output-escaping="yes"><![CDATA[&#8212;]]>
        The CDATA and disable-output-escaping are unnecessary and not recommended.
    -->    
 <xsl:template match="mdash"><xsl:text>&#8212;</xsl:text></xsl:template>
 <xsl:template match="trade"><xsl:text>&#8482;</xsl:text></xsl:template>
 <xsl:template match="nbsp"><xsl:text>&#160;</xsl:text></xsl:template>
  <xsl:template match="iexcl"><xsl:text>&#161;</xsl:text></xsl:template>
  <xsl:template match="cent"><xsl:text>&#162;</xsl:text></xsl:template>
  <xsl:template match="pound"><xsl:text>&#163;</xsl:text></xsl:template>
  <xsl:template match="curren"><xsl:text>&#164;</xsl:text></xsl:template>
  <xsl:template match="yen"><xsl:text>&#165;</xsl:text></xsl:template>
  <xsl:template match="brvbar"><xsl:text>&#166;</xsl:text></xsl:template>
  <xsl:template match="sect"><xsl:text>&#167;</xsl:text></xsl:template>
  <xsl:template match="uml"><xsl:text>&#168;</xsl:text></xsl:template>
  <xsl:template match="copy"><xsl:text>&#169;</xsl:text></xsl:template>
  <xsl:template match="ordf"><xsl:text>&#170;</xsl:text></xsl:template>
  <xsl:template match="laquo"><xsl:text>&#171;</xsl:text></xsl:template>
  <xsl:template match="not"><xsl:text>&#172;</xsl:text></xsl:template>
  <xsl:template match="shy"><xsl:text>&#173;</xsl:text></xsl:template>
  <xsl:template match="reg"><xsl:text>&#174;</xsl:text></xsl:template>
  <xsl:template match="macr"><xsl:text>&#175;</xsl:text></xsl:template>
  <xsl:template match="deg"><xsl:text>&#176;</xsl:text></xsl:template>
  <xsl:template match="plusmn"><xsl:text>&#177;</xsl:text></xsl:template>
  <xsl:template match="sup2"><xsl:text>&#178;</xsl:text></xsl:template>
  <xsl:template match="sup3"><xsl:text>&#179;</xsl:text></xsl:template>
  <xsl:template match="acute"><xsl:text>&#180;</xsl:text></xsl:template>
  <xsl:template match="micro"><xsl:text>&#181;</xsl:text></xsl:template>
  <xsl:template match="para"><xsl:text>&#182;</xsl:text></xsl:template>
  <xsl:template match="middot"><xsl:text>&#183;</xsl:text></xsl:template>
  <xsl:template match="cedil"><xsl:text>&#184;</xsl:text></xsl:template>
  <xsl:template match="sup1"><xsl:text>&#185;</xsl:text></xsl:template>
  <xsl:template match="ordm"><xsl:text>&#186;</xsl:text></xsl:template>
  <xsl:template match="raquo"><xsl:text>&#187;</xsl:text></xsl:template>
  <xsl:template match="frac14"><xsl:text>&#188;</xsl:text></xsl:template>
  <xsl:template match="frac12"><xsl:text>&#189;</xsl:text></xsl:template>
  <xsl:template match="frac34"><xsl:text>&#190;</xsl:text></xsl:template>
  <xsl:template match="iquest"><xsl:text>&#191;</xsl:text></xsl:template>
  <xsl:template match="Agrave"><xsl:text>&#192;</xsl:text></xsl:template>
  <xsl:template match="Aacute"><xsl:text>&#193;</xsl:text></xsl:template>
  <xsl:template match="Acirc"><xsl:text>&#194;</xsl:text></xsl:template>
  <xsl:template match="Atilde"><xsl:text>&#195;</xsl:text></xsl:template>
  <xsl:template match="Auml"><xsl:text>&#196;</xsl:text></xsl:template>
  <xsl:template match="Aring"><xsl:text>&#197;</xsl:text></xsl:template>
  <xsl:template match="AElig"><xsl:text>&#198;</xsl:text></xsl:template>
  <xsl:template match="Ccedil"><xsl:text>&#199;</xsl:text></xsl:template>
  <xsl:template match="Egrave"><xsl:text>&#200;</xsl:text></xsl:template>
  <xsl:template match="Eacute"><xsl:text>&#201;</xsl:text></xsl:template>
  <xsl:template match="Ecirc"><xsl:text>&#202;</xsl:text></xsl:template>
  <xsl:template match="Euml"><xsl:text>&#203;</xsl:text></xsl:template>
  <xsl:template match="Igrave"><xsl:text>&#204;</xsl:text></xsl:template>
  <xsl:template match="Iacute"><xsl:text>&#205;</xsl:text></xsl:template>
  <xsl:template match="Icirc"><xsl:text>&#206;</xsl:text></xsl:template>
  <xsl:template match="Iuml"><xsl:text>&#207;</xsl:text></xsl:template>
  <xsl:template match="ETH"><xsl:text>&#208;</xsl:text></xsl:template>
  <xsl:template match="Ntilde"><xsl:text>&#209;</xsl:text></xsl:template>
  <xsl:template match="Ograve"><xsl:text>&#210;</xsl:text></xsl:template>
  <xsl:template match="Oacute"><xsl:text>&#211;</xsl:text></xsl:template>
  <xsl:template match="Ocirc"><xsl:text>&#212;</xsl:text></xsl:template>
  <xsl:template match="Otilde"><xsl:text>&#213;</xsl:text></xsl:template>
  <xsl:template match="Ouml"><xsl:text>&#214;</xsl:text></xsl:template>
  <xsl:template match="times"><xsl:text>&#215;</xsl:text></xsl:template>
  <xsl:template match="Oslash"><xsl:text>&#216;</xsl:text></xsl:template>
  <xsl:template match="Ugrave"><xsl:text>&#217;</xsl:text></xsl:template>
  <xsl:template match="Uacute"><xsl:text>&#218;</xsl:text></xsl:template>
  <xsl:template match="Ucirc"><xsl:text>&#219;</xsl:text></xsl:template>
  <xsl:template match="Uuml"><xsl:text>&#220;</xsl:text></xsl:template>
  <xsl:template match="Yacute"><xsl:text>&#221;</xsl:text></xsl:template>
  <xsl:template match="THORN"><xsl:text>&#222;</xsl:text></xsl:template>
  <xsl:template match="szlig"><xsl:text>&#223;</xsl:text></xsl:template>
  <xsl:template match="agrave"><xsl:text>&#224;</xsl:text></xsl:template>
  <xsl:template match="aacute"><xsl:text>&#225;</xsl:text></xsl:template>
  <xsl:template match="acirc"><xsl:text>&#226;</xsl:text></xsl:template>
  <xsl:template match="atilde"><xsl:text>&#227;</xsl:text></xsl:template>
  <xsl:template match="auml"><xsl:text>&#228;</xsl:text></xsl:template>
  <xsl:template match="aring"><xsl:text>&#229;</xsl:text></xsl:template>
  <xsl:template match="aelig"><xsl:text>&#230;</xsl:text></xsl:template>
  <xsl:template match="ccedil"><xsl:text>&#231;</xsl:text></xsl:template>
  <xsl:template match="egrave"><xsl:text>&#232;</xsl:text></xsl:template>
  <xsl:template match="eacute"><xsl:text>&#233;</xsl:text></xsl:template>
  <xsl:template match="ecirc"><xsl:text>&#234;</xsl:text></xsl:template>
  <xsl:template match="euml"><xsl:text>&#235;</xsl:text></xsl:template>
  <xsl:template match="igrave"><xsl:text>&#236;</xsl:text></xsl:template>
  <xsl:template match="iacute"><xsl:text>&#237;</xsl:text></xsl:template>
  <xsl:template match="icirc"><xsl:text>&#238;</xsl:text></xsl:template>
  <xsl:template match="iuml"><xsl:text>&#239;</xsl:text></xsl:template>
  <xsl:template match="eth"><xsl:text>&#240;</xsl:text></xsl:template>
  <xsl:template match="ntilde"><xsl:text>&#241;</xsl:text></xsl:template>
  <xsl:template match="ograve"><xsl:text>&#242;</xsl:text></xsl:template>
  <xsl:template match="oacute"><xsl:text>&#243;</xsl:text></xsl:template>
  <xsl:template match="ocirc"><xsl:text>&#244;</xsl:text></xsl:template>
  <xsl:template match="otilde"><xsl:text>&#245;</xsl:text></xsl:template>
  <xsl:template match="ouml"><xsl:text>&#246;</xsl:text></xsl:template>
  <xsl:template match="divide"><xsl:text>&#247;</xsl:text></xsl:template>
  <xsl:template match="oslash"><xsl:text>&#248;</xsl:text></xsl:template>
  <xsl:template match="ugrave"><xsl:text>&#249;</xsl:text></xsl:template>
  <xsl:template match="uacute"><xsl:text>&#250;</xsl:text></xsl:template>
  <xsl:template match="ucirc"><xsl:text>&#251;</xsl:text></xsl:template>
  <xsl:template match="uuml"><xsl:text>&#252;</xsl:text></xsl:template>
  <xsl:template match="yacute"><xsl:text>&#253;</xsl:text></xsl:template>
  <xsl:template match="thorn"><xsl:text>&#254;</xsl:text></xsl:template>
  <xsl:template match="yuml"><xsl:text>&#255;</xsl:text></xsl:template>
  <!-- Greek -->
  <!-- 5.2 10/13 fjc: added greek to PDF -->
    
    <!-- ibs 2011-07-06 
        Previously these templates contained coding like:
        <fo:inline font-family="Symbol"><xsl:text disable-output-escaping="yes"><![CDATA[&#913;]]></xsl:text></fo:inline>
        The CDATA and disable-output-escaping are unnecessary and not recommended.
        The font-family should be unnecessary as these letters should be in a decent
        Unicode font. In any event FOP will try to assign a word to the best font for that
        word. A need to specify a particular font may arise if some words use one font and
        other words use another font, simply because one word contains a special character
        of some sort that is not available int he main font. 
    -->
 <xsl:template match="Alpha"><xsl:text>&#913;</xsl:text></xsl:template><!-- greek capital letter alpha, -->
 <xsl:template match="Beta"><xsl:text>&#914;</xsl:text></xsl:template><!-- greek capital letter beta -->
 <xsl:template match="Gamma"><xsl:text>&#915;</xsl:text></xsl:template><!-- greek capital letter gamma -->
 <xsl:template match="Delta"><xsl:text>&#916;</xsl:text></xsl:template><!-- greek capital letter delta -->
 <xsl:template match="Epsilon"><xsl:text>&#917;</xsl:text></xsl:template><!-- greek capital letter epsilon -->
 <xsl:template match="Zeta"><xsl:text>&#918;</xsl:text></xsl:template><!-- greek capital letter zeta -->
 <xsl:template match="Eta"><xsl:text>&#919;</xsl:text></xsl:template><!-- greek capital letter eta -->
 <xsl:template match="Theta"><xsl:text>&#920;</xsl:text></xsl:template><!-- greek capital letter theta -->
 <xsl:template match="Iota"><xsl:text>&#921;</xsl:text></xsl:template><!-- greek capital letter iota -->
 <xsl:template match="Kappa"><xsl:text>&#922;</xsl:text></xsl:template><!-- greek capital letter kappa -->
 <xsl:template match="Lambda"><xsl:text>&#923;</xsl:text></xsl:template><!-- greek capital letter lambda -->
 <xsl:template match="Mu"><xsl:text>&#924;</xsl:text></xsl:template><!-- greek capital letter mu -->
 <xsl:template match="Nu"><xsl:text>&#925;</xsl:text></xsl:template><!-- greek capital letter nu -->
 <xsl:template match="Xi"><xsl:text>&#926;</xsl:text></xsl:template><!-- greek capital letter xi -->
 <xsl:template match="Omicron"><xsl:text>&#927;</xsl:text></xsl:template><!-- greek capital letter omicron -->
 <xsl:template match="Pi"><xsl:text>&#928;</xsl:text></xsl:template><!-- greek capital letter pi -->
 <xsl:template match="Rho"><xsl:text>&#929;</xsl:text></xsl:template><!-- greek capital letter rho -->
 <xsl:template match="Sigma"><xsl:text>&#931;</xsl:text></xsl:template><!-- greek capital letter sigma -->
 <xsl:template match="Tau"><xsl:text>&#932;</xsl:text></xsl:template><!-- greek capital letter tau -->
 <xsl:template match="Upsilon"><xsl:text>&#933;</xsl:text></xsl:template><!-- greek capital letter upsilon -->
 <xsl:template match="Phi"><xsl:text>&#934;</xsl:text></xsl:template><!-- greek capital letter phi -->
 <xsl:template match="Chi"><xsl:text>&#935;</xsl:text></xsl:template><!-- greek capital letter chi -->
 <xsl:template match="Psi"><xsl:text>&#935;</xsl:text></xsl:template><!-- greek capital letter psi -->
 <xsl:template match="Omega"><xsl:text>&#935;</xsl:text></xsl:template><!-- greek capital letter omega -->
 <xsl:template match="alpha"><xsl:text>&#945;</xsl:text></xsl:template><!-- greek small letter alpha -->
 <xsl:template match="beta"><xsl:text>&#946;</xsl:text></xsl:template><!-- greek small letter beta -->
 <xsl:template match="gamma"><xsl:text>&#947;</xsl:text></xsl:template><!-- greek small letter gamma -->
 <xsl:template match="delta"><xsl:text>&#948;</xsl:text></xsl:template><!-- greek small letter delta -->
 <xsl:template match="epsilon"><xsl:text>&#949;</xsl:text></xsl:template><!-- greek small letter epsilon -->
 <xsl:template match="zeta"><xsl:text>&#950;</xsl:text></xsl:template><!-- greek small letter zeta -->
 <xsl:template match="eta"><xsl:text>&#951;</xsl:text></xsl:template><!-- greek small letter eta -->
 <xsl:template match="theta"><xsl:text>&#952;</xsl:text></xsl:template><!-- greek small letter theta -->
 <xsl:template match="iota"><xsl:text>&#953;</xsl:text></xsl:template><!-- greek small letter iota -->
 <xsl:template match="kappa"><xsl:text>&#954;</xsl:text></xsl:template><!-- greek small letter kappa -->
 <xsl:template match="lambda"><xsl:text>&#955;</xsl:text></xsl:template><!-- greek small letter lambda -->
 <xsl:template match="mu"><xsl:text>&#956;</xsl:text></xsl:template><!-- greek small letter mu -->
 <xsl:template match="nu"><xsl:text>&#957;</xsl:text></xsl:template><!-- greek small letter nu -->
 <xsl:template match="xi"><xsl:text>&#958;</xsl:text></xsl:template><!-- greek small letter xi -->
 <xsl:template match="omicron"><xsl:text>&#959;</xsl:text></xsl:template><!-- greek small letter omicron -->
 <xsl:template match="pi"><xsl:text>&#960;</xsl:text></xsl:template><!-- greek small letter pi -->
 <xsl:template match="rho"><xsl:text>&#961;</xsl:text></xsl:template><!-- greek small letter rho -->
 <xsl:template match="sigmaf"><xsl:text>&#962;</xsl:text></xsl:template><!-- greek small letter final sigma -->
 <xsl:template match="sigma"><xsl:text>&#963;</xsl:text></xsl:template><!-- greek small letter sigma -->
 <xsl:template match="tau"><xsl:text>&#964;</xsl:text></xsl:template><!-- greek small letter tau -->
 <xsl:template match="upsilon"><xsl:text>&#965;</xsl:text></xsl:template><!-- greek small letter upsilon -->
 <xsl:template match="phi"><xsl:text>&#966;</xsl:text></xsl:template><!-- greek small letter phi -->
 <xsl:template match="chi"><xsl:text>&#967;</xsl:text></xsl:template><!-- greek small letter chi -->
 <xsl:template match="psi"><xsl:text>&#968;</xsl:text></xsl:template><!-- greek small letter ps -->
 <xsl:template match="omega"><xsl:text>&#969;</xsl:text></xsl:template><!-- greek small letter omega -->
 <xsl:template match="thetasym"><xsl:text>&#977;</xsl:text></xsl:template><!-- greek small letter theta symbol-->
 <xsl:template match="upsih"><xsl:text>&#978;</xsl:text></xsl:template><!-- greek upsilon with hook symbol -->
 <xsl:template match="piv"><xsl:text>&#982;</xsl:text></xsl:template><!-- greek pi symbol -->
</xsl:stylesheet>
