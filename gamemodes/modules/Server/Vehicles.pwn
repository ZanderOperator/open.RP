#include <YSI_Coding\y_hooks>
#include "modules/Systems/LSPD/LSPD_h.pwn"

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// rBits
static
	Bit1:	gr_JackedPlayer		<MAX_PLAYERS>,
	Bit16:	gr_JackedVehicle	<MAX_PLAYERS>,
	Bit16:	gr_LastDriver		<MAX_VEHICLES>;

timer ResetVehicleSafeTeleport[60](vehicleid)
{
	VehicleInfo[vehicleid][vServerTeleport] = false;
	return 1;
}

timer ResetVehicleSafeDelete[100](vehicleid)
{
	VehicleInfo[vehicleid][vDeleted] = false;
	return 1;
}


/*
	##     ## ######## ##     ##    ##     ## ########    ###    ##       ######## ##     ##
	##     ## ##       ##     ##    ##     ## ##         ## ##   ##          ##    ##     ##
	##     ## ##       ##     ##    ##     ## ##        ##   ##  ##          ##    ##     ##
	##     ## ######   #########    ######### ######   ##     ## ##          ##    #########
	 ##   ##  ##       ##     ##    ##     ## ##       ######### ##          ##    ##     ##
	  ## ##   ##       ##     ##    ##     ## ##       ##     ## ##          ##    ##     ##
	   ###    ######## ##     ##    ##     ## ######## ##     ## ########    ##    ##     ##
*/

