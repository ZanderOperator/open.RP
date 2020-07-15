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
/////////////////////////////////////////////////////////////
#define MAX_RENTS       				(10)
#define RENT_POS                        1079.2101, -1386.8029, 12.8189
#define MAX_RENT_LIST					(16)
#define MODEL_SELECTION_RENTCARS		(314)
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

new bool:rentedVehicle[MAX_PLAYERS],
	bool:locatedRentedVeh[MAX_PLAYERS],
	_RentPrice[MAX_PLAYERS] = 0;

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
stock DestroyRentVehicle(vehicleid)
{
	ResetVehicleInfo(vehicleid);
	AC_DestroyVehicle(vehicleid);
	foreach(new i: Player)
	{
		if(rentedVehID[i] == vehicleid)
		{
			rentedVehicle[i] = false;
			rentedVehID[i] = INVALID_VEHICLE_ID;
		}
	}
	return 1;
}

stock static PlayerRentVehicle(playerid, modelid, price)
{
	new rvPos = random(sizeof(RandomVehicleRentSpawn)),
		color1 = random(6),
		color2 = random(6);
	rentedVehID[playerid] = AC_CreateVehicle(modelid, RandomVehicleRentSpawn[rvPos][0], RandomVehicleRentSpawn[rvPos][1], RandomVehicleRentSpawn[rvPos][2], RandomVehicleRentSpawn[rvPos][3], random(6), random(6), -1, 0);
	ResetVehicleInfo(rentedVehID[playerid]);
	rentedVehicle[playerid] = true;

	VehicleInfo[ rentedVehID[playerid] ][ vModel ]				= modelid;
	VehicleInfo[ rentedVehID[playerid] ][ vParkX ]				= RandomVehicleRentSpawn[rvPos][0];
	VehicleInfo[ rentedVehID[playerid] ][ vParkY ]				= RandomVehicleRentSpawn[rvPos][1];
	VehicleInfo[ rentedVehID[playerid] ][ vParkZ ]				= RandomVehicleRentSpawn[rvPos][2];
	VehicleInfo[ rentedVehID[playerid] ][ vAngle ]				= RandomVehicleRentSpawn[rvPos][3];
	VehicleInfo[ rentedVehID[playerid] ][ vColor1 ]				= color1;
	VehicleInfo[ rentedVehID[playerid] ][ vColor2 ]				= color2;
	VehicleInfo[ rentedVehID[playerid] ][ vInt ]				= GetPlayerInterior(playerid);
	VehicleInfo[ rentedVehID[playerid] ][ vViwo ]				= GetPlayerVirtualWorld(playerid);
	
	VehicleInfo[ rentedVehID[playerid] ][ vFuel ] 				= 100;
	VehicleInfo[ rentedVehID[playerid] ][ vCanStart ]       	= 1;
	VehicleInfo[ rentedVehID[playerid] ][ vParts ]          	= 0;
	VehicleInfo[ rentedVehID[playerid] ][ vTimesDestroy ]		= 0;
	VehicleInfo[ rentedVehID[playerid] ][ vUsage ] 				= 5;
	VehicleInfo[ rentedVehID[playerid] ][ vEngineRunning ]		= 0;
	

	PlayerToBusinessMoneyTAX(playerid, 76, price); // Novac ide u biznis 76
	
	new tmpString[15], buffer[70], vehName[32];
	strunpack(vehName, Model_Name(modelid));
	format(tmpString, sizeof(tmpString), "~r~-$%d", price);
	format(buffer, sizeof(buffer), "[ ! ] Uspjesno ste rentali vozilo pod imenom %s za %s.", vehName, FormatNumber(price));
	
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
	{
 		AC_DestroyVehicle(rentedVehID[playerid]);
	}
	rentedVehicle[playerid] = false;
	rentedVehID[playerid] = -1;
	locatedRentedVeh[playerid] = false;
	return 1;
}

