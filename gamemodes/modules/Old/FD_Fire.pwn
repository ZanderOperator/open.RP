/* 
*		 Fire Department - Fire 
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/


#include <YSI_Coding\y_hooks>

/*
	- defines & enumerator
*/
#define DEFAULT_FIRE_HEALTH			(5000) 	// Defualt Health od Vatre
#define MAX_FIRE_HEALTH				(30000) 	// Maximalan Health od Vatre
#define FD_BUDGET_INCREASE			(1500)		// Novac koji FD dobiva za obavljen posao.
#define CREATE_FIRE_TIME			(120) 		// Svakih "CREATE_FIRE_TIME/60"server kreira pozar.
#define CHECK_FIRE_TIME				(45)		// Svakih 45 minuta provjera pozara

enum fire_enum {
	f_ID,
    f_Object,
    f_Interior,
	f_health,
	
    Float: f_Pos[3],
	Text3D: f_Label
};
new FireData[MAX_SERVER_FLAMES][fire_enum];

/*
	- vars & iters
*/
new	
	Iterator:FlameID_Iter<MAX_SERVER_FLAMES>,
	PlayerText:PanicAlarm_TD[MAX_PLAYERS][16],
	
	GetFlameDialogID[MAX_PLAYERS] = INVALID_OBJECT_ID,
	Panic_Timer[MAX_PLAYERS],
	
	ServerFireTimer,
	FireActivatedTimer,
	
	Float:GetDistanceToSituation[MAX_PLAYERS],
	Float:FireSituation_CP[3],
	
	bool: fire_activated = false;
	
/*
	- Global Functions
*/
CreateServerFlame(interior = 0, vw = 0, Float:x, Float:y, Float:z, Health) {
	new fire_id = Iter_Free(FlameID_Iter), buffer[128];
	
	// Fire 
	FireData[fire_id][f_ID] = fire_id;
    Iter_Add(FlameID_Iter, fire_id);
	
	// Create Fire
	FireData[fire_id][f_Object] = CreateDynamicObject(18691, x,y,z - 2.0, 0.0, 0.0, 0.0, vw, interior, -1, 800.0);
	FireData[fire_id][f_Pos][0] = x; 
	FireData[fire_id][f_Pos][1] = y; 
	FireData[fire_id][f_Pos][2] = z-2.0;
	
	FireData[fire_id][f_health] = Health;
	FireData[fire_id][f_ID] 	= fire_id;
	
	// Create Label
  	format(buffer, sizeof(buffer), "(%d) %d", FireData[fire_id][f_ID], FireData[fire_id][f_health]);
  	FireData[fire_id][f_Label] = CreateDynamic3DTextLabel(buffer, 0x008080FF, x, y, z+1, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw, interior);
  	return (true);
}

DestroyServerFlame(fire_id) {
	// Destroy Object + Label
	if(IsValidDynamicObject(FireData[fire_id][f_Object]))
		DestroyDynamicObject(FireData[fire_id][f_Object]);
		
	if(IsValidDynamic3DTextLabel(FireData[fire_id][f_Label])) 
		DestroyDynamic3DTextLabel(FireData[fire_id][f_Label]);
		
	// Empty Fire Data.	
	FireData[fire_id][f_ID] 		    = -1;		
    FireData[fire_id][f_Interior]	 	= 0;
	FireData[fire_id][f_health] 		= 0;
	FireData[fire_id][f_Pos][0] 		= 0,
	FireData[fire_id][f_Pos][1] 		= 0, 
	FireData[fire_id][f_Pos][2] 		= 0;
	
	// remove iter.
	Iter_Remove(FlameID_Iter, fire_id);
	
	if(Iter_Count(FlameID_Iter) == 0) {
		fire_activated = false; 
		BudgetToOrgMoney ( FACTION_TYPE_FD, FD_BUDGET_INCREASE ); 
		SendLawMessage(COLOR_ALLDEPT, "** [LSFD HQ] : Pozar je uspjesno ugasen. Hvala svima na intervenciji.");
	}
 	return (true);
}

