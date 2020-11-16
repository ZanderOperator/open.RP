/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/

enum E_SKILL_TREE_DATA
{
	tName[ 12 ],
	tSkill1Name[ 15 ],
	tSkill2Name[ 15 ],
	tSkill3Name[ 15 ],
	tSkill4Name[ 15 ],
	tSkill5Name[ 15 ],
	tMaxValue
}
new
	TreeInfo[ ][ E_SKILL_TREE_DATA ] = {
		{ "Lopov", 	"Pickpocket", 	"Burglar", 	"Master Burglar", 	"Mugger", 			"Nista", 		45 },
		{ "Farmer", "Planter", 		"Milk Man", "Egg Picker", 		"Combine Driver",	"Transporter",  45 },
		{ "Jacker",	"Newbie", 		"Jacker", 	"Master Jacker", 	"Pro Elite", 		"Nista", 		45 },
		{ "Pilot",	"Newbie", 		"Jacker", 	"Nista", 	"Nista", 		"Nista", 		50 }
	};

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock GetSkillJobId(jobid)
{
	new
		index = 0;
	switch( jobid ) {
		case 6: index = 1;
		case 9: index = 0;
		case 13: index = 2;
		case 17: index = 3;
	}
	return index;
}

stock LoadPlayerSkills(playerid, jobid)
{
	new
		tmpQuery[ 128 ];
	format( tmpQuery, 128, "SELECT * FROM skills WHERE id = '%d' AND jobid = '%d'", PlayerInfo[ playerid ][ pSQLID ], jobid );
	mysql_pquery(g_SQL, tmpQuery, "OnPlayerSkillsLoad", "ii", playerid, jobid);
}

stock SavePlayerSkill(playerid)
{
	new
		jobid = GetSkillJobId(PlayerInfo[ playerid ][ pJob ]);
	if( !PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 0 ] ) {
		new
			tmpQuery[ 256 ];
		format(tmpQuery, 256, "INSERT INTO skills (id, jobid, skill1_value, skill2_value, skill3_value, skill4_value, skill5_value) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d')",
			PlayerInfo[ playerid ][ pSQLID ],
			jobid,
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 0 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 1 ],			
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 2 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 3 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 4 ]
		);
		mysql_tquery(g_SQL, tmpQuery, "");
	} else {
		new
			tmpQuery[ 256 ];
		format(tmpQuery, 256, "UPDATE skills SET skill1_value = '%d', skill2_value = '%d', skill3_value = '%d', skill4_value = '%d', skill5_value = '%d' WHERE id = '%d' AND jobid = '%d'",
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 0 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 1 ],			
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 2 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 3 ],
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 4 ],
			PlayerInfo[ playerid ][ pSQLID ],
			jobid
		);
		mysql_pquery(g_SQL, tmpQuery, "");
	}
	return 1;
}

stock DeletePlayerSkill(playerid, jobid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 0 ]	= 0;
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 1 ]	= 0;
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 2 ]	= 0;
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 3 ]	= 0;
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 4 ]	= 0;
		
	new
		tmpQuery[ 128 ];
	format( tmpQuery, 128, "DELETE * FROM skills WHERE id = '%d' AND jobid = '%d'", PlayerInfo[ playerid ][ pSQLID ], jobid );
	mysql_tquery(g_SQL, tmpQuery, "", "");
	return 1;
}

stock ResetPlayerSkills(playerid)
{
	PlayerInfo[ playerid ][ pSkillValue ][ 0 ][ 0 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 0 ][ 1 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 0 ][ 2 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 0 ][ 3 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 0 ][ 4 ] = 0;
	
	PlayerInfo[ playerid ][ pSkillValue ][ 1 ][ 0 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 1 ][ 1 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 1 ][ 2 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 1 ][ 3 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 1 ][ 4 ] = 0;
	
	PlayerInfo[ playerid ][ pSkillValue ][ 2 ][ 0 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 2 ][ 1 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 2 ][ 2 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 2 ][ 3 ] = 0;
	PlayerInfo[ playerid ][ pSkillValue ][ 2 ][ 4 ] = 0;
}

stock UpdatePlayerSkill(playerid, jobid, skillid, value=1)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	
	PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ skillid ] += value;
	if( PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ skillid ] >= TreeInfo[ jobid ][ tMaxValue ] ) {
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ skillid ] = 0;
		
		if( strcmp(TreeInfo[ jobid ][ tSkill5Name ], "Nista", true) ) {
			PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ (skillid+1) ] = 1;
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste povecali vas skill na %d!", (skillid + 2)); // Uneseni skill + skillup + jedan za prikaz
		}
	}
	//SavePlayerSkill(playerid);
	return 1;
}

stock GetPlayerSkill(playerid, jobid)
{
	new
		index = 0;
	for( new i = 0; i < 6; i++ ) {
		if( PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ index ] > 0 && PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ index ] < TreeInfo[ jobid ][ tMaxValue ] ) 
			index++;
	}
	return index;
}

stock GetSkillPoints(playerid, jobid, skillid)
{
	return PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ skillid ];
}

// Custom callbacks
forward OnPlayerSkillsLoad(playerid, jobid);
public OnPlayerSkillsLoad(playerid, jobid)
{
	if( cache_num_rows() ) {
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 0 ]	= cache_get_field_content_int(0, "skill1_value");
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 1 ]	= cache_get_field_content_int(0, "skill2_value");
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 2 ]	= cache_get_field_content_int(0, "skill3_value");
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 3 ]	= cache_get_field_content_int(0, "skill4_value");
		PlayerInfo[ playerid ][ pSkillValue ][ jobid ][ 4 ]	= cache_get_field_content_int(0, "skill5_value");			
	}
	return 1;
}