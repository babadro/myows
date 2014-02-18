<!--- EXAMPLE 1: Creating and Renaming
Check that the directory exists to avoid getting a ColdFusion error message. --->
<cfset newDirectory = "otherNewDir">
<cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & "newDir">
<!--- Check whether the directory exists. --->
<cfif DirectoryExists(currentDirectory)>
<!--- If yes, rename the directory. --->
<cfdirectory action = "rename" directory = "#currentDirectory#"
newDirectory = "#newDirectory#" >
<cfoutput>
<p>The directory existed and the name has been changed to: #newDirectory#</p>
</cfoutput>
<cfelse>
<!--- If no, create the directory. --->
<cfdirectory action = "create" directory = "#currentDirectory#" >
<cfoutput><p>Your directory has been created.</p></cfoutput>
</cfif>
<!--- EXAMPLE 2: Deleting a directory
Check that the directory exists and that files are not in the directory to avoid getting ColdFusion error messages. --->
<cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & "otherNewDir">
<!--- Check whether the directory exists. --->
<cfif DirectoryExists(currentDirectory)>
<!--- If yes, check whether there are files in the directory before deleting. --->
<cfdirectory action="list" directory="#currentDirectory#"
name="myDirectory">
<cfif myDirectory.recordcount gt 0>
<!--- If yes, delete the files from the directory. --->
<cfoutput>
<p>Files exist in this directory. Either delete the files or code
something to do so.</P>
</cfoutput>
<cfelse>
<!--- Directory is empty - just delete the directory. --->
<cfdirectory action = "delete" directory = "#currentDirectory#">
<cfoutput>
<p>The directory existed and has been deleted.</P>
</cfoutput>
</cfif>
<cfelse>
<!--- If no, post message or do some other function. --->
<cfoutput><p>The directory did NOT exist.</p></cfoutput>
</cfif>
<!---EXAMPLE 3: List directories
The following example creates both an array of directory names and a query that contains entries for the directories only. --->
<cfdirectory directory="C:/temp" name="dirQuery" action="LIST">
<!--- Get an array of directory names. --->
<cfset dirsArray=arraynew(1)>
<cfset i=1>
<cfloop query="dirQuery">
<cfif dirQuery.type IS "dir">
<cfset dirsArray[i]=dirQuery.name>
<cfset i = i + 1>
</cfif>
</cfloop>
<cfdump var="#dirsArray#">
<br>
<!--- Get all directory information in a query of queries.--->
<cfquery dbtype="query" name="dirsOnly">
SELECT * FROM dirQuery
WHERE TYPE='Dir'
</cfquery>
<cfdump var="#dirsOnly#">