DestroyAllServerFlames() {
	if(Iter_Count(FlameID_Iter) == 0) 
		return (true);
	
	foreach(new fire_id: FlameID_Iter) {
		if(IsValidDynamicObject(FireData[fire_id][f_Object]))
		DestroyDynamicObject(FireData[fire_id][f_Object]);
		
		if(IsValidDynamic3DTextLabel(FireData[fire_id][f_Label])) 
			DestroyDynamic3DTextLabel(FireData[fire_id][f_Label]);
			
		// Empty Fire Data.	
		FireData[fire_id][f_ID] 		    = -1;		
		FireData[fire_id][f_Interior]	 	= 0;
		FireData[fire_id][f_health] 		= 0;
		FireData[fire_id][f_Pos][0] 		= 0,
		FireData[fire_id][f_Pos][1] 		= 0, 
		FireData[fire_id][f_Pos][2] 		= 0;
	}
	Iter_Clear(FlameID_Iter);
	fire_activated = false; 
	
	foreach(new i: Player)
		CreatePanicAlarm(i, false);
	return (true);
}

MoveServerFlame(fire_id, playerid) {
	new Float: X, Float: Y, Float: Z, buffer[128];
	GetPlayerPos(playerid, X, Y, Z);
	
	// Destroy Fire
	if(IsValidDynamicObject(FireData[fire_id][f_Object]))
		DestroyDynamicObject(FireData[fire_id][f_Object]);
		
	if(IsValidDynamic3DTextLabel(FireData[fire_id][f_Label])) 
		DestroyDynamic3DTextLabel(FireData[fire_id][f_Label]);
	
	// Create Fire
	FireData[fire_id][f_Object] 		= CreateDynamicObject(18691, X,Y, Z - 2.0, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 800.0);
	FireData[fire_id][f_Pos][0] 		= X,
	FireData[fire_id][f_Pos][1] 		= Y, 
	FireData[fire_id][f_Pos][2] 		= Z - 2;
		
  	format(buffer, sizeof(buffer), "(%d) %d", FireData[fire_id][f_ID], FireData[fire_id][f_health]);
  	FireData[fire_id][f_Label] = CreateDynamic3DTextLabel(buffer, 0x008080FF, X, Y, Z+1.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
 	return (true);
}

/*
	- Panic Alarm && Situations
*/
FD_ResetPlayerVars(playerid, bool: reset = true) {
	if(reset == true) {
		CreatePanicAlarm(playerid, false);
		
		KillTimer(Panic_Timer[playerid]);
	}
	return (true);
}

CreateDynamicFire(Float: X, Float: Y, Float: Z, situation[]) {
	new buffer_m[64],
		buffer_s[64],
		buffer_l[64];
		
	// format
	FireSituation_CP[0] = X;
	FireSituation_CP[1] = Y;
	FireSituation_CP[2] = Z;
			
	format(buffer_s, sizeof(buffer_s), "Situation: Pozar");
	format(buffer_l, sizeof(buffer_l), "Location: Willowfield");
     
	foreach(new f_id: Factions) {
		if(FactionInfo[f_id][fType] == FACTION_TYPE_FD || FactionInfo[f_id][fType] == FACTION_TYPE_LAW) {
			SendRadioMessage(f_id, COLOR_LIGHTRED, situation);
		}
	}
	foreach(new i: Player) 
	{
		if(IsFDMember(i)) 
		{
			CreatePanicAlarm(i, true);
			
			GetDistanceToSituation[i] = GetPlayerDistanceFromPoint(i, FireSituation_CP[0], FireSituation_CP[1], FireSituation_CP[2]);
			format(buffer_m, sizeof(buffer_m), "Meters: %0.2f~y~m", GetDistanceToSituation[i]);	
			
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][15], buffer_m);
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][9],  buffer_l);
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][11], buffer_s);
			
			Panic_Timer[i] = SetTimerEx("UpdateLocationDistance", 1000, true, "i", i);
		}
	}
	fire_activated = (true); 
	return (true);
}