hook OnModelSelResponse( playerid, extraid, index, modelid, response ) {
	if ((extraid == MODEL_SELECTION_RENTCARS && response)) {
		new price = RentVehInfo[index][rvPrice],
			multiple = _RentPrice[playerid];
		price *= _RentPrice[playerid];
		if(PlayerInfo[playerid][pDonateRank] == 0)
			price = RentVehInfo[index][rvPrice] * multiple;
		else if	(PlayerInfo[playerid][pDonateRank] == 1)
			price = RentVehInfo[index][rvPrice] * multiple / 4;
		else if	(PlayerInfo[playerid][pDonateRank] == 2)
			price = RentVehInfo[index][rvPrice] * multiple / 2;
		else if	(PlayerInfo[playerid][pDonateRank] == 3 || PlayerInfo[playerid][pDonateRank] == 4)
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
			if(PlayerInfo[playerid][pDonateRank] == 0)
				price = RentVehInfo[listitem][rvPrice] * multiple;
			else if	(PlayerInfo[playerid][pDonateRank] == 1)
				price = RentVehInfo[listitem][rvPrice] * multiple / 4;
			else if	(PlayerInfo[playerid][pDonateRank] == 2)
				price = RentVehInfo[listitem][rvPrice] * multiple / 2;
			else if	(PlayerInfo[playerid][pDonateRank] == 3 || PlayerInfo[playerid][pDonateRank] == 4)
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
		if( rentedVehicle[playerid] ) {
			if( vehicleid == rentedVehID[playerid] ) {
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unistili ste rentano vozilo i kaznjeni ste s 250$ kazne!");
				PlayerToBusinessMoneyTAX(playerid, 76, 250);// Novac ide u biznis 76
				
				DestroyFarmerObjects(playerid);
				ResetVehicleInfo( rentedVehID[playerid] );
				AC_DestroyVehicle(rentedVehID[playerid]);
				
				rentedVehicle[playerid] 	= false;
				rentedVehID[playerid] 		= -1;
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
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rentveh [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: take, locate, giveback, trunk");
		return 1;
	}
	if (!strcmp(param, "take", true)) {
		new rented_vehicles[MAX_RENT_LIST], rented_vehprice[MAX_RENT_LIST];//, get_price;
		
		if( !IsPlayerInRangeOfPoint(playerid, 7.5, RENT_POS)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za rentanje vozila!");
		if( rentedVehicle[playerid] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste iznajmili vozilo kucajte /rentveh locate");
		
		/*// Get Price by Level - novo by L3o.
		switch(PlayerInfo[playerid][pLevel]) {
			case 1..3: get_price = 1; 
			case 4..7: get_price = 2; 
			case 8..15: get_price = 3; 
			case 16..99: get_price = 5; 
		}*/
		_RentPrice[playerid] = 1;
		
		for(new i = 0; i < sizeof(RentVehInfo); i++) {
			rented_vehicles[i] = RentVehInfo[i][rvModel];
			rented_vehprice[i] = RentVehInfo[i][rvPrice];//*get_price;
		}
		ShowModelESelectionMenu(playerid, "Rent Vehicle", MODEL_SELECTION_RENTCARS, rented_vehicles, MAX_RENT_LIST, -16.0, 0.0, -55.0, 0.9, 1, true, rented_vehprice);	
	}
	else if(!strcmp(param, "locate", true))
	{
		if(Bit1_Get(gr_IsWorkingJob, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
		if(gStartedWork[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete to koristiti dok radite!");
	    if(locatedRentedVeh[playerid] == false)
		{
			if(rentedVehicle[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste iznajmili vozilo!");
		    new rvID = rentedVehID[playerid], Float:rPositions[3];
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
		    SendClientMessage(playerid, COLOR_RED, "Ugasili ste gps");
		    GameTextForPlayer(playerid, "~r~gps offline", 2000, 1);
	    }
	}
	else if(!strcmp(param, "giveback", true))
	{
		if( !IsPlayerInRangeOfPoint(playerid, 7.5, RENT_POS)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za rentanje vozila!");
		if(rentedVehicle[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi niste iznajmili vozilo!");
		if(GetPlayerVehicleID(playerid) != rentedVehID[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti u iznajmljenom vozilu!");
		
		rentedVehicle[playerid] = false;
		ResetVehicleInfo( rentedVehID[playerid] );
		AC_DestroyVehicle(rentedVehID[playerid]);
		rentedVehID[playerid] = INVALID_VEHICLE_ID;
		GameTextForPlayer(playerid, "~g~Vraceno rentano vozilo", 1000, 1);
	}
	else if(!strcmp(param, "trunk", true))
	{
		new
			Float:X, Float:Y, Float:Z,
			rent_vID = rentedVehID[playerid],
			engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehiclePos(rent_vID, X, Y, Z);

		if( !IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu svoga vozila!");
		if(IsANoTrunkVehicle(GetVehicleModel(rent_vID))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema prtljaznik!");
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti na nogama da biste zatvorili/otvorili prtljaznik.");
		GetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, boot, objective);
		if(VehicleInfo[rent_vID][vTrunk] == VEHICLE_PARAMS_OFF) {
			SetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
			VehicleInfo[rent_vID][vTrunk] = VEHICLE_PARAMS_ON;
			GameTextForPlayer(playerid, "~w~gepek otvoren", 1000, 3);
		}
		else if(VehicleInfo[rent_vID][vTrunk] == VEHICLE_PARAMS_ON) {
			SetVehicleParamsEx(rent_vID, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
			VehicleInfo[rent_vID][vTrunk] = VEHICLE_PARAMS_OFF;
			GameTextForPlayer(playerid, "~w~gepek zatvoren", 1000, 3);
		}
	}
	return 1;
}

