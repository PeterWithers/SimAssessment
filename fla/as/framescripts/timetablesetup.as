trace("timetablesetup.as");
// switch to wait until assessment is set - should be a function
keepstat=_global.stat; _global.stat=0; trace ("switch to stop while changing assessment");
_root.time.stop();
_root.clock.rotates=0;
_root.simmenu.indicator.gotoAndStop(10+stat*10);

// set values on screen
var i=_global.weechoo;
var inputweek=_global.weechoo;
var inputworth=WWorth[i];
// retrieve WValues and set Screen display choices right
for (x=0;x<=7;x++) {
	if (WAssess[i]==AssessmentType[x]) {
		WAssessButton.gotoAndStop((x+1)*10);
		set (WDue[i], inputweek);
	}
}
for (x=0;x<=3;x++) {
	if (WMark[i]==Marker[x]) {
		WMarkButton.gotoAndStop((x+1)*10);
	}
}
for (x=0;x<=5;x++) {
	if (WType[i]==FeedbackType[x]) {
		WTypeButton.gotoAndStop((x+1)*10);
	}
}


// debug
for (i=0;i<=14;i++) {
	trace(WDue[i]+"/"+WAssess[i]+"/"+WWorth[i]+"/"+WType[i]+"/"+WMark[i])
}
trace("");

stop();
