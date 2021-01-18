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

const MAX_ILLEGAL_GARAGES		= 10;
const DESTROYING_CAR_TIME		= 45; // 45 seconds

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

static
	Iterator:IllegalGarage<MAX_ILLEGAL_GARAGES>;

enum E_Illegal_GARAGES 
{
	igSQLID,
	igName[ 32 ],
	igOwner,
	igVehicleIds[ 6 ],
	igMoney,
	igBoard,
	igHeader,
	igText[ 6 ],
	igCarsJacked,
	igWantedLevel,
	Text3D:ig3dText,
	Float:ig3dTextPos[ 4 ]
}
static
	IllegalGarage[ MAX_ILLEGAL_GARAGES ][ E_Illegal_GARAGES ];
	
static 
	PlayerText:JackerTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	DestroyedCar[ MAX_PLAYERS ],
	JackerIllegalGarage[ MAX_PLAYERS ],
	Timer:DestroyingCarTimer[ MAX_PLAYERS ],
	DestroyingCarCount[ MAX_PLAYERS ],
	PlayerBribeMoney[ MAX_PLAYERS ],
	PlayerJackingCar[ MAX_PLAYERS ];

/*
	   _____ ______ _   _ ______ _____            _      
	  / ____|  ____| \ | |  ____|  __ \     /\   | |     
	 | |  __| |__  |  \| | |__  | |__) |   /  \  | |     
	 | | |_ |  __| | .  |  __| |  _  /   / /\ \ | |     
	 | |__| | |____| |\  | |____| | \ \  / ____ \| |____ 
	  \_____|______|_| \_|______|_|  \_\/_/    \_\______|
*/
/////////////////////////////////////////////////////
GetIllegalGarageFromSQL(sqlid)
{
	new
		garageid = -1;
	foreach(new igarage : IllegalGarage)
	{
		if(IllegalGarage[ igarage ][ igOwner ] == sqlid)
		{
			garageid = igarage;
			break;
		}
	}
	return garageid;
}

stock LoadIllegalGarages()
{
	mysql_pquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM Illegal_garages WHERE 1"), 
		"OnServerIllegalGaragesLoad",
		""
	);
	return 1;
}

forward OnServerIllegalGaragesLoad();
public OnServerIllegalGaragesLoad()
{
	if( !cache_num_rows() ) return printf( "MySQL Report: No Illegal garages exist to load.");
	for( new row = 0; row < cache_num_rows(); row++ ) 
	{
		cache_get_value_name_int( row, 		"id"		, IllegalGarage[ row ][ igSQLID ]);
		cache_get_value_name_int( row, 		"owner"		, IllegalGarage[ row ][ igOwner ]);
		cache_get_value_name( row, 			"name"		, IllegalGarage[ row ][ igName ], 32 );
		cache_get_value_name_int( row, 		"jackedcars", IllegalGarage[ row ][ igCarsJacked ]);
		cache_get_value_name_int( row, 		"jackedcars", IllegalGarage[ row ][ igWantedLevel ]);
		cache_get_value_name_float( row, 	"3dtextX"	, IllegalGarage[ row ][ ig3dTextPos ][ 0 ]);
		cache_get_value_name_float( row, 	"3dtextY"	, IllegalGarage[ row ][ ig3dTextPos ][ 1 ]);
		cache_get_value_name_float( row, 	"3dtextZ"	, IllegalGarage[ row ][ ig3dTextPos ][ 2 ]);
		cache_get_value_name_float( row, 	"rotZ"		, IllegalGarage[ row ][ ig3dTextPos ][ 2 ]);
		InitIllegalGarage(row);
		Iter_Add(IllegalGarage, row);
	}
	printf("MySQL Report: Illegal Garages Loaded. [%d/%d]", cache_num_rows(), MAX_ILLEGAL_GARAGES);
	return 1;
}

