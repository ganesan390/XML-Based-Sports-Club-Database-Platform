<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_3.xsl
    PURPOSE: Transform SportsClub XML → Team Overview HTML
    OUTPUT: teams.html
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
            <title>Team Overview — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #7c3aed; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; opacity: 0.85; }
                main { padding: 30px 40px; }
                .team-card { background: white; border-radius: 8px; margin-bottom: 24px;
                             box-shadow: 0 2px 8px rgba(0,0,0,0.09); overflow: hidden; }
                .team-header { background: #7c3aed; color: white; padding: 14px 20px;
                               display: flex; justify-content: space-between; align-items: center; }
                .team-header h2 { margin: 0; font-size: 1.1em; }
                .team-meta { padding: 16px 20px; display: grid;
                             grid-template-columns: 1fr 1fr 1fr; gap: 12px; }
                .meta-item .label { font-size: 0.78em; color: #6b7280; font-weight: bold;
                                    text-transform: uppercase; letter-spacing: 0.05em; }
                .meta-item .val   { font-size: 0.95em; color: #111; margin-top: 2px; }
                .members-section { padding: 0 20px 16px; }
                .members-section h3 { font-size: 0.85em; color: #7c3aed; margin: 0 0 8px;
                                      text-transform: uppercase; letter-spacing: 0.06em; }
                .member-chip { display: inline-block; background: #ede9fe; color: #5b21b6;
                               border-radius: 20px; padding: 3px 12px; font-size: 0.84em;
                               margin: 3px 4px 3px 0; }
                .level-badge { font-size: 0.78em; padding: 3px 10px; border-radius: 12px;
                               background: rgba(255,255,255,0.25); }
                .id { font-family: monospace; font-size: 0.8em; color: #d8b4fe; }
                footer { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>🏆 Team Overview</h1>
                <p>Total teams: <xsl:value-of select="count(//Teams/Team)"/></p>
            </header>
            <main>
                <xsl:for-each select="//Teams/Team">
                    <xsl:sort select="Name"/>
                    <div class="team-card">
                        <!-- Team header bar -->
                        <div class="team-header">
                            <h2><xsl:value-of select="Name"/></h2>
                            <span class="level-badge"><xsl:value-of select="Level"/></span>
                        </div>
                        <!-- Team metadata grid -->
                        <div class="team-meta">
                            <div class="meta-item">
                                <div class="label">Sport</div>
                                <div class="val"><xsl:value-of select="Sport"/></div>
                            </div>
                            <div class="meta-item">
                                <div class="label">Coach</div>
                                <!-- Resolve CoachRef to coach name -->
                                <div class="val">
                                    <xsl:variable name="cid" select="CoachRef"/>
                                    <xsl:value-of select="//Coaches/Coach[@coachID=$cid]/Name"/>
                                </div>
                            </div>
                            <div class="meta-item">
                                <div class="label">Team ID</div>
                                <div class="val id"><xsl:value-of select="@teamID"/></div>
                            </div>
                        </div>
                        <!-- Member roster chips -->
                        <div class="members-section">
                            <h3>Roster (<xsl:value-of select="count(Members/MemberRef)"/> members)</h3>
                            <xsl:for-each select="Members/MemberRef">
                                <!-- Resolve each MemberRef to the member's name -->
                                <xsl:variable name="mid" select="."/>
                                <span class="member-chip">
                                    <xsl:value-of select="//Members/Member[@memberID=$mid]/Name"/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </div>
                </xsl:for-each>
            </main>
            <footer>Sports Club Database Platform — A25 Data Pipeline 1</footer>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
