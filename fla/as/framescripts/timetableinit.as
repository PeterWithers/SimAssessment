trace("timetableinit.as");
// setup Arrays
var WAssess=new Array(x,"fred",0,"ESSAY",0,0,0,0,0,"PROJECT",0,0,0,"MULTIPLE CHOICE QUESTIONS",0);
var WWorth=new Array(x,0,0,20,0,0,0,0,0,50,0,0,0,30,0);
var WDue=new Array(x,0,0,3,0,0,0,0,0,9,0,0,0,13,0);
var WMark=new Array(x,"by fred",0,"self",0,0,0,0,0,"peer",0,0,0,"teacher",0);
var WType=new Array(x,'freded',0,"written detailed comments",0,0,0,0,0,"verbal feedback in class",0,0,0,"assign a grade",0);

var AssessmentType=new Array("AssessmentType ESSAY","REPORT","MULTIPLE CHOICE QUESTIONS","PROJECT","INTERVIEW","CLASS PRESENTATION","POSTER PRESENTATION","CASE STUDY");
var Marker=new Array("Marker teacher","peer","self");
var FeedbackType=new Array("FeedbackType assign a grade","assign a grade with comments","use a checklist","verbal feedback in class","written detailed comments");

// translate Array format to dynamic named Variable 
// -> cann't use Arrays in dynamic textfield ??? why not ???
// should be a function
for (i=1; i<=14; i++) {
	if (WAssess[i]==0) {
		set ("WTTsecond"+i,"");
		set ("WTTfirst"+i,"");
	} else {
		set ("WTTfirst"+i,WAssess[i]);
		set ("WTTsecond"+i,("worth: "+WWorth[i]+" %   "+WMark[i]+"-marked"));
	}
}
trace("start and read in new timetable data");
stop();


