<cfparam name="attributes.orderID" type="numeric">
<cfparam name="attributes.useHTML" type="boolean" default="yes">
<cfset imgSrcPath = "http://#cgihttp_host#/ows/images">

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

<cfif getOrder.recordCount eq 0>
	<cfthrow message="Failed to obtain order information." detail="Either the Order ID was incerrect,
	or order has no detail records.">
<cfelseif isValid("email", getOwer.email)>
	<cfthrow message="Failed to obtain order information." 
	detail="Email addresses ned to have an @ sign and at least one 'dot">
</cfif>
<cfquery dbtype="query" name="getTotal">
	SELECT SUM(ItemPrice * OrderQty) AS OrderTotal FROM GetOrder
</cfquery>
<cfif attributes.useHTML>
	<cfmail query="getOrder" group="ContactID" groupCasesensitive="No"
	subject="Thanks for your order (Order number #ATTRIBUTES.orderID#)"
	to="""#FirstName# #LastName#"" <#Email#>"
	from="""Orange Whip Online Store"" <orders@orangewhipstudios.com>" type="HTML">
	<html>
	<head>
		<style type="text/css">
			body {font-family: sans-serif; font-size:12px; color: navy}
			td {font-size: 12px}
			tkh {font-size:12px; color:white; background: navy; text-align:left}
		</style>
	</head>
	<body>
		<h2>Thank you for your order</h2>
		<p><b>
				Thank you for ordering from <a href="http://www.orangewhipstudios.com">Orange Whip Studios</a>
		</b></p><br>
		Here are the details of your order, which will ship shortly.
		Please save or print this email for your records.<br>
		<p>
			<strong>Order Number:</strong>#ATTRIBUTES.orderID#<br>
			<strong>Items Ordered:</strong> #recordCount#<br>
			<strong>Date of Order:</strong>
			#dateFormat(OrderDate, "dddd, mmmm d, yyyy")#
			#timeFormat(OrderDate)#<br>
		</p>
		
		<table>
			<cfoutput>
				<tr valign="top"><th colspan="2">#MerchName#</th></tr>
				<tr>
					<td><cfif ImageNameSmall neq "">
						<img src="#imgSrcPath#/#ImageNameSmall#" alt="#MerchName#" width="50" border="0">
					</cfif></td>
					<td>
						<em>(in commemoration of the film "#MovieTitle#")</em></br>
						<strong>Price:</strong> #lsCurrencyFormat(itemPrice)#<br>
						<strong>Qty:</strong> #OrderQty#<br>&nbsp;<br>
					</td>
				</tr>
			</cfoutput>
		</table>
		<p>
			Order Total: #lsCurrencyFormat(getTotal.OrderTotal)#<br>
			#ShipAddress#<br>
			#ShipCite#<br>
			#ShipState# #ShipZip# #ShipCountry#<br>
		</p>
		<p>
			If you have any questions, please write back to us at
			<a href="order@orangewhipstudios.com">orders@orangewhipstudios.com</a>,or just reply too this email.
			<br>
		</p>
	</body>
	</html>	

	</cfmail>
<cfelse>
	<cfprocessingdirective suppressWhitespace="no">
		<cfmail query="getOrder" group="ContactID" groupCasesensitive="No" 
		subject="Thanks for your order (Order number #attributes.OrderID#)"
		to="""#FirstName# #LastName#"" <#Email#>"
		from="""Orange Whip Online Store"" <orders@orangewhipstudios.com>">
			Thank you for ordering from Orange Whip Studios. Here are the detail of your order, which will ship shortly.
			Please save or print this email for your records.
			
			Order Number: #attributes.orderID#
			Items Ordered: #recordCount#
			Date of Order: #dateFormat(OrderDate, "dddd, mmmm d, yyyy")#
			#timeFormat(OrderDate)#
			-----------------------------------------------------------
			<cfoutput>
				#currentRow#. #MerchName#
				(in commemoration of the film "#MovieTitle#")
				Price: #lsCurrencyFormat(ItemPrice)#
				Qty: #OrderQty#
			</cfoutput>
			-----------------------------------------------------------
			Order Total: #lsCurrencyFormat(getTotal.OrderTotal)#
			
			This order will be shipped to:
			#FirstName# #LastName#
			#ShipAddress#
			#ShipCity#
			#ShipState# #ShipZip# #ShipCountry#
			If you have any questions, please write back to us at
			orders@orangewhipstudios.com, or just reply to this email.
		</cfmail>
	</cfprocessingdirective>
</cfif>