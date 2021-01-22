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

#define GYM_WANTED_TIME			(7000)

// Modes
#define GYM_MODE_SPRINT			(1)
//#define GYM_MODE_BELLS			(2)
#define GYM_MODE_BIKE			(3)
#define GYM_MODE_BENCH			(4)

// Train Types
#define GYM_TRAIN_BOX			(5)
#define GYM_TRAIN_KUNG			(6)
#define GYM_TRAIN_KNEE			(7)
#define GYM_TRAIN_GRAB			(8)
#define GYM_TRAIN_ELBOW			(9)

// Cijene stajlova
#define BOX_STYLE_PRICE			1500
#define KUNG_STYLE_PRICE		500
#define KNEE_STYLE_PRICE		3500
#define GRAB_STYLE_PRICE		5000
#define ELBOW_STYLE_PRICE		2000


/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
enum E_GYM_DATA {
	gmMode,
	gmCount,
	PlayerBar:gmBar,	
	Float:gmValue,
	Float:gmDistance,
	Float:gmWntdValue,
	gmHits,
	Timer:gmWntdTimer,
	Timer:gmTimer,
	gmReps,
	gmNeeded
}
static stock
	GymInfo[MAX_PLAYERS][E_GYM_DATA];

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

// 32bit
new
		//objectBells,
        objectBench,
		sprintStatus 	= 0,
		benchStatus 	= 0,
		//bellsStatus 	= 0,
		bikeStatus 		= 0,
		pickupSprint,
		pickupBench,
		//pickupBells,
		pickupBike,
		pickupBags;

// rBits
static stock
	Bit1: r_PlayerExitingGym<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1: r_GymStop <MAX_PLAYERS> = { Bit1: false, ... },
	Bit4: r_PlayerGymMachine <MAX_PLAYERS> = { Bit4: 0, ... },
	Bit8: r_PreviousGymCount <MAX_PLAYERS> = { Bit8: 0, ... };
	
