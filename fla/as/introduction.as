function IntroductionStart()
{ 
	trace('IntroductionStart()');
	
	// increment RequiredCFCResults because InitSemester is called to give loading box on IntroductionFinish
	//_root.RequiredCFCResults++;
	
	if (_root.UserName == null)
	{
		// go to frame two so that frame one scripts get called later
		_root.introduction.gotoAndStop(2);
		_root.introduction._visible = false;
		return;
	}
	_root.DisableControlsFunction();
	_root.IntroductionRunning = true;
//	_root.RequiredCFCResults++;

	// just incase the indroduction took longer to load than the cfcs
//	_root.RemoveMessageBox();

	_root.introduction.SkipButton.onRelease = _root.IntroductionFinish;
	_root.introduction.nextButton.onRelease = _root.IntroductionCallback;
//	for (things in _root.introduction) trace(things);
}	
function IntroductionCallback()
{ 
	trace('IntroductionCallback()');
    clearInterval(_root.IntroductionIntervalID);
	_root.CloseDialogues();
	_root.introduction.play();
}
function IntroductionPauseSeconds(seconds)
{
	if (_root.UserName == null)
	{
		return;
	}
	trace('IntroductionPauseSeconds(' + seconds + ')');
	_root.introduction.stop();	
	_root.IntroductionIntervalID = setInterval(_root.IntroductionCallback, seconds * 1000);
}
function IntroductionLoadTimetable()
{
	_root.WeekOfAssignments = _root.GoodSetup;
	_root.timetable.SetupTimetableDisplay();
}
function IntroductionShowAssessment()
{
	_global.weechoo = 8;
	_root.timetable.gotoAndStop("setup");
}
function IntroductionStudentHandUp(comment)
{
	_root.Classroom.ExemplaryStudent.student.gotoAndPlay(121);
	_root.Classroom.ExemplaryStudent.feedback = comment;
}
function IntroductionStudentHandDown()
{
	_root.Classroom.ExemplaryStudent.student.gotoAndPlay(10);
}
function IntroductionFinish()
{
	trace('IntroductionFinish()');
	clearInterval(_root.IntroductionIntervalID);
	_root.EnableControlsFunction();
	_root.IntroductionRunning = false;
	_root.introduction.unloadMovie();
	
	// clear the timetable
	_root.WeekOfAssignments = 1;
	_root.timetable.SetupTimetableDisplay();
	_root.IntroductionStudentHandDown();
	//_root.InitSemester();
}
function IntroductionWizard()
{
	_root.introduction.stop();
	_root.SetUpPresets(_root.introduction.Presets);
		
	_root.introduction.view.onRelease = function()
	{
		_root.introduction.view.gotoAndStop('yes');
		_root.introduction.create.gotoAndStop('no');
		_root.introduction.preset.gotoAndStop('no');
		_root.introduction.load.gotoAndStop('no');
	}
	_root.introduction.create.onRelease = function()
	{
		_root.introduction.view.gotoAndStop('no');
		_root.introduction.create.gotoAndStop('yes');
		_root.introduction.preset.gotoAndStop('no');
		_root.introduction.load.gotoAndStop('no');
	}
	_root.introduction.preset.onRelease = function()
	{
		_root.introduction.view.gotoAndStop('no');
		_root.introduction.create.gotoAndStop('no');
		_root.introduction.preset.gotoAndStop('yes');
		_root.introduction.load.gotoAndStop('no');
	}
	_root.introduction.load.onRelease = function()
	{
		_root.introduction.view.gotoAndStop('no');
		_root.introduction.create.gotoAndStop('no');
		_root.introduction.preset.gotoAndStop('no');
		_root.introduction.load.gotoAndStop('yes');
	}
	
	_root.introduction.Presets.setChangeHandler('onRelease', _root.introduction.preset);
	
	_root.introduction.continueButton.onRelease = function()
	{
		if (_root.introduction.view._currentframe > 1)
		{
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.introduction.gotoAndPlay(1);
			_root.introduction._visible = true;
		}
		if (_root.introduction.create._currentframe > 1) 
		{
			_root.IntroductionFinish();
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
		}
		if (_root.introduction.preset._currentframe > 1) 
		{
			_root.IntroductionFinish();
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.calculation_engine_called = false;
			_root.StopSemester();
			//	_root.ClearPreviousWeeks();
			_root.WeekOfAssignments = _root.introduction.Presets.getSelectedItem().data;
			_root.Presets.setSelectedIndex( _root.introduction.Presets.getSelectedIndex() );
//			_root.Presets.setSelected(2); //_root.messagepopup.Presets.getSelectedIndex());
			_root.Call_calculation_engineService();
			_root.timetable.SetupTimetableDisplay();
		}	
		if (_root.introduction.load._currentframe > 1) 
		{		
			_root.IntroductionFinish();
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.LoadButton.onRelease();
		}	
	}		
}

