
#include <YSI_Coding\y_hooks>

CMD:radio(playerid, params[])
{
	if (!PlayerRadio[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new 
		string[144],
		radioChan = PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if (PlayerRadio[i][pRadio][s] == radioChan && PlayerRadio[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
			{
				format(string, 144, "**[CH: %d, S: %d] %s kaze: %s", 
					PlayerRadio[i][pRadio][s], 
					GetChannelSlot(i, radioChan), 
					GetName(playerid, true), 
					params
				);
				if (s != PlayerRadio[i][pMainSlot])
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
	if (!PlayerRadio[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
	
	if(!PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new string[144], radioChan = PlayerRadio[playerid][pRadio][PlayerRadio[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if (PlayerRadio[i][pRadio][s] == radioChan && PlayerRadio[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
			{
				format (string, 144, "**[CH: %d, S: %d] %s kaze: %s", 
					PlayerRadio[i][pRadio][s], 
					GetChannelSlot(i, radioChan), 
					GetName(playerid, true), 
					params
				);
				if (s != PlayerRadio[i][pMainSlot])
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
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	if(!PlayerRadio[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerRadio[playerid][pRadio][2])return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /r2 [radio text]");

	new chan;
	chan = PlayerRadio[playerid][pRadio][2];

	foreach(new i : Player)
	{
		for(new r = 0; r < 4; r++)
		{
			if(PlayerRadio[i][pRadio][r] == PlayerRadio[playerid][pRadio][2] && PlayerRadio[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
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
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	if(!PlayerRadio[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerRadio[playerid][pRadio][3])return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /r3 [radio text]");

	new chan;
	chan = PlayerRadio[playerid][pRadio][3];

	foreach(new i : Player)
	{
		for(new r = 0; r < 4; r++)
		{
			if(PlayerRadio[i][pRadio][r] == PlayerRadio[playerid][pRadio][3] && PlayerRadio[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
			{
				if(r != PlayerRadio[i][pMainSlot])
				{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerRadio[playerid][pRadio][3], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else{
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
	if( !Bit1_Get(gr_PlayerRadio, playerid))
	{
		Bit1_Set(gr_PlayerRadio, playerid, true);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste radio!");
	} else {
		Bit1_Set(gr_PlayerRadio, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "[ ! ] Iskljucili ste radio!");
	}
    return 1;
}

CMD:channel(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	if(strlen(params) >= 16)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Opcija ne smije imati vise od 16 znakova!");
	new choice[16];
	if(sscanf(params, "s[16] ", choice)) 
	{
		SendClientMessage(playerid, -1, "[ ? ]: /channel [opcija]");
		SendClientMessage(playerid, -1, "[ ? ] OPCIJE: setslot, leave, set, playerfreq, checkfreq");
		return 1;
	}
	if( !strcmp( choice, "setslot", true ) ) 
	{
		new string[128], slotid;
		if(!PlayerRadio[playerid][pHasRadio])
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(sscanf(params, "s[16]i", choice, slotid))
			return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /channel setslot [slotid]");
		if(slotid < 1 || slotid > 3)
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");

		format(string, sizeof(string), "Lokalni kanal setovan na slot %d!", slotid);
		SendClientMessage(playerid, COLOR_RED, string);
		
		PlayerRadio[playerid][pMainSlot] = slotid;
        SavePlayerRadio(playerid);
	}
	if( !strcmp( choice, "leave", true ) ) 
	{
		new string[128], slotid;
		if(!PlayerRadio[playerid][pHasRadio]) 
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(!Bit1_Get(gr_PlayerRadio, playerid))
			return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
		if(sscanf(params, "s[16]i", choice, slotid)) 
			return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /channel leave [slotid]");
		if(slotid < 1 || slotid > 3) 
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-5.");

		PlayerRadio[playerid][pRadio][slotid] = 0;
		PlayerRadio[playerid][pRadioSlot][slotid] = 0;
        SavePlayerRadio(playerid);
		
		format(string, sizeof(string), "Napustili ste radio na slotu %d.", slotid);
		SendClientMessage(playerid, COLOR_RED, string);
	}
	if( !strcmp( choice, "set", true ) ) 
	{
		new channel, slotid;
		if(!PlayerRadio[playerid][pHasRadio]) 
			return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
		if(sscanf(params, "s[16]ii", choice, channel, slotid))
			return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /channel set [frekvencija][slot]");
		if(channel < 1 || channel > 100000)
			return SendClientMessage(playerid, COLOR_RED, "Samo kanali izmedju 1 - 100000 su podrzani.");
		if(slotid < 1 || slotid > 3)
			return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");
		if(PlayerRadio[playerid][pRadio][1] == channel || PlayerRadio[playerid][pRadio][2] == channel || PlayerRadio[playerid][pRadio][3] == channel)  
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Jedan od vasih slotova vec je na tom kanalu.");
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

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Sada cete slusati kanal broj %d pod slotom %d.", channel, slotid);
	}
	if( !strcmp( choice, "playerfreq", true ) ) 
	{
		new giveplayerid;
		if (PlayerInfo[playerid][pAdmin] < 3) 
			return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
		if(sscanf(params, "s[16]u", choice, giveplayerid))
			return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /channel playerfreq [playerid]");

		if(giveplayerid == INVALID_PLAYER_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi ID igraca!");
		if(!SafeSpawned[giveplayerid])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan!");

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac %s se nalazi na frekvencijama %d, %d, %d.",
			GetName(giveplayerid, false),
			PlayerRadio[giveplayerid][pRadio][1],
			PlayerRadio[giveplayerid][pRadio][2],
			PlayerRadio[giveplayerid][pRadio][3]
		);
	}
	if( !strcmp( choice, "checkfreq", true ) ) 
	{
		new channel;
		if (PlayerInfo[playerid][pAdmin] < 3) 
			return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
		if(sscanf(params, "s[16]i", choice, channel))
			return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /channel checkfreq [frequency]");
		
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