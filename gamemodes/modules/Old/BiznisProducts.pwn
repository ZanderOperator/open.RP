/* 
*	  Business - Products Transport
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI_Coding\y_hooks>

/*
	- Defines & Enums
*/
#define MAX_BIZ_VEHICLES (7)
#define MODEL_SELECTION_BIZCARS (3223)
#define MODEL_SELECTION_BVCOLOR (3224)
#define PRODUCT_ATTACH_OBJECT 	(9)
#define MAX_ORDERED_ITEMS		(10)

enum BIZNIS_VEHICLE_DATA {
	bizVName[14+1],
	bizVModel,
	bizVPrice	
}

static stock 
	BizVehicle[][BIZNIS_VEHICLE_DATA] = {
	{"Pony", 413, 18500},
	{"Mule", 414, 15300},
	{"Rumpo", 440, 13500},
	{"Yankee", 456, 25750},
	{"Benson", 499, 30000},
	{"Boxville ", 609, 17750},
	{"Burrito", 482, 26750}
};

enum WarehouseData {
	whouseName[40],
	Float:wX,
	Float:wY,
	Float:wZ
};

new Warehouses[][WarehouseData] = {
    {"Venice Shop Center", 1123.6459, -1334.0880, 11.8142}, // Warehouse 1
    {"Ocean Docks Warehouse", 2781.6106, -2418.1289, 12.7523}, // Warehouse 2
    {"Dillimore Warehouse", 804.6757,-607.4324,15.9112} // Warehouse 3
};

enum PLAYER_STATS
{
	pProducts,
	pProductType,
	pBizzType
};
new PlayerStats[MAX_PLAYERS][PLAYER_STATS];

enum TRUCK_STATS {
	vProducts[MAX_ORDERED_ITEMS],
	vProductType[MAX_ORDERED_ITEMS],
	vBizzType[MAX_ORDERED_ITEMS]
};
new TruckStats[MAX_VEHICLES][TRUCK_STATS];

/*
	- Vars
*/

new 
	_BizVehicleIndex[MAX_PLAYERS] = {0, ...},
	_BizVehicleColor[MAX_PLAYERS] = {0, ...},
	_WarehouseType[MAX_PLAYERS]	 = {0, ...},
	bool: _WarehouseCP[MAX_PLAYERS] = { (false), ...},
	bool: _BizVehicleEPos[MAX_PLAYERS] = { (false), ...};

/*
	- MySQL
*/

Public:StoreBVehicleInDB(biznis) {
	BizzInfo[biznis][b_VSQLID] = cache_insert_id();
	return (true);
}

/*
	- Functions
*/

ResetBizVars(playerid) {
	_BizVehicleIndex[playerid] = 0;
	_BizVehicleColor[playerid] = 0;
	_BizVehicleEPos[playerid] = (false);
	return (true);
}
/*
BizVehicleSpawn(playerid, biznis) {

	BizzInfo[biznis][b_VehicleID] = AC_CreateVehicle(BizzInfo[biznis][b_VModel], BizzInfo[biznis][b_Vpos][0], BizzInfo[biznis][b_Vpos][1], BizzInfo[biznis][b_Vpos][2],BizzInfo[biznis][b_Vpos][0], BizzInfo[biznis][b_VColor], BizzInfo[biznis][b_VColor], -1, 0);
	ResetVehicleInfo(BizzInfo[biznis][b_VehicleID]);

	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vModel ]	= BizzInfo[biznis][b_VModel];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vParkX ]	= BizzInfo[biznis][b_Vpos][0];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vParkY ]	= BizzInfo[biznis][b_Vpos][1];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vParkZ ]	= BizzInfo[biznis][b_Vpos][2];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vAngle ]	= BizzInfo[biznis][b_Vpos][3];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vColor1 ]	= BizzInfo[biznis][b_VColor];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vColor2 ]	= BizzInfo[biznis][b_VColor];
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vInt ]	= 0;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vViwo ]	= 0;
	
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vFuel ] 	= 100;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vCanStart ]  = 1;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vParts ]     = 0;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vTimesDestroy ] = 0;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vUsage ] 	= VEHICLE_USAGE_NORMAL;
	VehicleInfo[ BizzInfo[biznis][b_VehicleID] ][ vEngineRunning ] = 0;
	
	BizzInfo[biznis][b_VSpawned] = (true);
	ResetVehicleProducts(BizzInfo[biznis][b_VehicleID]);
	
	// Msg.
	new carname[36];
	strunpack(carname, Model_Name(BizzInfo[biznis][b_VModel]));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spawnali vozilo %s za vasu firmu.", carname);
	return (true);
}*/
/*
BizVehiclePark(playerid, biznis) {
	RemovePlayerFromVehicle(playerid);
	
	AC_DestroyVehicle(BizzInfo[biznis][b_VehicleID]);
	ResetVehicleInfo(BizzInfo[biznis][b_VehicleID]);
	BizzInfo[biznis][b_VSpawned] = (false);
	
	// Msg.
	new carname[36];
	strunpack(carname, Model_Name(BizzInfo[biznis][b_VModel]));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste parkirali vozilo %s za vasu firmu.", carname);
	return (true);
}*/

