
#include <YSI\y_hooks>

#if !defined IsNaN
    #define IsNaN(%0) ((%0) != (%0))
#endif

#define BulletCrasher -5.5
#define COLOR_LIGHTRED 0xFF6347AA

new VehicleDestroyed = 136;
const VEHICLE_SYNC = 200;
const AIM_SYNC = 203;
const PLAYER_SYNC = 207;
const UNOCCUPIED_SYNC = 209;
const PASSENGER_SYNC = 211;

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
	switch(packetid)
	{
		case VEHICLE_SYNC:
		{
			new inCarData[PR_InCarSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadInCarSync(bs, inCarData);
			if (inCarData[PR_position][2] == (BulletCrasher))
			{
				new string[144];
				format(string, sizeof(string), "[Anti-Cheat]: %s je pokusao koristiti Bullet Crasher u vozilu te je kickan.", GetName(playerid, false));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				KickMessage(playerid);
			}
			if(!IsValidVehicle(inCarData[PR_vehicleId]) && !Iter_Contains(Vehicles, inCarData[PR_vehicleId]) && !VehicleInfo[inCarData[PR_vehicleId]][vDeleted])
			{
				new string[144];
				format(string, sizeof(string), "[Anti-Cheat]: %s je pokusao koristiti Vehicle Hack na nepostojecem vozilu te je kickan.", GetName(playerid, false));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				KickMessage(playerid);
			}
			BS_ResetReadPointer(bs);
		}
		case AIM_SYNC:
		{
			new aimData[PR_AimSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadAimSync(bs, aimData);
			if(aimData[PR_aimZ] != aimData[PR_aimZ])
			{
				aimData[PR_aimZ] = 0.0;
				BS_SetWriteOffset(bs, 8);
				BS_WriteAimSync(bs, aimData);
			}
			BS_ResetReadPointer(bs);
		}
		case PLAYER_SYNC:
		{
			new ac_fData[PR_OnFootSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadOnFootSync(bs, ac_fData);
			if(ac_fData[PR_surfingOffsets][0] != ac_fData[PR_surfingOffsets][0] ||
			ac_fData[PR_surfingOffsets][1] != ac_fData[PR_surfingOffsets][1] ||
			ac_fData[PR_surfingOffsets][2] != ac_fData[PR_surfingOffsets][2])
			{
				ac_fData[PR_surfingOffsets][0] =
				ac_fData[PR_surfingOffsets][1] =
				ac_fData[PR_surfingOffsets][2] = 0.0;
				ac_fData[PR_surfingVehicleId] = 0;
				BS_SetWriteOffset(bs, 8);
				BS_WriteOnFootSync(bs, ac_fData);
			}
			else if(ac_fData[PR_surfingVehicleId] != 0 &&
			ac_fData[PR_surfingOffsets][0] == 0.0 && ac_fData[PR_surfingOffsets][1] == 0.0 &&
			ac_fData[PR_surfingOffsets][2] == 0.0)
			{
				ac_fData[PR_surfingVehicleId] = 0;
				BS_SetWriteOffset(bs, 8);
				BS_WriteOnFootSync(bs, ac_fData);
			}
			if (ac_fData[PR_position][2] == (BulletCrasher))
			{
				new string[144];
				format(string, sizeof(string), "[Anti-Cheat]: %s je pokusao koristiti Bullet Crasher te je kickan.", GetName(playerid, false));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				KickMessage(playerid);
			}
			BS_ResetReadPointer(bs);
		}
		case PASSENGER_SYNC:
		{
			new ac_pData[PR_PassengerSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadPassengerSync(bs, ac_pData);
			if(ac_pData[PR_seatId] < 1 || !Iter_Contains(Vehicles, ac_pData[PR_vehicleId]))
			{
				new string[144];
				format(string, sizeof(string), "[Anti-Cheat]: %s je pokusao koristiti Invalid Vehicle Seat Crasher te je kickan.", GetName(playerid, false));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				KickMessage(playerid);
			}
			if (ac_pData[PR_position][2] == (BulletCrasher))
			{
				new string[144];
				format(string, sizeof(string), "[Anti-Cheat]: %s je pokusao koristiti Bullet Crasher u vozilu te je kickan.", GetName(playerid, false));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				KickMessage(playerid);
			}
			BS_ResetReadPointer(bs);
		}
	}
    return 1;
}

IRPC:VehicleDestroyed(playerid, BitStream:bs)
{
    new vehicleid;

    BS_ReadUint16(bs, vehicleid);

    if (GetVehicleModel(vehicleid) < 400)
    {
        return 0;
    }

    return OnVehicleRequestDeath(vehicleid, playerid);
}

forward OnVehicleRequestDeath(vehicleid, killerid);
public OnVehicleRequestDeath(vehicleid, killerid)
{
	new Float:X, Float:Y, Float:Z, Float:health;
	GetVehiclePos(vehicleid, X, Y, Z);
	MapAndreas_FindZ_For2DCoord(X, Y, Z);
	GetVehicleHealth(vehicleid, health);
	
	if(health >= 250.0 && Z != 0.0) // If car above the water MapAndreas return a height 0.0
	{
		return 0;
	}
	
	return 1;
}

IPacket:UNOCCUPIED_SYNC(playerid, BitStream:bs)
{
    new unoccupiedData[PR_UnoccupiedSync];
 
    BS_IgnoreBits(bs, 8); // ignore packetid (byte)
    BS_ReadUnoccupiedSync(bs, unoccupiedData);
 
    if (IsNaN(unoccupiedData[PR_roll][0]) ||
        IsNaN(unoccupiedData[PR_roll][1]) ||
        IsNaN(unoccupiedData[PR_roll][2]) ||
        IsNaN(unoccupiedData[PR_direction][0]) ||
        IsNaN(unoccupiedData[PR_direction][1]) ||
        IsNaN(unoccupiedData[PR_direction][2]) ||
        IsNaN(unoccupiedData[PR_position][0]) ||
        IsNaN(unoccupiedData[PR_position][1]) ||
        IsNaN(unoccupiedData[PR_position][2]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][0]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][1]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][2]) ||
        IsNaN(unoccupiedData[PR_velocity][0]) ||
        IsNaN(unoccupiedData[PR_velocity][1]) ||
        IsNaN(unoccupiedData[PR_velocity][2]) ||
        (floatabs(unoccupiedData[PR_roll][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_roll][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_roll][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_position][0]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_position][1]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_position][2]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_velocity][0]) > 100.0) ||
        (floatabs(unoccupiedData[PR_velocity][1]) > 100.0) ||
        (floatabs(unoccupiedData[PR_velocity][2]) > 100.0)
    ) {
        return 0; // ignore bad packet
    }
	if ((unoccupiedData[PR_roll][0] == unoccupiedData[PR_direction][0]) &&
        (unoccupiedData[PR_roll][1] == unoccupiedData[PR_direction][1]) &&
        (unoccupiedData[PR_roll][2] == unoccupiedData[PR_direction][2])
    ) {
        return 0; // ignore bad packet
    }

    return 1;
}

hook OnGameModeInit()
{
	print("Server: Anti Crasher Sucessfully Loaded.");
	return 1;
}
