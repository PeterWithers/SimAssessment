<!--- project history  note: * means the distinct stage
=================================================================================================
* incorporate rules that Peter gave to calculate outcomes (6 outcomes)
* make the final report (associating matched variables with outcomes) and the small table at the end of the semester
* make the graph using cfx_image
* 17 may 2002: incorporate andrew's image, (5 images: happy, stress, anxious, depressed, neutral
* 23 may 2002: peter ask to make the prototype suppressed (eg: combine 2 forms into one form)
	eg: first screen... user enter the name and select subject
	    second screen... user setup a particular subject
	    third screen... start semester screen..
  the reason is because peter is working on the student class rules... to make it faster in navigate between screens

--->

<CFHEADER NAME="Expires" VALUE="#DateFormat(Now(),'ddd dd mmm yyyy')# #TimeFormat(Now(),'HH:mm:ss')# GMT">
<CFHEADER NAME="Pragma" VALUE="no-cache">
<CFHEADER NAME="cache-control" VALUE="no-cache, no-store, must-revalidate">

<cfif not isdefined("session.subject")><cflocation url="index.html" addtoken="No"></cfif>

<!--- get all associated assessments --->
<CFQUERY NAME="get_ass" DATASOURCE="sim_assess">
SELECT distinct new_subject_assessment.which_ass, new_subject_assessment.due_week, new_subject_assessment.marker, new_subject_assessment.weighting, new_subject_assessment.feedback, new_assessment.ass_id, new_assessment.ass_name
FROM new_subject_assessment, new_assessment, subjects
WHERE subjects.subject_id = new_subject_assessment.subject_id
AND new_subject_assessment.ass_id = new_assessment.ass_id
AND subjects.subject_name = '#session.subject#'
ORDER BY 2 ASC, 1 ASC
</CFQUERY>

<cfif get_ass.recordcount eq 0><!--- if user hasn't specified any assessments --->
	<cflocation url="semester_setup.cfm?NoAssessment=true" addtoken="No">
</cfif>

<!--- The code below is to set the position of the current state --->
<CFQUERY NAME="get_state" DATASOURCE="sim_assess">
SELECT current_state 
FROM run_state
WHERE user_id = #session.userid#
AND user_name = '#session.username#'
AND subject_id = #session.subjectid#
</CFQUERY>

<cfset cur_state = #get_state.current_state#>
<cfif isdefined("run_sem")><!---if user press continue semester,  update current state --->

	<cfscript>
	cur_state = #get_state.current_state# + 1;
	If (#cur_state# gt #get_ass.recordcount#)
		//#cur_state# = #get_ass.recordcount#;
		#cur_state# = 0;
	</cfscript>
	<CFQUERY NAME="update_state" DATASOURCE="sim_assess">
	UPDATE run_state
	SET current_state = #cur_state#
	WHERE user_id = #session.userid#
	AND user_name = '#session.username#'
	AND subject_id = #session.subjectid#
	</CFQUERY>
<cfelse>
	<!--- we have to check in case user delete assessment in the middle of running the semester --->
	<cfscript>
	If (#cur_state# gt #get_ass.recordcount#)
		//#cur_state# = #get_ass.recordcount#;
		#cur_state# = 0;
	</cfscript>
</cfif>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
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
		
		preloadFlag = true;
	}
}
function new_window(path)
			{
				viewWindow = window.open(path,'previewwindow','personalbar=yes,toolbar=yes,status=yes,scrollbars=yes,,location=yes,resizable=yes,menubar=yes,width=650,height=500');
				viewWindow.focus();
				return false;
			}
// -->
</SCRIPT>

<script language="JavaScript">//This block of js is for swapping layers
<!--
var oldlayer='start'

function ShowHideChart(action,myChart)
{
	if (action == 'show')
	{
		if (document.all) 
	        document.all[myChart].style.visibility = 'visible';
	    else if (document.getElementById)
	        document.getElementById(myChart).style.visibility = 'visible';
	    else
	        document.layers[myChart].visibility = 'visible';
	}
	else if (action = 'hide')
	{
		if (document.all) 
	        document.all[myChart].style.visibility = 'hidden';
	    else if (document.getElementById)
	        document.getElementById(myChart).style.visibility = 'hidden';
	    else
	        document.layers[myChart].visibility = 'hidden';
	}
}

