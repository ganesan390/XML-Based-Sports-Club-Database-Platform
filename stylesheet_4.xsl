<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_4.xsl
    PURPOSE: Transform SportsClub XML → Facility Availability HTML
    OUTPUT: facilities.html
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
            <title>Facility Availability — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #b45309; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; opacity: 0.85; }
                main { padding: 30px 40px; }
                .stats { display: flex; gap: 20px; margin-bottom: 24px; }
                .stat-box { background: white; border-radius: 8px; padding: 16px 24px;
                            box-shadow: 0 2px 6px rgba(0,0,0,0.08); text-align: center; flex: 1; }
                .stat-box .num  { font-size: 2em; font-weight: bold; }
                .stat-box .desc { font-size: 0.82em; color: #6b7280; margin-top: 4px; }
                .available-num   { color: #16a34a; }
                .unavailable-num { color: #dc2626; }
                .total-num       { color: #b45309; }
                table { width: 100%; border-collapse: collapse; background: white;
                        box-shadow: 0 2px 6px rgba(0,0,0,0.08); border-radius: 6px;
                        overflow: hidden; }
                th { background: #b45309; color: white; padding: 12px 16px;
                     text-align: left; font-size: 0.9em; }
                td { padding: 11px 16px; border-bottom: 1px solid #e8ecf0; font-size: 0.92em; }
                tr:last-child td { border-bottom: none; }
                tr:hover td { background: #fefce8; }
                .avail-yes { display: inline-block; background: #dcfce7; color: #15803d;
                             padding: 2px 10px; border-radius: 12px; font-weight: bold; font-size: 0.85em; }
                .avail-no  { display: inline-block; background: #fee2e2; color: #b91c1c;
                             padding: 2px 10px; border-radius: 12px; font-weight: bold; font-size: 0.85em; }
                .id { font-family: monospace; font-size: 0.82em; color: #9ca3af; }
                footer { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>🏟️ Facility Availability</h1>
                <p>All club facilities and their current status</p>
            </header>
            <main>
                <!-- Summary stats boxes -->
                <div class="stats">
                    <div class="stat-box">
                        <div class="num total-num">
                            <xsl:value-of select="count(//Facilities/Facility)"/>
                        </div>
                        <div class="desc">Total Facilities</div>
                    </div>
                    <div class="stat-box">
                        <div class="num available-num">
                            <!-- Count facilities where Available = true -->
                            <xsl:value-of select="count(//Facilities/Facility[Available='true'])"/>
                        </div>
                        <div class="desc">Available</div>
                    </div>
                    <div class="stat-box">
                        <div class="num unavailable-num">
                            <!-- Count facilities where Available = false -->
                            <xsl:value-of select="count(//Facilities/Facility[Available='false'])"/>
                        </div>
                        <div class="desc">Unavailable</div>
                    </div>
                    <div class="stat-box">
                        <div class="num total-num">
                            <!-- Sum all capacities -->
                            <xsl:value-of select="sum(//Facilities/Facility/Capacity)"/>
                        </div>
                        <div class="desc">Total Capacity</div>
                    </div>
                </div>

                <!-- Facilities table -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Capacity</th>
                            <th>Status</th>
                            <th>Equipment Stored</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//Facilities/Facility">
                            <xsl:sort select="Name"/>
                            <tr>
                                <td class="id"><xsl:value-of select="@facilityID"/></td>
                                <td><strong><xsl:value-of select="Name"/></strong></td>
                                <td><xsl:value-of select="Type"/></td>
                                <td><xsl:value-of select="Location"/></td>
                                <td><xsl:value-of select="Capacity"/></td>
                                <td>
                                    <!-- Show availability badge based on boolean value -->
                                    <xsl:choose>
                                        <xsl:when test="Available='true'">
                                            <span class="avail-yes">✔ Available</span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="avail-no">✖ Unavailable</span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td>
                                    <!-- Cross-reference Equipment to list items stored here -->
                                    <xsl:variable name="fid" select="@facilityID"/>
                                    <xsl:for-each select="//Equipment/Item[FacilityRef=$fid]">
                                        <xsl:value-of select="Name"/>
                                        <xsl:if test="position() != last()">, </xsl:if>
                                    </xsl:for-each>
                                    <xsl:if test="not(//Equipment/Item[FacilityRef=@facilityID])">—</xsl:if>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </main>
            <footer>Sports Club Database Platform — A25 Data Pipeline 1</footer>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