// TextDraws
static stock 
	PlayerText:GymProgressBcg[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GymProgressTxt[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GymProgressTxt1[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GymProgressTxt2[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };


/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
// Callbacks

/*timer SetPlayerBells[1610](playerid)
{
	SetPlayerAttachedObject(playerid, 8, 3072, 5);
	SetPlayerAttachedObject(playerid, 9, 3071, 6);
	return 1;
}*/



hook function ResetPlayerVariables(playerid)
{
    PlayerGym[playerid][pMuscle] = 0;
    PlayerGym[playerid][pGymTimes] = 0;
    PlayerGym[playerid][pGymCounter] = 0;
    PlayerGym[playerid][pFightStyle] = FIGHT_STYLE_NORMAL;

	ResetGymVars(playerid);
	
	static
		e_GymInfo[E_GYM_DATA];
	
	GymInfo[playerid] = e_GymInfo;
	
	stop GymInfo[playerid][gmTimer];
	stop GymInfo[playerid][gmWntdTimer];
	DestroyGymProgressTD(playerid);
	SetCameraBehindPlayer(playerid);
	
	Bit1_Set(r_GymStop, playerid, false);
	Bit1_Set( r_PlayerExitingGym, playerid, false);
	Bit4_Set(r_PlayerGymMachine, playerid, 0);
	Bit8_Set(r_PreviousGymCount, playerid, 0);
	return continue(playerid);
}

timer StartGymBench[50](playerid, mode) 
{
	switch(mode) {
		/*case GYM_MODE_BELLS: {			
			// TextDraws
			CreateGymProgressTD(playerid);
			PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], "REPS: 0");
			PlayerTextDrawSetString(playerid, GymProgressTxt[playerid], "Tegovi");
			
			if(IsValidPlayerProgressBar(playerid, GymInfo[playerid][gmBar])) {
				DestroyPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
				GymInfo[playerid][gmBar] = INVALID_PLAYER_BAR_ID;
			}
			GymInfo[playerid][gmBar] = CreatePlayerProgressBar(playerid, 545.0, 147.0, 55.5, 4.2, -1429936641, 100.0, 0);
			ShowPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
			
			// Vars
			GymInfo[playerid][gmMode] 		= mode;
			GymInfo[playerid][gmReps]		= 0;
			GymInfo[playerid][gmValue] 		= 0.0;
			GymInfo[playerid][gmTimer] 		= repeat OnPlayerUsingGym(playerid, mode);
			GymInfo[playerid][gmNeeded] 	= floatround( PlayerGym[playerid][pMuscle] * 2.4 );
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Sto brze stiscite ~k~~PED_SPRINT~ za bolji progres, a ~k~~VEHICLE_ENTER_EXIT~ za izlazak!\nPotrebno je napraviti %d liftova za Level Up!", GymInfo[playerid][gmNeeded] );
			
			Bit1_Set(r_GymStop, playerid, false);
			
			if(IsValidObject(objectBells))
				DestroyObject(objectBells);
		}*/
		case GYM_MODE_BENCH: {
			// TextDraws
			CreateGymProgressTD(playerid);
			PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], "REPS: 0/0");
			PlayerTextDrawSetString(playerid, GymProgressTxt[playerid], "Bench");
		
			if(IsValidPlayerProgressBar(playerid, GymInfo[playerid][gmBar])) {
				DestroyPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
				GymInfo[playerid][gmBar] = INVALID_PLAYER_BAR_ID;
			}
			GymInfo[playerid][gmBar] = CreatePlayerProgressBar(playerid, 545.0, 147.0, 55.5, 4.2, -1429936641, 100.0, 0);
			ShowPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
		
			// Vars
			GymInfo[playerid][gmMode] 		= mode;
			GymInfo[playerid][gmReps]		= 0;
			GymInfo[playerid][gmValue] 		= 0.0;
			GymInfo[playerid][gmTimer] 		= repeat OnPlayerUsingGym(playerid, mode);
			GymInfo[playerid][gmNeeded] 	= floatround( PlayerGym[playerid][pMuscle] * 2.4 );
			if(GymInfo[playerid][gmNeeded] <= 20)
				GymInfo[playerid][gmNeeded] = 20 + (PlayerGym[playerid][pMuscle] * 2); 
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Sto brze stiscite ~k~~PED_SPRINT~ za bolji progres, a ~k~~VEHICLE_ENTER_EXIT~ za izlazak!\nPotrebno je napraviti %d liftova za Level Up!", GymInfo[playerid][gmNeeded] );
			
			SetPlayerAttachedObject(playerid, 9, 2913, 6);
			Bit1_Set(r_GymStop, playerid, false);
			
			if(IsValidObject(objectBench))
				DestroyObject(objectBench);
		}
	}
}

timer EndGymBench[50](playerid, mode)
{
	TogglePlayerControllable(playerid, true);
	switch(mode) {
		/*case GYM_MODE_BELLS: {
			RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
			objectBells = CreateObject(2915, 772.80933, 5.56540, 999.90002,   0.00000, 0.00000, 90.00000);
			Streamer_Update(playerid);
		}*/
		case GYM_MODE_BENCH: {
			RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
			objectBench = CreateObject(2913, 774.37433, 1.90330, 1000.59998,   90.00000, 0.00000, 0.00000);
			Streamer_Update(playerid);
		}
	}
}

timer OnPlayerUsingGym[250](playerid, mode)
{
	if(playerid == INVALID_PLAYER_ID ) stop GymInfo[playerid][gmTimer];
	switch( mode ) 
	{
		case GYM_MODE_SPRINT: 
		{
			if(GymInfo[playerid][gmValue] >= 100.0 ) GymInfo[playerid][gmValue] = 100.0; 
			if(GymInfo[playerid][gmValue] >= 0.75 ) GymInfo[playerid][gmValue] -= 0.75;
			else 
			{
				if(++GymInfo[playerid][gmCount] >= 16 ) {
					TogglePlayerControllable(playerid, true);
					ApplyAnimationEx(playerid,"GYMNASIUM","gym_walk_falloff", 4.1, 0, 0, 0, 0, 0, 1, 0);
					RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
				}
			}
			if(GymInfo[playerid][gmValue] > 0.5 ) 
			{
				new
					tmpString[32];
				format(tmpString, 32, "DISTANCE: %d/%d", floatround(GymInfo[playerid][gmDistance], floatround_floor), GymInfo[playerid][gmNeeded]);
				PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], tmpString);
				
				if(floatround(GymInfo[playerid][gmDistance]) >= GymInfo[playerid][gmNeeded] ) 
				{
					PlayerGym[playerid][pMuscle]++;
					if(PlayerGym[playerid][pMuscle] >= 50)
							PlayerGym[playerid][pMuscle] = 50;
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli svoj muscle level na %d!", PlayerGym[playerid][pMuscle]);
					PlayerGym[playerid][pGymTimes]++;
					LeavePlayerGym(playerid, GymInfo[playerid][gmMode]);
				}
			}
		}
		/*case GYM_MODE_BELLS: 
		{
			if(GymInfo[playerid][gmValue] >= 2.5 ) {
				GymInfo[playerid][gmValue] -= 2.5;
				ApplyAnimationEx(playerid,"Freeweights","gym_free_down", 2.8, 0, 0, 0, 1, 0, 1, 0);
			}
		}*/
		case GYM_MODE_BIKE:
		 {
			if(GymInfo[playerid][gmValue] >= 100.0 ) GymInfo[playerid][gmValue] = 100.0; 
			if(GymInfo[playerid][gmValue] >= 0.75 ) GymInfo[playerid][gmValue] -= 0.75;
			else {
				if(++GymInfo[playerid][gmCount] >= 16 ) {
					TogglePlayerControllable(playerid, true);
					ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_getoff", 4.1, 0, 0, 0, 0, 0, 1, 0);
					RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
				}
			}
			if(GymInfo[playerid][gmValue] > 1.0 ) 
			{
				new
					tmpString[32];
				format(tmpString, 32, "DISTANCE: %d/%d", floatround(GymInfo[playerid][gmDistance], floatround_floor), GymInfo[playerid][gmNeeded]);
				PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], tmpString);
				
				if(floatround(GymInfo[playerid][gmDistance]) >= GymInfo[playerid][gmNeeded] ) {
					PlayerGym[playerid][pMuscle]++;
					if(PlayerGym[playerid][pMuscle] >= 50)
							PlayerGym[playerid][pMuscle] = 50;
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli svoj muscle level na %d!", PlayerGym[playerid][pMuscle]);
					PlayerGym[playerid][pGymTimes]++;
					LeavePlayerGym(playerid, GymInfo[playerid][gmMode]);
				}
			}
		}
		case GYM_MODE_BENCH: if(GymInfo[playerid][gmValue] >= 2.5 ) GymInfo[playerid][gmValue] -= 2.5;
	}
	SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
	SetPlayerGymAnimation(playerid, GymInfo[playerid][gmMode], GymInfo[playerid][gmValue]);
	return 1;
}

timer OnPlayerGymsWantedValue[GYM_WANTED_TIME](playerid)
{
	if(playerid == INVALID_PLAYER_ID ) stop GymInfo[playerid][gmWntdTimer];
	if(( GymInfo[playerid][gmHits] >= GymInfo[playerid][gmWntdValue] ) && GymInfo[playerid][gmValue] > 0.0 )
	{
		GymInfo[playerid][gmHits] = 0;
		GymInfo[playerid][gmWntdTimer]	= defer OnPlayerGymsWantedValue(playerid);
	} 
	else 
	{
		TogglePlayerControllable(playerid, true);
		ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_falloff", 4.1, 0, 1, 1, 0, 0, 1, 0);
		RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
		stop GymInfo[playerid][gmWntdTimer];
	}
	return 1;
}

