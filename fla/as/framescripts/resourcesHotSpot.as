on(release) {
	trace("goto online ressources");
	_root.email.gotoAndStop("no mail");
	_root.report.gotoAndStop("no report");
	_root.resources.gotoAndStop(10);
}

