#if defined MODULE_ANPR
    #endinput
#endif
#define MODULE_ANPR

// Automatic number plate recognition system - cops only

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
    bool:ANPRActivated       [MAX_PLAYERS] = {false, ...},
    Timer:PlayerANPRTimer    [MAX_PLAYERS],
    PlayerText:AnprBackground[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:AnprTitle     [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:AnprInfo      [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_HasANPRActivated(playerid)
{
    return ANPRActivated[playerid];
}

stock Player_SetANPRActivated(playerid, bool:v)
{
    ANPRActivated[playerid] = v;
}

timer ANPRTimer[2000](playerid)
{
    new
        Float:vX, Float:vY, Float:vZ,
        string[86];

    foreach(new i : StreamedVehicle[playerid])
    {
        if(IsPlayerInVehicle(playerid, i))
            continue;
        
        GetVehiclePos(i, vX, vY, vZ);
        if(GetPlayerDistanceFromPoint(playerid, vX, vY, vZ) <= 20.0)
        {
            new count = 0;

            static
                Float:fPX, Float:fPY, Float:fPZ,
                Float:fVX, Float:fVY, Float:fVZ;

            GetPlayerCameraPos(playerid, fPX, fPY, fPZ);
            GetPlayerCameraFrontVector(playerid, fVX, fVY, fVZ);

            fPX += floatmul(fVX, 5.0);
            fPY += floatmul(fVY, 5.0);

            if(GetPlayerDistanceFromPoint(playerid, fPX, fPY, vZ) <= 15.0)
            {
                if(VehicleInfo[i][vTickets][0] != 0)
                    count++;
                if(VehicleInfo[i][vTickets][1] != 0)
                    count++;
                if(VehicleInfo[i][vTickets][2]  != 0)
                    count++;
                if(VehicleInfo[i][vTickets][3] != 0)
                    count++;
                if(VehicleInfo[i][vTickets][4] != 0)
                    count++;

                if(VehicleInfo[i][vNumberPlate][0] != '0')
                {
                    format(string, sizeof(string), "~y~Registracija: ~w~%s~n~~y~Owner: ~w~%s~n~~y~Kazne: ~w~%d",
                        VehicleInfo[i][vNumberPlate],
                        ConvertSQLIDToName(VehicleInfo[i][vOwnerID]),
                        count
                   );

                    PlayerTextDrawSetString(playerid,AnprInfo[playerid], string);
                }
                // TODO: all of these else statements can be removed and text draw formatting done
                // at the end, with variable assignments for strings based on player distance
                // which will reduce code duplication and deep nesting
                else
                {
                    PlayerTextDrawSetString(playerid, AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
                }

                break;
            }
            else
            {
                PlayerTextDrawSetString(playerid, AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
            }
        }
        else
        {
            PlayerTextDrawSetString(playerid, AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
        }
    }
}

static CreateANPRTextDraw(playerid)
{
    DestroyANPRTextDraw(playerid);

    AnprBackground[playerid] = CreatePlayerTextDraw(playerid, 495.679992, 110.774696, "usebox");
    PlayerTextDrawLetterSize(playerid, AnprBackground[playerid], 0.000000, 7.082777);
    PlayerTextDrawTextSize(playerid, AnprBackground[playerid], 612.329895, 0.000000);
    PlayerTextDrawAlignment(playerid, AnprBackground[playerid], 1);
    PlayerTextDrawColor(playerid, AnprBackground[playerid], 0);
    PlayerTextDrawUseBox(playerid, AnprBackground[playerid], true);
    PlayerTextDrawBoxColor(playerid, AnprBackground[playerid], 102);
    PlayerTextDrawSetShadow(playerid, AnprBackground[playerid], 0);
    PlayerTextDrawSetOutline(playerid, AnprBackground[playerid], 0);
    PlayerTextDrawFont(playerid, AnprBackground[playerid], 0);
    PlayerTextDrawShow(playerid, AnprBackground[playerid]);

    AnprTitle[playerid] = CreatePlayerTextDraw(playerid, 555.439636, 109.834625, "~y~ANPR");
    PlayerTextDrawLetterSize(playerid, AnprTitle[playerid], 0.440879, 1.709013);
    PlayerTextDrawAlignment(playerid, AnprTitle[playerid], 2);
    PlayerTextDrawColor(playerid, AnprTitle[playerid], -1);
    PlayerTextDrawSetShadow(playerid, AnprTitle[playerid], 0);
    PlayerTextDrawSetOutline(playerid, AnprTitle[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, AnprTitle[playerid], 51);
    PlayerTextDrawFont(playerid, AnprTitle[playerid], 2);
    PlayerTextDrawSetProportional(playerid, AnprTitle[playerid], 1);
    PlayerTextDrawShow(playerid, AnprTitle[playerid]);

    AnprInfo[playerid] = CreatePlayerTextDraw(playerid, 497.840057, 130.367950, "~y~Registracija: ~w~None~n~~y~Trazen: ~g~Ne~n~~y~Kazne: ~w~0");
    PlayerTextDrawLetterSize(playerid, AnprInfo[playerid], 0.334319, 1.339414);
    PlayerTextDrawAlignment(playerid, AnprInfo[playerid], 1);
    PlayerTextDrawColor(playerid, AnprInfo[playerid], -1);
    PlayerTextDrawSetShadow(playerid, AnprInfo[playerid], 0);
    PlayerTextDrawSetOutline(playerid, AnprInfo[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, AnprInfo[playerid], 51);
    PlayerTextDrawFont(playerid, AnprInfo[playerid], 1);
    PlayerTextDrawSetProportional(playerid, AnprInfo[playerid], 1);
    PlayerTextDrawShow(playerid, AnprInfo[playerid]);
    return 1;
}

static DestroyANPRTextDraw(playerid)
{
    if(AnprBackground[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, AnprBackground[playerid]);
        AnprBackground[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }

    if(AnprTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, AnprTitle[playerid]);
        AnprTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }

    if(AnprInfo[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, AnprInfo[playerid]);
        AnprInfo[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

stock DisableANPRForPlayer(playerid)
{
    DestroyANPRTextDraw(playerid);
    stop PlayerANPRTimer[playerid];
    Player_SetANPRActivated(playerid, false);
}

stock EnableANPRForPlayer(playerid)
{
    CreateANPRTextDraw(playerid);
    PlayerANPRTimer[playerid] = repeat ANPRTimer(playerid);
    Player_SetANPRActivated(playerid, true);
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

hook OnPlayerDisconnect(playerid, reason)
{
    if(Player_HasANPRActivated(playerid))
    {
        DisableANPRForPlayer(playerid);
    }
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
    {
        if(Player_HasANPRActivated(playerid))
        {
            DisableANPRForPlayer(playerid);
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

CMD:anpr(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
    if(!IsInStateVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");

    new string[80];
    if(!Player_HasANPRActivated(playerid))
    {
        EnableANPRForPlayer(playerid);

        GameTextForPlayer(playerid, "~g~ANPR Active", 1500, 1);
        format(string, sizeof(string), "* %s pokreće ANPR system.", GetName(playerid, true));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    else
    {
        DisableANPRForPlayer(playerid);

        GameTextForPlayer(playerid, "~r~ANPR deactivated", 1500, 1);
        format(string, sizeof(string), "* %s isključuje ANPR system.", GetName(playerid, true));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    return 1;
}