function swap(layer) {
if (document.all) {
        document.all[layer].style.visibility = 'visible';
        if (oldlayer != 'start' && oldlayer != layer) {         
                document.all[oldlayer].style.visibility 
= 'hidden'
        }
} else if (document.getElementById) {
        document.getElementById(layer).style.visibility 
= 'visible';
        if (oldlayer != 'start' && oldlayer != layer) {         
                document.getElementById
(oldlayer).style.visibility = 'hidden'
        }
} else {
        document.layers[layer].visibility = 'visible';
        if (oldlayer != 'start' && oldlayer != layer) {
                document.layers[oldlayer].visibility 
= 'hidden';
        }
} 

oldlayer = layer
}

function hidelayer(layer) {
if (document.all)
        document.all[layer].style.visibility = 'hidden';
else if (document.getElementById)
        document.getElementById(layer).style.visibility = 'hidden';
else
        document.layers[layer].visibility = 'hidden';
}

function callfunction(){
}

//-->
</script>


<style type="text/css">
	<!--

	<cfset week1 = "8px">
	<cfset week2 = "50px">
	<cfset week3 = "92px">
	<cfset week4 = "134px">
	<cfset week5 = "175px">
	<cfset week6 = "219px">
	<cfset week7 = "260px">
	<cfset week8 = "302px">
	<cfset week9 = "344px">
	<cfset week10 = "387px">
	<cfset week11 = "431px">
	<cfset week12 = "470px">
	<cfset week13 = "512px">
	<cfset week14 = "553px">
	
	<cfoutput query="get_ass" group="due_week"><!--- loop through all assessments to generate their individual css --->
			##tab_#get_ass.due_week# {
			position: absolute;
			top:129px;
			left: #Evaluate("week#get_ass.due_week#")#;
			visibility: hidden;
			overflow: auto;
			z-index: +1;
			}
	</cfoutput>
	
	<cfif cur_state neq 0 AND cur_state neq get_ass.recordcount>
		##OutcomesChart {
			position: absolute;
			top:650px;
			left:10px;
			visibility: hidden;
			overflow: auto;
			z-index: +1;
			}
	</cfif>
//-->
	</style>
</head>
	
<body bgcolor="#0099CC" leftmargin="8" topmargin="8" marginwidth="8" marginheight="8" ONLOAD="preloadImages();">
<a name="Top">
<div id="overDiv" style="position:absolute; visibility:hide; z-index:1;"></div>
<script language="JavaScript" src="overlib3.js" type="text/javascript"></script>
<!--- ======= --->

<DIV ID="outputStatus" style="position: absolute; "></DIV>

<cfoutput>
	<cfif cur_state eq "0">
		<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
		<cfscript>
		// reset all accumulated variables
		
		session.total_level_of_assessment = 0;
		session.total_spacing_of_assessment = 0;
		session.total_weighting = 0;
		session.total_progression = 0;
		
		session.unaligned_assessment = 0;
		
		//reset all graph variables
		session.goal_alignment_values = "";
		session.approach_to_learning_values = "";
		session.student_workload_values = "";
		session.teacher_workload_values = "";
		session.feedback_values = "";
		session.public_confidence_values = "";
		
		session.ass_weeks_list = "";
		
		//set the intial emotion of student
		//student_emotion = 0;
		</cfscript>
		</cflock>
	<cfelse>
	
		<!--- rules counting starts ***********************
		****************************************************--->
		<cfset student_emotion = ""><!--- to determine class emotion --->
		
		<cfset student_workload = "">
		<cfset teacher_workload = "">
		<cfset feedback = "">
		<cfset public_confidence = "">
		<cfset goal_alignment = "">
		<cfset approach_to_learning = "">
		
		<!--- the module below returns all 7 variables above --->
		<!--- <cfif isdefined("update_all")>update all details now</cfif> --->
		
		<cfif isdefined("run_sem")><!--- user clicks "continue semester" button --->
			<cfmodule template="calculation_engine.cfm"
			cur_state="#cur_state#"
			counter="#cur_state#">
		<cfelse><!--- user comes from "semester setup" screen or "edit" screen, we need to reset all session variables, and then go through the loop to do the calculation --->
			<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
			<cfscript>
			// reset all accumulated variables
			
			session.total_level_of_assessment = 0;
			session.total_spacing_of_assessment = 0;
			session.total_weighting = 0;
			session.total_progression = 0;
			
			session.unaligned_assessment = 0;
			
			//reset all graph variables
			session.goal_alignment_values = "";
			session.approach_to_learning_values = "";
			session.student_workload_values = "";
			session.teacher_workload_values = "";
			session.feedback_values = "";
			session.public_confidence_values = "";
			
			session.ass_weeks_list = "";
			
			//set the intial emotion of student
			//student_emotion = 0;
			</cfscript>
			</cflock>
			<!--- looping through all previous assessment until current state => to update all previous session variables --->
			<cfloop index="current_ass" from="1" to="#cur_state#">
				<cfmodule template="calculation_engine.cfm"
				cur_state="#current_ass#"
				counter="#current_ass#">
			</cfloop>
			
		</cfif>
		<!--- rules counting finishes ============================
		===========================================================--->
	</cfif>
