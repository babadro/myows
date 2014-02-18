<!--- 
 Filename: LoginCheck.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Validates a userÕs password entries
 Please Note Included by LoginForm.cfm
--->

<!--- Make sure we have Login name and Password --->
<cfparam name="FORM.userLogin" type="string">
<cfparam name="FORM.userPassword" type="string">

<!--- Find record with this Username/Password --->
<!--- If no rows returned, password not valid --->
<cfquery name="getUser" datasource="#APPLICATION.dataSource#">
 SELECT ContactID, FirstName
 FROM Contacts
 WHERE UserLogin = '#FORM.UserLogin#'
 AND UserPassword = '#FORM.UserPassword#'
</cfquery>

<!--- If the username and password are correct --->
<cfif getUser.recordCount eq 1>
 <!--- Remember userÕs logged-in status, plus --->
 <!--- ContactID and First Name, in structure --->
 <cfset SESSION.auth = structNew()>
 <cfset SESSION.auth.isLoggedIn = "Yes">
 <cfset SESSION.auth.contactID = getUser.contactID>
 <cfset SESSION.auth.firstName = getUser.firstName>

 <!--- Now that user is logged in, send them --->
 <!--- to whatever page makes sense to start --->
 <cflocation url="#CGI.script_name#?#CGI.query_string#">
</cfif>
