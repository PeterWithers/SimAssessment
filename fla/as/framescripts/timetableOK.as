on(release)
{
	if (_root.DisableControls == true) return;
	
	// remove the (new) so that AssignmentInstanceSelect will update the current selection
	if (_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedItem().label == '1 of 1 (new)')
		_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedItem().label = '1 of 1';
		
	// call the AssignmentInstanceSelect change handler to update the current selection
	if (!_root.timetable.AssignmentInstanceDataIntoSelectData()) return;
	
	_root.CloseDialogues();
	
	_root.calculation_engine_called = false;
	_root.PreCalculatedStatesForSemester = null;
	_root.TweenedWeeklyStates = null;
	_root.AssessmentWeeksArray = null;
	
	splicebegin = null;
	splicecount = 0;
	
	// find the previous record of the weeks assignment
	for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
	{
		trace('AssignmentsForWeek: ' + AssignmentsForWeek);
		trace('due_week: ' + _root.WeekOfAssignments[AssignmentsForWeek].due_week); 
		if (_global.weechoo <= _root.WeekOfAssignments[AssignmentsForWeek].due_week)
		{
			trace('Add Assignment at: ' + AssignmentsForWeek);
			if (splicebegin == null) splicebegin = AssignmentsForWeek;
			if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].due_week) splicecount++;
		}
	}

	if (_root.WeekOfAssignments == 1) _root.WeekOfAssignments = new Array();
	
	// remove the previous record of the weeks assignment
	_root.WeekOfAssignments.splice(splicebegin, splicecount);

	// add the assignments from the select box data, excluding the 'new' element
	for (AssignmentInstanceCounter = _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 2; AssignmentInstanceCounter >= 0; AssignmentInstanceCounter--)
 		_root.WeekOfAssignments.splice(splicebegin, 0, _root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter).data);

	// sort assignments by due week and previous assignment number (which_ass)
	_root.WeekOfAssignments.sortOn( [ "due_week" , "which_ass" ], Array.NUMERIC );

	for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
	{
		_root.WeekOfAssignments[AssignmentsForWeek].which_ass = AssignmentsForWeek + 1;
	}

	SetupTimetableDisplay();
	//_root.timetable.CheckSemesterWorkloadPercentOK()
}


