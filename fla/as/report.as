_root.GetRMSValue = function (feedback_values_string)
{
	if ( isNaN ( feedback_values_string ) )
	{	
		feedback_values_array = feedback_values_string.split(',');
		itemresult = 0;
		itemweighting = 1;
	//	_root.FinalReportText = _root.FinalReportText + "\n" + feedback_values_array + "\n\nSQRT (\n\t(\n";
		for (sessionvalue in feedback_values_array)
		{
			itemresult = itemresult + Number(feedback_values_array[sessionvalue]) * Number(feedback_values_array[sessionvalue]) * itemweighting;
	//		_root.FinalReportText = _root.FinalReportText + "\t\t( " + feedback_values_array[sessionvalue] + " * " + feedback_values_array[sessionvalue] + " * " + itemweighting + " ) + \n";
		}
		itemresult = itemresult / feedback_values_array.length;
	//	_root.FinalReportText = _root.FinalReportText + "\t) / " + feedback_values_array.length + " )\n";
		itemresult = Math.sqrt(itemresult);
	}
	else
	{
		itemresult = new Number(feedback_values_string);
	}
	//trace("\nRMS ( " + feedback_values_string + " ) = " + itemresult + "");
	return (itemresult)
}

_root.GetRMSintValue = function (feedback_values_string)
{
	itemresult = _root.GetRMSValue(feedback_values_string);
	itemresult = Math.round(itemresult);
	if (itemresult > 5) itemresult = 5;
	if (itemresult < 1) itemresult = 1;
	return (itemresult);
}

_root.draw_goal_alignment_grid = function()
{
	for (things in _root.goal_alignment_array) 
	{
		_root.FinalReportText = _root.FinalReportText + things + ": ";
		for (thing in _root.goal_alignment_array[things]) 
		{
			_root.FinalReportText = _root.FinalReportText + _root.goal_alignment_array[things][thing] + " | ";
//			_root.FinalReportText = _root.FinalReportText + thing + ", ";
		}
		_root.FinalReportText = _root.FinalReportText + "\n";
	}
}

