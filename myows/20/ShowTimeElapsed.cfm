<cfset secsSinceStart = dateDiff("s", cookie.VisitStart, now())>
<cfset minutesElapsed = int(secsSinceStart / 60)>
<cfset secondsElapsed = secsSinceStart MOD 60>

<cfoutput>
	Minutes Elapsed:
	#minutesElapsed#:#numberFormat(secondsElapsed, "00")#
</cfoutput>