BizVehicleDelete(biznis) {
	new query[64];
	
	BizzInfo[biznis][b_Vehicle] = (false);
	BizzInfo[biznis][b_VSpawned] = (false);
	BizzInfo[biznis][b_VModel] = INVALID_VEHICLE_ID;
	BizzInfo[biznis][b_VColor] = 0;	
	BizzInfo[biznis][b_Vpos][0] = 0;
	BizzInfo[biznis][b_Vpos][1] = 0;
	BizzInfo[biznis][b_Vpos][2] = 0;
	BizzInfo[biznis][b_Vpos][3] = 0;
	
	format(query, 64, "DELETE FROM `server_biznis_vehicles` WHERE id = '%d'", 
		BizzInfo[biznis][b_VSQLID]
	);
	mysql_tquery(g_SQL, query, "", "");
	return (true);
}

BizVehicleBuy(playerid, vehicle_model, price, color) {
	new biznis = PlayerInfo[playerid][pBizzKey];
	
	// Player
	PlayerToBudgetMoney(playerid, price);
	_BizVehicleEPos[playerid] = (true);
	
	// Vehicle
	BizzInfo[biznis][b_Vehicle] = (true);
	BizzInfo[biznis][b_VSpawned] = (false);
	BizzInfo[biznis][b_VModel] = vehicle_model;
	BizzInfo[biznis][b_VColor] = color;	
	BizzInfo[biznis][b_Vpos][0] = BizzInfo[biznis][bEntranceX];
	BizzInfo[biznis][b_Vpos][1] = BizzInfo[biznis][bEntranceY];
	BizzInfo[biznis][b_Vpos][2] = BizzInfo[biznis][bEntranceZ];
	BizzInfo[biznis][b_Vpos][3] = BizzInfo[biznis][bEntranceZ];
	
	// Msg.
	new carname[36];
	strunpack(carname, Model_Name(BizzInfo[biznis][b_VModel]));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili vozilo %s za vasu firmu.", carname);
	SendClientMessage(playerid, COLOR_RED, "[!] - Sada otidjite na mjesto gdje zelite parkirati vase vozilo za firmu i pritisnite 'Y'.");
	
	//mySQL
	new query[ 164 ];
	format(query, sizeof(query), "INSERT INTO `server_biznis_vehicles` (`biznis_id`, `bVehModel`, `bVehColor`) VALUES ('%d','%d','%d')",
		BizzInfo[biznis][bSQLID],
		vehicle_model,
		color
	);
	mysql_tquery(g_SQL, query, "StoreBVehicleInDB", "i", biznis);
	return (true);
}

GetVehicleProdSlot(vehicleid) {
	for(new i = 0; i < MAX_ORDERED_ITEMS; i++) {
		if(TruckStats[vehicleid][vProducts][i] == 0) {
			return i;
		}
	}
	return -1;
}

GetVehicleProducts(vehicleid) {
	new amount = 0;
	for(new i = 0; i < MAX_ORDERED_ITEMS; i++) {
		if(TruckStats[vehicleid][vProducts][i] != 0) {
			amount++;
		}
	}
	return amount;
}
/*
ResetVehicleProducts(vehicleid) {
	for(new i = 0; i < MAX_ORDERED_ITEMS; i++) {
		TruckStats[vehicleid][vProductType][i] = 0;
		TruckStats[vehicleid][vProducts][i] = 0;
		TruckStats[vehicleid][vBizzType][i] = 0;
	}
	return (true);
}
*/
ResetPlayerProducts(playerid) {
	PlayerStats[playerid][pProducts] = 0;
	PlayerStats[playerid][pProductType] = -1;
	PlayerStats[playerid][pBizzType] = 0;
	return (true);
}

/*
	- Hooks
*/

