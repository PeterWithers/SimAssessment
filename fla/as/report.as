_root.GetReportValues = function (feedback_values_string)
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
//	_root.FinalReportText = _root.FinalReportText + itemresult + "\n";
		
	itemresult = Math.round(itemresult);
	if (itemresult > 5) itemresult = 5;
	if (itemresult < 1) itemresult = 1;
	_root.FinalReportText = _root.FinalReportText + "\nRMS " + itemresult + "\n";
	return (itemresult)
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

function GenerateReport(FinalAssessmentData)
{
	trace('GenerateReport()');
	_root.FinalReportText = "";
	
/*	for (Student in _root.Classroom)
	{
		_root.Classroom[Student].gotoAndStop('neutral');
		_root.Classroom[Student].feedback = 'What does the report say?';
	}	*/
	
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_deviation_" ) != -1 )
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
	_root.FinalReportText = _root.FinalReportText + "\n";
		
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_" ) != -1 and ReportItem.indexOf( "goal_deviation_" ) == -1)
			_root.FinalReportText = _root.FinalReportText + ReportItem + ": " + _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] + "\n";
	}	
	_root.FinalReportText = _root.FinalReportText + "\n";
		
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_deviation_" ) != -1 )
			_root.FinalReportText = _root.FinalReportText + ReportItem + ": " + _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] + "\n";
	}
	_root.FinalReportText = _root.FinalReportText + "\n";	
	
	_root.draw_goal_alignment_grid();
		
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		if (ReportItem.indexOf( "goal_" ) == -1 )
		{
			_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = Math.round(_root.PreCalculatedStatesForSemester.reportvalues[ReportItem]);
			if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] > 5) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 5;
			if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] < 1) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 1;
		}
	}

	/*
	CalculatedAssessment [5]
	goal_alignment: 2
	teacher_workload: 5
	sessionfeedback_values: 5,5,5,5,5
	sessionteacher_workload_values: 3.08333333333,4.33333333333,4.95833333333,5,5
	sessionapproach_to_learning_values: 2.33333333333,3.11111111111,3.02777777778,3.69444444444,4
	approach_to_learning: 4
	student_workload: 5
	feedback: 5
	sessionpublic_confidence_values: 3.79166666667,3.16666666667,2.79166666667,2.66666666667,2.54166666667
	sessionass_weeks_list: 4,6,8,10,12
	sessiongoal_alignment_values: 2,2,1,2,2
	student_emotion: -10
	sessiontotal_level_of_assessment: 0
	public_confidence: 2.54166666666667
	*/
	
	// items and order as used in the cfm version are: Approach to Learning,Feedback,Student Workload,Teacher Workload,Public Confidence,Goal Alignment		

	ReportApproachToLearning = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionapproach_to_learning_values);
	_root.FinalReportText = _root.FinalReportText + 
	'Approach to Learning\n' +
		_root.FinalReportArray['Approach to Learning'][ReportApproachToLearning] + '\n\n';

	ReportFeedback = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionfeedback_values);	
	_root.FinalReportText = _root.FinalReportText + 
	'Feedback\n' + // ReportFeedback + "\n" +
		_root.FinalReportArray['Feedback'][ReportFeedback] + '\n\n';

//	 = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionfeedback_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'Student Workload\n' + //_root.PreCalculatedStatesForSemester.reportvalues.ReportStudentWorkload + "\n" +
		_root.FinalReportArray['Student Workload'][_root.PreCalculatedStatesForSemester.reportvalues.ReportStudentWorkload] + '\n\n';

/*		
	ReportTeacherWorkload = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionteacher_workload_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'Teacher Workload\n' + //ReportTeacherWorkload + "\n" +
		_root.FinalReportArray['Teacher Workload'][ReportTeacherWorkload] + '\n\n';

	ReportPublicConfidence = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionpublic_confidence_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'Public Confidence\n' + //ReportPublicConfidence + "\n" +
		_root.FinalReportArray['Public Confidence'][ReportPublicConfidence] + '\n\n';
*/
//	 = GetReportValues(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionfeedback_values);	
	 _root.FinalReportText = _root.FinalReportText + 
	'Goal Alignment\n' + //_root.PreCalculatedStatesForSemester.reportvalues.ReportGoalAlignment + "\n" +
		_root.FinalReportArray['Goal Alignment'][_root.PreCalculatedStatesForSemester.reportvalues.ReportGoalAlignment] + '\n\n';
	
	// the following are not used in the cfm version
	_root.FinalReportText = _root.FinalReportText + 
	'Depth of Feedback\n' + _root.FinalReportArray['Depth of Feedback'][_root.PreCalculatedStatesForSemester.reportvalues.ReportDepthOfFeedback] + '\n\n';	
	_root.FinalReportText = _root.FinalReportText + 
	'Style of Feedback\n' + _root.FinalReportArray['Style of Feedback'][_root.PreCalculatedStatesForSemester.reportvalues.ReportStyleOfFeedback] + '\n\n';
	_root.FinalReportText = _root.FinalReportText + 
	'Progression\n' + _root.FinalReportArray['Progression'][_root.PreCalculatedStatesForSemester.reportvalues.ReportProgression] + '\n\n';
	_root.FinalReportText = _root.FinalReportText + 
	'Weighting\n' + _root.FinalReportArray['Weighting'][_root.PreCalculatedStatesForSemester.reportvalues.ReportWeighting] + '\n\n';
	_root.FinalReportText = _root.FinalReportText + 
	'Marker\n' + _root.FinalReportArray['Marker'][_root.PreCalculatedStatesForSemester.reportvalues.ReportMarker] + '\n\n';
	_root.FinalReportText = _root.FinalReportText + 
	'Spacing of Assessments\n' + _root.FinalReportArray['Spacing of Assessments'][_root.PreCalculatedStatesForSemester.reportvalues.ReportSpacingOfAssessments] + '\n\n';
	_root.FinalReportText = _root.FinalReportText + 
	'Number of Assessment\n' + _root.FinalReportArray['Number of Assessment'][_root.PreCalculatedStatesForSemester.reportvalues.ReportNumberOfAssessment] + '\n\n';
	_root.FinalReportText = _root.FinalReportText +
	'Level of Assessment\n' + _root.FinalReportArray['Level of Assessment'][_root.PreCalculatedStatesForSemester.reportvalues.ReportLevelOfAssessment] + '\n\n';
}
		
		