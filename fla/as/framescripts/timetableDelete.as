on(release) 
{
	if (_root.DisableControls == true) return;
	
	// move selected item to end of the list
	for (AssignmentInstanceCounter = _root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedIndex(); AssignmentInstanceCounter < _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() - 1; AssignmentInstanceCounter++)
 		_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter).data = _root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter + 1).data;

	// remove the item and the "new" from the select
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
		_root.PreCalculatedStatesForSemester = null;
		_root.TweenedWeeklyStates = null;
		_root.AssignmentWeeks = null;
	
		WeekOfAssignmentsUpdated = new Array();
		for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
		{
			trace('AssignmentsForWeek: ' + AssignmentsForWeek);
			trace('due_week: ' + _root.WeekOfAssignments[AssignmentsForWeek].due_week); 
			if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].due_week)
				trace('one to remove');
			else
			{
				WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length] = _root.WeekOfAssignments[AssignmentsForWeek];
				WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length - 1].which_ass = WeekOfAssignmentsUpdated.length;
				WeekOfAssignmentsUpdated[WeekOfAssignmentsUpdated.length - 1].ass_id = WeekOfAssignmentsUpdated.length;
			}
		}
		_root.WeekOfAssignments = WeekOfAssignmentsUpdated;
		
		// sort assignments by due week and previous assignment number (which_ass)
		_root.WeekOfAssignments.sortOn( [ "due_week" , "which_ass" ], Array.NUMERIC );
		for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
		{
			_root.WeekOfAssignments[AssignmentsForWeek].which_ass = AssignmentsForWeek + 1;
		}		
		SetupTimetableDisplay();
	}
}


