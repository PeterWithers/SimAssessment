_root.MentorDoneWeeks = new Array();

_root.RoundOneToFive = function (ValueToRound)
{
	ValueToRound = Math.round(ValueToRound);
	if (ValueToRound > 5) ValueToRound = 5;
	if (ValueToRound < 1) ValueToRound = 1;
	return (ValueToRound);
}

function SetupMentorCommentsForWeek(AssessmentThisWeek)
{	
	MentorComments = "";
	mentor_teacher_workload = _root.RoundOneToFive( _root.TweenedWeeklyStates[_root.CurrentWeekInSemester].teacher_workload );
	mentor_goal_alignment = _root.RoundOneToFive( _root.TweenedWeeklyStates[_root.CurrentWeekInSemester].goal_alignment );
	mentor_approach_to_learning = _root.RoundOneToFive( _root.TweenedWeeklyStates[_root.CurrentWeekInSemester].approach_to_learning );

	if (_root.EngineTest == true)
	{
		MentorComments = MentorComments + "AssessmentThisWeek: " + AssessmentThisWeek + "\n";
		MentorComments = MentorComments + "mentor_teacher_workload: " + mentor_teacher_workload + "\n";
		MentorComments = MentorComments + "mentor_goal_alignment: " + mentor_goal_alignment + "\n";
		MentorComments = MentorComments + "mentor_approach_to_learning: " + mentor_approach_to_learning + "\n";
	}
	
	// Approach to Learning
	MentorComments = MentorComments + 
	'<b>Approach to Learning</b><br>' +
	_root.FinalReportArray['Approach to Learning'][mentor_approach_to_learning] + '<br><br>';
		
	// Teacher Workload
	MentorComments = MentorComments + 
	'<b>Teacher Workload</b><br>' +
	_root.FinalReportArray['Teacher Workload'][mentor_teacher_workload] + '<br><br>';

	// Goal Alignment
	MentorComments = MentorComments + 
	'<b>Goal Alignment</b><br>' +
	_root.FinalReportArray['Goal Alignment'][mentor_goal_alignment] + '<br><br>';
	
	// Mentor comment
	MentorComments = MentorComments + 
//	"<br><br>" +
	_root.MentorCommentsArray[ mentor_goal_alignment ][ mentor_teacher_workload ];

	_root.mentorpopup.mentorSpeech.htmlText = MentorComments;

	if (_root.MentorDoneWeeks[_root.CurrentWeekInSemester] == null and AssessmentThisWeek)
	{
		_root.email.InBoxGrid.addItem({Arrival: _root.email.InBoxGrid.length, From:'Mentor', Date:'week ' + _root.CurrentWeekInSemester, emailcont:'<i>from:&nbsp;Mentor</i><br><b>Week ' + _root.CurrentWeekInSemester+'</b><br><br>To ' + _root.UserName + '\n\n' + MentorComments + '\n\nMentor'});
		_root.MentorDoneWeeks[_root.CurrentWeekInSemester] = 1;
		_root.Phone.Light.gotoAndPlay('flash');
		_root.UpDateEmailCounters();
	}
}
_root.Phone.Light.gotoAndStop('off');
	
