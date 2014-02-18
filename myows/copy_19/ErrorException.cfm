<html>
<head><title> Error </title></head>
<body>
<h2>
	Кто знает, но почему-то ошибка...
</h2>
<p>
	Показывается шаблон ErrorException
</p>

<cfif error.mailTo neq "">
	<cfmail to = "#error.mailTo#" from = "errorsender@orangewehipstudios.com"
	subject = "Error on Page #error.Template#">
		Error Date/Time: #error.dateTime#
		User`s Browser: #error.browser#
		URL Parameters: #error.queryString#
		Previous Page:	#error.HTTPReferer#
		------------------------------------
		 #ERROR.diagnostics#
	</cfmail>
</cfif>

<img src="../images/logo_b.gif" width = "73" height = "73" alt = "" border = "0">
<cfoutput>
 #ERROR.diagnostics#
</cfoutput>
