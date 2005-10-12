import mx.remoting.Service;
import mx.services.Log;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;
import mx.remoting.PendingCall;
import mx.remoting.RecordSet;
import mx.remoting.debug.NetDebug;

// NetDebug.initialize();

var calculation_engineService:Service;

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
//	deselect the preset dropdown which responds to up and down keys causing the semester to reload <eek>.
//		focusManager.setFocus(_root.PlaceToPutFocus);
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

		var usersfunctionsService:Service = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/usersfunctions", null, null);
		var mentorService:Service = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/mentor", null, null);
		var studentService:Service = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/student", null, null);
		var commentsService:Service = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/comments", null, null);
		var resourcesService:Service = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/resources", null, null);
		calculation_engineService = new Service(_root.xmlGatewayUrl, new Log(Log.DEBUG), _root.xmlGatewayPath + "/calculation_engine", null, null);;
		
		_root.RequiredCFCResults = 0;
//		resourcesService.get_subjects(); _root.RequiredCFCResults++;
		resourcesService.get_assessment().responder = new RelayResponder(this, "get_assessment_Result", "get_assessment_Status"); _root.RequiredCFCResults++;		
//		resourcesService.get_marker(); _root.RequiredCFCResults++;
		resourcesService.get_feedback_type().responder = new RelayResponder(this, "get_feedback_type_Result", "get_feedback_type_Status"); _root.RequiredCFCResults++;		
//		resourcesService.get_Assignment_Workload();_root.RequiredCFCResults++;
		resourcesService.get_subject_goals().responder = new RelayResponder(this, "get_subject_goals_Result", "get_subject_goals_Status"); _root.RequiredCFCResults++;		
		resourcesService.get_class_characteristic().responder = new RelayResponder(this, "get_class_characteristic_Result", "get_class_characteristic_Status"); _root.RequiredCFCResults++;		
		commentsService.get_studentcomments().responder = new RelayResponder(this, "get_studentcomments_Result", "get_studentcomments_Status"); _root.RequiredCFCResults++;		
		commentsService.get_mentorcomments().responder = new RelayResponder(this, "get_mentorcomments_Result", "get_mentorcomments_Status"); _root.RequiredCFCResults++;		
		commentsService.get_finalreport().responder = new RelayResponder(this, "get_finalreport_Result", "get_finalreport_Status"); _root.RequiredCFCResults++;		
		resourcesService.get_goal_alignment_grid().responder = new RelayResponder(this, "get_goal_alignment_grid_Result", "get_goal_alignment_grid_Status"); _root.RequiredCFCResults++;		
//		Call_calculation_engineService();
	}
}
function Call_calculation_engineService()
{
	if (_root.timetable.CheckSemesterWorkloadPercentOK() or (Key.isDown(Key.CONTROL) and _root.EngineTest == true ) )
	{
		if (_root.WeekOfAssignments.length != null)
		{
			_root.MessageBox('Calling for semester calculations');
			if (_root.calculation_engine_called != true)
			{
				_root.calculation_engine_returned = false;
				_root.calculation_engine_called = true;
				calculation_engineService.calculate(_root.WeekOfAssignments).responder = new RelayResponder(this, "calculate_Result", "calculate_Status"); _root.RequiredCFCResults++;
				_root.ErrorMessageShowing = false;
			}
		} else {
			_root.StopSemester();
			_root.gererateClassState(0, 0, 0, 0);
		}
	}
}

function calculate_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('calculate\n' + ResultE.result.description);
}
function calculate_Result(ResultE:ResultEvent)
{
	_root.PreCalculatedStatesForSemester = ResultE.result;
	
	_root.GraphDisplay.tweeningvalues = ResultE.result.tweeningvalues;
	_root.PreCalculatedStatesForSemester.tweeningvalues = null;
	
	if (isNaN(_root.PreCalculatedStatesForSemester.assignment_weeks_list))
		_root.AssessmentWeeksArray = _root.PreCalculatedStatesForSemester.assignment_weeks_list.split(',');
	else
	{
		_root.AssessmentWeeksArray = new Array();
		_root.AssessmentWeeksArray[0] = _root.PreCalculatedStatesForSemester.assignment_weeks_list;
	}	
	
	_root.GraphDisplay.supressweektween = _root.GraphDisplay.tweeningvalues.tween != 'true';
	_root.GraphDisplay.supressweekdecay = _root.GraphDisplay.tweeningvalues.decay != 'true';
	_root.GraphDisplay.weekdecaylog = _root.GraphDisplay.tweeningvalues.logdecay == 'true';
	
	_root.tweenweeks();
	_root.calculation_engine_returned = true;
	_root.InitSemester();
}

