<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<!--Add data -->
	<xsl:template match="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='getDeclarationStatusById']">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://ws.vehsigna.DGO7.wallonie.be/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<soapenv:Body>
				<tns:getDeclarationStatusById>
					<callContext>
						<applicationName><xsl:value-of select="//SPW/VEHSIGNA/APPNAME"/></applicationName>
						<applicantIdentifier><xsl:value-of select="//SPW/VEHSIGNA/APPID"/></applicantIdentifier>
						<ticket><xsl:value-of select="*[local-name()='customerInformations']/*[local-name()='ticket']/text()"/></ticket>
						<context><xsl:value-of select="//SPW/VEHSIGNA/CONTEXT"/></context>
						<folderId><xsl:value-of select="*[local-name()='privacyLog']/*[local-name()='dossier']/*[local-name()='dossierId']/text()"/></folderId>
						<language>FR</language>
						<timestampSent><xsl:value-of select="*[local-name()='customerInformations']/*[local-name()='timestampSent']/text()"/></timestampSent>
					</callContext>
					<request>
						<xsl:if test="*[local-name()='request']/*[local-name()='plateNumber']">
							<plateNumber><xsl:value-of select="*[local-name()='request']/*[local-name()='plateNumber']/text()"/></plateNumber>
						</xsl:if>
						<xsl:if test="*[local-name()='request']/*[local-name()='vin']">
							<vin><xsl:value-of select="*[local-name()='request']/*[local-name()='vin']/text()"/></vin>
						</xsl:if>
						<xsl:if test="*[local-name()='request']/*[local-name()='unifier']">
							<unifier><xsl:value-of select="*[local-name()='request']/*[local-name()='unifier']/text()"/></unifier>
						</xsl:if>
					</request>
				</tns:getDeclarationStatusById>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	<!--Remove customerInformations-->
	<xsl:template match="//*[local-name()='customerInformations']"/>
	<!--Remove context-->
	<xsl:template match="//*[local-name()='context']"/>
	<!--Remove result-->
	<xsl:template match="//*[local-name()='result']"/>	
</xsl:stylesheet>