Public:OnServerVehicleLoad()
{
	if( !cache_num_rows() ) return printf("MySQL Report: No cars exist to load.");
	new
		carLoad[E_VEHICLE_DATA],
		vCarID,
		tmp[9],rmp[15];
	for(new b = 0; b < cache_num_rows(); b++) {
		cache_get_value_name_int(b, 	"model"		, carLoad[vModel]);
		cache_get_value_name_float(b, 	"parkX"		, carLoad[vParkX]);
		cache_get_value_name_float(b, 	"parkY"		, carLoad[vParkY]);
		cache_get_value_name_float(b, 	"parkZ"		, carLoad[vParkZ]);
		cache_get_value_name_float(b, 	"angle"		, carLoad[vAngle]);
		cache_get_value_name_int(b, 	"color1"	, carLoad[vColor1]);
		cache_get_value_name_int(b, 	"color2"	, carLoad[vColor2]);
		cache_get_value_name_int(b, 	"respawn"	, carLoad[vRespawn]);
		cache_get_value_name_int(b, 	"sirenon"	, carLoad[vSirenon]);

		vCarID = AC_CreateVehicle( carLoad[vModel], carLoad[vParkX], carLoad[vParkY], carLoad[vParkZ], carLoad[vAngle], carLoad[vColor1], carLoad[vColor2], carLoad[vRespawn], carLoad[vSirenon] );
		ResetVehicleInfo(vCarID);

		VehiclePrevInfo[vCarID][vPosX] = carLoad[ vParkX ];
		VehiclePrevInfo[vCarID][vPosY] = carLoad[ vParkY ];
		VehiclePrevInfo[vCarID][vPosZ] = carLoad[ vParkZ ];
		VehiclePrevInfo[vCarID][vRotZ] = carLoad[ vAngle ];
		VehiclePrevInfo[vCarID][vPosDiff] = 0.0;

		VehicleInfo[ vCarID ][ vModel ] 			= carLoad[ vModel ];
		VehicleInfo[ vCarID ][ vParkX ] 			= carLoad[ vParkX ];
		VehicleInfo[ vCarID ][ vParkY ] 			= carLoad[ vParkY ];
		VehicleInfo[ vCarID ][ vParkZ ] 			= carLoad[ vParkZ ];
		VehicleInfo[ vCarID ][ vAngle ] 			= carLoad[ vAngle ];
		VehicleInfo[ vCarID ][ vColor1 ] 			= carLoad[ vColor1 ];
		VehicleInfo[ vCarID ][ vColor2 ] 			= carLoad[ vColor2 ];
		VehicleInfo[ vCarID ][ vRespawn ] 			= carLoad[ vRespawn ];
		VehicleInfo[ vCarID ][ vSirenon ] 			= carLoad[ vSirenon ];
		

		cache_get_value_name_int(b, 	"id"		, VehicleInfo[ vCarID ][ vSQLID ]);
		cache_get_value_name_int(b, 	"type"		, VehicleInfo[ vCarID ][ vType ]);
		cache_get_value_name_int(b, 	"usage"		, VehicleInfo[ vCarID ][ vUsage ]);
		cache_get_value_name_int(b, 	"faction"	, VehicleInfo[ vCarID ][ vFaction ]);
		cache_get_value_name_int(b, 	"job"		, VehicleInfo[ vCarID ][ vJob ]);
		cache_get_value_name_int(b, 	"locked"	, VehicleInfo[ vCarID ][ vLocked ]);
		cache_get_value_name_int(b, 	"int"		, VehicleInfo[ vCarID ][ vInt ]);
		cache_get_value_name_int(b, 	"viwo"		, VehicleInfo[ vCarID ][ vViwo ]);
		cache_get_value_name_float(b, 	"health"	, VehicleInfo[ vCarID ][ vHealth ]);
		cache_get_value_name_int(b, 	"paintjob"	, VehicleInfo[ vCarID ][ vPaintJob ]);

		VehicleInfo[ vCarID ][ vBodyArmor ] 		= carLoad[ vBodyArmor ];
		VehicleInfo[ vCarID ][ vTireArmor ] 		= carLoad[ vTireArmor ];

		cache_get_value_name(b, "numberplate", tmp, sizeof(tmp));
		format( VehicleInfo[ vCarID ][ vNumberPlate ], 8, tmp );

		cache_get_value_name_float(b, 	"travel"		, VehicleInfo[ vCarID ][ vTravel ] );
		cache_get_value_name_int(b, 	"overheated"	, VehicleInfo[ vCarID ][ vOverHeated]);
		VehicleInfo[ vCarID ][ vFuel ] 				= 100;
		VehicleInfo[ vCarID ][ vTrunk ] 			= 1;
		VehicleInfo[ vCarID ][ vCanStart ] 			= 1;
		VehicleInfo[ vCarID ][ vParts ] 			= 0;
		VehicleInfo[ vCarID ][ vTimesDestroy ] 		= 0;
		SetVehicleHealth( vCarID, VehicleInfo[ vCarID ][ vHealth ] );

		new model = GetVehicleModel(vCarID);
		cache_get_value_name(b, "text", rmp);
		format( VehicleInfo[ vCarID ][ vText ], 13, rmp );
		if(VehicleInfo[vCarID][vFaction] > 0 || VehicleInfo[vCarID][vJob] > 0) VehicleInfo[vCarID][vAudio] = 1;
		switch( VehicleInfo[vCarID][vFaction] ) {
			case 1: {
				if( !(model == 497 || model == 469 || model == 430 || model == 431) ) {
					if( isnull(VehicleInfo[vCarID][vText]) )
						format(VehicleInfo[vCarID][vText], 13, "LSPD");
					if( VehicleInfo[vCarID][vText][0] != '0' ) {
						VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
						VehicleInfo[vCarID][vFactionTextOn] = 1;
					}
				}
			}
			case 3: {
				if( !(model == 497 || model == 469 || model == 430 || model == 431) ) {
					if( isnull(VehicleInfo[vCarID][vText]) )
						format(VehicleInfo[vCarID][vText], 13, "LSSD");
					if( VehicleInfo[vCarID][vText][0] != '0' ) {
						VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
						VehicleInfo[vCarID][vFactionTextOn] = 1;
					}
				}
			}
			case 4: {
				if( isnull(VehicleInfo[vCarID][vText]) )
					format(VehicleInfo[vCarID][vText], 13, "GOV");
				if( VehicleInfo[vCarID][vText][0] != '0' ) {
					VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
					VehicleInfo[vCarID][vFactionTextOn] = 1;
				}
				VehicleInfo[vCarID][vBodyArmor] = 1;
				AC_SetVehicleHealth(vCarID, 1600.0);
			}
			case 2: {
				switch(model) {
					case 407: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.5361, -3.8234, -0.7254, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 416: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.5434, -3.6819, -0.4500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 424: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.0413, -1.6196, 0.2500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 544: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.0442, -3.7343, -0.2000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 490: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6381, -3.2258, -0.3600, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 596: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 599: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6504, -2.7506, -0.3600, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 552: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.9242, -3.0798, 0.0234, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 427: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.3975, -3.6268, 0.0234, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
						VehicleInfo[vCarID][vFactionTextOn] = 1;
					}
					case 525: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6073, -3.0629, -0.1200, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 437: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.4615, -5.4731, -0.1200, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 563: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.7704, -4.0637, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
					case 497: {
						if( isnull(VehicleInfo[vCarID][vText]) )
							format(VehicleInfo[vCarID][vText], 13, "LSFD");

						if( VehicleInfo[vCarID][vText][0] != '0' ) {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.1615, -2.0197, -0.2500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0 );
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
				}
			}
		}
		if( VehicleInfo[vCarID][vNumberPlate][0] == '0' )
				SetVehicleNumberPlate(vCarID, "");
			else
				SetVehicleNumberPlate(vCarID, VehicleInfo[vCarID][vNumberPlate]);

		new
			engine,lights,alarm,doors, edoors, bonnet,boot,objective;
		if(VehicleInfo[vCarID][vLocked])
			doors = 1;
		else doors = 0;
		GetVehicleParamsEx(vCarID,engine,lights,alarm,edoors,bonnet,boot,objective);

		if(IsABike(model) || IsAPlane(model) || IsABike(model) ) {
			SetVehicleParamsEx(vCarID,VEHICLE_PARAMS_ON,VEHICLE_PARAMS_OFF,alarm,doors,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
			VehicleInfo[vCarID][vEngineRunning] = 1;
		} else {
			SetVehicleParamsEx(vCarID,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,alarm,doors,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
			VehicleInfo[vCarID][vEngineRunning] = 0;
		}
		LinkVehicleToInterior(vCarID, 	VehicleInfo[vCarID][vInt]);
		SetVehicleVirtualWorld(vCarID, 	VehicleInfo[vCarID][vViwo]);
	}
	printf("MySQL Report: Cars Loaded (%d)!", cache_num_rows());
	return 1;
}

Public:OnServerVehicleCreate(vehicleid)
{
	VehicleInfo[vehicleid][ vSQLID ] = cache_insert_id();
	SaveVehicle(vehicleid);
}


/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

stock ResetVehicleInfo(vehicleid)
{
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	
	ClearVehicleMusic(vehicleid);	
	ResetTuning(vehicleid);
	
	// Vehicle Previous Info
	VehiclePrevInfo[vehicleid][vPosX] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosY] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vRotZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vHealth] 				= 0.0;
	VehiclePrevInfo[vehicleid][vPanels]					= 0;
	VehiclePrevInfo[vehicleid][vDoors]					= 0;
	VehiclePrevInfo[vehicleid][vTires]					= 0;
	VehiclePrevInfo[vehicleid][vLights]					= 0;
	
	// Ints
	VehicleInfo[ vehicleid ][ vSQLID ]					= -1;
	VehicleInfo[ vehicleid ][ vModel ]                  = 400;
	VehicleInfo[ vehicleid ][ vOwnerID ]                = 0;
	VehicleInfo[ vehicleid ][ vServerTeleport ] 		= false;
	VehicleInfo[ vehicleid ][ vSpawned ]                = 0;
	VehicleInfo[ vehicleid ][ vColor1 ]                 = 0;
	VehicleInfo[ vehicleid ][ vColor2 ]                 = 0;
	VehicleInfo[ vehicleid ][ vEngineType ]             = 0;
	VehicleInfo[ vehicleid ][ vEngineLife ]             = 0;
	VehicleInfo[ vehicleid ][ vEngineScrewed ]          = 0;
	VehicleInfo[ vehicleid ][ vEngineRunning ]          = 0;
	VehicleInfo[ vehicleid ][ vCanStart ]               = 0;
	VehicleInfo[ vehicleid ][ vParts ]                  = 0;
	VehicleInfo[ vehicleid ][ vTimesDestroy ]			= 0;
	VehicleInfo[ vehicleid ][ vOverHeated ]             = 0;
	VehicleInfo[ vehicleid ][ vBatteryType ]            = 0;
	VehicleInfo[ vehicleid ][ vFuel ]                   = 0;
	VehicleInfo[ vehicleid ][ vInsurance ]              = 0;
	VehicleInfo[ vehicleid ][ vPanels ]                 = 0;
	VehicleInfo[ vehicleid ][ vDoors ]                  = 0;
	VehicleInfo[ vehicleid ][ vTires ]                  = 0;
	VehicleInfo[ vehicleid ][ vLights ]                 = 0;
	VehicleInfo[ vehicleid ][ vBonnets ]                = 0;
	VehicleInfo[ vehicleid ][ vTrunk ]                  = 0;
	
	VehicleInfo[ vehicleid ][ vLock ]                   = 0;
	VehicleInfo[ vehicleid ][ vLocked ]                 = 0;
	VehicleInfo[ vehicleid ][ vAlarm ]                  = 0;
	VehicleInfo[ vehicleid ][ vImmob ]                  = 0;
	VehicleInfo[ vehicleid ][ vAudio ]                  = 0;
	VehicleInfo[ vehicleid ][ vBodyArmor ]              = 0;
	VehicleInfo[ vehicleid ][ vTireArmor ]              = 0;

	vTireHP[ vehicleid ][ 0 ] 							= 100;
	vTireHP[ vehicleid ][ 1 ] 							= 100;
	vTireHP[ vehicleid ][ 2 ] 							= 100;
	vTireHP[ vehicleid ][ 3 ] 							= 100;

	VehicleInfo[ vehicleid ][ vDestroys ]               = 0;
	VehicleInfo[ vehicleid ][ vUsage ]                  = 0;
	VehicleInfo[ vehicleid ][ vType ]                   = 0;
	VehicleInfo[ vehicleid ][ vFaction ]                = 0;
	VehicleInfo[ vehicleid ][ vJob ]                    = 0;
	VehicleInfo[ vehicleid ][ vInt ]                    = 0;
	VehicleInfo[ vehicleid ][ vViwo ]                   = 0;
	VehicleInfo[ vehicleid ][ vRespawn ]                = 0;
	VehicleInfo[ vehicleid ][ vGPS ] 					= true;
	VehicleInfo[ vehicleid ][ vTuned ] 					= false;
	VehicleInfo[ vehicleid ][ vPaintJob ]               = 255;
	VehicleInfo[ vehicleid ][ vSpoiler ]                = -1;
	VehicleInfo[ vehicleid ][ vHood ]                   = -1;
	VehicleInfo[ vehicleid ][ vRoof ]                   = -1;
	VehicleInfo[ vehicleid ][ vSkirt ]                  = -1;
	VehicleInfo[ vehicleid ][ vLamps ]                  = -1;
	VehicleInfo[ vehicleid ][ vNitro ]                  = -1;
	VehicleInfo[ vehicleid ][ vSirenon ]                = 0;
	VehicleInfo[ vehicleid ][ vExhaust ]                = -1;
	VehicleInfo[ vehicleid ][ vWheels ]                 = -1;
	VehicleInfo[ vehicleid ][ vStereo ]                 = -1;
	VehicleInfo[ vehicleid ][ vHydraulics ]             = -1;
	VehicleInfo[ vehicleid ][ vFrontBumper ]            = -1;
	VehicleInfo[ vehicleid ][ vRearBumper ]             = -1;
	VehicleInfo[ vehicleid ][ vRightVent ]              = -1;
	VehicleInfo[ vehicleid ][ vLeftVent ]               = -1;
	VehicleInfo[ vehicleid ][ vImpounded ]              = 0;
	VehicleInfo[ vehicleid ][ vFactionTextOn ]          = 0;
	
	VehicleInfo[ vehicleid ][ vTicketsSQLID ][ 0 ]		= 0;
	VehicleInfo[ vehicleid ][ vTicketsSQLID ][ 1 ]		= 0;
	VehicleInfo[ vehicleid ][ vTicketsSQLID ][ 2 ]		= 0;
	VehicleInfo[ vehicleid ][ vTicketsSQLID ][ 3 ]		= 0;
	VehicleInfo[ vehicleid ][ vTicketsSQLID ][ 4 ]		= 0;
	VehicleInfo[ vehicleid ][ vTickets ][ 0 ]			= 0;
	VehicleInfo[ vehicleid ][ vTickets ][ 1 ]			= 0;
	VehicleInfo[ vehicleid ][ vTickets ][ 2 ]			= 0;
	VehicleInfo[ vehicleid ][ vTickets ][ 3 ]			= 0;
	VehicleInfo[ vehicleid ][ vTickets ][ 4 ]			= 0;
	VehicleInfo[ vehicleid ][ vTicketShown ][ 0 ]		= 1;
	VehicleInfo[ vehicleid ][ vTicketShown ][ 1 ]		= 1;
	VehicleInfo[ vehicleid ][ vTicketShown ][ 2 ]		= 1;
	VehicleInfo[ vehicleid ][ vTicketShown ][ 3 ]		= 1;
	VehicleInfo[ vehicleid ][ vTicketShown ][ 4 ]		= 1;
		
	SirenObject[ vehicleid ]							= INVALID_OBJECT_ID;

	// Strings
	VehicleInfo[ vehicleid ][ vOwner ][ 0 ]				= EOS;
	VehicleInfo[ vehicleid ][ vNumberPlate ][ 0 ]		= EOS;
	VehicleInfo[ vehicleid ][ vText ][ 0 ]				= EOS;
	VehicleInfo[ vehicleid ][ vVehicleAdText ][ 0 ]		= EOS;

	// Floats
	VehicleInfo[ vehicleid ][ vParkX ]			= 0.0;
	VehicleInfo[ vehicleid ][ vParkY ]          = 0.0;
	VehicleInfo[ vehicleid ][ vParkZ ]          = 0.0;
	VehicleInfo[ vehicleid ][ vAngle ]          = 0.0;
	VehicleInfo[ vehicleid ][ vHeat ]           = 0.0;
	VehicleInfo[ vehicleid ][ vBatteryLife ]    = 0.0;
	VehicleInfo[ vehicleid ][ vTravel ]         = 0.0;
	VehicleInfo[ vehicleid ][ vDoorHealth ]		= 0.0;
	VehicleInfo[ vehicleid ][ vTrunkHealth ] 	= 0.0;
	VehicleInfo[ vehicleid ][ vHealth ]			= 1000.0;

	// Bools
	VehicleInfo[ vehicleid ][ vDestroyed ] 		= false;

	// 3d Texts
	if(VehicleInfo[ vehicleid ][ vFactionText ] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel( VehicleInfo[ vehicleid ][ vFactionText ] );
		VehicleInfo[ vehicleid ][ vFactionText ] = Text3D:INVALID_3DTEXT_ID;
	}
	
	if(VehicleInfo[ vehicleid ][ vVehicleAdId ] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel( VehicleInfo[ vehicleid ][ vVehicleAdId ] );
		VehicleInfo[ vehicleid ][ vVehicleAdId ] = Text3D:INVALID_3DTEXT_ID;
	}
	
	if(DoorHealth3DText[vehicleid] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel(DoorHealth3DText[vehicleid]);
		DoorHealth3DText[vehicleid] = Text3D:INVALID_3DTEXT_ID;
	}
	
	if(TrunkHealth3DText[vehicleid] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel(TrunkHealth3DText[vehicleid]);
		TrunkHealth3DText[vehicleid] = Text3D:INVALID_3DTEXT_ID;
	}
	
	Bit1_Set( gr_VehicleAttachedBomb, vehicleid, false );
	Bit16_Set( gr_LastDriver, vehicleid, INVALID_PLAYER_ID );
}

