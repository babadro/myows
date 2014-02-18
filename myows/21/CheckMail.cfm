<!--- 
 Filename: CheckMail.cfm
 Author: Nate Weiss (NMW)
 Purpose: Creates a very simple POP client
--->

<html>
<head><title>Check Your Mail</title></head>
<body>

<!--- Simple CSS-based formatting styles --->
<style>
 body { font-family:sans-serif;font-size:12px} 
 th { font-size:12px;background:navy;color:white} 
 td { font-size:12px;background:lightgrey;color:navy} 
</style>

<h2>Check Your Mail</h2>

<cfif isDefined("URL.logout") or isDefined("Form.popServer")>
	<cfset structDelete(SESSION, "mail")>
</cfif>

<cfif not isDefined("SESSION.mail")>
	<cfinclude template="CheckMailLogin.cfm">
</cfif>

<cfif not isDefined("SESSION.mail.getMessages") or isDefined("URL.refresh")>
	<cfflush>
	
	<cfpop action="getHeaderOnly" name="SESSION.mail.getMessages"
	server="#SESSION.mail.popServer#" username="#SESSION.mail.username#"
	password="#SESSION.mail.password#" maxrows="50">
</cfif>
	
<cfif SESSION.mail.getMessages.recordCount eq 0>
	<p>You have not messages at this time</p>
<cfelse>
	<table border="0" cellSpacing="2" cols="3" width="550">
		<tr>
			<th width="100">Date Setn</th>
			<th width="200">From</th>
			<th width="200">Subject</th>
		</tr>
		<cfoutput query="SESSION.mail.getMessages">
			<cfset msgDate = ParseDateTIme(date, "pop")>
			<cfset linkURL = "CheckMailMsg.cfm?uid=#urlEncoddedFormat(uid)#">
			<tr valign="baseline">
				<td>
					<strong>#dateFormat(msgDate)#</strong><br>
					#timeFormat(msgDate)# #ReplyTo#
				</td>
				<td>#htmlEditFormat(From)#</td>
				<td><strong><a href="#linkURL#">#Subject#</a></strong></td>
			</tr>
		</cfoutput>
	</table>
</cfif>

<strong><a href="CheckMail.cfm?Refresh=Yes">Refresh Message List</a></strong>
<a href="checkMail.cfm?Logout=Yes">Log Out</a><br>

</body>
</html>