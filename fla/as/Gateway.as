#include "NetServices.as"
// #include "NetDebug.as"

function InitSemester()
{
	_root.RequiredCFCResults--;
	if (_root.CurrentWeekInSemester < 0 or _root.CurrentWeekInSemester > 15) _root.CurrentWeekInSemester = 0;
	dots = _root.RequiredCFCResults;
	dotsout = '';
	while (dots > 0)
	{
		dotsout = dotsout + '.';
		dots--;		
	}
	//if (_root.IntroductionRunning != true) 
		_root.MessageBox(dotsout);
	if (_root.RequiredCFCResults < 1)
	{		
		if (_root.UserName != null) _root.RemoveMessageBox();
		else _root.startwizard();		
		_root.RecalculateExistingWeeks();
		if (_root.EngineTest == true) _root.GraphDisplay.show();
	}
}

function openGateway()
{
	trace('openGateway()');
	if (isGatewayOpen == null) 
	{
		trace('(isGatewayOpen == null)');
		// do this code only once
		isGatewayOpen = true;
		_root.MessageBox('Opening Gateway');
		NetServices.setDefaultGatewayUrl(_root.xmlGatewayUrl);
		gatewayConnection = NetServices.createGatewayConnection(); 
		usersfunctionsService = gatewayConnection.getService(xmlGatewayPath+'/usersfunctions', this);
		mentorService = gatewayConnection.getService(xmlGatewayPath+'/mentor', this);
		studentService = gatewayConnection.getService(xmlGatewayPath+'/student', this);
		commentsService = gatewayConnection.getService(xmlGatewayPath+'/comments', this);
		resourcesService = gatewayConnection.getService(xmlGatewayPath+'/resources', this);
		calculation_engineService = gatewayConnection.getService(xmlGatewayPath+'/calculation_engine', this);
		
		_root.RequiredCFCResults = 0;
//		resourcesService.get_subjects(); _root.RequiredCFCResults++;
		resourcesService.get_assessment(); _root.RequiredCFCResults++;
//		resourcesService.get_marker(); _root.RequiredCFCResults++;
		resourcesService.get_feedback_type(); _root.RequiredCFCResults++;
//		resourcesService.get_Assignment_Workload();_root.RequiredCFCResults++;
		resourcesService.get_subject_goals(); _root.RequiredCFCResults++;
		resourcesService.get_class_characteristic(); _root.RequiredCFCResults++;
		commentsService.get_studentcomments(); _root.RequiredCFCResults++;
		commentsService.get_mentorcomments(); _root.RequiredCFCResults++;
		commentsService.get_finalreport(); _root.RequiredCFCResults++;
		resourcesService.get_goal_alignment_grid(); _root.RequiredCFCResults++;
//		Call_calculation_engineService();
	}
}
function Call_calculation_engineService()
{
	if (_root.timetable.CheckSemesterWorkloadPercentOK()) //  or _root.EngineTest == true
	{
		if (_root.WeekOfAssignments.length != null)
		{
			_root.MessageBox('Calling for semester calculations');
			if (_root.calculation_engine_called != true)
			{
				_root.calculation_engine_returned = false;
				_root.calculation_engine_called = true;
				_root.calculation_engineService.calculate(_root.WeekOfAssignments); _root.RequiredCFCResults++;
				_root.ErrorMessageShowing = false;
			}
		} else {
			_root.StopSemester();
			_root.gererateClassState(0, 0, 0, 0);
		}
	}
}

function calculate_Status(result)
{
	_root.ErrorMessageBox('calculate\n' + result.description);
}
function calculate_Result(result)
{
	_root.PreCalculatedStatesForSemester = result;
	
	_root.GraphDisplay.tweeningvalues = result.tweeningvalues;
	_root.PreCalculatedStatesForSemester.tweeningvalues = null;
	
	_root.GraphDisplay.supressweektween = _root.GraphDisplay.tweeningvalues.tween != 'true';
	_root.GraphDisplay.supressweekdecay = _root.GraphDisplay.tweeningvalues.decay != 'true';
	_root.GraphDisplay.weekdecaylog = _root.GraphDisplay.tweeningvalues.logdecay == 'true';
	
	_root.tweenweeks();
	_root.calculation_engine_returned = true;
	_root.InitSemester();
	
//	_root.DataGrid.dataProvider = result;
//	_root.DataHolder.dataProvider = result;
//	_root.DataSet.dataProvider = result;
}

function get_subjects_Status(result)
{
	_root.ErrorMessageBox('get_subjects\n' + result.description);
}
function get_subjects_Result(result)
{
	trace('get_subjects_Result(result)');
	_root.SubjectsArray = result.items;
	_root.InitSemester();
}
function get_assessment_Status(result)
{
	_root.ErrorMessageBox('get_assessment\n' + result.description);
}
function get_assessment_Result(result)
{
	_root.timetable.EditAssignment.AssessmentType.addItem('Select..', 0);
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.AssessmentType.addItem(result.items[resultrow].ass_name, result.items[resultrow]);
	}
	_root.InitSemester();
}
function get_feedback_type_Status(result)
{
	_root.ErrorMessageBox('get_feedback_type\n' + result.description);
}
function get_feedback_type_Result(result)
{
	_root.timetable.EditAssignment.FeedbackType.addItem('Select..', 0);
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.FeedbackType.addItem(result.items[resultrow].type, result.items[resultrow]);
	}
	// these strings are used in the calculation engine and I dont have time atm to fix this design flaw
	_root.timetable.EditAssignment.MarkerType.addItem('Select..', 0);
	_root.timetable.EditAssignment.MarkerType.addItem('Teacher', 'Teacher');
	_root.timetable.EditAssignment.MarkerType.addItem('Peer', 'Peer');
	_root.timetable.EditAssignment.MarkerType.addItem('Self', 'Self');
	
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Select..', 0);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem(_root.AssignmentWorkloadInfoArray[1].DisplayString, 1);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem(_root.AssignmentWorkloadInfoArray[2].DisplayString, 2);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem(_root.AssignmentWorkloadInfoArray[3].DisplayString, 3);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem(_root.AssignmentWorkloadInfoArray[4].DisplayString, 4);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem(_root.AssignmentWorkloadInfoArray[5].DisplayString, 5);
	
