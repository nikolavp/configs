<!-- 

This XSLT is used to translate an XML response from the www.google.com/ig/
 XML API. 

 You can format this file to your liking. Two things you may feel 
 like doing:

	1) Modify the layout of the fields or static text already defined
	2) Add other fields from the XML response file that aren't referenced in this
	   XSLT. You can grab a full list by just doing a: 
       wget "http://www.google.com/ig/api?weather=$LOCID" 
       (change $LOCID to <CITY>,<COUNTRY> to get weather info for that location)
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" > 
	<xsl:output method="text" disable-output-escaping="yes"/>
    <xsl:template match="xml_api_reply">
		<xsl:apply-templates select="weather"/>
	</xsl:template>
 
	
    <xsl:template match="weather">
        <xsl:variable name="new-line"><xsl:text>&#10;</xsl:text></xsl:variable>
        <xsl:text>  Location: </xsl:text><xsl:value-of select="forecast_information/postal_code/@data"/> 
        <xsl:value-of select="$new-line" />
        <xsl:text>  Temperature: </xsl:text><xsl:value-of select="tmp"/><xsl:value-of select="current_conditions/temp_c/@data"/>
        <xsl:text> C</xsl:text>
        <xsl:value-of select="$new-line" />
        <xsl:text>  Conditions: </xsl:text><xsl:value-of select="current_conditions/condition/@data"/>
        <xsl:value-of select="$new-line" />
        <xsl:text>  </xsl:text><xsl:value-of select="current_conditions/humidity/@data" />
        <xsl:value-of select="$new-line" />
        <xsl:text>  </xsl:text><xsl:value-of select="current_conditions/wind_condition/@data" />
        <xsl:value-of select="$new-line" />
    </xsl:template>
</xsl:stylesheet>
