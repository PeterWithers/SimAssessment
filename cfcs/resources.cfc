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
</cfcomponent>


