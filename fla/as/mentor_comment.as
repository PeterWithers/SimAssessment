_root.MentorDoneWeeks = new Array();

//<!--- THE CODE BELOW IS TO GENERATE THE mentor comment --->
function SetupMentorCommentsForWeek(mentor_approach_to_learning, mentor_goal_alignment, AssessmentThisWeek)
{	
	trace('SetupMentorCommentsForWeek('+mentor_approach_to_learning+', '+mentor_goal_alignment+')');
	MentorComments = '';
	if  (_root.MentorCommentsArray[mentor_goal_alignment][Math.round(mentor_approach_to_learning)] != null)
		MentorComments = MentorComments + _root.MentorCommentsArray[mentor_goal_alignment][Math.round(mentor_approach_to_learning)];

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
	
