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
			<!--- 	<CFQUERY NAME="drop_helptext" DATASOURCE="sim_assess">
				if exists (select * from sysobjects where id = object_id(N'helptext') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
				drop table helptext
			</CFQUERY>		
			<CFQUERY NAME="create_helptext" DATASOURCE="sim_assess">
				CREATE TABLE helptext
				(
					id int IDENTITY (1, 1) NOT NULL,
					helptext varchar (2000) NOT NULL, 
					targetname varchar (100) NOT NULL,
					topic varchar (100) NOT NULL
				)
			</CFQUERY>			
			<CFQUERY NAME="create_PK_helptext" DATASOURCE="sim_assess">
				ALTER TABLE helptext WITH NOCHECK ADD
				CONSTRAINT PK_helptext PRIMARY KEY  CLUSTERED (id)
			</CFQUERY>			
			<CFQUERY NAME="drop_FK_timetableconfig_publicusers" DATASOURCE="sim_assess">
				if exists (select * from dbo.sysobjects where id = object_id(N'FK_timetableconfig_publicusers') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
				ALTER TABLE timetableconfig DROP CONSTRAINT FK_timetableconfig_publicusers
			</CFQUERY>				
			<CFQUERY NAME="drop_FK_timetableassignment_timetableconfig" DATASOURCE="sim_assess">
				if exists (select * from dbo.sysobjects where id = object_id(N'FK_timetableassignment_timetableconfig') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
				ALTER TABLE timetableassignment DROP CONSTRAINT FK_timetableassignment_timetableconfig
			</CFQUERY>									
			<CFQUERY NAME="drop_timetableassignment" DATASOURCE="sim_assess">
				if exists (select * from sysobjects where id = object_id(N'timetableassignment') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
				drop table timetableassignment
			</CFQUERY>			
			<CFQUERY NAME="drop_timetableconfig" DATASOURCE="sim_assess">
				if exists (select * from sysobjects where id = object_id(N'timetableconfig') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
				drop table timetableconfig
			</CFQUERY>								
			<CFQUERY NAME="drop_publicusers" DATASOURCE="sim_assess">
				if exists (select * from sysobjects where id = object_id(N'publicusers') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
				drop table publicusers
			</CFQUERY>		
			<CFQUERY NAME="create_timetableassignment" DATASOURCE="sim_assess">
				CREATE TABLE timetableassignment
				(
					timetableid int NOT NULL, 
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
			<CFQUERY NAME="create_timetableconfig" DATASOURCE="sim_assess">
				CREATE TABLE timetableconfig
				(
					id int IDENTITY (1, 1) NOT NULL,
					timetablelabel varchar (500) NULL, 
					userid int NOT NULL
				)
			</CFQUERY>			
			<CFQUERY NAME="create_publicusers" DATASOURCE="sim_assess">
				CREATE TABLE publicusers
				(
					id int IDENTITY (1, 1) NOT NULL,
					username varchar (500) NOT NULL, 
					loginname varchar (500) NOT NULL, 
					password varchar (500) NOT NULL
				)
			</CFQUERY>					
			<CFQUERY NAME="create_PK_publicusers" DATASOURCE="sim_assess">
				ALTER TABLE publicusers WITH NOCHECK ADD 
				CONSTRAINT PK_publicusers PRIMARY KEY  CLUSTERED (id)
			</CFQUERY>							
			<CFQUERY NAME="create_PK_timetableconfig" DATASOURCE="sim_assess">
				ALTER TABLE timetableconfig WITH NOCHECK ADD 
				CONSTRAINT PK_timetableconfig PRIMARY KEY  CLUSTERED (id)
			</CFQUERY>			
			<CFQUERY NAME="create_FK_timetableconfig_publicusers" DATASOURCE="sim_assess">
				ALTER TABLE timetableconfig ADD 
				CONSTRAINT FK_timetableconfig_publicusers FOREIGN KEY (userid) REFERENCES publicusers (id)
			</CFQUERY>			
			<CFQUERY NAME="create_FK_timetableassignment_timetableconfig" DATASOURCE="sim_assess">
				ALTER TABLE timetableassignment ADD 
				CONSTRAINT FK_timetableassignment_timetableconfig FOREIGN KEY (timetableid) REFERENCES timetableconfig (id)
			</CFQUERY>  --->
		</cftransaction>
	</cffunction> 
</cfcomponent>
