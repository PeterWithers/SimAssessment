<a href="student-comments.cfm">Edit Student Comments</a>&nbsp;|&nbsp;<a href="mentor-comments.cfm">Edit Mentor Comments</a>&nbsp;|&nbsp;<a href="report-comments.cfm">Edit Report Comments</a>
<br>
<br>

<cfif isdefined("approachtolearninggoalalignment")>
	<cfoutput>
		<cfset description = left(description, 300)>
		updating: #approachtolearninggoalalignment#<br>
		<br>
		Comment A<br>
		#description#<br>
	</cfoutput><br><br><br>
	<CFQUERY NAME="StudentCommentsUpdate" DATASOURCE="sim_assess">
		update comments
		set 
		DESCRIPTION = <cfqueryparam value="#description#" cfsqltype="CF_SQL_CHAR" maxlength="300">
		where outcome = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 1, "_")#" cfsqltype="CF_SQL_VARCHAR"> and outcome_value = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 2, "_")#" cfsqltype="CF_SQL_INTEGER">
		and comment_id = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 3, "_")#" cfsqltype="CF_SQL_INTEGER">
		and type = 'report'		
	</CFQUERY>
</cfif>

<CFQUERY NAME="Comments" DATASOURCE="sim_assess">
	select outcome, outcome_value, comment_id, description
	from comments
	where type = 'report'
	order by outcome, outcome_value
</CFQUERY>
<!--- <cfdump var="#Comments#"> --->
<cfoutput query="Comments">
	<form action="report-comments.cfm" method="post" name="form_#outcome#_#outcome_value#" id="form_#outcome#_#outcome_value#">
		<div>
			Report Comment<br>
			Outcome: #outcome#<br>
			Outcome Value: #outcome_value#<br><br>
			<textarea cols="60" rows="10" name="description">#description#</textarea>
			<input type="hidden" name="approachtolearninggoalalignment" value="#outcome#_#outcome_value#_#comment_id#"> <button name="submit" value="Update Row" type="submit">Update Row</button>
		</div>
	</form>
	<br><br>
</cfoutput>
