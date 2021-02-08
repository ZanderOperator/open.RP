#include <YSI_Coding\y_hooks>

/*

  ,ad8888ba,                                                       
 d8"'    `"8b                                     ,d               
d8'                                               88               
88             ,adPPYba,  8b,dPPYba,  ,adPPYba, MM88MMM ,adPPYba,  
88            a8"     "8a 88P'   `"8a I8[  ""   88    I8[  ""  
Y8,           8b       d8 88       88  `"Y8ba,    88     `"Y8ba,   
 Y8a.    .a8P "8a,   ,a8" 88       88 aa  ]8I   88,   aa  ]8I  
  `"Y8888Y"'   `"YbbdP"'  88       88 `"YbbdP"'   "Y888 `"YbbdP"' 

*/

const MAX_ILLEGAL_GARAGES		= 10;
const DESTROYING_CAR_TIME		= 45; 		// 45 seconds
const LIST_UPDATE_TIME			= 3600; 	// 1 hour
const CHOP_SHOP_PRICE			= 60000; 	// 60,000$

/*

8b           d8                                
`8b         d8'                                
 `8b       d8'                                 
  `8b     d8' ,adPPYYba, 8b,dPPYba, ,adPPYba,  
   `8b   d8'  ""     `Y8 88P'   "Y8 I8[  ""  
    `8b d8'   ,adPPPPP88 88          `"Y8ba,   
     `888'    88,    ,88 88         aa  ]8I  
      `8'     `"8bbdP"Y8 88         `"YbbdP"'  

*/
                                               

static
	Iterator:IllegalGarage<MAX_ILLEGAL_GARAGES>;

enum E_ILLEGAL_GARAGES 
{
	igSQLID,
	igName[32],
	igOwner,
	igVehicleIds[6],
	igMoney,
	igBoard,
	igHeader,
	igText[6],
	igCarsJacked,
	igWantedLevel,
	Text3D:ig3dText,
	Float:ig3dTextPos[4]
}
static
	IllegalGarage[MAX_ILLEGAL_GARAGES][E_ILLEGAL_GARAGES];
	
static 
	IllegalGarageStamp = 0,
	PlayerText:JackerTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	DestroyedCar[MAX_PLAYERS],
	JackerIllegalGarage[MAX_PLAYERS],
	Timer:DestroyingCarTimer[MAX_PLAYERS],
	DestroyingCarCount[MAX_PLAYERS],
	PlayerBribeMoney[MAX_PLAYERS],
	PlayerJackingCar[MAX_PLAYERS],
	EditingBoardID[MAX_PLAYERS];

/*
																							
88888888888                                        88                                    
88                                           ,d    ""                                    
88                                           88                                          
88aaaaa 88       88 8b,dPPYba,   ,adPPYba, MM88MMM 88  ,adPPYba,  8b,dPPYba,  ,adPPYba,  
88""""" 88       88 88P'   `"8a a8"     ""   88    88 a8"     "8a 88P'   `"8a I8[  ""  
88      88       88 88       88 8b           88    88 8b       d8 88       88  `"Y8ba,   
88      "8a,   ,a88 88       88 "8a,   ,aa   88,   88 "8a,   ,a8" 88       88 aa  ]8I  
88       `"YbbdP'Y8 88       88  `"Ybbd8"'   "Y888 88  `"YbbdP"'  88       88 `"YbbdP"'  
                                                                                         
*/

task IllegalGarageUpdate[1000]()
{
	if(Iter_Count(IllegalGarage) == 0)
		return 1;

	if(gettimestamp() >= IllegalGarageStamp)
	{
		IllegalGarageStamp = gettimestamp() + LIST_UPDATE_TIME;
		foreach(new i_garage: IllegalGarage)
			UpdateIllegalGarage(i_garage);
	}
	return 1;
}

static ResetIllegalGarage(garage)
{
	if(Iter_Contains(IllegalGarage, garage))
		Iter_Remove(IllegalGarage, garage);

	IllegalGarage[garage][igSQLID] = -1;
	IllegalGarage[garage][igName][0] = EOS;
	IllegalGarage[garage][igOwner] = 0;

	if(IsValidDynamicObject(IllegalGarage[garage][igBoard]))
		DestroyDynamicObject(IllegalGarage[garage][igBoard]);
	if(IsValidDynamicObject(IllegalGarage[garage][igHeader]))
		DestroyDynamicObject(IllegalGarage[garage][igHeader]);
	for(new i = 0; i < 6; i++)
	{
		IllegalGarage[garage][igVehicleIds][i] = -1;
		if(IsValidDynamicObject(IllegalGarage[garage][igText][i]))
			DestroyDynamicObject(IllegalGarage[garage][igText][i]);
	}
	if(IsValidDynamic3DTextLabel(IllegalGarage[garage][ig3dText]))
		DestroyDynamic3DTextLabel(IllegalGarage[garage][ig3dText]);

	IllegalGarage[garage][igMoney] = 0;
	IllegalGarage[garage][igCarsJacked] = 0;
	IllegalGarage[garage][igWantedLevel] = 0;
	IllegalGarage[garage][ig3dTextPos][0] = 0.0;
	IllegalGarage[garage][ig3dTextPos][1] = 0.0;
	IllegalGarage[garage][ig3dTextPos][2] = 0.0;
	IllegalGarage[garage][ig3dTextPos][3] = 0.0;
	return 1;
}

GetIllegalGarageFromSQL(sqlid)
{
	new
		garageid = -1;
	foreach(new igarage : IllegalGarage)
	{
		if(IllegalGarage[igarage][igOwner] == sqlid)
		{
			garageid = igarage;
			break;
		}
	}
	return garageid;
}

