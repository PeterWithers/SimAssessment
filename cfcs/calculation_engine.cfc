<cfcomponent>
	<cffunction name="calculate" access="remote" returntype="struct">
		<cfargument name="AssignmentSetupArray" type="array" required="yes">
		
		<cfset CFCresult = StructNew()>
		<cfscript>
			// reset all accumulated variables			
			sessiontotal_level_of_assessment = 0;
			sessiontotal_spacing_of_assessment = 0;
			sessiontotal_weighting = 0;
			sessiontotal_progression = 0;			
			sessionunaligned_assessment = 0;
			
			//reset all graph variables
//			sessiongoal_alignment_values = "";
			sessionapproach_to_learning_values = "";
			sessionstudent_workload_values = "";
			sessionteacher_workload_values = "";
			sessionfeedback_values = "";
			sessionpublic_confidence_values = "";			
			sessionass_weeks_list = "";
		</cfscript>
	
		<cfset sessionsubject = "SimAssessment">
		<cfset sessionsubjectid = "2">

		<cfloop index="attributescounter" from="1" to="#ArrayLen(AssignmentSetupArray)#">
			<cfif 0 EQ listfind(sessionass_weeks_list, AssignmentSetupArray[attributescounter].due_week)>
				<cfset cur_stateStruct = StructNew()>
				<cfset result = StructInsert(CFCresult, "#attributescounter#", cur_stateStruct)>
				
				<cfset result = StructInsert(cur_stateStruct, "attributescounter_#attributescounter#", AssignmentSetupArray[attributescounter].due_week)>
			</cfif>
			<cfset result = StructInsert(CFCresult, "attributescounter_#attributescounter#", AssignmentSetupArray[attributescounter].due_week)>
			<cfset attributescur_state = attributescounter>
			
			<cfparam name="AssignmentIdList" default="">
			<cfset AssignmentIdList = listappend(AssignmentIdList, AssignmentSetupArray[attributescounter].ass_id)>
			
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

- Also, this module access the "AssignmentSetupArray" query from the calling page, which contains all assessment details for a particular subject

