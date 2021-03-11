#include <YSI_Coding\y_hooks>

#define CAR_LICENSE_PRICE	1000
#define FLY_LICENSE_PRICE	3000
#define FISH_LICENSE_PRICE	800

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
	Bit1:gr_DrivingStarted<MAX_PLAYERS> = { Bit1:false, ... },
	Bit1:gr_TookDriving<MAX_PLAYERS> = { Bit1:false, ... },
	DrivingCP[MAX_PLAYERS] = { -1, ... },
	DrivingCPPos[MAX_PLAYERS] = { 0, ... },
	DrivingBoatCP[MAX_PLAYERS] = { -1, ... },
	Timer:DrivingTimer[MAX_PLAYERS];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock const Float:CarDrivingCP[8][3] = 
{
	{ 1746.5531, -1697.8358, 12.3721 },
	{ 1857.0297, -1754.7694, 12.3551 },
	{ 1927.3354, -1610.1016, 12.3758 },
	{ 1834.2618,-1609.7915,13.0312 	 },
	{ 1683.6436, -1590.5527, 12.3299 },
	{ 1526.9058, -1649.7567, 12.3502 },
	{ 1703.4657, -1734.7837, 12.3632 },
	{ 1751.8290, -1697.6012, 12.3721 }
};

stock const Float:BoatDrivingCP[8][3] = 
{
	{ 724.8758, -1915.6556, -0.0316 },
	{ 332.8357, -1975.4020, -0.0379 },
	{ -90.2559, -2027.6696, -0.1084 },
	{ 334.6657, -2473.1809, -0.1987 }, 
	{ 806.0511, -2425.4814, -0.1174 },
	{ 896.7186, -2053.1128, -0.0397 },
	{ 723.9417, -1763.8594, -0.0241 },
	{ 728.4023, -1508.5182, -0.0081 }
};

stock ResetPlayerDrivingVars(playerid)
{
	Bit1_Set( gr_DrivingStarted, 	playerid, false);
	Bit1_Set( gr_TookDriving, 		playerid, false);
	
	stop DrivingTimer[playerid];
	
	DrivingCP[playerid] 	= -1;
	DrivingCPPos[playerid] 	= -1;
	DrivingBoatCP[playerid] = -1;
	return 1;
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
timer OnPlayerDrivingLesson[1000](playerid)
{
	if(GetPlayerVehicleSpeed(playerid) >= 110.0) 
	{
		SendClientMessage( playerid, COLOR_RED, "[GRESKA]: Vozili ste preko 110km/h, pali ste vozacki!");
		
		DisablePlayerCheckpoint(playerid);
		stop DrivingTimer[playerid];
		
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		RemovePlayerFromVehicle(playerid);
		Bit1_Set( gr_DrivingStarted, playerid, false);
		Bit1_Set( gr_TookDriving, playerid, false);
	}
}

/*
																		
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'                                              
*/

LoadPlayerLicenses(playerid)
{
	inline LoadingPlayerLicenses()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(SQL_Handle(), 
				"INSERT INTO player_licenses(sqlid, carlic, gunlic, boatlic, fishlic, flylic, passport) \n\
					VALUES('%d', '0', '0', '0', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
		);
			return 1;
		}
		cache_get_value_name_int(0,  "carlic"		, LicenseInfo[playerid][pCarLic]);
		cache_get_value_name_int(0,  "gunlic"		, LicenseInfo[playerid][pGunLic]);
		cache_get_value_name_int(0,	 "boatlic"		, LicenseInfo[playerid][pBoatLic]);
		cache_get_value_name_int(0,	 "fishlic"		, LicenseInfo[playerid][pFishLic]);
		cache_get_value_name_int(0,	 "flylic"		, LicenseInfo[playerid][pFlyLic]);
		cache_get_value_name_int(0,  "passport"		, LicenseInfo[playerid][pPassport]);
		return 1;
	}
    MySQL_PQueryInline(SQL_Handle(),
		using inline LoadingPlayerLicenses, 
        va_fquery(SQL_Handle(), "SELECT * FROM player_licenses WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
   	);
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerLicenses(playerid);
	return continue(playerid);
}

