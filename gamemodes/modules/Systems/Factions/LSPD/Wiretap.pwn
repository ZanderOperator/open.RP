#if defined MODULE_LSPD_WIRETAP
    #endinput
#endif
#define MODULE_LSPD_WIRETAP

/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>

/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static
    Float:ListeningDevicePos     [MAX_PLAYERS][3],
    bool:HasListeningDevice      [MAX_PLAYERS] = {false, ...},
    bool:HasPlacedListeningDevice[MAX_PLAYERS] = {false, ...},
    ListeningDeviceMode          [MAX_PLAYERS],

    TappedBy          [MAX_PLAYERS] = {INVALID_PLAYER_ID, ...},
    bool:TappingCall  [MAX_PLAYERS] = {false, ...},
    bool:TappingSMS   [MAX_PLAYERS] = {false, ...},
    bool:TracingNumber[MAX_PLAYERS] = {false, ...},
    Timer:TracingNumberTimer[MAX_PLAYERS],
    TracingNumberZone [MAX_PLAYERS] = {-1, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_HasListeningDevice(playerid)
{
    return HasListeningDevice[playerid];
}

stock Player_SetHasListeningDevice(playerid, bool:v)
{
    HasListeningDevice[playerid] = v;
}

stock bool:Player_PlacedListeningDevice(playerid)
{
    return HasPlacedListeningDevice[playerid];
}

stock Player_SetPlacedListeningDevice(playerid, bool:v)
{
    HasPlacedListeningDevice[playerid] = v;
}

stock Player_ListeningDeviceMode(playerid)
{
    return ListeningDeviceMode[playerid];
}

stock Player_SetListeningDeviceMode(playerid, v)
{
    ListeningDeviceMode[playerid] = v;
}

stock Player_TappedBy(playerid)
{
    return TappedBy[playerid];
}

stock Player_SetTappedBy(playerid, v)
{
    TappedBy[playerid] = v;
}

stock bool:Player_TappingCall(playerid)
{
    return TappingCall[playerid];
}

stock Player_SetTappingCall(playerid, bool:v)
{
    TappingCall[playerid] = v;
}

stock bool:Player_TappingSMS(playerid)
{
    return TappingSMS[playerid];
}

stock Player_SetTappingSMS(playerid, bool:v)
{
    TappingSMS[playerid] = v;
}

stock bool:Player_TracingNumber(playerid)
{
    return TracingNumber[playerid];
}

stock Player_SetTracingNumber(playerid, bool:v)
{
    TracingNumber[playerid] = v;
}

timer OnPlayerTracingNumber[5000](playerid, targetid, type)
{
    if(!Player_MobileOn(targetid))
    {
        stop TracingNumberTimer[playerid];
        GangZoneDestroy(TracingNumberZone[playerid]);
        Player_SetTracingNumber(playerid, false);

        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mobitel je ugasen!");
        return 1;
    }

    switch (type)
    {
        case 1:
        {
            va_SendClientMessage(playerid, COLOR_RED, "[UREDJAJ]: Trazeni broj se nalazi na lokaciji %s. Zapocinjem detaljniji pregled koji ce zahtjevati vise vremena!", GetPlayerStreet(targetid));
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prekid kucajte /tracenumber.");
            TracingNumberTimer[playerid] = defer OnPlayerTracingNumber[30000 + random(1000)](playerid, targetid, 2);
        }
        case 2:
        {
            new
                Float:X, Float:Y, Float:Z;
            GetPlayerPos(targetid, X, Y, Z);
            TracingNumberZone[playerid] = CreateGangZoneAroundPoint(X, Y, 250.0, 250.0);
            GangZoneShowForPlayer(playerid, TracingNumberZone[playerid], COLOR_YELLOW);

            SendClientMessage(playerid, COLOR_RED, "[UREDJAJ] Lokacija broja je prikazana na GPSu. Zapocinjem detaljniji pregled koji ce zahtjevati vise vremena!");
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prekid kucajte /tracenumber.");
            TracingNumberTimer[playerid] = defer OnPlayerTracingNumber[60000 + random(1000)](playerid, targetid, 3);
        }
        case 3:
        {
            new
                Float:X, Float:Y, Float:Z;
            GetPlayerPos(targetid, X, Y, Z);

            GangZoneDestroy(TracingNumberZone[playerid]);
            TracingNumberZone[playerid] = CreateGangZoneAroundPoint(X, Y, 125.0, 125.0);
            GangZoneShowForPlayer(playerid, TracingNumberZone[playerid], COLOR_YELLOW);

            SendClientMessage(playerid, COLOR_RED, "[UREDJAJ] Lokacija broja je prikazana na GPSu. Zapocinjem detaljniji pregled koji ce zahtjevati vise vremena!");
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prekid kucajte /tracenumber.");
            TracingNumberTimer[playerid] = defer OnPlayerTracingNumber[100000 + random(1000)](playerid, targetid, 4);
        }
        case 4:
        {
            new
                Float:X, Float:Y, Float:Z;
            GetPlayerPos(targetid, X, Y, Z);

            GangZoneDestroy(TracingNumberZone[playerid]);
            TracingNumberZone[playerid] = CreateGangZoneAroundPoint(X, Y, 60.0, 60.0);
            GangZoneShowForPlayer(playerid, TracingNumberZone[playerid], COLOR_YELLOW);

            SendClientMessage(playerid, COLOR_RED, "[UREDJAJ] Lokacija broja je prikazana na GPSu. Zapocinjem detaljniji pregled koji ce zahtjevati vise vremena!");
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prekid kucajte /tracenumber.");
            TracingNumberTimer[playerid] = defer OnPlayerTracingNumber[120000 + random(1000)](playerid, targetid, 2);
        }
    }
    return 1;
}

/*
     ######  ##     ## ########
    ##    ## ###   ### ##     ##
    ##       #### #### ##     ##
    ##       ## ### ## ##     ##
    ##       ##     ## ##     ##
    ##    ## ##     ## ##     ##
     ######  ##     ## ########
*/

CMD:tap(playerid, params[])
{
    if(!IsACop(playerid) && PlayerFaction[playerid][pRank] < 2) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac rank 2+.");

    new
        string[80],
        param[7];
    if(sscanf( params, "s[7] ", param))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /tap [odabir]");
        SendClientMessage(playerid, COLOR_RED, "[!] buy - take - place - listen");
        return 1;
    }
    if(!strcmp(param, "buy", true))
    {
        if(!IsPlayerInRangeOfPoint(playerid, 10.0, 2037.5465,1256.3229,-11.1115)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u policijskoj stanici!"); //PD LOCKER
        if(Player_HasListeningDevice(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate uredaj za prisluskivanje!");

        Player_SetHasListeningDevice(playerid, true);

        format(string, sizeof(string), "* %s uzima uredjaj s police.", GetName(playerid, true));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    else if(!strcmp(param, "place", true))
    {
        if(!Player_HasListeningDevice(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uredaj za prisluskivanje!");

        GetPlayerPos(playerid, ListeningDevicePos[playerid][0], ListeningDevicePos[playerid][1], ListeningDevicePos[playerid][2]);
        Player_SetHasListeningDevice(playerid, false);
        Player_SetPlacedListeningDevice(playerid, true);

        format(string, sizeof(string), "* %s se saginje i nesto postavlja blizu sebe.", GetName(playerid, true));
        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
        SendClientMessage(playerid, COLOR_PURPLE, string);
    }
    else if(!strcmp(param, "take", true))
    {
        if(!IsPlayerInRangeOfPoint(playerid, 5.0, ListeningDevicePos[playerid][0], ListeningDevicePos[playerid][1], ListeningDevicePos[playerid][2])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog uredaja za prisluskivanje!");

        ListeningDevicePos[playerid][0] = 0.0;
        ListeningDevicePos[playerid][1] = 0.0;
        ListeningDevicePos[playerid][2] = 0.0;
        Player_SetHasListeningDevice      (playerid, true);
        Player_SetPlacedListeningDevice(playerid, false);

        format(string, sizeof(string), "* %s se saginje i uzima nesto blizu sebe.", GetName(playerid, true));
        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
        SendClientMessage(playerid, COLOR_PURPLE, string);
    }
    else if(!strcmp(param, "listen", true))
    {
        new type;
        if(sscanf(params, "s[7]i", param, type)) return SendClientMessage(playerid, COLOR_RED, "[?]: /tap listen [1 - samostalno/2 - zvucnik]");
        if(1 <= type <= 2) return SendClientMessage(playerid, COLOR_RED, "[?]: /tap listen [1 - samostalno/2 - zvucnik]");

        SendMessage(playerid, MESSAGE_TYPE_INFO, "Sada cete cuti sve razgovore koji se vode oko vaseg uredaja!");
        Player_SetListeningDeviceMode(playerid, type);
    }
    return 1;
}

CMD:wiretap(playerid, params[])
{
    new faction = PlayerFaction[playerid][pMember];
    if(faction == -1) return 1;
    if(!IsACop(playerid) && PlayerFaction[playerid][pRank] < FactionInfo[faction][rLstnNumber])
    {
        SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac r%d+!", FactionInfo[faction][rLstnNumber]);
        return 1;
    }

    if(Player_TappingCall(playerid))
    {
        foreach(new gplayerid : Player)
        {
            if(Player_TappedBy(gplayerid) == playerid)
            {
                Player_SetTappedBy(gplayerid, INVALID_PLAYER_ID);
                break;
            }
        }
        Player_SetTappingCall(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prestali ste prisluskivati mobitel!");
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 5.0, -1194.4789,-1649.6088,900.7064) &&
        !IsPlayerInRangeOfPoint(playerid, 5.0, 2845.8594,-846.8279,-21.6994) &&
        !IsPlayerInRangeOfPoint(playerid, 5.0, 1907.0248,627.1588,-14.942))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u policijskoj stanici!");
        return 1;
    }
    new
        number,
        string[8];

    if(sscanf(params, "i", number)) return SendClientMessage(playerid, COLOR_RED, "[?]: /listennumber [broj mobitela]");

    valstr(string, number);
    if(strlen(string) != 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unesite broj mobitela!");

    foreach(new gplayerid : Player)
    {
        if(PlayerMobile[gplayerid][pMobileNumber] == number)
        {
            if(Player_TappedBy(gplayerid) != INVALID_PLAYER_ID)
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Netko vec prisluskuje taj broj!");
                return 1;
            }
            Player_SetTappedBy(gplayerid, playerid);
            Player_SetTappingCall(playerid, true);
            Player_SetTappingSMS(playerid, true);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Poceli ste prisluskivati %d.", number);
            return 1;
        }
    }
    SendMessage(playerid, MESSAGE_TYPE_ERROR, "Broj nije u bazi podataka!");
    return 1;
}

CMD:tracenumber(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni.");

    if(Player_TracingNumber(playerid))
    {
        stop TracingNumberTimer[playerid];
        GangZoneDestroy(TracingNumberZone[playerid]);
        Player_SetTracingNumber(playerid, false);

        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prekinuli ste potragu za brojem!");
        return 1;
    }

    new vehmodelid = GetVehicleModel(GetPlayerVehicleID(playerid));
    if(GetPlayerVehicleID(playerid) == INVALID_VEHICLE_ID ||
        vehmodelid != 596 ||
        vehmodelid != 597 ||
        vehmodelid != 598 ||
        vehmodelid != 599 ||
        vehmodelid != 490 ||
        vehmodelid != 497 ||
        vehmodelid != 426 ||
        vehmodelid != 560)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar sluzbenog vozila!");
        return 1;
    }

    new
        number,
        string[8];
    if(sscanf(params, "i", number)) return SendClientMessage(playerid, COLOR_RED, "[?]: /tracenumber [broj mobitela]");
    valstr(string, number);
    if(strlen(string) != 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unesite broj mobitela!");

    foreach(new gplayerid : Player)
    {
        if(PlayerMobile[gplayerid][pMobileNumber] == number)
        {
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Poceli ste s trazenjem lokacije broja %d.", number);

            TracingNumberTimer[playerid] = defer OnPlayerTracingNumber[8000 + random(900)](playerid, gplayerid, 1);
            Player_SetTracingNumber(playerid, true);
            return 1;
        }
    }
    return 1;
}


/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

// Gets called under OnPlayerDisconnect etc
hook function ResetPlayerVariables(playerid)
{
    // Bug device / Mole
    Player_SetHasListeningDevice   (playerid, false);
    Player_SetPlacedListeningDevice(playerid, false);
    Player_SetListeningDeviceMode  (playerid, 0);

    ListeningDevicePos[playerid][0] = 0.0;
    ListeningDevicePos[playerid][1] = 0.0;
    ListeningDevicePos[playerid][2] = 0.0;

    // Wiretap
    if(Player_TappedBy(playerid) != INVALID_PLAYER_ID)
        SendClientMessage(Player_TappedBy(playerid), COLOR_RED, "[!]: Line is busy (( Player is offline))!");
    
    Player_SetTappedBy(playerid, INVALID_PLAYER_ID);
    Player_SetTappingCall(playerid, false);
    Player_SetTappingSMS(playerid, false);

    // Cellphone GPS tracking
    if(Player_TracingNumber(playerid))
    {
        stop TracingNumberTimer[playerid];
        GangZoneDestroy(TracingNumberZone[playerid]);
        Player_SetTracingNumber(playerid, false);
        TracingNumberZone [playerid] = -1;
    }
	return continue(playerid);
}

hook OnPlayerText(playerid, text[])
{
    new string[144];
    foreach(new i : Player)
    {
        if(Player_PlacedListeningDevice(i) &&
            IsPlayerInRangeOfPoint(playerid, 10.0, ListeningDevicePos[i][0], ListeningDevicePos[i][1], ListeningDevicePos[i][2]))
        {
            format(string, sizeof(string), "[DEVICE] %s: %s", GetName(playerid), text);

            new mode = Player_ListeningDeviceMode(playerid);
            if(mode == 1)
            {
                SendClientMessage(i, COLOR_YELLOW, string);
            }
            else if(mode == 2)
            {
                RealProxDetector(8.0, i, string, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW);
            }
            return 1;
        }
    }
    return 0;
}
