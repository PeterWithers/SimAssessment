trace("timetablesetup.as");
trace(this);

function AssignmentInstanceDataIntoSelectData()
{
	// check that the select boxes are populated
	if (_root.timetable.EditAssignment.AssessmentType.getSelectedIndex() == 0)	
	{
		_root.OkMessageBox('Assessment type must be chosen');
		return(0);
	}
	if (_root.timetable.EditAssignment.AssignmentWorkload.getSelectedIndex() == 0)	
	{
		_root.OkMessageBox('Assignment workload must be chosen');
		return(0);
	}
	if (_root.timetable.EditAssignment.FeedbackType.getSelectedIndex() == 0)	
	{
		_root.OkMessageBox('Feedback type must be chosen');
		return(0);
	}
	if (_root.timetable.EditAssignment.MarkerType.getSelectedIndex() == 0)	
	{
		_root.OkMessageBox('Marker type must be chosen');
		return(0);
	}
	// find the selected goal ids
	SelectedGoalIds = new Array();
	for (CheckBoxItem in _root.timetable.EditAssignment.SubjectOutlineGoals)
	{
		if (_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].selected)
			SelectedGoalIds.push(_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].DataObject.id);
	}
	trace('SelectedGoalIds: ' + SelectedGoalIds);
	
	// check that goals are chosen
	if (SelectedGoalIds.length < 1)	
	{
		_root.OkMessageBox('Goals must be chosen');
		return(0);
	}
	
	_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(_root.timetable.LastSelectedAssignmentInstanceIndex).data = 
	{
		ASS_ID: _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_id, 
		ASS_NAME: _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_name, 
		DUE_WEEK: _global.weechoo, 
		FEEDBACK: _root.timetable.EditAssignment.FeedbackType.getSelectedItem().data.feedback_id, 
		MARKER: _root.timetable.EditAssignment.MarkerType.getSelectedItem().data, 
		WEIGHTING: _root.timetable.EditAssignment.AssignmentWorkload.getSelectedItem().data, 
		WHICH_ASS: '?', 
		goal_ids: SelectedGoalIds.toString()
	};
	
	/*trace(
	'AssignmentsByWeek['+_global.weechoo+'] = { ASS_ID: ' + _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ASS_ID +
	', ASS_NAME: ' + _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_name + 
	', DUE_WEEK: ' + _global.weechoo + ' , FEEDBACK: ' + _root.timetable.EditAssignment.FeedbackType.getSelectedItem().data.feedback_id + ' , ' +
	'MARKER: ' + _root.timetable.EditAssignment.MarkerType.getSelectedItem().data + ' , ' +
	'WEIGHTING: ' + _root.timetable.EditAssignment.AssignmentWorkload.getSelectedItem().data + ', ' + 
	' WHICH_ASS: ?, goal_ids: ' + SelectedGoalIds.toString() + '	};');*/
	
	// store the last selection;
	_root.timetable.LastSelectedAssignmentInstanceIndex =_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedIndex();
	return(1);
}

function UpdateSelectAddingNewItem()
{
	trace('UpdateSelectAddingNewItem');
	// these names are also set in the delete script
	for (AssignmentInstanceCounter = 0; AssignmentInstanceCounter < _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength(); AssignmentInstanceCounter++)
 		_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(AssignmentInstanceCounter).label = (AssignmentInstanceCounter + 1) + ' of ' + _root.timetable.EditAssignment.AssignmentInstanceSelect.getLength();
	// if none then provide a blank
	if (_root.timetable.EditAssignment.AssignmentInstanceSelect.getLength() == 0) _root.timetable.EditAssignment.AssignmentInstanceSelect.addItem('1 of 1', null);
	_root.timetable.EditAssignment.AssignmentInstanceSelect.addItem('new', null);
}
	
function AssignmentInstanceSelectChange()
{
	trace('AssignmentInstanceSelectChange()');
	// save the current settings
	if (_root.timetable.AssignmentInstanceDataIntoSelectData())
	{
		if (_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedItem().label == 'new') _root.timetable.UpdateSelectAddingNewItem();
		// clear and load the selections settings
		_root.timetable.PopulateSubjectInputs(_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedItem().data);
	}else
		if (_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedIndex() != _root.timetable.LastSelectedAssignmentInstanceIndex)
			_root.timetable.EditAssignment.AssignmentInstanceSelect.setSelectedIndex(_root.timetable.LastSelectedAssignmentInstanceIndex);
}

function PopulateSubjectInputs(AssignmentObjectForWeek)
{	
	// clear previous settings
	_root.timetable.EditAssignment.AssessmentType.setSelectedIndex(0);
	_root.timetable.EditAssignment.AssignmentWorkload.setSelectedIndex(0);
	_root.timetable.EditAssignment.FeedbackType.setSelectedIndex(0);
	_root.timetable.EditAssignment.MarkerType.setSelectedIndex(0);
	
	// preset the inputs to match the current values
	trace('about to IndesOfThings');
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.MarkerType.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.MarkerType.getItemAt(IndesOfThings).data == AssignmentObjectForWeek.MARKER)
			_root.timetable.EditAssignment.MarkerType.setSelectedIndex(IndesOfThings);
	}
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.AssessmentType.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.AssessmentType.getItemAt(IndesOfThings).data.ass_name == AssignmentObjectForWeek.ASS_NAME)
			_root.timetable.EditAssignment.AssessmentType.setSelectedIndex(IndesOfThings);
	}
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.AssignmentWorkload.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.AssignmentWorkload.getItemAt(IndesOfThings).data == AssignmentObjectForWeek.WEIGHTING)
			_root.timetable.EditAssignment.AssignmentWorkload.setSelectedIndex(IndesOfThings); 
	}
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.FeedbackType.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.FeedbackType.getItemAt(IndesOfThings).data.feedback_id == AssignmentObjectForWeek.FEEDBACK)
			_root.timetable.EditAssignment.FeedbackType.setSelectedIndex(IndesOfThings);
	}
	
	for (IndexOfThings in _root.timetable.EditAssignment.SubjectOutlineGoals)
	{		
//		trace('IndexOfThings: ' + IndexOfThings);
		_root.timetable.EditAssignment.SubjectOutlineGoals[IndexOfThings].selected = false;
	}
		
	AssignmentObjectForWeekArray = AssignmentObjectForWeek.goal_ids.split(',');
	for (GoalIdCounter in AssignmentObjectForWeekArray)
	{
//		trace('GoalIdCounter: ' + GoalIdCounter);
		_root.timetable.EditAssignment.SubjectOutlineGoals['CheckBox' + AssignmentObjectForWeekArray[GoalIdCounter]].selected  = true;
	}
}
AssignmentObjectForWeek = null;

// count the Assignments in this week
// and put them into the AssignmentInstanceSelect 
_root.timetable.EditAssignment.AssignmentInstanceSelect.removeAll();
for (AssignmentsForWeek in _root.WeekOfAssignments)
{
	if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK)
	_root.timetable.EditAssignment.AssignmentInstanceSelect.addItem('temp name', _root.WeekOfAssignments[AssignmentsForWeek]);
}
_root.timetable.UpdateSelectAddingNewItem();

_root.timetable.PopulateSubjectInputs(_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(0).data);

// store the last selection;
_root.timetable.LastSelectedAssignmentInstanceIndex =_root.timetable.EditAssignment.AssignmentInstanceSelect.getSelectedIndex();

_root.timetable.EditAssignment.AssignmentInstanceSelect.setChangeHandler('AssignmentInstanceSelectChange', _root.timetable);
_root.timetable.EditAssignment._visible = true;

stop();

