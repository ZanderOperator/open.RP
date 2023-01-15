#include <YSI_Coding\y_hooks>

#define MAX_VEHICLES_IN_RANGE		(15)
#define MAX_NEAR_VEHICLE_RANGE		(10.0)

GetVehicleDriver(vehicleid)
{
	new
		playerid = INVALID_PLAYER_ID;
	foreach(new i : Player)
	{
		if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
		{
			playerid = i;
			break;
		}
	}
	return playerid;
}

DoesVehicleHavePlayers(vehicleid)
{
	foreach(new i:  Player)
	{
		if(IsPlayerInVehicle(i, vehicleid))
			return 1;
	}
	return 0;
}

IsVehicleOccupied(vehicleid) 
{
    foreach(new i : Player) 
	{
        if(IsPlayerInAnyVehicle(i))  
		{
            if(GetPlayerVehicleID(i) == vehicleid)
                return 1;
        }
    }
	return 0;
}

RemovePlayersFromVehicle(vehicleid)
{
	foreach(new i : Player)
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			SendMessage(i, MESSAGE_TYPE_INFO, "Vozilo je u procesu sigurnog parkiranja. Molimo nemojte ulaziti u njega 5 sekundi!");
		}
	}
	return 1;
}

bool:IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:range)
{
	new 
		Float:vX, Float:vY, Float: vZ;
	GetVehiclePos(vehicleid, vX, vY, vZ);
	if(IsPlayerInRangeOfPoint(playerid, range, vX, vY, vZ)) 
		return true;
	return false;
}

GetNearestVehicle(playerid, VEHICLE_TYPE = -1, VEHICLE_FACTION = -1)
{
	new 
		vehicleid = INVALID_VEHICLE_ID,
		slotid = 0,
		Float:vX, Float:vY, Float:vZ,
		close_vehicles[MAX_SUBJECTS_IN_RANGE][E_CLOSEST_SUBJECTS];
	
	foreach(new i : StreamedVehicle[playerid])
	{
		if(slotid >= MAX_SUBJECTS_IN_RANGE)
			break;
			
		if(VEHICLE_TYPE != -1)
		{
			if(VehicleInfo[i][vUsage] != VEHICLE_TYPE)
				continue;
		}
		if(VEHICLE_FACTION != -1)
		{
			if(VehicleInfo[i][vFaction] != VEHICLE_FACTION)
				continue;
		}
		if(IsPlayerInRangeOfVehicle(playerid, i, MAX_NEAR_VEHICLE_RANGE))
		{
			GetVehiclePos(i, vX, vY, vZ);
			close_vehicles[slotid][cDistance] = GetPlayerDistanceFromPoint(playerid, vX, vY, vZ);
			close_vehicles[slotid][cID] = i;
			slotid++;
		}
	}
	SortNearestRangeID(close_vehicles, slotid);
	vehicleid = close_vehicles[0][cID];	
	return vehicleid;
}

GetVehicleByModel(modelid, bool:price = false)
{
	for(new i = 0; i < sizeof(LandVehicles); i++)
	{
		if(LandVehicles[i][viModelid] == modelid)
		{
			if(price)
				return LandVehicles[i][viPrice];
			return i;
		}
	}
	for(new i = 0; i < sizeof(SeaVehicles); i++)
	{
		if(SeaVehicles[i][viModelid] == modelid)
		{
			if(price)
				return SeaVehicles[i][viPrice];
			return i;
		}
	}
	for(new i = 0; i < sizeof(AirVehicles); i++)
	{
		if(AirVehicles[i][viModelid] == modelid)
		{
			if(price)
				return AirVehicles[i][viPrice];
			return i;
		}
	}
	return -1;
}

GetVehicleCapacityByModel(modelid)
{
	for(new i = 0; i < sizeof(LandVehicles); i++)
	{
		if(LandVehicles[i][viModelid] == modelid)
		{
			return LandVehicles[i][viSlots];
		}
	}
	return -1;
}

