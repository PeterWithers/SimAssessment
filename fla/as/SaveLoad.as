function GetUserTextBox()
{
	_root.messagepopup.gotoAndStop('GetUserText');
	_root.messagepopup._visible = true;
	_root.messagepopup.save.onRelease = function() 
	{
		_root.RemoveMessageBox();
		_root.usersfunctionsService.save_timetable({timetabletosave: _root.WeekOfAssignments, timetablelabel: _root.messagepopup.UserText.text, userid: _root.userid});
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
		_root.usersfunctionsService.login_user({LoginName: _root.messagepopup.LoginName.text, Password: _root.messagepopup.Password.text});
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
		_root.usersfunctionsService.register_user({LoginName: _root.messagepopup.LoginName.text, Password: _root.messagepopup.Password.text, UserName: _root.UserName});
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
function save_timetable_Status(result)
{
	_root.ErrorMessageBox('save_timetable\n' + result.description);
}
function save_timetable_Result(result)
{
	trace('save_timetable_Result(result)');
	Presets.addItem(result.items[0].timetablelabel, result.items);
	_root.RemoveMessageBox();
}

function login_user_Status(result)
{
	_root.ErrorMessageBox('login_user\n' + result.description);
}
function login_user_Result(result)
{
	trace('register_user_Result(result)');
	if (result != -1)
	{
		_root.RemoveMessageBox();
		_root.logedin = true;
		
		_root.userid = result.items[0].userid;
	//	_root.LoginName = result.items[0].LoginName;	
	//	_root.Password = result.items[0].Password;
		_root.UserName = result.items[0].UserName;
		
		_root.GetUserLoginCallBackFunction();
	} else _root.OkMessageBoxOKfunction('Incorrect login', _root.messagepopup.loginbox);
}
function register_user_Status(result)
{
	_root.ErrorMessageBox('register_user\n' + result.description);
}
function register_user_Result(result)
{
	trace('register_user_Result(result)');
	if (result > 0)
	{
		_root.userid = result;
		_root.RemoveMessageBox();
		_root.logedin = true;
		_root.GetUserLoginCallBackFunction();
	} else {
		_root.OkMessageBoxOKfunction('This login name is taken please use another.\n Your display name will remain the same.', _root.messagepopup.registerbox);
	}
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
	usersfunctionsService.load_timetable({userid: _root.userid});
	_root.MessageBox('Loading saved setups');
//	usersfunctionsService.create_timetableconfig_table();
}
function load_timetable_Status(result)
{
	_root.ErrorMessageBox('load_timetable\n' + result.description);
}
function load_timetable_Result(result)
{
	trace('get_subjects_Result(result)');
//	Presets.addItem(result.items[0].timetablelabel, result.items);	
	LoadedSetups = new Array();
	for (resultrow = 0; resultrow < result.items.length; resultrow++) 
	{
		if (LoadedSetups[result.items[resultrow].timetablelabel] == null) LoadedSetups[result.items[resultrow].timetablelabel] = new Array();
		LoadedSetups[result.items[resultrow].timetablelabel][LoadedSetups[result.items[resultrow].timetablelabel].length] = result.items[resultrow];
	}
	_root.SetUpPresets();
	for (LoadedNames in LoadedSetups)Presets.addItem(LoadedNames, LoadedSetups[LoadedNames]);
	_root.RemoveMessageBox();
}
SetUpTablesButton.onRelease = function()
{
	trace('SetUpTablesButton.onRelease');
	usersfunctionsService.create_timetableconfig_table();
}
function SetUpTablesButton_Status(result)
{
	_root.ErrorMessageBox('set up had a problem\n' + result.description);
}
function SetUpTablesButton_Result(result)
{
	_root.ErrorMessageBox('set up went ok');
}

function PresetsOnChangeHandler()
{
	_root.calculation_engine_called = false;
	_root.StopSemester();
//	_root.ClearPreviousWeeks();
	_root.WeekOfAssignments = _root.Presets.getSelectedItem().data;
	_root.Call_calculation_engineService();
	_root.timetable.SetupTimetableDisplay();
}
function SetUpPresets(dropdowntopopulate)
{
	dropdowntopopulate.removeAll();
	cfmSetup = new Array();
	cfmSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 1, goal_ids: '2'};
	cfmSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 2, goal_ids: '2'};
	cfmSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 5, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 3, goal_ids: '2'};
	cfmSetup[3] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 4, goal_ids: '2'};
	cfmSetup[4] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 5, goal_ids: '2'};
	
	BadSetup = new Array();
	BadSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 1, goal_ids: '2'};
	BadSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 2, goal_ids: '2'};
	BadSetup[2] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 3, goal_ids: '2'};
	BadSetup[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 4, goal_ids: '2'};
	
	happySetup = new Array();
	happySetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 5, feedback: 5, marker: 'Teacher', weighting: 'Less than 20%', which_ass: 1, goal_ids: '2'};
	happySetup[1] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 5, marker: 'Teacher', weighting: '20% and 40%', which_ass: 2, goal_ids: '2'};
	happySetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 5, marker: 'Teacher', weighting: '40% and 60%', which_ass: 3, goal_ids: '2'};
	
	GoodSetup = new Array();
	GoodSetup[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 5, marker: 'Self', weighting: '20% and 40%', which_ass: 1, goal_ids: '2'};
	GoodSetup[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 5, marker: 'Teacher', weighting: '60% and 80%', which_ass: 2, goal_ids: '8'};
	GoodSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 13, feedback: 5, marker: 'Teacher', weighting: '40% and 60%', which_ass: 3, goal_ids: '14,8'};
	
	MultiSetup = new Array();
	MultiSetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '2'};
	MultiSetup[1] = {ass_id: 3, ass_name: 'Report', due_week: 8, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 2, goal_ids: '8'};
	MultiSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 8, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 3, goal_ids: '8,14'};
	MultiSetup[3] = {ass_id: 5, ass_name: 'Short answer question', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '2'};
	MultiSetup[4] = {ass_id: 3, ass_name: 'Report', due_week: 13, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 5, goal_ids: '8'};
	MultiSetup[5] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 13, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 6, goal_ids: '8,14'};
	MultiSetup[6] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 7, goal_ids: '8,14'};
	MultiSetup[7] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 8, goal_ids: '8,14'};
	MultiSetup[8] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 9, goal_ids: '8,14'};
	MultiSetup[9] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 10, goal_ids: '8,14'};
	MultiSetup[10] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 11, goal_ids: '8,14'};
	
	dropdowntopopulate.addItem('Blank Setup', 1);
	dropdowntopopulate.addItem('Good Setup', GoodSetup);
	dropdowntopopulate.addItem('Bad Setup', BadSetup);
	dropdowntopopulate.addItem('Multi per Week', MultiSetup);
	//Presets.addItem('cfm setup', cfmSetup);
	//Presets.addItem('Happy Setup', happySetup);
	//Presets.addItem('error', 1);
}
_root.SetUpPresets(_root.Presets);
_root.Presets.setChangeHandler('PresetsOnChangeHandler', _root);


