<h3>ParseDateTime Example</h3>
<cfif IsDefined("form.theTestValue")>
<cfif IsDate(form.theTestValue)>
<h3>The expression <cfoutput>#DE(form.theTestValue)#</cfoutput> is a valid date</h3>
<p>The parsed date/time is:
<cfoutput>#ParseDateTime(form.theTestValue)#</cfoutput>
<cfelse>
<h3>The expression <cfoutput>#DE(form.theTestValue)#</cfoutput> is not a valid date</h3>
</cfif>
</cfif>
<form action="#CGI.ScriptName#" method="POST">
<p>Enter an expression, and discover if it can be evaluated to a date value.
<input type="Text" name="TheTestValue" value="<CFOUTPUT>#DateFormat(Now())#
#TimeFormat(Now())#</CFOUTPUT>">
<input type="Submit" value="Parse the Date" name="">
</form>