CreatePanicAlarm(playerid, bool: status) {
	if(status == false) {
		for(new i = 0; i < 16; i++) {
		    PlayerTextDrawHide(playerid, PanicAlarm_TD[playerid][i]);
		}
	}
	else if(status == true) {
		PanicAlarm_TD[playerid][0] = CreatePlayerTextDraw(playerid, 381.333251, 382.300079, "usebox");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][0], 0.000000, 7.047940);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][0], 275.000030, 0.000000);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][0], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][0], 0);
		PlayerTextDrawUseBox(playerid, PanicAlarm_TD[playerid][0], true);
		PlayerTextDrawBoxColor(playerid, PanicAlarm_TD[playerid][0], 102);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][0], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][0], 0);

		PanicAlarm_TD[playerid][1] = CreatePlayerTextDraw(playerid,276.666656, 448.000030, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][1], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][1], 103.333351, -4.562967);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][1], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][1], 255);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][1], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][1], 4);

		PanicAlarm_TD[playerid][2] = CreatePlayerTextDraw(playerid,276.333343, 381.629638, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][2], 103.333343, -0.829620);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][2], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][2], 255);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][2], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][2], 4);

		PanicAlarm_TD[playerid][3] = CreatePlayerTextDraw(playerid,275.999938, 380.799987, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][3], 0.666646, 67.199996);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][3], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][3], 255);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][3], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][3], 4);

		PanicAlarm_TD[playerid][4] = CreatePlayerTextDraw(playerid,379.333312, 381.629638, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][4], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][4], 0.333343, 65.540740);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][4], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][4], 255);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][4], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][4], 4);

		PanicAlarm_TD[playerid][5] = CreatePlayerTextDraw(playerid,279.333435, 389.511260, "-");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][5], 6.812330, 0.712296);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][5], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][5], -2139062017);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][5], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][5], 1);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][5], 1);

		PanicAlarm_TD[playerid][6] = CreatePlayerTextDraw(playerid,305.333404, 381.629638, "Panic Alarm");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][6], 0.204666, 1.060740);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][6], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][6], -1061109505);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][6], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][6], 3);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][6], 1);

		PanicAlarm_TD[playerid][7] = CreatePlayerTextDraw(playerid,380.666717, 376.237152, "ld_chat:badchat");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][7], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][7], -13.333352, 10.785173);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][7], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][7], -1); 
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][7], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][7], 4);

		PanicAlarm_TD[playerid][8] = CreatePlayerTextDraw(playerid,291.999938, 438.874145, "FIRE DEPARTMENT dispatcher");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][8], 0.112333, 0.704000);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][8], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][8], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][8], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][8], 2);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][8], 1);

		PanicAlarm_TD[playerid][9] = CreatePlayerTextDraw(playerid,290.000183, 401.125915, "Location:_Mullholand");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][9], 0.111000, 0.907258);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][9], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][9], -1);
		PlayerTextDrawUseBox(playerid, PanicAlarm_TD[playerid][9], true);
		PlayerTextDrawBoxColor(playerid, PanicAlarm_TD[playerid][9], 0);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][9], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][9], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][9], 2);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][9], 1);

		PanicAlarm_TD[playerid][11] = CreatePlayerTextDraw(playerid,289.666656, 418.548065, "Situation: Pozar");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][11], 0.118333, 0.944592);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][11], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][11], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][11], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][11], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][11], 2);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][11], 1);

		PanicAlarm_TD[playerid][12] = CreatePlayerTextDraw(playerid,281.000030, 402.785217, "ld_chat:thumbdn");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][12], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][12], 6.666678, 7.466671);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][12], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][12], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][12], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][12], 4);
		PlayerTextDrawSetPreviewModel(playerid, PanicAlarm_TD[playerid][12], 0);
		PlayerTextDrawSetPreviewRot(playerid, PanicAlarm_TD[playerid][12], 0.000000, 0.000000, 0.000000, 0.000000);

		PanicAlarm_TD[playerid][13] = CreatePlayerTextDraw(playerid,280.666625, 411.081481, "ld_chat:thumbdn");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][13], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][13], 6.666656, 7.466655);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][13], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][13], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][13], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][13], 4);
		PlayerTextDrawSetPreviewModel(playerid, PanicAlarm_TD[playerid][13], 0);
		PlayerTextDrawSetPreviewRot(playerid, PanicAlarm_TD[playerid][13], 0.000000, 0.000000, 0.000000, 0.000000);

		PanicAlarm_TD[playerid][14] = CreatePlayerTextDraw(playerid,280.666564, 420.207305, "ld_chat:thumbdn");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][14], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PanicAlarm_TD[playerid][14], 7.000007, 7.466666);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][14], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][14], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][14], 0);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][14], 4);
		PlayerTextDrawSetPreviewModel(playerid, PanicAlarm_TD[playerid][14], 0);
		PlayerTextDrawSetPreviewRot(playerid, PanicAlarm_TD[playerid][14], 0.000000, 0.000000, 0.000000, 0.000000);
		
		PanicAlarm_TD[playerid][15] = CreatePlayerTextDraw(playerid, 289.666778, 410.251770, "Meters: 100m");
		PlayerTextDrawLetterSize(playerid, PanicAlarm_TD[playerid][15], 0.135333, 0.853333);
		PlayerTextDrawAlignment(playerid, PanicAlarm_TD[playerid][15], 1);
		PlayerTextDrawColor(playerid, PanicAlarm_TD[playerid][15], -1);
		PlayerTextDrawSetShadow(playerid, PanicAlarm_TD[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, PanicAlarm_TD[playerid][15], 1);
		PlayerTextDrawBackgroundColor(playerid, PanicAlarm_TD[playerid][15], 51);
		PlayerTextDrawFont(playerid, PanicAlarm_TD[playerid][15], 2);
		PlayerTextDrawSetProportional(playerid, PanicAlarm_TD[playerid][15], 1);
		PlayerTextDrawShow(playerid, PanicAlarm_TD[playerid][15]);
		
		for(new i = 0; i < 16; i++) {
		    PlayerTextDrawShow(playerid, PanicAlarm_TD[playerid][i]);
		}
	}
	FDArrived[playerid] = false;
	return (true);
}

