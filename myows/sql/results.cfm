<!--- Init variables --->
<cfparam name="FORM.datasource" default="#APPLICATION.datasource_default#">
<cfparam name="FORM.sql" default="">

<!--- If no SQL, quit --->
<cfif Trim(FORM.sql) IS "">
	<cfabort>
</cfif>

<body>

<!--- Check if only SELECT allowed --->
<!---><cfif APPLICATION.select_only>
	<!--- Check first word is SELECT --->
	<cfif ListFirst(FORM.sql, " #Chr(10)##Chr(13)#") NEQ "SELECT">
		<!--- Abort --->
		<h1>Only SELECT statements are allowed</h1>
		<cfabort>
	</cfif>
</cfif>

--->

<!--- Try/catch block --->
<cftry>
	<!--- Execute SQL --->
	<cfquery name="query" result="result" datasource="#FORM.datasource#" debug="no">
	#PreserveSingleQuotes(FORM.sql)#
	</cfquery>
	<!--- Number of results --->
	<cfoutput><strong>#result.RecordCount# #IIf(result.RecordCount IS 1, DE("Row"), DE("Rows"))# Returned</strong></cfoutput>
	<!--- Dump results --->
    <cfif IsDefined("query")>
		<cfdump var="#query#">
	<cfelse>
		<cfdump var="#result#">
	</cfif>
	<!--- Catch errors --->
	<cfcatch>
		<!--- Something went wrong --->
		<cfoutput><h1>#CFCATCH.Message#</h1><h3>#CFCATCH.Detail#</h3></cfoutput>
		<!--- Provide extra hints, if possible --->
		<cfif FindNoCase("Too few parameters", CFCATCH.Detail)>
			Hint: This usually means you've mistyped a column name or have missed a comma.
		<cfelseif FindNoCase("missing operator", CFCATCH.Detail)>
			Hint: Make sure that you have not missed a comma or mistyped a keyword.
		</cfif>
	</cfcatch>
</cftry>

</body>
