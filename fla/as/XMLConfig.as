trace('XMLConfig.as');
function xmlOnLoad(success) {
	if (success)
	{
		_root.MessageBox('Reading configuration file');
		configdata = this.firstChild.childNodes;
		for(itemcount = 0; itemcount < configdata.length; itemcount++)
		{
			switch(configdata[itemcount].nodeName)
			{
				case "GatewayUrl":
					_root.xmlGatewayUrl = string(configdata[itemcount].firstChild.nodeValue);
					_root.XMLConfigInit = true;
					break;
				case "GatewayPath":
					_root.xmlGatewayPath = string(configdata[itemcount].firstChild.nodeValue); 
					break;	
				case "Debug":
					_root.DebugMode = (string(timetableconfigdata[itemcount].firstChild.nodeValue) == "true"); 
					break;	
			}
		}
		if (_root.DebugMode == true)
		{
			_root.MessageBox('Warning: debug is on.');
		}
		simassessmentInit();
	} else 
	{
		if (_root.secondtry != true)
		{
			_root._root.MessageBox('Retrying configuration file');
			_root.secondtry = true;
			_root.timetableconfigXML.load("../application.xml");
		}else 
			_root.MessageBox('Unable to find configuration file');
	}
}
_root.MessageBox('Loading configuration file');
var timetableconfigXML = new XML();
timetableconfigXML.ignoreWhite = true
timetableconfigXML.onLoad = xmlOnLoad;
timetableconfigXML.load("application.xml");

