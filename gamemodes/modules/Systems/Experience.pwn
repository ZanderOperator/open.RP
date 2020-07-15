#include <YSI\y_hooks>

// RolePlay EXP system by Logan - 24.7.2019.

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
					
					new expQueryUpdate[90];
					format(expQueryUpdate, sizeof(expQueryUpdate), "UPDATE `experience` SET `points` = '%d' WHERE `sqlid` = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, expQueryUpdate);
					
					PlayerInfo[playerid][pLevel]++;
					new levelUpUpdate[90];
					format(levelUpUpdate, 90, "UPDATE `accounts` SET `levels` = '%d' WHERE `sqlid` = '%d'",
						PlayerInfo[playerid][pLevel],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, levelUpUpdate);
					
					SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
					GameTextForPlayer( playerid, "~g~Level up!", 1000, 1 );
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Level Up opciju. Preostalo: %d EXP", LEVEL_UP_EXP, ExpInfo[playerid][ePoints]);
					return 1;
				}
				case 1: // Permanent Furniture Slots 
				{
					if(ExpInfo[playerid][ePoints] < MAX_FURSLOTS_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili %d Furniture slotova!", MAX_FURSLOTS_EXP, FURNITURE_PREMIUM_OBJECTS);
					
					ExpInfo[playerid][ePoints] -= MAX_FURSLOTS_EXP;
					
					new expQueryUpdate[90];
					format(expQueryUpdate, sizeof(expQueryUpdate), "UPDATE `experience` SET `points` = '%d' WHERE `sqlid` = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, expQueryUpdate);
					
					PlayerInfo[playerid][FurnPremium] = 1;
					if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
						SetPlayerPremiumFurniture(playerid, PlayerInfo[playerid][pHouseKey]);
					
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za %d Furniture slotova. Preostalo: %d EXP", MAX_FURSLOTS_EXP, FURNITURE_PREMIUM_OBJECTS, ExpInfo[playerid][ePoints]);
					return 1;
				}
				case 2: // Premium Bronze paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_BRONZE_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Bronze paket!", PREMIUM_BRONZE_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_BRONZE_EXP;
					
					new expQueryUpdate[90];
					format(expQueryUpdate, sizeof(expQueryUpdate), "UPDATE `experience` SET `points` = '%d' WHERE `sqlid` = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, expQueryUpdate);
				
					// Premium Bronze
					PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);
					new log[128],
						playerip[MAX_PLAYER_IP];
					GetPlayerIp(playerid, playerip, sizeof(playerip));

					format(log, sizeof(log), "%s(%s), maskid %d.",
						GetName(playerid, false),
						playerip,
						PlayerInfo[ playerid ][ pMaskID ]
					);
					LogMask(log);
					PlayerInfo[playerid][pFreeWorks] 	= 25;
					PlayerInfo[playerid][pDonateRank] 	= 1;
					PlayerInfo[playerid][pRespects] 	+= 10;
					PlayerInfo[playerid][pChangeTimes] 	+= 2;
					PlayerInfo[playerid][pLevel] 		+= 1;
					PlayerInfo[playerid][pDonateTime]	= gettimestamp() + 2592000;
					BudgetToPlayerMoney(playerid, 15000); // budjet - igrac
					
					if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
						UpdatePremiumHouseFurSlots(playerid, -1, PlayerInfo[ playerid ][ pHouseKey ]);
					if(PlayerInfo[playerid][pBizzKey] != INVALID_BIZNIS_ID)
						UpdatePremiumBizFurSlots(playerid);
					new
						vipUpdtQuery[ 128 ];
					format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d' WHERE `sqlid` = '%d'",
						PlayerInfo[playerid][pDonateRank],
						PlayerInfo[playerid][pDonateTime],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, vipUpdtQuery);
					
					
					// MySQL Log
					new vipLog[200];
					format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pDonateRank],
						gettimestamp(),
						PlayerInfo[playerid][pDonateTime]
					);
					mysql_pquery(g_SQL, vipLog);
					
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Bronze. Preostalo: %d EXP", PREMIUM_BRONZE_EXP, ExpInfo[playerid][ePoints]);
					SendClientMessage(playerid, COLOR_RED, "[SERVER]  Iskrene cestitke na Premium paketu! Vas Premium paket traje sljedecih mjesec dana.");
					return 1;
				}
				case 3: // Premium Bronze paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_SILVER_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Silver paket!", PREMIUM_SILVER_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_SILVER_EXP;
				
					new expQueryUpdate[90];
					format(expQueryUpdate, sizeof(expQueryUpdate), "UPDATE `experience` SET `points` = '%d' WHERE `sqlid` = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, expQueryUpdate);
					
					PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);
					new log[128],
						playerip[MAX_PLAYER_IP];
					GetPlayerIp(playerid, playerip, sizeof(playerip));

					format(log, sizeof(log), "%s(%s), maskid %d.",
						GetName(playerid, false),
						playerip,
						PlayerInfo[ playerid ][ pMaskID ]
					);
					LogMask(log);
					
					PlayerInfo[playerid][pFreeWorks] 	= 25;
					PlayerInfo[playerid][pDonateRank] 	= 2;
					PlayerInfo[playerid][pRespects] 	+= 20;
					PlayerInfo[playerid][pLevel] 		+= 2;
					PlayerInfo[playerid][pChangeTimes] 	+= 3;
					PlayerInfo[playerid][pDonateTime]	= gettimestamp() + 2592000;
					BudgetToPlayerMoney(playerid, 30000); // budjet - igrac
					
					if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
						UpdatePremiumHouseFurSlots(playerid, -1, PlayerInfo[ playerid ][ pHouseKey ]);
					if(PlayerInfo[playerid][pBizzKey] != INVALID_BIZNIS_ID)
						UpdatePremiumBizFurSlots(playerid);
					new
						vipUpdtQuery[ 128 ];
					format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d' WHERE `sqlid` = '%d'",
						PlayerInfo[playerid][pDonateRank],
						PlayerInfo[playerid][pDonateTime],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, vipUpdtQuery);
					
					// MySQL Log
					new vipLog[200];
					format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pDonateRank],
						gettimestamp(),
						PlayerInfo[playerid][pDonateTime]
					);
					mysql_pquery(g_SQL, vipLog);
					
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Silver. Preostalo: %d EXP", PREMIUM_SILVER_EXP, ExpInfo[playerid][ePoints]);
					SendClientMessage(playerid,COLOR_RED, "[SERVER] Iskrene cestitke na Premium paketu! Vas Premium paket traje sljedecih mjesec dana.");
					return 1;
				}
				case 4: // Premium Gold paket na mjesec dana
				{
					if(ExpInfo[playerid][ePoints] < PREMIUM_GOLD_EXP)
						return va_SendClientMessage(playerid,COLOR_RED, "Potrebno je %d EXP-a da bi dobili Premium Gold paket!", PREMIUM_GOLD_EXP);
					
					ExpInfo[playerid][ePoints] -= PREMIUM_GOLD_EXP;
				
					new expQueryUpdate[90];
					format(expQueryUpdate, sizeof(expQueryUpdate), "UPDATE `experience` SET `points` = '%d' WHERE `sqlid` = '%d'",
						ExpInfo[playerid][ePoints],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_pquery(g_SQL, expQueryUpdate);
					
					PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);
					new log[128],
						playerip[MAX_PLAYER_IP];
					GetPlayerIp(playerid, playerip, sizeof(playerip));

					format(log, sizeof(log), "%s(%s), maskid %d.",
						GetName(playerid, false),
						playerip,
						PlayerInfo[ playerid ][ pMaskID ]
					);
					LogMask(log);
					
					PlayerInfo[playerid][pFreeWorks] 	= 30;
					PlayerInfo[playerid][pDonateRank] 	= 3;
					PlayerInfo[playerid][pRespects] 	+= 30;
					PlayerInfo[playerid][pLevel] 		+= 3;
					PlayerInfo[playerid][pChangeTimes] 	+= 5;
					PlayerInfo[playerid][pDonateTime]	= gettimestamp() + 2592000;
					BudgetToPlayerMoney(playerid, 40000); // budjet - igrac
					
					PlayerInfo[playerid][pCarLic] 	= 1;
					PlayerInfo[playerid][pFlyLic] 	= 1;
					PlayerInfo[playerid][pBoatLic] 	= 1;
					PlayerInfo[playerid][pFishLic]  = 1;
					
					if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
						UpdatePremiumHouseFurSlots(playerid, -1, PlayerInfo[ playerid ][ pHouseKey ]);
					if(PlayerInfo[playerid][pBizzKey] != INVALID_BIZNIS_ID)
						UpdatePremiumBizFurSlots(playerid);
					new
						vipUpdtQuery[ 128 ];
					format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d' WHERE `sqlid` = '%d'",
						PlayerInfo[playerid][pDonateRank],
						PlayerInfo[playerid][pDonateTime],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, vipUpdtQuery);
					
					// MySQL Log
					new vipLog[200];
					format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pSQLID],
						PlayerInfo[playerid][pDonateRank],
						gettimestamp(),
						PlayerInfo[playerid][pDonateTime]
					);
					mysql_pquery(g_SQL, vipLog);
					
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Iskoristili ste %d EXP-a za Premium Gold. Preostalo: %d EXP", PREMIUM_GOLD_EXP, ExpInfo[playerid][ePoints]);
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

