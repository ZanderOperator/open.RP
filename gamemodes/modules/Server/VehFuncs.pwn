#include <YSI_Coding\y_hooks>

#define MAX_VEHICLES_IN_RANGE		(15)
#define MAX_NEAR_VEHICLE_RANGE		(10.0)

new Iterator:VehWeapon[MAX_VEHICLES]<MAX_WEAPON_SLOTS>,
	Iterator:VehWeaponObject[MAX_VEHICLES]<MAX_WEAPON_SLOTS>,
	Timer:VehicleAlarmTimer[MAX_VEHICLES],
	Timer:VehicleLightsTimer[MAX_VEHICLES],
	VehicleLightsBlinker[MAX_VEHICLES],
	bool:VehicleBlinking[MAX_VEHICLES],
	bool:VehicleAlarmStarted[MAX_VEHICLES];

stock bool:IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:range)
{
	new Float:vX, Float:vY, Float: vZ;
	GetVehiclePos(vehicleid, vX, vY, vZ);
	if(IsPlayerInRangeOfPoint(playerid, range, vX, vY, vZ)) return true;
	return false;
}

stock GetNearestVehicle(playerid, VEHICLE_TYPE = -1, VEHICLE_FACTION = -1)
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
    new const g_aWeaponModels[] = {
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    if (1 <= weaponid <= 46)
        return g_aWeaponModels[weaponid];

	return 0;
}

stock IsVehicleWithoutTrunk(modelid)
{
	switch(modelid) {
	    case 403,406,407,408,416,417,423,424,425,430,432,434,435,441,443,444,446,447,449,450,452,453,454,457,460,464,465,469,472,473,476,481,485,486,493,494,495,501,502,503,504,505,509,510,512,513,514,515,520,524,525,528,530,531,532,537,538,539,544,552,556,557,564,568,569,570,571,572,573,574,578,583,584, 590,591,592,593,594,595,601,606,607,608,610,611:
	        return true;
	}
	return false;
}

enum e_OffsetTypes {
    VEHICLE_OFFSET_BOOT,
    VEHICLE_OFFSET_HOOD,
    VEHICLE_OFFSET_ROOF
};

stock GetVehicleOffset(vehicleid, type, &Float:x, &Float:y, &Float:z)
{
    new Float:fPos[4], Float:fSize[3];
 
    if (!Vehicle_Exists(VehicleInfo[vehicleid][vUsage], vehicleid))
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

stock IsPlayerNearDoor(playerid, vehicleid)
{
	new Float:X, Float:Y, Float:Z;
	GetVehiclePos(vehicleid, X, Y, Z);

	X -= -0.9681;
	Y += 0.2947;
	if(GetPlayerDistanceFromPoint(playerid, X, Y, Z) <= 3.0) return 1;
	return 0;
}

stock IsPlayerNearTrunk(playerid, vehicleid)
{
	new Float:X, Float:Y, Float:Z;
	GetVehicleOffset(vehicleid, VEHICLE_OFFSET_BOOT, X, Y, Z);
	if(GetPlayerDistanceFromPoint(playerid, X, Y, Z) <= 3.0) return 1;
	return 0;
}

stock IsABike(model)
{
	switch(model) {
		case 509, 481, 510: return 1;
	}
	return 0;
}

stock IsABoat(modelid)
{
	switch(modelid) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:
			return 1;
	}
	return 0;
}

stock IsAMotorBike(modelid)
{
    if(modelid ==581 || modelid ==522 || modelid ==521 || modelid ==523 || modelid ==586 || modelid ==462 || modelid ==448 || modelid ==461 || modelid ==463 || modelid ==468 || modelid ==471) return 1;
    else return 0;
}

stock IsAPlane(model)
{
	switch(model) {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469:
			return 1;
	}
	return 0;
}

stock IsALowrider(modelid)
{
	switch( modelid ) {
		case 412, 534, 535, 536, 567, 575, 576: return 1;
		default: return 0;
	}
	return 0;
}

stock IsAHelio(model)
{
 	switch(model) {
		case 548, 425, 417, 487, 488, 497, 563, 447, 469:
			return 1;
 	}
 	return 0;
}

stock IsHaveNoNumberPlate(model)
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

getTire(vehid, tireid)
{
    new panels,doors,lights,tires,t1,t2,t3,t4,ret;//121 line
    GetVehicleDamageStatus(vehid, panels, doors, lights, tires);
	decode_tires(tires, t1, t2, t3, t4);//123
	switch(tireid)//124
	{//125
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
	new panels,doors,lights,tires,t1,t2,t3,t4;
	GetVehicleDamageStatus(vehid, panels, doors, lights, tires);
	t1 = getTire(vehid, F_L_TIRE);
	t2 = getTire(vehid, B_L_TIRE);//151
	t3 = getTire(vehid, F_R_TIRE);
	t4 = getTire(vehid, B_R_TIRE);//153
	switch(tireid)//154
	{//155
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