timer OnPlayerHitAnimation[1050](playerid, mode)
{
	if(playerid == INVALID_PLAYER_ID || !mode ) return 0;
	switch(mode) 
	{
		/*case GYM_MODE_BELLS: {
			ApplyAnimationEx(playerid,"Freeweights","gym_free_down", 3.2, 0, 0, 0, 1, 0, 1, 0);
			Bit1_Set( r_GymStop, playerid, false );
			GymInfo[playerid][gmTimer] = repeat OnPlayerUsingGym(playerid, mode);
			
			GymInfo[playerid][gmValue] = 0.0;
			SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
		}*/
		case GYM_MODE_BENCH: {
			ApplyAnimationEx(playerid,"benchpress","gym_bp_down", 3.2, 0, 0, 0, 1, 0, 1, 0);
			Bit1_Set( r_GymStop, playerid, false );
			GymInfo[playerid][gmTimer] = defer OnPlayerUsingGym(playerid, mode);
			
			GymInfo[playerid][gmValue] = 0.0;
			SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
		}
	}
	return 1;
}

// Stocks
stock static LeavePlayerGym(playerid, mode = -1)
{
	switch(mode)
	{
		case GYM_MODE_SPRINT: {
			TogglePlayerControllable(playerid, true);
			ApplyAnimationEx(playerid,"GYMNASIUM","gym_walk_falloff", 4.1, 0, 0, 0, 0, 0, 1, 0);
			RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
		}
		/*case GYM_MODE_BELLS: {
			ApplyAnimationEx(playerid,"Freeweights","gym_free_putdown", 4.1, 0, 1, 1, 0, 0, 1, 0);
			defer EndGymBench[2500](playerid, GYM_MODE_BELLS);
		}*/
		case GYM_MODE_BIKE: {
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 772.1906, 8.6423, 1000.9000);
			ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_getoff", 4.1, 0, 0, 0, 0, 0, 1, 0);
			RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
		}
		case GYM_MODE_BENCH: {
			ApplyAnimationEx(playerid,"benchpress","gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1, 0);
			defer EndGymBench[3500](playerid, GYM_MODE_BENCH);
		}
	}
	return 1;
}

stock static RemovePlayerFromGym(playerid, mode = -1)
{
	if(playerid == INVALID_PLAYER_ID || mode == -1 ) return 0;
	
	if(PlayerHealth[playerid][pHunger] >= 1.5 ) PlayerHealth[playerid][pHunger] -= 1.5;
	if(IsValidPlayerProgressBar(playerid, GymInfo[playerid][gmBar])) {
		DestroyPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
		GymInfo[playerid][gmBar] = INVALID_PLAYER_BAR_ID;
	}
	
	if(IsPlayerAttachedObjectSlotUsed(playerid, 8) || IsPlayerAttachedObjectSlotUsed(playerid, 9)) {
		RemovePlayerAttachedObject(playerid, 8);
		RemovePlayerAttachedObject(playerid, 9);
	}
	
	switch( mode ) {
		case GYM_MODE_SPRINT: 	sprintStatus 	= 0;
		case GYM_MODE_BENCH: 	benchStatus 	= 0;
		//case GYM_MODE_BELLS: 	bellsStatus 	= 0;
		case GYM_MODE_BIKE: 	bikeStatus 		= 0;
	}
		
	GymInfo[playerid][gmMode] 		= 0;
	GymInfo[playerid][gmCount]		= 0;
	GymInfo[playerid][gmValue] 		= 0.0;
	GymInfo[playerid][gmDistance] 	= 0.0;
	GymInfo[playerid][gmWntdValue] 	= 0.0;
	GymInfo[playerid][gmHits] 		= 0;
	GymInfo[playerid][gmReps] 		= 0;
	GymInfo[playerid][gmNeeded] 	= 0;
	
	stop GymInfo[playerid][gmTimer];
	stop GymInfo[playerid][gmWntdTimer];
	DestroyGymProgressTD(playerid);
	SetCameraBehindPlayer(playerid);
	
	Bit1_Set(r_GymStop, playerid, false);
	Bit1_Set( r_PlayerExitingGym, playerid, false);
	Bit4_Set(r_PlayerGymMachine, playerid, 0);
	Bit8_Set(r_PreviousGymCount, playerid, 0);
	return 1;
}

stock static GetGymModeWantedProgress(mode)
{
	new
		count = 0;
	switch( mode ) {
		case GYM_MODE_SPRINT: count = 25;
	}
	return count;
}

