on(release)
{
	_root.CloseDialogues();
	_root.calculation_engine_called = false;	
	trace('_root.WeekOfAssignments['+_global.weechoo+']')
//	trace(_root.timetable.EditAssignment.MarkerType.getSelectedItem().data);
//	trace(_root.timetable.EditAssignment.AssignmentWorkload.getSelectedItem().data);
//	trace(_root.timetable.EditAssignment.FeedbackType.getSelectedItem().data.feedback_id);
//	trace(_root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_name);
	
	// put the AssignmentsForWeek into and array by week
	AssignmentsByWeek = new Array();
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{
		AssignmentsByWeek[_root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK] = _root.WeekOfAssignments[AssignmentsForWeek];
	}
	
	// call the AssignmentInstanceSelect change handler to update the current selection
	_root.timetable.AssignmentInstanceSelectChange();
	
	// modify the relevant week
	trace('insert week ass here');
	
	// put the assignments back into AssignmentsForWeek by week order
	_root.WeekOfAssignments = new Array();
	for (WeekCounter=1; WeekCounter<=14; WeekCounter++) 
	{
		if (AssignmentsByWeek[WeekCounter] != null)AssignmentsByWeek[WeekCounter].WHICH_ASS = _root.WeekOfAssignments.push(AssignmentsByWeek[WeekCounter]);
	}
	
	SetupTimetableDisplay();
}


