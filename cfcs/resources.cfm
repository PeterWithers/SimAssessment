<CFQUERY NAME="subjects" DATASOURCE="sim_assess">
	SELECT *
	FROM subjects
</CFQUERY>	

<cfdump var="#subjects#" label="subjects">
<br>
<br>

<CFQUERY NAME="new_assessment" DATASOURCE="sim_assess">
	SELECT *
	FROM new_assessment
</CFQUERY>	

<cfdump var="#new_assessment#" label="new_assessment">
<br>
<br>

<CFQUERY NAME="new_marker" DATASOURCE="sim_assess">
	SELECT *
	FROM new_marker
</CFQUERY>	

<cfdump var="#new_marker#" label="new_marker">
<br>
<br>

<CFQUERY NAME="new_level_assignment" DATASOURCE="sim_assess">
	SELECT *
	FROM new_level_assignment
</CFQUERY>	

<cfdump var="#new_level_assignment#" label="new_level_assignment">
<br>
<br>

<CFQUERY NAME="new_feedback_type" DATASOURCE="sim_assess">
	SELECT *
	FROM new_feedback_type
</CFQUERY>	

<cfdump var="#new_feedback_type#" label="new_feedback_type">
<br>
<br>

<CFQUERY NAME="class_characteristic" DATASOURCE="sim_assess">
	SELECT * FROM class_characteristic
</CFQUERY>	

<cfdump var="#class_characteristic#" label="class_characteristic">
<br>
<br>

<CFQUERY NAME="helptext" DATASOURCE="sim_assess">
	SELECT * FROM helptext 
</CFQUERY>

<cfdump var="#helptext#" label="helptext">
<br>
<br>


