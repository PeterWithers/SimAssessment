trace("timetablesetup.as");
trace(this);
function PopulateSubjectInputs(AssignmentObjectForWeek)
{
	// preset the inputs to match the current values
	trace('about to IndesOfThings');
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.MarkerType.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.MarkerType.getItemAt(IndesOfThings).data == AssignmentObjectForWeek.MARKER)
			_root.timetable.EditAssignment.MarkerType.setSelectedIndex(IndesOfThings);
	}
	for (IndesOfThings = 0; IndesOfThings < _root.timetable.EditAssignment.AssessmentType.getLength(); IndesOfThings++)
	{
		if (_root.timetable.EditAssignment.AssessmentType.getItemAt(IndesOfThings).data.ASS_NAME == AssignmentObjectForWeek.ASS_NAME)
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
	for (IndesOfThings in _root.timetable.EditAssignment.SubjectOutlineGoals)
	{
		_root.timetable.EditAssignment.SubjectOutlineGoals[IndesOfThings].setValue(false);
		AssignmentObjectForWeekArray = AssignmentObjectForWeek.goal_ids.split(',')
		for (GoalIdCounter in AssignmentObjectForWeekArray)
		{
			trace(_root.timetable.EditAssignment.SubjectOutlineGoals[IndesOfThings].DataObject.id + ' == ' + AssignmentObjectForWeekArray[GoalIdCounter]);
			if (_root.timetable.EditAssignment.SubjectOutlineGoals[IndesOfThings].DataObject.id == AssignmentObjectForWeekArray[GoalIdCounter])
				_root.timetable.EditAssignment.SubjectOutlineGoals[IndesOfThings].setValue(true);
		}
	}
}

// clear previous settings
_root.timetable.EditAssignment.AssessmentType.setSelectedIndex(0);
_root.timetable.EditAssignment.AssignmentWorkload.setSelectedIndex(0);
_root.timetable.EditAssignment.FeedbackType.setSelectedIndex(0);
_root.timetable.EditAssignment.MarkerType.setSelectedIndex(0);
AssignmentObjectForWeek = null;

// count the Assignments in this week
// and put them into the AssignmentInstanceSelect 
_root.timetable.EditAssignment.AssignmentInstanceSelect.removeAll();
for (AssignmentsForWeek in _root.WeekOfAssignments)
{
	if (_global.weechoo == _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK)
	_root.timetable.EditAssignment.AssignmentInstanceSelect.addItem(_root.timetable.EditAssignment.AssignmentInstanceSelect.length, _root.WeekOfAssignments[AssignmentsForWeek]);
}
_root.timetable.EditAssignment.AssignmentInstanceSelect.addItem('new', null);
//{ASS_ID: -1, ASS_NAME: -1, DUE_WEEK: -1, FEEDBACK: -1, MARKER: -1, WEIGHTING: -1, WHICH_ASS: -1, goal_ids: -1});

_root.timetable.PopulateSubjectInputs(_root.timetable.EditAssignment.AssignmentInstanceSelect.getItemAt(0).data);
_root.timetable.EditAssignment.AssignmentInstanceSelect.addEventListener("_root.timetable.PopulateSubjectInputs", _root.timetable.EditAssignment.AssignmentInstanceSelect.selectedItem.data);

_root.timetable.EditAssignment._visible = true;

// switch to wait until assessment is set - should be a function
keepstat=_global.stat; _global.stat=0; trace ("switch to stop while changing assessment");
//_root.time.stop();
//_root.clock.rotates=0;
//_root.simmenu.indicator.gotoAndStop(10+stat*10);

// set values on screen
var i=_global.weechoo;
var inputweek=_global.weechoo;
var inputworth=WWorth[i];
// retrieve WValues and set Screen display choices right
for (x=0;x<=7;x++) {
	if (WAssess[i]==AssessmentType[x]) {
		WAssessButton.gotoAndStop((x+1)*10);
		set (WDue[i], inputweek);
	}
}
for (x=0;x<=3;x++) {
	if (WMark[i]==Marker[x]) {
		WMarkButton.gotoAndStop((x+1)*10);
	}
}
for (x=0;x<=5;x++) {
	if (WType[i]==FeedbackType[x]) {
		WTypeButton.gotoAndStop((x+1)*10);
	}
}


// debug
for (i=0;i<=14;i++) {
	trace(WDue[i]+"/"+WAssess[i]+"/"+WWorth[i]+"/"+WType[i]+"/"+WMark[i])
}
trace("");

stop();

