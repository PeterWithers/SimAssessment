// no assignmentd decay

function tweenweeks()
{
	TweenableList = new Array();
	for (returnvalues in _root.PreCalculatedStatesForSemester[1])
	{
		//if (!isNaN(_root.PreCalculatedStatesForSemester[1][returnvalues])) 
		TweenableList.push(returnvalues);
	}
	trace('TweenableList: ' + TweenableList.toString());
	
	WeeklyStates = new Array();
	laststate = 0;

	trace('_root.AssessmentWeeksArray: ' + _root.AssessmentWeeksArray);

	sessionass_week_list_index = 0;
	
	for (weekcount = 1; weekcount <= 14; weekcount++)
	{
		while (_root.AssessmentWeeksArray[sessionass_week_list_index] == weekcount and _root.AssessmentWeeksArray.length > sessionass_week_list_index) sessionass_week_list_index++;
		
		WeeklyStates[weekcount] = new Object();
		
		// for weeks with an assignment use the provided value
		if (_root.AssessmentWeeksArray[sessionass_week_list_index - 1] == weekcount)
		{
			trace('assignment week: ' + weekcount);
			for (tweenableindex in TweenableList)
			{
				tweenable = TweenableList[tweenableindex];
//				trace ( "tweenableindex: " + tweenableindex);
				WeeklyStates[weekcount][tweenable] = _root.GetRMSValue(_root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable]);
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
				//	trace ( "tweenable: " + tweenable);
					lastvalue = _root.GetRMSValue(_root.PreCalculatedStatesForSemester[sessionass_week_list_index][tweenable]);
					lastassignmetweek = _root.AssessmentWeeksArray[sessionass_week_list_index - 1];
				}
				else
				{
					// set the initial value
					lastvalue = 2.5;
					lastassignmetweek = 1;
				}
				// get next value
				if (_root.AssessmentWeeksArray.length > sessionass_week_list_index)
				{
//					if ( tweenable == "feedback" ) trace("get next value");
					//trace ( "tweenable: " + tweenable);
					nextvalue = _root.GetRMSValue(_root.PreCalculatedStatesForSemester[sessionass_week_list_index + 1][tweenable]);
					nextassignmentweek = (_root.AssessmentWeeksArray[sessionass_week_list_index]);
				}
				else
				{
//					if ( tweenable == "feedback" ) trace("get last value");
					nextvalue = WeeklyStates[_root.AssessmentWeeksArray[_root.AssessmentWeeksArray.length - 1]][tweenable];
					nextassignmentweek = 14;
				}
//				if ( tweenable == "feedback" ) trace('weeksfromtillassignment: ' + weeksfromtillassignment + ' weekstillassignment: ' + weekstillassignment + ' weeksfromassignment: ' + weeksfromassignment + ' weekcount: ' + weekcount);
				
				percentagebetween = (weekcount - lastassignmetweek) / (nextassignmentweek - lastassignmetweek) * 100;
				
				// add linear tween 
				if (_root.GraphDisplay.supressweektween == true) currentvalue = Number(lastvalue);
				else currentvalue = Number(lastvalue) + (Number(nextvalue) - Number(lastvalue)) * percentagebetween / 100;
				// end add linear tween 
				
				// add the lack of assignment decay
				if (eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') != null and !_root.GraphDisplay.supressweekdecay)
				{
//					trace('add the lack of assignment decay: ' + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') + ' : ' + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment);
					weeksfromassignment = weekcount - lastassignmetweek;
					weekstillassignment = nextassignmentweek - weekcount;
					
					if (_root.AssessmentWeeksArray.length <= sessionass_week_list_index + 1) weeksfromtillassignment = weeksfromassignment;
					else if (sessionass_week_list_index == 0) weeksfromtillassignment = weekstillassignment;
					else if (weeksfromassignment < weekstillassignment) weeksfromtillassignment = weeksfromassignment;
					else weeksfromtillassignment = weekstillassignment;
					
					if (!_root.GraphDisplay.weekdecaylog)
						currentvalue = currentvalue + eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment;
					else
						currentvalue = currentvalue + (eval('_root.GraphDisplay.tweeningvalues.' + tweenable + '_decay') * weeksfromtillassignment) / (1 + Math.log( weeksfromtillassignment)) / 1.5;
				}
				// end add the lack of assignment decay
			
//				if ( tweenable == "feedback" ) trace('lastvalue: ' + lastvalue + ' lastassignmetweek: ' + lastassignmetweek + '  nextvalue: ' + nextvalue + ' nextassignmentweek: ' + nextassignmentweek + ' percentagebetween: ' + percentagebetween);
//				if ( tweenable == "feedback" ) trace('lastvalue: ' + lastvalue + '  nextvalue: ' + nextvalue + ' currentvalue: ' + currentvalue + ' percentagebetween: ' + percentagebetween);

				WeeklyStates[weekcount][tweenable] = currentvalue;
//				if ( tweenable == "feedback" ) trace('currentvalue: ' + currentvalue + ' tweenable: ' + tweenable);
			}
		}		
	}
	
	// arrray of all weeks and their states
	_root.TweenedWeeklyStates = WeeklyStates;
}