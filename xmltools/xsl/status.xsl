<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:نحو="http://www.sibawayhi.org/schema/2009/07/sibawayhi"
    xmlns:sib="http://www.sibawayhi.org/schema/2009/07/sibawayhi"
    version="3.0">

  <xsl:output method="text"
	      indent="no"
	      encoding="utf-8"
	      />

  <xsl:strip-space elements="*"/>

  <!-- this template will be used for loaded docs? -->
  <xsl:template match="/">
<xsl:message>
  XXXX
</xsl:message>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="xsl:initial-template">

    <xsl:iterate select="fn:reverse(1 to 571)">
      <xsl:variable name="artid">
        <xsl:value-of select="format-number(., '000')"/>
      </xsl:variable>
      <xsl:variable name="ardocname">
        <xsl:value-of select="fn:concat('../../text/xml/', $artid,'.ar.xml')"/>
      </xsl:variable>

      <xsl:text>&#xA;</xsl:text>
      <xsl:value-of select="$artid"/>
      <xsl:text>:  </xsl:text>
      <xsl:if test="document($ardocname)//نحو:التحرير">
      <!-- <xsl:message> -->
      <!-- </xsl:message> -->
        <xsl:apply-templates select="document($ardocname)//نحو:التحرير"/>

      <!-- <xsl:message> -->
	<!-- <xsl:text>&#xA;/</xsl:text> -->
        <!-- <xsl:value-of select="$artid"/> -->
      <!-- </xsl:message> -->
      </xsl:if>

    </xsl:iterate>
  </xsl:template>

  <xsl:template match="نحو:التحرير">
    <xsl:apply-templates/>
  </xsl:template>
     <!-- <تشكيل  نسخة="0" نسبة="100"/> -->
     <!-- <تقطيع  نسخة="0"/> -->
     <!-- <أقوال  نسخة="0" نسبة="0"/> -->
     <!-- <شواهد  نسخة="0" نسبة="0"/> -->

  <xsl:template match="نحو:تشكيل">
    <xsl:text>tashkeel: </xsl:text>
    <xsl:value-of select="@نسخة"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="format-number(@نسبة, '0')"/>
    <xsl:text>%</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:تقطيع">
    <xsl:text>  segmentation: </xsl:text>
    <xsl:value-of select="@نسخة"/>
    <xsl:text> </xsl:text>
    <!-- <xsl:value-of select="@نسبة"/> -->
    <!-- <xsl:text>%</xsl:text> -->
  </xsl:template>

  <xsl:template match="نحو:أقوال">
    <xsl:text>  dicta: </xsl:text>
    <xsl:value-of select="@نسخة"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@نسبة"/>
    <xsl:text>%</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:شواهد">
    <xsl:text>  poetry: </xsl:text>
    <xsl:value-of select="@نسخة"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@نسبة"/>
    <xsl:text>%</xsl:text>
  </xsl:template>

  <xsl:template match="نحو:آيات">
    <xsl:text>  quran: </xsl:text>
    <xsl:value-of select="@نسخة"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@نسبة"/>
    <xsl:text>%</xsl:text>
  </xsl:template>

</xsl:stylesheet>
