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
    ########  ######## ######## #### ##    ## ######## 
    ##     ## ##       ##        ##  ###   ## ##       
    ##     ## ##       ##        ##  ####  ## ##       
    ##     ## ######   ######    ##  ## ## ## ######   
    ##     ## ##       ##        ##  ##  #### ##       
    ##     ## ##       ##        ##  ##   ### ##       
    ########  ######## ##       #### ##    ## ######## 
*/

#define MAX_NEWS_LINES                  (5)
#define MAX_NEWS_STR_SIZE               (97)


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
    bool:blockedLive[MAX_PLAYERS],
    bool:blockedNews[MAX_PLAYERS],
    bool:OnLive[MAX_PLAYERS],
    NewsText[MAX_NEWS_LINES][MAX_NEWS_STR_SIZE],
    Text:NewsLineTextDraw[MAX_NEWS_LINES],
    NewsLineNumber      = 0,
    SendNewsT           = 0,
    NoNews              = 0;


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_OnAirBlocked(playerid)
{
    return blockedLive[playerid];
}


stock bool:Player_IsOnAir(playerid)
{
    return OnLive[playerid];
}

stock Player_SetIsOnAir(playerid, bool:v)
{
    OnLive[playerid] = v;
}

stock NewsLineCheck()
{
    if(NewsLineNumber > 0)
    {
        if(++NoNews >= 60)
        {
            ClearNews();
            NoNews = 0;
        }
    }
}

stock SendNews(string[])
{
    if(NewsLineNumber < 5)
    {
        NewsLineNumber++;
    }
    else
    {
        return 0;
    }

    for (new i = MAX_NEWS_LINES-1; i > 0; i--)
    {
        TextDrawSetString(NewsLineTextDraw[i], NewsText[i-1]);
        strmid(NewsText[i], NewsText[i-1], 0, strlen(NewsText[i-1]), MAX_NEWS_STR_SIZE);
    }
    TextDrawSetString(NewsLineTextDraw[0], string);
    strmid(NewsText[0], string, 0, strlen(string), MAX_NEWS_STR_SIZE);
    // TODO: never use strmid unless neccessary. Use strcpy or others
    return 1;
}

stock SendWalkieTalkieMessage(member, color, sstring[])
{
    foreach (new i : Player)
    {
        if(PlayerFaction[i][pMember] == member)
        {
            SendClientMessage(i, color, sstring);
            PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
        }
    }
}

stock ClearNews()
{
    if((NewsLineNumber - 1) < 0)
    {
        return 0;
    }

    NewsLineNumber--;
    TextDrawSetString(NewsLineTextDraw[NewsLineNumber], "\n");
    format(NewsText[NewsLineNumber], MAX_NEWS_STR_SIZE, "\n"); // TODO: strcpy
    return 1;
}

stock CreateNewsTextDraws()
{
    for (new i = 0; i < MAX_NEWS_LINES; i++)
    {
        format(NewsText[i], MAX_NEWS_STR_SIZE, "\n"); // TODO: strcpy
        NewsLineTextDraw[i] = TextDrawCreate(340.0, 415.0 - (i * 11), NewsText[i]);

        TextDrawLetterSize(NewsLineTextDraw[i], 0.249, 1.040);
        TextDrawFont(NewsLineTextDraw[i], 1);
        TextDrawSetShadow(NewsLineTextDraw[i], 0);
        TextDrawSetOutline(NewsLineTextDraw[i], 1);
        TextDrawSetProportional(NewsLineTextDraw[i], 1);
        TextDrawAlignment(NewsLineTextDraw[i], 2);
    }
}


/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

