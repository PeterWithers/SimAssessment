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
	newFrame = random(30) + this._currentframe;
	gotoAndPlay(newFrame);
}


