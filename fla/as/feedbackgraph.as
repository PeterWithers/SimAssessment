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
	
	// label buttons
	if (_root.GraphDisplay.supressweekdecay) _root.GraphDisplay.nodecay.label = 'decay';
	else _root.GraphDisplay.nodecay.label = 'logdecay';
	if (_root.GraphDisplay.supressweektween) _root.GraphDisplay.untween.label = 'tween';
	else _root.GraphDisplay.untween.label = 'untween';
	if (_root.GraphDisplay.weekdecaylog)  _root.GraphDisplay.nodecay.label = 'nodecay';
	
	
	leftedge_graph = _root.GraphDisplay.GraphMarker._x;
	rightedge_graph = leftedge_graph + _root.GraphDisplay.GraphMarker._width;
	topedge_graph = _root.GraphDisplay.GraphMarker._y;
	bottomedge_graph = topedge_graph + _root.GraphDisplay.GraphMarker._height;
	width_graph = rightedge_graph - leftedge_graph;
	height_graph = bottomedge_graph - topedge_graph;

	_root.GraphDisplay.createEmptyMovieClip ("graph", 1);
	
	_root.GraphDisplay.graph._x = _root.GraphDisplay._x;
//	_root.GraphDisplay.graph._y = _root.GraphDisplay._y
	
	
	//  make the items in graph limited to the following
	graph_items = 'student_emotion,feedback,student_workload,teacher_workload,public_confidence,approach_to_learning,goal_alignment';
	TweenableList = graph_items.split(',');
//	totalrows_graph = 7;
	
	
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
		currentrowheight_graph = bottomedge_graph - rowheight_graph * currentrow_graph;

		// draw reference lines
		_root.GraphDisplay.graph.lineStyle (1, 0x999999, 100);
		_root.GraphDisplay.graph.moveTo(leftedge_graph, currentrowheight_graph);
		_root.GraphDisplay.graph.lineTo (rightedge_graph, currentrowheight_graph);
		
		// draw increment lines
		_root.GraphDisplay.graph.lineStyle (1, 0x999999, 40);
		for (incrementlines = 1; incrementlines < 5; incrementlines++)
		{
			_root.GraphDisplay.graph.moveTo(leftedge_graph, currentrowheight_graph + (rowheight_graph / 5 * incrementlines));
			_root.GraphDisplay.graph.lineTo (rightedge_graph, currentrowheight_graph + (rowheight_graph / 5 * incrementlines));
		} 
		tweenable = TweenableList[currentrow_graph - 1];
		
		// exception for student_emotion
		if (tweenable == "student_emotion")
		{		
			// draw the variation based on personality
			for (Student in _root.Classroom)
			{
				if (_root.Classroom[Student].student != null)
				{
					personality_workload = _root.Classroom[Student].personality_workload;
					personality_feedback = _root.Classroom[Student].personality_feedback;
					
					_root.GraphDisplay.graph.lineStyle (1, linecolour_graph + 0x999900, 100);
					_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph + (width_graph / 14) * 0, currentrowheight_graph + (5 - calculate_emotion(Number(_root.TweenedWeeklyStates[1]['student_workload']) + personality_workload, Number(_root.TweenedWeeklyStates[1]['feedback']) + personality_feedback)) * 11);
					for (weekgraphpoint = 1; weekgraphpoint < 14; weekgraphpoint++) 
					{
						_root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (5 - calculate_emotion(Number(_root.TweenedWeeklyStates[weekgraphpoint + 1]['student_workload']) + personality_workload, Number(_root.TweenedWeeklyStates[weekgraphpoint + 1]['feedback']) + personality_feedback)) * 11);
					}
				}
			}
			
			// draw the variation based on personality  limits
			for (query_position = 0; query_position < 4; query_position++)
			{
				switch(query_position)
				{
					case 0:
						personality_workload = -1;
						personality_feedback = -1;
						break;
					case 1:
						personality_workload = 1;
						personality_feedback = -1;
						break;
					case 2:
						personality_workload = -1;
						personality_feedback = 1;
						break;
					case 3:
						personality_workload = 1;
						personality_feedback = 1;
						break;
				}
				_root.GraphDisplay.graph.lineStyle (1, linecolour_graph + 0x331177, 100);
				_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph + (width_graph / 14) * 0, currentrowheight_graph + (5 - calculate_emotion(Number(_root.TweenedWeeklyStates[1]['student_workload']) + personality_workload, Number(_root.TweenedWeeklyStates[1]['feedback']) + personality_feedback)) * 11);
				for (weekgraphpoint = 1; weekgraphpoint < 14; weekgraphpoint++) 
				{
					_root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (5 - calculate_emotion(Number(_root.TweenedWeeklyStates[weekgraphpoint + 1]['student_workload']) + personality_workload, Number(_root.TweenedWeeklyStates[weekgraphpoint + 1]['feedback']) + personality_feedback)) * 11);
				}
			}
			
			// draw the emotion
			linecolour_graph = linecolour_graph + 0x005522;
			_root.GraphDisplay.graph.lineStyle (5, linecolour_graph, 100);
			_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph + (width_graph / 14) * 0, currentrowheight_graph + (5 - calculate_emotion(_root.TweenedWeeklyStates[1]['student_workload'], _root.TweenedWeeklyStates[1]['feedback'])) * 11);
			for (weekgraphpoint = 1; weekgraphpoint < 14; weekgraphpoint++) 
			{
				_root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (5 - calculate_emotion(_root.TweenedWeeklyStates[weekgraphpoint + 1]['student_workload'], _root.TweenedWeeklyStates[weekgraphpoint + 1]['feedback'])) * 11);
			}		
			
			// label the emotions
			EmotionValue = 5;
			EmotionY = currentrowheight_graph + (5 - EmotionValue) * 11;
			_root.GraphDisplay.graph.createTextField("Happy", currentrow_graph * 14 + 1, rightedge_graph - 33, EmotionY - 10, 33, 20);
			_root.GraphDisplay.graph.Happy.text = "Happy";

			EmotionValue = 4;
			EmotionY = currentrowheight_graph + (5 - EmotionValue) * 11;
			_root.GraphDisplay.graph.createTextField("Stressed", currentrow_graph * 14 + 2, rightedge_graph - 33, EmotionY - 10, 33, 20);
			_root.GraphDisplay.graph.Stressed.text = "Stressed";
			
			EmotionValue = 3;
			EmotionY = currentrowheight_graph + (5 - EmotionValue) * 11;
			_root.GraphDisplay.graph.createTextField("Neutral", currentrow_graph * 14 + 3, rightedge_graph - 33, EmotionY - 10, 33, 20);
			_root.GraphDisplay.graph.Neutral.text = "Neutral";
			
			EmotionValue = 2;
			EmotionY = currentrowheight_graph + (5 - EmotionValue) * 11;
			_root.GraphDisplay.graph.createTextField("Anxious", currentrow_graph * 14 + 4, rightedge_graph - 33, EmotionY - 10, 33, 20);
			_root.GraphDisplay.graph.Anxious.text = "Anxious";
			
			EmotionValue = 1;
			EmotionY = currentrowheight_graph + (5 - EmotionValue) * 11;
			_root.GraphDisplay.graph.createTextField("Depressed", currentrow_graph * 14 + 5, rightedge_graph - 33, EmotionY - 10, 33, 20);
			_root.GraphDisplay.graph.Depressed.text = "Depressed";
		}
		else
		{
			// draw data			
			linecolour_graph = linecolour_graph + 0x005522;
			_root.GraphDisplay.graph.lineStyle (5, linecolour_graph, 100);
	//		_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph, currentrowheight_graph);

			// draw the data line
			_root.GraphDisplay.graph.moveTo (leftedge_graph + offset_graph + (width_graph / 14) * 0, currentrowheight_graph + (5 - _root.TweenedWeeklyStates[1][tweenable]) * 11);
			for (weekgraphpoint = 1; weekgraphpoint < 14; weekgraphpoint++) _root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (5 - _root.TweenedWeeklyStates[weekgraphpoint + 1][tweenable]) * 11);

