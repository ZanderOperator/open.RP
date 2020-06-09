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
#define JACKER_JOB_ID			(13)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

// Enums
enum E_ILEGAL_GARAGES {
	igSQLID,
	igName[ 32 ],
	igOwner,	// Spremamo njegov MySQL ID
	igVehicleIds[ 6 ],
	igBoard,
	igText[ 6 ],
	igCarsJacked,
	igWantedLevel,
	Text3D:ig3dText,
	Float:ig3dTextPos[ 3 ],
	Float:igCameraPos[ 3 ],
	Float:igCameraLookAt[ 3 ]
}
new
	IlegalGarage[ MAX_ILEGAL_GARAGES ][ E_ILEGAL_GARAGES ];
	
// rBits
static stock
	Bit1: r_CarDestroyed 		<MAX_PLAYERS> = { Bit1:false, ... },
	Bit8: r_DestroyingCarSecs 	<MAX_PLAYERS> = { Bit8:0, ... };

// 32bit
static stock
	PlayerJackerCoolDown[ MAX_PLAYERS ],
	DestroyedCar[ MAX_PLAYERS ],
	JackerMoney[ MAX_PLAYERS ],
	JackerIlegalGarage[ MAX_PLAYERS ],
	DestroyingCarTimer[ MAX_PLAYERS ],
	PlayerBribeMoney[ MAX_PLAYERS ];

// TextDraws
/*static stock
	PlayerText:JackerArrow1[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... }, // Arrows
	PlayerText:JackerArrow2[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow3[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow4[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow5[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow6[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickBcg1[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... }, // Picking
	PlayerText:JackerPickBcg2[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickTitle[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickVehicle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickInfo[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickTake[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickLeave[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };*/

// Globals
new
	// 32 bit
	PlayerJackingCar[ MAX_PLAYERS ],
	// rBits
	Bit1: gr_PlayerPickingJack <MAX_PLAYERS> 	= { Bit1:false, ... },
	Bit1: gr_PlayerJackSure <MAX_PLAYERS> 		= { Bit1:false, ... };

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/*
	   _____ ______ _   _ ______ _____            _      
	  / ____|  ____| \ | |  ____|  __ \     /\   | |     
	 | |  __| |__  |  \| | |__  | |__) |   /  \  | |     
	 | | |_ |  __| | . ` |  __| |  _  /   / /\ \ | |     
	 | |__| | |____| |\  | |____| | \ \  / ____ \| |____ 
	  \_____|______|_| \_|______|_|  \_\/_/    \_\______|
*/
/////////////////////////////////////////////////////
stock LoadGarages()
{
	mysql_tquery(g_SQL, "SELECT * FROM ilegal_garages WHERE 1", "OnServerIlegalGaragesLoad");
	return 1;
}

forward OnServerIlegalGaragesLoad();
public OnServerIlegalGaragesLoad()
{
	if( !cache_num_rows() ) return printf( "MySQL Report: No ilegal garages exist to load.");
	for( new row = 0; row < cache_num_rows(); row++ ) 
	{
		cache_get_value_name_int( row, "id"		, IlegalGarage[ row ][ igSQLID ]);
		cache_get_value_name_int( row, "owner"		, IlegalGarage[ row ][ igOwner ]);
		cache_get_value_name( row, "name"			, IlegalGarage[ row ][ igName ], 32 );
		cache_get_value_name_int( row, "jackedcars", IlegalGarage[ row ][ igCarsJacked ]);
		cache_get_value_name_int( row, "jackedcars", IlegalGarage[ row ][ igWantedLevel ]);
		cache_get_value_name_float( row, "3dtextX"	, IlegalGarage[ row ][ ig3dTextPos ][ 0 ]);
		cache_get_value_name_float( row, "3dtextY"	, IlegalGarage[ row ][ ig3dTextPos ][ 1 ]);
		cache_get_value_name_float( row, "3dtextZ"	, IlegalGarage[ row ][ ig3dTextPos ][ 2 ]);
		cache_get_value_name_float( row, "cameraX"	, IlegalGarage[ row ][ igCameraPos ][ 0 ]);
		cache_get_value_name_float( row, "cameraY"	, IlegalGarage[ row ][ igCameraPos ][ 1 ]);
		cache_get_value_name_float( row, "cameraZ"	, IlegalGarage[ row ][ igCameraPos ][ 2 ]);
		cache_get_value_name_float( row, "lookX"	, IlegalGarage[ row ][ igCameraLookAt ][ 0 ]);
		cache_get_value_name_float( row, "lookY"	, IlegalGarage[ row ][ igCameraLookAt ][ 1 ]);
		cache_get_value_name_float( row, "lookZ"	, IlegalGarage[ row ][ igCameraLookAt ][ 2 ]);
		
		InitIlegalGarage(row);
		Iter_Add(IllegalGarages, row);
	}
	printf("MySQL Report: Ilegal Garages Loaded (%d)!", cache_num_rows());
	return 1;
}

