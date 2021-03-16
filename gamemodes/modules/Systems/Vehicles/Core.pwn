#include <YSI_Coding\y_hooks>

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
	Iterator:ServerVehicle[MAX_VEHICLE_TYPES]<MAX_VEHICLES>;

static 
	GlobalVehicleStamp 	= 0,	// VehicleGlobalTimer
	VehicleTimer		= 0;

// rBits
static
	Bit1:	gr_JackedPlayer		<MAX_PLAYERS>,
	Bit16:	gr_JackedVehicle	<MAX_PLAYERS>;

Vehicle_Add(type, vehicleid)
{
	return Iter_Add(ServerVehicle[type], vehicleid);
}

Vehicle_Random(type)
{
	return Iter_Random(ServerVehicle[type]);
}

bool: Vehicle_Exists(type, vehicleid)
{
	return Iter_Contains(ServerVehicle[type], vehicleid);
}

task VehicleGlobalTask[1000]()
{
	if(gettimestamp() >= VehicleTimer && gettimestamp() >= GlobalVehicleStamp)
	{
		VehicleTimer = gettimestamp() + 100;
		GlobalVehicleStamp = gettimestamp() + 45;
		foreach(new vehicleid : Vehicle)
		{
			if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_PRIVATE)
			{
				if(VehicleInfo[vehicleid][vEngineRunning]) CheckVehicleEngine(vehicleid);
				if(!IsVehicleOccupied(vehicleid))
				CheckEngineHeat(vehicleid);
				
				if(VehicleInfo[vehicleid][vBodyArmor] == 1)
				{
					new Float:Vhealth;
					GetVehicleHealth(vehicleid, Vhealth);
					if(Vhealth > 600.00)
					{
						static 
							vcpanels, 
							vcdoors, 
							vclights, 
							vctires;
						
						GetVehicleDamageStatus(vehicleid, vcpanels, vcdoors, vclights, vctires); // pripazi
						UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, vctires);
					}
				}
			}

			if(IsAHelio(GetVehicleModel(vehicleid)) || IsAPlane(GetVehicleModel(vehicleid)) || IsABike(GetVehicleModel(vehicleid)) ||
				VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_NORMAL || VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_JOB ||
				VehicleInfo[vehicleid][vUsage] ==  VEHICLE_USAGE_LICENSE) continue;
				
			if(VehicleInfo[vehicleid][vEngineRunning])
			{
				new
					Float:health;
				GetVehicleHealth(vehicleid, health);
				if(health <= 390.0) {
					if(!VehicleInfo[vehicleid][vDestroyed]) {
						new
							playerid = GetVehicleDriver(vehicleid);
							
						SendClientMessage(playerid, COLOR_RED, "Vase je vozilo unisteno, zovite mehanicara!");
						AC_SetVehicleHealth(vehicleid, 390.0);
						VehicleInfo[vehicleid][vDestroyed] = true;

						new
							engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
						VehicleInfo[vehicleid][vEngineRunning] = false;
					}
				}

				if(VehicleInfo[vehicleid][vFuel] > 0)
					VehicleInfo[vehicleid][vFuel]--;
				if(VehicleInfo[vehicleid][vFuel] == 0) 
				{
					GameTextForPlayer(GetVehicleDriver(vehicleid), "~r~Ostali ste bez goriva...", 1000, 1);
					new
						engine, lights, alarm, doors, bonnet, boot, objective;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);

					VehicleInfo[vehicleid][vEngineRunning] = false;
				}
			}
		}
		return 1;
	}
	if(gettimestamp() >= VehicleTimer)
	{
		VehicleTimer = gettimestamp() + 60;
		foreach(new vehicleid : ServerVehicle[VEHICLE_USAGE_PRIVATE])
		{
			if(VehicleInfo[vehicleid][vEngineRunning]) 
				CheckVehicleEngine(vehicleid);
			if(!IsVehicleOccupied(vehicleid))
				CheckEngineHeat(vehicleid);
		}
		return 1;
	}
	if(gettimestamp() >= GlobalVehicleStamp)
	{
		GlobalVehicleStamp = gettimestamp() + 90;
		foreach(new vehicleid : Vehicle)
		{
			if(IsAHelio(GetVehicleModel(vehicleid)) || IsAPlane(GetVehicleModel(vehicleid)) || IsABike(GetVehicleModel(vehicleid)) ||
				VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_NORMAL || VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_JOB ||
				VehicleInfo[vehicleid][vUsage] ==  VEHICLE_USAGE_LICENSE) continue;
			if(VehicleInfo[vehicleid][vEngineRunning])
			{
				new
					Float:health;
				GetVehicleHealth(vehicleid, health);
				if(health <= 390.0) 
				{
					if(!VehicleInfo[vehicleid][vDestroyed]) 
					{
						SendClientMessage(GetVehicleDriver(vehicleid), COLOR_RED, "Vase je vozilo unisteno, zovite mehanicara!");
						AC_SetVehicleHealth(vehicleid, 390.0);
						VehicleInfo[vehicleid][vDestroyed] = true;

						new
							engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
						VehicleInfo[vehicleid][vEngineRunning] = false;
					}
				}

				if(VehicleInfo[vehicleid][vFuel] > 0)
					VehicleInfo[vehicleid][vFuel]--;
				if(VehicleInfo[vehicleid][vFuel] == 0) {
					GameTextForPlayer(GetVehicleDriver(vehicleid), "~r~Ostali ste bez goriva...", 1000, 1);
					new
						engine, lights, alarm, doors, bonnet, boot, objective;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);

					VehicleInfo[vehicleid][vEngineRunning] = false;
				}
			}
		}
		return 1;
	}
	return 1;
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

CountVehicleModels()
{
	new 
		Iterator: VehicleTypes<MAX_VEHICLES>,
		carid,
		model;
	if(Iter_Count(ServerVehicle[VEHICLE_USAGE_PRIVATE]) == 0)
		return 0;
		
	foreach(new vehicleid: ServerVehicle[VEHICLE_USAGE_PRIVATE])
	{
		model = GetVehicleModel(vehicleid);
		carid = GetVehicleByModel(model);
		if(carid == -1) continue;
		if(IsABike(model) || IsABoat(model) || IsAMotorBike(model) || IsAPlane(model) || IsAHelio(model)) continue;
		if(!IsVehicleJackable(carid)) continue;
		if(Iter_Contains(VehicleTypes, model)) continue;
		Iter_Add(VehicleTypes, model);
	}
	return Iter_Count(VehicleTypes);
}

