function tweenweeks()
{
	TweenableList = new Array();
	for (returnvalues in _root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1])
	{
		if (!isNaN(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1][returnvalues])) TweenableList.push(returnvalues);
	}
	trace('TweenableList: ' + TweenableList.toString());
	
	WeeklyStates = new Array();
	laststate = 0;
	if (isNaN(_root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionass_weeks_list))
		sessionass_week_list = _root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionass_weeks_list.split(',');
	else
	{
		sessionass_week_list = new Array();
		sessionass_week_list[0] = _root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionass_weeks_list;
	}
	trace('sessionass_week_list: ' + sessionass_week_list.toString());
	trace('sessionass_week_list: ' + sessionass_week_list);

	sessionass_week_list_index = 0;
	for (weekcount = 1; weekcount <= 14; weekcount++)
	{
		if (sessionass_week_list[sessionass_week_list_index] == weekcount and sessionass_week_list.length > sessionass_week_list_index) sessionass_week_list_index++;
		
		WeeklyStates[weekcount] = new Object();
		
		if (sessionass_week_list_index == 0)
		{
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				WeeklyStates[weekcount][tweenable] = 0; //weekcount % 2;
				trace('weekcount: ' + weekcount + ' list_index: ' + sessionass_week_list_index + ' ' +  tweenable + ': unset :' + WeeklyStates[weekcount][tweenable]);
			}		
		}
		else
		{
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				WeeklyStates[weekcount][tweenable] = _root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable];
				trace('weekcount: ' + weekcount + ' list_index: ' + sessionass_week_list_index + ' ' +  tweenable + ': ' + WeeklyStates[weekcount][tweenable]);
			}
		}
		
	//	currentweek - lastweek / nextweek - lastweek 
	//	lastweekValue nextweekValue
		
		
	}
	
	// arrray of all weeks and their states
	_root.CalculatedWeeklyStates = WeeklyStates;
	// array of week numbers with asignments
	_root.AssignmentWeeks = sessionass_week_list;
}