on(release) {
	if (_root.DisableControls == true) return;
	trace("goto online ressources");
	_root.email.gotoAndStop("no mail");
	_root.report.gotoAndStop("no report");
	_root.resources.gotoAndStop(10);
}

