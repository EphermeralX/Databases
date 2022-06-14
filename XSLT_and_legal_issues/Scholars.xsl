<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match='/'>
    <html>
        <h1>
            (Scholars)
        </h1>
        <h2>
            Details of (<xsl:value-of select="count(//Scholar)"/>) Scholars
        </h2>
        <table border='5'>
            <tr bgcolor="#FFFF00">
                <th align="center">Name</th>
                <th align="center">Nationality</th>
                <th align="center">Birthplace</th>
                <th align="center">Age</th>
                <th align="center">Birthdate</th>
                <th align="center">Deathdate</th>
                <th align="center">Sex</th>
                <th align="center">Professions</th>
            </tr>
            <xsl:apply-templates/>
        </table>
    </html>
    </xsl:template>
    <xsl:template match="Scholar">
        <tr>
        <td>
        <xsl:choose>
            <xsl:when test="Fullname">
                <xsl:value-of select="Fullname"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(Firstname,Lastname)"/>
            </xsl:otherwise>
        </xsl:choose>
        </td>
        <td><xsl:value-of select="Nationality"/></td>
        <td>
            <xsl:choose>
                <xsl:when test="Birthplace != null">
                    <xsl:value-of select="Birthplace"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    Null
                </xsl:otherwise>
            </xsl:choose>
        </td>
        <td><xsl:value-of select='Age'/></td>
        <td><xsl:value-of select="Age/@Birthdate"/></td>
        <td>
                <xsl:if test = "Age/@Deathdate != null">
                    <xsl:value-of select = "Age/@Deathdate"/>
                </xsl:if>
                <xsl:value-of select = "Age/@Status"/>
        </td>
        <td><xsl:value-of select='Sex'/></td>
        <td><xsl:value-of select="Professions"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>