function SetUpEngineTestPresets(dropdowntopopulate)
{
	dropdowntopopulate.removeAll();
	dropdowntopopulate.addItem('EngineTest:', 1);
	
	Multiple = new Array();
	Multiple[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '2'};
	Multiple[1] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '2'};
	Multiple[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '2'};
	Multiple[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 4, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
	Multiple[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 5, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('Multiple', Multiple);
	
	
			Feedback1 = new Array();
	Feedback1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '2'};
	Feedback1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '2'};
	Feedback1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '2'};
	Feedback1[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 4, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
	Feedback1[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 5, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('Feedback1', Feedback1);
	
			Feedback2 = new Array();
	Feedback2[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 5, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '2'};
	Feedback2[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 4, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '2'};
	Feedback2[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '2'};
	Feedback2[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
	Feedback2[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('Feedback2', Feedback2);

	////////////////////////////////////////
	dropdowntopopulate.addItem('--------', 1);
	
/*			StudentWorkload1 = new Array();
	StudentWorkload1[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentWorkload1[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '2'};
	StudentWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '2'};
	StudentWorkload1[3] = {ass_id: 12, ass_name: 'Case studies', due_week: 10, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
	StudentWorkload1[4] = {ass_id: 14, ass_name: 'Portfolio', due_week: 12, feedback: 1, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('StudentWorkload1', StudentWorkload1); */
	
	StudentWorkload1 = new Array();
	StudentWorkload1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Teacher', weighting: 3,  which_ass: 1, goal_ids: '2'};
	StudentWorkload1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
//	StudentWorkload1[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 3, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '2'};
//	StudentWorkload1[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('StudentWorkload1', StudentWorkload1);
	
///////////////////////////////////////////
	dropdowntopopulate.addItem('--------', 1);

	AssignmentWorkloadH = new Array();
	AssignmentWorkloadH[0] = {ass_id: 6, ass_name: 'Practicum', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	AssignmentWorkloadH[1] = {ass_id: 6, ass_name: 'Practicum', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	AssignmentWorkloadH[2] = {ass_id: 6, ass_name: 'Practicum', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('AssigWorkloadH', AssignmentWorkloadH);

	AssignmentWorkloadM = new Array();
	AssignmentWorkloadM[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	AssignmentWorkloadM[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	AssignmentWorkloadM[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('AssigWorkloadM', AssignmentWorkloadM);	
	
	AssignmentWorkloadL = new Array();
	AssignmentWorkloadL[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	AssignmentWorkloadL[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	AssignmentWorkloadL[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('AssigWorkloadL', AssignmentWorkloadL);	
	
	AssignmentWorkloadA = new Array();
	AssignmentWorkloadA[0] = {ass_id: 1, ass_name: 'Essay', due_week: 1, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	AssignmentWorkloadA[1] = {ass_id: 2, ass_name: 'Problem', due_week: 3, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 2, goal_ids: '2'};
	AssignmentWorkloadA[2] = {ass_id: 3, ass_name: 'Report', due_week: 5, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 3, goal_ids: '2'};
	AssignmentWorkloadA[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	AssignmentWorkloadA[4] = {ass_id: 5, ass_name: 'Short answer question', due_week: 9, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 2, goal_ids: '2'};
	AssignmentWorkloadA[5] = {ass_id: 6, ass_name: 'Practicum', due_week: 11, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 3, goal_ids: '2'};
	AssignmentWorkloadA[6] = {ass_id: 7, ass_name: 'Project', due_week: 13, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	dropdowntopopulate.addItem('AssigWorkloadA', AssignmentWorkloadA);	

	////////////////////////////////////////
	dropdowntopopulate.addItem('--------', 1);
		
	MarkerWorkloadL = new Array();
	MarkerWorkloadL[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 1, goal_ids: '2'};
	MarkerWorkloadL[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 2, goal_ids: '2'};
	MarkerWorkloadL[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('MarkerWorkloadL', MarkerWorkloadL);

	MarkerWorkloadM = new Array();
	MarkerWorkloadM[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	MarkerWorkloadM[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	MarkerWorkloadM[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('MarkerWorkloadM', MarkerWorkloadM);	
	
	MarkerWorkloadH = new Array();
	MarkerWorkloadH[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Teacher', weighting: 3,  which_ass: 1, goal_ids: '2'};
	MarkerWorkloadH[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Teacher', weighting: 3,  which_ass: 2, goal_ids: '2'};
	MarkerWorkloadH[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Teacher', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('MarkerWorkloadH', MarkerWorkloadH);
	
	MarkerWorkloadA = new Array();
	MarkerWorkloadA[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 1, goal_ids: '2'};
	MarkerWorkloadA[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	MarkerWorkloadA[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Teacher', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('MarkerWorkloadA', MarkerWorkloadA);		
	
	//////////////////////////////////
	dropdowntopopulate.addItem('--------', 1);
	
	WeightingWorkloadH = new Array();
	WeightingWorkloadH[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 5,  which_ass: 1, goal_ids: '2'};
	WeightingWorkloadH[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 5,  which_ass: 2, goal_ids: '2'};
	WeightingWorkloadH[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 5,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('WeightWorkloadH', WeightingWorkloadH);
	
	WeightingWorkloadM = new Array();
	WeightingWorkloadM[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	WeightingWorkloadM[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	WeightingWorkloadM[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('WeightWorkloadM', WeightingWorkloadM);
	
	WeightingWorkloadL = new Array();
	WeightingWorkloadL[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	WeightingWorkloadL[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 2, goal_ids: '2'};
	WeightingWorkloadL[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('WeightWorkloadL', WeightingWorkloadL);
	
	WeightingWorkloadA = new Array();
	WeightingWorkloadA[0] = {ass_id: 1, ass_name: 'Essay', due_week: 3, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	WeightingWorkloadA[1] = {ass_id: 1, ass_name: 'Essay', due_week: 5, feedback: 3, marker: 'Peer', weighting: 2,  which_ass: 2, goal_ids: '2'};
	WeightingWorkloadA[2] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	WeightingWorkloadA[3] = {ass_id: 1, ass_name: 'Essay', due_week: 9, feedback: 3, marker: 'Peer', weighting: 4,  which_ass: 2, goal_ids: '2'};
	WeightingWorkloadA[4] = {ass_id: 1, ass_name: 'Essay', due_week: 11, feedback: 3, marker: 'Peer', weighting: 5,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('WeightWorkloadA', WeightingWorkloadA);
	
	///////////////////////////
	dropdowntopopulate.addItem('--------', 1);	
	
	CloseSpacingWorkload1 = new Array();
	CloseSpacingWorkload1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	CloseSpacingWorkload1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	CloseSpacingWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('CloseSpcWorkload1', CloseSpacingWorkload1);	
	
	MediumSpacingWorkload1 = new Array();
	MediumSpacingWorkload1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	MediumSpacingWorkload1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	MediumSpacingWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	dropdowntopopulate.addItem('MediumSpcWorkload1', MediumSpacingWorkload1);	
	
	DistantSpacingWorkload1 = new Array();
	DistantSpacingWorkload1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	DistantSpacingWorkload1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	dropdowntopopulate.addItem('DistantSpcWorkload1', DistantSpacingWorkload1);	
	
	IntenseSpacingWorkload1 = new Array();
	IntenseSpacingWorkload1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 1, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	IntenseSpacingWorkload1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 2, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	IntenseSpacingWorkload1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 3, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	IntenseSpacingWorkload1[3] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 4, goal_ids: '2'};
	IntenseSpacingWorkload1[4] = {ass_id: 1, ass_name: 'Essay', due_week: 5, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 5, goal_ids: '2'};
	IntenseSpacingWorkload1[5] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 6, goal_ids: '2'};
	IntenseSpacingWorkload1[6] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 7, goal_ids: '2'};
	IntenseSpacingWorkload1[7] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 8, goal_ids: '2'};
	IntenseSpacingWorkload1[8] = {ass_id: 1, ass_name: 'Essay', due_week: 9, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 9, goal_ids: '2'};
	IntenseSpacingWorkload1[9] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 10, goal_ids: '2'};
	IntenseSpacingWorkload1[10] = {ass_id: 1, ass_name: 'Essay', due_week: 11, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 11, goal_ids: '2'};
	IntenseSpacingWorkload1[11] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 12, goal_ids: '2'};
	IntenseSpacingWorkload1[12] = {ass_id: 1, ass_name: 'Essay', due_week: 13, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 13, goal_ids: '2'};
	IntenseSpacingWorkload1[13] = {ass_id: 1, ass_name: 'Essay', due_week: 14, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 14, goal_ids: '2'};
	dropdowntopopulate.addItem('IntenWorkload1', IntenseSpacingWorkload1);		
	
	IntenseSpacingWorkload2 = new Array();
	IntenseSpacingWorkload2[0] = {ass_id: 1, ass_name: 'Essay', due_week: 1, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	IntenseSpacingWorkload2[1] = {ass_id: 1, ass_name: 'Essay', due_week: 3, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	IntenseSpacingWorkload2[2] = {ass_id: 1, ass_name: 'Essay', due_week: 5, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	IntenseSpacingWorkload2[3] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 4, goal_ids: '2'};
	IntenseSpacingWorkload2[4] = {ass_id: 1, ass_name: 'Essay', due_week: 9, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 5, goal_ids: '2'};
	IntenseSpacingWorkload2[5] = {ass_id: 1, ass_name: 'Essay', due_week: 11, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 6, goal_ids: '2'};
	IntenseSpacingWorkload2[6] = {ass_id: 1, ass_name: 'Essay', due_week: 13, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 7, goal_ids: '2'};
	dropdowntopopulate.addItem('IntenWorkload2', IntenseSpacingWorkload2);		
	
	IntenseSpacingWorkload3 = new Array();
	IntenseSpacingWorkload3[0] = {ass_id: 1, ass_name: 'Essay', due_week: 2, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 1, goal_ids: '2'};
	IntenseSpacingWorkload3[1] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	IntenseSpacingWorkload3[2] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 3, goal_ids: '2'};
	IntenseSpacingWorkload3[3] = {ass_id: 1, ass_name: 'Essay', due_week: 8, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 4, goal_ids: '2'};
	IntenseSpacingWorkload3[4] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 5, goal_ids: '2'};
	IntenseSpacingWorkload3[5] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 6, goal_ids: '2'};
	IntenseSpacingWorkload3[6] = {ass_id: 1, ass_name: 'Essay', due_week: 14, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 7, goal_ids: '2'};
	dropdowntopopulate.addItem('IntenWorkload3', IntenseSpacingWorkload3);		
	
	///////////////////////////
	dropdowntopopulate.addItem('--------', 1);	
	
	StudentEmotionGrid1 = new Array();
	StudentEmotionGrid1[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentEmotionGrid1[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 1, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentEmotionGrid1[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 1, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	StudentEmotionGrid1[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 1, marker: 'Self', weighting: 3,  which_ass: 4, goal_ids: '2'};
	StudentEmotionGrid1[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 1, marker: 'Self', weighting: 4,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('EmotionGrid1', StudentEmotionGrid1);	
		
	StudentEmotionGrid2 = new Array();
	StudentEmotionGrid2[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 2, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentEmotionGrid2[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 2, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentEmotionGrid2[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	StudentEmotionGrid2[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 2, marker: 'Self', weighting: 3,  which_ass: 4, goal_ids: '2'};
	StudentEmotionGrid2[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 2, marker: 'Self', weighting: 4,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('EmotionGrid2', StudentEmotionGrid2);	
		
	StudentEmotionGrid3 = new Array();
	StudentEmotionGrid3[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 3, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentEmotionGrid3[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 3, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentEmotionGrid3[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	StudentEmotionGrid3[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 3, marker: 'Self', weighting: 3,  which_ass: 4, goal_ids: '2'};
	StudentEmotionGrid3[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 3, marker: 'Self', weighting: 4,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('EmotionGrid3', StudentEmotionGrid3);	
		
	StudentEmotionGrid4 = new Array();
	StudentEmotionGrid4[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 4, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentEmotionGrid4[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 4, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentEmotionGrid4[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 4, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	StudentEmotionGrid4[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 4, marker: 'Self', weighting: 3,  which_ass: 4, goal_ids: '2'};
	StudentEmotionGrid4[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 4, marker: 'Self', weighting: 4,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('EmotionGrid4', StudentEmotionGrid4);	
		
	StudentEmotionGrid5 = new Array();
	StudentEmotionGrid5[0] = {ass_id: 1, ass_name: 'Essay', due_week: 4, feedback: 5, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	StudentEmotionGrid5[1] = {ass_id: 1, ass_name: 'Essay', due_week: 6, feedback: 5, marker: 'Peer', weighting: 3,  which_ass: 2, goal_ids: '2'};
	StudentEmotionGrid5[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 5, marker: 'Self', weighting: 3,  which_ass: 3, goal_ids: '2'};
	StudentEmotionGrid5[3] = {ass_id: 1, ass_name: 'Essay', due_week: 10, feedback: 5, marker: 'Self', weighting: 3,  which_ass: 4, goal_ids: '2'};
	StudentEmotionGrid5[4] = {ass_id: 1, ass_name: 'Essay', due_week: 12, feedback: 5, marker: 'Self', weighting: 4,  which_ass: 5, goal_ids: '2'};
	dropdowntopopulate.addItem('EmotionGrid5', StudentEmotionGrid5);	
			
	///////////////////////////
	dropdowntopopulate.addItem('--------', 1);	
	
	ReportGoals1 = new Array();
	ReportGoals1[0] = {ass_id: 1, ass_name: '', due_week: 1, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 1, goal_ids: '2'};
	ReportGoals1[1] = {ass_id: 2, ass_name: '', due_week: 2, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 2, goal_ids: '2'};
	ReportGoals1[2] = {ass_id: 3, ass_name: '', due_week: 3, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 3, goal_ids: '2'};
	ReportGoals1[3] = {ass_id: 4, ass_name: '', due_week: 4, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 4, goal_ids: '2'};
	ReportGoals1[4] = {ass_id: 5, ass_name: '', due_week: 5, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 5, goal_ids: '2'};
	ReportGoals1[5] = {ass_id: 6, ass_name: '', due_week: 6, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 6, goal_ids: '2'};
	ReportGoals1[6] = {ass_id: 7, ass_name: '', due_week: 7, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 7, goal_ids: '2'};
	ReportGoals1[7] = {ass_id: 8, ass_name: '', due_week: 8, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 8, goal_ids: '2'};
	ReportGoals1[8] = {ass_id: 9, ass_name: '', due_week: 9, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 9, goal_ids: '2'};
	ReportGoals1[9] = {ass_id: 10, ass_name: '', due_week: 10, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 10, goal_ids: '2'};
	ReportGoals1[10] = {ass_id: 11, ass_name: '', due_week: 11, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 11, goal_ids: '2'};
	ReportGoals1[11] = {ass_id: 12, ass_name: '', due_week: 12, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 12, goal_ids: '2'};
	ReportGoals1[12] = {ass_id: 13, ass_name: '', due_week: 13, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 13, goal_ids: '2'};
	ReportGoals1[13] = {ass_id: 14, ass_name: '', due_week: 14, feedback: 1, marker: 'Peer', weighting: 1,  which_ass: 14, goal_ids: '2'};
	
	dropdowntopopulate.addItem('ReportGoals1', ReportGoals1);	
	
	//////////////////////////////
			
//	'Multiple choice questions'
//	'Poster presentation'
//	'Class presentation'
//	'Interview'
//	'Essay'
//	'Project'	
//	'Case studies'
//	'Portfolio'
	
	
	
	
	
	
	
	
/*	
	EngineTest1 = new Array();
	EngineTest1[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '14'};
	EngineTest1[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 2, goal_ids: '14'};
	EngineTest1[2] = {ass_id: 1, ass_name: 'Essay', due_week: 11, feedback: 2, marker: 'Teacher', weighting: 3, which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest1', EngineTest1);
	
	EngineTest2 = new Array();
	EngineTest2[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '14'};
	EngineTest2[1] = {ass_id: 9, ass_name: 'Class presentation', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 2, goal_ids: '14'};
	EngineTest2[2] = {ass_id: 1, ass_name: 'Essay', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 3, which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest2', EngineTest2);


		EngineTest17 = new Array();
	EngineTest17[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 1, goal_ids: '14'};
	EngineTest17[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '14'};
	EngineTest17[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '14'};
	EngineTest17[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '14'};
	EngineTest17[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '14'};
	EngineTest17[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 6, goal_ids: '14'};
	EngineTest17[6] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 7, goal_ids: '14'};
	EngineTest17[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 8, goal_ids: '14'};
	EngineTest17[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 10, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 9, goal_ids: '14'};
	EngineTest17[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 10, goal_ids: '14'};
	EngineTest17[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:12, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 11, goal_ids: '14'};
	EngineTest17[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 12, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest17', EngineTest17);

		EngineTest18 = new Array();
	EngineTest18[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 1, goal_ids: '14'};
	EngineTest18[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 2, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '14'};
	EngineTest18[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '14'};
	EngineTest18[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '14'};
	EngineTest18[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '14'};
	EngineTest18[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 6, goal_ids: '14'};
	EngineTest18[6] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 7, goal_ids: '14'};
	EngineTest18[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 8, goal_ids: '14'};
	EngineTest18[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 9, goal_ids: '14'};
	EngineTest18[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:10, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 10, goal_ids: '14'};
	EngineTest18[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 11, goal_ids: '14'};
	EngineTest18[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 12, goal_ids: '14'};
	EngineTest18[12] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 13, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest18', EngineTest18);
	
			EngineTest19 = new Array();
	EngineTest19[0] = {ass_id: 1, ass_name: 'Essay', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 2,  which_ass: 1, goal_ids: '14'};
	EngineTest19[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 2, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 2, goal_ids: '14'};
	EngineTest19[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 3, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 3, goal_ids: '14'};
	EngineTest19[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 4, goal_ids: '14'};
	EngineTest19[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 5, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 5, goal_ids: '14'};
	EngineTest19[5] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 6, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 6, goal_ids: '14'};
	EngineTest19[6] = {ass_id: 1, ass_name: 'Essay', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 7, goal_ids: '14'};
	EngineTest19[7] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 8, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 8, goal_ids: '14'};
	EngineTest19[8] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 9, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 9, goal_ids: '14'};
	EngineTest19[9] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:10, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 10, goal_ids: '14'};
	EngineTest19[10] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week:11, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 11, goal_ids: '14'};
	EngineTest19[11] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 12, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 12, goal_ids: '14'};
	EngineTest19[12] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 13, feedback: 2, marker: 'Teacher', weighting: 1,  which_ass: 13, goal_ids: '14'};
	EngineTest19[13] = {ass_id: 1, ass_name: 'Essay', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 14, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest19', EngineTest19);
	
	EngineTest40 = new Array();
	EngineTest40[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 1, goal_ids: '14'};
	EngineTest40[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 2, goal_ids: '14'};
	EngineTest40[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 3, goal_ids: '14'};
	EngineTest40[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 11, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 4, goal_ids: '14'};
	EngineTest40[4] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 5, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest40', EngineTest40);
	
	EngineTest41 = new Array();
	EngineTest41[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 1, goal_ids: '14'};
	EngineTest41[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 4, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 2, goal_ids: '14'};
	EngineTest41[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 3, goal_ids: '14'};
	EngineTest41[3] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 3,  which_ass: 4, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest41', EngineTest41);

	EngineTest42 = new Array();
	EngineTest42[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 4,  which_ass: 1, goal_ids: '14'};
	EngineTest42[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 7, feedback: 2, marker: 'Teacher', weighting: 4,  which_ass: 2, goal_ids: '14'};
	EngineTest42[2] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 4,  which_ass: 3, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest42', EngineTest42);
		
	EngineTest43 = new Array();
	EngineTest43[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 5,  which_ass: 1, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest43', EngineTest43);

	EngineTest44 = new Array();
	EngineTest44[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 5,  which_ass: 1, goal_ids: '14'};
	EngineTest44[1] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 14, feedback: 2, marker: 'Teacher', weighting: 5,  which_ass: 2, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest44', EngineTest44);
	
	EngineTest45 = new Array();
	EngineTest45[0] = {ass_id: 4, ass_name: 'Multiple choice questions', due_week: 1, feedback: 2, marker: 'Teacher', weighting: 5,  which_ass: 1, goal_ids: '14'};
	dropdowntopopulate.addItem('EngineTest45', EngineTest45);
*/	
	_root.EngineTest = true;
}
// 1
function LoadEngineTestPresets()
{
	_root.UserName = 'EngineTestPresets';
	_root.EnableControlsFunction();
	_root.SetUpClass();
	_root.RemoveMessageBox();
	_root.SetUpEngineTestPresets(_root.Presets);
}		