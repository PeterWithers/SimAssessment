//_root.email.InBoxGrid
InBoxGridListenerObject = new Object();
InBoxGridListenerObject.change = function(eventObject){
	SelectedEmailIndex = eventObject.target.selectedIndex;
	_root.email.contents.htmlText = _root.email.InBoxGrid.getItemAt(SelectedEmailIndex).emailcont;
	trace('InBoxGridListenerObject: ' + SelectedEmailIndex);
	_root.email.OutBoxGrid.addItem(_root.email.InBoxGrid.getItemAt(SelectedEmailIndex));
	_root.email.InBoxGrid.removeItemAt(SelectedEmailIndex);
	_root.UpDateEmailCounters();
}
_root.email.InBoxGrid.addEventListener("change", _root.InBoxGridListenerObject);

OutBoxGridListenerObject = new Object();
OutBoxGridListenerObject.change = function(eventObject){
	SelectedEmailIndex = eventObject.target.selectedIndex;
	_root.email.contents.htmlText = _root.email.OutBoxGrid.getItemAt(SelectedEmailIndex).emailcont;
}
_root.email.OutBoxGrid.addEventListener("change", _root.OutBoxGridListenerObject);

_root.email.InBoxGrid.addColumn('From');
_root.email.InBoxGrid.addColumn('Date');
_root.email.OutBoxGrid.addColumn('From');
_root.email.OutBoxGrid.addColumn('Date');


_root.email.InBoxGrid.getColumnAt(0).width = _root.email.InBoxGrid.width * 0.6;
_root.email.InBoxGrid.getColumnAt(1).width = _root.email.InBoxGrid.width * 0.4;
_root.email.OutBoxGrid.getColumnAt(0).width = _root.email.InBoxGrid.width * 0.6;
_root.email.OutBoxGrid.getColumnAt(1).width = _root.email.InBoxGrid.width * 0.4;

_root.email.InBoxGrid._visible = false;
_root.email.OutBoxGrid._visible = false;

function UpDateEmailCounters()
{
	trace('In: ' + _root.email.InBoxGrid.length + ' Out: ' + _root.email.OutBoxGrid.length);
}

_root.UpDateEmailCounters();

