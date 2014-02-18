<cfparam name="attributes.orderID" type="numeric">

<cfquery name="getOrder">
	SELECT
	c.ContactID, c.FirstName, c.LastName, c.Email,
	o.OrderDate, o.ShipAddress, o.ShipCountry,
	oi.OrderQty, oi.ItemPrice,
	m.Merchname,
	F.MovieTitle
	FROM
	Contacts c,
	MerchandiseOrders o, 
	MerchandiseOrdersItems oi,
	Merchandise m,
	Films f
	WHERE o.OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.orderID#">
	AND c.ContactID = o.ContactID
	AND m.MerchID = oi.ItemID
	AND o.OrderID = oi.OrderID
	AND f.FilmID = m.FilmID
	ORDER BY m.MerchName
</cfquery>

<cfquery dbtype="query" name="getTotal">
	SELECT SUM(ItemPrice * OrderQty) AS OrderTotal FROM GetORder
</cfquery>

<cfprocessingdirective suppressWhitespace="no">
	<cfmail query="getOrder" group="ContactID" groupCasesensitive="no" startrow="1"
	subject="Thanks for your order (Order number #Attributes.orderID#)"
	to="""#FirstName# #LastName#"" <#Email#>"
	from="""Orange Whip Online Store"" <orders@orangeshipstudios.com>">
	Thank you for ordering from Orange Whip Studios. Here are the details of your order, which will ship shortly.
	Please save or print this email for your records.
	Order Number: #attributes.orderID#
	Items Ordered: #recordCount#
	Date of Order: #dateFormat(OrderDate, "dddd, mmmm d, yyyy")#
	#timeFormat(orderDate)#
	------------------------------------------------------------
	<cfoutput>
		#currentRow#. #MerchName#
		(in commemoration of the film "#MovieTitle#")
		Price: #LSCurrencyFormat(ItemsPrice)#
		Qty: #OrderQty#
	</cfoutput>
	-------------------------------------------------------------
	Order Total: #lsCurrencyFormat(getTotal.OrderTotal)#
	
	This order will be shipped to:	
	#FirstName# #LastName#
	#ShipAddress#
	#ShipCity#
	#ShipState# #ShipZip# #ShipCountry#
	
	If you have any questions, please write back to us at orders@orangewhipstudios.comm,
	 or just reply to this email.								
	</cfmail>
	
	
</cfprocessingdirective>