stock ListBestTemporaryEXP(playerid)
{
	new tempExpQuery[100], dialogstring[2056];
	format(tempExpQuery, sizeof(tempExpQuery), "SELECT * FROM  `experience` ORDER BY `experience`.`points` DESC LIMIT 0 , 30");
	inline OnPlayerLoadTempBestEXP()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows)
		{
			new sqlid[30], allpoints[30], points[30], motd[64];
			for( new i = 0; i < rows; i++ ) 
			{
				cache_get_value_name_int(i, "sqlid"				, sqlid[i]);
				cache_get_value_name_int(i, "allpoints"			, allpoints[i]);
				cache_get_value_name_int(i, "points"			, points[i]);
			}
			for( new i = 0; i < rows; i++ ) 
			{
				format(motd, sizeof(motd), "%d EXP | Overall EXP: %d | %s [SQLID: %d]\n",
					points[i],
					allpoints[i],
					ConvertSQLIDToName(sqlid[i]),
					sqlid[i]
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_MOST_TEMPEXP, DIALOG_STYLE_MSGBOX, "Igraci sa najvise trenutnog EXP-a:", dialogstring, "Zatvori", "");
			return 1;
		}
	}
	mysql_tquery_inline(g_SQL, tempExpQuery, using inline OnPlayerLoadTempBestEXP, "i", playerid);
	return 1;
}

