#include <YSI\y_hooks>

/*================================================INFO================================================
	Farmer 			- 	0
	PizzaBoy 		- 	1
	Smetlar			-	2
	Crafter			-	3
	Kosa� trave		-	4
	Lopov			-	5
	Car jacker		- 	6
	Trucker         -   7
	Drug Dealer		-	8
	Pilot			- 	9
======================================================================================================*/
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock LoadPlayerSkills(playerid)
{
	new 
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `skill` WHERE `player_id` = '%d' LIMIT 0,1",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery, "OnPlayerSkillsLoad", "i", playerid);
	return 1;
}

stock ResetPlayerSkills(playerid)
{
	PlayerInfo[ playerid ][ pSkillId ] = -1;
	for(new i = 0; i < 7; i++)
		PlayerInfo[ playerid ][ pSkills ][ i ] = 0;
}

stock UpgradePlayerSkill(playerid, skillid, points = 1)
{
	new 
		skill = 0;
	if(PlayerInfo[playerid][pSkills][skillid] == 49)
		skill = 1;
	else if(PlayerInfo[playerid][pSkills][skillid] == 99)
		skill = 2;
	else if(PlayerInfo[playerid][pSkills][skillid] == 149)
		skill = 3;
	else if(PlayerInfo[playerid][pSkills][skillid] == 199)
		skill = 4;
	if(skill > 0) {
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Vas skill level posla se povecao na %i.", skill);
	}
	PlayerInfo[playerid][pSkills][skillid] += points;
	if(PlayerInfo[playerid][pSkills][skillid] >= 250) 
		PlayerInfo[playerid][pSkills][skillid] = 250;
	Bit1_Set( gr_IsWorkingJob, playerid, false );
	return 1;
}

SavePlayerSkill(playerid, sqlid)
{
	if(sqlid == 0) // tria vidit ovo salje 0 na playerid u update skillsu
		return 0;

	if(PlayerInfo[playerid][pSkillId] == -1)
	{
		new
			skillQuery[ 256 ];
			
		format(skillQuery, 256, "INSERT INTO `skill` (`player_id`, `skill0`, `skill1`, `skill2`, `skill3`, `skill4`, `skill5`, `skill6`, `skill7`, `skill8`, `skill9`) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')",
			sqlid,
			PlayerInfo[playerid][pSkills][0],
			PlayerInfo[playerid][pSkills][1],
			PlayerInfo[playerid][pSkills][2],
			PlayerInfo[playerid][pSkills][3],
			PlayerInfo[playerid][pSkills][4],
			PlayerInfo[playerid][pSkills][5],
			PlayerInfo[playerid][pSkills][6],
			PlayerInfo[playerid][pSkills][7],
			PlayerInfo[playerid][pSkills][8],
			PlayerInfo[playerid][pSkills][9]
		);
		mysql_tquery(g_SQL, skillQuery, "OnSkillsInsertQuery", "id", playerid, sqlid);
	} 
	else 
	{
		new
			skillQuery[ 256 ];
		format(skillQuery, 256, "UPDATE `skill` SET `player_id` = '%d', `skill0` = '%d', `skill1` = '%d', `skill2` = '%d', `skill3` = '%d', `skill4` = '%d', `skill5` = '%d', `skill6` = '%d', `skill7` = '%d', `skill8` = '%d', `skill9` = '%d' WHERE `id` = '%d'",
			sqlid,
			PlayerInfo[playerid][pSkills][0],
			PlayerInfo[playerid][pSkills][1],
			PlayerInfo[playerid][pSkills][2],
			PlayerInfo[playerid][pSkills][3],
			PlayerInfo[playerid][pSkills][4],
			PlayerInfo[playerid][pSkills][5],
			PlayerInfo[playerid][pSkills][6],
			PlayerInfo[playerid][pSkills][7],
			PlayerInfo[playerid][pSkills][8],
			PlayerInfo[playerid][pSkills][9],
			PlayerInfo[playerid][pSkillId]
		);
		mysql_tquery(g_SQL, skillQuery, "", "");
	}
	return 1;
}

stock GetPlayerSkillLevel(playerid, skillid)
{
	new 
		skilllevel;
	skilllevel = floatround((PlayerInfo[playerid][pSkills][skillid] / 50), floatround_floor);
	if(skilllevel > 4)
		skilllevel = 4;
	return skilllevel;
}

