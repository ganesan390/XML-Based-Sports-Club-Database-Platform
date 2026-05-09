<?xml version="1.0" encoding="UTF-8"?>
<!--
    ============================================
    FILE: stylesheet_6.xsl
    PURPOSE: Transform SportsClub XML → Membership Report HTML
    OUTPUT: memberships.html
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
            <title>Membership Report — Sports Club</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 0; background: #f4f6f9; color: #333; }
                header { background: #0f4c81; color: white; padding: 20px 40px; }
                header h1 { margin: 0; font-size: 1.8em; }
                header p  { margin: 4px 0 0; opacity: 0.85; }
                main { padding: 30px 40px; }
                .summary { display: flex; gap: 16px; margin-bottom: 28px; flex-wrap: wrap; }
                .summary-card { background: white; border-radius: 8px; padding: 14px 20px;
                                box-shadow: 0 2px 6px rgba(0,0,0,0.08); flex: 1; min-width: 120px; }
                .summary-card .cat   { font-size: 0.8em; color: #6b7280; text-transform: uppercase;
                                       letter-spacing: 0.05em; font-weight: bold; }
                .summary-card .count { font-size: 1.8em; font-weight: bold; color: #0f4c81; }
                .summary-card .fee   { font-size: 0.82em; color: #059669; margin-top: 2px; }
                table { width: 100%; border-collapse: collapse; background: white;
                        box-shadow: 0 2px 6px rgba(0,0,0,0.08); border-radius: 6px;
                        overflow: hidden; }
                th { background: #0f4c81; color: white; padding: 12px 16px;
                     text-align: left; font-size: 0.9em; }
                td { padding: 11px 16px; border-bottom: 1px solid #e8ecf0; font-size: 0.92em; }
                tr:last-child td { border-bottom: none; }
                tr:hover td { background: #f0f7ff; }
                .cat-basic   { background: #e0f2fe; color: #0369a1; }
                .cat-premium { background: #fef3c7; color: #92400e; }
                .cat-vip     { background: #f3e8ff; color: #7e22ce; }
                .cat-student { background: #dcfce7; color: #166534; }
                .cat-badge   { display: inline-block; padding: 2px 10px; border-radius: 12px;
                               font-size: 0.82em; font-weight: bold; }
                .fee-cell    { font-weight: bold; color: #059669; }
                .id          { font-family: monospace; font-size: 0.82em; color: #9ca3af; }
                tfoot td     { background: #f8fafc; font-weight: bold; border-top: 2px solid #0f4c81; }
                footer { text-align: center; padding: 20px; font-size: 0.82em; color: #9ca3af; }
            </style>
        </head>
        <body>
            <header>
                <h1>💳 Membership Report</h1>
                <p>Total memberships: <xsl:value-of select="count(//Memberships/Membership)"/></p>
            </header>
            <main>
                <!-- Summary by category -->
                <div class="summary">
                    <div class="summary-card">
                        <div class="cat">Basic</div>
                        <div class="count">
                            <xsl:value-of select="count(//Memberships/Membership[Category='Basic'])"/>
                        </div>
                        <div class="fee">
                            €<xsl:value-of select="sum(//Memberships/Membership[Category='Basic']/Fee)"/>
                        </div>
                    </div>
                    <div class="summary-card">
                        <div class="cat">Premium</div>
                        <div class="count">
                            <xsl:value-of select="count(//Memberships/Membership[Category='Premium'])"/>
                        </div>
                        <div class="fee">
                            €<xsl:value-of select="sum(//Memberships/Membership[Category='Premium']/Fee)"/>
                        </div>
                    </div>
                    <div class="summary-card">
                        <div class="cat">VIP</div>
                        <div class="count">
                            <xsl:value-of select="count(//Memberships/Membership[Category='VIP'])"/>
                        </div>
                        <div class="fee">
                            €<xsl:value-of select="sum(//Memberships/Membership[Category='VIP']/Fee)"/>
                        </div>
                    </div>
                    <div class="summary-card">
                        <div class="cat">Student</div>
                        <div class="count">
                            <xsl:value-of select="count(//Memberships/Membership[Category='Student'])"/>
                        </div>
                        <div class="fee">
                            €<xsl:value-of select="sum(//Memberships/Membership[Category='Student']/Fee)"/>
                        </div>
                    </div>
                </div>

                <!-- Full membership table -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Member</th>
                            <th>Category</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Fee (€)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sort by Category then Member name -->
                        <xsl:for-each select="//Memberships/Membership">
                            <xsl:sort select="Category"/>
                            <tr>
                                <td class="id"><xsl:value-of select="@membershipID"/></td>
                                <td>
                                    <!-- Resolve MemberRef to member name -->
                                    <xsl:variable name="mid" select="MemberRef"/>
                                    <strong>
                                        <xsl:value-of select="//Members/Member[@memberID=$mid]/Name"/>
                                    </strong>
                                    <span class="id"> (<xsl:value-of select="MemberRef"/>)</span>
                                </td>
                                <td>
                                    <!-- Category badge with colour per type -->
                                    <xsl:choose>
                                        <xsl:when test="Category='Basic'">
                                            <span class="cat-badge cat-basic">Basic</span>
                                        </xsl:when>
                                        <xsl:when test="Category='Premium'">
                                            <span class="cat-badge cat-premium">Premium</span>
                                        </xsl:when>
                                        <xsl:when test="Category='VIP'">
                                            <span class="cat-badge cat-vip">⭐ VIP</span>
                                        </xsl:when>
                                        <xsl:when test="Category='Student'">
                                            <span class="cat-badge cat-student">Student</span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="Category"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td><xsl:value-of select="StartDate"/></td>
                                <td><xsl:value-of select="EndDate"/></td>
                                <td class="fee-cell">€<xsl:value-of select="Fee"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                    <!-- Total revenue row in footer -->
                    <tfoot>
                        <tr>
                            <td colspan="5">Total Revenue</td>
                            <td class="fee-cell">€<xsl:value-of select="sum(//Memberships/Membership/Fee)"/></td>
                        </tr>
                    </tfoot>
                </table>
            </main>
            <footer>Sports Club Database Platform — A25 Data Pipeline 1</footer>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
