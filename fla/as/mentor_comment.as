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
		_root.MentorDoneWeeks[_root.CurrentWeekInSemester] = 1;
		email.emailwhen.push(_root.CurrentWeekInSemester);
		email.emailfrom.push('Mentor');
		email.emailref.push('Week ' + _root.CurrentWeekInSemester);
		email.emailcont.push('To ' + _root.UserName + '\n\n' + MentorComments + '\n\nMentor');
		_root.computer.emailindicator.gotoAndPlay('new');
	}
}
	
