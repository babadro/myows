<html>
<head>
	<title>Personnel Office Mailer</title>
	<style>ht {background: blue; colof:white; text-align: right;}</style>
	<script language = "javaScript">
		function guessEmail() {
			var guess;
			
			with (document.mailForm) {
					guess = firstName.value.substr(0,1) + lastName.value;
					toAddress.value = guess.toLowerCase();	
			};
		};
	</script>
</head>
<body 
	<cfif not isDefined("form.subject")>
		onLoad = "document.mailForm.firstName.focus()"
	</cfif>	
>
<h2>Personnel Office Mailer</h2>
<cfif isDefined("form.subject")>
	<cfset recipEmail = listFirst(form.toAddress, "@") & "@orangewhipstudios.com">
	
	<cfprocessingdirective suppressWhitespace="No">
		<cfmail
				subject = "#form.subject#"
				from = """Personnel Office"" <baba_dro@mail.ru>"
				to = """#form.firstName# #form.lastName#"" <#recipEmail#>"
				bcc = "bontpost@gmail.com">
				This is a message from the Personnel Office: 
				#uCase(form.subject)#
				#form.messageBody#
				
				If you hava any questions about this message, please write back or call us
				at extenstion 352. Thanks!			
		</cfmail>
	</cfprocessingdirective>
	<p>The Email message was sent.</br></p>
<cfelse>
	<cfform action = "#cgi.script_name#" method = "post">
		<table cellPadding = "2" cellSpacing = "2">
			<tr>
				<th>Recipient's Name:</th>
				<td>
					<cfinput type = "text" name = "firstName" required = "yes" size = "15"
					message = "You must provide a first name."
					onChange = "quessEmail()">
					
					<cfinput type = "text" name = "lastName" required = "yes" size = "20"
					message = "You must provide a last(?) name."
					onChange = "guessEmail()">	
				</td>
			</tr>
			<tr>
				<th>Email Address</th>
				<td>
					<cfinput type = "text" name = "toAddress" required = "yes" size = "20"
					message = "You must provide the recipient's email.">@orangewhipstudios.com
				</td>
			</tr>
			
			<tr>
				<th>Subject:</th>
				<td>
					<cfselect name = "subject">
						<option>Sorry, but you have been fired.
						<option>Congratulations! You got a raise!
						<option>Just FYI, you have hit the glass ceiling.
						<option>The company dress code, Capri Pants, and you
						<option>All your Ben Forta are belong to us.
					</cfselect>
				</td>
			</tr>
			
			<tr>
				<th>Your Message:</th>
				<td>
					<cftextarea name = "messageBody" cols = "30" rows = "5" wrap = "hard"
					required = "yes" message = "You must provide a message body."/>
				</td>
			</tr>
					
			<tr>
				<td>&nbsp;</td>
				<td>
					<cfinput type = "submit" name = "submit" value = "Send Message Now">	
				</td>
			</tr>
		</table>
	</cfform>
</cfif>
</body>
</html>