WeaponModels(weaponid) 
{
    new const g_aWeaponModels[] = 
	{
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    if(1 <= weaponid <= 46)
        return g_aWeaponModels[weaponid];

	return 0;
}

IsVehicleWithoutTrunk(modelid)
{
	switch(modelid) 
	{
	    case 403,406,407,408,416,417,423,424,425,430,432,434,435,441,443,444,
			446,447,449,450,452,453,454,457,460,464,465,469,472,473,476,481,485,486,493,494,495,501,
			502,503,504,505,509,510,512,513,514,515,520,524,525,528,530,531,532,537,538,539,544,552,
			556,557,564,568,569,570,571,572,573,574,578,583,584, 590,591,592,593,594,
			595,601,606,607,608,610,611:
	        return true;
	}
	return false;
}

enum e_OffsetTypes 
{
    VEHICLE_OFFSET_BOOT,
    VEHICLE_OFFSET_HOOD,
    VEHICLE_OFFSET_ROOF
};

GetVehicleOffset(vehicleid, type, &Float:x, &Float:y, &Float:z)
{
    new Float:fPos[4], Float:fSize[3];
 
    if(!Vehicle_Exists(VehicleInfo[vehicleid][vUsage], vehicleid))
    {
        x = 0.0;
        y = 0.0;
        z = 0.0;
        return 0;
    }
    else
    {
        GetVehiclePos(vehicleid, fPos[0], fPos[1], fPos[2]);
        GetVehicleZAngle(vehicleid, fPos[3]);
        GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
 
        switch (type)
        {
            case VEHICLE_OFFSET_BOOT:
            {
                x = fPos[0] - (floatsqroot(fSize[1] + fSize[1]) * floatsin(-fPos[3], degrees));
                y = fPos[1] - (floatsqroot(fSize[1] + fSize[1]) * floatcos(-fPos[3], degrees));
                z = fPos[2];
            }
            case VEHICLE_OFFSET_HOOD:
            {
                x = fPos[0] + (floatsqroot(fSize[1] + fSize[1]) * floatsin(-fPos[3], degrees));
                y = fPos[1] + (floatsqroot(fSize[1] + fSize[1]) * floatcos(-fPos[3], degrees));
                z = fPos[2];
            }
            case VEHICLE_OFFSET_ROOF:
            {
                x = fPos[0];
                y = fPos[1];
                z = fPos[2] + floatsqroot(fSize[2]);
            }
        }
    }
    return 1;
}

IsPlayerNearDoor(playerid, vehicleid)
{
	new Float:X, Float:Y, Float:Z;
	GetVehiclePos(vehicleid, X, Y, Z);

	X -= -0.9681;
	Y += 0.2947;
	if(GetPlayerDistanceFromPoint(playerid, X, Y, Z) <= 3.0) return 1;
	return 0;
}

IsPlayerNearTrunk(playerid, vehicleid)
{
	new Float:X, Float:Y, Float:Z;
	GetVehicleOffset(vehicleid, VEHICLE_OFFSET_BOOT, X, Y, Z);
	if(GetPlayerDistanceFromPoint(playerid, X, Y, Z) <= 3.0) return 1;
	return 0;
}

IsABike(model)
{
	switch(model) 
	{
		case 509, 481, 510: return 1;
	}
	return 0;
}

IsABoat(modelid)
{
	switch(modelid) 
	{
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:
			return 1;
	}
	return 0;
}

IsAMotorBike(modelid)
{
    if(modelid ==581 || modelid ==522 || modelid ==521 || modelid ==523 || modelid ==586 || modelid ==462 || modelid ==448 || modelid ==461 || modelid ==463 || modelid ==468 || modelid ==471) return 1;
    else return 0;
}

IsAPlane(model)
{
	switch(model) {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469:
			return 1;
	}
	return 0;
}

IsAHelio(model)
{
 	switch(model) {
		case 548, 425, 417, 487, 488, 497, 563, 447, 469:
			return 1;
 	}
 	return 0;
}

IsACabrio(model)
{
	switch(model) {
		case 424, 429, 430, 439, 446, 448, 452, 453, 454, 457, 461, 462, 463, 468, 471, 472, 473, 476, 480, 481, 484, 485, 486, 493, 500, 506, 509, 510, 512, 513, 521, 522, 523, 530, 531, 533, 536, 539, 555, 567, 568, 571, 572, 575, 581, 586:
			return 1;
		default:
			return 0;
	}
	return 0;
}

IsHaveNoNumberPlate(model)
{
    switch(model)
	{
		case 481, 509, 510, 592,476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469, 430, 446, 452, 453, 454 , 472, 473, 484, 493, 595, 494, 502, 503, 444, 457, 471, 539, 568, 530, 572, 583, 605, 406 , 486, 514, 531, 532, 573, 485, 432, 528, 601:
			return 1;
    }
    return 0;
}

encode_panels(flp, frp, rlp, rrp, windshield, front_bumper, rear_bumper)
{
    return flp | (frp << 4) | (rlp << 8) | (rrp << 12) | (windshield << 16) | (front_bumper << 20) | (rear_bumper << 24);
}

encode_doors(bonnet, boot, driver_door, passenger_door, behind_driver_door, behind_passenger_door)
{
    #pragma unused behind_driver_door
    #pragma unused behind_passenger_door
    return bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24);
}

