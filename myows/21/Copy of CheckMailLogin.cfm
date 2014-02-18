<!--- 
 Filename: CheckMailLogin.cfm
 Author: Nate Weiss (NMW)
 Purpose: Provides a login form for the simple POP client
--->

<!--- If user is submitting username/password form --->
<cfif isDefined("FORM.popServer")>
 <!--- Retain username, password, server in SESSION --->
 <cfset SESSION.mail = structNew()>
 <cfset SESSION.mail.popServer = FORM.popServer>
 <cfset SESSION.mail.username = FORM.username>
 <cfset SESSION.mail.password = FORM.password>
 <!--- Remember server and username for next time ---> 
 <cfset CLIENT.mailServer = FORM.popServer>
 <cfset CLIENT.mailUsername = FORM.username>

<cfelse> 

 <!--- Use server/username from last time, if available --->
 <cfparam name="CLIENT.mailServer" type="string" default="">
 <cfparam name="CLIENT.mailUsername" type="string" default="">
 
 <!--- Simple form for user to provide mailbox info --->
 <cfform action="#CGI.script_name#" method="post">
 <p>To access your mail, please provide the 
 server, username and password.<br>
 
 <!--- FORM field: POPServer --->
 <p>Mail Server:<br>
 <cfinput type="text" name="popServer" 
 value="#CLIENT.mailServer#" required="Yes" 
 message="Please provide your mail server."> 
 (example: pop.yourcompany.com)<br>
 
 <!--- FORM field: Username ---> 
 Mailbox Username:<br>
 <cfinput type="text" name="username"
 value="#CLIENT.mailUsername#" required="Yes"
 message="Please provide your username."> 
 (yourname@yourcompany.com)<br>
 
 <!--- FORM field: Password ---> 
 Mailbox Password:<BR>
 <cfinput type="password" name="password"
 required="yes" 
 message="Please provide your password."><br>
 
 <cfinput type="submit" name="submit" value="Check Mail"><br>
 </cfform>
 
 </body></html>
 <cfabort>
</cfif>
