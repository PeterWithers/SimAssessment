trace("timetableinit.as");

_root.timetable.EditAssignment._visible = false;

// setup Arrays
/*var WAssess=new Array(x,"fred",0,"ESSAY",0,0,0,0,0,"PROJECT",0,0,0,"MULTIPLE CHOICE QUESTIONS",0);
var WWorth=new Array(x,0,0,20,0,0,0,0,0,50,0,0,0,30,0);
var WDue=new Array(x,0,0,3,0,0,0,0,0,9,0,0,0,13,0);
var WMark=new Array(x,"by fred",0,"self",0,0,0,0,0,"peer",0,0,0,"teacher",0);
var WType=new Array(x,'freded',0,"written detailed comments",0,0,0,0,0,"verbal feedback in class",0,0,0,"assign a grade",0);
*/
//var AssessmentType= _root.AssessmentTypesArray;
//var Marker = _root.MarkerArray;
//var FeedbackType = _root.FeedbackTypeArray;

function SetupTimetableDisplay()
{
	for (i=1; i<=14; i++) 
	{
		set ("WTTsecond" + i, "");
		set ("WTTfirst" + i, "");
	}
	for (AssignmentsForWeek in _root.WeekOfAssignments)
	{
		DUE_WEEK = _root.WeekOfAssignments[AssignmentsForWeek].DUE_WEEK
		set ("WTTfirst" + DUE_WEEK, _root.WeekOfAssignments[AssignmentsForWeek].ASS_NAME);
		set ("WTTsecond" + DUE_WEEK, (_root.WeekOfAssignments[AssignmentsForWeek].WEIGHTING+"  " + _root.WeekOfAssignments[AssignmentsForWeek].MARKER + "-marked"));
	}
}
SetupTimetableDisplay();

trace("start and read in new timetable data");
stop();

