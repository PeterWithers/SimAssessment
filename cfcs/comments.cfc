/*
// File: comments.cfc
// Author: Lawrence Lukito
// Date: 16 Oct 2003
// Usage: To get student comments, mentor comments, and final report
//====================
// get_studentcomments function: - This function returns all student comments. 
//								 - Use the combination of "student_workload" and "feedback_value" to get corresponding comment.
//								 - There are 3 student characteristics. Thus, there are 3 descriptions for each student characteristic.
//										* if the characteristic of the student is 1 -> Use the "description" field
//										* elseif the characteristic of the student is 2 -> Use the "description2" field
//										* elseif the characteristic of the student is 3 -> Use the "description3" field
//=====================
// get_mentorcomments function: - This function returns all mentor comments. 
//								- Use the combination of "GoalAlignment_value" and "ApproachToLearning_value" to get corresponding comment.
//=====================
// get_finalreport function: - This function returns the final report at the end of semester.
//							 - The final report will list comments of each the following variables (which are calculated during the semester): 
//									* Approach to Learning: Approach to Learning, Level of Assessment
//									* Goal Alignment: Goal Alignment
//									* Teacher Workload: Teacher Workload, Marker
//									* Student Workload: Student Workload, Number of Assessment, Spacing of Assessments, Weighting
//									* Feedback: Feedback, Progression
//									* Public Confidence: Public Confidence
//							 - So for each variable, just match the variable name (eg: Goal Alignment, Marker, etc) with the "outcome" field and relevant value (calculated during the semester), in order to get associated comment
//
*/

<cfcomponent>

<cffunction name="get_studentcomments" access="remote" returntype="query" displayname="get_studentcomments" hint="Returns information about all buildings" output="no">
        <CFQUERY NAME="qComments" DATASOURCE="sim_assess">
			SELECT student_workload_value, feedback_value, description, description2, description3
			FROM StudentComments
        </CFQUERY>
        <cfreturn qComments>
</cffunction>

<cffunction name="get_mentorcomments" access="remote" returntype="query" displayname="get_mentorcomments" hint="Returns information about all buildings" output="no">
        <CFQUERY NAME="qComments" DATASOURCE="sim_assess">
			SELECT GoalAlignment_value, ApproachToLearning_value, description
			FROM comments
			WHERE type = 'mentor'
        </CFQUERY>
        <cfreturn qComments>
</cffunction>

<cffunction name="get_finalreport" access="remote" returntype="query" displayname="get_finalreport" hint="Returns information about all buildings" output="no">
        <CFQUERY NAME="qComments" DATASOURCE="sim_assess">
			SELECT outcome, outcome_value, description
			FROM comments
			WHERE type = 'report'
        </CFQUERY>
        <cfreturn qComments>
</cffunction>
		 
</cfcomponent>
