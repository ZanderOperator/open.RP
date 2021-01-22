#include <YSI_Coding\y_hooks>

/*
	######## ##    ## ##     ## ##     ##  ######
	##       ###   ## ##     ## ###   ### ##    ##
	##       ####  ## ##     ## #### #### ##
	######   ## ## ## ##     ## ## ### ##  ######
	##       ##  #### ##     ## ##     ##       ##
	##       ##   ### ##     ## ##     ## ##    ##
	######## ##    ##  #######  ##     ##  ######
*/

enum E_PLAYER_COMBINE_INFO
{
 	cWork,
 	cPlant[90],
 	cPlantNumber,
 	Timer:cTimer,
 	cHarvested,
 	cZone,
 	cCP
};
new CombineInfo[MAX_PLAYERS][E_PLAYER_COMBINE_INFO];

enum E_PLAYER_MILK_INFO
{
	mEmptyBucket,
	mFullBucket,
	mMilking,
	mTransfering,
	mCanister,
	mStorageCP,
	mTransportCP,
	mStorageCanister,
	mTransporting,
	mFactoryCP,
	mLiters
};
new MilkInfo[MAX_PLAYERS][E_PLAYER_MILK_INFO];

enum E_TRUCK_INFO
{
	t1Object[20],
	Float:tXOffes,
	Float:tYOffes,
	Float:tZOffes,
	tLimit,
	tLiters,
	tEggsNumber,
	tCropNumber
};
new TruckInfo[MAX_PLAYERS][E_TRUCK_INFO];

enum E_PLAYER_SEED_INFO
{
	sSeeds,
	sTrailerSeeds,
	sWork,
	sZone,
	sPlant[50],
	sPlantsNumber,
	sSpade,
	sHarvesting,
	sHarvestPlant,
	sHarvested,
	sStored,
	sTransportCP,
	sTransporting,
	sFactoryCP,
	sStorageCrops
 };
new SeedInfo[MAX_PLAYERS][E_PLAYER_SEED_INFO];

enum E_PLAYER_EGGS_INFO
{
	eEmptyCarton,
	eFullCarton,
	eEggs,
	eCollecting,
	eProcessing,
	eProcessed,
	eStorageCP,
	eTransportCP,
	eTransporting,
	eFactoryCP,
	eStorageCarton
};
new EggInfo[MAX_PLAYERS][E_PLAYER_EGGS_INFO];

/*
    ########  #######  ########  ##      ##    ###    ########  ########   ######
	##       ##     ## ##     ## ##  ##  ##   ## ##   ##     ## ##     ## ##    ##
	##       ##     ## ##     ## ##  ##  ##  ##   ##  ##     ## ##     ## ##
	######   ##     ## ########  ##  ##  ## ##     ## ########  ##     ##  ######
	##       ##     ## ##   ##   ##  ##  ## ######### ##   ##   ##     ##       ##
	##       ##     ## ##    ##  ##  ##  ## ##     ## ##    ##  ##     ## ##    ##
	##        #######  ##     ##  ###  ###  ##     ## ##     ## ########   ######
*/

//*****SA-MP CALLBACKS*****

