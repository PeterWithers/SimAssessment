function startwizard()
{
	_root.UserNameRequestBox();
}

function UserNameRequestBox()
{
	_root.messagepopup.gotoAndStop('welcome');
	_root.messagepopup.Presets._x = -500;
	if (_root.UserName != null and _root.UserName != '') _root.messagepopup.UserName.text = _root.UserName;
	else _root.messagepopup.UserName.text = 'Please enter your name here';
	_root.messagepopup.neverused.gotoAndStop('yes');
	_root.messagepopup.familiar.gotoAndStop('no');
	_root.messagepopup.neverused.onRelease = function()
	{
		_root.messagepopup.neverused.gotoAndStop('yes');
		_root.messagepopup.familiar.gotoAndStop('no');
	}
	_root.messagepopup.familiar.onRelease = function()
	{
		_root.messagepopup.familiar.gotoAndStop('yes');
		_root.messagepopup.neverused.gotoAndStop('no');
	}
	_root.DisableControlsFunction();
	_root.messagepopup.UserName.onSetFocus = function()
	{	
		if(_root.messagepopup.UserName.text != 'Please enter your name here')
		{
			if (_root.UserName != null and _root.UserName != '' and _root.messagepopup.UserName.text == '')
				_root.messagepopup.UserName.text = _root.UserName;
		}else _root.messagepopup.UserName.text = '';
//		_root.messagepopup.UserName.onSetFocus = null;
	}
	_root.messagepopup.OKWelcome.onRelease = function()
	{
		if(_root.messagepopup.UserName.text == '') 
		{
			_root.UserName = '';
			_root.UserNameRequestBox();
		}
		else if(_root.messagepopup.UserName.text != 'Please enter your name here')
		{
			_root.UserName = _root.messagepopup.UserName.text;
			_root.WhatDoYouWantBox();
		}
	}
}

function WhatDoYouWantBox()
{
	if (_root.messagepopup.neverused._currentframe > 1) _root.messagepopup.gotoAndStop('no');
		else _root.messagepopup.gotoAndStop('yes');
			
	
	_root.SetUpPresets(_root.messagepopup.Presets);
	_root.messagepopup.Presets._x = 160.0;
		
	_root.messagepopup.goback.onRelease = _root.UserNameRequestBox;
	
	_root.messagepopup.view.gotoAndStop('yes');
	_root.messagepopup.create.gotoAndStop('no');
	_root.messagepopup.preset.gotoAndStop('no');
	_root.messagepopup.load.gotoAndStop('no');
		
	_root.messagepopup.view.onRelease = function()
	{
		_root.messagepopup.view.gotoAndStop('yes');
		_root.messagepopup.create.gotoAndStop('no');
		_root.messagepopup.preset.gotoAndStop('no');
		_root.messagepopup.load.gotoAndStop('no');
	}
	_root.messagepopup.create.onRelease = function()
	{
		_root.messagepopup.view.gotoAndStop('no');
		_root.messagepopup.create.gotoAndStop('yes');
		_root.messagepopup.preset.gotoAndStop('no');
		_root.messagepopup.load.gotoAndStop('no');
	}
	_root.messagepopup.preset.onRelease = function()
	{
		_root.messagepopup.view.gotoAndStop('no');
		_root.messagepopup.create.gotoAndStop('no');
		_root.messagepopup.preset.gotoAndStop('yes');
		_root.messagepopup.load.gotoAndStop('no');
	}
	_root.messagepopup.load.onRelease = function()
	{
		_root.messagepopup.view.gotoAndStop('no');
		_root.messagepopup.create.gotoAndStop('no');
		_root.messagepopup.preset.gotoAndStop('no');
		_root.messagepopup.load.gotoAndStop('yes');
	}
	
	_root.messagepopup.Presets.setChangeHandler('onRelease', _root.messagepopup.preset);
	
	_root.messagepopup.OKWelcome.onRelease = function()
	{
		if (_root.messagepopup.view._currentframe > 1)
		{
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.introduction.gotoAndPlay(1);
			_root.introduction._visible = true;
		}
		if (_root.messagepopup.create._currentframe > 1) 
		{
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.calculation_engine_called = false;
			_root.StopSemester();
			//	_root.ClearPreviousWeeks();
			_root.WeekOfAssignments = 1;
			_root.Presets.setSelectedIndex( 0 );
			_root.Call_calculation_engineService();
			_root.timetable.SetupTimetableDisplay();
		}
		if (_root.messagepopup.preset._currentframe > 1) 
		{
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.calculation_engine_called = false;
			_root.StopSemester();
			//	_root.ClearPreviousWeeks();
			_root.WeekOfAssignments = _root.messagepopup.Presets.getSelectedItem().data;
			_root.Presets.setSelectedIndex( _root.messagepopup.Presets.getSelectedIndex() );
//			_root.Presets.setSelected(2); //_root.messagepopup.Presets.getSelectedIndex());
			_root.Call_calculation_engineService();
			_root.timetable.SetupTimetableDisplay();
		}	
		if (_root.messagepopup.load._currentframe > 1) 
		{		
			_root.EnableControlsFunction();
			_root.SetUpClass();
			_root.RemoveMessageBox();
			_root.LoadButton.onRelease();
		}	
	}		
//	_root.EnableControlsFunction();
//			_root.SetUpClass();
//			_root.RemoveMessageBox();
//			_root.introduction.gotoAndPlay(1);
//			_root.introduction._visible = true;

}

