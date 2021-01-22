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
#define MAX_STRIPPERS			(10)
#define STRIPTIZ_CP_SIZE		(1.2)

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/	
enum E_STRIPPER_CAMERA_DATA {
	Float:camX,
	Float:camY,
	Float:camZ
}
static stock
	StripCamera[][E_STRIPPER_CAMERA_DATA] = {
		{ 1206.5167, 14.1947, 1002.4015 },
		{ 1203.0289, 14.5532, 1002.4015 },
		{ 1202.4108, 18.3549, 1001.2000 },
		{ 1206.7811, 17.9049, 1001.9000 },
		{ 1204.5240, 17.4066, 1001.0663 }
	};

enum E_STRIPPER_DANCE_DATA {
	sdLib[6],
	sdName[8]
}
static stock
	StripAnim[][E_STRIPPER_DANCE_DATA] = {
		{ "STRIP", "strip_A"},
		{ "STRIP", "strip_B"},
		{ "STRIP", "strip_C"},
		{ "STRIP", "strip_D"},
		{ "STRIP", "strip_E"},
		{ "STRIP", "strip_F"},
		{ "STRIP", "strip_G"},
		{ "STRIP", "STR_A2B"},
		{ "STRIP", "STR_B2C"},
		{ "STRIP", "STR_C1" },
		{ "STRIP", "STR_C2" }
	};

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
static stock
	StriptizCashCP,
	StriptizRoomCP,
	StripperActorId[4] = { INVALID_ACTOR_ID , ... },
	PlayerStripperActor[MAX_PLAYERS] = { INVALID_ACTOR_ID, ... },
	StripperView[MAX_PLAYERS];
	