hook OnGameModeInit() {
	// Warehouses - maps by L3o
	CreateDynamicObject(3630, 2787.92847, -2414.96167, 14.06070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3630, 2787.89624, -2418.08228, 14.06070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3630, 2787.89355, -2420.71411, 14.06070,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3630, 2787.34937, -2417.83447, 17.05313,   0.00000, 0.00000, 82.00000);
	CreateDynamicObject(1421, 1127.51123, -1334.57056, 12.58479,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1421, 1125.84619, -1334.57422, 12.58479,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2971, 1120.66980, -1333.91309, 11.73770,   5.00000, 0.00000, 0.00000);
	return (true);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	new bizid = PlayerInfo[playerid][pBusinessJob],
		vehid = getPlayerNearestVehicle(playerid),
		wid = _WarehouseType[playerid];
		
	if( PRESSED(KEY_YES) ) {
		if(_BizVehicleEPos[playerid] == (true)) {
			new Float: X, Float: Y, Float: Z, Float: A,
				biznis = PlayerInfo[playerid][pBizzKey];
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, A);
				
			BizzInfo[biznis][b_Vpos][0] = X;
			BizzInfo[biznis][b_Vpos][1] = Y;
			BizzInfo[biznis][b_Vpos][2] = Z;
			BizzInfo[biznis][b_Vpos][3] = A;
					
			ShowPlayerDialog(playerid, DIALOG_BIZNIS_SPAWNVEHICLE, DIALOG_STYLE_MSGBOX, "{3C95C2}* Biznis - Vehicle Spawn", "\nJeste li sigurni da zelite ovdije postaviti spawn mjesto za vozilo firme?\n{3C95C2}[!] - Jednom kada postavite vise necete moci mjenjati poziciju spawn vozila firme.", "(da)", "Close");
		}
		if(PlayerStats[playerid][pProducts] != 0) {	
				
			if(!IsPlayerInRangeOfPoint(playerid, 10.0, Warehouses[wid][wX], Warehouses[wid][wY], Warehouses[wid][wZ]))
				return (true);
				
			if( PlayerInfo[playerid][pBusinessJob] == -1)	
				return (true);
					
			new freeslot = GetVehicleProdSlot(vehid);
						
			if(IsPlayerInAnyVehicle(playerid)) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijes biti u vozilu.");
					
			/*if(GetVehicleModel(vehid) != BizzInfo[bizid][b_VModel]) 
				return SendClientMessage( playerid, COLOR_RED, "Niste blizu vozila svoje firme.");*/
						
			if(freeslot == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo je puno.");
					
			// Product
			TruckStats[vehid][vProducts][freeslot] = PlayerStats[playerid][pProducts];
			TruckStats[vehid][vProductType][freeslot] = PlayerStats[playerid][pProductType];
			TruckStats[vehid][vBizzType][freeslot]	= PlayerStats[playerid][pBizzType];
			PlayerStats[playerid][pProducts] = 0;
			PlayerStats[playerid][pProductType] = -1;
			PlayerStats[playerid][pBizzType] = 0;
					
			// Msg.
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ostavili kutiju u vase vozilo, trenutno imate %d/%d kutija u vasem vozilu.", 
				GetVehicleProducts(vehid), MAX_ORDERED_ITEMS
			);
					
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT);
		}
		if(PlayerInfo[playerid][pBusinessJob] != -1) {
			new loaded = 0;
			/*if(GetVehicleModel(vehid) != BizzInfo[bizid][b_VModel]) 
				return SendMessage( playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila svoje firme.");*/
				
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, BizzInfo[bizid][bEntranceX], BizzInfo[bizid][bEntranceY], BizzInfo[bizid][bEntranceZ]))
				return (true);
				
			if(IsPlayerInAnyVehicle(playerid)) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijes biti u vozilu.");
					
			if(PlayerStats[playerid][pProducts] != 0) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imas kutiju sa produktima u rukama, ako ju zelite bacit upisite /products drop.");
					
			loaded = 0;
			// Check Truck Slots.
			for(new i = 0; i < MAX_ORDERED_ITEMS; i++) {
				if(TruckStats[vehid][vProducts][i] != 0) {
					PlayerStats[playerid][pProducts] 	= TruckStats[vehid][vProducts][i];
					PlayerStats[playerid][pProductType] = TruckStats[vehid][vProductType][i];
					PlayerStats[playerid][pBizzType]	= TruckStats[vehid][vBizzType][i];
					TruckStats[vehid][vProductType][i] = 0;
					TruckStats[vehid][vProducts][i] = 0;
					TruckStats[vehid][vBizzType][i] = 0;
							
					break;
				}
			}
			// Check Biz Slots.
			for(new i = 0; i < MAX_SALE_PRODUCTS; i++) {
				if(BiznisProducts[bizid][bpType][i] == PlayerStats[playerid][pProductType]) {
					if(PlayerStats[playerid][pProducts] == 0) return (true);
							
					new quantity = 100 - BiznisProducts[bizid][bpAmount][i],
						query[100];
								
					if(PlayerStats[playerid][pProducts] < (quantity))
						(quantity) = PlayerStats[playerid][pProducts];
							
					loaded = 1;
					BiznisProducts[bizid][bpAmount][i] = BiznisProducts[bizid][bpAmount][i] + (quantity);
					PlayerStats[playerid][pProducts] = (0);					
								
					format(query, 100, "UPDATE `server_biznis_products` SET `amount` = '%d' WHERE `id` = '%d'",
						BiznisProducts[bizid][bpAmount][i],
						BiznisProducts[bizid][bpSQLID][i]
					);
					mysql_tquery(g_SQL, query);		
							
							
					if(BizzInfo[bizid][bType] == BIZZ_TYPE_DUCAN)
						SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ubacili %d produkta '%s' u firmu.", quantity, GetStoreProductName(BiznisProducts[bizid][bpType][i]));
					else if(BizzInfo[bizid][bType] == BIZZ_TYPE_BAR)
						SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ubacili %d produkta '%s' u firmu.", quantity, GetDrinkName(BiznisProducts[bizid][bpType][i]));	
				}
			}
			if(loaded == 0) SendMessage(playerid, MESSAGE_TYPE_ERROR, "Produkt koji ste kupili vasa firma ne posjeduje, automatski ste izgubili kutiju produkta."), ResetPlayerProducts(playerid);
		}
	}
	#if defined BP_OnPlayerKeyStateChange
        BP_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #endif
	return (true);
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange BP_OnPlayerKeyStateChange
#if defined BP_OnPlayerKeyStateChange
    forward	BP_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