hook OnGameModeInit()
{	
	//--------3d Tekstovi--------
	CreateDynamic3DTextLabel("Kante", -1, -79.5052, -82.1840, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Kanisteri", -1, -85.3304, -38.0246, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Sjemenke", -1, -96.7375, -39.4615, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Lopate", -1, -69.2246, 42.0311, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Kutije", -1, -56.1417, 47.6496, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Procesiranje jaja", -1, -132.3292 , -99.2501, 3.6172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("Spremiste", -1, -9.4406, 54.8088, 3.1172, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);

	//--------Objekti--------
	//KRAVE
	CreateDynamicObject(16442, -95.8766, -102.4241, 3.5000, 0, 0, 116.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(16442, -92.9274, -97.4952, 3.5000, 0, 0, 342.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(16442, -82.8393, -99.4222, 3.5000, 0, 0, -149.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(16442, -86.4812, -105.1304, 3.5000, 0, 0, 156.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(16442, -75.9674, -107.8656, 3.5000, 0, 0, 37.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(16442, -72.8941, -99.8919, 3.5000, 0, 0, -78.0, -1, -1, -1, 200.0, 0.0);
	//KUCICE ZA KOKOSI
	CreateDynamicObject(1451, -70.1010, 54.4408, 2.9000, 0, 0, 340.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(1451, -76.9046, 56.6308, 2.9000, 0, 0, 340.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(1451, -74.8616, 52.6856, 2.9000, 0, 0, 340.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(1451, -71.7300, 47.8216, 2.9000, 0, 0, 340.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(1451, -80.5432, 51.4941, 2.9000, 0, 0, 340.0, -1, -1, -1, 200.0, 0.0);
    //GENERATOR
    CreateDynamicObject(929, -131.7085,-100.2917, 3.0000, 0, 0, 80.0, -1, -1, -1, 200.0, 0.0);
	//KANTE
	CreateDynamicObject(19468, -77.7476, -80.4175, 2.2000, 0, 0, 170.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(19468, -80.7825, -83.4430, 2.2000, 0, 0, 180.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(19468, -81.4706, -83.6137, 2.2000, 0, 0, 190.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(19468, -80.7080, -82.8691, 2.2000, 0, 0, 2000.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(19468, -80.0737, -83.0128, 2.2000, 0, 0, 270.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(19468, -81.2081, -84.2206, 2.2000, 0, 0, 280.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(19468, -78.5285, -81.1139, 2.2000, 0, 0, 290.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(19468, -77.7282, -80.9851, 2.2000, 0, 0, 3000.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(19468, -77.0876, -80.1790, 2.2000, 0, 0, 0.0, -1, -1, -1, 200.0, 0.0);
	//KANISTERI
	CreateDynamicObject(918, -84.2253, -38.5844, 2.5000, 0, 0, 165.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(918, -84.4457, -39.1359, 2.5000, 0, 0, 65.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(918, -84.4779, -37.7374, 2.5000, 0, 0, 265.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(918, -83.8218, -37.6795, 2.5000, 0, 0, 0.0, -1, -1, -1, 200.0, 0.0);
	//KUTIJE SA SJEMENKAMA
	CreateDynamicObject(2912, -97.6201, -38.9144, 2.2000, 0, 0, 75.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2912, -98.2444, -39.9802, 2.2000, 0, 0, 123.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2912, -96.9889, -40.6289, 2.2000, 0, 0, 321.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2912, -98.8100, -41.5214, 2.2000, 0, 0, 69.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2912, -97.4148, -37.4085, 2.2000, 0, 0, 222.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2912, -95.8708, -37.1358, 2.2000, 0, 0, 0.0, -1, -1, -1, 200.0, 0.0);
	//LOPATE
	CreateDynamicObject(2228, -70.6864, 41.8743, 2.6000, 0, 0, 360.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2228, -70.0176, 43.2546, 2.6000, 0, 0, 111.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2228, -68.9946, 42.7535, 2.6000, 0, 0, 34.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2228, -70.2072, 41.6171, 2.6000, 0, 0, 189.0, -1, -1, -1, 200.0, 0.0);
	CreateDynamicObject(2228, -69.7582, 42.3486, 2.6000, 0, 0, 222.0, -1, -1, -1, 200.0, 0.0);
	//KUTIJE ZA JAJA
	CreateDynamicObject(2358, -55.4488, 46.0262, 2.2000, 0, 0, 157.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(2358, -56.5167, 46.3694, 2.2000, 0, 0, 77.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(2358, -55.1163, 47.2890, 2.2000, 0, 0, 236.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(2358, -54.6426, 48.6712, 2.2000, 0, 0, 124.0, -1, -1, -1, 200.0, 0.0);
    CreateDynamicObject(2358, -56.0056, 48.9775, 2.2000, 0, 0, 333.0, -1, -1, -1, 200.0, 0.0);
	
	// Prikolice za sjemenke
	AddStaticVehicleEx(610, -82.0967, -22.8492, 3.1172, 80.0, 0, 0, 1800);
    AddStaticVehicleEx(610, -80.4207, -19.5172, 3.1172, 80.0, 0, 0, 180);
    AddStaticVehicleEx(610, -78.9581, -16.0699, 3.1172, 80.0, 0, 0, 180);
    AddStaticVehicleEx(610, -72.2348, 0.0292, 3.1172, 80.0, 0, 0, 180);
    AddStaticVehicleEx(610, -69.6873, 5.4156, 3.1172, 80.0, 0, 0, 180);
	
	return 1;
}		

hook OnPlayerDisconnect(playerid, reason)
{
	for( new i=0; i < 90; i++) {
		if(IsValidDynamicObject(CombineInfo[playerid][cPlant][i]))
			DestroyDynamicObject(CombineInfo[playerid][cPlant][i]);
	}
	if(CombineInfo[playerid][cWork])
		stop CombineInfo[playerid][cTimer];
		
	if(IsValidDynamicArea(CombineInfo[playerid][cZone]))
		DestroyDynamicArea(CombineInfo[playerid][cZone]);
		
	if(CombineInfo[playerid][cCP] == 1)
		CombineInfo[playerid][cCP] = 0;
	
	DisablePlayerCheckpoint(playerid);	
		
	CombineInfo[playerid][cPlantNumber] = 0;
	CombineInfo[playerid][cWork] = 0;

	for( new i=0; i < 90; i++) {
		if(IsValidDynamicObject(CombineInfo[playerid][cPlant][i]))
			DestroyDynamicObject(CombineInfo[playerid][cPlant][i]);
	}
	Player_SetIsWorkingJob(playerid, false);
	DestroyFarmerObjects(playerid);
	ResetFarmerVars(playerid);
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if(MilkInfo[playerid][mStorageCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /milk store kako bi spremio mlijeko u spremiste", 9000, 3);
	}
	if(MilkInfo[playerid][mTransportCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /milk take kako bi uzeo mlijko iz spremista", 9000, 3);
	}
	if(MilkInfo[playerid][mFactoryCP] == 1) 
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /milk sell kako bi prodao mlijeko", 9000, 3);
	}
	if(SeedInfo[playerid][sTransportCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /crops take kako bi uzeo vrecu s usjevom iz spremista", 9000, 3);
	}
	if(SeedInfo[playerid][sFactoryCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /crops sell kako bi prodao usjeve", 9000, 3);
	}
	if(EggInfo[playerid][eStorageCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /eggs take kako bi uzeo kutiju s jajima iz spremista", 9000, 3);
	}
	if(EggInfo[playerid][eTransportCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /eggs take kako bi uzeo kutiju s jajima iz spremista", 9000, 3);
	} 
	if(EggInfo[playerid][eFactoryCP] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "Koristi /eggs sell kako bi prodao jaja", 9000, 3);
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(( newkeys & KEY_FIRE) && !( oldkeys & KEY_FIRE)) 
	{
		if(SeedInfo[playerid][sWork]) 
		{
			if(IsPlayerInAnyVehicle(playerid)) 
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 531) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u traktoru!");
				if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Traktor nema prikolicu!");
				if(!IsPlayerInDynamicArea(playerid, SeedInfo[playerid][sZone], 0)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u podrucju za sadenje!");
				if(!SeedInfo[playerid][sTrailerSeeds]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sjemenki u prikolici!");
				
				new
					Float:X, Float:Y, Float:Z;
				if(SeedInfo[playerid][sPlantsNumber]) {
					GetDynamicObjectPos(SeedInfo[playerid][sPlant][SeedInfo[playerid][sPlantsNumber]-1], X, Y, Z);
					if(GetVehicleDistanceFromPoint(GetPlayerVehicleID(playerid), X, Y, Z) <= 15.0)
					return 1;
				}

				GetVehiclePos(GetVehicleTrailer(GetPlayerVehicleID(playerid)), X, Y, Z);
				SeedInfo[playerid][sPlant][SeedInfo[playerid][sPlantsNumber]] = CreateDynamicObject(826, X, Y, Z-2.0, 0, 0, 0, -1, -1, playerid, 50.0, 0.0);
				MoveDynamicObject(SeedInfo[playerid][sPlant][SeedInfo[playerid][sPlantsNumber]], X, Y, Z, 0.012, -1000.0, -1000.0, -1000.0);
				
				SeedInfo[playerid][sPlantsNumber]++;
				SeedInfo[playerid][sTrailerSeeds]--;
				
				if(!SeedInfo[playerid][sTrailerSeeds]) {
					if(IsValidDynamicArea(SeedInfo[playerid][sZone]))
						DestroyDynamicArea(SeedInfo[playerid][sZone]);
						
					SeedInfo[playerid][sWork] = 0;
					SendMessage(playerid, MESSAGE_TYPE_INFO, "Istrosili ste sve sjemenke u prikolici!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Odite do lopata, te upisite /takespade kako bi uzeli lopatu za usjeve.");
				}
			}
		}
	}

	return 1;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	if(areaid == CombineInfo[playerid][cZone]) 
	{
		if(CombineInfo[playerid][cWork]) 
		{
		    if(IsPlayerInAnyVehicle(playerid)) 
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 532) 
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kombajnu!");
				CombineInfo[playerid][cTimer] = repeat CombineCheck(playerid);
			}
		}
	}
	
	return 1;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	if(areaid == CombineInfo[playerid][cZone]) 
	{
		if(CombineInfo[playerid][cWork] && CombineInfo[playerid][cPlantNumber] > 0) 
		{
			stop CombineInfo[playerid][cTimer];
			if(IsValidDynamicArea(CombineInfo[playerid][cZone]))
			    DestroyDynamicArea(CombineInfo[playerid][cZone]);
				
			if(CombineInfo[playerid][cCP] == 1)
				CombineInfo[playerid][cCP] = 0;
			
			DisablePlayerCheckpoint(playerid);	
			    
	    	CombineInfo[playerid][cPlantNumber] = 0;
	    	CombineInfo[playerid][cWork] = 0;

			for( new i=0; i < 90; i++) {
			    if(IsValidDynamicObject(CombineInfo[playerid][cPlant][i]))
	        		DestroyDynamicObject(CombineInfo[playerid][cPlant][i]);
			}
			Player_SetIsWorkingJob(playerid, false);
	    	SendClientMessage(playerid, COLOR_RED, "[!] Izasli ste iz podrucja te ste automatski prestali raditi posao.");
			DestroyFarmerObjects(playerid);
			ResetFarmerVars(playerid);
		}
	}
	return 1;
}

hook OnPlayerKeyInputEnds(playerid, type, succeeded)
{
	if(!succeeded) return 1;
	new 
		string[50];
	if(type == 4) {
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		EggInfo[playerid][eEggs] = random(3)+1;
		EggInfo[playerid][eFullCarton] = 1;
		EggInfo[playerid][eEmptyCarton] = 0;
		

		if(InputInfo[playerid][piTempScore] == 50)
			EggInfo[playerid][eEggs] = random(4)+7;
		else if(InputInfo[playerid][piTempScore] < 25) {
			EggInfo[playerid][eEggs] = 0;
			EggInfo[playerid][eFullCarton] = 0;
			EggInfo[playerid][eEmptyCarton] = 1;
			DisablePlayerKeyInput(playerid);
			return SendClientMessage(playerid, COLOR_RED, "[!] Niste dobro sakupili jaja, te zbog toga niste dobili nista jaja!");
		}

		format(string, sizeof(string), "[!] Uspjesno ste nabavili %i jaja!", EggInfo[playerid][eEggs]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		SendClientMessage(playerid, COLOR_RED, "[!] Idite do masine, te upisite /eggs process kako bi procesirali jaja.");
		DisablePlayerKeyInput(playerid);
	}
	else if(type == 5) {
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		MilkInfo[playerid][mLiters] = minrand(1, 2);
		MilkInfo[playerid][mEmptyBucket] = 0;
		MilkInfo[playerid][mFullBucket] = 1;
		MilkInfo[playerid][mMilking] = 0;
		
		if(InputInfo[playerid][piTempScore] == 50)
			MilkInfo[playerid][mLiters] = random(2)+4;
		else if(InputInfo[playerid][piTempScore] < 25)
		{
			MilkInfo[playerid][mLiters] = 0;
			MilkInfo[playerid][mEmptyBucket] = 1;
			MilkInfo[playerid][mFullBucket] = 0;
			DisablePlayerKeyInput(playerid);
			return SendClientMessage(playerid, COLOR_RED, "[!] Niste dobro pomuzili kravu, te zbog toga niste dobili nista mlijeka!");
		}
			
		format(string, sizeof(string), "[!] Uspjesno ste nabavili %iL mlijeka!", MilkInfo[playerid][mLiters]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		SendClientMessage(playerid, COLOR_RED, "[!] Odite do kanistera, te kucajte /milk transfer kako bi prelili mlijeko u kanister.");
		DisablePlayerKeyInput(playerid);
	}
    return 1;
}

//*****CUSTOM CALLBACKS*****

timer CombineCheck[200](playerid)
{
	new 
		Float:X, Float:Y, Float:Z,
		Float:vx, Float:vy, Float:vz,
		string[50];
	
	if(!IsPlayerInAnyVehicle(playerid)) 
	 {
	    stop CombineInfo[playerid][cTimer];
	    if(IsValidDynamicArea(CombineInfo[playerid][cZone]))
	        DestroyDynamicArea(CombineInfo[playerid][cZone]);
	    
	    CombineInfo[playerid][cWork] = 0;
	    for(new i=0;i<90;i++) 
		{
			if(IsValidDynamicObject(CombineInfo[playerid][cPlant][i]))
	        	DestroyDynamicObject(CombineInfo[playerid][cPlant][i]);
		}
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Izasli ste iz vozila te ste automatski prestali raditi posao.");
	}
	if(CombineInfo[playerid][cPlantNumber] == 0) 
	{
		stop CombineInfo[playerid][cTimer];
		if(IsValidDynamicArea(CombineInfo[playerid][cZone]))
			DestroyDynamicArea(CombineInfo[playerid][cZone]);
		
		if(CombineInfo[playerid][cCP] == 1)
			CombineInfo[playerid][cCP] = 0;
		
		DisablePlayerCheckpoint(playerid);
		CombineInfo[playerid][cWork] = 0;
		new Profit = (random(650) + 505) + (GetPlayerSkillLevel(playerid) * 20);
		va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", Profit);
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
		BudgetToPlayerBankMoney(playerid, Profit);
		PaydayInfo[playerid][pPayDayMoney] += Profit;
		PlayerJob[playerid][pFreeWorks] -= 5;
	} else {
		if(IsPlayerInAnyVehicle(playerid)) 
		{
	    	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 532) 
			{
            	GetVehicleVelocity(GetPlayerVehicleID(playerid), vx, vy, vz);
            	if(( floatsqroot( ( ( vx * vx) + ( vy * vy)) + ( vz * vz)) * 181.5) >= 40.0) 
				{
					GameTextForPlayer(playerid, "~r~Vozite Prebrzo!", 500, 6);
					return 1;
				}
				for(new j=0;j<90;j++) {
					GetDynamicObjectPos(CombineInfo[playerid][cPlant][j], X, Y, Z);
	            
	            	if(GetVehicleDistanceFromPoint(GetPlayerVehicleID(playerid), X, Y, Z) <= 4.0) {
						if(IsValidDynamicObject(CombineInfo[playerid][cPlant][j]))
							DestroyDynamicObject(CombineInfo[playerid][cPlant][j]);
							
						CombineInfo[playerid][cPlantNumber] = CombineInfo[playerid][cPlantNumber] - 1;
						CombineInfo[playerid][cHarvested] = CombineInfo[playerid][cHarvested] + 1;
						PlayerPlaySound(playerid, 1056, 0.0, 0.0 , 10.0);
						format(string, sizeof(string), "~w~%i/90", CombineInfo[playerid][cHarvested]);
						return GameTextForPlayer(playerid, string, 400, 1);
					}
				}
			}
		}
	}
	return 1;
}
timer HarvestingSeed[30000](playerid)
{
	new
	    Float:X, Float:Y, Float:Z;
	    
	if(IsValidDynamicObject(SeedInfo[playerid][sPlant][SeedInfo[playerid][sHarvestPlant]]))
		DestroyDynamicObject(SeedInfo[playerid][sPlant][SeedInfo[playerid][sHarvestPlant]]);
		
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	SetPlayerAttachedObject(playerid, 8, 2060, 5, 0.489000, -0.131999, 0.000000, 79.199989, -13.099998, -0.800004, 1.000000, 1.000000, 1.000000);
	SeedInfo[playerid][sHarvested] = 1;
	SeedInfo[playerid][sPlantsNumber]--;
	SeedInfo[playerid][sHarvesting] = 0;
	GetPlayerPos(playerid, X, Y, Z);
	Streamer_UpdateEx(playerid, X, Y, Z, -1, -1);
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste pozeli usjev i stavili ga u vrecu!");
	return SendClientMessage(playerid, COLOR_RED, "[!] Idite do skladista za usjeve, te upisite /crops store kako bi spremili usjeve u skladiste.");
}

timer TransferingMilk[30000](playerid)
{
    RemovePlayerAttachedObject(playerid, 9);
    TogglePlayerControllable(playerid, 1);
	MilkInfo[playerid][mFullBucket] = 0;
	SetPlayerAttachedObject(playerid, 9, 918, 6, 0.000000, 0.201999, -0.160000, -16.400003, 0.000000, -2.400001, 1.000000, 1.000000, 1.000000);
	SetPlayerSpecialAction(playerid, 25);
	MilkInfo[playerid][mCanister] = 1;
	ClearAnimations(playerid);
	MilkInfo[playerid][mTransfering] = 0;
	MilkInfo[playerid][mStorageCP] = 1;
	SetPlayerCheckpoint(playerid, -1.3600, 74.3902, 3.1172, 4.0);
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste prebacili mlijeko u kanister!");
	return SendClientMessage(playerid, COLOR_RED, "[!] Idite do skladista za mlijeko, te upisite /milk store kako bi spremili mlijeko u skladiste.");
}

timer ProcessingEggs[30000](playerid)
{
	new
		EggNumber, GoodEggs, BadEggs,
		string[80];
	
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	EggNumber = EggInfo[playerid][eEggs]+1;
	GoodEggs = random(EggNumber);
	BadEggs = EggInfo[playerid][eEggs]-GoodEggs;
	EggInfo[playerid][eEggs] = GoodEggs;
	EggInfo[playerid][eProcessing] = 0;

	if(!EggInfo[playerid][eEggs]) {
		EggInfo[playerid][eEmptyCarton] = 1;
		EggInfo[playerid][eFullCarton] = 0;
		RemovePlayerAttachedObject(playerid, 8);
		SetPlayerSpecialAction(playerid, 0);
		return SendMessage(playerid, MESSAGE_TYPE_INFO, "Posto niste nabavili nijedno dobro jaje, automatski ste bacili kutiju na pod!");
	}
	EggInfo[playerid][eProcessed] = 1;
	EggInfo[playerid][eStorageCP] = 1;
	SetPlayerCheckpoint(playerid, -79.3684, 90.7796, 3.1172, 4.0);
	format(string, sizeof(string), "[INFO]:Zavrsili ste procesiranje jaja! Od %i jaja, %i je dobro, a %i lose.", EggInfo[playerid][eEggs], GoodEggs, BadEggs);
	SendClientMessage(playerid, COLOR_RED, string);
	return SendClientMessage(playerid, COLOR_RED, "[!] Odite do skladista za jaja, te kucajte /eggs store kako bi spremili jaja u skladiste.");
}

stock ResetFarmerVars(playerid)
{
	CombineInfo[playerid][cWork] = 0;
	CombineInfo[playerid][cPlantNumber] = 0;
	stop CombineInfo[playerid][cTimer];
	CombineInfo[playerid][cHarvested] = 0;
	CombineInfo[playerid][cZone] = 0;
	CombineInfo[playerid][cCP] = 0;
	
	MilkInfo[playerid][mEmptyBucket] = 0;
	MilkInfo[playerid][mFullBucket] = 0;
	MilkInfo[playerid][mMilking] = 0;
	MilkInfo[playerid][mTransfering] = 0;
	MilkInfo[playerid][mCanister] = 0;
	MilkInfo[playerid][mStorageCanister] = 0;
	MilkInfo[playerid][mTransporting] = 0;
	MilkInfo[playerid][mLiters] = 0;
	MilkInfo[playerid][mStorageCP] = 0;
	MilkInfo[playerid][mTransportCP] = 0;
	MilkInfo[playerid][mFactoryCP] = 0;
		
	TruckInfo[playerid][tXOffes] = 0.0;
	TruckInfo[playerid][tYOffes] = 0.0;
	TruckInfo[playerid][tZOffes] = 0.0;
	TruckInfo[playerid][tLimit] = 0;
	TruckInfo[playerid][tLiters] = 0;
	TruckInfo[playerid][tEggsNumber] = 0;
	TruckInfo[playerid][tCropNumber] = 0;
	
	SeedInfo[playerid][sSeeds] = 0;
	SeedInfo[playerid][sTrailerSeeds] = 0;
	SeedInfo[playerid][sWork] = 0;
	SeedInfo[playerid][sZone] = 0;
	SeedInfo[playerid][sPlantsNumber] = 0;
	SeedInfo[playerid][sSpade] = 0;
	SeedInfo[playerid][sHarvesting] = 0;
	SeedInfo[playerid][sHarvestPlant] = 0;
	SeedInfo[playerid][sHarvested] = 0;
	SeedInfo[playerid][sStored] = 0;
	SeedInfo[playerid][sTransporting] = 0;
	SeedInfo[playerid][sStorageCrops] = 0;
	SeedInfo[playerid][sTransportCP] = 0;
	SeedInfo[playerid][sFactoryCP] = 0;
	
	EggInfo[playerid][eEmptyCarton] = 0;
	EggInfo[playerid][eFullCarton] = 0;
	EggInfo[playerid][eEggs] = 0;
	EggInfo[playerid][eCollecting] = 0;
	EggInfo[playerid][eProcessed] = 0;
	EggInfo[playerid][eTransporting] = 0;
	EggInfo[playerid][eStorageCarton] = 0;
	EggInfo[playerid][eStorageCP] = 0;
	EggInfo[playerid][eTransportCP] = 0;
	EggInfo[playerid][eFactoryCP] = 0; 	
	
	DisablePlayerCheckpoint(playerid);
	DisablePlayerKeyInput(playerid);
	return 1;
}

stock DestroyFarmerObjects(playerid)
{
	if(PlayerKeys[playerid][pVehicleKey] != -1) 
	{
		new VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel == 478 || VehicleModel == 543 || VehicleModel == 422) 
		{
			for(new j=0;j<20;j++) {
				if(IsValidDynamicObject(TruckInfo[playerid][t1Object][j]))
					DestroyDynamicObject(TruckInfo[playerid][t1Object][j]);
			}
		}
	}
	return 1;
}
	

/*
	 ######  ##     ## ########   ######
	##    ## ###   ### ##     ## ##    ##
	##       #### #### ##     ## ##
	##       ## ### ## ##     ##  ######
	##       ##     ## ##     ##       ##
	##    ## ##     ## ##     ## ##    ##
	 ######  ##     ## ########   ######
*/

// Kombajn
CMD:work(playerid, params[])
{
	if((PlayerJob[playerid][pJob] != JOB_FARMER)) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(CombineInfo[playerid][cWork]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec radite sa kombajnom!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kombajnu!");
	
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 532) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kombajnu!");
	CombineInfo[playerid][cWork] = 1;
	CombineInfo[playerid][cZone] = CreateDynamicRectangle(-300.0000, -100.0000, -100.0000, 120.0000, -1, -1, playerid);
	CombineInfo[playerid][cPlantNumber] = 90;
	CombineInfo[playerid][cHarvested] 	= 0;

	//1.stupac
	CombineInfo[playerid][cPlant][0] = CreateDynamicObject(855, -129.5597, 57.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][1] = CreateDynamicObject(855, -135.6193, 41.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][2] = CreateDynamicObject(855, -141.9381, 24.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][3] = CreateDynamicObject(855, -148.6467, 7.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][4] = CreateDynamicObject(855, -155.2305, -9.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][5] = CreateDynamicObject(855, -161.8650, -26.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][6] = CreateDynamicObject(855, -168.6589, -44.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][7] = CreateDynamicObject(855, -175.2055, -60.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][8] = CreateDynamicObject(855, -182.8214, -80.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//2.stupac
	CombineInfo[playerid][cPlant][9] = CreateDynamicObject(855, -139.5597, 61.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][10] = CreateDynamicObject(855, -145.6193, 45.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][11] = CreateDynamicObject(855, -151.9381, 28.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][12] = CreateDynamicObject(855, -158.6467, 11.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][13] = CreateDynamicObject(855, -165.2305, -5.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][14] = CreateDynamicObject(855, -171.8650, -22.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][15] = CreateDynamicObject(855, -178.6589, -40.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][16] = CreateDynamicObject(855, -185.2055, -56.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][17] = CreateDynamicObject(855, -192.8214, -76.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//3.stupac
	CombineInfo[playerid][cPlant][18] = CreateDynamicObject(855, -149.5597, 65.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][19] = CreateDynamicObject(855, -155.6193, 49.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][20] = CreateDynamicObject(855, -161.9381, 32.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][21] = CreateDynamicObject(855, -168.6467, 15.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][22] = CreateDynamicObject(855, -175.2305, -1.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][23] = CreateDynamicObject(855, -181.8650, -18.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][24] = CreateDynamicObject(855, -188.6589, -36.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][25] = CreateDynamicObject(855, -195.2055, -52.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][26] = CreateDynamicObject(855, -202.8214, -72.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//4.stupac
	CombineInfo[playerid][cPlant][27] = CreateDynamicObject(855, -159.5597, 69.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][28] = CreateDynamicObject(855, -165.6193, 53.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][29] = CreateDynamicObject(855, -171.9381, 36.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][30] = CreateDynamicObject(855, -178.6467, 19.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][31] = CreateDynamicObject(855, -185.2305, 3.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][32] = CreateDynamicObject(855, -191.8650, -14.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][33] = CreateDynamicObject(855, -198.6589, -32.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][34] = CreateDynamicObject(855, -205.2055, -48.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][35] = CreateDynamicObject(855, -212.8214, -68.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//5.stupac
	CombineInfo[playerid][cPlant][36] = CreateDynamicObject(855, -169.5597, 73.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][37] = CreateDynamicObject(855, -175.6193, 57.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][38] = CreateDynamicObject(855, -181.9381, 40.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][39] = CreateDynamicObject(855, -188.6467, 23.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][40] = CreateDynamicObject(855, -195.2305, 7.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][41] = CreateDynamicObject(855, -201.8650, -10.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][42] = CreateDynamicObject(855, -208.6589, -28.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][43] = CreateDynamicObject(855, -215.2055, -44.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][44] = CreateDynamicObject(855, -222.8214, -64.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//6.stupac
	CombineInfo[playerid][cPlant][45] = CreateDynamicObject(855, -179.5597, 77.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][46] = CreateDynamicObject(855, -185.6193, 61.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][47] = CreateDynamicObject(855, -191.9381, 44.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][48] = CreateDynamicObject(855, -198.6467, 27.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][49] = CreateDynamicObject(855, -205.2305, 11.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][50] = CreateDynamicObject(855, -211.8650, -6.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][51] = CreateDynamicObject(855, -218.6589, -24.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][52] = CreateDynamicObject(855, -225.2055, -40.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][53] = CreateDynamicObject(855, -232.8214, -60.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//7.stupac
	CombineInfo[playerid][cPlant][54] = CreateDynamicObject(855, -189.5597, 81.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][55] = CreateDynamicObject(855, -195.6193, 65.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][56] = CreateDynamicObject(855, -201.9381, 48.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][57] = CreateDynamicObject(855, -208.6467, 31.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][58] = CreateDynamicObject(855, -215.2305, 15.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][59] = CreateDynamicObject(855, -221.8650, -2.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][60] = CreateDynamicObject(855, -228.6589, -20.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][61] = CreateDynamicObject(855, -235.2055, -36.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][62] = CreateDynamicObject(855, -242.8214, -56.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//8.stupac/
	CombineInfo[playerid][cPlant][63] = CreateDynamicObject(855, -199.5597, 85.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][64] = CreateDynamicObject(855, -205.6193, 69.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][65] = CreateDynamicObject(855, -211.9381, 52.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][66] = CreateDynamicObject(855, -218.6467, 35.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][67] = CreateDynamicObject(855, -225.2305, 19.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][68] = CreateDynamicObject(855, -231.8650, 2.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][69] = CreateDynamicObject(855, -238.6589, -16.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][70] = CreateDynamicObject(855, -245.2055, -32.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][71] = CreateDynamicObject(855, -252.8214, -52.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//9.stupac/
	CombineInfo[playerid][cPlant][72] = CreateDynamicObject(855, -209.5597, 89.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][73] = CreateDynamicObject(855, -215.6193, 73.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][74] = CreateDynamicObject(855, -221.9381, 56.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][75] = CreateDynamicObject(855, -228.6467, 39.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][76] = CreateDynamicObject(855, -235.2305, 23.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][77] = CreateDynamicObject(855, -241.8650, 6.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][78] = CreateDynamicObject(855, -248.6589, -12.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][79] = CreateDynamicObject(855, -255.2055, -28.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][80] = CreateDynamicObject(855, -262.8214, -48.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	//10.stupac/
	CombineInfo[playerid][cPlant][81] = CreateDynamicObject(855, -219.5597, 93.2725, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][82] = CreateDynamicObject(855, -225.6193, 77.6574, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][83] = CreateDynamicObject(855, -231.9381, 60.5351, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][84] = CreateDynamicObject(855, -238.6467, 43.5898, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][85] = CreateDynamicObject(855, -245.2305, 27.6065, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][86] = CreateDynamicObject(855, -251.8650, 10.5996, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][87] = CreateDynamicObject(855, -258.6589, -8.0102, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][88] = CreateDynamicObject(855, -265.2055, -24.7004, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);
	CombineInfo[playerid][cPlant][89] = CreateDynamicObject(855, -272.8214, -44.8117, 3.0000, 0, 0, 0, -1, -1, playerid, 1000.0, 0.0);

	SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste rad sa kombajnom!");
	SendClientMessage(playerid, COLOR_RED, "[!] Odite do polja sa zitom, te pocnite sa zetvom usjeva!");
	return 1;
}

// Mlijeko
CMD:takebucket(playerid, params[])
{
    if((PlayerJob[playerid][pJob] != JOB_FARMER)) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -79.5052, -82.1840, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu mjesta za uzimanje kante!");
	if(MilkInfo[playerid][mEmptyBucket] || MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kantu kod sebe!");
	if(MilkInfo[playerid][mCanister] || MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kanister kod sebe! Bacite ga kako bi mogli uzeti kantu!");
	if(SeedInfo[playerid][sSpade]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate lopatu kod sebe! Bacite ju kako bi mogli uzeti kanister!");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
	
	SetPlayerAttachedObject(playerid, 9, 19468, 6, 0.257999, 0.002999, -0.000000, 0.000000, -57.700019, -22.000003, 1.000000, 1.000000, 1.000000);
	MilkInfo[playerid][mEmptyBucket] = 1;
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste kantu!");
	return SendClientMessage(playerid, COLOR_RED, "[!] Idite do krave, te kucajte /milk milking da bi zapoceli sa muzenjem krave.");
}

CMD:dropbucket(playerid, params[])
{
	if(!MilkInfo[playerid][mEmptyBucket] && !MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kantu kod sebe!");
	if(MilkInfo[playerid][mMilking] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZete baciti kantu dok muzete kravu!");
	if(MilkInfo[playerid][mTransfering]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZete baciti kantu dok prelijevate mlijeko!");
	RemovePlayerAttachedObject(playerid, 9);
	MilkInfo[playerid][mEmptyBucket] = 0;
	MilkInfo[playerid][mFullBucket] = 0;
	return SendClientMessage(playerid, COLOR_RED, "Bacili ste kantu na pod.");
}

CMD:milk(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(!MilkInfo[playerid][mTransporting] && IsPlayerInAnyVehicle(playerid))	 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
	
	new
		param[9];
	if(sscanf( params, "s[9] ", param)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /milk [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: milking - transfer - store - take - put - check - sell - stop");
		return 1;
	}
	if(!strcmp(param, "milking", true)) {
		
		if(!MilkInfo[playerid][mEmptyBucket] && !MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kantu pri sebi!");
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, -95.8766, -102.4241, 3.5000) && !IsPlayerInRangeOfPoint(playerid, 2.0, -92.9274, -97.4952, 3.5000) && !IsPlayerInRangeOfPoint(playerid, 2.0, -82.8393, -99.4222, 3.5000) && !IsPlayerInRangeOfPoint(playerid, 2.0, -86.4812, -105.1304, 3.5000) && !IsPlayerInRangeOfPoint(playerid, 2.0, -75.9674, -107.8656, 3.5000) && !IsPlayerInRangeOfPoint(playerid, 2.0, -72.8941, -99.8919, 3.5000)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu krave!");
		if(MilkInfo[playerid][mFullBucket]) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kantu punu mlijeka kod sebe!");
		if(!MilkInfo[playerid][mTransporting] && IsPlayerInAnyVehicle(playerid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
		if(MilkInfo[playerid][mMilking] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec muzete kravu!");

		MilkInfo[playerid][mMilking] = 1;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 300000, 0);
		SetPlayerKeyInput(playerid, 50, 1900, 180, 5);
		Player_SetIsWorkingJob(playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste sa muznjom krave!");
		SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa muznjom, kucajte /milk stop da bi prestali muziti kravu.");
	}
	else if(!strcmp(param, "transfer", true)) {
		if(MilkInfo[playerid][mTransfering]) { 
			MilkInfo[playerid][mTransfering] = 0;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
			Player_SetIsWorkingJob(playerid, false);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Prekinuli ste sa prijenos mlijeka u kanister.");
			return 1;
		}
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!IsPlayerInRangeOfPoint(playerid, 1.0, -85.3304, -38.0246, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu kanistera!");
		if(!MilkInfo[playerid][mEmptyBucket] && !MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kantu pri sebi!");
		if(MilkInfo[playerid][mEmptyBucket]) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate mlijeka u kanti za preliti u kanister!");
		if(MilkInfo[playerid][mTransfering]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec prijenosite mlijeko iz kante u karnister!");
		
		MilkInfo[playerid][mTransfering] = 1;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 30000, 0);
		defer TransferingMilk(playerid);
		Player_SetIsWorkingJob(playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste prijenos mlijeka iz kante u kanister! Pricekajte dok se ne zavrsi proces.");
		return SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa prelijevanjem, upisite /milk transfer da bi prestali prijenos mlijeka u kanister.");
	}
	else if(!strcmp(param, "store", true)) 
	{
		if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, -1.3600, 74.3902, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
		if(MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo prelite mlijeko u kanister!");
		if(!MilkInfo[playerid][mCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kanister sa mlijekom kod sebe!");
		if(MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemozete spremiti taj kanister s mlijekom!");
		if(MilkInfo[playerid][mStorageCP])
		{
			MilkInfo[playerid][mStorageCP] = 0;
			DisablePlayerCheckpoint(playerid);
		}
		MilkInfo[playerid][mCanister] = 0;
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, 0);
		new moneys = (MilkInfo[playerid][mLiters] * 150) + (GetPlayerSkillLevel(playerid) * 20);
		BudgetToPlayerBankMoney (playerid, moneys); // sjeda na radnu knjizicu
		PlayerJob[playerid][pFreeWorks] -= 5;
		
		MilkInfo[playerid][mLiters] = 0;
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spremili kanister sa mlijekom u spremiste, te ste zaradili %i$!", moneys);
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
	}
	else if(!strcmp(param, "take", true)) 
	{
		if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(!MilkInfo[playerid][mTransporting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne transportirate mlijeko!");
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, -1.3600, 74.3902, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
    	if(MilkInfo[playerid][mCanister] || MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kanister s mlijekom kod sebe!");
    	if(MilkInfo[playerid][mEmptyBucket] || MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kantu kod sebe! Bacite ju kako bi mogli uzeti kanister.");
    	if(SeedInfo[playerid][sSpade]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate lopatu u ruci! Bacite ju kako bi mogli uzeti kanister!");
    	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");

		SetPlayerAttachedObject(playerid, 9, 918, 6, 0.000000, 0.201999, -0.160000, -16.400003, 0.000000, -2.400001, 1.000000, 1.000000, 1.000000);
		SetPlayerSpecialAction(playerid, 25);
    	MilkInfo[playerid][mStorageCanister] = 1;
    	MilkInfo[playerid][mLiters] += minrand(2, 3);
    	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste kanister s mlijekom iz spremista!");
    	SendClientMessage(playerid, COLOR_RED, "[!] Odite do svog kamiona, te kucajte /milk put kako bi stavili kanister na kamion.");
    	return SendClientMessage(playerid, -1, "Kanister mozete baciti sa /dropcanister.");
	}
	else if(!strcmp(param, "put", true)) 
	{
		new
			VehicleModel;

    	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(MilkInfo[playerid][mCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete spremiti taj kanister pri sebi!");
		if(!MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kanister pri sebi!");
		if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		switch(VehicleModel)
		{
			case(478):
			{
            	if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu mlijeka i kucajte /milk sell kako bi prodali mlijeko.");
				}

				if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 10 || TruckInfo[playerid][tLimit] == 15)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] -= 0.5;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(918, 0.0, 0.0, 0.0, 0, 0, 96.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.72+TruckInfo[playerid][tXOffes], -0.8+TruckInfo[playerid][tYOffes], 0.3, 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tXOffes] += 0.35;
				TruckInfo[playerid][tLiters] += MilkInfo[playerid][mLiters];
			}

			case(543):
			{
            	if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu mlijeka i kucajte /milk sell kako bi prodali mlijeko.");
				}

				if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 10 || TruckInfo[playerid][tLimit] == 15)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] -= 0.5;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(918, 0.0, 0.0, 0.0, 0, 0, 96.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.72+TruckInfo[playerid][tXOffes], -0.8+TruckInfo[playerid][tYOffes], 0.2, 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tXOffes] += 0.35;
				TruckInfo[playerid][tLiters] += MilkInfo[playerid][mLiters];
			}

			case(422):
			{
            	if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu mlijeka i kucajte /milk sell kako bi prodali mlijeko.");
				}

				if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 10 || TruckInfo[playerid][tLimit] == 15)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] -= 0.45;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(918, 0.0, 0.0, 0.0, 0, 0, 96.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.62+TruckInfo[playerid][tXOffes], -0.8+TruckInfo[playerid][tYOffes], 0.1, 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tXOffes] += 0.3;
				TruckInfo[playerid][tLiters] += MilkInfo[playerid][mLiters];
			}
		}
		if(MilkInfo[playerid][mFactoryCP] == 0)
		{
			DisablePlayerCheckpoint(playerid);
			MilkInfo[playerid][mFactoryCP] = 1;
			SetPlayerCheckpoint(playerid, 2362.4734, -2099.7356, 13.5469, 5.0);
		}
		MilkInfo[playerid][mStorageCanister] = 0;
		MilkInfo[playerid][mLiters] = 0;
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, 0);
		return SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste spremili kanister sa mlijekom na kamion!");
	}
	else if(!strcmp(param, "check", true)) 
	{
		new
			string[50],
			VehicleModel;

		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		format(string, sizeof(string), "[!] Trenutno se na kamionu nalazi %i litara.", TruckInfo[playerid][tLiters]);
		return SendClientMessage(playerid, COLOR_GREEN, string);
	}
	else if(!strcmp(param, "sell", true)) {
		new
			VehicleModel;
    	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(!IsPlayerInRangeOfPoint(playerid, 10.0, 2362.4734, -2099.7356, 13.5469)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu tvornice!");
		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");
		if(!IsPlayerInVehicle(playerid, PlayerKeys[playerid][pVehicleKey])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u svojem kamionu!");

    	if(!TruckInfo[playerid][tLiters]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate mlijeka u kamionu!");

		for(new j=0;j<20;j++) {
			if(IsValidDynamicObject(TruckInfo[playerid][t1Object][j]))
			DestroyDynamicObject(TruckInfo[playerid][t1Object][j]);
		}

		new moneys = (TruckInfo[playerid][tLiters] * 10) + (GetPlayerSkillLevel(playerid) * 20);
		TruckInfo[playerid][tLiters] = 0;
		TruckInfo[playerid][tLimit] = 0;
		TruckInfo[playerid][tXOffes] = 0.0;
		TruckInfo[playerid][tYOffes] = 0.0;

    	BudgetToPlayerBankMoney (playerid, moneys);
		PaydayInfo[playerid][pPayDayMoney] += moneys;
		PlayerJob[playerid][pFreeWorks] -= 5;
		MilkInfo[playerid][mTransportCP] = 0;
		MilkInfo[playerid][mFactoryCP] = 0;
		
		DisablePlayerCheckpoint(playerid);
		MilkInfo[playerid][mTransporting] = 0;
		va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", moneys);
		
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
	}
	else if(!strcmp(param, "stop", true)) {
		MilkInfo[playerid][mMilking] = 0;
		Player_SetIsWorkingJob(playerid, false);
		TogglePlayerControllable(playerid, 1);

		RemovePlayerAttachedObject(playerid, 9);
  		MilkInfo[playerid][mEmptyBucket] = 0;
		MilkInfo[playerid][mFullBucket] = 0;
		MilkInfo[playerid][mMilking] = 0;
		MilkInfo[playerid][mTransfering] = 0;
		MilkInfo[playerid][mCanister] = 0;
		MilkInfo[playerid][mStorageCanister] = 0;
		MilkInfo[playerid][mTransporting] = 0;
		MilkInfo[playerid][mLiters] = 0;
		MilkInfo[playerid][mStorageCP] = 0;
		MilkInfo[playerid][mTransportCP] = 0;
		MilkInfo[playerid][mFactoryCP] = 0;

		TruckInfo[playerid][tLiters] = 0;
		TruckInfo[playerid][tLimit] = 0;
		TruckInfo[playerid][tXOffes] = 0.0;
		TruckInfo[playerid][tYOffes] = 0.0;
		
		DisablePlayerCheckpoint(playerid);
		ResetFarmerVars(playerid);
		
		SendClientMessage(playerid, COLOR_RED, "[!] Prestali ste sa muznjom krave.");
	}
	return 1;
}

CMD:dropcanister(playerid, params[])
{
	if(!MilkInfo[playerid][mCanister] && !MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kanister kod sebe!");

	RemovePlayerAttachedObject(playerid, 9);
	MilkInfo[playerid][mCanister] = 0;
	MilkInfo[playerid][mStorageCanister] = 0;
	SetPlayerSpecialAction(playerid, 0);

	SendMessage(playerid, MESSAGE_TYPE_INFO, "Bacili ste kanister na pod.");
	return 1;
}

// Sadnja
CMD:seeds(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	new 
		param[6];
	if(sscanf(params, "s[6] ", param)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /seeds [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: take - drop - check - put");
		return 1;
	}
	if(!strcmp(param, "take", true)) {
		if(!IsPlayerInRangeOfPoint(playerid, 1.0, -96.7375, -39.4615, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu mjesta za uzimanje sjemenki!");
		if(SeedInfo[playerid][sSeeds]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate sjemenke kod sebe!");
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(SeedInfo[playerid][sTrailerSeeds] == 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dovoljno sjemenki u prikolici!");
		if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
		
		SeedInfo[playerid][sSeeds] += 10;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste 10 sjemenki iz kutije!");
		SendClientMessage(playerid, COLOR_RED, "[!] Idite do prikolica, te upisite /seeds put kako bi stavili sjemenke u prikolicu.");
	}
	else if(!strcmp(param, "drop", true)) {
		if(!SeedInfo[playerid][sSeeds]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sjemenke kod sebe!");
		SeedInfo[playerid][sSeeds] = 0;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Bacili ste sjemenke na pod.");
	}
	else if(!strcmp(param, "check", true)) {
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno kod sebe imate %i sjemenki, a u prikolici %i.", 
			SeedInfo[playerid][sSeeds] * 10, 
			SeedInfo[playerid][sTrailerSeeds]
		);
	}
	else if(!strcmp(param, "put", true)) 
	{
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		foreach(new i: StreamedVehicle[playerid])
		{
			if(GetVehicleModel(i) == 610) 
			{
				if(IsPlayerInRangeOfVehicle(playerid, i, 5.0)) 
				{
					if(!SeedInfo[playerid][sSeeds]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sjemenke kod sebe!");
					SeedInfo[playerid][sSeeds] 			= 0;
					SeedInfo[playerid][sTrailerSeeds] 	+= 10;
					SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste stavili sjemenke u prikolicu!");
					SendClientMessage(playerid, COLOR_RED, "[!] Sjednite na traktor, te idite do prikolice i kucajte /attach_trailer da bi prikvacili prikolicu za traktor.");
					return 1;
				}
			}
		}
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu prikolice!");
	}
	return 1;
}

CMD:tow2(playerid, params[]) 
{ // brooks
	new vehicleid = GetPlayerVehicleID(playerid),
		Float:X, Float:Y, Float:Z;
	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
 	
	if(IsTrailerAttachedToVehicle(vehicleid)) {
		DetachTrailerFromVehicle(vehicleid);
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid))  {
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Traktor vec ima prikolicu!");

		foreach(new i: StreamedVehicle[playerid])
		{
			GetVehiclePos(i, X, Y, Z);
			if(GetVehicleDistanceFromPoint(GetPlayerVehicleID(playerid), X, Y, Z) <= 5.0) 
			{
				AttachTrailerToVehicle(i, GetPlayerVehicleID(playerid));
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Da detach-ate prikolicu, kucajte ponovo /tow2.");
				break;
			}
		}
	}
    return 1;
}


CMD:attach_trailer(playerid, params[])
{
	new
		Float:X, Float:Y, Float:Z;
	
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 531) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u traktoru!");
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Traktor vec ima prikolicu!");

		foreach(new i: StreamedVehicle[playerid])
		{
			GetVehiclePos(i, X, Y, Z);
			if(GetVehicleDistanceFromPoint(GetPlayerVehicleID(playerid), X, Y, Z) <= 3.0) 
			{
				if(GetVehicleModel(i) == 610) 
				{
					AttachTrailerToVehicle(i, GetPlayerVehicleID(playerid));
					SendClientMessage(playerid, COLOR_RED, "[!] Kucajte /detach_trailer da bi otkacili prikolicu, ili /plant da bi zapoceli rad sa traktorom.");
					break;
				}
			}
		}
	}
	return 1;
}

CMD:detach_trailer(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 531) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u traktoru!");
		if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Traktor nema prikolicu!");
		
		DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		return 1;
	}
    SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u traktoru!");
	return 1;
}

CMD:plant(playerid, params[])
{
	if(SeedInfo[playerid][sWork]) {
		SeedInfo[playerid][sWork] = 0;
		if(IsValidDynamicArea(SeedInfo[playerid][sZone]))
			DestroyDynamicArea(SeedInfo[playerid][sZone]);
			
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prekinuli ste rad sa traktorom.");
		return 1;
	}
	
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 531) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u traktoru!");
	if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Traktor nema prikolicu!");
	if(SeedInfo[playerid][sTrailerSeeds] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sjemenke u prikolici!");
	
	Player_SetIsWorkingJob(playerid, true);
	SeedInfo[playerid][sZone] = CreateDynamicCircle(0.2381, -70.7436, 65.0, -1, -1, playerid);
	SeedInfo[playerid][sWork] = 1;
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste rad sa traktorom!");
	SendClientMessage(playerid, COLOR_RED, "[!] Vozite do polja kako bi posadili sjemenke (Sjemenke postavljate pritiskom na LMB).");
	SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa sadenjem, kucajte /plant da bi prestali rad sa traktorom.");
	return 1;
}

CMD:checkplant(playerid, params[])
{
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	new
		Float:X, Float:Y, Float:Z;
	for( new i = 0; i < SeedInfo[playerid][sPlantsNumber]; i++) {
		GetDynamicObjectPos(SeedInfo[playerid][sPlant][i], X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 3.0, X, Y, Z+1.5)) {
		    if(IsDynamicObjectMoving(SeedInfo[playerid][sPlant][i])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Usjev jos nije spreman za zetvu.");
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Usjev je spreman za zetvu.");
			SendClientMessage(playerid, COLOR_RED, "[!] Upisite /harvest kako bi zapoceli sa zetvom usjeva.");
			return 1;
		}
	}
	SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu usjeva!");
	return 1;
}

CMD:takespade(playerid, params[])
{
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, -69.2246, 42.0311, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu mjesta za uzimanje lopate!");
	if(MilkInfo[playerid][mEmptyBucket] || MilkInfo[playerid][mFullBucket]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kantu kod sebe! Bacite ju kako bi mogli uzeti lopatu!");
	if(MilkInfo[playerid][mCanister] || MilkInfo[playerid][mStorageCanister]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kanister kod sebe! Bacite ga kako bi mogli uzeti lopatu!");
	if(SeedInfo[playerid][sSpade]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate lopatu kod sebe!");
    if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
    
	SetPlayerAttachedObject(playerid, 9, 2228, 6, 0.055999, -0.022000, 0.465000, -171.800018, 13.100005, -179.300094, 1.000000, 1.000000, 1.000000);
	SeedInfo[playerid][sSpade] = 1;
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste lopatu!");
	SendClientMessage(playerid, COLOR_RED, "[!] Idite do svojih usjeva, te kucajte /checkplant kako bi provjerili stanje.");
	return 1;
}

CMD:dropspade(playerid, params[])
{
	if(!SeedInfo[playerid][sSpade]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate lopatu kod sebe!");
	if(SeedInfo[playerid][sHarvesting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete baciti lopatu dok ne zavrsite sa zetvom usjeva!");

	RemovePlayerAttachedObject(playerid, 9);
	SeedInfo[playerid][sSpade] = 0;
	SendClientMessage(playerid, COLOR_RED, "Bacili ste lopatu na pod.");
	return 1;
}

CMD:harvest(playerid, params[])
{
	if(SeedInfo[playerid][sHarvesting]) {
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		SeedInfo[playerid][sHarvesting] = 0;
		Player_SetIsWorkingJob(playerid, false);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa zetvom usjeva.");
		return 1;
	}
	
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(SeedInfo[playerid][sHarvested]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate vrecu sa usjevom kod sebe!");
	if(!SeedInfo[playerid][sSpade]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate lopatu kod sebe!");
	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
	new
		Float:X, Float:Y, Float:Z;
	
	for(new i=0;i<50;i++) {
        if(SeedInfo[playerid][sPlant][i] != INVALID_OBJECT_ID)
			GetDynamicObjectPos(SeedInfo[playerid][sPlant][i], X, Y, Z);

		if(IsPlayerInRangeOfPoint(playerid, 4.0, X, Y, Z))
		{
		    if(IsDynamicObjectMoving(SeedInfo[playerid][sPlant][i])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Usjev nije spreman za zetvu!");
		    if(SeedInfo[playerid][sHarvesting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste zapoceli zetvu usjeva!");

			Player_SetIsWorkingJob(playerid, true);
			SeedInfo[playerid][sHarvesting] = 1;
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 0, 30000, 0);
			SeedInfo[playerid][sHarvestPlant] = i;
			defer HarvestingSeed(playerid);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste zetvu usjeva! Pricekajte dok ne zavrsite sa zetvom.");
			SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa zetvom, ponovno ukucajte /harvest kako bi prestali sa zetvom usjeva.");
			return 1;
		}
	}
	SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu usjeva!");
	return 1;
}

CMD:crops(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao farmer.");
	new
		param[7];
	if(sscanf( params, "s[7] ", param)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /crops [odabir]");
	    SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: drop - store - take - put - check - sell");
		return 1;
	}
	if(!strcmp(param, "drop", true)) {
		RemovePlayerAttachedObject(playerid, 8);
		SeedInfo[playerid][sHarvested] = 0;
		SeedInfo[playerid][sStorageCrops] = 0;
		SetPlayerSpecialAction(playerid, 0);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Bacili ste vrecu sa usjevom na pod.");
	}
	else if(!strcmp(param, "store", true)) {	
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, -9.4406, 54.8088, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
		if(SeedInfo[playerid][sStorageCrops]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete spremiti tu vrecu sa usjevom!");
		if(!SeedInfo[playerid][sHarvested]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate vrecu sa usjevom kod sebe!");

		RemovePlayerAttachedObject(playerid, 8);
		SeedInfo[playerid][sStored]++;
		PlayerJob[playerid][pFreeWorks] -= 1;
		SeedInfo[playerid][sHarvested] = 0;
		
		if(!SeedInfo[playerid][sPlantsNumber]) {
			new moneys = SeedInfo[playerid][sStored] * 20 + (GetPlayerSkillLevel(playerid) * 20);
			PlayerJob[playerid][pFreeWorks] -= 5;
			BudgetToPlayerBankMoney (playerid, moneys); // sjeda novac na knjizicu
			PaydayInfo[playerid][pPayDayMoney] += moneys;
			va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", moneys);
			ResetFarmerVars(playerid);
			UpgradePlayerSkill(playerid);
		}

		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spremili vrecu sa usjevom u spremiste!");
	}
	else if(!strcmp(param, "take", true)) {
		if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!SeedInfo[playerid][sTransporting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne transportirate usjeve!");
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, -9.4406, 54.8088, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
		if(SeedInfo[playerid][sHarvested] || SeedInfo[playerid][sStorageCrops]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate vrecu sa usjevima kod sebe!");
		if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");

		SetPlayerAttachedObject(playerid, 8, 2060, 5, 0.020000, 0.119999, 0.185999, -72.500053, -9.700006, -76.799949, 1.000000, 1.000000, 1.000000);
		SetPlayerSpecialAction(playerid, 25);
		SeedInfo[playerid][sStorageCrops] = 1;
		Player_SetIsWorkingJob(playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste vrecu sa usjevom iz spremista!");
		SendClientMessage(playerid, COLOR_RED, "[!] Odite do svog kamiona, te kucajte /crops put kako bi stavili vrecu na kamion.");
		return SendClientMessage(playerid, COLOR_RED, "[!] Vrecu mozete baciti sa /crops drop.");
	}
	else if(!strcmp(param, "put", true)) 
	{
		new VehicleModel;

    	if(PlayerJob[playerid][pJob] != JOB_FARMER) 
			return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(SeedInfo[playerid][sHarvested]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete spremiti tu vrecu na kamion!");
		if(!SeedInfo[playerid][sStorageCrops]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate vrecu sa usjevom kod sebe!");
		if(IsPlayerInAnyVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
		if(PlayerKeys[playerid][pVehicleKey] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		switch(VehicleModel) 
		{
			case(478): 
			{
				if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu usjeva i kucajte /crops sell kako bi prodali usjeve.");
				}

            	if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2060, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.3+TruckInfo[playerid][tYOffes], 0.0+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tCropNumber]++;
			}

			case(543): 
			{
				if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu usjeva i kucajte /crops sell kako bi prodali usjeve.");
				}

            	if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2060, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.3+TruckInfo[playerid][tYOffes], 0.0+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tCropNumber]++;
			}
			case(422): 
			{
				if(TruckInfo[playerid][tLimit] == 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu usjeva i kucajte /crops sell kako bi prodali usjeve.");
				}

           		if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}
				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2060, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 0.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.1+TruckInfo[playerid][tYOffes], -0.2+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tCropNumber]++;
			}
		}
		if(SeedInfo[playerid][sFactoryCP] == 0)
		{
			DisablePlayerCheckpoint(playerid);
			SeedInfo[playerid][sFactoryCP] = 1;
			SetPlayerCheckpoint(playerid, 2454.6055, -2455.7285, 13.6491, 5.0);
		}
		SeedInfo[playerid][sStorageCrops] = 0;
		RemovePlayerAttachedObject(playerid, 8);
    	SetPlayerSpecialAction(playerid, 0);
		return SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste spremili vrecu sa usjevom na kamion!");
	}
	else if(!strcmp(param, "check", true)) 
	{
		new
			string[50],
			VehicleModel;

		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		format(string, sizeof(string), "[!] Trenutno se na kamionu nalazi %i vreca usjeva.", TruckInfo[playerid][tCropNumber]);
		return SendClientMessage(playerid, COLOR_RED, string);
	}
	else if(!strcmp(param, "sell", true)) 
	{
		new
			moneys, VehicleModel;

    	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2454.6055, -2455.7285, 13.6491)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu tvornice!");
		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");
		if(!IsPlayerInVehicle(playerid, PlayerKeys[playerid][pVehicleKey])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u svojem kamionu!");

    	if(!TruckInfo[playerid][tCropNumber]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate usjeva u kamionu!");

		for(new j=0;j<20;j++) {
			if(IsValidDynamicObject(TruckInfo[playerid][t1Object][j]))
			DestroyDynamicObject(TruckInfo[playerid][t1Object][j]);
		}

		moneys = TruckInfo[playerid][tCropNumber] + (GetPlayerSkillLevel(playerid) * 20);
		TruckInfo[playerid][tCropNumber] = 0;
		TruckInfo[playerid][tLimit] = 0;
		TruckInfo[playerid][tXOffes] = 0.0;
		TruckInfo[playerid][tYOffes] = 0.0;
		TruckInfo[playerid][tZOffes] = 0.0;

    	BudgetToPlayerBankMoney (playerid, moneys); // novac iz proracuna ide na knjizicu
		PaydayInfo[playerid][pPayDayMoney] += moneys;
		PlayerJob[playerid][pFreeWorks] -= 5;

		SeedInfo[playerid][sTransportCP] = 0;
		SeedInfo[playerid][sFactoryCP] = 0;
					
		DisablePlayerCheckpoint(playerid);
    	SeedInfo[playerid][sTransporting] = 0;
    	va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", moneys);
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
	}
	return 1;
}

// Jaja
CMD:takecarton(playerid, params[])
{
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -56.1417, 47.6496, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu mjesta za uzimanje kutije!");
	if(SeedInfo[playerid][sHarvested] || SeedInfo[playerid][sStorageCrops]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate vrecu u ruci! Bacite ju kako bi mogli uzeti kutiju!");
	if(EggInfo[playerid][eEmptyCarton] || EggInfo[playerid][eFullCarton] || EggInfo[playerid][eStorageCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kutiju kod sebe!");
	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");

	SetPlayerAttachedObject(playerid, 8, 2358, 5, 0.010000, 0.076000, 0.171999, -72.500030, -12.500003, -68.199996, 1.000000, 1.000000, 1.000000);
	SetPlayerSpecialAction(playerid, 25);
	EggInfo[playerid][eEmptyCarton] = 1;
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste kutiju!");
	return SendClientMessage(playerid, COLOR_RED, "[!] Odite do kokosinjaca, te stanite ispred jedne i kucajte /eggs collect kako bi zapoceli skupljanje jaja.");
}

CMD:dropcarton(playerid, params[])
{
	if(!EggInfo[playerid][eEmptyCarton] && !EggInfo[playerid][eFullCarton] && !EggInfo[playerid][eStorageCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kutiju kod sebe!");
	if(EggInfo[playerid][eCollecting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete baciti kutiju dok skupljate jaja!");
	if(EggInfo[playerid][eProcessing]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete baciti kutiju dok procesirate jaja!");
	
	RemovePlayerAttachedObject(playerid, 8);
	EggInfo[playerid][eEmptyCarton] = 0;
	EggInfo[playerid][eFullCarton] = 0;
	EggInfo[playerid][eStorageCarton] = 0;
	EggInfo[playerid][eEggs] = 0;
	EggInfo[playerid][eProcessed] = 0;
	SetPlayerSpecialAction(playerid, 0);
	return SendClientMessage(playerid, COLOR_RED, "Bacili ste kutiju na pod.");
}

CMD:eggs(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
	if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(!EggInfo[playerid][eTransporting]&& IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");

	new 
		param[8];
	if(sscanf( params, "s[8] ", param)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /eggs [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: collect - process - store - take - put - check - sell");
		return 1;
	}
	if(!strcmp(param, "collect", true)) 
	{
		if(EggInfo[playerid][eCollecting]) {
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
			EggInfo[playerid][eCollecting] = 0;
			DisablePlayerKeyInput(playerid);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa sakupljanjem jaja.");
			return 1;
		}
		
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, -71.1010, 53.4408, 3.1172) && !IsPlayerInRangeOfPoint(playerid, 1.0, -77.9046, 55.6308, 3.1172) && !IsPlayerInRangeOfPoint(playerid, 1.0, -75.8616, 51.6856, 3.1172) && !IsPlayerInRangeOfPoint(playerid, 1.0, -72.7300, 46.8216, 3.1172) && !IsPlayerInRangeOfPoint(playerid, 1.0, -81.5432, 50.4941, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se ispred kucice sa kokosima!");
		if(!EggInfo[playerid][eEmptyCarton] && !EggInfo[playerid][eFullCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kutiju kod sebe!");
		if(EggInfo[playerid][eFullCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kutiju s jajima kod sebe!");
		if(EggInfo[playerid][eCollecting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec sakupljate jaja u kutiju!");
		
		Player_SetIsWorkingJob(playerid, true);
		EggInfo[playerid][eCollecting] = 1;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 0, 1, 0);
		SetPlayerKeyInput(playerid, 50, 2000, 180, 4);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Zapoceli ste sakupljati jaja!");
		SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa sakupljanjem, opet ukucajte /eggs collect da bi prestali sa sakupljanjem jaja.");
	}
	else if(!strcmp(param, "process", true)) {
		
		if(!EggInfo[playerid][eProcessing]) { 
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
			EggInfo[playerid][eProcessing] = 0;
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa procesiranjem jaja.");
		}
		
		if(!IsPlayerInRangeOfPoint(playerid, 1.0, -132.3292 , -99.2501, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu stroja za procesiranje jaja!");
		if(!EggInfo[playerid][eEmptyCarton] && !EggInfo[playerid][eFullCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kutiju kod sebe!");
		if(EggInfo[playerid][eEmptyCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate jaja u kutiji za procesirati!");
		if(EggInfo[playerid][eProcessing]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste zapoceli procesiranje jaja!");
		if(EggInfo[playerid][eProcessed]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste procesirali ta jaja!");
		
		EggInfo[playerid][eProcessing] = 1;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 0, 1, 0);
		defer ProcessingEggs(playerid);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste zapoceli procesiranje jaja! Pricekajte dok se proces ne zavrsi!");
		SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa procesom, upisite /eggs process da bi prestali sa procesiranjem jaja.");
	}
	else if(!strcmp(param, "store", true)) {
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, -79.3684, 90.7796, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
		if(!EggInfo[playerid][eFullCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kutiju sa jajima kod sebe!");
		if(!EggInfo[playerid][eProcessed]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo procesirajte jaja!");
		if(EggInfo[playerid][eStorageCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemozete spremiti tu kutiju s jajima!");
		
		EggInfo[playerid][eFullCarton] = 0;
		RemovePlayerAttachedObject(playerid, 8);
		SetPlayerSpecialAction(playerid, 0);
		new Profit = EggInfo[playerid][eEggs]*(random(45)+70);
		BudgetToPlayerBankMoney (playerid, Profit); // novac sjeda na radnu knjizicu iz proracuna
		PlayerJob[playerid][pFreeWorks] -= 3;
		EggInfo[playerid][eStorageCP] = 0;
		DisablePlayerCheckpoint(playerid);
			
		EggInfo[playerid][eEggs] = 0;
		EggInfo[playerid][eProcessed] = 0;
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste spremili kutiju s jajima, te ste zaradili %i$!", Profit);
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
	}
	else if(!strcmp(param, "take", true))
	{
		if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
		if(!EggInfo[playerid][eTransporting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne transportirate jaja!");
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, -79.3684, 90.7796, 3.1172)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu spremista!");
    	if(EggInfo[playerid][eEmptyCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate praznu kutiju kod sebe! Bacite ju kako bi mogli uzeti kutiju s jajima!");
		if(EggInfo[playerid][eFullCarton] || EggInfo[playerid][eStorageCarton]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate kutiju sa jajima kod sebe!");
		if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");

		SetPlayerAttachedObject(playerid, 8, 2358, 5, 0.010000, 0.076000, 0.171999, -72.500030, -12.500003, -68.199996, 1.000000, 1.000000, 1.000000);
		SetPlayerSpecialAction(playerid, 25);
		EggInfo[playerid][eStorageCarton] = 1;
		EggInfo[playerid][eEggs] += (random(10)+1); // JEL MOGUCE // dodat brisanje kad se ode stoptransport!!!! i naravno maknit JEBENI +=
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste kutiju s jajima iz spremista!");
		SendClientMessage(playerid, COLOR_RED, "[!] Odite do svog kamiona, te kucajte /eggs put kako bi stavili kutiju na kamion.");
		return SendClientMessage(playerid, COLOR_RED, "[!] Kutiju mozete baciti sa /dropcarton.");
	}
	else if(!strcmp(param, "put", true)) 
	{
		new
			VehicleModel;

    	if(PlayerJob[playerid][pJob] != JOB_FARMER) 
			return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(EggInfo[playerid][eFullCarton]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete spremiti tu kutiju na kamion!");
		if(!EggInfo[playerid][eStorageCarton]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kutiju sa jajima kod sebe!");
		if(IsPlayerInAnyVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo izadite iz vozila!");
		if(PlayerKeys[playerid][pVehicleKey] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		switch(VehicleModel)
		{
	    	case(422):
	    	{
				if(TruckInfo[playerid][tLimit] >= 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu jaja i kucajte /eggs sell kako bi prodali jaja.");
				}

				if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}

				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2358, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 30.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.2+TruckInfo[playerid][tYOffes], -0.1+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tEggsNumber]+= EggInfo[playerid][eEggs];
			}

	    	case(478):
	    	{
				if(TruckInfo[playerid][tLimit] >= 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu jaja i kucajte /eggs sell kako bi prodali jaja.");
				}

            	if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}

				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2358, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 30.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.3+TruckInfo[playerid][tYOffes], 0.1+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tEggsNumber]+= EggInfo[playerid][eEggs];
			}

			case(543):
			{
				if(TruckInfo[playerid][tLimit] >= 20)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kamion je pun!");
					return SendClientMessage(playerid, COLOR_RED, "[!] Vozite do tvornice za preradu jaja i kucajte /eggs sell kako bi prodali jaja.");
				}

            	if(TruckInfo[playerid][tLimit] == 5 || TruckInfo[playerid][tLimit] == 15)
				{
			    	TruckInfo[playerid][tXOffes] = 0.8;
			    	TruckInfo[playerid][tYOffes] = 0.0;
				}
				if(TruckInfo[playerid][tLimit] == 10)
				{
					TruckInfo[playerid][tXOffes] = 0.0;
					TruckInfo[playerid][tYOffes] = 0.0;
					TruckInfo[playerid][tZOffes] = 0.2;
				}

				TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]] = CreateDynamicObject(2358, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 400.0, 30.0);
				AttachDynamicObjectToVehicle(TruckInfo[playerid][t1Object][TruckInfo[playerid][tLimit]], PlayerKeys[playerid][pVehicleKey], -0.4+TruckInfo[playerid][tXOffes], -2.3+TruckInfo[playerid][tYOffes], -0.1+TruckInfo[playerid][tZOffes], 0.0, 0.0, 0.0);
				TruckInfo[playerid][tLimit]++;
				TruckInfo[playerid][tYOffes] += 0.4;
				TruckInfo[playerid][tEggsNumber]+= EggInfo[playerid][eEggs];
			}
		}
		if(EggInfo[playerid][eFactoryCP] == 0)
		{
			DisablePlayerCheckpoint(playerid);
			EggInfo[playerid][eFactoryCP] = 1;
			SetPlayerCheckpoint(playerid, 2271.2578, -2351.6902, 13.5469, 5.0);
		}
    	EggInfo[playerid][eStorageCarton] = 0;
		EggInfo[playerid][eEggs] = 0;
		RemovePlayerAttachedObject(playerid, 8);
		SetPlayerSpecialAction(playerid, 0);
		return SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste spremili kutiju s jajima na kamion!");
	}
	else if(!strcmp(param, "check", true))
	{
		new
			string[50],
			VehicleModel;

		if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");

		if(!IsPlayerInRangeOfVehicle(playerid, PlayerKeys[playerid][pVehicleKey], 4.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu svog kamiona!");

		format(string, sizeof(string), "[!] Trenutno se na kamionu nalazi %i jaja.", TruckInfo[playerid][tEggsNumber]);
		return SendClientMessage(playerid, COLOR_RED, string);
	}
	else if(!strcmp(param, "sell", true)) {
		new
			Profit, VehicleModel;

    	if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, 2271.2578, -2351.6902, 13.5469)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu tvornice!");
    	if(PlayerKeys[playerid][pVehicleKey] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano vozilo!");

		VehicleModel = GetVehicleModel(PlayerKeys[playerid][pVehicleKey]);
		if(VehicleModel != 478 && VehicleModel != 543 && VehicleModel != 422) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnan kamion za prijevoz!");
		if(!IsPlayerInVehicle(playerid, PlayerKeys[playerid][pVehicleKey])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u svojem kamionu!");

		if(!TruckInfo[playerid][tEggsNumber]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate jaja u kamionu!");

		for(new j=0;j<20;j++) {
			if(IsValidDynamicObject(TruckInfo[playerid][t1Object][j]))
				DestroyDynamicObject(TruckInfo[playerid][t1Object][j]);
		}

		Profit = TruckInfo[playerid][tEggsNumber] * (random(4) + 7) + (GetPlayerSkillLevel(playerid) * 20);
		TruckInfo[playerid][tEggsNumber] = 0;
		TruckInfo[playerid][tLimit] = 0;
		TruckInfo[playerid][tXOffes] = 0.0;
		TruckInfo[playerid][tYOffes] = 0.0;
		TruckInfo[playerid][tZOffes] = 0.0;

		BudgetToPlayerBankMoney (playerid, Profit); // novac sjeda na knjizicu iz proracuna
		PaydayInfo[playerid][pPayDayMoney] += Profit;
		PlayerJob[playerid][pFreeWorks] -= 5;
		EggInfo[playerid][eTransportCP] = 0;
		EggInfo[playerid][eFactoryCP] = 0;
			
		DisablePlayerCheckpoint(playerid);
		EggInfo[playerid][eTransporting] = 0;
		va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", Profit);
	
		ResetFarmerVars(playerid);
		UpgradePlayerSkill(playerid);
	}
	return 1;
}

// Prijevoz
CMD:transport(playerid, params[])
{
	new transportchoice;
	
    if(PlayerJob[playerid][pJob] != JOB_FARMER) return SendClientMessage( playerid, COLOR_RED, "Niste farmer!");
    if(PlayerJob[playerid][pFreeWorks] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise raditi! Pricekajte payday.");
	if(sscanf(params, "i", transportchoice)) return SendClientMessage(playerid, COLOR_RED, "[?]: /transport [1(usjevi) / 2(mlijeko) / 3(jaja)]");
	if(SeedInfo[playerid][sTransporting] || MilkInfo[playerid][mTransporting] || EggInfo[playerid][eTransporting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste zapoceli sa transportiranjem!");
	
	switch(transportchoice)
	{
	    case 1:
	    {
	        SeedInfo[playerid][sTransportCP] = 1;
			SetPlayerCheckpoint(playerid, -9.4406, 54.8088, 3.1172, 4.0);
	        SeedInfo[playerid][sTransporting] = 1;
			Player_SetIsWorkingJob(playerid, true);
	        SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste zapoceli sa transportom usjeva!");
	        SendClientMessage(playerid, COLOR_RED, "[!] Odite do skladista za usjeve, te upisite /crops take kako bi uzeli vrecu s usjevima iz skladista.");
		}
		case 2:
		{
		    MilkInfo[playerid][mTransportCP] = 1;
			SetPlayerCheckpoint(playerid, -1.3600, 74.3902, 3.1172, 4.0);
		    MilkInfo[playerid][mTransporting] = 1;
			Player_SetIsWorkingJob(playerid, true);
		    SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste zapoceli sa transportom mlijeka!");
	        SendClientMessage(playerid, COLOR_RED, "[!] Odite do skladista za mlijeko, te upisite /milk take kako bi uzeli kanister s mlijekom iz skladista.");
		}
		case 3:
		{
			EggInfo[playerid][eTransportCP] = 1;
			SetPlayerCheckpoint(playerid, -79.3684, 90.7796, 3.1172, 4.0);
			EggInfo[playerid][eTransporting] = 1;
			Player_SetIsWorkingJob(playerid, true);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste zapoceli sa transportom jaja!");
	        SendClientMessage(playerid, COLOR_RED, "[!]  Odite do skladista za jaja, te upisite /eggs take kako bi uzeli kutiju s jajima iz skladista.");
		}
	}

	return SendClientMessage(playerid, COLOR_RED, "[!] Ako zelite prestati sa transportiranjem, kucajte /stoptransport.");
}
	    
CMD:stoptransport(playerid, params[])
{
	if(!SeedInfo[playerid][sTransporting] && !MilkInfo[playerid][mTransporting] && !EggInfo[playerid][eTransporting]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno ne transportirate nista!");
	
	Player_SetIsWorkingJob(playerid, false);
    TruckInfo[playerid][tCropNumber] = 0;
    TruckInfo[playerid][tEggsNumber] = 0;
	TruckInfo[playerid][tLimit] = 0;
	TruckInfo[playerid][tXOffes] = 0.0;
	TruckInfo[playerid][tYOffes] = 0.0;
	TruckInfo[playerid][tZOffes] = 0.0;

	for(new i = 0; i < 20; i++) {
		if(IsValidDynamicObject(TruckInfo[playerid][t1Object][i]))
			DestroyDynamicObject(TruckInfo[playerid][t1Object][i]);
	}
	
	if(EggInfo[playerid][eTransporting]) 
	{
		EggInfo[playerid][eTransporting] = 0;
		EggInfo[playerid][eTransportCP] = 0;
		EggInfo[playerid][eFactoryCP] = 0;
		DisablePlayerCheckpoint(playerid);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa transportiranjem jaja.");
	}
	else if(MilkInfo[playerid][mTransporting]) 
	{
		MilkInfo[playerid][mTransporting] = 0;
		MilkInfo[playerid][mTransportCP] = 0;
		MilkInfo[playerid][mFactoryCP] = 0;
		DisablePlayerCheckpoint(playerid);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa transportiranjem mlijeka.");
	} 
	else 
	{
		SeedInfo[playerid][sTransporting] = 0;
		SeedInfo[playerid][sTransportCP] = 0;
		SeedInfo[playerid][sFactoryCP] = 0;
		DisablePlayerCheckpoint(playerid);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prestali ste sa transportiranjem usjeva.");
	}
	return 1;
}
