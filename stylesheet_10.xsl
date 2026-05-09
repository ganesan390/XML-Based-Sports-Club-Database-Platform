<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
<xsl:text>{
  "equipment": [
</xsl:text>
        <xsl:for-each select="SportsClub/Equipment/Item">
<xsl:text>    {
      "equipmentID": "</xsl:text><xsl:value-of select="@equipmentID"/><xsl:text>",
      "name": "</xsl:text><xsl:value-of select="Name"/><xsl:text>",
      "category": "</xsl:text><xsl:value-of select="Category"/><xsl:text>",
      "quantity": </xsl:text><xsl:value-of select="Quantity"/><xsl:text>,
      "condition": "</xsl:text><xsl:value-of select="Condition"/><xsl:text>",
      "facilityRef": "</xsl:text><xsl:value-of select="FacilityRef"/><xsl:text>"
    }</xsl:text>
            <xsl:if test="position() != last()"><xsl:text>,
</xsl:text></xsl:if>
        </xsl:for-each>
<xsl:text>
  ]
}
</xsl:text>
    </xsl:template>

</xsl:stylesheet>