stock static CheckForGarageWantedLevel(garage, bool:save=false)
{
	new
		tmpStars[ 5 ];
	tmpStars = "None";
	switch( IlegalGarage[ garage ][ igCarsJacked ] ) {
		case 55 .. 95:   { IlegalGarage[ garage ][ igWantedLevel ] 	= 1; tmpStars = "*";   }
		case 96 .. 136:  { IlegalGarage[ garage ][ igWantedLevel ] 	= 2; tmpStars = "**";  }
		case 137 .. 177: { IlegalGarage[ garage ][ igWantedLevel ]	= 3; tmpStars = "***"; }
	}
	if( !save ) {
		new
			tmpString[ 128 ];
		format(tmpString, 128, "UPDATE ilegal_garages SET wanted = '%d' WHERE id = '%d'", IlegalGarage[ garage ][ igWantedLevel ], IlegalGarage[ garage ][ igSQLID ]);
		mysql_tquery(g_SQL, tmpString, "");
	}
	new
		tmpString[ 135 ];		
	format(tmpString, 135, ""COL_LIGHTBLUE"%s\n===============\n"COL_WHITE"%s"COL_LIGHTBLUE"\n===============\n"COL_LIGHTBLUE"%d$\n===============\n"COL_WHITE"%s", 
		IlegalGarage[ garage ][ igName ],
		tmpStars,
		CityInfo[cIllegalBudget],
		( IlegalGarage[ garage ][ igOwner ] != 0 ? (GetPlayerNameFromID(IlegalGarage[ garage ][ igOwner ])) : ("Na prodaju (/garage buy)") )
	);
	UpdateDynamic3DTextLabelText(IlegalGarage[ garage ][ ig3dText ], -1, tmpString);
}

stock static IsVehicleOnList(garage, index)
{
	new
		returning = 0;
	for( new i=0; i < 6; i++ ) {
		if( IlegalGarage[ garage ][ igVehicleIds ][ i ] == index ) {
			returning = 1;
			break;
		}
	}
	return returning;
}

stock CountVehicleKinds()
{
	new Iterator: VehicleTypes<MAX_VEHICLES>,
		carid,
		model;
		
	Iter_Clear(VehicleTypes);
	
	if(Iter_Count(COVehicles) == 0)
		return 0;
		
	foreach(new vehicleid: COVehicles)
	{
		model = GetVehicleModel(vehicleid);
		carid = GetVehicleByModel(model);
		if( carid == -1 ) continue;
		if( IsABike(model) || IsABoat(model) || IsAMotorBike(model) || IsAPlane(model) || IsAHelio(model) ) continue;
		if( !LandVehicles[ carid ][ viCarJackerPrice ] ) continue;
		if( Iter_Contains(VehicleTypes, model) ) continue;
		Iter_Add(VehicleTypes, model);
	}
	return Iter_Count(VehicleTypes);
}

stock GetVehiclesForIlegalGarages(garage)
{
	new vehkinds = CountVehicleKinds();
	if(vehkinds >= 6) 
	{
		new vehid, carid;
		for( new i=0; i < 6; i++ ) 
		{
			CARID_GET:
			
			vehid = Iter_Random(COVehicles),
			carid = GetVehicleByModel(GetVehicleModel(vehid));
				
			if( carid == -1 ) goto CARID_GET;
			if( IsABike(GetVehicleModel(vehid)) || IsABoat(GetVehicleModel(vehid)) || IsAMotorBike(GetVehicleModel(vehid)) || IsAPlane(GetVehicleModel(vehid)) || IsAHelio(GetVehicleModel(vehid)) ) goto CARID_GET;
			if( !LandVehicles[ carid ][ viCarJackerPrice ] ) goto CARID_GET;
			if( IsVehicleOnList(garage, carid) ) goto CARID_GET;
			IlegalGarage[ garage ][ igVehicleIds ][ i ] = carid;
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
			if( !LandVehicles[ caridmodel ][ viCarJackerPrice ] ) goto CARID1_GET;
			if( IsVehicleOnList(garage, caridmodel) ) goto CARID1_GET;
			IlegalGarage[ garage ][ igVehicleIds ][ i ] = caridmodel;
		}	
	}
	return 1;
}

stock UpdateIlegalGarages(garage)
{
	for( new i=0; i < 6; i++ )
		IlegalGarage[ garage ][ igVehicleIds ][ i ] = 0;

	new vehicleName[MAX_VEHICLE_NAME];
	GetVehiclesForIlegalGarages(garage);

	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 0 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 0 ]);
		IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.969,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 1 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 1 ]);
		IlegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.519,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 1 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 2 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 2 ]);
		IlegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 2 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 3 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 3 ]);
		IlegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 3 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 4 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 4 ]);
		IlegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.509,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 4 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 5 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 5 ]);
		IlegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.959,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 5 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
}