hook OnPlayerEnterCheckpoint(playerid) {
	if(_WarehouseCP[playerid] == true) {
		DisablePlayerCheckpoint(playerid);
		_WarehouseCP[playerid] = false;
		GameTextForPlayer(playerid, "Warehouse", 3000, 1);
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_BIZNIS_SPAWNVEHICLE: {
			if(response) {
				new query[165];
				_BizVehicleEPos[playerid] = (false);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili poziciju za vase vozilo u firmi, da ga kontrolirate kucajte /products.");
				
				format(query, 165, "UPDATE `server_biznis_vehicles` SET `bVehPos1` = '%f', `bVehPos2` = '%f', `bVehPos3` = '%f', `bVehPos4` = '%f'  WHERE `id` = '%d'",
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][b_Vpos][0],
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][b_Vpos][1],
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][b_Vpos][2],
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][b_Vpos][3],
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][b_VSQLID]
				);
				mysql_tquery(g_SQL, query, "");
			}
		}
		case DIALOG_BIZNIS_BUYVEHICLE: {
			if(!response) 
				return ResetBizVars(playerid);
			if(response) {
				new index = _BizVehicleIndex[playerid];
				
				BizVehicleBuy(playerid, BizVehicle[index][bizVModel], BizVehicle[index][bizVPrice], _BizVehicleColor[playerid]);
			
			}
		}
		case DIALOG_PRODUCTS_LOCATION: {
			if(response) {
				_WarehouseCP[playerid] = (true);
				_WarehouseType[playerid] = (listitem);
				SetPlayerCheckpoint(playerid, Warehouses[listitem][wX], Warehouses[listitem][wY], Warehouses[listitem][wZ], 5.0);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste Warehouse '%s', odite do odredene lokacije i kupite produkte za vasu firmu.", Warehouses[listitem][whouseName]);
			}
		}
		case DIALOG_PRODUCTS_DUCAN: {
			switch( listitem ) {
				case 0:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 1:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 2:{
					if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 150);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 3:{
					if(AC_GetPlayerMoney(playerid) < 90) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 90);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 4:{
					if(AC_GetPlayerMoney(playerid) < 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 50);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 5:{
					if(AC_GetPlayerMoney(playerid) < 55) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 55);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 6:{
					if(AC_GetPlayerMoney(playerid) < 70) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 70);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 7:{
					if(AC_GetPlayerMoney(playerid) < 60) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 60);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 8:{
					if(AC_GetPlayerMoney(playerid) < 60) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 60);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 9:{
					if(AC_GetPlayerMoney(playerid) < 70) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 70);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 10:{
					if(AC_GetPlayerMoney(playerid) < 200) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 200);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 11:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 12:{
					if(AC_GetPlayerMoney(playerid) < 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 50);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 13:{
					if(AC_GetPlayerMoney(playerid) < 350) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 350);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 14:{
					if(AC_GetPlayerMoney(playerid) < 80) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 80);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 15:{
					if(AC_GetPlayerMoney(playerid) < 70) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 70);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 16:{
					if(AC_GetPlayerMoney(playerid) < 120) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 120);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 17:{
					if(AC_GetPlayerMoney(playerid) < 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 50);
					PlayerStats[playerid][pProductType] = PRODUCT_BOOMBOX;
				}
				case 18:{
					if(AC_GetPlayerMoney(playerid) < 25) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 25);
					PlayerStats[playerid][pProductType] = PRODUCT_PCREDIT;
				}
				case 19:{
					if(AC_GetPlayerMoney(playerid) < 40) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 40);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 20:{
					if(AC_GetPlayerMoney(playerid) < 30) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 30);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 21:{
					if(AC_GetPlayerMoney(playerid) < 75) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 75);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 22:{
					if(AC_GetPlayerMoney(playerid) < 80) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 80);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 23:{
					if(AC_GetPlayerMoney(playerid) < 80) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 80);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
			}
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste kutiju kutiju sa produktima '%s'.", GetStoreProductName(PlayerStats[playerid][pProductType]));
			PlayerStats[playerid][pProducts] = 20;
			
			if(PlayerStats[playerid][pProductType] > 99 && PlayerStats[playerid][pProductType] < 104)
				PlayerStats[playerid][pBizzType] = 3;
			else
				PlayerStats[playerid][pBizzType] = 1;
		}
		case DIALOG_PRODUCTS_BAR: {
			switch( listitem ) {
				case 0:{
					if(AC_GetPlayerMoney(playerid) < 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata."); //skoci
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 50);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 1:{
					if(AC_GetPlayerMoney(playerid) < 90) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 90);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 2:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 3:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 4:{
					if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 150);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 5:{
					if(AC_GetPlayerMoney(playerid) < 90) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 90);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 6:{
					if(AC_GetPlayerMoney(playerid) < 250) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 250);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 7:{
					if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 150);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 8:{
					if(AC_GetPlayerMoney(playerid) < 145) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 145);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 9:{
					if(AC_GetPlayerMoney(playerid) < 160) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 160);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 10:{
					if(AC_GetPlayerMoney(playerid) < 160) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 160);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 11:{
					if(AC_GetPlayerMoney(playerid) < 170) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 170);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 12:{
					if(AC_GetPlayerMoney(playerid) < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 100);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 13:{
					if(AC_GetPlayerMoney(playerid) < 200) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 200);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 14:{
					if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 150);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 15:{
					if(AC_GetPlayerMoney(playerid) < 350) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 350);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 16:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 17:{
					if(AC_GetPlayerMoney(playerid) < 170) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 170);
					PlayerStats[playerid][pProductType] = PRODUCT_BOOMBOX;
				}
				case 18:{
					if(AC_GetPlayerMoney(playerid) < 220) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 220);
					PlayerStats[playerid][pProductType] = PRODUCT_PCREDIT;
				}
				case 19:{
					if(AC_GetPlayerMoney(playerid) < 250) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 250);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 20:{
					if(AC_GetPlayerMoney(playerid) < 225) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 225);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 21:{
					if(AC_GetPlayerMoney(playerid) < 140) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 140);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 22:{
					if(AC_GetPlayerMoney(playerid) < 130) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 130);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 23:{
					if(AC_GetPlayerMoney(playerid) < 175) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 175);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 24:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 25:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 26:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 27:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 28:{
					if(AC_GetPlayerMoney(playerid) < 190) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 190);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 29:{
					if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 150);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 30:{
					if(AC_GetPlayerMoney(playerid) < 280) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 280);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 31:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 32:{
					if(AC_GetPlayerMoney(playerid) < 180) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 180);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 33:{
					if(AC_GetPlayerMoney(playerid) < 130) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 130);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
				case 34:{
					if(AC_GetPlayerMoney(playerid) < 280) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za ovu vrstu produkata.");
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerAttachedObject(playerid, PRODUCT_ATTACH_OBJECT, 1271, 5, 0.25, 0.38, -0.00, 0.0, 23.0, 0.0);
					PlayerToBudgetMoney(playerid, 280);
					PlayerStats[playerid][pProductType] = (listitem+100);
				}
			}
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste kutiju kutiju sa produktima '%s'.", GetStoreProductName(PlayerStats[playerid][pProductType]));
			PlayerStats[playerid][pProducts] = 20;
			
			if(PlayerStats[playerid][pProductType] > 99 && PlayerStats[playerid][pProductType] < 104)
				PlayerStats[playerid][pBizzType] = 3;
			else
				PlayerStats[playerid][pBizzType] = 2;
		}
	}
	return(true);
}

