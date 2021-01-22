#include <YSI_Coding\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ###### 
*/
enum E_LAST_CP_DATA
{
	lcpLastCP,
	bool:lcpIsDynCP,
	Float:lcpPosX,
	Float:lcpPosY,
	Float:lcpPosZ,
	Float:lcpSize,
	lcpViwo,
	lcpInt,
	Float:lcpStreamDst,
	lcpAreaId,
	lcpPriority
}
static stock
	LastCPInfo[MAX_PLAYERS][E_LAST_CP_DATA];


/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock static GetPlayerFromCP(checkpointid)
{
	foreach(new playerid : Player)
	{
		if(LastCPInfo[playerid][lcpLastCP] != 0 && LastCPInfo[playerid][lcpLastCP] == checkpointid)
			return playerid;
	}
	return INVALID_PLAYER_ID;
}

stock static ResetPlayerCheckpoints(playerid)
{
	if(playerid == INVALID_PLAYER_ID) 			return 0;
	if(LastCPInfo[playerid][lcpLastCP] == 0) 	return 0;
	if(LastCPInfo[playerid][lcpIsDynCP]) 
	{
		if(IsValidDynamicCP(LastCPInfo[playerid][lcpLastCP]))
			DestroyDynamicCP(LastCPInfo[playerid][lcpLastCP]);
	}
	else
		DisablePlayerCheckpoint(playerid);
	
	LastCPInfo[playerid][lcpLastCP]		= 0;
	LastCPInfo[playerid][lcpIsDynCP] 	= false;
	LastCPInfo[playerid][lcpPosX] 		= 0.0;
	LastCPInfo[playerid][lcpPosY] 		= 0.0;
	LastCPInfo[playerid][lcpPosZ] 		= 0.0;
	LastCPInfo[playerid][lcpSize] 		= 0.0;
	LastCPInfo[playerid][lcpViwo] 		= 0;
	LastCPInfo[playerid][lcpInt] 		= 0;
	LastCPInfo[playerid][lcpStreamDst] 	= -1;
	LastCPInfo[playerid][lcpAreaId] 	= -1;
	LastCPInfo[playerid][lcpPriority] 	= -1;
	TogglePlayerAllDynamicCPs(playerid, false);
	Streamer_Update(playerid);
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
stock H_SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size)
{
	ResetPlayerCheckpoints(playerid);
	if(playerid == INVALID_PLAYER_ID) return 0;
	if(LastCPInfo[playerid][lcpIsDynCP]) 
	{
		if(IsValidDynamicCP(LastCPInfo[playerid][lcpLastCP]))
			DestroyDynamicCP(LastCPInfo[playerid][lcpLastCP]);
	}
	
	TogglePlayerAllDynamicCPs(playerid, false);
	TogglePlayerAllDynamicRaceCPs(playerid, false);

	LastCPInfo[playerid][lcpLastCP]		= minrand(1000, 9999);
	LastCPInfo[playerid][lcpIsDynCP] 	= false;
	LastCPInfo[playerid][lcpPosX] 		= x;
	LastCPInfo[playerid][lcpPosY] 		= y;
	LastCPInfo[playerid][lcpPosZ] 		= z;
	LastCPInfo[playerid][lcpSize] 		= size;
	LastCPInfo[playerid][lcpViwo] 		= -1;
	LastCPInfo[playerid][lcpInt] 		= -1;
	LastCPInfo[playerid][lcpStreamDst] 	= -1;
	LastCPInfo[playerid][lcpAreaId] 	= -1;
	LastCPInfo[playerid][lcpPriority] 	= -1;
	
	SetPlayerCheckpoint(playerid, x, y, z, size);
	return 1;
}
#if defined _ALS_SetPlayerCheckpoint
	#undef SetPlayerCheckpoint
#else
#define _ALS_SetPlayerCheckpoint
#endif
#define SetPlayerCheckpoint H_SetPlayerCheckpoint

stock H_DisablePlayerCheckpoint(playerid)
{
	if(playerid == INVALID_PLAYER_ID) 			return 0;
	if(LastCPInfo[playerid][lcpLastCP] == 0) 	return 0;
	if(LastCPInfo[playerid][lcpIsDynCP]) 		return 0;
	
	TogglePlayerAllDynamicCPs(playerid, true);
	TogglePlayerAllDynamicRaceCPs(playerid, true);

	LastCPInfo[playerid][lcpLastCP]		= 0;
	LastCPInfo[playerid][lcpIsDynCP] 	= false;
	LastCPInfo[playerid][lcpPosX] 		= 0.0;
	LastCPInfo[playerid][lcpPosY] 		= 0.0;
	LastCPInfo[playerid][lcpPosZ] 		= 0.0;
	LastCPInfo[playerid][lcpSize] 		= 0.0;
	LastCPInfo[playerid][lcpViwo] 		= 0;
	LastCPInfo[playerid][lcpInt] 		= 0;
	LastCPInfo[playerid][lcpStreamDst] 	= -1;
	LastCPInfo[playerid][lcpAreaId] 	= -1;
	LastCPInfo[playerid][lcpPriority] 	= -1;
	
	DisablePlayerCheckpoint(playerid);
	return 1;
}
#if defined _ALS_DisablePlayerCheckpoint
	#undef DisablePlayerCheckpoint
