<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cflock name="subject" timeout="20">
	<cfset session.subject = #url.subject#>
	<cfset session.subjectid = #s_id#>
</cflock>

<CFQUERY NAME="insert_user" DATASOURCE="sim_assess">
INSERT INTO run_state (user_name, subject_id, s_outline_viewed, current_state)
VALUES ('#session.username#', #s_id#, 0, 0)
</CFQUERY>

<CFQUERY NAME="get_user_id" DATASOURCE="sim_assess">
SELECT MAX(user_id) as id_last
FROM run_state
</CFQUERY>

<cflock name="id" timeout="20">
	<cfset session.userid = #get_user_id.id_last#>
</cflock>

<cfset todayDate = #Now()#>

<cfoutput><h3>Sim Assessment for "#session.username#"</h3>
	<br>
From: The Head of School of #url.dept#<br>
Date: #DateFormat("#todayDate#", "dd mmmm yyyy")#<br>
To: #session.username#<br>
Subject: Stand in Request<br>
<br><br>
I would like to thankyou for agreeing to take over #lec#'s #session.subject# class at such short notice and covering her 
classes for the rest of the semester as part of you teaching load. <br>
As you know, #lec#'s mother has taken seriously ill so she has decided to take leave to go to the UK and help nurse her mother through this difficult time.
<Br><br>
#lec# asked me to pass on some documents that will help you with your class preparation:
<br><br>
- The Graduate Attributes<br>
- Subject Outline<br>
- Assessment Schedule<br>
- Timetable<br>
- A summary of the feedback #lec# received from Last year's students on the course.
<br><Br>
#lec# hasn't had time to make changes to the subject based on the student feedback and would be grateful if you could do this for her. Could you send me the
 revised plan so that I can keep track of what's going on?
 <br><br>
 Thank you again for your help in these difficult times.
</cfoutput>
<form action="synopsis.cfm" method="post">
<input type="submit" value="Start >>">
</form>
</body>
</html>
