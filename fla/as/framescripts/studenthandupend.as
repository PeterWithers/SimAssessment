if (_root.IntroductionRunning) gotoAndStop('talk');
else if (sendtolabel == 'talk') 
{
	gotoAndStop('talk');
	sendtolabel = null;
}
else if (sendtolabel != null) 
{
	gotoAndPlay(sendtolabel);
	sendtolabel = null;
}
else gotoAndPlay('studenthandupstart');

