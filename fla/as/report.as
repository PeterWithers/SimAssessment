function GenerateReport(FinalAssessmentData)
{
	trace('GenerateReport()');
/*	for (Student in _root.Classroom)
	{
		_root.Classroom[Student].gotoAndStop('neutral');
		_root.Classroom[Student].feedback = 'What does the report say?';
	}	*/
	/*
	Goal Alignment 
	Approach to Learning
	Feedback
	Student Workload
	Teacher Workload
	Public Confidence
	Level of Assessment
	Number of Assessment
	Spacing of Assessments
	Marker
	Weighting
	Progression
	Style of Feedback
	Depth of Feedback
	*/
	
	_root.FinalReportText = 
	'Goal Alignment\n' +
	_root.FinalReportArray['Goal Alignment'][FinalAssessmentData.goal_alignment] + '\n\n' +
	'Approach to Learning\n'+
	_root.FinalReportArray['Approach to Learning'][Math.round(FinalAssessmentData.approach_to_learning)] + '\n\n' +
	'Feedback\n'+
	_root.FinalReportArray['Feedback'][Math.round(FinalAssessmentData.feedback)] + '\n\n' +
	'Student Workload\n'+
	_root.FinalReportArray['Student Workload'][Math.round(FinalAssessmentData.student_workload)] + '\n\n' +
	'Teacher Workload\n'+
	_root.FinalReportArray['Teacher Workload'][Math.round(FinalAssessmentData.teacher_workload)] + '\n\n' +
	'Public Confidence\n'+
	_root.FinalReportArray['Public Confidence'][Math.round(FinalAssessmentData.public_confidence)] + '\n\n'; // +
/*	'Level of Assessment\n'+
//	_root.FinalReportArray['Level of Assessment'][
	 + '\n\n' +
	'Number of Assessment\n'+
//	_root.FinalReportArray['Number of Assessment'][
	 + '\n\n' +
	'Spacing of Assessments\n'+
//	_root.FinalReportArray['Spacing of Assessments'][
	 + '\n\n' +
	'Marker\n'+
	//_root.FinalReportArray['Marker'][
	 + '\n\n' +
	'Weighting\n'+
	//_root.FinalReportArray['Weighting'][
	 + '\n\n' +
	'Progression\n'+
	//_root.FinalReportArray['Progression'][
	 + '\n\n' +
	'Style of Feedback\n'+
	//_root.FinalReportArray['Style of Feedback'][
	 + '\n\n' +
	'Depth of Feedback\n'+
	//_root.FinalReportArray['Depth of Feedback'][
	 + '\n\n' ;*/
//	trace(_root.FinalReportText);
}
		
		