static DeleteIllegalGarage(garage)
{
	mysql_fquery(g_SQL,
		"DELETE FROM illegal_garages WHERE id = '%d'",
		IllegalGarage[garage][igSQLID]
	);
	ResetIllegalGarage(garage);
}

static CreateIllegalGarage(garage)
{
	inline OnIllegalGarageCreated()
	{
		IllegalGarage[garage][igSQLID] = cache_insert_id();
		Iter_Add(IllegalGarage, garage);
		InitIllegalGarage(garage);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline OnIllegalGarageCreated, 
		va_fquery(g_SQL,
			"INSERT INTO illegal_garages (owner, name, jackedcars, wantedlevel, 3dtextX, 3dtextY, 3dtextZ, rotZ) \n\
				VALUES ('0', '%e', '0', '0', '%f', '%f', '%f', '%f')",
			IllegalGarage[garage][igName],
			IllegalGarage[garage][ig3dTextPos][0],
			IllegalGarage[garage][ig3dTextPos][1],
			IllegalGarage[garage][ig3dTextPos][2],
			IllegalGarage[garage][ig3dTextPos][3]
		),
		"i",
		garage
	);
	return 1;
}

static LoadIllegalGarages()
{
	Iter_Init(IlegalGarage);
	inline OnIllegalGaragesLoad()
	{
		if(!cache_num_rows()) 
			return print("MySQL Report: No Illegal Garages exist to load.");
		
		for(new row = 0; row < cache_num_rows(); row++) 
		{
			cache_get_value_name_int(row, 		"id"		, IllegalGarage[row][igSQLID]);
			cache_get_value_name_int(row, 		"owner"		, IllegalGarage[row][igOwner]);
			cache_get_value_name(row, 			"name"		, IllegalGarage[row][igName], 32);
			cache_get_value_name_int(row, 		"jackedcars", IllegalGarage[row][igCarsJacked]);
			cache_get_value_name_int(row, 		"wantedlevel",IllegalGarage[row][igWantedLevel]);
			cache_get_value_name_float(row, 	"3dtextX"	, IllegalGarage[row][ig3dTextPos][0]);
			cache_get_value_name_float(row, 	"3dtextY"	, IllegalGarage[row][ig3dTextPos][1]);
			cache_get_value_name_float(row, 	"3dtextZ"	, IllegalGarage[row][ig3dTextPos][2]);
			cache_get_value_name_float(row, 	"rotZ"		, IllegalGarage[row][ig3dTextPos][2]);
			InitIllegalGarage(row);
			Iter_Add(IllegalGarage, row);
		}
		printf("MySQL Report: Illegal Garages Loaded. [%d/%d]", cache_num_rows(), MAX_ILLEGAL_GARAGES);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline OnIllegalGaragesLoad,
		va_fquery(g_SQL, "SELECT * FROM illegal_garages"),
		""
	);
	return 1;
}

static CheckGarageWantedLevel(garage, bool:save=false)
{
	new
		tmpStars[5];
	tmpStars = "None";
	switch( IllegalGarage[garage][igCarsJacked]) 
	{
		case 55 .. 95:   
		{ 
			IllegalGarage[garage][igWantedLevel] = 1; 
			tmpStars = "*";   
		}
		case 96 .. 136:  
		{ 
			IllegalGarage[garage][igWantedLevel] = 2; 
			tmpStars = "**";  
		}
		case 137 .. 177: 
		{ 
			IllegalGarage[garage][igWantedLevel] = 3; 
			tmpStars = "***"; 
		}
	}
	if(!save) 
	{
		mysql_fquery(g_SQL, "UPDATE illegal_garages SET wantedlevel = '%d' WHERE id = '%d'", 
			IllegalGarage[garage][igWantedLevel], 
			IllegalGarage[garage][igSQLID]
		);
	}
	new
		tmpString[135];		
	format(tmpString, 
		135, 
		""COL_LIGHTBLUE"%s\n\
			==============="COL_WHITE"%s\n\
			"COL_LIGHTBLUE"\n===============\n"COL_LIGHTBLUE"%d$\n===============\n\
			"COL_WHITE"%s", 
		IllegalGarage[garage][igName],
		tmpStars,
		IllegalGarage[garage][igMoney],
		(
			(IllegalGarage[garage][igOwner] != 0) ? 
			(ConvertSQLIDToName(IllegalGarage[garage][igOwner])) 
			: ("On sell (/garage buy)")
		)
	);
	UpdateDynamic3DTextLabelText(IllegalGarage[garage][ig3dText], -1, tmpString);
}

static bool: IsVehicleJackable(carid)
{
	new 
		bool: value = true;
	if(!LandVehicles[carid][viCarJackerPrice])
		value = false;
	return value;
}

static bool:IsVehicleOnList(garage, index)
{
	if(!Iter_Contains(IllegalGarage, garage))
		return false;
	
	new
		bool:value = false;
	for(new i = 0; i < 6; i++) 
	{
		if(IllegalGarage[garage][igVehicleIds][i] == index) 
		{
			value = true;
			break;
		}
	}
	return value;
}