stock static InitIlegalGarage(garage)
{
	IlegalGarage[ garage ][ igBoard ] = CreateDynamicObject(3077,2534.141,-2412.661,12.619,0.000,0.000,1.799,-1,-1,-1,300.000,300.000);
	IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2534.196,-2412.609,15.439,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, "Wanted List", 140, "courier", 42, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.969,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, "1", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.519,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 1 ], 0, "2", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 2 ], 0, "3", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 3 ], 0, "6", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.509,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 4 ], 0, "5", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.959,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 5 ], 0, "4", 140, "courier", 38, 1, -1, 0, 1);
	UpdateIlegalGarages(garage);
	
	IlegalGarage[ garage ][ ig3dText ] = CreateDynamic3DTextLabel("*", -1, IlegalGarage[ garage ][ ig3dTextPos ][ 0 ], IlegalGarage[ garage ][ ig3dTextPos ][ 1 ], IlegalGarage[ garage ][ ig3dTextPos ][ 2 ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 30.0);
	CheckForGarageWantedLevel(garage);
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
	// rBits
	Bit1_Set(r_CarDestroyed, 			playerid, false);
	Bit1_Set(gr_PlayerPickingJack, 		playerid, false);
	Bit1_Set(gr_PlayerJackSure, 		playerid, false);
	Bit8_Set(r_DestroyingCarSecs, 		playerid, 0);
	
	// 32bit
	PlayerJackerCoolDown[ playerid ]	= 0;
	DestroyedCar[ playerid ]			= 0;
	PlayerJackingCar[ playerid ]		= -1;
	JackerIlegalGarage[ playerid ]		= -1;
	JackerMoney[ playerid ]				= 0;
	
	if( DestroyingCarTimer[ playerid ] ) {
		KillTimer(DestroyingCarTimer[ playerid ]);
		DestroyingCarTimer[ playerid ]		= -1;
	}
	// TextDraws
//	DestroyJackerInfoPickTD(playerid);
//	DestroyJackerInterfaceTD(playerid);
}
/*stock DestroyJackerInterfaceTD(playerid)
{
	if( JackerArrow1[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow1[ playerid ]);
		JackerArrow1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerArrow2[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow2[ playerid ]);
		JackerArrow2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerArrow3[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow3[ playerid ]);
		JackerArrow3[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerArrow4[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow4[ playerid ]);
		JackerArrow4[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerArrow5[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow5[ playerid ]);
		JackerArrow5[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerArrow6[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerArrow6[ playerid ]);
		JackerArrow6[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static ShowJackerInterfaceTD(playerid)
{
	DestroyJackerInterfaceTD(playerid);
	JackerArrow1[playerid] = CreatePlayerTextDraw(playerid, 38.9, 121.1, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow1[playerid], 0.000000, 0.100000);
	PlayerTextDrawTextSize(playerid, JackerArrow1[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow1[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow1[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow1[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow1[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow1[playerid]);

	JackerArrow2[playerid] = CreatePlayerTextDraw(playerid, 38.9, 235.5, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow2[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, JackerArrow2[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow2[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow2[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow2[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow2[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow2[playerid]);

	JackerArrow3[playerid] = CreatePlayerTextDraw(playerid, 38.9, 361.0, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, JackerArrow3[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow3[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow3[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow3[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow3[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow3[playerid]);

	JackerArrow4[playerid] = CreatePlayerTextDraw(playerid, 319.9, 134.3, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow4[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, JackerArrow4[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow4[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow4[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow4[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow4[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow4[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow4[playerid]);

	JackerArrow5[playerid] = CreatePlayerTextDraw(playerid, 319.9, 235.6, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow5[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, JackerArrow5[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow5[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow5[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow5[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow5[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow5[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow5[playerid]);

	JackerArrow6[playerid] = CreatePlayerTextDraw(playerid, 319.9, 353.8, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, JackerArrow6[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, JackerArrow6[playerid], 31.0, 34.6);
	PlayerTextDrawAlignment(playerid, JackerArrow6[playerid], 1);
	PlayerTextDrawColor(playerid, JackerArrow6[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerArrow6[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerArrow6[playerid], 0);
	PlayerTextDrawFont(playerid, JackerArrow6[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, JackerArrow6[playerid], true);
	PlayerTextDrawShow(playerid, JackerArrow6[playerid]);
}*/
/*
stock DestroyJackerInfoPickTD(playerid)
{
	if( JackerPickBcg1[playerid]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickBcg1[playerid]);
		JackerPickBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickBcg2[playerid]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickBcg2[playerid]);
		JackerPickBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickTitle[playerid] 	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickTitle[playerid]);
		JackerPickTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickVehicle[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickVehicle[playerid]);
		JackerPickVehicle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickText[playerid] 	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickText[playerid]);
		JackerPickText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickInfo[playerid] 	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickInfo[playerid]);
		JackerPickInfo[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickTake[playerid] 	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickTake[playerid]);
		JackerPickTake[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( JackerPickLeave[playerid]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, JackerPickLeave[playerid]);
		JackerPickLeave[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}	*/

