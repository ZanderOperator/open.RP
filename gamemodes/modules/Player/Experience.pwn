#include <YSI_Coding\y_hooks>

// RolePlay EXP system by Logan - 24.7.2019.

stock ResetPlayerExperience(playerid)
{
	ExpInfo[playerid][eGivenEXP] = false;
	ExpInfo[playerid][eAllPoints] = 0;
	ExpInfo[playerid][ePoints] = 0;
	ExpInfo[playerid][eLastPayDayStamp] = 0;
	ExpInfo[playerid][eDayPayDays] = 0;
	ExpInfo[playerid][eMonthPayDays] = 0;
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetPlayerExperience(playerid);
	return continue(playerid);
}

stock ListBestTemporaryEXP(playerid)
{
	new 
		dialogstring[2056];
	inline OnPlayerLoadTempBestEXP()
	{
		new 
			rows;
		cache_get_row_count(rows);
		if(rows)
		{
			new 
				sqlid,
				allpoints,
				points,
				playername[MAX_PLAYER_NAME], 
				motd[80];

			for( new i = 0; i < rows; i++) 
			{
				// experience table
				cache_get_value_name_int(i, "sqlid"				, sqlid);
				cache_get_value_name_int(i, "allpoints"			, allpoints);
				cache_get_value_name_int(i, "points"			, points);
				
				// accounts table
				cache_get_value_name(i, 	"name"				, playername, MAX_PLAYER_NAME);

				format(motd, sizeof(motd), "%d EXP | Overall EXP: %d | %s [SQLID: %d]\n",
					points,
					allpoints,
					playername,
					sqlid
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_MOST_TEMPEXP, DIALOG_STYLE_MSGBOX, "Igraci sa najvise trenutnog EXP-a:", dialogstring, "Close", "");
			return 1;
		}
	}
	MySQL_TQueryInline(SQL_Handle(),  
		using inline OnPlayerLoadTempBestEXP, 
	 	va_fquery(SQL_Handle(),
		 	"SELECT \n\
			 	experience.sqlid, experience.points, experience.allpoints, \n\
				accounts.name \n\
			FROM \n\
				experience, \n\
				accounts \n\
			WHERE \n\
				accounts.sqlid = experience.sqlid \n\
			ORDER BY experience.points DESC \n\
			LIMIT 0 , 30"
		),
		""
	);
	return 1;
}

stock ListBestOverallEXP(playerid)
{
	new 
		dialogstring[2056];

	inline OnListOverallBestEXP()
	{
		new 
			rows;
		cache_get_row_count(rows);
		if(rows)
		{
			new 
				sqlid,
				allpoints,
				points,
				playername[MAX_PLAYER_NAME], 
				motd[80];

			for( new i = 0; i < rows; i++) 
			{
				// experience table
				cache_get_value_name_int(i, "sqlid"				, sqlid);
				cache_get_value_name_int(i, "allpoints"			, allpoints);
				cache_get_value_name_int(i, "points"			, points);
				
				// accounts table
				cache_get_value_name(i, 	"name"				, playername, MAX_PLAYER_NAME);

				format(motd, sizeof(motd), "%d EXP | Overall EXP: %d | %s [SQLID: %d]\n",
					points,
					allpoints,
					playername,
					sqlid
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_MOST_TEMPEXP, DIALOG_STYLE_MSGBOX, "Igraci sa najvise Overall EXP-a:", dialogstring, "Close", "");
			return 1;
		}
	}
	MySQL_TQueryInline(SQL_Handle(),  
		using inline OnListOverallBestEXP, 
	 	va_fquery(SQL_Handle(),
		 	"SELECT \n\
			 	experience.sqlid, experience.points, experience.allpoints, \n\
				accounts.name \n\
			FROM \n\
				experience, \n\
				accounts \n\
			WHERE \n\
				accounts.sqlid = experience.sqlid \n\
			ORDER BY experience.allpoints DESC \n\
			LIMIT 0 , 30"
		 ),
		""
	);
	return 1;
}

LoadPlayerExperience(playerid)
{	
	inline OnPlayerLoadExperience()
	{
		new 
			rows = cache_num_rows();
		if(rows)
		{
			cache_get_value_name_int(0, "givenexp"			, ExpInfo[playerid][eGivenEXP]);
			cache_get_value_name_int(0, "allpoints"			, ExpInfo[playerid][eAllPoints]);
			cache_get_value_name_int(0, "points"			, ExpInfo[playerid][ePoints]);
			cache_get_value_name_int(0, "lastpayday"		, ExpInfo[playerid][eLastPayDayStamp]);
			cache_get_value_name_int(0, "daypaydays"		, ExpInfo[playerid][eDayPayDays]);
			cache_get_value_name_int(0, "monthpaydays"		, ExpInfo[playerid][eMonthPayDays]);
		}
		else
		{
			return mysql_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					experience \n\
				(sqlid,givenexp,allpoints,points,lastpayday,daypaydays,monthpaydays) \n\
				VALUES \n\
					('%d', '0', '0', '0', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
		}
		return 1;
	} 
	MySQL_TQueryInline(SQL_Handle(), 
		using inline OnPlayerLoadExperience,
		va_fquery(SQL_Handle(), "SELECT * FROM experience WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),  
		"i", 
		playerid
	);
	return 1;
}

hook function LoadPlayerStats(playerid)
{
	LoadPlayerExperience(playerid);
	return continue(playerid);
}

stock SavePlayerExperience(playerid)
{
	if(!Player_SafeSpawned(playerid))	
		return 1;
	
	mysql_fquery(SQL_Handle(), 
		"UPDATE experience SET givenexp = '%d', allpoints = '%d', points = '%d', lastpayday = '%d',\n\
			daypaydays = '%d', monthpaydays = '%d' WHERE sqlid = '%d'",
		ExpInfo[playerid][eGivenEXP],
		ExpInfo[playerid][eAllPoints],
		ExpInfo[playerid][ePoints],
		ExpInfo[playerid][eLastPayDayStamp],
		ExpInfo[playerid][eDayPayDays],
		ExpInfo[playerid][eMonthPayDays],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

hook function SavePlayerStats(playerid)
{
	SavePlayerExperience(playerid);
	return continue(playerid);
}

stock CanPlayerGiveExp(playerid)
{
	if(PlayerInfo[playerid][pLevel] < 2)
	{
		SendErrorMessage(playerid, "Morate biti minimalno Level 2 da bi nekome dali EXP!");
		return 0;
	}
	if(ExpInfo[playerid][eGivenEXP])
	{
		SendErrorMessage(playerid, "Vec ste danas dali EXP nekome! Mozete ga davati samo jednom dnevno.");
		return 0;
	}
	if(ExpInfo[playerid][eDayPayDays] < MIN_GIVER_EXP_PAYDAYS)
	{
		va_SendClientMessage(playerid,COLOR_RED, "Trebate skupiti minimalno %d paydaya da bi dali EXP nekome.", MIN_GIVER_EXP_PAYDAYS);
		return 0;
	}
	return 1;
}

stock CanPlayerTakeExp(playerid, giveplayerid) 
{
	if(ExpInfo[giveplayerid][eDayPayDays] < MIN_RECIEVER_EXP_PAYDAYS)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s nije skupio %d paydaya da bi mogao dobiti EXP.", GetName(giveplayerid, true), MIN_RECIEVER_EXP_PAYDAYS);
		return 0;
	}
	if(PlayerInfo[giveplayerid][pLevel] < 2)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s treba biti minimalno Level 2 da bi primio EXP.", GetName(giveplayerid, true));
		return 0;
	}
	new currentday, day;
	TimeFormat(Timestamp:gettimestamp(), DAY_OF_MONTH, "%d" ,currentday);
	TimeFormat(Timestamp:ExpInfo[playerid][eLastPayDayStamp], DAY_OF_MONTH, "%d", day);
	
	if(currentday != day)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s nije danas imao payday te ne moze primiti EXP.", GetName(giveplayerid, true));
		return 0;
	}
	return 1;
}

stock CanPlayerTakeExpEx(playerid, playername[]) 
{
	new 
		sqlid, 
		level,
		Cache:result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT sqlid, levels FROM accounts WHERE name = '%e'", playername)),
		rows;
		
    cache_get_row_count(rows);
	if(!rows)
	{
		SendClientMessage(playerid,COLOR_RED, "Ne postoji korisnik s tim nickom!");
		return 0;
	}
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_get_value_name_int(0, "levels", level);
	cache_delete(result);
	
	if(level < 2)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s je Level %d, treba biti Level 2 da bi primio EXP.", playername, level);
		return 0;
	}

	new Cache:result2 = mysql_query(SQL_Handle(), 
							va_fquery(SQL_Handle(), "SELECT lastpayday, daypaydays FROM experience WHERE sqlid = '%d'", sqlid)
						);
	
	new lastpayday, daypaydays, currentday, day;
	cache_get_value_name_int(0, "lastpayday"	, lastpayday);
	cache_get_value_name_int(0, "daypaydays"	, daypaydays);
	cache_delete(result2);
	
	TimeFormat(Timestamp:gettimestamp(), DAY_OF_MONTH, "%d", currentday);
	TimeFormat(Timestamp:lastpayday, DAY_OF_MONTH, "%d", day);
	
	if(currentday != day)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s nije danas imao payday te ne moze primiti EXP.", playername);
		return 0;
	}
	if(daypaydays < MIN_RECIEVER_EXP_PAYDAYS)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s bi trebao primiti %d paydayova danas da bi dobio EXP.", playername, MIN_RECIEVER_EXP_PAYDAYS);
		return 0;
	}
	return 1;
}

