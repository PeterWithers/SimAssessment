on(release) {
	// switch back
	_global.stat=keepstat; trace ("switch back");

	if (keepstat==1) {
		_root.time.play();
		_root.clock.rotates=5;
	} else {
		_root.time.stop();
		_root.clock.rotates=0;
	}
	_root.simmenu.indicator.gotoAndStop(10+stat*10);
	gotoAndStop("no ressource")
}