function GenerateReport()
{
	_root.FinalReportText = "<b>Report</b><br><br>";
	
//	_root.FinalReportText = _root.FinalReportText + "\n\n\t<a href='actionscript:ShowAssignmentGoalGrid()'>ShowAssignmentGoalGrid</a>\n\n";
//	_root.FinalReportText = _root.FinalReportText + "<A HREF=\"asfunction:_root.ShowAssignmentGoalGrid,Foo \">Click Me!</A>";
	
//	_root.FinalReportText = _root.FinalReportText + "<span style='writing-mode:tb-rl;'>ass_name_writing-mode</span>\n\n";
//	_root.FinalReportText = _root.FinalReportText + "<table> <th>new_goal_alignment2</th><tr><td>&nbsp;</td><td>ass_name</td></tr><tr><td>ass_name</td></tr><tr><td>NAME</td><td>VALUE</td></tr></table>";
//	_root.FinalReportText = _root.FinalReportText + "<table> <th>new_goal_alignment2</th><tr><td>&nbsp;</td><td>ass_name</td></tr><tr><td style='writing-mode:tb-rl;'>ass_name</td></tr><tr><td>NAME</td><td>VALUE</td></tr></table>";
//	_root.FinalReportText = _root.FinalReportText + "<table> <th>new_goal_alignment2</th><tr><td>&nbsp;</td><td>ass_name</td></tr><tr><td nowrap style='writing-mode:tb-rl;'>ass_name</td></tr><tr><td>NAME</td><td>VALUE</td></tr></table>";
//	_root.FinalReportText = _root.FinalReportText + "\n";
//	_root.FinalReportText = _root.FinalReportText + "\n";
//	_root.FinalReportText = _root.FinalReportText + "\n";	
//	_root.FinalReportText = _root.FinalReportText + "<table> <th>new_goal_alignment2</th><tr bgcolor='eeaaaa'><td>&nbsp;</td><td>ass_name</td></tr><tr bgcolor='eeaaaa'><td nowrap style='writing-mode:tb-rl;'>ass_name</td></tr><tr bgcolor='eeaaaa'><td>NAME</td><td>VALUE</td></tr>";
//	_root.FinalReportText = _root.FinalReportText + "<tr bgcolor='eeaaaa'><td>&nbsp;</td><td>ass_name</td></tr><tr bgcolor='eeaaaa'><td nowrap style='writing-mode:tb-rl;'>ass_name</td></tr><tr bgcolor='eeaaaa'><td>NAME</td><td>VALUE</td></tr></table>";

	/*	
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_" ) != -1 and ReportItem.indexOf( "goal_deviation_" ) == -1)
			_root.FinalReportText = _root.FinalReportText + ReportItem + ": " + _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] + "\n";
	}	
	_root.FinalReportText = _root.FinalReportText + "\n";
	*/
	/*
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_deviation_" ) != -1 )
			_root.FinalReportText = _root.FinalReportText + ReportItem + ": " + _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] + "\n";
	}
	_root.FinalReportText = _root.FinalReportText + "\n";	
	*/

	
	// items and order as used in the cfm version are: Approach to Learning,Feedback,Student Workload,Teacher Workload,Public Confidence,Goal Alignment		

	ReportApproachToLearning = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.approach_to_learning_values);
	_root.FinalReportText = _root.FinalReportText + 
	'<b>Approach to Learning</b><br>' +
		_root.FinalReportArray['Approach to Learning'][ReportApproachToLearning] + '<br><br>';

	ReportFeedback = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.feedback_values);	
	_root.FinalReportText = _root.FinalReportText + 
	'<b>Feedback</b><br>' + // ReportFeedback + "<br>" +
		_root.FinalReportArray['Feedback'][ReportFeedback] + '<br><br>';

	 ReportStudentWorkload = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.student_workload_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'<b>Student Workload</b><br>' + //_root.PreCalculatedStatesForSemester.reportvalues.ReportStudentWorkload + "<br>" +
		_root.FinalReportArray['Student Workload'][ReportStudentWorkload] + '<br><br>';

	ReportTeacherWorkload = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.teacher_workload_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'<b>Teacher Workload</b><br>' + //ReportTeacherWorkload + "<br>" +
		_root.FinalReportArray['Teacher Workload'][ReportTeacherWorkload] + '<br><br>';

	ReportPublicConfidence = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.public_confidence_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'<b>Public Confidence</b><br>' + //ReportPublicConfidence + "<br>" +
		_root.FinalReportArray['Public Confidence'][ReportPublicConfidence] + '<br><br>';
		
//	 = GetRMSintValue(_root.PreCalculatedStatesForSemester.reportvalues.feedback_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'<b>Goal Alignment</b><br>' + // Math.round(_root.PreCalculatedStatesForSemester.reportvalues.ReportGoalAlignment) + "<br>" +
		_root.FinalReportArray['Goal Alignment'][Math.round(_root.PreCalculatedStatesForSemester.reportvalues.ReportGoalAlignment)] + '<br><br>';