GetPlayerPrivateVehicle(playerid)
{
	new
		found = -1;
	foreach(new vehicleid : ServerVehicle[VEHICLE_USAGE_PRIVATE])
	{
		if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_PRIVATE && PlayerInfo[playerid][pSQLID] == VehicleInfo[vehicleid][vOwnerID])
		{
			found = vehicleid;
			break;
		}
	}
	return found;
}

RefillVehicles()
{
	foreach(new vehicleid : Vehicle)
		VehicleInfo[vehicleid][vFuel] = 100;
	
	return 1;
}

RespawnVehicles()
{
	foreach(new vehicleid : Vehicle)
	{
		if(!IsVehicleOccupied(vehicleid))
			SetVehicleToRespawn(vehicleid);
	}
	return 1;
}

RespawnFactionVehicles(factionid)
{
	foreach(new x : ServerVehicle[VEHICLE_USAGE_FACTION])
	{
		if(VehicleInfo[x][vFaction] == factionid)
		{
			if(!IsVehicleOccupied(x))
				SetVehicleToRespawn(x);
		}
	}
	return 1;
}

FindImpoundableVehicle()
{
	new
		vehicleid = INVALID_VEHICLE_ID;
	foreach(new v : ServerVehicle[VEHICLE_USAGE_PRIVATE])
	{
		if(VehicleInfo[v][vImpounded])
			continue;

		if(!IsVehicleImpoundable(v))
			continue;
		
		vehicleid = v;
		break;
	}
	return vehicleid;
}

hook function ResetVehicleInfo(vehicleid)
{	
	ResetPrivateVehicleInfo(vehicleid);

	// Ints
	VehicleInfo[vehicleid][vSQLID]					= -1;
	VehicleInfo[vehicleid][vModel]                  = 400;
	VehicleInfo[vehicleid][vOwnerID]                = 0;
	VehicleInfo[vehicleid][vColor1]                 = 0;
	VehicleInfo[vehicleid][vColor2]                 = 0;
	VehicleInfo[vehicleid][vEngineType]             = 0;
	VehicleInfo[vehicleid][vEngineLife]             = 0;
	VehicleInfo[vehicleid][vEngineScrewed]          = 0;
	VehicleInfo[vehicleid][vEngineRunning]          = 0;
	VehicleInfo[vehicleid][vCanStart]               = 0;
	VehicleInfo[vehicleid][vParts]                  = 0;
	VehicleInfo[vehicleid][vTimesDestroy]			= 0;
	VehicleInfo[vehicleid][vOverHeated]             = 0;
	VehicleInfo[vehicleid][vBatteryType]            = 0;
	VehicleInfo[vehicleid][vFuel]                   = 0;
	VehicleInfo[vehicleid][vInsurance]              = 0;
	VehicleInfo[vehicleid][vPanels]                 = 0;
	VehicleInfo[vehicleid][vDoors]                  = 0;
	VehicleInfo[vehicleid][vTires]                  = 0;
	VehicleInfo[vehicleid][vLights]                 = 0;
	VehicleInfo[vehicleid][vBonnets]                = 0;
	VehicleInfo[vehicleid][vTrunk]                  = 0;
	
	VehicleInfo[vehicleid][vLock]                   = 0;
	VehicleInfo[vehicleid][vLocked]                 = 0;
	VehicleInfo[vehicleid][vAlarm]                  = 0;
	VehicleInfo[vehicleid][vImmob]                  = 0;
	VehicleInfo[vehicleid][vAudio]                  = 0;
	VehicleInfo[vehicleid][vBodyArmor]              = 0;
	VehicleInfo[vehicleid][vTireArmor]              = 0;

	vTireHP[vehicleid][0] 							= 100;
	vTireHP[vehicleid][1] 							= 100;
	vTireHP[vehicleid][2] 							= 100;
	vTireHP[vehicleid][3] 							= 100;

	VehicleInfo[vehicleid][vDestroys]               = 0;
	VehicleInfo[vehicleid][vUsage]                  = 0;
	VehicleInfo[vehicleid][vType]                   = 0;
	VehicleInfo[vehicleid][vFaction]                = 0;
	VehicleInfo[vehicleid][vJob]                    = 0;
	VehicleInfo[vehicleid][vInt]                    = 0;
	VehicleInfo[vehicleid][vViwo]                   = 0;
	VehicleInfo[vehicleid][vRespawn]                = 0;
	VehicleInfo[vehicleid][vGPS] 					= true;
	VehicleInfo[vehicleid][vTuned] 					= false;
	VehicleInfo[vehicleid][vPaintJob]               = 255;
	VehicleInfo[vehicleid][vSpoiler]                = -1;
	VehicleInfo[vehicleid][vHood]                   = -1;
	VehicleInfo[vehicleid][vRoof]                   = -1;
	VehicleInfo[vehicleid][vSkirt]                  = -1;
	VehicleInfo[vehicleid][vLamps]                  = -1;
	VehicleInfo[vehicleid][vNitro]                  = -1;
	VehicleInfo[vehicleid][vSirenon]                = 0;
	VehicleInfo[vehicleid][vExhaust]                = -1;
	VehicleInfo[vehicleid][vWheels]                 = -1;
	VehicleInfo[vehicleid][vStereo]                 = -1;
	VehicleInfo[vehicleid][vHydraulics]             = -1;
	VehicleInfo[vehicleid][vFrontBumper]            = -1;
	VehicleInfo[vehicleid][vRearBumper]             = -1;
	VehicleInfo[vehicleid][vRightVent]              = -1;
	VehicleInfo[vehicleid][vLeftVent]               = -1;
	VehicleInfo[vehicleid][vImpounded]              = 0;
	VehicleInfo[vehicleid][vFactionTextOn]          = 0;
	
	VehicleInfo[vehicleid][vTicketSQLID][0]		= 0;
	VehicleInfo[vehicleid][vTicketSQLID][1]		= 0;
	VehicleInfo[vehicleid][vTicketSQLID][2]		= 0;
	VehicleInfo[vehicleid][vTicketSQLID][3]		= 0;
	VehicleInfo[vehicleid][vTicketSQLID][4]		= 0;
	VehicleInfo[vehicleid][vTickets][0]			= 0;
	VehicleInfo[vehicleid][vTickets][1]			= 0;
	VehicleInfo[vehicleid][vTickets][2]			= 0;
	VehicleInfo[vehicleid][vTickets][3]			= 0;
	VehicleInfo[vehicleid][vTickets][4]			= 0;
	VehicleInfo[vehicleid][vTicketShown][0]		= true;
	VehicleInfo[vehicleid][vTicketShown][1]		= true;
	VehicleInfo[vehicleid][vTicketShown][2]		= true;
	VehicleInfo[vehicleid][vTicketShown][3]		= true;
	VehicleInfo[vehicleid][vTicketShown][4]		= true;
		
	// Strings
	VehicleInfo[vehicleid][vOwner][0]				= EOS;
	VehicleInfo[vehicleid][vNumberPlate][0]		= EOS;
	VehicleInfo[vehicleid][vText][0]				= EOS;
	VehicleInfo[vehicleid][vVehicleAdText][0]		= EOS;

	// Floats
	VehicleInfo[vehicleid][vParkX]			= 0.0;
	VehicleInfo[vehicleid][vParkY]          = 0.0;
	VehicleInfo[vehicleid][vParkZ]          = 0.0;
	VehicleInfo[vehicleid][vAngle]          = 0.0;
	VehicleInfo[vehicleid][vHeat]           = 0.0;
	VehicleInfo[vehicleid][vBatteryLife]    = 0.0;
	VehicleInfo[vehicleid][vTravel]         = 0.0;
	VehicleInfo[vehicleid][vDoorHealth]		= 0.0;
	VehicleInfo[vehicleid][vTrunkHealth] 	= 0.0;
	VehicleInfo[vehicleid][vHealth]			= 1000.0;

	// Bools
	VehicleInfo[vehicleid][vDestroyed] 		= false;

	// 3d Texts
	if(VehicleInfo[vehicleid][vFactionText] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel( VehicleInfo[vehicleid][vFactionText]);
		VehicleInfo[vehicleid][vFactionText] = Text3D:INVALID_3DTEXT_ID;
	}
	
	Bit1_Set( gr_VehicleAttachedBomb, vehicleid, false);

	return continue(vehicleid);
}

