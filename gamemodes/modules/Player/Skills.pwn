#include <YSI_Coding\y_hooks>

const MAX_SKILLS 	= (MAX_JOBS - 1); // Because first Job ID in enumerator starts with 1, not 0.

enum E_SKILLS_INFO
{
	sSQLID,
	sJob,
	sSkill
}
new PlayerSkills[MAX_PLAYERS][E_SKILLS_INFO][MAX_SKILLS];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock ResetPlayerSkills(playerid)
{
	for(new i = 0; i < MAX_SKILLS; i++)
	{
    	PlayerSkills[playerid][sSQLID][i] = -1;
		PlayerSkills[playerid][sSkill][i] = 0;
		PlayerSkills[playerid][sJob][i]	  = 0;
	}
	return 1;
}

stock LoadPlayerSkills(playerid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM skill WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]), 
		"OnPlayerSkillsLoad", 
		"i", 
		playerid
	);
	return 1;
}

static stock ReturnSkillID(playerid)
{
	new 
		value = -1;
	for(new i = 0; i < MAX_SKILLS; i++)
	{
		if(PlayerSkills[playerid][sJob][i] == PlayerJob[playerid][pJob])
		{
			value = i;
			break;
		}
	}
	return value;
}

static stock CreatePlayerSkill(playerid)
{
	new value;
	for(new i = 0; i < MAX_SKILLS; i++)
	{
		if(PlayerSkills[playerid][sJob][i] == 0)
		{
			PlayerSkills[playerid][sJob][i] = PlayerJob[playerid][pJob];
			value = i;
			break;
		}
	}
	return value;
}

stock UpgradePlayerSkill(playerid, points = 1)
{
	new 
		skillid = ReturnSkillID(playerid);
	if(skillid == -1)
		skillid = CreatePlayerSkill(playerid);

	new 
		skill = 0;
	if(PlayerSkills[playerid][sSkill][skillid] == 49)
		skill = 1;
	else if(PlayerSkills[playerid][sSkill][skillid] == 99)
		skill = 2;
	else if(PlayerSkills[playerid][sSkill][skillid] == 149)
		skill = 3;
	else if(PlayerSkills[playerid][sSkill][skillid] == 199)
		skill = 4;
	else if(PlayerSkills[playerid][sSkill][skillid] == 249)
		skill = 5;
	if(skill > 0) {
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Your job skill level increased. Now it's %d, congratz!", skill);
	}
	PlayerSkills[playerid][sSkill][skillid] += points;
	if(PlayerSkills[playerid][sSkill][skillid] >= 250) 
		PlayerSkills[playerid][sSkill][skillid] = 250;
	
	SavePlayerSkill(playerid, skillid);

	Player_SetIsWorkingJob(playerid, false);
	return 1;
}

Public: OnPlayerSkillInsert(playerid, skillid)
{
	PlayerSkills[playerid][sSQLID][skillid] = cache_insert_id();
	return 1;
}

stock GetPlayerSkillLevel(playerid)
{
	new 
		skillid = ReturnSkillID(playerid);
	if(skillid == -1)
		return 0;

	new
		skilllevel = floatround((PlayerSkills[playerid][sSkill][skillid] / 50), floatround_floor);
	if(skilllevel == 0)
		skilllevel = 1;
	if(skilllevel >= 5)
		skilllevel = 5;
	return skilllevel;
}

static stock CreatePlayerSkills(playerid)
{
	for(new i = 0; i < MAX_SKILLS; i++)
	{
		mysql_tquery(g_SQL,
			"INSERT INTO skill(playerid, jobid, skill) VALUES('%d', '%d', '%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerSkills[playerid][sJob][i],
			PlayerSkills[playerid][sSkill][i],
			"OnPlayerSkillInsert",
			"ii",
			playerid,
			i
		);
	}
	return 1;
}

