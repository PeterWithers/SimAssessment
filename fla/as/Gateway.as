#include "NetServices.as"
#include "NetDebug.as"

function InitSemester()
{
	_root.RequiredCFCResults--;
	if (!(_root.CurrentWeekInSemester >= 1 and _root.CurrentWeekInSemester <= 14)) _root.CurrentWeekInSemester = 1;
	dots = _root.RequiredCFCResults;
	dotsout = '';
	while (dots > 0)
	{
		dotsout = dotsout + '.';
		dots--;		
	}
	_root.MessageBox(dotsout);
	if (_root.RequiredCFCResults < 1)
	{		
		if (_root.UserName != null) _root.RemoveMessageBox();
		else _root.UserNameRequestBox();		
		_root.RecalculateExistingWeeks();
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
		timetableconfigService = gatewayConnection.getService(xmlGatewayPath+'/timetableconfig', this);
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
//		Call_calculation_engineService();
	}
}
function Call_calculation_engineService()
{
	if (_root.WeekOfAssignments.length != null)
	{
		_root.MessageBox('Calling for semester calculations');
//		trace('calculation_engine_called ' + _root.calculation_engine_called);
		if (_root.calculation_engine_called != true)
		{
			_root.calculation_engine_returned = false;
			_root.calculation_engine_called = true;
			_root.calculation_engineService.calculate(_root.WeekOfAssignments); _root.RequiredCFCResults++;
			_root.ErrorMessageShowing = false;
		}
	}else _root.StopSemester();
}
function get_subjects_Status(result)
{
	_root.ErrorMessageBox(result.description);
}
function get_subjects_Result(result)
{
	trace('get_subjects_Result(result)');
	_root.SubjectsArray = result.items;
	_root.InitSemester();
}
function get_assessment_Status(result)
{
	_root.ErrorMessageBox(result.description);
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
	_root.ErrorMessageBox(result.description);
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
	// these strings are used in the calculation engine and I dont have time atm to fix this design flaw
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Select..', 0);
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Less than 20%', 'Less than 20%');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 20% and 40%', '20% and 40%');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 40% and 60%', '40% and 60%');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 60% and 80%', '60% and 80%');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('More than 80%', 'More than 80%');
	
//	for (WeekCounting = 1; WeekCounting < 15; WeekCounting++) _root.timetable.EditAssignment.WeekDue.addItem(WeekCounting, WeekCounting);
	
	_root.InitSemester();
}
function get_subject_goals_Status(result)
{
	_root.ErrorMessageBox(result.description);
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
	_root.ErrorMessageBox(result.description);
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
	_root.ErrorMessageBox(result.description);
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
function calculate_Status(result)
{
	_root.ErrorMessageBox(result.description);
}
function calculate_Result(result)
{
	_root.PreCalculatedStatesForSemester = result;
	_root.calculation_engine_returned = true;
	_root.InitSemester();
	
//	_root.DataGrid.dataProvider = result;
//	_root.DataHolder.dataProvider = result;
//	_root.DataSet.dataProvider = result;
}

function get_mentorcomments_Status(result)
{
	_root.ErrorMessageBox(result.description);
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
	_root.ErrorMessageBox(result.description);
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