</cfoutput>


<!--- this is to display the option which enables user to change class 
<a href="Javascript:void new_window('options.cfm')">[Options]</a>--->

<cfoutput>

<cfif cur_state neq 0>

 <!--- =================================================================================
=================================================================================
this is to display all outcomes
=================================================================================	

	Goal Alignment: #goal_alignment# - rounded to #round(goal_alignment)#<br>
	Approach to learning: #approach_to_learning# - rounded to #round(approach_to_learning)#<br>
	Student Workload: #student_workload# - rounded to #round(student_workload)#<br>
	Teacher Workload: #teacher_workload# - rounded to #round(teacher_workload)#<br>
	Feedback: #feedback# - rounded to #round(feedback)#<br>
	Public confidence: #public_confidence# - rounded to #round(public_confidence)#<br>
	
=================================================================================
end displaying outcomes
=================================================================================	 --->
</cfif>
</cfoutput>

<!--- ============= --->

<table width=721 border=0 cellpadding=0 cellspacing=0>
	<form name="frm" action="start_semester.cfm" method="post">
<input type="hidden" name="run_sem" value="true"> 
	<tr>
		<td colspan=3><img src="images/UTS_logo.gif" width="128" height="29" alt=" "></td>
		<td><img src="images/13_cut_02.gif" width="1" height="29" alt=""></td>
		<td colspan=2><img src="images/Title.gif" width="276" height="29" alt="Sim Assessment"></td>
		<td><img src="images/dot_clear.gif" width="33" height="29" alt=""></td>
		<td class="login"><b>Teacher:</b> <cfoutput>#session.username#<br><b>Subject:</b> #session.subject#</cfoutput></td>
		<td><a href="#" onmouseover="changeImages('help', 'images/help-over.gif'); return true;" onmouseout="changeImages('help', 'images/help.gif'); return true;"><img name="help" src="images/help.gif" width="49" height="29" border="0" alt="Help"></a></td>
		<td colspan=2><a href="index.html" onmouseover="changeImages('home', 'images/home-over.gif'); return true;" onmouseout="changeImages('home', 'images/home.gif'); return true;"><img name="home" src="images/home.gif" width="49" height="29" border="0" alt="Home"></a></td>
		<td><img src="images/13_cut_08.gif" width="1" height="29" alt=""></td>
	</tr>
	<tr>
		<td colspan=12><img src="images/dot_clear.gif" width="721" height="31" alt=""></td>
	</tr>
	<tr>
		<td colspan=2>
		<cfif (cur_state neq 0) AND (cur_state neq get_ass.recordcount)>
			<a href="javascript:document.frm.submit();" onmouseover="changeImages('continue', 'images/continue-over.gif'); return true;" onmouseout="changeImages('continue', 'images/continue.gif'); return true;"><img name="continue" src="images/continue.gif" width="96" height="27" border="0" alt="Continue Semester"></a>
		<cfelse>
			<a href="javascript:document.frm.submit();" onmouseover="changeImages('Run', 'images/Run-over.gif'); return true;" onmouseout="changeImages('Run', 'images/Run.gif'); return true;"><img name="Run" src="images/Run.gif" width="96" height="27" border="0" alt="Run Semester"></a>
		</cfif>
</td>
		<td colspan=3><a href="semester_setup.cfm" onmouseover="changeImages('setup', 'images/setup-over.gif'); return true;" onmouseout="changeImages('setup', 'images/setup.gif'); return true;"><img name="setup" src="images/setup.gif" width="120" height="27" border="0" alt="Semester Setup"></a></td>
		<td colspan=7><img src="images/dot_clear.gif" width="505" height="27" alt=""></td>
	</tr>
	</form> 