stock AC_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay = -1, sirenon = 0)
{
	new
		id = CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, sirenon);

	if(!Iter_Contains(Vehicles, id))
		Iter_Add(Vehicles, id);

	VehicleInfo[id][vModel] = vehicletype;
	VehicleInfo[id][vRespawn] = respawn_delay;
	VehicleInfo[id][vServerTeleport] = false;
	VehicleInfo[id][vViwo] = GetVehicleVirtualWorld(id);


	VehiclePrevInfo[id][vPosX] = x;
	VehiclePrevInfo[id][vPosY] = y;
	VehiclePrevInfo[id][vPosZ] = z;
	VehiclePrevInfo[id][vRotZ] = rotation;
	VehiclePrevInfo[id][vPosDiff] = 0.0;

	CheckVehicleObjects(id);
	return id;
}

stock AC_DestroyVehicle(vehicleid)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 		return 0;
	if( !Iter_Contains(Vehicles, vehicleid) || !IsValidVehicle(vehicleid) )	
		return 0;

	RemoveAllVehicleTuning(vehicleid);
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	if(VehicleInfo[vehicleid][vUsage] == 5) // VEHICLE_USAGE_RENT
		DestroyRentVehicle(vehicleid);

	VehicleInfo[vehicleid][vDeleted]					= true;

	// Vehicle Previous Info
	VehiclePrevInfo[vehicleid][vPosX] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosY] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vRotZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vHealth] 				= 0.0;
	VehiclePrevInfo[vehicleid][vPanels]					= 0;
	VehiclePrevInfo[vehicleid][vDoors]					= 0;
	VehiclePrevInfo[vehicleid][vTires]					= 0;
	VehiclePrevInfo[vehicleid][vLights]					= 0;

	VehicleInfo[vehicleid][vEngineRunning] = 0;
	VehicleAlarmStarted[vehicleid] = false;
	DestroyVehicle(vehicleid);
	Iter_Remove(Vehicles, vehicleid);
	defer ResetVehicleSafeDelete(vehicleid);
	return 1;
}