/*
	 ######     ###    ##       ##       ########     ###     ######  ##    ##  ######  
	##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##  ##    ## 
	##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##   ##       
	##       ##     ## ##       ##       ########  ##     ## ##       #####     ######  
	##       ######### ##       ##       ##     ## ######### ##       ##  ##         ## 
	##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##  ##    ## 
	 ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##  ######  
*/
forward OnPlayerSkillsLoad(playerid);
public OnPlayerSkillsLoad(playerid)
{
	if(cache_num_rows()) 
	{
		cache_get_value_name_int(0, "id"		, PlayerInfo[ playerid ][ pSkillId ]);
		cache_get_value_name_int(0, "skill0"	, PlayerInfo[ playerid ][ pSkills ][ 0 ]);
		cache_get_value_name_int(0, "skill1"	, PlayerInfo[ playerid ][ pSkills ][ 1 ]);
		cache_get_value_name_int(0, "skill2"	, PlayerInfo[ playerid ][ pSkills ][ 2 ]);
		cache_get_value_name_int(0, "skill3"	, PlayerInfo[ playerid ][ pSkills ][ 3 ]);
		cache_get_value_name_int(0, "skill4"	, PlayerInfo[ playerid ][ pSkills ][ 4 ]);
		cache_get_value_name_int(0, "skill5"	, PlayerInfo[ playerid ][ pSkills ][ 5 ]);
		cache_get_value_name_int(0, "skill6"	, PlayerInfo[ playerid ][ pSkills ][ 6 ]);
		cache_get_value_name_int(0, "skill7"	, PlayerInfo[ playerid ][ pSkills ][ 7 ]);
		cache_get_value_name_int(0, "skill8"	, PlayerInfo[ playerid ][ pSkills ][ 8 ]);
		cache_get_value_name_int(0, "skill9"	, PlayerInfo[ playerid ][ pSkills ][ 9 ]);
	}
	return 1;
}

forward OnSkillsInsertQuery(playerid, sqlid);
public OnSkillsInsertQuery(playerid, sqlid)
{
	if(PlayerInfo[playerid][pSQLID] != sqlid)
		return 0;

	PlayerInfo[playerid][pSkillId] = cache_insert_id();
	return 1;
}

/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/
CMD:skills(playerid, params[])
{
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Maksimalni iznos skill pointova je 250.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "*_________________* SKILLS *_________________*");
	va_SendClientMessage(playerid, COLOR_RED, "Farmer (%d/%d, Level %d) | Pizza Boy (%d/%d, Level %d)",
		PlayerInfo[ playerid ][ pSkills ][ 0 ],
		(GetPlayerSkillLevel(playerid, 0) + 1) * 50,
		GetPlayerSkillLevel(playerid, 0),
		PlayerInfo[ playerid ][ pSkills ][ 1 ],	
		(GetPlayerSkillLevel(playerid, 1) + 1) * 50,		
		GetPlayerSkillLevel(playerid, 1)
	);
	va_SendClientMessage(playerid, COLOR_RED, "Smetlar (%d/%d, Level %d) | Tvornicki radnik (%d/%d, Level %d)", 
		PlayerInfo[ playerid ][ pSkills ][ 2 ],
		(GetPlayerSkillLevel(playerid, 2) + 1) * 50,
		GetPlayerSkillLevel(playerid, 2),
		PlayerInfo[ playerid ][ pSkills ][ 3 ],		
		(GetPlayerSkillLevel(playerid, 3) + 1) * 50,	
		GetPlayerSkillLevel(playerid, 3)
	);
	va_SendClientMessage(playerid, COLOR_RED, "Kosac trave (%d/%d, Level %d) | Lopov (%d/%d, Level %d)", 
		PlayerInfo[ playerid ][ pSkills ][ 4 ],
		(GetPlayerSkillLevel(playerid, 4) + 1) * 50,
		GetPlayerSkillLevel(playerid, 4),
		PlayerInfo[ playerid ][ pSkills ][ 5 ],	
		(GetPlayerSkillLevel(playerid, 5) + 1) * 50,		
		GetPlayerSkillLevel(playerid, 5)
	);
	va_SendClientMessage(playerid, COLOR_RED, "Jacker (%d/%d, Level %d) | Trucker (%d/%d, Level %d)", 
		PlayerInfo[ playerid ][ pSkills ][ 6 ],
		(GetPlayerSkillLevel(playerid, 6) + 1) * 50,
		GetPlayerSkillLevel(playerid, 6),
		PlayerInfo[ playerid ][ pSkills ][ 7 ],	
		(GetPlayerSkillLevel(playerid, 7) + 1) * 50,	
		GetPlayerSkillLevel(playerid, 7)
	);
	va_SendClientMessage(playerid, COLOR_RED, "Pilot (%d/%d, Level %d)", 
		PlayerInfo[ playerid ][ pSkills ][ 9 ],
		(GetPlayerSkillLevel(playerid, 9) + 1) * 50,
		GetPlayerSkillLevel(playerid, 9)
	);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "*____________________________________________*");
	return 1;
}

CMD:setskill(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
	new
		giveplayerid,
		skillid,
		value;
	if( sscanf( params, "uii",giveplayerid, skillid, value ) ){
		SendClientMessage(playerid, COLOR_RED, "USAGE: /setskill [playerid][skillid][points]");
		SendClientMessage(playerid, COLOR_RED, "[skillid]: Farmer - 0      PizzaBoy - 1    Cistac - 2");
		SendClientMessage(playerid, COLOR_RED, "[skillid]: Crafter - 3     Kosac - 4       Lopov - 5");
		SendClientMessage(playerid, COLOR_RED, "[skillid]: Jacker - 6		 Trucker - 7	 Drug Dealer - 8");
		SendClientMessage(playerid, COLOR_RED, "[skillid]: Pilot - 9");
		return 1;
	}
	if(skillid < 0 || skillid > 9) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pogresan skill id!");
	PlayerInfo[giveplayerid][pSkills][skillid] = value;
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili Skill poene %i igracu %s!", value, GetName(giveplayerid, false));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Uspjesno vam je postavljeno %d Skill Poena od Admina %s!", value, GetName(playerid, false));
	return 1;
}
