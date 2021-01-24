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
    ########  ######## ######## #### ##    ## ########  ######  
    ##     ## ##       ##        ##  ###   ## ##       ##    ## 
    ##     ## ##       ##        ##  ####  ## ##       ##       
    ##     ## ######   ######    ##  ## ## ## ######    ######  
    ##     ## ##       ##        ##  ##  #### ##             ## 
    ##     ## ##       ##        ##  ##   ### ##       ##    ## 
    ########  ######## ##       #### ##    ## ########  ######  
*/

#define MAX_RACING_CPS                  (15)
#define MAX_RACING_CONTESTERS           (5)
#define RACING_CP_SIZE                  6.5


/*
    ##     ##    ###    ########   ######  
    ##     ##   ## ##   ##     ## ##    ## 
    ##     ##  ##   ##  ##     ## ##       
    ##     ## ##     ## ########   ######  
     ##   ##  ######### ##   ##         ## 
      ## ##   ##     ## ##    ##  ##    ## 
       ###    ##     ## ##     ##  ######  
*/

enum E_RACING_DATA
{
    rdContesters[MAX_RACING_CONTESTERS],
    Float:rdPosX[MAX_RACING_CPS],
    Float:rdPosY[MAX_RACING_CPS],
    Float:rdPosZ[MAX_RACING_CPS],
    rdFinished[MAX_RACING_CONTESTERS],
    rdCounter,
    bool:rdStarted,
    rdEndCP,
    Timer:rdTimer,
    rdFnsdRacers
}
static
    RacingInfo[MAX_PLAYERS][E_RACING_DATA];

static
    RacingDialogID  [MAX_PLAYERS],
    RaceAuthor      [MAX_PLAYERS],
    RacingCallID    [MAX_PLAYERS],
    RacerSlot       [MAX_PLAYERS],
    CurrentRaceCP   [MAX_PLAYERS],
    bool:InRace     [MAX_PLAYERS],
    bool:RaceCreated[MAX_PLAYERS];

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

static stock GetFreeRacingCPSlot(playerid)
{
    new index = -1;
    for (new i = 0; i < MAX_RACING_CPS; i++)
    {
        if(RacingInfo[playerid][rdPosX][i] == 0.0)
        {
            index = i;
            break;
        }
    }
    return index;
}

static stock GetLastRacingCPSlot(playerid)
{
    new index = 0;
    for (new i = 0; i < MAX_RACING_CPS; i++)
    {
        if(RacingInfo[playerid][rdPosX][i] != 0.0)
        {
            index = i;
            break;
        }
    }
    return index;
}

static stock GetContestantFromPool(playerid)
{
    new index = -1;
    for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
    {
        if(RacingInfo[playerid][rdContesters][i] == -1)
        {
            index = i;
            break;
        }
    }
    return index;
}

static stock GetTotalContesters(playerid)
{
    new count = -1;
    for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
    {
        if(RacingInfo[playerid][rdContesters][i] != -1)
        {
            count++;
        }
    }
    return count;
}

static stock GetRacingCpPool(playerid)
{
    new count = 0;
    for (new i = 0; i < MAX_RACING_CPS; i++)
    {
        if(RacingInfo[playerid][rdPosX][i] != 0.0)
        {
            count++;
        }
    }
    return count;
}

static stock SendRacingMessage(playerid, const message[])
{
    for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
    {
        new racer = RacingInfo[playerid][rdContesters][i];
        if(racer != -1 && InRace[racer])
        {
            SendClientMessage(racer, COLOR_YELLOW, message);
        }
    }
    return 1;
}

static stock CreateRacingCP(playerid, Float:x, Float:y, Float:z)
{
    if(!IsPlayerConnected(playerid))
    {
        return -1;
    }

    new index = GetFreeRacingCPSlot(playerid);
    RacingInfo[playerid][rdPosX][index] = x;
    RacingInfo[playerid][rdPosY][index] = y;
    RacingInfo[playerid][rdPosZ][index] = z;
    return index;
}