/*	
	// the following are not used in the cfm version
	_root.FinalReportText = _root.FinalReportText + 
	'Depth of Feedback<br>' + _root.FinalReportArray['Depth of Feedback'][_root.PreCalculatedStatesForSemester.reportvalues.ReportDepthOfFeedback] + '<br><br>';	
	_root.FinalReportText = _root.FinalReportText + 
	'Style of Feedback<br>' + _root.FinalReportArray['Style of Feedback'][_root.PreCalculatedStatesForSemester.reportvalues.ReportStyleOfFeedback] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText + 
	'Progression<br>' + _root.FinalReportArray['Progression'][_root.PreCalculatedStatesForSemester.reportvalues.ReportProgression] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText + 
	'Weighting<br>' + _root.FinalReportArray['Weighting'][_root.PreCalculatedStatesForSemester.reportvalues.ReportWeighting] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText + 
	'Marker<br>' + _root.FinalReportArray['Marker'][_root.PreCalculatedStatesForSemester.reportvalues.ReportMarker] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText + 
	'Spacing of Assessments<br>' + _root.FinalReportArray['Spacing of Assessments'][_root.PreCalculatedStatesForSemester.reportvalues.ReportSpacingOfAssessments] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText + 
	'Number of Assessment<br>' + _root.FinalReportArray['Number of Assessment'][_root.PreCalculatedStatesForSemester.reportvalues.ReportNumberOfAssessment] + '<br><br>';
	_root.FinalReportText = _root.FinalReportText +
	'Level of Assessment<br>' + _root.FinalReportArray['Level of Assessment'][_root.PreCalculatedStatesForSemester.reportvalues.ReportLevelOfAssessment] + '<br><br>';
*/

	for (GoalAssignmentType in _root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items)
	{
//		_root.FinalReportText = _root.FinalReportText + GoalAssignmentType + "\t";
//		_root.FinalReportText = _root.FinalReportText + _root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType] + "\t";
//		_root.FinalReportText = _root.FinalReportText + "\t\t\t\t\t\t";
		_root.FinalReportText = _root.FinalReportText + "<textformat tabstops='[200]'>";
		_root.FinalReportText = _root.FinalReportText + "<b>" + _root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].AssignmentType + "</b>";
		_root.FinalReportText = _root.FinalReportText + "\t(X = achieved, 0 = not achieved) <br>";
		_root.FinalReportText = _root.FinalReportText + "Autonomy\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].autonomy > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Citizenship\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].citizenship > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Communicative\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].communicative > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Contextual\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].contextual > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Knowledge Literacy\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].knowledgeliteracy > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Responsive\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].responsive > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Technical\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].technical > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "Workload\t";
		if (_root.PreCalculatedStatesForSemester.reportvalues.goal_deviation.items[GoalAssignmentType].workload > 0) _root.FinalReportText = _root.FinalReportText + "X<br>";
		else _root.FinalReportText = _root.FinalReportText + "0<br>";
		_root.FinalReportText = _root.FinalReportText + "</textformat> <br>";
	}
	/*
	_root.FinalReportText = _root.FinalReportText + "\n";
	_root.FinalReportText = _root.FinalReportText + "\n";		
	_root.FinalReportText = _root.FinalReportText + "----------------------------------------------------";
	_root.FinalReportText = _root.FinalReportText + "\n";
	_root.FinalReportText = _root.FinalReportText + "\n";			
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_deviation" ) != -1 )
		{
			_root.FinalReportText = _root.FinalReportText + ReportItem.substring(15) + "\t";
			TempGoalArray = _root.PreCalculatedStatesForSemester.reportvalues[ReportItem].split(',')
			for (goalassignments in TempGoalArray)
			{
				if ( TempGoalArray[goalassignments] > 0) _root.FinalReportText = _root.FinalReportText + 'X\t';
				else _root.FinalReportText = _root.FinalReportText + 'O\t';
			}
			_root.FinalReportText = _root.FinalReportText + "\n";
		}
	}	

	_root.FinalReportText = _root.FinalReportText + "\n\n";
	_root.draw_goal_alignment_grid();
	
	_root.FinalReportText = _root.FinalReportText + "\n\n";	
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_" ) == -1 )
		{
			_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = Math.round(_root.PreCalculatedStatesForSemester.reportvalues[ReportItem]);
			if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] > 5) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 5;
			if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] < 1) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 1;
		}
	}	
	
	
	_root.FinalReportText = _root.FinalReportText + "\n\n";
	// draw titles sideways
	TitlesArray = ["Autonomy", "Citizenship", "Communicative", "Contextual", "Knowledge Lit", "Responsive", "Technical", "Workload"];
	CharsLeft = true;
	CharsCount = 0;
	while (CharsLeft)
	{
		CharsLeft = false;	
		_root.FinalReportText = _root.FinalReportText + "\t\t";	
		for (Titles in TitlesArray)
		{
			if (TitlesArray[Titles].length > CharsCount)
			{
				CharsLeft = true;
				_root.FinalReportText = _root.FinalReportText + TitlesArray[Titles].charAt(CharsCount);
			} else _root.FinalReportText = _root.FinalReportText + " ";
			_root.FinalReportText = _root.FinalReportText + "\t\t";
		}
		CharsCount++;
		_root.FinalReportText = _root.FinalReportText + "\n";
	}	
	*/
}
		
		