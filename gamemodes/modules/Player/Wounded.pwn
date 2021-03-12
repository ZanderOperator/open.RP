#include <YSI_Coding\y_hooks>

#if defined MODULE_WOUNDED
	#endinput
#endif
#define MODULE_WOUNDED

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

// IDovi ozlijeda
#define PLAYER_WOUNDED_LEG					(1)
#define PLAYER_WOUNDED_ARMS					(2)
#define PLAYER_WOUNDED_TORSO				(3)
#define PLAYER_WOUNDED_GROIN				(4)
#define PLAYER_WOUNDED_HEAD					(5)

// Damage
#define WOUND_LEGS_AMOUNT					(0.02)
#define WOUND_ARMS_AMOUNT					(0.02)
#define WOUND_BODY_AMOUNT					(0.04)
#define WOUND_HEAD_AMOUNT					(0.08)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/



// TextDraws
static stock 
	PlayerText:WndedBcg[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:WndedText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };
	
// rBits
new
	Bit8:r_PlayerWounded<MAX_PLAYERS>		= { Bit8:0, ... };
	
// 32bit
static stock
	Timer:PlayerBleedTimer[MAX_PLAYERS];
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/*
	TTTTTT EEEE X   X TTTTTT DDD  RRRR   AA  W     W  SSS  
	  TT   E     X X    TT   D  D R   R A  A W     W S     
	  TT   EEE    X     TT   D  D RRRR  AAAA W  W  W  SSS  
	  TT   E     X X    TT   D  D R R   A  A  W W W      S 
	  TT   EEEE X   X   TT   DDD  R  RR A  A   W W   SSSS
*/

timer HidePlayerWoundedTDs[10000](playerid)
{
	DestroyPlayerWoundedTDs(playerid);
	return 1;
}

stock ApplyWoundedAnimation(playerid, bodypart)
{
	if(PlayerWoundedAnim[playerid]) 
		return 1;
		
	if(PlayerDeath[playerid][pKilled] == 0)
	{
		new cbstring[64];
		format(cbstring, sizeof(cbstring), "* %s je ranjen i pada na pod.", GetName(playerid, true));
		SetPlayerChatBubble(playerid, cbstring, COLOR_PURPLE, 20, 2500);
		GameTextForPlayer(playerid, "~b~BRUTALLY WOUNDED", 5000, 3);
		PlayerWoundedAnim[playerid] = true;
		PlayerWounded[playerid] = true;
		PlayerWoundedSeconds[playerid] = gettimestamp() + 30; // 30 sekundi
		PlayerDeath[playerid][pKilled] = 1; // Wounded state
		SetPlayerDrunkLevel(playerid, 5000);
		CreateDeathInfos(playerid, 2); // Wounded Situation
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(IsABike(GetVehicleModel(vehicleid)) || IsAMotorBike(GetVehicleModel(vehicleid)))
				RemovePlayerFromVehicle(playerid), defer ApplyVehicleFallAnim(playerid);
			else 
				ApplyAnimation(playerid, "PED", "CAR_dead_LHS", 4.1, 0, 1, 1, 1, 0);
			return 1;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			switch(bodypart)
			{
				case BODY_PART_TORSO:
					ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0);
				case BODY_PART_GROIN:
					ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0);
				case BODY_PART_LEFT_ARM:
					ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0);
				case BODY_PART_RIGHT_ARM:
					ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0);
				case BODY_PART_HEAD:
					ApplyAnimation(playerid, "PED", "KO_shot_face",4.1,0,1,1,1,0);
				case BODY_PART_LEFT_LEG:
					ApplyAnimation(playerid, "CRACK","crckdeth2", 4.1,0,1,1,1,0);
				case BODY_PART_RIGHT_LEG:
					ApplyAnimation(playerid, "CRACK","crckdeth2", 4.1,0,1,1,1,0);
			}
		}
	}
	return 1;
}

stock ResetPlayerWounded(playerid)
{
	if(Bit8_Get( r_PlayerWounded, playerid) != 0) 
		stop PlayerBleedTimer[playerid];
	
	DestroyPlayerWoundedTDs(playerid);
	Bit8_Set(r_PlayerWounded, playerid, 0);
		
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47,				999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 				999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 				999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 			999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 	999);
	SetPlayerDrunkLevel(playerid, 0);
	
	PlayerWounded[playerid] 	= false;
	PlayerWoundedAnim[playerid] = false;
	PlayerWoundedSeconds[playerid] = 0;
	PlayerWTripTime[playerid] = 0;
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetPlayerWounded(playerid);
	return continue(playerid);
}