static stock CallRaceContestant(playerid, giveplayerid)
{
    if(!IsPlayerConnected(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste se spojili na server!");
    if(!IsPlayerConnected(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pozvani igrac nije na serveru!");

    new index = GetContestantFromPool(playerid);
    if(index == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise zvati igrace na svoju utrku!");

    RacingCallID[giveplayerid] = playerid;
    va_ShowPlayerDialog(giveplayerid, DIALOG_RACE_CALL, DIALOG_STYLE_MSGBOX, "RACING SYSTEM", "%s te poziva da dodjes u njegovu utrku. Zelite li uci?", "Yes", "No", GetName(playerid, false));
    return 1;
}

static stock StartPlayerRace(playerid)
{
    InRace    [playerid]            = true;
    RacingInfo[playerid][rdStarted] = true;
    RacingInfo[playerid][rdEndCP]   = GetLastRacingCPSlot(playerid);
    RaceAuthor[playerid]            = playerid;
    RacerSlot [playerid]            = 0;
    RacingInfo[playerid][rdCounter] = 5;
    RacingInfo[playerid][rdFnsdRacers] = 0;

    for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
    {
        new racer = RacingInfo[playerid][rdContesters][i];
        if(racer == -1) continue;

        va_GameTextForPlayer(racer, "~y~%d", 1000, 4, RacingInfo[playerid][rdCounter]);
        PlayerPlaySound(racer, 1056, 0.0, 0.0, 0.0);
        TogglePlayerAllDynamicCPs(racer, false);
    }
    RacingInfo[playerid][rdTimer] = repeat RacingCounter(playerid);
    return 1;
}

static stock ResetPlayerRaceCP(playerid, index)
{
    RacingInfo[playerid][rdPosX][index] = 0.0;
    RacingInfo[playerid][rdPosY][index] = 0.0;
    RacingInfo[playerid][rdPosZ][index] = 0.0;
}

stock ResetPlayerRace(playerid, bool:reset=false)
{
    RacingInfo[playerid][rdContesters][0] = -1;
    RacingInfo[playerid][rdContesters][1] = -1;
    RacingInfo[playerid][rdContesters][2] = -1;
    RacingInfo[playerid][rdContesters][3] = -1;

    RacingInfo[playerid][rdFinished][0]   = -1;
    RacingInfo[playerid][rdFinished][1]   = -1;
    RacingInfo[playerid][rdFinished][2]   = -1;
    RacingInfo[playerid][rdFinished][3]   = -1;

    RacingInfo[playerid][rdCounter]       = 0;
    RacingInfo[playerid][rdStarted]       = false;
    RacingInfo[playerid][rdFnsdRacers]    = 0;

    RaceCreated[playerid] = false;

    if(reset)
    {
        for (new i = 0; i < MAX_RACING_CPS; i++)
        {
            if(RacingInfo[playerid][rdPosX][i] != 0.0)
                ResetPlayerRaceCP(playerid, i);
        }
    }
}

stock ResetRacerVars(playerid)
{
    RacingDialogID[playerid] = -1;
    RaceAuthor    [playerid] = -1;
    RacingCallID  [playerid] = -1;
    RacerSlot     [playerid] = -1;
    CurrentRaceCP [playerid] = -1;
    InRace        [playerid] = false;
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

timer StopRacingSound[8000](playerid)
{
    PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
    return 1;
}

timer RacingCounter[1000](playerid)
{
    RacingInfo[playerid][rdCounter]--;
    if(RacingInfo[playerid][rdCounter] != 0)
    {
        for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
        {
            new racer = RacingInfo[playerid][rdContesters][i];
            if(racer == -1) continue;

            va_GameTextForPlayer(racer, "~y~%d", 1000, 4, RacingInfo[playerid][rdCounter]);
            PlayerPlaySound(racer, 1056, 0.0, 0.0, 0.0);
        }
    }
    else
    {
        RacingInfo[playerid][rdFinished][0] = -1;
        RacingInfo[playerid][rdFinished][1] = -1;
        RacingInfo[playerid][rdFinished][2] = -1;
        RacingInfo[playerid][rdFinished][3] = -1;

        for (new i = 0; i < MAX_RACING_CONTESTERS; i++)
        {
            new racer = RacingInfo[playerid][rdContesters][i];
            if(racer == -1) continue;

            GameTextForPlayer(racer, "~g~GO GO GO", 2500, 4);
            PlayerPlaySound(racer, 1057, 0.0, 0.0, 0.0);
            CurrentRaceCP[racer] = 0;
            SetPlayerRaceCheckpoint(racer, 0, RacingInfo[playerid][rdPosX][0], RacingInfo[playerid][rdPosY][0], RacingInfo[playerid][rdPosZ][0], RacingInfo[playerid][rdPosX][1], RacingInfo[playerid][rdPosY][1], RacingInfo[playerid][rdPosZ][1], RACING_CP_SIZE);
        }

        stop RacingInfo[playerid][rdTimer];
    }
    return 1;
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

hook OnPlayerDisconnect(playerid, reason)
{
    InRace[playerid] = false;

    if(RaceCreated[playerid])
    {
        SendRacingMessage(playerid, "[!] Trka je zavrsila!");
        ResetPlayerRace(playerid, true);
        ResetRacerVars(playerid);
    }
    return 1;
}

// TODO: OnPlayerDeath, end race for player...

hook OnPlayerEnterRaceCP(playerid)
{
    if(!InRace[playerid])
    {
        return 1;
    }

    new
        giveplayerid = RaceAuthor   [playerid],
        currentCP    = CurrentRaceCP[playerid];

    if(currentCP != RacingInfo[giveplayerid][rdEndCP])
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);

        currentCP++;
        if(currentCP == RacingInfo[giveplayerid][rdEndCP])
        {
            SetPlayerRaceCheckpoint(playerid, 1, RacingInfo[giveplayerid][rdPosX][currentCP], RacingInfo[giveplayerid][rdPosY][currentCP], RacingInfo[giveplayerid][rdPosZ][currentCP], 0.0, 0.0, 0.0, RACING_CP_SIZE);
        }
        else
        {
            SetPlayerRaceCheckpoint(playerid, 0, RacingInfo[giveplayerid][rdPosX][currentCP], RacingInfo[giveplayerid][rdPosY][currentCP], RacingInfo[giveplayerid][rdPosZ][currentCP], RacingInfo[giveplayerid][rdPosX][currentCP + 1], RacingInfo[giveplayerid][rdPosY][currentCP + 1], RacingInfo[giveplayerid][rdPosZ][currentCP + 1], RACING_CP_SIZE);
        }
        CurrentRaceCP[playerid] = currentCP;
    }
    else
    {
        printf("DEBUG: finish1(%d) | finish2(%d) | finish3(%d) | finish4(%d)", RacingInfo[giveplayerid][rdFinished][0], RacingInfo[giveplayerid][rdFinished][1], RacingInfo[giveplayerid][rdFinished][2], RacingInfo[giveplayerid][rdFinished][3]);

        // TODO: try and refactor this, reduce code duplication
        new string[54];
        if(RacingInfo[giveplayerid][rdFinished][0] == -1)
        {
            RacingInfo[giveplayerid][rdFinished][0] = playerid;

            format(string, sizeof(string), "[!] %s je zavrsio kao prvi!", GetName(playerid, false));
            SendRacingMessage(giveplayerid, string);
        }
        else if(RacingInfo[giveplayerid][rdFinished][1] == -1)
        {
            RacingInfo[giveplayerid][rdFinished][1] = playerid;

            format(string, sizeof(string), "[!] %s je zavrsio kao drugi!", GetName(playerid, false));
            SendRacingMessage(giveplayerid, string);
        }
        else if(RacingInfo[giveplayerid][rdFinished][2] == -1)
        {
            RacingInfo[giveplayerid][rdFinished][2] = playerid;

            format(string, sizeof(string), "[!] %s je zavrsio kao treci!", GetName(playerid, false));
            SendRacingMessage(giveplayerid, string);
        }
        else if(RacingInfo[giveplayerid][rdFinished][3] == -1)
        {
            RacingInfo[giveplayerid][rdFinished][3] = playerid;

            format(string, sizeof(string), "[!] %s je zavrsio kao cetvrti!", GetName(playerid, false));
            SendRacingMessage(giveplayerid, string);
        }

        if(++RacingInfo[giveplayerid][rdFnsdRacers] == GetTotalContesters(giveplayerid))
        {
            SendRacingMessage(giveplayerid, "[!] Trka je zavrsila!");
            ResetPlayerRace(giveplayerid, true);
        }

        ResetRacerVars(playerid);
        
        PlayerPlaySound(playerid, 1097, 0.0, 0.0, 0.0);
        DisablePlayerRaceCheckpoint(playerid);
        TogglePlayerAllDynamicCPs(playerid, true);

        defer StopRacingSound(playerid);
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_RACE_MAIN:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                { // Dodaj
                    new
                        Float:X, Float:Y, Float:Z;
                    GetPlayerPos(playerid, X, Y, Z);

                    new
                        index = GetFreeRacingCPSlot(playerid);
                    if(index == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Popunili ste vas inventory!");

                    SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dodali ste CP u slot %d!", CreateRacingCP(playerid, X, Y, Z)+1);

                    if(RacingInfo[playerid][rdContesters][0] <= 0)
                    {
                        RaceCreated[playerid] = true;

                        RacingInfo[playerid][rdContesters][0] = playerid;
                        RacingInfo[playerid][rdContesters][1] = -1;
                        RacingInfo[playerid][rdContesters][2] = -1;
                        RacingInfo[playerid][rdContesters][3] = -1;

                        RacingInfo[playerid][rdFinished][0]   = -1;
                        RacingInfo[playerid][rdFinished][1]   = -1;
                        RacingInfo[playerid][rdFinished][2]   = -1;
                        RacingInfo[playerid][rdFinished][3]   = -1;
                        RacingInfo[playerid][rdStarted]       = false;
                    }
                }
                case 1:
                { // Obrisi
                    new buffer[1024];
                    new row[90];

                    buffer[0] = EOS;
                    for (new i = 0; i < MAX_RACING_CPS; i++)
                    {
                        if(RacingInfo[playerid][rdPosX][i] != 0.0)
                        {
                            format(row, sizeof(row), "#%d | %s (%.2f, %.2f, %.2f)\n",
                                i + 1,
                                GetZoneFromXYZ(RacingInfo[playerid][rdPosX][i], RacingInfo[playerid][rdPosY][i], RacingInfo[playerid][rdPosZ][i]),
                                RacingInfo[playerid][rdPosX][i], RacingInfo[playerid][rdPosY][i], RacingInfo[playerid][rdPosZ][i]
                           );
                            strcat(buffer, row);
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_RACE_DCP, DIALOG_STYLE_LIST, "RACING SYSTEM", buffer, "Choose", "Abort");
                }
            }
            return 1;
        }
        case DIALOG_RACE_DCP:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_RACE_MAIN, DIALOG_STYLE_LIST, "RACING SYSTEM", "Dodaj checkpoint\nObrisi checkpoint", "Choose", "Abort");

            RacingDialogID[playerid] = listitem;
            va_ShowPlayerDialog(playerid, DIALOG_RACE_DCPS, DIALOG_STYLE_MSGBOX, "RACING SYSTEM - BRISANJE CPa", "Zelite li obrisati checkpoint u slotu %d?", "Yes", "No");
            return 1;
        }
        case DIALOG_RACE_DCPS:
        {
            if(!response)
            {
                new buffer[1024];
                new row[90];

                buffer[0] = EOS;
                for (new i = 0; i < MAX_RACING_CPS; i++)
                {
                    if(RacingInfo[playerid][rdPosX][i] != 0.0)
                    {
                        format(row, sizeof(row), "#%d | %s (%.2f, %.2f, %.2f)\n",
                            i + 1,
                            GetZoneFromXYZ(RacingInfo[playerid][rdPosX][i], RacingInfo[playerid][rdPosY][i], RacingInfo[playerid][rdPosZ][i]),
                            RacingInfo[playerid][rdPosX][i], RacingInfo[playerid][rdPosY][i], RacingInfo[playerid][rdPosZ][i]
                       );
                        strcat(buffer, row);
                    }
                }
                ShowPlayerDialog(playerid, DIALOG_RACE_DCP, DIALOG_STYLE_LIST, "RACING SYSTEM", buffer, "Choose", "Abort");
                return 1;
            }

            ResetPlayerRaceCP(playerid, RacingDialogID[playerid]);
            SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Obrisali ste checkpoint u slotu #%d!", RacingDialogID[playerid]+1);
            RacingDialogID[playerid] = -1;

            if(!GetRacingCpPool(playerid))
            {
               RaceCreated[playerid] = false;
            }
            return 1;
        }
        case DIALOG_RACE_CALL:
        {
            if(!response) return 1;

            new
                giveplayerid = RacingCallID[playerid],
                index = GetContestantFromPool(giveplayerid);
            if(index == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je puna!");
            if(RacingInfo[giveplayerid][rdStarted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je vec pocela!");

            RacingInfo[giveplayerid][rdContesters][index] = playerid;

            RacerSlot    [playerid] = index;
            RaceAuthor   [playerid] = giveplayerid;
            CurrentRaceCP[playerid] = 0;
            InRace       [playerid] = false;

            va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s je prihvatio vas poziv za utrku! Za pokretanje utrke idite /race start.", GetName(playerid, true));
            SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Prihvatili ste poziv za trku od %s!", GetName(giveplayerid, true));
            return 1;
        }
    }
    return 0;
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

CMD:race(playerid, params[])
{
    if(!IsARacer(playerid) || PlayerFaction[playerid][pRank] < FactionInfo[PlayerFaction[playerid][pMember]][rRace])
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik rejsera");
        return 1;
    }

    new param[8];
    if(sscanf(params, "s[8]", param))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /race [menu/invite/start]");
        return 1;
    }

    if(!strcmp(param, "menu", true))
    {
        ShowPlayerDialog(playerid, DIALOG_RACE_MAIN, DIALOG_STYLE_LIST, "RACING SYSTEM", "Dodaj checkpoint\nObrisi checkpoint", "Choose", "Abort");
    }
    else if(!strcmp(param, "invite", true))
    {
        new giveplayerid;
        if(sscanf(params, "s[8]i", param, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /race invite [playerid / Part of name]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unijeli ste nevaljan playerid!");
        if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe zvati, vase je mjesto osigurano!");

        CallRaceContestant(playerid, giveplayerid);
        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste pozvali %s u utrku!", GetName(giveplayerid,true));
    }
    else if(!strcmp(param, "start", true))
    {
        if(RacingInfo[playerid][rdPosX][1] == 0.0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate dodati minimalno 2 CPa da mozete pokreniti trku!");
        if(RacingInfo[playerid][rdStarted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je vec pocela!");

        StartPlayerRace(playerid);
    }
    return 1;
}
