<html>
	<head>
		<title>Mailing List</title>
		<style>
			th {background: blue; color:white; font-family: sans-serif; font-size:12px;
			text-align:right; padding: 5px;}
		</style>
</head>
<body>
	
<h2>Send Message To Miling List</h2>
<cfif isDefined("form.subject")>
	<cfquery name="getList">
		SELECT FirstName, LastName, Email FROM Contacts WHERE MailingList = 1
	</cfquery>
	<cfmail query="getList" subject="#fofm.subject#" from="""Orange Whip Studios"" <mailings@orangewhipstudios.com>"
	to="""#FirstName# #LastName#"" <#Email#>" bcc="personneldirector@orangewhipstudios.com">
		#FORM.messageBody#
	</cfmail>
	<p>The email message was sent.</p><br>
<cfelse>
	<cfform action="#cgi.script_name#" name="mailForm" method="POST">
		<table cellPadding="2" cellSpacing="2">
			<tr>
				<th>Subject:</th>
				<td>
					<cfinput type="text" name="subject" required="yes" size="40"
					message="You must profide a subject for the email.">
				</td>
			</tr>
			<tr>
				<th>Your Message:</th>
				<td>
					<cftextarea name="messageBody" cols="30" rows="5" wrap="hard" required="yes"
					message="You must provide a message body."/>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="submit" value="Send Message Now"></td>
			</tr>			
		</table>
	</cfform>
</cfif>

</body>
</html>
