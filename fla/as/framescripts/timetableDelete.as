on(release) 
{
	for (AssignmentInstanceCounter = _root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedIndex(); AssignmentInstanceCounter < _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 1; AssignmentInstanceCounter++)
 		_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter).data = _root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter + 1).data;
	_root.timetable.EditAssignment.AssignmentInstanceSelect.removeItemAt(_root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 1);
	_root.timetable.EditAssignment.AssignmentInstanceSelect.removeItemAt(_root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 1);
	if (_root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() > 0)
	{
		_root.timetable.UpdateSelectAddingNewItem();
		if (_root.timetable.LastSelectedAssignmentInstanceIndex < _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 2)
		{
			NextSelectedAssignmentInstanceIndex = _root.timetable.LastSelectedAssignmentInstanceIndex
		}
		else
		{
			NextSelectedAssignmentInstanceIndex = _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 2;
		}
		// clear and load the selections settings
		_root.timetable.PopulateSubjectInputs(_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(NextSelectedAssignmentInstanceIndex).data);
		// set the selection
		_root.timetable.EditAssignment.AssignmentInstanceSelect.setSelectedIndex(NextSelectedAssignmentInstanceIndex);
	}else{	
		_root.CloseDialogues();
		_root.calculation_engine_called = false;
	
		WeekOfAssignmentsUpdated = new Array();
		for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
		{
			trace('AssignmentsForWeek: ' + AssignmentsForWeek);
			trace('DUE_WEEK: ' + _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK); 
			if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK)
				trace('one to remove');
			else
				WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length] = _root.WeekOfAssignments[AssignmentsForWeek];
		}
//		WeekOfAssignmentsUpdated.sortOn('DUE_WEEK');
		_root.WeekOfAssignments = WeekOfAssignmentsUpdated;
		SetupTimetableDisplay();
	}
}


