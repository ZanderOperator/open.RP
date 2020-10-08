// forum.cityofangels-roleplay.com // Fire system // by L3o

/*
	### #     #  #####  #       #     # ######  #######  #####
	 #  ##    # #     # #       #     # #     # #       #     #
	 #  # #   # #       #       #     # #     # #       #
	 #  #  #  # #       #       #     # #     # #####    #####
	 #  #   # # #       #       #     # #     # #             #
	 #  #    ## #     # #       #     # #     # #       #     #
	### #     #  #####  #######  #####  ######  #######  #####
*/
#include <YSI\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
*/

#define	FIRE_EXTINGUISH_BONUS				(500)   // Bonus za gasenje pozara
#define DEFAULT_FIRE_HEALTH					(2000) 	// Defualt Health od Vatre
#define MAX_FIRE_HEALTH						(5000) 	// Maximalan Health od Vatre
#define PLAYER_MINUS_HP                 	(5)   	// Koliko HP-a gubi igrac kada je blizu vatre
#define FIREFAGHTER_MINUS_HP                (1)     // Koliko HP-a gubi vatrogasac kada je blizu vatre
#define NEAR_FLAME_DISTANCE                 (2.5)   // Distanca koliko igrac mora biti udaljen od Vatre

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// Flame.pwn
enum fire_enum
{
	fire_id,
    fire_object,
    fire_interior,
    Float:GetFire_Pos[3],
	fire_health
};
new FireEnumator[MAX_SERVER_FLAMES][fire_enum];


enum PA_enum
{
    Float:GetPlayer_Pos[3]
}
new PanicalAlar_enum[MAX_PLAYERS][PA_enum];


new Text3D:fire_3dLabel[MAX_SERVER_FLAMES];

// Player Vars
stock static
				panicalarm_situation[MAX_PLAYERS],
				bool: PlayerWarned[MAX_PLAYERS],
				GetFlameDialogID[MAX_PLAYERS],
				GetPlayerLocationAnnounce[MAX_PLAYERS];

// Textdraws:
new
	Text:PanicAlarm_TD[15],
 	PlayerText:PlayerPanicAlarm_TD[MAX_PLAYERS],
	firestarted = 0,
	Float:LastFirePos[3];
	
	
/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/

stock CreatePanicAlarmTextdraw(playerid)
{
	DestroyPanicAlarmTextdraw(playerid);

	for(new i = 0; i < 15; i++) { TextDrawShowForPlayer(playerid, PanicAlarm_TD[i]); }
	
	PlayerPanicAlarm_TD[playerid] = CreatePlayerTextDraw(playerid, 289.666778, 410.251770, "Meters: 100m");
	PlayerTextDrawLetterSize(playerid, PlayerPanicAlarm_TD[playerid], 0.135333, 0.853333);
	PlayerTextDrawAlignment(playerid, PlayerPanicAlarm_TD[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerPanicAlarm_TD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PlayerPanicAlarm_TD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPanicAlarm_TD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerPanicAlarm_TD[playerid], 51);
	PlayerTextDrawFont(playerid, PlayerPanicAlarm_TD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PlayerPanicAlarm_TD[playerid], 1);
	PlayerTextDrawShow(playerid, PlayerPanicAlarm_TD[playerid]);
	return (true);
}

stock DestroyPanicAlarmTextdraw(playerid)
{
    for(new i = 0; i < 15; i++) 
		TextDrawHideForPlayer(playerid, PanicAlarm_TD[i]); 
    PlayerTextDrawHide(playerid, PlayerPanicAlarm_TD[playerid]);  
	PlayerTextDrawDestroy(playerid, PlayerPanicAlarm_TD[playerid]);
    return (true);
}

stock FireSistem(playerid)
{
	new Float:toFireLocation, PAlarmStr[64];
	if(panicalarm_situation[playerid] > 0)
	{
		switch(panicalarm_situation[playerid])
		{
			case 1:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 1940.1210, -1755.4462, 12.3754);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0,	1940.1210, -1755.4462, 12.3754))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 2:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 1801.8098, -1170.5629, 22.8253);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0,	1801.8098, -1170.5629, 22.8253))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 3:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 1309.8984, -1390.1172, 15.6406);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 1309.8984, -1390.1172, 15.6406))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 4:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 544.9503, -1466.1942, 13.7484);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 544.9503, -1466.1942, 13.7484))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 5:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 2709.9922, -1967.0000, 16.2813);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 2709.9922, -1967.0000, 16.2813))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 6:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 946.2368, -774.3885, 107.6119);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 946.2368, -774.3885, 107.6119))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 7:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 1848.5565, -1926.9087, 12.5473);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 1848.5565, -1926.9087, 12.5473))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 8:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 996.3060, -953.4834, 41.0342);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 996.3060, -953.4834, 41.0342))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 9:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 438.8778, -1652.9626, 24.3346);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 438.8778, -1652.9626, 24.3346))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 10:
			{
				toFireLocation = GetPlayerDistanceFromPoint(playerid, 374.7969, -2006.1563, 9.5000);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, 374.7969, -2006.1563, 9.5000))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
			}
			case 11:
			{
				// Fd Annouce - Bonus Script
				toFireLocation = GetPlayerDistanceFromPoint(playerid, PanicalAlar_enum[playerid][GetPlayer_Pos][0], PanicalAlar_enum[playerid][GetPlayer_Pos][1], PanicalAlar_enum[playerid][GetPlayer_Pos][2]);
				format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
				PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
				if(IsPlayerInRangeOfPoint(playerid, 50.0, PanicalAlar_enum[playerid][GetPlayer_Pos][0], PanicalAlar_enum[playerid][GetPlayer_Pos][1], PanicalAlar_enum[playerid][GetPlayer_Pos][2]))
				{
					panicalarm_situation[playerid] = 0;
					DestroyPanicAlarmTextdraw(playerid);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					PanicalAlar_enum[playerid][GetPlayer_Pos][0] = 0;
					PanicalAlar_enum[playerid][GetPlayer_Pos][1] = 0;
					PanicalAlar_enum[playerid][GetPlayer_Pos][2] = 0;
				}
			}
		}
	}
	return (true);
}