static GetVehiclesForIllegalGarages(garage)
{
	if(!Iter_Contains(IllegalGarage, garage))
		return 0;
	
	new
		Float: bX = IllegalGarage[garage][ig3dTextPos][0],
		Float: bY = IllegalGarage[garage][ig3dTextPos][1] - 1.0,
		Float: hZ = IllegalGarage[garage][ig3dTextPos][2] + 2.0, // Header board text - "Wanted List"
		Float: rotZ = IllegalGarage[garage][ig3dTextPos][3] - 90.0; 

	if(CountVehicleModels() < 6)
	{
		if(IsValidDynamicObject(IllegalGarage[garage][igHeader]))
			DestroyDynamicObject(IllegalGarage[garage][igHeader]);
		IllegalGarage[garage][igHeader] = CreateDynamicObject(18659, bX, bY, hZ, 0.000, 0.000, rotZ, -1, -1, -1, 300.000, 300.000);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igHeader], 0, "Not recieving vehicles!", 140, "courier", 42, 1, -1, 0, 1);
		return 0;
	}
	new 
		vehid, 
		carid;

	for(new i = 0; i < 6; i++) 
    {
        do 
		{
            vehid = Vehicle_Random(VEHICLE_USAGE_PRIVATE),
            carid = GetVehicleByModel(GetVehicleModel(vehid));    
        }
        while(
            carid == -1 ||
            IsABike(GetVehicleModel(vehid)) || 
            IsABoat(GetVehicleModel(vehid)) || 
            IsAMotorBike(GetVehicleModel(vehid)) ||
            IsAPlane(GetVehicleModel(vehid)) ||
            IsAHelio(GetVehicleModel(vehid)) ||
            !IsVehicleJackable(carid) ||
            IsVehicleOnList(garage, carid)
        );
        IllegalGarage[garage][igVehicleIds][i] = carid;
    }
	return 1;
}

static UpdateIllegalGarage(garage)
{
	for(new i = 0; i < 6; i++)
		IllegalGarage[garage][igVehicleIds][i] = -1;
	
	if(!GetVehiclesForIllegalGarages(garage))
		return 1;
	new 
		Float: bY = IllegalGarage[garage][ig3dTextPos][1] - 1.0,	// Y of the board object
		Float: ltX = IllegalGarage[garage][ig3dTextPos][0] - 0.8, // Left aligned board text
		Float: rtX = IllegalGarage[garage][ig3dTextPos][0] + 0.8, // Right aligned board text
		Float: Z1 = IllegalGarage[garage][ig3dTextPos][2] + 1.5, // First row of board text
		Float: Z2 = IllegalGarage[garage][ig3dTextPos][2] + 1.0, // Second row of board text
		Float: Z3 = IllegalGarage[garage][ig3dTextPos][2] + 0.5, // Third row of board text
		Float: rotZ = IllegalGarage[garage][ig3dTextPos][3] - 90.0;
	new 
		vehicleName[MAX_VEHICLE_NAME];
	
	// Left side of the board texts
	if(IsValidDynamicObject(IllegalGarage[garage][igText][0])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][0]);
		IllegalGarage[garage][igText][0] = CreateDynamicObject(18659, ltX, bY, Z1, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][0]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][0], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if(IsValidDynamicObject(IllegalGarage[garage][igText][1])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][1]);
		IllegalGarage[garage][igText][1] = CreateDynamicObject(18659, ltX, bY, Z2, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][1]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][1], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if(IsValidDynamicObject(IllegalGarage[garage][igText][2])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][2]);
		IllegalGarage[garage][igText][2] = CreateDynamicObject(18659, ltX, bY, Z3, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][2]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][2], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	// Right side of the board texts
	if(IsValidDynamicObject(IllegalGarage[garage][igText][3])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][3]);
		IllegalGarage[garage][igText][3] = CreateDynamicObject(18659, rtX, bY, Z1, 0.000, 0.000, rotZ, -1, -1, -1,300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][3]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][3], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if(IsValidDynamicObject(IllegalGarage[garage][igText][4])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][4]);
		IllegalGarage[garage][igText][4] = CreateDynamicObject(18659, rtX, bY, Z2, 0.000, 0.000, rotZ, -1, -1,-1, 300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][4]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][4], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if(IsValidDynamicObject(IllegalGarage[garage][igText][5])) 
	{
		DestroyDynamicObject(IllegalGarage[garage][igText][5]);
		IllegalGarage[garage][igText][5] = CreateDynamicObject(18659, rtX, bY, Z3, 0.000, 0.000, rotZ, -1, -1, -1, 300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[IllegalGarage[garage][igVehicleIds][5]][viModelid], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[garage][igText][5], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	return 1;
}

static InitIllegalGarage(garage)
{ 	
	new
		Float: bX = IllegalGarage[garage][ig3dTextPos][0],
		Float: bY = IllegalGarage[garage][ig3dTextPos][1] - 1.0,
		Float: bZ = IllegalGarage[garage][ig3dTextPos][2] - 1.0,
		Float: brZ = IllegalGarage[garage][ig3dTextPos][3];

	if(!IsValidDynamicObject(IllegalGarage[garage][igBoard]))
		IllegalGarage[garage][igBoard] = CreateDynamicObject(3077, bX, bY, bZ, 0.000, 0.000, brZ, -1,- 1, -1,300.000, 300.000);
		
	// Total: 6 board texts in 3 rows on jacker board
	new 
		Float: ltX = IllegalGarage[garage][ig3dTextPos][0] - 0.8, // Left aligned board text
		Float: rtX = IllegalGarage[garage][ig3dTextPos][0] + 0.8, // Right aligned board text
		Float: hZ = IllegalGarage[garage][ig3dTextPos][2] + 2.0, // Header board text - "Wanted List"
		Float: Z1 = IllegalGarage[garage][ig3dTextPos][2] + 1.5, // First row of board text
		Float: Z2 = IllegalGarage[garage][ig3dTextPos][2] + 1.0, // Second row of board text
		Float: Z3 = IllegalGarage[garage][ig3dTextPos][2] + 0.5, // Third row of board text
		Float: rotZ = IllegalGarage[garage][ig3dTextPos][3] - 90.0; 
	
	IllegalGarage[garage][igHeader] = CreateDynamicObject(18659, bX, bY, hZ, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igHeader], 0, "Wanted List", 140, "courier", 42, 1, -1, 0, 1);
	
	// Left column 
	IllegalGarage[garage][igText][0] = CreateDynamicObject(18659, ltX, bY, Z1, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][0], 0, "1", 140, "courier", 38, 1, -1, 0, 1);	
	IllegalGarage[garage][igText][1] = CreateDynamicObject(18659, ltX, bY, Z2, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][1], 0, "2", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[garage][igText][2] = CreateDynamicObject(18659, ltX, bY, Z3, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][2], 0, "3", 140, "courier", 38, 1, -1, 0, 1);
	
	// Right column
	IllegalGarage[garage][igText][3] = CreateDynamicObject(18659, rtX, bY, Z1, 0.000, 0.000, rotZ, -1, -1, -1,300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][3], 0, "4", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[garage][igText][4] = CreateDynamicObject(18659, rtX, bY, Z2, 0.000, 0.000, rotZ, -1, -1,-1, 300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][4], 0, "5", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[garage][igText][5] = CreateDynamicObject(18659, rtX, bY, Z3, 0.000, 0.000, rotZ, -1, -1, -1, 300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[garage][igText][5], 0, "6", 140, "courier", 38, 1, -1, 0, 1);
	UpdateIllegalGarage(garage);
	IllegalGarage[garage][ig3dText] = CreateDynamic3DTextLabel("*", -1, IllegalGarage[garage][ig3dTextPos][0], IllegalGarage[garage][ig3dTextPos][1], IllegalGarage[garage][ig3dTextPos][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 30.0);
	CheckGarageWantedLevel(garage);
	return 1;
}

