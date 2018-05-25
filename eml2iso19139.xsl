<?xml version="1.0" encoding="UTF-8"?>

<!--
Stylesheet downloaded from https://www.ngdc.noaa.gov/metadata/published/xsl/Ecology%20Markup%20Language/ on 2018-05-25; xslt file in directory there dated 2016-12-27, and includes 
no metadata.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eml="eml://ecoinformatics.org/eml-2.1.1" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gmx="http://www.isotc211.org/2005/gmx"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:date="http://exslt.org/dates-and-times" exclude-result-prefixes="date">
	<xsl:output method="xml"/>
	<xsl:template match="eml:eml">
		<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gco="http://www.isotc211.org/2005/gco"
			xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">
			<gmd:fileIdentifier>
				<xsl:call-template name="writeCharacterString">
					<xsl:with-param name="stringToWrite" select="@packageId"/>
				</xsl:call-template>
			</gmd:fileIdentifier>
			<gmd:language>
				<xsl:call-template name="writeCharacterString">
					<xsl:with-param name="stringToWrite">
						<xsl:choose>
							<xsl:when test="dataset/@xml:lang">
								<xsl:value-of select="dataset/@xml:lang"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'eng'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</gmd:language>
			<gmd:characterSet>
				<xsl:call-template name="writeCodelist">
					<xsl:with-param name="codeListName" select="'gmd:MD_CharacterSetCode'"/>
					<xsl:with-param name="codeListValue" select="'utf8'"/>
				</xsl:call-template>
			</gmd:characterSet>
			<gmd:hierarchyLevel>
				<xsl:call-template name="writeCodelist">
					<xsl:with-param name="codeListName" select="'gmd:MD_ScopeCode'"/>
					<xsl:with-param name="codeListValue" select="'dataset'"/>
				</xsl:call-template>
			</gmd:hierarchyLevel>
			<xsl:for-each select="dataset/metadataProvider">
				<gmd:contact>
					<xsl:call-template name="emlPerson2ResponsibleParty">
						<xsl:with-param name="roleCode" select="'pointOfContact'"/>
					</xsl:call-template>
				</gmd:contact>
			</xsl:for-each>
			<gmd:dateStamp>
				<!-- generate a date/time stamp for the metadata document -->
				<gco:DateTime>
					<xsl:value-of select="date:date-time()"/>
				</gco:DateTime>
			</gmd:dateStamp>
			<gmd:metadataStandardName>
				<gco:CharacterString>ISO 19115</gco:CharacterString>
			</gmd:metadataStandardName>
			<gmd:metadataStandardVersion>
				<gco:CharacterString>2003</gco:CharacterString>
			</gmd:metadataStandardVersion>
			<xsl:if test="access">
				<gmd:metadataConstraints>
					<gmd:MD_LegalConstraints>
						<xsl:for-each select="access/allow">
							<gmd:otherConstraints>
								<gco:CharacterString>
									<xsl:value-of select="concat(principal,': ',permission)"/>
								</gco:CharacterString>
							</gmd:otherConstraints>
						</xsl:for-each>
					</gmd:MD_LegalConstraints>
				</gmd:metadataConstraints>
			</xsl:if>
			<gmd:identificationInfo>
				<gmd:MD_DataIdentification>
					<gmd:citation>
						<gmd:CI_Citation>
							<!-- added conditional in case xml:lang attribute is not present -->
							<xsl:choose>
								<xsl:when test="dataset/title/@xml:lang='eng'">
									<gmd:title>
										<gco:CharacterString>
											<xsl:value-of select="dataset/title"/>
										</gco:CharacterString>
									</gmd:title>
								</xsl:when>
								<xsl:otherwise>
									<gmd:title>
										<gco:CharacterString>
											<xsl:value-of select="dataset/title"/>
										</gco:CharacterString>
									</gmd:title>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="dataset/shortName">
								<gmd:alternateTitle>
									<gco:CharacterString>
										<xsl:value-of select="dataset/shortName"/>
									</gco:CharacterString>
								</gmd:alternateTitle>
							</xsl:if>
							<gmd:date>
								<gmd:CI_Date>
									<gmd:date>
										<gco:Date>
											<xsl:value-of select="dataset/pubDate"/>
										</gco:Date>
									</gmd:date>
									<gmd:dateType>
										<xsl:call-template name="writeCodelist">
											<xsl:with-param name="codeListName" select="'gmd:CI_DateTypeCode'"/>
											<xsl:with-param name="codeListValue" select="'publication'"/>
										</xsl:call-template>
									</gmd:dateType>
								</gmd:CI_Date>
							</gmd:date>
							<xsl:if test="dataset/alternateIdentifier">
								<gmd:identifier>
									<gmd:MD_Identifier>
										<gmd:code>
											<xsl:value-of select="dataset/alternateIdentifier"/>
										</gmd:code>
									</gmd:MD_Identifier>
								</gmd:identifier>
							</xsl:if>
							<xsl:for-each select="dataset/creator">
								<gmd:citedResponsibleParty>
									<xsl:call-template name="emlPerson2ResponsibleParty">
										<xsl:with-param name="roleCode" select="'originator'"/>
									</xsl:call-template>
								</gmd:citedResponsibleParty>
							</xsl:for-each>
							<xsl:for-each select="dataset/associatedParty">
								<gmd:citedResponsibleParty>
									<xsl:call-template name="emlPerson2ResponsibleParty">
										<xsl:with-param name="roleCode" select="'originator'"/>
									</xsl:call-template>
								</gmd:citedResponsibleParty>
							</xsl:for-each>
							<xsl:for-each select="dataset/publisher">
								<gmd:citedResponsibleParty>
									<xsl:call-template name="emlPerson2ResponsibleParty">
										<xsl:with-param name="roleCode" select="'publisher'"/>
									</xsl:call-template>
								</gmd:citedResponsibleParty>
							</xsl:for-each>
						</gmd:CI_Citation>
					</gmd:citation>
					<gmd:abstract>
						<xsl:call-template name="writeCharacterString">
							<xsl:with-param name="stringToWrite" select="dataset/abstract/para"/>
						</xsl:call-template>
					</gmd:abstract>
					<gmd:purpose>
						<xsl:call-template name="writeCharacterString">
							<xsl:with-param name="stringToWrite">
								<xsl:value-of select="concat(dataset/purpose/title,': ')"/>
								<xsl:for-each select="dataset/purpose/para">
									<xsl:value-of select="concat(.,' ')"/>
								</xsl:for-each>
							</xsl:with-param>
						</xsl:call-template>
					</gmd:purpose>
					<xsl:for-each select="dataset/contact">
						<gmd:pointOfContact>
							<xsl:call-template name="emlPerson2ResponsibleParty">
								<xsl:with-param name="roleCode" select="'pointOfContact'"/>
							</xsl:call-template>
						</gmd:pointOfContact>
					</xsl:for-each>
					<xsl:if test="dataset/keywordSet">
						<xsl:for-each select="dataset/keywordSet">
							<gmd:descriptiveKeywords>
								<gmd:MD_Keywords>
									<xsl:for-each select="keyword">
										<gmd:keyword>
											<gco:CharacterString>
												<xsl:value-of select="."/>
											</gco:CharacterString>
										</gmd:keyword>
									</xsl:for-each>
									<xsl:if test="keywordThesaurus">
										<gmd:thesaurusName>
											<gmd:CI_Citation>
												<gmd:title>
													<gco:CharacterString>
														<xsl:value-of select="keywordThesaurus"/>
													</gco:CharacterString>
												</gmd:title>
												<gmd:date gco:nilReason="missing"/>
											</gmd:CI_Citation>
										</gmd:thesaurusName>
									</xsl:if>
								</gmd:MD_Keywords>
							</gmd:descriptiveKeywords>
						</xsl:for-each>
					</xsl:if>
					<gmd:resourceConstraints>
						<gmd:MD_LegalConstraints>
							<gmd:accessConstraints>
								<xsl:call-template name="writeCodelist">
									<xsl:with-param name="codeListName" select="'gmd:MD_RestrictionCode'"/>
									<xsl:with-param name="codeListValue" select="'otherRestrictions'"/>
								</xsl:call-template>
							</gmd:accessConstraints>
							<gmd:otherConstraints>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="dataset/intellectualRights"/>
								</xsl:call-template>
							</gmd:otherConstraints>
							<xsl:if test="*/physical/distribution/access">
								<xsl:for-each select="access/allow">
									<gmd:otherConstraints>
										<gco:CharacterString>
											<xsl:value-of select="concat(principal,': ',permission)"/>
										</gco:CharacterString>
									</gmd:otherConstraints>
								</xsl:for-each>
							</xsl:if>
						</gmd:MD_LegalConstraints>
					</gmd:resourceConstraints>
					<gmd:language>
						<gmd:LanguageCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#LanguageCode" codeListValue="eng">English</gmd:LanguageCode>
					</gmd:language>
					<gmd:characterSet>
						<gmd:MD_CharacterSetCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode" codeListValue=""/>
					</gmd:characterSet>
					<gmd:extent>
						<gmd:EX_Extent id="boundingExtent">
							<xsl:for-each select="dataset/coverage/geographicCoverage">
								<xsl:apply-templates select="."/>
							</xsl:for-each>
							<xsl:for-each select="dataset/coverage/temporalCoverage">
								<xsl:apply-templates select=".">
									<xsl:with-param name="timePeriodId">
										<xsl:number value="position()" format="1"/>
									</xsl:with-param>
								</xsl:apply-templates>
							</xsl:for-each>
						</gmd:EX_Extent>
					</gmd:extent>
				</gmd:MD_DataIdentification>
			</gmd:identificationInfo>
			<xsl:for-each select="//dataTable">
				<gmd:contentInfo>
					<gmd:MD_CoverageDescription>
						<gmd:attributeDescription>
							<xsl:attribute name="gco:nilReason">
								<xsl:value-of select="'unknown'"/>
							</xsl:attribute>
						</gmd:attributeDescription>
						<gmd:contentType>
							<xsl:call-template name="writeCodelist">
								<xsl:with-param name="codeListName" select="'gmd:MD_CoverageContentTypeCode'"/>
								<xsl:with-param name="codeListValue" select="'physicalMeasurement'"/>
							</xsl:call-template>
						</gmd:contentType>
						<xsl:for-each select="attributeList/attribute">
							<xsl:call-template name="writeVariable"/>
						</xsl:for-each>
					</gmd:MD_CoverageDescription>
				</gmd:contentInfo>
			</xsl:for-each>
			<gmd:distributionInfo>
				<gmd:MD_Distribution>
					<gmd:distributionFormat>
						<gmd:MD_Format>
							<gmd:name>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="additionalMetadata/metadata/physical/dataFormat/externallyDefinedFormat/formatName"/>
								</xsl:call-template>
							</gmd:name>
							<gmd:version>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="additionalMetadata/metadata/physical/dataFormat/externallyDefinedFormat/formatVersion"/>
								</xsl:call-template>
							</gmd:version>
						</gmd:MD_Format>
					</gmd:distributionFormat>
					<xsl:for-each select="dataset/distribution/online">
						<gmd:transferOptions>
							<gmd:MD_DigitalTransferOptions>
								<gmd:onLine>
									<gmd:CI_OnlineResource>
										<gmd:linkage>
											<gmd:URL>
												<xsl:value-of select="url"/>
											</gmd:URL>
										</gmd:linkage>
										<gmd:protocol>
											<gco:CharacterString>
												<xsl:value-of select="substring-before(url,':')"/>
											</gco:CharacterString>
										</gmd:protocol>
										<gmd:description>
											<xsl:call-template name="writeCharacterString">
												<xsl:with-param name="stringToWrite" select="onlineDescription"/>
											</xsl:call-template>
										</gmd:description>
										<gmd:function>
											<xsl:call-template name="writeCodelist">
												<xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
												<xsl:with-param name="codeListValue" select="url/@function"/>
											</xsl:call-template>
										</gmd:function>
									</gmd:CI_OnlineResource>
								</gmd:onLine>
							</gmd:MD_DigitalTransferOptions>
						</gmd:transferOptions>
					</xsl:for-each>
					<gmd:transferOptions>
						<gmd:MD_DigitalTransferOptions>
							<gmd:onLine>
								<gmd:CI_OnlineResource>
									<gmd:linkage>
										<gmd:URL>
											<xsl:value-of select="additionalMetadata/metadata/physical/distribution/online/url"/>
										</gmd:URL>
									</gmd:linkage>
									<gmd:protocol>
										<gco:CharacterString/>
									</gmd:protocol>
									<gmd:description>
										<gco:CharacterString/>
									</gmd:description>
									<gmd:function>
										<gmd:CI_OnLineFunctionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode" codeListValue=""/>
									</gmd:function>
								</gmd:CI_OnlineResource>
							</gmd:onLine>
						</gmd:MD_DigitalTransferOptions>
					</gmd:transferOptions>
				</gmd:MD_Distribution>
			</gmd:distributionInfo>
			<gmd:dataQualityInfo>
				<gmd:DQ_DataQuality>
					<gmd:scope>
						<gmd:DQ_Scope>
							<gmd:level>
								<gmd:MD_ScopeCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>
							</gmd:level>
						</gmd:DQ_Scope>
					</gmd:scope>
					<gmd:lineage>
						<gmd:LI_Lineage>
							<gmd:statement>
								<gco:CharacterString/>
							</gmd:statement>
							<xsl:for-each select="/eml:eml/dataset/methods/methodStep">
								<gmd:processStep>
									<gmd:LI_ProcessStep>
										<gmd:description>
											<xsl:call-template name="writeCharacterString">
												<xsl:with-param name="stringToWrite">
													<xsl:value-of select="concat(description/section/title,': ')"/>
													<xsl:for-each select="description/section/para">
														<xsl:value-of select="."/>
													</xsl:for-each>
												</xsl:with-param>
											</xsl:call-template>
										</gmd:description>
									</gmd:LI_ProcessStep>
								</gmd:processStep>
							</xsl:for-each>
						</gmd:LI_Lineage>
					</gmd:lineage>
				</gmd:DQ_DataQuality>
			</gmd:dataQualityInfo>
		</gmd:MD_Metadata>
	</xsl:template>
	<xsl:template match="individualName" mode="name">
		<gmd:individualName>
			<gco:CharacterString>
				<xsl:value-of select="givenName"/>
				<xsl:value-of select="surName"/>
			</gco:CharacterString>
		</gmd:individualName>
	</xsl:template>
	<xsl:template match="onlineUrl">
		<gmd:onlineResource>
			<gmd:CI_OnlineResource>
				<gmd:linkage>
					<gmd:URL>
						<xsl:value-of select="."/>
					</gmd:URL>
				</gmd:linkage>
			</gmd:CI_OnlineResource>
		</gmd:onlineResource>
	</xsl:template>
	<xsl:template match="geographicCoverage">
		<gmd:geographicElement>
			<gmd:EX_GeographicBoundingBox>
				<gmd:westBoundLongitude>
					<gco:Decimal>
						<xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/>
					</gco:Decimal>
				</gmd:westBoundLongitude>
				<gmd:eastBoundLongitude>
					<gco:Decimal>
						<xsl:value-of select="boundingCoordinates/eastBoundingCoordinate"/>
					</gco:Decimal>
				</gmd:eastBoundLongitude>
				<gmd:southBoundLatitude>
					<gco:Decimal>
						<xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/>
					</gco:Decimal>
				</gmd:southBoundLatitude>
				<gmd:northBoundLatitude>
					<gco:Decimal>
						<xsl:value-of select="boundingCoordinates/northBoundingCoordinate"/>
					</gco:Decimal>
				</gmd:northBoundLatitude>
			</gmd:EX_GeographicBoundingBox>
		</gmd:geographicElement>
	</xsl:template>
	<xsl:template match="temporalCoverage">
		<xsl:param name="timePeriodId"/>
		<!-- check on how to handle single dates in ISO -->
		<gmd:temporalElement>
			<gmd:EX_TemporalExtent>
				<gmd:extent>
					<gml:TimePeriod gml:id="timePeriod{$timePeriodId}">
						<gml:begin>
							<gml:TimeInstant gml:id="timePeriod{$timePeriodId}BeginDate">
								<gml:timePosition>
									<xsl:value-of select="rangeOfDates/beginDate/calendarDate"/>
								</gml:timePosition>
							</gml:TimeInstant>
						</gml:begin>
						<gml:end>
							<gml:TimeInstant gml:id="timePeriod{$timePeriodId}EndDate">
								<gml:timePosition>
									<xsl:value-of select="rangeOfDates/endDate/calendarDate"/>
								</gml:timePosition>
							</gml:TimeInstant>
						</gml:end>
					</gml:TimePeriod>
				</gmd:extent>
			</gmd:EX_TemporalExtent>
		</gmd:temporalElement>
	</xsl:template>
	<xsl:template match="methods">
		<xsl:if test="normalize-space(methodStep/description/para)">
			<xsl:text>Methods: </xsl:text>
			<xsl:value-of select="methodStep/description/para"/>
			<xsl:text>  | </xsl:text>
		</xsl:if>
		<xsl:if test="normalize-space(sampling/studyExtent/description)">
			<xsl:text>Sampling area: </xsl:text>
			<xsl:value-of select="sampling/studyExtent/description"/>
			<xsl:text>  | </xsl:text>
		</xsl:if>
		<xsl:if test="normalize-space(sampling/samplingDescription/para)">
			<xsl:text>Sampling procedure: </xsl:text>
			<xsl:value-of select="sampling/samplingDescription/para"/>
			<xsl:text>  | </xsl:text>
		</xsl:if>
		<xsl:if test="normalize-space(qualityControl/description/para)">
			<xsl:text>Quality control: </xsl:text>
			<xsl:value-of select="qualityControl/description/para"/>
			<xsl:text>  | </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template name="writeCharacterString">
		<xsl:param name="stringToWrite"/>
		<xsl:choose>
			<xsl:when test="string($stringToWrite)">
				<gco:CharacterString>
					<xsl:value-of select="$stringToWrite"/>
				</gco:CharacterString>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="gco:nilReason">
					<xsl:value-of select="'missing'"/>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="writeCodelist">
		<xsl:param name="codeListName"/>
		<xsl:param name="codeListValue"/>
		<xsl:variable name="codeListLocation" select="'https://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml'"/>
		<xsl:element name="{$codeListName}">
			<xsl:attribute name="codeList">
				<xsl:value-of select="$codeListLocation"/>
				<xsl:value-of select="'#'"/>
				<xsl:value-of select="$codeListName"/>
			</xsl:attribute>
			<xsl:attribute name="codeListValue">
				<xsl:value-of select="$codeListValue"/>
			</xsl:attribute>
			<xsl:value-of select="$codeListValue"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="emlPerson2ResponsibleParty">
		<xsl:param name="roleCode"/>
		<gmd:CI_ResponsibleParty>
			<gmd:individualName>
				<xsl:call-template name="writeCharacterString">
					<xsl:with-param name="stringToWrite" select="normalize-space(concat(individualName/salutation,' ',individualName/givenName,' ',individualName/surName))"/>
				</xsl:call-template>
			</gmd:individualName>
			<gmd:organisationName>
				<xsl:call-template name="writeCharacterString">
					<xsl:with-param name="stringToWrite" select="organizationName"/>
				</xsl:call-template>
			</gmd:organisationName>
			<gmd:positionName>
				<xsl:call-template name="writeCharacterString">
					<xsl:with-param name="stringToWrite" select="positionName"/>
				</xsl:call-template>
			</gmd:positionName>
			<gmd:contactInfo>
				<gmd:CI_Contact>
					<gmd:phone>
						<gmd:CI_Telephone>
							<gmd:voice>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="phone"/>
								</xsl:call-template>
							</gmd:voice>
						</gmd:CI_Telephone>
					</gmd:phone>
					<gmd:address>
						<gmd:CI_Address>
							<xsl:for-each select="address/deliveryPoint">
								<gmd:deliveryPoint>
									<xsl:call-template name="writeCharacterString">
										<xsl:with-param name="stringToWrite" select="."/>
									</xsl:call-template>
								</gmd:deliveryPoint>
							</xsl:for-each>
							<gmd:city>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="address/city"/>
								</xsl:call-template>
							</gmd:city>
							<gmd:administrativeArea>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="address/administrativeArea"/>
								</xsl:call-template>
							</gmd:administrativeArea>
							<gmd:postalCode>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="address/postalCode"/>
								</xsl:call-template>
							</gmd:postalCode>
							<gmd:country>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="address/country"/>
								</xsl:call-template>
							</gmd:country>
							<gmd:electronicMailAddress>
								<xsl:call-template name="writeCharacterString">
									<xsl:with-param name="stringToWrite" select="electronicMailAddress"/>
								</xsl:call-template>
							</gmd:electronicMailAddress>
						</gmd:CI_Address>
					</gmd:address>
					<gmd:onlineResource>
						<gmd:CI_OnlineResource>
							<gmd:linkage>
								<xsl:choose>
									<xsl:when test="org-contact-info/url">
										<gmd:URL>
											<xsl:value-of select="org-contact-info/url"/>
										</gmd:URL>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="gco:nilReason">
											<xsl:value-of select="'missing'"/>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</gmd:linkage>
						</gmd:CI_OnlineResource>
					</gmd:onlineResource>
					<gmd:hoursOfService>
						<xsl:call-template name="writeCharacterString">
							<xsl:with-param name="stringToWrite" select="org-contact-info/business-hours"/>
						</xsl:call-template>
					</gmd:hoursOfService>
					<gmd:contactInstructions>
						<xsl:call-template name="writeCharacterString">
							<xsl:with-param name="stringToWrite" select="contact-instructions"/>
						</xsl:call-template>
					</gmd:contactInstructions>
				</gmd:CI_Contact>
			</gmd:contactInfo>
			<gmd:role>
				<xsl:call-template name="writeCodelist">
					<xsl:with-param name="codeListName" select="'gmd:CI_RoleCode'"/>
					<xsl:with-param name="codeListValue" select="$roleCode"/>
				</xsl:call-template>
			</gmd:role>
		</gmd:CI_ResponsibleParty>
	</xsl:template>
	<xsl:template name="writeVariable">
		<gmd:dimension>
			<gmd:MD_Band>
				<gmd:sequenceIdentifier>
					<gco:MemberName>
						<gco:aName>
							<xsl:call-template name="writeCharacterString">
								<xsl:with-param name="stringToWrite" select="attributeName"/>
							</xsl:call-template>
						</gco:aName>
						<gco:attributeType>
							<gco:TypeName>
								<gco:aName>
									<xsl:call-template name="writeCharacterString">
										<xsl:with-param name="stringToWrite" select="measurementScale/interval/unit/standardUnit"/>
									</xsl:call-template>
								</gco:aName>
							</gco:TypeName>
						</gco:attributeType>
					</gco:MemberName>
				</gmd:sequenceIdentifier>
				<gmd:descriptor>
					<xsl:call-template name="writeCharacterString">
						<xsl:with-param name="stringToWrite">
							<xsl:value-of select="attributeLabel"/>
							<xsl:if test="attributeDefinition">
								<xsl:value-of select="concat('- ',attributeDefinition)"/>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</gmd:descriptor>
				<xsl:if test="measurementScale/interval/unit/standardUnit">
					<gmd:units>
						<xsl:attribute name="xlink:href">
							<xsl:value-of select="'http://someUnitsDictionary.xml#'"/>
							<xsl:value-of select="measurementScale/interval/unit/standardUnit"/>
						</xsl:attribute>
					</gmd:units>
				</xsl:if>
			</gmd:MD_Band>
		</gmd:dimension>
	</xsl:template>
</xsl:stylesheet>