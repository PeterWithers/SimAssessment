<cfcomponent>
	<cffunction name="get_subjects" access="remote" returntype="query">
		<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
			SELECT *
			FROM subjects
		</CFQUERY>	
	</cffunction>
</cfcomponent>




