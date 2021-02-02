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
/////////////////////////////////////////////////////////////
#define MAX_RENTS       				(10)
#define RENT_POS                        1079.2101, -1386.8029, 12.8189
#define MAX_RENT_LIST					(16)
/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
/////////////////////////////////////////////////////////////
enum E_RENT_VEHICLE_DATA
{
	rvName[14+1],
	rvModel,
	rvPrice
}
static stock 
	RentVehInfo[][E_RENT_VEHICLE_DATA] = {
		{"Savanna", 		567, 200},
		{"Bravura", 		401, 130},
		{"Perennial", 		404, 150},
		{"Manana", 			410, 120},
		{"Bobcat", 			422, 150},
		{"Previon", 		436, 120},
		{"Solair", 			458, 150},
		{"Tahoma", 			566, 180},
		{"Yosemite", 		554, 200},
		{"Stallion", 		439 ,160},
		{"Glendale",		466, 130},
		{"Burrito",			482, 250},
		{"Virgo", 			491, 130},
		{"Williard",		529, 130},
		{"Landstalker",		400, 200},
		{"Faggio",			462, 100}
};

static 
	bool:rentedVehicle[MAX_PLAYERS],
	bool:locatedRentedVeh[MAX_PLAYERS],
	_RentPrice[MAX_PLAYERS] = 0,
	rentedVehID[MAX_PLAYERS];

