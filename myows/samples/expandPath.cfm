
<h3>ExpandPath Example</h3>
<cfset thisPath=ExpandPath("*.*")>
<cfset thisDirectory=GetDirectoryFromPath(thisPath)>
<cfoutput>
The current directory is: #GetDirectoryFromPath(thisPath)#
<cfif IsDefined("form.yourFile") AND form.yourFile is not "">
<cfset yourFile = form.yourFile>
<cfif FileExists(ExpandPath(yourfile))>
<p>Your file exists in this directory. You entered
the correct filename, #GetFileFromPath("#thisPath#/#yourfile#")#
<cfelse>
<p>Your file was not found in this directory:
<br>Here is a list of the other files in this directory:
<!--- use cfdirectory to give the contents of the
snippets directory, order by name and size --->
<cfdirectory directory="#thisDirectory#" name="myDirectory" sort="name ASC, size DESC">
<!--- Output the contents of the cfdirectory as a cftable --->
<cftable query="myDirectory">
<cfcol header="NAME:"
text="#Name#">
<cfcol header="SIZE:"
text="#Size#">
</cftable>
</cfif>
</cfif>
</cfoutput>
<form action="expandpath.cfm" method="post">
<h3>Enter the name of a file in this directory <i>
<font size="-1">(try expandpath.cfm)</font></i></h3>
<input type="text" name="yourFile">
<input type="submit" name="">
</form>