#include "as/XMLConfig.as"
//#include "as/class_generator.as"
#include "as/Gateway.as"
//#include "as/calculation_engine.as"
#include "as/class_generator.as"
#include "as/mentor_comment.as"
#include "as/report.as"


function simassessmentInit()
{
	trace("simassessmentInit()");
	openGateway();
}

_root.mentorpopup._visible = false;

function PhoneClick()
{
	_root.mentorpopup._visible = true;
	_root.mentorpopup.onRelease = function(){this._visible = false;};
}
function ComputerMailClick() {
	trace("check email ok");
	_root.mentorpopup._visible = false;
	_root.report.gotoAndStop("no report");
	_root.ressources.gotoAndStop("no ressources");
	_root.computer.emailindicator.gotoAndPlay('static');
	_root.email.gotoAndStop(10);
}

for (Student in _root.Classroom)
{
	_root.Classroom[Student].gotoAndStop('happy');
	_root.Classroom[Student].feedback = 'We want to learn?';
}

function StopSemester()
{
	clearInterval(_root.SemesterInterval);
}
function PlaySemester()
{
	clearInterval(_root.SemesterInterval);
	_root.GoForwardOneWeek();
	_root.SemesterInterval = setInterval(_root.GoForwardOneWeek, 4000);	
}



_root.WeekOfAssignments = new Array();
WeekOfAssignments[0] = {ASS_ID: 7, ASS_NAME: 'Project', DUE_WEEK: 2, FEEDBACK: 1, MARKER: 'Self ', WEIGHTING: 'Between 40 and 60 ', WHICH_ASS: 1, goal_ids: '2'};
WeekOfAssignments[1] = {ASS_ID: 12, ASS_NAME: 'Case studies', DUE_WEEK: 3, FEEDBACK: 1, MARKER: 'Self ', WEIGHTING: 'Between 40 and 60 ', WHICH_ASS: 2, goal_ids: '2'};
WeekOfAssignments[2] = {ASS_ID: 11, ASS_NAME: 'Reflective journals', DUE_WEEK: 5, FEEDBACK: 1, MARKER: 'Self ', WEIGHTING: 'Less than 20 ', WHICH_ASS: 3, goal_ids: '2'};
WeekOfAssignments[3] = {ASS_ID: 3, ASS_NAME: 'Report', DUE_WEEK: 7, FEEDBACK: 1, MARKER: 'Self ', WEIGHTING: 'Less than 20 ', WHICH_ASS: 4, goal_ids: '2'};
WeekOfAssignments[4] = {ASS_ID: 1, ASS_NAME: 'Essay', DUE_WEEK: 10, FEEDBACK: 1, MARKER: 'Self ', WEIGHTING: 'Less than 20 ', WHICH_ASS: 5, goal_ids: '2'};


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