<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:han="http://soa.spw.wallonie.be/services/handiDSL/messages/v1" xmlns:cod="http://soa.spw.wallonie.be/data/common/code/v4" xmlns:err="http://soa.spw.wallonie.be/data/common/error/v4" xmlns:resp="http://soa.spw.wallonie.be/data/common/response/v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="status" select="//*[local-name()='status']"/>
	<xsl:variable name="ConsultFilesByPeriodResponse" select="//*[local-name()='ConsultFilesByPeriodResponse']"/>
	<xsl:variable name="fileByPeriod" select="$ConsultFilesByPeriodResponse/*[local-name()='ConsultFilesByPeriodResult']/*[local-name()='fileByPeriod']"/>
	<xsl:attribute-set name="langFR">
	<xsl:attribute name="lang">fr</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="langEN">
		<xsl:attribute name="lang">en</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="languageFR">
		<xsl:attribute name="language">fr</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="languageEN">
		<xsl:attribute name="language">en</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template match="/">
		<soapenv:Envelope>
			<soapenv:Body>
				<han:getFileByPeriodResponse>
					<xsl:attribute name="customerTicket"><xsl:value-of select="//*[local-name()='ConsultFilesByPeriodResult']/@*[local-name()='customerTicket']"/></xsl:attribute>
					<xsl:attribute name="requestId"><xsl:value-of select="//*[local-name()='ConsultFilesByPeriodResult']/@*[local-name()='requestId']"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="//soapenv:Fault">
							<xsl:call-template name="technicalFaultMapper"/>
						</xsl:when>
						<xsl:when test="$status/*[local-name()='value']">
							<xsl:call-template name="tmpStatus"/>
							<xsl:if test="($status/*[local-name()='value']='NO_DATA_FOUND')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="($status/*[local-name()='value']='NO_RESULT')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="($status/*[local-name()='value']='INCOMPLETE_DATA')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="(($status/*[local-name()='value']!='NO_RESULT' and $status/*[local-name()='value']!='NO_DATA_FOUND') or $status/*[local-name()='value']='INCOMPLETE_DATA')">
								<xsl:element name="han:fileByPeriod">
									<xsl:copy-of select="$fileByPeriod/*" copy-namespaces="no"/>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<resp:status>ERROR</resp:status>
							<err:error>
								<err:category>140</err:category>
								<err:code origin="BCED">
									<cod:code>00001</cod:code>
									<xsl:element name="cod:description" use-attribute-sets="languageEN">Service provider has generated an error</xsl:element>
									<xsl:element name="cod:description" use-attribute-sets="languageFR">Le fournisseur de service a généré une erreur</xsl:element>
								</err:code>
							</err:error>
						</xsl:otherwise>
					</xsl:choose>
				</han:getFileByPeriodResponse>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	<!--  tmpStatus -->
	<xsl:template name="tmpStatus">
		<xsl:element name="resp:status">
			<xsl:choose>
				<xsl:when test="($status/*[local-name()='value']='NO_DATA_FOUND') or ($status/*[local-name()='value']='DATA_FOUND') or ($status/*[local-name()='value']='SUCCESS')">PROCESSED</xsl:when>
				<xsl:otherwise>ERROR</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!--  return message -->
	<xsl:template name="tmpErrorOrWarning">
		<xsl:choose>
			<xsl:when test="($status/*[local-name()='value']='INCOMPLETE_DATA')">
				<xsl:element name="err:warning">
					<xsl:element name="err:category">100</xsl:element>
					<xsl:element name="err:code">
						<xsl:element name="cod:code">00003</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Réponse partielle</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">Partial response</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="($status/*[local-name()='value']='NO_DATA_FOUND')">
				<xsl:element name="err:warning">
					<xsl:element name="err:category">100</xsl:element>
					<xsl:element name="err:code">
						<xsl:element name="cod:code">00001</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Aucune donnée trouvée</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">No data found</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="($status/*[local-name()='value']='NO_RESULT')">
				<xsl:element name="err:error">
					<xsl:element name="err:category">600</xsl:element>
					<xsl:element name="err:code">
						<xsl:element name="cod:code">00001</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">La requête contient des données invalides</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">The request contains invalid data</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="technicalFaultMapper">
		<resp:status>ERROR</resp:status>
		<err:error>
			<xsl:choose>
				<!-- Provider response is not SOAP (e.g. html, when it is unavailable) -->
				<!-- Provider response is not compliant with its contract -->
				<xsl:when test="not(//*[local-name()='status']) and (not(//*[local-name()='faultcode']) or contains(//faultcode,'VersionMismatch') or starts-with(//faultstring,'RUNTIME0037') or starts-with(//faultstring,'SECU1079') or starts-with(//reasonCode,'MSG00003'))">
					<err:category>140</err:category>
					<err:code origin="BCED">
						<cod:code>00001</cod:code>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">Service provider has generated an error</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Le fournisseur de service a généré une erreur</xsl:element>
					</err:code>
				</xsl:when>
				<!-- Provider took too long to respond - Timeout -->
				<xsl:when test="starts-with(//faultstring,'APPL0119') or starts-with(//faultstring,'APPL0014') or starts-with(//reasonCode,'MSG00002') or contains(//faultstring,'RUNTIME0013')">
					<err:category>140</err:category>
					<err:code origin="BCED">
						<cod:code>00002</cod:code>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">Service provider unavailable</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Le fournisseur est inaccessible</xsl:element>
					</err:code>
				</xsl:when>
				<xsl:otherwise>
					<!-- Unhandled codes are considered as internal errors, to be mapped -->
					<err:category>150</err:category>
					<err:code origin="BCED">
						<cod:code>00001</cod:code>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">Internal error</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Erreur Interne</xsl:element>
					</err:code>
				</xsl:otherwise>
			</xsl:choose>
		</err:error>
	</xsl:template>
</xsl:stylesheet>
