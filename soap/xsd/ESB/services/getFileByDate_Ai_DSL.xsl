<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://soa.spw.wallonie.be/services/handiDSL/messages/v1" xmlns:v2="https://spw.selbstbestimmt.be/Services/HandiserviceV2" xmlns:com="http://soa.spw.wallonie.be/data/common/common/v3" xmlns:id="http://soa.spw.wallonie.be/common/identification/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="operationNode" select="/*[local-name()='Envelope']/*[local-name()='Body']/*"/>
	<xsl:variable name="operation" select="concat('tns:',local-name($operationNode))"/>
	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="v2:ConsultFilesBydate">
					<xsl:element name="v2:request">
						<xsl:element name="id:customerInformations">
							<xsl:element name="id:ticket">
								<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='ticket']"/>
							</xsl:element>
							<xsl:element name="id:timestampSent">
								<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='timestampSent']"/>
							</xsl:element>
							<xsl:element name="id:customerIdentification">
								<xsl:if test="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='organisationId']">
									<xsl:element name="id:organisationId">
										<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='organisationId']"/>
									</xsl:element>
								</xsl:if>
								<xsl:if test="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationId']">
									<xsl:element name="id:applicationId">
										<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationId']"/>
									</xsl:element>
								</xsl:if>
								<xsl:if test="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationName']">
									<xsl:element name="id:applicationName">
										<xsl:value-of select="$operationNode/*[local-name()='customerInformations']/*[local-name()='customerIdentification']/*[local-name()='applicationName']"/>
									</xsl:element>
								</xsl:if>
							</xsl:element>
						</xsl:element>
						<xsl:element name="com:context">
							<xsl:value-of select="$operationNode/*[local-name()='context']"/>
						</xsl:element>
						<xsl:element name="tns:request">
							<xsl:element name="informationCustomer">
								<xsl:element name="customerIdentification">
									<xsl:element name="cbeNumber">0316381138</xsl:element>									
								</xsl:element>
							</xsl:element>
							<xsl:element name="criteria">						
								<xsl:element name="ssin"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='ssin']"/></xsl:element>
								<xsl:element name="referenceDate"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='referenceDate']"/></xsl:element>
								<xsl:element name="parts">
									<xsl:element name="evolutionOfRequest"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='parts']/*[local-name()='evolutionOfRequest']"/></xsl:element>
									<xsl:element name="handicapRecognitions"><xsl:value-of select="$operationNode/*[local-name()='request']/*[local-name()='parts']/*[local-name()='handicapRecognitions']"/></xsl:element>
								</xsl:element>		
							</xsl:element>						
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
</xsl:stylesheet>