RandomFireSituation() {
	new random_situation = random(6),
		buffer[158],
		buffer_m[64],
		buffer_s[64],
		buffer_l[64];
	
    switch (random_situation) {
        case 0: {
            // Create Fire
            CreateServerFlame(0, 0, 1930.4942, -1784.1799, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5037, -1782.1473, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5136, -1779.6364, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5238, -1777.1058, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5346, -1774.5141, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5428, -1772.4306, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5507, -1770.4219, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1930.5588, -1768.3559, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1929.1459, -1767.9173, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8776, -1769.5853, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8422, -1772.0158, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8189, -1773.6047, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8776, -1769.5853, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8422, -1772.0158, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8189, -1773.6047, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8001, -1774.8883, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7772, -1776.4462, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7534, -1778.0637, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.8001, -1774.8883, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7772, -1776.4462, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7534, -1778.0637, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7347, -1779.3225, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.7145, -1780.7152, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.6938, -1782.1208, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1928.6655, -1784.0491, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1935.3200, -1783.8045, 10.7728, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1935.2098, -1781.6428, 10.7728, DEFAULT_FIRE_HEALTH);
			
			// format
			FireSituation_CP[0] = 1940.1210;
			FireSituation_CP[1] = -1755.4462;
			FireSituation_CP[2] = 12.3754;
			
			format(buffer_s, sizeof(buffer_s), "Situation: Pozar na Pumpi.");
			format(buffer_l, sizeof(buffer_l), "Location: Idlewood");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Idlewood-a, molimo sve dostupne da krenu na lokaciju.");
		}
		case 1:
        {

            // Create Fire
            CreateServerFlame(0, 0, 1786.4844, -1164.2786, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1787.8876, -1164.3374, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1790.0416, -1164.8181, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1791.7430, -1165.1977, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1793.3637, -1165.5594, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1794.8229, -1165.8847, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1796.5830, -1166.2770, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1798.3182, -1166.6638, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1798.2283, -1166.9202, 22.1465, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1797.1246, -1166.2222, 22.5881, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1796.1480, -1165.5697, 22.5401, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1795.4377, -1165.1295, 22.1495, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1794.7139, -1164.6824, 21.4488, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1789.6914, -1164.0892, 22.3047, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1788.5687, -1163.1995, 22.3698, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1788.0295, -1162.8452, 21.9937, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1786.2319, -1163.1064, 21.8608, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1785.3194, -1163.1263, 21.9294, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1791.5643, -1163.1118, 21.3996, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1791.8800, -1164.3983, 22.2759, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1791.8519, -1165.1618, 22.5094, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1788.8287, -1163.4260, 22.0600, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1790.2512, -1164.0129, 21.2942, DEFAULT_FIRE_HEALTH);

			// format
			FireSituation_CP[0] = 1801.8098;
			FireSituation_CP[1] = -1170.5629;
			FireSituation_CP[2] = 22.8253;
			
			format(buffer_s, sizeof(buffer_s), "Situation: Restoran Pozar.");
			format(buffer_l, sizeof(buffer_l), "Location: Glen Park");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Glen Park-a, molimo sve dostupne da krenu na lokaciju.");
        }	
		case 2:
        {
            // Create Fire
            CreateServerFlame(0, 0, 1315.0238, -1368.2282, 10.9438,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1314.0100, -1368.2265, 10.9438,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1312.6562, -1368.2235, 10.9399,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1311.8308, -1367.5294, 10.9296,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1310.9281, -1367.4926, 10.9273,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1309.7708, -1367.4902, 10.9252,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1308.6425, -1367.4877, 10.9232,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1307.3302, -1368.0213, 10.9332,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1306.0062, -1368.3232, 10.9355,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1304.3460, -1368.3197, 10.9354,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1304.4842, -1369.0036, 10.9451,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1305.8629, -1369.4384, 10.9513,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1307.2315, -1369.3804, 10.9512,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1309.0936, -1369.7593, 10.9550,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1310.8515, -1369.5230, 10.9544,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1312.0820, -1369.2214, 10.9522,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1309.4581, -1367.9462, 13.2241,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1307.8933, -1367.5498, 13.5101,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1307.3311, -1369.9162, 13.0364,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1306.5539, -1370.5288, 12.7001,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1310.9852, -1369.3835, 12.2585,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1310.3361, -1370.6992, 12.9585,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1313.2864, -1370.2733, 10.9708,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1313.3056, -1371.2634, 10.9838,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1311.6168, -1370.8870, 10.9735,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1308.9244, -1371.1181, 10.9726,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1306.5335, -1370.7678, 10.9712,DEFAULT_FIRE_HEALTH);
			
			// format
			FireSituation_CP[0] = 1309.8984;
			FireSituation_CP[1] = -1390.1172;
			FireSituation_CP[2] = 15.6406;
			
			format(buffer_s, sizeof(buffer_s), "Situation: Pozar Casino");
			format(buffer_l, sizeof(buffer_l), "Location: Vinewood");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Vinewood-a, molimo sve dostupne da krenu na lokaciju.");
        }
		case 3:
        {
            CreateServerFlame(0, 0, 2695.65015, -1949.06250, 12.54154 ,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2695.10010, -1954.75354, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2692.62964, -1961.54712, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2692.31104, -1950.05884, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2696.82837, -1956.44617, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2686.55566, -1947.81885, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2682.85107, -1954.25696, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2682.52173, -1964.70874, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2671.11841, -1958.40588, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2669.31226, -1951.90393, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2665.87573, -1964.25916, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2662.32568, -1964.55762, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2662.88696, -1957.85828, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2661.02783, -1952.92908, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2662.99414, -1951.87964, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2649.53467, -1954.09631, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2649.14722, -1961.72229, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2648.13599, -1957.93018, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2643.23975, -1953.98267, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2642.57959, -1960.68640, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2639.86548, -1957.60510, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2639.74536, -1949.45728, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2639.11548, -1954.69849, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 2649.55737, -1949.23108, 12.54154,DEFAULT_FIRE_HEALTH);
			
			// format
			FireSituation_CP[0] = 2709.9922;
			FireSituation_CP[1] = -1967.0000;
			FireSituation_CP[2] = 16.2813;
			
			format(buffer_s, sizeof(buffer_s), "Situation: Pozar Elektrana");
			format(buffer_l, sizeof(buffer_l), "Location: Willowfield");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Willowfield, molimo sve dostupne da krenu na lokaciju.");   
        }
		case 4:
		{
			CreateServerFlame(0, 0, 432.94742, -1636.96460, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.17465, -1638.59375, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.20975, -1640.59619, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.06595, -1642.55334, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.14911, -1633.25122, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.16656, -1631.28271, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.15195, -1628.89355, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.00537, -1625.23352, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.15359, -1622.58716, 25.24613,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 421.3337, -1645.8163, 26.4123,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 433.09879, -1619.80981, 25.24613,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 425.4478, -1645.9899, 26.4123,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 429.1613, -1646.5884, 26.4123,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 433.1602, -1619.8157, 26.3204,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 432.9348, -1625.9297, 26.3204,DEFAULT_FIRE_HEALTH);
			
            // format
			FireSituation_CP[0] = 434.8630;
			FireSituation_CP[1] = -1648.9707;
			FireSituation_CP[2] = 24.4299;
			
			format(buffer_s, sizeof(buffer_s), "Situation: Pozar - Market");
			format(buffer_l, sizeof(buffer_l), "Location: Rodeo");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Rodeo, molimo sve dostupne da krenu na lokaciju.");
        }
        case 5:
		{
			CreateServerFlame(0, 0, 1733.4249, -1900.8369, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.4243, -1901.9098, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.2101, -1903.4496, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.0109, -1904.8752, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.4049, -1906.1436, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1734.4969, -1906.5066, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1734.4874, -1906.9038, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.9302, -1907.8275, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.7953, -1908.7891, 12.0000,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 1733.2367, -1910.2745, 12.0000,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(0, 0, 1733.0428, -1911.6644, 12.0000,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 1733.3209, -1912.7192, 12.0000,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 1733.2922, -1912.7723, 12.0000,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 1733.2968, -1911.1790, 12.0000,DEFAULT_FIRE_HEALTH);
			CreateServerFlame(0, 0, 1732.3397, -1909.1624, 12.0000,DEFAULT_FIRE_HEALTH);

            // format
			FireSituation_CP[0] = 1740.4300;
			FireSituation_CP[1] = -1930.8369;
			FireSituation_CP[2] = 10.5323;

			format(buffer_s, sizeof(buffer_s), "Situation: Pozar - Kolodvor");
			format(buffer_l, sizeof(buffer_l), "Location: Unity Station");
			format(buffer, sizeof(buffer), "** HQ Announcement: Izbio je pozar u blizini Unity Station, molimo sve dostupne da krenu na lokaciju.");
        }
	}
	foreach(new f_id: Factions) {
		if(FactionInfo[f_id][fType] == FACTION_TYPE_FD || FactionInfo[f_id][fType] == FACTION_TYPE_NEWS || FactionInfo[f_id][fType] == FACTION_TYPE_LAW) {
			SendRadioMessage(f_id, COLOR_LIGHTRED, buffer);
		}
	}
	foreach(new i: Player) 
	{
		if(IsFDMember(i)) 
		{
			CreatePanicAlarm(i, true);
			
			GetDistanceToSituation[i] = GetPlayerDistanceFromPoint(i, FireSituation_CP[0], FireSituation_CP[1], FireSituation_CP[2]);
			format(buffer_m, sizeof(buffer_m), "Meters: %0.2f~y~m", GetDistanceToSituation[i]);	
			
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][15], buffer_m);
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][9],  buffer_l);
			PlayerTextDrawSetString(i, PanicAlarm_TD[i][11], buffer_s);
			
			Panic_Timer[i] = SetTimerEx("UpdateLocationDistance", 1000, true, "i", i);
		}
	}
	fire_activated = (true);
	FireActivatedTimer = SetTimerEx("CheckFireSituation", 60000*CHECK_FIRE_TIME, true, ""); // Svakih CHECK_FIRE_TIME minuta.	
	return (true);
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (timers)
Public:UpdateLocationDistance(faction) 
{
	if(!FDArrived[faction])
	{
		// update distance.
		new buffer_m[64];
		
		GetDistanceToSituation[faction] = GetPlayerDistanceFromPoint(faction, FireSituation_CP[0], FireSituation_CP[1], FireSituation_CP[2]);
		format(buffer_m, sizeof(buffer_m), "Meters: %0.2f~y~m", GetDistanceToSituation[faction]);	
		PlayerTextDrawSetString(faction, PanicAlarm_TD[faction][15], buffer_m);
		
		if(IsPlayerInRangeOfPoint(faction, 40.0, FireSituation_CP[0], FireSituation_CP[1], FireSituation_CP[2])) {
			FD_ResetPlayerVars(faction, true);
			FDArrived[faction] = true;
			KillTimer(Panic_Timer[faction]);
			
			SendMessage(faction, MESSAGE_TYPE_INFO, "Uspjesno ste dosli na prijavljenu lokaciju pozara, u vasoj blizini se nalazi pozar.");
			PlayerPlaySound(faction, 1057, 0.0, 0.0, 0.0);
		}
	}
	return (true);
}	

