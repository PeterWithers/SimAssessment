<cfset studentA_color = "##66ccff">
<cfset studentB_color = "##ffb18c">
<cfset studentC_color = "##b3ffc6">
<cfset studentD_color = "##ffffcc">
<cfset studentE_color = "##d6adad">

<!--- get all different student types and characteristics from db (15 different students) --->
<CFQUERY NAME="qClass" DATASOURCE="sim_assess">
SELECT *
FROM class_characteristic
</CFQUERY>

<cfset class_counter = 1>
<cfoutput>
<cfif attributes.semester_running eq "true">
<!--- 	========================================================================== --->
	<!--- code for class generation  --->
	<!--- the code below is to generate the class emotion. outer-loop loops 3 times while inner-loop loops 5 times -> to generate 15 different student. --->
	<cfloop index="outer_loop" from="1" to="3">
		<tr>
		<cfif outer_loop eq 1><!--- this is for design point of view --->
			<td rowspan="3"><img src="images/students_left.gif" width="11" height="165" alt=""></td>
		</cfif>
		<cfloop index="inner_loop" from="1" to="5">
			<cfscript>
			query_position = session.default_class[class_counter];//assign the random query position -> pick up random student..... according to the associated session variable
			//calculate new student workload value for a particular student
			modified_student_workload = round(attributes.student_workload) + qClass.student_workload[query_position];
			//calculate new feedback value for a particular student
			modified_feedback = round(attributes.feedback) + qClass.feedback[query_position];
			//calculate new student emotion value.. this is the inverse of generating student workload
			modified_student_emotion = (abs(modified_student_workload - 5) * 4) - 10;
			</cfscript>
			
			<!--- make sure that all value ranges from 1-5 --->
			<cfif round(modified_student_workload) eq 0>
				<cfset modified_student_workload = 1>
			<cfelseif round(modified_student_workload) gt 5>
				<cfset modified_student_workload = 5>
			</cfif>
			
			<cfif round(modified_feedback) eq 0>
				<cfset modified_feedback = 1>
			<cfelseif round(modified_feedback) gt 5>
				<cfset modified_feedback = 5>
			</cfif>
			<!--- ================================================= --->
			
				<!--- find the appropriate picture for class --->
				<CFQUERY NAME="qStudentcomment" DATASOURCE="sim_assess">
				SELECT description, outcome
				FROM comments
				WHERE type = 'student'
				AND student_workload_value = #round(modified_student_workload)#
				AND feedback_value = #round(modified_feedback)#
				</CFQUERY>
			
				<cfif modified_student_emotion gte 3>
					<cfset student_image = "happy">
				<cfelseif (modified_student_emotion gt 0) AND (modified_student_emotion lt 3)>
					<cfset student_image = "stressed">
				<cfelseif modified_student_emotion eq 0>
					<cfset student_image = "neutral">
				<cfelseif (modified_student_emotion gt -3) AND (modified_student_emotion lt 0)>
					<cfset student_image = "anxious">
				<cfelseif modified_student_emotion lt -3>
					<cfset student_image = "depressed">	
				</cfif>
		
				<td width="52" height="55" nowrap bgcolor="##007AA3"<!--- uncomment this to display different color for different characteristics-> bgcolor="#Evaluate("student#qClass.student_type[query_position]#_color")#" --->><a href="javascript:void(0);"
						onmouseover="return overlib('#JSStringFormat(qStudentcomment.description)#' , HEIGHT, 35, LEFT, ABOVE, SNAPX, 5, SNAPY, 5);"
						onmouseout="nd();"><img name="#student_image#_#class_counter#" src="images/#student_image#.gif" alt="#student_image#" width="52" height="55" border="0"></a></td>
				
				<cfset class_counter = class_counter + 1>
		</cfloop>
		<cfif outer_loop eq 1><!--- this is for design point of view --->
			<td rowspan="3"><img src="images/students_right.gif" width="12" height="165" alt=""></td>
		</cfif>
		</tr>
	</cfloop>	
<!--- 	end code --->
<!--- 	========================================================================== --->
<!--- 	========================================================================== --->
<cfelse>

	<cfloop index="outer_loop" from="1" to="3">
		<tr>
		<cfif outer_loop eq 1><!--- this is for design point of view --->
			<td rowspan="3"><img src="images/students_left.gif" width="11" height="165" alt=""></td>
		</cfif>
		<cfloop index="inner_loop" from="1" to="5">
				<cfset query_position = session.default_class[class_counter]>
				<td width="52" height="55" nowrap bgcolor="##007AA3" <!--- uncomment this to display different color for different characteristics-> bgcolor="#Evaluate("student#qClass.student_type[query_position]#_color")#" --->><a href="javascript:void(0);"
						onmouseover="changeImages('neutral_#class_counter#', 'images/neutral-over.gif'); return true;"
						onmouseout="changeImages('neutral_#class_counter#', 'images/neutral.gif'); return true;"><img name="neutral_#class_counter#" src="images/neutral.gif" alt="neutral" width="52" height="55" border="0"></a></td>
				
				<cfset class_counter = class_counter + 1>
		</cfloop>
		<cfif outer_loop eq 1><!--- this is for design point of view --->
			<td rowspan="3"><img src="images/students_right.gif" width="12" height="165" alt=""></td>
		</cfif>
		</tr>
	</cfloop>	

</cfif>
</cfoutput>