function startHelp()
{
	trace('startHelp()');	
	_root.StopSemester();
	_root.DisableControls = true;
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
}
_root.helpCursor._visible = false;
_root.HelpBox._visible = false;

helpListener = new Object();
helpListener.onMouseUp = function()
{
	if (_root.help.hitTest(_root._xmouse, _root._ymouse, true))
	{
		_root.DisableControls = false;
		return;
	}
	_root.HelpBox.helpContent.text = '';
	//if (Key.isDown(Key.CONTROL))
	for (things in _root)
	{
		//if (_root.help.hitTest(_root[things]))
		if (_root[things]._visible and _root[things].hitTest(_root._xmouse, _root._ymouse, true) and things != 'helpCursor')
			_root.HelpBox.helpContent.text = _root.HelpBox.helpContent.text + 'Hit: ' + things + '\n';
	}
	_root.stopHelp();
	_root.help.gotoAndStop('off');
	
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
	_root.DisableControls = false;
}