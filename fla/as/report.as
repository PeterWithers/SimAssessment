function GenerateReport(FinalAssessmentData)
{
	trace('GenerateReport()');
/*	for (Student in _root.Classroom)
	{
		_root.Classroom[Student].gotoAndStop('neutral');
		_root.Classroom[Student].feedback = 'What does the report say?';
	}	*/
		
	for (ReportItem in _root.PreCalculatedStatesForSemester.reportvalues)
	{
		_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = Math.round(_root.PreCalculatedStatesForSemester.reportvalues[ReportItem]);
		if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] > 5) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 5;
		if (_root.PreCalculatedStatesForSemester.reportvalues[ReportItem] < 1) _root.PreCalculatedStatesForSemester.reportvalues[ReportItem] = 1;
	}
			
		
	// items and order as used in the cfm version are: Approach to Learning,Feedback,Student Workload,Teacher Workload,Public Confidence,Goal Alignment		
	_root.FinalReportText = "";

	_root.FinalReportText = _root.FinalReportText + 
	'Approach to Learning\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportApproachToLearning + "\n" +
		_root.FinalReportArray['Approach to Learning'][_root.PreCalculatedStatesForSemester.reportvalues.ReportApproachToLearning] + '\n\n';

	_root.FinalReportText = _root.FinalReportText + 
	'Feedback\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportFeedback + "\n" +
		_root.FinalReportArray['Feedback'][_root.PreCalculatedStatesForSemester.reportvalues.ReportFeedback] + '\n\n';

	_root.FinalReportText = _root.FinalReportText + 
	'Student Workload\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportStudentWorkload + "\n" +
		_root.FinalReportArray['Student Workload'][_root.PreCalculatedStatesForSemester.reportvalues.ReportStudentWorkload] + '\n\n';

	_root.FinalReportText = _root.FinalReportText + 
	'Teacher Workload\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportTeacherWorkload + "\n" +
		_root.FinalReportArray['Teacher Workload'][_root.PreCalculatedStatesForSemester.reportvalues.ReportTeacherWorkload] + '\n\n';

	_root.FinalReportText = _root.FinalReportText + 
	'Public Confidence\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportPublicConfidence + "\n" +
		_root.FinalReportArray['Public Confidence'][_root.PreCalculatedStatesForSemester.reportvalues.ReportPublicConfidence] + '\n\n';

	_root.FinalReportText = _root.FinalReportText + 
	'Goal Alignment\n' + _root.PreCalculatedStatesForSemester.reportvalues.ReportGoalAlignment + "\n" +
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
		
		