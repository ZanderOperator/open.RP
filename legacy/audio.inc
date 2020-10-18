/*
    SA-MP Audio Plugin v0.5
    Copyright © 2011 Incognito

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <a_samp>

// Main Natives

native Audio_CreateTCPServer(port);
native Audio_DestroyTCPServer();
native Audio_SetPack(const name[], bool:transferable = true, bool:automated = true);
native Audio_IsClientConnected(playerid);
native Audio_SendMessage(playerid, const message[]);
native Audio_TransferPack(playerid);

// Sequence Natives

native Audio_CreateSequence();
native Audio_DestroySequence(sequenceid);
native Audio_AddToSequence(sequenceid, audioid);
native Audio_RemoveFromSequence(sequenceid, audioid);

// Audio Natives

native Audio_Play(playerid, audioid, bool:pause = false, bool:loop = false, bool:downmix = false);
native Audio_PlayStreamed(playerid, const url[], bool:pause = false, bool:loop = false, bool:downmix = false);
native Audio_PlaySequence(playerid, sequenceid, bool:pause = false, bool:loop = false, bool:downmix = false);
native Audio_Pause(playerid, handleid);
native Audio_Resume(playerid, handleid);
native Audio_Stop(playerid, handleid);
native Audio_Restart(playerid, handleid);
native Audio_GetPosition(playerid, handleid, const callback[] = "Audio_OnGetPosition");
native Audio_SetPosition(playerid, handleid, seconds);
native Audio_SetVolume(playerid, handleid, volume);
native Audio_SetFX(playerid, handleid, type);
native Audio_RemoveFX(playerid, handleid, type);
native Audio_Set3DPosition(playerid, handleid, Float:x, Float:y, Float:z, Float:distance);
native Audio_Remove3DPosition(playerid, handleid);

// Radio Station Natives

native Audio_SetRadioStation(playerid, station);
native Audio_StopRadio(playerid);

// Internal Natives

native Audio_AddPlayer(playerid, const ip[], const name[]);
native Audio_RenamePlayer(playerid, const name[]);
native Audio_RemovePlayer(playerid);

// Main Callbacks

forward Audio_OnClientConnect(playerid);
forward Audio_OnClientDisconnect(playerid);
forward Audio_OnTransferFile(playerid, file[], current, total, result);
forward Audio_OnPlay(playerid, handleid);
forward Audio_OnStop(playerid, handleid);
forward Audio_OnTrackChange(playerid, handleid, track[]);
forward Audio_OnRadioStationChange(playerid, station);

// Custom Callbacks

forward Audio_OnGetPosition(playerid, handleid, seconds);

// Callback Hook Section

static bool:Audio_g_CTS = false;
static bool:Audio_g_OPC = false;
static bool:Audio_g_OPDC = false;

public OnFilterScriptInit()
{
	if (!Audio_g_CTS)
	{
		Audio_g_CTS = true;
		Audio_g_OPC = (funcidx("Audio_OnPlayerConnect") != -1);
		Audio_g_OPDC = (funcidx("Audio_OnPlayerDisconnect") != -1);
		Audio_CreateTCPServer(GetServerVarAsInt("port"));
	}
	if (funcidx("Audio_OnFilterScriptInit") != -1)
	{
		return CallLocalFunction("Audio_OnFilterScriptInit", "");
	}
	return 1;
}

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit Audio_OnFilterScriptInit

forward Audio_OnFilterScriptInit();

public OnGameModeInit()
{
	if (!Audio_g_CTS)
	{
		Audio_g_CTS = true;
		Audio_g_OPC = (funcidx("Audio_OnPlayerConnect") != -1);
		Audio_g_OPDC = (funcidx("Audio_OnPlayerDisconnect") != -1);
		Audio_CreateTCPServer(GetServerVarAsInt("port"));
	}
	if (funcidx("Audio_OnGameModeInit") != -1)
	{
		return CallLocalFunction("Audio_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Audio_OnGameModeInit

forward Audio_OnGameModeInit();

public OnPlayerConnect(playerid)
{
	if (!IsPlayerNPC(playerid))
	{
		new ip[16], name[MAX_PLAYER_NAME];
		GetPlayerIp(playerid, ip, sizeof(ip));
		GetPlayerName(playerid, name, sizeof(name));
		Audio_AddPlayer(playerid, ip, name);
	}
	if (Audio_g_OPC)
	{
		return CallLocalFunction("Audio_OnPlayerConnect", "d", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Audio_OnPlayerConnect

forward Audio_OnPlayerConnect(playerid);

public OnPlayerDisconnect(playerid, reason)
{
	if (!IsPlayerNPC(playerid))
	{
		Audio_RemovePlayer(playerid);
	}
	if (Audio_g_OPDC)
	{
		return CallLocalFunction("Audio_OnPlayerDisconnect", "dd", playerid, reason);
	}
	return 1;
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Audio_OnPlayerDisconnect

forward Audio_OnPlayerDisconnect(playerid, reason);

// Native Hook Section

stock Audio_SetPlayerName(playerid, name[])
{
	new value = SetPlayerName(playerid, name);
	if (value > 0)
	{
		Audio_RenamePlayer(playerid, name);
	}
	return value;
}
#if defined _ALS_SetPlayerName
	#undef SetPlayerName
#else
	#define _ALS_SetPlayerName
#endif
#define SetPlayerName Audio_SetPlayerName