<tr><td colspan=12>
	
	
<!--TIMELINE STARTS HERE-->	
	
	<table width="721" border="0" cellpadding="0" cellspacing="0"><tr><td width="42" height="12" nowrap></td><td colspan="16"><img src="images/timeline_top_02.gif" width="679" height="12" alt=""></td></tr>
	<cfoutput>
	<tr>
		<td colspan="2"><img src="images/timeline_weeks.gif" width="72" height="28" alt="weeks"></td>
		
		<cfset counter = 1>
		<cfset week = 1>
		<cfloop condition="week LESS THAN OR EQUAL TO 14">
			<cfif week neq get_ass.due_week[counter]>
				<td><img src="images/timeline_w#week#.gif" width="42" height="28" alt=""></td>
				<cfset week = week + 1>
			<cfelseif week eq get_ass.due_week[counter]>
				<cfset previousCounter = counter - 1>
				<cfif (counter eq 1) OR (get_ass.due_week[counter] neq get_ass.due_week[previousCounter])><!--- if 1 week have multiple items, we only display the tab once --->
					<td><a href="javascript:callfunction();" onmouseover="javascript:swap('tab_#get_ass.due_week[counter]#');window.focus();" onmouseout="javascript:hidelayer('tab_#get_ass.due_week[counter]#');window.focus();"><img src="images/timeline_tab#get_ass.due_week[counter]#.gif" border="0" width="42" height="28" alt=""></a></td>
				</cfif>
				<cfset counter = counter + 1>
				
				<cfif counter gt get_ass.recordcount>
					<cfset counter = #get_ass.recordcount#>
					<cfset week = week + 1>
				<cfelseif week neq get_ass.due_week[counter]>
					<cfset week = week + 1>
				</cfif>
			</cfif>	
		</cfloop>
		
		<td rowspan="2">
			<img src="images/timeline_end.gif" width="61" height="44" alt=""></td>
	</tr>
	<tr>
		<td width="42" height="16" nowrap><cfif cur_state eq 0><img src="images/timeline_arrow.gif" alt="" width="42" height="16" border="0"></cfif></td>
		<td width="30" height="16" nowrap></td>
		<cfif cur_state eq 0>
			<td colspan="14" nowrap></td>
		<cfelse>
			<cfset week = 1>
			<cfloop condition="week LESS THAN OR EQUAL TO 14">
				<cfif week eq get_ass.due_week[cur_state]>
					<td width="42" height="16" nowrap><img src="images/timeline_arrow.gif" alt="" width="42" height="16" border="0"></td>
				<cfelse>
					<td width="42" height="16" nowrap></td>
				</cfif>
				<cfset week = week + 1>
			</cfloop>
		</cfif>
	</tr>
	</cfoutput>
</table>


<!--TIMELINE ENDS HERE-->
	<cfif cur_state neq 0>
		<cfscript>
		avg_level_of_assessment = #session.total_level_of_assessment# / #cur_state#;
		</cfscript>
	</cfif>
	</tr>
	<tr>
		<td colspan=12><img src="images/dot_clear.gif" width="721" height="28" alt=""></td>
	</tr>
	<tr>
		<td colspan=6>
		<!--MENTOR STARTS HERE-->	
		
		<table border="0" width="405" cellspacing="0" cellpadding="0">
	<tr>
		<td rowspan="0" align="left" valign="top" width="103">
<img src="images/mentor.gif" width="103" height="172" alt=""><br>
<cfif cur_state neq 0 AND cur_state neq get_ass.recordcount><A HREF="#Chart" ONMOUSEOVER="changeImages('progress', 'images/progress-over.gif'); return true;" ONMOUSEOUT="changeImages('progress', 'images/progress.gif'); return true;" onclick="javascript:ShowHideChart('show','OutcomesChart');window.focus();"><IMG NAME="progress" SRC="images/progress.gif" WIDTH=103 HEIGHT=27 BORDER=0 ALT="View your progress"></A><cfelse>&nbsp;</cfif></td>
		<td rowspan="0" align="left" valign="top" width="302">