RegisterPlayerDeath(playerid, killerid) // funkcija
{
	new
		tmpString[135];
	format(tmpString, 135, "KillWarn: Player %s[%d] killed player %s[%d] with %s!",
		GetName( killerid, false),
		killerid,
		GetName( playerid, false),
		playerid,
		GetWeaponNameEx(killerid)
	);
	DMERSBroadCast(COLOR_RED, tmpString, 1);

	mysql_fquery_ex(SQL_Handle(), 
		"INSERT INTO \n\
			server_deaths \n\
		(killer_id, death_id, weaponid, date) \n\
		VALUES \n\
			('%d','%d','%d','%d')",
		PlayerInfo[KilledBy[playerid]][pSQLID],
		PlayerInfo[playerid][pSQLID],
		KilledReason[playerid],
		gettimestamp()
	);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/kills.txt", 
		"(%s) %s{%d}(%s) has killed %s{%d}(%s) with %s(%d).",
		ReturnDate(),
		GetName(killerid, false),
		PlayerInfo[killerid][pSQLID],
		ReturnPlayerIP(killerid),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		ReturnPlayerIP(playerid),
		GetWeaponNameEx(KilledReason[playerid]),
		KilledReason[playerid]
	);
	#endif
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	PlayerDeath[playerid][pDeathX] 	= X;
	PlayerDeath[playerid][pDeathY] 	= Y;
	PlayerDeath[playerid][pDeathZ] 	= Z;
	PlayerDeath[playerid][pDeathInt] 	= GetPlayerInterior( playerid);
	PlayerDeath[playerid][pDeathVW] 		= GetPlayerVirtualWorld( playerid);

	// FIRST DEATH
	if(DeathData[playerid][ddOverall] > 0)
	{
		DeathTime[playerid] = gettimestamp() + 60;
		//DropPlayerMoney(playerid); // Gubitak novca

		//DropPlayerWeapons(playerid, X, Y);
		//DropPlayerDrugs(playerid, X, Y, true);

		mysql_fquery_ex(SQL_Handle(), 
			"INSERT INTO \n\
				player_deaths \n\
			(player_id, killed, pos_x, pos_y, pos_z, interior, viwo, time) \n\
			VALUES \n\
				('%d','%f','%f','%f','%d','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerDeath[playerid][pKilled],
			PlayerDeath[playerid][pDeathX],
			PlayerDeath[playerid][pDeathY],
			PlayerDeath[playerid][pDeathZ],
			PlayerDeath[playerid][pDeathInt],
			PlayerDeath[playerid][pDeathVW],
			gettimestamp()
		);
	}
	AC_ResetPlayerWeapons(playerid);

	HiddenWeapon[playerid][pwSQLID] = -1;
	HiddenWeapon[playerid][pwWeaponId] = 0;
	HiddenWeapon[playerid][pwAmmo] = 0;

	HidePlayerMobile(playerid);
	
	RemovePlayerMask(playerid);

	KilledBy[playerid] = INVALID_PLAYER_ID;
	WoundedBy[playerid] = INVALID_PLAYER_ID;
	KilledReason[playerid] = -1;

	PlayerDeath[playerid][pKilled] = 0;

	Bit1_Set(gr_PlayerAlive, 	playerid, true);
	return 1;
}