encode_lights(light1, light2, light3, light4)
{
    return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);
}

encode_tires(tires1, tires2, tires3, tires4)
{
	return tires1 | (tires2 << 1) | (tires3 << 2) | (tires4 << 3);
}


decode_lights(lights, &light1, &light2, &light3, &light4)
{
    light1 = lights & 1;
    light2 = lights >> 1 & 1;
    light3 = lights >> 2 & 1;
    light4 = lights >> 3 & 1;
}
 
decode_panels(panels, &front_left_panel, &front_right_panel, &rear_left_panel, &rear_right_panel, &windshield, &front_bumper, &rear_bumper)
{
    front_left_panel = panels & 15;
    front_right_panel = panels >> 4 & 15;
    rear_left_panel = panels >> 8 & 15;
    rear_right_panel = panels >> 12 & 15;
    windshield = panels >> 16 & 15;
    front_bumper = panels >> 20 & 15;
    rear_bumper = panels >> 24 & 15;
}
 
decode_doors(doors, &bonnet, &boot, &driver_door, &passenger_door)
{
    bonnet = doors & 7;
    boot = doors >> 8 & 7;
    driver_door = doors >> 16 & 7;
    passenger_door = doors >> 24 & 7;
}
 
decode_tires(tires, &tire1, &tire2, &tire3, &tire4)
{
    tire1 = tires & 1;
    tire2 = tires >> 1 & 1;
    tire3 = tires >> 2 & 1;
    tire4 = tires >> 3 & 1;
}


getTire(vehid, tireid)
{
    new 
		panels,doors,lights,tires,t1,t2,t3,t4,ret;
    GetVehicleDamageStatus(vehid, panels, doors, lights, tires);
	decode_tires(tires, t1, t2, t3, t4);
	switch(tireid)
	{
	    case F_L_TIRE:
	    {
 			ret = t1;
	    }
	    case B_L_TIRE:
	    {
 			ret = t2;
	    }
	    case F_R_TIRE:
	    {
 			ret = t3;
	    }
	    case B_R_TIRE:
	    {
 			ret = t4;
	    }
	}
	return ret;
}

setTire(vehid, tireid, stat)
{
	new 
		panels,doors,lights,tires,t1,t2,t3,t4;
	GetVehicleDamageStatus(vehid, panels, doors, lights, tires);
	t1 = getTire(vehid, F_L_TIRE);
	t2 = getTire(vehid, B_L_TIRE);
	t3 = getTire(vehid, F_R_TIRE);
	t4 = getTire(vehid, B_R_TIRE);
	switch(tireid)//
	{
	    case F_L_TIRE:
	    {
 			UpdateVehicleDamageStatus(vehid, panels, doors, lights, encode_tires(stat, t2, t3, t4));
	    }
	    case B_L_TIRE:
	    {
 			UpdateVehicleDamageStatus(vehid, panels, doors, lights, encode_tires(t1, stat, t3, t4));
	    }
	    case F_R_TIRE:
	    {
 			UpdateVehicleDamageStatus(vehid, panels, doors, lights, encode_tires(t1, t2, stat, t4));
	    }
	    case B_R_TIRE:
	    {
 			UpdateVehicleDamageStatus(vehid, panels, doors, lights, encode_tires(t1, t2, t3, stat));
	    }
	}
	return 1;
}

SetVehiclePosEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
    new 
		vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;
	
	TogglePlayerControllable(playerid, 0);
	Streamer_ToggleIdleUpdate(playerid, 1);
	
	SetVehiclePos(vehicleid, x, y, z);
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	
	SetVehicleVirtualWorld(vehicleid, viwo);
	LinkVehicleToInterior(vehicleid, interior);
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);
	PutPlayerInVehicle(playerid, vehicleid, 0);

	if(update)
		CallInstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);
	return 1;
}
