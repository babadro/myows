<!--- 
 Filename: Application.cfc
 Created by: Raymond Camden (ray@camdenfamily.com)
 Please Note Executes for every page request
--->

<cfcomponent output="false">

  <!--- Name the application. --->
  <cfset this.name="OrangeWhipSite">
  <!--- Turn on session management. --->
  <cfset this.sessionManagement=true>
  <cfset this.clientManagement=true>
    
  <cffunction name="onSessionEnd" output="false" returnType="void">
    <!--- Look for attachments to delete --->
    
    <cfset var attachDir = expandPath("Attach")>
    <cfset var getFiles = "">
    <cfset var thisFile = "">

    <!--- Get a list of all files in the directory --->
    <cfdirectory directory="#attachDir#" name="getFiles">
  
    <!--- For each file in the directory ---> 
    <cfloop query="getFiles">
      <!--- If itÕs a file (rather than a directory) --->
      <cfif getFiles.type neq "Dir">
        <!--- Get full filename of this file --->
        <cfset thisFile = expandPath("Attach\ #getFiles.Name#")>
      
        <!--- Go ahead and delete the file --->
        <cffile action="delete" file="#thisFile#">
      </cfif>
    </cfloop>

  </cffunction>
  
</cfcomponent>
