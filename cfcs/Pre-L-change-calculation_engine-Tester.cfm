<a href="calculation_engine-Tester.cfm">reload</a><br><br><br>
<cfscript>
// reset all accumulated variables

sessiontotal_level_of_assessment = 0;
sessiontotal_spacing_of_assessment = 0;
sessiontotal_weighting = 0;
sessiontotal_progression = 0;

sessionunaligned_assessment = 0;

//reset all graph variables
sessiongoal_alignment_values = "";
sessionapproach_to_learning_values = "";
sessionstudent_workload_values = "";
sessionteacher_workload_values = "";
sessionfeedback_values = "";
sessionpublic_confidence_values = "";

sessionass_weeks_list = "";

//set the intial emotion of student
//student_emotion = 0;
</cfscript>

<cfset sessionsubject = "SimAssessment">
<cfset sessionsubjectid = "2">

<!--- get all associated assessments --->
<CFQUERY NAME="get_ass" DATASOURCE="sim_assess">
SELECT distinct new_subject_assessment.which_ass, new_subject_assessment.due_week, new_subject_assessment.marker, new_subject_assessment.weighting, new_subject_assessment.feedback, new_assessment.ass_id, new_assessment.ass_name
FROM new_subject_assessment, new_assessment, subjects
WHERE subjects.subject_id = new_subject_assessment.subject_id
AND new_subject_assessment.ass_id = new_assessment.ass_id
AND subjects.subject_name = '#sessionsubject#'
ORDER BY 2 ASC, 1 ASC
</CFQUERY>

<cfset CFCresult = StructNew()>
<cfset result = StructInsert(CFCresult, "get_ass", get_ass)>


<cfloop index="attributescounter" from="1" to="#get_ass.recordcount#">
	<cfset cur_stateStruct = StructNew()>
	<cfset result = StructInsert(CFCresult, "#attributescounter#", cur_stateStruct)>

	<cfset attributescur_state = attributescounter>
<!--- 	<br><cfoutput>attributescounter: #attributescounter#</cfoutput><br> --->
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

			<!--- the script below is to count the spacing of assignments: --->
			<cfscript>
			prior_ass = #attributescur_state# - 1;
			If (prior_ass eq 0)
				spacing_of_ass = #get_ass.due_week[attributescounter]#;
			else
				spacing_of_ass = #get_ass.due_week[attributescounter]# - #get_ass.due_week[prior_ass]#;
			</cfscript>
			<!--- end script to calculate the spacing of assignments --->
<!--- set the progression --->
			<cfif get_ass.feedback[attributescounter] eq 5>
				<cfset progression = 5>
			<cfelseif get_ass.feedback[attributescounter] eq 4>
				<cfset progression = 4>
			<cfelseif get_ass.feedback[attributescounter] eq 3>
				<cfset progression = 3>
			<cfelseif get_ass.feedback[attributescounter] eq 2>
				<cfset progression = 2>
			<cfelseif get_ass.feedback[attributescounter] eq 1>
				<cfset progression = 1>
			</cfif>
			
			<!--- find the new feedback type value --->
			<CFQUERY NAME="qNewFeedback" DATASOURCE="sim_assess">
			SELECT feedback_value
			FROM new_feedback_type
			WHERE feedback_id = #get_ass.feedback[attributescounter]#
			</CFQUERY>
			<cfset result = StructInsert(cur_stateStruct, "qNewFeedback", qNewFeedback)>
			<!--- find the value of assignment workload --->
			<CFQUERY NAME="qAss_workload" DATASOURCE="sim_assess">
			SELECT value
			FROM new_goal_alignment2
			WHERE name = 'Assignment Workload'
			AND ass_id = #get_ass.ass_id[attributescounter]#
			</CFQUERY>
			<cfset result = StructInsert(cur_stateStruct, "qAss_workload", qAss_workload)>

			<!--- find the weighting value --->
			<CFIF trim("#get_ass.weighting[attributescounter]#") eq "Less than 20">
				<cfset weighting = 1>
				<cfset weighting_for_student_emotion = 1>
				<!--- weighting_for_student_emotion is a variable to calculate student emotion.. look below at the student emotion calculation section --->
			<cfelseif trim("#get_ass.weighting[attributescounter]#") eq "Between 20 and 40">
				<cfset weighting = 2>
				<cfset weighting_for_student_emotion = 0.5>
			<cfelseif trim("#get_ass.weighting[attributescounter]#") eq "Between 40 and 60">
				<cfset weighting = 3>
				<cfset weighting_for_student_emotion = 0>
			<cfelseif trim("#get_ass.weighting[attributescounter]#") eq "Between 60 and 80">
				<cfset weighting = 4>
				<cfset weighting_for_student_emotion = -0.5>
			<cfelseif trim("#get_ass.weighting[attributescounter]#") eq "More than 80%">
				<cfset weighting = 5>	
				<cfset weighting_for_student_emotion = -1>
			</CFIF>
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
			WHERE fac_id = #sessionsubjectid#
			</CFQUERY>
			<cfset result = StructInsert(cur_stateStruct, "qAlign1", qAlign1)>
			<cfset goal_alignment = 0>
			
			<cfloop query="qAlign1">
				<cfif qAlign1.name neq "Subject level">
					<CFQUERY NAME="qAlign2" DATASOURCE="sim_assess">
					SELECT *
					FROM new_goal_alignment2
					WHERE name LIKE '%#qAlign1.name#%'
					AND ass_id = #get_ass.ass_id[attributescounter]#
					</CFQUERY>
	<cfelse><!--- special consideration for "Subject level" --->
					<CFQUERY NAME="qDetail" DATASOURCE="sim_assess">
					SELECT goal_id
					FROM new_subject_assessment
					WHERE subject_id = #sessionsubjectid#
					AND ass_id = #get_ass.ass_id[attributescounter]#
					AND which_ass = #attributescur_state#
					</CFQUERY>         
					