static CheckForGarageWantedLevel(garage, bool:save=false)
{
	new
		tmpStars[ 5 ];
	tmpStars = "None";
	switch( IllegalGarage[ garage ][ igCarsJacked ] ) {
		case 55 .. 95:   { IllegalGarage[ garage ][ igWantedLevel ] 	= 1; tmpStars = "*";   }
		case 96 .. 136:  { IllegalGarage[ garage ][ igWantedLevel ] 	= 2; tmpStars = "**";  }
		case 137 .. 177: { IllegalGarage[ garage ][ igWantedLevel ]	= 3; tmpStars = "***"; }
	}
	if( !save ) 
	{
		mysql_fquery(g_SQL, "UPDATE Illegal_garages SET wanted = '%d' WHERE id = '%d'", 
			IllegalGarage[ garage ][ igWantedLevel ], 
			IllegalGarage[ garage ][ igSQLID ]
		);
	}
	new
		tmpString[ 135 ];		
	format(tmpString, 135, ""COL_LIGHTBLUE"%s\n===============\n"COL_WHITE"%s"COL_LIGHTBLUE"\n===============\n"COL_LIGHTBLUE"%d$\n===============\n"COL_WHITE"%s", 
		IllegalGarage[ garage ][ igName ],
		tmpStars,
		IllegalGarage[ garage ][ igMoney ],
		( IllegalGarage[ garage ][ igOwner ] != 0 ? (ConvertSQLIDToName(IllegalGarage[ garage ][ igOwner ])) : ("Na prodaju (/garage buy)") )
	);
	UpdateDynamic3DTextLabelText(IllegalGarage[ garage ][ ig3dText ], -1, tmpString);
}

static bool: IsVehicleJackable(carid)
{
	new bool: value = true;
	if(!LandVehicles[carid][viCarJackerPrice])
		value = false;
	return value;
}

static IsVehicleOnList(garage, index)
{
	new
		returning = 0;
	for( new i=0; i < 6; i++ ) 
	{
		if( IllegalGarage[ garage ][ igVehicleIds ][ i ] == index ) 
		{
			returning = 1;
			break;
		}
	}
	return returning;
}

static GetVehiclesForIllegalGarages(garage)
{
	new vehkinds = CountVehicleModels();
	if(vehkinds >= 6) 
	{
		new vehid, carid;
		for( new i = 0; i < 6; i++ ) 
		{
			CARID_GET:
			
			vehid = Vehicle_Random(VEHICLE_USAGE_PRIVATE),
			carid = GetVehicleByModel(GetVehicleModel(vehid));
				
			if( carid == -1 ) goto CARID_GET;
			if( IsABike(GetVehicleModel(vehid)) || IsABoat(GetVehicleModel(vehid)) || IsAMotorBike(GetVehicleModel(vehid)) || IsAPlane(GetVehicleModel(vehid)) || IsAHelio(GetVehicleModel(vehid)) ) goto CARID_GET;
			if( !IsVehicleJackable(carid) ) goto CARID_GET;
			if( IsVehicleOnList(garage, carid) ) goto CARID_GET;
			IllegalGarage[ garage ][ igVehicleIds ][ i ] = carid;
		}
	}
	else 
	{
		new carid, model, caridmodel;
		for( new i=0; i < 6; i++ ) 
		{
			CARID1_GET:
			
			carid = random(random(119)),
			model = carid + 400,
			caridmodel = GetVehicleByModel(model);
				
			if( carid > 119 ) goto CARID1_GET;
			if( caridmodel == -1 ) goto CARID1_GET;
			if( IsABike(model) || IsABoat(model) || IsAMotorBike(model) || IsAPlane(model) || IsAHelio(model) ) goto CARID1_GET;
			if( !IsVehicleJackable(carid) ) goto CARID_GET;			
			if( IsVehicleOnList(garage, caridmodel) ) goto CARID1_GET;
			IllegalGarage[ garage ][ igVehicleIds ][ i ] = caridmodel;
		}	
	}
	return 1;
}

