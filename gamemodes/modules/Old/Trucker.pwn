/*
	UPDATE BY L3O
	Mullholand ZIP, Ganton Binco, Ganton Gym = Skill 0
	Verona Mall, East LS Car Wash, Idlewood Car Wash = 200
	LS bla bla = 400
	- Fixan abuse.
*/

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
 #define TRUCKER_ID				(15)
 #define PRODUCT_PRICE			(20)
 #define UTOVAR 				(1)
 #define ISTOVAR 				(2)
 #define TRAILER_OIL 			(1)
 #define TRAILER_HEAVY 			(2)
 #define TRAILER_FREEZER 		(3)
 #define TRAILER_CONSTRUCTION	(4)
 #define TRAILER_FRAGILE 		(5)
/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/
new Text3D:TrailerText[11];

new last_route[MAX_PLAYERS];
new TruckerTrailer[11];
new TruckerDeliveryTimer[MAX_PLAYERS];

enum TRUCKER_INFO
{
	tStarted,
	Float:tUtovarCPx,
	Float:tUtovarCPy,
	Float:tUtovarCPz,
	Float:tIstovarCPx,
	Float:tIstovarCPy,
	Float:tIstovarCPz,
	tTrailerModel,
	tDeliveryBiz,
	tDeliveryType,
	tDeliveryTime,
	tDeliveryDetails,
	tPayCheck,
	tJobName[64]
};
new TruckerInfo[MAX_PLAYERS][TRUCKER_INFO];

enum { // leo - novo
	DEFUALT_TRUCKER_JOB	= 300,
	MEDIUM_TRUCKER_JOB = 500,
	BEST_TRUCKER_JOB = 700,
	
	TRUCKER_SKILL_DEFUALT = 0,
	TRUCKER_SKILL_MEDIUM = 1,
	TRUCKER_SKILL_BEST = 2
};

enum TruckerCPInfo {
	Float:trX,
	Float:trY,
	Float:trZ
};

new TruckerCPInfos[][TruckerCPInfo] =
{
	//*****************************ISTOVAR********************************
    {2247.7141,	-1725.4420,	13.5469}, 		// LS GYM GANTON (0)
    {2623.3962, -2207.1013, 13.5469},		// LS CONSTRUCTION CO (1)
    {2040.0056, -1413.6522, 17.1641},       // LS MEDIC (2)
    {2510.3635, -1467.8199,	24.0245},		// EAST CAR WASH (3)
    {1916.6219, -1789.4966, 13.3906},		// IDLEWOOD CAR WASH (4)
    {2077.6182, -2045.6045, 13.5469},		// LS MECHANIC PARTS (5)
    {2253.0657, -1664.8781, 15.4690},		// LS GANTON BINCO (6)
    {1439.3265, -1153.4375, 23.6550},		// VINEWOOD ZIP (7)
    {1062.3550, -1477.4865, 13.2735},		// HRANA VERONA (8)
    {1066.6494, -1458.4073, 13.2799},		// PICE VERONA (9)
    {1053.2849, -1515.3918, 13.2844},		// OBUCA/ODJECA VERONA (10)
    {1045.6860, -1548.8009, 13.2760},		// PRIBOR ZA HRANU/POSUDJE VERONA (11)
	{1188.4537, -1473.6782, 13.2739},		// MOBITELI VERONA (12)
    //*****************************UTOVAR********************************
    {307.3925,  -241.4779,  1.3052},		// UTOVAR 1 Blueberry (13)
   	{804.6757,	-607.4324,	15.9112},  		//BLUEBERRY
    {804.6757,	-607.4324,	15.9112},		// UTOVAR 3 Blueberry fabrika (15)
    {245.4177, 	1371.7611, 	10.3130},		// UTOVAR 4 FORT CARSON RAFINJERIJA (16)
	{579.0739,  1219.2950,  11.4387},		// UTOVAR 5 FORT CARSON FARMA (17)
	{2524.1489, 2820.5950, 	10.5474},		// UTOVAR 6 VOJNA BAZA (18)
	{1919.7749, 174.9691, 	37.0054},		// UTOVAR 7 DILIMORE FARMA ( 19)
	{-1012.9489, -694.7842, 31.7349},		// UTOVAR 8 FABRIKA LS-SF ( 20)
	{2671.0930, -1474.0356, 30.5656}		// FABRIKA U EAST LS ( 21)


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

stock ResetTruckerInfo(playerid)
{
	TruckerInfo[playerid][tStarted] = 0;
	TruckerInfo[playerid][tPayCheck] = 0;
	TruckerInfo[playerid][tUtovarCPx] = 0.0;
	TruckerInfo[playerid][tUtovarCPy] = 0.0;
	TruckerInfo[playerid][tUtovarCPz] = 0.0;
	TruckerInfo[playerid][tIstovarCPx] = 0.0;
	TruckerInfo[playerid][tIstovarCPy] = 0.0;
	TruckerInfo[playerid][tIstovarCPz] = 0.0;
	TruckerInfo[playerid][tStarted] = 0;
	TruckerInfo[playerid][tDeliveryDetails] = 0;
	TruckerInfo[playerid][tDeliveryTime] = -100;
	KillTimer(TruckerDeliveryTimer[playerid]);
	return 1;
}

stock SetTruckerJob(playerid, trName[35], trSkill, trPayCheck, trTrailer, Float:trUtovarCPx, Float:trUtovarCPy, Float:trUtovarCPz, Float:trIstovarCPx, Float:trIstovarCPy, Float:trIstovarCPz)
{
	if(GetPlayerSkillLevel(playerid, 7) < trSkill) return SendClientMessage( playerid, COLOR_RED, "Nemate dovoljan skill za voznju ovog tereta!");
    if(!TrailerType(GetVehicleTrailer(GetPlayerVehicleID(playerid)), trTrailer)) return SendClientMessage( playerid, COLOR_RED, "Nemate zakacenu odgovarajucu prikolicu!");
    
	TruckerInfo[playerid][tTrailerModel] 	= trTrailer;
    TruckerInfo[playerid][tUtovarCPx] 		= trUtovarCPx;
    TruckerInfo[playerid][tUtovarCPy] 		= trUtovarCPy;
    TruckerInfo[playerid][tUtovarCPz] 		= trUtovarCPz;
    TruckerInfo[playerid][tIstovarCPx] 		= trIstovarCPx;
    TruckerInfo[playerid][tIstovarCPy] 		= trIstovarCPy;
    TruckerInfo[playerid][tIstovarCPz] 		= trIstovarCPz;
    TruckerInfo[playerid][tPayCheck] 		= trPayCheck;
    TruckerInfo[playerid][tDeliveryDetails] = UTOVAR;
    TruckerInfo[playerid][tStarted] 		= 1;
    TruckerInfo[playerid][tDeliveryTime] 	= -100;
	
	Bit1_Set( gr_IsWorkingJob, playerid, true );
	strmid(TruckerInfo[playerid][tJobName], trName, 0, strlen(trName), 35);
   
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Odabrali ste teret "COL_WHITE"%s (skill: %d) "COL_YELLOW". Odvezite se na lokaciju za utovar.",
		TruckerInfo[playerid][tJobName], trSkill
	);
    SetPlayerCheckpoint(playerid, TruckerInfo[playerid][tUtovarCPx], TruckerInfo[playerid][tUtovarCPy], TruckerInfo[playerid][tUtovarCPz], 5.0);
    return 1;
}

stock IsVehicleATruck(id)
{
	if(GetVehicleModel(id) == 403 || GetVehicleModel(id) == 514 || GetVehicleModel(id) == 515)
	{
		return true;
	}
	return false;
}

