on(release)
{
	_root.timetable.EditAssignment._visible = false;
	
	trace('_root.WeekOfAssignments['+_global.weechoo+']')
	trace(_root.timetable.EditAssignment.MarkerType.getSelectedItem().data);
	trace(_root.timetable.EditAssignment.AssignmentWorkload.getSelectedItem().data);
	trace(_root.timetable.EditAssignment.FeedbackType.getSelectedItem().data.feedback_id);
	trace(_root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_name);
	
	// put the AssignmentsForWeek into and array by week
	AssignmentsByWeek = new Array();
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{
		AssignmentsByWeek[_root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK] = _root.WeekOfAssignments[AssignmentsForWeek];
	}
	
	// find the selected goal ids
	SelectedGoalIds = new Array();
	for (CheckBoxItem in _root.timetable.EditAssignment.SubjectOutlineGoals)
	{
		trace('CheckBoxItem: ' + CheckBoxItem + ' ' + _root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].DataObject.id);
		if (_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].getValue())
			SelectedGoalIds.push(_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].DataObject.id);
	}
	trace('SelectedGoalIds: ' + SelectedGoalIds);
	
	// modify the relevant week
	AssignmentsByWeek[_global.weechoo] = 
	{
		ASS_ID: _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ASS_ID, 
		ASS_NAME: _root.timetable.EditAssignment.AssessmentType.getSelectedItem().data.ass_name, 
		DUE_WEEK: _global.weechoo, 
		FEEDBACK: _root.timetable.EditAssignment.FeedbackType.getSelectedItem().data.feedback_id, 
		MARKER: _root.timetable.EditAssignment.MarkerType.getSelectedItem().data, 
		WEIGHTING: _root.timetable.EditAssignment.AssignmentWorkload.getSelectedItem().data, 
		WHICH_ASS: '?', 
		goal_ids: SelectedGoalIds.toString()
	};
	// put the assignments back into AssignmentsForWeek by week order
	_root.WeekOfAssignments = new Array();
	for (WeekCounter=1; WeekCounter<=14; WeekCounter++) 
	{
		if (AssignmentsByWeek[WeekCounter] != null)AssignmentsByWeek[WeekCounter].WHICH_ASS = _root.WeekOfAssignments.push(AssignmentsByWeek[WeekCounter]);
	}
	
	SetupTimetableDisplay();
	
	/*
		i=_global.weechoo;
		WWorth[i]=inputworth;
		WDue[i]=inputweek;
	if (WAssess[i]==0) {
		set ("WTTfirst"+i,"");
		set ("WTTsecond"+i,"");
	} else {
		set ("WTTfirst"+i,WAssess[i]);
		set ("WTTsecond"+i,("worth: "+WWorth[i]+" %   "+WMark[i]+"-marked"));
	}
	
	// switch back
	_global.stat=keepstat; trace ("switch back");
	if (keepstat==1) {
		_root.time.play();
		_root.clock.rotates=5;
	} else {
		_root.time.stop();
		_root.clock.rotates=0;
	}
	_root.simmenu.indicator.gotoAndStop(10+stat*10);
	*/
	gotoAndStop("start");
}


