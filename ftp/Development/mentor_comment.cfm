<!--- THE CODE BELOW IS TO GENERATE THE mentor comment --->
<cfoutput>
	<cfloop index="outcome" list="Goal Alignment,Approach to Learning,Teacher Workload" delimiters=",">
		<cfset current_outcome = #outcome#>
		<cfif current_outcome eq "Approach to Learning">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('Research into student learning has identified three qualitatively different ways that students approach learning. A combination of goal alignment, moderate student workload and detailed feedback ensure students adopt a deep approach to learning. High workloads or a lack of feedback will encourage students to adopt a surface or strategic approach to learning.' , HEIGHT, 35, WIDTH, 300, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
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
		
		<cfelseif current_outcome eq "Teacher Workload">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('The teacher workload is related to the number of assessments and the type of feedback provided to the students. The teacher workload will be higher if they insist on marking all of the assignments themselves.' , HEIGHT, 35, WIDTH, 300, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
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
			
		<cfelseif current_outcome eq "Goal Alignment">
			<a href="javascript:void(0);" onmouseout="nd();" onmouseover="return overlib('When the goals of the subject and the goals of the assessments tasks are aligned the students are more likely to achieve high quality learning outcomes.' , HEIGHT, 35, WIDTH, 300, RIGHT, ABOVE, SNAPX, 5, SNAPY, 5)"><b>#current_outcome#</b></a><br>
			<CFQUERY NAME="qComment1" DATASOURCE="sim_assess">
			SELECT description
			FROM comments
			WHERE type = 'report'
			AND outcome = '#current_outcome#'
			AND outcome_value = #attributes.goal_alignment#
			</CFQUERY>
			* #qComment1.description#<br>
		</cfif>	
	</cfloop>
</cfoutput>	
	<!--- END CODE TO GENERATE mentor comment --->