hook OnModelSelResponse( playerid, extraid, index, modelid, response ) {
	if ((extraid == MODEL_SELECTION_BIZCARS && response)) {
		new price = BizVehicle[index][bizVPrice], all_colors[256];
			
		if(AC_GetPlayerMoney(playerid) < price) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Cijena ovog vozila je %s.", FormatNumber(price));
		
		for (new i = 0; i < sizeof(all_colors); i ++) {
			all_colors[i] = i;
		}
		ShowColorSelectionMenu(playerid, MODEL_SELECTION_BVCOLOR, all_colors);
		_BizVehicleIndex[playerid] = index;			
	}
	if ((extraid == MODEL_SELECTION_BVCOLOR && response)) { 
		new buffer[256], carname[36];
		strunpack(carname, Model_Name(BizVehicle[_BizVehicleIndex[playerid]][bizVModel]));
		
		_BizVehicleColor[playerid] = modelid;

		format(buffer, sizeof(buffer), "\nJeste li sigurni da zelite kupiti %s za vasu firmu %s?\nCijena ovog vozila iznosi %s, da potvrdite stisnite 'da'.", 
			carname,
			BizzInfo[PlayerInfo[playerid][pBizzKey]][bMessage],
			FormatNumber(BizVehicle[_BizVehicleIndex[playerid]][bizVPrice])
		);
		ShowPlayerDialog(playerid, DIALOG_BIZNIS_BUYVEHICLE, DIALOG_STYLE_MSGBOX, "{3C95C2}* Biznis - Vehicle", buffer, "(da)", "Close");
	}
	return (true);
}