Public:CheckFireSituation() 
{
	new
		count_members = 0;
		
	if(fire_activated == true) {
		foreach(new i: Player) {
			if(IsFDMember(i)) {
				count_members++;
					
				if(count_members < 3) {
					DestroyAllServerFlames();
					KillTimer(FireActivatedTimer);
					break;
				}
			}
		}
	}
	return (true);
}

Public:CreateServerFire() 
{
	if(gettimestamp() >= CreateFireTimer)
	{
		new
			count_members = 0;
		if(fire_activated == (true)) 
			return (true);
			
		foreach(new i: Player) {
			if(IsFDMember(i)) {
				count_members++;
					
				if(count_members >= 3) {
					RandomFireSituation();
					CreateFireTimer = gettimestamp() + (CREATE_FIRE_TIME * 180);
					break;
				}
			}
		}
	}
	return (true);
}
/*
	fire functons, credits: samp
*/
Float:GetPlayerDistanceFromAiming(Float:CamX, Float:CamY, Float:CamZ,   Float:ObjX, Float:ObjY, Float:ObjZ,   Float:FrX, Float:FrY, Float:FrZ) {
	new Float:TGTDistance;
	
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));
	new Float:tmpX, Float:tmpY, Float:tmpZ;
	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;
	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

IsPlayerNearFlame(playerid, Float:x, Float:y, Float:z, Float:radius) {
	new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
	
	GetPlayerCameraPos(playerid, cx, cy, cz);
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);
	return (radius >= GetPlayerDistanceFromAiming(cx, cy, cz, x, y, z, fx, fy, fz));
}
/*
	- Hooks
*/

