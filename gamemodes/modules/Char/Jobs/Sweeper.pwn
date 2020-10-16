#include <YSI\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/
#define SWEEPER_ID      					(1) 	// ID posla smecara zamjeni sa kojim zelis

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
static stock
	Float:cleanerCP[][ 3 ] = {
		{ 1672.85193, -1871.20142, 12.37467 },
		{ 1691.91020, -1744.76290, 12.37520 },
		{ 1691.90430, -1604.21110, 12.37510 },
		{ 1809.75630, -1614.55110, 12.34180 },
		{ 1938.37630, -1617.93790, 12.37340 },
		{ 1959.24150, -1921.23240, 12.37190 },
		{ 1824.18540, -1886.49600, 12.22880 },
		{ 1852.93120, -1391.06420, 12.36120 },
		{ 1747.90770, -1160.70700, 22.61080 },
		{ 1369.69600, -1138.63700, 22.64450 },
		{ 1299.35250, -1536.81240, 12.35880 },
		{ 1294.96700, -1841.25050, 12.35030 },
		{ 1620.23240, -1882.50490, 12.54710 }
	};

stock IsVehicleASweep(id)
{
	if(GetVehicleModel(id) == 574)
	{
		return true;
	}
	return false;
}

new	PlayerCleanerCP[MAX_PLAYERS];
	
new
	Bit1: r_Sweeping<MAX_PLAYERS>			= { Bit1:false, ... };

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/
hook OnPlayerDisconnect(playerid, reason)
{
	PlayerCleanerCP[ playerid ] = 0;
    Bit1_Set( r_Sweeping, playerid, false );
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerInfo[playerid][pJob] == SWEEPER_ID) 
	{
		if( Bit1_Get( r_Sweeping, playerid ) && GPS_Active_Check(playerid)) 
		{
			new vID = GetPlayerVehicleID(playerid);
			if(!IsVehicleASweep(vID)) return SendClientMessage( playerid, COLOR_RED, "Ne cistite ulice sa Sweeperom!");
			DisablePlayerCheckpoint(playerid);
			PlayerCleanerCP[playerid]++;
			if( PlayerCleanerCP[playerid] == 13 ) {
				DisablePlayerCheckpoint(playerid);
				new 
					money = minrand(400, 450) + (GetPlayerSkillLevel(playerid, 2) * 25); 
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);

				BudgetToPlayerBankMoney(playerid, money); // dobiva novac na knjizicu iz proracuna
				PlayerInfo[playerid][pPayDayMoney] += money;
				UpgradePlayerSkill(playerid, 2);
				PlayerInfo[playerid][pFreeWorks] -= 5;
				Bit1_Set( r_Sweeping, playerid, false );
				Bit1_Set( gr_IsWorkingJob, playerid, false );
				TogglePlayerAllDynamicCPs(playerid, true);
				PlayerCleanerCP[playerid] = 0;
				
				foreach(new i : Houses) 
				{
					TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], true);
				}
				return 1;
			} else SetPlayerCheckpoint(playerid, cleanerCP[ PlayerCleanerCP[playerid] ][ 0 ], cleanerCP[ PlayerCleanerCP[playerid] ][ 1 ], cleanerCP[ PlayerCleanerCP[playerid] ][ 2 ], 6.0);
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
CMD:sweep(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != SWEEPER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni kao smecar!");
	new
		vehicleID = GetPlayerVehicleID(playerid),
		pick[ 8 ];
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage(playerid, -1, "[KORISTENJE]: /sweep [start/stop]");
	if (strcmp(pick, "start", true) == 0) {
		if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
		if( IsVehicleASweep(vehicleID) ) 
		{
			if( Bit1_Get( r_Sweeping, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste poceli sa poslom!");
			Bit1_Set( r_Sweeping, playerid, true );
			Bit1_Set( gr_IsWorkingJob, playerid, true );
			PlayerCleanerCP[playerid] = 0;
			
			DisablePlayerCheckpoint(playerid);
			foreach(new i : Houses) 
			{
				TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], false);
			}
			SetPlayerCheckpoint(playerid, cleanerCP[ 0 ][ 0 ], cleanerCP[ 0 ][ 1 ], cleanerCP[ 0 ][ 2 ], 6.0 );
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Poceli ste sa poslom! Vas cilj je prolazenje kroz checkpointe i ciscenje grada!");
		}
		else 
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar vozila za ciscenje!");
	}
	else if (strcmp(pick, "stop", true) == 0) 
	{
		if( IsVehicleASweep(vehicleID) ) 
		{
			if(VehicleInfo[ vehicleID ][ vJob ] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nije za ovaj posao!");
			if( !Bit1_Get( r_Sweeping, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste poceli sa poslom!");

			PlayerInfo[playerid][pFreeWorks] -= 5;
			Bit1_Set( r_Sweeping, playerid, false );
			Bit1_Set( gr_IsWorkingJob, playerid, false );
			TogglePlayerAllDynamicCPs(playerid, true);
			DisablePlayerCheckpoint(playerid);
			
			foreach(new i : Houses) 
			{
				TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], true);
			}
			SetVehicleToRespawn( vehicleID );
		}
		else 
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar vozila za ciscenje!");
	}
	else
	    SendClientMessage(playerid, -1, "[KORISTENJE]: /sweep [start/stop]");
	return 1;
}