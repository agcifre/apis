<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:han="http://soa.spw.wallonie.be/services/handiAVIQ/messages/v1" xmlns:cod="http://soa.spw.wallonie.be/data/common/code/v4" xmlns:err="http://soa.spw.wallonie.be/data/common/error/v4" xmlns:resp="http://soa.spw.wallonie.be/data/common/response/v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="consultFileByPeriodResponse" select="//*[local-name()='consultFilesByPeriodResponse']"/>
	<xsl:variable name="status" select="$consultFileByPeriodResponse/*[local-name()='consultFilesByPeriodResult']/*[local-name()='fileByPeriod']/*[local-name()='status']"/>
	<xsl:variable name="fileByPeriod" select="$consultFileByPeriodResponse/*[local-name()='consultFilesByPeriodResult']/*[local-name()='fileByPeriod']"/>
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
					<xsl:attribute name="customerTicket"><xsl:value-of select="//*[local-name()='informationCustomer']/*[local-name()='ticket']"/></xsl:attribute>
					<xsl:attribute name="requestId"><xsl:value-of select="//*[local-name()='informationSupplier']/*[local-name()='ticket']"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="//soapenv:Fault">
							<xsl:call-template name="technicalFaultMapper"/>
						</xsl:when>
						<xsl:when test="$status/*[local-name()='value']">
							<xsl:call-template name="tmpStatus"/>
							<xsl:if test="($status/*[local-name()='value']='NO_DATA_FOUND') or ($status/*[local-name()='value']='1')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="($status/*[local-name()='value']='NO_RESULT') or ($status/*[local-name()='value']='2')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="($status/*[local-name()='value']='INCOMPLETE_DATA')">
								<xsl:call-template name="tmpErrorOrWarning"/>
							</xsl:if>
							<xsl:if test="((($status/*[local-name()='value']!='NO_RESULT' or ($status/*[local-name()='value']='2'))  and ($status/*[local-name()='value']!='NO_DATA_FOUND' or ($status/*[local-name()='value']='1'))) or $status/*[local-name()='value']='INCOMPLETE_DATA')">
								<han:fileByPeriod>
									<informationCustomer>
										<ticket><xsl:value-of select="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='ticket']"/></ticket>
										<timestampSent><xsl:value-of select="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='timestampSent']"/></timestampSent>
										<customerIdentification>
											<xsl:choose>
												<xsl:when test="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='customerIdentification']/*[local-name()='CbeNumber']">
													<cbeNumber><xsl:value-of select="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='customerIdentification']/*[local-name()='CbeNumber']"/></cbeNumber>
												</xsl:when>
												<xsl:otherwise>
													<sector><xsl:value-of select="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='customerIdentification']/*[local-name()='Sector']"/></sector>
													<institution><xsl:value-of select="$fileByPeriod/*[local-name()='informationCustomer']/*[local-name()='customerIdentification']/*[local-name()='Institution']"/></institution>
												</xsl:otherwise>
											</xsl:choose>
										</customerIdentification>
									</informationCustomer>									
									<informationSupplier>
										<ticket><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='ticket']"/></ticket>
										<timestampReceive><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='timestampReceive']"/></timestampReceive>
										<timestampReply><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='timestampReply']"/></timestampReply>
										<supplierIdentification>
											<xsl:choose>
												<xsl:when test="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='supplierIdentification']/*[local-name()='CbeNumber']">
													<cbeNumber><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='supplierIdentification']/*[local-name()='CbeNumber']"/></cbeNumber>
												</xsl:when>
												<xsl:otherwise>
													<sector><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='supplierIdentification']/*[local-name()='Sector']"/></sector>
													<institution><xsl:value-of select="$fileByPeriod/*[local-name()='informationSupplier']/*[local-name()='supplierIdentification']/*[local-name()='Institution']"/></institution>
												</xsl:otherwise>
											</xsl:choose>
										</supplierIdentification>
									</informationSupplier>
									<criteria>
										<ssin><xsl:value-of select="$fileByPeriod/*[local-name()='criteria']/*[local-name()='ssin']"/></ssin>
										<period>
											<beginDate><xsl:value-of select="substring-before(string($fileByPeriod/*[local-name()='criteria']/*[local-name()='period']//*[local-name()='beginDate']),'T')"/></beginDate>
											<endDate><xsl:value-of select="substring-before(string($fileByPeriod/*[local-name()='criteria']/*[local-name()='period']//*[local-name()='endDate']),'T')"/></endDate>
										</period>
										<parts>
											<evolutionOfRequest><xsl:value-of select="$fileByPeriod/*[local-name()='criteria']/*[local-name()='parts']/*[local-name()='evolutionOfRequest']"/></evolutionOfRequest>
											<handicapRecognitions><xsl:value-of select="$fileByPeriod/*[local-name()='criteria']/*[local-name()='parts']/*[local-name()='handicapRecognitions']"/></handicapRecognitions>
										</parts>
									</criteria>
									<status>
										<value><xsl:value-of select="$fileByPeriod/*[local-name()='status']/*[local-name()='value']"/></value>
										<xsl:choose>
											<xsl:when test="$fileByPeriod/*[local-name()='status']/*[local-name()='value'] = 'DATA_FOUND'"><code>SOA0000000</code></xsl:when>
											<xsl:when test="$fileByPeriod/*[local-name()='status']/*[local-name()='value'] = 'NO_DATA_FOUND'"><code>SOA0000001</code></xsl:when>
											<xsl:otherwise><code>SOA5100000</code></xsl:otherwise>
										</xsl:choose>
									</status>
									
									<xsl:if test="$fileByPeriod/*[local-name()='result']/*[local-name()='ssin'] !=' '">
										<result>
											<ssin>
												<xsl:value-of select="$fileByPeriod/*[local-name()='result']/*[local-name()='ssin']"/>
											</ssin>
											<file>
												<xsl:if test="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest'] != ' ' ">
													<evolutionOfRequest>
														<legislation><xsl:value-of select="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='legislation']"/></legislation>
														<xsl:if test="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='requestDate'] != ' ' ">
															<requestDate>
																<xsl:value-of select="substring-before(string($fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='requestDate']),'T')"/>
															</requestDate>
														</xsl:if>
														<administrativePendingRequest>
															<xsl:value-of select="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='administrativePendingRequest']"/>
														</administrativePendingRequest>
														<handicapRecognitionPending>
															<xsl:value-of select="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='handicapRecognitionPending']"/>
														</handicapRecognitionPending>
														<xsl:if test="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='fileCompletionDate'] != ' '">
															<fileCompletionDate>
																<xsl:value-of select="substring-before(string($fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='fileCompletionDate']),'T')"/>
															</fileCompletionDate>
														</xsl:if>
														<appeal><xsl:value-of select="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='evolutionOfRequest']/*[local-name()='appeal']"/></appeal>
													</evolutionOfRequest>
												</xsl:if>												
												
												<xsl:if test="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='handicapRecognition'] != ' '">
													<handicapRecognitions>
														<xsl:for-each select="$fileByPeriod/*[local-name()='result']/*[local-name()='file']/*[local-name()='handicapRecognition']/*[local-name()='HandicapRecognitionType']">
															<handicapRecognition>
																<recognitionStatus>
																	<dateOfDecision>
																		<xsl:value-of select="substring-before(string(./*[local-name()='recognitionStatus']/*[local-name()='dateOfDecision']),'T')"/>
																	</dateOfDecision>
																	<startDateRecognition>
																		<xsl:value-of select="substring-before(string(./*[local-name()='recognitionStatus']/*[local-name()='startDateRecognition']),'T')"/>
																	</startDateRecognition>
																	<xsl:if test="./*[local-name()='recognitionStatus']/*[local-name()='endDateRecognition'] != ' '">
																		<endDateRecognition>
																			<xsl:value-of select="substring-before(string(./*[local-name()='recognitionStatus']/*[local-name()='endDateRecognition']),'T')"/>
																		</endDateRecognition>
																	</xsl:if>
																</recognitionStatus>
																<legislation><xsl:value-of select="./*[local-name()='legislation']"/></legislation>
																<xsl:if test="./*[local-name()='resultRecognitionChild'] != ' '">
																<resultRecognitionChild>
																	<xsl:if test="./*[local-name()='resultRecognitionChild']/*[local-name()='inabilityFollowCourse'] != ' '">
																		<inabilityFollowCourse><xsl:value-of select="./*[local-name()='resultRecognitionChild']/*[local-name()='inabilityFollowCourse']"/></inabilityFollowCourse>
																	</xsl:if>
																	<pillars>
																		<xsl:if test="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar1'] != ' '">
																			<pillar1><xsl:value-of select="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar1']"/></pillar1>
																		</xsl:if>
																		<xsl:if test="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar2'] != ' '">
																			<pillar2><xsl:value-of select="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar2']"/></pillar2>
																		</xsl:if>
																		<xsl:if test="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar3'] != ' '">
																			<pillar3><xsl:value-of select="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillar3']"/></pillar3>
																		</xsl:if>
																		<xsl:if test="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillarsTotal'] != ' '">
																			<pillarsTotal><xsl:value-of select="./*[local-name()='resultRecognitionChild']/*[local-name()='pillars']/*[local-name()='pillarsTotal']"/></pillarsTotal>
																		</xsl:if>
																	</pillars>
																</resultRecognitionChild>
																</xsl:if>
																<decisionStatus><xsl:value-of select="./*[local-name()='decisionStatus']"/></decisionStatus>
															</handicapRecognition>
														</xsl:for-each>
													</handicapRecognitions>
												</xsl:if>
											</file>
										</result>
									</xsl:if>
								</han:fileByPeriod>
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
				<xsl:when test="($status/*[local-name()='value']='NO_DATA_FOUND') or ($status/*[local-name()='value']='DATA_FOUND') or ($status/*[local-name()='value']='SUCCESS') or ($status/*[local-name()='value']='0') or ($status/*[local-name()='value']='1') or ($status/*[local-name()='value']='2')">PROCESSED</xsl:when>
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
			<xsl:when test="($status/*[local-name()='value']='NO_DATA_FOUND') or ($status/*[local-name()='value']='1')">
				<xsl:element name="err:warning">
					<xsl:element name="err:category">100</xsl:element>
					<xsl:element name="err:code">
						<xsl:element name="cod:code">00001</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageFR">Aucune donnée trouvée</xsl:element>
						<xsl:element name="cod:description" use-attribute-sets="languageEN">No data found</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="($status/*[local-name()='value']='NO_RESULT') or ($status/*[local-name()='value']='2')">
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
