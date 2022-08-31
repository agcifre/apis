<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:tns="http://ws.vehsigna.DGO7.wallonie.be/" exclude-result-prefixes="tns fo xsi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='getDeclarationStatusByIdResponse']">
	<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cod="http://soa.spw.wallonie.be/data/common/code/v1" xmlns:err="http://soa.spw.wallonie.be/data/common/error/v1" xmlns:common="http://soa.spw.wallonie.be/data/common/common/v1" xmlns:bus="http://soa.spw.wallonie.be/data/business/vehicleDGO7/v1" xmlns:veh="http://soa.spw.wallonie.be/services/vehicleDGO7/messages/v1" >
			<soapenv:Body>
				<veh:getDeclarationStatusByIdResponse >
					<common:status>
						<common:value>
							<xsl:value-of select="*[local-name()='status']/*[local-name()='value']/text()"/>
						</common:value>
						<common:code>
							<xsl:value-of select="*[local-name()='status']/*[local-name()='code']/text()"/>
						</common:code>
						<xsl:for-each select="*[local-name()='status']/*[local-name()='description']">
							<common:description>
								<xsl:attribute name="lang"><xsl:value-of select="*[local-name()='status']/*[local-name()='description']/@lang"/></xsl:attribute>
								<xsl:value-of select="."/>
							</common:description>
						</xsl:for-each>
						<xsl:if test="*[local-name()='status']/*[local-name()='details']">
							<common:details>
								<xsl:if test="*[local-name()='status']/*[local-name()='details']/*[local-name()='informations']">
									<common:informations>
										<xsl:for-each select="*[local-name()='status']/*[local-name()='details']/*[local-name()='informations']/*[local-name()='information']">
											<common:information>
												<common:informationField>
													<xsl:value-of select="*[local-name()='informationField']/text()"/>
												</common:informationField>
												<common:informationValue>
													<xsl:value-of select="*[local-name()='informationValue']/text()"/>
												</common:informationValue>
											</common:information>
										</xsl:for-each>
									</common:informations>
								</xsl:if>
								<xsl:if test="*[local-name()='status']/*[local-name()='details']/*[local-name()='warning']">
									<err:warning>
										<err:code codeSource="SPW:1591">
											<cod:code>
												<xsl:value-of select="*[local-name()='status']/*[local-name()='details']/*[local-name()='warning']/*[local-name()='code']/text()"/>
											</cod:code>
											<xsl:for-each select="*[local-name()='status']/*[local-name()='details']/*[local-name()='warning']/*[local-name()='description']/text()">
												<cod:description>
													<xsl:value-of select="."/>
												</cod:description>
											</xsl:for-each>
										</err:code>
									</err:warning>
								</xsl:if>
								<xsl:if test="*[local-name()='status']/*[local-name()='details']/*[local-name()='error']">
									<err:error>
										<err:code>
											<cod:code codeSource="SPW:1591">
												<xsl:value-of select="*[local-name()='status']/*[local-name()='details']/*[local-name()='error']/*[local-name()='code']/text()"/>
											</cod:code>
											<xsl:for-each select="*[local-name()='status']/*[local-name()='details']/*[local-name()='error']/*[local-name()='description']/text()">
												<cod:description>
													<xsl:value-of select="."/>
												</cod:description>
											</xsl:for-each>
										</err:code>
									</err:error>
								</xsl:if>
							</common:details>
						</xsl:if>
					</common:status>
					<veh:declaration>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='declarationStatus']">
							<bus:declarationStatus>
								<xsl:value-of select="*[local-name()='declaration']/*[local-name()='declarationStatus']/text()"/>
							</bus:declarationStatus>
						</xsl:if>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='declarationDate']">
							<bus:declarationDate>
								<xsl:value-of select="*[local-name()='declaration']/*[local-name()='declarationDate']/text()"/>
							</bus:declarationDate>
						</xsl:if>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='revocationDate']">
							<bus:revocationDate>
								<xsl:value-of select="*[local-name()='declaration']/*[local-name()='revocationDate']/text()"/>
							</bus:revocationDate>
						</xsl:if>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='declarer']">
							<bus:declarer>
								<bus:type>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='declarer']/*[local-name()='type']/text()"/>
								</bus:type>
								<bus:identifier>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='declarer']/*[local-name()='identifier']/text()"/>
								</bus:identifier>
							</bus:declarer>
						</xsl:if>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='revoker']">
							<bus:revoker>
								<bus:type>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='revoker']/*[local-name()='type']/text()"/>
								</bus:type>
								<bus:identifier>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='revoker']/*[local-name()='identifier']/text()"/>
								</bus:identifier>
							</bus:revoker>
						</xsl:if>
						<xsl:if test="*[local-name()='declaration']/*[local-name()='user']">
							<bus:user>
								<bus:type>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='user']/*[local-name()='type']/text()"/>
								</bus:type>
								<bus:identifier>
									<xsl:value-of select="*[local-name()='declaration']/*[local-name()='user']/*[local-name()='identifier']/text()"/>
								</bus:identifier>
							</bus:user>
						</xsl:if>
					</veh:declaration>
				</veh:getDeclarationStatusByIdResponse>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
</xsl:stylesheet>