stock AC_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay = -1, sirenon = 0)
{
	new
		id = CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, sirenon);
	ResetVehicleInfo(id);
	VehicleInfo[id][vModel] = vehicletype;
	VehicleInfo[id][vRespawn] = respawn_delay;
	VehicleInfo[id][vViwo] = GetVehicleVirtualWorld(id);
	return id;
}

hook AC_DestroyVehicle(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) 		
		return 0;
	if(!IsValidVehicle(vehicleid))	
		return 0;

	VehicleInfo[vehicleid][vEngineRunning] = 0;
	DestroyVehicle(vehicleid);
	if(Iter_Contains(ServerVehicle[VehicleInfo[vehicleid][vUsage]], vehicleid))
		Iter_Remove(ServerVehicle[VehicleInfo[vehicleid][vUsage]], vehicleid);
	
	ResetVehicleInfo(vehicleid);
	return continue(vehicleid);
}

stock SetRespawnedVehicleParams(vehicleid)
{
	if(VehicleInfo[vehicleid][vNumberPlate][0] == '0')
		SetVehicleNumberPlate(vehicleid, " ");
	else
		SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][vNumberPlate]);
	new
		engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);

	if(IsABike(VehicleInfo[vehicleid][vModel]) || IsAPlane(VehicleInfo[vehicleid][vModel])) 
	{
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,VEHICLE_PARAMS_OFF,alarm,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
		VehicleInfo[vehicleid][vEngineRunning] = 1;
	} 
	else 
	{
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

stock AC_SetVehicleToRespawn(vehicleid)
{
	new
		Float:vhealth;

	if(vehicleid == INVALID_VEHICLE_ID)	return 0;
	if(!Iter_Contains(ServerVehicle[VehicleInfo[vehicleid][vUsage]], vehicleid)) return 0;
	RemoveAllVehicleTuning(vehicleid);
	DestroyVehicleSiren(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	SetVehicleToRespawn(vehicleid);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][vInt]);
	SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][vViwo]);
	if(VehicleInfo[vehicleid][vImpounded] == 1)
	{
		SetVehiclePos(vehicleid, VehicleInfo[vehicleid][vParkX], VehicleInfo[vehicleid][vParkY], VehicleInfo[vehicleid][vParkZ]);
		SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][vAngle]);
	}
	SetRespawnedVehicleParams(vehicleid);
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
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
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
	if(DoesVehicleHavePlayers(vehicleid))
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

