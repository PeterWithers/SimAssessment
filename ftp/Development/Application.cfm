<cfapplication name="sim_assess" sessionmanagement="yes" sessiontimeout=#CreateTimeSpan(0, 0, 30, 0)# applicationtimeout=#CreateTimeSpan(0, 0, 30, 0)#>



<cfparam name="session.total_level_of_assessment" default="0">
<cfparam name="session.total_spacing_of_assessment" default="0">
<cfparam name="session.total_weighting" default="0">
<cfparam name="session.total_progression" default="0">

<cfparam name="session.unaligned_assessment" default="0">

<!--- VARIABLE BELOW IS FOR THE GRAPH --->
<cfparam name="session.goal_alignment_values" default="">
<cfparam name="session.approach_to_learning_values" default="">
<cfparam name="session.student_workload_values" default="">
<cfparam name="session.teacher_workload_values" default="">
<cfparam name="session.feedback_values" default="">
<cfparam name="session.public_confidence_values" default="">

<cfparam name="session.ass_weeks_list" default="">

<cfif not isdefined("session.default_class") or isdefined("url.change_class")>
	<!--- generate random students for the class --->
	<cfset session.default_class = ArrayNew(1)>
	<CFSET my_random = RandRange(1,15)>
	<cfset session.default_class[1] = my_random><!--- put the first element --->
	
	<CFLOOP index="TEST" from="1" to="14">
		<CFSET my_random = RandRange(1,15)>
		<cfscript>
		ArrayAppend(session.default_class, "#my_random#");
		</cfscript>
	</CFLOOP>
</cfif>