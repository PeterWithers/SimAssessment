function SetUpEngineTestPresets(dropdowntopopulate)
{
	dropdowntopopulate.removeAll();
	dropdowntopopulate.addItem('EngineTest:', 1);
	
			Feedback1 = new Array();
	Feedback1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '2'};
	Feedback1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 2, goal_ids: '2'};
	Feedback1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 3, goal_ids: '2'};
	Feedback1[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 4, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '2'};
	Feedback1[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 5, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('Feedback1', Feedback1);

			StudentWorkload1 = new Array();
	StudentWorkload1[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '2'};
	StudentWorkload1[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 2, goal_ids: '2'};
	StudentWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 3, goal_ids: '2'};
	StudentWorkload1[3] = {ass_id: 12, ass_name: 'Case studies', due_week: 10, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '2'};
	StudentWorkload1[4] = {ass_id: 14, ass_name: 'Portfolio', due_week: 12, feedback: 1, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('StudentWorkload1', StudentWorkload1);
	
	
//	'Multiple choice questions'
//	'Poster presentation'
//	'Class presentation'
//	'Interview'
//	'Essay'
//	'Project'	
//	'Case studies'
//	'Portfolio'
	
	
	
	
	
	
	
	
	
	EngineTest1 = new Array();
	EngineTest1[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '14'};
	EngineTest1[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 2, goal_ids: '14'};
	EngineTest1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 11, feedback: 2, marker: 'Teacher', weighting: '40% and 60%', which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest1', EngineTest1);
	
	EngineTest2 = new Array();
	EngineTest2[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '14'};
	EngineTest2[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 2, goal_ids: '14'};
	EngineTest2[2] = {ass_id: 1, ass_name: 'Essay', due_week: 9, feedback: 2, marker: 'Teacher', weighting: '40% and 60%', which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest2', EngineTest2);


		EngineTest17 = new Array();
	EngineTest17[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 1, goal_ids: '14'};
	EngineTest17[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 2, goal_ids: '14'};
	EngineTest17[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 3, goal_ids: '14'};
	EngineTest17[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '14'};
	EngineTest17[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 5, goal_ids: '14'};
	EngineTest17[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 6, goal_ids: '14'};
	EngineTest17[6] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 7, goal_ids: '14'};
	EngineTest17[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 8, goal_ids: '14'};
	EngineTest17[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 10, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 9, goal_ids: '14'};
	EngineTest17[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 10, goal_ids: '14'};
	EngineTest17[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:12, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 11, goal_ids: '14'};
	EngineTest17[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 12, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest17', EngineTest17);

		EngineTest18 = new Array();
	EngineTest18[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 1, goal_ids: '14'};
	EngineTest18[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 2, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 2, goal_ids: '14'};
	EngineTest18[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 3, goal_ids: '14'};
	EngineTest18[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '14'};
	EngineTest18[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 5, goal_ids: '14'};
	EngineTest18[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 6, goal_ids: '14'};
	EngineTest18[6] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 7, goal_ids: '14'};
	EngineTest18[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 8, goal_ids: '14'};
	EngineTest18[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 9, goal_ids: '14'};
	EngineTest18[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:10, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 10, goal_ids: '14'};
	EngineTest18[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 11, goal_ids: '14'};
	EngineTest18[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 12, goal_ids: '14'};
	EngineTest18[12] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 13, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest18', EngineTest18);
	
			EngineTest19 = new Array();
	EngineTest19[0] = {ass_id: 1, ass_name: 'Essay', due_week: 1, feedback: 2, marker: 'Teacher', weighting: '20% and 40%',  which_ass: 1, goal_ids: '14'};
	EngineTest19[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 2, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 2, goal_ids: '14'};
	EngineTest19[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 3, goal_ids: '14'};
	EngineTest19[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 4, goal_ids: '14'};
	EngineTest19[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 5, goal_ids: '14'};
	EngineTest19[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 6, goal_ids: '14'};
	EngineTest19[6] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 7, goal_ids: '14'};
	EngineTest19[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 8, goal_ids: '14'};
	EngineTest19[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 9, goal_ids: '14'};
	EngineTest19[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:10, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 10, goal_ids: '14'};
	EngineTest19[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 11, goal_ids: '14'};
	EngineTest19[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 12, goal_ids: '14'};
	EngineTest19[12] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 13, feedback: 2, marker: 'Teacher', weighting: 'Less than 20%',  which_ass: 13, goal_ids: '14'};
	EngineTest19[13] = {ass_id: 1, ass_name: 'Essay', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 14, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest19', EngineTest19);
	
	EngineTest40 = new Array();
	EngineTest40[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 1, goal_ids: '14'};
	EngineTest40[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 2, goal_ids: '14'};
	EngineTest40[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 3, goal_ids: '14'};
	EngineTest40[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 11, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 4, goal_ids: '14'};
	EngineTest40[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 5, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest40', EngineTest40);
	
	EngineTest41 = new Array();
	EngineTest41[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 1, goal_ids: '14'};
	EngineTest41[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 2, goal_ids: '14'};
	EngineTest41[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 3, goal_ids: '14'};
	EngineTest41[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '40% and 60%',  which_ass: 4, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest41', EngineTest41);

	EngineTest42 = new Array();
	EngineTest42[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: '60% and 80%',  which_ass: 1, goal_ids: '14'};
	EngineTest42[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: '60% and 80%',  which_ass: 2, goal_ids: '14'};
	EngineTest42[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: '60% and 80%',  which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest42', EngineTest42);
		
	EngineTest43 = new Array();
	EngineTest43[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 'More than 80%',  which_ass: 1, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest43', EngineTest43);

	EngineTest44 = new Array();
	EngineTest44[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 'More than 80%',  which_ass: 1, goal_ids: '14'};
	EngineTest44[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 'More than 80%',  which_ass: 2, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest44', EngineTest44);
	
	EngineTest45 = new Array();
	EngineTest45[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 'More than 80%',  which_ass: 1, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest45', EngineTest45);
	
	_root.EngineTest = true;
}
// 'Less than 20%'
function LoadEngineTestPresets()
{
	_root.UserName = 'EngineTestPresets';
	_root.EnableControlsFunction();
	_root.SetUpClass();
	_root.RemoveMessageBox();
	_root.SetUpEngineTestPresets(_root.Presets);
}		