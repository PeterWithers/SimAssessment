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