stock UpdateIllegalGarages(garage)
{
	for( new i=0; i < 6; i++ )
		IllegalGarage[ garage ][ igVehicleIds ][ i ] = 0;

	new 
		vehicleName[MAX_VEHICLE_NAME];
	GetVehiclesForIllegalGarages(garage);

	new 
		Float: bY = IllegalGarage[ garage ][ ig3dTextPos ][ 1 ] - 1.0,	// Y of the board object
		Float: ltX = IllegalGarage[ garage ][ ig3dTextPos ][ 0 ] - 0.8, // Left aligned board text
		Float: rtX = IllegalGarage[ garage ][ ig3dTextPos ][ 0 ] + 0.8, // Right aligned board text
		Float: Z1 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 1.5, // First row of board text
		Float: Z2 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 1.0, // Second row of board text
		Float: Z3 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 0.5, // Third row of board text
		Float: rotZ = IllegalGarage[ garage ][ ig3dTextPos ][ 3 ] - 90.0;

	// Left side of the board texts
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 0 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 0 ]);
		IllegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659, ltX, bY, Z1, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 0 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 1 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 1 ]);
		IllegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659, ltX, bY, Z2, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 1 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 2 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 2 ]);
		IllegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659, ltX, bY, Z3, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 2 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	// Right side of the board texts
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 3 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 3 ]);
		IllegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659, rtX, bY, Z1, 0.000, 0.000, rotZ, -1, -1, -1,300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 3 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 4 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 4 ]);
		IllegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659, rtX, bY, Z2, 0.000, 0.000, rotZ, -1, -1,-1, 300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 4 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	if( IsValidDynamicObject(IllegalGarage[ garage ][ igText ][ 5 ]) ) 
	{
		DestroyDynamicObject(IllegalGarage[ garage ][ igText ][ 5 ]);
		IllegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659, rtX, bY, Z3, 0.000, 0.000, rotZ, -1, -1, -1, 300.000, 300.000);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 5 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	return 1;
}

stock static InitIllegalGarage(garage)
{ 	
	new
		Float: bX = IllegalGarage[ garage ][ ig3dTextPos ][ 0 ],
		Float: bY = IllegalGarage[ garage ][ ig3dTextPos ][ 1 ] - 1.0,
		Float: bZ = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] - 1.0,
		Float: brZ = IllegalGarage[ garage ][ ig3dTextPos ][ 3 ];

	IllegalGarage[ garage ][ igBoard ] = CreateDynamicObject(3077, bX, bY, bZ, 0.000, 0.000, brZ, -1,- 1, -1,300.000, 300.000);

	// Total: 6 board texts in 3 rows on jacker board
	new 
		Float: ltX = IllegalGarage[ garage ][ ig3dTextPos ][ 0 ] - 0.8, // Left aligned board text
		Float: rtX = IllegalGarage[ garage ][ ig3dTextPos ][ 0 ] + 0.8, // Right aligned board text
		Float: hZ = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 2.0, // Header board text - "Wanted List"
		Float: Z1 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 1.5, // First row of board text
		Float: Z2 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 1.0, // Second row of board text
		Float: Z3 = IllegalGarage[ garage ][ ig3dTextPos ][ 2 ] + 0.5, // Third row of board text
		Float: rotZ = IllegalGarage[ garage ][ ig3dTextPos ][ 3 ] - 90.0; 


	IllegalGarage[ garage ][ igHeader ] = CreateDynamicObject(18659, bX, bY, hZ, 0.000, 0.000, brZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igHeader ], 0, "Wanted List", 140, "courier", 42, 1, -1, 0, 1);
	
	IllegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659, ltX, bY, Z1, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 0 ], 0, "1", 140, "courier", 38, 1, -1, 0, 1);	
	IllegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659, ltX, bY, Z2, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 1 ], 0, "2", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659, ltX, bY, Z3, 0.000, 0.000, rotZ,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 2 ], 0, "3", 140, "courier", 38, 1, -1, 0, 1);
	
	IllegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659, rtX, bY, Z1, 0.000, 0.000, rotZ, -1, -1, -1,300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 3 ], 0, "6", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659, rtX, bY, Z2, 0.000, 0.000, rotZ, -1, -1,-1, 300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 4 ], 0, "5", 140, "courier", 38, 1, -1, 0, 1);
	IllegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659, rtX, bY, Z3, 0.000, 0.000, rotZ, -1, -1, -1, 300.000, 300.000);
	SetDynamicObjectMaterialText(IllegalGarage[ garage ][ igText ][ 5 ], 0, "4", 140, "courier", 38, 1, -1, 0, 1);
	UpdateIllegalGarages(garage);
	
	IllegalGarage[ garage ][ ig3dText ] = CreateDynamic3DTextLabel("*", -1, IllegalGarage[ garage ][ ig3dTextPos ][ 0 ], IllegalGarage[ garage ][ ig3dTextPos ][ 1 ], IllegalGarage[ garage ][ ig3dTextPos ][ 2 ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 30.0);
	CheckForGarageWantedLevel(garage);
	return 1;
}