stock SetRespawnedVehicleParams(vehicleid)
{
	if( VehicleInfo[vehicleid][vNumberPlate][0] == '0' )
		SetVehicleNumberPlate(vehicleid, " ");
	else
		SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][vNumberPlate]);
	new
		engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(IsABike(VehicleInfo[vehicleid][vModel]) || IsAPlane(VehicleInfo[vehicleid][vModel])) {
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,VEHICLE_PARAMS_OFF,alarm,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
		VehicleInfo[vehicleid][vEngineRunning] = 1;
	} else {
		if(VehicleInfo[vehicleid][vDestroyed] == true)
		{
			doors = 0;
			VehicleInfo[vehicleid][vLocked] = false;
		}
		else
		{
			if(!VehicleInfo[vehicleid][vLocked])
				doors = 0;
			else
				doors = 1;
		}
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		VehicleInfo[vehicleid][vEngineRunning] = 0;
	}
	return 1;
}

stock GetVehiclePreviousInfo(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 1;
	new Float:x, Float:y, Float:z, Float:rz;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, rz);
	VehiclePrevInfo[vehicleid][vPosX] = x;
	VehiclePrevInfo[vehicleid][vPosY] = y;
	VehiclePrevInfo[vehicleid][vPosZ] = z;
	VehiclePrevInfo[vehicleid][vRotZ] = rz;
	GetVehicleDamageStatus(vehicleid, VehiclePrevInfo[vehicleid][vPanels], VehiclePrevInfo[vehicleid][vDoors], VehiclePrevInfo[vehicleid][vLights], VehiclePrevInfo[vehicleid][vTires]);
	GetVehicleHealth(vehicleid, VehiclePrevInfo[vehicleid][vHealth]);
	return 1;
}