#else
#define _ALS_DisablePlayerCheckpoint
#endif
#define DisablePlayerCheckpoint H_DisablePlayerCheckpoint

stock H_CreateDynamicCP(Float:x, Float:y, Float:z, Float:size, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_CP_SD, areaid = -1, priority = 0)
{
	if(playerid != -1)
		ResetPlayerCheckpoints(playerid);
	if(playerid == INVALID_PLAYER_ID || playerid == -1) return CreateDynamicCP(x, y, z, size, worldid, interiorid, playerid, streamdistance, areaid, priority);
	if(LastCPInfo[playerid][lcpLastCP] != 0)
	{
		if(LastCPInfo[playerid][lcpIsDynCP] == true)
		{
			if(IsValidDynamicCP(LastCPInfo[playerid][lcpLastCP]))
				DestroyDynamicCP(LastCPInfo[playerid][lcpLastCP]);
		}
		else
			DisablePlayerCheckpoint(playerid);
	}
	TogglePlayerAllDynamicCPs(playerid, true);
	LastCPInfo[playerid][lcpLastCP]		= CreateDynamicCP(x, y, z, size, worldid, interiorid, playerid, streamdistance, areaid, priority);
	LastCPInfo[playerid][lcpIsDynCP] 	= true;
	LastCPInfo[playerid][lcpPosX] 		= x;
	LastCPInfo[playerid][lcpPosY] 		= y;
	LastCPInfo[playerid][lcpPosZ] 		= z;
	LastCPInfo[playerid][lcpSize] 		= size;
	LastCPInfo[playerid][lcpViwo] 		= worldid;
	LastCPInfo[playerid][lcpInt] 		= interiorid;
	LastCPInfo[playerid][lcpStreamDst] 	= streamdistance;
	LastCPInfo[playerid][lcpAreaId] 	= areaid;
	LastCPInfo[playerid][lcpPriority] 	= priority;
	
	Streamer_Update(playerid);
	return LastCPInfo[playerid][lcpLastCP];
}
#if defined _ALS_CreateDynamicCP
	#undef CreateDynamicCP
#else
#define _ALS_CreateDynamicCP
#endif
#define CreateDynamicCP H_CreateDynamicCP

stock H_DestroyDynamicCP(checkpointid)
{
	if(!IsValidDynamicCP(checkpointid)) return 0;
	new playerid = GetPlayerFromCP(checkpointid);
	if(playerid == INVALID_PLAYER_ID) 	return 0;
	
	LastCPInfo[playerid][lcpLastCP]		= 0;
	LastCPInfo[playerid][lcpIsDynCP] 	= false;
	LastCPInfo[playerid][lcpPosX] 		= 0.0;
	LastCPInfo[playerid][lcpPosY] 		= 0.0;
	LastCPInfo[playerid][lcpPosZ] 		= 0.0;
	LastCPInfo[playerid][lcpSize] 		= 0.0;
	LastCPInfo[playerid][lcpViwo] 		= 0;
	LastCPInfo[playerid][lcpInt] 		= 0;
	LastCPInfo[playerid][lcpStreamDst] 	= -1;
	LastCPInfo[playerid][lcpAreaId] 	= -1;
	LastCPInfo[playerid][lcpPriority] 	= -1;	
	
	DestroyDynamicCP(checkpointid);
	Streamer_Update(playerid);
	return 1;
}
#if defined _ALS_DestroyDynamicCP
	#undef DestroyDynamicCP
#else
#define _ALS_DestroyDynamicCP
#endif
#define DestroyDynamicCP H_DestroyDynamicCP

hook OnPlayerDisconnect(playerid, reason)
{
	ResetPlayerCheckpoints(playerid);
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

CMD:resetcp(playerid, params[])
{	
	if(LastCPInfo[playerid][lcpLastCP] == 0) return SendClientMessage(playerid, COLOR_RED, "Nemate aktivne CPove!");
	if(!LastCPInfo[playerid][lcpIsDynCP])
	{
		SetPlayerCheckpoint(playerid, LastCPInfo[playerid][lcpPosX], LastCPInfo[playerid][lcpPosY], LastCPInfo[playerid][lcpPosZ], LastCPInfo[playerid][lcpSize]);
	} 
	else 
	{
		if(!IsValidDynamicCP(LastCPInfo[playerid][lcpLastCP])) return 1;
		Streamer_SetFloatData(STREAMER_TYPE_CP, LastCPInfo[playerid][lcpLastCP], E_STREAMER_X, LastCPInfo[playerid][lcpPosX]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, LastCPInfo[playerid][lcpLastCP], E_STREAMER_Y, LastCPInfo[playerid][lcpPosY]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, LastCPInfo[playerid][lcpLastCP], E_STREAMER_Z, LastCPInfo[playerid][lcpPosZ]);
		Streamer_Update(playerid);
	}
	SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste resetirali svoje checkpointove!");
	return 1;
}