<!--- rules counting below --->

			<!--- the script below is to count the spacing of assignments: --->
			<cfscript>
			prior_ass = #attributes.cur_state# - 1;
			If (prior_ass eq 0)
				spacing_of_ass = #caller.get_ass.due_week[attributes.counter]#;
			else
				spacing_of_ass = #caller.get_ass.due_week[attributes.counter]# - #caller.get_ass.due_week[prior_ass]#;
			</cfscript>
			<!--- end script to calculate the spacing of assignments --->
			<cfif caller.get_ass.feedback[attributes.counter] eq 5>
				<cfset progression = 5>
			<cfelseif caller.get_ass.feedback[attributes.counter] eq 4>
				<cfset progression = 4>
			<cfelseif caller.get_ass.feedback[attributes.counter] eq 3>
				<cfset progression = 3>
			<cfelseif caller.get_ass.feedback[attributes.counter] eq 2>
				<cfset progression = 2>
			<cfelseif caller.get_ass.feedback[attributes.counter] eq 1>
				<cfset progression = 1>
			</cfif>
			
			<!--- find the new feedback type value --->
			<CFQUERY NAME="qNewFeedback" DATASOURCE="sim_assess">
			SELECT feedback_value
			FROM new_feedback_type
			WHERE feedback_id = #caller.get_ass.feedback[attributes.counter]#
			</CFQUERY>
			
			<!--- find the value of assignment workload --->
			<CFQUERY NAME="qAss_workload" DATASOURCE="sim_assess">
			SELECT value
			FROM new_goal_alignment2
			WHERE name = 'Assignment Workload'
			AND ass_id = #caller.get_ass.ass_id[attributes.counter]#
			</CFQUERY>
		
			<!--- find the weighting value --->
			<CFIF trim("#caller.get_ass.weighting[attributes.counter]#") eq "Less than 20">
				<cfset weighting = 1>
				<cfset weighting_for_student_emotion = 1>
				<!--- weighting_for_student_emotion is a variable to calculate student emotion.. look below at the student emotion calculation section --->
			<cfelseif trim("#caller.get_ass.weighting[attributes.counter]#") eq "Between 20 and 40">
				<cfset weighting = 2>
				<cfset weighting_for_student_emotion = 0.5>
			<cfelseif trim("#caller.get_ass.weighting[attributes.counter]#") eq "Between 40 and 60">
				<cfset weighting = 3>
				<cfset weighting_for_student_emotion = 0>
			<cfelseif trim("#caller.get_ass.weighting[attributes.counter]#") eq "Between 60 and 80">
				<cfset weighting = 4>
				<cfset weighting_for_student_emotion = -0.5>
			<cfelseif trim("#caller.get_ass.weighting[attributes.counter]#") eq "More than 80%">
				<cfset weighting = 5>	
				<cfset weighting_for_student_emotion = -1>
			</CFIF>
			
			<!--- Find the goal alignment --->
			<CFQUERY NAME="qAlign1" DATASOURCE="sim_assess">
			SELECT *
			FROM new_goal_alignment1
			WHERE fac_id = #session.subjectid#
			</CFQUERY>
			
			<cfset goal_alignment = 0>
			
			<cfloop query="qAlign1">
				<cfif qAlign1.name neq "Subject level">
					<CFQUERY NAME="qAlign2" DATASOURCE="sim_assess">
					SELECT *
					FROM new_goal_alignment2
					WHERE name LIKE '%#qAlign1.name#%'
					AND ass_id = #caller.get_ass.ass_id[attributes.counter]#
					</CFQUERY>
				<cfelse>
					<CFQUERY NAME="qDetail" DATASOURCE="sim_assess">
					SELECT goal_id
					FROM new_subject_assessment
					WHERE subject_id = #session.subjectid#
					AND ass_id = #caller.get_ass.ass_id[attributes.counter]#
					AND which_ass = #attributes.cur_state#
					</CFQUERY>         
					<!--- query below is to find the largest value of "level assignments" (we don't have to consider the smaller value.. because they are already
					included in the bigger value, to be used in the accumulated variable--->
					<CFQUERY NAME="qLargest_level" DATASOURCE="sim_assess">
					SELECT max(value) as value
					FROM new_level_assignment
					WHERE id in (#ValueList(qDetail.goal_id)#)
					</CFQUERY>
					<!--- -------------------------------------------------------------------------- --->   
					<!--- query below is to find the average value of "level assignments" --->
					<CFQUERY NAME="qAlign2" DATASOURCE="sim_assess">
					SELECT AVG(value) as value
					FROM new_level_assignment
					WHERE id in (#ValueList(qDetail.goal_id)#)
					</CFQUERY>
					<!--- script below is to calculate the approach to learning and others--->
					<cfscript>
					//==to calculate approach to learning we take average of GA, SW, and feedback==approach_to_learning = (#val("#qAlign2.value#")# + #get_ass.recordcount# + #spacing_of_ass# + #val("#weighting#")# + #progression# + #qStyle.value# + #qDepth.value# + #val("#qMarker_student.value#")#)/8;
					//================================================================
					//================================================================
					//the code below is to calculate the student emotion.
					//================================================================
					if (Trim(#caller.get_ass.marker[attributes.counter]#) eq "Teacher")
					{
						marker_for_student_emotion = 0.5;
						marker_factor_for_public_confidence = 1;
						marker_factor_for_teacher_workload = -0.5;
					}
					else if (Trim(#caller.get_ass.marker[attributes.counter]#) eq "Peer")
					{
						marker_for_student_emotion = 0;
						marker_factor_for_public_confidence = 0;
						marker_factor_for_teacher_workload = 0;
					}
					else if (Trim(#caller.get_ass.marker[attributes.counter]#) eq "Self")
					{
						marker_for_student_emotion = -0.5;
						marker_factor_for_public_confidence = -1;
						marker_factor_for_teacher_workload = 0.5;
					}
	
					penalty_factor = 1;
					penalty = (caller.get_ass.which_ass[attributes.counter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (caller.get_ass.recordcount + 1);
					assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
					student_emotion = assessment_time_factor + marker_for_student_emotion + weighting_for_student_emotion + qAss_workload.value;			
					//end code to calculate the student emotion
					//================================================================
					//now we calculate student workload based on the student_emotion, the calculation is below:
					//we only want the student emotion to be in range of -10 and 10
					//=================================================================
					if (student_emotion gt 10)
						student_emotion = 10;
					else if (student_emotion lt -10)
						student_emotion = -10;
						
					student_workload = abs(((student_emotion + 10) / 4) - 5);
					//student_workload = (#get_ass.recordcount# + #spacing_of_ass# + #weighting# + #val("#qMarker_student.value#")#)/4;
					//end calculation to calculate student workload
					//==============================================================================
					//==============================================================================	
					//new calculation for teacher workload
					//teacher_workload = (#get_ass.recordcount# + #spacing_of_ass# + #progression# + #qStyle.value# + #qDepth.value# + #val("#qMarker_teacher.value#")#)/6;
					penalty_factor = 1;
					penalty = (caller.get_ass.which_ass[attributes.counter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (caller.get_ass.recordcount + 1);
					assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
					teacher_workload = assessment_time_factor - qNewFeedback.feedback_value + marker_factor_for_teacher_workload;
					
					if (teacher_workload gt 10)
						teacher_workload = 10;
					else if (teacher_workload lt -10)
						teacher_workload = -10;
					
					teacher_workload = abs(((teacher_workload + 10) / 4) - 5);
					//end calculation to calculate teacher workload
					//==============================================================================
					//==============================================================================	
					//new calculation for feedback.
					//feedback = (#spacing_of_ass# + #progression# + #qStyle.value# + #qDepth.value#)/4; --->
					penalty_factor = 0.5;
					penalty = (caller.get_ass.which_ass[attributes.counter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (caller.get_ass.recordcount + 1);
					assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
					feedback = assessment_time_factor + qNewFeedback.feedback_value;
					
					if (feedback gt 10)
						feedback = 10;
					else if (feedback lt -10)
						feedback = -10;

					feedback = (feedback + 10) / 4;
					//end calculation for feedback
					//==============================================================================
					//==============================================================================
					//public_confidence = (#get_ass.recordcount# + #spacing_of_ass# + #val("#qMarker_teacher.value#")#)/3;
					//new calculation to calculate public confidence
					penalty_factor = 0.5;
					penalty = (caller.get_ass.which_ass[attributes.counter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (caller.get_ass.recordcount + 1);
					assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
					public_confidence = assessment_time_factor + marker_factor_for_public_confidence;
					if (public_confidence gt 10)
						public_confidence = 10;
					else if (public_confidence lt -10)
						public_confidence = -10;

					public_confidence = (public_confidence + 10) / 4;
					//end calculation of public confidence
					</cfscript>
				</cfif>
				<!--- the script below is to calculate goal alignment --->
				<cfscript>	
				if (qAlign2.value lt qAlign1.value)//if task goal is less than subject goal =>i.e. not aligned
					goal_alignment = goal_alignment - 1;
				
				if (goal_alignment lt -4)
					goal_alignment = -4;
				</cfscript>
			</cfloop>
			
			<cfif goal_alignment lt 0>
				<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
				<cfset session.unaligned_assessment = session.unaligned_assessment + 1>
				</cflock>
			</cfif>
			
			<Cfset goal_alignment = goal_alignment + 5>
			
			<!--- <cfif isdefined("run_sem")> --->
				<!--- make sure only accumulate outcomes if the user run the semester, not accumulate when the user come from the edit page --->
				<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
				<cfscript>
				// calculate the accumulated outcomes of all assignments
				session.total_level_of_assessment = #session.total_level_of_assessment# + #qLargest_level.value#;
				session.total_spacing_of_assessment = #session.total_spacing_of_assessment# + #spacing_of_ass#;
				session.total_weighting = #session.total_weighting# + #weighting#;
				session.total_progression = #session.total_progression# + #progression#;
				
				approach_to_learning = (goal_alignment + student_workload + feedback)/3;
					
				</cfscript>
				</cflock>
			<!--- </cfif> --->
			
			<!--- make sure that all outcomes values are not 0 --->
			<cfif round(student_workload) eq 0><cfset student_workload = 1></cfif>
			<cfif round(teacher_workload) eq 0><cfset teacher_workload = 1></cfif>
			<cfif round(feedback) eq 0><cfset feedback = 1></cfif>
			<cfif round(public_confidence) eq 0><cfset public_confidence = 1></cfif>
			<cfif round(goal_alignment) eq 0><cfset goal_alignment = 1></cfif>
			<cfif round(approach_to_learning) eq 0><cfset approach_to_learning = 1></cfif>
			<!--- ========================================== --->
			
			<cfset caller.student_workload = student_workload>
			<cfset caller.teacher_workload = teacher_workload>
			<cfset caller.feedback = feedback>
			<cfset caller.public_confidence = public_confidence>
			<cfset caller.student_emotion = student_emotion>
			<cfset caller.goal_alignment = goal_alignment>
			<cfset caller.approach_to_learning = approach_to_learning>
			
			<!--- additional calculation below --->
			<!--- query below is to find what week it is now?? --->
			<CFQUERY NAME="qWeek" DATASOURCE="sim_assess">
			SELECT DISTINCT due_week
			FROM new_subject_assessment
			WHERE subject_id = #session.subjectid#
			AND which_ass = #attributes.cur_state#
			</CFQUERY>
			<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
			<cfscript>
			
			//update the graph variable
			//if (isdefined("run_sem"))
			//{
				if (session.goal_alignment_values eq "")
					session.goal_alignment_values = #goal_alignment#;
				else
					session.goal_alignment_values = ListAppend("#session.goal_alignment_values#", "#goal_alignment#", ",");
				if (session.approach_to_learning_values eq "")
					session.approach_to_learning_values = #approach_to_learning#;
				else
					session.approach_to_learning_values = ListAppend("#session.approach_to_learning_values#", "#approach_to_learning#", ",");
				if (session.student_workload_values eq "")
					session.student_workload_values = #student_workload#;
				else
					session.student_workload_values = ListAppend("#session.student_workload_values#", "#student_workload#", ",");
				if (session.teacher_workload_values eq "")
					session.teacher_workload_values = #teacher_workload#;
				else
					session.teacher_workload_values = ListAppend("#session.teacher_workload_values#", "#teacher_workload#", ",");
				if (session.feedback_values eq "")
					session.feedback_values = #feedback#;
				else
					session.feedback_values = ListAppend("#session.feedback_values#", "#feedback#", ",");
				if (session.public_confidence_values eq "")
					session.public_confidence_values = #public_confidence#;
				else
					session.public_confidence_values = ListAppend("#session.public_confidence_values#", "#public_confidence#", ",");
				if (session.ass_weeks_list eq "")
					session.ass_weeks_list = #qWeek.due_week#;
				else
					session.ass_weeks_list = ListAppend("#session.ass_weeks_list#", "#qWeek.due_week#", ",");
			//}
			</cfscript>
			</cflock>
			<!--- end calculation --->
			<!---=========================--->
			<!---== rules counting finish=--->
			<!---=========================--->