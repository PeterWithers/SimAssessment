_root.email._x = _root.emailXPosition;

/*
// function turn on scrollers or turn them off
function needscrollers() {
    adownScroll._visible = lista.scroll<lista.maxscroll;
    aupScroll._visible = lista.scroll>1;
	bdownScroll._visible = listb.scroll<listb.maxscroll;
    bupScroll._visible = listb.scroll>1;
	cdownScroll._visible = cont.scroll<cont.maxscroll;
    cupScroll._visible = cont.scroll>1;
}
// check if we need to turn on the scrollers once
needscrollers();

//initiate scrolling of text in textfields lista listb & cont

adownscroll.onPress = function() {
	lista.scroll += 1;
	// check if the scrollers should still appear
    needscrollers();
};

aupscroll.onPress = function() {
	lista.scroll -= 1;
	// check if the scrollers should still appear
    needscrollers();
};

bdownscroll.onPress = function() {
	listb.scroll += 1;
	// check if the scrollers should still appear
    needscrollers();
};

bupscroll.onPress = function() {
	listb.scroll -= 1;
	// check if the scrollers should still appear
    needscrollers();
};

cdownscroll.onPress = function() {
	cont.scroll += 1;
	// check if the scrollers should still appear
    needscrollers();
};

cupscroll.onPress = function() {
	cont.scroll -= 1;
	// check if the scrollers should still appear
    needscrollers();
};



// function for feedback on choosen email
function emailchoice(what) {
	trace(what);
	// display email in content field
	cont = "";
	cont = "<i>from:&nbsp;"+emailfrom[what]+"</i><br><b>"+emailref[what]+"</b><br><br>"
	+emailcont[what];
	// "unshift" email into archiv - add at the beginning of the archiv array
	archivwhen.unshift(emailwhen[what]);
	archivfrom.unshift(emailfrom[what]);
	archivref.unshift(emailref[what]);
	archivcont.unshift(emailcont[what]);
	// "splice" email list - remove element which was "unshifted"
	emailwhen.splice(what,1);
	emailfrom.splice(what,1);
	emailref.splice(what,1);
	emailcont.splice(what,1);	
	// update list A and list B
	this.printoutlista();
	this.printoutlistb();
	// check if we need to turn on the scrollers once
	needscrollers();
}


// function for feedback on choosen email
function archivchoice(what) {
	trace(what);
	// display email in content field
	cont = "";
	cont = "<i>from:&nbsp;"+archivfrom[what]+"</i><br><b>"+archivref[what]+"</b><br><br>"
	+archivcont[what];	
	// update list A and list B
	this.printoutlista();
	this.printoutlistb();
	// check if we need to turn on the scrollers once
	needscrollers();
}


// function create printout list A
function printoutlista() {
	lista.htmlText = "";
	// loop through the array
	for (i=0;i<emailcont.length;i++) {
		// for each entry in the array add another line to the text in the textfield
    	var nexta = "<A HREF='asfunction:_root.email.emailchoice,"+i+"'>"+"<b>"+email[2][i]+"&nbsp;</b><i>"+email[1][i]+"</i>"+"</A>";
    	lista.htmlText += nexta;
	}
}


// function create printout list B
function printoutlistb() {
	listb.htmlText = "";
	// loop through the array
	for (i=0;i<archivcont.length;i++) {
		// for each entry in the array add another line to the text in the textfield
    	var nextb = "<A HREF='asfunction:_root.email.archivchoice,"+i+"'>"+archiv[2][i]+"&nbsp;<i>"+archiv[1][i]+"</i>"+"</A>";
    	listb.htmlText += nextb;
	}
}

// printout list A and list B
this.printoutlista();
this.printoutlistb();
// check if we need to turn on the scrollers once
needscrollers();
*/
stop();