stock InflictPlayerDamage(playerid, issuerid, bodypart, Float:damage)
{
	if(PlayerDeath[playerid][pKilled] != 2 && KilledBy[playerid] == INVALID_PLAYER_ID)
	{
		new Float:health;
		GetPlayerHealth(playerid, health);
		if((health - damage) <= 2.0)
		{
			if(PlayerWounded[playerid])
			{
				SetPlayerDrunkLevel(playerid, 0);
				SetPlayerHealth(playerid, 100);
				TogglePlayerControllable(playerid, 0);
				AC_ResetPlayerWeapons(playerid);
				
				KilledBy[playerid] = issuerid;
				KilledReason[playerid] = AC_GetPlayerWeapon(issuerid);
				
				PlayerDeath[playerid][pKilled] = 2;
				SendClientMessage(playerid, COLOR_DEATH, "Smrtno si ranjen. Pricekaj 60 sekundi do ponovnog spawna!");
				RegisterPlayerDeath(playerid, issuerid);

				if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
					ApplyAnimation(playerid,"WUZI","CS_DEAD_GUY", 4.0,0,1,1,1,0);

				DeathCountStarted_Set(playerid, true);
				DeathCountSeconds_Set(playerid, 61);

				CreateDeathTD(playerid);
				CreateDeathInfos(playerid, 1);

				DeathTimer[playerid] = repeat StartDeathCount(playerid);
				return (true);
			}
			else
			{
				ApplyWoundedAnimation(playerid, bodypart);
				SendClientMessage(playerid, COLOR_RED, "[!] Tesko ste ranjeni te pali na pod. Ako izgubite sav HP - DeathMode. ");
				SendClientMessage(playerid, COLOR_DEATH, "* Tek nakon 30 sec mozete ulaziti u kola kao vozac/suvozac.");
				GameTextForPlayer(playerid, "~b~TESKO RANJEN", 5000, 3);
				SetPlayerHealth(playerid, 25.0);
				AC_ResetPlayerWeapons(playerid);
				
				new
					wndString[135];
				format(wndString, 135, "KillWarn: Igrac %s[%d] je bacio u wounded mode igraca %s[%d] oruzjem %s!",
					GetName( issuerid, false),
					issuerid,
					GetName( playerid, false),
					playerid,
					GetWeaponNameEx(AC_GetPlayerWeapon(issuerid))
				);
				DMERSBroadCast(COLOR_RED, wndString, 1);

				#if defined MODULE_LOGS
				Log_Write("logfiles/kills.txt", "[WOUNDED] (%s) %s{%d}(%s) brutally wounded %s{%d}(%s) with %s(%d).",
					ReturnDate(),
					GetName(issuerid, false),
					PlayerInfo[issuerid][pSQLID],
					ReturnPlayerIP(issuerid),
					GetName(playerid, false),
					PlayerInfo[playerid][pSQLID],
					ReturnPlayerIP(playerid),
					GetWeaponNameEx(AC_GetPlayerWeapon(issuerid)),
					AC_GetPlayerWeapon(issuerid)
				);
				#endif
				
				new
					Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X, Y, Z);

				PlayerDeath[playerid][pDeathX] 	= X;
				PlayerDeath[playerid][pDeathY] 	= Y;
				PlayerDeath[playerid][pDeathZ] 	= Z;
				PlayerDeath[playerid][pDeathInt] 	= GetPlayerInterior( playerid);
				PlayerDeath[playerid][pDeathVW] 		= GetPlayerVirtualWorld( playerid);
				if(DeathData[playerid][ddOverall] > 0)
				{
					DeathTime[playerid] = gettimestamp() + 60;
					//DropPlayerMoney(playerid); // Gubitak novca
					//DropPlayerWeapons(playerid, X, Y);
					//DropPlayerDrugs(playerid, X, Y, true);

					mysql_fquery_ex(SQL_Handle(), 
						"INSERT INTO \n\
							player_deaths \n\
						(player_id, killed, pos_x, pos_y, pos_z, interior, viwo, time) \n\
						VALUES \n\
							('%d','%f','%f','%f','%d','%d','%d')",
						PlayerInfo[playerid][pSQLID],
						PlayerDeath[playerid][pKilled],
						PlayerDeath[playerid][pDeathX],
						PlayerDeath[playerid][pDeathY],
						PlayerDeath[playerid][pDeathZ],
						PlayerDeath[playerid][pDeathInt],
						PlayerDeath[playerid][pDeathVW],
						gettimestamp()
					);
				}
				return (true);
			}
		}
		else 
			return SetPlayerHealth(playerid, health - damage);
	}
	return 1;
}

