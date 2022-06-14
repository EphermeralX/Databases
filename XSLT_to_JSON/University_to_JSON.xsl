<xsl:stylesheet version='2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
	<xsl:output method='xhtml' omit-xml-declaration="yes"/>
	<xsl:template match='/'>
		<xsl:apply-templates select="University"/>
	</xsl:template>

	<xsl:template match="University">
		The XML to JSON transformation is working well <!-- remove this line once you have tested the transform is working and start writing your code-->
	</xsl:template>
</xsl:stylesheet>