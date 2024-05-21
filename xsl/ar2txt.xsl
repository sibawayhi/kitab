<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
    <!ENTITY XSLDIR "../../../xsl">
]>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:نحو="http://www.sibawayhi.org/schema/2009/07/sibawayhi"

    xmlns:sib="http://www.sibawayhi.org/schema/2009/07/sibawayhi"
    version="3.0">

  <!-- input: xxx.ar.xml, then reads en/xxx.en.xml -->
  <!-- output: tmp/toc.ar.tex -->

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
      <xsl:variable name="docname">
        <xsl:value-of select="format-number(., '000')"/>
      </xsl:variable>
      <xsl:result-document
          method="text"
          href="text/txt/{$docname}.ar.txt">
        <xsl:apply-templates select="document(fn:concat(
                                     '../text/xml/', $docname,
                                     '.ar.xml'))"/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:result-document>
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
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="نحو:رأس"/>
  <xsl:template match="نحو:مادة"/>

</xsl:stylesheet>
