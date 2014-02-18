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

<!--- If user is logging out, ---> 
<!--- or if user is submitting a different username/password --->
<cfif isDefined("URL.logout") or isDefined("FORM.popServer")>
 <cfset structDelete(SESSION, "mail")>
</cfif>

<!--- If we donÕt have a username/password --->
<cfif not isDefined("SESSION.mail")>
 <!--- Show "mail server login" form --->
 <cfinclude template="CheckMailLogin.cfm">
</cfif>

<!--- If we need to contact server for list of messages --->
<!--- (if just logged in, or if clicked "Refresh" link) --->
<cfif not isDefined("SESSION.mail.getMessages") or isDefined("URL.refresh")>
 <!--- Flush page output buffer --->
 <cfflush>

 <!--- Contact POP Server and retieve messages --->
 <cfpop action="GetHeaderOnly" name="SESSION.mail.getMessages"
 server="#SESSION.mail.popServer#"
 username="#SESSION.mail.username#" password="#SESSION.mail.password#"
 maxrows="50">
</cfif> 

 
<!--- If no messages were retrieved... --->
<cfif SESSION.mail.getMessages.recordCount eq 0>
 <p>You have no mail messages at this time.<br>
 
<!--- If messages were retrieved... ---> 
<cfelse>
 <!--- Display Messages in HTML Table Format ---> 
 <table border="0" cellSpacing="2" cellSpacing="2" cols="3" width="550">
 <!--- Column Headings for Table --->
 <tr>
 <th width="100">Date Sent</th>
 <th width="200">From</th>
 <th width="200">Subject</th>
 </tr>
 <!--- Display info about each message in a table row --->
 <cfoutput query="SESSION.mail.getMessages">
 <!--- Parse Date from the "date" mail header --->
 <cfset msgDate = parseDateTime(date,"pop")>
 <!--- Let user click on Subject to read full message --->
 <cfset linkURL = "CheckMailMsg.cfm?uid=#urlEncodedFormat(uid)#">

 <tr valign="baseline">
 <!--- Show parsed Date and Time for message--->
 <td>
 <strong>#dateFormat(msgDate)#</strong><br>
 #timeFormat(msgDate)# #ReplyTo#
 </td>
 <!--- Show "From" address, escaping brackets --->
 <td>#htmlEditFormat(From)#</td>
 <td><strong><a href="#linkURL#">#Subject#</a></strong></td>
 </tr> 
 </cfoutput>
 </table>
 
</cfif>

<!--- "Refresh" link to get new list of messages --->
<strong><a href="CheckMail.cfm?Refresh=Yes">Refresh Message List</a></strong><br>
<!--- "Log Out" link to discard SESSION.Mail info --->
<a href="CheckMail.cfm?Logout=Yes">Log Out</a><br>


</body>
</html>
