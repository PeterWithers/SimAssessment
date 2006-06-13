<cfcomponent>

<!--- User login functions --->

	<cffunction name="login_user" access="remote" returntype="any">	
		<cfargument name="loginname" type="string" required="yes">		
		<cfargument name="password" type="string" required="yes">
		<CFQUERY NAME="usersearch" DATASOURCE="sim_assess">
			select LoginName, Password, UserName, id as userid from publicusers
			where loginname = '#loginname#'
			and password = '#password#'
		</CFQUERY>	
		<cfif usersearch.recordcount eq 0>
			<cfreturn -1>
		<cfelse>
			<cfreturn usersearch>
		</cfif>
	</cffunction>
	
	<cffunction name="register_user" access="remote" returntype="string">		
		<cfargument name="loginname" type="string" required="yes">	
		<cfargument name="username" type="string" required="yes">		
		<cfargument name="password" type="string" required="yes">
		<CFQUERY NAME="usersearch" DATASOURCE="sim_assess">
			select * from publicusers
			where loginname = '#loginname#'
			and password = '#password#'
		</CFQUERY>	
		<cfif usersearch.recordcount eq 0>
			<cftransaction>
			<CFQUERY NAME="userinsert" DATASOURCE="sim_assess">
				insert into publicusers
				(loginname, username, password)
				values
				('#loginname#', '#username#', '#password#')
			</CFQUERY>	
			<CFQUERY NAME="usersearch" DATASOURCE="sim_assess">
				select id as userid from publicusers
				where loginname = '#loginname#'
				and password = '#password#'
				and username = '#username#'
			</CFQUERY>	
			</cftransaction>
			<cfreturn usersearch.userid>			
		<cfelse>
			<cfreturn -1>
		</cfif>
	</cffunction>

<!--- timetable functions --->

	<cffunction name="load_timetable" access="remote" returntype="query">	
		<cfargument name="userid" type="numeric" required="yes">
		<CFQUERY NAME="listing" DATASOURCE="sim_assess">
			select * from timetableconfig, timetableassignment
			where userid = #userid#
			and timetableid = timetableconfig.id
			order by timetablelabel, which_ass 			
		</CFQUERY>	
		<cfreturn listing>
	</cffunction>
	
	<cffunction name="save_timetable" access="remote" returntype="query">
		<cfargument name="timetabletosave" type="array" required="yes">
		<cfargument name="timetablelabel" type="string" required="yes">
		<cfargument name="userid" type="numeric" required="yes">
		
		<CFQUERY NAME="timetableconfigquery" DATASOURCE="sim_assess">
			select id from timetableconfig
			where timetablelabel = '#timetablelabel#'
			and userid = #userid#
		</CFQUERY>		
		<cfif timetableconfigquery.recordcount gt 0>
			<CFQUERY NAME="delete" DATASOURCE="sim_assess">
				delete from timetableassignment
				where timetableid = #timetableconfigquery.id#
			</CFQUERY>		
		<cfelse>
			<CFQUERY NAME="timetableconfigquery" DATASOURCE="sim_assess">
				insert into timetableconfig
				(timetablelabel, userid)
				values
				('#timetablelabel#', #userid#)
			</CFQUERY>		
			<CFQUERY NAME="timetableconfigquery" DATASOURCE="sim_assess">
				select id from timetableconfig
				where timetablelabel = '#timetablelabel#'
				and userid = #userid#
			</CFQUERY>
		</cfif>
		
		<cfloop index="attributescounter" from="1" to="#ArrayLen(timetabletosave)#">
			<CFQUERY NAME="Save" DATASOURCE="sim_assess">
				insert into timetableassignment
				(
				timetableid, 
				ass_id, 
				ass_name, 
				due_week,  
				feedback, 
				marker, 
				weighting,
				which_ass,
				goal_ids
				) values (
				#timetableconfigquery.id#,
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
			select * from timetableconfig, timetableassignment
			where timetablelabel = '#timetablelabel#'
			and userid = #userid#
			and timetableid = timetableconfig.id
			order by which_ass 
		</CFQUERY>			
		<cfreturn listing>
	</cffunction>	
	
<!--- table functions --->
	
<cffunction name="create_timetableconfig_table" access="remote">
		<cftransaction>		
		</cftransaction>
	</cffunction> 
</cfcomponent>
