function lessHands()
{
	for (Student in _root.Classroom)
	{
		_root.Classroom[Student].student.gotoAndStop(10);
		_root.Classroom[Student].student.happyprobability=1000;
		_root.Classroom[Student].student.stressedprobability=1000;
		_root.Classroom[Student].student.neutralprobability=1000;
		_root.Classroom[Student].student.anxiousprobability=1000;
		_root.Classroom[Student].student.depressedprobability=1000;
	}	
}

function moreHands()
{
	for (Student in _root.Classroom)
	{
		_root.Classroom[Student].student.happyprobability=5;
		_root.Classroom[Student].student.stressedprobability=5;
		_root.Classroom[Student].student.neutralprobability=5;
		_root.Classroom[Student].student.anxiousprobability=5;
		_root.Classroom[Student].student.depressedprobability=5;
		_root.Classroom[Student].student.gotoAndPlay(1);
	}	
}

