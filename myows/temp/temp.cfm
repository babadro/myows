<cfcookie
name = "Visit"
value = "#now()#"
expires = "30"
domain = "localhost"
path = "/exp/temp"
secure = "Yes">
<cfoutput>
	#cookie.Visit#	
</cfoutput>