function get_subjects_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_subjects\n' + ResultE.result.description);
}
function get_subjects_Result(ResultE:ResultEvent)
{
	trace('get_subjects_Result(ResultE:ResultEvent)');
	_root.SubjectsArray = ResultE.result.items;
	_root.InitSemester();
}
function get_assessment_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_assessment\n' + ResultE.result.description);
}
function get_assessment_Result(ResultE:ResultEvent)
{
	_root.timetable.EditAssignment.AssessmentType.addItem('Select..', 0);
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.AssessmentType.addItem(ResultE.result.items[resultrow].ass_name, ResultE.result.items[resultrow]);
	}
	_root.InitSemester();
}
function get_feedback_type_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_feedback_type\n' + ResultE.result.description);
}
function get_feedback_type_Result(ResultE:ResultEvent)
{
	_root.timetable.EditAssignment.FeedbackType.addItem('Select..', 0);
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.FeedbackType.addItem(ResultE.result.items[resultrow].type, ResultE.result.items[resultrow]);
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
function get_subject_goals_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_subject_goals\n' + ResultE.result.description);
}
function get_subject_goals_Result(ResultE:ResultEvent)
{
	for (resultrow in ResultE.result.items)
	{
		CurrentCheckBox = _root.timetable.EditAssignment.SubjectOutlineGoals.attachMovie('CheckBox', 'CheckBox' + ResultE.result.items[resultrow].id, resultrow);
		CurrentCheckBox._y = resultrow * 20;
		CurrentCheckBox.setSize(466, CurrentCheckBox.height);
		CurrentCheckBox.setLabel(ResultE.result.items[resultrow].name);	
		CurrentCheckBox.DataObject = ResultE.result.items[resultrow];
	}
	_root.InitSemester();
}
function get_studentcomments_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_studentcomments\n' + ResultE.result.description);
}
function get_studentcomments_Result(ResultE:ResultEvent)
{
	_root.StudentCommentsArray = new Array();
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		if (_root.StudentCommentsArray[ResultE.result.items[resultrow].student_workload_value] == null)_root.StudentCommentsArray[ResultE.result.items[resultrow].student_workload_value] = new Array();
		if (_root.StudentCommentsArray[ResultE.result.items[resultrow].student_workload_value][ResultE.result.items[resultrow].feedback_value] != null) trace('duplicate comment coordinate found');
		_root.StudentCommentsArray[ResultE.result.items[resultrow].student_workload_value][ResultE.result.items[resultrow].feedback_value] = ResultE.result.items[resultrow];
//		trace(result.items[resultrow].student_workload_value + ' : ' + result.items[resultrow].feedback_value + ' : ' + _root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value].description);
	}
	_root.InitSemester();
}


function get_class_characteristic_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_class_characteristic\n' + ResultE.result.description);
}
function get_class_characteristic_Result(ResultE:ResultEvent)
{// get all different student types and characteristics from db (15 different students)
	_root.Class_CharacteristicsArray = new Array();
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		_root.Class_CharacteristicsArray[ResultE.result.items[resultrow].id] = ResultE.result.items[resultrow];
	}	
	_root.InitSemester();
}

function get_mentorcomments_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_mentorcomments\n' + ResultE.result.description);
}
function get_mentorcomments_Result(ResultE:ResultEvent)
{
	_root.MentorCommentsArray = new Array();
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		if (_root.MentorCommentsArray[ResultE.result.items[resultrow].GoalAlignment_value] == null)_root.MentorCommentsArray[ResultE.result.items[resultrow].GoalAlignment_value] = new Array();
		if (_root.MentorCommentsArray[ResultE.result.items[resultrow].GoalAlignment_value][ResultE.result.items[resultrow].ApproachToLearning_value] != null) trace('duplicate mentor comment coordinate found');
		_root.MentorCommentsArray[ResultE.result.items[resultrow].GoalAlignment_value][ResultE.result.items[resultrow].ApproachToLearning_value] = ResultE.result.items[resultrow].description;
//		trace('_root.MentorCommentsArray['+result.items[resultrow].GoalAlignment_value+']['+result.items[resultrow].ApproachToLearning_value+']');
//		trace(_root.MentorCommentsArray[result.items[resultrow].GoalAlignment_value][result.items[resultrow].ApproachToLearning_value]);
	}
	_root.InitSemester();
}

function get_finalreport_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_finalreport\n' + ResultE.result.description);
}
function get_finalreport_Result(ResultE:ResultEvent)
{
	_root.FinalReportArray = new Array();
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		// remove the trailing white space
		while (ResultE.result.items[resultrow].outcome.charAt(ResultE.result.items[resultrow].outcome.length - 1) == ' ') ResultE.result.items[resultrow].outcome = ResultE.result.items[resultrow].outcome.substring(0, ResultE.result.items[resultrow].outcome.length-1);
		if (_root.FinalReportArray[ResultE.result.items[resultrow].outcome] == null)
		{
			_root.FinalReportArray[ResultE.result.items[resultrow].outcome] = new Array();
			trace(ResultE.result.items[resultrow].outcome);
		}
		if (_root.FinalReportArray[ResultE.result.items[resultrow].outcome][ResultE.result.items[resultrow].outcome_value] != null) trace('duplicate mentor comment coordinate found');
		_root.FinalReportArray[ResultE.result.items[resultrow].outcome][ResultE.result.items[resultrow].outcome_value] = ResultE.result.items[resultrow].description;
//		trace('_root.FinalReportArray['+result.items[resultrow].outcome+']['+result.items[resultrow].outcome_value+']');
//		trace(_root.FinalReportArray[result.items[resultrow].outcome][result.items[resultrow].outcome_value]);
	}
	_root.InitSemester();
}

// get_goal_alignment_grid

function get_goal_alignment_grid_Status(ResultE:ResultEvent)
{
	_root.ErrorMessageBox('get_class_characteristic\n' + ResultE.result.description);
}
function get_goal_alignment_grid_Result(ResultE:ResultEvent)
{
//	_root.get_goal_alignment_grid = result.items;
	_root.goal_alignment_array = new Array();
	for (resultrow = 0; resultrow < ResultE.result.items.length; resultrow++) 
	{
		if (_root.goal_alignment_array[ResultE.result.items[resultrow].name] == null) _root.goal_alignment_array[ResultE.result.items[resultrow].name] = new Array();
		_root.goal_alignment_array[ResultE.result.items[resultrow].name][ResultE.result.items[resultrow].ASS_NAME] = ResultE.result.items[resultrow].value;
	}
//	ASS_NAME
//	name
//	value
	_root.InitSemester();
}
