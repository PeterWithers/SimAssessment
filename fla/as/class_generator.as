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
			_root.Classroom[Student].personality_workload = Math.random() * 2 - 1;
			_root.Classroom[Student].personality_feedback = Math.random() * 2 - 1;
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

		gererateClassState(_root.TweenedWeeklyStates[_root.CurrentWeekInSemester].feedback, AssessmentIndex != 0, _root.TweenedWeeklyStates[_root.CurrentWeekInSemester].student_workload, AssessmentThisWeek);

		SetupMentorCommentsForWeek(_root.TweenedWeeklyStates[_root.CurrentWeekInSemester].approach_to_learning, _root.TweenedWeeklyStates[_root.CurrentWeekInSemester].goal_alignment, AssessmentThisWeek);
	}
}
function GoBackOneWeek()
{
	if (_root.calculation_engine_called == true and _root.calculation_engine_returned == true)
	{
		_root.CurrentWeekInSemester--;
		_root.LastPlayerButtonPress = "done";
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
			_root.LastPlayerButtonPress = "done";
			_root.CurrentWeekInSemester++;
			if (_root.CurrentWeekInSemester > 15)_root.CurrentWeekInSemester = 15;
			_root.SetUpWeek();
		}else if (_root.calculation_engine_called == false) _root.Call_calculation_engineService();
		updateAfterEvent();
		_root.ProccessingOneAtATime = false;
	}
}

function calculate_emotion(calculate_emotion_workload, calculate_emotion_feedback)
{
	calculate_emotion_workload = Number(calculate_emotion_workload);
	calculate_emotion_feedback = Number(calculate_emotion_feedback);

	if (calculate_emotion_workload < 1) calculate_emotion_workload = 1;
	if (calculate_emotion_workload > 5) calculate_emotion_workload = 5;
	if (calculate_emotion_feedback < 1) calculate_emotion_feedback = 1;
	if (calculate_emotion_feedback > 5) calculate_emotion_feedback = 5;
	// good for 0 - 5
//	calculated_student_emotion = ((Math.abs(calculate_emotion_workload * 1.47 - 5) * 4) - 10);
	// good for 1 - 5
//	calculated_student_emotion = ((Math.abs(calculate_emotion_workload - 3) * 5) - 5);
//	if (calculated_student_emotion > 5) calculated_student_emotion = 5;
//	if (calculated_student_emotion < -5) calculated_student_emotion = -5;
	
	// calculate the feedback into the equation
//	calculated_student_emotion = calculated_student_emotion + ((calculate_emotion_feedback - 1) * 2.5) -5;
//	calculated_student_emotion = calculated_student_emotion / 2;

	calculated_student_emotion = (calculate_emotion_workload + calculate_emotion_feedback) / 2;
	
	if (calculated_student_emotion > 5) calculated_student_emotion = 5;
	if (calculated_student_emotion < 1) calculated_student_emotion = 1;

	return Math.round(calculated_student_emotion);
}


function gererateClassState(current_weeks_feedback, attributesSEMESTER_RUNNING, current_weeks_workload, AssessmentThisWeek)	
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
			//calculate new student workload and feedback values for the current student			
			personal_workload = Math.round(Number(current_weeks_workload) + _root.StudentsInClassroom[class_counter].personality_workload);
			personal_feedback = Math.round(Number(current_weeks_feedback) + _root.StudentsInClassroom[class_counter].personality_feedback);
			
			personal_emotion = calculate_emotion(personal_workload, personal_feedback);

				// emotion should be workload and feedback 
				// where feedback is a linear relationship
				// and workload is a bell curve
				// all values except emotion are 0 - 5 so the auto range graph can be removed
				// assignmet spacing algor
				// graph starts at 2.5 
				// graph personalities in grey to indicate personality offset
				
					//		<!--- make sure that all value ranges from 1-5 --->
			if (personal_workload == 0) personal_workload = 1;
			else if (personal_workload > 5) personal_workload = 5;
			
			if (personal_feedback == 0) personal_feedback = 1;
			else if (personal_feedback > 5) personal_feedback = 5;
				
	//		<!--- find the appropriate comment for student --->
			qStudentcomment = _root.StudentCommentsArray[personal_workload][personal_feedback];
					
			switch(personal_emotion)
			{
				case 5:		
					student_image = "happy";
					happyCount++;
					break;
				case 4:
					student_image = "stressed";
					stressedCount++;
					break;
				case 3:
					student_image = "neutral";
					neutralCount++;
					break;
				case 2:
					student_image = "anxious";
					anxiousCount++;
					break;
				case 1:
					student_image = "depressed";
					depressedCount++;
					break;
			}
			
			trace('updating states of students');
			_root.StudentsInClassroom[class_counter].gotoAndStop(student_image);
			_root.StudentsInClassroom[class_counter].feedback = qStudentcomment.description;
			
			if(AssessmentThisWeek)
			{
				// give each comment only once
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester] = new Array();
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload] = new Array();
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload][personal_feedback] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload][personal_feedback] = new Array();
				
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload][personal_feedback][_root.StudentsInClassroom[class_counter].type] == null)
				{
					_root.StudentDoneWeeks[_root.CurrentWeekInSemester][personal_workload][personal_feedback][_root.StudentsInClassroom[class_counter].type] = 1;
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

