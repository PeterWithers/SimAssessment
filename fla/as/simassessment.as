#include "as/XMLConfig.as"
//#include "as/class_generator.as"
#include "as/Gateway.as"
//#include "as/calculation_engine.as"
#include "as/class_generator.as"
#include "as/mentor_comment.as"
#include "as/report.as"
#include "as/studentNoHands.as"
#include "as/feedbackgraph.as"
#include "as/email.as"

_root.messagepopup.messagetext.text = ''
function OkMessageBox(messagetext)
{
	_root.messagepopup.gotoAndStop('ok');
	_root.messagepopup._visible = true;
	_root.messagepopup.messagetext.text = messagetext;
	_root.messagepopup.start.onRelease = function() {_root.messagepopup._visible = false;}
}
function MessageBox(messagetext)
{
	_root.messagepopup.gotoAndStop('loading');
	_root.messagepopup._visible = true;
	_root.messagepopup.messagetext.text = _root.messagepopup.messagetext.text + messagetext + '\n';
	_root.messagepopup.messagetext.scroll = _root.messagepopup.messagetext.maxscroll;
}
function ErrorMessageBox(messagetext)
{
	trace(messagetext);
	_root.ErrorMessageShowing = true;
	_root.messagepopup.gotoAndPlay('error');
	_root.messagepopup._visible = true;
	_root.messagepopup.messagetext.text = _root.messagepopup.messagetext.text + messagetext + '\n';
	_root.messagepopup.messagetext.scroll = _root.messagepopup.messagetext.maxscroll;
}
function UserNameRequestBox()
{
	if (_root.ErrorMessageShowing != true)
	{
		_root.messagepopup.gotoAndPlay('welcome');
		_root.messagepopup.UserName.text = 'Please enter your name here';
		_root.messagepopup.UserName.onSetFocus = function()
		{
			_root.messagepopup.UserName.text = '';
			_root.messagepopup.UserName.onSetFocus = null;
		}
		_root.messagepopup.start.onRelease = function()
		{
			if(_root.messagepopup.UserName.text == '') _root.UserNameRequestBox();
			else if(_root.messagepopup.UserName.text != 'Please enter your name here')
			{
				_root.UserName = _root.messagepopup.UserName.text;
				_root.SetUpClass();
				_root.messagepopup._visible = false;
			}
		}
	}
}
function RemoveMessageBox()
{
	if (_root.ErrorMessageShowing != true)
	{
		_root.messagepopup._visible = false;
		_root.messagepopup.messagetext = '';
	}
}
function ClearPreviousWeeks()
{
	_root.CurrentWeekInSemester = 1;
	_root.email.gotoAndStop('init');
	_root.mentorpopup.mentorSpeech.htmlText = '';
	_root.timetable.crossout.gotoAndStop(_root.CurrentWeekInSemester);
	_root.MentorDoneWeeks = new Array();
	_root.StudentDoneWeeks = new Array();	
	_root.computer.emailindicator.gotoAndStop('static');
	_root.SetUpClass();
}
function simassessmentInit()
{
	trace("simassessmentInit()");
	openGateway();
}

_root.mentorpopup._visible = false;
//_root.mentorpopup.mentorSpeech.htmlText = 'rhubarb rhubarb';


function ShowDebugInfo()
{
	_root.mentorpopup.mentorSpeech.text = 'Selected Assessments\n\n';
	for (Assessments = 0; Assessments < _root.WeekOfAssignments.length; Assessments++)
	{
		_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + 'Assessment [' + (Assessments + 1) + ']\n';
		for (AssessmentThings in _root.WeekOfAssignments[Assessments])
		{
			_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + AssessmentThings + ': ';
			_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + _root.WeekOfAssignments[Assessments][AssessmentThings] + '\n';
		}
		_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + '\n\n';
	}
	_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + '\nEngine Output\n\n';
	for (PreCalculatedAssessments = 1; PreCalculatedAssessments < _root.PreCalculatedStatesForSemester.length; PreCalculatedAssessments++)
	{
		_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + 'CalculatedAssessment [' + PreCalculatedAssessments + ']\n';
		for (PreCalculatedAssessmentThings in _root.PreCalculatedStatesForSemester[PreCalculatedAssessments])
		{
			_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + PreCalculatedAssessmentThings + ': ';
			_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + _root.PreCalculatedStatesForSemester[PreCalculatedAssessments][PreCalculatedAssessmentThings] + '\n';
		}
		_root.mentorpopup.mentorSpeech.text = _root.mentorpopup.mentorSpeech.text + '\n\n';
	}	
	_root.CloseDialogues();
	_root.mentorpopup._visible = true;
	_root.mentorpopup.ok.onRelease = _root.CloseDialogues;
}

