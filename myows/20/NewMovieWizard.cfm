<cfset numberOfSteps = 5>

<cfif not isDefined("session.movWiz")>
	<cfset session.movWiz = structNew()>
	<cfset session.movWiz.stepNum = 1>
	<cfset session.movWiz.movieTitle = "">
	<cfset session.movWiz.pitchText = "">
	<cfset session.movWiz.directorID = "">
	<cfset session.movWiz.ratingID = "">
	<cfset session.movWiz.actorIDs = "">
	<cfset session.movWiz.starActorID = "">
</cfif>

<cfif isDefined("form.movieTitle")>
	<cfset session.movWiz.movieTitle = form.movieTitle>
	<cfset session.movWiz.pitchText = form.pitchText>
	<cfset session.movWiz.ratingID = form.ratingID>
<cfelseif isDefined("form.directorID")>
	<cfset session.movWiz.directorID = form.directorID>
<cfelseif isDefined("form.actorID")>
	<cfset session.movWiz.actorIDs = form.actorID>
<cfelseif isDefined("form.starActorID")>
	<cfset session.movWiz.starActorID = form.starActorID>	
</cfif>

<cfif isDefined("form.goBack")>
	<cfset session.movWiz.stepNum = url.stepNum - 1>
<cfelseif isDefined("form.goNext")>
	<cfset session.movWiz.stepNum = url.stepNum + 1>
<cfelseif isDefined("form.goDone")>
	<cflocation url = "NewMovieCommit.cfm">
</cfif>

<html>
<head><title>New Movie Wizard</title></head>
<body>
	<cfoutput>
	<b>New Movie Wizard</b><br>
	Step #session.movWiz.StepNum# of #NumberOfSteps#<br>
	</cfoutput>
	
	<cfform action = "NewMovieWizard.cfm?StepNum=#session.movWiz.stepNum#" method = "post">
		<cfswitch expression="#session.movWiz.stepNum#">
		
		<cfcase value = "1">
		<cfquery name = "getRatings" datasource = "ows">
			SELECT RatingID, Rating FROM FilmsRatings ORDER BY RatingID
		</cfquery>
		What is the title of the movie?<br>
		<cfinput name = "MovieTitle" SIZE = "50" VALUE = "#session.movWiz.MovieTitle#">
		<p>What is the "pitch" or "on-liner" for the movie?<br></p>
		<cfinput name = "pitchText" SIZE = "50"	value = "#session.movWiz.pitchText#">
		<p>Please select the rating:<br></p>
		<cfloop query = "getRatings">
			<cfset isChecked = ratingID EQ session.movWiz.ratingID>
			<cfinput type="radio" name="ratingID" checked="#isChecked#" value="#ratingID#">
			<cfoutput>#rating#<br></cfoutput>
		</cfloop>
		</cfcase>
		
		<cfcase value = "2">
		<cfquery name = "getDirectors">
			SELECT DirectorID, FirstName || ' ' || LastName As FullName FROM Directors
			ORDER BY LastName
		</cfquery>
		Who will be directing the movie?<br>
		<cfselect
		size = "#getDirectors.recordCount#"
		query = "getDirectors"
		name = "directorID"
		display = "FullName"
		Value = "directorID"
		selected = "#session.movWiz.directorID#"/>
		</cfcase>
		
		<cfcase value = "3">
		<cfquery name = "getActors" datasource = "ows">
			SELECT * FROM Actors Order BY NameLast
		</cfquery>
		What Actors will be in the movie?<br>
		<cfloop query = "GetActors">
			<cfset isChecked = listFind(session.movWiz.actorIDs, actorID)>
			<cfinput type="checkbox" name="actorID" value="#actorID#" checked="#isChecked#">
			<cfoutput>#nameFirst# #nameLast#</cfoutput><br>
		</cfloop>
		
		</cfcase>
		
		<cfcase value="4">
		<cfif session.movWiz.actorIDs EQ "">
			Please go back to he last step and choose at least one actor or actress
			to be in the movie.
		<cfelse>
			<cfquery name = "getActors" DATASOURCE = "ows">
				SELECT * FROM Actors WHERE ActorID IN (#session.movWiz.ActorIDs#)
				Order BY NameLast
			</cfquery>
		Which on of the actors will get top billing?<br>
			<cfloop query = "getActors">
				<cfset isChecked = session.movWiz.starActorID EQ actorID>
				<cfinput type="radio" name="starActorID"
				value="#actorID#" checked="#isChecked#">
				<cfoutput>#nameFirst# #nameLast#</cfoutput><br>
			</cfloop>
			
		</cfif>
		
		</cfcase>
		
		<cfcase value = "5">
		You have succesfully finished the New Movie Wizard.<br>	
		Click hte Finish button to Add the movie to the database.<br>
		Click Back if you need to change anything.<br>
		</cfcase>
		
		</cfswitch>
		
		<p>
		<cfif session.movWiz.stepNum GT 1>
			<input type = "submit" name = "goBack" value = "&lt;&lt; Back">
		</cfif>
		<cfif session.movWiz.stepNum lt numberOfSteps>
			<input type = "submit" name = "gonext" value="Next &gt;&gt;">
		<cfelse>
			<input type="submit" name="goDone" value = "Finish">
		</cfif>
		</p>
	</cfform>
</body>
</html>