Function: PlayerNearFlame(playerid)
{
	foreach(new i: FlameID_Iter)
	{
		if(IsValidFlameObject(i))
		{
			if(IsPlayerInRangeOfPoint(playerid, NEAR_FLAME_DISTANCE, FireEnumator[i][GetFire_Pos][0], FireEnumator[i][GetFire_Pos][1], FireEnumator[i][GetFire_Pos][2]) && !IsPlayerInAnyVehicle(playerid))
			{
				if(IsFDMember(playerid))
				{
					new Float:HP;
					GetPlayerHealth(playerid, HP);
					SetPlayerHealth(playerid, HP-FIREFAGHTER_MINUS_HP);
				}
				else if(!IsFDMember(playerid))
				{
					new Float:HP;
					GetPlayerHealth(playerid, HP);
					SetPlayerHealth(playerid, HP-PLAYER_MINUS_HP);
				}
				break;
			}
		}
	}
	if( firestarted == 1 && IsPlayerInRangeOfPoint(playerid, 40.0, LastFirePos[0], LastFirePos[1], LastFirePos[2]) && Iter_Count(FlameID_Iter) == 0  )
	{
		BudgetToOrgMoney ( FACTION_TYPE_FD, FIRE_EXTINGUISH_BONUS );
		firestarted = 0;
		LastFirePos[0] = 0.0;
		LastFirePos[1] = 0.0;
		LastFirePos[2] = 0.0;
		new string[128];
		format(string, sizeof(string), "** [LSFD HQ] : Pozar je ugasen. Hvala svima na intervenciji.");
		SendLawMessage(COLOR_ALLDEPT, string);
	}
	return 1;
}

stock CreateServerFlame(Float:x, Float:y, Float:z, Health)
{
	firestarted = 1;
	LastFirePos[0] = x;
	LastFirePos[1] = y;
	LastFirePos[2] = z;
	
	z = z - 10.0 + 10.0;
    new getFlameID = Iter_Free(FlameID_Iter),
    	Float:Zcord;

	MapAndreas_FindAverageZ(x,y, Zcord);
	FireEnumator[getFlameID][fire_object] = CreateDynamicObject(18691, x,y,Zcord-2.0, 0.0, 0.0, 0.0, -1, -1, -1, 500.0);
	FireEnumator[getFlameID][GetFire_Pos][0] = x; FireEnumator[getFlameID][GetFire_Pos][1] = y; FireEnumator[getFlameID][GetFire_Pos][2] = Zcord;
	FireEnumator[getFlameID][fire_health] = Health;
	FireEnumator[getFlameID][fire_id] = getFlameID;
	Iter_Add(FlameID_Iter, getFlameID);

	new string[128];
  	format(string, sizeof(string), "[ Fire HP(ID: %d) ]\n%d", FireEnumator[getFlameID][fire_id], FireEnumator[getFlameID][fire_health]);
  	fire_3dLabel[getFlameID] = Create3DTextLabel(string, 0x008080FF, x, y, Zcord+1.5, 30, 0);
	
  	return (true);
}

stock DestroyServerFlame(getFlameID, bool:remove=true)
{
	if(IsValidDynamicObject(FireEnumator[getFlameID][fire_object]))
		DestroyDynamicObject(FireEnumator[getFlameID][fire_object]);
	FireEnumator[getFlameID][fire_object] = 0;
	FireEnumator[getFlameID][GetFire_Pos][0] = 0, FireEnumator[getFlameID][GetFire_Pos][1] = 0, FireEnumator[getFlameID][GetFire_Pos][2] = 0;
 	Delete3DTextLabel(fire_3dLabel[getFlameID]);

 	// Iterator
	if(remove)
		Iter_Remove(FlameID_Iter, getFlameID);
 	return 1;
}

stock MoveServerFlame(getFlameID, playerid)
{
	new Float:playerPos[3], string[128], Float:Zcord;
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	// Destroy Currently Position
	DestroyDynamicObject(FireEnumator[getFlameID][fire_object]);
	FireEnumator[getFlameID][GetFire_Pos][0] = 0, FireEnumator[getFlameID][GetFire_Pos][1] = 0, FireEnumator[getFlameID][GetFire_Pos][2] = 0;
	Delete3DTextLabel(fire_3dLabel[getFlameID]);
	// Create And Move On New Position
	MapAndreas_FindAverageZ(playerPos[0], playerPos[1], Zcord);
	FireEnumator[getFlameID][fire_object] = CreateDynamicObject(18691, playerPos[0], playerPos[1], Zcord-2.0, 0.0, 0.0, 0.0, -1, -1, -1, 500.0);
	FireEnumator[getFlameID][GetFire_Pos][0] = playerPos[0], FireEnumator[getFlameID][GetFire_Pos][1] = playerPos[1], FireEnumator[getFlameID][GetFire_Pos][2] = playerPos[2];
  	format(string, sizeof(string), "[ Fire HP(ID:: %d) ]\n%d", FireEnumator[getFlameID][fire_id], FireEnumator[getFlameID][fire_health]);
  	fire_3dLabel[getFlameID] = Create3DTextLabel(string, 0x008080FF, playerPos[0], playerPos[1], playerPos[2]+1.5, 30, 0);
 	return (true);
}

Function: DestroyAllServerFlames()
{
	if(Iter_Count(FlameID_Iter) == 0) return 1;
	
	foreach(new flid: FlameID_Iter)
	{
		if(FireEnumator[flid][fire_object] != 0)
			DestroyServerFlame(flid, false);
	}
	Iter_Clear(FlameID_Iter);
	foreach(new i: Player)
		DestroyPanicAlarmTextdraw(i);
	firestarted = 0;
	LastFirePos[0] = 0.0;
	LastFirePos[1] = 0.0;
	LastFirePos[2] = 0.0;
	return (true);
}

