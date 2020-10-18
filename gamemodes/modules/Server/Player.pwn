#include <YSI_Coding\y_hooks>

stock GetPlayerPacketloss(playerid, &Float:packetloss)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	new
		nstats[401],
		nstats_loss[20],
		start,
		end;

	GetPlayerNetworkStats(playerid, nstats, sizeof(nstats));

	start = strfind(nstats,"packetloss",true);
	end = strfind(nstats,"%",true,start);

	strmid(nstats_loss, nstats, start+12, end, sizeof(nstats_loss));
	packetloss = floatstr(nstats_loss);
	return 1;
}

stock PackageLossCheck(playerid)
{
	new Float:packetLoss;
	GetPlayerPacketloss(playerid, packetLoss);
	if(packetLoss >= 40.0)
	{
		Log_Write("logfiles/packageloss_kick.txt", "(%s) %s(IP: %s) is automatically kicked by server. Reason: Package Loss(%.2f percent).",
			ReturnDate(),
			GetName(playerid, false),
			GetPlayerIP(playerid),
			packetLoss
		);
		new kickstring[128];
		format(kickstring, sizeof(kickstring), "[SERVER] %s(IP: %s) je kickan radi Package Loss-a(%.2f posto).",
			GetName(playerid, false),
			GetPlayerIP(playerid),
			packetLoss);

		ABroadCast(COLOR_RED,kickstring,1);

		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobio si automatski kick od servera radi desynca/slabe konekcije. Ponovno se logiraj.");
		KickMessage(playerid);
	}
	return 1;
}


stock AC_TogglePlayerControllable(playerid, toggle)
{
	if(toggle == 0)
		Frozen[playerid] = true;
	else
		Frozen[playerid] = false;
	return TogglePlayerControllable(playerid, toggle);
}
#if defined _ALS_TogglePlayerControllable
    #undef TogglePlayerControllable
#else
    #define _ALS_TogglePlayerControllable
#endif
#define TogglePlayerControllable AC_TogglePlayerControllable

stock AC_SpawnPlayer(playerid)
{
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, playerid);
	SpawnPlayer(playerid);
	Streamer_Update(playerid);
	CallLocalFunction("OnPlayerSpawn", "d", playerid);
}
#if defined _ALS_SpawnPlayer
    #undef SpawnPlayer
#else
    #define _ALS_SpawnPlayer
#endif
#define SpawnPlayer AC_SpawnPlayer

stock AC_SetPlayerHealth(playerid, Float:health, bool:admin_duty = false)
{
	if(!admin_duty)
		PlayerInfo[playerid][pHealth] = health;
	return SetPlayerHealth(playerid, health);
}
#if defined _ALS_SetPlayerHealth
    #undef SetPlayerHealth
#else
    #define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth AC_SetPlayerHealth

stock AC_SetPlayerArmour(playerid, Float:armour, bool:admin_duty = false)
{
	if(!admin_duty)
		PlayerInfo[playerid][pArmour] = armour;
	return SetPlayerArmour(playerid, armour);
}
#if defined _ALS_SetPlayerArmour
    #undef SetPlayerArmour
#else
    #define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour AC_SetPlayerArmour

stock AC_TogglePlayerSpectating(playerid, yon)
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0)
	{
		if(yon)
			Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, false);
	}
	if(!yon)
		Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, true);

	FIXES_TogglePlayerSpectating(playerid, yon);
	return 1;
}
#if defined _ALS_TogglePlayerSpectating
    #undef TogglePlayerSpectating
#else
    #define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating AC_TogglePlayerSpectating