//_root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * 7, currentrowheight_graph + 0 * 11);
//_root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * 7, currentrowheight_graph + 5 * 11);


			// draw the data nodes
			_root.GraphDisplay.graph.lineStyle (20, linecolour_graph, 100);
			for (AssignmentWeek in _root.AssignmentWeeks) 
			{
				weekgraphpoint = _root.AssignmentWeeks[AssignmentWeek] - 1;
				trace('weekgraphpoint: ' + weekgraphpoint);
				Xcurrent = leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint;
				Ycurrent = currentrowheight_graph + (5 - _root.TweenedWeeklyStates[weekgraphpoint + 1][tweenable]) * 10;
				_root.GraphDisplay.graph.moveTo(Xcurrent, Ycurrent);
				_root.GraphDisplay.graph.lineTo (Xcurrent, Ycurrent + 1);
				_root.GraphDisplay.graph.createTextField("DataValue_" + currentrow_graph + "_" + AssignmentWeek, currentrow_graph * 14 + AssignmentWeek, Xcurrent, Ycurrent - 10, 33, 20);
				eval("_root.GraphDisplay.graph.DataValue_" + currentrow_graph + "_" + AssignmentWeek).text = _root.TweenedWeeklyStates[weekgraphpoint + 1][tweenable];
			}
		}
		//for (weekgraphpoint = 0; weekgraphpoint < 14; weekgraphpoint++) _root.GraphDisplay.graph.lineTo (leftedge_graph + offset_graph + (width_graph / 14) * weekgraphpoint, currentrowheight_graph + (weekgraphpoint % 2) * 10);

		// draw text labels
		_root.GraphDisplay.graph.createTextField(tweenable + '_label', currentrow_graph + 5, leftedge_graph + offset_graph, currentrowheight_graph, 200, 100);
		_root.GraphDisplay.graph[tweenable + '_label'].text = tweenable;
	}
}

_root.GraphDisplay.hide = function()
{
	_root.GraphDisplay._x = -800;
}

_root.GraphDisplay.settween = function()
{
	_root.GraphDisplay.supressweektween = !_root.GraphDisplay.supressweektween;
	_root.tweenweeks();
	_root.GraphDisplay.show();
}
_root.GraphDisplay.setdecay = function()
{
	if (_root.GraphDisplay.weekdecaylog and !_root.GraphDisplay.supressweekdecay)
	{
		_root.GraphDisplay.weekdecaylog = false;
		_root.GraphDisplay.supressweekdecay = true;
	}
	else if (!_root.GraphDisplay.supressweekdecay) _root.GraphDisplay.weekdecaylog = true;
	else _root.GraphDisplay.supressweekdecay = false;

	_root.tweenweeks();
	_root.GraphDisplay.show();
}