function PhoneClick()
{
	if (Key.isDown(Key.CONTROL))
	{
		_root.ShowDebugInfo();
	}else{
		_root.CloseDialogues();
		_root.mentorpopup._visible = true;
		_root.mentorpopup.ok.onRelease = _root.CloseDialogues;
	}
}
function ComputerMailClick()
{
	_root.CloseDialogues();
	_root.computer.emailindicator.gotoAndStop('static');
	_root.email.gotoAndStop(10);
}

for (Student in _root.Classroom)
{
	_root.Classroom[Student].gotoAndStop('happy');
	_root.Classroom[Student].feedback = 'We want to learn?';
	_root.ShowOfHands = false;
//	_root.lessHands();
}
function StepSemesterBack()
{
	_root.CloseDialogues();
	_root.SemesterPlaying = false;
	clearInterval(_root.SemesterInterval);
	_root.playStatus.gotoAndStop("paused");
	_root.clock.gotoAndPlay("step");
	_root.GoBackOneWeek();
}
function StepSemesterForward()
{
	_root.CloseDialogues();
	_root.SemesterPlaying = false;
	clearInterval(_root.SemesterInterval);
	_root.playStatus.gotoAndStop("paused");
	_root.clock.gotoAndPlay("step");
	_root.GoForwardOneWeek();
}
function StopSemester()
{
	_root.SemesterPlaying = false;
	clearInterval(_root.SemesterInterval);
	_root.playStatus.gotoAndStop("paused");
	_root.clock.gotoAndStop("pause");
}
function PlaySemester()
{
	_root.CloseDialogues();
	_root.SemesterPlaying = true;
	clearInterval(_root.SemesterInterval);
	_root.playStatus.gotoAndStop("playing");
	_root.clock.gotoAndStop("play");
	_root.GoForwardOneWeek();
	_root.SemesterInterval = setInterval(_root.GoForwardOneWeek, 4000);	
}
function CloseDialogues()
{
	_root.StopSemester();
	
	// close timetable
	_root.timetable.EditAssignment._visible = false;
	_root.timetable.gotoAndStop("start");
	
	// close resources
	_root.resources.gotoAndStop("no ressources");

	// close report
	_root.report.gotoAndStop("no report")
	
	// close 
	_root.email.gotoAndStop("no mail");
	_root.email.InBoxGrid._visible = false;
	_root.email.OutBoxGrid._visible = false;

	
	// close mentorpopup
	_root.mentorpopup._visible = false;
}

