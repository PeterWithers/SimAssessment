<CFHEADER NAME="Expires" VALUE="#DateFormat(Now(),'ddd dd mmm yyyy')# #TimeFormat(Now(),'HH:mm:ss')# GMT">
<CFHEADER NAME="Pragma" VALUE="no-cache">
<CFHEADER NAME="cache-control" VALUE="no-cache, no-store, must-revalidate">


<!--- validation --->
<cfif not isdefined("session.username") AND  not isdefined("form.user_name")>
	<cflocation url="index.html" addtoken="No">
</cfif>



<!--- <CFQUERY NAME="qCheck" DATASOURCE="sim_assess">
SELECT isCurrentlyUsed, CurrentUserName
FROM new_subject_assessment
WHERE subject_id = 
</CFQUERY> --->

<!--- <cfif qCheck.isCurrentlyUsed eq 0 or (isdefined("session.username") and qCheck.CurrentUserName eq session.username) or (isdefined("form.user_name") and qCheck.CurrentUserName eq form.user_name)><!--- if no one else is currently accessing the same subject it ---> --->

	<cfif isdefined("form.user_name")><!--- user comes from start.cfm --->
		<!--- check whether someone else is currently accessing the same subject --->
		<cfif not isdefined("application.SubjectIDAccessed") AND not isdefined("application.SimAssUserName")>
		<!--- if no one is using it, set the application variable	 --->
			<cflock scope="APPLICATION" type="EXCLUSIVE" timeout="10">
				<cfset application.SubjectIDAccessed = form.s_id>
				<cfset application.SimAssUserName = form.user_name>
			</cflock>
			
		<!--- uncomment this
		<cfelseif isdefined("application.SimAssUserName") AND application.SimAssUserName neq form.user_name>
			<cflocation url="info/unavailable.cfm" addtoken="No"> --->
		</cfif>
		
		<cfif form.AssessmentSpec eq "none"><!--- user chose the 'no assessment' mode --->
			<CFQUERY NAME="del_ass" DATASOURCE="sim_assess">
			DELETE FROM new_subject_assessment
			WHERE subject_id = #form.s_id#
			</CFQUERY>
		<cfelseif form.AssessmentSpec eq "preset"><!--- setup preset assessments --->
			<CFQUERY NAME="del_ass" DATASOURCE="sim_assess">
			DELETE FROM new_subject_assessment
			WHERE subject_id = #form.s_id#
			</CFQUERY>
			
			<CFQUERY NAME="insert_new" DATASOURCE="sim_assess"><!--- setup 1st assessment --->
			INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
			VALUES (#form.s_id#, 7, 1, 2, 'Self', 'Between 40 and 60', 1, 2)
			</CFQUERY>
			
			<CFQUERY NAME="insert_new2" DATASOURCE="sim_assess"><!--- setup 2nd assessment --->
			INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
			VALUES (#form.s_id#, 12, 2, 3, 'Self', 'Between 40 and 60', 1, 2)
			</CFQUERY>
			
			<CFQUERY NAME="insert_new3" DATASOURCE="sim_assess"><!--- setup 3rd assessment --->
			INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
			VALUES (#form.s_id#, 11, 3, 5, 'Self', 'Less than 20', 1, 2)
			</CFQUERY>
			
			<CFQUERY NAME="insert_new4" DATASOURCE="sim_assess"><!--- setup 4th assessment --->
			INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
			VALUES (#form.s_id#, 3, 4, 7, 'Self', 'Less than 20', 1, 2)
			</CFQUERY>
			
			<CFQUERY NAME="insert_new5" DATASOURCE="sim_assess"><!--- setup 5th assessment --->
			INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
			VALUES (#form.s_id#, 1, 5, 10, 'Self', 'Less than 20', 1, 2)
			</CFQUERY>
		</cfif>
		
		
		
		<CFQUERY NAME="q_subjectname" DATASOURCE="sim_assess">
		SELECT subject_name
		FROM subjects
		where subject_id = #s_id#
		</CFQUERY>
		
		
		
		<CFQUERY NAME="insert_user" DATASOURCE="sim_assess">
		INSERT INTO run_state (user_name, subject_id, s_outline_viewed, current_state)
		VALUES ('#form.user_name#', #s_id#, 0, 0)
		</CFQUERY>
		
		<CFQUERY NAME="get_user_id" DATASOURCE="sim_assess">
		SELECT MAX(user_id) as id_last
		FROM run_state
		</CFQUERY>
		
		<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
			<cfset session.username = #user_name#>
			<cfset session.subject = #q_subjectname.subject_name#>
			<cfset session.subjectid = #s_id#>
			<cfset session.userid = #get_user_id.id_last#>
		</cflock>
	</cfif>
	
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	
	<html>
	<head>
		<title>Sim Assessment for <cfoutput>#session.username#</cfoutput></title>
		<script language="javascript">
		function confirmation (ass_name)
		{
			var msg = "Do you want to permanently remove " + ass_name + " assessment?";
			if(confirm(msg))
				return true;
			else
				return false;
		}
		</script>
		<link rel="stylesheet" href="http://www.uts.edu.au/css/uts_core1.css">	
		<link rel="stylesheet" href="sim.css" type="text/css" media="screen">
		<script language="JavaScript" TYPE="text/javascript" src="http://www.uts.edu.au/scripts/ns_resize.js"></script>
	
		<SCRIPT TYPE="text/javascript">
		<!--
		
		function newImage(arg) {
			if (document.images) {
				rslt = new Image();
				rslt.src = arg;
				return rslt;
			}
		}
		
		function changeImages() {
			if (document.images && (preloadFlag == true)) {
				for (var i=0; i<changeImages.arguments.length; i+=2) {
					document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
				}
			}
		}
		
		var preloadFlag = false;
		function preloadImages() {
		<cfif isdefined("url.NoAssessment")><!--- if user hasn't setup any assessment --->
			alert("Please specify at least one assessment before starting the simulation");
		</cfif>
		
			if (document.images) {
				help_over = newImage("images/help-over.gif");
				home_over = newImage("images/home-over.gif");
				Run_over = newImage("images/Run-over.gif");
				setup_over = newImage("images/setup-over.gif");
				continue_over = newImage("images/continue-over.gif");
				continue_over = newImage("images/continue.gif");
				preloadFlag = true;
			}
		}
		
		// -->
		</SCRIPT>
	
	</head>
	
	<body bgcolor="#0099CC" leftmargin="8" topmargin="8" marginwidth="8" marginheight="8" ONLOAD="preloadImages();">
	<table width=721 border=0 cellpadding=0 cellspacing=0>
		<tr>
			<td width="128"><img src="images/UTS_logo.gif" width="128" height="29" alt=" "></td>
			<td><img src="images/13_cut_02.gif" width="1" height="29" alt=""></td>
			<td width="276"><img src="images/Title.gif" width="276" height="29" alt="Sim Assessment"></td>
			<td width="33"><img src="images/dot_clear.gif" width="33" height="29" alt=""></td>
			<td class="login" width="184"><b>Teacher:</b> <cfoutput>#session.username#<br><b>Subject:</b> #session.subject#</cfoutput></td>
			<td width="49"><a href="#" onmouseover="changeImages('help', 'images/help-over.gif'); return true;" onmouseout="changeImages('help', 'images/help.gif'); return true;"><img name="help" src="images/help.gif" width="49" height="29" border="0" alt="Help"></a></td>
			<td width="49"><a href="index.html" onmouseover="changeImages('home', 'images/home-over.gif'); return true;" onmouseout="changeImages('home', 'images/home.gif'); return true;"><img name="home" src="images/home.gif" width="49" height="29" border="0" alt="Home"></a></td>
			<td width="1"><img src="images/13_cut_08.gif" width="1" height="29" alt=""></td>
		</tr>
		<tr>
			<td colspan=8><img src="images/dot_clear.gif" width="721" height="31" alt=""></td>
		</tr>
		<tr>
			<td colspan="8" width="721">
			<!--- content starts here --->
			
			
			<h2>Subject Synopsis for <cfoutput>#session.subject#</cfoutput></h2>
					
			<div class="Copy">
				Here are the key bits of information about the subject you are going to teach:
				<ul>
				<li><a href="synopsis.cfm?s_outline=true" target="_blank">Subject Outline</a> for the Semester
				<li><a href="synopsis.cfm?grad_attr=true" target="_blank">graduate Attributes</a>
				<li>Last Year's Student <a href="synopsis.cfm?feedback=true" target="_blank">Feedback</a>
				</ul>
			</div>
			<p class="Copy">This information will help you make decisions about the assessment structure and content for the subject. Click on each one to view the information.
			</p>
			<br>
			
			<cfif isdefined("new_ass")>
				<!--- The code below is to determine the assessment order --->
				<CFQUERY NAME="get_ass" DATASOURCE="sim_assess">
				SELECT distinct ass_id, which_ass, due_week
				FROM new_subject_assessment
				WHERE subject_id = #session.subjectid#
				ORDER BY 3 ASC
				</CFQUERY>
				
				<cfset flag = "false">
				<cfoutput query="get_ass">
				<cfif get_ass.due_week gte duedate>
					<cfif flag eq "false">
						<cfset new_which_ass = #get_ass.currentrow#>
						<Cfset flag = "true">
					</cfif>
					<Cfscript>
					new_value = #get_ass.currentrow# + 1;
					</cfscript>
					<CFQUERY NAME="update_record" DATASOURCE="sim_assess">
					UPDATE new_subject_assessment
					SET which_ass = #new_value#
					WHERE subject_id = #session.subjectid#
					AND ass_id = #get_ass.ass_id#
					AND due_week = #get_ass.due_week#
					and which_ass = #get_ass.which_ass#
					</CFQUERY>
					
					<!--- <CFQUERY NAME="update_record2" DATASOURCE="sim_assess">
					UPDATE new_assessment_goals
					SET which_ass = #new_value#
					WHERE subject_id = #session.subjectid#
					and which_ass = #get_ass.which_ass# 
					</CFQUERY>--->
				</cfif>
				</cfoutput>
				<cfif flag eq "false">
					<cfset new_which_ass = #get_ass.recordcount# + 1>
				</cfif>
				
				<!--- end code to determine assessment order --->		
				
				
				<CFQUERY NAME="qGoals" DATASOURCE="sim_assess">
				SELECT *
				FROM new_level_assignment
				</CFQUERY>
				<CFOUTPUT query="qGoals">
				<cfparam name="form.goal#qGoals.id#" default="not_exist">
				<cfif Evaluate("form.goal#qGoals.id#") neq "not_exist">
					<!--- <CFQUERY NAME="insert2" DATASOURCE="sim_assess">
					INSERT INTO new_assessment_goals (subject_id, which_ass, goal_id)
					VALUES (#session.subjectid#, #form.new_which_ass#, #qGoals.id#)
					</CFQUERY> --->
					<CFQUERY NAME="insert_new" DATASOURCE="sim_assess">
					INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
					VALUES (#session.subjectid#, #form.ass_type#, #new_which_ass#, #duedate#, '#form.marker#', '#form.weighting#', #form.feedback#, #qGoals.id#)
					</CFQUERY>
				</cfif>
				</cfoutput> 
			</cfif>
			
			<cfif isdefined("delete_id") and isdefined("whichass")>
				
				<CFQUERY NAME="del_ass" DATASOURCE="sim_assess">
				DELETE FROM new_subject_assessment
				WHERE ass_id = #delete_id#
				AND subject_id = #session.subjectid#
				AND which_ass = #whichass#
				</CFQUERY>
				
				
				<CFQUERY NAME="get_ass2" DATASOURCE="sim_assess">
				SELECT distinct ass_id, which_ass, due_week
				FROM new_subject_assessment
				WHERE subject_id = #session.subjectid#
				ORDER BY 2 ASC
				</CFQUERY>
				
				<cfoutput query="get_ass2">
						<CFQUERY NAME="update2" DATASOURCE="sim_assess">
						UPDATE new_subject_assessment
						SET which_ass = #get_ass2.currentrow#
						WHERE subject_id = #session.subjectid#
						AND ass_id = #get_ass2.ass_id#
						AND due_week = #get_ass2.due_week#
						</CFQUERY>
				</cfoutput>
			</cfif>
			
			<h2>Semester Setup</h2>
			<CFQUERY NAME="get_ass" DATASOURCE="sim_assess">
			SELECT distinct new_subject_assessment.which_ass, new_subject_assessment.due_week, new_assessment.ass_id, new_assessment.ass_name
			FROM new_subject_assessment, new_assessment, subjects
			WHERE subjects.subject_id = new_subject_assessment.subject_id
			AND new_subject_assessment.ass_id = new_assessment.ass_id
			AND subjects.subject_id = #session.subjectid#
			ORDER BY 2 ASC, 1 ASC
			</CFQUERY>
			
			
			<cfoutput>
			<cfset counter = 1>
			<cfset week = 1>
			<table border="0" cellpadding="2" cellspacing="1">
			<tr>
				<td bgcolor="##ffffff">
					<table border="0" cellpadding="1" cellspacing="0">
					<tr>
						<td><b>Week</b></td>
						<td colspan="4">&nbsp;</td>
					</tr>
					<cfloop condition="week LESS THAN OR EQUAL TO 14">
						<cfif week neq get_ass.due_week[counter]>
							<Tr>
								<td bgcolor="##0099CC" class="Copy">&nbsp;#week#</td>
								<td bgcolor="##66ccff">&nbsp;</td>
								<Td bgcolor="##0099CC" colspan="2">&nbsp;</td>
								<td bgcolor="##0099CC" class="Copy">[<a href="add_assessment.cfm?duedate=#week#">Add new assessment</a>]</td>
							</tr>
							<cfset week = week + 1>
						<cfelseif week eq get_ass.due_week[counter]>
							<Tr>
								<td bgcolor="##0099CC" class="Copy">&nbsp;#week#</td>
								<td class="Copy" bgcolor="##f07800">Assessment #get_ass.which_ass[counter]# - #get_ass.ass_name[counter]#</td>
								<td bgcolor="##0099CC" class="Copy">[<a href="edit_assessment.cfm?type=#get_ass.ass_id[counter]#&duedate=#week#&whichass=#get_ass.which_ass[counter]#">Edit</a>]</td>
								<td bgcolor="##0099CC" class="Copy">[<a href="semester_setup.cfm?delete_id=#get_ass.ass_id[counter]#&whichass=#get_ass.which_ass[counter]#" onclick="return confirmation('#get_ass.ass_name[counter]#');">Delete</a>]</td>
								<td bgcolor="##0099CC" class="Copy">[<a href="add_assessment.cfm?duedate=#week#">Add new assessment</a>]</td>
							</tr>
							<cfset counter = counter + 1>
							
							<cfif counter gt get_ass.recordcount>
								<cfset counter = #get_ass.recordcount#>
								<cfset week = week + 1>
							<cfelseif week neq get_ass.due_week[counter]>
								<cfset week = week + 1>
							</cfif>
							
						</cfif>	
					
					</cfloop>
				</td>
			</tr>
			<form action="start_semester.cfm" method="post" name="frm">
			<tr>
				<td colspan="5" bgcolor="##ffffff">
				<a href="javascript:document.frm.submit();"
					onmouseover="changeImages('start', 'images/start-over.gif'); return true;"
					onmouseout="changeImages('start', 'images/start.gif'); return true;">
					<img name="start" src="images/start.gif" width=94 height=27 border=0 alt="Start SimAssessment"></a>
					<input type="hidden" name="dummy" value="dummy">
				</td>
			</tr></form>
			</table>
			</td>
		</tr>
		</table>
			</cfoutput>
			
			<!--- content ends here --->
			
			</td>
		</tr>
		</table>
	</body>
	</html>

<!--- <cfelse>
<h2>Someone else is currently accessing this subject<br>Please try again in the next one hour</h2>
</cfif> --->