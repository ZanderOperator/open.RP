#include <YSI_Coding\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

#define CRAFTING_TIME				(57000)
#define CRAFTING_CP_SIZE			1.5
#define CRAFT_OBJECT_MOVE			0.35

// Crafing types
#define CRAFTING_TYPE_UNPACK		(1)
#define CRAFTING_TYPE_BOXING		(2)
#define CRAFTING_TYPE_TAKEBOX		(3)
#define CRAFTING_TYPE_GENERATOR		(4)
#define CRAFTING_TYPE_PAYCHECK 		(5)

// DrawDistances
#define FACTORY_DRAW_NORMAL			80.0
#define FACTORY_DRAW_MEDIUM			45.0


/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

// Player Vars (rBits)
static stock
	Bit1: gr_PlayerWorkCrafting		<MAX_PLAYERS>,
	Bit1: gr_CraftingTimer			<MAX_PLAYERS>,
	Bit1: gr_ObjectMoveTimer		<MAX_PLAYERS>,
	Bit4: gr_CraftingCPId			<MAX_PLAYERS>,
	Bit4: gr_CraftingGeneratorId 	<MAX_PLAYERS>;

// Player Vars (32bit)
static stock
	PlayerCraftId[MAX_PLAYERS],
	CraftingPick[MAX_PLAYERS],
	CraftingCP[MAX_PLAYERS],
	PlayerCraftingObject[MAX_PLAYERS],
	Timer:CrafingObjectMoveTimer[MAX_PLAYERS],
	Timer:CraftingTimer[MAX_PLAYERS];

static stock
	Float:FactoryAttach[][6] = {
		{ 0.093000,  0.256700, 0.180000, 281.500000, 0.000000, 100.000000 },
		{ -0.267000, 0.036999, 0.105999, -79.099929, 4.000000, 105.699981 },
		{ -0.224000, 0.011000,-0.023000, -74.699943,-2.400000, 92.4999920 },
		{ -0.151999,-0.059999, 0.256999, -69.400001,-5.500011, 118.800056 },
		{ 0.1560000, 0.072600, 0.156000, -72.600000, -8.39900, 101.100000 },
		{ 0.1560000, 0.072600, 0.156000, -72.600000, -8.39900, 101.100000 }
	};

enum E_CRAFTING_ITEM
{
	ciModel,
	Float:ciStartX,
	Float:ciStartY,
	Float:ciStartZ,
	Float:ciEndX,
	Float:ciEndY,
	Float:ciEndZ
}
static stock
	CraftInfo[][E_CRAFTING_ITEM] = {
		// Model, ciStartX, ciStartY, ciStartZ, ciEndX, ciEndY, ciEndZ
		{ 2317, 2563.9133, -1360.3934, 1044.6000,  2559.4324, -1360.3934, 1044.6000 },
		{ 1781, 2563.7896, -1360.1204, 1044.3450,  2559.2146, -1360.1204, 1044.3450 },
		{ 1747, 2563.6160, -1360.1604, 1044.3450,  2559.4746, -1360.1604, 1044.3450 },
		{ 1792, 2564.2444, -1360.1389, 1044.3450,  2559.3875, -1360.1389, 1044.3450 },
		{ 1782, 2563.8711, -1360.4451, 1044.4200,  2559.2800, -1360.4451, 1044.4200 },
		{ 1788, 2563.8711, -1360.4451, 1044.4200,  2559.2800, -1360.4451, 1044.4200 }
	};