stock IsTrailer(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 435,450,584,591,611,610: return true;
		default: return false;
	}
	return false;

}

stock SendTruckerMessage(color, string[])
{
	new
		vehicle;
	foreach (new i : Player)
	{
	    vehicle = GetPlayerVehicleID(i);
		if(PlayerInfo[i][pJob] == 15 && (VehicleInfo[ vehicle ][ vJob ] == 15 || VehicleInfo[ vehicle ][ vUsage ] == VEHICLE_USAGE_PRIVATE) && (VehicleInfo[vehicle][vModel] == 403 || VehicleInfo[vehicle][vModel] == 514 || VehicleInfo[vehicle][vModel] == 515))
			SendClientMessage(i, color, string);
	}
}
stock TrailerType(id, tmodel)
{
	if(tmodel == TRAILER_OIL)
	{
	    if(id == TruckerTrailer[1] || id == TruckerTrailer[6]) return 1;
	    return 0;
	}
	else if(tmodel == TRAILER_HEAVY)
	{
	    if(id == TruckerTrailer[2] || id == TruckerTrailer[7]) return 1;
	    return 0;
	}
	else if(tmodel == TRAILER_FREEZER)
	{
	    if(id == TruckerTrailer[3] || id == TruckerTrailer[8]) return 1;
	    return 0;
	}
	else if(tmodel == TRAILER_CONSTRUCTION)
	{
	    if(id == TruckerTrailer[4] || id == TruckerTrailer[9]) return 1;
	    return 0;
	}
	else if(tmodel == TRAILER_FRAGILE)
	{
	    if(id == TruckerTrailer[5] || id == TruckerTrailer[10]) return 1;
	    return 0;
	}
	return 0;
}

