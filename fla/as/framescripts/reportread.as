_root.report.report.htmlText = _root.FinalReportText;
//_root.report.fred.htmlText = _root.FinalReportText;
/*
// report in - write array to display variable
rep="";
for(x=1;x<=reportsum.length;x++) {
	rep+=reportsum[x-1];
}

// function turn on scrollers or turn them off
function needscrollers() {
    ddownScroll._visible = rep.scroll<rep.maxscroll;
    dupScroll._visible = rep.scroll>1;
}

// check if we need to turn on the scrollers once
needscrollers();

//initiate scrolling of text in textfield rep
ddownscroll.onPress = function() {
	rep.scroll += 1;
	// check if the scrollers should still appear
    needscrollers();
};
dupscroll.onPress = function() {
	rep.scroll -= 1;
	// check if the scrollers should still appear
    needscrollers();
};

// switch to wait until report pops back - should be a function
keepstat=_global.stat; _global.stat=0; trace ("switch to stop while report is active");
_root.time.stop();
_root.clock.rotates=0;
_root.simmenu.indicator.gotoAndStop(10+stat*10);
// check if we need to turn on the scrollers once
needscrollers();
stop();


*/