/*stock static CreateJackerInfoPickTD(playerid, carid)
{
	DestroyJackerInfoPickTD(playerid);
	PlayerJackingCar[ playerid ] = carid;
	
	JackerPickBcg1[playerid] = CreatePlayerTextDraw(playerid, 473.4, 177.7, "usebox");
	PlayerTextDrawLetterSize(playerid, JackerPickBcg1[playerid], 0.000000, 16.9);
	PlayerTextDrawTextSize(playerid, JackerPickBcg1[playerid], 185.4, 0.000000);
	PlayerTextDrawAlignment(playerid, JackerPickBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, JackerPickBcg1[playerid], -1);
	PlayerTextDrawUseBox(playerid, JackerPickBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, JackerPickBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, JackerPickBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, JackerPickBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, JackerPickBcg1[playerid]);

	JackerPickBcg2[playerid] = CreatePlayerTextDraw(playerid, 473.7, 178.5, "usebox");
	PlayerTextDrawLetterSize(playerid, JackerPickBcg2[playerid], 0.000000, 1.4);
	PlayerTextDrawTextSize(playerid, JackerPickBcg2[playerid], 185.599990, 0.000000);
	PlayerTextDrawAlignment(playerid, JackerPickBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, JackerPickBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, JackerPickBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, JackerPickBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, JackerPickBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, JackerPickBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, JackerPickBcg2[playerid]);

	JackerPickTitle[playerid] = va_CreatePlayerTextDraw(playerid, 285.5, 77.5, "Uzimate %s misiju?", GetVehicleName(LandVehicles[ carid ][ viModelid ], true));
	PlayerTextDrawLetterSize(playerid, JackerPickTitle[playerid], 0.4, 1.4);
	PlayerTextDrawAlignment(playerid, JackerPickTitle[playerid], 1);
	PlayerTextDrawColor(playerid, JackerPickTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerPickTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JackerPickTitle[playerid], 51);
	PlayerTextDrawFont(playerid, JackerPickTitle[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JackerPickTitle[playerid], 1);
	PlayerTextDrawShow(playerid, JackerPickTitle[playerid]);

	JackerPickText[playerid] = CreatePlayerTextDraw(playerid, 276.2, 202.9, "OSNOVNE INFORMACIJE");
	PlayerTextDrawLetterSize(playerid, JackerPickText[playerid], 0.4, 1.2);
	PlayerTextDrawAlignment(playerid, JackerPickText[playerid], 2);
	PlayerTextDrawColor(playerid, JackerPickText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerPickText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JackerPickText[playerid], 51);
	PlayerTextDrawFont(playerid, JackerPickText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JackerPickText[playerid], 1);
	PlayerTextDrawShow(playerid, JackerPickText[playerid]);

	JackerPickVehicle[playerid] = CreatePlayerTextDraw(playerid, 211.1, 225.9, "_");
	PlayerTextDrawLetterSize(playerid, JackerPickVehicle[playerid], 0.0, 0.0);
	PlayerTextDrawTextSize(playerid, JackerPickVehicle[playerid], 77.8, 76.9);
	PlayerTextDrawSetPreviewModel(playerid, JackerPickVehicle[playerid], LandVehicles[ carid ][ viModelid ]);
	PlayerTextDrawAlignment(playerid, JackerPickVehicle[playerid], 1);
	PlayerTextDrawColor(playerid, JackerPickVehicle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerPickVehicle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickVehicle[playerid], 0);
	PlayerTextDrawFont(playerid, JackerPickVehicle[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawShow(playerid, JackerPickVehicle[playerid]);


	JackerPickInfo[playerid] = va_CreatePlayerTextDraw(playerid, 313.4, 231.7, "~y~Naziv: ~w~%s~n~~y~Modelid: ~w~%d~n~~y~Sjedala: ~w~%d~n~~y~Cijena: ~w~%d~g~$", GetVehicleName(LandVehicles[ carid ][ viModelid ], true), LandVehicles[ carid ][ viModelid ], LandVehicles[ carid ][ viSeats ], LandVehicles[ carid ][ viCarJackerPrice ]);
	PlayerTextDrawLetterSize(playerid, JackerPickInfo[playerid], 0.4, 1.4);
	PlayerTextDrawAlignment(playerid, JackerPickInfo[playerid], 1);
	PlayerTextDrawColor(playerid, JackerPickInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JackerPickInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JackerPickInfo[playerid], 51);
	PlayerTextDrawFont(playerid, JackerPickInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JackerPickInfo[playerid], 1);
	PlayerTextDrawShow(playerid, JackerPickInfo[playerid]);

	JackerPickTake[playerid] = CreatePlayerTextDraw(playerid, 390.1, 316.4, "UZIMAM");
	PlayerTextDrawLetterSize(playerid, JackerPickTake[playerid], 0.3, 1.3);
	PlayerTextDrawTextSize(playerid, JackerPickTake[playerid], 997.6, 44.1);
	PlayerTextDrawAlignment(playerid, JackerPickTake[playerid], 2);
	PlayerTextDrawColor(playerid, JackerPickTake[playerid], -1);
	PlayerTextDrawUseBox(playerid, JackerPickTake[playerid], true);
	PlayerTextDrawBoxColor(playerid, JackerPickTake[playerid], 255);
	PlayerTextDrawSetShadow(playerid, JackerPickTake[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickTake[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JackerPickTake[playerid], 51);
	PlayerTextDrawFont(playerid, JackerPickTake[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JackerPickTake[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, JackerPickTake[playerid], true);
	PlayerTextDrawShow(playerid, JackerPickTake[playerid]);

	JackerPickLeave[playerid] = CreatePlayerTextDraw(playerid, 442.7, 316.5, "ODUSTANI");
	PlayerTextDrawLetterSize(playerid, JackerPickLeave[playerid], 0.3, 1.3);
	PlayerTextDrawTextSize(playerid, JackerPickLeave[playerid], 48.8, 53.0);
	PlayerTextDrawAlignment(playerid, JackerPickLeave[playerid], 2);
	PlayerTextDrawColor(playerid, JackerPickLeave[playerid], -1);
	PlayerTextDrawUseBox(playerid, JackerPickLeave[playerid], true);
	PlayerTextDrawBoxColor(playerid, JackerPickLeave[playerid], 255);
	PlayerTextDrawSetShadow(playerid, JackerPickLeave[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JackerPickLeave[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JackerPickLeave[playerid], 51);
	PlayerTextDrawFont(playerid, JackerPickLeave[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JackerPickLeave[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, JackerPickLeave[playerid], true);
	PlayerTextDrawShow(playerid, JackerPickLeave[playerid]);
}*/

