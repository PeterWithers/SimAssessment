<cfcomponent>
	<cffunction name="get_subjects" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM subjects
		</CFQUERY>	
		<cfreturn get_subjects>
	</cffunction>
	<cffunction name="get_assessment" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM new_assessment
		</CFQUERY>	
		<cfreturn get_subjects>
	</cffunction> 
	<cffunction name="get_marker" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM new_marker
		</CFQUERY>	
		<cfreturn get_subjects>
	</cffunction> 
	<cffunction name="get_subject_goals" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM new_level_assignment
		</CFQUERY>	
		<cfreturn get_subjects>
	</cffunction> 
	<cffunction name="get_feedback_type" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM new_feedback_type
		</CFQUERY>	
		<cfreturn get_subjects>
	</cffunction>	 
	<cffunction name="get_class_characteristic" access="remote" returntype="query">
		<CFQUERY NAME="class_characteristic" DATASOURCE="sim_assess">
			SELECT * FROM class_characteristic
		</CFQUERY>	
		<cfreturn class_characteristic>
	</cffunction>	
	<cffunction name="get_help" access="remote" returntype="query">
		<cfargument name="targetnamelist" type="string" required="yes">
		<CFQUERY NAME="get_helptext" DATASOURCE="sim_assess">
			SELECT * FROM helptext 
			where targetname in (<cfqueryparam value="#targetnamelist#" cfsqltype="CF_SQL_VARCHAR" maxlength="100" list="Yes">)
		</CFQUERY>
		<cfreturn get_helptext>
	</cffunction>	
	<cffunction name="get_goal_alignment_grid" access="remote" returntype="query">
		<CFQUERY NAME="qAlign2" DATASOURCE="sim_assess">
			select name, ASS_NAME, value 
			from new_goal_alignment2, new_assessment
			where new_assessment.ass_id = new_goal_alignment2.ass_id
			group by name, ASS_NAME, value 
		</CFQUERY>
		<cfreturn qAlign2>
	</cffunction>	
</cfcomponent>


