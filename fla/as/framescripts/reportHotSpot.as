on(release) 
{
	if (_root.DisableControls == true) return;
	_root.CloseDialogues();
	_root.report.gotoAndStop(10);
}

