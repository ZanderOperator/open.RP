#include <YSI_Coding\y_hooks>

static 
	globalstring[144],
	bool:AdminFly[MAX_PLAYERS],
	Float:AdminMark1[MAX_PLAYERS][3],
	Float:AdminMark2[MAX_PLAYERS][3],
	Float:AdminMark3[MAX_PLAYERS][3],
	Float:AdminMark4[MAX_PLAYERS][3],
	Float:AdminMark5[MAX_PLAYERS][3];


/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/

CMD:ahelp(playerid, params[])
{
	new p_dialog[2772], // 25.3.2020 - Runner
		f_dialog[256];

	if(PlayerInfo[playerid][pAdmin] == 0)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /alogin, /forumname, /lastdriver, /toga, /bhears, /a, /houseo, /bizo, /complexo, /checknetstats.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /rtc, /gotopos, /goto, /checklastlogin, /fly, /lt, /rt, /checkoffline, /count, /akill.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /freeze, /unfreeze, /learn, /slap, /clearchat, /dmers, /masked, /setviwo, /recon, /reconoff.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /return, /aon, /pweapons, /am, /mute, /setint, /check, /kick, /approveobjects, /apm.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /house_id, /biznis_id, /complex_id, /afurniture, /atoll, /adminmsg\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 2) 
	{
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /getcar, /gotomark, /mark, /getip, /iptoname, /prisonex, /warnex, /ban, /unprison, /prison.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /charge, /gotocar, /unbanip, /rtcinradius, /weatherall, /prisoned, /banex, /jailex, /jail, /unjail.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /gethere, /unban, /warn, /pmears, /rtcacar(radius), /cnn, /givebullet, /rears, /checkfreq, /banip.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
    }
	if (PlayerInfo[playerid][pAdmin] >= 3) 
	{
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 3]: /skin, /sethp, /pns, /blockreport, /fpm, /fpmed, /entercar, /checkcostats.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog, sizeof(f_dialog), "\n{FF9933}[A 3]: /check_gunrack, /check_hdrugs, /putplayerincar, /refillnos, /flipcar\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 4) 
	{
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 4]: /aname, /rac, /setarmour, /veh, /veh_spawned, /undie, /unfreezearound, /freezearound, /setarmouraround.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 4]: /sethparound, /fixveh, /aunlock, /atake, /mutearound, /togreport, /fire, /deletevehicle, /bizinfo, /hidestatus.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 1337) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /fakekick, /timeout, /givemoney, /address, /edit(biz/house), /asellbiz, /asellhouse, /asellcomplex, /asellcomplexroom, /fuelcars.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /fuelcar, /factionmembers, /weather, /setstat, /fstyle, /givelicense, /givegun, /ac, /healcar, /create_garage, /garage.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /item_give/drop/reload, /checkinv, /lts, /dakar, /quad.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 1338) {
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /makehelper, /makeadmin, /playercars, /makeadmin, /happyhours, /removewarn, /crash, /givepremium, /achangename, /giveallmoney.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /customhouseint, /createpickup, /bizint, /city, /setcity, /agps.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /exp, /custombizint, /createvehicle, /bizint, /houseint, /afaction.\n/changepass, /teampin - Promjena passworda/Team PIN-a.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /blacklist, /unblacklist, /agivedrug, /checkplayerdrugs, /checkvehdrugs, /togreg, ");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FF9933}* Game Admin Commands", p_dialog, "Close", "");
	return 1;
}

CMD:hhelp(playerid, params[])
{
	new p_dialog[1024],
		f_dialog[256];

	if(PlayerInfo[playerid][pHelper] == 0 && PlayerInfo[playerid][pAdmin] < 1338)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (PlayerInfo[playerid][pHelper] >= 1 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 1]: /learn /apm /hon /hoff /hm /a /h /ach /forumname /kick /disconnect /slap /goto /checkoffline.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pHelper] >= 2 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 2]: /port /recon /rtc /rtcinradius /setint /setviwo.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
    }
	if (PlayerInfo[playerid][pHelper] >= 3 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 3]: /gethere /freeze /unfreeze.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pHelper] >= 4 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 4]: /mark /gotomark /check.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{91FABB}* Helper - Commands", p_dialog, "Close", "");
	return 1;
}

// All
CMD:alogin(playerid, params[])
{
	if(!PlayerInfo[playerid][pTempRank][0] && !PlayerInfo[playerid][pTempRank][1]) return SendClientMessage(playerid, COLOR_RED, "Niste admin/helper!");
	if(!strlen(PlayerInfo[playerid][pTeamPIN])) return SendClientMessage(playerid, COLOR_RED, "Nemate sigurnosni PIN!");
	if(PlayerInfo[playerid][pAdmin] || PlayerInfo[playerid][pHelper]) return SendClientMessage(playerid, COLOR_RED, "Vec imate postavljene rankove!");

	new	pin[16];
	if(sscanf(params, "s[16]", pin)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /alogin [PIN]");
	
	bcrypt_check(pin, PlayerInfo[playerid][pTeamPIN], "OnPINChecked", "d", playerid);
	return 1;
}

// Administrator Level RCON
CMD:makehelper(playerid, params[])
{
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new 
		giveplayerid, level, teamPIN[12];
	if(sscanf(params, "uis[12]", giveplayerid, level, teamPIN)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makehelper [Playerid/DioImena] [level(1-4)]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "Igrac nije online!");
	
	if(!level) 
	{
		mysql_fquery(g_SQL, 
			"UPDATE accounts SET teampin = '', helper = '0' WHERE sqlid = '%d'", 
			PlayerInfo[giveplayerid][pSQLID]
		);
		
		PlayerInfo[giveplayerid][pTempRank][0] 	= 0;
		PlayerInfo[giveplayerid][pHelper] 		= 0;
		PlayerInfo[giveplayerid][pTeamPIN][0]	= EOS;
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Skinuli ste %s Game Helpera!", GetName(giveplayerid, false));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Skinut vam je Game Helper od strane %s!", GetName(playerid, false));
		return 1;
	}
	
	if( !strlen(PlayerInfo[giveplayerid][pTeamPIN]) ) 
	{		
		va_ShowPlayerDialog(giveplayerid, 0, DIALOG_STYLE_MSGBOX, "Helper PIN kod", "Congrats on your Game Helper position!\nTeam PIN is unique for you, and is your Game Admin credentials, each login you have to use /alogin to use Team Commands.\nDo not give your Team PIN to anyone and remember it well/write it down!\nYour Team PIN is:"COL_COMPADMIN"%s\n"COL_RED"You are REQUIRED to set your Forum Nick with /forumname.", "Okay", "", teamPIN);
		bcrypt_hash(teamPIN, BCRYPT_COST, "OnHelperPINHashed", "dd", giveplayerid, level);
	}
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_makeah.txt", "(%s) %s(%s) gives %s(%s) Helper Level %d", 
		ReturnDate(), 
		GetName(playerid,false), 
		ReturnPlayerIP(playerid), 
		GetName(giveplayerid,false), 
		ReturnPlayerIP(giveplayerid), 
		level
	);
	#endif
	
	PlayerInfo[giveplayerid][pHelper] = PlayerInfo[giveplayerid][pTempRank][1] = level;
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Postavljeni ste za Game Helper od Administratora %s", GetName(playerid,false));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Postavili ste %s za Game Helper.", GetName(giveplayerid,false));
	return 1;
}

CMD:inactivity(playerid, params[])
{
	new choice[12], playername[24], giveplayerid, bool:online=false, days, reason[64];
	
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Game Admin Level 3+!");
		
	if(sscanf(params, "s[12] ", choice)) 
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity [opcija]");
		SendClientMessage(playerid, COLOR_RED, "OPCIJE: add, remove, check, list");
		return 1;
	}
	if( !strcmp(choice, "check", true) )
	{
		if (sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity check [Ime_Prezime]");
			return 1;
		}
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(!IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s nema registriranu neaktivnost u bazi podataka!");
			
		CheckInactivePlayer(playerid, sqlid);
	}		
		
	if( !strcmp(choice, "list", true) )
		ListInactivePlayers(playerid);
		
	if( !strcmp(choice, "add", true) )
	{
		new startstamp, endstamp;
		if (sscanf(params, "s[12]s[24]is[64]", choice, playername, days, reason))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity add [Ime_Prezime][broj dana][razlog]");
			return 1;
		}
		if(days < 1 || days > 45)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Neaktivnost ne moze biti kraca od 1, ni dulja od 45 dana!");
		if(strlen(reason) < 1 || strlen(reason) >= 64)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Razlog ne moze biti kraci od 1, ni dulji od 64 znaka!");
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s vec ima registriranu neaktivnost u bazi podataka!");
		
		startstamp = gettimestamp();
		endstamp = gettimestamp() + (3600 * 24 * days);
		
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && SafeSpawned[playerid])
			{
				new playername2[MAX_PLAYER_NAME];
				GetPlayerName(i, playername2, sizeof(playername2));
				if(strcmp(playername2, playername, true, strlen(playername)) == 0)
				{
					online = true;
					giveplayerid = i;
					break;
				}
			}
		}
		mysql_fquery_ex(g_SQL, 
			"INSERT INTO inactive_accounts(sqlid, startstamp, endstamp, reason) VALUES ('%d','%d','%d','%e')",
			sqlid,
			startstamp,
			endstamp,
			reason
		);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/a_inactive_players.txt", "(%s) %s[A%d] approved %s[SQLID: %d] %d days long inactivity. Reason: %s",
			ReturnDate(),
			GetName(playerid,false),
			PlayerInfo[playerid][pAdmin],
			playername,
			sqlid,
			days,
			reason
		);
		#endif
		
		if(online)
		{
			va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "Game Admin %s vam je odobrio neaktivnost od %d dana, razlog: %s.", GetName(playerid, false), days, reason);
			SendClientMessage(giveplayerid, COLOR_LIGHTRED, "UPOZORENJE: Ukoliko se ulogirate na account za vrijeme neaktivnosti, ona se automatski ponistava!");
		}
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Uspjesno ste registrirali neaktivnost %s[SQLID: %d] na %d dana. Razlog: %s", playername, sqlid, days, reason);
	}
	if( !strcmp(choice, "remove", true) )
	{
		if (sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity remove [Ime_Prezime]");
			return 1;
		}
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(!IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s nema ima registriranu neaktivnost u bazi podataka!");
		
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && SafeSpawned[playerid])
			{
				new playername2[MAX_PLAYER_NAME];
				GetPlayerName(i, playername2, sizeof(playername2));
				if(strcmp(playername2, playername, true, strlen(playername)) == 0)
				{
					online = true;
					giveplayerid = i;
					break;
				}
			}
		}
		mysql_fquery(g_SQL, "DELETE FROM inactive_accounts WHERE sqlid = '%d'", sqlid);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/a_inactive_players.txt", "(%s) %s[A%d] deleted %s[SQLID: %d] registered inactivity from database.",
			ReturnDate(),
			GetName(playerid,false),
			PlayerInfo[playerid][pAdmin],
			playername,
			sqlid
		);
		#endif
		
		if(online)
			va_SendClientMessage(giveplayerid, COLOR_LIGHTRED, "Game Admin %s vam je ponistio registriranu neaktivnost.", GetName(playerid, false));
			
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Uspjesno ste ponistili registriranu neaktivnost %s[SQLID: %d]", playername, sqlid);
	}
	return 1;
}

