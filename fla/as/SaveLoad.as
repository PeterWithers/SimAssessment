function GetUserTextBox()
{
	_root.messagepopup.gotoAndStop('GetUserText');
	_root.messagepopup._visible = true;
	_root.messagepopup.ok.onRelease = function() 
	{
		_root.RemoveMessageBox();
		_root.timetableconfigService.save_timetable({timetabletosave: _root.WeekOfAssignments, timetablelabel: _root.messagepopup.UserText.text, userid: 1});
		_root.SavingMessageBox(_root.messagepopup.UserText.text);
	}
	_root.messagepopup.cancel.onRelease = function() 
	{
		_root.RemoveMessageBox();
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
	_root.messagepopup.login.onRelease = function() 
	{
		_root.messagepopup.gotoAndStop('Login');
		_root.messagepopup.ok.onRelease = function() 
		{
//			_root.SavingMessageBox('saving user name');
			_root.logedin = true;
			_root.GetUserLoginCallBackFunction();
		}
		_root.messagepopup.cancel.onRelease = function() 
		{
			_root.RemoveMessageBox();
		}
	}
	_root.messagepopup.register.onRelease = function() 
	{
		_root.messagepopup.gotoAndStop('Register');
		_root.messagepopup.ok.onRelease = function() 
		{
//			_root.SavingMessageBox('registering user name');
			_root.logedin = true;
			_root.GetUserLoginCallBackFunction();
		}
		_root.messagepopup.cancel.onRelease = function() 
		{
			_root.RemoveMessageBox();
		}
	}
}

_root.logedin = false;

SaveButton.onRelease = function()
{
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
	_root.ErrorMessageBox(result.description);
}
function save_timetable_Result(result)
{
	trace('get_subjects_Result(result)');
	Presets.addItem(result.items[0].timetablelabel, result.items);
	_root.RemoveMessageBox();
}
LoadButton.onRelease = function()
{
	trace('LoadButton.onRelease');
	if (_root.logedin != true) 
	{
		_root.GetUserLogin(_root.LoadButton.onRelease);
		return;
	}
	timetableconfigService.load_timetable({userid: 1});
	_root.MessageBox('Loading saved setups');
//	timetableconfigService.create_timetableconfig_table();
}
function load_timetable_Status(result)
{
	_root.ErrorMessageBox(result.description);
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
	timetableconfigService.create_timetableconfig_table();
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
	if (Presets.editable == true) 
	{
		Presets.editable = false;
	}
	trace(_root.Presets.getSelectedItem().label);
	if (_root.Presets.getSelectedItem().label == 'enter name')
	{
		Presets.editable = true;
	}

	_root.calculation_engine_called = false;
	_root.StopSemester();
//	_root.ClearPreviousWeeks();
	_root.WeekOfAssignments = _root.Presets.getSelectedItem().data;
	_root.Call_calculation_engineService();
	_root.timetable.SetupTimetableDisplay();
}
function SetUpPresets()
{
	_root.Presets.removeAll();
	cfmSetup = new Array();
	cfmSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 1, goal_ids: '2'};
	cfmSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 2, goal_ids: '2'};
	cfmSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 5, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 3, goal_ids: '2'};
	cfmSetup[3] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 4, goal_ids: '2'};
	cfmSetup[4] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 5, goal_ids: '2'};
	
	BadSetup = new Array();
	BadSetup[0] = {ass_id: 7, ass_name: 'Project', due_week: 2, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 1, goal_ids: '2'};
	BadSetup[1] = {ass_id: 12, ass_name: 'Case studies', due_week: 3, feedback: 1, marker: 'Self', weighting: '40% and 60%', which_ass: 2, goal_ids: '2'};
	BadSetup[2] = {ass_id: 3, ass_name: 'Report', due_week: 7, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 4, goal_ids: '2'};
	BadSetup[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 'Less than 20%', which_ass: 5, goal_ids: '2'};
	
	happySetup = new Array();
	happySetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 5, feedback: 5, marker: 'Teacher', weighting: 'Less than 20%', which_ass: 1, goal_ids: '2'};
	happySetup[1] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 5, marker: 'Teacher', weighting: '20% and 40%', which_ass: 2, goal_ids: '2'};
	happySetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 14, feedback: 5, marker: 'Teacher', weighting: '40% and 60%', which_ass: 3, goal_ids: '2'};
	
	GoodSetup = new Array();
	GoodSetup[0] = {ass_id: 5, ass_name: 'Short answer question', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '2'};
	GoodSetup[1] = {ass_id: 3, ass_name: 'Report', due_week: 8, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 2, goal_ids: '8'};
	GoodSetup[2] = {ass_id: 11, ass_name: 'Reflective journals', due_week: 13, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 3, goal_ids: '8,14'};
	
	
	_root.Presets.addItem('Blank Setup', 1);
	_root.Presets.addItem('Good Setup', GoodSetup);
	_root.Presets.addItem('Bad Setup', BadSetup);
	//Presets.addItem('cfm setup', cfmSetup);
	//Presets.addItem('Happy Setup', happySetup);
	//Presets.addItem('error', 1);
}
_root.SetUpPresets();
_root.Presets.setChangeHandler('PresetsOnChangeHandler', _root);