static stock SavePlayerSkill(playerid, skillid)
{
	if(PlayerSkills[playerid][sSQLID][skillid] != -1)
	{
		mysql_fquery(g_SQL,
			"UPDATE skill SET skill = '%d', jobid = '%d' WHERE id = '%d",
			PlayerSkills[playerid][sJob][skillid],
			PlayerSkills[playerid][sSkill][skillid],
			PlayerSkills[playerid][sSQLID][skillid]
		);
	}
	else
	{
		PlayerSkills[playerid][sJob][skillid] = PlayerJob[playerid][pJob];
		mysql_tquery(g_SQL,
			"INSERT INTO skill(playerid, jobid, skill) VALUES('%d', '%d', '%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerSkills[playerid][sJob][skillid],
			PlayerSkills[playerid][sSkill][skillid],
			"OnPlayerSkillInsert",
			"ii",
			playerid,
			skillid
		);
	}
	return 1;
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
	new rows = cache_num_rows();
	if(rows) 
	{
		for(new i = 0; i < MAX_SKILLS; i++)
		{
			cache_get_value_name_int(i, "id"	, PlayerSkills[playerid][sSQLID][i]);
			cache_get_value_name_int(i, "job"	, PlayerSkills[playerid][sJob][i]);
			cache_get_value_name_int(i, "skill"	, PlayerSkills[playerid][sSkill][i]);
		}
	}
	else return CreatePlayerSkills(playerid);
	return 1;
}

hook function LoadPlayerStats(playerid)
{
	LoadPlayerSkills(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
	ResetPlayerSkills(playerid);
	return continue(playerid);
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
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Maximal amount of skill points per skill is 250.");
	
	new 
		motd[64],
		dstring[512],
		bool:tabtag = false;

	for(new i = 0; i < MAX_SKILLS; i++)
	{
		if(PlayerSkills[playerid][sJob][i] == 0)
			continue;
			
		format(motd, 64,  "%s ID: %d | %s | (%d/%d, Level %d) %s", 
			(!tabtag) ? ("") : ("\n"), 
			i,
			ReturnJob(PlayerSkills[playerid][sJob][i]),
			PlayerSkills[playerid][sSkill][i],
			GetPlayerSkillLevel(playerid) * 50,
			GetPlayerSkillLevel(playerid),
			(i != (MAX_SKILLS-1)) ? ("\n") : ("")
		);
		strcat(dstring, motd, 512);
		tabtag = true;
	}
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "Acquired job skills", dstring, "Close", "");
	return 1;
}

CMD:setskill(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized for this command usage.");
	new
		giveplayerid,
		skillid,
		value;
		
	if(sscanf( params, "uii", giveplayerid, skillid, value ))
	{
		SendClientMessage(playerid, COLOR_RED, "WARNING: Because of the uniqueness of skill ID's, you MUST ask a player for skill ID!");
		SendClientMessage(playerid, COLOR_RED, "[?]: /setskill [playerid][skillid][points]");
		return 1;
	}
	if((skillid < 0 || skillid > MAX_SKILLS)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Wrong skill ID! Ask player again for a skill ID he wants to have adjusted!");
	if(PlayerSkills[playerid][sSQLID][skillid] == -1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Wrong skill ID! Ask player again for a skill ID he wants to have adjusted!");

	PlayerSkills[giveplayerid][sSkill][skillid] = value;
	SavePlayerSkill(giveplayerid, skillid);

	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "You've sucessfully set %d %s Skill Points to player %s!", 
		value,
		ReturnJob(PlayerSkills[giveplayerid][sJob][skillid]),
		GetName(giveplayerid, false)
	);

	va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Game Admin %s adjusted your %s Skill Points to %d(Level %d)!", 
		GetName(playerid, false),
		ReturnJob(PlayerSkills[giveplayerid][sJob][skillid]),
		value,
		GetPlayerSkillLevel(giveplayerid)
	);
	return 1;
}