#include <YSI_Coding\y_hooks>

#if defined MODULE_BOMBS
	#endinput
#endif
#define MODULE_BOMBS

#define BOMB_TYPE_C4_TRIG			(1)
#define BOMB_TYPE_C4_TIME			(2)
#define BOMB_TYPE_CAR				(3)

#define BOMB_C4_TIMER_PRICE			(3500)
#define BOMB_C4_TRIGGER_PRICE		(4000)
#define BOMB_CAR_PRICE				(2500)

#define MIN_BOMB_TIME				(60)
#define MAX_BOMB_TIME				(300)

enum E_PLAYER_BOMB_DATA {
	bType,				// Tip bombi koje igrac posjeduje
	bVehicleid,			// Ukoliko je auto bomba onda uzimamo vehicleid
	bool:bPlanted,		// Da li je bomba postavljena?
	bTime,				// Vrijeme nakon kojeg ce bomba eksplodirati
	bObject,			// Objekt bombe
	Float:bPos[3],	// XYZ pozicija bombe
	Timer:bTimer		// Timer id
}
new
	BombInfo[MAX_PLAYERS][E_PLAYER_BOMB_DATA];
	
new
	Bit1:r_BombAccept<MAX_PLAYERS>		= { Bit1:false, ... },
	Bit4:r_BombType<MAX_PLAYERS>		= { Bit4:0, ... };	

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock ResetBombArrays(playerid)
{
	if(BombInfo[playerid][bPlanted])
		stop BombInfo[playerid][bTimer];
	BombInfo[playerid][bType]		= -1;
	BombInfo[playerid][bPlanted]	= false;
	BombInfo[playerid][bTime	]		= 0;
	BombInfo[playerid][bVehicleid]	= INVALID_VEHICLE_ID;
	if(IsValidDynamicObject(BombInfo[playerid][bObject])) {
		DestroyDynamicObject(BombInfo[playerid][bObject]);
		BombInfo[playerid][bObject] = INVALID_OBJECT_ID;
	}
	BombInfo[playerid][bPos][0]	= 0.0;
	BombInfo[playerid][bPos][1]	= 0.0;
	BombInfo[playerid][bPos][2]	= 0.0;
	
	Bit1_Set( r_BombAccept, playerid, false);
	Bit4_Set( r_BombType, playerid, 0);
	return 1;
}
stock CreateBomb(playerid, bomb_type = BOMB_TYPE_C4_TIME, bomb_time = MIN_BOMB_TIME, bomb_veh = INVALID_VEHICLE_ID)
{
	BombInfo[playerid][bType]		= bomb_type;
	if(bomb_type == BOMB_TYPE_C4_TIME)
		BombInfo[playerid][bTimer] = repeat OnTimerBombTicks(playerid);
	BombInfo[playerid][bPlanted]	= true;
	BombInfo[playerid][bTime	]		= bomb_time;
	BombInfo[playerid][bVehicleid]	= bomb_veh;

	if(bomb_veh == INVALID_VEHICLE_ID) {
		GetPlayerPos(playerid, BombInfo[playerid][bPos][0], BombInfo[playerid][bPos][1], BombInfo[playerid][bPos][2]);
		BombInfo[playerid][bObject] = CreateDynamicObject(1252, BombInfo[playerid][bPos][0], BombInfo[playerid][bPos][1], BombInfo[playerid][bPos][2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
	}
	return 1;
}
stock DetonateBomb(playerid)
{
	if(!BombInfo[playerid][bPlanted]) return 0;
	
	new 
		Float: bX, 
		Float: bY, 
		Float: bZ;

	if(BombInfo[playerid][bVehicleid] != INVALID_VEHICLE_ID) 
	{
		GetVehiclePos(BombInfo[playerid][bVehicleid], bX, bY, bZ);
  		CreateExplosion(bX, bY, bZ, 3, 10.0);
		SetVehicleHealth(BombInfo[playerid][bVehicleid], 250.0);
		UpdateVehicleDamageStatus(BombInfo[playerid][bVehicleid], 16909060, 16909060, 5, 15);
	}
	else
	{
		bX = BombInfo[playerid][bPos][0];
		bY = BombInfo[playerid][bPos][1];
		bZ = BombInfo[playerid][bPos][2];
		CreateExplosion(BombInfo[playerid][bPos][0], BombInfo[playerid][bPos][1], BombInfo[playerid][bPos][2], 6, 450.0);
	}
 	#if defined MODULE_DEATH
	new 
		Float: damage = 75.0,
		Float: health,
		Float: armour;
	foreach (new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i, 20.0, bX, bY, bZ))
		{
			GetPlayerHealth(i, health);
			GetPlayerArmour(i, armour);
			DealDamage(i, playerid, health, armour, damage, BODY_PART_TORSO);
		}
	}
	#endif
	ResetBombArrays(playerid);
	return 1;
}