<table width="302" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5">
			<img src="images/mentor_T_01.gif" width="302" height="14" alt=""></td>
	</tr>
	<tr>
		<td width="2" nowrap align="left" valign="top" bgcolor="#000000"><img src="images/mentor_left.gif" alt="" width="2" height="52" border="0"></td>
		<td width="5" nowrap></td>
		<td width="288" align="left" valign="top">
		<cfif cur_state neq 0>
			<div class="mentor">
			<cfmodule template="mentor_comment.cfm" 
			goal_alignment="#goal_alignment#"
			approach_to_learning="#approach_to_learning#"
			teacher_workload="#teacher_workload#"
			avg_level_of_assessment="#avg_level_of_assessment#">
			</div>
		<cfelse>
			<p class="mentor">
			Welcome to the start of your semester. I'll be here to offer some advice as the semester progresses. Click &quot;Run semester&quot; to start the simulation.
			</p>
			
			<p class="mentor">
			Here are some tips on using the simulator:
			</p>
			
			<p class="mentor">
			&bull; Move your cursor over highlighted weeks to view and edit the assessments set for those particular weeks.
			</p>
			
			<p class="mentor">
			&bull; Move your cursor over a student in your class to view feedback they may have for you as the semester progresses.
			</p>
			
			<p class="mentor">
			All the best, Anne :)
			</p>
		</cfif>	

</td>
		<td width="5" nowrap></td>
		<td width="2" nowrap bgcolor="#000000"></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="images/mentor_T_07.gif" width="302" height="15" alt=""></td>
	</tr>
</table>
		</td>
	</tr>
</table>

</td>
		<td><img src="images/dot_clear.gif" width="33" height="199" alt=""></td>
		<td colspan="5" valign="top">
		<!--STUDENTS START HERE-->		
		
		<table width="283" border="0" cellpadding="0" cellspacing="0">
			<tr><td colspan="7"><img src="images/students_top.gif" width="283" height="13" alt=""></td></tr>
			<cfif cur_state neq 0>
				<!--- generate class --->
				<cfmodule template="class_generator.cfm"
				 semester_running="true"
				 student_workload="#student_workload#"
				 feedback="#feedback#">
				<!--- end module --->
			<cfelse><!--- display the neutral picture --->
				<!--- generate class --->
				<cfmodule template="class_generator.cfm"
				 semester_running="false">
				<!--- end module --->
			</cfif>
			
			<tr><td colspan="7"><img src="images/students_bottom.gif" width="283" height="21" alt=""></td></tr>
		</table>
				
				
		<!--STUDENTS END HERE-->		
		
		
		</td>
	</tr>
	<tr>
		<td colspan=12><img src="images/dot_clear.gif" width="721" height="30" alt=""></td>
	</tr>
	<cfif cur_state neq 0>
	
	<tr>
		<td colspan=12>

		<!--CHART STARTS HERE-->		
		
		<div id="OutcomesChart">
		<a name="Chart">
		<table width="721" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="4"><img src="images/chart_01.gif" width="721" height="34" alt=""></td>
			</tr>
			<tr>
				<td rowspan="2"><img src="images/chart_02.gif" width="2" height="355" alt=""></td>
				<td bgcolor="#007AA3" colspan="2">&nbsp;<cfmodule template="outcomes_graph.cfm"></td>
				<td rowspan="2"><img src="images/chart_04.gif" width="14" height="355" alt=""></td>
			</tr>
			<tr>
				<td width="94"><a href="#Top"	onmouseover="changeImages('backtoclass', 'images/backtoclass-over.gif'); return true;"
						onmouseout="changeImages('backtoclass', 'images/backtoclass.gif'); return true;"<cfif cur_state neq get_ass.recordcount> onclick="javascript:ShowHideChart('hide','OutcomesChart');window.focus();"</cfif>><img name="backtoclass" src="images/backtoclass.gif" width="94" height="55" border="0" alt="Back to class"></a></td>
				<td><img src="images/chart_05.gif" width="611" height="55" alt=""></td>
			</tr>
		</table>
		</div>