stock DealDamage(playerid, issuerid, Float: health, Float: armour, Float: damage, bodypart = BODY_PART_GROIN)
{		
	if(PlayerDeath[playerid][pKilled] != 2 && KilledBy[playerid] == INVALID_PLAYER_ID)
	{		
		new Float: rest = armour - damage;
		if(armour > 0)
		{
			if(bodypart == BODY_PART_TORSO)
			{
				if(rest <= 0) {
					SetPlayerArmour(playerid, 0);
				}	
				else
					SetPlayerArmour(playerid, rest);
				return (true);
			}
			else return InflictPlayerDamage(playerid, issuerid, bodypart, damage);
		}
		if((health - damage) <= 2.0)
		{
			if(PlayerWounded[playerid])
			{
				SetPlayerDrunkLevel(playerid, 0);
				SetPlayerHealth(playerid, 100);
				TogglePlayerControllable(playerid, 0);
				
				KilledBy[playerid] = issuerid;
				KilledReason[playerid] = AC_GetPlayerWeapon(issuerid);
				
				PlayerDeath[playerid][pKilled] = 2;
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Smrtno si ranjen. Pricekaj 60 sekundi do ponovnog spawna!");
				RegisterPlayerDeath(playerid, issuerid);

				if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
					ApplyAnimation(playerid,"WUZI","CS_DEAD_GUY", 4.0,0,1,1,1,0);
				
				DeathCountStarted_Set(playerid, true);
				DeathCountSeconds_Set(playerid, 61);

				CreateDeathTD(playerid);
				CreateDeathInfos(playerid, 1);

				DeathTimer[playerid] = repeat StartDeathCount(playerid);
				return (true);
			}
			else
			{
				WoundedBy[playerid] = issuerid;
				
				ApplyWoundedAnimation(playerid, bodypart);
				SendClientMessage(playerid, COLOR_RED, "[!] Tesko ste ranjeni te pali na pod. Ako izgubite sav HP - DeathMode. ");
				SendClientMessage(playerid, COLOR_DEATH, "* Tek nakon 30 sec mozete ulaziti u kola kao vozac/suvozac.");
				SendClientMessage(playerid, COLOR_RED, "[!] Da prihvatite smrt kucajte /acceptdeath");
				SetPlayerHealth(playerid, 25.0);
				AC_ResetPlayerWeapons(playerid);
				new
					wndString[135];
				format(wndString, 135, "KillWarn: Igrac %s[%d] je bacio u wounded mode igraca %s[%d] oruzjem %s!",
					GetName( issuerid, false),
					issuerid,
					GetName( playerid, false),
					playerid,
					GetWeaponNameEx(AC_GetPlayerWeapon(issuerid))
				);
				DMERSBroadCast(COLOR_RED, wndString, 1);

				#if defined MODULE_LOGS
				Log_Write("logfiles/kills.txt", "[WOUNDED] (%s) %s{%d}(%s) brutally wounded %s{%d}(%s) with %s(%d).",
					ReturnDate(),
					GetName(issuerid, false),
					PlayerInfo[issuerid][pSQLID],
					ReturnPlayerIP(issuerid),
					GetName(playerid, false),
					PlayerInfo[playerid][pSQLID],
					ReturnPlayerIP(playerid),
					GetWeaponNameEx(AC_GetPlayerWeapon(issuerid)),
					AC_GetPlayerWeapon(issuerid)
				);
				#endif
				
				new
					Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X, Y, Z);

				PlayerDeath[playerid][pDeathX] 	= X;
				PlayerDeath[playerid][pDeathY] 	= Y;
				PlayerDeath[playerid][pDeathZ] 	= Z;
				PlayerDeath[playerid][pDeathInt] 	= GetPlayerInterior( playerid);
				PlayerDeath[playerid][pDeathVW] 		= GetPlayerVirtualWorld( playerid);
				if(DeathData[playerid][ddOverall] > 0)
				{
					DeathTime[playerid] = gettimestamp() + 60;
					//DropPlayerMoney(playerid); // Gubitak novca

					//DropPlayerWeapons(playerid, X, Y);
					//DropPlayerDrugs(playerid, X, Y, true);

					mysql_fquery_ex(SQL_Handle(), 
						"INSERT INTO \n\
							player_deaths \n\
						(player_id, killed, pos_x, pos_y, pos_z, interior, viwo, time) \n\
						VALUES \n\
							('%d','%f','%f','%f','%d','%d','%d')",
						PlayerInfo[playerid][pSQLID],
						PlayerDeath[playerid][pKilled],
						PlayerDeath[playerid][pDeathX],
						PlayerDeath[playerid][pDeathY],
						PlayerDeath[playerid][pDeathZ],
						PlayerDeath[playerid][pDeathInt],
						PlayerDeath[playerid][pDeathVW],
						gettimestamp()
					);
				}
			}
		}
		else
			return SetPlayerHealth(playerid, health - damage);
	}
	return 1;
}

