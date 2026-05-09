<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <ScheduleExport>
            <xsl:for-each select="SportsClub/TrainingSessions/TrainingSession">
                <Session>
                    <SessionID><xsl:value-of select="@sessionID"/></SessionID>
                    <Title><xsl:value-of select="Title"/></Title>
                    <Date><xsl:value-of select="Date"/></Date>
                    <StartTime><xsl:value-of select="StartTime"/></StartTime>
                    <EndTime><xsl:value-of select="EndTime"/></EndTime>
                    <CoachRef><xsl:value-of select="CoachRef"/></CoachRef>
                    <FacilityRef><xsl:value-of select="FacilityRef"/></FacilityRef>
                    <MaxCapacity><xsl:value-of select="MaxCapacity"/></MaxCapacity>
                </Session>
            </xsl:for-each>
        </ScheduleExport>
    </xsl:template>

</xsl:stylesheet>