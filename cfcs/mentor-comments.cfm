<a href="student-comments.cfm">Edit Student Comments</a>&nbsp;|&nbsp;<a href="mentor-comments.cfm">Edit Mentor Comments</a>&nbsp;|&nbsp;<a href="report-comments.cfm">Edit Report Comments</a>&nbsp;|&nbsp;<a href="assignment-workload.cfm">Edit Assignment Workload Weighting</a>
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
		where approachtolearning_value = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 1, "_")#" cfsqltype="CF_SQL_INTEGER"> and goalalignment_value = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 2, "_")#" cfsqltype="CF_SQL_INTEGER">
		and comment_id = <cfqueryparam value="#listgetat(approachtolearninggoalalignment, 3, "_")#" cfsqltype="CF_SQL_INTEGER">
		and type = 'mentor'		
	</CFQUERY>
</cfif>

<CFQUERY NAME="Comments" DATASOURCE="sim_assess">
	select approachtolearning_value, comment_id, description, goalalignment_value
	from comments
	where type = 'mentor'
	order by approachtolearning_value, goalalignment_value
</CFQUERY>
<!--- <cfdump var="#Comments#"> --->
<cfoutput query="Comments">
	<form action="mentor-comments.cfm" method="post" name="form_#approachtolearning_value#_#goalalignment_value#" id="form_#approachtolearning_value#_#goalalignment_value#">
		<div>
			Mentor Comment<br>
			Approach To Learning: #approachtolearning_value#&nbsp;&nbsp;&nbsp;&nbsp;Goal Alignment Value: #goalalignment_value#<br><br>
			<textarea cols="60" rows="10" name="description">#description#</textarea>
			<input type="hidden" name="approachtolearninggoalalignment" value="#approachtolearning_value#_#goalalignment_value#_#comment_id#"> <button name="submit" value="Update Row" type="submit">Update Row</button>
		</div>
	</form>
	<br><br>
</cfoutput>
