#include "NetServices.as"
#include "NetDebug.as"

function openGateway()
{
	trace('openGateway()');
	if (isGatewayOpen == null) 
	{
		trace('(isGatewayOpen == null)');
		// do this code only once
		isGatewayOpen = true;
		NetServices.setDefaultGatewayUrl(xmlGatewayUrl);
		gatewayConnection = NetServices.createGatewayConnection(); 
		mentorService = gatewayConnection.getService(xmlGatewayPath+'/mentor', this);
		studentService = gatewayConnection.getService(xmlGatewayPath+'/student', this);
		commentsService = gatewayConnection.getService(xmlGatewayPath+'/comments', this);
		resourcesService = gatewayConnection.getService(xmlGatewayPath+'/resources', this);
		calculation_engineService = gatewayConnection.getService(xmlGatewayPath+'/calculation_engine', this);
		
		RequiredCFCResults = 0;
//		resourcesService.get_subjects(); RequiredCFCResults++;
		resourcesService.get_assessment(); RequiredCFCResults++;
//		resourcesService.get_marker(); RequiredCFCResults++;
		resourcesService.get_feedback_type(); RequiredCFCResults++;
//		resourcesService.get_Assignment_Workload();RequiredCFCResults++;
		resourcesService.get_subject_goals();
		resourcesService.get_class_characteristic(); RequiredCFCResults++;
		commentsService.get_studentcomments(); RequiredCFCResults++;
		commentsService.get_mentorcomments();
		Call_calculation_engineService();
/*
		WeekOfAssignments = new Array();
		WeekOfAssignments[0] = {ASS_ID: 7, ASS_NAME: 'Project', DUE_WEEK: 2, FEEDBACK: 1, MARKER: 'Teacher', WEIGHTING: 'Between 40 and 60', WHICH_ASS: 1};
		WeekOfAssignments[1] = {ASS_ID: 12, ASS_NAME: 'Case studies', DUE_WEEK: 3, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Between 40 and 60', WHICH_ASS: 2};
		WeekOfAssignments[2] = {ASS_ID: 11, ASS_NAME: 'Reflective journals', DUE_WEEK: 5, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20', WHICH_ASS: 3};
		WeekOfAssignments[3] = {ASS_ID: 3, ASS_NAME: 'Report', DUE_WEEK: 7, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20', WHICH_ASS: 4};
		WeekOfAssignments[4] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 10, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20', WHICH_ASS: 5};
		WeekOfAssignments[5] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 12, FEEDBACK: 1, MARKER: 'Teacher', WEIGHTING: 'Less than 20', WHICH_ASS: 6};
		calculation_engineService.calculate(WeekOfAssignments);
*/
	}
}
function Call_calculation_engineService()
{
	_root.calculation_engine_called = true;
	_root.calculation_engineService.calculate(WeekOfAssignments); RequiredCFCResults++;
	_root.SetUpClass();
}
function get_subjects_result(result)
{
	trace('get_subjects_result(result)');
	_root.SubjectsArray = result.items;
	InitSemester();
}
function get_assessment_result(result)
{
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.AssessmentType.addItem(result.items[resultrow].ass_name, result.items[resultrow]);
	}
	InitSemester();
}
function get_feedback_type_result(result)
{
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.timetable.EditAssignment.FeedbackType.addItem(result.items[resultrow].type, result.items[resultrow]);
	}
	// these strings are used in the calculation engine and I dont have time atm to fix this design flaw
	_root.timetable.EditAssignment.MarkerType.addItem('Teacher', 'Teacher');
	_root.timetable.EditAssignment.MarkerType.addItem('Peer', 'Peer');
	_root.timetable.EditAssignment.MarkerType.addItem('Self', 'Self');
	// these strings are used in the calculation engine and I dont have time atm to fix this design flaw
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Less than 20%', 'Less than 20');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 20% and 40%', 'Between 20 and 40');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 40% and 60%', 'Between 40 and 60');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('Between 60% and 80%', 'Between 60 and 80');
	_root.timetable.EditAssignment.AssignmentWorkload.addItem('More than 80%', 'More than 80%');
	
//	for (WeekCounting = 1; WeekCounting < 15; WeekCounting++) _root.timetable.EditAssignment.WeekDue.addItem(WeekCounting, WeekCounting);
	
	InitSemester();
}
function get_subject_goals_Result(result)
{
/*	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.FeedbackType.addItem(result.items[resultrow].type, result.items[resultrow]);
	}*/
	resultrow = 0;
	for (CheckBoxItem in _root.timetable.EditAssignment.SubjectOutlineGoals)
	{
		trace(CheckBoxItem);
		if (resultrow < result.items.length)
		{
			_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].setLabel(result.items[resultrow].name);	
			_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem].DataObject = result.items[resultrow];
			_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem]._visible = true;
			resultrow++;
		}
		else
			_root.timetable.EditAssignment.SubjectOutlineGoals[CheckBoxItem]._visible = false;
	}
}
function get_studentcomments_result(result)
{
	_root.StudentCommentsArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		if (_root.StudentCommentsArray[result.items[resultrow].student_workload_value] == null)_root.StudentCommentsArray[result.items[resultrow].student_workload_value] = new Array();
		if (_root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value] != null) trace('duplicate comment coordinate found');
		_root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value] = result.items[resultrow];
//		trace(result.items[resultrow].student_workload_value + ' : ' + result.items[resultrow].feedback_value + ' : ' + _root.StudentCommentsArray[result.items[resultrow].student_workload_value][result.items[resultrow].feedback_value].description);
	}
	InitSemester();
}


function get_class_characteristic_result(result)
{// get all different student types and characteristics from db (15 different students)
	_root.Class_CharacteristicsArray = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		_root.Class_CharacteristicsArray[result.items[resultrow].id] = result.items[resultrow];
	}	
	InitSemester();
}
function calculate_result(result)
{
	_root.PreCalculatedStatesForSemester = result;
	InitSemester();
}

function InitSemester()
{
	RequiredCFCResults--;
	_root.CurrentWeekInSemester = 1;
	if (RequiredCFCResults < 1)
	{
	
	}
}
function get_mentorcomments_Result(result)
{
	
}