function GetUserTextBox()
{
	_root.messagepopup.gotoAndStop('GetUserText');
	_root.messagepopup._visible = true;
	_root.messagepopup.save.onRelease = function() 
	{
		_root.RemoveMessageBox();
		_root.call_save_timetable();
		_root.SavingMessageBox(_root.messagepopup.UserText.text);
	}
	_root.messagepopup.cancel.onRelease = function() 
	{
		_root.RemoveMessageBox();
	}
	_root.messagepopup.UserText.onSetFocus = function()
	{
		_root.messagepopup.UserText.text = '';
		_root.messagepopup.UserText.onSetFocus = null;
	}
}
function GetUserLogin(callbackfunction)
{
	_root.GetUserLoginCallBackFunction = callbackfunction;
	_root.messagepopup.gotoAndStop('LoginOrNew');
	_root.messagepopup._visible = true;
	_root.messagepopup.cancel.onRelease = function() 
	{
		_root.RemoveMessageBox();
	}
	_root.messagepopup.login.onRelease = _root.messagepopup.loginbox;
	_root.messagepopup.register.onRelease = _root.messagepopup.registerbox;
}
_root.messagepopup.loginbox = function() 
{
	_root.messagepopup.gotoAndStop('Login');
	_root.messagepopup.login.onRelease = function() 
	{
    	_root.call_login_user();
		_root.SavingMessageBox('loging in user name');
	}
	_root.messagepopup.cancel.onRelease = function() 
	{
		_root.RemoveMessageBox();
	}		
	_root.messagepopup.LoginName.onSetFocus = function()
	{
		_root.messagepopup.LoginName.text = '';
		_root.messagepopup.LoginName.onSetFocus = null;
	}
	_root.messagepopup.Password.onSetFocus = function()
	{
		_root.messagepopup.Password.text = '';
		_root.messagepopup.Password.onSetFocus = null;
	}
	_root.messagepopup._visible = true;
}
_root.messagepopup.registerbox = function() 
{
	_root.messagepopup.gotoAndStop('Register');
	_root.messagepopup.LoginNameDefault = _root.messagepopup.LoginName.text;
	_root.messagepopup.PasswordDefault = _root.messagepopup.Password.text;
	_root.messagepopup.register.onRelease = function() 
	{		
		if (_root.messagepopup.LoginName.text == '' or _root.messagepopup.LoginName.text == _root.messagepopup.LoginNameDefault)
		{
			_root.messagepopup.LoginName.text = _root.messagepopup.LoginNameDefault;			
			_root.messagepopup.LoginName.onSetFocus = function()
			{
				_root.messagepopup.LoginName.text = '';
				_root.messagepopup.LoginName.onSetFocus = null;
			}
			return;
		}
		if (_root.messagepopup.Password.text == '' or _root.messagepopup.Password.text == _root.messagepopup.PasswordDefault)
		{
			_root.messagepopup.Password.text = _root.messagepopup.PasswordDefault;
			_root.messagepopup.Password.onSetFocus = function()
			{
				_root.messagepopup.Password.text = '';
				_root.messagepopup.Password.onSetFocus = null;
			}
			return;
		}
		if (_root.UserName == null) _root.UserName = _root.messagepopup.LoginName.text;
		_root.call_register_user();
		_root.SavingMessageBox('Registering user name');
	}
	_root.messagepopup.cancel.onRelease = function() 
	{
		_root.RemoveMessageBox();
	}
	_root.messagepopup.LoginName.onSetFocus = function()
	{
		_root.messagepopup.LoginName.text = '';
		_root.messagepopup.LoginName.onSetFocus = null;
	}
	_root.messagepopup.Password.onSetFocus = function()
	{
		_root.messagepopup.Password.text = '';
		_root.messagepopup.Password.onSetFocus = null;
	}
	_root.messagepopup._visible = true;
}

_root.logedin = false;

SaveButton.onRelease = function()
{
	if (_root.DisableControls == true) return;
	trace('SaveButton.onRelease');
	if (_root.logedin != true) 
	{
		_root.GetUserLogin(_root.SaveButton.onRelease);
		return;
	}
	if (_root.WeekOfAssignments.length != null)
		_root.GetUserTextBox();
	else
		_root.OkMessageBox('Nothing to save');
}

