on(release) 
{
	_root.timetable.EditAssignment._visible = false;
	
	// put the AssignmentsForWeek into and array by week
	AssignmentsByWeek = new Array();
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{
		AssignmentsByWeek[_root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK] = _root.WeekOfAssignments[AssignmentsForWeek];
	}
	// modify the relevant week
	AssignmentsByWeek[_global.weechoo] = null;
	// put the assignments back into AssignmentsForWeek by week order
	_root.WeekOfAssignments = new Array();
	for (WeekCounter=1; WeekCounter<=14; WeekCounter++) 
	{
		if (AssignmentsByWeek[WeekCounter] != null)_root.WeekOfAssignments.push(AssignmentsByWeek[WeekCounter]);
	}
	
	SetupTimetableDisplay();
/*	var i=_global.weechoo;
	set ("WTTfirst"+i,"");
	set ("WTTsecond"+i,"");
	WAssess[i]=0;
	WWorth[i]=0;
	WDue[i]=0;
	WMark[i]=0;
	WType[i]=0;
	
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