stock IsValidFlameObject(getFlameID)
{
	if( (FireEnumator[getFlameID][GetFire_Pos][0] != 0) && (FireEnumator[getFlameID][GetFire_Pos][1] != 0) && (FireEnumator[getFlameID][GetFire_Pos][2] != 0) ) return true;
	else return false;
}

Float:GetPlayerDistanceFromAiming(Float:CamX, Float:CamY, Float:CamZ,   Float:ObjX, Float:ObjY, Float:ObjZ,   Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));
	new Float:tmpX, Float:tmpY, Float:tmpZ;
	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;
	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock IsPlayerNearFlame(playerid, Float:x, Float:y, Float:z, Float:radius)
{
	new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
	GetPlayerCameraPos(playerid, cx, cy, cz);
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);
	return (radius >= GetPlayerDistanceFromAiming(cx, cy, cz, x, y, z, fx, fy, fz));
}

//============================ Functions ============================//

Function: RandomFireSituation()
{
	RandomFireTimer = gettimestamp() + 6600;
	/* Destroy All Activated Server Flames*/
	DestroyAllServerFlames();
	firestarted = 1;
    new	Float:toFireLocation,
    	PAlarmStr[64],
		rand = random(10);
    switch (rand)
    {
        case 0:
        {
            // Create Fire
            CreateServerFlame(1930.4942, -1784.1799, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5037, -1782.1473, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5136, -1779.6364, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5238, -1777.1058, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5346, -1774.5141, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5428, -1772.4306, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5507, -1770.4219, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1930.5588, -1768.3559, 10.9368, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1929.1459, -1767.9173, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8776, -1769.5853, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8422, -1772.0158, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8189, -1773.6047, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8776, -1769.5853, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8422, -1772.0158, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8189, -1773.6047, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8001, -1774.8883, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7772, -1776.4462, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7534, -1778.0637, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.8001, -1774.8883, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7772, -1776.4462, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7534, -1778.0637, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7347, -1779.3225, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.7145, -1780.7152, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.6938, -1782.1208, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1928.6655, -1784.0491, 14.3093, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1935.3200, -1783.8045, 10.7728, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1935.2098, -1781.6428, 10.7728, DEFAULT_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Idlewood-a, molimo sve dostupne da krenu na lokaciju.");
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 1940.1210, -1755.4462, 12.3754);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar na Pumpi");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Idlewood");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 1;
				}
     		}
        }
        case 1:
        {

            // Create Fire
            CreateServerFlame(1786.4844, -1164.2786, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1787.8876, -1164.3374, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1790.0416, -1164.8181, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1791.7430, -1165.1977, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1793.3637, -1165.5594, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1794.8229, -1165.8847, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1796.5830, -1166.2770, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1798.3182, -1166.6638, 21.2181, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1798.2283, -1166.9202, 22.1465, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1797.1246, -1166.2222, 22.5881, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1796.1480, -1165.5697, 22.5401, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1795.4377, -1165.1295, 22.1495, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1794.7139, -1164.6824, 21.4488, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1789.6914, -1164.0892, 22.3047, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1788.5687, -1163.1995, 22.3698, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1788.0295, -1162.8452, 21.9937, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1786.2319, -1163.1064, 21.8608, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1785.3194, -1163.1263, 21.9294, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1791.5643, -1163.1118, 21.3996, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1791.8800, -1164.3983, 22.2759, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1791.8519, -1165.1618, 22.5094, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1788.8287, -1163.4260, 22.0600, DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1790.2512, -1164.0129, 21.2942, DEFAULT_FIRE_HEALTH);


            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Glen Park-a, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 1801.8098, -1170.5629, 22.8253);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Restoran Pozar");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Glen Park");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 2;
				}
			}
        }
        case 2:
        {
            // Create Fire
            CreateServerFlame(1315.0238, -1368.2282, 10.9438,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1314.0100, -1368.2265, 10.9438,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1312.6562, -1368.2235, 10.9399,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1311.8308, -1367.5294, 10.9296,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1310.9281, -1367.4926, 10.9273,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1309.7708, -1367.4902, 10.9252,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1308.6425, -1367.4877, 10.9232,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1307.3302, -1368.0213, 10.9332,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1306.0062, -1368.3232, 10.9355,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1304.3460, -1368.3197, 10.9354,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1304.4842, -1369.0036, 10.9451,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1305.8629, -1369.4384, 10.9513,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1307.2315, -1369.3804, 10.9512,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1309.0936, -1369.7593, 10.9550,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1310.8515, -1369.5230, 10.9544,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1312.0820, -1369.2214, 10.9522,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1309.4581, -1367.9462, 13.2241,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1307.8933, -1367.5498, 13.5101,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1307.3311, -1369.9162, 13.0364,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1306.5539, -1370.5288, 12.7001,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1310.9852, -1369.3835, 12.2585,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1310.3361, -1370.6992, 12.9585,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1313.2864, -1370.2733, 10.9708,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1313.3056, -1371.2634, 10.9838,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1311.6168, -1370.8870, 10.9735,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1308.9244, -1371.1181, 10.9726,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1306.5335, -1370.7678, 10.9712,DEFAULT_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Vinewood-a, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 1309.8984, -1390.1172, 15.6406);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar Casino");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Vinewood");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 3;
				}
            }
        }
        case 3:
        {
            // Create Fire
            CreateServerFlame(556.65753, -1469.56860, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(556.58594, -1471.49243, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(556.81879, -1476.62866, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(556.73499, -1478.33191, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(556.43610, -1462.06433, 13.88755,MAX_FIRE_HEALTH);
        	CreateServerFlame(556.44202, -1463.64795, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(557.17212, -1483.92065, 13.88755,MAX_FIRE_HEALTH);
            CreateServerFlame(557.22223, -1485.56018, 13.8875,MAX_FIRE_HEALTH);


            // Panic Alarm System
            foreach(new i:Player)
			{
                if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Gnocchi Cluba, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 544.9503, -1466.1942, 13.7484);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar Gnocchi Club");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Rodeo");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);
					// Set Vars
					panicalarm_situation[i] = 4;
				}
            }
        }
        case 4:
        {
            CreateServerFlame(2695.65015, -1949.06250, 12.54154 ,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2695.10010, -1954.75354, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2692.62964, -1961.54712, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2692.31104, -1950.05884, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2696.82837, -1956.44617, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2686.55566, -1947.81885, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2682.85107, -1954.25696, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2682.52173, -1964.70874, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2671.11841, -1958.40588, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2669.31226, -1951.90393, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2665.87573, -1964.25916, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2662.32568, -1964.55762, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2662.88696, -1957.85828, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2661.02783, -1952.92908, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2662.99414, -1951.87964, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2649.53467, -1954.09631, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2649.14722, -1961.72229, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2648.13599, -1957.93018, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2643.23975, -1953.98267, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2642.57959, -1960.68640, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2639.86548, -1957.60510, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2639.74536, -1949.45728, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2639.11548, -1954.69849, 12.54154,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(2649.55737, -1949.23108, 12.54154,DEFAULT_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Willowfield, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 2709.9922, -1967.0000, 16.2813);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar Elektrana");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Willowfield");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 5;
				}
            }
        }
        case 5:
        {
            CreateServerFlame(961.57471, -780.63550, 112.87647,MAX_FIRE_HEALTH);
            CreateServerFlame(964.44305, -780.31500, 113.28251,MAX_FIRE_HEALTH);
            CreateServerFlame(962.25232, -775.18463, 113.28251,MAX_FIRE_HEALTH);
            CreateServerFlame(966.10236, -773.35309, 113.28251,MAX_FIRE_HEALTH);
            CreateServerFlame(971.21344, -779.04449, 115.22195,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(976.76324, -776.79034, 115.22195,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(976.69775, -785.94818, 115.22195,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(982.70068, -782.58002, 112.87959,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(982.20001, -773.67975, 112.97446,DEFAULT_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Vinewood-a, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 946.2368, -774.3885, 107.6119);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar - Kuca");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Vinewood");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 6;
				}
            }
        }
        case 6:
        {
            CreateServerFlame(1848.95935, -1913.93579, 18.58122,MAX_FIRE_HEALTH);
            CreateServerFlame(1851.87903, -1909.69446, 18.58122,DEFAULT_FIRE_HEALTH);
        	CreateServerFlame(1855.85986, -1913.89258, 18.58122,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1853.38708, -1905.09607, 18.58122,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1848.20605, -1895.90662, 16.33471,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1843.27380, -1891.40015, 16.33471,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1843.65613, -1895.24756, 16.33471,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1847.79956, -1891.81836, 16.33471,MAX_FIRE_HEALTH);
            CreateServerFlame(1847.14673, -1888.83008, 16.33471,MAX_FIRE_HEALTH);
            CreateServerFlame(1856.63550, -1919.26624, 14.02529,MAX_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
				    SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini El Corona, molimo sve dostupne da krenu na lokaciju.");
				    DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 1848.5565, -1926.9087, 12.5473);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar - Kuca");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: El Corona");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 7;
				}
            }
        }
        case 7:
        {
            CreateServerFlame(1000.09021, -914.12115, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1000.31781, -916.29059, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1000.65796, -918.68622, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1001.37097, -922.82782, 41.41134,MAX_FIRE_HEALTH);
            CreateServerFlame(1001.79749, -926.45038, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1002.04797, -929.33002, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(999.62671, -911.32654, 41.41134,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(990.17987, -900.48456, 41.22604,MAX_FIRE_HEALTH);
            CreateServerFlame(994.79376, -899.53406, 41.22604,MAX_FIRE_HEALTH);
            CreateServerFlame(1002.65131, -895.18518, 41.22604,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1002.61639, -899.38428, 41.22604,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(1007.56213, -897.84839, 41.22604,DEFAULT_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Mullholand, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 996.3060, -953.4834, 41.0342);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar na Pumpi");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Mullholand");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 8;
				}
            }
        }
        case 8:
        {
            CreateServerFlame(432.94742, -1636.96460, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.17465, -1638.59375, 25.19456,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.20975, -1640.59619, 25.19456,MAX_FIRE_HEALTH);
            CreateServerFlame(433.06595, -1642.55334, 25.19456,MAX_FIRE_HEALTH);
            CreateServerFlame(433.14911, -1633.25122, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.16656, -1631.28271, 25.24613,MAX_FIRE_HEALTH);
            CreateServerFlame(433.15195, -1628.89355, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.00537, -1625.23352, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.15359, -1622.58716, 25.24613,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(433.09879, -1619.80981, 25.24613,MAX_FIRE_HEALTH);

            // Panic Alarm System
            foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
					// Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Rodeo, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 438.8778, -1652.9626, 24.3346);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar - Market");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Rodeo");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					// Set Vars
					panicalarm_situation[i] = 9;
				}
            }
        }
        case 9:
        {
            CreateServerFlame(386.45114, -2026.83301, 6.83457,MAX_FIRE_HEALTH);
            CreateServerFlame(387.44235, -2030.50366, 6.83457,DEFAULT_FIRE_HEALTH);
            CreateServerFlame(387.70468, -2034.13049, 6.83457,MAX_FIRE_HEALTH);
            CreateServerFlame(389.65405, -2038.45471, 6.83457,MAX_FIRE_HEALTH);
            CreateServerFlame(388.09985, -2023.10229, 6.83457,MAX_FIRE_HEALTH);
            CreateServerFlame(393.46494, -2028.15344, 6.83457,MAX_FIRE_HEALTH);

            // Panic Alarm System
			foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
				    // Send MSG & Set Panic Alarm Informations
					SendClientMessage(i, COLOR_YELLOW, "** HQ Announcement: Izbio je pozar u blizini Santa Maria, molimo sve dostupne da krenu na lokaciju.");
					DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, 374.7969, -2006.1563, 9.5000);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Kvar i Pozar");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: Santa Maria");
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					panicalarm_situation[i] = 10;
				}
			}
        }
    }
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
	// TextDraws
	PanicAlarm_TD[0] = TextDrawCreate(381.333251, 382.300079, "usebox");
	TextDrawLetterSize(PanicAlarm_TD[0], 0.000000, 7.047940);
	TextDrawTextSize(PanicAlarm_TD[0], 275.000030, 0.000000);
	TextDrawAlignment(PanicAlarm_TD[0], 1);
	TextDrawColor(PanicAlarm_TD[0], 0);
	TextDrawUseBox(PanicAlarm_TD[0], true);
	TextDrawBoxColor(PanicAlarm_TD[0], 102);
	TextDrawSetShadow(PanicAlarm_TD[0], 0);
	TextDrawSetOutline(PanicAlarm_TD[0], 0);
	TextDrawFont(PanicAlarm_TD[0], 0);

	PanicAlarm_TD[1] = TextDrawCreate(276.666656, 448.000030, "LD_SPAC:white");
	TextDrawLetterSize(PanicAlarm_TD[1], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[1], 103.333351, -4.562967);
	TextDrawAlignment(PanicAlarm_TD[1], 1);
	TextDrawColor(PanicAlarm_TD[1], 255);
	TextDrawSetShadow(PanicAlarm_TD[1], 0);
	TextDrawSetOutline(PanicAlarm_TD[1], 0);
	TextDrawFont(PanicAlarm_TD[1], 4);

	PanicAlarm_TD[2] = TextDrawCreate(276.333343, 381.629638, "LD_SPAC:white");
	TextDrawLetterSize(PanicAlarm_TD[2], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[2], 103.333343, -0.829620);
	TextDrawAlignment(PanicAlarm_TD[2], 1);
	TextDrawColor(PanicAlarm_TD[2], 255);
	TextDrawSetShadow(PanicAlarm_TD[2], 0);
	TextDrawSetOutline(PanicAlarm_TD[2], 0);
	TextDrawFont(PanicAlarm_TD[2], 4);

	PanicAlarm_TD[3] = TextDrawCreate(275.999938, 380.799987, "LD_SPAC:white");
	TextDrawLetterSize(PanicAlarm_TD[3], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[3], 0.666646, 67.199996);
	TextDrawAlignment(PanicAlarm_TD[3], 1);
	TextDrawColor(PanicAlarm_TD[3], 255);
	TextDrawSetShadow(PanicAlarm_TD[3], 0);
	TextDrawSetOutline(PanicAlarm_TD[3], 0);
	TextDrawFont(PanicAlarm_TD[3], 4);

	PanicAlarm_TD[4] = TextDrawCreate(379.333312, 381.629638, "LD_SPAC:white");
	TextDrawLetterSize(PanicAlarm_TD[4], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[4], 0.333343, 65.540740);
	TextDrawAlignment(PanicAlarm_TD[4], 1);
	TextDrawColor(PanicAlarm_TD[4], 255);
	TextDrawSetShadow(PanicAlarm_TD[4], 0);
	TextDrawSetOutline(PanicAlarm_TD[4], 0);
	TextDrawFont(PanicAlarm_TD[4], 4);

	PanicAlarm_TD[5] = TextDrawCreate(279.333435, 389.511260, "-");
	TextDrawLetterSize(PanicAlarm_TD[5], 6.812330, 0.712296);
	TextDrawAlignment(PanicAlarm_TD[5], 1);
	TextDrawColor(PanicAlarm_TD[5], -2139062017);
	TextDrawSetShadow(PanicAlarm_TD[5], 0);
	TextDrawSetOutline(PanicAlarm_TD[5], 1);
	TextDrawBackgroundColor(PanicAlarm_TD[5], 51);
	TextDrawFont(PanicAlarm_TD[5], 1);
	TextDrawSetProportional(PanicAlarm_TD[5], 1);

	PanicAlarm_TD[6] = TextDrawCreate(305.333404, 381.629638, "Panic Alarm");
	TextDrawLetterSize(PanicAlarm_TD[6], 0.204666, 1.060740);
	TextDrawAlignment(PanicAlarm_TD[6], 1);
	TextDrawColor(PanicAlarm_TD[6], -1061109505);
	TextDrawSetShadow(PanicAlarm_TD[6], 0);
	TextDrawSetOutline(PanicAlarm_TD[6], 1);
	TextDrawBackgroundColor(PanicAlarm_TD[6], 51);
	TextDrawFont(PanicAlarm_TD[6], 3);
	TextDrawSetProportional(PanicAlarm_TD[6], 1);

	PanicAlarm_TD[7] = TextDrawCreate(380.666717, 376.237152, "ld_chat:badchat");
	TextDrawLetterSize(PanicAlarm_TD[7], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[7], -13.333352, 10.785173);
	TextDrawAlignment(PanicAlarm_TD[7], 1);
	TextDrawColor(PanicAlarm_TD[7], -1); 
	TextDrawSetShadow(PanicAlarm_TD[7], 0);
	TextDrawSetOutline(PanicAlarm_TD[7], 0);
	TextDrawFont(PanicAlarm_TD[7], 4);

	PanicAlarm_TD[8] = TextDrawCreate(291.999938, 438.874145, "FIRE DEPARTMENT dispatcher");
	TextDrawLetterSize(PanicAlarm_TD[8], 0.112333, 0.704000);
	TextDrawAlignment(PanicAlarm_TD[8], 1);
	TextDrawColor(PanicAlarm_TD[8], -1);
	TextDrawSetShadow(PanicAlarm_TD[8], 0);
	TextDrawSetOutline(PanicAlarm_TD[8], 1);
	TextDrawBackgroundColor(PanicAlarm_TD[8], 51);
	TextDrawFont(PanicAlarm_TD[8], 2);
	TextDrawSetProportional(PanicAlarm_TD[8], 1);

	PanicAlarm_TD[9] = TextDrawCreate(290.000183, 401.125915, "Location:_Mullholand");
	TextDrawLetterSize(PanicAlarm_TD[9], 0.111000, 0.907258);
	TextDrawAlignment(PanicAlarm_TD[9], 1);
	TextDrawColor(PanicAlarm_TD[9], -1);
	TextDrawUseBox(PanicAlarm_TD[9], true);
	TextDrawBoxColor(PanicAlarm_TD[9], 0);
	TextDrawSetShadow(PanicAlarm_TD[9], 0);
	TextDrawSetOutline(PanicAlarm_TD[9], 1);
	TextDrawBackgroundColor(PanicAlarm_TD[9], 51);
	TextDrawFont(PanicAlarm_TD[9], 2);
	TextDrawSetProportional(PanicAlarm_TD[9], 1);

	PanicAlarm_TD[11] = TextDrawCreate(289.666656, 418.548065, "Situation: Pozar");
	TextDrawLetterSize(PanicAlarm_TD[11], 0.118333, 0.944592);
	TextDrawAlignment(PanicAlarm_TD[11], 1);
	TextDrawColor(PanicAlarm_TD[11], -1);
	TextDrawSetShadow(PanicAlarm_TD[11], 0);
	TextDrawSetOutline(PanicAlarm_TD[11], 1);
	TextDrawBackgroundColor(PanicAlarm_TD[11], 51);
	TextDrawFont(PanicAlarm_TD[11], 2);
	TextDrawSetProportional(PanicAlarm_TD[11], 1);

	PanicAlarm_TD[12] = TextDrawCreate(281.000030, 402.785217, "ld_chat:thumbdn");
	TextDrawLetterSize(PanicAlarm_TD[12], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[12], 6.666678, 7.466671);
	TextDrawAlignment(PanicAlarm_TD[12], 1);
	TextDrawColor(PanicAlarm_TD[12], -1);
	TextDrawSetShadow(PanicAlarm_TD[12], 0);
	TextDrawSetOutline(PanicAlarm_TD[12], 0);
	TextDrawFont(PanicAlarm_TD[12], 4);
	TextDrawSetPreviewModel(PanicAlarm_TD[12], 0);
	TextDrawSetPreviewRot(PanicAlarm_TD[12], 0.000000, 0.000000, 0.000000, 0.000000);

	PanicAlarm_TD[13] = TextDrawCreate(280.666625, 411.081481, "ld_chat:thumbdn");
	TextDrawLetterSize(PanicAlarm_TD[13], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[13], 6.666656, 7.466655);
	TextDrawAlignment(PanicAlarm_TD[13], 1);
	TextDrawColor(PanicAlarm_TD[13], -1);
	TextDrawSetShadow(PanicAlarm_TD[13], 0);
	TextDrawSetOutline(PanicAlarm_TD[13], 0);
	TextDrawFont(PanicAlarm_TD[13], 4);
	TextDrawSetPreviewModel(PanicAlarm_TD[13], 0);
	TextDrawSetPreviewRot(PanicAlarm_TD[13], 0.000000, 0.000000, 0.000000, 0.000000);

	PanicAlarm_TD[14] = TextDrawCreate(280.666564, 420.207305, "ld_chat:thumbdn");
	TextDrawLetterSize(PanicAlarm_TD[14], 0.000000, 0.000000);
	TextDrawTextSize(PanicAlarm_TD[14], 7.000007, 7.466666);
	TextDrawAlignment(PanicAlarm_TD[14], 1);
	TextDrawColor(PanicAlarm_TD[14], -1);
	TextDrawSetShadow(PanicAlarm_TD[14], 0);
	TextDrawSetOutline(PanicAlarm_TD[14], 0);
	TextDrawFont(PanicAlarm_TD[14], 4);
	TextDrawSetPreviewModel(PanicAlarm_TD[14], 0);
	TextDrawSetPreviewRot(PanicAlarm_TD[14], 0.000000, 0.000000, 0.000000, 0.000000);
	
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(panicalarm_situation[playerid] > 0)
    {
        DestroyPanicAlarmTextdraw(playerid);
    }
    return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(panicalarm_situation[playerid] > 0) { DestroyPanicAlarmTextdraw(playerid); panicalarm_situation[playerid] = 0; }
    PlayerWarned[playerid] = false;
	DestroyPanicAlarmTextdraw(playerid);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	// Spawn Fire
	switch(dialogid) {
		case DIALOG_SPAWNFIRE:
		{
			if(!response) return true;
			if(response)
			{
				new Float:x, Float:y, Float:z,
					health = strval(inputtext);
				GetPlayerPos(playerid, x, y, z);

				CreateServerFlame(x, y, z, health);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste stvorili 'vatru', na lokaciji %s, fire health: %d.", GetPlayerLocation(playerid), health);
			}
		}
		// Destroy Fire
		case DIALOG_DESTROYFIRE:
		{
			if(!response) return true;
			if(response)
			{
				new flameid = strval(inputtext);
				if(!Iter_Contains(FlameID_Iter, flameid) ) return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogresan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");
				DestroyServerFlame(flameid);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste unistili 'vatru' pod ID-om %d.", flameid);
			}
		}
		// Move Fire
		case DIALOG_MOVEFIRE:
		{
			if(!response) return true;
			if(response)
			{
				new flameid = strval(inputtext);
				if(!Iter_Contains(FlameID_Iter, flameid) ) return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogreSan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");
				MoveServerFlame(flameid, playerid);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promijenili poziciju 'vatre' id -> %d.", flameid);
			}
		}
		case DIALOG_HEALTHFIRE1:
		{
			if(!response) return true;
			if(response)
			{

				GetFlameDialogID[playerid] = strval(inputtext);
				if(!Iter_Contains(FlameID_Iter, GetFlameDialogID[playerid]) ) return SendClientMessage(playerid,COLOR_RED, "Unijeli ste pogresan ID Flame-a, trenutni upisani ID ne postoji/nije spawn-an!");

				new dialogstring[128];
				format(dialogstring, sizeof(dialogstring),"Molimo Vas unesite koliko zelite da Fire(id: %d) ima health-a.",  GetFlameDialogID[playerid]);
				ShowPlayerDialog(playerid, DIALOG_HEALTHFIRE2, DIALOG_STYLE_INPUT, "* Fire Health", dialogstring, "Spawn", "Exit");

			}
		}
		case DIALOG_HEALTHFIRE2:
		{
			if(!response) return true;
			if(response)
			{
				new string[128];
				new flameid = GetFlameDialogID[playerid];
				FireEnumator[flameid][fire_health] = strval(inputtext);
				format(string, sizeof(string), "[ Fire HP(ID: %d) ]\n%d", FireEnumator[flameid][fire_id], FireEnumator[flameid][fire_health]);
				Update3DTextLabelText(fire_3dLabel[flameid], 0x008080FF, string);
				va_SSendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promijenili health na vatri ID %d, postavili ste health na %d.", flameid, FireEnumator[flameid][fire_health]);
			}
		}
		case DIALOG_FDANNOUNCE:
		{
		    new Float:x, Float:y, Float:z,
				Float:toFireLocation,
				PAlarmStr[64];

			GetPlayerPos(playerid, x, y, z);

			if(PlayerInfo[playerid][pAdmin] >= 4)
			{
				SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste poslali Announcement(poruku) svim online FD clanovima.");
				va_SendClientMessage(playerid, 0xAFAFAFAA, "(message) -> %s.", inputtext);
			}
			new string[128];
			foreach(new fid: Factions)
			{
				if(FactionInfo[fid][fType] == FACTION_TYPE_FD || FactionInfo[fid][fType] == FACTION_TYPE_LAW)
				{
					format(string, sizeof(string), "** HQ Announcement: %s ",inputtext);
					SendRadioMessage(fid, TEAM_YELLOW_COLOR, string);
				}
			}
			foreach(new i:Player)
			{
			    if(IsFDMember(i))
		 		{
		 		    DestroyPanicAlarmTextdraw(playerid); DestroyPanicAlarmTextdraw(i);
					CreatePanicAlarmTextdraw(i);

					toFireLocation = GetPlayerDistanceFromPoint(i, x, y, z);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(i, PlayerPanicAlarm_TD[i], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Situation: Pozar");
					TextDrawSetString(PanicAlarm_TD[11], PAlarmStr);
					format(PAlarmStr, sizeof(PAlarmStr), "Location: %s", GetPlayerLocation(playerid));
					TextDrawSetString(PanicAlarm_TD[9], PAlarmStr);

					panicalarm_situation[i] = 11;
					PanicalAlar_enum[i][GetPlayer_Pos][0] = x, PanicalAlar_enum[i][GetPlayer_Pos][1] = y, PanicalAlar_enum[i][GetPlayer_Pos][2] = z;
				}
			}
		}
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(firestarted)
	{
		new 
			newkeys,
			key1,
			key2,
			GetKeyFromPlayer;

		GetPlayerKeys(playerid, newkeys, key1, key2);
		if( Iter_Count(FlameID_Iter) == 0 ) return 1;

		if(GetPlayerWeapon(playerid) == WEAPON_FIREEXTINGUISHER)
		{
			if(HOLDING(KEY_FIRE) || HOLDING(KEY_ACTION))
			{
				foreach(GetKeyFromPlayer: FlameID_Iter)
				{
					if(IsValidFlameObject(GetKeyFromPlayer))
					{
						if(IsPlayerNearFlame(playerid, FireEnumator[GetKeyFromPlayer][GetFire_Pos][0],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][1],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][2], 5) )
						{
							if(IsPlayerAimingAt(playerid, FireEnumator[GetKeyFromPlayer][GetFire_Pos][0],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][1],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][2], 2.5))
							{
								FireEnumator[GetKeyFromPlayer][fire_health]-=2;
								new string[128];
								format(string, sizeof(string), "[ Fire HP(ID: %d) ]\n%d", FireEnumator[GetKeyFromPlayer][fire_id], FireEnumator[GetKeyFromPlayer][fire_health]);
								Update3DTextLabelText(fire_3dLabel[GetKeyFromPlayer], 0x008080FF, string);
								if(FireEnumator[GetKeyFromPlayer][fire_health] <= 0)
									DestroyServerFlame(GetKeyFromPlayer);
							}
						}
					}
				}
			}
		}
		if(GetPlayerState(playerid) == 2 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 407)
		{
			if(HOLDING(KEY_FIRE) || HOLDING(KEY_ACTION))
			{
				foreach(GetKeyFromPlayer: FlameID_Iter)
				{
					if(IsValidFlameObject(GetKeyFromPlayer))
					{
						if(IsPlayerNearFlame(playerid, FireEnumator[GetKeyFromPlayer][GetFire_Pos][0],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][1],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][2], 30.0))
						{
							if(IsPlayerAimingAt(playerid, FireEnumator[GetKeyFromPlayer][GetFire_Pos][0],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][1],  FireEnumator[GetKeyFromPlayer][GetFire_Pos][2], 7.5))
							{
								FireEnumator[GetKeyFromPlayer][fire_health]-=5;
								new string[128];
								format(string, sizeof(string), "[ Fire HP(ID: %d) ]\n%d", FireEnumator[GetKeyFromPlayer][fire_id], FireEnumator[GetKeyFromPlayer][fire_health]);
								Update3DTextLabelText(fire_3dLabel[GetKeyFromPlayer], 0x008080FF, string);
								if(FireEnumator[GetKeyFromPlayer][fire_health] <= 0)
									DestroyServerFlame(GetKeyFromPlayer);
							}
						}
					}
				}
			}
		}
		if(panicalarm_situation[playerid] > 0)
		{
			new Float:toFireLocation, PAlarmStr[64];
			switch(panicalarm_situation[playerid])
			{
				case 1:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 1940.1210, -1755.4462, 12.3754);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0,	1940.1210, -1755.4462, 12.3754))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 2:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 1801.8098, -1170.5629, 22.8253);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0,	1801.8098, -1170.5629, 22.8253))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 3:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 1309.8984, -1390.1172, 15.6406);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 1309.8984, -1390.1172, 15.6406))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 4:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 544.9503, -1466.1942, 13.7484);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 544.9503, -1466.1942, 13.7484))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 5:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 2709.9922, -1967.0000, 16.2813);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 2709.9922, -1967.0000, 16.2813))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 6:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 946.2368, -774.3885, 107.6119);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 946.2368, -774.3885, 107.6119))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 7:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 1848.5565, -1926.9087, 12.5473);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 1848.5565, -1926.9087, 12.5473))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 8:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 996.3060, -953.4834, 41.0342);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 996.3060, -953.4834, 41.0342))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 9:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 438.8778, -1652.9626, 24.3346);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 438.8778, -1652.9626, 24.3346))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 10:
				{
					toFireLocation = GetPlayerDistanceFromPoint(playerid, 374.7969, -2006.1563, 9.5000);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, 374.7969, -2006.1563, 9.5000))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					}
				}
				case 11:
				{
					// Fd Annouce - Bonus Script
					toFireLocation = GetPlayerDistanceFromPoint(playerid, PanicalAlar_enum[playerid][GetPlayer_Pos][0], PanicalAlar_enum[playerid][GetPlayer_Pos][1], PanicalAlar_enum[playerid][GetPlayer_Pos][2]);
					format(PAlarmStr, sizeof(PAlarmStr), "METERS: %0.2f~y~m", toFireLocation);
					PlayerTextDrawSetString(playerid, PlayerPanicAlarm_TD[playerid], PAlarmStr);
					if(IsPlayerInRangeOfPoint(playerid, 50.0, PanicalAlar_enum[playerid][GetPlayer_Pos][0], PanicalAlar_enum[playerid][GetPlayer_Pos][1], PanicalAlar_enum[playerid][GetPlayer_Pos][2]))
					{
						panicalarm_situation[playerid] = 0;
						DestroyPanicAlarmTextdraw(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dosli na lokaciju pozara, u vasoj blizini se nalazi pozar.");
						PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
						PanicalAlar_enum[playerid][GetPlayer_Pos][0] = 0;
						PanicalAlar_enum[playerid][GetPlayer_Pos][1] = 0;
						PanicalAlar_enum[playerid][GetPlayer_Pos][2] = 0;
					}
				}
			}
		}
	}
	return 1;
}

