
#include <YSI_Coding\y_hooks>

#define COLOR_RADIO		(0xFFEC8BFF)
#define COLOR_RADIOEX	(0xB5AF8FFF)

static
	bool:RadioOn[MAX_PLAYERS];

static GetChannelSlot(playerid, channel)
{
	if(channel == PlayerRadio[playerid][pRadio][1])
		return 1;
	if(channel == PlayerRadio[playerid][pRadio][2])
		return 2;
	if(channel == PlayerRadio[playerid][pRadio][3])
		return 3;
	return 0;
}

/*

																		
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'                             

*/

LoadPlayerRadio(playerid)
{
	inline LoadingPlayerRadio()
	{
		if(!cache_num_rows())
		{
			mysql_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					player_radio \n\
				(sqlid, HasRadio, MainSlot, Radio1, Slot1, Radio2, Slot2, Radio3, Slot3) \n\
				VALUES \n\
					('%d', '0', '0', '0', '0', '0', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name_int(0,	"HasRadio"	, PlayerRadio[playerid][pHasRadio]);
		cache_get_value_name_int(0, "MainSlot"  , PlayerRadio[playerid][pMainSlot]);
		cache_get_value_name_int(0, "Radio1"    , PlayerRadio[playerid][pRadio][1]);
		cache_get_value_name_int(0, "Slot1"     , PlayerRadio[playerid][pRadioSlot][1]);
		cache_get_value_name_int(0, "Radio2"    , PlayerRadio[playerid][pRadio][2]);
		cache_get_value_name_int(0, "Slot2"     , PlayerRadio[playerid][pRadioSlot][2]);
		cache_get_value_name_int(0, "Radio3"    , PlayerRadio[playerid][pRadio][3]);
		cache_get_value_name_int(0, "Slot3"     , PlayerRadio[playerid][pRadioSlot][3]);
		return 1;
	}
    MySQL_TQueryInline(SQL_Handle(),
		using inline LoadingPlayerRadio,
        va_fquery(SQL_Handle(), "SELECT * FROM player_radio WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "i", 
        playerid
   );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerRadio(playerid);
	return continue(playerid);
}

SavePlayerRadio(playerid)
{
    mysql_fquery(SQL_Handle(),
        "UPDATE player_radio SET HasRadio = '%d', MainSlot = '%d', \n\
            Radio1 = '%d', Slot1 = '%d', \n\
            Radio2 = '%d', Slot2 = '%d', \n\
            Radio3 = '%d', Slot3 = '%d' \n\
            WHERE sqlid = '%d'",
        PlayerRadio[playerid][pHasRadio],
        PlayerRadio[playerid][pMainSlot],
        PlayerRadio[playerid][pRadio][1], PlayerRadio[playerid][pRadioSlot][1],
        PlayerRadio[playerid][pRadio][2], PlayerRadio[playerid][pRadioSlot][2],
        PlayerRadio[playerid][pRadio][3], PlayerRadio[playerid][pRadioSlot][3],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerRadio(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
	RadioOn[playerid] = true;

    PlayerRadio[playerid][pHasRadio] = 0;
    PlayerRadio[playerid][pMainSlot] = 0;
    PlayerRadio[playerid][pRadio][1] = 0; 
    PlayerRadio[playerid][pRadioSlot][1] = 0;
    PlayerRadio[playerid][pRadio][2] = 0;
    PlayerRadio[playerid][pRadioSlot][2] = 0;
    PlayerRadio[playerid][pRadio][3] = 0; 
    PlayerRadio[playerid][pRadioSlot][3] = 0;
	return continue(playerid);
}

CMD:radio(playerid, params[])
{
	if(!PlayerRadio[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!RadioOn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new 
		string[144],
		radioChan = PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if(PlayerRadio[i][pRadio][s] == radioChan && PlayerRadio[i][pHasRadio] && RadioOn[i])
			{
				format(string, 144, "**[CH: %d, S: %d] %s kaze: %s", 
					PlayerRadio[i][pRadio][s], 
					GetChannelSlot(i, radioChan), 
					GetName(playerid, true), 
					params
				);
				if(s != PlayerRadio[i][pMainSlot])
					SendClientMessage(i, COLOR_RADIOEX, string);
				else 
					SendClientMessage(i, COLOR_RADIO, string);
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

    REarsBroadCast(0xFFD1D1FF,string,1);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, false), params);
 			SendClientMessage(i, COLOR_FADE1, string);
		}
	}


	return true;
}

CMD:radiolow(playerid, params[])
{
	if(!PlayerRadio[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!RadioOn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
	
	if(!PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new string[144], radioChan = PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if(PlayerRadio[i][pRadio][s] == radioChan && PlayerRadio[i][pHasRadio] && RadioOn[i])
			{
				format (string, 144, "**[CH: %d, S: %d] %s kaze: %s", 
					PlayerRadio[i][pRadio][s], 
					GetChannelSlot(i, radioChan), 
					GetName(playerid, true), 
					params
				);
				if(s != PlayerRadio[i][pMainSlot])
					SendClientMessage(i, COLOR_RADIOEX, string);
				else
					SendClientMessage(i, COLOR_RADIO, string);
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s says[Low]: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_FADE1, string);
		}
	}
	REarsBroadCast(0xFFD1D1FF,string,1);
	return true;
}

CMD:r2(playerid, params[])
{
	if(!Player_SafeSpawned(playerid) || !IsPlayerConnected(playerid)) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	if(!PlayerRadio[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!RadioOn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerRadio[playerid][pRadio][2])return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))return SendClientMessage(playerid, COLOR_RED, "[?]: /r2 [radio text]");

	new chan;
	chan = PlayerRadio[playerid][pRadio][2];

	foreach(new i : Player)
	{
		for(new r = 0; r < 4; r++)
		{
			if(PlayerRadio[i][pRadio][r] == PlayerRadio[playerid][pRadio][2] && PlayerRadio[i][pHasRadio] && RadioOn[i])
			{
				if(r != PlayerRadio[i][pMainSlot])
				{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerRadio[playerid][pRadio][2], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else
				{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerRadio[playerid][pRadio][2], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIO, string);
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_WHITE, string);
		}
	}
	REarsBroadCast(0xFFD1D1FF,string,1);
	return true;
}

CMD:r3(playerid, params[])
{
	if(!Player_SafeSpawned(playerid) || !IsPlayerConnected(playerid)) 
		return SendErrorMessage(playerid, "Niste ulogirani!");
	if(!PlayerRadio[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
	if(!RadioOn[playerid])
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
	if(!PlayerRadio[playerid][pRadio][3])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /r3 [radio text]");

	new 
		chan = PlayerRadio[playerid][pRadio][3],
		string[144];

	foreach(new i : Player)
	{
		for(new r = 0; r < 4; r++)
		{
			if(PlayerRadio[i][pRadio][r] == PlayerRadio[playerid][pRadio][3] && PlayerRadio[i][pHasRadio] && RadioOn[i])
			{
				if(r != PlayerRadio[i][pMainSlot])
				{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerRadio[playerid][pRadio][3], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else
				{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerRadio[playerid][pRadio][3], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIO, string);
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_WHITE, string);
		}
	}
	REarsBroadCast(0xFFD1D1FF,string,1);
	return true;
}

CMD:togradio(playerid, params[])
{
	#pragma unused params

 	if(!PlayerRadio[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
	
	RadioOn[playerid] = !RadioOn[playerid],
	va_SendMessage(playerid,
		MESSAGE_TYPE_INFO,
		"You have %s your radio!",
		(RadioOn[playerid]) ? ("turned on") : ("turned off")
	);
    return 1;
}

CMD:channel(playerid, params[])
{
	if(!Player_SafeSpawned(playerid) || !IsPlayerConnected(playerid)) 
		return SendErrorMessage(playerid, "Niste ulogirani!");
	new 
		choice[16];
	if(sscanf(params, "s[16] ", choice)) 
	{
		SendClientMessage(playerid, -1, "[?]: /channel [opcija]");
		SendClientMessage(playerid, -1, "[?] OPCIJE: setslot, leave, set, playerfreq, checkfreq");
		return 1;
	}
	if(!strcmp( choice, "setslot", true)) 
	{
		new 
			string[144], 
			slotid;
		if(!PlayerRadio[playerid][pHasRadio])
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(sscanf(params, "s[16]i", choice, slotid))
			return SendClientMessage(playerid, COLOR_RED, "[?]: /channel setslot [slotid]");
		if(slotid < 1 || slotid > 3)
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");

		format(string, sizeof(string), "Lokalni kanal setovan na slot %d!", slotid);
		SendClientMessage(playerid, COLOR_RED, string);
		
		PlayerRadio[playerid][pMainSlot] = slotid;
        SavePlayerRadio(playerid);
	}
	if(!strcmp( choice, "leave", true)) 
	{
		new 
			string[144], 
			slotid;
		if(!PlayerRadio[playerid][pHasRadio]) 
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(!RadioOn[playerid])
			return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
		if(sscanf(params, "s[16]i", choice, slotid)) 
			return SendClientMessage(playerid, COLOR_RED, "[?]: /channel leave [slotid]");
		if(slotid < 1 || slotid > 3) 
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-5.");

		PlayerRadio[playerid][pRadio][slotid] = 0;
		PlayerRadio[playerid][pRadioSlot][slotid] = 0;
        SavePlayerRadio(playerid);
		
		format(string, sizeof(string), "Napustili ste radio na slotu %d.", slotid);
		SendClientMessage(playerid, COLOR_RED, string);
	}
	if(!strcmp( choice, "set", true)) 
	{
		new channel, slotid;
		if(!PlayerRadio[playerid][pHasRadio]) 
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(sscanf(params, "s[16]ii", choice, channel, slotid))
			return SendClientMessage(playerid, COLOR_RED, "[?]: /channel set [frekvencija][slot]");
		if(channel < 1 || channel > 100000)
			return SendClientMessage(playerid, COLOR_RED, "Samo kanali izmedju 1 - 100000 su podrzani.");
		if(slotid < 1 || slotid > 3)
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");
		if(PlayerRadio[playerid][pRadio][1] == channel || PlayerRadio[playerid][pRadio][2] == channel || PlayerRadio[playerid][pRadio][3] == channel)  
			return SendClientMessage(playerid, COLOR_RED, "[!] Jedan od vasih slotova vec je na tom kanalu.");
		if(!IsACop(playerid) && (channel == 911 || channel == 9030 || channel == 9040))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
		if(!IsASD(playerid) && (channel == 999 || channel == 9930 || channel == 9940))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
		if(!IsFDMember(playerid) && (channel == 471 || channel == 4030 || channel == 4040))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
		if(!IsAGov(playerid) && (channel == 651))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
		if(!IsANews(playerid) && (channel == 340))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
		if(!IsAFM(playerid) && (channel == 770))
			return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");

		PlayerRadio[playerid][pRadio][slotid] = channel;
		PlayerRadio[playerid][pRadioSlot][slotid] = slotid;
        SavePlayerRadio(playerid);

		va_SendClientMessage(playerid, COLOR_RED, "[!] Sada cete slusati kanal broj %d pod slotom %d.", channel, slotid);
	}
	if(!strcmp( choice, "playerfreq", true)) 
	{
		new giveplayerid;
		if(PlayerInfo[playerid][pAdmin] < 3) 
			return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
		if(sscanf(params, "s[16]u", choice, giveplayerid))
			return SendClientMessage(playerid, COLOR_RED, "[?]: /channel playerfreq [playerid]");

		if(giveplayerid == INVALID_PLAYER_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi ID igraca!");
		if(!Player_SafeSpawned(giveplayerid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Igrac %s se nalazi na frekvencijama %d, %d, %d.",
			GetName(giveplayerid, false),
			PlayerRadio[giveplayerid][pRadio][1],
			PlayerRadio[giveplayerid][pRadio][2],
			PlayerRadio[giveplayerid][pRadio][3]
		);
	}
	if(!strcmp( choice, "checkfreq", true)) 
	{
		new channel;
		if(PlayerInfo[playerid][pAdmin] < 3) 
			return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
		if(sscanf(params, "s[16]i", choice, channel))
			return SendClientMessage(playerid, COLOR_RED, "[?]: /channel checkfreq [frequency]");
		
		if(channel < 1 || channel > 100000)return SendClientMessage(playerid, COLOR_RED, "Pogresna frekvencija.");

		va_SendClientMessage(playerid, COLOR_RED, "Igraci na frekvenciji %d:", channel);
		foreach(new i : Player)
		{
			for(new x = 0; x < 3; x++) 
				if(PlayerRadio[i][pRadio][x] == channel)
					va_SendClientMessage(playerid, COLOR_GREY, "- %s [ID: %i]", GetName(i, false), i);
		}
	}
	return 1;
}