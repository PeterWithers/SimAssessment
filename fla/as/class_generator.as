_root.StudentDoneWeeks = new Array();

function SetUpClass()
{
//<!--- on set up only not between weeks --->	
	_root.StudentsInClassroom = new Array();
	for (Student in _root.Classroom)
	{
		_root.StudentsInClassroom.push(_root.Classroom[Student]);
		_root.Classroom[Student].personality = Math.ceil(Math.random() * 15);
	}	
	_root.NumberOfStudents = _root.StudentsInClassroom.length;


//	sessiondefault_class = new Array();
//	for (studentcounter = 0; studentcounter < NumberOfStudents; studentcounter++)
//	{
//		sessiondefault_class[studentcounter] = Math.ceil(Math.random() * 15);
//		trace('sessiondefault_class[' + studentcounter + ']: '+ sessiondefault_class[studentcounter]);
//	}
	SetUpWeek();
}
function SetUpWeek()
{
	//	gererateClassState(2.79166666667, true, 2.20833333333);
	_root.timetable.crossout.gotoAndStop(_root.CurrentWeekInSemester);
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
	if (_root.calculation_engine_called == true)
	{
		_root.CurrentWeekInSemester--;
		if (_root.CurrentWeekInSemester < 1)_root.CurrentWeekInSemester = 1;
		SetUpWeek();
	}else _root.Call_calculation_engineService();
}
ProccessingOneAtATime = false;
function GoForwardOneWeek()
{
	// during testing this has been slow to return
	// hence we check to see if the function has returned before calling again
	// not the most fool proof way but it will do in this case
	if (_root.ProccessingOneAtATime == false)
	{
		_root.ProccessingOneAtATime = true;
		if (_root.CurrentWeekInSemester == 15)clearInterval(_root.SemesterInterval);
		if (_root.calculation_engine_called == true)
		{
			_root.CurrentWeekInSemester++;
			if (_root.CurrentWeekInSemester > 15)_root.CurrentWeekInSemester = 15;
			_root.SetUpWeek();
		}else _root.Call_calculation_engineService();
		updateAfterEvent();
		_root.ProccessingOneAtATime = false;
	}
}
function gererateClassState(attributesFEEDBACK, attributesSEMESTER_RUNNING, attributesSTUDENT_WORKLOAD, AssessmentThisWeek)	
{
	trace('gererateClassState(' + attributesFEEDBACK + ' , ' + attributesSEMESTER_RUNNING + ' , ' + attributesSTUDENT_WORKLOAD + ')');
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
				
	//		<!--- find the appropriate picture for class --->
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
			
	//		<!--- uncomment this to display different color for different characteristics->
//			trace('student: ' + class_counter + ' type: ' + _root.Class_CharacteristicsArray[query_position].student_type + ' : ' + student_image + ' : qStudentcomment.description');
			_root.StudentsInClassroom[class_counter].gotoAndStop(student_image);
			_root.StudentsInClassroom[class_counter].feedback = qStudentcomment.description;

			if(AssessmentThisWeek)
			{
				trace('made changes here to the email code\n and you should probably test it a bit more.');
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester] == null)_root.StudentDoneWeeks[_root.CurrentWeekInSemester] = new Array();			
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][_root.CurrentWeekInSemester] == null) _root.StudentDoneWeeks[_root.CurrentWeekInSemester][_root.CurrentWeekInSemester] = new Array();
				
				if (_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)] == null)
				{
					_root.StudentDoneWeeks[_root.CurrentWeekInSemester][Math.round(modified_student_workload)][Math.round(modified_feedback)] = 1;
	
/*					if (qStudentcomment.description != null and qStudentcomment.description != '')
					{					
						_root.email.emailwhen.push('week ' + _root.CurrentWeekInSemester);
						_root.email.emailfrom.push('Student');
						_root.email.emailref.push(student_image);
						_root.email.emailcont.push('To ' + _root.UserName + '\n\n' + qStudentcomment.description + '\n\nStudent');
						_root.computer.emailindicator.gotoAndPlay('new');
					}*/
					if (qStudentcomment.description1 != null and qStudentcomment.description1 != '')
					{
						_root.email.emailwhen.push('week ' + _root.CurrentWeekInSemester);
						_root.email.emailfrom.push('Student');
						_root.email.emailref.push(student_image);
						_root.email.emailcont.push('To ' + _root.UserName + '\n\n' + qStudentcomment.description2 + '\n\nStudent');
						_root.computer.emailindicator.gotoAndPlay('new');
					}
					if (qStudentcomment.description2 != null and qStudentcomment.description2 != '')
					{			
						_root.email.emailwhen.push('week ' + _root.CurrentWeekInSemester);
						_root.email.emailfrom.push('Student');
						_root.email.emailref.push(student_image);
						_root.email.emailcont.push('To ' + _root.UserName + '\n\n' + qStudentcomment.description3 + '\n\nStudent');
						_root.computer.emailindicator.gotoAndPlay('new');
					}
				}
			}
		}
	}	
	else
	{ 
		trace('first week');
		for (class_counter = 0; class_counter < NumberOfStudents; class_counter++)
		{
			query_position = _root.StudentsInClassroom[class_counter].personality;
			student_image = "neutral";
//		<!--- uncomment this to display different color for different characteristics->
//			trace('student: ' + class_counter + ' type: ' + _root.Class_CharacteristicsArray[query_position].student_type + ' : ' + student_image + ' : qStudentcomment.description');
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

