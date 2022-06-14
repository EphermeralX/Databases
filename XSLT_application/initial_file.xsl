<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="root">
		<root>
			<xsl:apply-templates select="results"/>
		</root>
	</xsl:template>
	<xsl:template match="results">
		<xsl:variable name="addIn" select="document('data.xml')"/>
		<xsl:variable name="currentTitle" select="title"/>
		<movie>
			<xsl:copy-of select="title"/>
			<xsl:copy-of select="overview"/>
			<xsl:for-each select="$addIn/root/movie">
				<xsl:if test="@title=$currentTitle">
					<imdbid>
						<xsl:value-of select="@imdbid"/>
					</imdbid>
					<writer>
						<xsl:value-of select="@writer"/>
					</writer>
					<director>
						<xsl:value-of select="@director"/>
					</director>
				</xsl:if>
			</xsl:for-each>
			<xsl:copy-of select="cast"/>
			<xsl:copy-of select="showing-in"/>
		</movie>
	</xsl:template>
</xsl:stylesheet>