<!--CHART ENDS HERE-->

		</td>
	</tr>
	
	</cfif>
	
	
	
	<cfif cur_state eq get_ass.recordcount><!--- if reach the last assessment --->
		<!--- calculate variables needed to generate final report --->
		<tr>
		<td colspan=12>
		
		<cfscript>
		
		avg_spacing_of_assessment = #session.total_spacing_of_assessment# / #cur_state#;
		avg_weighting = #session.total_weighting# / #cur_state#;
		avg_progression = #session.total_progression# / #cur_state#;
		</cfscript>
		
		<!--- make sure that all important variables range from 1 to 5--->
		<cfif round(avg_spacing_of_assessment) eq 0>
			<cfset avg_spacing_of_assessment = 1>
		<cfelseif round(avg_spacing_of_assessment) gt 5>
			<cfset avg_spacing_of_assessment = 5>
		</cfif>
		
		<cfif round(avg_weighting) eq 0>
			<cfset avg_weighting = 1>
		<cfelseif round(avg_weighting) gt 5>
			<cfset avg_weighting = 5>
		</cfif>
		
		<cfif round(avg_level_of_assessment) eq 0>
			<cfset avg_level_of_assessment = 1>
		<cfelseif round(avg_level_of_assessment) gt 5>
			<cfset avg_level_of_assessment = 5>
		</cfif>
		<!--- ========================================== --->
		
		<!--- call final report module --->
		<div class="copy">
		<cfmodule template="final_report.cfm" 
		goal_alignment="#goal_alignment#"
		approach_to_learning="#approach_to_learning#"
		student_workload="#student_workload#"
		teacher_workload="#teacher_workload#"
		feedback="#feedback#"
		public_confidence="#public_confidence#"
		avg_level_of_assessment="#avg_level_of_assessment#"
		avg_progression="#avg_progression#"
		avg_spacing_of_assessment="#avg_spacing_of_assessment#"
		avg_weighting="#avg_weighting#"
		num_assessment="#get_ass.recordcount#">
		</div>
		</td>
		</tr>
	</cfif>
<tr>
		<td><img src="images/dot_clear.gif" width="38" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="58" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="32" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="1" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="87" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="189" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="33" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="184" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="49" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="47" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="2" height="1" alt=""></td>
		<td><img src="images/dot_clear.gif" width="1" height="1" alt=""></td>
	</tr>
</table>

<!--FLOATING LAYERS START-->

<!--- <div id="numbers">
 <img src="images/numbers.gif" width=721 height=56>
</div> --->



<cfoutput query="get_ass" group="due_week"><!--- loop through all assessments to generate their individual layer --->
	<div id="tab_#get_ass.due_week#" onmouseover="javascript:swap('tab_#get_ass.due_week#');window.focus();" onmouseout="javascript:hidelayer('tab_#get_ass.due_week#');window.focus();">
	 <TABLE WIDTH=175 BORDER=0 CELLPADDING=0 CELLSPACING=0>
		<TR>
			<TD COLSPAN=4>
				<IMG SRC="images/panel_top.gif" WIDTH="175" HEIGHT="17" ALT=""></TD>
				</TR>
		<TR>
			<TD WIDTH="2" BGCOLOR="##FFCC00"><img src="images/dot_clear.gif" alt="" width="2" height="2" border="0"></TD>
			<TD WIDTH="171" COLSPAN="2" ALIGN="left" VALIGN="top" BGCOLOR="##007AA3" class="tabpanel">
	<cfoutput>
		<a href="edit_assessment.cfm?type=#get_ass.ass_id#&duedate=#get_ass.due_week#&whichass=#get_ass.which_ass#&start=true">#get_ass.which_ass# - #get_ass.ass_name#</a><br>
	</cfoutput>
	</TD>
			<TD WIDTH="2" BGCOLOR="##FFCC00"><img src="images/dot_clear.gif" alt="" width="2" height="2" border="0"></TD>
		</TR>
		<TR>
			<TD COLSPAN="2">
				<IMG SRC="images/panel_bottom.gif" WIDTH="135" HEIGHT="16" ALT=""></TD>
			<TD COLSPAN="2">
				<IMG SRC="images/panel_edit.gif" WIDTH="40" HEIGHT="16" BORDER=0 ALT="edit"></TD>
		</TR>
	<tr><td><img src="images/dot_clear.gif" width="2" height="1" alt=""></td><td><img src="images/dot_clear.gif" width="133" height="1" alt=""></td><td><img src="images/dot_clear.gif" width="38" height="1" alt=""></td><td><img src="images/dot_clear.gif" width="2" height="1" alt=""></td></tr>
	</TABLE>
	</div>
</cfoutput>





<!--- ============= --->

</body>
</html>
