function StudentHandUp(student)
{
	trace('StudentHandUp: ' + student);
	student.handuppause = 0;
	student.handup = true;
	student.onRelease = function() { this.gotoAndStop('talk'); };
	student.onRollOver = function() { this.gotoAndStop('talk'); };
	student.onRollOut = function() { student.onRollOver = null; this.gotoAndPlay('studentstart') };
}
function StudentHandUpNow(student)
{
	trace('StudentHandUpNow: ' + student);
	student.handuppause = 0;
	student.sendtolabel = 'studenthandupstart';
}
function StudentHandUpSpeak(student)
{
	trace('StudentHandUpSpeak: ' + student);
	student.sendtolabel = 'talk';
}
function StudentHandDown(student)
{
	student.onRelease = null;
	student.onRollOut = null;
	trace('StudentHandDown: ' + student);
	student.gotoAndPlay('studentstart');
}

