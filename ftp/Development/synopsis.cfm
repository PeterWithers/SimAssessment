<CFQUERY NAME="check" DATASOURCE="sim_assess">
SELECT s_outline_viewed
FROM run_state
WHERE user_id = #session.userid#
AND subject_id = #session.subjectid#
</CFQUERY>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Sim Assessment for <cfoutput>#session.username#</cfoutput></title>
	
	
	
	
</head>

<body>


<cfoutput><h3>Sim Assessment for "#session.username#"</h3></cfoutput>


<cfif isdefined ("s_outline")>
	<CFQUERY NAME="get_outline" DATASOURCE="sim_assess">
	SELECT subject_outline
	FROM subjects
	WHERE subject_name = '#session.subject#'
	</CFQUERY>
	<cfif get_outline.recordcount neq 0>
		<cfscript>
		trailer = ListDeleteAt("#cgi.script_name#","#ListLen("#cgi.script_name#","/")#","/");
		trailer = ListAppend("#trailer#","resources/#URLEncodedFormat("#get_outline.subject_outline#")#","/");
		NewUrl = "http://"&cgi.server_name&trailer;
		</cfscript>
		<!--- <cfoutput>#NewUrl#</cfoutput> --->
		<cflocation url="#NewUrl#" addtoken="No"> 
	<cfelse>
		The subject outline for this subject has not been setup.
	</cfif>
	<!--- <b>Subject Outline for: <cfoutput>#session.subject#</b>
	<br><br>
	#get_outline.subject_outline#
	</cfoutput> --->
	
	<CFQUERY NAME="update" DATASOURCE="sim_assess">
	UPDATE run_state
	SET s_outline_viewed = '1'
	WHERE user_id = #session.userid#
	AND subject_id = #session.subjectid#
	</CFQUERY>
	
	<!--- <p><a href="Javascript:void();" onclick="window.close();">Close</a></p> --->
<cfelseif isdefined ("grad_attr")>
	<CFQUERY NAME="get_grad" DATASOURCE="sim_assess">
	SELECT grad_attr
	FROM subjects
	WHERE subject_name = '#session.subject#'
	</CFQUERY>
	<cfif get_grad.recordcount neq 0>
		<cfscript>
		trailer = ListDeleteAt("#cgi.script_name#","#ListLen("#cgi.script_name#","/")#","/");
		trailer = ListAppend("#trailer#","resources/#URLEncodedFormat("#get_grad.grad_attr#")#","/");
		NewUrl = "http://"&cgi.server_name&trailer;
		</cfscript>
		
		<cflocation url="#NewUrl#" addtoken="No"> 
	<cfelse>
		The graduate attribute for this subject has not been setup.
	</cfif>
	<!--- <b>Graduate Attribute for: <cfoutput>#session.subject#</b>
	<br><br>
	#get_grad.grad_attr#
	</cfoutput>
	<p><a href="Javascript:void();" onclick="window.close();">Close</a></p> --->
<cfelseif isdefined ("feedback")>
	<CFQUERY NAME="get_feedback" DATASOURCE="sim_assess">
	SELECT feedback
	FROM subjects
	WHERE subject_name = '#session.subject#'
	</CFQUERY>
	<cfif get_feedback.recordcount neq 0>
		<cfscript>
		trailer = ListDeleteAt("#cgi.script_name#","#ListLen("#cgi.script_name#","/")#","/");
		trailer = ListAppend("#trailer#","resources/#URLEncodedFormat("#get_feedback.feedback#")#","/");
		NewUrl = "http://"&cgi.server_name&trailer;
		</cfscript>
		
		<cflocation url="#NewUrl#" addtoken="No"> 
	<cfelse>
		The feedback for this subject has not been setup.
	</cfif>
	<!--- <b>Feedback for: <cfoutput>#session.subject#</b>
	<br><br>
	#get_feedback.feedback#
	</cfoutput>
	<p><a href="Javascript:void();" onclick="window.close();">Close</a></p> --->
</cfif>
</body>
</html>