stock GivePlayerExperience(playerid, playername[])
{
	new sqlid;
	
	new Cache:result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT sqlid FROM accounts WHERE name = '%e'", playername));

	new rows;
	cache_get_row_count(rows);
	if(!rows)
	{
		va_SendClientMessage(playerid,COLOR_RED, "Ne postoji korisnik s tim nickom!");
		return 0;
	}
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
		
	mysql_fquery(SQL_Handle(),  
		"UPDATE experience SET points = points + '%d', allpoints = allpoints + '%d' WHERE sqlid = '%d'", 
		1, 
		1, 
		sqlid
	);
	
	va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali %s 1 EXP.", playername);
	if(HappyHours_Get())
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 0;
	}
	else ExpInfo[playerid][eGivenEXP] = true;
	SavePlayerExperience(playerid);
	return 1;
}

RewardPlayerForActivity(sqlid, amount)
{	
	mysql_fquery(SQL_Handle(), 
		"UPDATE experience SET points = points +'%d', allpoints = allpoints + '%d' WHERE sqlid = '%d'", 
		amount, 
		amount, 
		sqlid
	);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case DIALOG_EXPERIENCE_BUY:
		{
			if(!response) 
				return 1;
				
			switch(listitem)
			{
				case 0: // Level Up
				{
					if(ExpInfo[playerid][ePoints] < LEVEL_UP_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi iskoristili Level Up!", LEVEL_UP_EXP);
						
					ExpInfo[playerid][ePoints] -= LEVEL_UP_EXP;
					mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '%d' WHERE sqlid = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					
					PlayerInfo[playerid][pLevel]++;
					mysql_fquery(SQL_Handle(), "UPDATE accounts SET levels = '%d' WHERE sqlid = '%d'",
						PlayerInfo[playerid][pLevel],
						PlayerInfo[playerid][pSQLID]
					);
					
					SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
					GameTextForPlayer( playerid, "~g~Level up!", 1000, 1);
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Level Up opciju. Preostalo: %d EXP", LEVEL_UP_EXP, ExpInfo[playerid][ePoints]);
					return 1;
				}
				case 1: // Permanent Furniture Slots 
				{
					if(ExpInfo[playerid][ePoints] < MAX_FURSLOTS_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili %d Furniture slotova!", MAX_FURSLOTS_EXP, FURNITURE_PREMIUM_OBJECTS);
					if(PlayerKeys[playerid][pHouseKey] == INVALID_HOUSE_ID)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be a house owner to use that EXP buy option!");

					ExpInfo[playerid][ePoints] -= MAX_FURSLOTS_EXP;
					mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '%d' WHERE sqlid = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					
					PlayerInfo[playerid][pExtraFurniture] = 1;
					SetPlayerPremiumFurniture(playerid, PlayerKeys[playerid][pHouseKey]);
					
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za %d Furniture slotova. Preostalo: %d EXP", MAX_FURSLOTS_EXP, FURNITURE_PREMIUM_OBJECTS, ExpInfo[playerid][ePoints]);
					return 1;
				}
				case 2: // Premium Bronze VIP paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_BRONZE_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Bronze paket!", PREMIUM_BRONZE_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_BRONZE_EXP;
					mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '%d' WHERE sqlid = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
				
					SetPlayerPremiumVIP(playerid, PREMIUM_BRONZE);
					
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Bronze. Preostalo: %d EXP", PREMIUM_BRONZE_EXP, ExpInfo[playerid][ePoints]);
					SendClientMessage(playerid, COLOR_RED, "[SERVER]  Iskrene cestitke na Premium paketu! Vas Premium paket traje sljedecih mjesec dana.");
					return 1;
				}
				case 3: // Premium Silver VIP paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_SILVER_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Silver paket!", PREMIUM_SILVER_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_SILVER_EXP;
					mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '%d' WHERE sqlid = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					
					SetPlayerPremiumVIP(playerid, PREMIUM_SILVER);
					
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Silver. Preostalo: %d EXP", PREMIUM_SILVER_EXP, ExpInfo[playerid][ePoints]);
					SendClientMessage(playerid,COLOR_RED, "[SERVER] Iskrene cestitke na Premium paketu! Vas Premium paket traje sljedecih mjesec dana.");
					return 1;
				}
				case 4: // Premium Gold paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_GOLD_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Gold paket!", PREMIUM_GOLD_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_GOLD_EXP;
					mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '%d' WHERE sqlid = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					
					SetPlayerPremiumVIP(playerid, PREMIUM_GOLD);
					
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Gold. Preostalo: %d EXP", PREMIUM_GOLD_EXP, ExpInfo[playerid][ePoints]);
					SendClientMessage(playerid, COLOR_RED, "[SERVER]  Iskrene cestitke na Premium paketu! Vas Premium paket traje sljedecih mjesec dana.");
					return 1;
				}
			}
		}
		case DIALOG_EXP_CHOOSE:
		{		
			switch(listitem)
			{
				case 0: ListBestTemporaryEXP(playerid);
				case 1: ListBestOverallEXP(playerid);
			}
			return 1;
		}
	}
	return 1;
}
	
