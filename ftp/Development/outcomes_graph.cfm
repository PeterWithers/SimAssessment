	<cfset ass_weeks_array = ListToArray(session.ass_weeks_list)>
	
	<cfset goal_alignment_color = "FFFF00">
	<cfset approach_to_learning_color = "FF00FF">
	<cfset student_workload_color = "FF9933">
	<cfset teacher_workload_color = "00FF00">
	<cfset feedback_color = "E20000">
	<cfset public_confidence_color = "00FFFF">
	
	<!--- <cfset goal_alignment_label = "When the goals of the subject and the goals of the assessments tasks are aligned the students are more likely to achieve high quality learning outcomes.">
	<cfset approach_to_learning_label = "Research into student learning has identified three qualitatively different ways that students approach learning. A combination of goal alignment, moderate student workload and detailed feedback ensure students adopt a deep approach to learning. High workloads or a lack of feedback will encourage students to adopt a surface or strategic approach to learning.">
	<cfset student_workload_label = "The student workload is related to the number of assessments, the weighting of each assessment and the students' involvement in the marking. Wider spacing the assignments permits a deeper engagement with the subject material.">
	<cfset teacher_workload_label = "The teacher workload is related to the number of assessments and the type of feedback provided to the students. The teacher workload will be higher if they insist on marking all of the assignments themselves.">
	<cfset feedback_label = "The quality of feedback depends on the detail in the comments and the turn-around time between assignments. When assessments are too closely spaced together any feedback students receive will be too late to be useful for student learning.">
	<cfset public_confidence_label = "Greater confidence in a subject is often perceived when there are a high number of regular assessment tasks marked by the lecturer."> --->
	<cfset goal_alignment_label = "The goals of the subject compared with the goals of the assessment task">
	<cfset approach_to_learning_label = "A combination of goal alignment, student workload and feedback">
	<cfset student_workload_label = "The number of assessments, the weighting of each assessment and the students' involvement in the marking">
	<cfset teacher_workload_label = "The number of assessments and the type of feedback provided to the students">
	<cfset feedback_label = "The detail of the comments and the turn-around time between assignments">
	<cfset public_confidence_label = "The regularity of the assessment tasks marked by the lecturer">
	
	<!--- chart processing--->
	<cfchart font="Arial" chartheight="297" chartwidth="690" scalefrom="0" scaleto="5" gridlines="6" showlegend="No"
	  databackgroundcolor="##000000" foregroundcolor="##ffffff" BackgroundColor="##007AA3" xaxistitle="Weeks" yaxistitle="Scores" tipbgcolor="##007AA3">
	
		<cfloop index="current_command" list="goal_alignment,approach_to_learning,student_workload,teacher_workload,feedback,public_confidence" delimiters=",">
			<cfset counter = 1>
			<cfchartseries type="line" serieslabel="#Evaluate("#current_command#_label")#" seriescolor="#Evaluate("#current_command#_color")#" paintstyle="plain" markerstyle="circle">
				<CFLOOP INDEX="cur_val" LIST="#Evaluate("session.#current_command#_values")#" delimiters=",">
						<cfchartdata item="Week #ass_weeks_array[counter]#" value="#cur_val#">
				
					<cfset counter = counter + 1>
				</CFLOOP>
			</cfchartseries>
		</cfloop>
	
	</cfchart>