/*stock static InitJackerInterface(playerid)
{
	new
		garage = JackerIlegalGarage[ playerid ];
	// Player sets
	SelectTextDraw(playerid, 0xFFFFFFFF);
	//SetPlayerVirtualWorld(playerid, playerid);
	//InterpolateCameraPos(playerid, IlegalGarage[ garage ][ igCameraPos ][ 0 ], IlegalGarage[ garage ][ igCameraPos ][ 1 ], IlegalGarage[ garage ][ igCameraPos ][ 2 ], IlegalGarage[ garage ][ igCameraPos ][ 0 ], IlegalGarage[ garage ][ igCameraPos ][ 1 ], IlegalGarage[ garage ][ igCameraPos ][ 2 ], 1000000);
	//InterpolateCameraLookAt(playerid, IlegalGarage[ garage ][ igCameraLookAt ][ 0 ], IlegalGarage[ garage ][ igCameraLookAt ][ 1 ], IlegalGarage[ garage ][ igCameraLookAt ][ 2 ], IlegalGarage[ garage ][ igCameraLookAt ][ 0 ], IlegalGarage[ garage ][ igCameraLookAt ][ 1 ], IlegalGarage[ garage ][ igCameraLookAt ][ 2 ], 1000000);
	//SetPlayerPos(playerid, IlegalGarage[ garage ][ igCameraPos ][ 0 ] - 5.0, IlegalGarage[ garage ][ igCameraPos ][ 1 ] - 10.0, IlegalGarage[ garage ][ igCameraPos ][ 2 ]);

    //CreateJackerInfoPickTD(playerid, IlegalGarage[ garage ][ igVehicleIds ][ 0 ]);
	ShowJackerInterfaceTD(playerid);
	Bit1_Set(gr_PlayerPickingJack, playerid, true);
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Odaberite vozilo koje zelite!");
}*/

stock static IsVehicleMission(playerid, modelid)
	return ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ] == modelid ? 1 : 0 );

stock static IsVehicleOnJackingList(garage, playercar)
{
	new
		index = 0;
	for( new i=0; i < 6; i++ ) {
		if( IlegalGarage[ garage ][ igVehicleIds ][ i ] == playercar ) {
			index = 1;
			break;
		}
	}
	return index;
}
	
forward DestroyingCar(playerid, vehicleid);
public DestroyingCar(playerid, vehicleid)
{
	if(JackerIlegalGarage[playerid] == -1)
	{
		DestroyMechanicTextDraw(playerid);
		KillTimer(DestroyingCarTimer[playerid]);
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta zbog greske!");
		return 0;
	}

	new 
		Float:X, 
		Float:Y, 
		Float:Z;
	
	GetVehiclePos(vehicleid, X, Y, Z);
	
	if( !IsPlayerInRangeOfPoint(playerid, 18.0, X, Y, Z) ) {
		DestroyMechanicTextDraw(playerid);
		KillTimer(DestroyingCarTimer[playerid]);
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta jer niste blizu vozila!");
		return 1;			
	}
	
	Bit8_Set( r_DestroyingCarSecs, playerid, Bit8_Get( r_DestroyingCarSecs, playerid )-1 );
	
	new
		tmpString[ 69 ];
	format(tmpString, 69, "~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d", Bit8_Get( r_DestroyingCarSecs, playerid ));
	PlayerTextDrawSetString(playerid, MechanicTD[playerid], tmpString);
	
	if( !Bit8_Get( r_DestroyingCarSecs, playerid ) ) {
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
			skillmoney = ((GetPlayerSkillLevel(playerid, 6) + 2) * 10),
			garage = JackerIlegalGarage[ playerid ],
			decrease = front_left_panel + front_right_panel + rear_left_panel + rear_right_panel + windshield + front_bumper + rear_bumper + bonnet + boot + driver_door + passenger_door + light1 + light2 + light3 + light4 + tire1 + tire2 + tire3 + tire4,
			value = ( ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viCarJackerPrice ] + skillmoney )  - ( decrease * 15 ) );
		
		IlegalGarage[ garage ][ igCarsJacked ]++;
		
		// Damage
		VehicleInfo[ vehicleid ][ vPanels ]		= encode_panels(1, 1, 1, 1, 3, 3, 3); 
		VehicleInfo[ vehicleid ][ vDoors ]		= encode_doors(4, 4, 4, 4, 0, 0);
		VehicleInfo[ vehicleid ][ vLights ]		= encode_lights(1, 1, 1, 1);
		VehicleInfo[ vehicleid ][ vTires ]		= encode_tires(1, 1, 1, 1);
		UpdateVehicleDamageStatus(vehicleid, VehicleInfo[ vehicleid ][ vPanels ], VehicleInfo[ vehicleid ][ vDoors ], VehicleInfo[ vehicleid ][ vLights ], VehicleInfo[ vehicleid ][ vTires ]);
		VehicleInfo[ vehicleid][ vTrunk ] = VEHICLE_PARAMS_ON;
		SetVehicleHealth(vehicleid, 388);
	
		// Finish
		JackerMoney[ playerid ] = value; // priprema novca koji pise sa leave
		//SendPoliceAlertMessage(vehicleid, garage);
		DestroyedCar[playerid] = GetVehicleModel(vehicleid);
		Bit1_Set(r_CarDestroyed, playerid, true);
		DestroyMechanicTextDraw(playerid);
		KillTimer(DestroyingCarTimer[playerid]);
		
		SendClientMessage(playerid,COLOR_RED, "Uspjesno ste rastavili vozilo. Sakrijte ga da biste dobili svoj novac! (/jacker leave)");
	}
	return 1;
}