static IllegalGarageToPlayerMoney(playerid, garage, money)
{
	new
		safemoney = floatround(floatabs(money));	
	IllegalGarage[garage][igMoney] -= safemoney;
	mysql_fquery(g_SQL,
		"UPDATE illegal_garages SET money = '%d' WHERE id = '%d'",
		IllegalGarage[garage][igMoney],
		IllegalGarage[garage][igSQLID]
	);
	AC_GivePlayerMoney(playerid, safemoney);
	return 1;
}

static PlayerToIllegalGarageMoney(playerid, garage, money)
{
	new
		safemoney = floatround(floatabs(money));	
	IllegalGarage[garage][igMoney] += safemoney;
	mysql_fquery(g_SQL,
		"UPDATE illegal_garages SET money = '%d' WHERE id = '%d'",
		IllegalGarage[garage][igMoney],
		IllegalGarage[garage][igSQLID]
	);
	AC_GivePlayerMoney(playerid, -safemoney);
	return 1;
}

static ResetCarJackerVariables(playerid)
{
	DestroyJackerTextDraw(playerid);
	
	DestroyedCar[playerid]			= -1;
	PlayerJackingCar[playerid]		= -1;
	JackerIllegalGarage[playerid]		= -1;
	stop DestroyingCarTimer[playerid];
	DestroyingCarCount[playerid] 		= -1;
	EditingBoardID[playerid] 			= -1;
	return 1;
}

static IsVehicleMission(playerid, modelid)
{
	return (LandVehicles[PlayerJackingCar[playerid]][viModelid] == modelid ? 1 : 0);
}

