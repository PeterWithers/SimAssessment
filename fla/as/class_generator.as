_root.StudentDoneWeeks = new Array();

function SetUpClass()
{
//<!--- on set up only not between weeks --->	
	_root.StudentsInClassroom = new Array();
	for (Student in _root.Classroom)
	{
		if (_root.Classroom[Student].student != null)
		{
			_root.StudentsInClassroom.push(_root.Classroom[Student]);
			_root.Classroom[Student].personality = Math.ceil(Math.random() * 15);
			// the following has been added to use the description, description1, description2 fields that Lawrence added.
			// there is a lack of clarity on how this fits with the personality 
			_root.Classroom[Student].type = Math.ceil(Math.random() * 3);
			_root.StudentHandDown(_root.Classroom[Student].student);
		}
	}
	_root.NumberOfStudents = _root.StudentsInClassroom.length;
	_root.SetUpWeek();
}
function SetUpWeek()
{
	//	gererateClassState(2.79166666667, true, 2.20833333333);
	_root.timetable.crossout.gotoAndStop(_root.CurrentWeekInSemester+1);
	trace('CurrentWeekInSemester: ' + _root.CurrentWeekInSemester);
	if (_root.CurrentWeekInSemester == 15)
	{
		FinalAssessmentData = _root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1];
		_root.GenerateReport(FinalAssessmentData);
		_root.intray.report.gotoAndPlay(2);
		_root.ShowOfHands = false;
		_root.StopSemester();
	}else{
		_root.intray.report.gotoAndStop(1);
		AssessmentWeeksArray = _root.PreCalculatedStatesForSemester[_root.PreCalculatedStatesForSemester.length - 1].sessionass_weeks_list.split(',');
		if (AssessmentWeeksArray == null)return;
		AssessmentIndex = AssessmentWeeksArray.length;
		while (AssessmentWeeksArray[AssessmentIndex - 1] > _root.CurrentWeekInSemester and AssessmentIndex > 0)AssessmentIndex--;
		trace('AssessmentIndex: ' + AssessmentIndex);
		AssessmentThisWeek = (AssessmentWeeksArray[AssessmentIndex - 1] == _root.CurrentWeekInSemester);
		_root.ShowOfHands = (AssessmentWeeksArray[0] <= _root.CurrentWeekInSemester);
		trace('_root.ShowOfHands'+_root.ShowOfHands);
//		avg_level_of_assessment = _root.PreCalculatedStatesForSemester[AssessmentIndex].total_level_of_assessment / WeekSearchCount;
		gererateClassState(_root.PreCalculatedStatesForSemester[AssessmentIndex].feedback, AssessmentIndex != 0, _root.PreCalculatedStatesForSemester[AssessmentIndex].student_workload, AssessmentThisWeek);
		SetupMentorCommentsForWeek(_root.PreCalculatedStatesForSemester[AssessmentIndex].approach_to_learning, _root.PreCalculatedStatesForSemester[AssessmentIndex].goal_alignment, AssessmentThisWeek);
	}
}
function GoBackOneWeek()
{
	if (_root.calculation_engine_called == true and _root.calculation_engine_returned == true)
	{
		_root.CurrentWeekInSemester--;
		if (_root.CurrentWeekInSemester < 0)_root.CurrentWeekInSemester = 0;
		SetUpWeek();
	}else if (_root.calculation_engine_called == false) _root.Call_calculation_engineService();
}
ProccessingOneAtATime = false;
function GoForwardOneWeek()
{
	trace('GoForwardOneWeek()');
	// during testing this has been slow to return
	// hence we check to see if the function has returned before calling again
	// not the most fool proof way but it will do in this case
	if (_root.ProccessingOneAtATime == false)
	{
		_root.ProccessingOneAtATime = true;
		if (_root.CurrentWeekInSemester == 15)clearInterval(_root.SemesterInterval);
		trace('calculation_engine_called == ' + _root.calculation_engine_called + ' and _root.calculation_engine_returned == ' + _root.calculation_engine_returned);
		if (_root.calculation_engine_called == true and _root.calculation_engine_returned == true)
		{
			_root.CurrentWeekInSemester++;
			if (_root.CurrentWeekInSemester > 15)_root.CurrentWeekInSemester = 15;
			_root.SetUpWeek();
		}else if (_root.calculation_engine_called == false) _root.Call_calculation_engineService();
		updateAfterEvent();
		_root.ProccessingOneAtATime = false;
	}
}
function gererateClassState(attributesfeedback, attributesSEMESTER_RUNNING, attributesstudent_workload, AssessmentThisWeek)	
{
	trace('gererateClassState(' + attributesfeedback + ' , ' + attributesSEMESTER_RUNNING + ' , ' + attributesstudent_workload + ')');
    happyCount = 0;
   	stressedCount = 0;
	neutralCount = 0;
    anxiousCount = 0;
	depressedCount = 0;
		
	if (attributesSEMESTER_RUNNING == true)
	{
//	<!--- code for class generation  --->
//	<!--- the code below is to generate the class emotion. to generate 15 different student. --->
		for (class_counter = 0; class_counter < NumberOfStudents; class_counter++)
		{
			query_position = _root.StudentsInClassroom[class_counter].personality;//assign the random query position -> pick up random student..... according to the associated session variable
			//calculate new student workload value for a particular student
			modified_student_workload = Math.round(attributesstudent_workload) + _root.Class_CharacteristicsArray[query_position].student_workload;
			//calculate new feedback value for a particular student
			modified_feedback = Math.round(attributesfeedback) + _root.Class_CharacteristicsArray[query_position].feedback;
			//calculate new student emotion value.. this is the inverse of generating student workload
			modified_student_emotion = (Math.abs(modified_student_workload - 5) * 4) - 10;
				
	//		<!--- make sure that all value ranges from 1-5 --->
			if (Math.round(modified_student_workload) == 0) modified_student_workload = 1;
			else if (Math.round(modified_student_workload) > 5) modified_student_workload = 5;
			
			if (Math.round(modified_feedback) == 0) modified_feedback = 1;
			else if (Math.round(modified_feedback) > 5) modified_feedback = 5;
				
	//		<!--- find the appropriate comment for student --->
			qStudentcomment = _root.StudentCommentsArray[Math.round(modified_student_workload)][Math.round(modified_feedback)];
					
			if (modified_student_emotion >= 3)
			{
				student_image = "happy";
				happyCount++;
			}
			else if ((modified_student_emotion > 0) and (modified_student_emotion < 3)) 
			{
				student_image = "stressed";
				stressedCount++;
			}
			else if (modified_student_emotion == 0) 
			{
				student_image = "neutral";
				neutralCount++;
			}
			else if ((modified_student_emotion > -3) and (modified_student_emotion < 0)) 
			{
				student_image = "anxious";
				anxiousCount++;
			}
			else if (modified_student_emotion < -3) 
			{
				student_image = "depressed";
				depressedCount++;
			}
			
			_root.StudentsInClassroom[class_counter].gotoAndStop(student_image);
			_root.StudentsInClassroom[class_counter].feedback = qStudentcomment.description;
			
			if(AssessmentThisWeek)
			{
				trace([_root.CurrentWeekInSemester] + ' : ' + [Math.round(modified_student_workload)] + ' : ' + [Math.round(modified_feedback)] + ' : ' + [_root.StudentsInClassroom[class_counter].type]);
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester] = new Array();
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)] = new Array();
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)] = new Array();
				
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)][_root.StudentsInClassroom[class_counter].type] == null)
				{
					_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)][_root.StudentsInClassroom[class_counter].type] = 1;
					trace('using comment');	
					if (qStudentcomment.description != null and qStudentcomment.description != '' and _root.StudentsInClassroom[class_counter].type == 1)
					{
						_root.email.InBoxGrid.addItem({Arrival: _root.email.InBoxGrid.length, From:'Student', Date:'week ' + _root.CurrentWeekInSemester, emailcont:'<i>from:&nbsp;Student</i><br><b>'+student_image+'</b><br><b>Week ' + _root.CurrentWeekInSemester+'</b><br><br>To ' + _root.UserName + '\n\n' + qStudentcomment.description + '\n\nStudent'});
						_root.computer.emailindicator.gotoAndPlay('new');
						_root.StudentHandUp(_root.StudentsInClassroom[class_counter].student);
					}
					if (qStudentcomment.description1 != null and qStudentcomment.description1 != '' and _root.StudentsInClassroom[class_counter].type == 2)
					{
						_root.email.InBoxGrid.addItem({Arrival: _root.email.InBoxGrid.length, From:'Student', Date:'week ' + _root.CurrentWeekInSemester, emailcont:'<i>from:&nbsp;Student</i><br><b>'+student_image+'</b><br><b>Week ' + _root.CurrentWeekInSemester+'</b><br><br>To ' + _root.UserName + '\n\n' + qStudentcomment.description2 + '\n\nStudent'});
						_root.computer.emailindicator.gotoAndPlay('new');			
						_root.StudentHandUp(_root.StudentsInClassroom[class_counter].student);
					}
					if (qStudentcomment.description2 != null and qStudentcomment.description2 != '' and _root.StudentsInClassroom[class_counter].type == 3)
					{			
						_root.email.InBoxGrid.addItem({Arrival: _root.email.InBoxGrid.length, From:'Student', Date:'week ' + _root.CurrentWeekInSemester, emailcont:'<i>from:&nbsp;Student</i><br><b>'+student_image+'</b><br><b>Week ' + _root.CurrentWeekInSemester+'</b><br><br>To ' + _root.UserName + '\n\n' + qStudentcomment.description3 + '\n\nStudent'});
						_root.computer.emailindicator.gotoAndPlay('new');						
						_root.StudentHandUp(_root.StudentsInClassroom[class_counter].student);
					}
				}
			}
		}
		_root.UpDateEmailCounters();
	}	
	else
	{ 
		trace('first week');
		for (class_counter = 0; class_counter < NumberOfStudents; class_counter++)
		{
			query_position = _root.StudentsInClassroom[class_counter].personality;
			student_image = "neutral";
			_root.StudentsInClassroom[class_counter].gotoAndStop(student_image);
			_root.StudentsInClassroom[class_counter].feedback = 'When does the semester start?';
		    happyCount = 0;
	    	stressedCount = 0;
			neutralCount = NumberOfStudents;
		    anxiousCount = 0;
			depressedCount = 0;
		}
	}
	_root.feedbackgraph.setValues(happyCount, stressedCount, neutralCount, anxiousCount, depressedCount, NumberOfStudents);
}

