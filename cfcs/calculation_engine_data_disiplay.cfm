<style>

table.tablestyle th{
	text-align: left;
	color: white;
	padding: 5;
}

table.tablestyle td{
	padding: 3;
	background-color: ffffff;
	vertical-align : top;
}

table.tablestyle {
	background-color: 884488 ;
}

</style>



<!--- NOTES :

- Basically the system will calculate 6 variables based on the subject specification:
	1.	Goal Alignment
	2.	Approach to learning
	3.	Teacher Workload
	4.	Student Workload
	5.	Feedback
	6.	Public confidence    
	
	There are also another additional variables needed for final report

- Flash will need to perform the following codes to calculate the required variables for each assessment

- This module is being passed a variable (cur_state), which indicates which assessment it is (eg: assessment 1, assessment 2, and so on)

- Also, this module access the "get_ass" query from the calling page, which contains all assessment details for a particular subject

--->

<!--- find the new feedback type value --->
<CFQUERY NAME="qNewFeedback" DATASOURCE="sim_assess">
SELECT FEEDBACK_VALUE, TYPE, feedback_id
FROM new_feedback_type
<!--- WHERE feedback_id = #get_ass[attributescounter].feedback# --->
</CFQUERY>

<table class="tablestyle">
	<th colspan="2">new_feedback_type</th>
	<tr><td></td><td nowrap style="writing-mode:tb-rl;">feedback</td><td nowrap style="writing-mode:tb-rl;">feedback_value</td>
	<td rowspan="6">
			//new calculation for feedback.<br>
			penalty_factor = 0.5;<br>
			penalty = (which_ass * penalty_factor) - 4;<br>
			avg_assessment_time = 14 / number_of_assignments;<br>
			assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;<br>
			feedback = assessment_time_factor + feedback_value;<br>
			<br>
			if (feedback gt 10)<br>
			feedback = 10;<br>
			else if (feedback lt -10)<br>
			feedback = -10;<br>
			<br>
			feedback = (feedback + 10) / 4;<br>
			//end calculation for feedback<br>
			<br>
			if round(feedback) eq 0 feedback = 1<br>
	</td></tr>
	<cfoutput query="qNewFeedback">
		<tr bgcolor="eeaaaa">
			<td>#TYPE#</td>
			<td>#feedback_id#</td>
			<td>#FEEDBACK_VALUE#</td>
		</tr>
	</cfoutput>
</table>
<br>
<br>
<!--- Find the goal alignment 

- the codes below simply comparing values from one table (new_goal_alignment1) and another table (new_goal_alignment2)

- Data from "new_goal_alignment1" is the ideal value, while Data from "new_goal_alignment2" comes from the assessment details set by user.

- We want to see whether the assessment goals set by user is aligned with the ideal ones.

- if the values from "new_goal_alignment2" less than those from "new_goal_alignment1" => not aligned
  else => aligned
--->
<CFQUERY NAME="qAlign1" DATASOURCE="sim_assess">
SELECT *
FROM new_goal_alignment1
group by NAME, FAC_ID, ID, VALUE 
<!--- order by NAME, FAC_ID, ID, VALUE --->
<!--- WHERE fac_id = #sessionsubjectid# --->
</CFQUERY>

<table class="tablestyle">
	<th colspan="10">new_goal_alignment1</th>
	<tr bgcolor="eeaaaa">
		<td rowspan="2">&nbsp;</td>
		<td colspan="10" align="center">FAC_ID (always 2)</td>
	</tr>
	<tr bgcolor="eeaaaa">
		<!--- <td>&nbsp;</td> --->
		<cfoutput query="qAlign1" group="name" maxrows=1>
			<cfoutput>
				<td>#FAC_ID#</td>
			</cfoutput>
		</cfoutput>
	</tr>
	<cfoutput query="qAlign1" group="name">
	<tr bgcolor="eeaaaa">
		<td>#NAME#</td>
		<cfoutput>
			<td><!--- #NAME#, #FAC_ID#, #ID#, ---> #VALUE#</td>
		</cfoutput>
	</tr>
	</cfoutput>
</table>
<br>
<br>

<CFQUERY NAME="qAlign2" DATASOURCE="sim_assess">
select name, ASS_NAME, value 
from new_goal_alignment2, new_assessment
where new_assessment.ass_id = new_goal_alignment2.ass_id
group by name, ASS_NAME, value 
</CFQUERY>


<table class="tablestyle">
	<th colspan="15">new_goal_alignment2</th>
	<tr bgcolor="eeaaaa">
		<td rowspan="2">&nbsp;</td>
		<td colspan="14" align="center">ass_name</td>
	</tr>
	<tr bgcolor="eeaaaa">
		<!--- <td>&nbsp;</td> --->
		<cfoutput query="qAlign2" group="name" maxrows=1>
			<cfoutput>
				<td nowrap style="writing-mode:tb-rl;">#ass_name#</td>
			</cfoutput>
		</cfoutput>
	</tr>
	<cfoutput query="qAlign2" group="name">
	<tr bgcolor="eeaaaa">
		<td>#NAME#</td>
		<cfoutput>
			<td><!--- #ASS_ID# #ID# #NAME# --->#VALUE#</td>
		</cfoutput>
	</tr>
	</cfoutput>
</table>
<br>
<br>

<CFQUERY NAME="qLargest_level" DATASOURCE="sim_assess">
SELECT NAME, VALUE 
FROM new_level_assignment
</CFQUERY>

<table class="tablestyle">
	<th colspan="2">new_level_assignment</th>
	<cfoutput query="qLargest_level">
		<tr bgcolor="eeaaaa">
			<td>#NAME#</td>
			<td>#VALUE#</td>
		</tr>
	</cfoutput>
</table>