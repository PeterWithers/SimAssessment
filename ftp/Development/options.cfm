

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Sim Assessment for <cfoutput>#session.username#</cfoutput></title>
	<script language="JavaScript">
	function change_class()
	{
	window.opener.location='start_semester.cfm?change_class=true';
	window.close();
	}
	</script>
</head>

<body>
<cfoutput><h3>Sim Assessment for "#session.username#"</h3></cfoutput>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td bgcolor="#ffcc99"><strong>Please select one of the options below</strong></td>
</tr>

<tr>
	<td bgcolor="#ffcc99" valign="middle">&nbsp;<form><input type="Button" value="Change Class" onclick="change_class();"></form></td>
</tr>
</table>

</body>
</html>