timer DestroyingCar[1000](playerid, vehicleid)
{
	if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 18.0)) 
	{
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Chopping process is stopped because you were too far from vehicle!");
		return 1;			
	}
	DestroyingCarCount[playerid] -= 1;	
	va_PlayerTextDrawSetString(playerid, 
		JackerTD[playerid], 
		"~w~Disassembling %s in process~r~... ~n~~w~Time Left: ~r~%d sec",
		ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid]),
		DestroyingCarCount[playerid]
	);
	if(DestroyingCarCount[playerid] <= 0) 
	{
		new 
			panels, doors, lights, tires,
			front_left_panel, front_right_panel, rear_left_panel, rear_right_panel, windshield, front_bumper, rear_bumper,
			bonnet, boot, 
			driver_door, passenger_door, light1, light2, 
			light3, light4, tire1, tire2, tire3, tire4;

		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		decode_panels(panels,front_left_panel, front_right_panel, rear_left_panel, rear_right_panel, windshield, front_bumper, rear_bumper);
		decode_doors(doors, bonnet, boot, driver_door, passenger_door);
		decode_lights(lights, light1, light2, light3, light4);
		decode_tires(tires, tire1, tire2, tire3, tire4);
		new
			skillmoney = ((GetPlayerSkillLevel(playerid) + 2) * 10),
			garage = JackerIllegalGarage[playerid],
			decrease = front_left_panel + front_right_panel + rear_left_panel + rear_right_panel + windshield + front_bumper + rear_bumper + bonnet + boot + driver_door + passenger_door + light1 + light2 + light3 + light4 + tire1 + tire2 + tire3 + tire4,
			value = ( ( LandVehicles[PlayerJackingCar[playerid]][viCarJackerPrice] + skillmoney)  - ( decrease * 15));
		
		IllegalGarage[garage][igCarsJacked]++;
		
		mysql_fquery(g_SQL, "UPDATE illegal_garages SET jackedcars = '%d' WHERE id = '%d'", 
			IllegalGarage[garage][igCarsJacked], 
			IllegalGarage[garage][igSQLID]
		);
		
		VehicleInfo[vehicleid][vPanels]		= encode_panels(1, 1, 1, 1, 3, 3, 3); 
		VehicleInfo[vehicleid][vDoors]		= encode_doors(4, 4, 4, 4, 0, 0);
		VehicleInfo[vehicleid][vLights]		= encode_lights(1, 1, 1, 1);
		VehicleInfo[vehicleid][vTires]		= encode_tires(1, 1, 1, 1);
		UpdateVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][vPanels], VehicleInfo[vehicleid][vDoors], VehicleInfo[vehicleid][vLights], VehicleInfo[vehicleid][vTires]);
		VehicleInfo[vehicleid][vTrunk] = VEHICLE_PARAMS_ON;
		SetVehicleHealth(vehicleid, 388);
	
		SendPoliceAlertMessage(vehicleid, garage);
		DestroyedCar[playerid] = GetVehicleModel(vehicleid);

		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		
		SendFormatMessage(playerid,
			MESSAGE_TYPE_INFO,
			"You have sucessfully dissasembled %s. Hide the vehicle to prevent police from finding about the garage!",
			ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid])
		);	

		IllegalGarageToPlayerMoney(playerid, garage, value);

		IllegalGarage[garage][igMoney] += (LandVehicles[PlayerJackingCar[playerid]][viCarJackerPrice] * 3);
		mysql_fquery(g_SQL,
			"UPDATE illegal_garages SET money = '%d' WHERE id = '%d'",
			IllegalGarage[garage][igMoney],
			IllegalGarage[garage][igSQLID] 
		);
				
		va_SendClientMessage(playerid, 
			COLOR_GREEN, 
			"[!]: Zavrsili ste %s jacker misiju i zaradili %s.", 
			ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid]),
			FormatNumber(value)
		);
				
		PlayerJackingCar[playerid] = -1;
		PlayerCoolDown[playerid][pJackerCool] = gettimestamp() + 3600; 
		CheckGarageWantedLevel(garage, true);
		UpgradePlayerSkill(playerid);
	}
	return 1;
}

static GetJackerIllegalGarage(playerid)
{
	new
		index = -1;
	foreach(new garage: IllegalGarage)
	{
		if(IsPlayerInRangeOfPoint(playerid, 
			20.0, 
			IllegalGarage[garage][ig3dTextPos][0], 
			IllegalGarage[garage][ig3dTextPos][1], 
			IllegalGarage[garage][ig3dTextPos][2])) 
		{
			index = garage;
			break;
		}
	}
	return index;
}

static SendPoliceAlertMessage(vehicleid, garage)
{
	if(IllegalGarage[garage][igWantedLevel] < 2) 
	{
		switch(random(5))
		{  
			case 0,2,4: return 1; // 20% risk of police being alerted
		}
	} 
	foreach(new playerid : Player) 
	{
		if(!IsACop(playerid)) 
			continue;
			
		SendClientMessage(playerid, 
			COLOR_LIGHTBLUE, 
			"*________________________ [VEHICLE CHOPPING] ________________________*"
		);
		va_SendClientMessage(playerid, -1, "\tModel: %s", ReturnVehicleName(VehicleInfo[vehicleid][vModel]));
		va_SendClientMessage(playerid, -1, "\tVehicle color: %d %d", 
			VehicleInfo[vehicleid][vColor1], 
			VehicleInfo[vehicleid][vColor2]
		);
		va_SendClientMessage(playerid, -1, "\tLocation: %s", GetVehicleZone(vehicleid));
		SendClientMessage(playerid, 
			COLOR_LIGHTBLUE, 
			"*____________________________________________________________________*"
		);
	}
	return 1;
}

