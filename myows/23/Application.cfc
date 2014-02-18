<cfcomponent output="false">
<!--- name the application. --->
<cfset this.name="OrangeWhipSite">
<!--- Turn on session management. --->
<cfset this.sessionManagement=true>
<!--- Default datasource --->
<cfset this.dataSource="ows">
<cffunction name="onApplicationStart" output="false" returnType="void">
<!--- Any variables set here can be used by all our pages --->
<cfset application.companyname = "Orange Whip Studios">
</cffunction>
<cffunction name="onRequestStart" output="false" returnType="void">
<!--- If user isn’t logged in, force them to now --->
<cfif not isDefined("session.auth.isLoggedIn")>
<!--- If the user is now submitting "Login" form, --->
<!--- Include "Login Check" code to validate user --->
<cfif isDefined("form.UserLogin")>
<cfinclude template="loginCheck.cfm">
</cfif>
<cfinclude template="loginForm.cfm">
<cfabort>
</cfif>
</cffunction>
</cfcomponent>