/*<br>
// re: student comments.<br>
//		 - Use the combination of "student_workload" and "feedback_value" to get corresponding comment.<br>
//		 - There are 3 student characteristics. Thus, there are 3 descriptions for each student characteristic.<br>
//		* if the characteristic of the student is 1 -> Use the "description" field<br>
//		* elseif the characteristic of the student is 2 -> Use the "description2" field<br>
//		* elseif the characteristic of the student is 3 -> Use the "description3" field<br>
*/<br>
<CFQUERY NAME="qComments" DATASOURCE="sim_assess">
	SELECT student_workload_value, feedback_value, description, description2, description3
	FROM comments
	WHERE type = 'student'
</CFQUERY>
<cfdump var="#qComments#">

<CFQUERY NAME="qComments" DATASOURCE="sim_assess">
	SELECT GoalAlignment_value, ApproachToLearning_value, description
	FROM comments
	WHERE type = 'mentor'
</CFQUERY>
<cfdump var="#qComments#">

<CFQUERY NAME="qComments" DATASOURCE="sim_assess">
	SELECT outcome, outcome_value, description
	FROM comments
	WHERE type = 'report'
</CFQUERY>
<cfdump var="#qComments#">

<!--- <CFQUERY NAME="qComments" DATASOURCE="sim_assess">
	SELECT *
	FROM comments
</CFQUERY>
<cfdump var="#qComments#"> --->