CMD:experience(playerid, params[])
{
	new choice[12], playername[24], giveplayerid, bool:online=false;
	if(sscanf(params, "s[12] ", choice)) 
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /experience [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[!] check, give, buy");
		if(PlayerInfo[playerid][pAdmin] == 1338)
			SendClientMessage(playerid, COLOR_RED, "[!](admin) reset, bestplayers, setexp");
		return 1;
	}
	if(!strcmp(choice, "bestplayers", true))
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		ShowPlayerDialog(playerid, DIALOG_EXP_CHOOSE, DIALOG_STYLE_LIST, "Odaberite kriterij po kojem zelite vidjeti EXP:", "Trenutni EXP\nOverall EXP", "Pick", "Exit");
		return 1;
	}
	if(!strcmp(choice, "reset", true))
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		if(sscanf(params, "s[12]u", choice, giveplayerid))
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /experience reset [Ime_Prezime]");
			return 1;
		}
		ResetPlayerExperience(giveplayerid);
		SavePlayerExperience(giveplayerid);
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste resetirali %s sve EXP statse.", GetName(giveplayerid, true));
		va_SendMessage(giveplayerid, MESSAGE_TYPE_INFO, "Administrator %s Vam je resetirao sve EXP statse.", GetName(playerid, true));
		return 1;
	}	
	if(!strcmp(choice, "setexp", true))
	{
		new exps;
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		if(sscanf(params, "s[12]ui", choice, giveplayerid, exps))
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /experience setexp [playerid][exp]");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid)) va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "ID %d nije online!", giveplayerid);
		if(!Player_SafeSpawned(giveplayerid)) va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "ID %d nije online!", giveplayerid);
		ExpInfo[giveplayerid][ePoints] = exps;
		ExpInfo[giveplayerid][eAllPoints] = exps;
		SavePlayerExperience(giveplayerid);
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste postavili %s EXP statse na %d.", GetName(giveplayerid, true), exps);
		va_SendMessage(giveplayerid, MESSAGE_TYPE_INFO, "Administrator %s Vam je postavio EXP statse na %d.", GetName(playerid, true), exps);
		return 1;
	}
	if(!strcmp(choice, "check", true))
	{
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno imate %d EXP-a na trosenje. Overall: [%d EXP]", ExpInfo[playerid][ePoints], ExpInfo[playerid][eAllPoints]);
		return 1;
	}	
	if(!strcmp(choice, "give", true))
	{
		if(sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /experience give [Ime_Prezime]");
			return 1;
		}
		if(!CanPlayerGiveExp(playerid))
			return 1;
		
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && Player_SafeSpawned(playerid))
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
		if(online)
		{
			if(playerid == giveplayerid)
				return SendErrorMessage(playerid, "Ne mozete sami sebi dati EXP!");
				
			if(!CanPlayerTakeExp(playerid, giveplayerid))
				return 1;
			
			if(HappyHours_Get())
			{
				ExpInfo[playerid][eGivenEXP] = false;
				ExpInfo[playerid][eDayPayDays] = 0;
			}
			else ExpInfo[playerid][eGivenEXP] = true;
			
			ExpInfo[giveplayerid][ePoints] += 1;
			ExpInfo[giveplayerid][eAllPoints] += 1;
			
			va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali %s 1 EXP.", playername);
			SendMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, "Dobili ste 1 EXP od nekoga. Cestitke za dobar RP!");
			
			SavePlayerExperience(playerid);
			SavePlayerExperience(giveplayerid);
			return 1;
		}
		else
		{
			if(!CanPlayerTakeExpEx(playerid, playername))
				return 1;
				
			GivePlayerExperience(playerid, playername);
			return 1;
		}
	}
	if(!strcmp(choice, "buy", true))
	{
		new expbuyinfo[264];
		format(expbuyinfo, sizeof(expbuyinfo), "{3C95C2}[%d EXP] - Level Up.\n{3C95C2}[%d EXP] - %d Furniture Premium(700 slotova).\n{3C95C2}[%d EXP] - VIP Premium Bronze.\n{3C95C2}[%d EXP] - VIP Premium Silver.\n{3C95C2}[%d EXP] - VIP Premium  Gold.", 
			LEVEL_UP_EXP, 
			MAX_FURSLOTS_EXP, 
			FURNITURE_PREMIUM_OBJECTS, 
			PREMIUM_BRONZE_EXP, 
			PREMIUM_SILVER_EXP, 
			PREMIUM_GOLD_EXP
		);
		ShowPlayerDialog(playerid, DIALOG_EXPERIENCE_BUY, DIALOG_STYLE_LIST, "Odaberite sto zelite kupiti EXP-om:", expbuyinfo, "Pick", "Close");
		return 1;
	}
	return 1;
}	