/*
	- Commands
*/

CMD:products(playerid, params[]) {
/*
	new action[18],
		biznis = PlayerInfo[playerid][pBizzKey];
	if(sscanf(params, "s[18] ", action)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /products [opcije].");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] warehouse, order, drop.");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buypark, park, spawn, delete, buyveh, locate, storage.");
		return 1;
	}
	
	if(strcmp(action,"warehouse",(true)) == 0) {	
		new bizid = PlayerInfo[playerid][pBusinessJob];
		
		if( PlayerInfo[playerid][pBusinessJob] == -1 ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
		if( BizzInfo[bizid][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa firma ne posjeduje vozilo za dostavu produkata.");
		if( BizzInfo[bizid][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo firme nije spawnano.");
		
		//Zakomentiraj i dobar
		if(GetPlayerVehicleID(playerid) != BizzInfo[bizid][b_VehicleID])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti u vasem vozilu firme.");
			
		new buffer[256];
		format(buffer, sizeof(buffer), "{3C95C2}[1] - %s.\n{3C95C2}[2] - %s.\n{3C95C2}[3] - %s.", Warehouses[0][whouseName], Warehouses[1][whouseName], Warehouses[2][whouseName]);
		ShowPlayerDialog(playerid, DIALOG_PRODUCTS_LOCATION, DIALOG_STYLE_LIST, "{3C95C2}* Warehouses - Location", buffer, "(odaberi)", "Close");
	}
	
	if(strcmp(action,"drop",(true)) == 0) {	
		new bizid = PlayerInfo[playerid][pBusinessJob];
		
		if( PlayerInfo[playerid][pBusinessJob] == -1 ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
		if( BizzInfo[bizid][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa firma ne posjeduje vozilo za dostavu produkata.");
		if( BizzInfo[bizid][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo firme nije spawnano.");
		
		PlayerStats[playerid][pProducts] 	= 0;
		PlayerStats[playerid][pProductType] = 0;
		PlayerStats[playerid][pBizzType]	= 0;
	}
	
	if(strcmp(action,"order",(true)) == 0) {	
		new bizid = PlayerInfo[playerid][pBusinessJob],
			wid = _WarehouseType[playerid];
		
		if( PlayerInfo[playerid][pBusinessJob] == -1 ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
		if( BizzInfo[bizid][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa firma ne posjeduje vozilo za dostavu produkata.");
		if( BizzInfo[bizid][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo firme nije spawnano.");
		if(IsPlayerInAnyVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti van vozila da ovo koristite.");
		if(!IsPlayerInRangeOfPoint(playerid, 10.0, Warehouses[wid][wX], Warehouses[wid][wY], Warehouses[wid][wZ]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se kod izabranog skladista.");	
			
		if(BizzInfo[bizid][bType] == BIZZ_TYPE_DUCAN) {
			ShowPlayerDialog(playerid, DIALOG_PRODUCTS_DUCAN, DIALOG_STYLE_TABLIST_HEADERS, "SKLADISTE", 
				"Product\tPrice\tAmount\n\
				Voda\t$50\t50\n\
				Pivo\t$90\t50\n\
				Pepsi\t$100\t50\n\
				Coca Cola\t$100\t50\n\
				Vino\t$150\t50\n\
				Cigare\t$55\t50\n\
				Burgeri\t$70\t50\n\
				Torta\t$60\t50\n\
				Hot Dog\t$60\t50\n\
				Pizza\t$70\t50\n\
				Namirnice\t$200\t50\n\
				Maska\t$100\t50\n\
				Cvijece\t$50\t50\n\
				Fotoaparat\t$350\t50\n\
				Palica\t$80\t50\n\
				Spray\t$70\t50\n\
				Toolkit\t$120\t50\n\
				Kazetofon\t$50\t50\n\
				Bon za mobitel\t$25\t50\n\
				Sat\t$40\t50\n\
				Kocka\t$30\t50\n\
				Upaljac\t$75\t50\n\
				Povez\t$80\t50\n\
				Konop\t$80\t50",
				"Buy", "Cancel"
			);
		}
		else if(BizzInfo[bizid][bType] == BIZZ_TYPE_BAR)	{
			ShowPlayerDialog(playerid, DIALOG_PRODUCTS_BAR, DIALOG_STYLE_TABLIST_HEADERS, "SKLADISTE",
				"Product\tPrice\tAmount\n\
				Voda\t$50\t50\n\
				Pivo\t$90\t50\n\
				Pepsi\t$100\t50\n\
				Coca Cola\t$100\t50\n\
				Sprite\t$150\t50\n\
				Sok\t$90\t50\n\
				Svedka Flavors (Vodka)\t$250\t50\n\
				Ketel One (Vodka)\t$150\t50\n\
				Grey Goose (Vodka)\t$145\t50\n\
				Belveredere (Vodka)\t$160\t50\n\
				Bacardi Silver (Rum)\t$160\t50\n\
				Captain Morgan (Rum)\t$170\t50\n\
				Jameson (Viski)\t$100\t50\n\
				Jack Daniels (Viski)\t$200\t50\n\
				Johnnie Walker Black (Viski)\t$150\t50\n\
				Dobel Tequila (Tekila)\t$350\t50\n\
				Avion (Tekila)\t$180\t50\n\
				Patron Silver (Tekila)\t$170\t50\n\
				Korbel Brut (Sampanjac)\t$220\t50\n\
				Veuve Clicquot (Sampanjac)\t$250\t50\n\
				Dom Perignon (Sampanjac)\t$225\t50\n\
				Wild Raspberry Daiquiri (Koktel)\t$140\t50\n\
				Mojito (Koktel)\t$130\t50\n\
				Wild Latina (Koktel)\t$175\t50\n\
				Illusion (Koktel)\t$180\t50\n\
				Tropical Delight (Koktel)\t$180\t50\n\
				Midori Splice (Koktel)\t$180\t50\n\
				Margarita (Koktel)\t$180\t50\n\
				Cosmopolitan (Koktel)\t$190\t50\n\
				Chi Chi (Koktel)\t$150\t50\n\
				Pina Colada (Koktel)\t$280\t50\n\
				Kamikaze (Koktel)\t$180\t50\n\
				Blue Lagoon (Koktel)\t$180\t50\n\
				Viagra (Koktel)\t$130\t50\n\
				Blood Mary (Koktel)\t$280\t50",
				"Buy", "Cancel"
			);
		}
	}
	
	if(strcmp(action,"buyveh",(true)) == 0) {	
		new biz_vehicles[MAX_BIZ_VEHICLES], biz_vehprice[MAX_BIZ_VEHICLES];
		
		if(biznis == INVALID_BIZNIS_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
	
		if( BizzInfo[biznis][b_Vehicle] == (true))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete vozilo za dostavu produkta.");
			
		for(new i = 0; i < sizeof(BizVehicle); i++) {
			biz_vehicles[i] = BizVehicle[i][bizVModel];
			biz_vehprice[i] = BizVehicle[i][bizVPrice];
		}	
		ShowModelESelectionMenu(playerid, "Biz Vehicle", MODEL_SELECTION_BIZCARS, biz_vehicles, MAX_BIZ_VEHICLES, -16.0, 0.0, -55.0, 0.9, 1, (true), biz_vehprice);			
	}
	
	if(strcmp(action,"spawn",(true)) == 0) {	
		
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		if( BizzInfo[biznis][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete vozilo za dostavu produkta.");
		if( BizzInfo[biznis][b_VSpawned] == (true))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste spawnali vozilo za dostavu produkta.");	
			
		BizVehicleSpawn(playerid, biznis);
	}
	
	if(strcmp(action, "delete",(true)) == 0) {
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		if( BizzInfo[biznis][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete vozilo za dostavu produkta.");
		if( BizzInfo[biznis][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste spawnali vozilo za dostavu produkta.");	
			
		BizVehicleDelete(biznis);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali svoje biznis vozilo, sada mozete kupiti novo.");
	}
	
	if(strcmp(action, "park",(true)) == 0) {
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		if( BizzInfo[biznis][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete vozilo za dostavu produkta.");
		if( BizzInfo[biznis][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste spawnali vozilo za dostavu produkta.");	
			
		BizVehiclePark(playerid, biznis);
	}
	
	if(strcmp(action, "buypark",(true)) == 0) {
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		if( BizzInfo[biznis][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete vozilo za dostavu produkta.");
		if( BizzInfo[biznis][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste spawnali vozilo za dostavu produkta.");	
			
		new Float: X, Float: Y, Float: Z, Float: A, query[165];
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);
				
		BizzInfo[biznis][b_Vpos][0] = X;
		BizzInfo[biznis][b_Vpos][1] = Y;
		BizzInfo[biznis][b_Vpos][2] = Z;
		BizzInfo[biznis][b_Vpos][3] = A;
		
		// mysql 
		format(query, 165, "UPDATE `server_biznis_vehicles` SET `bVehPos1` = '%f', `bVehPos2` = '%f', `bVehPos3` = '%f', `bVehPos4` = '%f'  WHERE `id` = '%d'",
			BizzInfo[ biznis ][b_Vpos][0],
			BizzInfo[ biznis ][b_Vpos][1],
			BizzInfo[ biznis ][b_Vpos][2],
			BizzInfo[ biznis ][b_Vpos][3],
			BizzInfo[ biznis ][b_VSQLID]
		);
		mysql_tquery(g_SQL, query, "");
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promijenili spawn mjesto za vase vozilo.");
	}
	
	if(strcmp(action, "storage", (true)) == 0) {
		new bizid = PlayerInfo[playerid][pBusinessJob];
		
		if( PlayerInfo[playerid][pBusinessJob] == -1 ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
	
		if( Bit1_Get( gr_PlayerLocateVeh, playerid ) ) {
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~r~gps offline", 2000, 1);
			Bit1_Set( gr_PlayerLocateVeh, playerid, (false) );
			return (true);
		}
		Bit1_Set( gr_PlayerLocateVeh, playerid, (true) );	

		SetPlayerCheckpoint(playerid, BizzInfo[bizid][bEntranceX], BizzInfo[bizid][bEntranceY], BizzInfo[bizid][bEntranceZ], 5.0);
		GameTextForPlayer(playerid, "~g~storage located", 2000, 1);
	}
	
	if(strcmp(action, "locate",(true)) == 0) {
		new Float:Pos[3], Float:z;
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		if( BizzInfo[biznis][b_Vehicle] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete vozilo za dostavu produkta.");
		if( BizzInfo[biznis][b_VSpawned] == (false))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste spawnali vozilo za dostavu produkta.");	
			
		if( Bit1_Get( gr_PlayerLocateVeh, playerid ) ) {
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~r~gps offline", 2000, 1);
			Bit1_Set( gr_PlayerLocateVeh, playerid, (false) );
			return (true);
		}
		Bit1_Set( gr_PlayerLocateVeh, playerid, (true) );	
		GetVehiclePos(BizzInfo[biznis][b_VehicleID], Pos[0], Pos[1], Pos[2]);
		z = Pos[2] - 0.5;
		SetPlayerCheckpoint(playerid, Pos[0], Pos[1], z, 5.0);
		GameTextForPlayer(playerid, "~g~vehicle located", 2000, 1);
	}
	*/
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Privremeno izbaceno");
	return (true);
}