CMD:hon(playerid, params[])
{
	if(Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Vec ste na Helper duznosti!");
    if(PlayerInfo[playerid][pHelper] >= 1)
	{
		SendClientMessage(playerid,COLOR_RED, "[ ! ] Sada si na Helper duznosti!");
		Bit1_Set(h_HelperOnDuty, playerid, true);
        SetPlayerColor(playerid, COLOR_HELPER);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
        foreach (new i : Player)
			SetPlayerMarkerForPlayer(i, playerid, COLOR_HELPER);
    }
    else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:hoff(playerid, params[])
{
    if(!Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Niste ste na Helper duznosti!");
    if(PlayerInfo[playerid][pHelper] >= 1)
	{
		SendClientMessage(playerid,COLOR_RED, "[ ! ] Vise nisi na Helper duznosti!");
		Bit1_Set(h_HelperOnDuty, playerid, false);
        SetPlayerColor(playerid,TEAM_HIT_COLOR);
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 100);
		foreach (new i : Player)
  			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
    }
    else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    return 1;
}

CMD:hm(playerid, params[])
{
	if(!Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Niste ste na Helper duznosti!");
	if (Player_UsingMask(playerid))
		return SendClientMessage(playerid,COLOR_RED, "Skinite masku prije nego sto koristite /hm!");
	if(PlayerInfo[playerid][pHelper] >= 1)
	{
	    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /hm [poruka]");
		new motd[180];
		format(motd, sizeof(motd), "(( HELPER %s:  %s ))", GetName(playerid, true), params);
		SendClientMessageToAll(COLOR_HELPER, motd);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_adminmessage.txt", globalstring);
		#endif
 	}
    else SendClientMessage(playerid, COLOR_RED, "Niste autorizirani za koristenje ove komande!");
    return 1;
}

CMD:ach(playerid, params[]) 
{
	new targetid;
	//if(!Bit1_Get(h_HelperOnDuty, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ste na Helper duznosti!");
	if(sscanf(params, "d", targetid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ach [target_id].");
	if(!Bit1_Get(a_NeedHelp, targetid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Ta osoba nije pozvala pomoc helpera.");
	
	SendFormatMessage(targetid, MESSAGE_TYPE_INFO, "Admin %s je prihvatio vas poziv za pomoc.", GetName(playerid));
	format(globalstring, sizeof(globalstring), "[ ! ] Admin %s je prihvatio pomoc od %s.",GetName(playerid, true), GetName(targetid, true));
	SendHelperMessage(COLOR_RED, globalstring, 1);
	
	Bit1_Set(a_NeedHelp, targetid, (false));
	return (true);
}

CMD:playercars(playerid, params[]) 
{
	new 
		Cache: mysql_search,
		player_sqlid,
		player_nick[MAX_PLAYER_NAME];
		
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "s[MAX_PLAYER_NAME]", player_nick)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /playercars [Ime_Prezime].");
	
	mysql_search = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", player_nick));
	cache_get_value_name_int(0, "sqlid"	, player_sqlid);
	cache_delete(mysql_search);
	
	ShowPlayerCars(playerid, player_sqlid, player_nick);
	return (true);
}

CMD:teampin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 1338!");
		
	new giveplayerid,
		teampin[12];
		
	if(sscanf(params, "us[12] ", giveplayerid, teampin)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /teampin [Playerid/DioImena] [Novi Team PIN za /alogin]");
	if(!IsPlayerConnected(giveplayerid))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
	if(!SafeSpawned[giveplayerid])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan!");
	if(!PlayerInfo[giveplayerid][pTempRank][0] && !PlayerInfo[giveplayerid][pTempRank][1] && !PlayerInfo[giveplayerid][pAdmin] && !PlayerInfo[giveplayerid][pHelper]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije Team Staff!");
	if(strlen(teampin) < 1 || strlen(teampin) > 12)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Team PIN ne moze biti kraci od jednog, ni dulji od 12 znakova!");
	
	bcrypt_hash(teampin, BCRYPT_COST, "OnTeamPINHashed", "d", giveplayerid);
	
	va_SendClientMessage(playerid, COLOR_RED, "[SERVER]  Uspjesno ste postavili %s Team PIN na: %s", GetName(giveplayerid, true), teampin );
	va_SendClientMessage(giveplayerid, COLOR_RED, "[SERVER] Administrator %s Vam je uspjesno postavio Team PIN na: %s", GetName(playerid, true), teampin );
	
	return 1;
}


CMD:makeadmin(playerid, params[])
{
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new 
		giveplayerid, level, teamPIN[12];
	if(sscanf(params, "uis[12]", giveplayerid, level, teamPIN)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makeadmin [Playerid/DioImena] [level(1-1338)] [Team PIN for /alogin]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "Igrac nije online!");
	
	
	if(!level) 
	{
		mysql_fquery(g_SQL, "UPDATE accounts SET teampin = '',adminLvl = '0' WHERE sqlid = '%d'", 
			PlayerInfo[giveplayerid][pSQLID]
		);
		
		PlayerInfo[giveplayerid][pTempRank][0] 	= 0;
		PlayerInfo[giveplayerid][pAdmin] 		= 0;
		PlayerInfo[giveplayerid][pTeamPIN][0]	= EOS;
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Skinuli ste %s Game Admina!", GetName(giveplayerid, false));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Skinut vam je Game Admin od strane %s!", GetName(playerid, false));
		return 1;
	}
	
	if( !strlen(PlayerInfo[giveplayerid][pTeamPIN]) ) 
	{
		va_ShowPlayerDialog(giveplayerid, 0, DIALOG_STYLE_MSGBOX, "Admin PIN kod", "Congrats on your Game Admin position!\nTeam PIN is unique for you, and is your Game Admin credentials, each login you have to use /alogin to use Team Commands.\nDo not give your Team PIN to anyone and remember it well/write it down!\nYour Team PIN is:"COL_COMPADMIN"%s\n"COL_RED"You are REQUIRED to set your Forum Nick with /forumname.", "Okay", "", teamPIN);
		bcrypt_hash(teamPIN, BCRYPT_COST, "OnAdminPINHashed", "dd", giveplayerid, level);
	}
	
	PlayerInfo[giveplayerid][pAdmin] = PlayerInfo[giveplayerid][pTempRank][0] = level;
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_makeah.txt", "(%s) %s(%s) gave %s(%s) Game Admin Level %d", 
		ReturnDate(), 
		GetName(playerid,false), 
		ReturnPlayerIP(playerid), 
		GetName(giveplayerid,false), 
		ReturnPlayerIP(giveplayerid), 
		level
	);
	#endif
	
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Postavljeni ste za Game Admina level %d od Administratora %s", level, GetName(playerid,false));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Postavili ste %s za Game Admina.", GetName(giveplayerid,false));
	return 1;
}

CMD:makeadminex(playerid, params[])
{
	if( IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] == 1338 ) 
	{
		new
			level,
			gplayername[MAX_PLAYER_NAME];
		if(sscanf(params, "s[24] ", gplayername)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makeadminex [Ime_Prezime] [Level(1-1338)] [Team PIN for /alogin]");
		
		mysql_fquery(g_SQL, "UPDATE accounts SET adminLvl = '%d' WHERE name = '%e' LIMIT 1", level, gplayername);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

// Administrator Level 1338
CMD:happyhours(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		happy;
	if( sscanf( params, "i ", happy ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /happyhours [0-makni/1-stavi]");
	if( 0 <= happy <= 1 ) {
		new
			gstring[64];
		if( happy ) {
			new
				level;
			if( sscanf( params, "ii", happy, level ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /happyhours 1-stavi [level]");
			format(gstring, sizeof(gstring), "hostname %s [Happy Hours do %d level]", 
				SERVER_NAME,
				level);
			SendRconCommand(gstring);
			HappyHoursLVL = level;
		} else {
			format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
			SendRconCommand(gstring);
		}
		HappyHours = happy;
		
	} else SendClientMessage(playerid, COLOR_RED, "Morate staviti 0 za skidanje happy hoursa i 1 za stavljanje!");
	return 1;
}
CMD:removewarn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /removewarn [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    PlayerInfo[giveplayerid][pWarns] -= 1;
    format(globalstring, sizeof(globalstring), "Maknuli ste warn igracu %s", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "*WARN: Admin %s je skinuo warning igracu: %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_YELLOW, globalstring);
	return 1;
}

CMD:explode(playerid, params[])
{
	new giveplayerid;
 	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Komanda /explode ne postoji!");
  	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[ ? ]: [ID/DioImena]");
  	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac� nije online!");

    new Float:SLX, Float:SLY, Float:SLZ;
    GetPlayerPos(giveplayerid, SLX, SLY,SLZ);
    CreateExplosion(SLX, SLY, SLZ, 11, 0.25);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Raznio si %s", GetName(giveplayerid, true));
    return 1;
}

CMD:fakekick(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Komanda '/fakekick' ne postoji!");
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fakekick [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SendClientMessage(giveplayerid, 0xA9C4E4AA, "Server closed the connection.");
	return 1;
}
CMD:crash(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Komanda '/crash' ne postoji!");
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /crash [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac� nije online!");
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	return 1;
}

//

CMD:givepremium(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		giveplayerid,
		dLevel[10];

    if(sscanf(params, "us[10] ", giveplayerid, dLevel)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givepremium [ID/DioImena][Bronze/Silver/Gold/Platinum]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");

	if(strcmp(dLevel,"bronze",true) == 0)
	{
		SetPlayerPremiumVIP(giveplayerid, PREMIUM_BRONZE);

		#if defined MODULE_LOGS
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s gave VIP Bronze status to %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);
		#endif
		
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Bronze VIP Account od admina %s.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Bronze VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));
    }
    else if(strcmp(dLevel,"silver",true) == 0)
	{
		SetPlayerPremiumVIP(giveplayerid, PREMIUM_SILVER);

		#if defined MODULE_LOGS
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s gave VIP Silver status to %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);
		#endif

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Silver VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Silver VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));
    }
    else if(strcmp(dLevel,"gold",true) == 0)
	{
		SetPlayerPremiumVIP(giveplayerid, PREMIUM_GOLD);

		#if defined MODULE_LOGS
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s gave VIP Gold %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);
		#endif
		
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Gold VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Gold VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));

    }
	else if(strcmp(dLevel,"platinum",true) == 0)
	{
		SetPlayerPremiumVIP(giveplayerid, PREMIUM_PLATINUM);

		#if defined MODULE_LOGS
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s gave VIP Platinum %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);
		#endif
		
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Platinum VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za 45 dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Platinum VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));

    }
	else SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givepremium [ID/DioImena] [Bronze/Silver/Gold/Platinum]");
	return 1;
}

CMD:achangename(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		giveplayerid,
	    novoime[MAX_PLAYER_NAME+1],
		oldnick[MAX_PLAYER_NAME+1],
		name[MAX_PLAYER_NAME+1];
		
    if(sscanf(params, "us[24]", giveplayerid, novoime)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /achangename [ID/Dio imena] [Ime_Prezime]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	GetPlayerName(giveplayerid, oldnick, sizeof(oldnick));
	GetPlayerName(playerid, name, sizeof(name));
	if(!IsValidName(novoime)) return SendClientMessage(playerid, COLOR_RED, "Nepravilan Role Play format imena.");
    format(globalstring, sizeof(globalstring), "[ ! ] Administrator %s je promjenio tvoj nick u %s!", name, novoime);
    SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	ChangePlayerName(giveplayerid, novoime, 1, (true));
	return 1;
}

CMD:aname(playerid, params[]) 
{
	if( !isnull(PlayerExName[playerid]) ) 
	{
		SetPlayerName(playerid, PlayerExName[playerid]);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj prijasnji nick!");
		PlayerExName[playerid][0] = EOS;
		return 1;
	}
	new 
		newName[ MAX_PLAYER_NAME ];
	if( sscanf(params, "s[24]", newName) ) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aname [novi nick].");
	if( !IsValidName(newName) ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan roleplay nick!");
	if (PlayerInfo[playerid][pAdmin] < 2) 
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	strcpy(PlayerExName[playerid], GetName(playerid, false), MAX_PLAYER_NAME);
		
	switch( SetPlayerName(playerid, newName) ) 
	{
		case -1: 
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko na serveru posjeduje taj nick!");
		case 0: 
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete taj nick!");
		case 1: 
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili nick u %s", newName); 
	}
	return 1;
} 

CMD:givemoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid, amount;
   	if (sscanf(params, "ui", giveplayerid, amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givemoney [ID/Dio imena] [Iznos]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    BudgetToPlayerMoney(giveplayerid, amount); // budjet - igrac
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je stvorio igracu %s $%d (/Givemoney)", GetName(playerid,false), GetName(giveplayerid,false), amount);
	SendAdminMessage(COLOR_RED, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_givemoney.txt", "(%s) Game Admin %s[%s] gave %s %d$ with /givemoney.", ReturnDate(), playerid, GetName(playerid,false), GetName(giveplayerid,false), amount);
	#endif
    return 1;
}

CMD:giveallmoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new amount;
   	if (sscanf(params, "i", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveallmoney [Iznos]");
	foreach( new giveplayerid : Player)
	{
		if (!IsPlayerLogged(giveplayerid) || !IsPlayerConnected(playerid) ) continue;
		BudgetToPlayerMoney(giveplayerid, amount); // budjet - igrac		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_givemoney.txt", "(%s) Game Admin %s[%s] gave %s %d$ with /givemoney.", ReturnDate(), playerid, GetName(playerid,false), GetName(giveplayerid,false), amount);
		#endif
	}
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je stvorio svim igracima $%d (/givemoneyallmoney)", GetName(playerid,false), amount);
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

// Administrator Level 1337

CMD:address(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni !");
	new id, address[32];
	if( sscanf(params, "is[32] ", id, address) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /address [houseid] [adresa]");
	if( strlen(address) > 32 ) return SendClientMessage( playerid, COLOR_RED, "Maksimalna velicina adrese je 11 znakova!");
	if( !House_Exists(id) ) return SendClientMessage(playerid, COLOR_RED, "Nevaljan ID kuce!");
	if( !IsPlayerInRangeOfPoint(playerid, 15.0, HouseInfo[ id ][ hEnterX ], HouseInfo[ id ][ hEnterY ], HouseInfo[ id ][ hEnterZ ] ) ) return SendClientMessage( playerid, COLOR_RED, "Morate biti blizu kuce!");
	
	format(HouseInfo[id][hAdress], 32, address);
	mysql_fquery(g_SQL, "UPDATE houses SET adress = '%e' WHERE id = '%d'", address, HouseInfo[id][hSQLID]);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Promjenili ste adresu kuce u %s", address);
	return 1;
}

CMD:edit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");

	new i, x_job[32], proplev, proptype = 0, propid = -1;
	if (sscanf(params, "s[32]i", x_job, proplev)) 
	{
		SendClientMessage(playerid, COLOR_RED, "|___________ Edit Houses/Business ___________|");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /edit [option] [value]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Level, Price, Funds, Locked, BizViwo");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] DoorLevel, LockLevel, AlarmLevel, hviwo");
		SendClientMessage(playerid, COLOR_RED, "|____________________________________________|");
		return 1;
	}
	i = Player_InfrontBizz(playerid);
	if(i != INVALID_BIZNIS_ID)
	{
		if(proplev >= 0)
		{
			if(strcmp(x_job,"level",true) == 0)
			{
				proptype = 2;
				propid = i;
				BizzInfo[i][bLevelNeeded] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET levelneeded = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
			else if(strcmp(x_job,"price",true) == 0)
			{
				proptype = 2;
				propid = i;
				BizzInfo[i][bBuyPrice] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET buyprice = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
			else if(strcmp(x_job,"funds",true) == 0)
			{
				proptype = 2;
				propid = i;
				BizzInfo[i][bTill] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
			else if(strcmp(x_job,"locked",true) == 0)
			{
				proptype = 2;
				propid = i;
				BizzInfo[i][bLocked] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET locked = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
			else if(strcmp(x_job,"bizviwo",true) == 0)
			{
				proptype = 2;
				propid = i;
				BizzInfo[i][bVirtualWorld] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET virtualworld = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
			else if(strcmp(x_job,"type",true) == 0)
			{
				proptype = 2;
				propid = i;
				if(proplev < 0 || proplev > 14) return SendClientMessage(playerid, COLOR_RED, "[ ! ]: Type range is 0-14!");
				BizzInfo[i][bType] = proplev;
				mysql_fquery(g_SQL, "UPDATE bizzes SET type = '%d' WHERE id = '%d'", proplev, BizzInfo[i][bSQLID]);
			}
		}
		if(proptype != 0 && propid != -1)
			return va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You just adjusted %s on Bizz ID %d[SQLID: %d][Name: %s] on value %d.", x_job, propid, BizzInfo[propid][bSQLID], BizzInfo[propid][bMessage], proplev);
	}
    i = Player_InfrontHouse(playerid);
	if(i != INVALID_HOUSE_ID)
	{
		if(proplev > 0)
		{
			if(strcmp(x_job,"level",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hLevel] = proplev;
				mysql_fquery(g_SQL,"UPDATE houses SET level = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"price",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hValue] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET value = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"locked",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hLock] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET lock = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"doorlevel",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hDoorLevel] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET doorlevel = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"locklevel",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hLockLevel] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET locklevel = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"alarmlevel",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hAlarm] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET alarm = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
			else if(strcmp(x_job,"hviwo",true) == 0)
			{
				proptype = 1;
				propid = i;
				HouseInfo[i][hVirtualWorld] = proplev;
				mysql_fquery(g_SQL, "UPDATE houses SET viwo = '%d' WHERE id = '%d'", proplev, HouseInfo[i][hSQLID]);
			}
		}
		if(proptype != 0 && propid != -1)
			return va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You just adjusted %s on House ID %d[SQLID: %d][Adress: %s] on value %d.", x_job, propid, HouseInfo[propid][hSQLID], HouseInfo[propid][hAdress], proplev);
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unfortunately, house/business for editing wasn't found in your proximity.");
	return 1;
}

CMD:asellbiz(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");

    new biz, foundonline = 0;
    if(sscanf(params, "i", biz)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellbiz [bizid]");

	foreach(new i : Player)
	{
		if(SafeSpawned[playerid] && PlayerInfo[i][pSQLID] == BizzInfo[biz][bOwnerID])
		{
			PlayerKeys[i][pBizzKey] = INVALID_BIZNIS_ID;
			va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your business has been moved out by Game Admin %s, you got %s refund in return.", GetName(playerid, false), FormatNumber(BizzInfo[biz][bBuyPrice]));
			BudgetToPlayerMoney(i, BizzInfo[biz][bBuyPrice]);
			foundonline = 1;
		}
	}
	mysql_fquery(g_SQL, "UPDATE bizzes SET ownerid = '0', co_ownerid = '0' WHERE id = '%d'", BizzInfo[ biz ][bSQLID]);
	if(foundonline == 0)
	{
		mysql_fquery(g_SQL, "UPDATE accounts SET handMoney = handMoney + '%d' WHERE sqlid = '%d'", 
			BizzInfo[ biz ][bBuyPrice],
			BizzInfo[ biz ][bOwnerID]
		);
		
		mysql_fquery(g_SQL,"UPDATE city SET budget = budget - '%d'", BizzInfo[ biz ][bBuyPrice]);
	}
	
	//------------------------------------------------------

	BizzInfo[biz][bLocked] 	= 1;
	BizzInfo[biz][bOwnerID] = 0;
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold Business %s with admin command, buy price was returned to the previous owner!", BizzInfo[biz][bMessage]);
	format(globalstring, sizeof(globalstring), "Game Admin %s moved out Business %s [ID %d][SQLID: %d].",GetName(playerid, false), BizzInfo[biz][bMessage], biz, BizzInfo[biz][bSQLID]);
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_sellbiz.txt", "(%s) Game Admin %s moved out Business %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), BizzInfo[biz][bMessage], biz, BizzInfo[biz][bSQLID]);
	#endif
		
	return 1;
}

CMD:asellgarage(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");

    new garage;

    if(sscanf(params, "i", garage)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellgarage [garageid]");
	
	if(!Garage_Exists(garage)) 
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Garage ID %d doesn't exist!", garage);
		
	foreach(new i : Player)
	{
		if(SafeSpawned[playerid] && PlayerKeys[i][pGarageKey] == garage)
		{
			PlayerKeys[i][pGarageKey] = -1;
			va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your garage has been moved out by Game Admin %s!", GetName(playerid, false));
			break;
		}				
	}
	
	mysql_fquery(g_SQL, "UPDATE server_garages SET ownerid = '0' WHERE id = '%d'", GarageInfo[garage][gSQLID]);
	
	GarageInfo[garage][gOwnerID] 				= 0;
	GarageInfo[ garage ][ gLocked ] 			= 1;
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "You sold garage %s with admin command!");
	format(globalstring, sizeof(globalstring), "Game Admin %s moved out garage %s[ID: %d][SQLID: %d].", GetName(playerid, false), GarageInfo[garage][gAdress], garage, GarageInfo[garage][gSQLID]);
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_sellhouse.txt", "(%s) Game Admin %s moved out garage %s[ID: %d][SQLID: %d].", ReturnDate(), GetName(playerid, false), GarageInfo[garage][gAdress], garage, GarageInfo[garage][gSQLID]);
	#endif
	return 1;
}

CMD:asellhouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");

	new house, foundonline = 0;
    if(sscanf(params, "i", house)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellhouse [houseid]");
   
	foreach(new i : Player)
	{
		if(SafeSpawned[playerid] && PlayerInfo[i][pSQLID] == HouseInfo[house][hOwnerID])
		{
			PlayerKeys[i][pHouseKey] = INVALID_HOUSE_ID;
			va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your house has been moved out by Game Admin %s, you got refunded buy price in return!", GetName(playerid, false));
			BudgetToPlayerMoney(i, HouseInfo[house][hValue]);
			foundonline = 1;
			break;
		}				
	}
	mysql_fquery(g_SQL, "UPDATE houses SET ownerid='0' WHERE ownerid = '%d'", HouseInfo[ house ][hOwnerID]);
	
	if(foundonline == 0)
	{
		mysql_fquery(g_SQL, "UPDATE accounts SET handMoney = handMoney + '%d' WHERE sqlid = '%d'", 
			HouseInfo[ house ][hValue],
			HouseInfo[ house ][hOwnerID]
		);
		mysql_fquery(g_SQL, "UPDATE city SET budget = budget - '%d'", HouseInfo[ house ][hValue]);
	}
	
	HouseInfo[house][hOwnerID]		= 0;
	HouseInfo[house][hLock] 		= 1;
	HouseInfo[house][hSafePass] 	= 0;
	HouseInfo[house][hSafeStatus] 	= 0;
	HouseInfo[house][hOrmar] 		= 0;
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold a house on adress %s, buy price was returned to the previous owner!", HouseInfo[house][hAdress]);
	format(globalstring, sizeof(globalstring), "Game Admin %s moved out House on adress %s[ID %d][SQLID: %d]", GetName(playerid, false), HouseInfo[house][hAdress], house, HouseInfo[house][hSQLID]);
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_sellhouse.txt", "(%s) Game Admin %s moved out House on adress %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), HouseInfo[house][hAdress], house, HouseInfo[house][hSQLID]);
	#endif
	
	return 1;
}

CMD:asellcomplex(playerid, params[])
{
	new complex, foundonline = 0;
    if(sscanf(params, "i", complex)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellcomplex [complexid]");
   	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");
	
	foreach(new i : Player)
	{
		if(SafeSpawned[playerid] && PlayerInfo[i][pSQLID] == ComplexInfo[complex][cOwnerID]) 
		{
			PlayerKeys[i][pComplexKey] = INVALID_COMPLEX_ID;
			va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your Complex has been moved out by Game Admin %s, you got refunded buy price of it!", GetName(playerid, false));
			BudgetToPlayerMoney(i, ComplexInfo[ complex ][ cPrice ]);
			foundonline = 1;
			break;
		}
	}
	mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id= '0' WHERE id = '%d'", ComplexInfo[ complex ][ cSQLID ]);	
	if(foundonline == 0)
	{
		// Update accounts
		mysql_fquery(g_SQL, "UPDATE accounts SET handMoney = handMoney + '%d' WHERE sqlid = '%d'", 
			ComplexInfo[complex][cPrice],
			ComplexInfo[complex][cOwnerID]
		);
		
		mysql_fquery(g_SQL, "UPDATE city SET budget = budget - '%d'", ComplexInfo[complex][cPrice]);
	}
			
	ComplexInfo[complex][cOwnerID]		= -1;
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold Complex %s with admin command, the owner got the buy price of Complex in return!", ComplexInfo[complex][cName]);
	format(globalstring, sizeof(globalstring), "Game Admin %s moved out Complex %s[ID %d][SQLID: %d]", GetName(playerid, false), ComplexInfo[complex][cName], complex, ComplexInfo[complex][cSQLID]);
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_sellcomplex.txt", "(%s) Game Admin %s moved out Complex %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), ComplexInfo[complex][cName], complex, ComplexInfo[complex][cSQLID]);
	#endif
	return 1;
}

CMD:asellcomplexroom(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");

	new complex;
    if(sscanf(params, "i", complex)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellcomplexroom [complexroomid]");
		
	foreach(new i : Player)
	{
		if(SafeSpawned[playerid] && PlayerInfo[i][pSQLID] == ComplexRoomInfo[complex][cOwnerID]) 
		{
			PlayerKeys[i][pComplexKey] = INVALID_COMPLEX_ID;
			va_SendClientMessage(i, COLOR_RED, "[ ! ]: You got moved out of Complex Room on adress %s by Game Admin %s!", ComplexRoomInfo[complex][cAdress], GetName(playerid, false));
			break;
		}
	}
	
	// Enum
	PlayerKeys[playerid][pComplexRoomKey] = INVALID_COMPLEX_ID;
	PlayerInfo[ playerid ][ pSpawnChange ] = 3;
	ComplexRoomInfo[complex][cOwnerID] = -1;
	
	// SQL
	mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'", ComplexRoomInfo[ complex ][cSQLID]);
	
	mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'", 
		PlayerInfo[playerid][pSpawnChange],
		PlayerInfo[playerid][pSQLID]
	);

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Iselio si complex sobu admin komandom!");
	format(globalstring, sizeof(globalstring), "Game Admin %s moved out Complex Room on adress %s[ID %d][SQLID: %d]", GetName(playerid, false), ComplexRoomInfo[complex][cAdress], complex, ComplexRoomInfo[complex][cSQLID]);
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_sellcomplex.txt", "(%s) Game Admin %s moved out Complex Room on adress %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), ComplexRoomInfo[complex][cAdress], complex, ComplexRoomInfo[complex][cSQLID]);
	#endif
	return 1;
}

CMD:forumname(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pHelper])
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
		
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /forumname [nick]");
	else if(isnull(PlayerInfo[playerid][pForumName]))
		strcpy(PlayerInfo[playerid][pForumName], params, 24);
	else
		return strdel(PlayerInfo[playerid][pForumName], 0, 24), SendClientMessage(playerid, COLOR_RED, "[ ! ] Obrisao si svoj forum nick!");
		
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si postavio forum ime!");
	return 1;
}

CMD:healcar(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new health;
	if (sscanf(params, "i", health)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /healcar [Iznos]");
	SetVehicleHealth(GetPlayerVehicleID(playerid), health);
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je healao svoj auto za %d", GetName(playerid,false), health);
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:fuelcars(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	RefillVehicles();
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "All Vehicles are now 100% full of gas.");
	return 1;
}

CMD:fuelcar(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		fuel, 
		vehicleid;
	if( sscanf( params, "ii", vehicleid, fuel ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /fuelcar [vehicleid][kolicina]");
	if( vehicleid == INVALID_VEHICLE_ID || !IsValidVehicle(vehicleid) ) return SendClientMessage( playerid, COLOR_RED, "Nevaljan unos vehicleida!");
	if( 1 <= fuel <= 100 ) 
	{
		VehicleInfo[ vehicleid ][ vFuel ] = fuel;
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Vozilo %d je napunjeno %d posto goriva!", vehicleid, fuel);
	} 
	else SendClientMessage( playerid, COLOR_RED, "Kolicina mora biti izmedju 1 i 100!");
	return 1;
}

CMD:factionmembers(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new orgid;
	if (sscanf(params, "i", orgid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /factionmembers [Orgid]");
	if (orgid < 1 || orgid > 16) return SendClientMessage(playerid, COLOR_RED, "Ne dopusten unos (1-16)!");
	
    mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE facMemId = '%d'", orgid), 
		"CountFactionMembers", 
		"ii", 
		playerid, 
		orgid
	);
	return 1;
}

CMD:weather(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new weather;
	if (sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weather [Weatherid]");
	if (weather < 0 || weather > 45) return SendClientMessage(playerid, COLOR_RED, "ID vremena ne moze ici ispod 0 ili iznad 45!");
	SetPlayerWeather(playerid, weather);
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je sebi stavio vrijeme ID %d.", GetName(playerid,false), weather);
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:setstat(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) 
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

    new giveplayerid, stat, amount;
    if (sscanf(params, "uii", giveplayerid, stat, amount))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setstat [ID/Nickname] [Statcode] [Amount]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Level), (2 - Age), (3 - PhoneNumber)");
		SendClientMessage(playerid, COLOR_GREY, "(4 - RespectPoints), (5 - Playing Hours), (6 - Sex) ");
		SendClientMessage(playerid, COLOR_GREY, " (7 - Players Job), (8 - PlayerContractTime), (9 - Minutes Till PayDay)");
		SendClientMessage(playerid, COLOR_GREY, "(10 - Muscle Skill), (11 - Times Arrested), (12 - Changename Permits)");
		SendClientMessage(playerid, COLOR_GREY, "(13 - Casino cool), (14 - Fishing skill)");
		return 1;
    }
    if(!SafeSpawned[playerid])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That player is not online!");
	
	switch (stat)
	{
		case 1:
		{
			PlayerInfo[giveplayerid][pLevel] = amount;
			SetPlayerScore( giveplayerid, amount );

			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s level at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);
			
			mysql_fquery(g_SQL, "UPDATE accounts SET levels = '%d', respects = '%d' WHERE sqlid = '%d'",
				PlayerInfo[giveplayerid][pLevel],
				PlayerInfo[giveplayerid][pRespects],
				PlayerInfo[giveplayerid][pSQLID]
			);
		}
		case 2:
		{
		    PlayerInfo[giveplayerid][pAge] = amount;

			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s age at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE accounts SET age = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
		}
		case 3:
		{
		    PlayerMobile[giveplayerid][pMobileNumber] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s mobile number at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_phones SET number = '%d' WHERE playerid = '%d' AND type = '1'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 4:
		{
		    PlayerInfo[giveplayerid][pRespects] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s Respect Points at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE accounts SET respects = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 5:
		{
		    PlayerInfo[giveplayerid][pConnectTime] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s Playing Hours at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);
			
			mysql_fquery(g_SQL, "UPDATE accounts SET connecttime = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);

			#if defined MODULE_LOGS
			Log_Write("/logfiles/a_setstat_connectedtime.txt", "(%s) Game Admin %s[%s] set %s's playing hours on %d.", 
				ReturnDate(), 
				GetName(playerid,false), 
				ReturnPlayerIP(playerid), 
				GetName(giveplayerid,false), 
				PlayerInfo[giveplayerid][pConnectTime]
			);
			#endif
  		}
		case 6:
		{
		    PlayerInfo[giveplayerid][pSex] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s sex at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE accounts SET sex = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 7:
		{
			if(PlayerJob[giveplayerid][pJob] != 0) 
				RemovePlayerJob(giveplayerid);
					
			SetPlayerJob(giveplayerid, amount);
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s job as %s.", 
				GetName(giveplayerid), 
				giveplayerid,
				ReturnJob(amount)
			);

			mysql_fquery(g_SQL, "UPDATE player_job SET jobkey = '%d', contracttime = '0' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 8:
		{
            PlayerJob[giveplayerid][pContractTime] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s job contract time at %d hours.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_job SET contracttime = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
  		case 9:
  		{
			amount = 60 - amount;
			if(amount <= 0)
				amount = 1;

  		    PaydayInfo[giveplayerid][pPayDay] = amount;
  		    
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s time untill payday at %d minutes.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_payday SET payday = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 10:
		{
		    PlayerGym[giveplayerid][pMuscle] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s muscle level at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_fitness SET muscle = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 11:
		{
		    PlayerJail[giveplayerid][pArrested] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s time arrested amount at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_jail SET arrested = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 12:
		{
		    PlayerInfo[giveplayerid][pChangeTimes] = amount;
		    
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s player changename perms at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);
		
			mysql_fquery(g_SQL, "UPDATE accounts SET changetimes = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/approve_changename.txt", "(%s) %s[A%d] allowed %d /changename's to %s[SQLID: %d].",
				ReturnDate(),
				GetName(playerid,false),
				PlayerInfo[playerid][pAdmin],
				amount,
				GetName(giveplayerid,false),
				PlayerInfo[giveplayerid][pSQLID]
			);
			#endif
  		}
		case 13:
		{
			PlayerCoolDown[giveplayerid][pCasinoCool] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s Casino Cooldown at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_cooldowns SET casinocooldown = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
		}
  		case 14:
		{
		    PlayerFish[playerid][pFishingSkill] = amount;
			
			format(globalstring, sizeof(globalstring), "You've set %s[ID %d]'s fishing skill at %d.", 
				GetName(giveplayerid), 
				giveplayerid,
				amount
			);

			mysql_fquery(g_SQL, "UPDATE player_fishes SET fishingskill = '%d' WHERE sqlid = '%d'",
				amount,
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		default:
			SendClientMessage(playerid, COLOR_RED, "Krivi kod stats-a!");
	}
	SendClientMessage(playerid, COLOR_SKYBLUE, globalstring);
	return 1;
}

CMD:skin(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, skin;
	if (sscanf(params, "ui", giveplayerid, skin)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /skin [ID/DioImena] [Skin id]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	//if (skin > 320 || skin < 0) return SendClientMessage(playerid, COLOR_RED, "Ne idite ispod 0 i preko 320!");
	
	SetPlayerSkin(giveplayerid, skin);
	PlayerAppearance[giveplayerid][pTmpSkin] = skin;
	PlayerAppearance[giveplayerid][pSkin] = skin;
	
	mysql_fquery(g_SQL, "UPDATE player_appearance SET skin = '%d' WHERE sqlid = '%d'", 
		PlayerAppearance[giveplayerid][pSkin], 
		PlayerInfo[giveplayerid][pSQLID]
	);
	return 1;
}

CMD:fstyle(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, item, string[64];
	if (sscanf(params, "ui", giveplayerid, item))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fstyle [ID/DioImena] [Opcija]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Normal), (2 - Boxing), (3 - Kung Fu), (4 - Kneehead), (5 - Grabback) (6 - Elbow)");
		return 1;
	}
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	switch(item)
 	{
  		case 1:
    	{
     		format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Normal.", GetName(playerid,false));
       		SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
         	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Normal.", GetName(giveplayerid,false));
          	SendClientMessage(playerid, COLOR_SKYBLUE, string);
           	SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_NORMAL);
            PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_NORMAL;
     	}
      	case 2:
       	{
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Boxing.", GetName(playerid,false));
         	SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
          	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Boxing.", GetName(giveplayerid,false));
            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_BOXING);
	        PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_BOXING;
        }
        case 3:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Kung Fu.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na Kung Fu.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_KUNGFU);
	        PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_KUNGFU;
        }
        case 4:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na KneeHead.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na KneeHead.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_KNEEHEAD);
	        PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_KNEEHEAD;
        }
        case 5:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na GrabBack.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na GrabBack.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
         	SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_GRABKICK);
	        PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_GRABKICK;
        }
        case 6:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Elbow.", GetName(playerid,false));
         	SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
          	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Elbow.", GetName(giveplayerid,false));
           	SendClientMessage(playerid, COLOR_SKYBLUE, string);
            SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_ELBOW);
            PlayerGym[giveplayerid][pFightStyle] = FIGHT_STYLE_ELBOW;
	    }
  		default:
  		SendClientMessage(playerid, COLOR_RED, "Krivi broj opcije!");
  	}
	return 1;
}

// Administrator Level 4
CMD:rac(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 4) 
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	RespawnVehicles();
	va_SendClientMessageToAll(COLOR_LIGHTRED, "[AdmCmd]: Admin %s je respawnao sva non-occupied vozila na serveru.", GetName(playerid));
	return 1;
}

CMD:timeout(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
		
	new
	    user;
		
	if(sscanf(params, "u", user))
	    return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /timeout [DioImena/PlayerID]");

	new str[35];

	format(str, 35, "banip %s", ReturnPlayerIP(user));
	SendRconCommand(str);
	
	defer TimeoutPlayer(user);
	//BlockIpAdress(
	
	return 1;
}

timer TimeoutPlayer[2000](playerid)
{
	new
		string[44];

	format(string, sizeof(string), "unbanip %s", ReturnPlayerIP(playerid));
 	SendRconCommand(string);
	
	SendRconCommand("reloadbans");
 	return 1;
}

CMD:sethp(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new
	    giveplayerid,
	    Float:health;

	if (sscanf(params, "uf", giveplayerid, health)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /sethp [ID/DioImena] [Health]");
	if (health > 100) return SendClientMessage(playerid, COLOR_RED, "Ne mozete vise od 100hp-a nekome dati.");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerHealth(giveplayerid, health);
	return 1;
}

CMD:setarmour(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    Float:armour;
	if (sscanf(params, "uf", giveplayerid, armour)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setarmour [ID/DioImena] [Armor]");
	if (armour < 0.0 || armour > 99.9) return SendClientMessage(playerid, COLOR_RED, "Minimalan unos je 0, a maksimalan 99.9!");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerArmour(giveplayerid, armour);
	return 1;
}

CMD:veh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new car, color1, color2, engine, lights, alarm, doors, bonnet, boot, objective;
	if (sscanf(params, "iii", car, color1, color2)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /veh [Model] [Color(1)] [Color(2)]");
	if (car < 400 || car > 611) return SendClientMessage(playerid, COLOR_RED, "Broj auta ne moze ici ispod 400 ili iznad 611!");
	if (color1 < 0 || color1 > 255) return SendClientMessage(playerid, COLOR_RED, "Broj boje ne moze ici ispod 0 ili iznad 255!");
	if (color2 < 0 || color2 > 255) return SendClientMessage(playerid, COLOR_RED, "Broj boje ne moze ici ispod 0 ili iznad 255!");
	if(Admin_vCounter[playerid] == 5)
		return SendErrorMessage(playerid, "Vec imate maximalno vozila spawnovano (5).");
	
	
	new
		Float:X, Float:Y, Float:Z, Float:ang;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid, ang);
	new carid = AC_CreateVehicle(car, X, Y+4, Z+3, ang, color1, color2, 60000,0);

	VehicleInfo[ carid ][ vModel ] 		= car;
	VehicleInfo[ carid ][ vColor1 ] 	= color1;
	VehicleInfo[ carid ][ vColor2 ] 	= color2;
	VehicleInfo[ carid ][ vParkX ]		= X;
	VehicleInfo[ carid ][ vParkY ]      = Y;
	VehicleInfo[ carid ][ vParkZ ]      = Z;
	VehicleInfo[ carid ][ vAngle ]      = 0.0;
	VehicleInfo[ carid ][ vHealth ]		= 1000.0;
	VehicleInfo[ carid ][ vType ]		= VEHICLE_TYPE_CAR;
	VehicleInfo[ carid ][ vUsage ] 		= VEHICLE_USAGE_NORMAL;
	VehicleInfo[ carid ][ vInt ]		= GetPlayerInterior(playerid);
	VehicleInfo[ carid ][ vViwo ]		= GetPlayerVirtualWorld(playerid);
	
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(carid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	PutPlayerInVehicle(playerid, carid, 0);
	Vehicle_Add(VEHICLE_USAGE_NORMAL, carid);
	CreateAdminVehicles(playerid, carid);
	
	format(globalstring, sizeof(globalstring), "[ ! ] Spawnali ste vozilo ID %d, Model: %d. (/veh)", carid, car);
	SendClientMessage(playerid, COLOR_RED, globalstring);
	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
	return 1;
}

CMD:deletevehicle(playerid, params[])
{
	new
		pick,
		vehicleid = GetPlayerVehicleID(playerid);

	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje ove komande.");
	if(sscanf(params, "i", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /deletevehicle [odabir]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] 1 - Vehicle (/veh), 2 - Car Ownership, 3 - Faction/Job");
		return 1;
	}
	switch(pick) 
	{
		case 1: 
		{
			DestroyFarmerObjects(playerid); // TODO:farmer
			AC_DestroyVehicle(vehicleid);
			DestroyAdminVehicle(playerid, vehicleid);
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste izbrisali vozilo %d iz baze/igre!", vehicleid);
		}
		case 2: 
		{
			if(PlayerInfo[playerid][pAdmin] < 1338) 
				return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje ove komande.");

			mysql_fquery(g_SQL, "DELETE FROM cocars WHERE id = '%d'", VehicleInfo[vehicleid][vSQLID]);
			
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "Uspjesno ste izbrisali %s(ID: %d | SQLID: %d) iz baze/igre!", 
				ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
				vehicleid,
				VehicleInfo[vehicleid][vSQLID]
			);

			DestroyFarmerObjects(playerid); // TODO: farmer
			AC_DestroyVehicle(vehicleid);
		}
		case 3: 
		{
			if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje ove komande.");

			mysql_fquery(g_SQL, "DELETE FROM server_cars WHERE id = '%d'", VehicleInfo[vehicleid][vSQLID]);

			va_SendClientMessage(playerid, COLOR_LIGHTRED, "Uspjesno ste izbrisali %s(ID: %d | SQLID: %d) iz baze/igre!", 
				ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
				vehicleid,
				VehicleInfo[vehicleid][vSQLID]
			);
			DestroyFarmerObjects(playerid); // TODO: Farmer
			AC_DestroyVehicle(vehicleid);
		}
	}
	return 1;
}

CMD:veh_spawned(playerid, params[]) {
	if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(1337+)!");
	ShowAdminVehicles(playerid);
	return (true);
}

CMD:givelicense(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(1337+)!");
	new giveplayerid, item, string[64];
	if (sscanf(params, "ui", giveplayerid, item))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givelicense [ID/DioImena] [Vrsta]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Drivinglicense), (2 - Gunlicense), (3- Flyinglicense), (4 - Boatlicense), (5 - Fishlicense)");
		return 1;
	}
	if (IsPlayerConnected(giveplayerid))
	{
	    switch(item)
	    {
	        case 1:
	        {
	            LicenseInfo[giveplayerid][pCarLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Drivinglicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Drivinglicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 2:
	        {
				//new vrsta;
				if (sscanf(params, "uii", giveplayerid, item))
				{
					SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /givelicense [Playerid/DioImena] [odabir] ");
					//SendClientMessage(playerid, COLOR_GREEN, "Tipovi: 1 - Concealed Carry Weapon(CCW),  2 - Open Carry Weapons + CC (OCW)");
					return 1;
				}
				//if(vrsta > 2 || vrsta < 0) return SendClientMessage(playerid, COLOR_RED, "   Nemoj ici ispod broja 0, ili iznad 2!");
	    		LicenseInfo[giveplayerid][pGunLic] = 1;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
	            format(string, sizeof(string), "* Admin %s vam je dao Gunlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Gunlicensu.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 3:
	        {
	            LicenseInfo[giveplayerid][pFlyLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Flyinglicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Flyinglicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 4:
	        {
	            LicenseInfo[giveplayerid][pBoatLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Boatlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Boatlicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 5:
	        {
	            LicenseInfo[giveplayerid][pFishLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Fishlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Fishlicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        default:
	        SendClientMessage(playerid, COLOR_RED, "Krivi ID license!");
	    }
	}
	return 1;
}
#if defined MODULE_DEATH
CMD:undie(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
 	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /undie [dio imena/playerid]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan playerid!");
	
	DestroyDeathInfo(giveplayerid);
	DestroyDeathTDs(giveplayerid);
	stop DeathTimer[giveplayerid];

	DeathCountStarted_Set(giveplayerid, false);
	DeathCountSeconds_Set(giveplayerid, 0);
	
    DeathData[ giveplayerid ][ ddOverall ] = 0;

	PlayerInfo[ giveplayerid ][ pDeath ][ 0 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 1 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 2 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeathInt ] 	= 0;
	PlayerInfo[ giveplayerid ][ pDeathVW ] 		= 0;
	PlayerInfo[ giveplayerid ][ pKilled ] 	 	= 0;

	ResetPlayerWounded(giveplayerid);

	SetPlayerHealth(giveplayerid, 25.0);
	TogglePlayerControllable(giveplayerid, true);

	mysql_fquery(g_SQL, "DELETE FROM player_deaths WHERE player_id = '%d'", PlayerInfo[giveplayerid][pSQLID]);

 	format(globalstring, sizeof(globalstring), "AdmWarn: %s je ugasio RPDeath stanje korisniku %s!", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);

	format(globalstring, sizeof(globalstring), "[ ! ] Admin %s vam je ugasio RPDeath stanje sada mozete normalno igrati!", GetName(playerid,false));
	SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	return 1;
}
#endif
CMD:unfreezearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
        if (IsPlayerConnected(i))
	    {
    	    if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) TogglePlayerControllable(i, 1); Frozen[i] = false;
		}
	}
	return 1;
}

CMD:freezearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
        if (IsPlayerConnected(i))
	    {
    	    if(IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) TogglePlayerControllable(i, 0); Frozen[i] = true;
	    }
	}
	return 1;
}

CMD:setarmoraround(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new Float:amount;
   	if (sscanf(params, "f", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setarmoraround [Iznos]");
    if (amount < 0 || amount > 99.9) return SendClientMessage(playerid, COLOR_RED, "Iznos mora biti izmedju 0 i 99.9!");
    new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
    foreach (new i : Player)
	{
	    if (SafeSpawned[i])
	    {
	        if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) 
				SetPlayerArmour(i, amount); 
	    }
	}
    return 1;
}

CMD:sethparound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new Float:amount;
   	if (sscanf(params, "f", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /sethparound [Iznos]");
    if (amount < 0 || amount > 100) return SendClientMessage(playerid, COLOR_RED, "Iznos mora biti izmedju 0 i 100!");
	new
		Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    foreach (new i : Player)
	{
	    if (IsPlayerConnected(i))
	    {
	        if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) SetPlayerHealth(i, amount);
	    }
	}
    return 1;
}


CMD:fixveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (IsPlayerInAnyVehicle(playerid))
	{
	    RepairVehicle(GetPlayerVehicleID(playerid));
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vBodyArmor] == 1) 
			AC_SetVehicleHealth(GetPlayerVehicleID(playerid), 1600.0);
		else
			AC_SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
		
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vTireArmor] == 1)
		{
			vTireHP[GetPlayerVehicleID(playerid)][0] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][1] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][2] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][3] = 100;
		}
		VehicleInfo[ GetPlayerVehicleID(playerid) ][ vCanStart ] = 1;
		VehicleInfo[ GetPlayerVehicleID(playerid) ][ vDestroyed ] = false;
	    TogglePlayerControllable(playerid, 1);
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si popravio vozilo. (/fixveh)");
	}
	return 1;
}

CMD:fixaveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car;
    if (sscanf(params, "i", car)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fixaveh [VehID]");
    
    RepairVehicle(car);
	if(VehicleInfo[car][vBodyArmor] == 1)
		AC_SetVehicleHealth(car, 1600.0);
	else
		AC_SetVehicleHealth(car, 1000.0);

	if(VehicleInfo[car][vTireArmor] == 1)
	{
		vTireHP[car][0] = 100;
		vTireHP[car][1] = 100;
		vTireHP[car][2] = 100;
		vTireHP[car][3] = 100;
	}
	VehicleInfo[ car ][ vCanStart ] = 1;
	VehicleInfo[ car ][ vDestroyed ] = false;
    TogglePlayerControllable(playerid, 1);
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si popravio vozilo ID: %d.", car);
	return 1;
}

CMD:aunlock(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car;
    if (sscanf(params, "i", car)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aunlock [CarID]");
	UnLockCar(car);
	format(globalstring, sizeof(globalstring), "Automobil ID: %d je otkljucan samo za vas.", car);
	SendClientMessage(playerid, -1, globalstring);
	return 1;
}

CMD:atake(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    x_nr[24],
	    giveplayerid;
    if (sscanf(params, "s[24]u", x_nr, giveplayerid))
	{
 		SendClientMessage(playerid, COLOR_SKYBLUE, "|___________________Oduzmite predmet____________________|");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /atake [Predmet] [ID/DioImena]");
		SendClientMessage(playerid, -1, "Predmeti: Driverslicense, Flyinglicense, Boatlicense, Fishinglicense, Weaponlicense, Weapons, Drugs, Materials");
		SendClientMessage(playerid, COLOR_SKYBLUE, "|___________________________________________________|");
		return 1;
	}
	if (strcmp(x_nr, "driverslicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s vozacku dozvolu.", GetName(giveplayerid,false));
  		SendClientMessage(playerid, -1, globalstring);
    	format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo vozacku dozvolu.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    LicenseInfo[giveplayerid][pCarLic] = false;
	}
	else if (strcmp(x_nr, "flyinglicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
  		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za avione.", GetName(giveplayerid,false));
    	SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za avione.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    LicenseInfo[giveplayerid][pFlyLic] = false;
	}
	else if (strcmp(x_nr, "boatlicense", true) == 0)
	{
	    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
 	    format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za brodove.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za brodove.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    LicenseInfo[giveplayerid][pBoatLic] = false;
	}
	else if (strcmp(x_nr, "fishinglicense", true) == 0)
	{
	    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za ribolov.", GetName(giveplayerid,false));
		SendClientMessage(playerid, -1, globalstring);
		format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za ribolov.", GetName(playerid,false));
		SendClientMessage(giveplayerid, -1, globalstring);
		LicenseInfo[giveplayerid][pFishLic] = false;
	}
	else if (strcmp(x_nr, "weaponlicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
  		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za oruzje.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za oruzje.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    LicenseInfo[giveplayerid][pGunLic] = 0;
	}
	else if (strcmp(x_nr, "weapons", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s oruzje.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo oruzje.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    AC_ResetPlayerWeapons(giveplayerid);
	}
	else if (strcmp(x_nr, "drugs", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s drogu.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo drogu.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    DeletePlayerDrug(giveplayerid, -1);
	}
	return 1;
}

CMD:mutearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
		if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid)
		{
			if (PlayerInfo[i][pMuted] == 1) PlayerInfo[i][pMuted] = 0;
			else if (PlayerInfo[i][pMuted] == 0) PlayerInfo[i][pMuted] = 1;
		}
	}
	return 1;
}

// Administrator Level 3
CMD:pns(playerid, params[]) {
	if (PlayerInfo[playerid][pAdmin] < 3) 
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(pns_garages == false) {
		pns_garages = true;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste omogucili koriscenje Pay'n'Spray garaza.");
	}
	else if(pns_garages == true) {
		pns_garages = false;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste onemogucili koriscenje Pay'n'Spray garaza.");
	}
	return (true);
}

CMD:blockreport(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /blockreport [ID/DioImena]");
	if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if( !Bit1_Get(gr_Blockedreport, giveplayerid)) {
		Bit1_Set(gr_Blockedreport, giveplayerid, true );
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je zabranio %s da salje reporte.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je zabranio da saljes reporte.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	else if (Bit1_Get(gr_Blockedreport, giveplayerid)) {
		Bit1_Set(gr_Blockedreport, giveplayerid, false);
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je dopustio %s da ponovno salje reporte.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je dopustio da ponovno saljes reporte.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	return 1;
}

CMD:fpm(playerid, params[])
{
    if( PlayerInfo[playerid][pAdmin] < 3 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new 
		giveplayerid;
    if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fpm [ID/DioImena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    if( PlayerInfo[giveplayerid][pAdmin] >= 1 ) return SendClientMessage(playerid, COLOR_RED, "Adminima i Helperima se ne blokiraju PMovi.");
	if( !Bit1_Get(gr_ForbiddenPM, giveplayerid)) {
		Bit1_Set(gr_ForbiddenPM, giveplayerid, true );
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je zabranio %s da salje PMove", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je zabranio da saljes PMove.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	else if (Bit1_Get(gr_ForbiddenPM, giveplayerid)) {
		Bit1_Set(gr_ForbiddenPM, giveplayerid, false);
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je dopustio %s da ponovno salje PMove.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je dopustio da ponovno saljes PMove.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	return 1;
}

CMD:fpmed(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	SendClientMessage(playerid, COLOR_GREY, "Igraci kojima je zabranje slanje PMova:");
	foreach (new i : Player)
	{
		if (IsPlayerConnected(i))
		{
 			if (Bit1_Get(gr_ForbiddenPM, i))
			{
				format(globalstring, sizeof(globalstring), "[%d] %s", i, GetName(i));
				SendClientMessage(playerid, -1, globalstring);
			}
		}
	}
	return 1;
}

CMD:getcar(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new plo;
	if (sscanf(params, "i", plo)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /getcar [CarID]");
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetVehiclePos(plo, X-floatsin(2.0, degrees), Y+floatcos(2.0, degrees), Z);
	LinkVehicleToInterior(plo, GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
	return 1;
}

CMD:entercar(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new testcar, seat;
    if (sscanf(params, "ii", testcar, seat)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /entercar [CarID] [seat]");
	PutPlayerInVehicle(playerid, testcar, seat);
	return 1;
}

CMD:putplayerincar(playerid, params[])
{

    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, testcar, seat;
    if (sscanf(params, "uii", giveplayerid, testcar, seat)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /putplayerincar [playerid] [carID] [seat]");
	PutPlayerInVehicle(giveplayerid, testcar, seat);
	return 1;
}

CMD:gotomark(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new id;
	
    if (sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gotomark [1-5]");
	if (id > 5 || id < 1) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 5!");
	if (id == 1)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, AdminMark1[playerid][0],AdminMark1[playerid][1],AdminMark1[playerid][2]);
		}
		else
		{
			SetPlayerPos(playerid, AdminMark1[playerid][0], AdminMark1[playerid][1], AdminMark1[playerid][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 1");
	}
	else if (id == 2)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, AdminMark2[playerid][0],AdminMark2[playerid][1],AdminMark2[playerid][2]);
		}
		else
		{
			SetPlayerPos(playerid, AdminMark2[playerid][0], AdminMark2[playerid][1], AdminMark2[playerid][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 2");
	}
	else if (id == 3)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, AdminMark3[playerid][0],AdminMark3[playerid][1],AdminMark3[playerid][2]);
		}
		else
		{
			SetPlayerPos(playerid, AdminMark3[playerid][0], AdminMark3[playerid][1], AdminMark3[playerid][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 3");
	}
	else if (id == 4)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, AdminMark4[playerid][0], AdminMark4[playerid][1], AdminMark4[playerid][2]);
		}
		else
		{
			SetPlayerPos(playerid, AdminMark4[playerid][0], AdminMark4[playerid][1], AdminMark4[playerid][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 4");
	}
	else if (id == 5)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, AdminMark5[playerid][0], AdminMark5[playerid][1], AdminMark5[playerid][2]);
		}
		else
		{
			SetPlayerPos(playerid, AdminMark5[playerid][0], AdminMark5[playerid][1], AdminMark5[playerid][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 5");
	}
	return 1;
}

CMD:mark(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new id;
	
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mark [1-5]");
	if (id > 5 || id < 1) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 5!");
	if (id == 1)
	{
		GetPlayerPos(playerid, AdminMark1[playerid][0], AdminMark1[playerid][1], AdminMark1[playerid][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 1.");
	}
	else if (id == 2)
	{
		GetPlayerPos(playerid, AdminMark2[playerid][0], AdminMark2[playerid][1], AdminMark2[playerid][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 2.");
	}
	else if (id == 3)
	{
		GetPlayerPos(playerid, AdminMark3[playerid][0], AdminMark3[playerid][1], AdminMark3[playerid][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 3.");
	}
	else if (id == 4)
	{
		GetPlayerPos(playerid, AdminMark4[playerid][0], AdminMark4[playerid][1], AdminMark4[playerid][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 4.");
	}
	else if (id == 5)
	{
		GetPlayerPos(playerid, AdminMark5[playerid][0],AdminMark5[playerid][1], AdminMark5[playerid][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 5.");
	}
	return 1;
}

// Administrator Level 2
CMD:jobids(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	SendClientMessage( playerid, COLOR_LIGHTBLUE, "*_____________________ POSLOVI _____________________*");
	SendClientMessage( playerid, COLOR_GREY, "LEGALNI: 1 - Sweeper, 2 - Pizza Boy, 3 - Mehanicar, 4 - Kosac trave, 5 - Tvornicki Radnik, 6 - Taksist, 7 - Farmer, 8 - Rudar");
	SendClientMessage( playerid, COLOR_GREY, "LEGALNI: 14 - Drvosjeca, 15 - Trucker, 16 - Smecar");
	SendClientMessage( playerid, COLOR_GREY, "10 - Drug Dealer, 12 - Gun Dealer, 13 - Car Jacker");
	return 1;
}
CMD:buyparkall(playerid, params[])
{
	new giveplayerid;
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /buyparkall [playerid/dio imena]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT COUNT(ownerid) FROM cocars WHERE ownerid = '%d'", PlayerInfo[giveplayerid][pSQLID]), 
		"OfflinePlayerVehicles", 
		"ii", 
		playerid, 
		giveplayerid
	);
	return 1;
}
CMD:getip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new	
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /getip [playerid/dio imena]");

	va_SendClientMessage(playerid, 
		COLOR_RED, 
		"[ ! ] Playerov IP: %s", 
		ReturnPlayerIP(giveplayerid)
	);
	return 1;
}
CMD:iptoname(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		ip[ MAX_PLAYER_IP ];
	if(sscanf(params, "s[24]", ip)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /iptoname [IP adresa]");
	if(strcount(ip, ".") < 3) return SendClientMessage(playerid, COLOR_RED, "Niste unijeli valjnu IP adresu!");

	mysql_tquery(g_SQL,
		va_fquery(g_SQL, 
			"SELECT name,online,lastip FROM  player_connects INNER JOIN\n\
				accounts ON accounts.sqlid = player_connects.player_id WHERE aip = '%e'", ip), 
		"LoadNamesFromIp", 
		"is", 
		playerid, 
		ip
	);
	return 1;
}

CMD:lastdriver(playerid, params[])
{
	new vpick, tmpString[128];
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (sscanf(params,"d", vpick)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lastdriver [VehicleID]");
	if(!strlen(LastDriver[vpick])) return SendClientMessage(playerid, COLOR_RED, "Vozilo ne postoji ili nije vozeno!");
	format(tmpString, sizeof(tmpString), "[ ! ] Vozilo ID %d je zadnji vozio %s", vpick, LastDriver[vpick]);
	SendClientMessage(playerid, COLOR_RED, tmpString);
	return 1;
}

CMD:prisonex(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    sati,
		reason[20];
    if (sscanf(params,"s[24]is[20]", targetname, sati, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /prisonex [Ime] [minute] [Razlog]");
    if (strlen(reason) < 1 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");

	new sqlid = ConvertNameToSQLID(targetname);
	if(sqlid == -1)
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s doesn't exist.", targetname);

    mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT jailed FROM player_jail WHERE sqlid = '%d'", sqlid), 
		"CheckPlayerPrison", 
		"iisis", 
		playerid,
		sqlid,
		targetname, 
		sati, 
		reason
	);
	return 1;
}

CMD:warnex(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    reason[20];
    if (sscanf(params,"s[24]s[20]", targetname, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warnex [Ime] [Razlog]");
	if (strlen(reason) < 1 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");
   	
    mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT playaWarns FROM accounts WHERE name = '%e'", targetname), 
		"LoadPlayerWarns", 
		"iss", 
		playerid, 
		targetname, 
		reason
	);
	
	new sqlid, 
		Cache:result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", targetname));
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	
	new
		forumname[ MAX_PLAYER_NAME ],
		tmp_reason[ 32 ];
		
	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	
	mysql_fquery_ex(g_SQL, "INSERT INTO warns (player_id,name, forumname, reason, date) VALUES ('%d', '%e', '%e', '%e', '%e')",
		sqlid,
		targetname,
		PlayerInfo[playerid][pForumName],
		tmp_reason,
		date
	);
	return 1;
}

CMD:ban(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid, reason[21],  days;
		
    if (sscanf(params,"us[21]i", giveplayerid, reason, days)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ban [ID/Dio imena] [Razlog][Dana (-1 za 4life)]");
	
	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "Igrac je offline! Koristi /banex.");
		
	new string[128];
	if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
	{
		format(string, sizeof(string), "AdmCmd: %s je dobio automatski kick poku�avajuci banovati veceg admina.", GetName(playerid, true));
		SendAdminMessage(COLOR_RED,string);
		KickMessage(playerid);
		return 1;
	}
	
	#if defined MODULE_BANS
	HOOK_Ban(giveplayerid, playerid, reason, days, false);
	#endif
	return 1;
}

CMD:unprison(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, year, month, day;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unprison [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    getdate(year, month, day);
	format(globalstring, sizeof(globalstring), "Admin: %s, Igrac: %s, Datum: (%d-%d-%d)", GetName(playerid,false), GetName(giveplayerid,false), month, day, year);
	format(globalstring, sizeof(globalstring), "[ ! ] Admin: %s je oslobodio Igraca: %s iz Fort DeMorgan", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "* Oslobodili ste %s iz Fort DeMorgan zatvora.", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "* Admin %s vas je pustio iz Fort DeMorgan zatvora.", GetName(playerid,false));
	SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	PlayerJail[giveplayerid][pJailed] = 0;
	PlayerJail[giveplayerid][pJailTime] = 0;
	SetPlayerPosEx(giveplayerid, 1481.0739,-1741.8704,13.5469, 0, 0, true);
	SetPlayerWorldBounds(giveplayerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_unprison.txt", "(%s)[IP: %s] Game Admin %s released %s from F.DeMorgan.", 
		ReturnDate(), 
		GetName(playerid,false),
		ReturnPlayerIP(playerid), 
		GetName(giveplayerid,false), 
	);
	#endif
    return 1;
}

CMD:prison(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, ptime, reason[80];
	if (sscanf(params, "uis[80]", giveplayerid, ptime, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /prison [ID/DioImena] [Vrijeme(minute)] [Razlog]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");
	new string[350];
    format(string, sizeof(string), "PRISON: Admin: %s je zatvorio %s u F.DeMorgan na %d minuta. Razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), ptime, reason);
	SendClientMessageToAll(COLOR_RED, string);

	format(string, sizeof(string), "* Stavio si %s in Fort DeMorgan.", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, string);
	format(string, sizeof(string), "* Zatvoreni ste u Fort Demorgan od Admina %s na %d minuta. Razlog: %s", PlayerInfo[playerid][pForumName], ptime, reason);
	SendClientMessage(giveplayerid, COLOR_RED, string);

	PutPlayerInJail(giveplayerid, ptime, 2); // 2 je Fort De Morgan

	ExpInfo[giveplayerid][ePoints] -= 5;
	ExpInfo[giveplayerid][eAllPoints] -= 5;
	SavePlayerExperience(giveplayerid);
	SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Radi Admin prisona, izgubili ste 5 trenutnih i 5 Overall EXP-ova.");

	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_prison.txt", "(%s)[IP: %s] Game Admin %s prisoned %s in F.DeMorgan.", 
		ReturnDate(), 
		GetName(playerid,false),
		ReturnPlayerIP(playerid), 
		GetName(giveplayerid,false), 
	);
	#endif
	return 1;
}

CMD:tod(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new time;
	if (sscanf(params, "i", time)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /tod [vrijeme]");
	if (time < 0 || time > 24) return SendClientMessage(playerid,COLOR_RED, "Vrijeme moze biti od 0-24!");
	SetWorldTime(time);
	return 1;
}

CMD:charge(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, money, result[64];
    if(sscanf(params, "uis[64]", giveplayerid, money, result)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /charge [ID/DioImena] [Iznos] [Razlog]");
    if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
 	if(money < 1) return SendClientMessage(playerid, COLOR_RED, "Cijena kazne nemoze biti manja od $1!");
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), money, result);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_charge.txt", "(%s) %s fined player %s. Amount: $%d. Reason:: %s", ReturnDate(), PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), money, result);
	#endif
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), money, result);
	SendClientMessageToAll(COLOR_RED, globalstring);
	PlayerToBudgetMoney(giveplayerid, money);


	new
		forumname[ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ];

	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);

	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);

	mysql_fquery(g_SQL, 
		"INSERT INTO charges (player_id,name, admin_name, money, reason, date) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		PlayerInfo[playerid][pForumName],
		money,
		result,
		date
	);
	return 1;
}

CMD:gotocar(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new testcar;
	if (sscanf(params, "i", testcar)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gotocar [Carid]");
	new
		Float:X, Float:Y, Float:Z;
	GetVehiclePos(testcar, X, Y, Z);
	if (GetPlayerState(playerid) == 2) {
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehiclePos(tmpcar, X, Y, Z);
	}
	else SetPlayerPos(playerid, X, Y, Z);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new playersip[16];
	if (sscanf(params, "s[16]", playersip)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unbanip [Igracev IP]");
	if( strlen(playersip) > 15 || strlen(playersip) < 1) return SendClientMessage(playerid, COLOR_RED, "Igracev IP mora biti izmedju 1 i 16!");
	
	new
		unbanString[ 25 ];
	format(unbanString, sizeof(unbanString), "unbanip %s", playersip);
	SendRconCommand(unbanString);
	SendRconCommand("reloadbans");
	
	#if defined MODULE_BANS
	UnbanPlayerIP(playersip, playerid);
	#endif
	
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je odbanao IP %s", GetName(playerid,false), playersip);
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

CMD:rtcinradius(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new Float: radius;
	if( sscanf( params, "f", radius)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rtcinradius [radius]");
	if(radius < 1.0 || radius > 300.0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Minimalni radius je 1.0, a maksimalni 300.0!");
	new
		engine, lights, alarm, doors, bonnet, boot, objective;
	
	foreach(new c: StreamedVehicle[playerid])
	{
		if(IsPlayerInRangeOfVehicle(playerid, c, radius))
		{
			if( !IsPlayerInVehicle(playerid, c) ) 
			{
				if( VehicleInfo[ c ][ vUsage ] == VEHICLE_USAGE_EVENT ) 
				{
					GetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(c, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleToRespawn(c);
					LinkVehicleToInterior(c, 0);
				} 
				else 
				{
					GetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleToRespawn(c);
					LinkVehicleToInterior(c, 0);
				}
			}
		}
	}
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sva vozila u radiusu %2.f od vas su respawnana! Ukoliko zelite respawnati prikolicu, koristite /dl te /rtcacar!", radius);
	return 1;
}

CMD:weatherall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new weather;
	if (sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weatherall [Weatherid]");
	//if (weather < 0 || weather > 50) return SendClientMessage(playerid, COLOR_RED, "ID vremena nemoze ici ispod 0 ili iznad 50!");
	
	SetWeather(weather);
	
	foreach (new i : Player)
	{
		SetPlayerWeather(i, weather);
	}
	
	SendClientMessage(playerid, COLOR_GREY, "Vrijeme postavljeno svima!");
	format(globalstring, 128, "AdmWarn: %s je stavio vrijeme ID %d", GetName(playerid,false), weather);
	WeatherSys = weather;
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:prisoned(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    type[12];
    SendClientMessage(playerid, COLOR_SKYBLUE, "*___________________________ Online igraci u bolnici/zatvoru/arei ___________________________*");
	foreach (new i : Player)
	{
		if (PlayerJail[i][pJailed] >= 1)
		{
			if (PlayerJail[i][pJailed] == 1) 		
			{ 
				type = "Jail"; 
			}
			else if(PlayerJail[i][pJailed] == 3) 	
			{ 
				type = "Bolnica"; 
			}
			else 
			{
				type = "F.DeMorgan";
			}
			va_SendClientMessage(playerid, COLOR_GREY, "%s | %s (%d) - Vrijeme: %d minuta", type, GetName(i), i, PlayerJail[i][pJailTime]);
		}
	}
	return 1;
}

CMD:newbies(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    SendClientMessage(playerid, COLOR_SKYBLUE, "*___________________________ Online igraci sa levelom 1 ___________________________*");
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pLevel] == 1)
		{
			va_SendClientMessage(playerid, COLOR_GREY, "%s[%d]", GetName(i), i);
		}
	}
	return 1;
}

CMD:banex(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    reason[24], days;
		
    if (sscanf(params,"s[24]s[24]i", targetname, reason, days)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /banex [Ime][Razlog][Dana (-1 za 4life)]");
	if( strlen(targetname) > 24 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina imena je 24!");
    if (strlen(reason) < 1 || strlen(reason) > 24) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina razloga je 24, a minimalna 1!");
	
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT lastip FROM accounts WHERE name = '%e'", targetname), 
		"OfflineBanPlayer", 
		"issi", 
		playerid, 
		targetname, 
		reason, 
		days
	);

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste banali igraca %s!", targetname);
	return 1;
}

CMD:jailex(playerid, params[])
{
	new LoopName[MAX_PLAYER_NAME];
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayername[24],
	    time;
	if (sscanf(params, "s[24]i", giveplayername, time)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jailex [Ime] [Time(minutes)]");
	if( strlen(giveplayername) > 24 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina imena je 24!");
	if (time < 1) return SendClientMessage(playerid, COLOR_RED, "Vrijeme pritvora ne moze biti manje od 1 minute!");
	
	foreach (new i : Player)
	{
	    GetPlayerName(i, LoopName, sizeof(LoopName));
		if(!strcmp(giveplayername, LoopName)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè je online!");
	}

	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", giveplayername), 
		"OfflineJailPlayer", 
		"ii", 
		playerid, 
		time
	);

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste zatvorili igraca %s!", giveplayername);
	return 1;
}

CMD:jail(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    time;
	if (sscanf(params, "ui", giveplayerid, time)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jail [ID/DioImena][Time(minutes)]");
		return 1;
	}
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (time < 1) return SendClientMessage(playerid, COLOR_RED, "Vrijeme pritvora ne moze biti manje od 1 minute!"); 
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stavio si %s u zatvor.", GetName(giveplayerid,false));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Stavljeni ste u zatvor od strane administratora %s.", PlayerInfo[playerid][pForumName]);
	
	PlayerJail[giveplayerid][pArrested] 	+= 1;
	PutPlayerInJail(giveplayerid, time, 1); // County Jail je 1
    PutPlayerInSector(giveplayerid);
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ADMIN JAIL] Pritvoreni ste na %d minuta. Jamcevina: Nedostupna", time);
	
	if(LicenseInfo[giveplayerid][pGunLic] != 0) {
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Nakon sto ste uhiceni, ostali ste bez dozvole za oruzje!");
		LicenseInfo[giveplayerid][pGunLic] = 0;
	}
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_jail.txt", "(%s) Game Admin %s(%s) jailed player %s on %d minutes.", 
		ReturnDate(), 
		PlayerInfo[playerid][pForumName], 
		ReturnPlayerIP(playerid), 
		GetName(giveplayerid,false), 
		time
	);
	#endif
	return 1;
}

CMD:unjail(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unjail [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerJail[giveplayerid][pJailed] == 0) return SendClientMessage(playerid, COLOR_RED, "Igrac nije u jailu!");
	if (PlayerJail[giveplayerid][pJailed] == 1)
	{
		format(globalstring, sizeof(globalstring), "* Oslobodili ste %s.", GetName(giveplayerid,false));
		SendClientMessage(playerid, COLOR_RED, globalstring);
		format(globalstring, sizeof(globalstring), "* Oslobodio vas je Admin %s.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);

		AC_SetPlayerWeapons(giveplayerid);
		PlayerJail[giveplayerid][pJailed] = 0;
		PlayerJail[giveplayerid][pJailTime] = 0;
		PlayerJail[playerid][pBailPrice] = 0;
		SetPlayerPos(giveplayerid, 90.6552, -236.3789, 1.5781);
		SetPlayerInterior(playerid, 0);

		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_unjail.txt", "(%s) Game Admin %s(%s) released %s from jail.", 
			ReturnDate(), 
			GetName(playerid,false), 
			ReturnPlayerIP(playerid), 
			GetName(giveplayerid,false)
		);
		#endif
	}
	else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije u zatvoru!");
    return 1;
}

CMD:toga(playerid, params[])
{
	#pragma unused params
    
	if(PlayerInfo[playerid][pAdmin] || IsPlayerAdmin(playerid))
	{
		if( !Bit1_Get(a_AdminChat, playerid))
		{
			Bit1_Set(a_AdminChat, playerid, true);
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost Admin chat-a!");
		} else {
			Bit1_Set(a_AdminChat, playerid, false);
			SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost Admin chat-a!");
		}
	}
	else 
		SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    
	return 1;
}

CMD:togreport(playerid, params[])
{
	#pragma unused params
	
	if( PlayerInfo[playerid][pAdmin] < 4 ) return SendClientMessage( playerid, COLOR_RED, "Niste ovlasteni!" );
	if( !Bit1_Get( a_TogReports, playerid ) ) {
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Iskljucili ste reportove!");
		Bit1_Set( a_TogReports, playerid, true );
	} else {
		Bit1_Set( a_TogReports, playerid, false );
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Ukljucili ste reportove!");
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pHelper] >= 3)
	{
		new giveplayerid;
		
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gethere [ID/DioImena]");
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		if (PlayerInfo[giveplayerid][pAdmin] > 1337) return SendClientMessage(playerid, COLOR_RED, "Pitajte Administratora da se teleportira do Vas.");
		if (PlayerJail[giveplayerid][pJailed] > 0) {
			ShowPlayerDialog(playerid, DIALOG_JAIL_GETHERE, DIALOG_STYLE_MSGBOX, "Warning", "Igrac kojeg zelite portati je u zatvoru.", "Port", "Exit");
			PortedPlayer[playerid] = giveplayerid;
			return 1;
		}
		new
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		if (GetPlayerState(giveplayerid) == 2) {
			new tmpcar = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(tmpcar, X, Y+4, Z);
		} else {
			SetPlayerPos(giveplayerid, X, Y+2, Z);
			SetPlayerInterior(giveplayerid, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(giveplayerid, GetPlayerVirtualWorld(playerid));
		}
		new
			complexid = Player_InApartmentComplex(playerid),
			roomid    = Player_InApartmentRoom(playerid),
			houseid   = Player_InHouse(playerid),
			bizzid    = Player_InBusiness(playerid),
			pickupid  = Player_InPickup(playerid);

		if (bizzid != INVALID_BIZNIS_ID)
			Player_SetInBusiness(giveplayerid, bizzid);
		if (houseid != INVALID_HOUSE_ID)
			Player_SetInHouse(giveplayerid, houseid);
		if (complexid != INVALID_COMPLEX_ID)
			Player_SetInApartmentComplex(giveplayerid, complexid);
		if (roomid != INVALID_COMPLEX_ID)
			Player_SetInApartmentRoom(giveplayerid, roomid);
		if (pickupid != -1)
			Player_SetInPickup(giveplayerid, pickupid);

		va_SendClientMessage(giveplayerid, COLOR_WHITE, "Teleportiran si od strane admina %s", GetName(playerid, false));
		va_SendClientMessage(playerid, COLOR_WHITE, "Teleportirao si %s, ID %d", GetName(giveplayerid, false), giveplayerid);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:unban(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new targetname[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", targetname )) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unban [Igracev Nick]");
	new sqlid = ConvertNameToSQLID(targetname);
	if(sqlid == -1)
		SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s doesn't exist in database!", targetname);

	#if defined MODULE_BANS
	UnbanPlayerName(targetname, playerid);
	#endif
	return 1;
}

CMD:warn(playerid, params[])
{

    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
        giveplayerid,
		reason[24],

		year,
		month,
		day;
    if (sscanf(params, "us[24]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warn [ID/DioImena] [Razlog]");
	if (strlen(reason) < 1 || strlen(reason) > 24) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina razloga je 24, a minimalna 1!");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");
	
	new
	    hour,
		minute,
		second;

	GetServerTime(hour, minute, second);
	getdate(year, month, day);

	new
	    date[20],
	    time[20];
	format(date, sizeof(date), "%02d.%02d.%d", day, month, year);
	format(time, sizeof(time), "%02d:%02d:%02d", hour, minute, second);


	PlayerInfo[giveplayerid][pWarns] += 1;

	ExpInfo[giveplayerid][ePoints] -= 10;
	ExpInfo[giveplayerid][eAllPoints] -= 10;
	SavePlayerExperience(giveplayerid);

    if (PlayerInfo[giveplayerid][pWarns] >= MAX_WARNS)
	{
		PlayerInfo[giveplayerid][pWarns] = 0;
		#if defined MODULE_BANS
		HOOK_Ban(giveplayerid, playerid, "Tri warna", 10, false);
		BanMessage(giveplayerid);
		#endif
		return 1;
	}
	va_SendClientMessage(playerid, COLOR_RED, "AdmCMD: Upozorili ste Igraca %s, razlog: %s", GetName(giveplayerid,false), reason);
	va_SendClientMessage(giveplayerid, COLOR_RED, "AdmCMD: Upozorio vas je Admin %s, razlog: %s", PlayerInfo[playerid][pForumName], reason);
	SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Radi Admin Warna, izgubili ste 10 trenutnih i Overall EXP-ova.");

	new
		forumname[ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ];

	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);

	mysql_fquery(g_SQL,
		 "INSERT INTO warns (player_id,name, forumname, reason, date) VALUES ('%d', '%e', '%e', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		PlayerInfo[playerid][pForumName],
		reason,
		date
	);
	return 1;
}

CMD:pmears(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_PMears, playerid)) {
		Bit1_Set(a_PMears, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih PM-ova!");
	} else {
		Bit1_Set(a_PMears, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih PM-ova!");
	}
	return 1;
}

CMD:togadnot(playerid, params[])
{
	#pragma unused params

	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_AdNot, playerid)) {
		Bit1_Set(a_AdNot, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost oglas reporta!");
	} else {
		Bit1_Set(a_AdNot, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "[ ! ] Iskljucili ste vidljivost oglas reporta!");
	}
	return 1;
}

CMD:rears(playerid, params[])
{
	#pragma unused params

	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_REars, playerid)) {
		Bit1_Set(a_REars, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih radio komunikacija!");
	} else {
		Bit1_Set(a_REars, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih radio komunikacija!");
	}
	return 1;
}

CMD:bhears(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_BHears, playerid)) {
		Bit1_Set(a_BHears, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih BH-ova!");
	} else {
		Bit1_Set(a_BHears, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih BH-ova!");
	}
	return 1;
}

// Administrator Level 1
CMD:a(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: (/a)dmin [Admin chat]");

	if( PlayerInfo[playerid][pAdmin] == 1338 ) {
		format(result, sizeof(result), "{FA5555}A[%d] {819BC6}%s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_adminchat.txt", result);
		#endif
	}
	else if( PlayerInfo[playerid][pAdmin] >= 1 ) {
		format(result, sizeof(result), "{FF9933}A[%d] {819BC6}%s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid,false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_adminchat.txt", result);
		#endif
	}
	else if( PlayerInfo[playerid][pHelper] >= 1 ) {
		format(result, sizeof(result), "{91FABB}H[%d] {819BC6}%s: %s", PlayerInfo[playerid][pHelper], GetName(playerid,false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_adminchat.txt", result);
		#endif
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:ac(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: (/ac)dmin [Admin chat]");

	if( PlayerInfo[playerid][pAdmin] >= 1337 ) {
		format(result, sizeof(result), "AC[%d] %s(%s): %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), PlayerInfo[playerid][pForumName], params);
		HighAdminBroadCast(0x4C3A8CFF, result, 1337);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:aa(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aa [TEXT]");

	if( PlayerInfo[playerid][pAdmin] >= 1338 ) {
		format(result, sizeof(result), "[!] A[%d] %s(%s): %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), PlayerInfo[playerid][pForumName], params);
		SendDirectiveMessage(COLOR_RED, result, 1);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}


CMD:houseo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		house;
	if( sscanf( params, "i", house ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /houseo [houseid]" );
	
	if(!House_Exists(house))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /houseo [houseid]" );
	
	if(HouseInfo[ house ][ hEnterX ] == 0.0)
		return SendClientMessage(playerid, COLOR_RED, "Taj kuca ne postoji!");

	SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 0, 0, true);
	return 1;
}

CMD:bizo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		biznis;
		
	if( sscanf( params, "i", biznis ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /bizo [biznisid]" );
	
	if(!Bizz_Exists(biznis))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Business ID %d doesn't exist!", biznis);
	
	SetPlayerPosEx(playerid, BizzInfo[ biznis ][ bEntranceX ], BizzInfo[ biznis ][ bEntranceY ], BizzInfo[ biznis ][ bEntranceZ ], 0, 0, true);
	
	return 1;
}

CMD:complexo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		complex;
	if( sscanf( params, "i", complex ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /complexo [complexid]" );
	if( 0 <= complex || complex <= MAX_COMPLEX-1 ) 
	{
		if( ComplexInfo[ complex ][ cEnterX ] == 0.0)
			return SendClientMessage(playerid, COLOR_RED, "Taj complex ne postoji!");
			
		SetPlayerPosEx(playerid, ComplexInfo[ complex ][ cEnterX ], ComplexInfo[ complex ][ cEnterY ], ComplexInfo[ complex ][ cEnterZ ], 0, 0, true);
	} 
	else 
		SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /complexo [complexid]" );
	
	return 1;
}

CMD:checknetstats(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
		number;
	if (sscanf(params, "ui", giveplayerid, number))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checknetstats [ID/DioImena] [0-1]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] 0 - Player Connection 1 - Player Network Stats");
		return 1;
	}
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (number < 0 || number > 1) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 1!");
	if (number == 0)
	{
        new
		    stats[400+1],
		    string[41];
        new dest[24];
        NetStats_GetIpPort(giveplayerid, dest, sizeof(dest));

	    format(stats, sizeof(stats), "You have been connected for %i milliseconds.\nYou have sent %i network messages. \
		\nYou have sent %i bytes of information to the server.\nYou have recieved %i network messages. \
		\nYou have received %i bytes of information from the server.\nYou have sent %i network messages in the last second. \
		\nPackets lost: %.2f percent.\nYour current connection status: %i.\nYour current IP and port: %s.",
		NetStats_GetConnectedTime(giveplayerid), NetStats_MessagesReceived(playerid), NetStats_BytesReceived(playerid),
		NetStats_MessagesSent(playerid), NetStats_BytesSent(playerid), NetStats_MessagesRecvPerSecond(playerid),
		NetStats_PacketLossPercent(playerid), NetStats_ConnectionStatus(playerid), dest);

        format(string, sizeof(string), "%s Connection Stats", GetName(giveplayerid,false));
	    ShowPlayerDialog(playerid, DIALOG_NETWORK_STATS, DIALOG_STYLE_MSGBOX, string, stats, "Okay", "");
	}
	else if (number == 1)
	{
	    new
		    stats[400+1],
	        string[39];
	    GetPlayerNetworkStats(giveplayerid, stats, sizeof(stats));
	    format(string, sizeof(string), "%s Network Stats", GetName(giveplayerid,false));
	    ShowPlayerDialog(playerid, DIALOG_NETWORK_STATS, DIALOG_STYLE_MSGBOX, string, stats, "Okay", "");
	}
	return 1;
}

CMD:rtc(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[ playerid ][ pHelper ] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car = GetPlayerVehicleID(playerid);
    if( !IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Niste unutar vozila!");
	RemovePlayerFromVehicle(playerid);
	SetVehicleToRespawn(car);
	format(globalstring, sizeof(globalstring), "AdmWARN: %s je respawnao vozilo ID %d (/rtc).", GetName(playerid,false), car);
	SendAdminMessage(COLOR_ORANGE, globalstring);
	format(globalstring,sizeof(globalstring),"Respawnao si vozilo ID %d. (/rtc)", car);
	SendClientMessage(playerid, -1, globalstring);
    return 1;
}

CMD:rtcacar(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		vehicleid;
	if( sscanf( params, "i", vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rtcacar [vehicleid]");
	
	if(!IsValidVehicle(vehicleid))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo ID %d ne postoji na serveru!", vehicleid);
	if(IsVehicleOccupied(vehicleid))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Netko se trenutno nalazi u vozilu ID %d!", vehicleid);
		
	SetVehicleToRespawn(vehicleid);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Vozilo ID %d je uspjesno respawnano.");
	format(globalstring, sizeof(globalstring), "AdmWARN: %s je respawnao vozilo ID %d (/rtc).", GetName(playerid,false), vehicleid);
	SendAdminMessage(COLOR_ORANGE, globalstring);
	return 1;
}

CMD:gotopos(playerid, params[])
{
	if( PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new
		Float:tmpPos[3], tmpInt, tmpViWo;
	if( sscanf( params, "fffii", tmpPos[0], tmpPos[1], tmpPos[2], tmpInt, tmpViWo ) ) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /gotopos [X][Y][Z][Interior ID][Virtual World ID]");
	SetPlayerPosEx(playerid, tmpPos[0], tmpPos[1], tmpPos[2], tmpViWo, tmpInt);
	return 1;
}

CMD:goto(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 1)
	{
		new giveplayerid;
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /goto [ID/Dio imena]");
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
		if( IsPlayerReconing(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Morate iskljuciti reconing!");
		if( IsPlayerReconing(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Igrac recona drugog igraca!");

		new
			Float:plocx,
			Float:plocy,
			Float:plocz;
		GetPlayerPos(giveplayerid, plocx, plocy, plocz);

		if (GetPlayerState(playerid) == 2)
		{
			AC_SetVehiclePos(GetPlayerVehicleID(playerid), plocx, plocy+2, plocz);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(giveplayerid));
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(giveplayerid));
		}
		else
		{
			SetPlayerPos(playerid, plocx, plocy+2, plocz);
			SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));

			new
				complexid = Player_InApartmentComplex(giveplayerid),
				roomid    = Player_InApartmentRoom(giveplayerid),
				houseid   = Player_InHouse(giveplayerid),
				bizzid    = Player_InBusiness(giveplayerid),
				pickupid  = Player_InPickup(giveplayerid);
			
			if (bizzid != INVALID_BIZNIS_ID)
				Player_SetInBusiness(playerid, bizzid);
			if (houseid != INVALID_HOUSE_ID)
				Player_SetInHouse(playerid, houseid);
			if (complexid != INVALID_COMPLEX_ID)
				Player_SetInApartmentComplex(playerid, complexid);
			if (roomid != INVALID_COMPLEX_ID)
				Player_SetInApartmentRoom(playerid, roomid);
			if (pickupid != -1)
				Player_SetInPickup(playerid, pickupid);

			va_SendClientMessage(playerid, COLOR_GREY, "Teleportiran si do %s, ID %d", GetName(giveplayerid, false), giveplayerid);
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:checklastlogin(playerid, params[])
{
	//if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!"); Da vratimo na staro da igraci mogu gledat kad je tko bio online zadnji put radi kuca i biznisa..
	new targetname[MAX_PLAYER_NAME];
	if (sscanf(params, "s[24]", targetname)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checklastlogin [Ime_Prezime]");
	
    mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", targetname), 
		"CheckPlayerData", 
		"is", 
		playerid, 
		targetname
	);
	return 1;
}

CMD:ninja(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:px,
        Float:py,
		Float:pz;
	GetPlayerPos(playerid, px, py, pz);
	GetXYInFrontOfPlayer(playerid, px, py, 10.0);
	SetPlayerPos(playerid, px, py, pz+5);
    return 1;
}

CMD:fly(playerid,params[])
{
	#pragma unused params
    if (PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_RED, "Niste autorizovani. [MAYDAY]");

	if(!AdminFly[playerid])
	{
		StartFly(playerid);
		AdminFly[playerid] = true;
		SetPlayerHealth(playerid, 99999);
	}
	else
	{
		StopFly(playerid);
		AdminFly[playerid] = false;
		SetPlayerHealth(playerid, 100);
	}
	return true;
}

CMD:lt(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:slx,
		Float:sly,
		Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerPos(playerid, slx, sly+2, slz);
    return 1;
}

CMD:rt(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:slx,
	    Float:sly,
		Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerPos(playerid, slx, sly-2, slz);
    return 1;
}

CMD:checkoffline(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorised for this command!");

	new targetname[MAX_PLAYER_NAME];
	if (sscanf(params, "s[24]", targetname)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checkoffline [nickname]");
    
	new sqlid = ConvertNameToSQLID(targetname);
	if(sqlid == -1)
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s doesn't exist in database!", targetname);

	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, 
			"SELECT \n\
				accounts.sqlid, accounts.name, accounts.levels, accounts.handMoney, accounts.bankMoney, \n\
                accounts.adminLvl, accounts.helper, accounts.playaWarns, accounts.connecttime, \n\
                player_job.jobkey, player_job.contracttime, \n\
                player_faction.facMemId, player_faction.facRank \n\
                FROM accounts, player_job, player_faction \n\
                WHERE accounts.sqlid = player_job.sqlid = player_faction.sqlid = '%d'",
			sqlid
		), 
		"CheckOffline", 
		"iis", 
		playerid,
		sqlid, 
		targetname
	);
	return 1;
}

CMD:count(playerid, params[])
{
	new
	    seconds,
	    string[64];
	if (sscanf(params, "i", seconds)) return SendClientMessage(playerid, COLOR_RED, "Morate unijeti vrijednost u sekundama.");
	if (seconds < 1 || seconds > 60) return SendClientMessage(playerid, COLOR_RED, "Sekunde nemogu biti manje od 1 i vece od 20!");
	if (count_started == true) return SendClientMessage(playerid, COLOR_RED, "Timer/Counter je vec startan.");
 	if( PlayerInfo[playerid][pAdmin] >= 1 && seconds > 0 )
    {
 		format(string, 40, "Zapoceli ste odbrojavanje od %d sekundi.", seconds);
  		SendClientMessage(playerid, COLOR_SKYBLUE, string);
		count_started = true;
   		cseconds = seconds + 1;
		CountingTimer = repeat OnAdminCountDown();
     	format(string, sizeof(string), "AdmWarn: %s koristi komandu /count.", GetName(playerid,false));
      	SendAdminMessage(COLOR_RED, string);
   	}
    else SendClientMessage(playerid, COLOR_RED, "Niste clan Street Racers organizacije / Niste Admin / Sekunde moraju biti vece od 1 i manje od 20!");
	return 1;
}
CMD:respawn(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /respawn [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");

    format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je respawnao igraca %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);

	new resstring[120];
	format(resstring, sizeof(resstring), "Admin %s vas je respawnovao.", GetName(playerid,false));
	SendMessage(giveplayerid, COLOR_RED, resstring);

	Player_SetInBusiness(giveplayerid, INVALID_BIZNIS_ID);
	Player_SetInHouse(giveplayerid, INVALID_HOUSE_ID);
	Player_SetInGarage(giveplayerid, 0);
	Player_SetInApartmentComplex(giveplayerid, INVALID_COMPLEX_ID);
	Player_SetInApartmentRoom(giveplayerid, INVALID_COMPLEX_ID);
    SpawnPlayer(giveplayerid);
	
	return 1;
}

CMD:akill(playerid, params[])
{
    
    if( PlayerInfo[ playerid ][ pAdmin ] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /akill [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
	if( !Bit1_Get( gr_PlayerSendKill, giveplayerid ) ) return SendClientMessage( playerid, COLOR_RED, "Taj igrac ne treba ubojstvo!" );
	
	AC_ResetPlayerWeapons(giveplayerid);
	SetPlayerHealth(giveplayerid, 0);
	Bit1_Set( gr_PlayerSendKill, giveplayerid, false );
	format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je odobrio kill igracu %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	
	return 1;
}

CMD:freeze(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /freeze [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerInfo[giveplayerid][pAdmin] > 0) return SendClientMessage(playerid, COLOR_RED, "Administratori ne mogu biti zaledjeni!");
	TogglePlayerControllable(giveplayerid, 0);
	Frozen[giveplayerid] = true;
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je zaledjen od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unfreeze [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	TogglePlayerControllable(giveplayerid, 1);
	Frozen[giveplayerid] = false;
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je odledjen od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:learn(playerid, params[])
{
    new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /learn [Playerid/DioImena]");
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 1)
	{
		if(IsPlayerConnected(giveplayerid))
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
            {
     			PlayerInfo[giveplayerid][pMustRead] = true;
     			PlayerInfo[giveplayerid][pMuted] = true;
     			TogglePlayerControllable(giveplayerid, 0);
        		LearnTimer[playerid] = defer LearnPlayer[1000](giveplayerid, 1);
				SendClientMessage(giveplayerid,COLOR_LIGHTRED, "Niste naucili pravila Roleplaya. Primorani ste ih ponovo procitati.");
				SendClientMessage(giveplayerid, COLOR_LIGHTRED, "Poslije pravila, slijedi kviz od 10 pitanja, tako da bolje pratite!");
				format(globalstring, 128, "AdmCMD: %s je poslao %s da procita tutorial o Roleplayu.", GetName(playerid, false), GetName(giveplayerid, false));
				SendClientMessageToAll(COLOR_LIGHTRED, globalstring);
			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije na serveru!");
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:slap(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid;
   	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /slap [ID/Dio imena]");
   	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	new
	    Float:shealth,
		Float:slx,
		Float:sly,
		Float:slz;
	GetPlayerHealth(giveplayerid, shealth);
	SetPlayerHealth(giveplayerid, shealth-3.0);
	GetPlayerPos(giveplayerid, slx, sly, slz);
	SetPlayerPos(giveplayerid, slx, sly, slz+5);
	PlayerPlaySound(giveplayerid, 1130, slx, sly, slz+5);
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je slapan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

CMD:clearchat(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    for (new a = 1; a <= 20; a++)
    {
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        GameTextForAll("Chat cleared!", 6000, 1);
    }
    format(globalstring, sizeof(globalstring), "* Admin %s je ocistio chat!", GetName(playerid,false));
    SendClientMessageToAll(COLOR_ORANGE, globalstring);
    return 1;
}

CMD:dmers(playerid, params[])
{

	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (!Bit1_Get(a_DMCheck, playerid))
	{
		Bit1_Set(a_DMCheck, playerid, true);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Sad cete dobivati dojave o ubojstvima igraca!");
		
	}
	else
	{
  		Bit1_Set(a_DMCheck, playerid, false);
   		SendClientMessage(playerid, COLOR_RED, "[ ! ] Vise necete dobivati dojave o ubojstvima igraca!");
	}
    return 1;
}

CMD:masked(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	SendClientMessage(playerid, COLOR_SKYBLUE, "Igraci s maskama:");
	foreach (new i : Player)
	{
		if (!Player_UsingMask(i)) continue;

		va_SendClientMessage(playerid, 
			-1, 
			"** ID: %d *** %s, MASK ID: %d", 
			i, 
			GetName(i, false), 
			PlayerInventory[i][pMaskID]
		);
	}
	return 1;
}

CMD:setviwo(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    viwoid,
	    string[32],
		giveplayerid;
    if (sscanf(params, "ui", giveplayerid, viwoid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setviwo [ID/Dio imena] [VirtualWorld]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerVirtualWorld(giveplayerid, viwoid);
	format(string, sizeof(string), "   Virtual World %d", viwoid);
	SendClientMessage(giveplayerid, COLOR_GREY, string);
	return 1;
}

CMD:onrecon(playerid, params[])
{
	if(!(PlayerInfo[playerid][pAdmin] >= 1337) && IsPlayerAdmin(playerid) == 0)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	foreach (new h : Player) 
	{
		if( IsPlayerReconing(h) ) 		
			va_SendClientMessage(playerid, 0x7A93BCFF, "RECON: Admin %s [%s] -> %s", GetName(h,false), PlayerInfo[h][pForumName] ,GetName(ReconingPlayer[h],false));
	}
	return 1;
}

CMD:recon(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new 
		giveplayerid;
	if( sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /recon [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    if( PlayerInfo[giveplayerid][pAdmin] >= 3 && PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid,COLOR_RED, "Ne mozes reconati admina level3+.");
	if( IsPlayerReconing(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Igrac vec recona nekoga!");

	oldskin[ playerid ] = GetPlayerSkin(playerid);

	if( IsPlayerReconing(playerid) ) 
	{
		stop ReconTimer[playerid];
		DestroyReconTextDraws(playerid);
		Bit4_Set(gr_SpecateId, playerid, 0);
	}
	
	ReconingPlayer[ playerid ] = giveplayerid;
	
	SetPlayerInterior(playerid, 	GetPlayerInterior(giveplayerid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
	
	if( IsPlayerInAnyVehicle(giveplayerid) ) {
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(giveplayerid));
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_VEH);
	} else {
		TogglePlayerSpectating(playerid, 1);
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_PLAYER);
		PlayerSpectatePlayer(playerid, giveplayerid);	
	}
	SetPlayerReconTarget(playerid, giveplayerid);
	return 1;
}

CMD:reconoff(playerid, params[])
{
	if( !IsPlayerReconing(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Ne reconate nikoga!");	
	
	stop ReconTimer[playerid];
	DestroyReconTextDraws(playerid);
	Bit4_Set(gr_SpecateId, playerid, 0);
	TogglePlayerSpectating(playerid, 0);
	
	ReconingPlayer[ playerid ] = -1;
	
	new
		tmpMoney = PlayerInfo[playerid][pMoney];
	AC_GivePlayerMoney(playerid, -tmpMoney);
	AC_GivePlayerMoney(playerid, tmpMoney);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Koristite /return za vracanje svojih oruzja i objekata prije recona!");
	return 1;
}

CMD:return(playerid, params[])
{
	#pragma unused params
    if( PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if( !Bit1_Get( a_PlayerReconed, playerid ) ) return SendClientMessage(playerid, COLOR_RED, "Ovu komandu mozete koristiti samo jednom!");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste vratili oruzja i objekte koje ste imali.");
	SetPlayerObjects(playerid);
	AC_SetPlayerWeapons(playerid);
	SetPlayerArmour(playerid, PlayerHealth[playerid][pArmour]);
	SetPlayerSkin(playerid, oldskin[playerid]);
	Bit1_Set( a_PlayerReconed, playerid, false );
	return 1;
}

CMD:aon(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_AdminOnDuty, playerid))
	{
	    SetPlayerColor(playerid, COLOR_ORANGE);
		SetPlayerHealth(playerid, 100, true);
		SetPlayerArmour(playerid, 100, true);
		
	    Bit1_Set(a_AdminOnDuty, playerid, true);
	    SendClientMessage(playerid, -1, "Sada ste na admin duznosti!");
	    foreach (new i : Player)
		{
	  		SetPlayerMarkerForPlayer(i, playerid, COLOR_ORANGE);
		}
	} 
	else 
	{
	    SetPlayerColor(playerid, COLOR_PLAYER);
		SetPlayerHealth(playerid, PlayerHealth[playerid][pHealth]);
		SetPlayerArmour(playerid, PlayerHealth[playerid][pArmour]);
		Bit1_Set(a_AdminOnDuty, playerid, false);

		SendClientMessage(playerid, -1, "Vise niste na admin duznosti!");
		foreach (new i : Player)
		{
	  		SetPlayerMarkerForPlayer(i, playerid, COLOR_PLAYER);
		}
	}
    return 1;
}

CMD:pweapons(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /pweapons [ID/Dio imena]");
	if( !IsPlayerLogged(giveplayerid) || !IsPlayerConnected(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije ulogiran!");
	
	new
	    weapon[13],
	    bullets[13];
	format(globalstring, sizeof(globalstring), "%s", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_GREEN, globalstring);
	for (new slot = 0; slot < 13; slot++)
    {
        GetPlayerWeaponData(giveplayerid, slot, weapon[slot], bullets[slot]);
        format(globalstring, sizeof(globalstring), "    SLOT: %d, ORUZJE: %s, METAKA: %d.", slot, WeapNames[weapon[slot]], bullets[slot]);
		SendClientMessage(playerid, -1, globalstring);
	}
	if(HiddenWeapon[giveplayerid][pwWeaponId] != 0)
		va_SendClientMessage(playerid, COLOR_WHITE, "	[Sakriveno ispod odjece]: %s, Metaka: %d.", WeapNames[HiddenWeapon[giveplayerid][pwWeaponId]], HiddenWeapon[giveplayerid][pwAmmo]);
	return 1;
}

CMD:am(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /am [Poruka]");
	format(globalstring, sizeof(globalstring), "(( ADMIN %s: %s ))", PlayerInfo[playerid][pForumName], params);
	SendClientMessageToAll(COLOR_YELLOW2, globalstring);
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_adminmessage.txt", globalstring);
	#endif
    return 1;
}

CMD:cnn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /cnn [Cnn textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
    if (strlen(params) < 0 || strlen(params) > 50) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 50 znakova!");
	format(globalstring, sizeof(globalstring), "~b~%s: ~w~%s", GetName(playerid,false), params);
	foreach (new i : Player)
	{
		if (IsPlayerConnected(i)) GameTextForPlayer(i, globalstring, 5000, 6);
	}
	return 1;
}

CMD:mute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mute [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerInfo[giveplayerid][pMuted] == 0)
	{
		PlayerInfo[giveplayerid][pMuted] = 1;
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je usutkan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	else
	{
		PlayerInfo[giveplayerid][pMuted] = 0;
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je odsutkan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	return 1;
}

CMD:setint(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new intid, giveplayerid;
	if (sscanf(params, "ui", giveplayerid, intid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setint [ID/Dio imena] [Interiorid]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerInterior(giveplayerid, intid);
	format(globalstring, sizeof(globalstring), "Interior %d.", intid);
	SendClientMessage(giveplayerid, -1, globalstring);
	return 1;
}

CMD:check(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /check [ID/DioImena]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    ShowPlayerStats(playerid, giveplayerid);
	return 1;
}

CMD:checkcostats(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checkcostats [playerid/PartOfName]");
		return 1;
	}
	if(PlayerKeys[giveplayerid][pVehicleKey] == -1) return SendClientMessage(playerid, COLOR_RED, "Igrac nema spawnano vozilo.");
	
	new name[ 36 ];
	strunpack( name, Model_Name(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vModel]) );
	format(globalstring, sizeof(globalstring), "Vozilo: %s [Model ID: %d] | Vlasnik: %s", name, VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vModel], GetName(giveplayerid, true));

	SendClientMessage(playerid, COLOR_SKYBLUE, globalstring);
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vNumberPlate] != 0)
	{
		format(globalstring, sizeof(globalstring), "Registriran    ||    Registracija: %s", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vNumberPlate]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Neregistriran");
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vLock] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Kvaliteta brave: Nekvalitetna");
	else
	{
		format(globalstring, sizeof(globalstring), "Kvaliteta brave: %d", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vLock]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vImmob] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Imobilizator: Nema");
	else
	{
		format(globalstring, sizeof(globalstring), "Imobilizator level: %d", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vImmob]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vAlarm] > 0)
	{
		format(globalstring, sizeof(globalstring), "Alarm level: %d", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vAlarm]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Alarm: Nema");
	
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vInsurance] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Osiguranje: Neosigurano");
	else
	{
		format(globalstring, sizeof(globalstring), "Osiguranje: %d", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vInsurance]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vDestroys] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Puta unisteno: Nikada");
	else
	{
		format(globalstring, sizeof(globalstring), "Puta unisteno: %d", VehicleInfo[PlayerKeys[giveplayerid][pVehicleKey]][vDestroys]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	return 1;
}

CMD:kick(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    reason[21];
    if( sscanf(params, "us[21]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /kick [ID/Dio imena] [Razlog].");
    if( strlen(reason) < 0 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");
	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "Krivi ID igraca!");
	
	if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_RED, "Ne mozes kickati admina veceg levela!");
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_kick.txt", "(%s) %s got kicked by Game Admin %s. Reason: %s", ReturnDate(), GetName(giveplayerid,false), PlayerInfo[playerid][pForumName], reason);
	#endif
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je dobio kick od Admina %s, razlog: %s", GetName(giveplayerid,false), PlayerInfo[playerid][pForumName], reason);
	SendClientMessageToAll(COLOR_RED, globalstring);
	KickMessage(giveplayerid);
	return 1;
}

CMD:approveobjects(playerid, params[]) {
	new giveplayerid;
	
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if( sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /approveobjects [ID/Dio imena].");
    if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage( playerid, COLOR_RED, "Krivi unos playerida/imena!" );
	
	if(Bit1_Get(gr_CreateObject, giveplayerid)) {
		Bit1_Set(gr_CreateObject, giveplayerid, false);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "%s vam je zabranio/maknuo kreiranje objekata.", GetName(playerid));
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je zabranio/maknuo igracu %s da koristi /createobject.", GetName(playerid,false), GetName(giveplayerid,false));
	}
	else if(!Bit1_Get(gr_CreateObject, giveplayerid)) {
		Bit1_Set(gr_CreateObject, giveplayerid, true);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "%s vam je dopustio kreiranje objekata, komanda: /createobject.", GetName(playerid));
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je dopustio igracu %s da koristi /createobject.", GetName(playerid,false), GetName(giveplayerid,false));	
	}	
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	return (true);
}

CMD:apm(playerid, params[])
{
	new
		name[ MAX_PLAYER_NAME ];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	if(!IsValidNick(name)) return Ban(playerid);
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Igrac nije ulogiran/connectan!");
	new 
		result[160], pmString[ 256 ],
		giveplayerid;
    if( sscanf( params, "us[160]", giveplayerid, result ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /apm [ID/Dio Imena][text]" );
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage( playerid, COLOR_RED, "Krivi unos playerida/imena!" );
	if( giveplayerid == playerid ) return SendClientMessage(playerid, COLOR_RED, "A ti i na viberu sam sebi pi�e�?" );
	if( strlen(result) > 160 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina unosa je 90!" );
	if( PlayerInfo[playerid][pAdmin] ) {
	
		va_SendClientMessage(giveplayerid, 0x70B9FFFF, "[PM] Admin %s: %s", 
			GetName(playerid, false), 
			result
		);
		va_SendClientMessage(playerid, 0xE5C43EAA, "Poslali ste PM igracu %s [%d]: %s", 
			GetName(giveplayerid, false), 
			giveplayerid, 
			result
		);
		format(pmString, sizeof(pmString), "[A] %s je poslao PM igracu %s",
			GetName(playerid, false), 
			GetName(giveplayerid, false)
		);
		AHBroadCast(COLOR_NICEYELLOW,pmString,1);
		
		format(pmString, sizeof(pmString), "[APM] %s za %s: %s", 
			GetName(playerid, false), 
			GetName(giveplayerid, false), 
			result
		);
		PmearsBroadCast(0xFFD1D1FF,pmString, 1337);
		Bit16_Set( gr_LastPMId, giveplayerid, playerid );
	}
	else if(PlayerInfo[playerid][pHelper] >= 1) {
		va_SendClientMessage(giveplayerid, 0x82FFB4FF, "[PM] Helper %s: %s", 
			GetName(playerid, false), 
			result
		);
		va_SendClientMessage(playerid, 0xE5C43EAA, "Poslali ste PM igracu %s [%d]: %s", 
			GetName(giveplayerid, false), 
			giveplayerid, 
			result
		);
		
		format(pmString, sizeof(pmString), "[H] %s je poslao PM igracu %s",
			GetName(playerid, false), 
			GetName(giveplayerid, false)
		);
		AHBroadCast(COLOR_NICEYELLOW,pmString,1);
		
		format(pmString, sizeof(pmString), "[HPM] %s za %s: %s", 
			GetName(playerid, false), 
			GetName(giveplayerid, false), 
			result
		);
		PmearsBroadCast(0xFFD1D1FF,pmString, 1337);
		Bit16_Set( gr_LastPMId, giveplayerid, playerid );
	}
	
	if(Player_ReportID(giveplayerid) != -1)
	{
		ClearReport(Player_ReportID(giveplayerid));
		Player_SetReportID(giveplayerid, -1);
		
		new str[128];
		format(str, sizeof(str), "[REPORT] %s je odgovorio na report ID od %s", GetName(playerid, false), GetName(giveplayerid, false));
 		SendAdminNotification(MESSAGE_TYPE_INFO, str);
	}
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_pm.txt", "(%s) %s(%s) for %s: %s",
		ReturnDate(),
		GetName(playerid, false),
		ReturnPlayerIP(playerid),
		GetName(giveplayerid, false),
		result
	);
	#endif
	
	return 1;
}

CMD:givegun(playerid, params[])
{
    
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    gun,
		ammo;
	if (sscanf(params, "uii", giveplayerid, gun, ammo))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givegun [ID/DioImena] [Weaponid(eg. 46 = Parachute)] [Ammo]");
		SendClientMessage(playerid, COLOR_GREY, "Hladna: 1(Brass Knuckles) 2(Golf Club) 3(Nite Stick) 4(Knife) 5(Baseball Bat) 6(Shovel) 7(Pool Cue)");
		SendClientMessage(playerid, COLOR_GREY, "	8(Katana) 10-13(Dildo) 14(Flowers) 15(Cane)");
		SendClientMessage(playerid, COLOR_GREY, "Vatrena: 24(Deagle) 25(Shot Gun) 27(Combat Shot) 28(Micro Uzi) 29(MP5) 30(AK47) 31(M4) 32(Tec9)");
		SendClientMessage(playerid, COLOR_GREY, "	33(C. Rifle) 34(Sniper) 41(Spray Can) 42(Fire Ext.) 43(Camera) 46(Parachute)");
		return 1;
    }
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
    if (PlayerInfo[giveplayerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Igrac nije level 2!");
	if (gun < 1 || gun > 46 || gun == 35 || gun == 16 ||gun == 26 || gun == 44 || gun == 45)
	{ SendClientMessage(playerid, COLOR_RED, "Pogresan WeaponID!"); return 1; }
	if (ForbiddenWeapons(gun)) return SendClientMessage(playerid, COLOR_RED, "To oruzje je zabranjeno!");
	if (ammo < 1 || ammo > 9999) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 9999! (Ammo)");
	if (! CheckPlayerWeapons(giveplayerid, gun) ) return 1;
	AC_GivePlayerWeapon(giveplayerid, gun, ammo);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste %s %s sa %d metaka.", GetName(giveplayerid, false), GetWeaponNameEx(gun), ammo);
	SendFormatMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, "Game Admin %s vam je dao %s sa %d metaka.", GetName(playerid, false), GetWeaponNameEx(gun), ammo);
	

	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_givegun.txt", "(%s) Game Admin %s gave %s %s with %d bullets.",
		ReturnDate(),
		GetName(playerid, false),
		GetName(giveplayerid, false),
		GetWeaponNameEx(gun),
		ammo
	);
	#endif

	return 1;
}

CMD:givebullet(playerid, params[])
{
    
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    gun; 
		
	if (sscanf(params, "ui", giveplayerid, gun))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givebullet [ID/DioImena] [Weaponid(eg. 46 = Parachute)] ");
		SendClientMessage(playerid, COLOR_GREY, "Hladna: 1(Brass Knuckles) 2(Golf Club) 3(Nite Stick) 4(Knife) 5(Baseball Bat) 6(Shovel) 7(Pool Cue)");
		SendClientMessage(playerid, COLOR_GREY, "	8(Katana) 10-13(Dildo) 14(Flowers) 15(Cane)");
		SendClientMessage(playerid, COLOR_GREY, "Vatrena: 24(Deagle) 25(Shot Gun) 27(Combat Shot) 28(Micro Uzi) 29(MP5) 30(AK47) 31(M4) 32(Tec9)");
		SendClientMessage(playerid, COLOR_GREY, "	33(C. Rifle) 34(Sniper) 41(Spray Can) 42(Fire Ext.) 43(Camera) 46(Parachute)");
		return 1;
    }
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
    if (PlayerInfo[giveplayerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Igrac nije level 2!");
	if (gun < 1 || gun > 46 || gun == 35 || gun == 16 ||gun == 26 || gun == 44 || gun == 45)
	{ SendClientMessage(playerid, COLOR_RED, "Pogresan WeaponID!"); return 1; }
	if (ForbiddenWeapons(gun)) return SendClientMessage(playerid, COLOR_RED, "To oruzje je zabranjeno!");
	if (! CheckPlayerWeapons(giveplayerid, gun) ) return 1;
	AC_GivePlayerWeapon(giveplayerid, gun, 1);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste %s %s sa jednim metkom.", GetName(giveplayerid, false), GetWeaponNameEx(gun));
	SendFormatMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, "Game Admin %s vam je dao %s sa jednim metkom.", GetName(playerid, false), GetWeaponNameEx(gun));
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_givegun.txt", "(%s) Game Admin %s gave %s %s with 1 bullet.",
		ReturnDate(),
		GetName(playerid, false),
		GetName(giveplayerid, false),
		GetWeaponNameEx(gun)
	);
	#endif
	return 1;
}

CMD:house_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	new	
		houseid = Player_InfrontHouse(playerid);
	if(houseid == INVALID_HOUSE_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in front of any house!");
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: House ID: %d", houseid);
	return 1;
}

CMD:biznis_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	new	
		bizzid = Player_InfrontBizz(playerid);
	if(bizzid == INVALID_BIZNIS_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in front of any business!");
		
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: Business ID: %d", bizzid);
	return 1;
}

CMD:complex_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	new	
		complexid = Player_InfrontComplex(playerid);
	if(complexid == INVALID_COMPLEX_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in front of any complex!");
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Complex ID: %d", complexid);
	return 1;
}

CMD:portplayer(playerid, params[])
{
	new locations, giveplayerid;

	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");

	if(sscanf(params, "un", giveplayerid, locations))
 	{
	 	SendClientMessage(playerid, COLOR_RED, "[ ? ]: /portplayer [playerid/DioImena] [location]");
	 	SendClientMessage(playerid, COLOR_GREY, "|1. Los Santos |2. Verona Mall |3. Richman |4. Grotti & Bank |5. Market Street");
	 	SendClientMessage(playerid, COLOR_GREY, "|6. Fire Department |7. Downtown LS |8. Vinewood |9. Ammunation |10. Verdant Bluffs");
	 	SendClientMessage(playerid, COLOR_GREY, "|11. El Corona |12. Idlewood |13. El Corona |14. Playa Del Seville |15. Ganton");
	 	SendClientMessage(playerid, COLOR_GREY, "|16. East LS |17. Jefferson |18. Glen Park |19. Mullholand");
	 	SendClientMessage(playerid, COLOR_GREY, "|20. Star Street |21. Trucker |22. Trucker (desert)");
	}
	else
	{
	    switch(locations)
	    {
	        case 1:
	        {
	            SetPlayerPosEx(giveplayerid, 1476.9183,-1679.6967,14.0469, 0, 0);
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
			case 2:
			{
			    SetPlayerPosEx(giveplayerid, 1102.3347,-1382.8169,13.7813, 0, 0);
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
			case 3:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 387.1776,-1173.8473,78.3563, 0, 0);
			}
			case 4:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 583.9010,-1240.2880,17.3085, 0, 0);
			}
			case 5:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 776.9227,-1388.4016,13.1934, 0, 0);
			}
			case 6:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1188.3400,-1316.9271,13.1330, 0, 0);
			}
			case 7:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1436.7577,-1167.1057,23.3978, 0, 0);
			}
			case 8:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1348.1587,-923.2181,34.6007, 0, 0);
			}
			case 9:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1364.0243,-1280.9617,13.1143, 0, 0);
			}
			case 10:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1194.3335,-2036.6687,68.5756, 0, 0);
			}
			case 11:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
           		SetPlayerPosEx(giveplayerid, 1955.3833,-2090.6282,13.1154, 0, 0);
			}
			case 12:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2041.3593,-1743.9049,13.1112, 0, 0);
			}
			case 13:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1882.9041,-2016.5022, 13.5469, 0, 0);
			}
			case 14:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2723.9143,-1943.1840,13.1113, 0, 0);
			}
			case 15:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2225.5811, -1742.8641, 13.5634, 0, 0);
			}
			case 16:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2392.5415,-1381.8247,23.5676, 0, 0);
			}
			case 17:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2095.8801,-1377.7487,23.5560, 0, 0);
			}
			case 18:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1975.2610,-1197.4194,25.3582, 0, 0);
			}
			case 19:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1647.8340,-1154.4443,23.6376, 0, 0);
			}
			case 20:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1236.0244,-1155.5094,23.1332, 0, 0);
			}
			case 21:
			{
				SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
				SetPlayerPosEx(giveplayerid, -303.6173,-2136.2605,28.0347, 0, 0);
			}
			case 22:
			{
				SetPlayerPosEx(giveplayerid, -231.5353,2621.0098,62.8980, 0, 0);
				SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
		}
  		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je teleportovao igraca %s na lokaciju.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	return 1;
}
CMD:adminmsg(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new playerb[25], n_reason[128];

	if (sscanf(params, "s[25]s[128]", playerb, n_reason))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /adminmsg [character name] [message]");

    mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT sqlid, online FROM accounts WHERE name = '%e'", playerb), 
		"AddAdminMessage", "iss", 
		playerid, 
		playerb, 
		n_reason
	);
	return 1;
}

CMD:kickall(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    foreach(new i: Player) 
    {
		if(IsPlayerConnected(i) && !IsPlayerAdmin(i))
		{
			Kick(i);
			printf("SERVER: Developer je kickovao sve igrace sa servera");
		}
    }
    format(globalstring, sizeof(globalstring), "AdmCMD: %s je kickovao sve igrace sa servera.", PlayerInfo[playerid][pForumName]);
	SendClientMessageToAll(COLOR_RED, globalstring);
    return true;
}

CMD:banip(playerid,params[]) {
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED,"[ ? ]: /banip [ip]");
	new string[128];
	format(string,sizeof string,"banip %s",params);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	format(string,sizeof string,"[ ! ] Uspje�no ste banovali IP.");
	return SendClientMessage(playerid,-1,string);
}
CMD:ptp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
		Float:X, Float:Y, Float:Z;
	new giveplayerid, targetid;
    if(sscanf(params, "uu", giveplayerid, targetid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ptp [giveplayerid] [targetid]");
	
	GetPlayerPos(targetid, X, Y, Z);
	SetPlayerPos(giveplayerid, X, Y, Z);
	
	va_SendClientMessage(targetid, COLOR_RED, "[ ! ] Admin je teleportova igraca %s do vas.", GetName(giveplayerid));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Admin vas je teleportovao do igraca %s", GetName(targetid));
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspje�no ste teleportovali %s do %s", GetName(giveplayerid), GetName(targetid));
	return 1;
}
CMD:forceduty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
 	new
 		giveplayerid;

	if(sscanf(params, "us[128]", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /forceduty [playerid/DioImena]");

	if(!IsPlayerConnected(giveplayerid))return SendClientMessage(playerid, giveplayerid, "Taj igrac nije konektovan.");
	if(!PlayerInfo[giveplayerid][pAdmin])return SendClientMessage(playerid, giveplayerid, "Taj igrac nije admin.");
	new
		str[128];

	if (!Bit1_Get(a_AdminOnDuty, playerid))
	{
		Bit1_Set(a_AdminOnDuty, playerid, true);

		format(str, sizeof(str), "AdmCmd: %s je sada na admin duznosti (forced by %s).", GetName(giveplayerid, false), GetName(playerid, false));
		SendAdminMessage(COLOR_RED, str);
		SetPlayerColor(giveplayerid, COLOR_ORANGE);
		Streamer_Update(giveplayerid);

	}
	else
	{
		Bit1_Set(a_AdminOnDuty, playerid, false);

		format(str, sizeof(str), "AdmCmd: %s vise nije na admin duznosti (forced by %s).", GetName(giveplayerid, false), GetName(playerid, false));
		SendAdminMessage(COLOR_RED, str);

		SetPlayerColor(giveplayerid, COLOR_PLAYER);
		Streamer_Update(giveplayerid);

		SetPlayerHealth(giveplayerid, 100);
	}
	return true;
}

CMD:togreg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return 0;
		
	if(regenabled)
		regenabled = false;
	else
		regenabled = true;
	
	va_ABroadCast((regenabled) ? (COLOR_GREEN) : (COLOR_RED), "AdmWarn: %s je %s registraciju na serveru!", 1, GetName(playerid, false), (regenabled) ? ("ukljucio") : ("iskljucio"));
	return 1;
}
CMD:setservertime(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new tmphour;
	if(sscanf(params, "i", tmphour))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setservertime [time]");
		
	foreach (new i : Player)
	{
	    if (IsPlayerConnected(i))
	    {
	        SetPlayerTime(i,tmphour,0);
	    }
	}
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	AdminFly[playerid] = false;

	AdminMark1[playerid][0] = 0.0;
	AdminMark1[playerid][1] = 0.0;
	AdminMark1[playerid][2] = 0.0;

	AdminMark2[playerid][0] = 0.0;
	AdminMark2[playerid][1] = 0.0;
	AdminMark2[playerid][2] = 0.0;

	AdminMark3[playerid][0] = 0.0;
	AdminMark3[playerid][1] = 0.0;
	AdminMark3[playerid][2] = 0.0;

	AdminMark4[playerid][0] = 0.0;
	AdminMark4[playerid][1] = 0.0;
	AdminMark4[playerid][2] = 0.0;

	AdminMark5[playerid][0] = 0.0;
	AdminMark5[playerid][1] = 0.0;
	AdminMark5[playerid][2] = 0.0;
	
	return continue(playerid);
}