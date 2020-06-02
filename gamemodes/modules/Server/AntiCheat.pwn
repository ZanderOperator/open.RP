#include <YSI\y_hooks>

public OnPlayerFakeKill(playerid, spoofedid, spoofedreason, faketype)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pLevel] > 2)
		return 1;

	if(PlayerInfo[playerid][pKilled] != 0 || (KilledReason[playerid] != -1 && KilledBy[playerid] != INVALID_PLAYER_ID))
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Fake Kill", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Fake Kill!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerFakeConnect(playerid)
{
	Ban(playerid);
	return 1;
}

public OnPlayerJetpackCheat(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0)
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Jetpack", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Jetpack!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerSpamChat(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
	SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si kick sa servera, razlog: Spamm!");
	KickMessage(playerid);
	return 1;
}

public OnPlayerSpeedCheat(playerid, speedtype)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(GetPlayerVehicleID(playerid) != 0)
	{
		if( IsAPlane(GetVehicleModel(GetPlayerVehicleID(playerid))) || IsAHelio(GetVehicleModel(GetPlayerVehicleID(playerid))) )
			return 1;
	}
	if(!SafeSpawned[playerid])
		return 1;

	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0)
		return 1;
    if(adminfly[playerid] == 0)
	    return 1;
	if(IsWithTeamStaff(playerid))
		return 1;

	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Speed Cheat", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Speed Cheat!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerBreakAir(playerid, breaktype)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pLevel] > 2)
		return 1;
		
	if(GetPlayerVehicleID(playerid) != 0)
	{
		if( IsAPlane(GetVehicleModel(GetPlayerVehicleID(playerid))) || IsAHelio(GetVehicleModel(GetPlayerVehicleID(playerid))) )
			return 1;
	}
	if(!SafeSpawned[playerid])
		return 1;

	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0)
		return 1;
    if(adminfly[playerid] == 0)
	    return 1;
	if(IsWithTeamStaff(playerid))
		return 1;

	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Air Break", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Air Break!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerSpamCars(playerid, number)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0 || Bit1_Get(gr_OnEvent, playerid))
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Vehicle Spam", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Vehicle Spam!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerCarSwing(playerid, vehicleid)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(GetPlayerVehicleID(playerid) != 0)
	{
		if( IsAPlane(GetVehicleModel(GetPlayerVehicleID(playerid))) || IsAHelio(GetVehicleModel(GetPlayerVehicleID(playerid))) )
			return 1;
	}
	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0)
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Vehicle Swing", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Vehicle Swing!");
		BanMessage(playerid);
	}
	SetVehiclePreviousInfo(vehicleid);
	return 1;
}

public OnVehicleModEx(playerid, vehicleid, componentid, illegal)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(Bit1_Get(gr_PlayerInTuningMode, playerid))
		return 1;
	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Car Modding Hack", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Car Modding Hack!");
		BanMessage(playerid);
	}
	RemoveVehicleComponent(vehicleid, componentid);
	SetVehicleToRespawn(vehicleid);
	return 1;
}

public OnPlayerSlide(playerid, weaponid, Float:speed)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Bugging", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Bugging!");
		BanMessage(playerid);
	}
	return 1;
}

public OnPlayerLagout(playerid, lagtype, ping)
{
    if(IsPlayerNPC(playerid)) return 1;
	SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si kick sa servera, razlog: Lagout!");
	KickMessage(playerid);
	return 1;
}

public OnPlayerBugAttempt(playerid, bugcode)
{
   /* if(IsPlayerNPC(playerid)) return 1;
	if(bugcode == 0)
		return 1;

	if(PlayerInfo[playerid][pBanned] == 0)
	{
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Bug Cheating", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Bug Cheating!");
		BanMessage(playerid);
	}*/
	return 1;
}
