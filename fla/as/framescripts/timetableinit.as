trace("timetableinit.as");

_root.timetable.EditAssignment._visible = false;

function SetWeekTextLable(AssignmentsForWeek)
{
	set ("WTTfirst" + _root.WeekOfAssignments[AssignmentsForWeek].due_week, _root.WeekOfAssignments[AssignmentsForWeek].ass_name);
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
		_root.timetable['tab' + i].current = 1;
		_root.timetable['tab' + i].WeekTabButton.onRelease = function()
		{
			this.current = this.current + 1;
		}
	}
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{		
		due_week = _root.WeekOfAssignments[AssignmentsForWeek].due_week;
		trace('due_week: ' + due_week);
		
		WeekTab = _root.timetable['tab' + due_week];
		WeekTab.count = WeekTab.count + 1;
		if (WeekTab.count > 1) 
		{
			WeekTab.WeekTabText.text = WeekTab.current + 'of' + WeekTab.count;
			WeekTab._visible = true;
		}
		_root.timetable.SetWeekTextLable(AssignmentsForWeek);
	}
}
SetupTimetableDisplay();

trace("start and read in new timetable data");
stop();

