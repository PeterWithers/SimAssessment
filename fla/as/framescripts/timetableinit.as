trace("timetableinit.as"); 

_root.timetable.EditAssignment._visible = false;

function SetWeekTextLable(AssignmentsForWeek)
{
	trace('SetWeekTextLable('+AssignmentsForWeek+')');
/*	if (_root.EngineTest == true) 
	EngineTestTimetableText = ' ' + _root.WeekOfAssignments[AssignmentsForWeek].ass_id + ':' + _root.WeekOfAssignments[AssignmentsForWeek].which_ass;
	else */
	EngineTestTimetableText = '';
	set ("WTTfirst" + _root.WeekOfAssignments[AssignmentsForWeek].due_week, _root.WeekOfAssignments[AssignmentsForWeek].ass_name + EngineTestTimetableText);
	set ("WTTsecond" + _root.WeekOfAssignments[AssignmentsForWeek].due_week, (_root.WeekOfAssignments[AssignmentsForWeek].weighting+"  " + _root.WeekOfAssignments[AssignmentsForWeek].marker + "-marked"));
}

function SetupTimetableDisplay()
{
	for (i=1; i<=14; i++) 
	{
		set ("WTTsecond" + i, "");
		set ("WTTfirst" + i, "");
		_root.timetable['tab' + i]._visible = false;
		_root.timetable['tab' + i].count = 0;
		if (_root.timetable['tab' + i].current != null) _root.timetable['tab' + i].lastselection = _root.timetable['tab' + i].current;
		_root.timetable['tab' + i].current = 1;
		_root.timetable['tab' + i].WeekTabButton.onRelease = function()
		{
			trace('this.current ' + this._parent.current);
			trace('this.count ' + this._parent.count);
			WeekTab.lastselection = null;
			this._parent.current = this._parent.current + 1;
			if (this._parent.current > this._parent.count) this._parent.current = 1;
			this._parent.WeekTabText.text = this._parent.current + 'of' + this._parent.count;
			_root.timetable.SetWeekTextLable(this._parent.assignmentindex + this._parent.current - 1);
		}
	}
	for (AssignmentsForWeek = 0; AssignmentsForWeek < _root.WeekOfAssignments.length; AssignmentsForWeek++)
//	for (AssignmentsForWeek in _root.WeekOfAssignments) //
	{		
		due_week = _root.WeekOfAssignments[AssignmentsForWeek].due_week;
		trace('due_week: ' + due_week);
		trace('ass_name: ' + _root.WeekOfAssignments[AssignmentsForWeek].ass_name)		
		WeekTab = _root.timetable['tab' + due_week];
		WeekTab.count = WeekTab.count + 1;
		if (WeekTab.count > 1) 
		{
			if (WeekTab.lastselection != null && WeekTab.count >= WeekTab.lastselection) WeekTab.current = WeekTab.lastselection;
		
			WeekTab.WeekTabText.text = WeekTab.current + 'of' + WeekTab.count;
			WeekTab._visible = true;
		}
		if (WeekTab.count == WeekTab.current)
		{
			_root.timetable.SetWeekTextLable(AssignmentsForWeek);
		}
		if (WeekTab.count == 1)
		{
			WeekTab.assignmentindex = AssignmentsForWeek;
		}
	}
	if (_root.EngineTest == true)
	{
		_root.CloseDialogues();
		_root.GraphDisplay.show();
	}	
}
SetupTimetableDisplay();

trace("start and read in new timetable data");
stop();

