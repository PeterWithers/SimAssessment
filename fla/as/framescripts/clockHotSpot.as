on(release)
{	
	if (_root.SemesterPlaying == false) _root.PlaySemester();
	else _root.StopSemester();
}