stock static DestroyGymProgressTD(playerid)
{
	if(GymProgressBcg[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, GymProgressBcg[playerid]);
		GymProgressBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(GymProgressTxt[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, GymProgressTxt[playerid]);
		GymProgressTxt[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(GymProgressTxt1[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, GymProgressTxt1[playerid]);
		GymProgressTxt1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(GymProgressTxt2[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, GymProgressTxt2[playerid]);
		GymProgressTxt2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}
	
stock static CreateGymProgressTD(playerid)
{
	DestroyGymProgressTD(playerid);
	GymProgressBcg[playerid] = CreatePlayerTextDraw(playerid, 606.750183, 129.571990, "usebox");
	PlayerTextDrawLetterSize(playerid, GymProgressBcg[playerid], 0.000000, 5.761103);
	PlayerTextDrawTextSize(playerid, GymProgressBcg[playerid], 471.300018, 0.000000);
	PlayerTextDrawAlignment(playerid, GymProgressBcg[playerid], 1);
	PlayerTextDrawColor(playerid, GymProgressBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, GymProgressBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, GymProgressBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, GymProgressBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GymProgressBcg[playerid], 0);
	PlayerTextDrawFont(playerid, GymProgressBcg[playerid], 0);
	PlayerTextDrawShow(playerid, GymProgressBcg[playerid]);

	GymProgressTxt[playerid] = CreatePlayerTextDraw(playerid, 497.350738, 111.160011, "Trcanje");
	PlayerTextDrawLetterSize(playerid, GymProgressTxt[playerid], 0.678699, 2.671838);
	PlayerTextDrawAlignment(playerid, GymProgressTxt[playerid], 2);
	PlayerTextDrawColor(playerid, GymProgressTxt[playerid], -1);
	PlayerTextDrawSetShadow(playerid, GymProgressTxt[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GymProgressTxt[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GymProgressTxt[playerid], 51);
	PlayerTextDrawFont(playerid, GymProgressTxt[playerid], 0);
	PlayerTextDrawSetProportional(playerid, GymProgressTxt[playerid], 1);
	PlayerTextDrawShow(playerid, GymProgressTxt[playerid]);

	GymProgressTxt1[playerid] = CreatePlayerTextDraw(playerid, 478.000061, 143.640029, "PROGRESS:");
	PlayerTextDrawLetterSize(playerid, GymProgressTxt1[playerid], 0.270000, 1.100000);
	PlayerTextDrawAlignment(playerid, GymProgressTxt1[playerid], 1);
	PlayerTextDrawColor(playerid, GymProgressTxt1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, GymProgressTxt1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GymProgressTxt1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GymProgressTxt1[playerid], 51);
	PlayerTextDrawFont(playerid, GymProgressTxt1[playerid], 2);
	PlayerTextDrawSetProportional(playerid, GymProgressTxt1[playerid], 1);
	PlayerTextDrawShow(playerid, GymProgressTxt1[playerid]);

	GymProgressTxt2[playerid] = CreatePlayerTextDraw(playerid, 477.850097, 158.256027, "DISTANCE: 2000");
	PlayerTextDrawLetterSize(playerid, GymProgressTxt2[playerid], 0.269398, 1.102159);
	PlayerTextDrawAlignment(playerid, GymProgressTxt2[playerid], 1);
	PlayerTextDrawColor(playerid, GymProgressTxt2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, GymProgressTxt2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GymProgressTxt2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GymProgressTxt2[playerid], 51);
	PlayerTextDrawFont(playerid, GymProgressTxt2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, GymProgressTxt2[playerid], 1);
	PlayerTextDrawShow(playerid, GymProgressTxt2[playerid]);
}

stock static InitPlayerGym(playerid, mode = -1)
{
	if(playerid == INVALID_PLAYER_ID || mode == -1 ) return 0;
	// Mode init
	FadeRuletWagesTD(playerid);
	TogglePlayerControllable(playerid, false);
	PlayerGym[playerid][pGymCounter] = 0;
	switch(mode) {
		case GYM_MODE_SPRINT: {
			if(IsValidPlayerProgressBar(playerid, GymInfo[playerid][gmBar])) {
				DestroyPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
				GymInfo[playerid][gmBar] = INVALID_PLAYER_BAR_ID;
			}
			GymInfo[playerid][gmBar] = CreatePlayerProgressBar(playerid, 545.0, 147.0, 55.5, 4.2, -1429936641, 100.0, 0);
			ShowPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
		
			CreateGymProgressTD(playerid);
			SetPlayerPos(playerid, 773.4666, -1.4138, 1000.7261);
			SetPlayerFacingAngle(playerid, 180.0);
			ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_geton", 4.1, 0, 0, 0, 1, 0, 1, 0);
			InterpolateCameraPos(playerid, 774.1841, -4.7128, 1001.5000, 774.1841, -4.7128, 1001.5000, 100000000);
			InterpolateCameraLookAt(playerid, 773.3922, -2.4008, 1000.8000, 773.3922, -2.4008, 1000.8000, 100000000);
			PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], "DISTANCE: 0/0");
			
			// Vars
			GymInfo[playerid][gmMode] 		= mode;
			GymInfo[playerid][gmCount]		= 0;
			GymInfo[playerid][gmValue] 		= 0.0;
			
			GymInfo[playerid][gmWntdValue] 	= GetGymModeWantedProgress(mode);
			GymInfo[playerid][gmWntdTimer]	= defer OnPlayerGymsWantedValue(playerid);
			GymInfo[playerid][gmTimer] 		= repeat OnPlayerUsingGym(playerid, mode);
			GymInfo[playerid][gmNeeded] 	= floatround( PlayerGym[playerid][pMuscle] * 13 );
			if(GymInfo[playerid][gmNeeded] <= 50)
				GymInfo[playerid][gmNeeded] = 50 + (PlayerGym[playerid][pMuscle] * 6);
			sprintStatus = 1;

			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Sto brze stiscite ~k~~PED_SPRINT~ za bolji progres, a ~k~~VEHICLE_ENTER_EXIT~ za izlazak!\nPotrebno je pretrcati %d distance za Level Up!", GymInfo[playerid][gmNeeded] );
			//BizzInfo[12][bTill] -= 5;
		}
		/*case GYM_MODE_BELLS: {			
			SetPlayerPos(playerid, 772.3107, 5.2600, 1000.8000);
			SetPlayerFacingAngle(playerid, 270.0);
			ApplyAnimationEx(playerid,"Freeweights","gym_free_pickup", 4.1, 0, 1, 1, 1, 0, 1, 0);
			InterpolateCameraPos(playerid, 774.3997, 5.3319, 1001.2000, 774.3997, 5.3319, 1001.2000, 100000000);
			InterpolateCameraLookAt(playerid, 772.5566, 5.3319, 1001.2000, 772.5566, 5.3319, 1001.2000, 100000000);
			if(IsPlayerAttachedObjectSlotUsed(playerid, 8))
				RemovePlayerAttachedObject(playerid, 8);
			if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
				RemovePlayerAttachedObject(playerid, 9);
			defer SetPlayerBells(playerid);
			defer StartGymBench[3000](playerid, mode);
			bellsStatus = 1;
			//BizzInfo[12][bTill] -= 2;
		}*/
		case GYM_MODE_BIKE: {
			if(IsValidPlayerProgressBar(playerid, GymInfo[playerid][gmBar])) {
				DestroyPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
				GymInfo[playerid][gmBar] = INVALID_PLAYER_BAR_ID;
			}
			GymInfo[playerid][gmBar] = CreatePlayerProgressBar(playerid, 545.0, 147.0, 55.5, 4.2, -1429936641, 100.0, 0);
			ShowPlayerProgressBar(playerid, GymInfo[playerid][gmBar]);
			
			CreateGymProgressTD(playerid);
			SetPlayerPos(playerid, 772.172+0.5, 9.41406-0.5, 1000.0);
			SetPlayerFacingAngle(playerid, 90.0);
			
			ApplyAnimationEx(playerid,"GYMNASIUM", "gym_bike_geton", 4.1, 0, 0, 0, 1, 0, 1, 0);
			InterpolateCameraPos(playerid, 771.2810, 6.7690, 1001.5, 771.2810, 6.7690, 1001.5, 100000000);
			InterpolateCameraLookAt(playerid, 772.3679, 9.4039, 1001.2, 772.3679, 9.4039, 1001.2, 100000000);
			PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], "DISTANCE: 0");
			PlayerTextDrawSetString(playerid, GymProgressTxt[playerid], "Bicikl");
		
			// Vars
			GymInfo[playerid][gmMode] 		= mode;
			GymInfo[playerid][gmCount]		= 0;
			GymInfo[playerid][gmValue] 		= 0.0;
			GymInfo[playerid][gmTimer] 		= repeat OnPlayerUsingGym(playerid, mode);
			GymInfo[playerid][gmNeeded] 	= floatround( PlayerGym[playerid][pMuscle] * 13 );
			if(GymInfo[playerid][gmNeeded] <= 50)
				GymInfo[playerid][gmNeeded] = 50 + (PlayerGym[playerid][pMuscle] * 6);
			bikeStatus = 1;

			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Sto brze stiscite ~k~~PED_SPRINT~ za bolji progres, a ~k~~VEHICLE_ENTER_EXIT~ za izlazak!\nPotrebno je pretrcati %d distance za Level Up!", GymInfo[playerid][gmNeeded] );
			//BizzInfo[12][bTill] -= 10;
		}
		case GYM_MODE_BENCH: {
			SetPlayerPos(playerid, 773.0491, 1.4285, 1000.7209);
			SetPlayerFacingAngle(playerid, 270.0);
			
			ApplyAnimationEx(playerid,"benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1, 0);
			InterpolateCameraPos(playerid, 772.7518, 2.9976, 1001.0000, 772.7518, 2.9976, 1001.0000, 100000000);
			InterpolateCameraLookAt(playerid, 774.2678, 1.4269, 1000.5500, 774.2678, 1.4269, 1000.5500, 100000000);
			defer StartGymBench[3500](playerid, mode);
			benchStatus = 0;
			//BizzInfo[12][bTill] -= 2;
		}
	}
	return 1;
}

stock static SetPlayerGymAnimation(playerid, mode = -1, Float:value = 0.0)
{
	if(playerid == INVALID_PLAYER_ID || mode == -1 || value == 0.0 ) return 0;
	switch( mode ) {
		case GYM_MODE_SPRINT: {
			switch(floatround(value)) {
				case 1 .. 15: 	ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_walk", 4.1, 1, 0, 0, 0, 0, 1, 0);
				case 16 .. 75:	ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_jog", 4.1, 1, 0, 0, 0, 0, 1, 0);
				case 76 .. 100:	ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_sprint", 4.1, 1, 0, 0, 0, 0, 1, 0);
			}
		}
		case GYM_MODE_BIKE: {
			switch(floatround(value)) {
				case 0:		{ ClearAnimations(playerid, 1); ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1, 0); }
				case 1 .. 65: 	ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_pedal", 4.1, 1, 0, 0, 0, 0, 1, 0);
				case 66 .. 100:	ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_faster", 4.1, 1, 0, 0, 0, 0, 1, 0);
			}
		}
	}
	return 1;
}

stock static GetPlayerGymMachineStatus(playerid)
{
	new
		index = 0;
	switch( Bit4_Get( r_PlayerGymMachine, playerid )) {
		case GYM_MODE_SPRINT: 	{ if(!sprintStatus ) 	index = 1; }
		case GYM_MODE_BENCH: 	{ if(!benchStatus ) 	index = 1; }
		//case GYM_MODE_BELLS: 	{ if(!bellsStatus ) 	index = 1; }
		case GYM_MODE_BIKE: 	{ if(!bikeStatus ) 	index = 1; }
	}
	return index;
}

stock static GetPlayerGymMachine(playerid)
{
	
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 773.4731, -2.5509, 1000.5000)) { Bit4_Set( r_PlayerGymMachine, playerid, GYM_MODE_SPRINT ); return 1; }
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 773.8419, 1.4023, 1000.1384)) { Bit4_Set( r_PlayerGymMachine, playerid, GYM_MODE_BENCH ); return 1; }
	//else if(IsPlayerInRangeOfPoint(playerid, 2.0, 773.0122, 5.4767, 1000.5000)) { Bit4_Set( r_PlayerGymMachine, playerid, GYM_MODE_BELLS ); return 1; }
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 772.2685, 9.4388, 1000.5000)) { Bit4_Set( r_PlayerGymMachine, playerid, GYM_MODE_BIKE ); return 1; }
	return 0;
}

