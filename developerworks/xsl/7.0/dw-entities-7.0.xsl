<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xsl fo">
<!-- 5.7 03/15/07 jpp:  Added em dash entity (DR #2141) -->
 <xsl:template match="mdash"><xsl:text disable-output-escaping="yes"><![CDATA[&#8212;]]></xsl:text></xsl:template>
 <xsl:template match="trade"><xsl:text disable-output-escaping="yes"><![CDATA[&#8482;]]></xsl:text></xsl:template>
 <xsl:template match="nbsp"><xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text></xsl:template>
  <xsl:template match="iexcl"><xsl:text disable-output-escaping="yes"><![CDATA[&#161;]]></xsl:text></xsl:template>
  <xsl:template match="cent"><xsl:text disable-output-escaping="yes"><![CDATA[&#162;]]></xsl:text></xsl:template>
  <xsl:template match="pound"><xsl:text disable-output-escaping="yes"><![CDATA[&#163;]]></xsl:text></xsl:template>
  <xsl:template match="curren"><xsl:text disable-output-escaping="yes"><![CDATA[&#164;]]></xsl:text></xsl:template>
  <xsl:template match="yen"><xsl:text disable-output-escaping="yes"><![CDATA[&#165;]]></xsl:text></xsl:template>
  <xsl:template match="brvbar"><xsl:text disable-output-escaping="yes"><![CDATA[&#166;]]></xsl:text></xsl:template>
  <xsl:template match="sect"><xsl:text disable-output-escaping="yes"><![CDATA[&#167;]]></xsl:text></xsl:template>
  <xsl:template match="uml"><xsl:text disable-output-escaping="yes"><![CDATA[&#168;]]></xsl:text></xsl:template>
  <xsl:template match="copy"><xsl:text disable-output-escaping="yes"><![CDATA[&#169;]]></xsl:text></xsl:template>
  <xsl:template match="ordf"><xsl:text disable-output-escaping="yes"><![CDATA[&#170;]]></xsl:text></xsl:template>
  <xsl:template match="laquo"><xsl:text disable-output-escaping="yes"><![CDATA[&#171;]]></xsl:text></xsl:template>
  <xsl:template match="not"><xsl:text disable-output-escaping="yes"><![CDATA[&#172;]]></xsl:text></xsl:template>
  <xsl:template match="shy"><xsl:text disable-output-escaping="yes"><![CDATA[&#173;]]></xsl:text></xsl:template>
  <xsl:template match="reg"><xsl:text disable-output-escaping="yes"><![CDATA[&#174;]]></xsl:text></xsl:template>
  <xsl:template match="macr"><xsl:text disable-output-escaping="yes"><![CDATA[&#175;]]></xsl:text></xsl:template>
  <xsl:template match="deg"><xsl:text disable-output-escaping="yes"><![CDATA[&#176;]]></xsl:text></xsl:template>
  <xsl:template match="plusmn"><xsl:text disable-output-escaping="yes"><![CDATA[&#177;]]></xsl:text></xsl:template>
  <xsl:template match="sup2"><xsl:text disable-output-escaping="yes"><![CDATA[&#178;]]></xsl:text></xsl:template>
  <xsl:template match="sup3"><xsl:text disable-output-escaping="yes"><![CDATA[&#179;]]></xsl:text></xsl:template>
  <xsl:template match="acute"><xsl:text disable-output-escaping="yes"><![CDATA[&#180;]]></xsl:text></xsl:template>
  <xsl:template match="micro"><xsl:text disable-output-escaping="yes"><![CDATA[&#181;]]></xsl:text></xsl:template>
  <xsl:template match="para"><xsl:text disable-output-escaping="yes"><![CDATA[&#182;]]></xsl:text></xsl:template>
  <xsl:template match="middot"><xsl:text disable-output-escaping="yes"><![CDATA[&#183;]]></xsl:text></xsl:template>
  <xsl:template match="cedil"><xsl:text disable-output-escaping="yes"><![CDATA[&#184;]]></xsl:text></xsl:template>
  <xsl:template match="sup1"><xsl:text disable-output-escaping="yes"><![CDATA[&#185;]]></xsl:text></xsl:template>
  <xsl:template match="ordm"><xsl:text disable-output-escaping="yes"><![CDATA[&#186;]]></xsl:text></xsl:template>
  <xsl:template match="raquo"><xsl:text disable-output-escaping="yes"><![CDATA[&#187;]]></xsl:text></xsl:template>
  <xsl:template match="frac14"><xsl:text disable-output-escaping="yes"><![CDATA[&#188;]]></xsl:text></xsl:template>
  <xsl:template match="frac12"><xsl:text disable-output-escaping="yes"><![CDATA[&#189;]]></xsl:text></xsl:template>
  <xsl:template match="frac34"><xsl:text disable-output-escaping="yes"><![CDATA[&#190;]]></xsl:text></xsl:template>
  <xsl:template match="iquest"><xsl:text disable-output-escaping="yes"><![CDATA[&#191;]]></xsl:text></xsl:template>
  <xsl:template match="Agrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#192;]]></xsl:text></xsl:template>
  <xsl:template match="Aacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#193;]]></xsl:text></xsl:template>
  <xsl:template match="Acirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#194;]]></xsl:text></xsl:template>
  <xsl:template match="Atilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#195;]]></xsl:text></xsl:template>
  <xsl:template match="Auml"><xsl:text disable-output-escaping="yes"><![CDATA[&#196;]]></xsl:text></xsl:template>
  <xsl:template match="Aring"><xsl:text disable-output-escaping="yes"><![CDATA[&#197;]]></xsl:text></xsl:template>
  <xsl:template match="AElig"><xsl:text disable-output-escaping="yes"><![CDATA[&#198;]]></xsl:text></xsl:template>
  <xsl:template match="Ccedil"><xsl:text disable-output-escaping="yes"><![CDATA[&#199;]]></xsl:text></xsl:template>
  <xsl:template match="Egrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#200;]]></xsl:text></xsl:template>
  <xsl:template match="Eacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#201;]]></xsl:text></xsl:template>
  <xsl:template match="Ecirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#202;]]></xsl:text></xsl:template>
  <xsl:template match="Euml"><xsl:text disable-output-escaping="yes"><![CDATA[&#203;]]></xsl:text></xsl:template>
  <xsl:template match="Igrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#204;]]></xsl:text></xsl:template>
  <xsl:template match="Iacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#205;]]></xsl:text></xsl:template>
  <xsl:template match="Icirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#206;]]></xsl:text></xsl:template>
  <xsl:template match="Iuml"><xsl:text disable-output-escaping="yes"><![CDATA[&#207;]]></xsl:text></xsl:template>
  <xsl:template match="ETH"><xsl:text disable-output-escaping="yes"><![CDATA[&#208;]]></xsl:text></xsl:template>
  <xsl:template match="Ntilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#209;]]></xsl:text></xsl:template>
  <xsl:template match="Ograve"><xsl:text disable-output-escaping="yes"><![CDATA[&#210;]]></xsl:text></xsl:template>
  <xsl:template match="Oacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#211;]]></xsl:text></xsl:template>
  <xsl:template match="Ocirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#212;]]></xsl:text></xsl:template>
  <xsl:template match="Otilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#213;]]></xsl:text></xsl:template>
  <xsl:template match="Ouml"><xsl:text disable-output-escaping="yes"><![CDATA[&#214;]]></xsl:text></xsl:template>
  <xsl:template match="times"><xsl:text disable-output-escaping="yes"><![CDATA[&#215;]]></xsl:text></xsl:template>
  <xsl:template match="Oslash"><xsl:text disable-output-escaping="yes"><![CDATA[&#216;]]></xsl:text></xsl:template>
  <xsl:template match="Ugrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#217;]]></xsl:text></xsl:template>
  <xsl:template match="Uacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#218;]]></xsl:text></xsl:template>
  <xsl:template match="Ucirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#219;]]></xsl:text></xsl:template>
  <xsl:template match="Uuml"><xsl:text disable-output-escaping="yes"><![CDATA[&#220;]]></xsl:text></xsl:template>
  <xsl:template match="Yacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#221;]]></xsl:text></xsl:template>
  <xsl:template match="THORN"><xsl:text disable-output-escaping="yes"><![CDATA[&#222;]]></xsl:text></xsl:template>
  <xsl:template match="szlig"><xsl:text disable-output-escaping="yes"><![CDATA[&#223;]]></xsl:text></xsl:template>
  <xsl:template match="agrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#224;]]></xsl:text></xsl:template>
  <xsl:template match="aacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#225;]]></xsl:text></xsl:template>
  <xsl:template match="acirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#226;]]></xsl:text></xsl:template>
  <xsl:template match="atilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#227;]]></xsl:text></xsl:template>
  <xsl:template match="auml"><xsl:text disable-output-escaping="yes"><![CDATA[&#228;]]></xsl:text></xsl:template>
  <xsl:template match="aring"><xsl:text disable-output-escaping="yes"><![CDATA[&#229;]]></xsl:text></xsl:template>
  <xsl:template match="aelig"><xsl:text disable-output-escaping="yes"><![CDATA[&#230;]]></xsl:text></xsl:template>
  <xsl:template match="ccedil"><xsl:text disable-output-escaping="yes"><![CDATA[&#231;]]></xsl:text></xsl:template>
  <xsl:template match="egrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#232;]]></xsl:text></xsl:template>
  <xsl:template match="eacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#233;]]></xsl:text></xsl:template>
  <xsl:template match="ecirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#234;]]></xsl:text></xsl:template>
  <xsl:template match="euml"><xsl:text disable-output-escaping="yes"><![CDATA[&#235;]]></xsl:text></xsl:template>
  <xsl:template match="igrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#236;]]></xsl:text></xsl:template>
  <xsl:template match="iacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#237;]]></xsl:text></xsl:template>
  <xsl:template match="icirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#238;]]></xsl:text></xsl:template>
  <xsl:template match="iuml"><xsl:text disable-output-escaping="yes"><![CDATA[&#239;]]></xsl:text></xsl:template>
  <xsl:template match="eth"><xsl:text disable-output-escaping="yes"><![CDATA[&#240;]]></xsl:text></xsl:template>
  <xsl:template match="ntilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#241;]]></xsl:text></xsl:template>
  <xsl:template match="ograve"><xsl:text disable-output-escaping="yes"><![CDATA[&#242;]]></xsl:text></xsl:template>
  <xsl:template match="oacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#243;]]></xsl:text></xsl:template>
  <xsl:template match="ocirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#244;]]></xsl:text></xsl:template>
  <xsl:template match="otilde"><xsl:text disable-output-escaping="yes"><![CDATA[&#245;]]></xsl:text></xsl:template>
  <xsl:template match="ouml"><xsl:text disable-output-escaping="yes"><![CDATA[&#246;]]></xsl:text></xsl:template>
  <xsl:template match="divide"><xsl:text disable-output-escaping="yes"><![CDATA[&#247;]]></xsl:text></xsl:template>
  <xsl:template match="oslash"><xsl:text disable-output-escaping="yes"><![CDATA[&#248;]]></xsl:text></xsl:template>
  <xsl:template match="ugrave"><xsl:text disable-output-escaping="yes"><![CDATA[&#249;]]></xsl:text></xsl:template>
  <xsl:template match="uacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#250;]]></xsl:text></xsl:template>
  <xsl:template match="ucirc"><xsl:text disable-output-escaping="yes"><![CDATA[&#251;]]></xsl:text></xsl:template>
  <xsl:template match="uuml"><xsl:text disable-output-escaping="yes"><![CDATA[&#252;]]></xsl:text></xsl:template>
  <xsl:template match="yacute"><xsl:text disable-output-escaping="yes"><![CDATA[&#253;]]></xsl:text></xsl:template>
  <xsl:template match="thorn"><xsl:text disable-output-escaping="yes"><![CDATA[&#254;]]></xsl:text></xsl:template>
  <xsl:template match="yuml"><xsl:text disable-output-escaping="yes"><![CDATA[&#255;]]></xsl:text></xsl:template>
  <!-- Greek -->
  <!-- 5.2 8/31 fjc: added greek -->
 <xsl:template match="Alpha"><xsl:text disable-output-escaping="yes"><![CDATA[&#913;]]></xsl:text></xsl:template><!-- greek capital letter alpha, -->
 <xsl:template match="Beta"><xsl:text disable-output-escaping="yes"><![CDATA[&#914;]]></xsl:text></xsl:template><!-- greek capital letter beta -->
 <xsl:template match="Gamma"><xsl:text disable-output-escaping="yes"><![CDATA[&#915;]]></xsl:text></xsl:template><!-- greek capital letter gamma -->
 <xsl:template match="Delta"><xsl:text disable-output-escaping="yes"><![CDATA[&#916;]]></xsl:text></xsl:template><!-- greek capital letter delta -->
 <xsl:template match="Epsilon"><xsl:text disable-output-escaping="yes"><![CDATA[&#917;]]></xsl:text></xsl:template><!-- greek capital letter epsilon -->
 <xsl:template match="Zeta"><xsl:text disable-output-escaping="yes"><![CDATA[&#918;]]></xsl:text></xsl:template><!-- greek capital letter zeta -->
 <xsl:template match="Eta"><xsl:text disable-output-escaping="yes"><![CDATA[&#919;]]></xsl:text></xsl:template><!-- greek capital letter eta -->
 <xsl:template match="Theta"><xsl:text disable-output-escaping="yes"><![CDATA[&#920;]]></xsl:text></xsl:template><!-- greek capital letter theta -->
 <xsl:template match="Iota"><xsl:text disable-output-escaping="yes"><![CDATA[&#921;]]></xsl:text></xsl:template><!-- greek capital letter iota -->
 <xsl:template match="Kappa"><xsl:text disable-output-escaping="yes"><![CDATA[&#922;]]></xsl:text></xsl:template><!-- greek capital letter kappa -->
 <xsl:template match="Lambda"><xsl:text disable-output-escaping="yes"><![CDATA[&#923;]]></xsl:text></xsl:template><!-- greek capital letter lambda -->
 <xsl:template match="Mu"><xsl:text disable-output-escaping="yes"><![CDATA[&#924;]]></xsl:text></xsl:template><!-- greek capital letter mu -->
 <xsl:template match="Nu"><xsl:text disable-output-escaping="yes"><![CDATA[&#925;]]></xsl:text></xsl:template><!-- greek capital letter nu -->
 <xsl:template match="Xi"><xsl:text disable-output-escaping="yes"><![CDATA[&#926;]]></xsl:text></xsl:template><!-- greek capital letter xi -->
 <xsl:template match="Omicron"><xsl:text disable-output-escaping="yes"><![CDATA[&#927;]]></xsl:text></xsl:template><!-- greek capital letter omicron -->
 <xsl:template match="Pi"><xsl:text disable-output-escaping="yes"><![CDATA[&#928;]]></xsl:text></xsl:template><!-- greek capital letter pi -->
 <xsl:template match="Rho"><xsl:text disable-output-escaping="yes"><![CDATA[&#929;]]></xsl:text></xsl:template><!-- greek capital letter rho -->
 <xsl:template match="Sigma"><xsl:text disable-output-escaping="yes"><![CDATA[&#931;]]></xsl:text></xsl:template><!-- greek capital letter sigma -->
 <xsl:template match="Tau"><xsl:text disable-output-escaping="yes"><![CDATA[&#932;]]></xsl:text></xsl:template><!-- greek capital letter tau -->
 <xsl:template match="Upsilon"><xsl:text disable-output-escaping="yes"><![CDATA[&#933;]]></xsl:text></xsl:template><!-- greek capital letter upsilon -->
 <xsl:template match="Phi"><xsl:text disable-output-escaping="yes"><![CDATA[&#934;]]></xsl:text></xsl:template><!-- greek capital letter phi -->
 <xsl:template match="Chi"><xsl:text disable-output-escaping="yes"><![CDATA[&#935;]]></xsl:text></xsl:template><!-- greek capital letter chi -->
 <xsl:template match="Psi"><xsl:text disable-output-escaping="yes"><![CDATA[&#935;]]></xsl:text></xsl:template><!-- greek capital letter psi -->
 <xsl:template match="Omega"><xsl:text disable-output-escaping="yes"><![CDATA[&#935;]]></xsl:text></xsl:template><!-- greek capital letter omega -->
 <xsl:template match="alpha"><xsl:text disable-output-escaping="yes"><![CDATA[&#945;]]></xsl:text></xsl:template><!-- greek small letter alpha -->
 <xsl:template match="beta"><xsl:text disable-output-escaping="yes"><![CDATA[&#946;]]></xsl:text></xsl:template><!-- greek small letter beta -->
 <xsl:template match="gamma"><xsl:text disable-output-escaping="yes"><![CDATA[&#947;]]></xsl:text></xsl:template><!-- greek small letter gamma -->
 <xsl:template match="delta"><xsl:text disable-output-escaping="yes"><![CDATA[&#948;]]></xsl:text></xsl:template><!-- greek small letter delta -->
 <xsl:template match="epsilon"><xsl:text disable-output-escaping="yes"><![CDATA[&#949;]]></xsl:text></xsl:template><!-- greek small letter epsilon -->
 <xsl:template match="zeta"><xsl:text disable-output-escaping="yes"><![CDATA[&#950;]]></xsl:text></xsl:template><!-- greek small letter zeta -->
 <xsl:template match="eta"><xsl:text disable-output-escaping="yes"><![CDATA[&#951;]]></xsl:text></xsl:template><!-- greek small letter eta -->
 <xsl:template match="theta"><xsl:text disable-output-escaping="yes"><![CDATA[&#952;]]></xsl:text></xsl:template><!-- greek small letter theta -->
 <xsl:template match="iota"><xsl:text disable-output-escaping="yes"><![CDATA[&#953;]]></xsl:text></xsl:template><!-- greek small letter iota -->
 <xsl:template match="kappa"><xsl:text disable-output-escaping="yes"><![CDATA[&#954;]]></xsl:text></xsl:template><!-- greek small letter kappa -->
 <xsl:template match="lambda"><xsl:text disable-output-escaping="yes"><![CDATA[&#955;]]></xsl:text></xsl:template><!-- greek small letter lambda -->
 <xsl:template match="mu"><xsl:text disable-output-escaping="yes"><![CDATA[&#956;]]></xsl:text></xsl:template><!-- greek small letter mu -->
 <xsl:template match="nu"><xsl:text disable-output-escaping="yes"><![CDATA[&#957;]]></xsl:text></xsl:template><!-- greek small letter nu -->
 <xsl:template match="xi"><xsl:text disable-output-escaping="yes"><![CDATA[&#958;]]></xsl:text></xsl:template><!-- greek small letter xi -->
 <xsl:template match="omicron"><xsl:text disable-output-escaping="yes"><![CDATA[&#959;]]></xsl:text></xsl:template><!-- greek small letter omicron -->
 <xsl:template match="pi"><xsl:text disable-output-escaping="yes"><![CDATA[&#960;]]></xsl:text></xsl:template><!-- greek small letter pi -->
 <xsl:template match="rho"><xsl:text disable-output-escaping="yes"><![CDATA[&#961;]]></xsl:text></xsl:template><!-- greek small letter rho -->
 <xsl:template match="sigmaf"><xsl:text disable-output-escaping="yes"><![CDATA[&#962;]]></xsl:text></xsl:template><!-- greek small letter final sigma -->
 <xsl:template match="sigma"><xsl:text disable-output-escaping="yes"><![CDATA[&#963;]]></xsl:text></xsl:template><!-- greek small letter sigma -->
 <xsl:template match="tau"><xsl:text disable-output-escaping="yes"><![CDATA[&#964;]]></xsl:text></xsl:template><!-- greek small letter tau -->
 <xsl:template match="upsilon"><xsl:text disable-output-escaping="yes"><![CDATA[&#965;]]></xsl:text></xsl:template><!-- greek small letter upsilon -->
 <xsl:template match="phi"><xsl:text disable-output-escaping="yes"><![CDATA[&#966;]]></xsl:text></xsl:template><!-- greek small letter phi -->
 <xsl:template match="chi"><xsl:text disable-output-escaping="yes"><![CDATA[&#967;]]></xsl:text></xsl:template><!-- greek small letter chi -->
 <xsl:template match="psi"><xsl:text disable-output-escaping="yes"><![CDATA[&#968;]]></xsl:text></xsl:template><!-- greek small letter ps -->
 <xsl:template match="omega"><xsl:text disable-output-escaping="yes"><![CDATA[&#969;]]></xsl:text></xsl:template><!-- greek small letter omega -->
 <xsl:template match="thetasym"><xsl:text disable-output-escaping="yes"><![CDATA[&#977;]]></xsl:text></xsl:template><!-- greek small letter theta symbol-->
 <xsl:template match="upsih"><xsl:text disable-output-escaping="yes"><![CDATA[&#978;]]></xsl:text></xsl:template><!-- greek upsilon with hook symbol -->
 <xsl:template match="piv"><xsl:text disable-output-escaping="yes"><![CDATA[&#982;]]></xsl:text></xsl:template><!-- greek pi symbol -->
<!-- 5.7 03/15/07 jpp:  Added em dash entity (DR #2141) -->
 <xsl:template match="mdash" mode="no-escaping" ><xsl:text >&#8212;</xsl:text></xsl:template>
 <xsl:template match="trade" mode="no-escaping" ><xsl:text >&#8482;</xsl:text></xsl:template>
 <xsl:template match="nbsp" mode="no-escaping" ><xsl:text >&#160;</xsl:text></xsl:template>
  <xsl:template match="iexcl" mode="no-escaping" ><xsl:text >&#161;</xsl:text></xsl:template>
  <xsl:template match="cent" mode="no-escaping" ><xsl:text >&#162;</xsl:text></xsl:template>
  <xsl:template match="pound" mode="no-escaping" ><xsl:text >&#163;</xsl:text></xsl:template>
  <xsl:template match="curren" mode="no-escaping" ><xsl:text >&#164;</xsl:text></xsl:template>
  <xsl:template match="yen" mode="no-escaping" ><xsl:text >&#165;</xsl:text></xsl:template>
  <xsl:template match="brvbar" mode="no-escaping" ><xsl:text >&#166;</xsl:text></xsl:template>
  <xsl:template match="sect" mode="no-escaping" ><xsl:text >&#167;</xsl:text></xsl:template>
  <xsl:template match="uml" mode="no-escaping" ><xsl:text >&#168;</xsl:text></xsl:template>
  <xsl:template match="copy" mode="no-escaping" ><xsl:text >&#169;</xsl:text></xsl:template>
  <xsl:template match="ordf" mode="no-escaping" ><xsl:text >&#170;</xsl:text></xsl:template>
  <xsl:template match="laquo" mode="no-escaping" ><xsl:text >&#171;</xsl:text></xsl:template>
  <xsl:template match="not" mode="no-escaping" ><xsl:text >&#172;</xsl:text></xsl:template>
  <xsl:template match="shy" mode="no-escaping" ><xsl:text >&#173;</xsl:text></xsl:template>
  <xsl:template match="reg" mode="no-escaping" ><xsl:text >&#174;</xsl:text></xsl:template>
  <xsl:template match="macr" mode="no-escaping" ><xsl:text >&#175;</xsl:text></xsl:template>
  <xsl:template match="deg" mode="no-escaping" ><xsl:text >&#176;</xsl:text></xsl:template>
  <xsl:template match="plusmn" mode="no-escaping" ><xsl:text >&#177;</xsl:text></xsl:template>
  <xsl:template match="sup2" mode="no-escaping" ><xsl:text >&#178;</xsl:text></xsl:template>
  <xsl:template match="sup3" mode="no-escaping" ><xsl:text >&#179;</xsl:text></xsl:template>
  <xsl:template match="acute" mode="no-escaping" ><xsl:text >&#180;</xsl:text></xsl:template>
  <xsl:template match="micro" mode="no-escaping" ><xsl:text >&#181;</xsl:text></xsl:template>
  <xsl:template match="para" mode="no-escaping" ><xsl:text >&#182;</xsl:text></xsl:template>
  <xsl:template match="middot" mode="no-escaping" ><xsl:text >&#183;</xsl:text></xsl:template>
  <xsl:template match="cedil" mode="no-escaping" ><xsl:text >&#184;</xsl:text></xsl:template>
  <xsl:template match="sup1" mode="no-escaping" ><xsl:text >&#185;</xsl:text></xsl:template>
  <xsl:template match="ordm" mode="no-escaping" ><xsl:text >&#186;</xsl:text></xsl:template>
  <xsl:template match="raquo" mode="no-escaping" ><xsl:text >&#187;</xsl:text></xsl:template>
  <xsl:template match="frac14" mode="no-escaping" ><xsl:text >&#188;</xsl:text></xsl:template>
  <xsl:template match="frac12" mode="no-escaping" ><xsl:text >&#189;</xsl:text></xsl:template>
  <xsl:template match="frac34" mode="no-escaping" ><xsl:text >&#190;</xsl:text></xsl:template>
  <xsl:template match="iquest" mode="no-escaping" ><xsl:text >&#191;</xsl:text></xsl:template>
  <xsl:template match="Agrave" mode="no-escaping" ><xsl:text >&#192;</xsl:text></xsl:template>
  <xsl:template match="Aacute" mode="no-escaping" ><xsl:text >&#193;</xsl:text></xsl:template>
  <xsl:template match="Acirc" mode="no-escaping" ><xsl:text >&#194;</xsl:text></xsl:template>
  <xsl:template match="Atilde" mode="no-escaping" ><xsl:text >&#195;</xsl:text></xsl:template>
  <xsl:template match="Auml" mode="no-escaping" ><xsl:text >&#196;</xsl:text></xsl:template>
  <xsl:template match="Aring" mode="no-escaping" ><xsl:text >&#197;</xsl:text></xsl:template>
  <xsl:template match="AElig" mode="no-escaping" ><xsl:text >&#198;</xsl:text></xsl:template>
  <xsl:template match="Ccedil" mode="no-escaping" ><xsl:text >&#199;</xsl:text></xsl:template>
  <xsl:template match="Egrave" mode="no-escaping" ><xsl:text >&#200;</xsl:text></xsl:template>
  <xsl:template match="Eacute" mode="no-escaping" ><xsl:text >&#201;</xsl:text></xsl:template>
  <xsl:template match="Ecirc" mode="no-escaping" ><xsl:text >&#202;</xsl:text></xsl:template>
  <xsl:template match="Euml" mode="no-escaping" ><xsl:text >&#203;</xsl:text></xsl:template>
  <xsl:template match="Igrave" mode="no-escaping" ><xsl:text >&#204;</xsl:text></xsl:template>
  <xsl:template match="Iacute" mode="no-escaping" ><xsl:text >&#205;</xsl:text></xsl:template>
  <xsl:template match="Icirc" mode="no-escaping" ><xsl:text >&#206;</xsl:text></xsl:template>
  <xsl:template match="Iuml" mode="no-escaping" ><xsl:text >&#207;</xsl:text></xsl:template>
  <xsl:template match="ETH" mode="no-escaping" ><xsl:text >&#208;</xsl:text></xsl:template>
  <xsl:template match="Ntilde" mode="no-escaping" ><xsl:text >&#209;</xsl:text></xsl:template>
  <xsl:template match="Ograve" mode="no-escaping" ><xsl:text >&#210;</xsl:text></xsl:template>
  <xsl:template match="Oacute" mode="no-escaping" ><xsl:text >&#211;</xsl:text></xsl:template>
  <xsl:template match="Ocirc" mode="no-escaping" ><xsl:text >&#212;</xsl:text></xsl:template>
  <xsl:template match="Otilde" mode="no-escaping" ><xsl:text >&#213;</xsl:text></xsl:template>
  <xsl:template match="Ouml" mode="no-escaping" ><xsl:text >&#214;</xsl:text></xsl:template>
  <xsl:template match="times" mode="no-escaping" ><xsl:text >&#215;</xsl:text></xsl:template>
  <xsl:template match="Oslash" mode="no-escaping" ><xsl:text >&#216;</xsl:text></xsl:template>
  <xsl:template match="Ugrave" mode="no-escaping" ><xsl:text >&#217;</xsl:text></xsl:template>
  <xsl:template match="Uacute" mode="no-escaping" ><xsl:text >&#218;</xsl:text></xsl:template>
  <xsl:template match="Ucirc" mode="no-escaping" ><xsl:text >&#219;</xsl:text></xsl:template>
  <xsl:template match="Uuml" mode="no-escaping" ><xsl:text >&#220;</xsl:text></xsl:template>
  <xsl:template match="Yacute" mode="no-escaping" ><xsl:text >&#221;</xsl:text></xsl:template>
  <xsl:template match="THORN" mode="no-escaping" ><xsl:text >&#222;</xsl:text></xsl:template>
  <xsl:template match="szlig" mode="no-escaping" ><xsl:text >&#223;</xsl:text></xsl:template>
  <xsl:template match="agrave" mode="no-escaping" ><xsl:text >&#224;</xsl:text></xsl:template>
  <xsl:template match="aacute" mode="no-escaping" ><xsl:text >&#225;</xsl:text></xsl:template>
  <xsl:template match="acirc" mode="no-escaping" ><xsl:text >&#226;</xsl:text></xsl:template>
  <xsl:template match="atilde" mode="no-escaping" ><xsl:text >&#227;</xsl:text></xsl:template>
  <xsl:template match="auml" mode="no-escaping" ><xsl:text >&#228;</xsl:text></xsl:template>
  <xsl:template match="aring" mode="no-escaping" ><xsl:text >&#229;</xsl:text></xsl:template>
  <xsl:template match="aelig" mode="no-escaping" ><xsl:text >&#230;</xsl:text></xsl:template>
  <xsl:template match="ccedil" mode="no-escaping" ><xsl:text >&#231;</xsl:text></xsl:template>
  <xsl:template match="egrave" mode="no-escaping" ><xsl:text >&#232;</xsl:text></xsl:template>
  <xsl:template match="eacute" mode="no-escaping" ><xsl:text >&#233;</xsl:text></xsl:template>
  <xsl:template match="ecirc" mode="no-escaping" ><xsl:text >&#234;</xsl:text></xsl:template>
  <xsl:template match="euml" mode="no-escaping" ><xsl:text >&#235;</xsl:text></xsl:template>
  <xsl:template match="igrave" mode="no-escaping" ><xsl:text >&#236;</xsl:text></xsl:template>
  <xsl:template match="iacute" mode="no-escaping" ><xsl:text >&#237;</xsl:text></xsl:template>
  <xsl:template match="icirc" mode="no-escaping" ><xsl:text >&#238;</xsl:text></xsl:template>
  <xsl:template match="iuml" mode="no-escaping" ><xsl:text >&#239;</xsl:text></xsl:template>
  <xsl:template match="eth" mode="no-escaping" ><xsl:text >&#240;</xsl:text></xsl:template>
  <xsl:template match="ntilde" mode="no-escaping" ><xsl:text >&#241;</xsl:text></xsl:template>
  <xsl:template match="ograve" mode="no-escaping" ><xsl:text >&#242;</xsl:text></xsl:template>
  <xsl:template match="oacute" mode="no-escaping" ><xsl:text >&#243;</xsl:text></xsl:template>
  <xsl:template match="ocirc" mode="no-escaping" ><xsl:text >&#244;</xsl:text></xsl:template>
  <xsl:template match="otilde" mode="no-escaping" ><xsl:text >&#245;</xsl:text></xsl:template>
  <xsl:template match="ouml" mode="no-escaping" ><xsl:text >&#246;</xsl:text></xsl:template>
  <xsl:template match="divide" mode="no-escaping" ><xsl:text >&#247;</xsl:text></xsl:template>
  <xsl:template match="oslash" mode="no-escaping" ><xsl:text >&#248;</xsl:text></xsl:template>
  <xsl:template match="ugrave" mode="no-escaping" ><xsl:text >&#249;</xsl:text></xsl:template>
  <xsl:template match="uacute" mode="no-escaping" ><xsl:text >&#250;</xsl:text></xsl:template>
  <xsl:template match="ucirc" mode="no-escaping" ><xsl:text >&#251;</xsl:text></xsl:template>
  <xsl:template match="uuml" mode="no-escaping" ><xsl:text >&#252;</xsl:text></xsl:template>
  <xsl:template match="yacute" mode="no-escaping" ><xsl:text >&#253;</xsl:text></xsl:template>
  <xsl:template match="thorn" mode="no-escaping" ><xsl:text >&#254;</xsl:text></xsl:template>
  <xsl:template match="yuml" mode="no-escaping" ><xsl:text >&#255;</xsl:text></xsl:template>
  <!-- Greek -->
  <!-- 5.2 8/31 fjc: added greek -->
 <xsl:template match="Alpha" mode="no-escaping" ><xsl:text >&#913;</xsl:text></xsl:template><!-- greek capital letter alpha, -->
 <xsl:template match="Beta" mode="no-escaping" ><xsl:text >&#914;</xsl:text></xsl:template><!-- greek capital letter beta -->
 <xsl:template match="Gamma" mode="no-escaping" ><xsl:text >&#915;</xsl:text></xsl:template><!-- greek capital letter gamma -->
 <xsl:template match="Delta" mode="no-escaping" ><xsl:text >&#916;</xsl:text></xsl:template><!-- greek capital letter delta -->
 <xsl:template match="Epsilon" mode="no-escaping" ><xsl:text >&#917;</xsl:text></xsl:template><!-- greek capital letter epsilon -->
 <xsl:template match="Zeta" mode="no-escaping" ><xsl:text >&#918;</xsl:text></xsl:template><!-- greek capital letter zeta -->
 <xsl:template match="Eta" mode="no-escaping" ><xsl:text >&#919;</xsl:text></xsl:template><!-- greek capital letter eta -->
 <xsl:template match="Theta" mode="no-escaping" ><xsl:text >&#920;</xsl:text></xsl:template><!-- greek capital letter theta -->
 <xsl:template match="Iota" mode="no-escaping" ><xsl:text >&#921;</xsl:text></xsl:template><!-- greek capital letter iota -->
 <xsl:template match="Kappa" mode="no-escaping" ><xsl:text >&#922;</xsl:text></xsl:template><!-- greek capital letter kappa -->
 <xsl:template match="Lambda" mode="no-escaping" ><xsl:text >&#923;</xsl:text></xsl:template><!-- greek capital letter lambda -->
 <xsl:template match="Mu" mode="no-escaping" ><xsl:text >&#924;</xsl:text></xsl:template><!-- greek capital letter mu -->
 <xsl:template match="Nu" mode="no-escaping" ><xsl:text >&#925;</xsl:text></xsl:template><!-- greek capital letter nu -->
 <xsl:template match="Xi" mode="no-escaping" ><xsl:text >&#926;</xsl:text></xsl:template><!-- greek capital letter xi -->
 <xsl:template match="Omicron" mode="no-escaping" ><xsl:text >&#927;</xsl:text></xsl:template><!-- greek capital letter omicron -->
 <xsl:template match="Pi" mode="no-escaping" ><xsl:text >&#928;</xsl:text></xsl:template><!-- greek capital letter pi -->
 <xsl:template match="Rho" mode="no-escaping" ><xsl:text >&#929;</xsl:text></xsl:template><!-- greek capital letter rho -->
 <xsl:template match="Sigma" mode="no-escaping" ><xsl:text >&#931;</xsl:text></xsl:template><!-- greek capital letter sigma -->
 <xsl:template match="Tau" mode="no-escaping" ><xsl:text >&#932;</xsl:text></xsl:template><!-- greek capital letter tau -->
 <xsl:template match="Upsilon" mode="no-escaping" ><xsl:text >&#933;</xsl:text></xsl:template><!-- greek capital letter upsilon -->
 <xsl:template match="Phi" mode="no-escaping" ><xsl:text >&#934;</xsl:text></xsl:template><!-- greek capital letter phi -->
 <xsl:template match="Chi" mode="no-escaping" ><xsl:text >&#935;</xsl:text></xsl:template><!-- greek capital letter chi -->
 <xsl:template match="Psi" mode="no-escaping" ><xsl:text >&#935;</xsl:text></xsl:template><!-- greek capital letter psi -->
 <xsl:template match="Omega" mode="no-escaping" ><xsl:text >&#935;</xsl:text></xsl:template><!-- greek capital letter omega -->
 <xsl:template match="alpha" mode="no-escaping" ><xsl:text >&#945;</xsl:text></xsl:template><!-- greek small letter alpha -->
 <xsl:template match="beta" mode="no-escaping" ><xsl:text >&#946;</xsl:text></xsl:template><!-- greek small letter beta -->
 <xsl:template match="gamma" mode="no-escaping" ><xsl:text >&#947;</xsl:text></xsl:template><!-- greek small letter gamma -->
 <xsl:template match="delta" mode="no-escaping" ><xsl:text >&#948;</xsl:text></xsl:template><!-- greek small letter delta -->
 <xsl:template match="epsilon" mode="no-escaping" ><xsl:text >&#949;</xsl:text></xsl:template><!-- greek small letter epsilon -->
 <xsl:template match="zeta" mode="no-escaping" ><xsl:text >&#950;</xsl:text></xsl:template><!-- greek small letter zeta -->
 <xsl:template match="eta" mode="no-escaping" ><xsl:text >&#951;</xsl:text></xsl:template><!-- greek small letter eta -->
 <xsl:template match="theta" mode="no-escaping" ><xsl:text >&#952;</xsl:text></xsl:template><!-- greek small letter theta -->
 <xsl:template match="iota" mode="no-escaping" ><xsl:text >&#953;</xsl:text></xsl:template><!-- greek small letter iota -->
 <xsl:template match="kappa" mode="no-escaping" ><xsl:text >&#954;</xsl:text></xsl:template><!-- greek small letter kappa -->
 <xsl:template match="lambda" mode="no-escaping" ><xsl:text >&#955;</xsl:text></xsl:template><!-- greek small letter lambda -->
 <xsl:template match="mu" mode="no-escaping" ><xsl:text >&#956;</xsl:text></xsl:template><!-- greek small letter mu -->
 <xsl:template match="nu" mode="no-escaping" ><xsl:text >&#957;</xsl:text></xsl:template><!-- greek small letter nu -->
 <xsl:template match="xi" mode="no-escaping" ><xsl:text >&#958;</xsl:text></xsl:template><!-- greek small letter xi -->
 <xsl:template match="omicron" mode="no-escaping" ><xsl:text >&#959;</xsl:text></xsl:template><!-- greek small letter omicron -->
 <xsl:template match="pi" mode="no-escaping" ><xsl:text >&#960;</xsl:text></xsl:template><!-- greek small letter pi -->
 <xsl:template match="rho" mode="no-escaping" ><xsl:text >&#961;</xsl:text></xsl:template><!-- greek small letter rho -->
 <xsl:template match="sigmaf" mode="no-escaping" ><xsl:text >&#962;</xsl:text></xsl:template><!-- greek small letter final sigma -->
 <xsl:template match="sigma" mode="no-escaping" ><xsl:text >&#963;</xsl:text></xsl:template><!-- greek small letter sigma -->
 <xsl:template match="tau" mode="no-escaping" ><xsl:text >&#964;</xsl:text></xsl:template><!-- greek small letter tau -->
 <xsl:template match="upsilon" mode="no-escaping" ><xsl:text >&#965;</xsl:text></xsl:template><!-- greek small letter upsilon -->
 <xsl:template match="phi" mode="no-escaping" ><xsl:text >&#966;</xsl:text></xsl:template><!-- greek small letter phi -->
 <xsl:template match="chi" mode="no-escaping" ><xsl:text >&#967;</xsl:text></xsl:template><!-- greek small letter chi -->
 <xsl:template match="psi" mode="no-escaping" ><xsl:text >&#968;</xsl:text></xsl:template><!-- greek small letter ps -->
 <xsl:template match="omega" mode="no-escaping" ><xsl:text >&#969;</xsl:text></xsl:template><!-- greek small letter omega -->
 <xsl:template match="thetasym" mode="no-escaping" ><xsl:text >&#977;</xsl:text></xsl:template><!-- greek small letter theta symbol-->
 <xsl:template match="upsih" mode="no-escaping" ><xsl:text >&#978;</xsl:text></xsl:template><!-- greek upsilon with hook symbol -->
 <xsl:template match="piv" mode="no-escaping" ><xsl:text >&#982;</xsl:text></xsl:template><!-- greek pi symbol -->


</xsl:stylesheet>
