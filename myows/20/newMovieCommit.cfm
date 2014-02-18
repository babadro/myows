<cfquery result="r">
	INSERT INTO Films (MovieTitle, PitchText, RatingID) VALUES (
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.MovWiz.MovieTitle#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.MovWiz.PitchText#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.MovWiz.RatingID#">)
</cfquery>
<cfset newId = r.generatedKey>

<cfquery>
	INSERT INTO FilmsDirectors(FilmID, DirectorID, Salary) VALUES (
	<cfqueryparam cfsqltype="cf_sql_integer" value="#newID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.MovWiz.DirectorID#">,
	0 )
</cfquery>

<cfloop list="#session.movWiz.actorIDs#" index="thisActor">
	<cfset isStar = thisActor eq session.movWiz.starActorId?1:0>
	<cfquery datasource="ows">
		INSERT INTO FilmsActors (FilmID, ActorID, Salary, IsStarringRole) VALUES (
		<cfqueryparam cfsqltype="cf_sql_integer" value="#newID#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#thisActor#">,
		0,
		<cfqueryparam cfsqltype="cf_sql_bit" value="#isStar#">
		)
	</cfquery>
</cfloop>

<cfset structDelete(session, "movWiz")>

<html>
<head><title>Movie Added</title></head>
<body>
	<h2>Movie Added</h2>
	<p>The movie has been added to the database.</p>
	<p><a href="newMovieWizard.cfm">Enter Another Movie</a></p>
</body>
</html>