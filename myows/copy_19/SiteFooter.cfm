<!---
 Filename: SiteFooter.cfm
 Created by: Nate Weiss (NMW)
 Please Note Included in every page by OnRequestEnd.cfm
--->

<!--- Display copyright notice at bottom of every page --->
<cfoutput>
  <p class="footer">
  (c) #year(now())# #REQUEST.companyName#. All rights reserved.
  </p>
</cfoutput>

</body>
</html>