hook OnPlayerSpawn(playerid)
{
    if(IsANewUser(playerid))
    {
        return 1;
    }

    for (new i = 0; i < MAX_NEWS_LINES; i++)
    {
        TextDrawShowForPlayer(playerid, NewsLineTextDraw[i]);
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    new lineIndex = Player_PhoneLine(playerid);
    if(lineIndex != -1)
    {
        NewsPhone[lineIndex][npNumber]   = 0;
        NewsPhone[lineIndex][npPlayerID] = -1;
        Player_SetPhoneLine(playerid, -1);
    }
    blockedLive[playerid] = false;
    blockedNews[playerid] = false;
    OnLive[playerid] = false;
	return continue(playerid);
}

hook OnPlayerConnect(playerid)
{
    // garaza LSN by L3o
    RemoveBuildingForPlayer(playerid, 1294, 1380.5938, -1145.6406, 27.3359, 0.25);
    return 1;
}

hook OnGameModeInit()
{
    CreateNewsTextDraws();

    // LSN garaza - novo - by L3o
    CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 8, -1, -1, 100.00); // world 8
    CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 8, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 8, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 8, -1, -1, 100.00);

    // garaza LSN by L3o
    CreateDynamicObject(9093, 1379.02710, -1159.67566, 24.54300,   0.00000, 0.00000, 90.10710);

    // Pickup
    CreateDynamicPickup(19133, 2, 284.846497, -1540.948486, 24.596806, 8, -1, -1, 80.0); // garaza
    return 1;
}


/*
    ######## #### ##     ## ######## ########   ######  
       ##     ##  ###   ### ##       ##     ## ##    ## 
       ##     ##  #### #### ##       ##     ## ##       
       ##     ##  ## ### ## ######   ########   ######  
       ##     ##  ##     ## ##       ##   ##         ## 
       ##     ##  ##     ## ##       ##    ##  ##    ## 
       ##    #### ##     ## ######## ##     ##  ######  
*/

task NewsLineTask[1000]()
{
    NewsLineCheck();
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

CMD:toglive(playerid, params[])
{
	new
		bool:status = !blockedLive[playerid];
    
    blockedLive[playerid] = status;

	va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "%s si News Live chat!", 
		(status) ? ("Ukljucio") : ("Iskljucio")
	);
	return 1;
}

