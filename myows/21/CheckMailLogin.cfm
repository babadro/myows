<cfif isDefined("FORM.popServer")>
	<cfset SESSION.mail = structNEW()>
	<cfset SESSION.mail.popServer = FORM.popServer>
	<cfset SESSION.mail.username = FORM.username>
	<cfset SESSION.mail.password = FORM.password>
	
	<cfset CLIENT.mail.Server = FORM.popServer>
	<cfset CLIENT.mail.Username = FORM.username>
<cfelse>
	<cfparam name="CLIENT.mailServer" type="string" default= "">
	<cfparam name="CLIENT.mailUsername" type="string" default="">
	
	<cfform action="#CGI.script_name#" method="post">
	
		<p>Provide data<br>
		
		<p>Mail Server</p>
		<cfinput type="text" name="PopServer" value="#CLIENT.mailServer#"
		required="Yes" message="Please provide your mail server">
		(example: pop.yourcompany.com)<br>
		
		Mailbox Username:<br>
		<cfinput type="text" name="username" value="#CLIENT.mailUsername#" 
		required="Yes" message="Please provide your username.">
		(yourname@yourcompany.com)<br>
		
		Mailbox Password:<br>
		<cfinput type="password" name="password" required="yes"
		message="Please provide your password."><br>
		
		<cfinput type="submit" name="submit" value="Check Mail"><br>
	</cfform>
	
	</body></html>
	<cfabort>

</cfif>