stock SetVehiclePreviousInfo(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 0;
	if(DoesVehicleHavePlayers(vehicleid)) return 0;
	SetVehiclePos(vehicleid, VehiclePrevInfo[vehicleid][vPosX], VehiclePrevInfo[vehicleid][vPosY], VehiclePrevInfo[vehicleid][vPosZ]);
	SetVehicleZAngle(vehicleid, VehiclePrevInfo[vehicleid][vRotZ]);
	UpdateVehicleDamageStatus(vehicleid, VehiclePrevInfo[vehicleid][vPanels], VehiclePrevInfo[vehicleid][vDoors], VehiclePrevInfo[vehicleid][vLights], VehiclePrevInfo[vehicleid][vTires]);
	SetVehicleHealth(vehicleid, VehiclePrevInfo[vehicleid][vHealth]);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	if(VehicleInfo[vehicleid][vServerTeleport] == true)
		defer ResetVehicleSafeTeleport(vehicleid);
	return 1;
}


stock AC_SetVehicleToRespawn(vehicleid, bool:oldpos = false)
{
	new
		Float:vhealth;

	if(vehicleid == INVALID_VEHICLE_ID)	return 0;
	if( !Iter_Contains(Vehicles, vehicleid) ) return 0;
	VehicleInfo[vehicleid][vServerTeleport] = true;
	RemoveAllVehicleTuning(vehicleid);
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	SetVehicleToRespawn(vehicleid);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][vInt]);
	SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][vViwo]);
	if( VehicleInfo[vehicleid][vUsage] == 2 )  // VEHICLE_USAGE_PRIVATE
	{
		CheckVehicleInsurance(vehicleid);
		SetTune(vehicleid);
		RespawnTrunkObjects(vehicleid);
	}
	if(VehicleInfo[ vehicleid ][ vImpounded ] == 1)
	{
		SetVehiclePos(vehicleid, VehicleInfo[vehicleid][vParkX], VehicleInfo[vehicleid][vParkY], VehicleInfo[vehicleid][vParkZ]);
		SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][vAngle]);
	}
	SetRespawnedVehicleParams(vehicleid);

	if(oldpos == true)
		SetVehiclePreviousInfo(vehicleid);
	else
		defer ResetVehicleSafeTeleport(vehicleid);

	GetVehicleHealth(vehicleid, vhealth);

	if(vhealth <= 250.0)
		AC_SetVehicleHealth(vehicleid, 254.0);
	return 1;
}

#if defined _ALS_SetVehicleToRespawn
    #undef SetVehicleToRespawn
#else
    #define _ALS_SetVehicleToRespawn
#endif
#define SetVehicleToRespawn AC_SetVehicleToRespawn



stock AC_AddVehicleComponent(vehicleid, componentid)
{
	if(!IsComponentidCompatible(GetVehicleModel(vehicleid), componentid))
		return 0;
	else AddVehicleComponent(vehicleid, componentid);
	return 1;
}
#if defined _ALS_AddVehicleComponent
    #undef AddVehicleComponent
#else
    #define _ALS_AddVehicleComponent
#endif
#define AddVehicleComponent AC_AddVehicleComponent

stock AC_SetVehicleHealth(vehicleid, Float:health)
{
	VehicleInfo[vehicleid][vHealth] = health;
	return SetVehicleHealth(vehicleid, health);
}
#if defined _ALS_SetVehicleHealth
    #undef SetVehicleHealth
#else
    #define _ALS_SetVehicleHealth
#endif
#define SetVehicleHealth AC_SetVehicleHealth

stock AC_RepairVehicle(vehicleid)
{
	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
	VehicleInfo[vehicleid][vPanels]		= 0;
	VehicleInfo[vehicleid][vDoors]		= 0;
	VehicleInfo[vehicleid][vLights]		= 0;
	VehicleInfo[vehicleid][vTires]		= 0;
	VehicleInfo[vehicleid][vHealth] 	= 1000.0;
	VehicleInfo[vehicleid][vDestroyed]	= false;
	VehicleInfo[vehicleid][vGPS] = true;
	return RepairVehicle(vehicleid);
}
#if defined _ALS_RepairVehicle
    #undef RepairVehicle
#else
    #define _ALS_RepairVehicle
#endif
#define RepairVehicle AC_RepairVehicle

stock AC_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	if(!Iter_Contains(Vehicles, vehicleid)) return 1;
	VehicleInfo[vehicleid][vServerTeleport] = true;
	VehiclePrevInfo[vehicleid][vPosX] = x;
	VehiclePrevInfo[vehicleid][vPosY] = y;
	VehiclePrevInfo[vehicleid][vPosZ] = z;
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	defer ResetVehicleSafeTeleport(vehicleid);
	return SetVehiclePos(vehicleid, x, y, z);
}
#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else
	#define _ALS_SetVehiclePos
