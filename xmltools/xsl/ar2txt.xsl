<?xml version="1.0" encoding="UTF-8"?>
<!-- <!DOCTYPE stylesheet [ -->
<!--     <!ENTITY XSLDIR "../../../xsl"> -->
<!-- ]> -->
<xsl:stylesheet
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:نحو="http://www.sibawayhi.org/schema/2009/07/sibawayhi"
    xmlns:sib="http://www.sibawayhi.org/schema/2009/07/sibawayhi"
    version="3.0">

    <!-- xmlns:xs="http://www.w3.org/2001/XMLSchema" -->
    <!-- xmlns:xi="http://www.w3.org/2001/XInclude" -->
    <!-- xmlns:err="http://www.w3.org/2005/xqt-errors" -->
    <!-- xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" -->
    <!-- xmlns:dc="http://purl.org/dc/elements/1.1/" -->
    <!-- xmlns:dcterms="http://purl.org/dc/terms/" -->

  <xsl:output method="text"
	      indent="no"
	      encoding="utf-8"
	      />

  <xsl:strip-space elements="*"/>

  <!-- this template will be used for loaded docs -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="xsl:initial-template">
    <xsl:iterate select="1 to 571">
      <xsl:variable name="artid">
        <xsl:value-of select="format-number(., '000')"/>
      </xsl:variable>
      <xsl:variable name="ardocname">
        <xsl:value-of select="fn:concat('../text/xml/', $artid,'.ar.xml')"/>
      </xsl:variable>

      <!-- <xsl:variable name="doc"> -->
      <!--   <xsl:value- select="document(fn:concat( -->
      <!--                                '../text/xml/', $artid, -->
      <!--                                '.ar.xml'))"/> -->
      <!-- </xsl:variable> -->

      <!-- 1. emit txt for article -->
      <xsl:result-document
          method="text"
          href="text/txt/{$artid}.ar.txt">
        <xsl:apply-templates select="document($ardocname)"/>
<!-- fn:concat( -->
<!--                                      '../text/xml/', $artid, -->
<!--                                      '.ar.xml'))"/> -->
        <xsl:text>&#xA;</xsl:text>
      </xsl:result-document>

      <!-- 2. extract dicta -->
      <xsl:result-document
          method="text"
          href="extracts/dicta/txt/{$artid}.dicta.txt">
        <xsl:apply-templates select="document($ardocname)//نحو:قول"
                             mode="dicta"/>
<!-- fn:concat( -->
<!--                                      '../text/xml/', $artid, -->
<!--                                      '.ar.xml'))//نحو:قول" -->
<!--                              mode="dicta"/> -->
        <xsl:text>&#xA;</xsl:text>
      </xsl:result-document>

      <!-- 2. extract poetry -->
      <xsl:if test="document($ardocname)//نحو:شاهدة">
        <xsl:result-document
            method="text"
            href="extracts/poetry/txt/{$artid}.poetry.txt">
          <xsl:apply-templates select="document(fn:concat(
                                       '../text/xml/', $artid,
                                       '.ar.xml'))//نحو:شاهدة"
                               mode="poetry"/>
          <xsl:text>&#xA;</xsl:text>
        </xsl:result-document>
      </xsl:if>

      <!-- 2. extract quranic fragments -->
      <xsl:if test="document($ardocname)//نحو:آية">
        <xsl:result-document
            method="text"
            href="extracts/quran/txt/{$artid}.quran.txt">
          <xsl:apply-templates select="document(fn:concat(
                                       '../text/xml/', $artid,
                                       '.ar.xml'))//نحو:آية"
                               mode="quran"/>
          <xsl:text>&#xA;</xsl:text>
        </xsl:result-document>
      </xsl:if>

    </xsl:iterate>
  </xsl:template>

  <xsl:template match="نحو:عنوان">
    <xsl:apply-templates/>
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:مقطع">
    <xsl:variable name="x">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:value-of select="normalize-space($x)"/>
    <xsl:if test="following-sibling::نحو:مقطع[position() != last()]">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="نحو:قول">
    <xsl:variable name="x">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:value-of select="normalize-space($x)"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="نحو:قول" mode="dicta">
    <xsl:number level="any" format="&#x661;"/>
    <xsl:text>  </xsl:text>
    <xsl:variable name="x">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:value-of select="normalize-space($x)"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:شاهدة" mode="poetry">
    <xsl:variable name="n">
      <xsl:number level="any" format="&#x661;"/>
    </xsl:variable>
    <xsl:value-of select="$n"/>
    <xsl:text>  </xsl:text>
    <xsl:apply-templates mode="poetry"/>
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>
  <xsl:template match="نحو:شاهدة/نحو:بيت" mode="poetry">
    <xsl:apply-templates mode="poetry"/>
    <xsl:if test="position() != last()">
      <xsl:text>&#xA;</xsl:text>
      <xsl:text>    </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="نحو:شاهدة/نحو:بيت/نحو:مصراع" mode="poetry">
    <xsl:value-of select="."/>
    <xsl:if test="position() != last()">
      <xsl:text>  *  </xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- **************************************************************** -->
  <xsl:template match="نحو:آية" mode="quran">
    <xsl:value-of select="."/>
    <xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:رأس"/>
  <xsl:template match="نحو:مادة"/>
  <xsl:template match="نحو:بدل"/>

</xsl:stylesheet>
