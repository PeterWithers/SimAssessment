<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Sim Assessment for <cfoutput>#session.username#</cfoutput></title>
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
<cfif not isdefined("ass_type")>
	<h2>Please make the adjustments from options below:</h2>
	
	<form name="frm" action="edit_assessment.cfm" method="post">
	<cfoutput>
	<input type="hidden" name="old_ass_id" value="#type#">
	<input type="hidden" name="old_whichass" value="#whichass#">
	<cfif isdefined ("start")><!--- caller page is start_semester.cfm --->
		<input type="hidden" name="start" value="#start#">
	</cfif>
	</cfoutput>
	<table>
	<tr>
		<td class="Copy"><b>Assessment Type: </b></td>
		<CFQUERY NAME="get_all_type" DATASOURCE="sim_assess">
		SELECT *
		FROM new_assessment
		</CFQUERY>
		<td><select name="ass_type">
		<cfoutput query="get_all_type">
		<option value="#get_all_type.ass_id#" <cfif get_all_type.ass_id eq type>selected</cfif>>#get_all_type.ass_name#
		</cfoutput>
		</select>
		</td>
	</tr>
	<tr>
		<Td valign="top" class="Copy"><b>Subject Outline goals: </b></td>
		<CFQUERY NAME="qDetail" DATASOURCE="sim_assess">
		SELECT distinct marker, weighting, feedback, goal_id
		FROM new_subject_assessment
		WHERE subject_id = #session.subjectid#
		AND ass_id = #type#
		AND which_ass = #whichass#
		</CFQUERY>                                                                                              
		<CFQUERY NAME="qGoals" DATASOURCE="sim_assess">
		SELECT *
		FROM new_level_assignment
		</CFQUERY>
		<td class="Copy">
		<table>
		<CFOUTPUT query="qGoals">
		<tr>
			<td width="15" valign="top"><input type="checkbox" name="goal#qGoals.id#" value="#qGoals.name#" <cfif ListFind("#ValueList(qDetail.goal_id)#", "#qGoals.id#") neq 0>checked</cfif>></td>
			<td width="500" class="Copy">#qGoals.name#</td>
		</tr>
		</cfoutput>
		</table>
		
		</td>
	</tr>
	<tr>
		<Td class="Copy"><b>Due in week: </b></td>
		<td>
		<select name="due_date">
		<cfoutput>
		<cfloop index="counter" from="1" to="14">
		<option value="#counter#" <cfif counter eq duedate>selected</cfif>>#counter#
		</cfloop>
		</cfoutput>
		</select>
		</td>
	</tr>
	
	<tr>
		<td class="Copy"><b>Who is the marker?</b></td>
		<td><select name="marker">
		<option value="Teacher"<cfif trim("#qDetail.marker[1]#") is "Teacher"> selected</cfif>>Teacher
		<option value="Peer"<cfif trim("#qDetail.marker[1]#") is "Peer"> selected</cfif>>Peer
		<option value="Self"<cfif trim("#qDetail.marker[1]#") is "Self"> selected</cfif>>Self
		</select></td>
	</tr>
	<tr>
		<td class="Copy"><b>Weighting: </b></td>
		<td><select name="weighting">
		<option value="Less than 20"<cfif trim("#qDetail.weighting[1]#") is "Less than 20"> selected</cfif>>Less than 20%
		<option value="Between 20 and 40"<cfif trim("#qDetail.weighting[1]#") is "Between 20 and 40"> selected</cfif>>Between 20% and 40%
		<option value="Between 40 and 60"<cfif trim("#qDetail.weighting[1]#") is "Between 40 and 60"> selected</cfif>>Between 40% and 60%
		<option value="Between 60 and 80"<cfif trim("#qDetail.weighting[1]#") is "Between 60 and 80"> selected</cfif>>Between 60% and 80%
		<option value="More than 80%"<cfif trim("#qDetail.weighting[1]#") is "More than 80%"> selected</cfif>>More than 80%
		</select></td>
	</tr>
	<CFQUERY NAME="qFeedback" DATASOURCE="sim_assess">
	SELECT *
	FROM new_feedback_type
	</CFQUERY>
	<tr>
		<td class="Copy"><b>Feedback given? </b></td>
		<td><select name="feedback">
		<option value="none">Please select feedback type
		<CFOUTPUT query="qFeedback">
		<option value="#qFeedback.feedback_id#"<cfif qDetail.feedback[1] eq qFeedback.feedback_id> selected</cfif>>#qFeedback.type#
		</CFOUTPUT>
		</select>
		</td>
	</tr>
	</table>
	<br>
	<cfif isdefined ("start")><!--- caller page is start_semester.cfm --->
	<table border="1" cellspacing="5" cellpadding="0" bordercolor="#000000">
	<tr>
		<td valign="top" bgcolor="#b5e4fb" bordercolor="#000000">&nbsp;<br>&nbsp;<input type="submit" name="update_all" value="Update and Continue Simulation">&nbsp;<br>&nbsp;(You can see the effects straight away)</td>
		<td valign="top" bgcolor="#b5e4fb" bordercolor="#000000">&nbsp;<br>&nbsp;<input type="submit" name="choice" value="Update and Start Simulation Again">&nbsp;</td>
		<td valign="top" bgcolor="#b5e4fb" bordercolor="#000000">&nbsp;<br>&nbsp;<input type="submit" name="no_update" value="Continue Simulation without changes">&nbsp;</td>
	</tr>
	</table>
	<Cfelse>
		<input type="Button" value="<< Back" onclick="javascript:history.go(-1);">&nbsp;&nbsp;&nbsp;<input type="submit" value="Update">&nbsp;&nbsp;&nbsp;<input type="reset">
	</cfif>
	</form>
	
