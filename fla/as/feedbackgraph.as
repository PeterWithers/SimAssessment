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

_root.GraphDisplay.show = function()
{
	_root.GraphDisplay._x = 0;
	
	leftedge_graph = _root.GraphDisplay.GraphMarker._x;
	rightedge_graph = leftedge_graph + _root.GraphDisplay.GraphMarker._width;
	topedge_graph = _root.GraphDisplay.GraphMarker._y;
	bottomedge_graph = topedge_graph + _root.GraphDisplay.GraphMarker._height;
	width_graph = rightedge_graph - leftedge_graph;
	height_graph = bottomedge_graph - topedge_graph;

	_root.GraphDisplay.createEmptyMovieClip ("graph", 1);
	
	_root.GraphDisplay.graph._x = _root.GraphDisplay._x;
//	_root.GraphDisplay.graph._y = _root.GraphDisplay._y
	
	offset_graph = width_graph / 28;
	linecolour_graph = 0x99FF00;
	totalrows_graph = TweenableList.length
	rowheight_graph = height_graph / totalrows_graph;
	
	// draw grid
	for (weekgraphpoint = 0; weekgraphpoint < 14; weekgraphpoint++)
	{
		_root.GraphDisplay.graph.lineStyle (1, 0x999999, 100);
		Xcurrent = leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint;
		_root.GraphDisplay.graph.moveTo(Xcurrent, bottomedge_graph);
		_root.GraphDisplay.graph.lineTo (Xcurrent, topedge_graph);
	}
	
	
	for (currentrow_graph = 1; currentrow_graph <= totalrows_graph; currentrow_graph++)
	{
		tweenable = TweenableList[currentrow_graph - 1];
		currentrowheight_graph = bottomedge_graph - rowheight_graph * currentrow_graph;
		linecolour_graph = linecolour_graph + 0x005522;
		_root.GraphDisplay.graph.lineStyle (5, linecolour_graph, 100);
//		_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph, currentrowheight_graph);
		_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph + (width_graph / 14) * 0, currentrowheight_graph + _root.TweenedWeeklyStates[1][tweenable] * 10);
		for (weekgraphpoint = 1; weekgraphpoint < 14; weekgraphpoint++) _root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + _root.TweenedWeeklyStates[weekgraphpoint + 1][tweenable] * 10);
		_root.GraphDisplay.graph.lineStyle (20, linecolour_graph, 100);
		for (AssignmentWeek in _root.AssignmentWeeks) 
		{
			weekgraphpoint = _root.AssignmentWeeks[AssignmentWeek] - 1;
			trace('weekgraphpoint: ' + weekgraphpoint);
			Xcurrent = leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint;
			Ycurrent = currentrowheight_graph + _root.TweenedWeeklyStates[weekgraphpoint + 1][tweenable] * 10;
			_root.GraphDisplay.graph.moveTo(Xcurrent, Ycurrent);
			_root.GraphDisplay.graph.lineTo (Xcurrent, Ycurrent + 1);
		}
		//for (weekgraphpoint = 0; weekgraphpoint < 14; weekgraphpoint++) _root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (weekgraphpoint % 2) * 10);
	}
}

_root.GraphDisplay.hide = function()
{
	_root.GraphDisplay._x = -800;
}

_root.GraphDisplay.removetween = function()
{
	_root.supressweektween = true;
	_root.tweenweeks();
	_root.GraphDisplay.show();
}

_root.GraphDisplay.replacetween = function()
{
	_root.supressweektween = false;
	_root.tweenweeks();
	_root.GraphDisplay.show();
}