static stock
	PlayerText:LapBcg[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:LapText[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:StripEffect1[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:StripEffect2[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };
	
static stock
	Bit1: r_PlayerInLapDance <MAX_PLAYERS>;

static stock
	StripperSkins[10] = { 178, 237, 238, 244, 207, 246, 256, 257, 64, 87 };


/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static InitStripperActors()
{
	new 
		animId;
	// Staticne plesacice po klubu
	StripperActorId[0] = CreateActor(StripperSkins[random(sizeof(StripperSkins))], 1213.8285, -4.4425, 1001.3000, 	19.9);
	StripperActorId[1] = CreateActor(StripperSkins[random(sizeof(StripperSkins))], 1220.2628, -6.7056, 1001.3000, 	90.0);
	StripperActorId[2] = CreateActor(StripperSkins[random(sizeof(StripperSkins))], 1220.9323, 8.2174, 1001.4000, 	65.3);
	
	animId = random(sizeof(StripAnim));
	ApplyActorAnimation(StripperActorId[0], StripAnim[animId][sdLib], StripAnim[animId][sdName], 4.1, 1, 1, 1, 1, 0);
	SetActorVirtualWorld(StripperActorId[0], 53);
	SetActorInvulnerable(StripperActorId[0], true);
	
	animId = random(sizeof(StripAnim));
	ApplyActorAnimation(StripperActorId[1], StripAnim[animId][sdLib], StripAnim[animId][sdName], 4.1, 1, 1, 1, 1, 0);
	SetActorVirtualWorld(StripperActorId[1], 53);
	SetActorInvulnerable(StripperActorId[1], true);
	
	animId = random(sizeof(StripAnim));
	ApplyActorAnimation(StripperActorId[2], StripAnim[animId][sdLib], StripAnim[animId][sdName], 4.1, 1, 1, 1, 1, 0);
	SetActorVirtualWorld(StripperActorId[2], 53);
	SetActorInvulnerable(StripperActorId[2], true);
	
	// Pickup
	StriptizCashCP = CreateDynamicPickup(19300, 2, 1212.7241, -6.1868, 999.9236, 53, 2, -1, 15.0);
	StriptizRoomCP = CreateDynamicPickup(19300, 2, 1204.7827, 12.2824, 999.9198, 53, 2, -1, 15.0);
}

stock static CreateLapDanceTextDraw(playerid)
{
	DestroyLapDanceTextDraw(playerid);
	LapBcg[playerid] = CreatePlayerTextDraw(playerid, 467.020233, 112.566680, "usebox");
	PlayerTextDrawLetterSize(playerid, LapBcg[playerid], 0.000000, 5.333556);
	PlayerTextDrawTextSize(playerid, LapBcg[playerid], 629.900146, 0.000000);
	PlayerTextDrawAlignment(playerid, LapBcg[playerid], 1);
	PlayerTextDrawColor(playerid, LapBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, LapBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, LapBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, LapBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LapBcg[playerid], 0);
	PlayerTextDrawFont(playerid, LapBcg[playerid], 0);
	PlayerTextDrawShow(playerid, LapBcg[playerid]);
	
	LapText[playerid] = CreatePlayerTextDraw(playerid, 471.640441, 118.402671, "~k~~VEHICLE_ENTER_EXIT~ za izlazak~n~~k~~PED_SPRINT~ za promjenu pogleda~n~~k~~CONVERSATION_YES~ za promjenu plesa (50$)");
	PlayerTextDrawLetterSize(playerid, LapText[playerid], 0.323989, 1.300960);
	PlayerTextDrawAlignment(playerid, LapText[playerid], 1);
	PlayerTextDrawColor(playerid, LapText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, LapText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LapText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, LapText[playerid], 51);
	PlayerTextDrawFont(playerid, LapText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, LapText[playerid], 1);
	PlayerTextDrawShow(playerid, LapText[playerid]);
	
	StripEffect1[playerid] = CreatePlayerTextDraw(playerid, 644.799926, 1.500000, "usebox");
	PlayerTextDrawLetterSize(playerid, StripEffect1[playerid], 0.000000, 9.346665);
	PlayerTextDrawTextSize(playerid, StripEffect1[playerid], -2.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, StripEffect1[playerid], 1);
	PlayerTextDrawColor(playerid, StripEffect1[playerid], 0);
	PlayerTextDrawUseBox(playerid, StripEffect1[playerid], true);
	PlayerTextDrawBoxColor(playerid, StripEffect1[playerid], 255);
	PlayerTextDrawSetShadow(playerid, StripEffect1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, StripEffect1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, StripEffect1[playerid], 255);
	PlayerTextDrawFont(playerid, StripEffect1[playerid], 0);
	PlayerTextDrawShow(playerid, StripEffect1[playerid]);

	StripEffect2[playerid] = CreatePlayerTextDraw(playerid, 641.500000, 376.699981, "usebox");
	PlayerTextDrawLetterSize(playerid, StripEffect2[playerid], 0.000000, 7.710002);
	PlayerTextDrawTextSize(playerid, StripEffect2[playerid], -2.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, StripEffect2[playerid], 1);
	PlayerTextDrawColor(playerid, StripEffect2[playerid], 0);
	PlayerTextDrawUseBox(playerid, StripEffect2[playerid], true);
	PlayerTextDrawBoxColor(playerid, StripEffect2[playerid], 255);
	PlayerTextDrawSetShadow(playerid, StripEffect2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, StripEffect2[playerid], 0);
	PlayerTextDrawFont(playerid, StripEffect2[playerid], 0);
	PlayerTextDrawShow(playerid, StripEffect2[playerid]);
}

stock InitStripperDanceActor(playerid)
{
	if(AC_GetPlayerMoney(playerid) < 100 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca!");
	
	PlayerToBudgetMoney(playerid, 100);
	PlayerStripperActor[playerid] = CreateActor(StripperSkins[random(sizeof(StripperSkins))], 1204.1025, 16.6808, 1000.9219, 149.2798);
	SetActorVirtualWorld(PlayerStripperActor[playerid], playerid);
	
	new
		animId = random(sizeof(StripAnim));
	ApplyActorAnimation(PlayerStripperActor[playerid], StripAnim[animId][sdLib], StripAnim[animId][sdName], 4.1, 1, 0, 0, 0, 0);
	
	SetPlayerInterior(playerid, 2);
	SetPlayerVirtualWorld(playerid, playerid);
	SetPlayerPos(playerid, 1204.5259, 17.3894, 1000.9219);
	SetPlayerFacingAngle(playerid, 144.6724);
	ApplyAnimation(playerid, "INT_HOUSE", "LOU_Loop", 4.1, 1, 0, 0, 1, 0);
	InterpolateCameraPos(playerid, StripCamera[0][camX], StripCamera[0][camY], StripCamera[0][camZ], StripCamera[0][camX], StripCamera[0][camY], StripCamera[0][camZ], 100000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 1204.4751,17.2457,1000.9219, 1204.4751,17.2457,1000.9219, 100000, CAMERA_CUT);
	Bit1_Set( r_PlayerInLapDance, playerid, true );
	StripperView[playerid] = 0;
	CreateLapDanceTextDraw(playerid);
	return 1;
}

stock static DestroyLapDanceTextDraw(playerid)
{
	if(LapBcg[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, LapBcg[playerid]);
		LapBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(LapText[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, LapText[playerid]);
		LapText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(StripEffect1[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, StripEffect1[playerid]);
		StripEffect1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(StripEffect2[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, StripEffect2[playerid]);
		StripEffect2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
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
	InitStripperActors();
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsValidActor(PlayerStripperActor[playerid])) {
		DestroyActor(PlayerStripperActor[playerid]);
		PlayerStripperActor[playerid] = INVALID_ACTOR_ID;
		Bit1_Set( r_PlayerInLapDance, playerid, false );
		StripperView[playerid] = 0;
		DestroyLapDanceTextDraw(playerid);
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SECONDARY_ATTACK)) {
		if(Bit1_Get( r_PlayerInLapDance, playerid )) {
			if(IsValidActor(PlayerStripperActor[playerid])) {
				DestroyActor(PlayerStripperActor[playerid]);
				PlayerStripperActor[playerid] = INVALID_ACTOR_ID;
			}
			
			SetPlayerPos(playerid, 1204.8041, 12.4384, 1001.2000);
			SetCameraBehindPlayer(playerid);
			
			new 
				biznis = Player_InBusiness(playerid);
			if(biznis != INVALID_BIZNIS_ID ) {
				SetPlayerInterior(playerid, BizzInfo[biznis][bInterior]);
				SetPlayerVirtualWorld(playerid, BizzInfo[biznis][bVirtualWorld]); 
			}
			DestroyLapDanceTextDraw(playerid);
			Bit1_Set( r_PlayerInLapDance, playerid, false );
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1204.7827, 12.2824, 999.9198)) {
			InitStripperDanceActor(playerid);
		}
	}
	
	if(PRESSED(KEY_SPRINT)) {
		if(Bit1_Get( r_PlayerInLapDance, playerid )) {
			new
				view = StripperView[playerid];
			if(++view >= 5 ) 
				view = 0;
			
			InterpolateCameraPos(playerid, StripCamera[StripperView[playerid]][camX], StripCamera[StripperView[playerid]][camY], StripCamera[StripperView[playerid]][camZ], StripCamera[view][camX], StripCamera[view][camY], StripCamera[view][camZ], 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1204.4751,17.2457,1000.9219, 1204.4751,17.2457,1000.9219, 1000000, CAMERA_MOVE);
			StripperView[playerid] = view;
			PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
		}

		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1212.7241, -6.1868, 999.9236) && AC_GetPlayerMoney(playerid) < 25 ) {
			ApplyAnimation(playerid, "STRIP", "PLY_CASH", 4.0, 0, 1, 1, 1, 1); 
			PlayerToBudgetMoney(playerid, 25);
		}
	}
	
	if(PRESSED(KEY_YES)) {
		if(!Bit1_Get( r_PlayerInLapDance, playerid )) return 1;
		
		new
			animId = random(sizeof(StripAnim));
		ApplyActorAnimation(PlayerStripperActor[playerid], StripAnim[animId][sdLib], StripAnim[animId][sdName], 4.1, 1, 0, 0, 0, 0);
		PlayerToBudgetMoney(playerid, 50);
	}
	return 1;
}