static IllegalGarageToPlayerMoney(playerid, money)
{
	new
		garage  = JackerIllegalGarage[playerid];
	IllegalGarage[garage][igMoney] -= money;
	mysql_fquery(g_SQL,
		"UPDATE Illegal_garages SET money = '%d' WHERE id = '%d'",
		IllegalGarage[ garage ][ igMoney ],
		IllegalGarage[ garage ][ igSQLID ]
	);

	AC_GivePlayerMoney(playerid, money);
	return 1;
}
/*
		 __               __                 
		|__|____    ____ |  | __ ___________ 
		|  \__  \ _/ ___\|  |/ // __ \_  __ \
		|  |/ __ \\  \___|    <\  ___/|  | \/
	/\__|  (____  /\___  >__|_ \\___  >__|   
	\______|    \/     \/     \/    \/       
*/
stock static ResetCarJackerVariables(playerid)
{
	DestroyJackerTextDraw(playerid);
	
	// 32bit
	DestroyedCar[ playerid ]			= 0;
	PlayerJackingCar[ playerid ]		= -1;
	JackerIllegalGarage[ playerid ]		= -1;
	stop DestroyingCarTimer[ playerid ];
	DestroyingCarCount[ playerid ] 		= -1;
	return 1;
}

stock static IsVehicleMission(playerid, modelid)
	return ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ] == modelid ? 1 : 0 );

stock static IsVehicleOnJackingList(garage, playercar)
{
	new
		index = 0;
	for( new i=0; i < 6; i++ ) {
		if( IllegalGarage[ garage ][ igVehicleIds ][ i ] == playercar ) {
			index = 1;
			break;
		}
	}
	return index;
}
	