#endif
#define SetVehiclePos AC_SetVehiclePos

stock AC_SetVehicleVelocity(vehicleid, Float:X, Float:Y, Float:Z)
{
	if(!VehicleInfo[vehicleid][vServerTeleport] || DoesVehicleHavePlayers(vehicleid))
		return 1;
	SetVehicleVelocity(vehicleid, X, Y, Z);
	return 1;
}
#if defined _ALS_SetVehicleVelocity
	#undef SetVehicleVelocity
#else
	#define _ALS_SetVehicleVelocity
#endif
#define SetVehicleVelocity AC_SetVehicleVelocity

stock LoadServerVehicles()
{
	mysql_tquery(g_SQL, "SELECT * FROM server_cars WHERE 1", "OnServerVehicleLoad");
	return 1;
}

stock static SaveVehicle(vehicleid)
{
	new
		saveQuery[ 512 ];

	mysql_format(g_SQL, saveQuery, 512, "UPDATE `server_cars` SET `model` = '%d', `type` = '%d', `usage` = '%d', `parkX` = '%f', `parkY` = '%f', `parkZ` = '%f', `angle` = '%f', `color1` = '%d', `color2` = '%d', `respawn` = '%d', `sirenon` = '%d', `faction` = '%d', `job` = '%d', `locked` = '%d',\
	 `int` = '%d', `viwo` = '%d', `health` = '%f', `numberplate` = '%e', `paintjob` = '%d', `impounded` = '%d', `text` = '%e', `travel` = '%d', `overheated` = '%d' WHERE `id` = '%d'",
		VehicleInfo[ vehicleid ][ vModel ],
		VehicleInfo[ vehicleid ][ vType ],
		VehicleInfo[ vehicleid ][ vUsage ],
		VehicleInfo[ vehicleid ][ vParkX ],
		VehicleInfo[ vehicleid ][ vParkY ],
		VehicleInfo[ vehicleid ][ vParkZ ],
		VehicleInfo[ vehicleid ][ vAngle ],
		VehicleInfo[ vehicleid ][ vColor1 ],
		VehicleInfo[ vehicleid ][ vColor2 ],
		VehicleInfo[ vehicleid ][ vRespawn ],
		VehicleInfo[ vehicleid ][ vSirenon ],
		VehicleInfo[ vehicleid ][ vFaction ],
		VehicleInfo[ vehicleid ][ vJob ],
		VehicleInfo[ vehicleid ][ vLocked ],
		VehicleInfo[ vehicleid ][ vInt ],
		VehicleInfo[ vehicleid ][ vViwo ],
		VehicleInfo[ vehicleid ][ vHealth ],
		VehicleInfo[ vehicleid ][ vNumberPlate ],
		VehicleInfo[ vehicleid ][ vPaintJob ],
		VehicleInfo[ vehicleid ][ vImpounded ],
		VehicleInfo[ vehicleid ][ vText ],
		VehicleInfo[ vehicleid ][ vTravel ],
		VehicleInfo[ vehicleid ][ vOverHeated],
		VehicleInfo[ vehicleid ][ vSQLID ]
	);
	mysql_tquery(g_SQL, saveQuery, "");
}

stock VehicleObjectCheck(vehicleid)
{
	if( SirenObject[ vehicleid ] != INVALID_OBJECT_ID ) {
		DestroyDynamicObject( SirenObject[ vehicleid ] );
		SirenObject[ vehicleid ] = INVALID_OBJECT_ID;
	}
	return 1;
}

Public:ResetVehicleEnumerator()
{
	for(new i=0; i<MAX_VEHICLES; i++)
		ResetVehicleInfo(i);
	return 1;
}

stock CreateNewVehicle(playerid, vehicleid)
{
	mysql_tquery(g_SQL, "BEGIN", "");
	new
		createQuery[ 1328 ];
	mysql_format(g_SQL, createQuery, sizeof(createQuery), "INSERT INTO server_cars (`model`, `type`, `usage`, `parkX`, `parkY`, `parkZ`, `angle`, `color1`, `color2`, `respawn`, `sirenon`, `faction`, `job`, `locked`, `int`, `viwo`, `health`, `numberplate`, `paintjob`, `impounded`, `text`, `travel`) VALUES ('%d','%d','%d','%f','%f','%f','%f','%d','%d','%d','%d','%d','%d','%d','%d','%d','%f','%e','%d','%d','%e','%d')",
		VehicleInfo[ vehicleid ][ vModel ],
		VehicleInfo[ vehicleid ][ vType ],
		VehicleInfo[ vehicleid ][ vUsage ],
		VehicleInfo[ vehicleid ][ vParkX ],
		VehicleInfo[ vehicleid ][ vParkY ],
		VehicleInfo[ vehicleid ][ vParkZ ],
		VehicleInfo[ vehicleid ][ vAngle ],
		VehicleInfo[ vehicleid ][ vColor1 ],
		VehicleInfo[ vehicleid ][ vColor2 ],
		VehicleInfo[ vehicleid ][ vRespawn ],
		VehicleInfo[ vehicleid ][ vSirenon ],
		VehicleInfo[ vehicleid ][ vFaction ],
		VehicleInfo[ vehicleid ][ vJob ],
		VehicleInfo[ vehicleid ][ vLocked ],
		VehicleInfo[ vehicleid ][ vInt ],
		VehicleInfo[ vehicleid ][ vViwo ],
		VehicleInfo[ vehicleid ][ vHealth ],
		VehicleInfo[ vehicleid ][ vNumberPlate ],
		VehicleInfo[ vehicleid ][ vPaintJob ],
		VehicleInfo[ vehicleid ][ vImpounded ],
		VehicleInfo[ vehicleid ][ vText ],
		VehicleInfo[ vehicleid ][ vTravel ]
	);
	mysql_tquery(g_SQL, createQuery, "OnServerVehicleCreate", "i", vehicleid);
	mysql_tquery(g_SQL, "COMMIT", "");

	printf("Script Report: Admin %s je kreirao vehicle ID %d",
		GetName(playerid, false),
		VehicleInfo[ vehicleid ][ vSQLID ]
	);
	return 1;
}