static LoadServerVehicles()
{
	inline OnServerVehicleLoad()
	{
		if(!cache_num_rows()) 
			return printf("MySQL Report: No cars exist to load.");
		
		new
			carLoad[E_VEHICLE_DATA],
			vCarID,
			tmp[9],rmp[15];

		for(new b = 0; b < cache_num_rows(); b++) 
		{
			cache_get_value_name_int(b, 	"model"		, carLoad[vModel]);
			cache_get_value_name_float(b, 	"parkX"		, carLoad[vParkX]);
			cache_get_value_name_float(b, 	"parkY"		, carLoad[vParkY]);
			cache_get_value_name_float(b, 	"parkZ"		, carLoad[vParkZ]);
			cache_get_value_name_float(b, 	"angle"		, carLoad[vAngle]);
			cache_get_value_name_int(b, 	"color1"	, carLoad[vColor1]);
			cache_get_value_name_int(b, 	"color2"	, carLoad[vColor2]);
			cache_get_value_name_int(b, 	"respawn"	, carLoad[vRespawn]);
			cache_get_value_name_int(b, 	"sirenon"	, carLoad[vSirenon]);

			vCarID = AC_CreateVehicle( carLoad[vModel], carLoad[vParkX], carLoad[vParkY], carLoad[vParkZ], carLoad[vAngle], carLoad[vColor1], carLoad[vColor2], carLoad[vRespawn], carLoad[vSirenon]);

			VehicleInfo[vCarID][vModel] 			= carLoad[vModel];
			VehicleInfo[vCarID][vParkX] 			= carLoad[vParkX];
			VehicleInfo[vCarID][vParkY] 			= carLoad[vParkY];
			VehicleInfo[vCarID][vParkZ] 			= carLoad[vParkZ];
			VehicleInfo[vCarID][vAngle] 			= carLoad[vAngle];
			VehicleInfo[vCarID][vColor1] 			= carLoad[vColor1];
			VehicleInfo[vCarID][vColor2] 			= carLoad[vColor2];
			VehicleInfo[vCarID][vRespawn] 			= carLoad[vRespawn];
			VehicleInfo[vCarID][vSirenon] 			= carLoad[vSirenon];

			cache_get_value_name_int(b, 	"id"		, VehicleInfo[vCarID][vSQLID]);
			cache_get_value_name_int(b, 	"type"		, VehicleInfo[vCarID][vType]);
			cache_get_value_name_int(b, 	"usage"		, VehicleInfo[vCarID][vUsage]);
			cache_get_value_name_int(b, 	"faction"	, VehicleInfo[vCarID][vFaction]);
			cache_get_value_name_int(b, 	"job"		, VehicleInfo[vCarID][vJob]);
			cache_get_value_name_int(b, 	"locked"	, VehicleInfo[vCarID][vLocked]);
			cache_get_value_name_int(b, 	"int"		, VehicleInfo[vCarID][vInt]);
			cache_get_value_name_int(b, 	"viwo"		, VehicleInfo[vCarID][vViwo]);
			cache_get_value_name_float(b, 	"health"	, VehicleInfo[vCarID][vHealth]);
			cache_get_value_name_int(b, 	"paintjob"	, VehicleInfo[vCarID][vPaintJob]);

			VehicleInfo[vCarID][vBodyArmor] 		= carLoad[vBodyArmor];
			VehicleInfo[vCarID][vTireArmor] 		= carLoad[vTireArmor];

			cache_get_value_name(b, "numberplate", tmp, sizeof(tmp));
			format( VehicleInfo[vCarID][vNumberPlate], 8, tmp);

			cache_get_value_name_float(b, 	"travel"		, VehicleInfo[vCarID][vTravel]);
			cache_get_value_name_int(b, 	"overheated"	, VehicleInfo[vCarID][vOverHeated]);
			VehicleInfo[vCarID][vFuel] 				= 100;
			VehicleInfo[vCarID][vTrunk] 			= 1;
			VehicleInfo[vCarID][vCanStart] 			= 1;
			VehicleInfo[vCarID][vParts] 			= 0;
			VehicleInfo[vCarID][vTimesDestroy] 		= 0;
			SetVehicleHealth( vCarID, VehicleInfo[vCarID][vHealth]);

			new 
				model = GetVehicleModel(vCarID);
			cache_get_value_name(b, "text", rmp);
			format( VehicleInfo[vCarID][vText], 13, rmp);
			if(VehicleInfo[vCarID][vFaction] > 0 || VehicleInfo[vCarID][vJob] > 0) 
				VehicleInfo[vCarID][vAudio] = 1;
			
			switch( VehicleInfo[vCarID][vFaction]) 
			{
				case 1: 
				{
					if(!(model == 497 || model == 469 || model == 430 || model == 431)) 
					{
						if(isnull(VehicleInfo[vCarID][vText]))
							format(VehicleInfo[vCarID][vText], 13, "LSPD");
						if(VehicleInfo[vCarID][vText][0] != '0') {
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
				}
				case 3: 
				{
					if(!(model == 497 || model == 469 || model == 430 || model == 431)) 
					{
						if(isnull(VehicleInfo[vCarID][vText]))
							format(VehicleInfo[vCarID][vText], 13, "LSSD");
						if(VehicleInfo[vCarID][vText][0] != '0') 
						{
							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
					}
				}
				case 4: 
				{
					if(isnull(VehicleInfo[vCarID][vText]))
						format(VehicleInfo[vCarID][vText], 13, "GOV");
					if(VehicleInfo[vCarID][vText][0] != '0') 
					{
						VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
						VehicleInfo[vCarID][vFactionTextOn] = 1;
					}
					VehicleInfo[vCarID][vBodyArmor] = 1;
					AC_SetVehicleHealth(vCarID, 1600.0);
				}
				case 2: {
					switch(model) {
						case 407: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.5361, -3.8234, -0.7254, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 416: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.5434, -3.6819, -0.4500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 424: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.0413, -1.6196, 0.2500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 544: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.0442, -3.7343, -0.2000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 490: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6381, -3.2258, -0.3600, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 596: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6969, -2.8092, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 599: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6504, -2.7506, -0.3600, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 552: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.9242, -3.0798, 0.0234, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 427: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.3975, -3.6268, 0.0234, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
							VehicleInfo[vCarID][vFactionTextOn] = 1;
						}
						case 525: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.6073, -3.0629, -0.1200, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 437: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.4615, -5.4731, -0.1200, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 563: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, 0.7704, -4.0637, -0.3000, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
						case 497: {
							if(isnull(VehicleInfo[vCarID][vText]))
								format(VehicleInfo[vCarID][vText], 13, "LSFD");

							if(VehicleInfo[vCarID][vText][0] != '0') {
								VehicleInfo[vCarID][vFactionText] = CreateDynamic3DTextLabel(VehicleInfo[vCarID][vText], 0xD2D2D2FF, -0.1615, -2.0197, -0.2500, 10.0, INVALID_PLAYER_ID, vCarID, 0, -1, -1, -1, 15.0);
								VehicleInfo[vCarID][vFactionTextOn] = 1;
							}
						}
					}
				}
			}
			if(VehicleInfo[vCarID][vNumberPlate][0] == '0')
					SetVehicleNumberPlate(vCarID, "");
				else
					SetVehicleNumberPlate(vCarID, VehicleInfo[vCarID][vNumberPlate]);

			new
				engine,lights,alarm,doors, edoors, bonnet,boot,objective;
			if(VehicleInfo[vCarID][vLocked])
				doors = 1;
			else doors = 0;
			GetVehicleParamsEx(vCarID,engine,lights,alarm,edoors,bonnet,boot,objective);

			if(IsABike(model) || IsAPlane(model) || IsABike(model)) {
				SetVehicleParamsEx(vCarID,VEHICLE_PARAMS_ON,VEHICLE_PARAMS_OFF,alarm,doors,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
				VehicleInfo[vCarID][vEngineRunning] = 1;
			} else {
				SetVehicleParamsEx(vCarID,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,alarm,doors,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
				VehicleInfo[vCarID][vEngineRunning] = 0;
			}
			LinkVehicleToInterior(vCarID, 	VehicleInfo[vCarID][vInt]);
			SetVehicleVirtualWorld(vCarID, 	VehicleInfo[vCarID][vViwo]);

			Iter_Add(ServerVehicle[VehicleInfo[vCarID][vUsage]], vCarID);
		}
		printf("MySQL Report: Vehicles Loaded. [%d/%d]", cache_num_rows(), MAX_VEHICLES);
		return 1;
	}
	MySQL_TQueryInline(SQL_Handle(),
		using inline OnServerVehicleLoad,
		"SELECT * FROM server_cars WHERE 1", 
		""
	);
	return 1;
}

static SaveVehicle(vehicleid)
{
	mysql_fquery(SQL_Handle(),
		"UPDATE server_cars SET model = '%d', type = '%d', usage = '%d', parkX = '%f', parkY = '%f', parkZ = '%f',\n\
			angle = '%f', color1 = '%d', color2 = '%d', respawn = '%d', sirenon = '%d', faction = '%d', job = '%d', locked = '%d',\n\
	 		int = '%d', viwo = '%d', health = '%f', numberplate = '%e', paintjob = '%d', impounded = '%d', text = '%e',\n\
		  	travel = '%d', overheated = '%d' WHERE id = '%d'",
		VehicleInfo[vehicleid][vModel],
		VehicleInfo[vehicleid][vType],
		VehicleInfo[vehicleid][vUsage],
		VehicleInfo[vehicleid][vParkX],
		VehicleInfo[vehicleid][vParkY],
		VehicleInfo[vehicleid][vParkZ],
		VehicleInfo[vehicleid][vAngle],
		VehicleInfo[vehicleid][vColor1],
		VehicleInfo[vehicleid][vColor2],
		VehicleInfo[vehicleid][vRespawn],
		VehicleInfo[vehicleid][vSirenon],
		VehicleInfo[vehicleid][vFaction],
		VehicleInfo[vehicleid][vJob],
		VehicleInfo[vehicleid][vLocked],
		VehicleInfo[vehicleid][vInt],
		VehicleInfo[vehicleid][vViwo],
		VehicleInfo[vehicleid][vHealth],
		VehicleInfo[vehicleid][vNumberPlate],
		VehicleInfo[vehicleid][vPaintJob],
		VehicleInfo[vehicleid][vImpounded],
		VehicleInfo[vehicleid][vText],
		VehicleInfo[vehicleid][vTravel],
		VehicleInfo[vehicleid][vOverHeated],
		VehicleInfo[vehicleid][vSQLID]
	);
}

static ResetVehicleEnumerator()
{
	for(new i=0; i<MAX_VEHICLES; i++)
		ResetVehicleInfo(i);
	for(new vtype = 0; vtype < MAX_VEHICLE_TYPES; vtype++)
		Iter_Clear(ServerVehicle[vtype]);
	return 1;
}

static CreateNewVehicle(playerid, vehicleid)
{	
	inline OnServerVehicleCreate()
	{
		VehicleInfo[vehicleid][vSQLID] = cache_insert_id();
		SaveVehicle(vehicleid);
	}
	MySQL_TQueryInline(SQL_Handle(),
		using inline OnServerVehicleCreate, 
		va_fquery(SQL_Handle(), 
			"INSERT INTO \n\
				server_cars \n\
			(model, type, usage, parkX, parkY, parkZ, angle, color1, color2, respawn,\n\
				sirenon, faction, job, locked, int, viwo, health, numberplate, paintjob, impounded, text, travel) \n\
			VALUES \n\
				('%d','%d','%d','%f','%f','%f','%f','%d','%d','%d','%d','%d','%d','%d','%d','%d','%f','%e','%d','%d','%e','%d')",
			VehicleInfo[vehicleid][vModel],
			VehicleInfo[vehicleid][vType],
			VehicleInfo[vehicleid][vUsage],
			VehicleInfo[vehicleid][vParkX],
			VehicleInfo[vehicleid][vParkY],
			VehicleInfo[vehicleid][vParkZ],
			VehicleInfo[vehicleid][vAngle],
			VehicleInfo[vehicleid][vColor1],
			VehicleInfo[vehicleid][vColor2],
			VehicleInfo[vehicleid][vRespawn],
			VehicleInfo[vehicleid][vSirenon],
			VehicleInfo[vehicleid][vFaction],
			VehicleInfo[vehicleid][vJob],
			VehicleInfo[vehicleid][vLocked],
			VehicleInfo[vehicleid][vInt],
			VehicleInfo[vehicleid][vViwo],
			VehicleInfo[vehicleid][vHealth],
			VehicleInfo[vehicleid][vNumberPlate],
			VehicleInfo[vehicleid][vPaintJob],
			VehicleInfo[vehicleid][vImpounded],
			VehicleInfo[vehicleid][vText],
			VehicleInfo[vehicleid][vTravel]
		),
		"i", 
		vehicleid
	);

	printf("Script Report: Game Admin %s created %s[Vehicle ID: %d]",
		GetName(playerid, false),
		ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
		VehicleInfo[vehicleid][vSQLID]
	);
	return 1;
}

timer JackerUnfreeze[3000](playerid)
{
	TogglePlayerControllable(playerid, true);
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

hook OnGameModeInit()
{
	ResetVehicleEnumerator();
	return 1;
}

hook function LoadServerData()
{
	LoadServerVehicles();
	return continue();

}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 0;
	if(!Iter_Contains(ServerVehicle[VehicleInfo[vehicleid][vUsage]], vehicleid)) return 0;
	if(killerid == INVALID_PLAYER_ID) return SetVehicleToRespawn(vehicleid);
	if(!IsPlayerLogged(killerid) || !IsPlayerConnected(killerid)) 
		return SetVehicleToRespawn(vehicleid);
	
	new
		string[8];
		
	switch(VehicleInfo[vehicleid][vUsage])
	{
		case VEHICLE_USAGE_PRIVATE: format(string, 8, "PRIVATE");
		case VEHICLE_USAGE_RENT: format(string, 8, "RENT");
	}
	
	printf("(%s) OnVehicleDeath debug: vehicleid: %d, killerid: %s[%d]", ReturnDate(), vehicleid, GetName(killerid, false), killerid);
	printf("(%s) vUsage: %s, GetPlayerVehicleID: %d, vJob = %d, vFaction = %d", ReturnDate(), string, GetPlayerVehicleID(killerid), VehicleInfo[vehicleid][vJob], VehicleInfo[vehicleid][vFaction]);
	
	if(VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE && VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_RENT) 
		SetVehicleToRespawn(vehicleid);
	
	if(vehicleid == GetPlayerVehicleID(killerid))
		RemovePlayerFromVehicle(killerid);
		
	if(VehicleInfo[vehicleid][vFaction] >= 1 || VehicleInfo[vehicleid][vJob] >= 1 || VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE) 
	{
		AC_RepairVehicle(vehicleid);
	    VehicleInfo[vehicleid][vDestroyed] 	= false;
	    VehicleInfo[vehicleid][vFuel] 		= 100;
	    VehicleInfo[vehicleid][vCanStart] 	= 1;
	}
    return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(vehicleid == INVALID_VEHICLE_ID)
			return 1;
		if(!Iter_Contains(ServerVehicle[VehicleInfo[vehicleid][vUsage]], vehicleid))
			return 1;
			
		if(VehicleInfo[vehicleid][vTireArmor] == 1)
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
		if(VehicleInfo[vehicleid][vBodyArmor] == 1)
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
	if(VehicleInfo[vehicleid][vInt] != 0) 
		LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][vInt]);
	else 
		LinkVehicleToInterior(vehicleid, 0);
	
	if(VehicleInfo[vehicleid][vViwo] != 0) 
		SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][vViwo]);
	else 
		SetVehicleVirtualWorld(vehicleid, 0);
	
	if(VehicleInfo[vehicleid][vParkX] != 0.0)
		SetVehiclePos(vehicleid, VehicleInfo[vehicleid][vParkX], VehicleInfo[vehicleid][vParkY], VehicleInfo[vehicleid][vParkZ]);
	
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
	if(GetPlayerVehicleID(playerid) && VehicleInfo[GetPlayerVehicleID(playerid)][vJob] != 0) {
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT) 
	{
		new
			vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][vType] == VEHICLE_TYPE_BOAT && !LicenseInfo[playerid][pBoatLic]) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate upravljati brodom pa ste izasli!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if(( VehicleInfo[vehicleid][vType] == VEHICLE_TYPE_PLANE || IsAHelio( GetVehicleModel( vehicleid))) && !LicenseInfo[playerid][pFlyLic]) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate upravljati avionom pa ste izasli!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if(( VehicleInfo[vehicleid][vType] == VEHICLE_TYPE_CAR || VehicleInfo[vehicleid][vType] == VEHICLE_TYPE_MOTOR) && !LicenseInfo[playerid][pCarLic] && !IsABike(vehicleid)) 
			SendClientMessage( playerid, COLOR_RED, "[!] Nemate vozacku dozvolu pazite se policije!");

		if(VehicleInfo[vehicleid][vJob] != 0)
		{
			if(VehicleInfo[vehicleid][vJob] != PlayerJob[playerid][pJob]) 
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne znate voziti ovo vozilo!");
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
		}
		if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_NEWBIES && PlayerInfo[playerid][pLevel] > 3) {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova vozila su predvidjena za nove igrace (max level 3)!");
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if(VehicleInfo[vehicleid][vDestroyed])
			SendClientMessage(GetVehicleDriver( vehicleid), COLOR_RED, "Vase je vozilo unisteno, zovite mehanicara ili pronadjite obliznji Pay 'n' Spray!");

		if(vehicleid == INVALID_VEHICLE_ID || vehicleid == 0) return 1;
		if(PlayerFaction[playerid][pMember] != VehicleInfo[vehicleid][vFaction] && VehicleInfo[vehicleid][vFaction] > 0 ) {
			RemovePlayerFromVehicle(playerid);
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik organizacije da mozete voziti organizacijska vozila!");
			return 1;
		}
	}
	if(( newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER) && Bit1_Get( gr_JackedPlayer, playerid)) {
	
		PutPlayerInVehicle( playerid, Bit16_Get( gr_JackedVehicle, playerid), 0);
		Bit1_Set( gr_JackedPlayer, 		playerid, true);
		Bit16_Set( gr_JackedVehicle, 	playerid, 999);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		if(VehicleInfo[vehicleid][vLocked])
		{
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx( vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			if(doors)
			{
				new
					Float:slx,Float:sly,Float:slz;
				TogglePlayerControllable(playerid, 0);
				defer JackerUnfreeze(playerid);
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
				SendClientMessage(playerid,COLOR_RED,"(( Freezean si 3 sekunde zbog pokusaja ninja jackanja.))");

				defer JackerUnfreeze(playerid);
				GetPlayerPos(playerid, 			slx, 	sly, slz);
				SetPlayerPos(playerid, 			slx, 	sly, slz+5);
				PlayerPlaySound(playerid, 		1130, 	slx, sly, slz+5);

				Bit1_Set( gr_JackedPlayer, 		i, true);
				Bit16_Set( gr_JackedVehicle, 	i, vehicleid);
				break;
			}
	 	}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_YES) && IsPlayerInAnyVehicle( playerid))
	{
		new engine,lights,alarm,doors,bonnet,boot,objective,
			vehicle = GetPlayerVehicleID(playerid),
			modelid = GetVehicleModel(vehicle);
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
		if(IsABike(modelid) || IsAPlane(modelid) || IsABoat(modelid)) return 1;

		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);

		if(!VehicleInfo[vehicle][vLights]) {
			VehicleInfo[vehicle][vLights] = 1;
			SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		} else {
			VehicleInfo[vehicle][vLights] = 0;
			SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		}
	}
	return 1;
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