static DestroyJackerTextDraw(playerid)
{
	if(JackerTD[playerid] != PlayerText:INVALID_TEXT_DRAW) 
	{
		PlayerTextDrawDestroy( playerid, JackerTD[playerid]);
		JackerTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

static CreateJackerTextDraw(playerid)
{
	DestroyJackerTextDraw(playerid);
	JackerTD[playerid] = CreatePlayerTextDraw(playerid, 100.0, 310.0, "              ");
    PlayerTextDrawFont(playerid, 		JackerTD[playerid], 2);
    PlayerTextDrawLetterSize(playerid, 	JackerTD[playerid], 0.249, 1.000000);
    PlayerTextDrawSetShadow(playerid, 	JackerTD[playerid], 1);
	PlayerTextDrawShow(playerid, 		JackerTD[playerid]);
	return 1;
}

/*
                                                          
88        88                         88                   
88        88                         88                   
88        88                         88                   
88aaaaaaaa88  ,adPPYba,   ,adPPYba,  88   ,d8  ,adPPYba,  
88""""""""88 a8"     "8a a8"     "8a 88 ,a8"   I8[  ""  
88        88 8b       d8 8b       d8 8888[    `"Y8ba,   
88        88 "8a,   ,a8" "8a,   ,a8" 88`"Yba,  aa  ]8I  
88        88  `"YbbdP"'   `"YbbdP"'  88   `Y8a `"YbbdP"'  
															
*/

hook function LoadServerData()
{
	LoadIllegalGarages();
	return continue();
}

hook OnGameModeInit()
{
	CreateDynamicObject(11387,2526.132,-2425.633,15.899,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11390,2530.332,-2407.504,16.910,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11389,2530.364,-2407.572,15.679,0.000,0.000,-43.499,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11393,2530.058,-2414.572,14.176,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11391,2518.897,-2407.879,13.898,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11388,2530.358,-2407.478,19.326,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11359,2515.739,-2416.442,14.674,0.000,0.000,-43.300,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11360,2539.552,-2411.309,14.714,0.000,0.000,136.499,-1,-1,-1,300.000,300.000);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 3707, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2546.046, -2396.593, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2571.164, -2421.132, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3707, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2546.046, -2396.593, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2571.164, -2421.132, 13.171, 0.250);
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetCarJackerVariables(playerid);
	return continue(playerid);
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(EditingBoardID[playerid] != -1)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);

		new 
			garage = EditingBoardID[playerid];
		if(response == EDIT_RESPONSE_FINAL)
		{
			IllegalGarage[garage][ig3dTextPos][0]	= x;
			IllegalGarage[garage][ig3dTextPos][1] = y - 1.0;
			IllegalGarage[garage][ig3dTextPos][2] = z - 1.0;
			IllegalGarage[garage][ig3dTextPos][3] = rz;
			
			CreateIllegalGarage(garage);

			SendAdminMessage(COLOR_RED, 
				"AdmCMD: %s has created Illegal Garage %s[ID %d].",
				IllegalGarage[garage][igName],
				garage
			);
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have sucessfully created Illegal Garage %s[ID %d].", 
				IllegalGarage[garage][igName],
				garage
			);
	
			EditingBoardID[playerid] = -1;

			SendFormatMessage(playerid,
				MESSAGE_TYPE_SUCCESS,
				"You have sucessfully created Illegal Garage %s!",
				IllegalGarage[garage][igName]
			);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			ResetIllegalGarage(garage);
			EditingBoardID[playerid] = -1;
			SendMessage(playerid, MESSAGE_TYPE_INFO, "You have aborted Illegal Garage creation.");
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_JACKER_PICK:
	    {
	        if(!response)
			{
				JackerIllegalGarage[playerid] = -1;
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "You aborted picking a Jacker Mission");
				return 1;
			}	        
            new
				garage = JackerIllegalGarage[playerid],
				carid = IllegalGarage[garage][igVehicleIds][listitem];

			if(IllegalGarage[garage][igMoney] < LandVehicles[carid][viCarJackerPrice])
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Garage doesn't have money to pay you out for the heist!");
			
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have chosen %s as your target vehicle for Jacker Mission!", 
				ReturnVehicleName(LandVehicles[carid][viModelid])
			);
            
			va_ShowPlayerDialog(playerid, 
				DIALOG_JACKER_SURE_1, 
				DIALOG_STYLE_MSGBOX, 
				"Jacking Mission", 
				"Are you sure you want to start %s Jacking Mission?", 
				"Yes", 
				"No", 
				ReturnVehicleName(LandVehicles[carid][viModelid])
			);
            PlayerJackingCar[playerid] = IllegalGarage[garage][igVehicleIds][listitem];
	    }
	    case DIALOG_JACKER_SURE_1:
	    {
     		if(!response)
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "You aborted your Jacking Mission.");
				JackerIllegalGarage[playerid] = -1;
				PlayerJackingCar[playerid] = -1;
				return 1;
			}
	        SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have picked %s Jacking Mission. Once you go offline, the mission terminates!", 
				ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid])
			);
		}
		case DIALOG_JACKER_SURE_2: 
		{
			if(!response) 
				return 1;			
			SendMessage(playerid, 
				MESSAGE_TYPE_INFO, 
				"You have sucessfully stopped your Jacking Mission. You can pick a new one in 60 minutes!"
			);
			PlayerJackingCar[playerid] = -1;
		}
		case DIALOG_JACKER_BRIBE: 
		{
			if(!response) 
				return 1;
			new 
				garage = PlayerKeys[playerid][pIllegalGarageKey];
			if(garage == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't own Illegal Garage!");

			IllegalGarage[garage][igWantedLevel] = 0;
			IllegalGarage[garage][igCarsJacked] = 0;

			mysql_fquery(g_SQL, "UPDATE illegal_garages SET wantedlevel = '%d', jackedcars = '%d' WHERE id = '%d'", 
				IllegalGarage[garage][igWantedLevel], 
				IllegalGarage[garage][igCarsJacked],
				IllegalGarage[garage][igSQLID]
			);

			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have sucessfully dropped Wanted Level in %s to 0!",
				IllegalGarage[garage][igName]
			);

			PlayerToFactionMoney(playerid, FACTION_TYPE_LAW, PlayerBribeMoney[playerid]);
			PlayerBribeMoney[playerid] = 0;
		}
	}
	return 0;
}

/*
                                                          
  ,ad8888ba,  88b           d88 88888888ba,    ad88888ba   
 d8"'    `"8b 888b         d888 88      `"8b  d8"     "8b  
d8'           88`8b       d8'88 88        `8b Y8,          
88            88 `8b     d8' 88 88         88 `Y8aaaaa,    
88            88  `8b   d8'  88 88         88   `"""""8b,  
Y8,           88   `8b d8'   88 88         8P         `8b  
 Y8a.    .a8P 88    `888'    88 88      .a8P  Y8a     a8P  
  `"Y8888Y"'  88     `8'     88 88888888Y"'    "Y88888P"                                                            
                                                           
*/