cfmSetup = new Array();
cfmSetup[0] = {ASS_ID: 7, ASS_NAME: 'Project', DUE_WEEK: 2, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: '40% and 60%', WHICH_ASS: 1, goal_ids: '2'};
cfmSetup[1] = {ASS_ID: 12, ASS_NAME: 'Case studies', DUE_WEEK: 3, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: '40% and 60%', WHICH_ASS: 2, goal_ids: '2'};
cfmSetup[2] = {ASS_ID: 11, ASS_NAME: 'Reflective journals', DUE_WEEK: 5, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20%', WHICH_ASS: 3, goal_ids: '2'};
cfmSetup[3] = {ASS_ID: 3, ASS_NAME: 'Report', DUE_WEEK: 7, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20%', WHICH_ASS: 4, goal_ids: '2'};
cfmSetup[4] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 10, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20%', WHICH_ASS: 5, goal_ids: '2'};

BadSetup = new Array();
BadSetup[0] = {ASS_ID: 7, ASS_NAME: 'Project', DUE_WEEK: 2, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: '40% and 60%', WHICH_ASS: 1, goal_ids: '2'};
BadSetup[1] = {ASS_ID: 12, ASS_NAME: 'Case studies', DUE_WEEK: 3, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: '40% and 60%', WHICH_ASS: 2, goal_ids: '2'};
BadSetup[2] = {ASS_ID: 3, ASS_NAME: 'Report', DUE_WEEK: 7, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20%', WHICH_ASS: 4, goal_ids: '2'};
BadSetup[3] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 10, FEEDBACK: 1, MARKER: 'Self', WEIGHTING: 'Less than 20%', WHICH_ASS: 5, goal_ids: '2'};

happySetup = new Array();
happySetup[0] = {ASS_ID: 5, ASS_NAME: 'Short answer question', DUE_WEEK: 5, FEEDBACK: 5, MARKER: 'Teacher', WEIGHTING: 'Less than 20%', WHICH_ASS: 1, goal_ids: '2'};
happySetup[1] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 10, FEEDBACK: 5, MARKER: 'Teacher', WEIGHTING: '20% and 40%', WHICH_ASS: 2, goal_ids: '2'};
happySetup[2] = {ASS_ID: 11, ASS_NAME: 'Reflective journals', DUE_WEEK: 14, FEEDBACK: 5, MARKER: 'Teacher', WEIGHTING: '40% and 60%', WHICH_ASS: 3, goal_ids: '2'};

GoodSetup = new Array();
GoodSetup[0] = {ASS_ID: 5, ASS_NAME: 'Short answer question', DUE_WEEK: 4, FEEDBACK: 2, MARKER: 'Teacher', WEIGHTING: 'Less than 20%',  WHICH_ASS: 1, goal_ids: '2'};
GoodSetup[1] = {ASS_ID: 3, ASS_NAME: 'Report', DUE_WEEK: 8, FEEDBACK: 2, MARKER: 'Teacher', WEIGHTING: '20% and 40%',  WHICH_ASS: 2, goal_ids: '8'};
GoodSetup[2] = {ASS_ID: 11, ASS_NAME: 'Reflective journals', DUE_WEEK: 13, FEEDBACK: 2, MARKER: 'Teacher', WEIGHTING: '20% and 40%',  WHICH_ASS: 3, goal_ids: '8,14'};

function PresetsOnChangeHandler()
{
	_root.calculation_engine_called = false;
	_root.StopSemester();
	_root.ClearPreviousWeeks();
	_root.WeekOfAssignments = _root.Presets.getSelectedItem().data;
	_root.Call_calculation_engineService();
	_root.timetable.SetupTimetableDisplay();
}

Presets.addItem('Blank Setup', 1);
Presets.addItem('Good Setup', GoodSetup);
Presets.addItem('Bad Setup', BadSetup);
//Presets.addItem('cfm setup', cfmSetup);
//Presets.addItem('Happy Setup', happySetup);
//Presets.addItem('error', 1);
Presets.setChangeHandler('PresetsOnChangeHandler', _root);

StopSemester();

/*
_root.get_ass.due_week[cur_state];
{
  ASS_ID ASS_NAME DUE_WEEK FEEDBACK MARKER WEIGHTING WHICH_ASS 
1 7  Project  2  1  Self  Between 40 and 60  1  
2 12  Case studies  3  1  Self  Between 40 and 60  2  
3 11  Reflective journals  5  1  Self  Less than 20  3  
4 3  Report  7  1  Self  Less than 20  4  
5 1  Essay  10  1  Self  Less than 20  5  
}

 approach_to_learning_values 3,2.70833333333 
 
ass_weeks_list 2,3 
 
cfid 4100 
 
cftoken 79992029 
 
default_class Array (15) 
 
feedback_values 2.79166666667,2.41666666667 
 
goal_alignment_values 4,3 
 
public_confidence_values 3.04166666667,2.66666666667 
 
sessionid SIM_ASSESS_4100_79992029 
 
student_workload_values 2.20833333333,2.70833333333 
 
subject SimAssessment 
 
subjectid 2 
 
teacher_workload_values 1.20833333333,1.70833333333 
 
total_level_of_assessment 4 
 
total_progression 2 
 
total_spacing_of_assessment 3 
 
total_weighting 6 
 
unaligned_assessment 2 
 
urltoken CFID=4100&CFTOKEN=79992029 
 
userid 737 
 
username 
 */