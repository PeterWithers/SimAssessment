trace('XMLConfig.as');
function xmlOnLoad(success) {
	if (success)
	{
		configdata = this.firstchild.childNodes;
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
//			_root.loadingscreen.loadinginfo.text = _root.loadingscreen.loadinginfo.text + '\nWarning: debug is on in XML';
		}
		simassessmentInit();
	} else 
	{
		trace("connectionFailed");
		if (_root.secondtry != true)
		{
			_root.secondtry = true;
			_root.timetableconfigXML.load("../application.xml");
		}
	}
}
var timetableconfigXML = new XML();
timetableconfigXML.ignoreWhite = true
timetableconfigXML.onLoad = xmlOnLoad;
timetableconfigXML.load("application.xml");

