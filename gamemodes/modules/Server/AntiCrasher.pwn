#include <a_samp>
#include <Pawn.RakNet>

#define BulletCrasher -5.5
#define eight 8
#define two 2
#define NULL 0
#define PASSENGER_SYNC  211
#define VEHICLE_SYNC  200
#define PLAYER_SYNC 207

#define InvalidSeat1 -1000000.0
#define InvalidSeat2 1000000.0

//Anti Crasher 0.3.7 R2 by [MD]_Shift | skype: dima.shift |
public OnIncomingPacket(playerid, packetid, BitStream:bs){
	switch(packetid) {
	case VEHICLE_SYNC:{
			new inCarData[PR_InCarSync];
			BS_IgnoreBits(bs, eight);
			BS_ReadInCarSync(bs, inCarData);
			if inCarData[PR_position][two] == BulletCrasher *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}|ID:%d| {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]",GetName(playerid),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return false;
			}
		}
	case PLAYER_SYNC:{
			new onFootData[PR_OnFootSync];
			BS_IgnoreBits(bs,eight);
			BS_ReadOnFootSync(bs, onFootData);
			if onFootData[PR_position][two] == BulletCrasher *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}|ID:%d| {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]",GetName(playerid),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return false;
			}
		}
	case PASSENGER_SYNC:{
			new passengerData[PR_PassengerSync];
			BS_IgnoreBits(bs, eight);
			BS_ReadPassengerSync(bs, passengerData);
			if GetPlayerVehicleSeat(playerid) == NULL *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}|ID:%d| {00FF00}je dobio auto-kick. {FF0000}[Razlog: VehicleCrasher]",GetName(playerid, true),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return false;
			}
			if passengerData[PR_position][two] == BulletCrasher *then {
				new string[MAX_CHATBUBBLE_LENGTH];
				format(string,sizeof(string),"[Anti-Cheat]: {FFFF00}%s {999999}|ID:%d| {00FF00}je dobio auto-kick. {FF0000}[Razlog: BulletCrasher]",GetName(playerid, true),playerid);
				SendClientMessageToAll(COLOR_LIGHTRED,string);
				Kick(playerid);
				return false;
			}
		}

	}
	return true;
}