stock ListBestOverallEXP(playerid)
{
	new tempExpQuery[100], dialogstring[1930];
	format(tempExpQuery, sizeof(tempExpQuery), "SELECT * FROM  `experience` ORDER BY `experience`.`allpoints` DESC LIMIT 0 , 30");
	inline OnListOverallBestEXP()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows)
		{
			new sqlid[30], allpoints[30], points[30], motd[64];
			for( new i = 0; i < rows; i++ ) 
			{
				cache_get_value_name_int(i, "sqlid"				, sqlid[i]);
				cache_get_value_name_int(i, "allpoints"			, allpoints[i]);
				cache_get_value_name_int(i, "points"			, points[i]);
			}
			for( new i = 0; i < rows; i++ ) 
			{
				format(motd, sizeof(motd), "Overall EXP: %d | %d EXP | %s [SQLID: %d]\n",
					allpoints[i],
					points[i],
					ConvertSQLIDToName(sqlid[i]),
					sqlid[i]
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_MOST_TEMPEXP, DIALOG_STYLE_MSGBOX, "Igraci sa najvise Overall EXP-a:", dialogstring, "Zatvori", "");
			return 1;
		}
	}
	mysql_tquery_inline(g_SQL, tempExpQuery, using inline OnListOverallBestEXP, "i", playerid);
	return 1;
}

stock LoadPlayerExperience(playerid)
{
	new expstring[100];
	format(expstring, sizeof(expstring), "SELECT * FROM `experience` WHERE `sqlid` = '%d'", PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, expstring, "OnPlayerLoadExperience", "i", playerid);
	return 1;
}

