<cfif isDefined("form.searchCriteria")>
	<cfset client.lastSearch = form.searchcriteria>
	<cfset client.lastMaxRows = form.searchMaxRows>
<cfelseif isDefined("client.lastSearch") and
isDefined("client.lastMaxRows")>
	<cfset searchCriteria = client.lastSearch>
	<cfset searchCriteria = client.lastSearch>
	<cfset searchMaxRows = client.lastMaxRows>
<cfelse>
	<cfset searchCriteria = "">
	<cfset searchMaxRows = 10>
</cfif>

<html>
<head><title>Search Orange Whip</title></head>
<body>
	<h2>Search Orange Whip</h2>
	<cfoutput>
		<form action = "#cgi.script_name#" method = "post">
			<input name = "SearchCriteria" value = "#searchCriteria#">
			<i>
				show up to
				<input name = "SearchMaxRows" value = "#searchMaxRows#" size = "2">
				matches
			</i>
			<br>
			<input type = "Submit" value = "Search">
			<br>
		</form>
	</cfoutput>
	
	<cfif searchCriteria neq "">
		<cfquery name = "getMatches">
			SELECT FilmID, MovieTitle, Summary
			FROM Films
			WHERE MovieTitle LIKE
			<cfqueryparam cfsqltype = "cf_sql_varchar" value = "%#SearchCriteria#%">
			OR Summary LIKE
			<cfqueryparam cfsqltype = "cf_sql_varchar" value = "%#SearchCriteria#%">
			ORDER BY MovieTitle
		</cfquery>
		
		<cfoutput>
			<hr>
			<i>#getMatches.RecordCount# record found for "#searchCriteria#"</i>
			<br>
		</cfoutput>
		<cfoutput query = "getMatches" maxrows = "#searchMaxRows#">
			<p><b>#MovieTitle#</b></p><br>
			#Summary#<br>
		</cfoutput>
	</cfif>

</body>
</html>