hook OnGameModeExit() {
	return KillTimer(ServerFireTimer);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_SPAWNFIRE: {
			if(response) {
				new Float:x, Float:y, Float:z;

				GetPlayerPos(playerid, x, y, z);

				CreateServerFlame(GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), x, y, z, strval(inputtext));
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste stvorili 'vatru', na lokaciji %s, fire health: %d.", GetPlayerLocation(playerid), strval(inputtext));
			}
		}
		case DIALOG_DESTROYFIRE: {
			if(response) {
				if(!Iter_Contains(FlameID_Iter, strval(inputtext))) 
					return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogresan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");
					
				DestroyServerFlame(strval(inputtext));
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste unistili 'vatru' pod ID-om %d.", strval(inputtext));
			}
		}
		case DIALOG_MOVEFIRE: {
			if(response) {
				if(!Iter_Contains(FlameID_Iter, strval(inputtext)) ) return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogresan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");
				MoveServerFlame(strval(inputtext), playerid);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promijenili poziciju 'vatre' id -> %d.", strval(inputtext));
			}
		}
		case DIALOG_HEALTHFIRE1:{
			if(response) {

				GetFlameDialogID[playerid] = strval(inputtext);
				if(!Iter_Contains(FlameID_Iter, GetFlameDialogID[playerid]) ) 
					return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogresan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");

				new buffer[128];
				format(buffer, sizeof(buffer),"Molimo vas unesite koliko zelite da Fire(id: %d) ima health-a.",  GetFlameDialogID[playerid]);
				ShowPlayerDialog(playerid, DIALOG_HEALTHFIRE2, DIALOG_STYLE_INPUT, "* Fire Health", buffer, "(change)", "Close");
			}
		}
		case DIALOG_HEALTHFIRE2: {
			if(response) {
				new buffer[128];
				FireData[GetFlameDialogID[playerid]][f_health] = strval(inputtext);
				
				format(buffer, sizeof(buffer), "(%d) %d", GetFlameDialogID[playerid], FireData[GetFlameDialogID[playerid]][f_health]);
				UpdateDynamic3DTextLabelText(FireData[GetFlameDialogID[playerid]][f_Label],0x008080FF, buffer);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promijenili health na vatri ID %d, postavili ste health na %d.", GetFlameDialogID[playerid], FireData[GetFlameDialogID[playerid]][f_health]);
			}
		}
		case DIALOG_FDANNOUNCE:
		{
		    new Float:x, Float:y, Float:z;

			GetPlayerPos(playerid, x, y, z);

			SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste poslali Announcement(poruku) svim online FD clanovima.");
			va_SendClientMessage(playerid, 0xAFAFAFAA, "(message) -> %s.", inputtext);
			
			CreateDynamicFire(x, y, z, inputtext);
		}
	}
	return (true);
}