// Trening
stock static GetPlayerTrainFightingStyle(playerid)
{
	new
		style = FIGHT_STYLE_NORMAL;
	
	switch( GymInfo[playerid][gmMode] ) {
		case GYM_TRAIN_BOX: 	style = FIGHT_STYLE_BOXING;
		case GYM_TRAIN_KUNG:	style = FIGHT_STYLE_KUNGFU;
		case GYM_TRAIN_ELBOW: 	style = FIGHT_STYLE_ELBOW;
		case GYM_TRAIN_GRAB: 	style = FIGHT_STYLE_GRABKICK;
		case GYM_TRAIN_KNEE: 	style = FIGHT_STYLE_KNEEHEAD;
	}
	return style;
}

stock static GetGymTrainingCount(playerid, mode=-1)
{
	if(playerid == INVALID_PLAYER_ID || mode == -1 ) return 0;
	new
		index = -1;
	
	switch( mode ) {
		case GYM_TRAIN_BOX: 	index = 75;
		case GYM_TRAIN_KUNG: 	index = 50;
		case GYM_TRAIN_ELBOW: 	index = 95;
		case GYM_TRAIN_GRAB:	index = 110;
		case GYM_TRAIN_KNEE:	index = 120;
	}
	return index;
}

stock static InitPlayerTraining(playerid, mode=-1)
{
	if(playerid == INVALID_PLAYER_ID || mode == -1 ) return 0;
	
	GymInfo[playerid][gmMode] 	= mode;
	GymInfo[playerid][gmCount] 	= 0;
	GymInfo[playerid][gmNeeded] = GetGymTrainingCount(playerid, mode);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Udarajte u vrece %d s ~k~~PED_FIREWEAPON~ puta da predjete razinu!", GymInfo[playerid][gmNeeded]);
	GameTextForPlayer(playerid,"~y~]]]", 200000, 4);
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
	//objectBells = CreateObject(2915, 772.80933, 5.56540, 999.90002,   0.00000, 0.00000, 90.00000);	// Bells
	objectBench = CreateObject(2913, 774.37433, 1.90330, 1000.59998,   90.00000, 0.00000, 0.00000); 	// Bench
	
	// Info Pickups
	pickupSprint = CreateDynamicPickup(19300, 2, 773.4230, -1.1890, 1000.5000, -1, 5, -1, 15.0);
	pickupBench  = CreateDynamicPickup(19300, 2, 772.7550, 1.4146, 1000.5000, -1, 5, -1, 15.0);
	//pickupBells  = CreateDynamicPickup(19300, 2, 770.5363, 5.3818, 1000.5000, -1, 5, -1, 15.0);
	pickupBike   = CreateDynamicPickup(19300, 2, 772.0385, 8.6523, 1000.5000, -1, 5, -1, 15.0);
	pickupBags   = CreateDynamicPickup(19300, 2, 769.4525, -2.4896, 1000.5000, -1, 5, -1, 15.0);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	ApplyAnimationEx(playerid,"Freeweights","null",0.0,0,0,0,0,0,1,0);
	ApplyAnimationEx(playerid,"GYMNASIUM","null",0.0,0,0,0,0,0,1,0);
	ApplyAnimationEx(playerid,"benchpress","null",0.0,0,0,0,0,0,1,0);
	return 1;
}

