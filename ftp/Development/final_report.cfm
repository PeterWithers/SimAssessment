<cfoutput>
<p>&nbsp;</p>
	<h2>Report</h2><!--- THE CODE BELOW IS TO GENERATE THE FINAL REPORT --->
	<cfloop index="outcome" list="Approach to Learning,Feedback,Student Workload,Teacher Workload,Public Confidence,Goal Alignment" delimiters=",">
		<cfset current_outcome = #outcome#>
		<cfif current_outcome eq "Approach to Learning">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('Research into student learning has identified three qualitatively different ways that students approach learning. A combination of goal alignment, moderate student workload and detailed feedback ensure students adopt a deep approach to learning. High workloads or a lack of feedback will encourage students to adopt a surface or strategic approach to learning.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #round(attributes.approach_to_learning)#
			</CFQUERY>
			* #qComment1.description#<br>
			
			<CFQUERY NAME="qComment2" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Level of Assessment'
			AND outcome_value = #round(attributes.avg_level_of_assessment)#
			</CFQUERY>
			* #qComment2.description#<br>
		<cfelseif current_outcome eq "Feedback">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('The quality of feedback depends on the detail in the comments and the turn-around time between assignments. When assessments are too closely spaced together any feedback students receive will be too late to be useful for student learning.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #round(attributes.feedback)#
			</CFQUERY>
			* #qComment1.description#<br>
			
			<CFQUERY NAME="qComment2" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Progression'
			AND outcome_value = #round(attributes.avg_progression)#
			</CFQUERY>
			* #qComment2.description#<br>
			
		<cfelseif current_outcome eq "Student Workload">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('The student workload is related to the number of assessments, the weighting of each assessment and the students\' involvement in the marking. Wider spacing the assignments permits a deeper engagement with the subject material.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #round(attributes.student_workload)#
			</CFQUERY>
			* #qComment1.description#<br>
			
			<cfif attributes.num_assessment gt 5>
				<cfset num_ass = 5>
			<cfelse>
				<cfset num_ass = attributes.num_assessment>
			</cfif>
			
			<CFQUERY NAME="qComment2" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Number of Assessment'
			AND outcome_value = #num_ass#
			</CFQUERY>
			* #qComment2.description#<br>
			
			<CFQUERY NAME="qComment3" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Spacing of Assessments'
			AND outcome_value = #round(attributes.avg_spacing_of_assessment)#
			</CFQUERY>
			* #qComment3.description#<br>
			
			<CFQUERY NAME="qComment5" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Weighting'
			AND outcome_value = #round(attributes.avg_weighting)#
			</CFQUERY>
			* #qComment5.description#<br>
		<cfelseif current_outcome eq "Teacher Workload">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('The teacher workload is related to the number of assessments and the type of feedback provided to the students. The teacher workload will be higher if they insist on marking all of the assignments themselves.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #round(attributes.teacher_workload)#
			</CFQUERY>
			* #qComment1.description#<br>
			
			<CFQUERY NAME="qComment2" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = 'Marker'
			AND outcome_value = #round(attributes.teacher_workload)#
			</CFQUERY>
			* #qComment2.description#<br>
			
		<cfelseif current_outcome eq "Public Confidence">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('Greater confidence in a subject is often perceived when there are a high number of regular assessment tasks marked by the lecturer.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #round(attributes.public_confidence)#
			</CFQUERY>
			* #qComment1.description#<br>
		<cfelseif current_outcome eq "Goal Alignment">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('When the goals of the subject and the goals of the assessments tasks are aligned the students are more likely to achieve high quality learning outcomes.' , HEIGHT, 35, WIDTH, 350, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #attributes.goal_alignment#
			</CFQUERY>
			* #qComment1.description#<br>
			<cfif session.unaligned_assessment gt 0>
				* You've got #session.unaligned_assessment# assessment(s) out of #attributes.num_assessment# which is/are not aligned with the goals of your discipline and the University<br>
			</cfif>
		</cfif>	
	</cfloop>
	<!--- END CODE TO GENERATE FINAL REPORT --->
	
	<CFQUERY NAME="qDistinct" DATASOURCE="sim_assess">
	SELECT DISTINCT new_subject_assessment.ass_id, new_assessment.ass_name
	FROM new_subject_assessment, new_assessment, subjects
	WHERE subjects.subject_id = new_subject_assessment.subject_id
	AND new_subject_assessment.ass_id = new_assessment.ass_id
	AND subjects.subject_name = '#session.subject#'
	</CFQUERY>
		<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td>&nbsp;</td>
			<cfloop query="qDistinct">
			<td class="copy">#qDistinct.ass_name#</td>
			</cfloop>
		</tr>
		<cfloop index="task" list="Task Knowledge literacy,Task Autonomy,Task Technical,Task Communicative,Task Contextual,Task Responsive,Task Citizenship" delimiters=",">
		<tr>
			<td class="copy">#task#</td>
			<cfset cur_task = #task#>
			<cfloop query="qDistinct">
				<CFQUERY NAME="qGraph" DATASOURCE="sim_assess">
				SELECT value
				FROM new_goal_alignment2
				WHERE name = '#cur_task#'
				AND ass_id = #qDistinct.ass_id#
				</CFQUERY>
				<cfif qGraph.value gt 3>
					<td bgcolor="##FF7171">&nbsp;</td>
				<cfelse>
					<td>&nbsp;</td>
				</cfif>
			</cfloop>
		</tr>
		</cfloop>
		</table>
	
</cfoutput>