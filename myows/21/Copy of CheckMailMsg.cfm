<!--- 
 Filename: CheckMailMsg2.cfm
 Author: Nate Weiss (NMW)
 Purpose: Allows the user to view a message on their POP server
--->

<html>
<head><title>Mail Message</title></head>
<body>

<!--- Simple CSS-based formatting styles --->
<style>
 body { font-family:sans-serif;font-size:12px} 
 th { font-size:12px;background:navy;color:white} 
 td { font-size:12px;background:lightgrey;color:navy} 
</style>

<h2>Mail Message</h2>

<!--- A message uid must be passed in the URL --->
<cfparam name="URL.uid">
<cfparam name="URL.delete" type="boolean" default="no">


<!--- Store attachments in ÒAttach" subfolder --->
<cfset attachDir = expandPath("Attach")>
<!--- Set a variable to hold the Tab character --->
<cfset TAB = chr(9)>
 
<!--- Create the folder if it doesnÕt already exist --->
<cfif not directoryExists(attachDir)>
 <cfdirectory action="create" directory="#attachDir#">
</cfif>

<!--- If we donÕt have a username/password --->
<!--- send user to main CheckMail.cfm page --->
<cfif not isDefined("SESSION.mail.getMessages")>
 <cflocation url="CheckMail.cfm">
</cfif>

<!--- find our position in the query --->
<cfset position = listFindNoCase(valueList(SESSION.mail.getMessages.uid), URL.uid)>

<!--- If the user is trying to delete the message --->
<cfif url.delete>
 <!--- Contact POP Server and delete the message --->
 <cfpop action="Delete"
 uid="#URL.uid#"
 server="#SESSION.mail.popServer#"
 username="#SESSION.mail.username#"
 password="#SESSION.mail.password#">

 <!--- Send user back to main "Check Mail" page ---> 
 <cflocation url="CheckMail.cfm?refresh=Yes">

<!--- If not deleting, retrieve and show the message --->
<cfelse>

 <!--- Contact POP Server and retrieve the message --->
 <cfpop action="GetAll" name="GetMsg"
 uid="#URL.uid#"
 server="#SESSION.mail.popServer#"
 username="#SESSION.mail.username#"
 password="#SESSION.mail.password#"
 attachmentPath="#attachDir#"
 generateUniqueFilenames="Yes">
 
 <!--- Parse messageÕs date string to CF Date value ---> 
 <cfset msgDate = parseDateTime(getMsg.Date, "POP")> 
 
 <!--- If message was not retrieved from POP server ---> 
 <cfif getMsg.recordCount neq 1>
 <cfthrow 
 message="Message could not be retrieved."
 detail="Perhaps the message has already been deleted.">
 </cfif> 
 
 <!--- We will provide a link to Delete message --->
 <cfset deleteURL = "#CGI.script_name#?uid=#uid#&delete=Yes">
 
 <!--- Display message in a simple table format ---> 
 <table border="0" cellSpacing="0" cellPadding="3">
 <cfoutput>
 <tr>
 <th bgcolor="wheat" align="left" nowrap>
 Message #position# of #SESSION.mail.getMessages.recordCount#
 </th>
 <td align="right" bgcolor="beige">
 <!--- Provide "Back" button, if appropriate ---> 
 <cfif position gt 1>
 <cfset prevuid = SESSION.mail.getMessages.uid[decrementValue(position)]>
 <a href="CheckMailMsg.cfm?uid=#prevuid#">
 <img src="../images/browseback.gif" 
 width="40" height="16" alt="Back" border="0"></a>
 </cfif>
 <!--- Provide "Next" button, if appropriate --->
 <cfif position lt SESSION.mail.getMessages.recordCount>
 <cfset nextuid = SESSION.mail.getMessages.uid[incrementValue(position)]>
 <a href="CheckMailMsg.cfm?uid=#nextuid#">
 <img src="../images/browsenext.gif" 
 width="40" height="16" alt="Next" border="0"></a>
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
 <th align="right">Date:</th>
 <td>#dateFormat(msgDate)# #timeFormat(msgDate)#</td>
 </tr>
 <tr>
 <th align="right">Subject:</th>
 <td>#getMsg.Subject#</td>
 </tr>
 <tr>
 <td bgcolor="beige" colspan="2">
 <strong>Message:</strong><br>
 
 <cfif getMsg.Header contains "Content-Type: text/html">
 #getMsg.Body# 
 <cfelse>
 #htmlCodeFormat(getMsg.Body)#
 </cfif>
 </td>
 </tr>
 <!--- If this message has any attachments --->
 <cfset numAttachments = listLen(getMsg.Attachments, TAB)>
 <cfif numattachments gt 0>
 <tr>
 <th align="right">Attachments:</th>
 <td>
 <!--- For each attachment, provide a link --->
 <cfloop from="1" to="#numAttachments#" index="i">
 <!--- Original filename, as it was attached to message --->
 <cfset thisFileOrig = listGetAt(getMsg.Attachments, i, TAB)>
 <!--- Full path to file, as it was saved on this server --->
 <cfset thisFilePath = listGetAt(getMsg.attachmentFiles, i, TAB)>
 <!--- Relative URL to file, so user can click to get it --->
 <cfset thisFileURL = "Attach/#getFileFromPath(thisFilePath)#">
 <!--- Actual link --->
 <a href="#thisFileURL#">#thisFileOrig#</a><br>
 </cfloop>
 </td>
 </tr>
 </cfif>
 </cfoutput>
 </table> 

 <cfoutput> 
 <!--- Provide link back to list of messages --->
 <strong><a href="CheckMail.cfm">Back To Message List</a></strong><br>
 <!--- Provide link to Delete message --->
 <a href="#deleteURL#">Delete Message</a><br>
 <!--- "Log Out" link to discard SESSION.Mail info --->
 <a href="CheckMail.cfm?logout=Yes">Log Out</a><br>
 </cfoutput>

</cfif>


</body>
</html>