ResetGymVars(playerid)
{
	if(GymInfo[playerid][gmMode] != 0) 
		RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
	return 1;	
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) {
		case DIALOG_GYM_TRAIN: {
			if(!response ) return 1;
			
			switch( listitem ) {
				case 0: { // Box
					if(PlayerGym[playerid][pMuscle] < 25 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 25+ razinu misica!");
					if(AC_GetPlayerMoney(playerid) < BOX_STYLE_PRICE ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kod sebe %d$!", BOX_STYLE_PRICE);
					InitPlayerTraining(playerid, GYM_TRAIN_BOX);
					PlayerToBusinessMoneyTAX(playerid, 12, BOX_STYLE_PRICE);
					
				}
				case 1: { // Kung Fu
					if(PlayerGym[playerid][pMuscle] < 20 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 20+ razinu misica!");
					if(AC_GetPlayerMoney(playerid) < KUNG_STYLE_PRICE ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kod sebe %d$!", KUNG_STYLE_PRICE);
					InitPlayerTraining(playerid, GYM_TRAIN_KUNG);
					PlayerToBusinessMoneyTAX(playerid, 12, KUNG_STYLE_PRICE);
					va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Platili ste %d$ za poducavanje novog stila tucnjave!", KUNG_STYLE_PRICE);
				}
				case 2: { // Knee Head
					if(PlayerGym[playerid][pMuscle] < 35 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 35+ razinu misica!");
					if(AC_GetPlayerMoney(playerid) < KNEE_STYLE_PRICE ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kod sebe %d$!", KNEE_STYLE_PRICE);
					InitPlayerTraining(playerid, GYM_TRAIN_KNEE);
					PlayerToBusinessMoneyTAX(playerid, 12, KNEE_STYLE_PRICE);
					va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Platili ste %d$ za poducavanje novog stila tucnjave!", KNEE_STYLE_PRICE);
				}
				case 3: { // Grab 'n' Kick
					if(PlayerGym[playerid][pMuscle] < 40 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 40+ razinu misica!");
					if(AC_GetPlayerMoney(playerid) < GRAB_STYLE_PRICE ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kod sebe %d$!", GRAB_STYLE_PRICE);
					InitPlayerTraining(playerid, GYM_TRAIN_GRAB);
					PlayerToBusinessMoneyTAX(playerid, 12, GRAB_STYLE_PRICE);
					va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Platili ste %d$ za poducavanje novog stila tucnjave!", GRAB_STYLE_PRICE);
				}
				case 4: { // Elbow
					if(PlayerGym[playerid][pMuscle] < 45 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 45+ razinu misica!");
					if(AC_GetPlayerMoney(playerid) < ELBOW_STYLE_PRICE ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kod sebe %d$!", ELBOW_STYLE_PRICE);
					InitPlayerTraining(playerid, GYM_TRAIN_ELBOW);
					PlayerToBusinessMoneyTAX(playerid, 12, ELBOW_STYLE_PRICE);
					va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Platili ste %d$ za poducavanje novog stila tucnjave!", ELBOW_STYLE_PRICE);
				}
			}
			return 1;
		}
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE)) 
	{
		if(GymInfo[playerid][gmMode] != 0 && GymInfo[playerid][gmCount] > 0 && GymInfo[playerid][gmCount] != (Bit8_Get(r_PreviousGymCount, playerid)))
		{
			Bit8_Set(r_PreviousGymCount, playerid, GymInfo[playerid][gmCount]);
			Player_SetAFK(playerid, 0);
		}
		if(5 <= GymInfo[playerid][gmMode] <= 9 )
		 {
			if(IsPlayerInRangeOfPoint(playerid, 3.5, 769.4609, -3.2109, 1002.4531)) {
				if(GetPlayerAnimationIndex(playerid) == 1137 || GetPlayerAnimationIndex(playerid) == 1138 ) return 1;
				if(++GymInfo[playerid][gmCount] >= GymInfo[playerid][gmNeeded] ) 
				{
					switch( ++GymInfo[playerid][gmHits] ) 
					{
						case 1: GameTextForPlayer(playerid,"~b~]~y~]]", 200000, 4);
						case 2: GameTextForPlayer(playerid,"~b~]] ~y~]", 200000, 4);
						case 3: { 
							GameTextForPlayer(playerid,"DONE", 250, 4);
							SetPlayerFightingStyle(playerid, GetPlayerTrainFightingStyle(playerid));
							PlayerGym[playerid][pFightStyle] = GetPlayerTrainFightingStyle(playerid);
							RemovePlayerFromGym(playerid, GymInfo[playerid][gmMode]);
							return 1;
						}
					}
					
					GymInfo[playerid][gmCount] 	= 0;
					GymInfo[playerid][gmNeeded] = GetGymTrainingCount(playerid, GymInfo[playerid][gmMode]);
				}
			}
		}
	}

	if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT)) 
	{
		switch( GymInfo[playerid][gmMode] ) 
		{
			case GYM_MODE_SPRINT: 
			{
				GymInfo[playerid][gmValue] += 1.5;
				if(GymInfo[playerid][gmValue] >= 75.0 ) 
					GymInfo[playerid][gmDistance] += 0.14;
				SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
				SetPlayerGymAnimation(playerid, GymInfo[playerid][gmMode], GymInfo[playerid][gmValue]);
				GymInfo[playerid][gmHits]++;
			}
			/*case GYM_MODE_BELLS: 
			{
				if(Bit1_Get( r_GymStop, playerid )) return 1;
				GymInfo[playerid][gmValue] += 5.0;
				SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
				if(GymInfo[playerid][gmValue] >= 100.0 ) {
					// Vars
					GymInfo[playerid][gmReps]++;
					ApplyAnimationEx(playerid,"Freeweights","gym_free_B", 3.2, 0, 0, 0, 1, 0, 1, 0);
					stop GymInfo[playerid][gmTimer];
					GymInfo[playerid][gmWntdTimer] = defer OnPlayerHitAnimation(playerid, GymInfo[playerid][gmMode]);
					Bit1_Set( r_GymStop, playerid, true );
					
					// TextDraws
					new
						tmpString[32];
					format(tmpString, 32, "REPS: %d/%d", GymInfo[playerid][gmReps], GymInfo[playerid][gmNeeded]);
					PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], tmpString);
					GymInfo[playerid][gmValue] = 0.0;
					
					if(GymInfo[playerid][gmReps] >= GymInfo[playerid][gmNeeded] ) {
						PlayerGym[playerid][pMuscle]++;
						if(PlayerGym[playerid][pMuscle] >= 50)
							PlayerGym[playerid][pMuscle] = 50;
						SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli svoj muscle level na %d!", PlayerGym[playerid][pMuscle]);
						PlayerGym[playerid][pGymTimes]++;
						LeavePlayerGym(playerid, GymInfo[playerid][gmMode]);
					}
					return 1;
				}
				ApplyAnimationEx(playerid,"Freeweights","gym_free_B", 2.5, 0, 0, 0, 1, 0, 1, 0);
			}*/
			case GYM_MODE_BIKE: 
			{
				GymInfo[playerid][gmValue] += 1.5;
				if(GymInfo[playerid][gmValue] >= 75.0 ) 
					GymInfo[playerid][gmDistance] += 0.14;
				SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
				SetPlayerGymAnimation(playerid, GymInfo[playerid][gmMode], GymInfo[playerid][gmValue]);
			}
			case GYM_MODE_BENCH: 
			{
				if(Bit1_Get( r_GymStop, playerid )) return 1;
				GymInfo[playerid][gmValue] += 5.0;
				SetPlayerProgressBarValue(playerid, GymInfo[playerid][gmBar], GymInfo[playerid][gmValue]);
				if(GymInfo[playerid][gmValue] >= 100.0 ) 
				{
					// Vars
					GymInfo[playerid][gmReps]++;
					ApplyAnimationEx(playerid,"benchpress","gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1, 0);
					stop GymInfo[playerid][gmTimer];
					GymInfo[playerid][gmWntdTimer] = defer OnPlayerHitAnimation(playerid, GymInfo[playerid][gmMode]);
					Bit1_Set( r_GymStop, playerid, true );
					
					// TextDraws
					new
						tmpString[32];
					format(tmpString, 32, "REPS: %d/%d", GymInfo[playerid][gmReps], GymInfo[playerid][gmNeeded]);
					PlayerTextDrawSetString(playerid, GymProgressTxt2[playerid], tmpString);
					GymInfo[playerid][gmValue] = 0.0;

					if(GymInfo[playerid][gmReps] >= GymInfo[playerid][gmNeeded] ) 
					{
						PlayerGym[playerid][pMuscle]++;
						if(PlayerGym[playerid][pMuscle] >= 50)
							PlayerGym[playerid][pMuscle] = 50;
						SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli svoj muscle level na %d!", PlayerGym[playerid][pMuscle]);
						PlayerGym[playerid][pGymTimes]++;
						LeavePlayerGym(playerid, GymInfo[playerid][gmMode]);
					}
					return 1;
				}
			}
		}
	}
	
	if(PRESSED(KEY_YES)) 
	{
		if(IsPlayerInRangeOfPoint(playerid, 100.0, 772.111999,-3.898649,1000.728820)) 
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.5, 769.4609, -3.2109, 1002.4531)) 
			{
				ShowPlayerDialog(playerid, DIALOG_GYM_TRAIN, DIALOG_STYLE_LIST, "Gym Trening", "Box (1500$)\nKung Fu (500$)\nKnee Head (3500$)\nGrab Kick (5000$)\nElbow (2000$)", "Choose", "Abort");
				return 1;
			}
			
			if(PlayerGym[playerid][pGymTimes] > 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Treba proci 3 barem Paydaya od zadnjeg treninga da bi ponovno trenirali!");
			if(!GetPlayerGymMachine(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred sprava u teretani!");
			if(!GetPlayerGymMachineStatus(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sprava je zauzeta!");
			//if(PlayerHealth[playerid][pHunger] < 1.5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete gladni vjezbati (minimalno 1.5 level)!");
			InitPlayerGym(playerid, Bit4_Get( r_PlayerGymMachine, playerid ));
		}
	}
	
	if(PRESSED(KEY_SECONDARY_ATTACK)) 
	{
		if(Bit1_Get( r_PlayerExitingGym, playerid )) return 1;
		LeavePlayerGym(playerid, GymInfo[playerid][gmMode]);
	}
	return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(pickupid == pickupSprint ) {
		ShowRuletPickupTDs(playerid);
		new	
			tmpString[46];
		PlayerTextDrawSetString(playerid, RuletTitle[playerid], "   Sprint track");
		format( tmpString, 46, "Naziv: Sprava za trcanje~n~Status: %s",
			( sprintStatus ? ("~r~Zauzeta") : ("~g~Slobodna"))
		);
		PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
		PlayerTextDrawSetString( playerid, RuletNote[playerid], "Kliknite tipku ~k~~CONVERSATION_YES~ za vjezbanje");
		defer FadeRuletWagesTD(playerid);
	}
	else if(pickupid == pickupBench ) {
		ShowRuletPickupTDs(playerid);
		new	
			tmpString[46];
		PlayerTextDrawSetString(playerid, RuletTitle[playerid], " Bench");
		format( tmpString, 46, "Naziv: Bench~n~Status: %s",
			( benchStatus ? ("~r~Zauzeta") : ("~g~Slobodna"))
		);
		PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
		PlayerTextDrawSetString( playerid, RuletNote[playerid], "Kliknite tipku ~k~~CONVERSATION_YES~ za vjezbanje");
		defer FadeRuletWagesTD(playerid);
	}
	/*else if(pickupid == pickupBells ) {
		ShowRuletPickupTDs(playerid);
		new	
			tmpString[46];
		PlayerTextDrawSetString(playerid, RuletTitle[playerid], " Tegovi");
		format( tmpString, 46, "Naziv: Tegovi~n~Status: %s",
			( bellsStatus ? ("~r~Zauzeta") : ("~g~Slobodna"))
		);
		PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
		PlayerTextDrawSetString( playerid, RuletNote[playerid], "Kliknite tipku ~k~~CONVERSATION_YES~ za vjezbanje");
		defer FadeRuletWagesTD(playerid);
	}*/
	else if(pickupid == pickupBike ) {
		ShowRuletPickupTDs(playerid);
		new	
			tmpString[46];
		PlayerTextDrawSetString(playerid, RuletTitle[playerid], " Bicikl");
		format( tmpString, 46, "Naziv: Bicikl~n~Status: %s",
			( bikeStatus ? ("~r~Zauzeta") : ("~g~Slobodna"))
		);
		PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
		PlayerTextDrawSetString( playerid, RuletNote[playerid], "Kliknite tipku ~k~~CONVERSATION_YES~ za vjezbanje");
		defer FadeRuletWagesTD(playerid);
	}
	else if(pickupid == pickupBags ) {
		ShowRuletPickupTDs(playerid);
		PlayerTextDrawSetString(playerid, RuletTitle[playerid], " Trening vrece");
		PlayerTextDrawSetString(playerid, RuletWages[playerid], "Vrece~n~Potreban muscle level: 10");
		PlayerTextDrawSetString( playerid, RuletNote[playerid], "Kliknite tipku ~k~~CONVERSATION_YES~ za vjezbanje");
		defer FadeRuletWagesTD(playerid);
	}
	return 1;
}

/*

                                                                      
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'                             

*/

LoadPlayerFitness(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_fitness WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerFitness", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerFitness(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_fitness(sqlid, muscle, gymtimes, gymcounter, fightstyle) \n\
                VALUES('%d', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0, "muscle"		, PlayerGym[playerid][pMuscle]);
    cache_get_value_name_int(0,	"gymtimes"		, PlayerGym[playerid][pGymTimes]);
	cache_get_value_name_int(0,	"gymcounter"	, PlayerGym[playerid][pGymCounter]);
    cache_get_value_name_int(0,	"fightstyle"	, PlayerGym[playerid][pFightStyle]);
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerFitness(playerid);
	return continue(playerid);
}

SavePlayerFitness(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_fitness SET muscle = '%d', gymtimes = '%d', gymcounter = '%d', fightstyle = '%d' WHERE sqlid = '%d'",
        PlayerGym[playerid][pMuscle],
        PlayerGym[playerid][pGymTimes],
        PlayerGym[playerid][pGymCounter],
        PlayerGym[playerid][pFightStyle],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerFitness(playerid);
	return continue(playerid);
}