/*
	######## #### ##     ## ######## ########  
	   ##     ##  ###   ### ##       ##     ## 
	   ##     ##  #### #### ##       ##     ## 
	   ##     ##  ## ### ## ######   ########  
	   ##     ##  ##     ## ##       ##   ##   
	   ##     ##  ##     ## ##       ##    ##  
	   ##    #### ##     ## ######## ##     ## 
*/
timer OnPlayerCrafting[1000](playerid, type)
{
	Bit1_Set( gr_CraftingTimer, playerid, false);
	switch( type) 
	{
		case CRAFTING_TYPE_UNPACK: 
		{
			DestroyPlayerObject(playerid, PlayerCraftingObject[playerid]);
			TogglePlayerControllable(playerid, true);
			Bit4_Set( gr_CraftingCPId, playerid, 0);
			SendClientMessage( playerid, COLOR_RED, "[!] Zavrsili ste s raspakiravanjem kutija. Odnesite kutije u stroj za preradu!");
			SetCameraBehindPlayer(playerid);
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
			ClearAnimations(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, 9, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
			SetPlayerCheckpoint(playerid, 2569.5220, -1354.4344, 1043.1500, CRAFTING_CP_SIZE);
			Bit4_Set( gr_CraftingCPId, playerid, 3);
			return 1;
		}
		case CRAFTING_TYPE_BOXING: 
		{
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			
			SetPlayerAttachedObject(playerid, 9, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			GameTextForPlayer( playerid, "~w~Odnesi kutiju do stola za otvaranje!", 3000, 1);
			TogglePlayerControllable(playerid, true);
			
			SetPlayerCheckpoint(playerid, 2575.9402, -1351.5945, 1043.1500, CRAFTING_CP_SIZE);
			Bit4_Set( gr_CraftingCPId, playerid, 1);
			return 1;
		}
		case CRAFTING_TYPE_TAKEBOX: 
		{
			SendClientMessage( playerid, COLOR_RED, "[!] Pokupi kutiju iz skladista za preradu!");
			SetPlayerCheckpoint(playerid, 2582.8999, -1363.1646, 1043.1500, 2.2);
			
			DestroyDynamicPickup(CraftingPick[playerid]);
			CraftingPick[playerid] 	= CreateDynamicPickup(1318, 2, 2582.8999, -1363.1646, 1044.5500, -1, -1, playerid);
			Bit4_Set( gr_CraftingCPId, playerid, 2);
			Streamer_Update(playerid);
			return 1;
		}
		case CRAFTING_TYPE_GENERATOR: 
		{
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			TogglePlayerControllable(playerid, true);
			
			if(Bit4_Get( gr_CraftingGeneratorId, playerid) == 0) {
				CraftingTimer[playerid] = defer OnPlayerCrafting(playerid, CRAFTING_TYPE_TAKEBOX);
				Bit1_Set( gr_CraftingTimer, playerid, true);
			}
			return 1;
		}
		case CRAFTING_TYPE_PAYCHECK:
		{
			Bit4_Set( gr_CraftingCPId, 			playerid, 0);
			Bit4_Set( gr_CraftingGeneratorId, 	playerid, 0);
			
			new
				money = 350 + (GetPlayerSkillLevel(playerid) * 25);
			va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na bankovni racun.", money);
			UpgradePlayerSkill(playerid);
			BudgetToPlayerBankMoney(playerid, money); // sjeda mu placa na bankovni racun iz proracuna
			PaydayInfo[playerid][pPayDayMoney] += money;
			PlayerJob[playerid][pFreeWorks] 	-= 5;
			
			TogglePlayerControllable(playerid, true);
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SetCameraBehindPlayer(playerid);
			Bit1_Set( gr_PlayerWorkCrafting, playerid, false);
			return 1;
		}
	}
	return 1;
}

timer OnCraftingObjectMove[100](playerid, type)
{
	if(!Bit1_Get(gr_ObjectMoveTimer, playerid)) return 0;
	if(!IsPlayerObjectMoving( playerid, PlayerCraftingObject[playerid])) 
	{
		stop CrafingObjectMoveTimer[playerid];
		Bit1_Set( gr_ObjectMoveTimer, playerid, false);
		
		if(type == 1) {
			SendClientMessage( playerid, COLOR_RED, "[!] Pokupite preradjenu robu i odnesite na drugu traku za preradu!");
			SetPlayerCheckpoint(playerid, 2551.2642, -1354.3190, 1043.1500, 1.5);
			Streamer_Update(playerid);
			Bit4_Set( gr_CraftingCPId, playerid, 4);
		}
		else if(type == 2) {
			DestroyPlayerObject(playerid, PlayerCraftingObject[playerid]);
			new
				craftid;
			PlayerCraftId[playerid] = craftid = random(5);
			PlayerCraftingObject[playerid] = CreatePlayerObject(playerid, CraftInfo[craftid][ciModel], CraftInfo[craftid][ciStartX], CraftInfo[craftid][ciStartY], CraftInfo[craftid][ciStartZ], 0.0, 0.0, 0.0);
			MovePlayerObject( playerid, PlayerCraftingObject[playerid], CraftInfo[craftid][ciEndX], CraftInfo[craftid][ciEndY], CraftInfo[craftid][ciEndZ], CRAFT_OBJECT_MOVE);
			Streamer_Update(playerid);
			
			CrafingObjectMoveTimer[playerid] = repeat OnCraftingObjectMove(playerid, 3);
			Bit1_Set( gr_ObjectMoveTimer, playerid, true);
		}
		else if(type == 3) {
			SendClientMessage( playerid, COLOR_RED, "[!] Pokupite zavrseni produkt i stavite ga u skladiste!");
			SetPlayerCheckpoint(playerid, 2559.3394, -1361.5549, 1043.1500, CRAFTING_CP_SIZE);
			Streamer_Update(playerid);
			Bit4_Set( gr_CraftingCPId, playerid, 6);
		}
	}
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

stock ResetFactoryVariables(playerid)
{
	PlayerCraftId[playerid]			= -1;
	
	if(Bit1_Get( gr_ObjectMoveTimer, playerid)) {
		stop CrafingObjectMoveTimer[playerid];
		Bit1_Set( gr_ObjectMoveTimer, playerid, false);
	}
	
	if(Bit1_Get( gr_CraftingTimer, playerid)) {
		stop CraftingTimer[playerid];
		Bit1_Set( gr_CraftingTimer, playerid, false);
	}
	
	DestroyDynamicPickup( CraftingPick[playerid]);
	DestroyDynamicCP( CraftingCP[playerid]);
		
	if(PlayerCraftingObject[playerid] != INVALID_OBJECT_ID) {
		DestroyPlayerObject( playerid, PlayerCraftingObject[playerid]);
		PlayerCraftingObject[playerid] = INVALID_OBJECT_ID;
	}
	
	Bit1_Set( gr_PlayerWorkCrafting		, playerid, false);
	Bit4_Set( gr_CraftingCPId			, playerid, 0);
	Bit4_Set( gr_CraftingGeneratorId 	, playerid, 0);
	return 1;
}

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/

hook OnGameModeInit()
{
	// Factory - B-Matt
	new 
		cftobjid;
	cftobjid = CreateDynamicObject(19433,2563.897,-1360.889,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(19433,2567.377,-1360.011,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(19433,2560.427,-1360.011,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(19433,2567.377,-1360.889,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(19433,2563.897,-1360.011,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(19433,2560.427,-1360.889,1043.599,90.000,0.000,90.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(1271,2568.700,-1360.449,1044.000,0.000,0.000,0.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2566.620,-1360.444,1044.000,0.000,0.000,180.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2568.019,-1360.449,1044.000,0.000,0.000,-180.000, -1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2567.298,-1360.449,1044.000,0.000,0.000,0.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(943,2564.908,-1360.461,1044.915,0.000,0.000,89.699, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(1271,2563.119,-1360.444,1044.000,0.000,0.000,0.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2562.434,-1360.444,1044.000,0.000,0.000,180.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2561.717,-1360.444,1044.000,0.000,0.000,0.000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2561.027,-1360.444,1044.000,0.000,0.000,180.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2560.302,-1360.444,1044.000,0.000,0.000,0.000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(1271,2559.610,-1360.444,1044.000,0.000,0.000,180.000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 5126, "imrancomp_las2", "sanpdconv", 0);

	cftobjid = CreateDynamicObject(7923,2559.14551, -1347.08838, 1042.93005,0.000,0.000,90.000, -1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	cftobjid = CreateDynamicObject(7923, 2568.69482, -1347.14954, 1042.93005,0.000,0.000,90.000, -1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	SetDynamicObjectMaterial(cftobjid, 0, 1259, "billbrd", "bluemetal02", 0);
	SetDynamicObjectMaterial(cftobjid, 1, 1259, "billbrd", "bluemetal02", 0);

	CreateDynamicObject(2567, 2567.36084, -1345.02600, 1044.90002,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14412, 2563.36206, -1357.53796, 1052.46802,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14445, 2572.61206, -1350.90601, 1049.18701,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14416, 2542.60693, -1350.39600, 1043.99402,   356.85800, 0.00000, 0.24000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14439, 2565.24805, -1357.60400, 1050.56201,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14435, 2541.09302, -1285.89697, 1052.71802,   356.85800, 0.00000, 3.14100, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2649, 2533.07202, -1356.09302, 1051.42798,   358.42801, 0.00000, -3.14100, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2649, 2523.07690, -1298.72498, 1051.42798,   358.42801, 0.00000, -3.14100, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2649, 2532.93799, -1354.31201, 1051.42798,   358.42801, 0.00000, -3.14100, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2608, 2532.33301, -1353.23401, 1048.73401,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2200, 2532.14893, -1350.47998, 1047.28101,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14451, 2536.12305, -1357.72205, 1051.34998,   356.85800, 0.00000, 3.14100, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14459, 2558.50000, -1357.56201, 1050.20300,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1508, 2531.94312, -1365.59705, 1048.09802,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1508, 2540.44507, -1370.81299, 1048.09802,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2539.60010, -1360.32898, 1048.01501,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2539.60693, -1359.85205, 1048.01501,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2539.63501, -1359.38098, 1048.01501,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2610, 2539.63501, -1358.89197, 1048.10901,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2530.21802, -1290.74097, 1048.01501,   356.85800, 0.00000, -1.57000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2610, 2539.63794, -1353.50098, 1048.10901,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2539.65601, -1353.10400, 1048.01501,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2609, 2539.67407, -1352.73499, 1048.01501,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2200, 2539.91797, -1347.90002, 1047.28101,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2605, 2536.53394, -1354.57898, 1047.68701,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2607, 2536.53394, -1352.38599, 1047.68701,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2605, 2536.51294, -1346.52002, 1047.68701,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2607, 2536.62598, -1363.30798, 1047.68701,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2607, 2536.61206, -1361.27197, 1047.68701,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2200, 2532.12793, -1359.57300, 1047.28101,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2608, 2532.35693, -1362.11304, 1048.73401,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(934, 2563.94189, -1361.83704, 1044.52002,   0.00000, 0.00000, -90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(3388, 2565.78491, -1359.37695, 1042.29895,   0.00000, 0.00000, 89.59900, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(3388, 2564.81592, -1359.39600, 1042.29895,   0.00000, 0.00000, 92.50000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(3389, 2563.80688, -1359.41296, 1043.05005,   0.00000, 0.00000, -90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1271, 2578.3882,  -1352.8138, 1044.4000,   0.00000, 0.00000, 90.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2567, 2572.58398, -1345.02600, 1044.90002,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2567, 2577.85107, -1345.02197, 1044.90002,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2571.07690, -1346.95605, 1043.56006,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2574.27002, -1346.95605, 1043.56006,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2577.78711, -1346.95605, 1043.56006,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2578.89893, -1353.87524, 1043.59998,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2578.89648, -1352.63000, 1043.59998,   0.00000, 0.00000, 180.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2575.91162, -1352.60217, 1043.59998,   0.00000, 0.00000, 180.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2575.90845, -1353.79053, 1043.59998,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2575.92407, -1358.00244, 1043.59998,   0.00000, 0.00000, 180.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2578.90088, -1357.94849, 1043.59998,   0.00000, 0.00000, 180.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2578.90356, -1359.21008, 1043.59998,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(936, 2575.92651, -1359.26453, 1043.59998,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(934, 2552.79126, -1346.53625, 1044.52002,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(934, 2558.96484, -1346.53625, 1044.52002,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(934, 2546.71509, -1346.53625, 1044.52002,   0.00000, 0.00000, 0.00000, 		-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2554.12036, -1346.74536, 1043.56006,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2560.35791, -1346.74536, 1043.56006,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(941, 2547.98071, -1346.74536, 1043.56006,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(3392, 2555.09961, -1354.39905, 1043.15000,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(3393, 2564.91406, -1354.39905, 1043.15000,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1271, 2563.11890, -1360.44397, 1044.00000,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1271, 2578.48657, -1358.04565, 1044.42004,   0.00000, 0.00000, 22.14000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1508, 2531.94312, -1365.59705, 1044.00000,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2567, 2577.85107, -1345.02197, 1044.90002,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2567, 2582.07861, -1349.80566, 1044.90002,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(2567, 2582.05322, -1354.88660, 1044.90002,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(931, 2586.12500, -1369.48340, 1044.19995,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(922, 2586.47314, -1365.89539, 1043.98999,   0.00000, 0.00000, -90.96000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1221, 2582.10669, -1360.25696, 1043.50000,   0.00000, 0.00000, -34.98000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1221, 2581.83838, -1361.61182, 1043.50000,   0.00000, 0.00000, -13.07999, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1221, 2582.99390, -1361.28210, 1043.50000,   0.00000, 0.00000, -8.69999, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1221, 2582.24341, -1361.02966, 1044.40002,   0.00000, 0.00000, -8.70000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1508, 2540.44507, -1370.81299, 1044.00000,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1499, 2580.83618, -1367.07947, 1043.11841,   0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1499, 2580.83618, -1364.06067, 1043.11841,   0.00000, 0.00000, 270.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(1508, 2587.47998, -1355.09399, 1044.00000,   0.00000, 0.00000, 0.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	CreateDynamicObject(14584, 2542.2971, -1352.7256, 1044.4000,     0.00000, 0.00000, 90.00000, 	-1, -1, -1, FACTORY_DRAW_MEDIUM, FACTORY_DRAW_MEDIUM);
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetFactoryVariables(playerid);
	return continue(playerid);
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(Bit4_Get( gr_CraftingGeneratorId, playerid) == 1)
	{
		GameTextForPlayer( playerid, "~w~Generator #1 ~g~upaljen", 1500, 1);
		
		TogglePlayerControllable(playerid, false);
		ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Loop", 4.1,1,0,0,0,0,1,0);
		CraftingTimer[playerid] = defer OnPlayerCrafting[2500](playerid, CRAFTING_TYPE_GENERATOR);
		Bit1_Set( gr_CraftingTimer, playerid, true);
		
		SetPlayerCheckpoint(playerid, 2554.2424, -1348.2162, 1043.1500, CRAFTING_CP_SIZE);
		Streamer_Update(playerid);
		Bit4_Set( gr_CraftingGeneratorId, playerid, 2);
	}
	else if(Bit4_Get( gr_CraftingGeneratorId, playerid) == 2) 
	{
		GameTextForPlayer( playerid, "~w~Generator #2 ~g~upaljen", 1500, 1);
		
		TogglePlayerControllable(playerid, false);
		ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Loop", 4.1,1,0,0,0,0,1,0);
		CraftingTimer[playerid] = defer OnPlayerCrafting[2500](playerid, CRAFTING_TYPE_GENERATOR);
		Bit1_Set( gr_CraftingTimer, playerid, true);
		
		SetPlayerCheckpoint(playerid, 2548.1968, -1348.2162, 1043.1500, CRAFTING_CP_SIZE);
		Streamer_Update(playerid);
		Bit4_Set( gr_CraftingGeneratorId, playerid, 3);
	}
	else if(Bit4_Get( gr_CraftingGeneratorId, playerid) == 3) 
	{
		GameTextForPlayer( playerid, "~w~Generator #3 ~g~upaljen", 1500, 1);
		
		TogglePlayerControllable(playerid, false);
		ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Loop", 4.1,1,0,0,0,0,1,0);
		Bit4_Set( gr_CraftingGeneratorId, playerid, 0);
		CraftingTimer[playerid] = defer OnPlayerCrafting[2500](playerid, CRAFTING_TYPE_GENERATOR);
		Bit1_Set( gr_CraftingTimer, playerid, true);
	}
	if(Bit4_Get( gr_CraftingCPId, playerid) == 1) 
	{
		GameTextForPlayer( playerid, "~w~Pricekajte 1 minutu~n~da zavrsite s raspakiravanjem", 40000, 1);
		RemovePlayerAttachedObject(playerid, 9);
		PlayerCraftingObject[playerid] = CreatePlayerObject(playerid, 1271, 2575.8855, -1352.7737, 1044.4000, 0.0, 0.0, 0.0);
		
		TogglePlayerControllable(playerid, false);
		
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		
		SetPlayerFacingAngle(playerid, 180.0);
		ApplyAnimationEx(playerid,"CASINO","cards_pick_02", 4.1,1,1,1,1,1,1,0);
		
		InterpolateCameraPos(playerid, 2578.6558, -1351.8114, 1044.4200, 2578.6558, -1351.8114, 1044.4200, 10000000);
		InterpolateCameraLookAt(playerid, 2575.9241, -1352.0225, 1044.4000, 2575.9241, -1352.0225, 1044.4000, 10000000);
		CraftingTimer[playerid] = defer OnPlayerCrafting[CRAFTING_TIME](playerid, CRAFTING_TYPE_UNPACK);
		Bit1_Set( gr_CraftingTimer, playerid, true);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 2) 
	{
		DisablePlayerCheckpoint(playerid);
		DestroyDynamicPickup(CraftingPick[playerid]);
	
		GameTextForPlayer( playerid, "~w~Pricekajte 1 minutu~n~da zavrsite s uzimanjem kutije", 40000, 1);

		TogglePlayerControllable(playerid, false);
		ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Loop", 4.1,1,0,0,0,0,1,0);
		CraftingTimer[playerid] = defer OnPlayerCrafting[CRAFTING_TIME](playerid, CRAFTING_TYPE_BOXING);
		Bit1_Set( gr_CraftingTimer, playerid, true);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 3) 
	{
		DisablePlayerCheckpoint(playerid);
		RemovePlayerAttachedObject(playerid, 9);
		
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		
		PlayerCraftingObject[playerid] = CreatePlayerObject(playerid, 1271, 2569.0049, -1352.6240, 1044.0699, 0.0, 0.0, 0.0);
		MovePlayerObject( playerid, PlayerCraftingObject[playerid], 2551.3921, -1352.9078, 1044.0699, 1.0);
		CrafingObjectMoveTimer[playerid] = repeat OnCraftingObjectMove[500](playerid, 1);
		Bit1_Set( gr_ObjectMoveTimer, playerid, true);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 4) 
	{
		DisablePlayerCheckpoint(playerid);
		DestroyPlayerObject(playerid, PlayerCraftingObject[playerid]);
		
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		
		SetPlayerAttachedObject(playerid, 9, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		GameTextForPlayer( playerid, "~w~Odnesi kutiju do stroja za preradu!", 3000, 1);
		
		SetPlayerCheckpoint(playerid, 2569.7898, -1360.2997, 1043.1206, 1.5);
		Streamer_Update(playerid);			
		Bit4_Set( gr_CraftingCPId, playerid, 5);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 5) 
	{
		DisablePlayerCheckpoint(playerid);
		RemovePlayerAttachedObject(playerid, 9);
		
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		
		PlayerCraftingObject[playerid] = CreatePlayerObject(playerid, 1271, 2568.6814, -1360.4534, 1044.6899, 0.0, 0.0, 0.0);
		MovePlayerObject( playerid, PlayerCraftingObject[playerid], 2564.9280, -1360.4746, 1044.4200, CRAFT_OBJECT_MOVE);
		CrafingObjectMoveTimer[playerid] = repeat OnCraftingObjectMove(playerid, 2);
		Bit1_Set( gr_ObjectMoveTimer, playerid, true);
		GameTextForPlayer( playerid, "~g~Resursi se preradjuju", 3000, 1);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 6) 
	{
		DisablePlayerCheckpoint(playerid);
		DestroyPlayerObject(playerid, PlayerCraftingObject[playerid]);
		
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		
		new
			craftid = PlayerCraftId[playerid];
		
		SetPlayerAttachedObject(playerid, 9, CraftInfo[craftid][ciModel], 5, FactoryAttach[craftid][0], FactoryAttach[craftid][1], FactoryAttach[craftid][2], FactoryAttach[craftid][3], FactoryAttach[craftid][4], FactoryAttach[craftid][5]);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		
		SetPlayerCheckpoint(playerid, 2584.2083, -1355.1130, 1043.1500, CRAFTING_CP_SIZE);
		Streamer_Update(playerid);
		
		DestroyDynamicPickup(CraftingPick[playerid]);
		CraftingPick[playerid] 	= CreateDynamicPickup(1318, 2, 2584.2083, -1355.1130, 1044.5500, -1, -1, playerid);
		Bit4_Set( gr_CraftingCPId, playerid, 7);
	}
	else if(Bit4_Get( gr_CraftingCPId, playerid) == 7) 
	{
		DisablePlayerCheckpoint(playerid);
		DestroyDynamicPickup(CraftingPick[playerid]);
		RemovePlayerAttachedObject(playerid, 9);
		
		TogglePlayerControllable(playerid, false);

		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		ApplyAnimationEx(playerid,"CARRY","putdwn105", 4.1,1,1,1,1,1,1,0);
		
		InterpolateCameraPos(playerid, 		2584.9199, -1358.6466, 1045.2000,  2584.9199, -1358.6466, 1045.2000,  10000000);
		InterpolateCameraLookAt(playerid, 	2584.2083, -1355.1130, 1044.5500,  2584.2083, -1355.1130, 1044.5500,  10000000);
		
		CraftingTimer[playerid] = defer OnPlayerCrafting[1000](playerid, CRAFTING_TYPE_PAYCHECK);
		Bit1_Set( gr_CraftingTimer, playerid, true);
	}
	return 1;
}

/*
	 ######  ##     ## ########  
	##    ## ###   ### ##     ## 
	##       #### #### ##     ## 
	##       ## ### ## ##     ## 
	##       ##     ## ##     ## 
	##    ## ##     ## ##     ## 
	 ######  ##     ## ########  
*/
CMD:craft(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_CRAFTER) 	return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao crafter!");
	if(Bit1_Get( gr_PlayerWorkCrafting, playerid)) {	
		Bit4_Set( gr_CraftingCPId, 			playerid, 0);
		Bit4_Set( gr_CraftingGeneratorId, 	playerid, 0);
		TogglePlayerControllable(playerid, true);
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		SetCameraBehindPlayer(playerid);
		Bit1_Set( gr_PlayerWorkCrafting, playerid, false);
		Player_SetIsWorkingJob(playerid, false);
		return SendClientMessage( playerid, COLOR_RED, "Prestali ste raditi posao craftera!");
	}
	if(PlayerJob[playerid][pFreeWorks] < 1) 				return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
	if(!IsPlayerInRangeOfPoint(playerid, 150.0, 2560.1531, -1357.0905, 1043.1147)) return SendClientMessage( playerid, COLOR_RED, "Morate biti unutar tvornice!");
	
	
	SendClientMessage( playerid, COLOR_RED, "[!] Krenite do checkpointa i ukljucite sve generatore!");
	Player_SetIsWorkingJob(playerid, true);
	Bit1_Set( gr_PlayerWorkCrafting, playerid, true);
	Bit4_Set( gr_CraftingGeneratorId, playerid, 1);
	SetPlayerCheckpoint(playerid, 2560.5459, -1348.2162, 1043.1500, CRAFTING_CP_SIZE);
	return 1;
}
