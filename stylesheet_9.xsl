<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
<xsl:text>{
  "bookings": [
</xsl:text>
        <xsl:for-each select="SportsClub/Bookings/Booking">
<xsl:text>    {
      "bookingID": "</xsl:text><xsl:value-of select="@bookingID"/><xsl:text>",
      "memberID": "</xsl:text><xsl:value-of select="MemberRef"/><xsl:text>",
      "facilityID": "</xsl:text><xsl:value-of select="FacilityRef"/><xsl:text>",
      "date": "</xsl:text><xsl:value-of select="Date"/><xsl:text>",
      "startTime": "</xsl:text><xsl:value-of select="StartTime"/><xsl:text>",
      "endTime": "</xsl:text><xsl:value-of select="EndTime"/><xsl:text>",
      "status": "</xsl:text><xsl:value-of select="Status"/><xsl:text>"
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