stock static DestroyPlayerWoundedTDs(playerid)
{
	if(WndedBcg[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, WndedBcg[playerid]);
		WndedBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(WndedText[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, WndedText[playerid]);
		WndedText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreatePlayerWoundedTDs(playerid)
{
	DestroyPlayerWoundedTDs(playerid);
	WndedBcg[playerid] = CreatePlayerTextDraw(playerid, 310.450714, 364.491943, "usebox");
	PlayerTextDrawLetterSize(playerid, WndedBcg[playerid], 0.000000, 4.070552);
	PlayerTextDrawTextSize(playerid, WndedBcg[playerid], 135.099548, 0.000000);
	PlayerTextDrawAlignment(playerid, WndedBcg[playerid], 1);
	PlayerTextDrawColor(playerid, WndedBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, WndedBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, WndedBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, WndedBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WndedBcg[playerid], 0);
	PlayerTextDrawFont(playerid, WndedBcg[playerid], 0);
	PlayerTextDrawShow(playerid, WndedBcg[playerid]);
	
	WndedText[playerid] = CreatePlayerTextDraw(playerid, 144.090072, 372.623840, "~n~                        ~n~");
	PlayerTextDrawLetterSize(playerid, WndedText[playerid], 0.219200, 0.966078);
	PlayerTextDrawAlignment(playerid, WndedText[playerid], 1);
	PlayerTextDrawColor(playerid, WndedText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WndedText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WndedText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WndedText[playerid], 51);
	PlayerTextDrawFont(playerid, WndedText[playerid], 2);
	PlayerTextDrawSetProportional(playerid, WndedText[playerid], 1);
	PlayerTextDrawShow(playerid, WndedText[playerid]);
	
	defer HidePlayerWoundedTDs(playerid);
}
/*
	 SSS  Y   Y  SSS  
	S      Y Y  S     
	 SSS    Y    SSS  
		S   Y       S 
	SSSS    Y   SSSS
*/
stock static SetPlayerBleeding(playerid, type)
{
	if(playerid == INVALID_PLAYER_ID) return 0;
	new
		Float:health;
	GetPlayerHealth(playerid, health);
	switch(type) {
		case PLAYER_WOUNDED_LEG: {
			SetPlayerHealth(playerid, health - WOUND_LEGS_AMOUNT);
		}
		case PLAYER_WOUNDED_ARMS: {
			SetPlayerHealth(playerid, health - WOUND_ARMS_AMOUNT);
			PlayerBleedTimer[playerid] = repeat OnPlayerBleed[3500](playerid);
		}
		case PLAYER_WOUNDED_TORSO, PLAYER_WOUNDED_GROIN: {
			SetPlayerHealth(playerid, health - WOUND_BODY_AMOUNT);
			PlayerBleedTimer[playerid] = repeat OnPlayerBleed[2200](playerid);
		}
		 case PLAYER_WOUNDED_HEAD: {
			SetPlayerHealth(playerid, health - WOUND_HEAD_AMOUNT);
			PlayerBleedTimer[playerid] = repeat OnPlayerBleed[1500](playerid);
		}
	}
	return 1;
}

/*
	TTTTTT III M   M EEEE RRRR   SSS  
	  TT    I  MM MM E    R   R S     
	  TT    I  M M M EEE  RRRR   SSS  
	  TT    I  M   M E    R R       S 
	  TT   III M   M EEEE R  RR SSSS 
*/

timer ApplyVehicleFallAnim[200](playerid)
{
	ApplyAnimation(playerid, "PED","BIKE_fall_off", 4.1,0,1,1,1,0);
	return 1;
}

timer ApplyVehicleFallOutAnim[2600](playerid)
{
	ApplyAnimationEx(playerid, "SWEET", "LaFin_Sweet", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

ptask WoundedPlayerCheck[1000](playerid)
{
	if(!SafeSpawned[playerid])
		return 1;
	if(!PlayerWoundedAnim[playerid] || PlayerDeath[playerid][pKilled] != 0)
		return 1;
	
	if(gettimestamp() >= PlayerWoundedSeconds[playerid])
	{
		PlayerWoundedSeconds[playerid] = 0;
		PlayerWoundedAnim[playerid] = false;
	}
	return 1;
}

timer OnPlayerBleed[500](playerid)
{
	new
		Float:health;
	GetPlayerHealth(playerid, health);
	
	switch(Bit8_Get(r_PlayerWounded, playerid)) 
	{
		case PLAYER_WOUNDED_ARMS: 
		{
			if(( health - WOUND_ARMS_AMOUNT) <= 10.0) 
			{
				stop PlayerBleedTimer[playerid];
				Bit8_Set(r_PlayerWounded, playerid, 0);
				
				SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47,				999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 				999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 				999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 			999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 	999);
				return 1;
			}
			SetPlayerHealth(playerid, health - WOUND_ARMS_AMOUNT);
		}
		case PLAYER_WOUNDED_TORSO, PLAYER_WOUNDED_GROIN: 
		{			
			if(( health - WOUND_BODY_AMOUNT) <= 10.0) 
			{
				stop PlayerBleedTimer[playerid];
				Bit8_Set(r_PlayerWounded, playerid, 0);
				return 1;
			}
			SetPlayerHealth(playerid, health - WOUND_BODY_AMOUNT);
		}
		case PLAYER_WOUNDED_HEAD: 
		{
			if(( health - WOUND_HEAD_AMOUNT) <= 10.0) 
			{
				stop PlayerBleedTimer[playerid];
				Bit8_Set(r_PlayerWounded, playerid, 0);
				return 1;
			}
			SetPlayerHealth(playerid, health - WOUND_HEAD_AMOUNT);
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

hook OnPlayerUpdate(playerid)
{
	if(PlayerWounded[playerid])
	{
		SetPlayerArmedWeapon(playerid, 0);
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new engine, lights, alarm, doors, bonnet, boot, objective,
				vehicleid = GetPlayerVehicleID(playerid);
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
		}
	}
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	PlayerWoundedAnim[playerid] = false;
	PlayerWoundedSeconds[playerid] = 0;
	PlayerWounded[playerid] = false;
	SetPlayerArmour(playerid, 0);
	return 1;
}

/* LOGAN DAMAGE SYSTEM
hook OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid)) return 0;
	
    new Float:health, Float:armour, Float:rnd;
	
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
	new Float:dX, Float:dY, Float: dZ;
	GetPlayerPos(playerid, dX, dY, dZ);
	new Float: fDistance = GetPlayerDistanceFromPoint(issuerid, dX, dY, dZ);
		
    if(PlayerDeath[playerid][pKilled] == 1 || PlayerDeath[playerid][pKilled] == 2)
    {
        SetPlayerHealth(playerid, 100);
        return 0;
	}
	if(issuerid != INVALID_PLAYER_ID && bodypart == BODY_PART_HEAD)
	{
	    switch(weaponid)
	    {
			case 0: DealDamage(playerid, issuerid, health, armour, amount, bodypart);
	        case 1 .. 5: //Palice, pendrek, noz
	        {
				rnd = randomEx(8, 15);
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
	        }
	        case 22, 23: //Colt, silencer
	        {
	            if(!Player_HasTaserGun(issuerid))
	            {
	            	rnd = 25/(fDistance+4)*9.0;
	            	DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
	        }
	        case 24: //Deagle
			{
			    rnd = 50/(fDistance+7)*17;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 25,27: //Shootgun
			{
			    if(!Player_BeanbagBulletsActive(issuerid))
			    {
   					rnd = 25/(fDistance)*8.8;
			    	DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
			}
			case 28, 29, 32: //Uzi, MP5, Tec9
			{
   				rnd = 80/(fDistance+18)*9;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 30:
			{
				rnd = 260/(fDistance+25)*5.56;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 31:
			{
				rnd = 100/(fDistance+8)*7.62;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 33: //Rifle
			{
   				rnd = 300/(fDistance+25)*5.56;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 34: //Sniper
			{
				KilledBy[playerid] = issuerid;
				KilledReason[playerid] = AC_GetPlayerWeapon(issuerid);
				SetPlayerHealth(playerid, 0);
				return 0;
			}
	    }
	}
	else if(issuerid != INVALID_PLAYER_ID && bodypart == BODY_PART_TORSO)
	{
	    switch(weaponid)
	    {
			case 0: DealDamage(playerid, issuerid, health, armour, amount, bodypart);
	        case 1 .. 5: //Palice, pendrek, noz
	        {
				rnd = randomEx(8, 15);
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
	        }
	        case 22, 23: //Colt, silencer
	        {
	            if(!Player_HasTaserGun(issuerid))
	            {
	            	rnd = 25/(fDistance+4)*9.0;
	            	DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
	        }
	        case 24: //Deagle
			{
			    rnd = 50/(fDistance+7)*17;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 25,27: //Shootgun
			{
			    if(!Player_BeanbagBulletsActive(issuerid))
			    {
   					rnd = 25/(fDistance)*8.8;
			    	DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
			}
			case 28, 29, 32: //Uzi, MP5, Tec9
			{
   				rnd = 80/(fDistance+18)*9;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 30:
			{
				rnd = 260/(fDistance+25)*5.56;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 31:
			{
				rnd = 100/(fDistance+8)*7.62;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 33: //Rifle
			{
   				rnd = 300/(fDistance+25)*5.56;
			    DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 34: //Sniper
			{
				rnd = 300/(fDistance+25)*5.56 + random(20);
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
	    }
	}
	else if(issuerid != INVALID_PLAYER_ID && (bodypart == BODY_PART_GROIN || bodypart == BODY_PART_LEFT_LEG || bodypart == BODY_PART_RIGHT_LEG || bodypart == BODY_PART_RIGHT_ARM || bodypart == BODY_PART_LEFT_ARM))
	{
		switch(weaponid)
		{
			case 0: DealDamage(playerid, issuerid, health, armour, amount, bodypart);
			case 1 .. 5: //Palice, pendrek, noZ
			{
				rnd = randomEx(8, 15);
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 22, 23: //Colt, silencer
			{
				if(!Player_HasTaserGun(issuerid))
				{
					rnd = 25/(fDistance+4)*9.0;
					DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
					SetPlayerHealth(playerid, health);
			}
			case 24: //Deagle
			{
				rnd = 50/(fDistance+7)*17;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 25,27: //Shootgun
			{
				if(!Player_BeanbagBulletsActive(issuerid))
				{
					rnd = 25/(fDistance)*8.8;
					DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
				}
				else
					SetPlayerHealth(playerid, health);
			}
			case 28, 29, 32: //Uzi, MP5, Tec9
			{
				rnd = 80/(fDistance+18)*9;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 30:
			{
				rnd = 100/(fDistance+8)*7.62;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 31:
			{
				rnd = 260/(fDistance+25)*5.56;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 33: //Rifle
			{
				rnd = 300/(fDistance+25)*5.56;
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
			case 34: //Sniper
			{
				rnd = 300/(fDistance+25)*5.56 + random(20);
				DealDamage(playerid, issuerid, health, armour, rnd, bodypart);
			}
		}
	}	
	return 0;
}
*/

// Fixano sve za update V18 by Khawaja
hook OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid)) return 0;
	
    new Float:health, Float:armour, Float:damage,
		Float:dX, Float:dY, Float: dZ;
	
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
	GetPlayerPos(playerid, dX, dY, dZ);
	
	switch (weaponid) 
	{
		case WEAPON_COLT45 .. WEAPON_SNIPER, WEAPON_MINIGUN, WEAPON_SPRAYCAN, WEAPON_FIREEXTINGUISHER: 
		{
			if(ProxDetectorS(0.7, issuerid, playerid)) 
				return 1;
		}
	}
	
	if(weaponid == WEAPON_PARACHUTE)
		weaponid = 0;
		
	if(issuerid != INVALID_PLAYER_ID && bodypart == BODY_PART_HEAD)
	{
			//Headshot System - na razmatranju
		/*damage = 200;
		DealDamage(playerid, issuerid, health, armour, damage, bodypart);*/
		
		switch(weaponid)
	    {
			case 0: 
			{
				damage += ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, amount, bodypart);
			}
	        case 1 .. 8:
	        {
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 10 .. 13:
			{ 
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 15:
			{
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
	        case 22, 23: {
	            if(!Player_HasTaserGun(issuerid)) {
	            	damage = 35;
	            	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
	        }
	        case 24: {
			    damage = 50;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 25,27: {
			    if(!Player_BeanbagBulletsActive(issuerid)) {
   					if(ProxDetectorS(5.0, issuerid, playerid))
						damage = 80;
					if(!ProxDetectorS(5.0, issuerid, playerid))
						damage = 40;
			    	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
			}
			case 28: {
   				damage = 25;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 29: {
   				damage = 35;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 30: {
				damage = 50;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 31: {
				damage = 45;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 32: {
				damage = 25;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 33: {
   				damage = 80;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 34: {
				damage = 99;
   				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
	    }
	}
	else if(issuerid != INVALID_PLAYER_ID && bodypart == BODY_PART_TORSO) // POGODAK U TORSO/TRBUH
	{
	    switch(weaponid)
	    {
			case 0: 
			{
				damage += ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, amount, bodypart);
			}
	        case 1 .. 8:
	        {
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 10 .. 13:
			{ 
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 15:
			{
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
	        case 22, 23: {
	            if(!Player_HasTaserGun(issuerid)) {
	            	damage = 25;
	            	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
	        }
	        case 24: {
			    damage = 45;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 25,27: {
			    if(!Player_BeanbagBulletsActive(issuerid)) {
   					if(ProxDetectorS(5.0, issuerid, playerid))
						damage = 80;
					if(!ProxDetectorS(5.0, issuerid, playerid))
						damage = 40;
			    	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
			}
			case 28: {
   				damage = 15;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 29: {
   				damage = 25;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 30: {
				damage = 40;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 31: {
				damage = 35;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 32: {
				damage = 20;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 33: {
   				damage = 70;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 34: {
				damage = 99;
   				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
	    }
	}
	else if(issuerid != INVALID_PLAYER_ID && (bodypart == BODY_PART_GROIN || bodypart == BODY_PART_LEFT_LEG || bodypart == BODY_PART_RIGHT_LEG || bodypart == BODY_PART_RIGHT_ARM || bodypart == BODY_PART_LEFT_ARM)) // POGODAK U NOGE,RUKE...
	{
		switch(weaponid)
	    {
			case 0: 
			{
				damage += ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, amount, bodypart);
			}
	        case 1 .. 8:
	        {
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 10 .. 13:
			{ 
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
			case 15:
			{
				damage = 13 + ((PlayerGym[playerid][pMuscle] / 50) * 1);
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
	        }
	        case 22, 23: {
	            if(!Player_HasTaserGun(issuerid)) {
	            	damage = 15;
	            	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
	        }
	        case 24: {
			    damage = 35;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 25,27: {
			    if(!Player_BeanbagBulletsActive(issuerid)) {
   					if(ProxDetectorS(5.0, issuerid, playerid))
						damage = 80;
					if(!ProxDetectorS(5.0, issuerid, playerid))
						damage = 40;
			    	DealDamage(playerid, issuerid, health, armour, damage, bodypart);
				}
				else
				    SetPlayerHealth(playerid, health);
			}
			case 28: {
   				damage = 10;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 29: {
   				damage = 20;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 30: {
				damage = 30;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 31: {
				damage = 25;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 32: {
				damage = 15;
				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 33: {
   				damage = 35;
			    DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}
			case 34: {
				damage = 99;
   				DealDamage(playerid, issuerid, health, armour, damage, bodypart);
			}	
	    }
	}
	return 0;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(PlayerWoundedAnim[playerid])
	{
		if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		{
			RemovePlayerFromVehicle(playerid);
			defer ApplyVehicleFallOutAnim(playerid);
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!PlayerWounded[playerid] || PlayerWoundedAnim[playerid])
		return 1;
		
	if(((newkeys & KEY_UP) && (newkeys & KEY_WALK)) || ((newkeys & KEY_DOWN) && (newkeys & KEY_WALK) || ((newkeys & KEY_WALK) && (newkeys & KEY_LEFT)) || ((newkeys & KEY_WALK) && (newkeys & KEY_RIGHT))) || (newkeys & KEY_SPRINT) || HOLDING(KEY_SPRINT))
		ApplyAnimationEx(playerid,"PED","WALK_old",4.1,1,1,1,1,1,1,0);
	else if(RELEASED(KEY_WALK) || RELEASED(KEY_SPRINT))
		ClearAnim(playerid);
	
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PlayerWoundedAnim[playerid])
		ApplyAnimation(playerid, "PED","BIKE_fall_off", 4.1,0,1,1,1,0);
		
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerWoundedAnim[playerid] && IsPlayerInAnyVehicle(playerid))
	{
		new seat = GetPlayerVehicleSeat(playerid);
		return PutPlayerInVehicle(playerid, vehicleid, seat);
	}
	return 1;
}
