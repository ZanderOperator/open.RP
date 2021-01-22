#include <YSI_Coding\y_hooks>

#if defined MODULE_DEATH
	#endinput
#endif
#define MODULE_DEATH

#define MAX_DROPPED_ITEMS 999

/*
	######## ##    ## ##     ## ##     ## 
	##       ###   ## ##     ## ###   ### 
	##       ####  ## ##     ## #### #### 
	######   ## ## ## ##     ## ## ### ## 
	##       ##  #### ##     ## ##     ## 
	##       ##   ### ##     ## ##     ## 
	######## ##    ##  #######  ##     ## 
*/

enum PLAYER_DEATH_DATA
{
	ddOverall,
	ddTorso[43],
	ddGroin[43],
	ddLArm[43],
	ddRArm[43],
	ddLLeg[43],
	ddRLeg[43],
	ddHead[43],
	Text3D:dd3dText
}
stock
	DeathData[MAX_PLAYERS][PLAYER_DEATH_DATA];
enum DROPPED_WEAPON_DATA
{
	dWeaponID,
	dWeaponAmmo,
	dWeaponObject,
	Float:dPos[3]
}
new DroppedWeapons[MAX_DROPPED_ITEMS][DROPPED_WEAPON_DATA];

new Iterator:WeaponsDropped<MAX_DROPPED_ITEMS>;
/*

	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

new
	Bit1:	gr_DeathCountStarted	<MAX_PLAYERS>,
	Bit8:	gr_DeathCountSeconds	<MAX_PLAYERS>;

new
	Timer:DeathTimer[MAX_PLAYERS],
	PlayerText:DeathPlayerTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };
	
new
	DeathTime[MAX_PLAYERS];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock DeathCountStarted_Get(playerid)
{
	return Bit1_Get(gr_DeathCountStarted, playerid);
}

stock DeathCountStarted_Set(playerid, bool:status)
{
	return Bit1_Set(gr_DeathCountStarted, playerid, status);
}

stock DeathCountSeconds_Set(playerid, secs)
{
	return Bit8_Set(gr_DeathCountSeconds, playerid, secs);
}

stock GetDroppedWeaponFreeID()
{
	return Iter_Free(WeaponsDropped);
}

stock GetNearDroppedWeapon(playerid)
{
	foreach(new slotid: WeaponsDropped)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 4.0, DroppedWeapons[slotid][dPos][0], DroppedWeapons[slotid][dPos][1], DroppedWeapons[slotid][dPos][2]))
		{
			if(! CheckPlayerWeapons(playerid, DroppedWeapons[slotid][dWeaponID])) return 1;
			AC_GivePlayerWeapon(playerid, DroppedWeapons[slotid][dWeaponID], DroppedWeapons[slotid][dWeaponAmmo]);
			#if defined MODULE_LOGS
			Log_Write("/logfiles/pickitems.txt", "(%s) %s took %s(%d ammo) from floor.", ReturnDate(), GetName(playerid), GetWeaponNameEx(DroppedWeapons[slotid][dWeaponID]), DroppedWeapons[slotid][dWeaponAmmo]);
			#endif
			DestroyDynamicObject(DroppedWeapons[slotid][dWeaponObject]);
			DroppedWeapons[slotid][dWeaponID] = 0;
			DroppedWeapons[slotid][dWeaponAmmo] = 0;
			DroppedWeapons[slotid][dPos][0] = 0;
			DroppedWeapons[slotid][dPos][1] = 0;
			DroppedWeapons[slotid][dPos][2] = 0;
			new string[80];
			format(string, sizeof(string), "%s uzima nesto sa poda.", GetName(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			new next;
			Iter_SafeRemove(WeaponsDropped, slotid, next);
			return 1;
		}
	}
	return 0;
}

stock DropPlayerWeapon(playerid, weaponid, Float:x, Float:y)
{
    new
		Float:Z;
	MapAndreas_FindAverageZ(x, y, Z);
	new i = GetWeaponSlot(weaponid);
	if(PlayerWeapons[playerid][pwAmmo][i] > 0)
	{
		new slot = GetDroppedWeaponFreeID();
		if(slot >= 0)
		{
			new Float:rndx = (10 / randomEx(20, 100)) + randomEx(1,3),
				Float:rndy = (10 / randomEx(40, 100)) + randomEx(1,3),
				Float:rndrot = randomEx(0, 180);

			DroppedWeapons[slot][dWeaponObject] = CreateDynamicObject(WeaponModels(weaponid), x+rndx, y+rndy, Z, 90, rndrot, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
			DroppedWeapons[slot][dWeaponID] = PlayerWeapons[playerid][pwWeaponId][i];
			DroppedWeapons[slot][dWeaponAmmo] = PlayerWeapons[playerid][pwAmmo][i];

			DroppedWeapons[slot][dPos][0] = x;
			DroppedWeapons[slot][dPos][1] = y;
			DroppedWeapons[slot][dPos][2] = Z;
			#if defined MODULE_LOGS
			Log_Write("/logfiles/dropitems.txt", "(%s) %s dropped a weapon %s(Ammo:%d) on the floor.", ReturnDate(), GetName(playerid),  GetWeaponNameEx(DroppedWeapons[slot][dWeaponID]), DroppedWeapons[slot][dWeaponAmmo]);
			#endif
		}
	}
	AC_ResetPlayerWeapon(playerid, weaponid);
	return 1;
}
stock DropPlayerWeapons(playerid, Float:x, Float:y)
{
    new
		Float:Z;
	MapAndreas_FindAverageZ(x, y, Z);
	for(new i = 0; i <= 12; i++) 
	{
		if(PlayerWeapons[playerid][pwAmmo][i] > 0)
        {
            new slot = GetDroppedWeaponFreeID();
            if(slot >= 0)
            {
                new Float:rndx = (10 / randomEx(20, 100)) + randomEx(1,3),
					Float:rndy = (10 / randomEx(40, 100)) + randomEx(1,3),
					Float:rndrot = randomEx(0, 180);

                DroppedWeapons[slot][dWeaponObject] = CreateDynamicObject(WeaponModels(PlayerWeapons[playerid][pwWeaponId][i]), x+rndx, y+rndy, Z+0.1, 90, rndrot, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
                DroppedWeapons[slot][dWeaponID] = PlayerWeapons[playerid][pwWeaponId][i];
				if(PlayerWeapons[playerid][pwAmmo][i] < 500)
					DroppedWeapons[slot][dWeaponAmmo] = PlayerWeapons[playerid][pwAmmo][i];
				else
					DroppedWeapons[slot][dWeaponAmmo] = 500;
					
                DroppedWeapons[slot][dPos][0] = x;
                DroppedWeapons[slot][dPos][1] = y;
                DroppedWeapons[slot][dPos][2] = Z;

				Iter_Add(WeaponsDropped, slot);
				#if defined MODULE_LOGS
				Log_Write("/logfiles/dropitems.txt", "(%s) %s dropped a weapon %s(Ammo:%d) on the floor after death.", ReturnDate(), GetName(playerid),  GetWeaponNameEx(DroppedWeapons[slot][dWeaponID]), DroppedWeapons[slot][dWeaponAmmo]);
				#endif
			}
        }
	}
	AC_ResetPlayerWeapons(playerid);
	return 1;
}


/*
stock DropPlayerMoney(playerid) // Na Death Modeu
{
	if(PlayerVIP[playerid][pDonateRank] > PREMIUM_BRONZE) return 0;
	new money = AC_GetPlayerMoney(playerid);
	if(money > 0)
	{
		new str[156];
		format(str, sizeof(str), "%s je ispustio %d$ na pod nakon smrti.", GetName(playerid), money);
		LogDropItem(str);
		PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
	}
	return 1;
}*/

