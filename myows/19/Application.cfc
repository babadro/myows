<cfcomponent output = "false">
	<cfset this.name = "ows19">
	
	<cffunction name="onApplicationStart" returnType= "boolean" output="false">
		<cfset appStarted = now()>
		<return True>
	</cffunction>
	
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="appScope" required="true">
		<cflog file=#this.name# text=
		"Application ended after #dateDiff('n', arguments.appScope.appStarted, now())# minutes.">
	</cffunction>
	
	<cffunction name="onRequestStart" returnType="boolean" output="True">
		<cfset REQUEST.companyName="OWS Orange Whip Studios">
		<cfset REQUEST.dataSource="ows">
		<cfif not isDefined("URL.print")>
			<cfinclude template="SiteHeader.cfm">
		</cfif>
		<cfreturn True>
	</cffunction>
	
	<cffunction name="onRequestEnd" returnType="void" output="True">
		<cfif not isDefined("URL.print")>
			<cfinclude template="SiteFooter.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name = "onRequest" returnType = "void" output = "true">
		<cfargument name = "targetPage" type = "string" required = "true">
		<cfset var content = "">
		
		<cfif not isDefined("URL.print")>
			<cfinclude template = "#arguments.targetPage#">
		<cfelse>
			<cfsavecontent variable = "content">
				<cfinclude template = "#arguments.targetPage#">
			</cfsavecontent>
			<cfset content = reReplace(content, "<.*?>", "", "all")>
			<cfoutput><pre>#content#</pre></cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="Exception" required="true">
		<cfargument name="eventName" type="string" required="true">
		<cfif arguments.eventName is "">
			<cflog file="#this.name#" type="error" text=
			"#arguments.exception.message#">
		<cfelse>
			<cflog file="#this.name#" type="error" text=
			"Error in method [#arguments.eventName#] #arguments.exception.message#">
		</cfif>
		<cfthrow object = "#arguments.exception#">
	</cffunction>
	
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetPage" type="string" required="true">
		<cflog file="#this.name#" text="Missing Template: #arguments.targetPage#">
		<cflocation url="404.cfm?missingtemplate=#urlEncodedFormat(arguments.targePage)#"
		addToken="False">
	</cffunction>

</cfcomponent>