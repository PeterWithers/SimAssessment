<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Sim Assessment for <cfoutput>#session.username#</cfoutput></title>
<script language="JavaScript">
function verify(f)
{
	for(var i = 0; i < f.ass_type.options.length; i++)
	{
		if (f.ass_type.options[i].selected)
			var selected_ass_type = f.ass_type.options[i].value;
	}
	
	for(var i = 0; i < f.feedback.options.length; i++)
	{
		if (f.feedback.options[i].selected)
			var selected_feedback = f.feedback.options[i].value;
	}
	
	if (selected_ass_type == "none")
	{
		alert ("Please select the assessment type");
		return false;
	}
	else if (selected_feedback == "none")
	{
		alert ("Please select the feedback type");
		return false;
	}
	else
		return true;
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
		
<cfoutput><h2>Add new assessment</h2>
<div class="Copy"><b>Assessment Due Date: Week #duedate#</b></div>
<br>
</cfoutput>


<form name="frm" action="semester_setup.cfm" method="post" onsubmit="return verify(this);">
<cfoutput><input type="hidden" name="new_ass" value="TRUE">
<input type="hidden" name="duedate" value="#duedate#">

</cfoutput>
<table border="0">
<tr>
	<td colspan="2" class="Copy"><b>Please complete assessment details below</b></td>
</tr>
<tr>
	<Td class="Copy"><b>Assessment Type: </b></td>
	<Td>
	<select name="ass_type">
<option value="none" selected>Please select assessment type
<CFQUERY NAME="get_all_type" DATASOURCE="sim_assess">
SELECT *
FROM new_assessment
</CFQUERY>
<cfoutput query="get_all_type">
<option value="#get_all_type.ass_id#">#get_all_type.ass_name#
</cfoutput>
</select></td>
</tr>
<tr>
	<Td valign="top" class="Copy"><b>Subject Outline goals: </b></td>
	<CFQUERY NAME="qGoals" DATASOURCE="sim_assess">
	SELECT *
	FROM new_level_assignment
	</CFQUERY>
	<td>
	<table>
	<CFOUTPUT query="qGoals">
	<tr>
		<td width="15" valign="top"><input type="checkbox" name="goal#qGoals.id#" value="#qGoals.name#"></td>
		<td width="500" class="Copy">#qGoals.name#</td>
	</tr>
	</cfoutput>
	</table>
	</td>
</tr>
<tr>
	<td class="Copy"><b>Who is the marker?</b></td>
	<td><select name="marker">
	<option value="Teacher" selected>Teacher
	<option value="Peer">Peer
	<option value="Self">Self
	</select></td>
</tr>
<tr>
	<td class="Copy"><b>Weighting: </b></td>
	<td><select name="weighting">
	<option value="Less than 20" selected>Less than 20%
	<option value="Between 20 and 40">Between 20% and 40%
	<option value="Between 40 and 60">Between 40% and 60%
	<option value="Between 60 and 80">Between 60% and 80%
	<option value="More than 80%">More than 80%
	</select></td>
</tr>
<CFQUERY NAME="qFeedback" DATASOURCE="sim_assess">
SELECT *
FROM new_feedback_type
</CFQUERY>
<tr>
	<td class="Copy"><b>Feedback given? </b></td>
	<td><select name="feedback">
	<option value="none" selected>Please select feedback type
	<CFOUTPUT query="qFeedback">
	<option value="#qFeedback.feedback_id#">#qFeedback.type#
	</CFOUTPUT>
	</select></td>
</tr>
</table>
<Br>
<input type="Button" value="<< Back" onclick="javascript:history.go(-1);">&nbsp;&nbsp;&nbsp;<input type="submit" value="Add new assessment">&nbsp;&nbsp;&nbsp;<input type="reset">
</form>
<!--- content ends here --->
		
		</td>
	</tr>
	</table>
</body>
</html>