forward DeliveryTimer(playerid);
public DeliveryTimer(playerid)
{
	new DeliveryStr[128], string[256];
	if(PlayerInfo[playerid][pJob] != 15) return 1;
	if(PlayerInfo[playerid][pFreeWorks] < 0) return 1;
 	if(TruckerInfo[playerid][tDeliveryTime] <= -100) return 1;
	TruckerInfo[playerid][tDeliveryTime]--;
	if(TruckerInfo[playerid][tDeliveryDetails] == UTOVAR) format(DeliveryStr, sizeof(DeliveryStr), "~g~UTOVAR PRODUKTA~n~~w~%d sec", TruckerInfo[playerid][tDeliveryTime]);
	else format(DeliveryStr, sizeof(DeliveryStr), "~g~ISTOVAR PRODUKTA~n~~w~%d sec", TruckerInfo[playerid][tDeliveryTime]);
	if(TruckerInfo[playerid][tDeliveryTime] <= 0 && TruckerInfo[playerid][tDeliveryTime] != -100)
	{
        if(TruckerInfo[playerid][tDeliveryDetails] == UTOVAR)
		{
		    TogglePlayerControllable(playerid, 1);
		    GameTextForPlayer(playerid, "~g~UTOVAR PRODUKTA~n~~w~GOTOV", 950, 1);
		    SetPlayerCheckpoint(playerid, TruckerInfo[playerid][tIstovarCPx], TruckerInfo[playerid][tIstovarCPy], TruckerInfo[playerid][tIstovarCPz], 5.0);
	    	TruckerInfo[playerid][tDeliveryDetails] = ISTOVAR;
		    format(string, sizeof(string),"[ ! ] Utovarili ste "COL_WHITE"%s "COL_YELLOW". Odvezite teret na lokaciju za istovar.",
			TruckerInfo[playerid][tJobName]
			);
			SendClientMessage(playerid, COLOR_RED, string);
		}
        else
		{
			TogglePlayerControllable(playerid, 1);
			GameTextForPlayer(playerid, "~g~ISTOVAR PRODUKTA~n~~w~GOTOV", 950, 1);
			format(string, sizeof(string),"[ ! ] Zavrsili ste prevoz "COL_WHITE"%s "COL_YELLOW".",
			TruckerInfo[playerid][tJobName]
			);
			SendClientMessage(playerid, COLOR_RED, string);
			new money = TruckerInfo[playerid][tPayCheck] + 400 + (GetPlayerSkillLevel(playerid, 7) * 32);
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si "COL_YELLOW"$%d"COL_WHITE", placa ti je sjela na racun.", money);
			UpgradePlayerSkill(playerid, 7);
			BudgetToPayDayMoney(playerid, money);
			/*else
			{
				new vehicleid = GetPlayerVehicleID(playerid),
					Float:amount,
					price,
					whid,
					factionid = IllegalTruckerInfo[playerid][tFaction];
					
				TogglePlayerControllable(playerid, 1);
				switch(IllegalTruckerInfo[playerid][tDeliveryType])
				{
					case DELIVERY_TYPE_COKE:
					{
						amount = float(IllegalTruckerInfo[playerid][tAmount]),
						price = IllegalTruckerInfo[playerid][tAmount] * COCAINE_GRAM_PRICE,
						whid = IllegalTruckerInfo[playerid][tWarehouse];
						
						Cocaine -= IllegalTruckerInfo[playerid][tAmount];
						FactionDrugs[factionid][dTaken][DELIVERY_TYPE_COKE] += IllegalTruckerInfo[playerid][tAmount];
					}
					case DELIVERY_TYPE_HEROIN:
					{
						amount = float(IllegalTruckerInfo[playerid][tAmount]),
						price = IllegalTruckerInfo[playerid][tAmount] * HEROIN_GRAM_PRICE,
						whid = IllegalTruckerInfo[playerid][tWarehouse];
							
						Heroin -= IllegalTruckerInfo[playerid][tAmount];
						FactionDrugs[factionid][dTaken][DELIVERY_TYPE_HEROIN] += IllegalTruckerInfo[playerid][tAmount];
					}
					case DELIVERY_TYPE_ECSTASY:
					{
						amount = float(IllegalTruckerInfo[playerid][tAmount]),
						price = IllegalTruckerInfo[playerid][tAmount] * ECSTASY_GRAM_PRICE,
						whid = IllegalTruckerInfo[playerid][tWarehouse];
							
						Ecstasy -= IllegalTruckerInfo[playerid][tAmount];
						FactionDrugs[factionid][dTaken][DELIVERY_TYPE_ECSTASY] += IllegalTruckerInfo[playerid][tAmount];
					}
				}
				PutSmuggleInWarehouse(IllegalTruckerInfo[playerid][tWarehouse], IllegalTruckerInfo[playerid][tFaction], IllegalTruckerInfo[playerid][tDrugCode], amount);
				WarehouseToIllegalBudgetMoney(whid, price);
				UpdateDrugDelivery();
				UpdateFactionDrugsUptake(factionid);
				
				IllegalTruckerInfo[playerid][tWarehouse] = 0;
				IllegalTruckerInfo[playerid][tDeliveryType] = -1;
				IllegalTruckerInfo[playerid][tFaction] = 0;
				IllegalTruckerInfo[playerid][tDrugCode] = 0;
				IllegalTruckerInfo[playerid][tAmount] = 0;
				Smuggler[vehicleid] = -1;
			}*/
			PlayerInfo[playerid][pFreeWorks] -= 6;
			TruckerInfo[playerid][tStarted] = 0;
			TruckerInfo[playerid][tPayCheck] = 0;
			TruckerInfo[playerid][tUtovarCPx] = 0.0;
			TruckerInfo[playerid][tUtovarCPy] = 0.0;
			TruckerInfo[playerid][tUtovarCPz] = 0.0;
			TruckerInfo[playerid][tIstovarCPx] = 0.0;
			TruckerInfo[playerid][tIstovarCPy] = 0.0;
			TruckerInfo[playerid][tIstovarCPz] = 0.0;
			TruckerInfo[playerid][tStarted] = 0;
			TruckerInfo[playerid][tDeliveryDetails] = 0;
			TruckerInfo[playerid][tDeliveryTime] = -100;
			//TruckerInfo[playerid][tIllegal] = false;
		}
		KillTimer(TruckerDeliveryTimer[playerid]);
	}
	else
	{
	    GameTextForPlayer(playerid, DeliveryStr, 950, 1);
	}
	return 1;
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
hook OnGameModeInit()
{
	TruckerTrailer[1] = AC_CreateVehicle(584, -274.0566, -2193.9648, 30.7207, 19.6716, -1, -1, -1); //CISTERNA
	TruckerTrailer[2] = AC_CreateVehicle(435, -269.0345, -2192.3633, 30.7207, 19.6716, -1, -1, -1); //LOMLJIVI TERET
	TruckerTrailer[3] = AC_CreateVehicle(435, -263.8450, -2190.5632, 30.7207, 19.6716, -1, -1, -1); //MLECNI PROIZVODI
	TruckerTrailer[4] = AC_CreateVehicle(591, -258.7666, -2188.7019, 30.7207, 19.6716, -1, -1, -1); //AUTO DELOVI
	TruckerTrailer[5] = AC_CreateVehicle(450, -253.5793, -2187.1948, 30.7207, 19.6716, -1, -1, -1); //PESAK

	TruckerTrailer[6] = AC_CreateVehicle(584, -270.6567, 2596.2063, 63.8168, 270.0000, -1, -1, -1); //CISTERNA
	TruckerTrailer[7] = AC_CreateVehicle(435, -270.6567, 2600.8381, 63.8168, 270.0000, -1, -1, -1); //LOMLJIVI TERET
	TruckerTrailer[8] = AC_CreateVehicle(435, -270.6567, 2605.1851, 63.8168, 270.0000, -1, -1, -1); //MLECNI PROIZVODI
	TruckerTrailer[9] = AC_CreateVehicle(591, -207.5822, 2595.6687, 63.1928, 0.0000, -1, -1, -1); //AUTO DELOVI
	TruckerTrailer[10] = AC_CreateVehicle(450, -213.5832, 2595.6687, 63.1928, 0.0000, -1, -1, -1); //PESAK
	
	for(new i = 1; i < 11; i++)
		Iter_Add(TruckTrailers, TruckerTrailer[i]);
		
	//3DTextovi nad Trailerima
	TrailerText[1] = CreateDynamic3DTextLabel( "OIL", 0xE7AE28FF, -274.0566, -2193.9648, 30.7207, 15.0, INVALID_PLAYER_ID, TruckerTrailer[1], 0, -1, -1, -1, 15.0);
	TrailerText[2] = CreateDynamic3DTextLabel( "HEAVY", 0xE7AE28FF, -269.0345, -2192.3633, 30.7207, 15.0, INVALID_PLAYER_ID, TruckerTrailer[2], 0, -1, -1, -1, 15.0);
	TrailerText[3] = CreateDynamic3DTextLabel( "FREEZER", 0xE7AE28FF, -263.8450, -2190.5632, 30.7207, 15.0, INVALID_PLAYER_ID, TruckerTrailer[3], 0, -1, -1, -1, 15.0);
	TrailerText[4] = CreateDynamic3DTextLabel( "CONSTRUCTION", 0xE7AE28FF, -258.7666, -2188.7019, 30.7207, 15.0, INVALID_PLAYER_ID, TruckerTrailer[4], 0, -1, -1, -1, 15.0);
	TrailerText[5] = CreateDynamic3DTextLabel( "FRAGILE", 0xE7AE28FF, -253.5793, -2187.1948, 30.7207, 15.0, INVALID_PLAYER_ID, TruckerTrailer[5], 0, -1, -1, -1, 15.0);
	TrailerText[6] = CreateDynamic3DTextLabel( "OIL", 0xE7AE28FF, -270.6567, 2596.2063, 63.8168, 15.0, INVALID_PLAYER_ID, TruckerTrailer[6], 0, -1, -1, -1, 15.0);
	TrailerText[7] = CreateDynamic3DTextLabel( "HEAVY", 0xE7AE28FF, -270.6567, 2600.8381, 63.8168, 15.0, INVALID_PLAYER_ID, TruckerTrailer[7], 0, -1, -1, -1, 15.0);
	TrailerText[8] = CreateDynamic3DTextLabel( "FREEZER", 0xE7AE28FF, -270.6567, 2605.1851, 63.8168, 15.0, INVALID_PLAYER_ID, TruckerTrailer[8], 0, -1, -1, -1, 15.0);
	TrailerText[9] = CreateDynamic3DTextLabel( "CONSTRUCTION", 0xE7AE28FF, -207.5822, 2595.6687, 63.1928, 15.0, INVALID_PLAYER_ID, TruckerTrailer[9], 0, -1, -1, -1, 15.0);
	TrailerText[10] = CreateDynamic3DTextLabel( "FRAGILE", 0xE7AE28FF, -213.5832, 2595.6687, 63.1928, 15.0, INVALID_PLAYER_ID, TruckerTrailer[10], 0, -1, -1, -1, 15.0);


	//ODMARALISTE LOS SANTOS-ANGEL PINE (ROUTE 27)
	new tmpobjid;
	tmpobjid = CreateDynamicObject(8947, -298.190765, -2154.281005, 24.420600, 0.000000, -10.000000, 19.670299, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -291.444488, -2138.888671, 29.256900, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -286.487487, -2137.112304, 29.252899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -299.144409, -2141.645996, 26.953599, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -290.469390, -2164.468505, 26.953599, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -277.418212, -2133.867431, 29.252899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -268.356597, -2130.626708, 29.248899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -286.105499, -2167.923339, 29.252899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -282.863098, -2176.989746, 29.252899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -279.622009, -2186.055908, 29.250900, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, -288.264892, -2161.888183, 29.256900, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, -295.387390, -2141.912109, 29.254899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(17038, -249.862625, -2137.939941, 28.692199, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 17545, "burnsground", "newall10_seamless", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -271.757110, -2193.129638, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateObject(8411, -273.201904, -2166.094970, -36.282100, 0.000000, 0.000000, -70.319999);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetObjectMaterial(tmpobjid, 5, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(8411, -249.229995, -2157.522460, -36.282100, 0.000000, 0.000000, -70.319999);
	SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -276.478210, -2194.853271, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.412597, -2197.778320, 29.250900, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -261.347290, -2194.534423, 29.248899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -252.289398, -2191.294677, 29.246900, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -243.220504, -2188.049804, 29.246900, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -234.152694, -2184.807617, 29.246900, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -231.440002, -2183.839599, 29.244899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -228.577194, -2177.794677, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -231.819900, -2168.724609, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -235.060104, -2159.658935, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -238.302398, -2150.590087, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -241.544998, -2141.516845, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -244.782806, -2132.462402, 29.248899, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -246.421295, -2127.872558, 29.246900, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -259.289489, -2127.383300, 29.248899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -252.488098, -2124.948730, 29.248899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -241.317794, -2156.703125, 29.244899, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -294.451995, -2143.676757, 29.864599, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "decoacwallbtm21_256", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -294.451995, -2143.676757, 27.596000, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -288.654510, -2159.942626, 29.864599, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "decoacwallbtm21_256", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -288.654510, -2159.942626, 27.596599, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13131, "cunte_blockammo", "newall10", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -266.596191, -2191.234863, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -261.443695, -2189.477539, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -256.279846, -2187.536621, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -251.247756, -2185.742675, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -246.198501, -2183.901367, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -241.183578, -2182.288085, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -236.408340, -2180.553466, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -232.017410, -2179.047363, 26.962999, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1256, -255.727645, -2132.713867, 29.352800, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1216, -257.325714, -2127.982421, 29.380500, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2670, -256.904754, -2128.821777, 28.791700, 0.000000, 0.000000, 170.099990, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1440, -253.048614, -2141.311523, 29.218599, 0.000000, 0.000000, -73.919998, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1216, -257.114959, -2128.565429, 29.380500, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1216, -256.893768, -2129.165039, 29.380500, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1256, -253.849044, -2137.811767, 29.352800, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2670, -254.495071, -2137.051269, 28.791700, 0.000000, 0.000000, 126.479988, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(18452, -244.090240, -2151.080810, 31.464799, 0.000000, 0.000000, 19.671600, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1686, -244.970703, -2148.395019, 28.693300, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1686, -243.132095, -2153.673828, 28.693300, 0.000000, 0.000000, -70.319999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1438, -237.815597, -2156.869384, 28.700500, 0.000000, 0.000000, 19.200000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1440, -240.739212, -2157.382080, 29.218599, 0.000000, 0.000000, 19.559989, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1441, -243.735931, -2158.173583, 29.338600, 0.000000, 0.000000, 19.559999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2673, -242.150756, -2158.529541, 28.823900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2670, -239.124099, -2157.803222, 28.833900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	//ODMARALISTE LAS PAYASADAS
	tmpobjid = CreateDynamicObject(19456, -249.770401, 2613.028076, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -259.403503, 2613.028808, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -269.029510, 2613.027587, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -278.662414, 2613.026611, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -285.176300, 2608.300048, 62.330799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19437, -284.281890, 2613.027587, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -285.176696, 2598.668701, 62.330799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -285.180114, 2592.499267, 62.328800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -280.449310, 2590.980957, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.816589, 2590.981445, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -261.186614, 2590.980468, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -251.596603, 2591.002685, 62.330799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -245.037002, 2592.512207, 62.330799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -249.771804, 2591.000000, 62.328800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -245.038299, 2595.721679, 62.330799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -245.033798, 2611.515380, 62.332801, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -245.032897, 2608.306396, 62.332801, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -243.336898, 2602.046875, 61.173400, 0.000000, -70.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -244.635696, 2596.922119, 61.323898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -244.635696, 2607.083251, 61.323898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -240.133300, 2613.031005, 60.748901, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -230.709701, 2613.032714, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -225.813796, 2617.758300, 60.748901, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -240.127304, 2590.995361, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -230.494201, 2590.996093, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -220.863693, 2590.996826, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -211.231796, 2590.997070, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -201.599105, 2590.997802, 60.746898, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -196.692398, 2595.725097, 60.746898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -196.693298, 2605.356933, 60.746898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19368, -196.690597, 2611.481445, 60.742900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -201.418304, 2613.025878, 60.744899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -211.044494, 2613.025878, 60.744899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -215.850601, 2617.751953, 60.748901, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.616729, 2607.468017, 60.106899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.696838, 2603.062500, 60.106899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.790496, 2598.413818, 60.106899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19456, -270.780059, 2593.890869, 60.106899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -216.139694, 2622.222900, 62.076499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	tmpobjid = CreateDynamicObject(9131, -225.525207, 2622.222900, 62.076499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 12946, "ce_bankalley1", "alleywall3", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(966, -245.203506, 2599.456298, 61.849601, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(967, -245.701400, 2598.058105, 61.850299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(968, -245.205398, 2599.248291, 62.644699, 0.000000, 35.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1232, -244.551300, 2596.934326, 59.956600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1232, -244.593704, 2607.089599, 59.956600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16398, -278.605499, 2604.517578, 61.827499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(939, -247.883407, 2592.415039, 64.259201, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(942, -253.187469, 2592.391113, 64.259201, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(922, -258.284362, 2591.654052, 62.743198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(0, -251.095092, 2595.813720, 62.743198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(923, -245.729278, 2595.672363, 62.743198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(931, -261.987030, 2592.043945, 62.857498, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(931, -264.678924, 2592.222656, 62.857498, 0.000000, 0.000000, -8.399999, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -256.231994, 2592.619140, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -257.051879, 2592.496582, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -245.814025, 2594.172851, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -260.309631, 2592.632324, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1348, -253.333053, 2612.382080, 62.557399, 0.000000, 0.000000, 181.560043, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -246.087249, 2611.904541, 62.595401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -246.125610, 2609.913574, 62.595401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -246.144577, 2607.902343, 62.595401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -248.288650, 2611.953857, 62.595401, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -247.040847, 2611.935791, 64.093002, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1685, -246.150070, 2608.987548, 64.093002, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1431, -251.025466, 2610.983398, 62.385398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1431, -247.426513, 2608.984619, 62.385398, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(944, -250.907257, 2612.124023, 62.713298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -247.629974, 2610.479736, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -248.638778, 2610.671142, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -254.626129, 2612.338378, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -247.469879, 2607.459472, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(935, -252.803619, 2611.406005, 62.417400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1232, -225.516296, 2622.260986, 60.725601, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1232, -216.122100, 2622.252929, 60.725601, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(18452, -201.314498, 2595.168457, 64.635803, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1686, -198.513900, 2595.182373, 61.873298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1686, -204.130706, 2595.182373, 61.873298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	return 1;
}

hook OnGameModeExit()
{
    DestroyDynamic3DTextLabel( TrailerText[1]);
    DestroyDynamic3DTextLabel( TrailerText[2]);
    DestroyDynamic3DTextLabel( TrailerText[3]);
    DestroyDynamic3DTextLabel( TrailerText[4]);
    DestroyDynamic3DTextLabel( TrailerText[5]);
    DestroyDynamic3DTextLabel( TrailerText[6]);
    DestroyDynamic3DTextLabel( TrailerText[7]);
    DestroyDynamic3DTextLabel( TrailerText[8]);
    DestroyDynamic3DTextLabel( TrailerText[9]);
    DestroyDynamic3DTextLabel( TrailerText[10]);
	
	Iter_Clear(TruckTrailers);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(TruckerDeliveryTimer[playerid]);
	
	TruckerInfo[playerid][tStarted] = 0;
	TruckerInfo[playerid][tUtovarCPx] = 0.0;
	TruckerInfo[playerid][tUtovarCPy] = 0.0;
	TruckerInfo[playerid][tUtovarCPz] = 0.0;
	TruckerInfo[playerid][tIstovarCPx] = 0.0;
	TruckerInfo[playerid][tIstovarCPy] = 0.0;
	TruckerInfo[playerid][tIstovarCPz] = 0.0;
	TruckerInfo[playerid][tTrailerModel] = 0;
	TruckerInfo[playerid][tDeliveryBiz] = 0;
	TruckerInfo[playerid][tDeliveryType] = 0;
	TruckerInfo[playerid][tDeliveryTime] = -100;
	return 1;
}

hook OnPlayerConnect(playerid)
{
	//SF
	RemoveBuildingForPlayer(playerid, 3276, -300.937, -2148.421, 28.320, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, -303.312, -2143.914, 27.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -297.187, -2141.570, 28.320, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -257.562, -2241.523, 28.320, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -263.867, -2231.578, 28.320, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -245.398, -2225.992, 28.687, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -245.437, -2236.687, 28.414, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -249.203, -2244.398, 28.414, 0.250);
	RemoveBuildingForPlayer(playerid, 17038, -280.187, -2167.703, 27.789, 0.250);
	RemoveBuildingForPlayer(playerid, 17037, -288.273, -2163.500, 30.093, 0.250);
	RemoveBuildingForPlayer(playerid, 17036, -285.398, -2151.046, 27.382, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -285.929, -2139.273, 28.320, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -274.578, -2138.632, 28.492, 0.250);
	RemoveBuildingForPlayer(playerid, 17039, -260.539, -2182.609, 26.687, 0.250);
	RemoveBuildingForPlayer(playerid, 17040, -257.531, -2202.835, 27.578, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -254.140, -2170.796, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -263.390, -2140.593, 28.828, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -258.000, -2148.109, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -256.250, -2159.320, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -251.304, -2181.804, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -248.039, -2192.812, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -244.859, -2203.867, 29.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3276, -243.726, -2214.726, 28.898, 0.250);
	
	//LV
	RemoveBuildingForPlayer(playerid, 16012, -264.671, 2596.570, 61.820, 0.250);
	RemoveBuildingForPlayer(playerid, 955, -253.742, 2597.953, 62.242, 0.250);
	RemoveBuildingForPlayer(playerid, 956, -253.742, 2599.757, 62.242, 0.250);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) {
		case DIALOG_TRUCKER_SELECT_INFO:
		{
			if(!response) return 1;
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Niste u kamionu");
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage( playerid, COLOR_RED, "Niste u kamionu/Niste vozac!");
			new InfoText[512];
			SendClientMessage( playerid, COLOR_WHITE, "[OBAVJEST]: Rute su odvojene ravnom crtom(|). U uglatim zagradama[] su skill leveli potrebni za odredjenu rutu.");
			switch(listitem)
			{
				case 0:
				{
					format(InfoText, sizeof(InfoText), "Vosak (East LS CarWash)[2] | Vosak (Idlewood CarWash)[2]");
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_OILINFO, DIALOG_STYLE_MSGBOX, "OIL rute", InfoText, "Zatvori", "");
				}
				case 1:
				{
					format(InfoText, sizeof(InfoText), "Alat (LS Mechanic Garage)[1] | Kreveti (LS Medical Department)[1]\nTegovi (Ganton Gym)[1] | Dijelovi (LS Mechanic Garage)[1]\n\
														Posteljina (LS Medical Department)[1] | Sprave (Ganton Gym)[1]\nGume (LS Mechanic Garage)[2] | Blokovi (LS Construction Co.)[2]");
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_HEAVYINFO, DIALOG_STYLE_MSGBOX, "HEAVY rute", InfoText, "Zatvori", "");
				}
				case 2:
				{
					format(InfoText, sizeof(InfoText), "Deterdzent (East LS CarWash)[0] | Deterdzent (Idlewood CarWash)[0]\n\
														Hrana (Verona Mall)[0] | Pice(Verona Mall)[0] | Ljekovi (LS Medical Department)[1]");
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_FREEZERINFO, DIALOG_STYLE_MSGBOX, "FREEZER rute", InfoText, "Zatvori", "");
				}
				case 3:
				{
					format(InfoText, sizeof(InfoText), "Pjesak (LS Construction Co.)[2] | Zemlja (LS Construction Co.)[2] | Kamen (LS Construction Co.)[2]");
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_CONSTINFO, DIALOG_STYLE_MSGBOX, "CONSTRUCTION rute", InfoText, "Zatvori", "");
				}
				case 4:
				{
					format(InfoText, sizeof(InfoText), "Odjeca (Verona Mall)[0] | Odjeca (Ganton Binco)[1] | Odjeca (Vinewood ZIP)[1]\nObuca (Verona Mall)[0] | Obuca (Ganton Binco)[1]\n\
														Pribor (LS Medical Department)[1] | Crnilo (East LS CarWash)[2] | Crnilo (Idlewood CarWash)[2]\nBoks oprema (Ganton Gym)[1]\n\
														Podloge za ring (Ganton Gym)[1] | Pribor za jelo (Verona Mall)[0]\nPosudje (Verona Mall)[0] | Obuca (Vinewood ZIP)[1]");
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_FRAGILEINFO, DIALOG_STYLE_MSGBOX, "FRAGILE rute", InfoText, "Zatvori", "");
				}
			}
		}
		case DIALOG_TRUCKER_SELECT_BIZ:
		{
			if(!response) return 1;
	 		if(PlayerInfo[playerid][pJob] != TRUCKER_ID) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
	 		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Niste u kamionu/Niste vozac!");
	 		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage( playerid, COLOR_RED, "Niste u kamionu/Niste vozac!");
            TruckerInfo[playerid][tDeliveryBiz] = listitem+1;
			switch(listitem)
		    {
		        case 0:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Pjesak\nZemlja\nKamen\nBlokovi", "Select", "Cancel");
				}
		        case 1:
		        {
					ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Alat\nDijelovi\nGume\nFelge", "Select", "Cancel");
				}
		        case 2:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Kreveti\nPosteljina\nPribor\nLjekovi", "Select", "Cancel");
				}
		        case 3:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Deterdzent\nVosak\nCrnilo", "Select", "Cancel");
				}
		        case 4:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Deterdzent\nVosak\nCrnilo", "Select", "Cancel");
				}
		        case 5:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Tegovi\nSprave\nBoks oprema\nPodloge za ring", "Select", "Cancel");
				}
		        case 6:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Odjeca\nObuca\nMobiteli\nHrana\nPice\nPribor za jelo\nPosudje", "Select", "Cancel");
				}
		        case 7:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Odjeca\nObuca", "Select", "Cancel");
				}
		        case 8:
		        {
		            ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_JOB, DIALOG_STYLE_LIST, "ODABIR TERETA", "Odjeca\nObuca", "Select", "Cancel");
				}
			}
		}
		case DIALOG_ATRAILER:
		{
			if(!response) return 1;
			switch(listitem)
		    {
	      		case 0:
		        {
		            SetVehiclePos(TruckerTrailer[1], -274.0566, -2193.9648, 30.7207);
		            SetVehicleZAngle(TruckerTrailer[1], 19.6716);
				}
				case 1:
				{
				    SetVehiclePos(TruckerTrailer[2], -269.0345, -2192.3633, 30.7207);
		            SetVehicleZAngle(TruckerTrailer[2], 19.6716);
				}
				case 2:
				{
		            SetVehiclePos(TruckerTrailer[3], -263.8450, -2190.5632, 30.7207);
		            SetVehicleZAngle(TruckerTrailer[3], 19.6716);
				}
				case 3:
				{
		            SetVehiclePos(TruckerTrailer[4], -258.7666, -2188.7019, 30.7207);
		            SetVehicleZAngle(TruckerTrailer[4], 19.6716);
				}
				case 4:
				{
		            SetVehiclePos(TruckerTrailer[5], -253.5793, -2187.1948, 30.7207);
		            SetVehicleZAngle(TruckerTrailer[5], 19.6716);
				}
				case 5:
				{
		            SetVehiclePos(TruckerTrailer[6], -270.6567, 2596.2063, 63.8168);
		            SetVehicleZAngle(TruckerTrailer[6], 270.0000);
				}
				case 6:
				{
		            SetVehiclePos(TruckerTrailer[7], -270.6567, 2600.8381, 63.8168);
		            SetVehicleZAngle(TruckerTrailer[7], 270.0000);
				}
				case 7:
				{
		            SetVehiclePos(TruckerTrailer[8], -270.6567, 2605.1851, 63.8168);
		            SetVehicleZAngle(TruckerTrailer[8], 270.0000);
				}
				case 8:
				{
		            SetVehiclePos(TruckerTrailer[9], -207.5822, 2595.6687, 63.1928);
		            SetVehicleZAngle(TruckerTrailer[9], 0.0000);
				}
				case 9:
				{
		            SetVehiclePos(TruckerTrailer[10],  -213.5832, 2595.6687, 63.1928);
		            SetVehicleZAngle(TruckerTrailer[10], 0.0000);
				}
			}
		}
	 	case DIALOG_TRUCKER_SELECT_JOB:
		{
			if(!response) return 1;
	 		if(PlayerInfo[playerid][pJob] != TRUCKER_ID) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
	 		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Niste u kamionu!");
	 		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage( playerid, COLOR_RED, "Niste vozac kamiona!");
	 		if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendClientMessage( playerid, COLOR_RED, "Nemate zakacenu odgovarajucu prikolicu!");
			switch(listitem)
		    {
		        case 0:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 1)
		            {
						if(last_route[playerid] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (1);
		                SetTruckerJob(playerid, "Pjesak (LS Construction Co.)", TRUCKER_SKILL_BEST,BEST_TRUCKER_JOB, TRAILER_CONSTRUCTION, TruckerCPInfos[17][trX], TruckerCPInfos[17][trY], TruckerCPInfos[17][trZ], TruckerCPInfos[1][trX], TruckerCPInfos[1][trY], TruckerCPInfos[1][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 2)
		            {
						if(last_route[playerid] == 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (2);
		                SetTruckerJob(playerid, "Alat (LS Mechanic Garage)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[13][trX], TruckerCPInfos[13][trY], TruckerCPInfos[13][trZ], TruckerCPInfos[5][trX], TruckerCPInfos[5][trY], TruckerCPInfos[5][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 3)
		            {
						if(last_route[playerid] == 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (3);
		                SetTruckerJob(playerid, "Kreveti (LS Medical Department)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[2][trX], TruckerCPInfos[2][trY], TruckerCPInfos[2][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 4)
		            {
						if(last_route[playerid] == 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (4);
		                SetTruckerJob(playerid, "Deterdzent (East LS CarWash)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FREEZER, TruckerCPInfos[20][trX], TruckerCPInfos[20][trY], TruckerCPInfos[20][trZ], TruckerCPInfos[3][trX], TruckerCPInfos[3][trY], TruckerCPInfos[3][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 5)
		            {
						if(last_route[playerid] == 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (5);
		                SetTruckerJob(playerid, "Deterdzent (Idlewood CarWash)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FREEZER, TruckerCPInfos[20][trX], TruckerCPInfos[20][trY], TruckerCPInfos[20][trZ], TruckerCPInfos[4][trX], TruckerCPInfos[4][trY], TruckerCPInfos[4][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 6)
		            {
						if(last_route[playerid] == 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (6);
		                SetTruckerJob(playerid, "Tegovi (Ganton Gym)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[3][trX], TruckerCPInfos[3][trY], TruckerCPInfos[3][trZ], TruckerCPInfos[0][trX], TruckerCPInfos[0][trY], TruckerCPInfos[0][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 7) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (7);
		                SetTruckerJob(playerid, "Odjeca (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[10][trX], TruckerCPInfos[10][trY], TruckerCPInfos[10][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 8)
		            {
						if(last_route[playerid] == 8) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (8);
		                SetTruckerJob(playerid, "Odjeca (Ganton Binco)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[6][trX], TruckerCPInfos[6][trY], TruckerCPInfos[6][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 9)
		            {
						if(last_route[playerid] == 9) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (9);
		                SetTruckerJob(playerid, "Odjeca (Vinewood ZIP)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[7][trX], TruckerCPInfos[7][trY], TruckerCPInfos[7][trZ]);
					}
				}
				case 1:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 1)
		            {
						if(last_route[playerid] == 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (10);
		                SetTruckerJob(playerid, "Zemlja (LS Construction Co.)", TRUCKER_SKILL_BEST,BEST_TRUCKER_JOB, TRAILER_CONSTRUCTION, TruckerCPInfos[17][trX], TruckerCPInfos[17][trY], TruckerCPInfos[17][trZ], TruckerCPInfos[1][trX], TruckerCPInfos[1][trY], TruckerCPInfos[1][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 2)
		            {
						if(last_route[playerid] == 11) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (11);
		                SetTruckerJob(playerid, "Dijelovi (LS Mechanic Garage)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[15][trX], TruckerCPInfos[15][trY], TruckerCPInfos[15][trZ], TruckerCPInfos[5][trX], TruckerCPInfos[5][trY], TruckerCPInfos[5][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 3)
		            {
						if(last_route[playerid] == 12) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (12);
		                SetTruckerJob(playerid, "Posteljina (LS Medical Department)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[2][trX], TruckerCPInfos[2][trY], TruckerCPInfos[2][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 4)
		            {
						if(last_route[playerid] == 13) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (13);
		                SetTruckerJob(playerid, "Vosak (East LS CarWash)", TRUCKER_SKILL_BEST,MEDIUM_TRUCKER_JOB, TRAILER_OIL, TruckerCPInfos[20][trX], TruckerCPInfos[20][trY], TruckerCPInfos[20][trZ], TruckerCPInfos[3][trX], TruckerCPInfos[3][trY], TruckerCPInfos[3][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 5)
		            {
						if(last_route[playerid] == 14) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (14);
		                SetTruckerJob(playerid, "Vosak (Idlewood CarWash)", TRUCKER_SKILL_BEST,MEDIUM_TRUCKER_JOB, TRAILER_OIL, TruckerCPInfos[20][trX], TruckerCPInfos[20][trY], TruckerCPInfos[20][trZ], TruckerCPInfos[4][trX], TruckerCPInfos[4][trY], TruckerCPInfos[4][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 6)
		            {
						if(last_route[playerid] == 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (15);
		                SetTruckerJob(playerid, "Sprave (Ganton Gym)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[15][trX], TruckerCPInfos[15][trY], TruckerCPInfos[15][trZ], TruckerCPInfos[0][trX], TruckerCPInfos[0][trY], TruckerCPInfos[0][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 16) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (16);
		                SetTruckerJob(playerid, "Obuca (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[10][trX], TruckerCPInfos[10][trY], TruckerCPInfos[10][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 8)
		            {
						if(last_route[playerid] == 17) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (17);
		                SetTruckerJob(playerid, "Obuca (Ganton Binco)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[6][trX], TruckerCPInfos[6][trY], TruckerCPInfos[6][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 9)
		            {
						if(last_route[playerid] == 18) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (18);
		                SetTruckerJob(playerid, "Obuca (Vinewood ZIP)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ], TruckerCPInfos[7][trX], TruckerCPInfos[7][trY], TruckerCPInfos[7][trZ]);
					}
				}
				case 2:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 1)
		            {
						if(last_route[playerid] == 19) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (19);
		                SetTruckerJob(playerid, "Kamen (LS Construction Co.)", TRUCKER_SKILL_BEST,BEST_TRUCKER_JOB, TRAILER_CONSTRUCTION, TruckerCPInfos[18][trX], TruckerCPInfos[18][trY], TruckerCPInfos[18][trZ], TruckerCPInfos[1][trX], TruckerCPInfos[1][trY], TruckerCPInfos[1][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 2)
		            {
						if(last_route[playerid] == 20) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (20);
		                SetTruckerJob(playerid, "Gume (LS Mechanic Garage)", TRUCKER_SKILL_BEST,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[18][trX], TruckerCPInfos[18][trY], TruckerCPInfos[18][trZ], TruckerCPInfos[5][trX], TruckerCPInfos[5][trY], TruckerCPInfos[5][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 3)
		            {
						if(last_route[playerid] == 21) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (21);
		                SetTruckerJob(playerid, "Pribor (LS Medical Department)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[14][trX], TruckerCPInfos[14][trY], TruckerCPInfos[14][trZ],TruckerCPInfos[2][trX], TruckerCPInfos[2][trY], TruckerCPInfos[2][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 4)
		            {
						if(last_route[playerid] == 22) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (22);
		                SetTruckerJob(playerid, "Crnilo (East LS CarWash)", TRUCKER_SKILL_BEST,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[19][trX], TruckerCPInfos[19][trY], TruckerCPInfos[19][trZ], TruckerCPInfos[3][trX], TruckerCPInfos[3][trY], TruckerCPInfos[3][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 5)
		            {
						if(last_route[playerid] == 23) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (23);
		                SetTruckerJob(playerid, "Crnilo (Idlewood CarWash)", TRUCKER_SKILL_BEST,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[19][trX], TruckerCPInfos[19][trY], TruckerCPInfos[19][trZ], TruckerCPInfos[4][trX], TruckerCPInfos[4][trY], TruckerCPInfos[4][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 6)
		            {
						if(last_route[playerid] == 24) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (24);
		                SetTruckerJob(playerid, "Boks oprema (Ganton Gym)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[15][trX], TruckerCPInfos[15][trY], TruckerCPInfos[15][trZ], TruckerCPInfos[0][trX], TruckerCPInfos[0][trY], TruckerCPInfos[0][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 25) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (25);
		                SetTruckerJob(playerid, "Mobiteli (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[13][trX], TruckerCPInfos[13][trY], TruckerCPInfos[13][trZ], TruckerCPInfos[12][trX], TruckerCPInfos[12][trY], TruckerCPInfos[12][trZ]);
					}
				}
				case 3:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 1)
		            {
						if(last_route[playerid] == 26) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (26);
		                SetTruckerJob(playerid, "Blokovi (LS Construction Co.)", TRUCKER_SKILL_BEST,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[18][trX], TruckerCPInfos[18][trY], TruckerCPInfos[18][trZ], TruckerCPInfos[1][trX], TruckerCPInfos[1][trY], TruckerCPInfos[1][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 2)
		            {
						if(last_route[playerid] == 27) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (27);
		                SetTruckerJob(playerid, "Felge (LS Mechanic Garage)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_HEAVY, TruckerCPInfos[13][trX], TruckerCPInfos[13][trY], TruckerCPInfos[13][trZ], TruckerCPInfos[5][trX], TruckerCPInfos[5][trY], TruckerCPInfos[5][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 3)
		            {
						if(last_route[playerid] == 28) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (28);
		                SetTruckerJob(playerid, "Ljekovi (LS Medical Department)", TRUCKER_SKILL_MEDIUM,BEST_TRUCKER_JOB, TRAILER_FREEZER, TruckerCPInfos[20][trX], TruckerCPInfos[20][trY], TruckerCPInfos[20][trZ], TruckerCPInfos[2][trX], TruckerCPInfos[2][trY], TruckerCPInfos[2][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 6)
		            {
						if(last_route[playerid] == 29) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (29);
		                SetTruckerJob(playerid, "Podloge za ring (Ganton Gym)", TRUCKER_SKILL_MEDIUM,DEFUALT_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[18][trX], TruckerCPInfos[18][trY], TruckerCPInfos[18][trZ], TruckerCPInfos[0][trX], TruckerCPInfos[0][trY], TruckerCPInfos[0][trZ]);
					}
		            else if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 30) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (30);
		                SetTruckerJob(playerid, "Hrana (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FREEZER, TruckerCPInfos[19][trX], TruckerCPInfos[19][trY], TruckerCPInfos[19][trZ], TruckerCPInfos[8][trX], TruckerCPInfos[8][trY], TruckerCPInfos[8][trZ]);
					}
				}
				case 4:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 31) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (31);
		                SetTruckerJob(playerid, "Pice (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FREEZER, TruckerCPInfos[21][trX], TruckerCPInfos[21][trY], TruckerCPInfos[21][trZ], TruckerCPInfos[9][trX], TruckerCPInfos[9][trY], TruckerCPInfos[9][trZ]);
					}
				}
				case 5:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 32) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (32);
		                SetTruckerJob(playerid, "Pribor za jelo (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[15][trX], TruckerCPInfos[15][trY], TruckerCPInfos[15][trZ], TruckerCPInfos[11][trX], TruckerCPInfos[11][trY], TruckerCPInfos[11][trZ]);
					}
				}
				case 6:
		        {
		            if(TruckerInfo[playerid][tDeliveryBiz] == 7)
		            {
						if(last_route[playerid] == 33) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete raditi ovu rutu ponovo!");
						last_route[playerid] = (33);
		                SetTruckerJob(playerid, "Posudje (Verona Mall)", TRUCKER_SKILL_DEFUALT,MEDIUM_TRUCKER_JOB, TRAILER_FRAGILE, TruckerCPInfos[15][trX], TruckerCPInfos[15][trY], TruckerCPInfos[15][trZ], TruckerCPInfos[11][trX], TruckerCPInfos[11][trY], TruckerCPInfos[11][trZ]);
		            }
				}
			}
		}
	}
	return 0;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if(TruckerInfo[playerid][tStarted] >= 1)
	{
	    if(!IsPlayerInAnyVehicle(playerid)) return 1;
	    if(IsVehicleATruck(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == 2)
	    {
	        if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)) && TrailerType(GetVehicleTrailer(GetPlayerVehicleID(playerid)), TruckerInfo[playerid][tTrailerModel]))
	        {
                new DeliveryStr[128];
                TogglePlayerControllable(playerid, 0);
		        if(TruckerInfo[playerid][tDeliveryDetails] == UTOVAR)
				{
				    if(IsPlayerInRangeOfPoint(playerid, 8.0, TruckerInfo[playerid][tUtovarCPx], TruckerInfo[playerid][tUtovarCPy], TruckerInfo[playerid][tUtovarCPz]))
					{
					    TruckerInfo[playerid][tDeliveryTime] = 120;
						format(DeliveryStr, sizeof(DeliveryStr), "~g~UTOVAR PRODUKTA~n~~w~%d sec", TruckerInfo[playerid][tDeliveryTime]);
					}
					else return 1;
				}
		        else
				{
				    if(IsPlayerInRangeOfPoint(playerid, 8.0, TruckerInfo[playerid][tIstovarCPx], TruckerInfo[playerid][tIstovarCPy], TruckerInfo[playerid][tIstovarCPz]))
					{
					    TruckerInfo[playerid][tDeliveryTime] = 60;
						format(DeliveryStr, sizeof(DeliveryStr), "~g~ISTOVAR PRODUKTA~n~~w~%d sec", TruckerInfo[playerid][tDeliveryTime]);
					}
					else return 1;
				}
		        TruckerDeliveryTimer[playerid] = SetTimerEx("DeliveryTimer", 1000, true, "d", playerid);
				DisablePlayerCheckpoint(playerid);
				GameTextForPlayer(playerid, DeliveryStr, 950, 1);
				TruckerInfo[playerid][tStarted] = 2;
	        }
	    }
	    else return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");
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
CMD:checkbiznis(playerid, params[])
{
	if( (PlayerInfo[playerid][pJob] != TRUCKER_ID)) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijes biti u vozilu!");
	new
		biznis = INVALID_BIZNIS_ID;

	foreach(new i : Bizzes) {
		if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
			biznis = i;
			break;
		}
	}
	if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa / nemas ovlasti za dostavljanje produkata ovom biznisu.");
	if(BizzInfo[biznis][bOwnerID] == 0) return SendClientMessage(playerid,COLOR_RED, "Biznis nema vlasnika.");
	new
		infoString[ 68],
		tmp = 0;
	
	if(BizzInfo[biznis][bPriceProd] == 0) 
		return SendClientMessage(playerid, COLOR_RED, "[ ! ] Biznis nema definiranu cijenu produkata.");
	else 
	{
		format(infoString, sizeof(infoString), "Cijena po produktu: %d", BizzInfo[biznis][bPriceProd]);
		SendClientMessage(playerid, -1,infoString);
	}
	
	new 
		Float:prodammount = BizzInfo[biznis][bTill] / BizzInfo[biznis][bPriceProd],
		RecievingPackages = floatround(prodammount, floatround_floor);
	if(RecievingPackages == 0) 
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Biznis nije spreman primiti nove produkte (Financijska kriza).");
	else
	{
		format(infoString, sizeof(infoString), "[INFO] Bizins je spreman primiti %d paketa produkata.", RecievingPackages);
		SendClientMessage(playerid, -1,infoString);
	}
	if( BizzInfo[biznis][bLocked] )
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Zakljucano");
	else
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Otkljucano");

	for(new i=0;i<=9;i++)
	{
		tmp = i+1;
		if(BizzInfo[biznis][bType] == BIZZ_TYPE_DUCAN)
		{
			format(infoString, sizeof(infoString), "Artikl #%d: %s [%d/%d]",
				tmp,
				GetStoreProductName( BiznisProducts[biznis][bpType][ i ] ),
				BiznisProducts[biznis][bpAmount][ i ],
				BizzInfo[ biznis ][ bMaxProducts ] );
		}
		else if(BizzInfo[biznis][bType] == BIZZ_TYPE_BAR || BizzInfo[biznis][bType] == BIZZ_TYPE_STRIP )
		{
			format(infoString, sizeof(infoString), "Artikl #%d: %s [%d/%d]",
				tmp,
				GetDrinkName( BiznisProducts[biznis][bpType][ i ] ),
				BiznisProducts[biznis][bpAmount][ i ],
				BizzInfo[ biznis ][ bMaxProducts ] );
		}
		SendClientMessage(playerid, -1, infoString);
	}
	return 1;
}
CMD:trucker(playerid, params[])
{
	new
		param[12];
	if( sscanf(params, "s[12] ", param ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /trucker [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: info - start - stop");
		return 1;
	}
	if( !strcmp(param, "info", true) ) {
	    if(PlayerInfo[playerid][pJob] != TRUCKER_ID) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona da biste vidjeli rute!");
		if(!IsVehicleATruck(GetPlayerVehicleID(playerid)) || GetPlayerState(playerid) != 2) return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona da biste vidjeli rute!");
		ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_INFO, DIALOG_STYLE_LIST, "Info o trailerima", "OIL\nHEAVY\nFREEZER\nCONSTRUCTION\nFRAGILE", "Select", "Cancel");
	}
	if( !strcmp(param, "start", true) ) {
		if( (PlayerInfo[playerid][pJob] != TRUCKER_ID)) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
		if(TruckerInfo[playerid][tStarted] >= 1) return SendClientMessage( playerid, COLOR_RED, "Vec ste zapoceli voznju. Da prekinete kucajte /trucker stop!");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");
		if(!IsVehicleATruck(GetPlayerVehicleID(playerid)) || GetPlayerState(playerid) != 2) return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");
		if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
		ShowPlayerDialog(playerid, DIALOG_TRUCKER_SELECT_BIZ, DIALOG_STYLE_LIST, "ODABIR FIRME", "LS Construction Co. (Skill: 400+)\n\
			LS Mechanic Garage (Skill: 400+)\n\
			LS Medical Department (Skill: 400+)\n\
			East LS CarWash (Skill: 200+)\n\
			Idlewood CarWash (Skill: 200+)\n\
			Ganton Gym (Skill: N/A)\n\
			Verona Mall (Skill: 200+)\n\
			Ganton Binco (Skill: N/A)\n\
			Mullholand ZIP (Skill: N/A)", 
		"Select", "Cancel");
	}
	else if( !strcmp(param, "stop", true) ) {
		if( (PlayerInfo[playerid][pJob] != TRUCKER_ID)) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
		if(TruckerInfo[playerid][tStarted] == 0) return SendClientMessage( playerid, COLOR_RED, "Nemate pokrenutu voznju!");
		if(TruckerInfo[playerid][tStarted] == 2)
		{
		    KillTimer(TruckerDeliveryTimer[playerid]);
		    TogglePlayerControllable(playerid, 1);
		}
		TruckerInfo[playerid][tStarted] = 0;
	    TruckerInfo[playerid][tPayCheck] = 0;
	    TruckerInfo[playerid][tUtovarCPx] = 0.0;
	    TruckerInfo[playerid][tUtovarCPy] = 0.0;
	    TruckerInfo[playerid][tUtovarCPz] = 0.0;
	    TruckerInfo[playerid][tIstovarCPx] = 0.0;
	    TruckerInfo[playerid][tIstovarCPy] = 0.0;
	    TruckerInfo[playerid][tIstovarCPz] = 0.0;
	    TruckerInfo[playerid][tDeliveryDetails] = 0;
	    TruckerInfo[playerid][tDeliveryTime] = -100;
		Bit1_Set( gr_IsWorkingJob, playerid, true );
	    DisablePlayerCheckpoint(playerid);
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste zaustavili rutu prevoza tereta.");
	}
	else {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /trucker [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: start - info - hire - stop");
		return 1;
	}
	return 1;
}
CMD:tc(playerid, params[])
{
	#if defined EVENTSTARTED
	SendClientMessage( playerid, COLOR_RED, "** Static **");
	return 1;
	#endif
	new message[64];
	if(sscanf(params,"s[64]", message)) return SendClientMessage(playerid, -1, "[KORISTENJE]: /tchannel [poruka]");
	if( (PlayerInfo[playerid][pJob] != TRUCKER_ID)) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 514 && GetVehicleModel(vehicleid) != 515 && GetVehicleModel(vehicleid) != 403) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kamionu.");
	if(VehicleInfo[vehicleid][vJob] != 15 && VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE) return SendClientMessage(playerid,COLOR_RED, "Morate biti vozac kamiona!");
	new string [104],
		name[MAX_PLAYER_NAME];
    GetPlayerName( playerid, name, sizeof(name) );
	format(string, sizeof(string), "** (%s) %s: %s, over. **", GetPlayerStreet(playerid), name, message);
	SendTruckerMessage(TEAM_BLUE_COLOR, string);
	return 1;
}

CMD:atrailers(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	new ptv[1024];
	format(ptv,1024,"Trailer #1 - OIL - FLINT - id: 6\nTrailer #2 - HEAVY - FLINT - id: 7\nTrailer #3 - FREEZER - FLINT - id: 8\nTrailer #4 - CONSTRUCTION - FLINT - id: 9\nTrailer #5 - FRAGILE - FLINT - id: 10\nTrailer #6\nTrailer #7\nTrailer #8\nTrailer #9\nTrailer #10");
	ShowPlayerDialog(playerid, DIALOG_ATRAILER, DIALOG_STYLE_LIST, "{FBE204}TRUCKER TRAILER", ptv, "Odaberi", "Izadji");
	return 1;
}