SavePlayerLicenses(playerid)
{
    mysql_fquery_ex(SQL_Handle(),
        "UPDATE player_licenses SET carlic = '%d', gunlic = '%d', boatlic = '%d', fishlic = '%d', \n\
            flylic = '%d', passport = '%d' WHERE sqlid = '%d'",
        LicenseInfo[playerid][pCarLic],
        LicenseInfo[playerid][pGunLic],
        LicenseInfo[playerid][pBoatLic],
        LicenseInfo[playerid][pFishLic],
        LicenseInfo[playerid][pFlyLic],
        LicenseInfo[playerid][pPassport],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerLicenses(playerid);
	return continue(playerid);
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

hook function ResetPlayerVariables(playerid)
{
	ResetPlayerDrivingVars(playerid);
    LicenseInfo[playerid][pCarLic] = 0;
    LicenseInfo[playerid][pGunLic] = 0;
    LicenseInfo[playerid][pBoatLic] = 0;
    LicenseInfo[playerid][pFishLic] = 0;
    LicenseInfo[playerid][pFlyLic] = 0,
    LicenseInfo[playerid][pPassport] = 0;
	return continue(playerid);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vUsage] == VEHICLE_USAGE_LICENSE)
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 410) {
				if(LicenseInfo[playerid][pCarLic])	{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete vozacku dozvolu!");
					RemovePlayerFromVehicle(playerid);
				}
				else if(!Bit1_Get( gr_TookDriving, playerid)) {
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste uzeli papire u zgradi!");
					RemovePlayerFromVehicle(playerid);
				}
				else {
					ShowPlayerDialog( playerid, DIALOG_DRIVING_QUEST1, DIALOG_STYLE_LIST, "Sto trebate uciniti prije zaobilazenja vozila?", "Provjeriti retrovizore\nDati zmigavac i kreniti zaobilaziri\nSve gore navedeno", "Choose", "Abort");
					Bit1_Set( gr_DrivingStarted, playerid, true);
				}
			}
			else if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 446) 
			{
				if(LicenseInfo[playerid][pBoatLic]) 
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete dozvolu za brod!");
					RemovePlayerFromVehicle(playerid);
				}
				else 
				{					
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, BoatDrivingCP[0][0],BoatDrivingCP[0][1],BoatDrivingCP[0][2], 5.0);
					
					DrivingBoatCP[playerid] = 1;
					DrivingCPPos[playerid] 	= 1;
					Bit1_Set( gr_DrivingStarted, playerid, true);
				}
			}
		}
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(Bit1_Get( gr_DrivingStarted, playerid))
	{
		if(DrivingBoatCP[playerid] == 1)
		{
			new
				cp = DrivingCPPos[playerid];
				
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, BoatDrivingCP[cp][0],BoatDrivingCP[cp][1],BoatDrivingCP[cp][2], 5.0);
			DrivingCPPos[playerid]++;
			
			if(DrivingCPPos[playerid] == 8) 
			{
				DisablePlayerCheckpoint(playerid);
				
				DrivingCPPos[playerid] 	= 0;
				DrivingBoatCP[playerid] = 0;
				
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				RemovePlayerFromVehicle(playerid);
				SendClientMessage( playerid, COLOR_RED, "[!] Uspjesno ste polozili vozacku za brod!");
				LicenseInfo[playerid][pBoatLic] = 1;
				
				// MySQL query
				mysql_fquery(SQL_Handle(), "UPDATE player_licenses SET boatlic = '1' WHERE sqlid = '%d'",
					PlayerInfo[playerid][pSQLID]
				);
				
				Bit1_Set( gr_DrivingStarted, playerid, false);
				stop DrivingTimer[playerid];
			}
			return 1;
		}

		if(DrivingCP[playerid] == 1)
		{
			new
				cp = DrivingCPPos[playerid];
				
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, CarDrivingCP[cp][0],CarDrivingCP[cp][1],CarDrivingCP[cp][2], 5.0);
			DrivingCPPos[playerid]++;
			
			if(DrivingCPPos[playerid] == 8)
			{
				DisablePlayerCheckpoint(playerid);
				
				DrivingCPPos[playerid] 	= 0;
				DrivingCP[playerid] = 0;
				
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				RemovePlayerFromVehicle(playerid);
				SendClientMessage( playerid, COLOR_RED, "[!] Uspjesno ste polozili vozacku za automobil!");
				LicenseInfo[playerid][pCarLic] = 1;
				
				mysql_fquery(SQL_Handle(), "UPDATE player_licenses SET carlic = '1' WHERE sqlid = '%d'",
					PlayerInfo[playerid][pSQLID]
				);
				
				Bit1_Set( gr_DrivingStarted, playerid, false);
				stop DrivingTimer[playerid];			
			}
			return 1;
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(Bit1_Get( gr_DrivingStarted, playerid)) 
	{
		DisablePlayerCheckpoint(playerid);
		stop DrivingTimer[playerid];
		
		SetVehicleToRespawn(vehicleid);
		RemovePlayerFromVehicle(playerid);
		Bit1_Set( gr_DrivingStarted, playerid, false);
		Bit1_Set( gr_TookDriving, playerid, false);		
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pali ste vozacki. Ne smijete izlaziti iz vozila dok polazete!");
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid)
	{
		case DIALOG_DRIVING_QUEST1: 
		{
			if(!response) 
			{
				SendClientMessage( playerid, COLOR_RED, "[!] Izasli ste iz ispita za polaganje vozacke dozvole!");
				Bit1_Set( gr_DrivingStarted, playerid, false);
				return 1;
			}
			
			switch( listitem)
			{	
				case 0:
				{ // Gleda
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog( playerid, DIALOG_DRIVING_QUEST1, DIALOG_STYLE_LIST, "Sto trebate uciniti prije zaobilazenja vozila?", "Provjeriti retrovizore\nDati zmigavac i kreniti zaobilaziri\nSve gore navedeno", "Choose", "Abort");
				}
				case 1: 
				{ // Zmigavac	
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog( playerid, DIALOG_DRIVING_QUEST1, DIALOG_STYLE_LIST, "Sto trebate uciniti prije zaobilazenja vozila?", "Provjeriti retrovizore\nDati zmigavac i kreniti zaobilaziri\nSve gore navedeno", "Choose", "Abort");
				}
				case 2: 
				{ // Sve
					GameTextForPlayer( playerid, "~g~Tocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST2, DIALOG_STYLE_LIST, "Kolika je dozvoljena brzina u naseljenom podrucju?", "100kmh\n50kmh\n80kmh", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_DRIVING_QUEST2: 
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_DRIVING_QUEST1, DIALOG_STYLE_LIST, "Sto trebate uciniti prije zaobilazenja vozila?", "Provjeriti retrovizore\nDati zmigavac i kreniti zaobilaziri\nSve gore navedeno", "Choose", "Abort");
			
			switch( listitem)
			{
				case 0: 
				{ // 100kmh
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST2, DIALOG_STYLE_LIST, "Kolika je dozvoljena brzina u naseljenom podrucju?", "100kmh\n50kmh\n80kmh", "Choose", "Abort");
				}
				case 1: 
				{ // 50kmh
					GameTextForPlayer( playerid, "~g~Tocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST3, DIALOG_STYLE_LIST, "Ispred vas je parkiran skolski bus s upaljenim zmigavcima", "Zaobici ga s punim gasom\nStati\nZaobici ga s malom brzinom i paziti na djecu", "Choose", "Abort");
				}
				case 2: 
				{ // 80kmh
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST2, DIALOG_STYLE_LIST, "Kolika je dozvoljena brzina u naseljenom podrucju?", "100kmh\n50kmh\n80kmh", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_DRIVING_QUEST3:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST2, DIALOG_STYLE_LIST, "Kolika je dozvoljena brzina u naseljenom podrucju?", "100kmh\n50kmh\n80kmh", "Choose", "Abort");
			
			switch( listitem)
			{
				case 0: 
				{ // Puni gas
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST3, DIALOG_STYLE_LIST, "Ispred vas je parkiran skolski bus s upaljenim zmigavcima", "Zaobici ga s punim gasom\nStati\nZaobici ga s malom brzinom i paziti na djecu", "Choose", "Abort");						
				}
				case 1:
				{ // Stati
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST3, DIALOG_STYLE_LIST, "Ispred vas je parkiran skolski bus s upaljenim zmigavcima", "Zaobici ga s punim gasom\nStati\nZaobici ga s malom brzinom i paziti na djecu", "Choose", "Abort");						
				}
				case 2: 
				{ // Zaobici s oprezom
					GameTextForPlayer( playerid, "~g~Tocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST4, DIALOG_STYLE_LIST, "Kolika je dopustena brzina na autocesti?", "130kmh\n200kmh\nMa koliko ja hocu", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_DRIVING_QUEST4: 
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST3, DIALOG_STYLE_LIST, "Ispred vas je parkiran skolski bus s upaljenim zmigavcima", "Zaobici ga s punim gasom\nStati\nZaobici ga s malom brzinom i paziti na djecu", "Choose", "Abort");	
			
			switch( listitem)
			{
				case 0: 
				{ // 130kmh
					SendClientMessage( playerid, COLOR_RED, "[!] Tocan odgovor! Upalite vozilo i krenite prema checkpointima!");					
					SendClientMessage( playerid, COLOR_RED, "[!] Nemojte voziti preko 110kmh!");
										
					DisablePlayerCheckpoint(playerid);
					DrivingCP[playerid] = 1;
					SetPlayerCheckpoint(playerid, CarDrivingCP[0][0],CarDrivingCP[0][1],CarDrivingCP[0][2], 5.0);
					DrivingCPPos[playerid] = 1;
					Bit1_Set( gr_DrivingStarted, playerid, true);
					
					stop DrivingTimer[playerid];
					DrivingTimer[playerid] = repeat OnPlayerDrivingLesson(playerid);
				}
				case 1:
				{ // 200kmh
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST4, DIALOG_STYLE_LIST, "Kolika je dopustena brzina na autocesti?", "130kmh\n200kmh\nMa koliko ja hocu", "Choose", "Abort");
				}
				case 2: 
				{ // Koliko hocu
					GameTextForPlayer( playerid, "~r~Netocan odgovor!", 1800, 1);
					ShowPlayerDialog(playerid, DIALOG_DRIVING_QUEST4, DIALOG_STYLE_LIST, "Kolika je dopustena brzina na autocesti?", "130kmh\n200kmh\nMa koliko ja hocu", "Choose", "Abort");
				}
			}
			return 1;
		}
	}
	return 0;
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

CMD:takedriving(playerid, params[])
{
	if(LicenseInfo[playerid][pCarLic]) 		
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete vozacku dozvolu!");
	if(Bit1_Get( gr_DrivingStarted, playerid)) 	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec polazete vozacki!");
	if(AC_GetPlayerMoney(playerid) < CAR_LICENSE_PRICE) 		
		return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %s!", FormatNumber(CAR_LICENSE_PRICE));
	if(Bit1_Get( gr_TookDriving, playerid)) 		
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste uzeli papire i krenuli s polaganjem!");
	if(!IsPlayerInRangeOfPoint( playerid, 5.0, 1779.8975, -1721.5961, 12.5387)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu auto skole!");
	
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "~Uzeli ste papire za polaganje.~n~Idite u vozilo iza i krenite sa ispitom!");
	PlayerToBudgetMoney(playerid, CAR_LICENSE_PRICE);
	Bit1_Set( gr_TookDriving, playerid, true);
	return 1;
}

CMD:buylicenses(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, 1472.1774, -1613.3490, -70.3896)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vijecnici za salterom za licence!");
	
	new	pick[6];
	if(sscanf( params, "s[6]", pick)) 
		return SendClientMessage(playerid, COLOR_RED, "[?]: /buylicenses [fly/fish]");
	
	if(!strcmp( pick, "fly")) 
	{
		if(LicenseInfo[playerid][pFlyLic])			
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dozvolu za letenje!");
		if(AC_GetPlayerMoney(playerid) < FLY_LICENSE_PRICE)
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %d$!", FLY_LICENSE_PRICE);
		
		GameTextForPlayer(playerid, "~g~Kupljena dozvola za letenje!", 1500, 1);
		LicenseInfo[playerid][pFlyLic] = 1;
		PlayerToBudgetMoney(playerid, FLY_LICENSE_PRICE); // u proracun novci idu
		
		mysql_fquery(SQL_Handle(), "UPDATE player_licenses SET flylic = '1' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pSQLID]
		);		
	}
	else if(!strcmp( pick, "fish"))
	 {
		if(LicenseInfo[playerid][pFishLic])		
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dozvolu za ribolov!");
		if(AC_GetPlayerMoney(playerid) < FISH_LICENSE_PRICE) 	
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %d$!", FISH_LICENSE_PRICE);
		
		GameTextForPlayer(playerid, "~g~Kupljena dozvola za ribolov!", 1500, 1);
		LicenseInfo[playerid][pFishLic] = 1;
		PlayerToBudgetMoney(playerid, FISH_LICENSE_PRICE); // u proracun novci idu
		
		mysql_fquery(SQL_Handle(), "UPDATE player_licenses SET fishlic = '1' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pSQLID]
		);
	}
	return 1;
}