stock ResetDeathVars(playerid)
{
	DestroyDeathTDs(playerid);
	if(IsValidDynamic3DTextLabel(DeathData[playerid][dd3dText])) {
		DestroyDynamic3DTextLabel( DeathData[playerid][dd3dText] );
		DeathData[playerid][dd3dText] = Text3D:INVALID_3DTEXT_ID;
	}
	DeathData[playerid][ddOverall] = 0;
	for(new i=0; i < 43; i++)
	{
		DeathData[playerid][ddTorso][i]	= 0;
		DeathData[playerid][ddGroin][i]	= 0;
		DeathData[playerid][ddLArm][i] 	= 0;
		DeathData[playerid][ddRArm][i] 	= 0;
		DeathData[playerid][ddLLeg][i] 	= 0;
		DeathData[playerid][ddRLeg][i] 	= 0;
		DeathData[playerid][ddHead][i] 	= 0;
	}
	return 1;
}

stock StopPlayerDeath(playerid)
{
	DestroyDeathInfo(playerid);
	DestroyDeathTDs(playerid);
	stop DeathTimer[playerid];

	DeathCountStarted_Set(playerid, false);
	DeathCountSeconds_Set(playerid, 0);

	PlayerDeath[playerid][pDeathX] 	= 0.0;
	PlayerDeath[playerid][pDeathY] 	= 0.0;
	PlayerDeath[playerid][pDeathZ] 	= 0.0;
	PlayerDeath[playerid][pDeathInt] 	= 0;
	PlayerDeath[playerid][pDeathVW] 		= 0;
	PlayerDeath[playerid][pKilled] 	 	= 0;

	return 1;
}