Function: OnPlayerLoadExperience(playerid)
{
	new rows;
    cache_get_row_count(rows);
    if(rows)
	{
		cache_get_value_name_int(0, "givenexp"			, ExpInfo[playerid][eGivenEXP]);
		cache_get_value_name_int(0, "allpoints"			, ExpInfo[playerid][eAllPoints]);
		cache_get_value_name_int(0, "points"			, ExpInfo[playerid][ePoints]);
		cache_get_value_name_int(0, "lastpayday"		, ExpInfo[playerid][eLastPayDayStamp]);
		cache_get_value_name_int(0, "daypaydays"		, ExpInfo[playerid][eDayPayDays]);
		cache_get_value_name_int(0, "monthpaydays"		, ExpInfo[playerid][eMonthPayDays]);
		return 1;
	}
	else
	{
		new insertQuery[200];
		format(insertQuery, sizeof(insertQuery), "INSERT INTO experience (sqlid,givenexp,allpoints,points,lastpayday,daypaydays,monthpaydays) VALUES ('%d', '0', '0', '0', '0', '0', '0')",
			PlayerInfo[playerid][pSQLID]
		);
		mysql_query(g_SQL, insertQuery);
		return 1;
	}
}

stock SavePlayerExperience(playerid)
{
	if( !SafeSpawned[playerid] )	
		return 1;
	
	new mysqlUpdate[200];
	format(mysqlUpdate, 200, "UPDATE `experience` SET `givenexp` = '%d', `allpoints` = '%d', `points` = '%d', `lastpayday` = '%d', `daypaydays` = '%d', `monthpaydays` = '%d' WHERE `sqlid` = '%d'",
		ExpInfo[playerid][eGivenEXP],
		ExpInfo[playerid][eAllPoints],
		ExpInfo[playerid][ePoints],
		ExpInfo[playerid][eLastPayDayStamp],
		ExpInfo[playerid][eDayPayDays],
		ExpInfo[playerid][eMonthPayDays],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate, "", "");
	return 1;
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
	stamp2datetime(gettimestamp(), _, _, currentday, _, _, _);
	stamp2datetime(ExpInfo[giveplayerid][eLastPayDayStamp], _, _, day, _, _, _);
	
	if(currentday != day)
	{
		va_SendClientMessage(playerid,COLOR_RED, "%s nije danas imao payday te ne moze primiti EXP.", GetName(giveplayerid, true));
		return 0;
	}
	return 1;
}

