


<!--- get all different student types and characteristics from db (15 different students) --->
<CFQUERY NAME="qClass" DATASOURCE="sim_assess">
SELECT *
FROM class_characteristic
</CFQUERY>



<!--- find the appropriate picture for class --->
<CFQUERY NAME="qStudentcomment" DATASOURCE="sim_assess">
SELECT description, outcome
FROM comments
WHERE type = 'student'
AND student_workload_value = #round(modified_student_workload)#
AND feedback_value = #round(modified_feedback)#
</CFQUERY>
			