static
	enginet[MAX_PLAYERS];

CMD:engine(playerid, params[])
{
	#pragma unused params
		
	new
		engine, lights, alarm, doors, bonnet, boot, objective,
		vehicleid = GetPlayerVehicleID( playerid),
		vstring[81],
		Float:vhp;
		
	GetVehicleHealth(vehicleid, vhp);
		
	if((enginet[playerid] > gettime()) && VehicleInfo[vehicleid][vDestroyed])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte prije ponovnog paljenja vozila!");
	
	if(Player_WoundedAnim(playerid)) 				
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ranjeni ste, trenutno niste u stanju upravljati vozilom!");
	if(IsABike(GetVehicleModel(vehicleid))) 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilno vozilo!");
	if(!IsPlayerInVehicle(playerid, vehicleid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste vozac auta!");
	if(VehicleInfo[vehicleid][vEngineScrewed]) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete upaliti motor jer je zaribao!");
	if(VehicleInfo[vehicleid][vOverHeated])		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete upaliti motor, svjecice su dotrajale.");
	if(VehicleInfo[vehicleid][vDestroyed] && vhp >= 255.0 && !VehicleInfo[vehicleid][vEngineRunning])
	{
		switch(random(99))
		{
			case 0 .. 15:
				format(vstring, sizeof(vstring), "* %s okrece kljuc te pali unisteno vozilo.", GetName(playerid, true));
			case 16 .. 99:
			{
				format(vstring, sizeof(vstring), "* %s pokusava upaliti unisteno vozilo ali ne uspijeva.", GetName(playerid, true));
				enginet[playerid] = gettime() + 2;
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi uspio upaliti motor! Koristi /engine kako bi pokusao ponovno.");
			}
		}
		SetPlayerChatBubble(playerid, vstring, COLOR_PURPLE, 20, 2000);
	}
	else if(VehicleInfo[vehicleid][vDestroyed] && vhp < 255.0)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo se ne moze upaliti jer je motor unisten.");
		
	if(VehicleInfo[vehicleid][vEngineRunning]) {
		GameTextForPlayer(playerid, "~r~Motor iskljucen", 3000, 4);

		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
		VehicleInfo[vehicleid][vEngineRunning] = 0;
	} 
	else 
	{
		if(!VehicleInfo[vehicleid][vFuel]) 	
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo je ostalo bez goriva!");
		if(!VehicleInfo[vehicleid][vCanStart] 
			&& VehicleInfo[vehicleid][vGPS] 
			&& PlayerJob[playerid][pJob] != JOB_JACKER) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo je unisteno! Zovite mehanicara na /call 555!");
		if(VehicleInfo[vehicleid][vImpounded]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo je zaplijenjeno od strane policije!");

		#if defined MODULE_BOMBS
		foreach(new i : Player) {
			if(BombInfo[i][bVehicleid] == vehicleid) {
				if(BombInfo[i][bPlanted]) {
					DetonateBomb(i);
					return 1;
				}
			}
		}
		#endif

		if(PlayerKeys[playerid][pVehicleKey] == vehicleid || VehicleInfo[vehicleid][vSpareKey1] == PlayerInfo[playerid][pSQLID] || VehicleInfo[vehicleid][vSpareKey2] == PlayerInfo[playerid][pSQLID]) {
			if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_PRIVATE) {

				VehicleInfo[vehicleid][vBatteryLife] 	-= 0.001;
				if(0.001 <= VehicleInfo[vehicleid][vBatteryLife] <= 5000.0) {
					switch(random(50))
					{
						case 0 .. 25: 
						{ 
							GameTextForPlayer(playerid, "~r~Motor nije upalio radi slabog akumulatora", 3000, 1);
							GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
							SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
							VehicleInfo[vehicleid][vEngineRunning] = 0;
						}
						case 26 .. 50: 
						{ 
							GameTextForPlayer(playerid, "~g~Motor ukljucen", 3000, 4);
							GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
							SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
							VehicleInfo[vehicleid][vEngineRunning] = 1;
						}
					}
				} 
				else 
				{
					if(VehicleInfo[vehicleid][vEngineLife] > 10000) 
					{
						GameTextForPlayer(playerid, "~g~Motor ukljucen", 3000, 4);
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
						VehicleInfo[vehicleid][vEngineRunning] = 1;
					}
					else if(1 <= VehicleInfo[vehicleid][vEngineLife] <= 10000)
					{
						switch(random(50)) 
						{
							case 0 .. 25: 
							{
								GameTextForPlayer(playerid, "~g~Motor ukljucen", 3000, 4);
								GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
								SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
								VehicleInfo[vehicleid][vEngineRunning] = 1;
							}
							case 26 .. 50: 
							{
								GameTextForPlayer(playerid, "~r~Motor nije upalio radi loseg motora", 3000, 1);
								GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
								SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
								VehicleInfo[vehicleid][vEngineRunning] = 0;
							}
						}
					}
				}
			}
		}
		else 
		{
			switch( VehicleInfo[vehicleid][vUsage])
			{
				case VEHICLE_USAGE_PRIVATE:
					StartHotWiring( playerid, vehicleid);
				case VEHICLE_USAGE_NORMAL, VEHICLE_USAGE_FACTION, VEHICLE_USAGE_JOB, VEHICLE_USAGE_LICENSE: 
				{
         			GameTextForPlayer(playerid, "~g~Motor ukljucen", 3000, 4);
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
					VehicleInfo[vehicleid][vEngineRunning] = 1;
				}
				case VEHICLE_USAGE_RENT: 
				{
					if(Player_RentVehicle(playerid) != vehicleid)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate kljuc od ovog vozila!");

					GameTextForPlayer(playerid, "~g~Motor ukljucen", 3000, 4);
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
					VehicleInfo[vehicleid][vEngineRunning] = 1;
				}
			}
		}
	}
	return 1;
}

CMD:lock(playerid, params[])
{
	new vehicleid = GetNearestVehicle(playerid);
	if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");
	new
		engine, lights, alarm, doors, bonnet, boot, objective,
		string[47];
	GetVehicleParamsEx( vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	switch( VehicleInfo[vehicleid][vUsage])
	{
		case VEHICLE_USAGE_PRIVATE: 
		{
			if(PlayerKeys[playerid][pVehicleKey] != vehicleid && VehicleInfo[vehicleid][vSpareKey1] != PlayerInfo[playerid][pSQLID] && VehicleInfo[vehicleid][vSpareKey2] != PlayerInfo[playerid][pSQLID]) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate kljuc od ovoga vozila!");
			
			if(!VehicleInfo[vehicleid][vLocked]) 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~r~zakljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = true;

				format( string, sizeof(string), "* %s zakljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			
			} 
			else 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = false;

				format( string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			}
		}
		case VEHICLE_USAGE_JOB:
		 {
			if(VehicleInfo[vehicleid][vJob] != PlayerJob[playerid][pJob]) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate kljuc od ovog vozila!");
			
			if(!VehicleInfo[vehicleid][vLocked]) 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~r~zakljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = true;

				format( string, sizeof(string), "* %s zakljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			} 
			else 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = false;

				format( string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			}
		}
		case VEHICLE_USAGE_FACTION: {
			if(VehicleInfo[vehicleid][vFaction] != 
				( !PlayerFaction[playerid][pLeader] ? PlayerFaction[playerid][pMember] : PlayerFaction[playerid][pLeader])) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate kljuc od ovog vozila!");
			
			if(!VehicleInfo[vehicleid][vLocked]) 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~r~zakljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = true;

				format( string, sizeof(string), "* %s zakljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			} 
			else 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = false;

				format( string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			}
		}
		case VEHICLE_USAGE_RENT: 
		{
			if(Player_RentVehicle(playerid) != vehicleid) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate kljuc od ovog vozila!");
			
			if(!VehicleInfo[vehicleid][vLocked]) 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~r~zakljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = true;

				format( string, sizeof(string), "* %s zakljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			} 
			else 
			{
				GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 4);
				SetVehicleParamsEx( vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
				VehicleInfo[vehicleid][vLocked] = false;

				format( string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
			}
		}
	}
	return 1;
}

CMD:createvehicle(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje ove komande.");
	new
		model, color1, color2, respawndelay, usage, type, faction, job, Float:health,
		vehCarId, registracija[32],sirenon,
		Float:X, Float:Y, Float:Z, Float:Angle;

	new engine,lights,alarm,doors,bonnet,boot,objective;
	if(sscanf(params, "iiiiiiiifi", model, color1, color2, respawndelay, usage, type, faction, job, health, sirenon)) return SendClientMessage(playerid, COLOR_RED, "[?]: /createvehicle [model][color1][color2][respawndelay][usage][type][faction][job][health][siren]");
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, Angle);

	vehCarId = AC_CreateVehicle(model, X, Y, Z, floatround(Angle), color1, color2, respawndelay, sirenon);

	VehicleInfo[vehCarId][vModel]		= model;
	VehicleInfo[vehCarId][vParkX] 		= X;
	VehicleInfo[vehCarId][vParkY] 		= Y;
	VehicleInfo[vehCarId][vParkZ] 		= Z;
	VehicleInfo[vehCarId][vAngle] 		= floatround(Angle);
	VehicleInfo[vehCarId][vInt]			= GetPlayerInterior(playerid);
	VehicleInfo[vehCarId][vViwo]		= GetPlayerVirtualWorld(playerid);
	VehicleInfo[vehCarId][vFuel] 		= 100;
	VehicleInfo[vehCarId][vHealth] 		= health;

	SetVehicleVirtualWorld(vehCarId, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehCarId, GetPlayerInterior(playerid));
	SetVehicleHealth(vehCarId, health);
	PutPlayerInVehicle(playerid, vehCarId, 0);

	GetVehicleParamsEx(vehCarId,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehCarId, IsABike(model) ? VEHICLE_PARAMS_ON : VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);

	VehicleInfo[vehCarId][vUsage] = usage;
	VehicleInfo[vehCarId][vColor1] = color1;
	VehicleInfo[vehCarId][vColor2] = color2;
	VehicleInfo[vehCarId][vPaintJob] = 0;
	VehicleInfo[vehCarId][vBodyArmor] = 0;
	VehicleInfo[vehCarId][vTireArmor] = 0;

	ChangeVehiclePaintjob(vehCarId, 3);
	ChangeVehicleColor(vehCarId, color1, color2);

	new rand = 100000 + random(8999999);
	format(registracija, sizeof(registracija), "%d", rand);
	format(VehicleInfo[vehCarId][vNumberPlate], 8, "%s",registracija);
   	SetVehicleNumberPlate(vehCarId, registracija);

	VehicleInfo[vehCarId][vModel] 			= model;
	VehicleInfo[vehCarId][vType] 			= type;
	VehicleInfo[vehCarId][vAngle] 			= floatround(Angle);
	VehicleInfo[vehCarId][vRespawn] 		= respawndelay;
	VehicleInfo[vehCarId][vSirenon] 		= sirenon;
	VehicleInfo[vehCarId][vFaction] 		= faction;
	VehicleInfo[vehCarId][vJob] 			= job;
	VehicleInfo[vehCarId][vLocked] 			= 1;
	VehicleInfo[vehCarId][vInt] 			= GetPlayerInterior(playerid);
	VehicleInfo[vehCarId][vViwo] 			= GetPlayerVirtualWorld(playerid);
	VehicleInfo[vehCarId][vImpounded] 		= 0;
	VehicleInfo[vehCarId][vTravel] 			= 0;
	VehicleInfo[vehCarId][vEngineRunning]   = 0;
	VehicleInfo[vehCarId][vCanStart]        = 1;

	CreateNewVehicle(playerid, vehCarId);
	return 1;
}


CMD:cl(playerid, params[])
{
	new
		engine, lights, alarm, doors, bonnet, boot, objective,
		vehicle = GetPlayerVehicleID(playerid),
		modelid = GetVehicleModel(vehicle);

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "Morate biti vozac da bi ste mogli koristit ovu komandu.");
	if(IsABike(modelid) || IsAPlane(modelid) || IsABoat(modelid)) return SendClientMessage(playerid, COLOR_RED, "Nepoznata akcija.");

	if(!VehicleInfo[vehicle][vLights]) 
	{
	    VehicleInfo[vehicle][vLights] = 1;
		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		if(IsTrailerAttachedToVehicle( vehicle)) {
			GetVehicleParamsEx( GetVehicleTrailer( vehicle),engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx( GetVehicleTrailer( vehicle),engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		}
	} 
	else 
	{
		VehicleInfo[vehicle][vLights] = 0;
		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicle,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		if(IsTrailerAttachedToVehicle( vehicle)) {
			GetVehicleParamsEx( GetVehicleTrailer( vehicle),engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx( GetVehicleTrailer( vehicle),engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		}
	}
	return 1;
}

CMD:bonnet(playerid, params[])
{
    new engine,lights,alarm,doors,bonnet,boot,objective,vehicle = GetPlayerVehicleID(playerid),modelid = GetVehicleModel(vehicle);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "Morate biti vozac da bi ste mogli koristit ovu komandu.");
	if(IsABike(modelid) || IsAPlane(modelid) || IsABoat(modelid)) return SendClientMessage(playerid, COLOR_RED, "Nepoznata akcija.");
	if(VehicleInfo[vehicle][vBonnets] == 0) {
	    VehicleInfo[vehicle][vBonnets] = 1;
		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicle,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
	} else {
		VehicleInfo[vehicle][vBonnets] = 0;
		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicle,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
	}
	return 1;
}