<!--- 					<cfoutput>
						<strong>#attributescounter# : #ValueList(qDetail.goal_id)#</strong><br>
					</cfoutput> --->
					
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
					goal_id: <cfoutput>#ValueList(qDetail.goal_id)#</cfoutput><br>
	
					<!--- script below is to calculate the approach to learning and others--->
					<cfscript>
					//==to calculate approach to learning we take average of GA, SW, and feedback==approach_to_learning = (#val("#qAlign2.value#")# + #get_ass.recordcount# + #spacing_of_ass# + #val("#weighting#")# + #progression# + #qStyle.value# + #qDepth.value# + #val("#qMarker_student.value#")#)/8;

					//================================================================
					//================================================================
					//the code below is to calculate the student emotion.
					//================================================================
					if (Trim(#get_ass.marker[attributescounter]#) eq "Teacher")
					{
						marker_for_student_emotion = 0.5;
						marker_factor_for_public_confidence = 1;
						marker_factor_for_teacher_workload = -0.5;
					}
					else if (Trim(#get_ass.marker[attributescounter]#) eq "Peer")
					{
						marker_for_student_emotion = 0;
						marker_factor_for_public_confidence = 0;
						marker_factor_for_teacher_workload = 0;
					}
					else if (Trim(#get_ass.marker[attributescounter]#) eq "Self")
					{
						marker_for_student_emotion = -0.5;
						marker_factor_for_public_confidence = -1;
						marker_factor_for_teacher_workload = 0.5;
					}
	
					penalty_factor = 1;
					penalty = (get_ass.which_ass[attributescounter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (get_ass.recordcount + 1);
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
					//end calculation to calculate student workload
					//==============================================================================
					//==============================================================================	
					//new calculation for teacher workload
					penalty_factor = 1;
					penalty = (get_ass.which_ass[attributescounter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (get_ass.recordcount + 1);
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
					penalty_factor = 0.5;
					penalty = (get_ass.which_ass[attributescounter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (get_ass.recordcount + 1);
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
					//new calculation to calculate public confidence
					penalty_factor = 0.5;
					penalty = (get_ass.which_ass[attributescounter] * penalty_factor) - 4;
					avg_assessment_time = 14 / (get_ass.recordcount + 1);
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
				<cfset sessionunaligned_assessment = sessionunaligned_assessment + 1>
			</cfif>
			
			<Cfset goal_alignment = goal_alignment + 5>
			
			<!--- <cfif isdefined("run_sem")> --->
				<!--- make sure only accumulate outcomes if the user run the semester, not accumulate when the user come from the edit page --->
				<cfscript>
				// calculate the accumulated outcomes of all assignments
				sessiontotal_level_of_assessment = #sessiontotal_level_of_assessment# + #qLargest_level.value#;
				sessiontotal_spacing_of_assessment = #sessiontotal_spacing_of_assessment# + #spacing_of_ass#;
				sessiontotal_weighting = #sessiontotal_weighting# + #weighting#;			
				sessiontotal_progression = #sessiontotal_progression# + #progression#;
				approach_to_learning = (goal_alignment + student_workload + feedback)/3;			
				</cfscript>
				<cfoutput>
				sessiontotal_level_of_assessment: #sessiontotal_level_of_assessment#<br>				
				sessiontotal_spacing_of_assessment: #sessiontotal_spacing_of_assessment#<br>
				sessiontotal_weighting: #sessiontotal_weighting#<br>
				sessiontotal_progression: #sessiontotal_progression#	<br>
				approach_to_learning: #approach_to_learning#<br>
				</cfoutput>
			<!--- </cfif> --->
			
			<!--- make sure that all outcomes values are not 0 --->
			<cfif round(student_workload) eq 0><cfset student_workload = 1></cfif>
			<cfif round(teacher_workload) eq 0><cfset teacher_workload = 1></cfif>
			<cfif round(feedback) eq 0><cfset feedback = 1></cfif>
			<cfif round(public_confidence) eq 0><cfset public_confidence = 1></cfif>
			<cfif round(goal_alignment) eq 0><cfset goal_alignment = 1></cfif>
			<cfif round(approach_to_learning) eq 0><cfset approach_to_learning = 1></cfif>
			<!--- ========================================== --->
			
			<cfscript>
				result = StructInsert(cur_stateStruct, "sessiontotal_level_of_assessment", sessiontotal_level_of_assessment);
				result = StructInsert(cur_stateStruct, "sessiontotal_spacing_of_assessment", sessiontotal_spacing_of_assessment);
				result = StructInsert(cur_stateStruct, "sessiontotal_weighting", sessiontotal_weighting);	
				result = StructInsert(cur_stateStruct, "sessiontotal_progression", sessiontotal_progression);
				result = StructInsert(cur_stateStruct, "student_workload", student_workload);
				result = StructInsert(cur_stateStruct, "teacher_workload", teacher_workload);
				result = StructInsert(cur_stateStruct, "feedback", feedback);
				result = StructInsert(cur_stateStruct, "public_confidence", public_confidence);
				result = StructInsert(cur_stateStruct, "student_emotion", student_emotion);
				result = StructInsert(cur_stateStruct, "goal_alignment", goal_alignment);
				result = StructInsert(cur_stateStruct, "approach_to_learning", approach_to_learning);	
			</cfscript>
<!--- 			<cfoutput>
			student_workload: #student_workload#<br>
			teacher_workload: #teacher_workload#<br>
			feedback: #feedback#<br>
			public_confidence: #public_confidence#<br>
			student_emotion: #student_emotion#<br>
			goal_alignment: #goal_alignment#<br>
			approach_to_learning: #approach_to_learning#<br>
			</cfoutput> --->
			
			<!--- additional calculation below --->
			<!--- query below is to find what week it is now?? --->
			<CFQUERY NAME="qWeek" DATASOURCE="sim_assess">
			SELECT DISTINCT due_week
			FROM new_subject_assessment
			WHERE subject_id = #sessionsubjectid#
			AND which_ass = #attributescur_state#
			</CFQUERY>
			<cfset result = StructInsert(cur_stateStruct, "qWeek", qWeek)>
<!--- 			<cfoutput>
				<strong><font color="##008000">#get_ass.due_week[attributescounter]# : #qWeek.due_week#</font></strong><br>
			</cfoutput> --->
			<cfscript>
			
// we save the variables into session variables in order to draw the graph.
			//update the graph variable
				if (sessiongoal_alignment_values eq "")
					sessiongoal_alignment_values = #goal_alignment#;
				else
					sessiongoal_alignment_values = ListAppend("#sessiongoal_alignment_values#", "#goal_alignment#", ",");
				if (sessionapproach_to_learning_values eq "")
					sessionapproach_to_learning_values = #approach_to_learning#;
				else
					sessionapproach_to_learning_values = ListAppend("#sessionapproach_to_learning_values#", "#approach_to_learning#", ",");
				if (sessionstudent_workload_values eq "")
					sessionstudent_workload_values = #student_workload#;
				else
					sessionstudent_workload_values = ListAppend("#sessionstudent_workload_values#", "#student_workload#", ",");
				if (sessionteacher_workload_values eq "")
					sessionteacher_workload_values = #teacher_workload#;
				else
					sessionteacher_workload_values = ListAppend("#sessionteacher_workload_values#", "#teacher_workload#", ",");
				if (sessionfeedback_values eq "")
					sessionfeedback_values = #feedback#;
				else
					sessionfeedback_values = ListAppend("#sessionfeedback_values#", "#feedback#", ",");
				if (sessionpublic_confidence_values eq "")
					sessionpublic_confidence_values = #public_confidence#;
				else
					sessionpublic_confidence_values = ListAppend("#sessionpublic_confidence_values#", "#public_confidence#", ",");
				if (sessionass_weeks_list eq "")
					sessionass_weeks_list = #qWeek.due_week#;
				else
					sessionass_weeks_list = ListAppend("#sessionass_weeks_list#", "#qWeek.due_week#", ",");
					
				result = StructInsert(cur_stateStruct, "sessiongoal_alignment_values", sessiongoal_alignment_values);
				result = StructInsert(cur_stateStruct, "sessionapproach_to_learning_values", sessionapproach_to_learning_values);
				result = StructInsert(cur_stateStruct, "sessionstudent_workload_values", sessionstudent_workload_values);
				result = StructInsert(cur_stateStruct, "sessionteacher_workload_values", sessionteacher_workload_values);
				result = StructInsert(cur_stateStruct, "sessionfeedback_values", sessionfeedback_values);
				result = StructInsert(cur_stateStruct, "sessionpublic_confidence_values", sessionpublic_confidence_values);
				result = StructInsert(cur_stateStruct, "sessionass_weeks_list", sessionass_weeks_list);
			</cfscript>
			<!--- end calculation --->
			<!---=========================--->
			<!---== rules counting finish=--->
			<!---=========================--->
			
</cfloop>
<cfdump var="#CFCresult#" label="CFCresult">