CMD:jacker(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_JACKER) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Car Jacker!");
	new
		param[7];
	if(sscanf( params, "s[7] ", param)) 
		return SendClientMessage(playerid, COLOR_RED, "[?]: /jacker [pick/chop/stop]");
	if(!strcmp(param, "pick", true)) 
	{
		JackerIllegalGarage[playerid] = GetJackerIllegalGarage(playerid);
		if(JackerIllegalGarage[playerid] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near any illegal garage!");
		if(IllegalGarage[JackerIllegalGarage[playerid]][igVehicleIds][0] == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "There are no jobs at the moment!");
		if(PlayerCoolDown[playerid][pJackerCool] <= gettimestamp()) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "60 minutes from last Jacking Mission finishing must pass!");
		if(PlayerJackingCar[playerid] != -1) 
		{
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"You already have a %s mission active. Use /jacker stop to abort current mission.",
				ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid])
			);
		}

		new
			garage = JackerIllegalGarage[playerid],
			vehicles_str[128];
		format(vehicles_str, sizeof(vehicles_str), "%s\n%s\n%s\n%s\n%s\n%s",
		    ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][0]][viModelid]),
		    ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][1]][viModelid]),
			ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][2]][viModelid]),
			ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][3]][viModelid]),
			ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][4]][viModelid]),
			ReturnVehicleName(LandVehicles[IllegalGarage[garage][igVehicleIds][5]][viModelid])
		);
		ShowPlayerDialog(playerid, 
			DIALOG_JACKER_PICK, 
			DIALOG_STYLE_LIST, 
			"Pick Jacking Mission", 
			vehicles_str, 
			"Choose", 
			"Abort"
		);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Please pick a desired vehicle jacking mission!");
	}
	else if(!strcmp(param, "chop", true)) 
	{
		new
			vehicleid = GetPlayerVehicleID(playerid),
			garageid = GetJackerIllegalGarage(playerid);
		if(garageid == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near Illegal Garage!");
		if(JackerIllegalGarage[playerid] != garageid)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must deliver the vehicle in garage you took mission in.");
		if(PlayerJackingCar[playerid] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must pick your mission first!");
		if(!IsPlayerInAnyVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in vehicle!");
		if(vehicleid == PlayerKeys[playerid][pVehicleKey]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't dissasemble your own vehicle!");
		if(!Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vehicleid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vehicle you stole must be a private property, not rented!");
		new 
			Float:health;
		GetVehicleHealth(vehicleid, health);
		if(health < 550.0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vehicle has to be in better state! (Min. 550+ HP)");
		if(!IsVehicleMission(playerid, GetVehicleModel(vehicleid)))
		{
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"You got the wrong vehicle. %s was your target vehicle!",
				ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid])
			);
			return 1;
		}
		RemovePlayerFromVehicle(playerid);
		SetVehiclePos(vehicleid, 2520.0364, -2412.6516, 13.7);

		DestroyingCarCount[playerid] = DESTROYING_CAR_TIME;
		CreateJackerTextDraw(playerid);
		va_PlayerTextDrawSetString(playerid, 
			JackerTD[playerid], 
			"~w~Disassembling %s in process~r~... ~n~~w~Time Left: ~r~%d sec",
			ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid]),
			DestroyingCarCount[playerid]
		);
		DestroyingCarTimer[playerid] = repeat DestroyingCar(playerid, vehicleid);
	}
	else if(!strcmp(param, "stop", true)) 
	{
		if(PlayerJackingCar[playerid] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an active mission!");
		
		va_ShowPlayerDialog(playerid, 
			DIALOG_JACKER_SURE_2, 
			DIALOG_STYLE_MSGBOX, 
			"Car Jacker Mission", 
			"Are you sure you want to abort %s Jacking Mission?\n\
				"COL_RED"NOTE: If you quit this mission, you can't pick a new one for 60 minutes!", 
			"Quit", 
			"Back",
			ReturnVehicleName(LandVehicles[PlayerJackingCar[playerid]][viModelid])
		);
	}
	return 1;
}

CMD:igarage(playerid, params[])
{
	new
		param[8];
	if(sscanf( params, "s[8] ", param))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /igarage [options]");
		SendClientMessage(playerid, COLOR_RED, "[!]: buy - info - bribe");
		if(PlayerInfo[playerid][pAdmin] == 1338)
			SendClientMessage(playerid, COLOR_RED, "[!]: add - remove");
		return 1;
	}
	if(!strcmp(param, "add", true))
	{
		if(PlayerInfo[playerid][pAdmin] != 1338)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Head Administrator!");
		new 
			garage_name[32];
		if(sscanf( params, "s[8]s[32]", param, garage_name))
			return SendClientMessage(playerid, -1, "[!]: /igarage add [garage_name]");
		new
			garage = Iter_Free(IllegalGarage);
		if(garage == -1)
		{
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"Max. limit of Illegal Garages reached. (%d)", 
				MAX_ILLEGAL_GARAGES
			);
			return 1;
		}

		strcpy(IllegalGarage[garage][igName], garage_name, 32);
		new 
			Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		IllegalGarage[garage][igBoard] = CreateDynamicObject(3077, x, y, z + 2.0, 0.000, 0.000, 0.000, -1,- 1, -1,300.000, 300.000);

		EditingBoardID[playerid] = garage;
		EditDynamicObject(playerid, IllegalGarage[garage][igBoard]);

		va_SendClientMessage(playerid, 
			COLOR_WHITE, 
			"You have placed main board for Illegal Garage %s.",
			garage_name
		);
		SendClientMessage(playerid, 
			COLOR_WHITE, 
			"Place board on desireable place to save progress. \n\
				Use '{3399FF}~k~~PED_SPRINT~{FFFFFF}' to move camera."
		);
	}
	if(!strcmp(param, "remove", true))
	{
		if(PlayerInfo[playerid][pAdmin] != 1338)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Head Administrator!");
		new 
			garage;		
		if(sscanf( params, "s[8]i", param, garage))
			return SendClientMessage(playerid, -1, "[!]: /igarage add [garage_name]");
		if(Iter_Contains(IllegalGarage, garage))
		{
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Illegal Garage %d doesn't exist!", garage);
			return 1;
		}

		SendAdminMessage(COLOR_RED, 
			"%s has deleted Illegal Garage %s[ID %d].",
			IllegalGarage[garage][igName],
			garage
		);
		SendFormatMessage(playerid, 
			MESSAGE_TYPE_SUCCESS, 
			"You have sucessfully deleted Illegal Garage %s[ID %d].", 
			IllegalGarage[garage][igName],
			garage
		);

		DeleteIllegalGarage(garage);
	}
	if(!strcmp(param, "buy", true)) 
	{
		if(PlayerKeys[playerid][pIllegalGarageKey] != -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You already own an illegal garage!");
		if(AC_GetPlayerMoney(playerid) < CHOP_SHOP_PRICE) 
		{
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"You don't have %s with you to buy Illegal Garage!", 
				FormatNumber(CHOP_SHOP_PRICE)
			);
			return 1;
		}
		new
			garage = GetJackerIllegalGarage(playerid);
		if(garage == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near Illegal Garage!");
		if(IllegalGarage[garage][igOwner] != 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "This Illegal Garage is already owned by somebody!");
		
		PlayerKeys[playerid][pIllegalGarageKey] = garage;		
		CheckGarageWantedLevel(garage, true);
		PlayerToIllegalBudgetMoney(playerid, CHOP_SHOP_PRICE); 

		IllegalGarage[garage][igOwner] = PlayerInfo[playerid][pSQLID];
		mysql_fquery(g_SQL,
			"UPDATE illegal_garages SET owner = '%d' WHERE id = '%d'",
			IllegalGarage[garage][igOwner],
			IllegalGarage[garage][igSQLID]  
		);

		SendFormatMessage(playerid, 
			MESSAGE_TYPE_SUCCESS, 
			"Congratulations, you just bought Illegal Garage %s for %s!", 
			IllegalGarage[garage][igName],
			FormatNumber(CHOP_SHOP_PRICE)
		);
	}
	else if(!strcmp(param, "info", true)) 
	{
		if(PlayerKeys[playerid][pIllegalGarageKey] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't own an illegal garage!");
		new
			garage = GetJackerIllegalGarage(playerid);
		if(garage == -1 || IllegalGarage[garage][igOwner] != PlayerInfo[playerid][pSQLID]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near Illegal Garage / you don't own it!");
		va_ShowPlayerDialog(playerid, 
			0, 
			DIALOG_STYLE_TABLIST, 
			"Illegal Garage - Info", 
			"Name:\t%s\nWanted Level:\t%d\nVehicles stolen:\t%d", 
			"OK", 
			"", 
			IllegalGarage[garage][igName], 
			IllegalGarage[garage][igWantedLevel], 
			IllegalGarage[garage][igCarsJacked]
		);
	}
	else if(!strcmp(param, "bribe", true)) 
	{
		if(PlayerKeys[playerid][pIllegalGarageKey] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't own an illegal garage!");
		new
			garage = GetJackerIllegalGarage(playerid);
		if(garage == -1 || IllegalGarage[garage][igOwner] != PlayerInfo[playerid][pSQLID]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near Illegal Garage / you don't own it!");
		if(IllegalGarage[garage][igWantedLevel] < 2) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You got to have at least 2+ stars.");
		new
			money = ( IllegalGarage[garage][igWantedLevel] * ( random(random(250)) + 1)) 
				+ ( IllegalGarage[garage][igCarsJacked] * 1000);
		PlayerBribeMoney[playerid] = money;
		
		va_ShowPlayerDialog(playerid, 
			DIALOG_JACKER_BRIBE, 
			DIALOG_STYLE_MSGBOX, 
			"Illegal Garage - Bribe", 
			"Do you want to bribe police to lower your heat on 0?\nIt will cost you %s!", 
			"Bribe", 
			"Abort", 
			FormatNumber(money)
		);
	}
	else if(!strcmp(param, "money", true)) 
	{
		new
			garage = GetJackerIllegalGarage(playerid),
			pick[4],
			money;

		if(garage == -1 || IllegalGarage[garage][igOwner] != PlayerInfo[playerid][pSQLID]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near Illegal Garage / you don't own it!");
		if(sscanf( params, "s[8]s[8]i", param, pick, money)) 
			return SendClientMessage(playerid, COLOR_RED, "[?]: /igarage money [take/put][amount]");
		if(!strcmp(pick, "take", true)) 
		{
			if(money >  IllegalGarage[garage][igMoney] || money < 1) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have that much money with you!");
			
			IllegalGarageToPlayerMoney(playerid, garage, money);
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have sucessfully took %s from %s garage!", 
				FormatNumber(money),
				IllegalGarage[garage][igName]
			);
		}
		else if(!strcmp(pick, "put", true)) 
		{
			if(money < 1 || money > AC_GetPlayerMoney(playerid)) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have that much money with you!");
			
			PlayerToIllegalGarageMoney(playerid, garage, money);
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have sucessfully stored %s in %s garage!", 
				FormatNumber(money),
				IllegalGarage[garage][igName]
			);
		}
	}
	return 1;
}