--->
		
			<!--- the script below is to count the spacing of assignments: --->
			<cfscript>
			prior_ass = #attributescur_state# - 1;
			If (prior_ass eq 0)
				spacing_of_ass = #AssignmentSetupArray[attributescounter].due_week#;
			else
				spacing_of_ass = #AssignmentSetupArray[attributescounter].due_week# - #AssignmentSetupArray[prior_ass].due_week#;
			</cfscript>
			<!--- end script to calculate the spacing of assignments --->
			
			<!--- set the progression --->
			<cfif AssignmentSetupArray[attributescounter].feedback eq 5>
				<cfset progression = 5>
			<cfelseif AssignmentSetupArray[attributescounter].feedback eq 4>
				<cfset progression = 4>
			<cfelseif AssignmentSetupArray[attributescounter].feedback eq 3>
				<cfset progression = 3>
			<cfelseif AssignmentSetupArray[attributescounter].feedback eq 2>
				<cfset progression = 2>
			<cfelseif AssignmentSetupArray[attributescounter].feedback eq 1>
				<cfset progression = 1>
			</cfif>
			
			<!--- find the new feedback type value --->
			<CFQUERY NAME="qNewFeedback" DATASOURCE="sim_assess">
			SELECT feedback_value
			FROM new_feedback_type
			WHERE feedback_id = #AssignmentSetupArray[attributescounter].feedback#
			</CFQUERY>

			<!--- find the value of assignment workload --->
			<CFQUERY NAME="qAss_workload" DATASOURCE="sim_assess">
			SELECT value
			FROM new_goal_alignment2
			WHERE name = 'Assignment Workload'
			AND ass_id = #AssignmentSetupArray[attributescounter].ass_id#
			</CFQUERY>

			<!--- find the weighting value --->
			<CFIF trim("#AssignmentSetupArray[attributescounter].weighting#") eq 1>
				<cfset weighting = 1>
				<cfset weighting_for_student_emotion = 1>
				<!--- weighting_for_student_emotion is a variable to calculate student emotion.. look below at the student emotion calculation section --->
			<cfelseif trim("#AssignmentSetupArray[attributescounter].weighting#") eq 2>
				<cfset weighting = 2>
				<cfset weighting_for_student_emotion = 0.5>
			<cfelseif trim("#AssignmentSetupArray[attributescounter].weighting#") eq 3>
				<cfset weighting = 3>
				<cfset weighting_for_student_emotion = 0>
			<cfelseif trim("#AssignmentSetupArray[attributescounter].weighting#") eq 4>
				<cfset weighting = 4>
				<cfset weighting_for_student_emotion = -0.5>
			<cfelseif trim("#AssignmentSetupArray[attributescounter].weighting#") eq 5>
				<cfset weighting = 5>	
				<cfset weighting_for_student_emotion = -1>
			</CFIF>
			
			<!--- 
				Find the goal alignment:
					goal_autonomy 
					goal_citizenship 
					goal_communicative 
					goal_contextual 
					goal_knowledgeliteracy 
					goal_responsive 
					goal_technical 
					goal_workload 
			--->
		
			<CFQUERY NAME="FacultyAssignmentTypeTasks" DATASOURCE="sim_assess">
				SELECT (FacultyTypeTasks.autonomy - AssignmentTypeTasks.autonomy) as autonomy,
				(FacultyTypeTasks.citizenship - AssignmentTypeTasks.citizenship) as citizenship,
				(FacultyTypeTasks.communicative - AssignmentTypeTasks.communicative) as communicative,
				(FacultyTypeTasks.contextual - AssignmentTypeTasks.contextual) as contextual,
				(FacultyTypeTasks.knowledgeliteracy - AssignmentTypeTasks.knowledgeliteracy) as knowledgeliteracy,
				(FacultyTypeTasks.responsive - AssignmentTypeTasks.responsive) as responsive,
				(FacultyTypeTasks.technical - AssignmentTypeTasks.technical) as technical,
				(FacultyTypeTasks.subjectlevel - AssignmentTypeTasks.workload) as workload
				FROM FacultyTypeTasks, AssignmentTypeTasks
				WHERE FACULTY_ID = #sessionsubjectid#
				and Assignment_id = #AssignmentSetupArray[attributescounter].ass_id#
			</CFQUERY>
			
			<cfscript>
				goal_alignment = 0;
				if (FacultyAssignmentTypeTasks.autonomy gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.citizenship gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.communicative gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.contextual gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.knowledgeliteracy gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.responsive gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.technical gt 0) goal_alignment = goal_alignment + 1;
				if (FacultyAssignmentTypeTasks.workload gt 0) goal_alignment = goal_alignment + 1;
				goal_alignment = goal_alignment * 0.625;	
			</cfscript>
			
			<!--- 	
			<CFQUERY NAME="AssignmentTypeTasks" DATASOURCE="sim_assess">
				SELECT *
				FROM AssignmentTypeTasks
				WHERE Assignment_id = #AssignmentSetupArray[attributescounter].ass_id#
			</CFQUERY>
			
			<cfparam name="goal_autonomy" default="">
			<cfset goal_autonomy = listappend(goal_autonomy, AssignmentTypeTasks.autonomy)>
			<cfparam name="goal_citizenship" default="">
			<cfset goal_citizenship = listappend(goal_citizenship, AssignmentTypeTasks.citizenship)>
			<cfparam name="goal_communicative" default="">
			<cfset goal_communicative = listappend(goal_communicative, AssignmentTypeTasks.communicative)>
			<cfparam name="goal_contextual" default="">
			<cfset goal_contextual = listappend(goal_contextual, AssignmentTypeTasks.contextual)>
			<cfparam name="goal_knowledgeliteracy" default="">
			<cfset goal_knowledgeliteracy = listappend(goal_knowledgeliteracy, AssignmentTypeTasks.knowledgeliteracy)>
			<cfparam name="goal_responsive" default="">
			<cfset goal_responsive = listappend(goal_responsive, AssignmentTypeTasks.responsive)>
			<cfparam name="goal_technical" default="">
			<cfset goal_technical = listappend(goal_technical, AssignmentTypeTasks.technical)>
			<cfparam name="goal_workload" default="">
			<cfset goal_workload = listappend(goal_workload, AssignmentTypeTasks.workload)>
			 --->
			
			 
			<!---  calculation for goal_value.  --->
			<cfset goal_value = 0>
			<cfset goal_value_list = "">
			<cfif AssignmentSetupArray[attributescounter].goal_ids neq "">
				<CFQUERY NAME="goal_value_query" DATASOURCE="sim_assess">
					SELECT value
					FROM new_level_assignment 
					WHERE id in (<cfqueryparam value="#AssignmentSetupArray[attributescounter].goal_ids#" cfsqltype="CF_SQL_INTEGER" separator="," list="Yes">)
				</CFQUERY>
				<cfoutput query="goal_value_query">
					<cfset goal_value = goal_value + value * value>				
				</cfoutput>
				<cfset goal_value = goal_value / goal_value_query.recordcount>
				<cfset goal_value = sqr(goal_value)>
				<cfset goal_value_list = valuelist(goal_value_query.value)>
			</cfif>
			<!---  end calculation to calculate goal_value  --->
			
			<!--- script below is to calculate all required variables--->
			<cfscript>
				//================================================================
				//now we calculate ambient workload based on the week in the semester
				//=================================================================
				switch (AssignmentSetupArray[attributescounter].due_week)
				{
					case 1:
					case 2:
					case 13:
					case 14:
						ambient_workload = -10;
						break;
					default:
						ambient_workload = 0;
						break;
				}						
				//end code to calculate the ambient workload
				//================================================================
				//the code below is to calculate the student emotion.
				//================================================================
				if (Trim(#AssignmentSetupArray[attributescounter].marker#) eq "Teacher")
				{
					marker_for_student_emotion = 0.5;
					marker_factor_for_public_confidence = 1;
					marker_factor_for_teacher_workload = -0.5;
				}
				else if (Trim(#AssignmentSetupArray[attributescounter].marker#) eq "Peer")
				{
					marker_for_student_emotion = 0;
					marker_factor_for_public_confidence = 0;
					marker_factor_for_teacher_workload = 0;
				}
				else if (Trim(#AssignmentSetupArray[attributescounter].marker#) eq "Self")
				{
					marker_for_student_emotion = -0.5;
					marker_factor_for_public_confidence = -1;
					marker_factor_for_teacher_workload = 0.5;
				}

				penalty_factor = 1;
				penalty = (AssignmentSetupArray[attributescounter].which_ass * penalty_factor) - 4;
				avg_assessment_time = 14 / (ArrayLen(AssignmentSetupArray) + 1);
				assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
				student_emotion = ambient_workload + assessment_time_factor + marker_for_student_emotion * 10 + weighting_for_student_emotion * 10 + qAss_workload.value;			
				//end code to calculate the student emotion
				//================================================================
				//now we calculate student workload based on the student_emotion, the calculation is below:
				//we only want the student emotion to be in range of -10 and 10
				//=================================================================
				if (student_emotion gt 10)
					student_emotion = 10;
				else if (student_emotion lt -10)
					student_emotion = -10;
					
	
				student_workload = abs(((student_emotion + 10) / 4) - 5); // + (AssignmentSetupArray[attributescounter].which_ass * 0.7);
				
				//end calculation to calculate student workload
				//==============================================================================
				

				//==============================================================================	
				//new calculation for teacher workload
				penalty_factor = 3;
				penalty = (AssignmentSetupArray[attributescounter].which_ass * penalty_factor) - 4;
				avg_assessment_time = 14 / (ArrayLen(AssignmentSetupArray) + 1);
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
				feedback = qNewFeedback.feedback_value; 
				//end calculation for feedback
				//==============================================================================
				
				
				//==============================================================================
				//new calculation to calculate public confidence
				penalty_factor = 0.5;
				penalty = (AssignmentSetupArray[attributescounter].which_ass * penalty_factor) - 4;
				avg_assessment_time = 14 / (ArrayLen(AssignmentSetupArray) + 1);
				assessment_time_factor = spacing_of_ass - avg_assessment_time - penalty;
				public_confidence = assessment_time_factor + marker_factor_for_public_confidence;
				if (public_confidence gt 10)
					public_confidence = 10;
				else if (public_confidence lt -10)
					public_confidence = -10;

				public_confidence = (public_confidence + 10) / 4;
			</cfscript>
			<!---
			end calculation of public confidence
			 ============================================================================== --->
					
			<!--- make sure that all outcomes values are not 0 --->
			<cfif round(student_workload) eq 0><cfset student_workload = 1></cfif>
			<cfif round(teacher_workload) eq 0><cfset teacher_workload = 1></cfif>
			<cfif round(feedback) eq 0><cfset feedback = 1></cfif>
			<cfif round(public_confidence) eq 0><cfset public_confidence = 1></cfif>
 			<cfif round(goal_alignment) eq 0><cfset goal_alignment = 1></cfif>
			<!--- ========================================== --->
			
			<cfscript>
				// calculate the accumulated outcomes of all assignments
				//sessiontotal_level_of_assessment = #sessiontotal_level_of_assessment# + #qLargest_level.value#; this might not be set
				sessiontotal_spacing_of_assessment = #sessiontotal_spacing_of_assessment# + #spacing_of_ass#;
				sessiontotal_weighting = #sessiontotal_weighting# + #weighting#;			
				sessiontotal_progression = #sessiontotal_progression# + #progression#;
				// 5 and 1 are the lowest student workload while 3 is the highest
				student_workload_temp = student_workload - 3;
				student_workload_temp = sqr(student_workload_temp * student_workload_temp);
				student_workload_temp = student_workload_temp * 2;
				student_workload_temp = 5 - student_workload_temp;
				// end 5 and 1 are the lowest student workload while 3 is the highest
				
				approach_to_learning = goal_value * student_workload_temp * feedback * 0.04;
			</cfscript>
			
			<cfif round(approach_to_learning) eq 0><cfset approach_to_learning = 1></cfif>
			
			<cfscript>
				if (not StructKeyExists(cur_stateStruct, "sessiontotal_level_of_assessment"))
				{
					result = StructInsert(cur_stateStruct, "sessiontotal_level_of_assessment", sessiontotal_level_of_assessment); 
	//				result = StructInsert(cur_stateStruct, "sessiontotal_spacing_of_assessment", sessiontotal_spacing_of_assessment);
	//				result = StructInsert(cur_stateStruct, "sessiontotal_weighting", sessiontotal_weighting);	
	//				result = StructInsert(cur_stateStruct, "sessiontotal_progression", sessiontotal_progression);
					result = StructInsert(cur_stateStruct, "student_workload", student_workload);
					result = StructInsert(cur_stateStruct, "teacher_workload", teacher_workload);
					result = StructInsert(cur_stateStruct, "feedback", feedback);
					result = StructInsert(cur_stateStruct, "public_confidence", public_confidence);
					result = StructInsert(cur_stateStruct, "student_emotion", student_emotion); 
					result = StructInsert(cur_stateStruct, "goal_alignment", goal_alignment);
					result = StructInsert(cur_stateStruct, "approach_to_learning", approach_to_learning);	
					result = StructInsert(cur_stateStruct, "goal_value", goal_value);	
					result = StructInsert(cur_stateStruct, "goal_value_list", goal_value_list);			
					result = StructInsert(cur_stateStruct, "student_workload_temp", student_workload_temp);							
				} else {
					sessiontotal_level_of_assessment = sessiontotal_level_of_assessment & "," & StructFind(cur_stateStruct, "sessiontotal_level_of_assessment");
					student_workload = student_workload & "," & StructFind(cur_stateStruct, "student_workload");
					teacher_workload = teacher_workload & "," & StructFind(cur_stateStruct, "teacher_workload");
					feedback = feedback & "," & StructFind(cur_stateStruct, "feedback");
					public_confidence = public_confidence & "," & StructFind(cur_stateStruct, "public_confidence");
					student_emotion = student_emotion & "," & StructFind(cur_stateStruct, "student_emotion");
					goal_alignment = goal_alignment & "," & StructFind(cur_stateStruct, "goal_alignment");
					approach_to_learning = approach_to_learning & "," & StructFind(cur_stateStruct, "approach_to_learning");
					goal_value = goal_value & "," & StructFind(cur_stateStruct, "goal_value");
					goal_value_list = goal_value_list & "," & StructFind(cur_stateStruct, "goal_value_list");
					student_workload_temp = student_workload_temp & "," & StructFind(cur_stateStruct, "student_workload_temp");
				
					result = StructUpdate(cur_stateStruct, "sessiontotal_level_of_assessment", sessiontotal_level_of_assessment); 
					result = StructUpdate(cur_stateStruct, "student_workload", student_workload);
					result = StructUpdate(cur_stateStruct, "teacher_workload", teacher_workload);
					result = StructUpdate(cur_stateStruct, "feedback", feedback);
					result = StructUpdate(cur_stateStruct, "public_confidence", public_confidence);
					result = StructUpdate(cur_stateStruct, "student_emotion", student_emotion); 
					result = StructUpdate(cur_stateStruct, "goal_alignment", goal_alignment);
					result = StructUpdate(cur_stateStruct, "approach_to_learning", approach_to_learning);	
					result = StructUpdate(cur_stateStruct, "goal_value", goal_value);	
					result = StructUpdate(cur_stateStruct, "goal_value_list", goal_value_list);			
					result = StructUpdate(cur_stateStruct, "student_workload_temp", student_workload_temp);							
				}			
					
				// we save the variables into session variables in order to draw the graph.
				//update the graph variable
//				if (sessiongoal_alignment_values eq "")
//					sessiongoal_alignment_values = #goal_alignment#;
//				else
//					sessiongoal_alignment_values = ListAppend("#sessiongoal_alignment_values#", "#goal_alignment#", ",");
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
				if (attributescounter eq ArrayLen(AssignmentSetupArray) or AssignmentSetupArray[attributescounter].due_week neq AssignmentSetupArray[attributescounter + 1].due_week)
				{
					if (sessionass_weeks_list eq "")
						sessionass_weeks_list = #AssignmentSetupArray[attributescounter].due_week#; //#qWeek.due_week#; 
					else
						sessionass_weeks_list = ListAppend("#sessionass_weeks_list#", "#AssignmentSetupArray[attributescounter].due_week#", ","); //#qWeek.due_week#", ",");
				}	
				
				if (not StructKeyExists(cur_stateStruct, "sessionapproach_to_learning_values"))
				{
	//				result = StructInsert(cur_stateStruct, "sessiongoal_alignment_values", sessiongoal_alignment_values);
					result = StructInsert(cur_stateStruct, "sessionapproach_to_learning_values", sessionapproach_to_learning_values);
					result = StructInsert(cur_stateStruct, "sessionstudent_workload_values", sessionstudent_workload_values);					
					result = StructInsert(cur_stateStruct, "sessionteacher_workload_values", sessionteacher_workload_values);
					result = StructInsert(cur_stateStruct, "sessionfeedback_values", sessionfeedback_values);
					result = StructInsert(cur_stateStruct, "sessionpublic_confidence_values", sessionpublic_confidence_values);
					result = StructInsert(cur_stateStruct, "sessionass_weeks_list", sessionass_weeks_list);
				} else {
					sessionapproach_to_learning_values = sessionapproach_to_learning_values & "," & StructFind(cur_stateStruct, "sessionapproach_to_learning_values");
					sessionstudent_workload_values = sessionstudent_workload_values & "," & StructFind(cur_stateStruct, "sessionstudent_workload_values");
					sessionteacher_workload_values = sessionteacher_workload_values & "," & StructFind(cur_stateStruct, "sessionteacher_workload_values");
					sessionfeedback_values = sessionfeedback_values & "," & StructFind(cur_stateStruct, "sessionfeedback_values");
					sessionpublic_confidence_values = sessionpublic_confidence_values & "," & StructFind(cur_stateStruct, "sessionpublic_confidence_values");
					sessionass_weeks_list = sessionass_weeks_list & "," & StructFind(cur_stateStruct, "sessionass_weeks_list");
				
					result = StructUpdate(cur_stateStruct, "sessionapproach_to_learning_values", sessionapproach_to_learning_values); 
					result = StructUpdate(cur_stateStruct, "sessionstudent_workload_values", sessionstudent_workload_values); 
					result = StructUpdate(cur_stateStruct, "sessionteacher_workload_values", sessionteacher_workload_values); 
					result = StructUpdate(cur_stateStruct, "sessionfeedback_values", sessionfeedback_values); 
					result = StructUpdate(cur_stateStruct, "sessionpublic_confidence_values", sessionpublic_confidence_values); 
					result = StructUpdate(cur_stateStruct, "sessionass_weeks_list", sessionass_weeks_list); 
				}
			</cfscript>
			<!--- end calculation --->
			<!---=========================--->
			<!---== rules counting finish=--->
			<!---=========================--->
					
		</cfloop>
		
		<cfif ArrayLen(AssignmentSetupArray) GT 0>
		
			<!--- 		Find the goal alignment for the report: goal_autonomy goal_citizenship goal_communicative goal_contextual goal_knowledgeliteracy goal_responsive goal_technical goal_workload 			--->
			<CFQUERY NAME="ReportFacultyAssignmentTypeTasks" DATASOURCE="sim_assess">
				SELECT ass_name as AssignmentType,
				(FacultyTypeTasks.autonomy - AssignmentTypeTasks.autonomy) as autonomy,
				(FacultyTypeTasks.citizenship - AssignmentTypeTasks.citizenship) as citizenship,
				(FacultyTypeTasks.communicative - AssignmentTypeTasks.communicative) as communicative,
				(FacultyTypeTasks.contextual - AssignmentTypeTasks.contextual) as contextual,
				(FacultyTypeTasks.knowledgeliteracy - AssignmentTypeTasks.knowledgeliteracy) as knowledgeliteracy,
				(FacultyTypeTasks.responsive - AssignmentTypeTasks.responsive) as responsive,
				(FacultyTypeTasks.technical - AssignmentTypeTasks.technical) as technical,
				(FacultyTypeTasks.subjectlevel - AssignmentTypeTasks.workload) as workload
				FROM FacultyTypeTasks, AssignmentTypeTasks, new_assessment
				WHERE FACULTY_ID = #sessionsubjectid#
				and Assignment_id in (#AssignmentIdList#)
				and ass_id = Assignment_id
			</CFQUERY>
		
			<cfscript>
			ReportGoalAlignment = 0;
			if (ReportFacultyAssignmentTypeTasks.autonomy gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.citizenship gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.communicative gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.contextual gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.knowledgeliteracy gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.responsive gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.technical gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			if (ReportFacultyAssignmentTypeTasks.workload gt 0) ReportGoalAlignment = ReportGoalAlignment + 1;
			ReportGoalAlignment = ReportGoalAlignment * 0.625;	
			
			ReportApproachToLearning = approach_to_learning;
			ReportFeedback = feedback;
			ReportStudentWorkload = student_workload;
			ReportTeacherWorkload = teacher_workload;
			ReportPublicConfidence = public_confidence;
//			ReportGoalAlignment = goal_alignment;
			
			// to be better tested
			ReportLevelOfAssessment = sessiontotal_level_of_assessment / attributescur_state;
			ReportWeighting = sessiontotal_weighting / attributescur_state;
			ReportSpacingOfAssessments = sessiontotal_spacing_of_assessment / attributescur_state;
			ReportProgression = sessiontotal_progression / attributescur_state;
			
			// not used
			//ReportAssessmentCount = ReportArrayLen(AssignmentSetupArray);
			</cfscript>
			
			<!--- add the report values to the return struct --->		
			<cfset reportvalues = StructNew()>			
			<cfset result = StructInsert(reportvalues, "ReportWeighting", ReportWeighting)>
			<cfset result = StructInsert(reportvalues, "ReportLevelOfAssessment", ReportLevelOfAssessment)>
			<cfset result = StructInsert(reportvalues, "ReportSpacingOfAssessments", ReportSpacingOfAssessments)>
			<cfset result = StructInsert(reportvalues, "ReportProgression", ReportProgression)>
			<!---  report goals deviation from subject norms --->
			<cfset result = StructInsert(reportvalues, "goal_deviation", ReportFacultyAssignmentTypeTasks)>			
<!--- 			<cfset result = StructInsert(reportvalues, "goal_deviation_autonomy", goal_deviation_autonomy)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_citizenship", goal_deviation_citizenship)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_communicative", goal_deviation_communicative)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_contextual", goal_deviation_contextual)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_knowledgeliteracy", goal_deviation_knowledgeliteracy)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_responsive", goal_deviation_responsive)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_technical", goal_deviation_technical)>
			<cfset result = StructInsert(reportvalues, "goal_deviation_workload", goal_deviation_workload)> --->
			<!---  report goals --->			
			<!--- <cfset result = StructInsert(reportvalues, "goal_autonomy", goal_autonomy)>
			<cfset result = StructInsert(reportvalues, "goal_citizenship", goal_citizenship)>
			<cfset result = StructInsert(reportvalues, "goal_communicative", goal_communicative)>
			<cfset result = StructInsert(reportvalues, "goal_contextual", goal_contextual)>
			<cfset result = StructInsert(reportvalues, "goal_knowledgeliteracy", goal_knowledgeliteracy)>
			<cfset result = StructInsert(reportvalues, "goal_responsive", goal_responsive)>
			<cfset result = StructInsert(reportvalues, "goal_technical", goal_technical)>
			<cfset result = StructInsert(reportvalues, "goal_workload", goal_workload)> --->
								
			<!---  not used atm: 
			ReportDepthOfFeedback, 
			ReportStyleOfFeedback, 
			ReportMarker, 
			ReportNumberOfAssessment, 
			 --->
			 
			<cfset result = StructInsert(reportvalues, "ReportApproachToLearning", ReportApproachToLearning)>
			<cfset result = StructInsert(reportvalues, "ReportFeedback", ReportFeedback)>
			<cfset result = StructInsert(reportvalues, "ReportStudentWorkload", ReportStudentWorkload)>
			<cfset result = StructInsert(reportvalues, "ReportTeacherWorkload", ReportTeacherWorkload)>
			<cfset result = StructInsert(reportvalues, "ReportPublicConfidence", ReportPublicConfidence)>
 			<cfset result = StructInsert(reportvalues, "ReportGoalAlignment", ReportGoalAlignment)> 
			<cfset result = StructInsert(CFCresult, "reportvalues", reportvalues)>
			<!--- end add the report values to the return struct --->
		</cfif>
		
		<!--- add the tweening values to the return struct --->		
		<cfset tweeningvalues = StructNew()>	
		<!--- insert rhe variables that you want to decay here 		
		* put zero if for variables that you don't want to decay --->
		<cfset result = StructInsert(tweeningvalues, "student_workload_decay", 0)>
		<cfset result = StructInsert(tweeningvalues, "goal_alignment_decay", 0)>
		<cfset result = StructInsert(tweeningvalues, "student_emotion_decay", 0)>
		<cfset result = StructInsert(tweeningvalues, "public_confidence_decay", 0)>
		<cfset result = StructInsert(tweeningvalues, "teacher_workload_decay", 0)>
		<cfset result = StructInsert(tweeningvalues, "feedback_decay", -1)>
		     	 
		<cfset result = StructInsert(tweeningvalues, "tween", true)>
		<cfset result = StructInsert(tweeningvalues, "decay", true)>
		<cfset result = StructInsert(tweeningvalues, "logdecay", true)>
		<!--- end add the tweening values to the return struct --->
		
		<cfset result = StructInsert(CFCresult, "tweeningvalues", tweeningvalues)>

		<cfreturn CFCresult>
	</cffunction>
</cfcomponent>