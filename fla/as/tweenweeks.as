// no assignmentd decay

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
	trace('sessionass_week_list: ' + sessionass_week_list);

	sessionass_week_list_index = 0;
	
	for (weekcount = 1; weekcount <= 14; weekcount++)
	{
		while (sessionass_week_list[sessionass_week_list_index] == weekcount and sessionass_week_list.length > sessionass_week_list_index) sessionass_week_list_index++;
		
		WeeklyStates[weekcount] = new Object();
		
		// for weeks with an assignment use the provided value
		if (sessionass_week_list[sessionass_week_list_index - 1] == weekcount)
		{
			trace('assignment week: ' + weekcount);
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
				WeeklyStates[weekcount][tweenable] = _root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable];
				trace('weekcount: ' + weekcount + ' list_index: ' + sessionass_week_list_index + ' ' +  tweenable + ': ' + WeeklyStates[weekcount][tweenable]);
				trace('currentvalue:: ' + WeeklyStates[weekcount][tweenable] + ' tweenable: ' + tweenable);
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
					// set the initial value
					lastvalue = 2.5;
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
					nextvalue = WeeklyStates[sessionass_week_list[sessionass_week_list.length - 1]][tweenable];
					nextassignmentweek = 14;
				}
				
				trace('weeksfromtillassignment: ' + weeksfromtillassignment + ' weekstillassignment: ' + weekstillassignment + ' weeksfromassignment: ' + weeksfromassignment + ' weekcount: ' + weekcount);
				
				percentagebetween = (weekcount - lastassignmetweek) / (nextassignmentweek - lastassignmetweek) * 100;
				
				// add linear tween 
				if (_root.GraphDisplay.supressweektween == true) currentvalue = Number(lastvalue);
				else currentvalue = Number(lastvalue) + (Number(nextvalue) - Number(lastvalue)) * percentagebetween / 100;
				// end add linear tween 
				
				// add the lack of assignment decay
				if (eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') != null and !_root.GraphDisplay.supressweekdecay)
				{
					trace('add the lack of assignment decay: ' + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') + ' : ' + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment);
					weeksfromassignment = weekcount - lastassignmetweek;
					weekstillassignment = nextassignmentweek - weekcount;
					
					if (_root.PreCalculatedStatesForSemester.length <= sessionass_week_list_index + 1) weeksfromtillassignment = weeksfromassignment;
					else if (sessionass_week_list_index == 0) weeksfromtillassignment = weekstillassignment;
					else if (weeksfromassignment < weekstillassignment) weeksfromtillassignment = weeksfromassignment;
					else weeksfromtillassignment = weekstillassignment;
					
					if (!_root.GraphDisplay.weekdecaylog)
						currentvalue = currentvalue + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment;
					else
						currentvalue = currentvalue + (eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment) / (1 + Math.log( weeksfromtillassignment)) / 1.5;
				}
				// end add the lack of assignment decay
			
				
				//trace('lastvalue: ' + lastvalue + ' lastassignmetweek: ' + lastassignmetweek + '  nextvalue: ' + nextvalue + ' nextassignmentweek: ' + nextassignmentweek + ' percentagebetween: ' + percentagebetween);
				
				//trace('lastvalue: ' + lastvalue + '  nextvalue: ' + nextvalue + ' currentvalue: ' + currentvalue + ' percentagebetween: ' + percentagebetween);

				WeeklyStates[weekcount][tweenable] = currentvalue;
				trace('currentvalue: ' + currentvalue + ' tweenable: ' + tweenable);
			}
		}		
	}
	
	// arrray of all weeks and their states
	_root.TweenedWeeklyStates = WeeklyStates;
	// array of week numbers with asignments
	_root.AssignmentWeeks = sessionass_week_list;
}