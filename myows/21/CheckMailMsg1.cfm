<html>
<head><title>Mail Message</title></head>
<body>
<style>
	body { font-family:sans-serif;font-size:12px}
	th { font-size:12px;background:navy;color:white}
	td { font-size:12px;background:lightgrey;color:navy}
</style>

<h2>Mail Message</h2>
<cfparam name="url.uid">
<cfparam name="url.delete" type="boolean" default="no">

<cfif not isDefined("session.mail.getMessages")>
	<cflocation url="CheckMail.cfm">
</cfif>

<cfset position = listFindNoCase(valueList(session.mail.getMessages.uid), url.uid)>

<cfif url.delete>
	<cfpop action="Delete" uid="#url.uid#" server="#session.mail.popServer#" username="#session.mail.username#"
	password="#session.mail.password#">
	<cflocation url="CheckMail.cfm?refresh=Yes" addToken="false">
<cfelse>
	<cfpop action="GetAll" name="GetMsg" uid="#url.uid#" server="#session.mail.popServer#"
	username="#session.mail.username#" password="#session.mail.password#">
	<cfset msgDate = parseDateTime(getMsgDate, "pop")>
	
	<cfif getMsg.recordCount neq 1>
		<cfthrow message="Message could not be retrieved." detail="Perhaps the message has alredy been deleted.">
	</cfif>
	
	<cfset deleteurl="#cgi.script_name#?uid=#uid#&delete=Yes">
	
	<table border="0" cellSpacing="0" cellPadding="3">
		<cfoutput>
			<tr>
				<th bgcolor="wheat" align="left" nowrap>
					Message #position# of #session.mail.getMessages.recordCount#
				</th>
				<td align="right" bgcolor="beige">
					<cfif position gt 1>
						<cfset prevuid = session.mail.getMessages.uid[decrementValue(position)]>
						<a href="CheckMailMsg.cfm?uid=#prevuid#">
							<img src="../images/browseback.gif" width="40" height="16" alt="Next" border="0">
						</a>
					</cfif>
				</td>
			</tr>
			<tr>
				<th align="right">From:</th>
				<td>#htmlEditFormat(getMsg.From)#</td>
			</tr>
			<cfif getMsg.CC neq "">
				<tr>
					<th align="right">CC:</th>
					<td>#htmlEditFormat(getMsg.CC)#</td>
				</tr>
			</cfif>
			<tr>
				<th align="right">Subject:</th>
				<td>#getMsg.Subject#</td>
				<td bgcolor="beige" colspan="2">
					<strong>Message:</strong><br>
					<cfif len(getMsg.htmlBody)>
						#getMsg.htmlBody#
					<cfelse>
						#htmlCodeFormat(getMsg.textBody)#
					</cfif>
				</td>
			</tr>
		</cfoutput>
	</table>
	
	<cfoutput>
		<strong><a href="checkMail.cfm">Back to Message List</a></strong><br>
		<a href="#deleteurl#">Delete Message</a><br>
		<a href="checkMail.cfm?Logout=Yes">Log Out</a><br>
	</cfoutput>
	
</cfif>

</body>
</html>