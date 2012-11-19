<!-- code adapted from thread found here: http://www.sitepoint.com/forums/showthread.php?534249-Pagination-with-XSL -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    
    <!-- these two parameters would be changed in server side code to go from page to page -->
    <xsl:param name="Page" select="0" />
    <xsl:param name="PageSize" select="20" />
    
   
    <xsl:template match="/" >
        
        <xsl:variable name="mycount" select="count(//var)"/>
        <xsl:variable name="selectedRowCount" select="round($mycount div $PageSize)"/>
        <p><xsl:value-of select="$mycount"/> records found.</p>
        <table>       
            <tr><th>Name</th><th>Short Desc</th><th>Codebook</th></tr>
            
        <xsl:for-each select="//var" >
            
            <xsl:if test="position() &gt;= ($Page * $PageSize) + 1">
                <xsl:if test="position() &lt;= $PageSize + ($PageSize * $Page)">                
                    <tr>
                        <td><xsl:value-of select='@name'></xsl:value-of></td>
                        <td><xsl:value-of select='labl'></xsl:value-of></td>
                        <td><xsl:value-of select='../../docDscr/citation/titlStmt/titl'></xsl:value-of></td> 
                    </tr>  
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        </table>
        <!-- Prev link for pagination -->
        <xsl:choose>
            <xsl:when test="number($Page)-1 &gt;= 0">
                <A>
                    <xsl:attribute name="onclick">query('<xsl:value-of select="number($Page)-1"/>') </xsl:attribute>  &lt;&lt;Prev
                </A>
            </xsl:when>
            <xsl:otherwise>
                <!-- display something else -->
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$selectedRowCount &gt; 1">
            <b class="blacktext">
                <xsl:value-of select="number($Page)+1"/> of <xsl:value-of select="number($selectedRowCount)"/>
            </b> 
        </xsl:if>
        <!-- Next link for pagination -->
        <xsl:choose>
            <xsl:when test="number($Page)+1 &lt; number($selectedRowCount)">
                <A>
                    <xsl:attribute name="onclick">query('<xsl:value-of select="number($Page)+1"/>')</xsl:attribute>  Next&gt;&gt;
                </A>
            </xsl:when>
            <xsl:otherwise>
                <!-- display something else -->
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
</xsl:stylesheet>