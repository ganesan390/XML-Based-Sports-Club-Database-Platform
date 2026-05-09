<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_1.xsl
    PURPOSE: Transform SportsClub XML → Member Directory HTML
    OUTPUT: members.html
    MEMBER: Member 2 — HTML Visualisation Developer
    ============================================
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Output as HTML with UTF-8 encoding -->
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- ===========================
         ROOT TEMPLATE
         =========================== -->
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Member Directory — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #1a3c6e; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; font-size: 0.95em; opacity: 0.85; }
                main { padding: 30px 40px; }
                table { width: 100%; border-collapse: collapse; background: white;
                        box-shadow: 0 2px 6px rgba(0,0,0,0.08); border-radius: 6px;
                        overflow: hidden; }
                th { background: #1a3c6e; color: white; padding: 12px 16px;
                     text-align: left; font-size: 0.9em; letter-spacing: 0.04em; }
                td { padding: 11px 16px; border-bottom: 1px solid #e8ecf0; font-size: 0.92em; }
                tr:last-child td { border-bottom: none; }
                tr:hover td { background: #f0f4fa; }
                .badge { display: inline-block; padding: 2px 8px; border-radius: 12px;
                         font-size: 0.8em; font-weight: bold; }
                .male   { background: #dbeafe; color: #1e40af; }
                .female { background: #fce7f3; color: #9d174d; }
                .other  { background: #e0e7ff; color: #3730a3; }
                .id     { color: #6b7280; font-size: 0.85em; font-family: monospace; }
                footer  { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>🏅 Sports Club — Member Directory</h1>
                <p>Total members: <xsl:value-of select="count(//Members/Member)"/></p>
            </header>
            <main>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Join Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Iterate over every Member element -->
                        <xsl:for-each select="//Members/Member">
                            <!-- Sort alphabetically by Name -->
                            <xsl:sort select="Name"/>
                            <tr>
                                <td class="id"><xsl:value-of select="@memberID"/></td>
                                <td><strong><xsl:value-of select="Name"/></strong></td>
                                <td><xsl:value-of select="Age"/></td>
                                <td>
                                    <!-- Apply badge colour based on gender value -->
                                    <xsl:choose>
                                        <xsl:when test="Gender='Male'">
                                            <span class="badge male">Male</span>
                                        </xsl:when>
                                        <xsl:when test="Gender='Female'">
                                            <span class="badge female">Female</span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="badge other"><xsl:value-of select="Gender"/></span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td><xsl:value-of select="Email"/></td>
                                <td><xsl:value-of select="Phone"/></td>
                                <!-- Address is optional (minOccurs=0 in XSD) -->
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="Address">
                                            <xsl:value-of select="Address"/>
                                        </xsl:when>
                                        <xsl:otherwise>—</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td><xsl:value-of select="JoinDate"/></td>
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