LoadButton.onRelease = function()
{
	if (_root.DisableControls == true) return;
	trace('LoadButton.onRelease');
	if (_root.logedin != true) 
	{
		_root.GetUserLogin(_root.LoadButton.onRelease);
		return;
	}
	_root.call_load_timetable();
	_root.MessageBox('Loading saved setups');
//	usersfunctionsService.create_timetableconfig_table();
}

/*
SetUpTablesButton.onRelease = function()
{
	trace('SetUpTablesButton.onRelease');
	usersfunctionsService.create_timetableconfig_table().responder = new RelayResponder(this, "SetUpTablesButton_Result", "SetUpTablesButton_Status");
}
function SetUpTablesButton_Status(result)
{
	_root.ErrorMessageBox('set up had a problem\n' + result.description);
}
function SetUpTablesButton_Result(result)
{
	_root.ErrorMessageBox('set up went ok');
}
*/
function PresetsOnChangeHandler()
{
	_root.calculation_engine_called = false;
	_root.PreCalculatedStatesForSemester = null;
	_root.TweenedWeeklyStates = null;
	_root.AssessmentWeeksArray = null;
	
	_root.StopSemester();
//	_root.ClearPreviousWeeks();
	_root.WeekOfAssignments = _root.Presets.getSelectedItem().data;
	_root.Call_calculation_engineService();
	_root.timetable.SetupTimetableDisplay();
}
function SetUpPresets(dropdowntopopulate)
{
	dropdowntopopulate.removeAll();
	/*
	cfmSetup = new Array();
	cfmSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: 3, which_ass: 1, goal_ids: '2'};
	cfmSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: 3, which_ass: 2, goal_ids: '2'};
	cfmSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 5, feedback: 1, marker: 'Self', weighting: 1, which_ass: 3, goal_ids: '2'};
	cfmSetup[3] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 1, which_ass: 4, goal_ids: '2'};
	cfmSetup[4] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 1, which_ass: 5, goal_ids: '2'};
	
	BadSetup = new Array();
	BadSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: 3, which_ass: 1, goal_ids: '2'};
	BadSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: 3, which_ass: 2, goal_ids: '2'};
	BadSetup[2] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 1, which_ass: 3, goal_ids: '2'};
	BadSetup[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 1, which_ass: 4, goal_ids: '2'};
	
	happySetup = new Array();
	happySetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 5, feedback: 5, marker: 'Teacher', weighting: 1, which_ass: 1, goal_ids: '2'};
	happySetup[1] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 5, marker: 'Teacher', weighting: 2, which_ass: 2, goal_ids: '2'};
	happySetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 5, marker: 'Teacher', weighting: 3, which_ass: 3, goal_ids: '2'};
	
	GoodSetup = new Array();
	GoodSetup[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 5, marker: 'Self', weighting: 2, which_ass: 1, goal_ids: '2'};
	GoodSetup[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 5, marker: 'Teacher', weighting: 3, which_ass: 2, goal_ids: '8'};
	GoodSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 13, feedback: 5, marker: 'Teacher', weighting: 3, which_ass: 3, goal_ids: '14,8'};
	
	MultiSetup = new Array();
	MultiSetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '2'};
	MultiSetup[1] = {ass_id: 3, ass_name: 'Report', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 2, goal_ids: '8'};
	MultiSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 3, goal_ids: '8,14'};
	MultiSetup[3] = {ass_id: 5, ass_name: 'Short answer question', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
	MultiSetup[4] = {ass_id: 3, ass_name: 'Report', due_week: 13, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 5, goal_ids: '8'};
	MultiSetup[5] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 13, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 6, goal_ids: '8,14'};
	MultiSetup[6] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 7, goal_ids: '8,14'};
	MultiSetup[7] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 8, goal_ids: '8,14'};
	MultiSetup[8] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 9, goal_ids: '8,14'};
	MultiSetup[9] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 10, goal_ids: '8,14'};
	MultiSetup[10] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 11, goal_ids: '8,14'};
	*/
	PetersKsGoodSetup = new Array();
	PetersKsGoodSetup[0] = { goal_ids: "4", which_ass: 1, weighting: 1, marker: "Self", feedback: 3, due_week: 4, ass_name: "Short answer question", ass_id: 5 };
	PetersKsGoodSetup[1] = { goal_ids: "7", which_ass: 2, weighting: 2, marker: "Peer", feedback: 4, due_week: 8, ass_name: "Class presentation", ass_id: 9 };
	PetersKsGoodSetup[2] = { goal_ids: "10", which_ass: 3, weighting: 3, marker: "Teacher", feedback: 2, due_week: 12, ass_name: "Report", ass_id: 3 };

	OverAssessment = new Array();
	OverAssessment [0] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 1, goal_ids: '2'};
	OverAssessment [1] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 2, goal_ids: '2'};
	OverAssessment [2] = { ass_id: 3, ass_name: 'Report', due_week: 9, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 3, goal_ids: '5'};
	OverAssessment [3] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 11, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 4, goal_ids: '2'};
	OverAssessment [4] = { ass_id: 3, ass_name: 'Report', due_week: 13, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 5, goal_ids: '1'};
	OverAssessment [5] = { ass_id: 1, ass_name: 'Essay', due_week: 14, feedback: 1, marker: 'Teacher', weighting: 3, which_ass: 6, goal_ids: '5'};

	LackOfFeedback = new Array();
	LackOfFeedback [0] = { ass_id: 5, ass_name: 'Short answer question', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1, which_ass: 1, goal_ids: '3'};
	LackOfFeedback [1] = { ass_id: 2, ass_name: 'Problem', due_week: 14, feedback: 1, marker: 'Teacher', weighting: 5, which_ass: 2, goal_ids: '10'};

	WeeklyQuiz = new Array();
	WeeklyQuiz [0] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 1, goal_ids: '2'};
	WeeklyQuiz [1] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 2, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 2, goal_ids: '2'};
	WeeklyQuiz [2] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 3, goal_ids: '2'};
	WeeklyQuiz [3] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 4, goal_ids: '2'};
	WeeklyQuiz [4] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 5, goal_ids: '2'};
	WeeklyQuiz [5] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 6, goal_ids: '2'};
	WeeklyQuiz [6] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 7, goal_ids: '2'};
	WeeklyQuiz [7] = { ass_id: 2, ass_name: 'Problem', due_week: 7, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 8, goal_ids: '4'};
	WeeklyQuiz [8] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 9, goal_ids: '2'};
	WeeklyQuiz [9] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 10, goal_ids: '2'};
	WeeklyQuiz [10] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 10, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 11, goal_ids: '2'};
	WeeklyQuiz [11] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 11, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 12, goal_ids: '2'};
	WeeklyQuiz [12] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 13, goal_ids: '2'};
	WeeklyQuiz [13] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 13, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 14, goal_ids: '2'};
	WeeklyQuiz [14] = { ass_id: 3, ass_name: 'Report', due_week: 13, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 15, goal_ids: '5'};
	WeeklyQuiz [15] = { ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 1, marker: 'Teacher', weighting: 1, which_ass: 16, goal_ids: '2'};
	WeeklyQuiz [16] = { ass_id: 2, ass_name: 'Problem', due_week: 14, feedback: 1, marker: 'Teacher', weighting: 3, which_ass: 17, goal_ids: '8'};

	
//	dropdowntopopulate.addItem('Blank Setup', 1);
//	dropdowntopopulate.addItem('Good Setup', GoodSetup);
//	dropdowntopopulate.addItem('Bad Setup', BadSetup);
	dropdowntopopulate.addItem('Good Setup', PetersKsGoodSetup);	
	dropdowntopopulate.addItem('Over-Assessment', OverAssessment);
	dropdowntopopulate.addItem('Lack of Feedback', LackOfFeedback);
	dropdowntopopulate.addItem('Weekly Quiz', WeeklyQuiz);

	
//	dropdowntopopulate.addItem('Multi per Week', MultiSetup);
	//Presets.addItem('cfm setup', cfmSetup);
	//Presets.addItem('Happy Setup', happySetup);
	//Presets.addItem('error', 1);
}
//_root.createTextField("PlaceToPutFocus", 1, -100, -100, 1, 1);
_root.SetUpPresets(_root.Presets);
_root.Presets.setChangeHandler('PresetsOnChangeHandler', _root);


