_root.MentorDoneWeeks = new Array();

function SetupMentorCommentsForWeek(mentor_teacher_workload, mentor_goal_alignment, AssessmentThisWeek)
{	
	MentorComments = "";
	if (_root.EngineTest == true)
	{
		MentorComments = "mentor_teacher_workload: " + mentor_teacher_workload + "\nmentor_goal_alignment: " + mentor_goal_alignment + "\nAssessmentThisWeek: " + AssessmentThisWeek + "\n";
		MentorComments = MentorComments  + "mentor_teacher_workload: " + Math.round(mentor_teacher_workload) + "\nmentor_goal_alignment: " + Math.round(mentor_goal_alignment) + "\n";
	}
	if  (_root.MentorCommentsArray[Math.round(mentor_goal_alignment)][Math.round(mentor_teacher_workload)] != null)
		MentorComments = MentorComments + _root.MentorCommentsArray[Math.round(mentor_goal_alignment)][Math.round(mentor_teacher_workload)];
	else MentorComments = MentorComments + "There are no comments for this week.";
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
	
