
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>SIM ASSESSMENT</title>
	<script language="javascript">
	function verify(f)
	{
		for(var i = 0; i < f.s_id.options.length; i++)
		{
			if (f.s_id.options[i].selected)
				var selected_value = f.s_id.options[i].value;
		}
		
		if (f.user_name && f.user_name.value == "")
		{
			alert ("Please enter your name");
			return false;
		}
		else if (selected_value == "none")
		{
			alert ("Please select the subject");
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

<body bgcolor="#0099CC" leftmargin="8" topmargin="8" marginwidth="8" marginheight="8" ONLOAD="preloadImages(); if(document.frm.user_name){document.frm.user_name.select(); document.frm.user_name.focus();}">
<table width=721 border=0 cellpadding=0 cellspacing=0>
	<tr>
		<td width="128"><img src="images/UTS_logo.gif" width="128" height="29" alt=" "></td>
		<td><img src="images/13_cut_02.gif" width="1" height="29" alt=""></td>
		<td width="276"><img src="images/Title.gif" width="276" height="29" alt="Sim Assessment"></td>
		<td width="33"><img src="images/dot_clear.gif" width="33" height="29" alt=""></td>
		<td class="login" width="184"><cfif isdefined("session.username") AND isdefined("session.subject")><b>Teacher:</b> <cfoutput>#session.username#<br><b>Subject:</b> #session.subject#</cfoutput><cfelse>&nbsp;</cfif></td>
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

	
	


<cfif isdefined("session.subjectid") AND session.subjectid neq "">
	<cfset default_s_id = session.subjectid>
<cfelse>
	<cfset default_s_id = "">
</cfif>
	<form name="frm" action="semester_setup.cfm?start=true" method="post" onsubmit="return verify(this);">
	<table width="600">
	<tr>
		<cfif isdefined("session.username") AND session.username neq "">
			<td width="250" class="Copy"><b>Name:</b></td>
			<td width="350" class="Copy"><cfoutput><strong>#session.username#</strong><br></cfoutput></td>

		<cfelse>
			<td width="250" class="Copy"><b>Please enter your name:</b></td>
			<td width="350"><input type="text" name="user_name" size="50"><br></td>
		</cfif>		
	</tr>
	<CFQUERY NAME="get_subjects" DATASOURCE="sim_assess">
	SELECT *
	FROM subjects
	</CFQUERY>
	<tr>
		<td width="210" class="Copy" valign="top"><b>Please choose the subject:</b></td>
		<td width="390" class="Copy">
		<select name="s_id">
		<option value="none" selected>Please select one subject
		<cfoutput query="get_subjects">
			<cfif get_subjects.subject_name eq "SimAssessment"><!--- for testing, we only use SimAssessment subject --->
				<option value="#get_subjects.subject_id#"<cfif default_s_id eq get_subjects.subject_id> selected</cfif>>#get_subjects.subject_name#
			</cfif>
		</cfoutput>
		</select><br>
		<input type="Radio" name="AssessmentSpec" value="preset" checked>Preset Assessment &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="AssessmentSpec" value="none">No Assessment 
		</td>
	</tr>
	</table>

	<!--- 
	<cfscript>
	count = Find(" ", "#get_subjects.lecturer_name#");
	count = count - 1;
	firstname = Left("#get_subjects.lecturer_name#", "#count#");
	</cfscript>
	<a href="letter.cfm?s_id=#get_subjects.subject_id#&subject=#URLEncodedFormat("#get_subjects.subject_name#")#&dept=#get_subjects.department#&lec=#firstname#">#get_subjects.subject_name#</a> - #get_subjects.lecturer_name#<br>

	 --->
	
	
	
	<br>	
	<input type="submit" value="Next >>">&nbsp;&nbsp;&nbsp;
	<input type="reset" value="Clear">
	
	</form>

	<!--- content ends here --->
		
		</td>
	</tr>
	</table>
	
	


</body>
</html>