stock CreateDeathTD(playerid)
{
	DestroyDeathTDs(playerid);
	DeathPlayerTextDraw[playerid] = CreatePlayerTextDraw(playerid, 42.079872, 318.527923, "60 SEKUNDI");
	PlayerTextDrawLetterSize(		playerid, DeathPlayerTextDraw[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(		playerid, DeathPlayerTextDraw[playerid], 1);
	PlayerTextDrawColor(			playerid, DeathPlayerTextDraw[playerid], -2147483393);
	PlayerTextDrawSetShadow(		playerid, DeathPlayerTextDraw[playerid], 0);
	PlayerTextDrawSetOutline(		playerid, DeathPlayerTextDraw[playerid], 1);
	PlayerTextDrawBackgroundColor(	playerid, DeathPlayerTextDraw[playerid], 51);
	PlayerTextDrawFont(				playerid, DeathPlayerTextDraw[playerid], 3);
	PlayerTextDrawSetProportional(	playerid, DeathPlayerTextDraw[playerid], 1);
	PlayerTextDrawShow(				playerid, DeathPlayerTextDraw[playerid]);
}

stock DestroyDeathTDs(playerid)
{
	PlayerTextDrawDestroy(playerid, DeathPlayerTextDraw[playerid]);
	DeathPlayerTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock DestroyDeathInfo(playerid)
{
	if(IsValidDynamic3DTextLabel(DeathData[playerid][dd3dText])) {
		DestroyDynamic3DTextLabel( DeathData[playerid][dd3dText] );
		DeathData[playerid][dd3dText] = Text3D:INVALID_3DTEXT_ID;
	}	
	DeathData[playerid][ddOverall] = 0;
	
	for( new weaponid = 22; weaponid != 34; weaponid++ ) {
		if(DeathData[playerid][ddTorso][weaponid] )
			DeathData[playerid][ddTorso][weaponid]	= 0;
		if(DeathData[playerid][ddGroin][weaponid] )
			DeathData[playerid][ddGroin][weaponid]	= 0;
		if(DeathData[playerid][ddLArm][weaponid] )
			DeathData[playerid][ddLArm][weaponid] 	= 0;
		if(DeathData[playerid][ddRArm][weaponid] )
			DeathData[playerid][ddRArm][weaponid] 	= 0;
		if(DeathData[playerid][ddLLeg][weaponid] )
			DeathData[playerid][ddLLeg][weaponid] 	= 0;
		if(DeathData[playerid][ddRLeg][weaponid] )
			DeathData[playerid][ddRLeg][weaponid] 	= 0;
		if(DeathData[playerid][ddHead][weaponid] )
			DeathData[playerid][ddHead][weaponid] 	= 0;
	}
	return 1;
}
stock CreateDeathInfos(playerid, situation = 0)
{
	new
		tmpString[85];

	if(IsValidDynamic3DTextLabel(DeathData[playerid][dd3dText])) {
		DestroyDynamic3DTextLabel( DeathData[playerid][dd3dText] );

		DeathData[playerid][dd3dText] = Text3D:INVALID_3DTEXT_ID;
	}
	switch(situation)
	{
		case 0:
		{
			format(tmpString, sizeof(tmpString), "** %s je ranjen %d puta (( DeathMode | /alldamages %d )) **", GetName(playerid), DeathData[playerid][ddOverall], playerid);
			DeathData[playerid][dd3dText] = CreateDynamic3DTextLabel(tmpString, COLOR_DEATH, 0.0000, 0.0000, 0.3500, 15.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
		}
		case 1:
		{
			format(tmpString, sizeof(tmpString), "** Osoba je mrtva, %d rana  (( /alldamages %d )) **", DeathData[playerid][ddOverall], playerid);
			DeathData[playerid][dd3dText] = CreateDynamic3DTextLabel(tmpString, COLOR_DEATH, 0.0000, 0.0000, 0.3500, 15.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
		}
		case 2:
		{
			format(tmpString, sizeof(tmpString), "** %s je ranjen %d puta (( Wounded | /alldamages %d )) **", GetName(playerid), DeathData[playerid][ddOverall], playerid);
			DeathData[playerid][dd3dText] = CreateDynamic3DTextLabel(tmpString, COLOR_DEATH, 0.0000, 0.0000, 0.3500, 15.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
		}
	}
	return 1;
}
stock LoadPlayerDeath(playerid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM player_deaths WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]),
		"LoadingPlayerDeaths", 
		"i", 
		playerid
	);
	return 1;
}
forward LoadingPlayerDeaths(playerid);
public LoadingPlayerDeaths(playerid)
{
	if(!cache_num_rows())
		return 0;

	cache_get_value_name_int(0, "killed", PlayerDeath[playerid][pKilled]);
	cache_get_value_name_float(0, "pos_x", PlayerDeath[playerid][pDeathX]);
	cache_get_value_name_float(0, "pos_y", PlayerDeath[playerid][pDeathY]);
	cache_get_value_name_float(0, "pos_z", PlayerDeath[playerid][pDeathZ]);
	cache_get_value_name_int(0, "interior", PlayerDeath[playerid][pDeathInt]);
	cache_get_value_name_int(0, "viwo", PlayerDeath[playerid][pDeathVW]);

	mysql_fquery(g_SQL, "DELETE FROM player_deaths WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]);
	return 1;
}

/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##     ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

hook function LoadPlayerStats(playerid)
{
	LoadPlayerDeath(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
	if(Bit1_Get( gr_DeathCountStarted, playerid )) 
	{
		DestroyDeathInfo(playerid);
		stop DeathTimer[playerid];
		Bit1_Set( gr_DeathCountStarted, playerid, false );
		Bit8_Set( gr_DeathCountSeconds, playerid, 0 );
	}
	ResetDeathVars(playerid);

	PlayerDeath[playerid][pKilled]			= 0;
	PlayerDeath[playerid][pDeathInt] 		= 0;
	PlayerDeath[playerid][pDeathVW] 		= 0;
	PlayerDeath[playerid][pDeathX] 			= 0.0;
	PlayerDeath[playerid][pDeathY] 			= 0.0;
	PlayerDeath[playerid][pDeathZ] 			= 0.0;
	
	return continue(playerid);
}

hook OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(weaponid < 43)
	switch( bodypart ) 
	{
		case BODY_PART_TORSO:			DeathData[playerid][ddTorso][weaponid]++;
		case BODY_PART_GROIN:          	DeathData[playerid][ddGroin][weaponid]++;
		case BODY_PART_LEFT_ARM:       	DeathData[playerid][ddLArm][weaponid]++;
		case BODY_PART_RIGHT_ARM:      	DeathData[playerid][ddRArm][weaponid]++;
		case BODY_PART_LEFT_LEG:       	DeathData[playerid][ddLLeg][weaponid]++;
		case BODY_PART_RIGHT_LEG:      	DeathData[playerid][ddRLeg][weaponid]++;
		case BODY_PART_HEAD: 			DeathData[playerid][ddHead][weaponid]++;
	}
	DeathData[playerid][ddOverall] ++;
	return 0;
}

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

timer StartDeathCount[1000](playerid)
{
	if(Bit8_Get(gr_DeathCountSeconds, playerid) > 0)
	{
		new 
			tmpString[32];
		
		Bit8_Set(gr_DeathCountSeconds, playerid, Bit8_Get(gr_DeathCountSeconds, playerid) - 1);
		format(tmpString, sizeof(tmpString), "%d SEKUNDI", Bit8_Get(gr_DeathCountSeconds, playerid));
		PlayerTextDrawSetString(playerid, DeathPlayerTextDraw[playerid], tmpString);
		
		if(!Bit8_Get(gr_DeathCountSeconds, playerid)) 
		{
			GameTextForPlayer( playerid, "~g~Nekoliko sati kasnije...", 1000, 1 );
			
			stop DeathTimer[playerid];
			DeathTime[playerid] = 0;
			
			Bit8_Set(gr_DeathCountSeconds, playerid, 0);
			Bit1_Set(gr_DeathCountStarted, playerid, false);
			
			DestroyDeathInfo(playerid);
			DestroyDeathTDs(playerid);
			
			PlayerToFactionMoneyTAX(playerid, FACTION_TYPE_FD, 500); // novac bolnici i proracunu*/
			SendClientMessage(playerid, COLOR_RED, "[!] Platio si bolnicke troskove u visini od 500$!");
			
			PlayerDeath[playerid][pDeathX] 	= 0.0;
			PlayerDeath[playerid][pDeathY] 	= 0.0;
			PlayerDeath[playerid][pDeathZ] 	= 0.0;
			PlayerDeath[playerid][pDeathInt] 	= 0;
			PlayerDeath[playerid][pDeathVW] 		= 0;
			PlayerDeath[playerid][pKilled] 	 	= 0;

            ResetPlayerWounded(playerid);
			SetPlayerDrunkLevel(playerid, 0);
			
			mysql_fquery(g_SQL, "DELETE FROM player_deaths WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]);			
			SetPlayerHealth(playerid, 0);
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
CMD:pickitem(playerid, params[])
{
	new str[32];
	if(sscanf(params, "s[32]", str)) return SendClientMessage(playerid, COLOR_RED, "[?]: /pickitem [weapon]");
	if(PlayerDeath[playerid][pKilled] > 0)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes uzimat predmete sa poda dok si u death stanju.");
	if(strcmp(str, "weapon", true) == 0)
	{
	    if(PlayerInfo[playerid][pLevel] > 1)
	    {
			if(!GetNearDroppedWeapon(playerid))
		    {
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "U vasoj blizini nema nikakvog oruzja.");
		    }
	    }
	    else
	        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljan level za posjedovanje oruzja.(level2)");
		return 1;
    }
    else
        SendClientMessage(playerid, COLOR_RED, "[?]: /pickitem [weapon/money]");
	return 1;
}

CMD:alldamages(playerid, params[])
{
	new
		damageString[160],
		damageNameString[30],
		motd[1024],
		gplayerid = INVALID_PLAYER_ID;
		
	if(sscanf(params, "u", gplayerid))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /alldamages [PlayerID / Part of name]");
		return 1;
	}
	if(!IsPlayerConnected(gplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pogresan ID igraca/nick!!");
	if(!SafeSpawned[gplayerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan!");
	if(!PlayerDeath[gplayerid][pKilled] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije u Wounded/Death Modeu!");

	new Float: pX, Float: pY, Float: pZ;
	GetPlayerPos(gplayerid, pX, pY, pZ);
	if(GetPlayerDistanceFromPoint(playerid, pX, pY, pZ) >= 50.0)
	{
		SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Niste dovoljno blizu %s!", GetName(gplayerid, false));
		return 1;
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Glava:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddHead][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddHead][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}

	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Torzo(trup):\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddTorso][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddTorso][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Prepone:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddGroin][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddGroin][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Lijeva ruka:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddLArm][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddLArm][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Desna ruka:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddRArm][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddRArm][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Lijeva noga:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddLLeg][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddLLeg][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	
	damageNameString[0] = EOS;
	format(damageNameString, sizeof(damageNameString), "Desna noga:\n");
	strcat(motd, damageNameString, sizeof(motd));
	
	for( new weaponid = 0; weaponid != 34; weaponid++ ) 
	{
		if(DeathData[gplayerid][ddRLeg][weaponid] )
		{
			damageString[0] = EOS;
			format(damageString, sizeof(damageString), "\tOruzje: %s | Nanesene rane: %d puta\n", 
				GetWeaponNameEx(weaponid), 
				DeathData[gplayerid][ddRLeg][weaponid]
			);
			strcat(motd, damageString, sizeof(motd));
		}
	}
	new dcaption[90];
	format(dcaption, sizeof(dcaption), "Ozljede na %s:", GetName(gplayerid));
	ShowPlayerDialog(playerid, PLAYER_DAMAGES_DIALOG, DIALOG_STYLE_MSGBOX, dcaption, motd, "Exit","");
	return 1;
}