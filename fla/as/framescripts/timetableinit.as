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
		DUE_WEEK = _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK
		set ("WTTfirst" + DUE_WEEK, _root.WeekOfAssignments[AssignmentsForWeek].ASS_NAME);
		set ("WTTsecond" + DUE_WEEK, (_root.WeekOfAssignments[AssignmentsForWeek].WEIGHTING+"  " + _root.WeekOfAssignments[AssignmentsForWeek].MARKER + "-marked"));
	}
}
SetupTimetableDisplay();

trace("start and read in new timetable data");
stop();

