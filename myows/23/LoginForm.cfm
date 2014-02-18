<!--- 
 Filename: LoginForm.cfm
 Created by: Nate Weiss (NMW)
 Purpose: Presented whenever a user has not logged in yet
 Please Note Included by Application.cfc
--->

<!--- If the user is now submitting ÒLoginÓ form, --->
<!--- Include ÒLogin CheckÓ code to validate user --->
<cfif isDefined("FORM.UserLogin")> 
 <cfinclude template="LoginCheck.cfm">
</cfif>



<html>
<head>
 <title>Please Log In</title>
</head>

<!--- Place cursor in "User Name" field when page loads--->
<body onLoad="document.LoginForm.userLogin.focus();">

<!--- Start our Login Form --->
<cfform action="#CGI.script_name#?#CGI.query_string#" name="LoginForm" method="post">
 <!--- Make the UserLogin and UserPassword fields required --->
 <input type="hidden" name="userLogin_required">
 <input type="hidden" name="userPassword_required">
 <!--- Use an HTML table for simple formatting --->
 <table border="0">
 <tr><th colspan="2" bgcolor="silver">Please Log In</th></tr>
 <tr>
 <th>Username:</th>
 <td>
 
 <!--- Text field for "User Name" ---> 
 <cfinput 
 type="text"
 name="userLogin"
 size="20"
 value=""
 maxlength="100"
 required="Yes"
 message="Please type your Username first.">

 </td>
 </tr><tr>
 <th>Password:</th>
 <td>
 
 <!--- Text field for Password ---> 
 <cfinput 
 type="password"
 name="userPassword"
 size="12"
 value=""
 maxlength="100"
 required="Yes"
 message="Please type your Password first.">

 <!--- Submit Button that reads "Enter" ---> 
 <input type="Submit" value="Enter">
 
 </td>
 </tr>
 </table>
 
</cfform>

</body>
</html>
