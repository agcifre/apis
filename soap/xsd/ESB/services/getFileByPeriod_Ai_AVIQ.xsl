<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="https://www.aviq.be" xmlns:com="http://soa.spw.wallonie.be/data/common/common/v3" xmlns:id="http://soa.spw.wallonie.be/common/identification/v1" xmlns:msg="http://soa.spw.wallonie.be/services/handiAVIQ/messages/v1" xmlns:av="http://kszbcss.fgov.be/types/Handi/aviq/v1" xmlns:v3="http://kszbcss.fgov.be/types/common/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="operationNode" select="/*[local-name()='Envelope']/*[local-name()='Body']/*"/>
	<xsl:variable name="operation" select="concat('tns:',local-name($operationNode))"/>
	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="tns:consultFilesByPeriod">
					<xsl:element name="tns:consultFilesByPeriodRequest">
						<xsl:element name="com:customerInformations">
							<xsl:element name="id:ticket">
								<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='ticket']"/>
							</xsl:element>
							<xsl:element name="id:timestampSent">
								<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='timestampSent']"/>
							</xsl:element>
							<xsl:element name="id:customerIdentification">
								<xsl:element name="id:organisationId">
									<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='organisationId']"/>
								</xsl:element>
								<xsl:element name="id:applicationId">
									<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationId']"/>
								</xsl:element>
								<xsl:element name="id:applicationName">
									<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationName']"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<xsl:element name="com:context">
							<xsl:value-of select="$operationNode/*[local-name()='context']"/>
						</xsl:element>
						<xsl:element name="msg:request">
							<xsl:element name="av:ssin"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='ssin']"/></xsl:element>
							<xsl:element name="av:period">							
								<xsl:element name="v3:beginDate"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='period']/*[local-name()='beginDate']"/>T00:00:00</xsl:element>
								<xsl:element name="v3:endDate"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='period']/*[local-name()='endDate']"/>T00:00:00</xsl:element>
							</xsl:element>
							<xsl:element name="av:parts">
								<xsl:element name="av:evolutionOfRequest"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='parts']/*[local-name()='evolutionOfRequest']"/></xsl:element>
								<xsl:element name="av:handicapRecognitions"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='parts']/*[local-name()='handicapRecognitions']"/></xsl:element>
							</xsl:element>						
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
</xsl:stylesheet>

