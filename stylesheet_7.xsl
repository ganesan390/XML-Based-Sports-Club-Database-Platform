<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <ContactList>
            <xsl:for-each select="SportsClub/Members/Member">
                <Contact>
                    <MemberID><xsl:value-of select="@memberID"/></MemberID>
                    <Name><xsl:value-of select="Name"/></Name>
                    <Email><xsl:value-of select="Email"/></Email>
                    <Phone><xsl:value-of select="Phone"/></Phone>
                    <Address><xsl:value-of select="Address"/></Address>
                </Contact>
            </xsl:for-each>
        </ContactList>
    </xsl:template>

</xsl:stylesheet>