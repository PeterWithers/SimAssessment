_root.feedbackgraph.setValues = function(happyCount, stressedCount, neutralCount, anxiousCount, depressedCount, NumberOfStudents)
{	
	clearInterval(_root.feedbackgraph.Interval);
	
	_root.feedbackgraph.Gradients = 10;
	_root.feedbackgraph.GradientsDone = 0;

    _root.feedbackgraph.OldHappybarScale = _root.feedbackgraph.happybar._xscale;
    _root.feedbackgraph.OldStressedbarScale = _root.feedbackgraph.stressedbar._xscale;
	_root.feedbackgraph.OldNeutralbarScale = _root.feedbackgraph.neutralbar._xscale;
    _root.feedbackgraph.OldAnxiousbarScale = _root.feedbackgraph.anxiousbar._xscale;
	_root.feedbackgraph.OldDepressedbarScale = _root.feedbackgraph.depressedbar._xscale;

    _root.feedbackgraph.NewHappybarScale = (happyCount / NumberOfStudents * 97) + 3;
    _root.feedbackgraph.NewStressedbarScale = (stressedCount / NumberOfStudents * 97) + 3;
	_root.feedbackgraph.NewNeutralbarScale = (neutralCount / NumberOfStudents * 97) + 3;
    _root.feedbackgraph.NewAnxiousbarScale = (anxiousCount / NumberOfStudents * 97) + 3;
	_root.feedbackgraph.NewDepressedbarScale = (depressedCount / NumberOfStudents * 97) + 3;
	
	_root.feedbackgraph.Interval = setInterval(_root.feedbackgraph.setValuesCallback, 50);
}

_root.feedbackgraph.setValuesCallback = function()
{
	_root.feedbackgraph.GradientsDone++;
	if (_root.feedbackgraph.GradientsDone >= _root.feedbackgraph.Gradients) clearInterval(_root.feedbackgraph.Interval);
	
	_root.feedbackgraph.happybar._xscale = _root.feedbackgraph.CalculateGradulatedScale(_root.feedbackgraph.NewHappybarScale, _root.feedbackgraph.OldHappybarScale);
    _root.feedbackgraph.stressedbar._xscale = _root.feedbackgraph.CalculateGradulatedScale(_root.feedbackgraph.NewStressedbarScale, _root.feedbackgraph.OldStressedbarScale);
	_root.feedbackgraph.neutralbar._xscale = _root.feedbackgraph.CalculateGradulatedScale(_root.feedbackgraph.NewNeutralbarScale, _root.feedbackgraph.OldNeutralbarScale);
    _root.feedbackgraph.anxiousbar._xscale = _root.feedbackgraph.CalculateGradulatedScale(_root.feedbackgraph.NewAnxiousbarScale, _root.feedbackgraph.OldAnxiousbarScale);
	_root.feedbackgraph.depressedbar._xscale = _root.feedbackgraph.CalculateGradulatedScale(_root.feedbackgraph.NewDepressedbarScale, _root.feedbackgraph.OldDepressedbarScale);
	updateAfterEvent();
}

_root.feedbackgraph.CalculateGradulatedScale = function(NewScale, OldScale)
{
	return ((NewScale - OldScale) * _root.feedbackgraph.GradientsDone / _root.feedbackgraph.Gradients + OldScale);
}



