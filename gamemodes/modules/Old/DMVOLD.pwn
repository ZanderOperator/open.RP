// www.cityofangels-roleplay.com - DMV system - by L3o | credits: Woo

#include <YSI_Coding\y_hooks>


#define DMV_VEHICLE_ID (589)
#define MAX_CITYDRIVE_KMH (100.00)
#define MAX_WARNINGS_DMV (3)
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (vars % enums % const stocks)
new
	driving_score[MAX_PLAYERS] = { 0, ... },
	cp_counter[MAX_PLAYERS] = { 0, ... },
	
	Float: dmv_carPos[MAX_PLAYERS][3],
	
	last_dmvCP[MAX_PLAYERS] = { -1, ... },
	dmv_CPtype[MAX_PLAYERS] = { -1, ... },
	DrivingTimer[MAX_PLAYERS];

enum {
	AUTO_LICENSE	   = (1),
	BOAT_LICENSE  	   = (2),
	
	CAR_LICENSE_PRICE  = 1000,
	FLY_LICENSE_PRICE  = 3000,
	FISH_LICENSE_PRICE = 800,
	BOAT_LICENSE_PRICE = 3000
};

stock const Float: DMV_CPpos[17][3] = { // Novi CPovi, by l3o
	{ 1109.8811,-1743.7841,13.0565 },
	{ 1173.0746,-1755.0004,13.0565 },
	{ 1172.6179,-1837.4406,13.0626 },
	{ 1304.9958,-1854.9711,13.0409 },
	{ 1385.4243,-1875.0121,13.0409 },
	{ 1391.3630,-1748.8843,13.0409 },
	{ 1531.1031,-1735.4325,13.0450 },
	{ 1806.2798,-1734.0183,13.0487 },
	{ 1818.6582,-1917.8270,13.0400 },
	{ 1946.1627,-1934.8297,13.0409 },
	{ 1959.2301,-2149.1995,13.0409 },
	{ 1713.2046,-2164.2073,14.4021 },
	{ 1532.7291,-1889.8275,13.3365 },
	{ 1383.4724,-1869.6642,13.0446 },
	{ 1198.0702,-1849.6559,13.0520 },
	{ 1182.2935,-1726.1703,13.0995 },
	{ 1113.1975,-1738.0474,13.1693 }
};

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (functions)
CreateDMVmap() { // map by leo
	CreateDynamicObject(970, 1158.73804, -1750.89319, 13.07934,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1162.89819, -1750.88367, 13.07934,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1154.57703, -1750.89319, 13.07934,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1143.05579, -1750.88086, 13.07934,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1147.21558, -1750.89307, 13.07934,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1141.00098, -1753.06238, 13.14050,   0.00000, 0.00000, 90.02477);
	CreateDynamicObject(970, 1164.94153, -1752.98560, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.93640, -1757.14124, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.93005, -1761.26184, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.92371, -1765.40198, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.91296, -1769.54236, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.94531, -1773.72461, 13.07100,   0.00000, 0.00000, 89.91130);
	CreateDynamicObject(970, 1164.92029, -1777.82593, 13.07100,   0.00000, 0.00000, 90.31734);
	CreateDynamicObject(970, 1164.95593, -1781.90796, 13.07100,   0.00000, 0.00000, 90.31734);
	CreateDynamicObject(970, 1140.99805, -1757.19165, 13.14050,   0.00000, 0.00000, 90.02477);
	CreateDynamicObject(1280, 1147.41516, -1751.34778, 12.95630,   0.00000, 0.00000, 89.47321);
	CreateDynamicObject(1280, 1142.39734, -1751.27502, 12.95630,   0.00000, 0.00000, 90.07923);
	CreateDynamicObject(1215, 1152.22461, -1750.94727, 13.16406,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(1215, 1149.50061, -1750.92188, 13.16406,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(673, 1140.57043, -1751.14221, 12.36978,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1289, 1159.96960, -1772.28748, 16.15930,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1289, 1160.97803, -1772.23340, 16.15930,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1289, 1160.47485, -1772.26038, 16.15930,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3861, 1163.35974, -1752.94861, 13.65870,   0.00000, 0.00000, 269.39120);
	CreateDynamicObject(19638, 1162.33374, -1751.88513, 13.30220,   0.00000, 0.00000, 359.69595);
	CreateDynamicObject(19638, 1162.95642, -1751.88440, 13.30220,   0.00000, 0.00000, 359.69595);
	CreateDynamicObject(19637, 1162.96008, -1752.74780, 13.30220,   0.00000, 0.00000, 359.69601);
	CreateDynamicObject(19637, 1162.33740, -1752.74854, 13.30220,   0.00000, 0.00000, 359.69601);
	CreateDynamicObject(19636, 1162.94568, -1753.63306, 13.30220,   0.00000, 0.00000, 359.69601);
	CreateDynamicObject(19636, 1162.32434, -1753.62708, 13.30220,   0.00000, 0.00000, 359.69601);
	CreateDynamicObject(19563, 1162.15466, -1754.28967, 13.30340,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19564, 1162.14624, -1754.12488, 13.30341,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2121, 1164.25732, -1753.73706, 12.94840,   0.00000, 0.00000, -105.00000);
	CreateDynamicObject(1776, 1149.57483, -1772.69800, 16.62108,   0.00000, 0.00000, 181.14873);
	CreateDynamicObject(1258, 1157.66394, -1751.32104, 13.18298,   0.00000, 0.00000, 359.68469);
	return (true);
}

ResetPlayerDrivingVars(playerid)
{
	DisablePlayerCheckpoint(playerid);
	Bit1_Set( gr_DrivingStarted, playerid, false);
	dmv_WarningsTD(playerid, false);
	KillTimer(DrivingTimer[playerid]);
	
	cp_counter[playerid] 	= -1;
	driving_score[playerid] = -1;
	dmv_warnings[playerid]  = -1;
	last_dmvCP[playerid] 	= -1;
	dmv_CPtype[playerid] 	= -1;
	dmv_carPos[playerid][0] = 0.0;
	dmv_carPos[playerid][1] = 0.0;
	dmv_carPos[playerid][2] = 0.0;
	return (true);
}

Public:OnPlayerDrivingLesson(playerid)
{
	if(!Bit1_Get(gr_DrivingStarted, playerid))
		return ResetPlayerDrivingVars(playerid);
	
	if( GetPlayerSpeed(playerid,true) >= MAX_CITYDRIVE_KMH ) {
		new buffer[64];
		dmv_warnings[playerid]++;
		va_SendClientMessage( playerid, COLOR_RED, "[DMV]: Prekoracili ste ogranicenje, dobili ste gresku. (%d / 3)", dmv_warnings[playerid]);
		
		format(buffer,sizeof(buffer),"~w~(DMV)_~y~%d / 3 warnings.", dmv_warnings[playerid]);
		PlayerTextDrawSetString(playerid, dmv_TDwarnings[playerid][0], buffer);
		if(dmv_warnings[playerid] == MAX_WARNINGS_DMV)
		{
			DisablePlayerCheckpoint(playerid);
			KillTimer(DrivingTimer[playerid]);
			
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			RemovePlayerFromVehicle(playerid);
			Bit1_Set( gr_DrivingStarted, playerid, false );
			TogglePlayerAllDynamicCPs(playerid, true);
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "[DMV]: Nazalost prekinuto vam je polaganje zbog previse gresaka.");
		}
	}
	return (true);
}

saveDMV_License(playerid, license_id)
{
	new query[80];
	switch(license_id) {
		case 0: {
			PlayerInfo[ playerid ][ pCarLic ] = 1;
			format(query, sizeof(query), "UPDATE `accounts` SET `carlic` = '1' WHERE `sqlid` = '%d'",PlayerInfo[playerid][pSQLID]);
		}
		
		case 1: {
			PlayerInfo[ playerid ][ pBoatLic ] = 1;
			format(query, sizeof(query), "UPDATE `accounts` SET `boatlic` = '1' WHERE `sqlid` = '%d'",PlayerInfo[playerid][pSQLID]);
		}
		
		case 2: {
			PlayerInfo[playerid][pFlyLic] = 1;
			format(query, sizeof(query), "UPDATE `accounts` SET `flylic` = '1' WHERE `sqlid` = '%d'",PlayerInfo[playerid][pSQLID]);
		}
		
		case 3: {
			PlayerInfo[playerid][pFishLic] = 1;
			format(query, sizeof(query), "UPDATE `accounts` SET `fishlic` = '1' WHERE `sqlid` = '%d'",PlayerInfo[playerid][pSQLID]);
		}
	}
	return mysql_pquery(g_SQL, query);
}

dmv_WarningsTD(playerid, bool:status)
{	
	if(status == false) {
		PlayerTextDrawHide(playerid, dmv_TDwarnings[playerid][0]);
		dmv_TDwarnings[playerid][0] = PlayerText:INVALID_TEXT_DRAW;
	}
	else if(status == true) {
		dmv_TDwarnings[playerid][0] = CreatePlayerTextDraw(playerid, 321.333984, 410.838531, "");
		PlayerTextDrawLetterSize(playerid, dmv_TDwarnings[playerid][0], 0.123666, 1.110517);
		PlayerTextDrawAlignment(playerid, dmv_TDwarnings[playerid][0], 2);
		PlayerTextDrawColor(playerid, dmv_TDwarnings[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, dmv_TDwarnings[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, dmv_TDwarnings[playerid][0], 255);
		PlayerTextDrawFont(playerid, dmv_TDwarnings[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, dmv_TDwarnings[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, dmv_TDwarnings[playerid][0], 0);
		PlayerTextDrawShow(playerid, dmv_TDwarnings[playerid][0]);
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hook)
hook OnGameModeInit() {
	CreateDMVmap();
	return (true);
}

hook OnPlayerDisconnect(playerid, reason) {
	ResetPlayerDrivingVars(playerid);
	return (true);
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	if( Bit1_Get( gr_DrivingStarted, playerid ) ) {
		SetVehicleToRespawn(vehicleid);
		RemovePlayerFromVehicle(playerid);
		ResetPlayerDrivingVars(playerid);
		
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Automatski vam je prekinuto polaganje jer ste izasli iz vozila.");
	}
	return (true);
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
	if( oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER )
	{
		if( VehicleInfo[ GetPlayerVehicleID(playerid) ][ vUsage ] == VEHICLE_USAGE_LICENSE )
		{
			if( GetVehicleModel(GetPlayerVehicleID(playerid)) == DMV_VEHICLE_ID ) {
				if( PlayerInfo[ playerid ][ pCarLic ] )	{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete vozacku dozvolu!");
					RemovePlayerFromVehicle(playerid);
				}
				else if(driving_score[playerid] == 0) {
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste polozili ispit za voznju!");
					RemovePlayerFromVehicle(playerid);
				}
				else {
					new
						Float: X, Float: Y, Float: Z;
					GetPlayerPos(playerid, X, Y, Z);
					dmv_carPos[playerid][0] = X;
					dmv_carPos[playerid][1] = Y;
					dmv_carPos[playerid][2] = Z;
					ShowPlayerDialog(playerid, DIALOG_DMV_START, DIALOG_STYLE_MSGBOX, "{3C95C2}DMV - Start", "\nZelite li zapoceti sa gradskom voznjom?\nPrije nego sto zapocnete moramo vas napomeniti da nakon\nsto dobijete tri greske(ili izadete iz vozila) automatski vam se prekida polaganje.\n \n{3C95C2}[!] - Moguce greske:\n- (1). Ne vezanje pojasa/paljenje svijetla pri pocetku voznje.\n- (2). Prekoracanje brzine u nasaljenim mjestima (70km/h).\n- (3). Ostecenje vozila.", "(ok)", "");
					return (true);
				}
			}
		}
	}
	return (true);
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if( Bit1_Get( gr_DrivingStarted, playerid ) ) { 
		if(dmv_CPtype[playerid] == AUTO_LICENSE) {
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, DMV_CPpos[cp_counter[playerid]][0],DMV_CPpos[cp_counter[playerid]][1],DMV_CPpos[cp_counter[playerid]][2], 5.0);
			cp_counter[playerid]++;
				
			if(cp_counter[playerid] == 17) {
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, dmv_carPos[playerid][0],dmv_carPos[playerid][1],dmv_carPos[playerid][2], 5.0);
				cp_counter[playerid] = -1;
				dmv_CPtype[playerid] = 0;
					
				ShowPlayerDialog(playerid, DIALOG_DMV_END, DIALOG_STYLE_MSGBOX, "{3C95C2}DMV - End", "\nUspijesno ste zavrsili gradsku voznju, prije nego sto dobijete rezultate\nmorate vratiti vozilo na mjesto gdje ste ga uzeli.", "(ok)", "");
			}
		}
	}
	if(last_dmvCP[playerid] == 1) {
		DisablePlayerCheckpoint(playerid);
			
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		RemovePlayerFromVehicle(playerid);
								
		SendClientMessage( playerid, COLOR_GREEN, "[DMV]: Uspjesno ste polozili vozacku za automobil. Cestitamo.");
		saveDMV_License(playerid, (0));
							
		Bit1_Set( gr_DrivingStarted, playerid, false );
		KillTimer(DrivingTimer[playerid]);
							
		TogglePlayerAllDynamicCPs(playerid, true);
		ResetPlayerDrivingVars(playerid);
	}
	return (true);
}


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch( dialogid )
	{
		case DIALOG_DMV_END: {
			if(response) return last_dmvCP[playerid] = 1;
			if(!response) return last_dmvCP[playerid] = 1;	
			dmv_WarningsTD(playerid, false);
		}
		case DIALOG_DMV_START: {
			if(response)
			{
				new buffer[64];
				dmv_warnings[playerid]  = 0;
				
				Bit1_Set( gr_DrivingStarted, playerid, true );
				cp_counter[playerid] = 0;
				dmv_CPtype[playerid] = AUTO_LICENSE;
				
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, DMV_CPpos[cp_counter[playerid]][0], DMV_CPpos[cp_counter[playerid]][1], DMV_CPpos[cp_counter[playerid]][2], 5.0);
				DrivingTimer[playerid] = SetTimerEx("OnPlayerDrivingLesson", 1000, (true), "i", playerid);
				dmv_WarningsTD(playerid, true);
				
				format(buffer,sizeof(buffer),"~w~(DMV)_~y~%d / 3 warnings.", dmv_warnings[playerid]);
				PlayerTextDrawSetString(playerid, dmv_TDwarnings[playerid][0], buffer);
				
				SendClientMessage(playerid, COLOR_RED, "[ ! ] [DMV]: Uspijesno ste zapoceli sa gradskom voznjom, pratite markere.");
			}
		}
		case DIALOG_DMV_LICENSE: {
		switch( listitem ) {
				case 0: {
					if( PlayerInfo[ playerid ][ pCarLic ] ) 		
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete vozacku dozvolu!");
					if( Bit1_Get( gr_DrivingStarted, playerid ) ) 	
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec polazete vozacki!");
					if( AC_GetPlayerMoney(playerid) < CAR_LICENSE_PRICE ) 		
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 1.000$!");
						
					ShowPlayerDialog( playerid,DIALOG_DMV_Q1, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(1/7).","{3C95C2}[!] Kojom stranom se vozi u Los Santosu?\n \n{3C95C2}[A] - Lijevom.\n{3C95C2}[B] - Desnom.","Select","Close");	
					driving_score[playerid] = 0;
					PlayerToBudgetMoney(playerid, CAR_LICENSE_PRICE); // u proracun novci idu
				}
				case 1: {
					if( PlayerInfo[playerid][pFlyLic] )	
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dozvolu za letenje!");
					if( AC_GetPlayerMoney(playerid) < FLY_LICENSE_PRICE ) 
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %d$!", FLY_LICENSE_PRICE );
						
					GameTextForPlayer(playerid, "~g~Kupljena dozvola za letenje!", 1500, 1);
					saveDMV_License(playerid, (2));
					PlayerToBudgetMoney(playerid, FLY_LICENSE_PRICE); // u proracun novci idu
					
				}
				case 2: {
					if( PlayerInfo[playerid][pFishLic] ) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dozvolu za ribolov!");
					if( AC_GetPlayerMoney(playerid) < FISH_LICENSE_PRICE ) 	
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %d$!", FISH_LICENSE_PRICE );
						
					GameTextForPlayer(playerid, "~g~Kupljena dozvola za ribolov!", 1500, 1);
					saveDMV_License(playerid, (3));
					PlayerToBudgetMoney(playerid, FISH_LICENSE_PRICE); // u proracun novci idu
					
				}
				case 3: {
					if( PlayerInfo[playerid][pBoatLic] )	
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dozvolu za plovidbu!");
					if( AC_GetPlayerMoney(playerid) < FLY_LICENSE_PRICE ) 
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %d$!", BOAT_LICENSE_PRICE );
						
					GameTextForPlayer(playerid, "~g~Kupljena dozvola za plovidbu!", 1500, 1);
					saveDMV_License(playerid, (1));
					PlayerToBudgetMoney(playerid, BOAT_LICENSE_PRICE); // u proracun novci idu
				}
			}
		}
		case DIALOG_DMV_Q1: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q1, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(1/7).","{3C95C2}[!] Kojom stranom se vozi u Los Santosu?\n \n{3C95C2}[A] - Lijevom.\n{3C95C2}[B] - Desnom.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q1, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(1/7).","{3C95C2}[!] Kojom stranom se vozi u Los Santosu?\n \n{3C95C2}[A] - Lijevom.\n{3C95C2}[B] - Desnom.","Select","Close");	
				case 2: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q2, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(2/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'naseljenim' mjestima?\n \n{3C95C2}[A] - 70km/h.\n{3C95C2}[B] - 100km/h.","Select","Close");	
				case 3: {
					ShowPlayerDialog( playerid,DIALOG_DMV_Q2, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(2/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'naseljenim' mjestima?\n \n{3C95C2}[A] - 70km/h.\n{3C95C2}[B] - 100km/h.","Select","Close");	
					driving_score[playerid]++;
				}
			}
		}
		case DIALOG_DMV_Q2: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q2, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(2/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'naseljenim' mjestima?\n \n{3C95C2}[A] - 70km/h.\n{3C95C2}[B] - 100km/h.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q2, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(2/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'naseljenim' mjestima?\n \n{3C95C2}[A] - 70km/h.\n{3C95C2}[B] - 100km/h.","Select","Close");	
				case 2: {
					ShowPlayerDialog( playerid,DIALOG_DMV_Q3, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(3/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'ne naseljenim' mjestima?\n \n{3C95C2}[A] - 130km/h.\n{3C95C2}[B] - 90km/h.","Select","Close");	
					driving_score[playerid]++;
				}
				case 3: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q3, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(3/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'ne naseljenim' mjestima?\n \n{3C95C2}[A] - 130km/h.\n{3C95C2}[B] - 90km/h.","Select","Close");	
			}
		}
		case DIALOG_DMV_Q3: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q3, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(3/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'ne naseljenim' mjestima?\n \n{3C95C2}[A] - 130km/h.\n{3C95C2}[B] - 90km/h.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q3, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(3/7).","{3C95C2}[!] Kolika je dozvoljena brzina u 'ne naseljenim' mjestima?\n \n{3C95C2}[A] - 130km/h.\n{3C95C2}[B] - 90km/h.","Select","Close");
				case 2: {
					ShowPlayerDialog( playerid,DIALOG_DMV_Q4, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(4/7).","{3C95C2}[!] Sta znaci crveno svijetlo na semaforu?\n \n{3C95C2}[A] - Da mozete krenut.\n{3C95C2}[B] - Da morate stati i pricekati za zeleno.","Select","Close");	
					driving_score[playerid]++;
				}
				case 3: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q4, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(4/7).","{3C95C2}[!] Sta znaci crveno svijetlo na semaforu?\n \n{3C95C2}[A] - Da mozete krenut.\n{3C95C2}[B] - Da morate stati i pricekati za zeleno.","Select","Close");		
			}
		}
		case DIALOG_DMV_Q4: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q4, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(4/7).","{3C95C2}[!] Sta znaci crveno svijetlo na semaforu?\n \n{3C95C2}[A] - Da mozete krenut.\n{3C95C2}[B] - Da morate stati i pricekati za zeleno.","Select","Close");
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q4, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(4/7).","{3C95C2}[!] Sta znaci crveno svijetlo na semaforu?\n \n{3C95C2}[A] - Da mozete krenut.\n{3C95C2}[B] - Da morate stati i pricekati za zeleno.","Select","Close");
				case 2: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q5, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(5/7).","{3C95C2}[!] Ukoliko napravite nesrecu, sta cete napraviti?\n \n{3C95C2}[A] - Pozvati policiju i bolnicare.\n{3C95C2}[B] - Pokusat pobijeci kako bi izbjegao kaznu.","Select","Close");			
				case 3: { 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q5, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(5/7).","{3C95C2}[!] Ukoliko napravite nesrecu, sta cete napraviti?\n \n{3C95C2}[A] - Pozvati policiju i bolnicare.\n{3C95C2}[B] - Pokusat pobijeci kako bi izbjegao kaznu.","Select","Close");		
					driving_score[playerid]++;
				}
			}
		}
		case DIALOG_DMV_Q5: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q5, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(5/7).","{3C95C2}[!] Ukoliko napravite nesrecu, sta cete napraviti?\n \n{3C95C2}[A] - Pozvati policiju i bolnicare.\n{3C95C2}[B] - Pokusat pobijeci kako bi izbjegao kaznu.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q5, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(5/7).","{3C95C2}[!] Ukoliko napravite nesrecu, sta cete napraviti?\n \n{3C95C2}[A] - Pozvati policiju i bolnicare.\n{3C95C2}[B] - Pokusat pobijeci kako bi izbjegao kaznu.","Select","Close");	
				case 2: {
					ShowPlayerDialog( playerid,DIALOG_DMV_Q6, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(6/7).","{3C95C2}[!] Sto trebate uciniti prije zaobilazenja vozila?\n \n{3C95C2}[A] - Provjeriti retrovizore.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti\n{3C95C2}[C] - Sve gore navedeno.","Select","Close");			
					driving_score[playerid]++;
				}
				case 3: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q6, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(6/7).","{3C95C2}[!] Sto trebate uciniti prije zaobilazenja vozila?\n \n{3C95C2}[A] - Provjeriti retrovizore.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti\n{3C95C2}[C] - Sve gore navedeno.","Select","Close");	
			}
		}
		case DIALOG_DMV_Q6: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q6, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(6/7).","{3C95C2}[!] Sto trebate uciniti prije zaobilazenja vozila?\n \n{3C95C2}[A] - Provjeriti retrovizore.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti\n{3C95C2}[C] - Sve gore navedeno.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q6, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(6/7).","{3C95C2}[!] Sto trebate uciniti prije zaobilazenja vozila?\n \n{3C95C2}[A] - Provjeriti retrovizore.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti\n{3C95C2}[C] - Sve gore navedeno.","Select","Close");	
				case 2: // A
					ShowPlayerDialog( playerid,DIALOG_DMV_Q7, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(7/7).","{3C95C2}[!] Ispred vas je parkiran skolski bus s upaljenim zmigavcima?\n \n{3C95C2}[A] - Proletiti punim gasom pored bus-a.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti.\n{3C95C2}[C] - Trubiti i psovati vozacu autobusa da se pomakne.","Select","Close");			
				case 3: // B
					ShowPlayerDialog( playerid,DIALOG_DMV_Q7, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(7/7).","{3C95C2}[!] Ispred vas je parkiran skolski bus s upaljenim zmigavcima?\n \n{3C95C2}[A] - Proletiti punim gasom pored bus-a.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti.\n{3C95C2}[C] - Trubiti i psovati vozacu autobusa da se pomakne.","Select","Close");	
				case 4: { // C
					ShowPlayerDialog( playerid,DIALOG_DMV_Q7, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(7/7).","{3C95C2}[!] Ispred vas je parkiran skolski bus s upaljenim zmigavcima?\n \n{3C95C2}[A] - Proletiti punim gasom pored bus-a.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti.\n{3C95C2}[C] - Trubiti i psovati vozacu autobusa da se pomakne.","Select","Close");	
					driving_score[playerid]++;
				}
			}
		}
		case DIALOG_DMV_Q7: {
		switch( listitem ) {
				case 0: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q7, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(7/7).","{3C95C2}[!] Ispred vas je parkiran skolski bus s upaljenim zmigavcima?\n \n{3C95C2}[A] - Proletiti punim gasom pored bus-a.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti.\n{3C95C2}[C] - Trubiti i psovati vozacu autobusa da se pomakne.","Select","Close");	
				case 1: 
					ShowPlayerDialog( playerid,DIALOG_DMV_Q7, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Test(7/7).","{3C95C2}[!] Ispred vas je parkiran skolski bus s upaljenim zmigavcima?\n \n{3C95C2}[A] - Proletiti punim gasom pored bus-a.\n{3C95C2}[B] - Dati zmigavac i kreniti zaobilaziti.\n{3C95C2}[C] - Trubiti i psovati vozacu autobusa da se pomakne.","Select","Close");
				case 2: {
					if(driving_score[playerid] > 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspijesno ste prosli ispite(%d/7), sada otidjite na parking i...", driving_score[playerid]);
						va_SendClientMessage(playerid, COLOR_RED, "udjite u neko od vozila kako bi zapoceli test gradske voznje.");
					}
					else if(driving_score[playerid] < 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Nazalost imali ste premalo bodova(%d/7) i niste uspijeli proci ispit.", driving_score[playerid]);
						driving_score[playerid] = 0;
					}
				}
				case 3: {
					driving_score[playerid]++;
					if(driving_score[playerid] > 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspijesno ste prosli ispite(%d/7), sada otidjite na parking udjite...", driving_score[playerid]);
						va_SendClientMessage(playerid, COLOR_RED, "u neko od vozila kako bi zapoceli test gradske voznje.");
					}
					else if(driving_score[playerid] < 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Nazalost imali ste premalo bodova(%d/7) i niste uspijeli proci ispit.", driving_score[playerid]);
						driving_score[playerid] = 0;
					}
				}
				case 4: {
					if(driving_score[playerid] > 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspijesno ste prosli ispite(%d/7), sada otidjite na parking i...", driving_score[playerid]);
						va_SendClientMessage(playerid, COLOR_RED, "udjite u neko od vozila kako bi zapoceli test gradske voznje.");
					}
					else if(driving_score[playerid] < 5) {
						SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Nazalost imali ste premalo bodova(%d/7) i niste uspijeli proci ispit.", driving_score[playerid]);
						driving_score[playerid] = 0;
					}
				}
			}
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)

CMD:license(playerid, params[]) {
	if( !IsPlayerInRangeOfPoint( playerid, 3.0, -2033.0352,-117.5965,1035.1719 ) ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u auto skoli.");
		
	ShowPlayerDialog( playerid,DIALOG_DMV_LICENSE, DIALOG_STYLE_LIST,"{3C95C2}* DMV - Category","{3C95C2}[1] - Dozvola za automobil.\n{3C95C2}[2] - Dozvola za letenje.\n{3C95C2}[3] - Dozvola za ribolov.\n{3C95C2}[4] - Dozvola za plovljenje.","Select","Close");
	return (true);
}