hook OnPlayerUpdate(playerid) {
	if(fire_activated)
	{
		new buffer[128];
		if( Iter_Count(FlameID_Iter) == 0 ) return (true);

		new newkeys,key1,key2, destroyFlameID = -1;
		GetPlayerKeys(playerid, newkeys, key1, key2);

		if(GetPlayerWeapon(playerid) == WEAPON_FIREEXTINGUISHER) {
			if(HOLDING(KEY_FIRE) || HOLDING(KEY_ACTION)) {
				foreach(new i: FlameID_Iter) {
					if(IsPlayerNearFlame(playerid, FireData[i][f_Pos][0],  FireData[i][f_Pos][1],  FireData[i][f_Pos][2], 5)) {
						if(IsPlayerAimingAt(playerid, FireData[i][f_Pos][0],  FireData[i][f_Pos][1],  FireData[i][f_Pos][2], 2.5)) {
							
							FireData[i][f_health] -= 12;
							
							format(buffer, sizeof(buffer), "(%d) %d", FireData[i][f_ID], FireData[i][f_health]);
							UpdateDynamic3DTextLabelText(FireData[i][f_Label],0x008080FF, buffer);
							
							if(FireData[i][f_health] <= 0)
							{
								destroyFlameID = i;
								break;
							}
						}
					}
				}
			}
		}
		if(GetPlayerState(playerid) == 2 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 407) {
			if(HOLDING(KEY_FIRE) || HOLDING(KEY_ACTION)) {
				foreach(new i: FlameID_Iter) {
					if(IsPlayerNearFlame(playerid, FireData[i][f_Pos][0],  FireData[i][f_Pos][1],  FireData[i][f_Pos][2], 30.0)) {
						if(IsPlayerAimingAt(playerid, FireData[i][f_Pos][0],  FireData[i][f_Pos][1],  FireData[i][f_Pos][2], 5.0)) {
							FireData[i][f_health] -= 8; 
							
							format(buffer, sizeof(buffer), "(%d) %d", FireData[i][f_ID], FireData[i][f_health]);
							UpdateDynamic3DTextLabelText(FireData[i][f_Label],0x008080FF, buffer);
							
							if(FireData[i][f_health] <= 0)
							{
								destroyFlameID = i;
								break;
							}
						}
					}
				}
			}
		}
		if(destroyFlameID != -1)
			DestroyServerFlame(destroyFlameID);
	}	
	return (true);
}

