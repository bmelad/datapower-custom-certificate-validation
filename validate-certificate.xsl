<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:dpconfig="http://www.datapower.com/param/config"
	xmlns:mgmt="http://www.datapower.com/schemas/management"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:regexp="http://exslt.org/regular-expressions"
	exclude-result-prefixes="dp dpconfig regexp date mgmt"
	extension-element-prefixes="dp"
	version="2.0">

    <xsl:param name="dpconfig:HttpHeaderName"/>
	<dp:param name="dpconfig:HttpHeaderName" type="dmString" xmlns="">
		<display>HTTP Header Name</display>
		<default>crt</default>
		<description>The name of the HTTP header which should contain the base64 value of the certificate for validation.</description>
	</dp:param>

    <xsl:param name="dpconfig:ValidationCredentialsObjectName"/>
	<dp:param name="dpconfig:ValidationCredentialsObjectName" type="dmString" xmlns="">
		<display>Crypto Validation Credentials Object Name</display>
		<default></default>
		<description>The name of an existing Crypto Validation Credentials object for the certificate validation.</description>
	</dp:param>

	<xsl:template match="/">
	    <xsl:variable name="base64certificate" select="dp:http-request-header($dpconfig:HttpHeaderName)"/>
	    <xsl:message dp:priority="debug">Certificate Details: <xsl:copy-of select="dp:get-cert-details(concat('cert:',$base64certificate))"/></xsl:message>
        <xsl:variable name="input"><input><subject>cert: <xsl:value-of select="$base64certificate" /></subject></input></xsl:variable>
        <xsl:variable name="validationResult"><xsl:copy-of select="dp:validate-certificate($input,$dpconfig:ValidationCredentialsObjectName)"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$validationResult/error"><dp:reject><errorMsg>Unauthorized</errorMsg></dp:reject></xsl:when>
            <xsl:otherwise><xsl:message dp:priority="debug">Certificate was validated successfully.</xsl:message></xsl:otherwise>
        </xsl:choose>
	</xsl:template>
</xsl:stylesheet>