timer DestroyingCar[1000](playerid, vehicleid)
{
	if(JackerIllegalGarage[playerid] == -1)
	{
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta zbog greske!");
		return 0;
	}
	if( !IsPlayerInRangeOfVehicle(playerid, vehicleid, 18.0) ) 
	{
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta jer niste blizu vozila!");
		return 1;			
	}
	
	DestroyingCarCount[ playerid ] -= 1;	
	
	va_PlayerTextDrawSetString(playerid, 
		JackerTD[playerid], 
		 "~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d", 
		 DestroyingCarCount[ playerid ]
	);
	
	if( DestroyingCarCount[ playerid ] <= 0 ) 
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
	
		// Money
		new
			skillmoney = ((GetPlayerSkillLevel(playerid) + 2) * 10),
			garage = JackerIllegalGarage[ playerid ],
			decrease = front_left_panel + front_right_panel + rear_left_panel + rear_right_panel + windshield + front_bumper + rear_bumper + bonnet + boot + driver_door + passenger_door + light1 + light2 + light3 + light4 + tire1 + tire2 + tire3 + tire4,
			value = ( ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viCarJackerPrice ] + skillmoney )  - ( decrease * 15 ) );
		
		IllegalGarage[ garage ][ igCarsJacked ]++;
		mysql_fquery(g_SQL, "UPDATE Illegal_garages SET jackedcars = '%d' WHERE id = '%d'", 
			IllegalGarage[ garage ][ igCarsJacked ], 
			IllegalGarage[ garage ][ igSQLID ]
		);
		
		// Damage
		VehicleInfo[ vehicleid ][ vPanels ]		= encode_panels(1, 1, 1, 1, 3, 3, 3); 
		VehicleInfo[ vehicleid ][ vDoors ]		= encode_doors(4, 4, 4, 4, 0, 0);
		VehicleInfo[ vehicleid ][ vLights ]		= encode_lights(1, 1, 1, 1);
		VehicleInfo[ vehicleid ][ vTires ]		= encode_tires(1, 1, 1, 1);
		UpdateVehicleDamageStatus(vehicleid, VehicleInfo[ vehicleid ][ vPanels ], VehicleInfo[ vehicleid ][ vDoors ], VehicleInfo[ vehicleid ][ vLights ], VehicleInfo[ vehicleid ][ vTires ]);
		VehicleInfo[ vehicleid][ vTrunk ] = VEHICLE_PARAMS_ON;
		SetVehicleHealth(vehicleid, 388);
	
		SendPoliceAlertMessage(vehicleid, garage);
		DestroyedCar[playerid] = GetVehicleModel(vehicleid);

		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		
		SendClientMessage(playerid,COLOR_RED, "Uspjesno ste rastavili vozilo. Sakrij vozilo da policija ne locira Chop Shop!");	

		IllegalGarageToPlayerMoney(playerid, value);

		IllegalGarage[ garage ][ igMoney ] += (LandVehicles[ PlayerJackingCar[playerid] ][ viCarJackerPrice ] * 3);
		mysql_fquery(g_SQL,
			"UPDATE Illegal_garages SET money = '%d' WHERE id = '%d'",
			IllegalGarage[ garage ][ igMoney ],
			IllegalGarage[ garage ][ igSQLID ] 
		);
				
		SendFormatMessage(playerid, 
			MESSAGE_TYPE_SUCCESS, 
			"Zavrsili ste %s jacker misiju i zaradili %s.", 
			ReturnVehicleName(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ]),
			FormatNumber(value)
		);
				
		PlayerJackingCar[ playerid ] = -1;
		PlayerCoolDown[playerid][pJackerCool] = gettimestamp(); // svakih sat vremena moze odradit jedan posao.
		CheckForGarageWantedLevel(garage, true);
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
	if( IllegalGarage[ garage ][ igWantedLevel ] < 2 ) 
	{
		switch( random(5) )  
		{
			case 0,2,4: return 1;
			case 1,3: goto end_mark; // 20% chance of Police Alert
		}
	} 
	else goto end_mark;
	end_mark:
	foreach(new playerid : Player) 
	{
		if(!IsACop(playerid)) 
			continue;
			
		SendClientMessage(playerid, 
			COLOR_LIGHTBLUE, 
			"*________________________ [ VEHICLE CHOPPING ] ________________________*"
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

stock static DestroyJackerTextDraw(playerid)
{
	if( JackerTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) 
	{
		PlayerTextDrawDestroy( playerid, JackerTD[playerid] );
		JackerTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreateJackerTextDraw(playerid)
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
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
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

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_JACKER_PICK:
	    {
	        if(!response)
	            return SendClientMessage(playerid, COLOR_RED, "Odustali ste od posla!");
	        
            new
				garage = JackerIllegalGarage[ playerid ],
				carid = IllegalGarage[ garage ][ igVehicleIds ][ listitem ];

			if(IllegalGarage[garage][igMoney] < LandVehicles[ carid ][ viCarJackerPrice ])
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "ChopShop doesn't have money to pay you out for that vehicle!");
			
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"Odabrali ste vozilo %s za Jacker Mission!", 
				ReturnVehicleName(LandVehicles[ carid ][ viModelid ])
			);
            
			va_ShowPlayerDialog(playerid, 
				DIALOG_JACKER_SURE_1, 
				DIALOG_STYLE_MSGBOX, 
				"Odabir vozila", 
				"Jeste li sigurni da zelite zapoceti %s misiju?", 
				"Yes", 
				"No", 
				ReturnVehicleName(LandVehicles[ carid ][ viModelid ])
			);
            PlayerJackingCar[playerid] = IllegalGarage[garage][igVehicleIds][listitem];
			return 1;
	    }
	    case DIALOG_JACKER_SURE_1:
	    {
     		if(!response)
	            return SendClientMessage(playerid, COLOR_RED, "Odustali ste od posla!"), PlayerJackingCar[ playerid ] = -1;
	    	new vehicleName[MAX_VEHICLE_NAME];
			GetVehicleNameByModel(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
	        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste %s misiju. Ona se prekida kada odete offline!", vehicleName);
		}
		case DIALOG_JACKER_SURE_2: 
		{
			if( !response ) return 1;			
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uspjesno ste prekinuli Car Jacker misiju!");
			PlayerJackingCar[ playerid ] = -1;
			UpdateIllegalGarages(JackerIllegalGarage[playerid]);
			return 1;
		}
		case DIALOG_JACKER_BRIBE: 
		{
			if( !response ) return 1;
			IllegalGarage[ PlayerKeys[playerid][pIllegalGarageKey] ][ igWantedLevel ]	= 0;
			IllegalGarage[ PlayerKeys[playerid][pIllegalGarageKey] ][ igCarsJacked ]	= 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spustili wanted level na 0!");
			PlayerToFactionMoney( playerid, FACTION_TYPE_LAW, PlayerBribeMoney[ playerid ]); // Novac dolazi u PD factionbank
			PlayerBribeMoney[ playerid ] = 0;
			return 1;
		}
	}
	return 0;
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

CMD:update_garage(playerid,params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1338 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
	new
		garage;
	if( sscanf(params, "i", garage) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /update_garage [garageid]");
	UpdateIllegalGarages(garage);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste updejtali garazu id %d.", garage);
	return 1;
}

CMD:jacker(playerid, params[])
{
	if( PlayerJob[playerid][pJob] != JOB_JACKER ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste car jacker!");
	new
		param[ 7 ];
	if( sscanf( params, "s[7] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jacker [pick/chop/stop]");
	if( !strcmp(param, "pick", true) ) 
	{
		JackerIllegalGarage[ playerid ] = GetJackerIllegalGarage(playerid);
		if( JackerIllegalGarage[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( PlayerCoolDown[playerid][pJackerCool] <= gettimestamp()) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mora proci 60 minuta od zadnje isporuke za novu misiju!");
		if( PlayerJackingCar[ playerid ] != -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa misija i dalje traje! Kucajte /jacker stop za odustanak.");

		new
			garage = JackerIllegalGarage[ playerid ];

		new
			vehicles_str[104],
			vehicleName[6][MAX_VEHICLE_NAME];
				
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName[0], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName[1], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName[2], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName[3], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName[4], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IllegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName[5], MAX_VEHICLE_NAME);

		format(vehicles_str, sizeof(vehicles_str), "%s\n%s\n%s\n%s\n%s\n%s",
		    vehicleName[0],
		    vehicleName[1],
		    vehicleName[2],
		    vehicleName[3],
		    vehicleName[4],
		    vehicleName[5]
		);
		ShowPlayerDialog(playerid, DIALOG_JACKER_PICK, DIALOG_STYLE_LIST, "Odaberite vozilo", vehicles_str, "Choose", "Abort");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Odaberite vozilo koje zelite ukrasti!");
	}
	else if( !strcmp(param, "chop", true) ) 
	{
		new
			Float:health,
			vehicleid = GetPlayerVehicleID(playerid);

		GetVehicleHealth(vehicleid, health);
		
		if( PlayerJackingCar[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate uzeti misiju!");
		if( vehicleid == PlayerKeys[playerid][pVehicleKey] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete svoje vozilo uzeti!");
		if( !Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo koje ste ukrali treba biti privatno, a ne iznajmljeno ili organizacijsko!");
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
		if( health < 550.0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo mora biti u boljem stanju (550+ HPa)!");
		
		if( GetJackerIllegalGarage(playerid) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( !IsVehicleMission(playerid, GetVehicleModel(vehicleid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo niste uzeli kao misiju!");
		
		RemovePlayerFromVehicle(playerid);
		SetVehiclePos(vehicleid, 2520.0364, -2412.6516, 13.7);

		DestroyingCarCount[ playerid ] = DESTROYING_CAR_TIME;
		CreateJackerTextDraw(playerid);
		va_PlayerTextDrawSetString(playerid, 
			JackerTD[playerid], 
			"~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d",
			DestroyingCarCount[ playerid ]
		);
		DestroyingCarTimer[playerid] = repeat DestroyingCar(playerid, vehicleid);
	}
	else if( !strcmp(param, "stop", true) ) 
	{
		if( PlayerJackingCar[ playerid ] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate aktivnu misiju!");
		ShowPlayerDialog(playerid, DIALOG_JACKER_SURE_2, DIALOG_STYLE_MSGBOX, "Jacker misija", "Zelite li odustati od misije?\n"COL_RED"NAPOMENA: Ukoliko odustanete cooldown od 45 minuta se primjenuje!", "Quit", "Back");
	}
	return 1;
}

CMD:igarage(playerid, params[])
{
	new
		param[ 8 ];
	if( sscanf( params, "s[8] ", param ) )
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /igarage [options]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buy - info - bribe");
		return 1;
	}
	if( !strcmp(param, "buy", true) ) 
	{
		if( PlayerKeys[playerid][pIllegalGarageKey] != -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate Illegalnu garazu!");
		if( AC_GetPlayerMoney(playerid) < 60000 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupovinu Illegalne garaze (60.000$)!");
		new
			garage = GetJackerIllegalGarage(playerid);
		if( garage == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu car jacker garaze!");
		if( IllegalGarage[ garage ][ igOwner ] != 0 || IllegalGarage[ garage ][ igOwner ] != 9999 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Garaza nije na prodaju!");
		PlayerKeys[playerid][pIllegalGarageKey] = garage;
		IllegalGarage[ garage ][ igOwner ] = PlayerInfo[ playerid ][ pSQLID ];
		CheckForGarageWantedLevel(garage, true);
		PlayerToIllegalBudgetMoney(playerid, 60000); // Novac dolazi u Illegalni proracun
	}
	else if( !strcmp(param, "info", true) ) 
	{
		if( PlayerKeys[playerid][pIllegalGarageKey] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete Illegalnu garazu!");
		new
			garage = GetJackerIllegalGarage(playerid);
		if( garage == -1 || IllegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		va_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST, "Illegal Garage - Info", "Ime:\t%s\nWanted level:\t%d\nAuta ukradeno:\t%d", "OK", "", IllegalGarage[ garage ][ igName ], IllegalGarage[ garage ][ igWantedLevel ], IllegalGarage[ garage ][ igCarsJacked ]);
	}
	else if( !strcmp(param, "bribe", true) ) 
	{
		if( PlayerKeys[playerid][pIllegalGarageKey] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete Illegalnu garazu!");
		new
			garage = GetJackerIllegalGarage(playerid);
		if( garage == -1 || IllegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		if( IllegalGarage[ garage ][ igWantedLevel ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 2+ zvjezdica!");
		new
			money = ( IllegalGarage[ garage ][ igWantedLevel ] * ( random(random(250)) + 1 ) ) + ( IllegalGarage[ garage ][ igCarsJacked ] * 1000 );
		PlayerBribeMoney[ playerid ] = money;
		va_ShowPlayerDialog(playerid, DIALOG_JACKER_BRIBE, DIALOG_STYLE_MSGBOX, "Illegal Garage - Bribe", "Zelite li podmititi policiju da vam spuste wanted level na 0?\nOna ce kostati %d$!", "Bribe", "Abort", money);
	}/*
	else if( !strcmp(param, "money", true) ) 
	{
		new
			garage = GetJackerIllegalGarage(playerid),
			pick[ 4 ],
			money;
		
		if( garage == -1 || IllegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze ili nemate garazu!");
		if( sscanf( params, "s[8]s[8]i", param, pick, money ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /igarage money [take/put][kolicina]");
		if( !strcmp(pick, "take", true) ) 
		{
			if( money >  IllegalGarage[ garage ][ igMoney ] || money < 1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u garazi!");
			
			IllegalGarage[ garage ][ igMoney ] -= money;
			AC_GivePlayerMoney(playerid, money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %d$ iz Illegalne garaze!", money);
		}
		else if( !strcmp(pick, "put", true) ) {
			if( money < 1 || money > AC_GetPlayerMoney(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u ruci!");
			
			IllegalGarage[ garage ][ igMoney ] += money;
			AC_GivePlayerMoney(playerid, -money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste stavili %d$ u Illegalnu garazu!", money);
		}
	}*/
	return 1;
}
