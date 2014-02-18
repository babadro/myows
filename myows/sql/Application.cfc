<cfcomponent>

	<cfset THIS.name="OWS_SQL">
	<!--- To restrict access by IP address specify the allowed client IP address here --->
	<cfset THIS.restrict_ip="127.0.0.1,0:0:0:0:0:0:0:1">
	<!--- Set to "yes" to only allow SELECT statements, "No" for all --->
	<cfset THIS.select_only="No">
    

	<cffunction name="onApplicationStart">
		<!--- To prompt for data source set this to "yes"> --->
		<cfset APPLICATION.datasource_prompt="no">
		<!--- Specify a default data source --->
		<cfset APPLICATION.datasource_default="ows">
		<!--- Set SELECT ONLY flag --->
		<cfset APPLICATION.select_only=THIS.select_only>
	</cffunction>


	<cffunction name="onRequestStart" returntype="boolean">
		<cfset var result=TRUE>
		<!--- Check IP address --->
		<cfif (THIS.restrict_ip NEQ "") AND (ListFind(THIS.restrict_ip, CGI.remote_addr) IS 0)>
			<!--- Access not allowed --->
            <cfset result=FALSE>
		</cfif>
		<cfreturn result>
    </cffunction>

</cfcomponent>