<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_2.xsl
    PURPOSE: Transform SportsClub XML → Training Schedule HTML
    OUTPUT: schedule.html
    MEMBER: Member 2 — HTML Visualisation Developer
    ============================================
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- ===========================
         ROOT TEMPLATE
         =========================== -->
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <title>Training Schedule — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #065f46; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; opacity: 0.85; }
                main { padding: 30px 40px; }
                .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px,1fr)); gap: 20px; }
                .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.09);
                        padding: 20px; border-left: 5px solid #065f46; }
                .card h2 { margin: 0 0 12px; font-size: 1.05em; color: #065f46; }
                .card .row { display: flex; justify-content: space-between;
                             font-size: 0.88em; margin-bottom: 6px; }
                .card .label { color: #6b7280; font-weight: bold; }
                .card .value { color: #111; text-align: right; }
                .session-id { font-size: 0.78em; font-family: monospace; color: #9ca3af;
                              margin-top: 10px; border-top: 1px solid #f0f0f0; padding-top: 8px; }
                footer { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>🗓️ Training Schedule</h1>
                <p>Total sessions: <xsl:value-of select="count(//TrainingSessions/TrainingSession)"/></p>
            </header>
            <main>
                <div class="card-grid">
                    <!-- Sort sessions chronologically by Date then StartTime -->
                    <xsl:for-each select="//TrainingSessions/TrainingSession">
                        <xsl:sort select="Date"/>
                        <xsl:sort select="StartTime"/>
                        <div class="card">
                            <h2><xsl:value-of select="Title"/></h2>
                            <div class="row">
                                <span class="label">📅 Date</span>
                                <span class="value"><xsl:value-of select="Date"/></span>
                            </div>
                            <div class="row">
                                <span class="label">⏰ Time</span>
                                <!-- Display time range -->
                                <span class="value">
                                    <xsl:value-of select="substring(StartTime,1,5)"/>
                                    –
                                    <xsl:value-of select="substring(EndTime,1,5)"/>
                                </span>
                            </div>
                            <div class="row">
                                <span class="label">👤 Coach</span>
                                <!-- Look up coach name by coachRef -->
                                <span class="value">
                                    <xsl:variable name="cid" select="CoachRef"/>
                                    <xsl:value-of select="//Coaches/Coach[@coachID=$cid]/Name"/>
                                </span>
                            </div>
                            <div class="row">
                                <span class="label">🏟️ Facility</span>
                                <!-- Look up facility name by facilityRef -->
                                <span class="value">
                                    <xsl:variable name="fid" select="FacilityRef"/>
                                    <xsl:value-of select="//Facilities/Facility[@facilityID=$fid]/Name"/>
                                </span>
                            </div>
                            <div class="row">
                                <span class="label">👥 Max Capacity</span>
                                <span class="value"><xsl:value-of select="MaxCapacity"/></span>
                            </div>
                            <div class="session-id">Session ID: <xsl:value-of select="@sessionID"/></div>
                        </div>
                    </xsl:for-each>
                </div>
            </main>
            <footer>Sports Club Database Platform — A25 Data Pipeline 1</footer>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