/*
		 ######    ##     ##  ########
		##    ##   ###   ###  ##     ##
		##         #### ####  ##     ##
		##         ## ### ##  ##     ##
		##         ##     ##  ##     ##
		##    ##   ##     ##  ##     ##
		 ######    ##     ##  ########
*/

CMD:fire(playerid, params[])
{
	new action[32], dialogstring[170];
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "Niste Admin Level 4+.");
	if(sscanf(params, "s[32]", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fire [opcija].");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] spawnfire, destroyfire, destroyall, fdannounce, movefire, startfire, firehealth");
        SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno je spawnano %d pozara.", Iter_Count(FlameID_Iter));
        return 1;
    }

	if(strcmp(action,"spawnfire",true) == 0)
	{
  		format(dialogstring, sizeof(dialogstring),"Kako bi kreirali 'plamena', morate unesti koliko HP-a zelite da plamen ima.\n{C9FFAB}Defualt Fire Health -> %d{C9FFAB}			Max Fire Health -> %d", DEFAULT_FIRE_HEALTH, MAX_FIRE_HEALTH);
  		ShowPlayerDialog(playerid, DIALOG_SPAWNFIRE, DIALOG_STYLE_INPUT, "* Spawn Fire", dialogstring, "Spawn", "Close");
	}

	if(strcmp(action,"destroyall",true) == 0)
	{
		DestroyAllServerFlames();
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Unistili ste sve pozare na serveru.");
	}
	
	if(strcmp(action,"destroyfire",true) == 0)
	{
		format(dialogstring, sizeof(dialogstring),"Kako bi izbrisali 'plamena', morate unesti ID plamena koji se nalazi na labelu od plamena.");
  		ShowPlayerDialog(playerid, DIALOG_DESTROYFIRE, DIALOG_STYLE_INPUT, "* Destroy Fire", dialogstring, "Spawn", "Close");
	}

	if(strcmp(action,"movefire",true) == 0)
	{
		format(dialogstring, sizeof(dialogstring),"Kako bi promijenili poziciju 'plamena', morate unesti ID plamena koji se nalazi na labelu od plamena.");
  		ShowPlayerDialog(playerid, DIALOG_MOVEFIRE, DIALOG_STYLE_INPUT, "* Move Fire", dialogstring, "Spawn", "Close");
	}

	if(strcmp(action,"firehealth",true) == 0)
	{
	    format(dialogstring, sizeof(dialogstring),"Kako bi promijenili health(kolicina) 'plamena', morate unesti id plamena koji se nalazi na labelu od plamena.");
  		ShowPlayerDialog(playerid, DIALOG_HEALTHFIRE1, DIALOG_STYLE_INPUT, "* Fire Health", dialogstring, "Spawn", "Close");
	}

	if(strcmp(action,"startfire",true) == 0)
	{
		if(firestarted == 1) return SendClientMessage(playerid,COLOR_RED, "Trenutno vec ima aktivnih pozara!");
 		RandomFireSituation();
   		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste aktivirali random pozar.");
	}

	if(strcmp(action,"fdannounce",true) == 0)
	{
	    format(dialogstring, sizeof(dialogstring),"Upisite kakvu poruku zelite poslati online Fire Department clanovima.\n[Primjer]: Izbio je pozar na lokaciji 'location name' i o kakvom se pozaru radi.");
  		ShowPlayerDialog(playerid, DIALOG_FDANNOUNCE, DIALOG_STYLE_INPUT, "* FD Announce", dialogstring, "Spawn", "Close");
	}
	return (true);
}
