<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes" doctype-system="transactions.dtd"/>
	
	<!-- Set key value to group -->
	<xsl:key name="shop" match="transaction" use="giftShop"/>
	<xsl:key name="date" match="transaction" use="concat(giftShop, '|', transaction_date)"/>
	<!-- Global variables refer to external files  -->
	<xsl:variable name="external" select="document('retail_customers.xml')"/>

	<xsl:template match="transactions">
		<Transactions>
			<!-- Return the string value that uniquely identifies the specified node -->
			<!-- in the transaction as giftShop and output it in sequence -->
			<xsl:apply-templates select="transaction[generate-id() = generate-id(key('shop', giftShop)[1])]" mode="shopGroup"/>
		</Transactions>
	</xsl:template>

	<xsl:template match="transaction" mode="shopGroup">
		<shop number="{giftShop}">
			<!-- Return the string value that uniquely identifies the specified node -->
			<!-- in the transaction as date and output it in sequence -->
			<xsl:apply-templates select="key('shop', giftShop)[generate-id() = generate-id(key('date', concat(giftShop, '|', transaction_date))[1])]" mode="dateGroup"/>
		</shop>
	</xsl:template>

	<xsl:template match="transaction" mode="dateGroup">
		<!-- Local variables are defined as the current giftShop and transaction_date -->
		<xsl:variable name="currentgiftShop" select="giftShop"/>
		<xsl:variable name="currenttransaction_date" select="transaction_date"/>
		<Date date="{transaction_date}">
			<!-- Traverse the transaction and record the current customerID -->
			<xsl:for-each select="//transaction">
			<xsl:variable name="currentcustomerID" select="customerID"/>
				<!-- Judge whether giftShop and transaction_date correspond to each other -->
				<xsl:if test="giftShop = $currentgiftShop and transaction_date = $currenttransaction_date">
					<!-- Output the ID and currency of each transaction -->
					<Transaction transactionID="{transactionID}">
						<value currency="{./value/@currency}">
                            <xsl:value-of select="value"></xsl:value-of>
                        </value>
						<key>oTMWj2i5IDXy3xYmut1G</key>
						<xsl:for-each select="$external/customers/customer">
							<xsl:if test="customerID=$currentcustomerID">
							<!-- If the user of this transaction can be retrieved from an external file--> 
							<!-- the customer specific information will be output -->
							<customer customerID="{customerID}">
								<prefix>
									<xsl:value-of select="prefix"/>
								</prefix>
								<lastName>
									<xsl:value-of select="lastName"/>
								</lastName>
								<givenName>
									<xsl:value-of select="givenName"/>
								</givenName>
								<addressID>
									<xsl:value-of select="addressID"/>
								</addressID>
							</customer>
							</xsl:if>
						</xsl:for-each>
					</Transaction>
				</xsl:if>
			</xsl:for-each>
		</Date>
	</xsl:template>
</xsl:stylesheet>