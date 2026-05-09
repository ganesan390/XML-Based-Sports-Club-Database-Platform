<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_5.xsl
    PURPOSE: Transform SportsClub XML → Competition Results HTML
    OUTPUT: competitions.html
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
            <title>Competition Results — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #991b1b; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; opacity: 0.85; }
                main { padding: 30px 40px; }
                table { width: 100%; border-collapse: collapse; background: white;
                        box-shadow: 0 2px 6px rgba(0,0,0,0.08); border-radius: 6px;
                        overflow: hidden; }
                th { background: #991b1b; color: white; padding: 12px 16px;
                     text-align: left; font-size: 0.9em; }
                td { padding: 12px 16px; border-bottom: 1px solid #e8ecf0; font-size: 0.92em; }
                tr:last-child td { border-bottom: none; }
                tr:hover td { background: #fff1f2; }
                .result { font-weight: bold; }
                .r-gold   { color: #b45309; }
                .r-silver { color: #64748b; }
                .r-other  { color: #374151; }
                .sport-tag { display: inline-block; background: #fee2e2; color: #991b1b;
                             padding: 2px 9px; border-radius: 12px; font-size: 0.82em; }
                .id { font-family: monospace; font-size: 0.82em; color: #9ca3af; }
                footer { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>🥇 Competition Results</h1>
                <p>Total competitions: <xsl:value-of select="count(//Competitions/Competition)"/></p>
            </header>
            <main>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Competition</th>
                            <th>Sport</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Team</th>
                            <th>Result</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sort by Date, earliest first -->
                        <xsl:for-each select="//Competitions/Competition">
                            <xsl:sort select="Date"/>
                            <tr>
                                <td class="id"><xsl:value-of select="@competitionID"/></td>
                                <td><strong><xsl:value-of select="Name"/></strong></td>
                                <td>
                                    <span class="sport-tag"><xsl:value-of select="Sport"/></span>
                                </td>
                                <td><xsl:value-of select="Date"/></td>
                                <td><xsl:value-of select="Location"/></td>
                                <td>
                                    <!-- Resolve TeamRef to team name -->
                                    <xsl:variable name="tid" select="TeamRef"/>
                                    <xsl:value-of select="//Teams/Team[@teamID=$tid]/Name"/>
                                </td>
                                <td>
                                    <!-- Colour-code result: gold for 1st, silver for Runner-Up, grey otherwise -->
                                    <xsl:choose>
                                        <xsl:when test="Result='1st Place'">
                                            <span class="result r-gold">🥇 <xsl:value-of select="Result"/></span>
                                        </xsl:when>
                                        <xsl:when test="Result='Runner Up' or Result='2nd Place'">
                                            <span class="result r-silver">🥈 <xsl:value-of select="Result"/></span>
                                        </xsl:when>
                                        <xsl:when test="Result='3rd Place'">
                                            <span class="result r-other">🥉 <xsl:value-of select="Result"/></span>
                                        </xsl:when>
                                        <xsl:when test="Result">
                                            <span class="result r-other"><xsl:value-of select="Result"/></span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <!-- Result is optional per XSD (minOccurs=0) -->
                                            <span style="color:#9ca3af">TBD</span>
                                        </xsl:otherwise>
                                    </xsl:choose>
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