timer OnTimerBombTicks[1000](playerid)
{
	if(--BombInfo[playerid][bTime] <= 0) {
		DetonateBomb(playerid);
		stop BombInfo[playerid][bTimer];
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
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_BOMB: 
		{
			if(!response) return 1;
			switch(listitem) 
			{
				case 0: 
				{
					if(AC_GetPlayerMoney(playerid) < BOMB_C4_TIMER_PRICE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za to!");
					PlayerToIllegalBudgetMoney(playerid, BOMB_C4_TIMER_PRICE);
					Bit4_Set( r_BombType, playerid, BOMB_TYPE_C4_TIME);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili bombu na timer! Koristite /bomb plant za njeno postavljanje!");
				}
				case 1: 
				{
					if(AC_GetPlayerMoney(playerid) < BOMB_C4_TRIGGER_PRICE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za to!");
					PlayerToIllegalBudgetMoney(playerid, BOMB_C4_TRIGGER_PRICE);
					Bit4_Set( r_BombType, playerid, BOMB_TYPE_C4_TRIG);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili bombu na okidac! Koristite /bomb plant za njeno postavljanje!");
				}
				case 2: 
				{
					if(AC_GetPlayerMoney(playerid) < BOMB_CAR_PRICE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za to!");
					PlayerToIllegalBudgetMoney(playerid, BOMB_CAR_PRICE);
					Bit4_Set( r_BombType, playerid, BOMB_TYPE_CAR);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili bombu za vozilo! Koristite /bomb plant za njeno postavljanje!");
				}
			}
			return 1;
		}
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE)) {
		if(BombInfo[playerid][bPlanted] && BombInfo[playerid][bType] == BOMB_TYPE_C4_TRIG) 
		{
			if(AC_GetPlayerWeapon(playerid) == WEAPON_BOMB)
			{
				DetonateBomb(playerid);
			}
		}
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

CMD:bomb(playerid, params[])
{
	new
		param[8];
	if(sscanf( params, "s[8] ", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /bomb [buy/approve/plant]");
	if(!strcmp(param, "buy", true)) 
	{
		if(!IsPlayerInRangeOfPoint(playerid, 8.0, 2116.0029, 182.7116, 0.4943)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mjesta gdje se kupuju bombe!");
		if(!Bit1_Get( r_BombAccept, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate traziti admina level 4+ za dopustenje!");
		if(!PlayerFaction[playerid][pMember] || !PlayerFaction[playerid][pLeader]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u official organizaciji da kupujete bombu!");
		ShowPlayerDialog(playerid, DIALOG_BOMB, DIALOG_STYLE_LIST, "KUPOVINA BOMBI", "C4(Timer) [35.000$]\nC4(Trigger) [40.000$]\nCar Bomb[25.000$]", "Choose", "Abort");
	}
	else if(!strcmp(param, "approve", true)) 
	{
		if(PlayerInfo[playerid][pAdmin] < 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
		new 
			giveplayerid;
		if(sscanf(params, "s[8]u", param, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /bomb approve [dio imena/playerid]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos playerida!");
		Bit1_Set( r_BombAccept, giveplayerid, true);
		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Admin %s vam je dozvolio postavljanje bombe!", GetName(playerid, false));
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Odobrili ste %s postavljanje bombe!", GetName(giveplayerid, false));		
	}
	else if(!strcmp(param, "plant", true)) 
	{
		if(!Bit1_Get( r_BombAccept, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate traziti admina level 4+ za dopustenje!");
		if(!Bit4_Get( r_BombType, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate prvo kupiti bombu!");
		new
			bomb_type = Bit4_Get( r_BombType, playerid);
		switch(bomb_type) 
		{
			case BOMB_TYPE_C4_TIME: 
			{
				new
					time;
				if(sscanf( params, "s[8]i", param, time)) return SendClientMessage(playerid, COLOR_RED, "[?]: /bomb plant [vrijeme (u sekundama)]");
				if(time < MIN_BOMB_TIME || time > MAX_BOMB_TIME) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Timer na bombi mora biti u rasponu od %d do %d.", MIN_BOMB_TIME, MAX_BOMB_TIME); 
				CreateBomb(playerid, BOMB_TYPE_C4_TIME, time, INVALID_VEHICLE_ID);
			}
			case BOMB_TYPE_CAR: 
			{
				new vehicle = GetNearestVehicle(playerid);
				if(vehicle == INVALID_VEHICLE_ID) 
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near any vehicle!");
				CreateBomb(playerid, BOMB_TYPE_CAR, 0, vehicle);
			}
			case BOMB_TYPE_C4_TRIG: 
			{
				AC_GivePlayerWeapon(playerid, WEAPON_BOMB, 1);
				CreateBomb(playerid, BOMB_TYPE_C4_TRIG, 0, INVALID_VEHICLE_ID);
			}
		}
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili bombu!");
		Bit4_Set( r_BombType, playerid, 0);
	}
	return 1;
}
