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
		
		// for the first week if there is no provided value set the data to zero
		if (sessionass_week_list_index == 0 and weekcount == 1)
		{
			trace('first week has no data; setting to zero');
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				WeeklyStates[weekcount][tweenable] = 0; //weekcount % 2;
				trace('weekcount: ' + weekcount + ' list_index: ' + sessionass_week_list_index + ' ' +  tweenable + ': unset :' + WeeklyStates[weekcount][tweenable]);
			}		
		}
		// for weeks with an assignment use the provided value
		else if (sessionass_week_list[sessionass_week_list_index - 1] == weekcount)
		{
			trace('assignment week: ' + weekcount);
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				WeeklyStates[weekcount][tweenable] = _root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable];
				trace('weekcount: ' + weekcount + ' list_index: ' + sessionass_week_list_index + ' ' +  tweenable + ': ' + WeeklyStates[weekcount][tweenable]);
			}
		}
		else
		{
			trace('tweened week: ' + weekcount);
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				
				lastvalue = WeeklyStates[weekcount - 1][tweenable];
				
				// get last value
				if (sessionass_week_list_index != 0)
				{
					lastvalue = _root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable];
					lastassignmetweek = sessionass_week_list[sessionass_week_list_index - 1];
				}
				else
				{
					lastvalue = 0;
					lastassignmetweek = 1;
				}
				// get next value
				if (_root.PreCalculatedStatesForSemester.length > sessionass_week_list_index + 1)
				{
					nextvalue = _root.PreCalculatedStatesForSemester[sessionass_week_list_index + 1][tweenable];
					nextassignmentweek = (sessionass_week_list[sessionass_week_list_index]);
				}
				else
				{
					nextvalue = 0;
					nextassignmentweek = 14;
				}
				
				percentagetweened = (weekcount - lastassignmetweek) / (nextassignmentweek - lastassignmetweek) * 100;
			
				currentvalue = lastvalue + (nextvalue - lastvalue) * percentagetweened / 100;
				
				trace('lastvalue: ' + lastvalue + ' lastassignmetweek: ' + lastassignmetweek + '  nextvalue: ' + nextvalue + ' nextassignmentweek: ' + nextassignmentweek + ' percentagetweened: ' + percentagetweened);
				
				trace('lastvalue: ' + lastvalue + '  nextvalue: ' + nextvalue + ' currentvalue: ' + currentvalue + ' percentagetweened: ' + percentagetweened);
				
				WeeklyStates[weekcount][tweenable] = currentvalue;
			}
		}		
	}
	
	// arrray of all weeks and their states
	_root.CalculatedWeeklyStates = WeeklyStates;
	// array of week numbers with asignments
	_root.AssignmentWeeks = sessionass_week_list;
}