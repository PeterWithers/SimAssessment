on(release)
{
	// call the AssignmentInstanceSelect change handler to update the current selection
	if (!_root.timetable.AssignmentInstanceDataIntoSelectData()) return;
	
	_root.CloseDialogues();
	_root.calculation_engine_called = false;

	WeekOfAssignmentsUpdated = new Array();
	for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
	{
		trace('AssignmentsForWeek: ' + AssignmentsForWeek);
		trace('due_week: ' + _root.WeekOfAssignments[AssignmentsForWeek].due_week); 
		if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].due_week)
			trace('one to remove');
		else
			WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length] = _root.WeekOfAssignments[AssignmentsForWeek];
	}

	for (AssignmentInstanceCounter = 0; AssignmentInstanceCounter < _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 1; AssignmentInstanceCounter++)
 		WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length] = _root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter).data;

	WeekOfAssignmentsUpdated.sortOn('due_week', Array.NUMERIC);
	_root.WeekOfAssignments = WeekOfAssignmentsUpdated;
	
	for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++) _root.WeekOfAssignments[AssignmentsForWeek].which_ass = AssignmentsForWeek + 1;

	SetupTimetableDisplay();
}