stock static GetJackerIlegalGarage(playerid)
{
	new
		index = -1;
	if( IsPlayerInRangeOfPoint(playerid, 10.0, 2534.1411, -2412.6609, 12.6190) ) index = 0;
	return index;
}

stock static SendPoliceAlertMessage(vehicleid, garage)
{
	if( IlegalGarage[ garage ][ igWantedLevel ] < 2 ) {
		switch( random(random(20)) ) {
			case 1, 3, 8, 10, 12, 17: {
				foreach(new playerid : Player) {
					if( IsACop(playerid) ) {
						new vehicleName[MAX_VEHICLE_NAME];
						GetVehicleNameById(vehicleid, vehicleName, MAX_VEHICLE_NAME);

						SendClientMessage( playerid, COLOR_LIGHTBLUE, "*________________________ [ CAR STEAL] ________________________*");
						va_SendClientMessage(playerid, -1, "\tModel vozila: %s", vehicleName);
						va_SendClientMessage(playerid, -1, "\tBoja vozila: %d %d", VehicleColor1[vehicleid], VehicleColor2[vehicleid]);
						va_SendClientMessage(playerid, -1, "\tLokacija vozila: %s", GetVehicleZone( vehicleid ));
						SendClientMessage( playerid, COLOR_LIGHTBLUE, "*____________________________________________________________________*");
					}
				}
			}
		}
	} else {
		foreach(new playerid : Player) {
			if( IsACop(playerid) ) 
			{
				new vehicleName[MAX_VEHICLE_NAME];
				GetVehicleNameById(vehicleid, vehicleName, MAX_VEHICLE_NAME);

				SendClientMessage( playerid, COLOR_LIGHTBLUE, "*________________________ [ CAR STEAL ] ________________________*");
				va_SendClientMessage(playerid, -1, "\tModel vozila: %s", vehicleName);
				va_SendClientMessage(playerid, -1, "\tBoja vozila: %d %d", VehicleColor1[vehicleid], VehicleColor2[vehicleid]);
				va_SendClientMessage(playerid, -1, "\tLokacija vozila: %s", GetVehicleZone( vehicleid ));
				SendClientMessage( playerid, COLOR_LIGHTBLUE, "*____________________________________________________________________*");
			}
		}
	}
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
	
	ResetCarJackerVariables(playerid);
	return 1;
}
/*
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(Bit1_Get(gr_PlayerJackSure, playerid))
	{
		if( playertextid != PlayerText:INVALID_TEXT_DRAW )
		{
	//		new
	//			garage = JackerIlegalGarage[ playerid ];

				CancelSelectTextDraw(playerid);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste %s misiju. Ona se prekida kada odete offline!", GetVehicleName(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ], true));
				DestroyJackerInfoPickTD(playerid);
				//SetCameraBehindPlayer(playerid);
				//SetPlayerPos(playerid, IlegalGarage[ garage ][ igCameraPos ][ 0 ], IlegalGarage[ garage ][ igCameraPos ][ 1 ], IlegalGarage[ garage ][ igCameraPos ][ 2 ] - 1.0);
				//SetPlayerVirtualWorld(playerid, 0);
				Bit1_Set( gr_PlayerJackSure, playerid, false);
		}
		if( playertextid == PlayerText:JackerPickLeave[playerid] )
		{
				CancelSelectTextDraw(playerid);
				PlayerJackingCar[ playerid ] = -1;
				DestroyJackerInfoPickTD(playerid);
				//SetCameraBehindPlayer(playerid);
				//SetPlayerPos(playerid, IlegalGarage[ garage ][ igCameraPos ][ 0 ], IlegalGarage[ garage ][ igCameraPos ][ 1 ], IlegalGarage[ garage ][ igCameraPos ][ 2 ] - 1.0);
				//SetPlayerVirtualWorld(playerid, 0);
				Bit1_Set( gr_PlayerJackSure, playerid, false);
		}
	}
	return 1;
}*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_JACKER_PICK:
	    {
	        if(!response)
	            return SendClientMessage(playerid, COLOR_RED, "Odustali ste od posla!");
	            
            new
				garage = JackerIlegalGarage[ playerid ],
				vehicleName[MAX_VEHICLE_NAME];

			GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ listitem ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste vozilo %s!", vehicleName);
            
			va_ShowPlayerDialog(playerid, DIALOG_JACKER_SURE_1, DIALOG_STYLE_MSGBOX, "Odabir vozila", "Jeste li sigurni da Zelite zapoceti %s misiju?", "Da", "Ne", vehicleName);
            PlayerJackingCar[playerid] = IlegalGarage[garage][igVehicleIds][listitem];
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
		case DIALOG_JACKER_SURE_2: {
			if( !response ) return 1;			
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uspjesno ste prekinuli Car Jacker misiju!");
			PlayerJackingCar[ playerid ] = -1;
			new Hour, Minute, Second;
			gettime(Hour, Minute, Second);
			PlayerJackerCoolDown[ playerid ] = Hour + 1;
			UpdateIlegalGarages(JackerIlegalGarage[playerid]);
			return 1;
		}
		case DIALOG_JACKER_BRIBE: {
			if( !response ) return 1;
			IlegalGarage[ PlayerInfo[ playerid ][ pIllegalGarageKey ] ][ igWantedLevel ]	= 0;
			IlegalGarage[ PlayerInfo[ playerid ][ pIllegalGarageKey ] ][ igCarsJacked ]	= 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spustili wanted level na 0!");
			PlayerToOrgMoney( playerid, FACTION_TYPE_LAW, PlayerBribeMoney[ playerid ]); // Novac dolazi u PD factionbank
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
	if( sscanf(params, "i", garage) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /update_garage [garageid]");
	UpdateIlegalGarages(garage);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste updejtali garazu id %d.", garage);
	return 1;
}

CMD:jacker(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pJob ] != JACKER_JOB_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste car jacker!");
	new
		param[ 7 ];
	if( sscanf( params, "s[7] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /jacker [pick/chop/leave/stop]");
	if( !strcmp(param, "pick", true) ) {
		JackerIlegalGarage[ playerid ] = GetJackerIlegalGarage(playerid);
		if( JackerIlegalGarage[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( PlayerInfo[playerid][JackerCoolDown] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mora proci 60 minuta za novu misiju!");
		if( PlayerJackingCar[ playerid ] != -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa misija i dalje traje! Kucajte /jacker stop za odustanak.");

		new
			garage = JackerIlegalGarage[ playerid ];

		new
			vehicles_str[104],
			vehicleName[6][MAX_VEHICLE_NAME];
				
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName[0], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName[1], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName[2], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName[3], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName[4], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName[5], MAX_VEHICLE_NAME);

		format(vehicles_str, sizeof(vehicles_str), "%s\n%s\n%s\n%s\n%s\n%s",
		    vehicleName[0],
		    vehicleName[1],
		    vehicleName[2],
		    vehicleName[3],
		    vehicleName[4],
		    vehicleName[5]
		);
		ShowPlayerDialog(playerid, DIALOG_JACKER_PICK, DIALOG_STYLE_LIST, "Odaberite vozilo", vehicles_str, "Odaberi", "Odustani");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Odaberite vozilo koje zelite ukrasti!");
	}
	else if( !strcmp(param, "chop", true) ) {
		new
			Float:health,
			vehicleid = GetPlayerVehicleID(playerid);
			//garage = JackerIlegalGarage[ playerid ];
		GetVehicleHealth(vehicleid, health);
		
		if( PlayerJackingCar[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate uzeti misiju!");
		if( vehicleid == PlayerInfo[ playerid ][ pSpawnedCar ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete svoje vozilo uzeti!");
		if( !Iter_Contains(COVehicles, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo koje ste ukrali treba biti privatno, a ne iznajmljeno ili organizacijsko!");
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
		if( health < 550.0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo mora biti u boljem stanju (550+ HPa)!");
		
		if( GetJackerIlegalGarage(playerid) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( !IsVehicleMission(playerid, GetVehicleModel(vehicleid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo niste uzeli kao misiju!");
		
		new
			money = floatround(( LandVehicles[ PlayerJackingCar[ playerid ] ][ viCarJackerPrice ] + 48 ) * 0.25);
		if( CityInfo[cIllegalBudget] <= money ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nema dovoljno novca (%d$)!", money);
		
		RemovePlayerFromVehicle(playerid);
		SetVehiclePos(vehicleid, 2520.0364, -2412.6516, 13.7);
		Bit8_Set(r_DestroyingCarSecs, playerid, 30);
		CreateMechanicTextDraw(playerid);
		PlayerTextDrawSetString(playerid, MechanicTD[playerid], "~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~30");
		DestroyingCarTimer[playerid] = SetTimerEx("DestroyingCar", 1000, true, "ii", playerid, vehicleid);
	}
	else if( !strcmp(param, "leave", true) ) {
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
		if( !DestroyedCar[playerid] || DestroyedCar[playerid] != GetVehicleModel(GetPlayerVehicleID(playerid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo nije unisteno!");
		if(	PlayerJackingCar[ playerid ] < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste izabrali misiju.");
		if(	IsPlayerInRangeOfPoint(playerid, 200.0, 2535.6685,-2408.7539,13.6301) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste dovoljno daleko sakrili vozilo!");
	
		new
			garage = JackerIlegalGarage[ playerid ],
			tmpString[ 128 ],
			vehicleName[MAX_VEHICLE_NAME];	

		IllegalBudgetToPlayerMoney(playerid, JackerMoney[ playerid ]); // ilegalni budget se updatea i igrac dobiva novce
		IlegalGarage[ garage ][ igCarsJacked ]++;
		format(tmpString, 128, "UPDATE ilegal_garages SET jackedcars = '%d' WHERE id = '%d'", IlegalGarage[ garage ][ igCarsJacked ], IlegalGarage[ garage ][ igSQLID ]);
		mysql_tquery(g_SQL, tmpString, "");
		GetVehicleNameByModel(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zavrsili %s jacker misiju i zaradili %i$.", vehicleName, JackerMoney[ playerid ]);
				
		PlayerJackingCar[ playerid ] = -1;
		JackerMoney[ playerid ]	= 0;
		//PlayerJackerCoolDown[ playerid ] = gettimestamp() + 2699999;
		PlayerInfo[playerid][JackerCoolDown] = 1; // svakih sat vremena moze odradit jedan posao.
		UpdateIlegalGarages(garage);
		CheckForGarageWantedLevel(garage, true);
		UpgradePlayerSkill(playerid, 6);
	}
	else if( !strcmp(param, "stop", true) ) {
		if( PlayerJackingCar[ playerid ] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate aktivnu misiju!");
		ShowPlayerDialog(playerid, DIALOG_JACKER_SURE_2, DIALOG_STYLE_MSGBOX, "Jacker misija", "Zelite li odustati od misije?\n"COL_RED"NAPOMENA: Ukoliko odustanete cooldown od 45 minuta se primjenuje!", "Odustajem", "Natrag");
	}
	return 1;
}

CMD:igarage(playerid, params[])
{
	new
		param[ 8 ];
	if( sscanf( params, "s[8] ", param ) ) {
		SendClientMessage(playerid, COLOR_RED, "USAGE: /igarage [options]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buy - info - bribe");
		return 1;
	}
	if( !strcmp(param, "buy", true) ) {
		if( PlayerInfo[ playerid ][ pIllegalGarageKey ] != -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate ilegalnu garazu!");
		if( AC_GetPlayerMoney(playerid) < 60000 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupovinu ilegalne garaze (60.000$)!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu car jacker garaze!");
		if( IlegalGarage[ garage ][ igOwner ] != 0 || IlegalGarage[ garage ][ igOwner ] != 9999 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Garaza nije na prodaju!");
		PlayerInfo[ playerid ][ pIllegalGarageKey ] = garage;
		IlegalGarage[ garage ][ igOwner ] = PlayerInfo[ playerid ][ pSQLID ];
		CheckForGarageWantedLevel(garage, true);
		PlayerToIllegalBudgetMoney(playerid, 60000); // Novac dolazi u ilegalni proracun
	}
	else if( !strcmp(param, "info", true) ) {
		if( PlayerInfo[ playerid ][ pIllegalGarageKey ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete ilegalnu garazu!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		va_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST, "Ilegal Garage - Info", "Ime:\t%s\nWanted level:\t%d\nAuta ukradeno:\t%d", "Uredu", "", IlegalGarage[ garage ][ igName ], IlegalGarage[ garage ][ igWantedLevel ], IlegalGarage[ garage ][ igCarsJacked ]);
	}
	else if( !strcmp(param, "bribe", true) ) {
		if( PlayerInfo[ playerid ][ pIllegalGarageKey ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete ilegalnu garazu!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		if( IlegalGarage[ garage ][ igWantedLevel ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 2+ zvjezdica!");
		new
			money = ( IlegalGarage[ garage ][ igWantedLevel ] * ( random(random(250)) + 1 ) ) + ( IlegalGarage[ garage ][ igCarsJacked ] * 1000 );
		PlayerBribeMoney[ playerid ] = money;
		va_ShowPlayerDialog(playerid, DIALOG_JACKER_BRIBE, DIALOG_STYLE_MSGBOX, "Ilegal Garage - Bribe", "Zelite li podmititi policiju da vam spuste wanted level na 0?\nOna ce kostati %d$!", "Podmiti", "Odustani", money);
	}
	/*else if( !strcmp(param, "money", true) ) {
		new
			garage = GetJackerIlegalGarage(playerid),
			pick[ 4 ],
			money;
		
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze ili nemate garazu!");
		if( sscanf( params, "s[8]s[8]i", param, pick, money ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /igarage money [take/put][kolicina]");
		if( !strcmp(pick, "take", true) ) {
			if( money >  IlegalGarage[ garage ][ igMoney ] || money < 1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u garazi!");
			
			IlegalGarage[ garage ][ igMoney ] -= money;
			AC_GivePlayerMoney(playerid, money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %d$ iz ilegalne garaze!", money);
		}
		else if( !strcmp(pick, "put", true) ) {
			if( money < 1 || money > AC_GetPlayerMoney(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u ruci!");
			
			IlegalGarage[ garage ][ igMoney ] += money;
			AC_GivePlayerMoney(playerid, -money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste stavili %d$ u ilegalnu garazu!", money);
		}
	}*/
	return 1;
}