CMD:mic(playerid, params[])
{
	if(!Player_IsOnAir(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not LIVE in News!");
        
    foreach(new i: Player)
    {
        if(blockedLive[i])
            continue;

        va_SendClientMessage(i, 
            COLOR_ORANGE, 
            "** %s (LIVE) %s: %s", 
            IsANews(playerid) ? ("REPORTER") : ("GUEST"), 
            GetName(playerid), 
            params
       );
    }
	return 1;
}

CMD:lsncamera(playerid, params[])
{
    if(!IsANews(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
    if(AC_GetPlayerWeapon(playerid) == WEAPON_CAMERA) return SendClientMessage(playerid, COLOR_RED, "[ANTI-BAN]: Vec imate kameru u rukama!");
    if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti izvan vozila!");
    if(VehicleInfo[GetPlayerVehicleID(playerid)][vUsage] != VEHICLE_USAGE_FACTION)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u LSN vozilu!");

    AC_GivePlayerWeapon(playerid, WEAPON_CAMERA, 50);
    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dobili ste kameru sa 50 bliceva u njoj!");
    return 1;
}

CMD:live(playerid, params[])
{
    if(!IsANews(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
    new giveplayerid, playerName[MAX_PLAYER_NAME], newsName[MAX_PLAYER_NAME];
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "[?]: /live [playerid / Part of name]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi ste ID unijeli!");

    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    GetPlayerName(giveplayerid, newsName, MAX_PLAYER_NAME);

    if(OnLive[giveplayerid])
    {
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Skinuli ste dozvolu gostu %s za pricanje u eter.", playerName);
        va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: Izgubili ste dozvolu za govor u eteru od novinara %s!", newsName);
    }
    else
    {
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Dali ste dozvolu gostu %s za ulazak u eter. Da skines dozvolu koristi /live.", playerName);
        va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: Dobili ste dozvolu za govor u eteru od novinara %s!", newsName);
    }
    OnLive[giveplayerid] = !OnLive[giveplayerid];
    return 1;
}

CMD:news(playerid, params[])
{
    if(!IsANews(playerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste novinar!");
        return 1;
    }
    new vehicleid = GetPlayerVehicleID(playerid);
    // TODO: if(IsInNewsVehicle(playerid) && IsAtNewsStudio(playyerid))
    if(GetVehicleModel(vehicleid) != 582 && GetVehicleModel(vehicleid) != 488 &&
        !IsPlayerInRangeOfPoint(playerid, 10.0, 1409.6332,-1195.5559,88.4888))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu ili unutar studija!");
        return 1;
    }
    if(SendNewsT > gettimestamp()) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati 5 sekundi!");
    if(!IsSafeForTextDraw(params)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Upisani tekst nije prikladan za news!");
    new text_len = strlen(params);
    if(text_len < 1 || text_len > 64) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan unos rijeci (1-64)!");

    new message[128];
    format(message, sizeof(message), "~y~%s: ~w~%s", GetName(playerid, false), params);
    if(!SendNews(message)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte da se tekst obrise!");

    BudgetToFactionMoney(FACTION_TYPE_NEWS, 100); // dobivaju novac iz proracuna
    SendNewsT = gettimestamp() + 5;
    return 1;
}

CMD:tognews(playerid, params[])
{
    blockedNews[playerid] = !blockedNews[playerid];
    if(blockedNews[playerid])
    {
        // TODO: ShowNewsTextForPlayer(playerid)
        for (new i = 0; i < 5; i++)
        {
            TextDrawShowForPlayer(playerid, NewsLineTextDraw[i]);
        }
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Ukljucio si vidljivost LSN-a!");
    }
    else
    {
        // TODO: HideNewsTextForPlayer(playerid)
        for (new i = 0; i < 5; i++)
        {
            TextDrawHideForPlayer(playerid, NewsLineTextDraw[i]);
        }
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Iskljucio si vidljivost LSN-a!");
    }
    return 1;
}

CMD:lsnup(playerid, params[])
{
    if(!IsANews(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1431.0470, -1183.8474, 88.4837)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu ulaza u hodnik!");

    SetPlayerPosEx(playerid, 1401.2340, -1187.0062, 187.2153, 0, 0, false);
    return 1;
}

CMD:lsndown(playerid, params[])
{
    if(!IsANews(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1401.2340, -1187.0062, 187.2153)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu ulaza u hodnik!");

    SetPlayerPosEx(playerid, 1431.0470, -1183.8474, 88.4837, 0, 0, false);
    return 1;
}

CMD:reset_news(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4 && PlayerFaction[playerid][pLeader] != 5)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Leader/Admin Lvl 4+!");
        return 1;
    }
    // TODO: ClearNewsText(playerid)
    for (new i = 0; i < 5; i++)
    {
        TextDrawSetString(NewsLineTextDraw[i], "\n");
        format(NewsText[i], 97, "\n"); // TODO: strcpy
    }
    NewsLineNumber = 0;
    return 1;
}

CMD:callnews(playerid,params[])
{
    if(!PlayerMobile[playerid][pMobileNumber]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate mobitel!");
    if(PlayerMobile[playerid][pMobileCost] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate novca na mobitelnom racunu da biste pozvali taxi!");

    new string[256], result[128];
    if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /callnews [opis stanja]");

    format(string, sizeof(string), "** [REDAKCIJA - POZIV] Mobitel broj: %d - Stanje: %s",
        PlayerMobile[playerid][pMobileNumber],
        result
   );
    SendWalkieTalkieMessage(5, 0x42C8F5FF, string);

    format(string, sizeof(string), "* %s vadi mobitel i stavlja ga na uho.", GetName(playerid));
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 5000);
    SendClientMessage(playerid, COLOR_YELLOW, "* Poslao si poziv u LSN ured!");

    PlayerMobile[playerid][pMobileCost] -= 3;

    mysql_fquery(SQL_Handle(), "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
        PlayerMobile[playerid][pMobileCost],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

CMD:lsngarage(playerid, params[])
{
    if(!IsANews(playerid))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");

    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1378.6362, -1155.7634, 23.8321) && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 284.8465,-1540.9485,24.5968, 8, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 287.2799, -1537.8717, 24.5278);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 8);
                }
            }

            SetPlayerVirtualWorld(playerid, 8);
            SetVehicleVirtualWorld(vehicleid, 8);
            SetVehicleZAngle(vehicleid, 325.2156);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 10.0, 284.8465, -1540.9485, 24.5968) && GetPlayerVirtualWorld(playerid) == 8)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 1378.6362, -1155.7634, 23.8321, 0, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 1379.3405, -1150.7832, 23.7682);
            SetVehicleVirtualWorld(vehicleid, 0);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleZAngle(vehicleid, 358.9041);
        }
    }
    return 1;
}

