onlineressources.htmlText = '<A href=\"http://gromit.iml.uts.edu.au/staging/simassessment/Flash/demo/subject_outline.doc\">Subject Outline</a><br><a href=\"http://gromit.iml.uts.edu.au/staging/simassessment/Flash/demo/graduate_attributes.doc\"><br>Graduate Attributes</a><br><br><a href=\"http://gromit.iml.uts.edu.au/staging/simassessment/Flash/demo/feedback.doc\">Feedback from Last Semester</a><br><br>Web Links:<br><br><a href=\"http://www.iml.uts.edu.au/learnteach/assess/index.html\">Assessing Student Learning</a><br><br><A href=\"http://www.clt.uts.edu.au/assess1.html\">Information for UTS Staff on Assessment</a><br><br><a href=\"http://www.cshe.unimelb.edu.au/assessinglearning/index.html\">A National Study on Assessment</a><br><br><a href=\"http://www.uts.edu.au/div/publications/policies/select/assess\">Coursework Assessment Policy and Procedures</a><br><br>Short Guides in Assessment<br><br>Group work<br>* <a href=\"http://www.iml.uts.edu.au/learnteach/assess/guides/011.htm\">Assessing group assignments</a><br>* <A href=\"http://www.iml.uts.edu.au/learnteach/assess/guides/012.htm\">Assigning individual grades</a><br><br>Online Assessment<br>* <A href=\"http://www.iml.uts.edu.au/learnteach/assess/guides/021.htm\">Assessing online discussions</a><br>* <a href=\"http://www.iml.uts.edu.au/learnteach/assess/guides/022.htm\">Online Examinations</A><br><br>Student Plagiarism<br>* <a herf=\"http://www.iml.uts.edu.au/learnteach/assess/guides/03.htm\">Preventing Plagiarism</a><br><br>* <a href=\"http://www.iml.uts.edu.au/learnteach/assess/paraphrasing.doc\">Example of how to avoid plagiarism in student writing</a> <br><br>* <a href=\"http://www.iml.uts.edu.au/learnteach/assess/turnitin.doc\">Get started with Turnitin.com</a> '

/*
// function turn on scrollers or turn them off
function needscrollers() {
    edownScroll._visible = onlineressources.scroll<onlineressources.maxscroll;
    eupScroll._visible = onlineressources.scroll>1;
}

// check if we need to turn on the scrollers once
needscrollers();

//initiate scrolling of text in textfields lista listb & cont

edownscroll.onPress = function() {
	onlineressources.scroll += 1;
	// check if the scrollers should still appear
    needscrollers();
};

eupscroll.onPress = function() {
	onlineressources.scroll -= 1;
	// check if the scrollers should still appear
    needscrollers();
};

// switch to wait until ressources pop back - should be a function
keepstat=_global.stat; _global.stat=0; trace ("switch to stop while ressources active");
_root.time.stop();
_root.clock.rotates=0;
_root.simmenu.indicator.gotoAndStop(10+stat*10);
// check if we need to turn on the scrollers once
needscrollers();
stop();
*/