<cfelse>
	<cfif isdefined("no_update")>
		<cflocation url="start_semester.cfm">
	</cfif>
	
	<CFQUERY NAME="delete1" DATASOURCE="sim_assess">
	DELETE FROM new_subject_assessment
	WHERE subject_id = #session.subjectid#
	AND ass_id = #old_ass_id#
	AND which_ass = #old_whichass#
	</CFQUERY> 
	
	
	<!--- The code below is to determine the assessment order --->
	<CFQUERY NAME="get_ass" DATASOURCE="sim_assess">
	SELECT distinct ass_id, which_ass, due_week
	FROM new_subject_assessment
	WHERE subject_id = #session.subjectid#
	ORDER BY 3 ASC
	</CFQUERY>
	
	<cfset flag = "false">
	<cfoutput query="get_ass">
		<cfif get_ass.due_week gte due_date>
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
			AND which_ass = #get_ass.which_ass#
			</CFQUERY>
		<cfelse>
			<CFQUERY NAME="update_record" DATASOURCE="sim_assess">
			UPDATE new_subject_assessment
			SET which_ass = #get_ass.currentrow#
			WHERE subject_id = #session.subjectid#
			AND ass_id = #get_ass.ass_id#
			AND due_week = #get_ass.due_week#
			</CFQUERY>
		</cfif>
	</cfoutput>
	
	<cfif flag eq "false">
		<cfset new_which_ass = #get_ass.recordcount# + 1>
	</cfif>
	<!--- end code to determine assessment order --->
	
	
	<CFQUERY NAME="qGoals2" DATASOURCE="sim_assess">
	SELECT *
	FROM new_level_assignment
	</CFQUERY>
	<CFOUTPUT query="qGoals2">
	<cfparam name="form.goal#qGoals2.id#" default="not_exist">
	<cfif Evaluate("form.goal#qGoals2.id#") neq "not_exist">
		<CFQUERY NAME="insert_new" DATASOURCE="sim_assess">
		INSERT INTO new_subject_assessment (subject_id, ass_id, which_ass, due_week, marker, weighting, feedback, goal_id)
		VALUES (#session.subjectid#, #form.ass_type#, #new_which_ass#, #form.due_date#, '#form.marker#', '#form.weighting#', #form.feedback#, #qGoals2.id#)
		</CFQUERY>
	</cfif>
	</cfoutput> 
	
	
	<cfif isdefined ("form.choice")>
		<CFQUERY NAME="update_state" DATASOURCE="sim_assess">
		UPDATE run_state
		SET current_state = 0
		WHERE user_id = #session.userid#
		AND user_name = '#session.username#'
		AND subject_id = #session.subjectid#
		</CFQUERY>
	</cfif>

	<cfif isdefined ("start")><!--- go to start semester page --->
		<!--- <cfif isdefined("update_all")><!--- if user selected to update and want to see the changes straight away --->
			<cflocation url="start_semester.cfm?update_all=1">
		<cfelse> --->
			<cflocation url="start_semester.cfm">
		<!--- </cfif> --->
			
	<Cfelse>
		<cflocation url="semester_setup.cfm">
	</cfif>
	
</cfif>

	<!--- content ends here --->
		
		</td>
	</tr>
	</table>

</body>
</html>