new Float:RandomVehicleRentSpawn[3][4] =
{
	{1084.9158, -1370.0908, 13.6000},
	{1084.9158, -1376.1683, 13.6000},
	{1084.9158, -1382.2687, 13.6000}
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
/////////////////////////////////////////////////////////////
Player_RentVehicle(playerid)
{
	return rentedVehID[playerid];
}


Player_SetRentVehicle(playerid, vehicleid)
{
	rentedVehID[playerid] = vehicleid;
}

hook function AC_DestroyVehicle(vehicleid)
{
	if(VehicleInfo[vehicleid][vUsage] == 5) // VEHICLE_USAGE_RENT
	{
		foreach(new i: Player)
		{
			if(Player_RentVehicle(i) == vehicleid)
			{
				rentedVehicle[i] = false;
				Player_SetRentVehicle(i, INVALID_VEHICLE_ID);
			}
		}
	}
	return continue(vehicleid);
}

stock static PlayerRentVehicle(playerid, modelid, price)
{
	new rvPos = random(sizeof(RandomVehicleRentSpawn)),
		color1 = random(6),
		color2 = random(6);
	
	new vehicleid = AC_CreateVehicle(modelid, RandomVehicleRentSpawn[rvPos][0], RandomVehicleRentSpawn[rvPos][1], RandomVehicleRentSpawn[rvPos][2], RandomVehicleRentSpawn[rvPos][3], random(6), random(6), -1, 0);
	rentedVehicle[playerid] = true;
	Player_SetRentVehicle(playerid, vehicleid);

	VehicleInfo[vehicleid][vModel]				= modelid;
	VehicleInfo[vehicleid][vParkX]				= RandomVehicleRentSpawn[rvPos][0];
	VehicleInfo[vehicleid][vParkY]				= RandomVehicleRentSpawn[rvPos][1];
	VehicleInfo[vehicleid][vParkZ]				= RandomVehicleRentSpawn[rvPos][2];
	VehicleInfo[vehicleid][vAngle]				= RandomVehicleRentSpawn[rvPos][3];

	VehicleInfo[vehicleid][vUsage]				= VEHICLE_USAGE_RENT;
	VehicleInfo[vehicleid][vColor1]				= color1;
	VehicleInfo[vehicleid][vColor2]				= color2;
	VehicleInfo[vehicleid][vInt]				= GetPlayerInterior(playerid);
	VehicleInfo[vehicleid][vViwo]				= GetPlayerVirtualWorld(playerid);
	
	VehicleInfo[vehicleid][vFuel] 				= 100;
	VehicleInfo[vehicleid][vCanStart]       	= 1;
	VehicleInfo[vehicleid][vParts]          	= 0;
	VehicleInfo[vehicleid][vTimesDestroy]		= 0;
	VehicleInfo[vehicleid][vUsage] 				= 5;
	VehicleInfo[vehicleid][vEngineRunning]		= 0;
	
	Vehicle_Add(VEHICLE_USAGE_RENT, vehicleid);

	PlayerToBusinessMoneyTAX(playerid, 76, price); // TODO: ???
	
	new tmpString[15], buffer[70], vehName[32];
	strunpack(vehName, Model_Name(modelid));
	format(tmpString, sizeof(tmpString), "~r~-$%d", price);
	format(buffer, sizeof(buffer), "[!] Uspjesno ste rentali vozilo pod imenom %s za %s.", vehName, FormatNumber(price));
	
	SendClientMessage(playerid, COLOR_RED, buffer);
	GameTextForPlayer(playerid, tmpString, 5000, 1);
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
/////////////////////////////////////////////////////////////

hook OnPlayerDisconnect(playerid, reason)
{
	if(rentedVehicle[playerid] == true)
 		AC_DestroyVehicle(Player_RentVehicle(playerid));

	Player_SetRentVehicle(playerid, INVALID_VEHICLE_ID);
	rentedVehicle[playerid] 	= false;
	locatedRentedVeh[playerid] 	= false;
	return 1;
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
	if((fselectid == ms_RENTCARS && response)) 
	{
		new 
			index = Player_ModelToIndex(playerid, modelid),
			price = RentVehInfo[index][rvPrice],
			multiple = _RentPrice[playerid];

		price *= _RentPrice[playerid];
		if(PlayerVIP[playerid][pDonateRank] == 0)
			price = RentVehInfo[index][rvPrice] * multiple;
		else if	(PlayerVIP[playerid][pDonateRank] == PREMIUM_BRONZE)
			price = RentVehInfo[index][rvPrice] * multiple / 4;
		else if	(PlayerVIP[playerid][pDonateRank] == PREMIUM_SILVER)
			price = RentVehInfo[index][rvPrice] * multiple / 2;
		else if	(PlayerVIP[playerid][pDonateRank] >= PREMIUM_GOLD)
			price = 0;
			
		if(AC_GetPlayerMoney(playerid) < price) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Rent ovog vozila kosta %s!", FormatNumber(price));
		PlayerRentVehicle(playerid, RentVehInfo[index][rvModel], price);	
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_RENT_V:
		{
		    if(!response) return SendMessage(playerid, MESSAGE_TYPE_INFO, "Ponistili ste rent vozila!");

			new price = RentVehInfo[listitem][rvPrice],
				multiple = _RentPrice[playerid];
			price *= _RentPrice[playerid];
			if(PlayerVIP[playerid][pDonateRank] == 0)
				price = RentVehInfo[listitem][rvPrice] * multiple;
			else if	(PlayerVIP[playerid][pDonateRank] == PREMIUM_BRONZE)
				price = RentVehInfo[listitem][rvPrice] * multiple / 4;
			else if	(PlayerVIP[playerid][pDonateRank] == PREMIUM_SILVER)
				price = RentVehInfo[listitem][rvPrice] * multiple / 2;
			else if	(PlayerVIP[playerid][pDonateRank] >= PREMIUM_GOLD)
				price = 0;
			
			if(AC_GetPlayerMoney(playerid) < price) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Rent ovog vozila kosta %d$!", price);
			PlayerRentVehicle(playerid, RentVehInfo[listitem][rvModel], price);	
	    }
	}
	return 0;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	foreach (new playerid : Player)
	{
		if(rentedVehicle[playerid]) 
		{
			if(Player_RentVehicle(playerid) == vehicleid) 
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unistili ste rentano vozilo i kaznjeni ste s 250$ kazne!");
				PlayerToBusinessMoneyTAX(playerid, 76, 250); // TODO: ???
				
				DestroyFarmerObjects(playerid);
				AC_DestroyVehicle(Player_RentVehicle(playerid));
				
				rentedVehicle[playerid] 	= false;
				Player_SetRentVehicle(playerid, INVALID_VEHICLE_ID);
			}
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
/////////////////////////////////
CMD:rentveh(playerid, params[])
{
	new param[9];
	if(sscanf(params, "s[9] ", param))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /rentveh [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: take, locate, giveback, trunk");
		return 1;
	}
	if(!strcmp(param, "take", true)) 
	{
		if(!IsPlayerInRangeOfPoint(playerid, 7.5, RENT_POS)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za rentanje vozila!");
		if(rentedVehicle[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste iznajmili vozilo kucajte /rentveh locate");
		
		/*// Get Price by Level - novo by L3o.
		switch(PlayerInfo[playerid][pLevel]) {
			case 1..3: get_price = 1; 
			case 4..7: get_price = 2; 
			case 8..15: get_price = 3; 
			case 16..99: get_price = 5; 
		}*/
		_RentPrice[playerid] = 1;
		
		for(new i = 0; i < sizeof(RentVehInfo); i++) 
		{
			fselection_add_item(playerid, RentVehInfo[i][rvModel]);
			Player_ModelToIndexSet(playerid, i, RentVehInfo[i][rvModel]);
		}
		fselection_show(playerid, ms_RENTCARS, "Rent Vehicle");
	}
	else if(!strcmp(param, "locate", true))
	{
		if(Player_IsWorkingJob(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
		if(gStartedWork[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete to koristiti dok radite!");
	    if(locatedRentedVeh[playerid] == false)
		{
			new rvID = Player_RentVehicle(playerid);
			if(rvID == INVALID_VEHICLE_ID) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste iznajmili vozilo!");
		    new 
				Float:rPositions[3];
		    locatedRentedVeh[playerid] = true;
		    GetVehiclePos(rvID, rPositions[0], rPositions[1], rPositions[2]);
			SetPlayerCheckpoint(playerid, rPositions[0], rPositions[1], rPositions[2], 3.5);
			GameTextForPlayer(playerid, "~g~gps online", 2000, 1);
	    }
	    else if(locatedRentedVeh[playerid] == true)
	    {
			if(rentedVehicle[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste iznajmili vozilo!");
		    locatedRentedVeh[playerid] = false;
		    DisablePlayerCheckpoint(playerid);
		    GameTextForPlayer(playerid, "~r~gps offline", 2000, 1);
	    }
	}
	else if(!strcmp(param, "giveback", true))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 7.5, RENT_POS)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za rentanje vozila!");
		if(rentedVehicle[playerid] == false) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste iznajmili vozilo!");
		if(GetPlayerVehicleID(playerid) != Player_RentVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti u iznajmljenom vozilu!");
		
		rentedVehicle[playerid] = false;
		AC_DestroyVehicle(Player_RentVehicle(playerid));
		Player_SetRentVehicle(playerid, INVALID_VEHICLE_ID);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili rentano vozilo!");
	}
	else if(!strcmp(param, "trunk", true))
	{
		new
			rent_vID = Player_RentVehicle(playerid),
			engine, lights, alarm, doors, bonnet, boot, objective;

		if(!IsPlayerInRangeOfVehicle(playerid, rent_vID, 5.0)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu svoga vozila!");
		if(IsVehicleWithoutTrunk(GetVehicleModel(rent_vID))) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema prtljaznik!");
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti na nogama da biste zatvorili/otvorili prtljaznik.");
		GetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, boot, objective);
		if(VehicleInfo[rent_vID][vTrunk] == VEHICLE_PARAMS_OFF) 
		{
			SetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
			VehicleInfo[rent_vID][vTrunk] = VEHICLE_PARAMS_ON;
			GameTextForPlayer(playerid, "~w~gepek otvoren", 1000, 3);
		}
		else if(VehicleInfo[rent_vID][vTrunk] == VEHICLE_PARAMS_ON) 
		{
			SetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
			VehicleInfo[rent_vID][vTrunk] = VEHICLE_PARAMS_OFF;
			GameTextForPlayer(playerid, "~w~gepek zatvoren", 1000, 3);
		}
	}
	return 1;
}

