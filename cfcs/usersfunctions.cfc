<cfcomponent>
	<cffunction name="load_timetable" access="remote" returntype="query">	
		<cfargument name="userid" type="numeric" required="yes">
		<CFQUERY NAME="listing" DATASOURCE="sim_assess">
			select * from timetableconfig
			where userid = #userid#
			order by timetablelabel, which_ass 			
		</CFQUERY>	
		<cfreturn listing>
	</cffunction>
	<cffunction name="save_timetable" access="remote" returntype="query">
		<cfargument name="timetabletosave" type="array" required="yes">
		<cfargument name="timetablelabel" type="string" required="yes">
		<cfargument name="userid" type="numeric" required="yes">
		<CFQUERY NAME="delete" DATASOURCE="sim_assess">
			delete from timetableconfig
			where timetablelabel = '#timetablelabel#'
			and userid = #userid#
		</CFQUERY>
		<cfloop index="attributescounter" from="1" to="#ArrayLen(timetabletosave)#">
			<CFQUERY NAME="Save" DATASOURCE="sim_assess">
				insert into timetableconfig
				(
				timetablelabel, 
				userid, 
				ass_id, 
				ass_name, 
				due_week,  
				feedback, 
				marker, 
				weighting,
				which_ass,
				goal_ids
				) values (
				'#timetablelabel#',
				#userid#,
				#timetabletosave[attributescounter].ass_id#,
				'#timetabletosave[attributescounter].ass_name#',
				#timetabletosave[attributescounter].due_week#, 
				#timetabletosave[attributescounter].feedback#, 
				'#timetabletosave[attributescounter].marker#',
				'#timetabletosave[attributescounter].weighting#',
				#timetabletosave[attributescounter].which_ass#, 
				'#timetabletosave[attributescounter].goal_ids#'
				)
			</CFQUERY>
		</cfloop>
		<CFQUERY NAME="listing" DATASOURCE="sim_assess">
			select * from timetableconfig
			where timetablelabel = '#timetablelabel#'
			and userid = #userid#
			order by which_ass 
		</CFQUERY>	
		<cfreturn listing>
	</cffunction>	
	<cffunction name="create_timetableconfig_table" access="remote">
		<cftransaction>
			<CFQUERY NAME="timetableconfig" DATASOURCE="sim_assess">
				if exists (select * from sysobjects where id = object_id(N'timetableconfig') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
				drop table timetableconfig
			</CFQUERY>
			<CFQUERY NAME="timetableconfig" DATASOURCE="sim_assess">
				CREATE TABLE timetableconfig
				(
					timetablelabel varchar (500) NULL, 
					userid int NOT NULL,
					ass_id int NOT NULL,
					ass_name varchar (100) NOT NULL,
					due_week int NOT NULL,
					feedback int NOT NULL,
					marker varchar (10) NOT NULL,
					weighting varchar (20) NOT NULL,
					which_ass int NOT NULL,
					goal_ids varchar (50) NOT NULL
				)
			</CFQUERY>		
		</cftransaction>
	</cffunction>
</cfcomponent>
