<!--- 
 Filename: SiteHeader.cfm 
 Created by: Nate Weiss (NMW)
 Please Note Included in every page by Application.cfc
--->

<html>
<head>
<title><cfoutput>#REQUEST.companyName#</cfoutput></title>
<style>
.header {
  font-size: 18px;
  font-family: sans-serif;
}
.footer { 
  font-size: 10px;
  color: silver;
  font-family: sans-serif;
}
body {
  font-family: sans-serif;
}
.error {
  color: gray;
}
</style>
</head>

<body>

<!--- Company Logo --->
<img src="../images/logo_c.gif" width="101" height="101" alt="" 
     align="absmiddle" border="0">
<cfoutput><span class="header">#REQUEST.companyName#</span></cfoutput>
<br clear="left">
