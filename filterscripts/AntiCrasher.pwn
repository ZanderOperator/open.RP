#include <a_samp>
#include <mapandreas>
#include <Pawn.RakNet>

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

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
	switch(packetid)
	{
		case PLAYER_SYNC:
		{
			new onFootData[PR_OnFootSync];

			BS_IgnoreBits(bs, 8); // ignore packetid (byte)
			BS_ReadOnFootSync(bs, onFootData);

			if (onFootData[PR_surfingVehicleId] != 0 &&
				onFootData[PR_surfingVehicleId] != INVALID_VEHICLE_ID
			) {
				if ((floatabs(onFootData[PR_surfingOffsets][0]) >= 50.0) ||
					(floatabs(onFootData[PR_surfingOffsets][1]) >= 50.0) ||
					(floatabs(onFootData[PR_surfingOffsets][2]) >= 50.0)
				) {
					return 0; // ignore bad packet
				} 
			}
			if onFootData[PR_position][2] == BulletCrasher *then 
			{
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}[ID:%d] {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]", GetName(playerid), playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return 0;
			}
		}
		case VEHICLE_SYNC:
		{
			new inCarData[PR_InCarSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadInCarSync(bs, inCarData);
			if inCarData[PR_position][2] == BulletCrasher *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}[ID:%d] {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]",GetName(playerid),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return 0;
			}
		}
		case PASSENGER_SYNC:
		{
			new passengerData[PR_PassengerSync];
			BS_IgnoreBits(bs, 8);
			BS_ReadPassengerSync(bs, passengerData);
			if GetPlayerVehicleSeat(playerid) == 0 *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}[ID:%d] {00FF00}je dobio auto-kick. {FF0000}[Razlog: VehicleCrasher]",GetName(playerid),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return 0;
			}
			if passengerData[PR_position][2] == BulletCrasher *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}[ID:%d] {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]",GetName(playerid),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return 0;
			}
		}
	}
    return 1;
}

IPacket:AIM_SYNC(playerid, BitStream:bs)
{
    new aimData[PR_AimSync];
    
    BS_IgnoreBits(bs, 8); // ignore packetid (byte)
    BS_ReadAimSync(bs, aimData);

    if (aimData[PR_aimZ] != aimData[PR_aimZ]) // is NaN
    {
        return 0; // ignore bad packet
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

public OnFilterScriptInit()
{
	print("Anti Crasher Script Sucessfully Loaded.");
	return 1;
}