/*
	- Commands
*/
CMD:afire(playerid, params[]) {
	new action[32], dialogstring[170];
	
	if(PlayerInfo[playerid][pAdmin] < 4) 
		return SendClientMessage(playerid,COLOR_RED, "Niste Admin Level 4+.");
	if(sscanf(params, "s[32]", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[ ? ]: /afire [opcija].");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] spawnfire, destroyfire, destroyall, fdannounce, movefire, startfire, firehealth");
		if(fire_activated == true) 
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno je spawnano %d pozara.", Iter_Count(FlameID_Iter));
        return (true);
    }

	if(strcmp(action,"spawnfire",true) == 0) {
  		format(dialogstring, sizeof(dialogstring),"Kako bi kreirali 'plamena', morate unesti koliko HP-a zelite da plamen ima.\n{C9FFAB}Defualt Fire Health -> %d{C9FFAB}			Max Fire Health -> %d", DEFAULT_FIRE_HEALTH, MAX_FIRE_HEALTH);
  		ShowPlayerDialog(playerid, DIALOG_SPAWNFIRE, DIALOG_STYLE_INPUT, "* Spawn Fire", dialogstring, "Spawn", "Close");
	}

	if(strcmp(action,"destroyall",true) == 0) {
		DestroyAllServerFlames();
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Unistili ste sve pozare na serveru.");
	}
	
	if(strcmp(action,"destroyfire",true) == 0) {
  		ShowPlayerDialog(playerid, DIALOG_DESTROYFIRE, DIALOG_STYLE_INPUT, "* Destroy Fire", "Kako bi izbrisali 'plamena', morate unesti ID plamena koji se nalazi na labelu od plamena.", "Spawn", "Close");
	}

	if(strcmp(action,"movefire",true) == 0) {
  		ShowPlayerDialog(playerid, DIALOG_MOVEFIRE, DIALOG_STYLE_INPUT, "* Move Fire", "Kako bi promijenili poziciju 'plamena', morate unesti ID plamena koji se nalazi na labelu od plamena.", "Spawn", "Close");
	}

	if(strcmp(action,"firehealth",true) == 0) {
  		ShowPlayerDialog(playerid, DIALOG_HEALTHFIRE1, DIALOG_STYLE_INPUT, "* Fire Health", "Kako bi promijenili health(kolicina) 'plamena', morate unesti id plamena koji se nalazi na labelu od plamena.", "Spawn", "Close");
	}

	if(strcmp(action,"startfire",true) == 0) {
		if(fire_activated == true) 
			return SendClientMessage(playerid,COLOR_RED, "Trenutno vec ima aktivnih pozara!");
			
 		RandomFireSituation();
		fire_activated = true;
   		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste aktivirali random pozar.");
	}

	if(strcmp(action,"fdannounce",true) == 0) {
  		ShowPlayerDialog(playerid, DIALOG_FDANNOUNCE, DIALOG_STYLE_INPUT, "* FD Announce", "Upisite kakvu poruku zelite poslati online Fire Department clanovima.\n[Primjer]: Izbio je pozar na lokaciji 'location name' i o kakvom se pozaru radi.", "Spawn", "Close");
	}
	return (true);
}