//	for (WeekCounting = 1; WeekCounting < 15; WeekCounting++) _root.timetable.EditAssignment.WeekDue.addItem(WeekCounting, WeekCounting);
	
	_root.InitSemester();
}
function get_subject_goals_Status(result)
{
	_root.ErrorMessageBox('get_subject_goals\n' + result.description);
}
function get_subject_goals_Result(result)
{
	for (resultrow in result.items)
	{
		CurrentCheckBox = _root.timetable.EditAssignment.SubjectOutlineGoals.attachMovie('CheckBox', 'CheckBox' + result.items[resultrow].id, resultrow);
		CurrentCheckBox._y = resultrow * 20;
		CurrentCheckBox.setSize(466, CurrentCheckBox.height);
		CurrentCheckBox.setLabel(result.items[resultrow].name);	
		CurrentCheckBox.DataObject = result.items[resultrow];
	}
	_root.InitSemester();
}
function get_studentcomments_Status(result)
{
	_root.ErrorMessageBox('get_studentcomments\n' + result.description);
}
function get_studentcomments_Result(result)
{
	_root.StudentCommentsArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		if (_root.StudentCommentsArray[result.items[resultrow].student_workload_value] == null)_root.StudentCommentsArray[result.items[resultrow].student_workload_value] = new Array();
		if (_root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value] != null) trace('duplicate comment coordinate found');
		_root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value] = result.items[resultrow];
//		trace(result.items[resultrow].student_workload_value + ' : ' + result.items[resultrow].feedback_value + ' : ' + _root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value].description);
	}
	_root.InitSemester();
}


function get_class_characteristic_Status(result)
{
	_root.ErrorMessageBox('get_class_characteristic\n' + result.description);
}
function get_class_characteristic_Result(result)
{// get all different student types and characteristics from db (15 different students)
	_root.Class_CharacteristicsArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.Class_CharacteristicsArray[result.items[resultrow].id] = result.items[resultrow];
	}	
	_root.InitSemester();
}

function get_mentorcomments_Status(result)
{
	_root.ErrorMessageBox('get_mentorcomments\n' + result.description);
}
function get_mentorcomments_Result(result)
{
	_root.MentorCommentsArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		if (_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value] == null)_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value] = new Array();
		if (_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value][result.items[resultrow].ApproachToLearning_value] != null) trace('duplicate mentor comment coordinate found');
		_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value][result.items[resultrow].ApproachToLearning_value] = result.items[resultrow].description;
//		trace('_root.MentorCommentsArray['+result.items[resultrow].GoalAlignment_value+']['+result.items[resultrow].ApproachToLearning_value+']');
//		trace(_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value][result.items[resultrow].ApproachToLearning_value]);
	}
	_root.InitSemester();
}

function get_finalreport_Status(result)
{
	_root.ErrorMessageBox('get_finalreport\n' + result.description);
}
function get_finalreport_Result(result)
{
	_root.FinalReportArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		// remove the trailing white space
		while (result.items[resultrow].outcome.charAt(result.items[resultrow].outcome.length - 1) == ' ') result.items[resultrow].outcome = result.items[resultrow].outcome.substring(0, result.items[resultrow].outcome.length-1);
		if (_root.FinalReportArray[result.items[resultrow].outcome] == null)
		{
			_root.FinalReportArray[result.items[resultrow].outcome] = new Array();
			trace(result.items[resultrow].outcome);
		}
		if (_root.FinalReportArray[result.items[resultrow].outcome][result.items[resultrow].outcome_value] != null) trace('duplicate mentor comment coordinate found');
		_root.FinalReportArray[result.items[resultrow].outcome][result.items[resultrow].outcome_value] = result.items[resultrow].description;
//		trace('_root.FinalReportArray['+result.items[resultrow].outcome+']['+result.items[resultrow].outcome_value+']');
//		trace(_root.FinalReportArray[result.items[resultrow].outcome][result.items[resultrow].outcome_value]);
	}
	_root.InitSemester();
}

// get_goal_alignment_grid

function get_goal_alignment_grid_Status(result)
{
	_root.ErrorMessageBox('get_class_characteristic\n' + result.description);
}
function get_goal_alignment_grid_Result(result)
{
//	_root.get_goal_alignment_grid = result.items;
	_root.goal_alignment_array = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		if (_root.goal_alignment_array[result.items[resultrow].name] == null) _root.goal_alignment_array[result.items[resultrow].name] = new Array();
		_root.goal_alignment_array[result.items[resultrow].name][result.items[resultrow].ASS_NAME] = result.items[resultrow].value;
	}
//	ASS_NAME
//	name
//	value
	_root.InitSemester();
}
