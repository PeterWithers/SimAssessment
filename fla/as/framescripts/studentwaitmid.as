if (sendtolabel == 'talk') 
{
	gotoAndStop('talk');
	sendtolabel = null;
}
else if (sendtolabel != null) 
{
	gotoAndPlay(sendtolabel);
	sendtolabel = null;
}
else 
{
	if (handuppause > 0) handuppause--; 
	if (handup and _root.ShowOfHands and handuppause <= 0)
	{
		handup = false;
		gotoAndPlay('studenthandupstart');
	}
	else gotoAndPlay(2);
}