stock CanPlayerTakeExpEx(playerid, playername[]) 
{
	new sqlid, level, idQuery[100];
	mysql_format(g_SQL, idQuery, sizeof(idQuery), "SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", playername);
	
	new 
		Cache:result = mysql_query(g_SQL, idQuery),
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
	new expstring[100];
	format(expstring, sizeof(expstring), "SELECT * FROM `experience` WHERE `sqlid` = '%d'", sqlid);
	new Cache:result2 = mysql_query(g_SQL, expstring);
	
	new lastpayday, daypaydays, currentday, day;
	cache_get_value_name_int(0, "lastpayday"	, lastpayday);
	cache_get_value_name_int(0, "daypaydays"	, daypaydays);
	cache_delete(result2);
	
	stamp2datetime(gettimestamp(), _, _, currentday, _, _, _);
	stamp2datetime(lastpayday, _, _, day, _, _, _);
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
	new sqlid, idQuery[100];
	
	mysql_format(g_SQL, idQuery, sizeof(idQuery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", playername);
	new Cache:result = mysql_query(g_SQL, idQuery),
		rows;
		
    cache_get_row_count(rows);
	if(!rows)
	{
		va_SendClientMessage(playerid,COLOR_RED, "Ne postoji korisnik s tim nickom!");
		return 0;
	}
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	
	new expstring[100];
	format(expstring, sizeof(expstring), "SELECT * FROM `experience` WHERE `sqlid` = '%d'", sqlid);
	new Cache:result2 = mysql_query(g_SQL, expstring),
		points,
		allpoints;
	
	cache_get_value_name_int(0, "points", points);
	cache_get_value_name_int(0, "points", allpoints);
	points++;
	allpoints++;
	cache_delete(result2);
		
	new expQuery[150];
	format(expQuery, sizeof(expQuery), "UPDATE `experience` SET `points` = '%d', `allpoints` = '%d' WHERE `sqlid` = '%d'", points, allpoints, sqlid);
	mysql_tquery(g_SQL, expQuery, "");
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali %s 1 EXP.", playername);
	if(HappyHours)
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 0;
	}
	else ExpInfo[playerid][eGivenEXP] = true;
	SavePlayerExperience(playerid);
	return 1;
}
	
CMD:experience(playerid, params[])
{
	new choice[12], playername[24], giveplayerid, bool:online=false;
	if(sscanf(params, "s[12] ", choice)) 
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /experience [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] check, give, buy");
		if(PlayerInfo[playerid][pAdmin] == 1338)
			SendClientMessage(playerid, COLOR_RED, "[ ! ](admin) reset, bestplayers, setexp");
		return 1;
	}
	if( !strcmp(choice, "bestplayers", true) )
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		ShowPlayerDialog(playerid, DIALOG_EXP_CHOOSE, DIALOG_STYLE_LIST, "Odaberite kriterij po kojem zelite vidjeti EXP:", "Trenutni EXP\nOverall EXP", "Odabir", "Izlaz");
		return 1;
	}
	if( !strcmp(choice, "reset", true) )
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		if (sscanf(params, "s[12]u", choice, giveplayerid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /experience reset [Ime_Prezime]");
			return 1;
		}
		ResetPlayerExperience(giveplayerid);
		SavePlayerExperience(giveplayerid);
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste resetirali %s sve EXP statse.", GetName(giveplayerid, true));
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "Administrator %s Vam je resetirao sve EXP statse.", GetName(playerid, true));
		return 1;
	}	
	if( !strcmp(choice, "setexp", true) )
	{
		new exps;
		if(PlayerInfo[playerid][pAdmin] < 1338)
		{
			SendErrorMessage(playerid, "Niste Head Administrator!");
			return 1;
		}
		if (sscanf(params, "s[12]ui", choice, giveplayerid, exps))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /experience setexp [playerid] [exp]");
			return 1;
		}
		ExpInfo[giveplayerid][ePoints] = exps;
		ExpInfo[giveplayerid][eAllPoints] = exps;
		SavePlayerExperience(giveplayerid);
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste postavili %s EXP statse na %d.", GetName(giveplayerid, true), exps);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "Administrator %s Vam je postavio EXP statse na %d.", GetName(playerid, true), exps);
		return 1;
	}
	if( !strcmp(choice, "check", true) )
	{
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno imate %d EXP-a na trosenje. Overall: [%d EXP]", ExpInfo[playerid][ePoints], ExpInfo[playerid][eAllPoints]);
		return 1;
	}	
	if( !strcmp(choice, "give", true) )
	{
		if (sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /experience give [Ime_Prezime]");
			return 1;
		}
		if(!CanPlayerGiveExp(playerid))
			return 1;
		
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
		if(online)
		{
			if(playerid == giveplayerid)
				return SendErrorMessage(playerid, "Ne mozete sami sebi dati EXP!");
				
			if(!CanPlayerTakeExp(playerid, giveplayerid))
				return 1;
			
			if(HappyHours)
			{
				ExpInfo[playerid][eGivenEXP] = false;
				ExpInfo[playerid][eDayPayDays] = 0;
			}
			else ExpInfo[playerid][eGivenEXP] = true;
			
			ExpInfo[giveplayerid][ePoints] += 1;
			ExpInfo[giveplayerid][eAllPoints] += 1;
			
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali %s 1 EXP.", playername);
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
	if( !strcmp(choice, "buy", true) )
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
		ShowPlayerDialog(playerid, DIALOG_EXPERIENCE_BUY, DIALOG_STYLE_LIST, "Odaberite sto zelite kupiti EXP-om:", expbuyinfo, "Odabir", "(x)");
		return 1;
	}
	return 1;
}	
