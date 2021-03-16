#include <YSI_Coding\y_hooks>

ptask PackageLossCheck[500](playerid)
{
	if(!Player_SafeSpawned(playerid))
		return 0;
		
	new Float:packetLoss;
	GetPlayerPacketloss(playerid, packetLoss);
	if(packetLoss >= 40.0)
	{
		Log_Write("logfiles/packageloss_kick.txt", "(%s) %s(IP: %s) is automatically kicked by server. Reason: Package Loss(%.2f percent).",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			packetLoss
		);
		new kickstring[128];
		format(kickstring, sizeof(kickstring), "[SERVER] %s(IP: %s) je kickan radi Package Loss-a(%.2f posto).",
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			packetLoss);

		ABroadCast(COLOR_RED,kickstring,1);

		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobio si automatski kick od servera radi desynca/slabe konekcije. Ponovno se logiraj.");
		KickMessage(playerid);
	}
	return 1;
}

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

stock AC_TogglePlayerControllable(playerid, toggle)
{
	if(toggle == 0)
		Player_SetFrozen(playerid, true);
	else
		Player_SetFrozen(playerid, false);
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
		PlayerHealth[playerid][pHealth] = health;
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
		PlayerHealth[playerid][pArmour] = armour;
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

static SendSplitMessage(playerid, color, const msgstring[])
{
    new len = strlen(msgstring);
    if(len >= EX_SPLITLENGTH)
    {
		new buffer[EX_SPLITLENGTH+10],
			colorstring[9] = EOS, colorstart = 0, colorend = 0,	
			buffer2[128], spacepos = 0, bool:broken = false;

		for(new j = 60; j < len; j++)
		{
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(msgstring[j] == ' ')
				spacepos = j;

			if(j >= EX_SPLITLENGTH && spacepos >= 60 && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;
				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));
				strmid(buffer, msgstring, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessage(playerid, color, buffer);
				strmid(buffer2, msgstring, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "%s...%s", colorstring, buffer2);
				SendClientMessage(playerid, color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessage(playerid, color, msgstring);
	}
    else return SendClientMessage(playerid, color, msgstring);
	return 1;
}

static SendSplitMessageToAll(color, const msgstring[])
{
    new len = strlen(msgstring);
    if(len >= EX_SPLITLENGTH)
    {
		new buffer[EX_SPLITLENGTH+10],
			colorstring[9] = EOS, colorstart = 0, colorend = 0,	
			buffer2[128], spacepos = 0, bool:broken=false;

		for(new j = 60; j < len; j++)
		{
			if(msgstring[j] == ' ')
				spacepos = j;
			
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(j >= EX_SPLITLENGTH && spacepos >= 60 && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;
				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));
				strmid(buffer, msgstring, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessageToAll(color, buffer);
				strmid(buffer2, msgstring, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "%s...%s", colorstring, buffer2);
				SendClientMessageToAll(color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessageToAll(color, msgstring);
	}
    else return SendClientMessageToAll(color, msgstring);
	return 1;
}

AC_SendClientMessageToAll(color, const message[])
{
	SendSplitMessageToAll(color, message);
	return 1;
}
#if defined _ALS_SendClientMessageToAll
    #undef SendClientMessageToAll
#else
    #define _ALS_SendClientMessageToAll
#endif
#define SendClientMessageToAll AC_SendClientMessageToAll

AC_SendClientMessage(playerid, color, const message[])
{
	SendSplitMessage(playerid, color, message);
	return 1;
}
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage AC_SendClientMessage

va_ShowPlayerDialog(playerid, dialogid, style, caption[], fmat[], button1[], button2[], va_args<>)
{
	new d_string[4096];
	va_format(d_string, sizeof(d_string), fmat, va_start<7>);
	return ShowPlayerDialog(playerid, dialogid, style, caption, d_string, button1, button2);
}

SendErrorMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_ERROR, smsgstring);
}

SendInfoMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_INFO, smsgstring);
}