<!--- <CFQUERY NAME="qComments" DATASOURCE="sim_assess">
	SELECT student_workload_value, feedback_value, description, description2, description3
	FROM comments
	WHERE type = 'student'
</CFQUERY> --->
<!--- <cfdump var="#qComments#"> --->
<!---  
<CFQUERY NAME="StudentComments" DATASOURCE="sim_assess">
	create table StudentComments
	(
		id int identity(1 ,1) not null,
		DESCRIPTION varchar(300) not null,
		DESCRIPTION2 varchar(300) not null,
		DESCRIPTION3 varchar(300) not null,
		FEEDBACK_VALUE int not null,
		STUDENT_WORKLOAD_VALUE int not null,
	)
</CFQUERY>
  --->
<!--- 
<CFQUERY NAME="StudentCommentsErase" DATASOURCE="sim_assess">
	delete FROM StudentComments
</CFQUERY>

<cfoutput query="qComments">
	<CFQUERY NAME="StudentCommentsInsert" DATASOURCE="sim_assess">
		insert into StudentComments
		(DESCRIPTION, DESCRIPTION2, DESCRIPTION3, FEEDBACK_VALUE, STUDENT_WORKLOAD_VALUE )
		values
		('#DESCRIPTION#', '#DESCRIPTION2#', '#DESCRIPTION3#', #FEEDBACK_VALUE#, #STUDENT_WORKLOAD_VALUE# )
	</CFQUERY>
</cfoutput>
 --->
 <CFQUERY NAME="StudentCommentsTidy" DATASOURCE="sim_assess">
	delete FROM StudentComments
	where FEEDBACK_VALUE = 0 or STUDENT_WORKLOAD_VALUE = 0
</CFQUERY>


<cfif isdefined("workloadfeedback")>
	<cfoutput>
		<cfset description = left(description, 300)>
		<cfset description1 = left(description1, 300)>
		<cfset description2 = left(description2, 300)>
		updating: #workloadfeedback#<br>
		<br>
		Comment A<br>
		#description#<br>
		<br>
		Comment B<br>		
		#description1#<br>
		<br>
		Comment C<br>
		#description2#<br>
	</cfoutput><br>
	<CFQUERY NAME="StudentCommentsUpdate" DATASOURCE="sim_assess">
		update StudentComments
		set 
		DESCRIPTION = <cfqueryparam value="#description#" cfsqltype="CF_SQL_CHAR" maxlength="300">,
		DESCRIPTION2 = <cfqueryparam value="#description1#" cfsqltype="CF_SQL_CHAR" maxlength="300">,
		DESCRIPTION3 = <cfqueryparam value="#description2#" cfsqltype="CF_SQL_CHAR" maxlength="300">
		where FEEDBACK_VALUE = <cfqueryparam value="#listgetat(workloadfeedback, 1, "_")#" cfsqltype="CF_SQL_INTEGER"> and STUDENT_WORKLOAD_VALUE = <cfqueryparam value="#listgetat(workloadfeedback, 2, "_")#" cfsqltype="CF_SQL_INTEGER">
	</CFQUERY>	
</cfif>

<CFQUERY NAME="StudentComments" DATASOURCE="sim_assess">
	SELECT *
	FROM StudentComments
	order by FEEDBACK_VALUE, STUDENT_WORKLOAD_VALUE
</CFQUERY>
<!--- <cfdump var="#StudentComments#"> --->
<cfoutput query="studentcomments">
	<form action="student-comments.cfm" method="post" name="form_#feedback_value#_#student_workload_value#" id="form_#feedback_value#_#student_workload_value#">
		<div>
			Feedback: #feedback_value#&nbsp;&nbsp;&nbsp;&nbsp;Student Workload: #student_workload_value#<br><br>
			<textarea cols="30" rows="5" name="description">#description#</textarea>
			<textarea cols="30" rows="5" name="description1">#description2#</textarea>
			<textarea cols="30" rows="5" name="description2">#description3#</textarea><br>
			<input type="hidden" name="workloadfeedback" value="#feedback_value#_#student_workload_value#"> <button name="submit" value="Update Row" type="submit" style="float: right;">Update Row</button>
		</div>
	</form>
	<br><br>
</cfoutput>