stock CheckVehicleObjects(vehicleid)
{
	if( SirenObject[ vehicleid ] != INVALID_OBJECT_ID ) {
		DestroyDynamicObject(SirenObject[ vehicleid ]);
		SirenObject[ vehicleid ] = INVALID_OBJECT_ID;
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
	##   	##  #######   #######  ##    ##  ######
*/

forward JackerUnfreeze(playerid);
public JackerUnfreeze(playerid)
{
	TogglePlayerControllable(playerid, true);
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if( !Iter_Contains(Vehicles, vehicleid) ) return 0;
	if(vehicleid == INVALID_VEHICLE_ID) return 0;
	if(killerid == INVALID_PLAYER_ID) return AC_SetVehicleToRespawn(vehicleid);
	if( !IsPlayerLogged(killerid) || !IsPlayerConnected(killerid) ) return AC_SetVehicleToRespawn(vehicleid, true);
	
	new
		string[8];
		
	switch(VehicleInfo[vehicleid][vUsage])
	{
		case VEHICLE_USAGE_PRIVATE: format(string, 8, "PRIVATE");
		case VEHICLE_USAGE_RENT: format(string, 8, "RENT");
	}
	
	printf("(%s) OnVehicleDeath debug: vehicleid: %d, killerid: %s[%d]", ReturnDate(), vehicleid, GetName(killerid, false), killerid);
	printf("(%s) vUsage: %s, GetPlayerVehicleID: %d, vJob = %d, vFaction = %d", ReturnDate(), string, GetPlayerVehicleID(killerid), VehicleInfo[vehicleid][vJob], VehicleInfo[vehicleid][vFaction]);
	
	if( VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE && VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_RENT ) 
		AC_SetVehicleToRespawn(vehicleid);
	
	if(vehicleid == GetPlayerVehicleID(killerid))
		RemovePlayerFromVehicle(killerid);
		
	if( VehicleInfo[ vehicleid ][ vFaction ] >= 1 || VehicleInfo[ vehicleid ][ vJob ] >= 1 || VehicleInfo[ vehicleid ][ vUsage ] != VEHICLE_USAGE_PRIVATE) 
	{
		AC_RepairVehicle(vehicleid);
	    VehicleInfo[ vehicleid ][ vDestroyed ] 	= false;
	    VehicleInfo[ vehicleid ][ vFuel ] 		= 100;
	    VehicleInfo[ vehicleid ][ vCanStart ] 	= 1;
	}
    return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!Iter_Contains(Vehicles, vehicleid))
			return 1;
			
		if(VehicleInfo[ vehicleid ][ vTireArmor ] == 1)
		{
			if(getTire(vehicleid, F_L_TIRE) != 0)
			{
				if(vTireHP[vehicleid][0] > 0)
				{
					setTire(vehicleid, F_L_TIRE, 0);
					vTireHP[vehicleid][0] -= 35;
				}
				else if(vTireHP[vehicleid][0] < 0) vTireHP[vehicleid][0] = 0;
			}
			if(getTire(vehicleid, B_L_TIRE) != 0)
			{
				if(vTireHP[vehicleid][1] > 0)
				{
					setTire(vehicleid, B_L_TIRE, 0);
					vTireHP[vehicleid][1] -= 35;
				}
				else if(vTireHP[vehicleid][1] < 0) vTireHP[vehicleid][1] = 0;
			}
			if(getTire(vehicleid, F_R_TIRE) != 0)
			{
				if(vTireHP[vehicleid][2] > 0)
				{
					setTire(vehicleid, F_R_TIRE, 0);
					vTireHP[vehicleid][2] -= 35;
				}
				else if(vTireHP[vehicleid][2] < 0) vTireHP[vehicleid][2] = 0;
			}
			if(getTire(vehicleid, B_R_TIRE) != 0)
			{
				if(vTireHP[vehicleid][3] > 0)
				{
					setTire(vehicleid, B_R_TIRE, 0);
					vTireHP[vehicleid][3] -= 35;
				}
				else if(vTireHP[vehicleid][3] < 0) vTireHP[vehicleid][3] = 0;
			}
		}
		if(VehicleInfo[ vehicleid ][ vBodyArmor ] == 1)
		{
			new Float:Vhealth;
			GetVehicleHealth(vehicleid, Vhealth);
			if(Vhealth > 600.00)
			{
				new engine, lights, alarm, doors, bonnet, boot, objective;
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				new vcpanels, vcdoors, vclights, vctires;
				GetVehicleDamageStatus(vehicleid, vcpanels, vcdoors, vclights, vctires);
				UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, vctires);
			}
		}
	}
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	if( VehicleInfo[ vehicleid ][ vInt ] != 0 ) 
		LinkVehicleToInterior(vehicleid, VehicleInfo[ vehicleid ][ vInt ]);
	else 
		LinkVehicleToInterior(vehicleid, 0);
	
	if( VehicleInfo[ vehicleid ][ vViwo ] != 0 ) 
		SetVehicleVirtualWorld(vehicleid, VehicleInfo[ vehicleid ][ vViwo ]);
	else 
		SetVehicleVirtualWorld(vehicleid, 0);
	
	if(VehicleInfo[ vehicleid ][ vParkX ] != 0.0)
		SetVehiclePos(vehicleid, VehicleInfo[ vehicleid ][ vParkX ], VehicleInfo[ vehicleid ][ vParkY ], VehicleInfo[ vehicleid ][ vParkZ ]);
	
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
	if( GetPlayerVehicleID(playerid) && VehicleInfo[ GetPlayerVehicleID(playerid) ][ vJob ] != 0 ) {
		AC_SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	}
    if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePreviousInfo(vehicleid);
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	GetVehiclePreviousInfo(vehicleid);
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT ) {
		new
			vehicleid = GetPlayerVehicleID(playerid);

		if( VehicleInfo[ vehicleid ][ vType ] == VEHICLE_TYPE_BOAT && !PlayerInfo[ playerid ][ pBoatLic ] ) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate upravljati brodom pa ste izasli!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if( ( VehicleInfo[ vehicleid ][ vType ] == VEHICLE_TYPE_PLANE || IsAHelio( GetVehicleModel( vehicleid ) ) ) && !PlayerInfo[ playerid ][ pFlyLic ] ) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate upravljati avionom pa ste izasli!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if( ( VehicleInfo[ vehicleid ][ vType ] == VEHICLE_TYPE_CAR || VehicleInfo[ vehicleid ][ vType ] == VEHICLE_TYPE_MOTOR ) && !PlayerInfo[ playerid ][ pCarLic ] && !IsABike(vehicleid) ) 
			SendClientMessage( playerid, COLOR_RED, "[ ! ] Nemate vozacku dozvolu pazite se policije!");

		if( VehicleInfo[ vehicleid ][ vJob ] != 0 ) {
			if( VehicleInfo[ vehicleid ][ vJob ] != PlayerInfo[playerid ][ pJob ] ) {
				SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate voziti ovo vozilo!");
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
		}
		if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_NEWBIES && PlayerInfo[ playerid ][ pLevel ] > 3 ) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova vozila su predvidjena za nove igrace (max level 3)!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if( VehicleInfo[ vehicleid ][ vDestroyed ] )
			SendClientMessage(GetVehicleDriver( vehicleid ), COLOR_RED, "Vase je vozilo unisteno, zovite mehanicara ili pronadjite obliznji Pay 'n' Spray!");

		if( vehicleid == INVALID_VEHICLE_ID || vehicleid == 0 ) return 1;
		if( PlayerInfo[ playerid ][ pMember ] != VehicleInfo[ vehicleid ][ vFaction ] && VehicleInfo[ vehicleid ][ vFaction ] > 0  ) {
			RemovePlayerFromVehicle(playerid);
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik organizacije da mozete voziti organizacijska vozila!");
			return 1;
		}
		/*switch( VehicleInfo[ vehicleid ][ vFaction ] ) {
			case 1: // LSPD
				PlayAudioStreamForPlayer( playerid, "http://www.broadcastify.com/scripts/playlists/1/17145/-5616135480.m3u");
			case 2: // LSFD
				PlayAudioStreamForPlayer( playerid, "http://www.broadcastify.com/scripts/playlists/1/2846/-5616135992.m3u");
		}*/
		LastVehicleDriver[ vehicleid ] = playerid;
	}
	if( oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT ) 
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePreviousInfo(vehicleid);
		return 1;
	}
	if( ( newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER ) && Bit1_Get( gr_JackedPlayer, playerid ) ) {
	
		PutPlayerInVehicle( playerid, Bit16_Get( gr_JackedVehicle, playerid ), 0 );
		Bit1_Set( gr_JackedPlayer, 		playerid, true );
		Bit16_Set( gr_JackedVehicle, 	playerid, 999 );
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		if( VehicleInfo[ vehicleid ][ vLocked ] )
		{
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx( vehicleid, engine, lights, alarm, doors, bonnet, boot, objective );
			if( doors )
			{
				new
					Float:slx,Float:sly,Float:slz;
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("JackerUnfreeze", 	3000, 	false, "i", playerid);
				GetPlayerPos(playerid, 			slx, 	sly, slz);
				SetPlayerPos(playerid, 			slx, 	sly, slz+5);
				PlayerPlaySound(playerid, 		1130, 	slx, sly, slz+5);
			}
			return 1;
		}
		foreach (new i : Player)
		{
			if(playerid != i && GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
				new Float:slx,Float:sly,Float:slz;
				TogglePlayerControllable(playerid, 0);
				SendClientMessage(playerid,COLOR_RED,"(( Freezean si 3 sekunde zbog pokusaja ninja jackanja. ))");

				SetTimerEx("JackerUnfreeze", 	3000, 	false, "i", playerid);
				GetPlayerPos(playerid, 			slx, 	sly, slz);
				SetPlayerPos(playerid, 			slx, 	sly, slz+5);
				PlayerPlaySound(playerid, 		1130, 	slx, sly, slz+5);

				Bit1_Set( gr_JackedPlayer, 		i, true );
				Bit16_Set( gr_JackedVehicle, 	i, vehicleid );
				break;
			}
	 	}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( PRESSED(KEY_YES ) && IsPlayerInAnyVehicle( playerid ) )
	{
		new engine,lights,alarm,doors,bonnet,boot,objective,
			vehicle = GetPlayerVehicleID(playerid),
			modelid = GetVehicleModel(vehicle);
		if( GetPlayerState(playerid) != PLAYER_STATE_DRIVER ) return 1;
		if( IsABike(modelid) || IsAPlane(modelid) || IsABoat(modelid) ) return 1;

		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);

		if( !VehicleInfo[ vehicle ][ vLights ] ) {
			VehicleInfo[ vehicle ][ vLights ] = 1;
			SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		} else {
			VehicleInfo[ vehicle ][ vLights ] = 0;
			SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		}
	}
	return 1;
}