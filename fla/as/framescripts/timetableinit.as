trace("timetableinit.as");

_root.timetable.EditAssignment._visible = false;

function SetupTimetableDisplay()
{
	for (i=1; i<=14; i++) 
	{
		set ("WTTsecond" + i, "");
		set ("WTTfirst" + i, "");
	}
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{
		due_week = _root.WeekOfAssignments[AssignmentsForWeek].due_week
		set ("WTTfirst" + due_week, _root.WeekOfAssignments[AssignmentsForWeek].ass_name);
		set ("WTTsecond" + due_week, (_root.WeekOfAssignments[AssignmentsForWeek].weighting+"  " + _root.WeekOfAssignments[AssignmentsForWeek].marker + "-marked"));
	}
}
SetupTimetableDisplay();

trace("start and read in new timetable data");
stop();

