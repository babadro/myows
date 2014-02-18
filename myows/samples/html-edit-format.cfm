<!--- This example shows the effects of HTMLCodeFormat and
HTMLEditFormat. View it in your browser, then View it
using your browser's the View Source command. --->
<cfset testString="This is a test
& this is another
<This text is in angle brackets>
Previous line was blank!!!">
<cfoutput>
<h3>The text without processing</h3>
#testString#<br>
<h3>Using HTMLCodeFormat</h3>
#HTMLCodeFormat(testString)#
<h3>Using HTMLEditFormat</h3>
#HTMLEditFormat(testString)#
</cfoutput>