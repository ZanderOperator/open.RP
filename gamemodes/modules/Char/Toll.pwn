#include <YSI_Coding\y_hooks>

const MAX_LOCKABLE_BOOTHS = 8;
const MAX_TOOL_BOOTHS = 19; 

new 
	LockToll[MAX_LOCKABLE_BOOTHS],
	Toll[MAX_TOOL_BOOTHS];



hook OnGameModeInit()
{
	Toll[1] = CreateDynamicObject(968,1683.41284180,418.20925903,30.52388000,359.99865723,90.09484863,342.51824951,-1,-1,-1,200.0); //LS-LV ( autocesta, kapija 1)
	Toll[2] = CreateDynamicObject(968,1692.31713867,415.22802734,30.52388000,359.99450684,90.09338379,342.51525879,-1,-1,-1,200.0); //LS-LV ( autocesta, kapija 2)
	Toll[3] = CreateDynamicObject(968,1707.93225098,409.89813232,30.52388000,359.99450684,90.09338379,160.31793213,-1,-1,-1,200.0); //LS-LV ( autocesta, kapija 3)
	Toll[4] = CreateDynamicObject(968,1716.30249023,407.26788330,30.52388000,359.98901367,90.09338379,160.31250000,-1,-1,-1,200.0); //LS-LV ( autocesta, kapija 4)
	Toll[5] = CreateDynamicObject(968,113.30566406,-1279.77832031,14.64699173,0.00000000,269.24929810,303.62915039,-1,-1,-1,200.0); //LS-SF ( tunel, kapija 1)
	Toll[6] = CreateDynamicObject(968,103.74797058,-1266.07958984,14.57025719,0.00000000,270.05493164,125.26062012,-1,-1,-1,200.0); //LS-SF ( tunel, kapija 2)
	Toll[7] = CreateDynamicObject(968,95.99414062,-1260.61328125,14.34005356,0.00000000,269.24743652,303.62365723,-1,-1,-1,200.0); //LS-SF ( tunel, kapija 3)
	Toll[8] = CreateDynamicObject(968,86.60900879,-1246.70239258,14.34005356,0.00000000,270.05493164,125.25512695,-1,-1,-1,200.0); //LS-SF ( tunel, kapija 4)
	Toll[9] = CreateDynamicObject(968,-974.24493408,-333.65698242,36.04855347,0.00000000,89.81762695,351.16613770,-1,-1,-1,200.0); //LS-SF ( pokraj Aera SF, kapija 1)
	Toll[10] = CreateDynamicObject(968,-956.93566895,-332.20819092,36.12528992,0.00000000,89.81323242,164.85620117,-1,-1,-1,200.0); //LS-SF ( pokraj Aera SF, kapija 2)
	Toll[11] = CreateDynamicObject(968,514.15112305,467.14340210,18.94581032,0.00000000,89.90936279,33.35720825,-1,-1,-1,200.0); //LS-LV ( pokraj mosta tj. glavne putarine LS-LV, kapija 1)
	Toll[12] = CreateDynamicObject(968,526.27526855,478.48483276,18.94581032,0.00000000,89.90722656,217.39634705,-1,-1,-1,200.0); //LS-LV ( pokraj mosta tj. glavne putarine LS-LV, kapija 2)
	Toll[13] = CreateDynamicObject(968,-187.35478210,328.09213257,12.10415840,0.00000000,90.09484863,348.04675293,-1,-1,-1,200.0); //LS-LV ( izmedu putarine LV-LS ( kraj aera) i putarine pokraj mosta, kapija 1)
	Toll[14] = CreateDynamicObject(968,-170.33795166,326.81927490,12.10415840,0.00000000,90.09338379,165.65856934,-1,-1,-1,200.0); //LS-LV ( izmedu putarine LV-LS ( kraj aera) i putarine pokraj mosta, kapija 2)
	Toll[15] = CreateDynamicObject(968,-101.02379608,-928.78637695,19.78243637,0.00000000,89.19689941,331.46118164,-1,-1,-1,200.0); //LS-SF ( izmedu tunela ( LS-SF tunel) i SF-a, prolaz za kombajn, kapija 1)
	Toll[16] = CreateDynamicObject(968,-88.61416626,-935.47473145,19.78243637,0.00000000,89.19250488,153.08990479,-1,-1,-1,200.0); //LS-SF ( izmedu tunela ( LS-SF tunel) i SF-a, prolaz za kombajn, kapija 2)
	Toll[17] = CreateDynamicObject(968,59.73470688,-1537.94152832,4.88530493,0.00000000,89.94403076,264.83972168,-1,-1,-1,200.0); //LS-SF ( autocesta, kapija 1)
	Toll[18] = CreateDynamicObject(968,54.97875214,-1527.18249512,4.88530493,0.00000000,89.13433838,82.54653931,-1,-1,-1,200.0); //LS-SF ( autocesta, kapija 2)

	CreateDynamicObject(9623,1692.27050781,416.92578125,32.50081635,0.79650879,0.00000000,340.91125488,-1,-1,-1,200.0); //object(toll_sfw) (1)
	CreateDynamicObject(9623,1709.37207031,411.03808594,32.50081635,0.79650879,0.00000000,340.91125488,-1,-1,-1,200.0); //object(toll_sfw) (2)
	CreateDynamicObject(1290,1703.70800781,423.16210938,36.12253571,0.00000000,0.00000000,342.51525879,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,1697.68176270,405.27697754,36.12253571,0.00000000,0.00000000,342.51525879,-1,-1,-1,200.0); //object(lamppost2) (2)
	CreateDynamicObject(1290,1717.75012207,408.07708740,36.12253571,0.00000000,0.00000000,250.56713867,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,1683.43701172,419.20550537,36.12253571,0.00000000,0.00000000,252.17126465,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1250,1683.56494141,418.35675049,29.74980354,2.40917969,0.00000000,70.43121338,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,1707.79321289,409.80056763,29.74980354,0.00000000,0.00000000,251.25732422,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,1716.73608398,406.92874146,30.05674171,23.28875732,0.00000000,251.25732422,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,1691.94934082,415.50692749,29.90327263,12.84579468,0.00000000,70.42785645,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(9623,107.26734161,-1274.37707520,16.46301651,2.50250244,0.00000000,305.22766113,-1,-1,-1,200.0); //object(toll_sfw) (7)
	CreateDynamicObject(9623,92.80078125,-1253.07519531,16.35984039,1.09863281,0.00000000,303.62365723,-1,-1,-1,200.0); //object(toll_sfw) (7)
	CreateDynamicObject(1290,85.38629150,-1257.18713379,16.66617203,0.00000000,0.00000000,304.52868652,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,99.67985535,-1247.79956055,16.66617203,0.00000000,0.00000000,304.52453613,-1,-1,-1,200.0); //object(lamppost2) (2)
	CreateDynamicObject(1290,100.02725220,-1278.71215820,16.66617203,0.00000000,0.00000000,304.52453613,-1,-1,-1,200.0); //object(lamppost2) (3)
	CreateDynamicObject(1290,114.17285156,-1268.83642578,16.66617203,0.00000000,0.00000000,304.52453613,-1,-1,-1,200.0); //object(lamppost2) (4)
	CreateDynamicObject(1250,86.78854370,-1246.62109375,13.80256653,0.00000000,0.00000000,33.26110840,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,96.03343964,-1260.95251465,13.57236290,0.00000000,0.00000000,214.08508301,-1,-1,-1,200.0); //object(smashbarpost) (2)
	CreateDynamicObject(1250,103.98409271,-1266.05395508,13.80256653,0.00000000,0.00000000,33.25561523,-1,-1,-1,200.0); //object(smashbarpost) (3)
	CreateDynamicObject(1250,113.46492004,-1280.29626465,13.95603561,0.00000000,0.00000000,214.08508301,-1,-1,-1,200.0); //object(smashbarpost) (4)
	CreateDynamicObject(9623,-965.97753906,-332.89361572,37.92106628,0.00000000,0.00000000,168.87603760,-1,-1,-1,200.0); //object(toll_sfw) (2)
	CreateDynamicObject(1290,-963.80029297,-324.58581543,41.68617249,0.00000000,0.00000000,349.56005859,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,-967.18914795,-341.65792847,41.68617249,0.00000000,0.00000000,349.55749512,-1,-1,-1,200.0); //object(lamppost2) (2)
	CreateDynamicObject(997,-978.93652344,-330.96963501,35.71093750,0.00000000,0.00000000,351.96923828,-1,-1,-1,200.0); //object(lhouse_barrier3) (1)
	CreateDynamicObject(997,-956.79534912,-335.58956909,35.71093750,0.00000000,0.00000000,351.96899414,-1,-1,-1,200.0); //object(lhouse_barrier3) (2)
	CreateDynamicObject(1237,-955.50927734,-334.81741333,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (1)
	CreateDynamicObject(1237,-955.84460449,-336.39328003,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (2)
	CreateDynamicObject(1237,-976.38635254,-332.00558472,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (3)
	CreateDynamicObject(1237,-976.16845703,-330.98297119,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (4)
	CreateDynamicObject(1237,-976.90588379,-330.77154541,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (5)
	CreateDynamicObject(1237,-977.21624756,-331.85247803,35.78708649,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (6)
	CreateDynamicObject(1250,-974.53509521,-333.49548340,35.21590805,0.00000000,0.00000000,78.57464600,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,-956.96301270,-332.30212402,35.29264450,0.00000000,0.00000000,258.60046387,-1,-1,-1,200.0); //object(smashbarpost) (2)
	CreateDynamicObject(9623,520.40234375,473.51855469,20.72397232,0.00000000,0.00000000,34.86511230,-1,-1,-1,200.0); //object(toll_sfw) (1)
	CreateDynamicObject(3330,512.12365723,468.07861328,7.84987926,0.00000000,0.00000000,304.52856445,-1,-1,-1,200.0); //object(cxrf_brigleg) (1)
	CreateDynamicObject(3330,527.95208740,479.02966309,7.84987926,0.00000000,0.00000000,304.52453613,-1,-1,-1,200.0); //object(cxrf_brigleg) (2)
	CreateDynamicObject(1290,524.90960693,465.99395752,20.55908203,0.00000000,0.00000000,35.67352295,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,514.84765625,480.34570312,20.55908203,0.00000000,0.00000000,35.66711426,-1,-1,-1,200.0); //object(lamppost2) (2)
	CreateDynamicObject(1250,514.24523926,467.41043091,18.23543549,0.00000000,0.00000000,127.62161255,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,526.40948486,478.37130737,18.38890457,0.00000000,0.00000000,306.93334961,-1,-1,-1,200.0); //object(smashbarpost) (2)
	CreateDynamicObject(1250,526.40722656,478.47961426,18.38890457,0.00000000,0.00000000,306.93054199,-1,-1,-1,200.0); //object(smashbarpost) (3)
	CreateDynamicObject(9623,-178.21191406,327.30761719,13.87241077,0.00000000,0.00000000,344.92675781,-1,-1,-1,200.0); //object(toll_sfw) (1)
	CreateDynamicObject(3330,-187.72065735,329.91174316,0.96378177,0.00000000,0.00000000,74.55929565,-1,-1,-1,200.0); //object(cxrf_brigleg) (1)
	CreateDynamicObject(3330,-169.02183533,325.17526245,0.88357770,0.00000000,0.00000000,74.55551147,-1,-1,-1,200.0); //object(cxrf_brigleg) (2)
	CreateDynamicObject(1290,-180.91593933,319.05368042,13.11486435,0.00000000,0.00000000,344.12438965,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,-176.46441650,336.04629517,13.11486435,0.00000000,0.00000000,344.11926270,-1,-1,-1,200.0); //object(lamppost2) (3)
	CreateDynamicObject(1250,-186.76553345,328.19100952,11.39191437,0.00000000,0.00000000,76.16543579,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,-170.30099487,326.64022827,11.39191437,0.00000000,0.00000000,254.67565918,-1,-1,-1,200.0); //object(smashbarpost) (2)
    CreateDynamicObject(3749,-94.43416595,-931.51208496,24.44122314,356.78775024,0.00000000,333.06735229,-1,-1,-1,200.0); //object(clubgate01_lax) (2)
	CreateDynamicObject(1250,-89.19935608,-935.38507080,19.08649063,0.00000000,0.00000000,244.23876953,-1,-1,-1,200.0); //object(smashbarpost) (1)
	CreateDynamicObject(1250,-100.25528717,-928.97064209,19.16322517,0.00000000,0.00000000,61.85409546,-1,-1,-1,200.0); //object(smashbarpost) (2)
	CreateDynamicObject(8168,-83.00942993,-937.70587158,21.16079140,0.00000000,0.00000000,347.33679199,-1,-1,-1,200.0); //object(vgs_guardhouse01) (2)
	CreateDynamicObject(8169,-82.94238281,-937.64550781,19.42057037,359.99407959,180.00000000,134.40798950,-1,-1,-1,200.0); //object(vgs_guardhseflr) (2)
	CreateDynamicObject(8169,-82.97048950,-937.71783447,19.44302177,0.00000000,0.00000000,347.33276367,-1,-1,-1,200.0); //object(vgs_guardhseflr) (4)
	CreateDynamicObject(10244,-85.63011169,-940.80798340,14.48068619,0.00000000,182.84686279,245.84490967,-1,-1,-1,200.0); //object(vicjump_sfe) (1)
	CreateDynamicObject(10244,-83.02670288,-942.35339355,14.48068619,0.00000000,182.84545898,243.43194580,-1,-1,-1,200.0); //object(vicjump_sfe) (2)
	CreateDynamicObject(10244,-85.83060455,-936.75927734,14.48068619,0.00000000,182.83996582,154.60095215,-1,-1,-1,200.0); //object(vicjump_sfe) (3)
	CreateDynamicObject(1472,-79.93952942,-938.36474609,18.81682587,0.00000000,0.00000000,61.80313110,-1,-1,-1,200.0); //object(dyn_porch_1) (1)
    CreateDynamicObject(8168,57.20381546,-1532.36120605,6.18163538,0.00000000,0.00000000,7.88525391,-1,-1,-1,200.0); //object(vgs_guardhouse01) (1)
	CreateDynamicObject(966,59.75226974,-1538.00561523,4.03877401,0.00000000,0.00000000,84.01031494,-1,-1,-1,200.0); //object(bar_gatebar01) (1)
	CreateDynamicObject(966,55.00196838,-1527.05871582,4.03877401,0.00000000,0.00000000,262.51879883,-1,-1,-1,200.0); //object(bar_gatebar01) (2)
	CreateDynamicObject(1290,59.90882874,-1535.55786133,9.51003265,0.00000000,0.00000000,260.11413574,-1,-1,-1,200.0); //object(lamppost2) (1)
	CreateDynamicObject(1290,54.12599564,-1529.22912598,9.58676720,0.00000000,0.00000000,260.11230469,-1,-1,-1,200.0); //object(lamppost2) (2)
	CreateDynamicObject(1237,59.80136108,-1537.25476074,4.05225134,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (1)
	CreateDynamicObject(1237,59.85860443,-1536.25732422,4.05225134,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (2)
	CreateDynamicObject(1237,54.49098969,-1528.57360840,4.05225134,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (3)
	CreateDynamicObject(1237,54.55532837,-1527.65478516,4.05225134,0.00000000,0.00000000,0.00000000,-1,-1,-1,200.0); //object(strtbarrier01) (4)
	CreateDynamicObject(970,56.56003571,-1544.83984375,5.32388496,0.00000000,0.00000000,352.77233887,-1,-1,-1,200.0); //object(fencesmallb) (1)
	CreateDynamicObject(970,57.99153900,-1520.27770996,5.32388496,0.00000000,0.00000000,352.77099609,-1,-1,-1,200.0); //object(fencesmallb) (2)
	return 1;
}

timer TollRampClose[7000](tollid)
{
	switch(tollid)
	{
		case 1: SetDynamicObjectRot(Toll[1],359.99865723,90.09484863,342.51824951);
		case 2: SetDynamicObjectRot(Toll[2],359.99450684,90.09338379,342.51525879);
		case 3: SetDynamicObjectRot(Toll[3],359.99450684,90.09338379,160.31793213);
		case 4: SetDynamicObjectRot(Toll[4],359.98901367,90.09338379,160.31250000);
		case 5: SetDynamicObjectRot(Toll[5],0.00000000,269.24929810,303.62915039);
		case 6: SetDynamicObjectRot(Toll[6],0.00000000,270.05493164,125.26062012);
		case 7: SetDynamicObjectRot(Toll[7],0.00000000,269.24743652,303.62365723);
		case 8: SetDynamicObjectRot(Toll[8],0.00000000,270.05493164,125.25512695);
		case 9: SetDynamicObjectRot(Toll[9],0.00000000,89.81762695,351.16613770);
		case 10: SetDynamicObjectRot(Toll[10],0.00000000,89.81323242,164.85620117);
		case 11: SetDynamicObjectRot(Toll[11],0.00000000,89.90936279,33.35720825);
		case 12: SetDynamicObjectRot(Toll[12],0.00000000,89.90722656,217.39634705);
		case 13: SetDynamicObjectRot(Toll[13],0.00000000,90.09484863,348.04675293);
		case 14: SetDynamicObjectRot(Toll[14],0.00000000,90.09338379,165.65856934);
		case 15: SetDynamicObjectRot(Toll[15],0.00000000,89.19689941,331.46118164);
		case 16: SetDynamicObjectRot(Toll[16],0.00000000,89.19250488,153.08990479);
		case 17: SetDynamicObjectRot(Toll[17],0.00000000,89.94403076,264.83972168);
		case 18: SetDynamicObjectRot(Toll[18],0.00000000,89.13433838,82.54653931);
	}
	return 1;	
}

CMD:locktoll(playerid, params[])
{
	new tollid;
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pristup ovoj komandi!");
	if(sscanf(params, "d", tollid))
	{
	    SendClientMessage(playerid, -1, "{AFAFAF}[?]: /locktoll [Toll Booth ID]");
	    SendClientMessage(playerid, -1, "Toll Booths: {BFC0C2}1) LS-LV Highway | 2) LS-SF Tunnel | 3) LS-SF Airport | 4) LS-LV Bridge");
	    SendClientMessage(playerid, -1, "{BFC0C2} | 5) LS-LV Optional pass | 6) LS-SF Heavy pass | 7) LS-SF Highway | 8) Lock All | 9) Unlock All");
	    return 1;
	}
	new LTStr[256];
	if(tollid == 1)
	{
	    if(LockToll[0] == 0)
	    {
	        LockToll[0] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-LV Highway.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[0] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-LV Highway.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 2)
	{
	    if(LockToll[1] == 0)
	    {
	        LockToll[1] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-SF Tunnel.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[1] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-SF Tunnel.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 3)
	{
	    if(LockToll[2] == 0)
	    {
	        LockToll[2] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-SF Airport.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[2] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-SF Airport.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 4)
	{
	    if(LockToll[3] == 0)
	    {
	        LockToll[3] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-LV Bridge.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[3] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-LV Bridge.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 5)
	{
	    if(LockToll[4] == 0)
	    {
	        LockToll[4] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-LV Optional pass.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[4] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-LV Optional pass.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(5, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 6)
	{
	    if(LockToll[5] == 0)
	    {
	        LockToll[5] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-SF Heavy pass.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[5] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-SF Heavy pass.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 7)
	{
	    if(LockToll[6] == 0)
	    {
	        LockToll[6] = 1;
	        format(LTStr, sizeof(LTStr), "* %s je zakljucao naplatnu kucicu LS-SF Highway.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	    else
	    {
	        LockToll[6] = 0;
	        format(LTStr, sizeof(LTStr), "* %s je otkljucao naplatnu kucicu LS-SF Highway.", GetName(playerid, false));
			SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
			SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	    }
	}
	else if(tollid == 8)
	{
        for(new i = 0; i < MAX_LOCKABLE_BOOTHS; i++)
		{
			LockToll[i] = 1;
		}
        format(LTStr, sizeof(LTStr), "* %s je zakljucao sve naplatne kucice.", GetName(playerid, false));
		SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
		SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	}
	else if(tollid == 9)
	{
		for(new i = 0; i < MAX_LOCKABLE_BOOTHS; i++)
		{
			LockToll[i] = 0;
		}
        format(LTStr, sizeof(LTStr), "* %s je otkljucao sve naplatne kucice.", GetName(playerid, false));
		SendRadioMessage(1, TEAM_BLUE_COLOR, LTStr);
		SendRadioMessage(3, TEAM_BLUE_COLOR, LTStr);
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznat ID naplatne kucice!");
	return 1;
}

CMD:atoll(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) 
	 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new 
		lock;
	if(sscanf(params, "d", lock))
	{
	    SendClientMessage(playerid, COLOR_RED, "[?]: /atool [Lock ID]");
	    SendClientMessage(playerid, -1, "Lock ID 0 - Unlock all || Lock ID 1 - Lock all");
	    return 1;
	}
	if(lock < 0 || lock > 1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznat ID naplatne kucice!");

	for(new i = 0; i < MAX_LOCKABLE_BOOTHS; i++)
		LockToll[i] = lock;

	SendAdminMessage(COLOR_RED, 
		"Game Admin %s %s all tool booths.", 
		GetName(playerid, false),
		(!lock) ? ("unlocked") : ("locked")
	);
	return 1;
}

CMD:opentoll(playerid, params[])
{
    if(AC_GetPlayerMoney(playerid) < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca!");
	new CmdString[128];
	if(IsPlayerInRangeOfPoint(playerid,8.0,1686.7776,416.7574,30.6589)) 
	{ //LS-LV AUTOCESTA
	    if(LockToll[0] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[1],0.00000,0.00000,90.00000);
		PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(1);
    }
    else if(IsPlayerInRangeOfPoint(playerid,8.0,1695.4078,413.8618,30.6586)) 
	{ //LS-LV AUTOCESTA
	    if(LockToll[0] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
        format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[2],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(2);
	}
	else if(IsPlayerInRangeOfPoint(playerid,8.0,1704.0769,410.8775,30.6571)) 
	{ //LS-LV AUTOCESTA
	    if(LockToll[0] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	    format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[3],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(3);
    }
    else if(IsPlayerInRangeOfPoint(playerid,8.0,1712.8297,408.0382,30.6583)) 
	{ //LS-LV AUTOCESTA
	    if(LockToll[0] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
   		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[4],0.00000,0.00000,90.00000);
		PlayerToBudgetMoney(playerid, 5);
        defer TollRampClose(4);
	}
	else if(IsPlayerInRangeOfPoint(playerid,8.0,110.3566,-1276.0198,14.7506)) 
	{ //LS-SF TUNEL
	    if(LockToll[1] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[5],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(5);
   	}
   	else if(IsPlayerInRangeOfPoint(playerid,8.0,106.1063,-1270.3074,14.7200)) 
	{ //LS-SF TUNEL
	    if(LockToll[1] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
   		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[6],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(6);
   	}
   	else if(IsPlayerInRangeOfPoint(playerid,8.0,94.2225,-1257.2662,14.5936)) 
	{ //LS-SF TUNEL
	    if(LockToll[1] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
   		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[7],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(7);
   	}
   	else if(IsPlayerInRangeOfPoint(playerid,8.0,89.3355,-1249.4337,14.5565)) 
	{ //LS-SF TUNEL
	    if(LockToll[1] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
   		format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[8],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
      	defer TollRampClose(8);
   	}
   	else if(IsPlayerInRangeOfPoint(playerid,8.0,-970.5789,-333.8476,36.4137)) 
	{ //LS-SF POKRAJ SF AIRPORTA
	    if(LockToll[2] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[9],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(9);
   	}
   	else if(IsPlayerInRangeOfPoint(playerid,8.0,-960.5711,-331.6124,36.1348)) 
	{ //LS-SF POKRAJ SF AIRPORTA
	    if(LockToll[2] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[10],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(10);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,517.2881,469.6673,18.9297)) 
	{ //LS-LV POKRAJ MOSTA
	    if(LockToll[3] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[11],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(11);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,523.5944,475.9694,18.9297)) 
	{ //LS-LV POKRAJ MOSTA
	    if(LockToll[3] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[12],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(12);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,-183.2823,327.6223,12.0781)) { //LS-LV IZMEDJU OVIH PRIJASNJIH Toll
	    if(LockToll[4] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[13],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(13);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,-174.1768,327.4136,12.0781)) 
	{ //LS-LV IZMEDJU OVIH PRIJASNJIH Toll
	    if(LockToll[4] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[14],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(14);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,-101.02379608,-928.78637695,19.78243637)) 
	{ //LS-SF/prolaz za kombajn
	    if(LockToll[5] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[15],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(15);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,-88.61416626,-935.47473145,19.78243637)) 
	{ //LS-SF/prolaz za kombajn
	    if(LockToll[5] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[16],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(16);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,59.0846,-1540.9741,5.0938)) 
	{ //LS-SF AUTOCESTA
	    if(LockToll[6] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[17],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(17);
 	}
 	else if(IsPlayerInRangeOfPoint(playerid,8.0,55.8233,-1523.6588,5.0027)) 
	{ //LS-SF AUTOCESTA
	    if(LockToll[6] == 1) return SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Ova naplatna kucica je zakljucana.");
	   	format(CmdString, 128, "* %s vadi novac i daje Toll Guardu.", GetName(playerid, true));
		ProxDetector(10.0, playerid, CmdString, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
       	SendClientMessage(playerid, COLOR_RED, "Toll Guard kaze: Sretan put.");
       	SetDynamicObjectRot(Toll[18],0.00000,0.00000,90.00000);
       	PlayerToBudgetMoney(playerid, 5);
       	defer TollRampClose(18);
 	}
 	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu naplatne rampe.");
    return 1;
}
