﻿function startHelp()
{
	trace('startHelp()');	
	if (_root.DisableControls == true) return;
	_root.help.gotoAndStop('on');
	_root.StopSemester();
	_root.PreHelpDisableControlsState = _root.DisableControls == true;
	_root.DisableControlsFunction();
	_root.HelpBox._visible = false;
	_root.helpCursor._x = _root._xmouse;
	_root.helpCursor._y = _root._ymouse;
	_root.helpCursor._visible = true;
	_root.helpCursor.startDrag();
	Mouse.hide();
	Mouse.addListener(_root.helpListener);
}
function stopHelp()
{
	Mouse.removeListener(_root.helpListener);
	trace('stopHelp()');
	_root.helpCursor._visible = false;
	_root.helpCursor.stopDrag();
	Mouse.show();
	_root.help.gotoAndStop('off');
}
_root.helpCursor._visible = false;
_root.HelpBox._visible = false;

helpListener = new Object();
helpListener.onMouseUp = function()
{
	_root.stopHelp();
	if (_root.help.hitTest(_root._xmouse, _root._ymouse, true))
	{
		if (_root.PreHelpDisableControlsState == false) _root.EnableControlsFunction();
		return;
	}
	_root.HelpBox.helpContent.text = '';
	_root.HelpBox.helpTopic.text = '';
	//if (Key.isDown(Key.CONTROL))
	targetnamearray = new Array();
	for (things in _root)
	{
		//if (_root.help.hitTest(_root[things]))
//		trace(things + ' : ' + typeof(_root[things]));
		if (typeof(_root[things]) == 'movieclip' and _root[things]._visible)
			if (_root[things].hitTest(_root._xmouse, _root._ymouse, true) and things != 'helpCursor')
			{
				if (things.length <= 100) targetnamearray.push(things + _root.HelpMode);
			}
	}
	_root.HelpBox.helpContent.text = '\n\nLoading\n';
	if (targetnamearray.length > 0)
	{
		trace('help targets: ' + targetnamearray.toString());
		_root.GetHelp(targetnamearray.toString());
	}
	else _root.HelpBox.helpContent.text = 'No help is associated with this item';
	
	HelpBoxPadding = 20;
	_root.HelpBox._x = _root._xmouse - _root.HelpBox._width / 2;
	_root.HelpBox._y = _root._ymouse - _root.HelpBox._height / 2;
	if (_root.HelpBox._x < HelpBoxPadding) _root.HelpBox._x = HelpBoxPadding;
	if (_root.HelpBox._y < HelpBoxPadding) _root.HelpBox._y = HelpBoxPadding;
	if (_root.HelpBox._x + _root.HelpBox._width > 800 - HelpBoxPadding) _root.HelpBox._x = 800 - _root.HelpBox._width - HelpBoxPadding;
	if (_root.HelpBox._y + _root.HelpBox._height > 600 - HelpBoxPadding) _root.HelpBox._y = 600 - _root.HelpBox._height - HelpBoxPadding;

	_root.HelpBox._visible = true;
}

_root.HelpBox.closebutton.onRelease = function()
{
	_root.HelpBox._visible = false;
	if (_root.PreHelpDisableControlsState == false) _root.EnableControlsFunction();
}

