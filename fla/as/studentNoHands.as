function StudentHandUp(student)
{
	trace('StudentHandUp: ' + student);
	student.handuppause = 0;
	student.handup = true;
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
	trace('StudentHandDown: ' + student);
	student.gotoAndPlay('studentstart');
}

