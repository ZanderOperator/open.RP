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

#define MAX_COMBINATIONS        (3)     // maximalno kombinacija za sef(gunrack/storage).
#define MAX_ROB_TIME            (60)    // maximalno vrijeme rob-a.
#define MIN_ROB_TIME            (35)    // hStorageAlarm level 3, najbolji alarm.
#define MAX_ROB_TDS             (17)


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
    PlayerText:srobTD[MAX_PLAYERS][MAX_ROB_TDS],
    rob_remaining[MAX_PLAYERS] = 0,
    rob_combinations[MAX_PLAYERS][MAX_COMBINATIONS],
    rob_counter[MAX_PLAYERS][MAX_COMBINATIONS],
    Timer:robs_timer[MAX_PLAYERS];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

CreateRobTextdraws(playerid, bool: td_status)
{
    if(td_status == false)
    {
        for (new i = 0; i < MAX_ROB_TDS; i++)
        {
            PlayerTextDrawHide(playerid, srobTD[playerid][i]);
        }
        CancelSelectTextDraw(playerid);
        return 1;
    }

    srobTD[playerid][0] = CreatePlayerTextDraw(playerid, 201.166336, 142.970382, "ld_otb2:butnb");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][0], 243.000000, 117.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][0], 255);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][0], 0);

    srobTD[playerid][1] = CreatePlayerTextDraw(playerid, 215.932891, 155.914749, "box");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][1], 0.000000, 4.399999);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][1], 428.599548, 0.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][1], 8388863);
    PlayerTextDrawUseBox(playerid, srobTD[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, srobTD[playerid][1], 866792362);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][1], 0);

    srobTD[playerid][2] = CreatePlayerTextDraw(playerid, 254.733230, 147.903732, "ld_beat:up");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][2], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, srobTD[playerid][2], true);

    srobTD[playerid][3] = CreatePlayerTextDraw(playerid, 261.834503, 163.451828, "1_2");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][3], 0.526332, 2.396444);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][3], 2);
    PlayerTextDrawColor(playerid, srobTD[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][3], 3);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][3], 0);

    srobTD[playerid][4] = CreatePlayerTextDraw(playerid, 320.938110, 163.451828, "3_4");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][4], 0.526332, 2.396444);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][4], 2);
    PlayerTextDrawColor(playerid, srobTD[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][4], 3);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][4], 0);

    srobTD[playerid][5] = CreatePlayerTextDraw(playerid, 377.774902, 163.451828, "5_6");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][5], 0.526332, 2.396444);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, srobTD[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][5], 3);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][5], 0);

    srobTD[playerid][6] = CreatePlayerTextDraw(playerid, 313.970153, 147.903732, "ld_beat:up");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][6], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][6], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][6], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, srobTD[playerid][6], true);

    srobTD[playerid][7] = CreatePlayerTextDraw(playerid, 370.173583, 147.903732, "ld_beat:up");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][7], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][7], 14.000000, 17.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][7], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][7], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][7], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][7], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][7], 0);
    PlayerTextDrawSetSelectable(playerid, srobTD[playerid][7], true);

    srobTD[playerid][8] = CreatePlayerTextDraw(playerid, 290.633514, 199.130142, "~y~(COMBINATION):~w~_00_00_00");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][8], 0.118333, 0.928000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][8], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][8], 2);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][8], 0);

    srobTD[playerid][9] = CreatePlayerTextDraw(playerid, 255.333297, 186.940765, "ld_chat:thumbdn");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][9], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][9], 11.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][9], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][9], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][9], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][9], 0);

    srobTD[playerid][10] = CreatePlayerTextDraw(playerid, 315.636962, 186.940765, "ld_chat:thumbdn");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][10], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][10], 11.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][10], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][10], 0);

    srobTD[playerid][11] = CreatePlayerTextDraw(playerid, 372.473754, 186.940765, "ld_chat:thumbdn");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][11], 11.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][11], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][11], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][11], 0);

    srobTD[playerid][12] = CreatePlayerTextDraw(playerid, 437.140594, 138.822280, "ld_chat:thumbdn");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, srobTD[playerid][12], 11.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][12], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][12], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, srobTD[playerid][12], true);

    srobTD[playerid][13] = CreatePlayerTextDraw(playerid, 292.966949, 214.478332, "~y~(time)~w~_30_seconds_remain...");
    PlayerTextDrawLetterSize(playerid, srobTD[playerid][13], 0.118333, 0.928000);
    PlayerTextDrawAlignment(playerid, srobTD[playerid][13], 1);
    PlayerTextDrawColor(playerid, srobTD[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, srobTD[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][13], 255);
    PlayerTextDrawFont(playerid, srobTD[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, srobTD[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, srobTD[playerid][13], 0);

    for (new i = 0; i < MAX_ROB_TDS; i++)
    {
        PlayerTextDrawShow(playerid, srobTD[playerid][i]);
    }
    SelectTextDraw(playerid, 0xAA3333AA);
    return 1;
}

PlayerHitCombination(playerid, combination_id)
{
    new buffer[27 + (MAX_COMBINATIONS * 3)];

    switch (combination_id)
    {
        case 0:
        {
            PlayerTextDrawDestroy(playerid, srobTD[playerid][9]);
            PlayerTextDrawHide(playerid, srobTD[playerid][2]);
            PlayerTextDrawShow(playerid, srobTD[playerid][6]);

            srobTD[playerid][14] = CreatePlayerTextDraw(playerid, 255.333297, 186.940765, "ld_chat:thumbup");
            PlayerTextDrawLetterSize(playerid, srobTD[playerid][14], 0.000000, 0.000000);
            PlayerTextDrawTextSize(playerid, srobTD[playerid][14], 11.000000, 10.000000);
            PlayerTextDrawAlignment(playerid, srobTD[playerid][14], 1);
            PlayerTextDrawColor(playerid, srobTD[playerid][14], -1);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][14], 0);
            PlayerTextDrawSetOutline(playerid, srobTD[playerid][14], 0);
            PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][14], 255);
            PlayerTextDrawFont(playerid, srobTD[playerid][14], 4);
            PlayerTextDrawSetProportional(playerid, srobTD[playerid][14], 0);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][14], 0);
            PlayerTextDrawShow(playerid, srobTD[playerid][14]);
        }
        case 1:
        {
            PlayerTextDrawDestroy(playerid, srobTD[playerid][10]);
            PlayerTextDrawHide(playerid, srobTD[playerid][6]);
            PlayerTextDrawShow(playerid, srobTD[playerid][7]);

            srobTD[playerid][15] = CreatePlayerTextDraw(playerid, 315.636962, 186.940765, "ld_chat:thumbup");
            PlayerTextDrawLetterSize(playerid, srobTD[playerid][15], 0.000000, 0.000000);
            PlayerTextDrawTextSize(playerid, srobTD[playerid][15], 11.000000, 10.000000);
            PlayerTextDrawAlignment(playerid, srobTD[playerid][15], 1);
            PlayerTextDrawColor(playerid, srobTD[playerid][15], -1);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][15], 0);
            PlayerTextDrawSetOutline(playerid, srobTD[playerid][15], 0);
            PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][15], 255);
            PlayerTextDrawFont(playerid, srobTD[playerid][15], 4);
            PlayerTextDrawSetProportional(playerid, srobTD[playerid][15], 0);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][15], 0);
            PlayerTextDrawShow(playerid, srobTD[playerid][15]);
        }
        case 2:
        {
            PlayerTextDrawDestroy(playerid, srobTD[playerid][11]);
            PlayerTextDrawHide(playerid, srobTD[playerid][7]);

            srobTD[playerid][16] = CreatePlayerTextDraw(playerid, 372.473754, 186.940765, "ld_chat:thumbup");
            PlayerTextDrawLetterSize(playerid, srobTD[playerid][16], 0.000000, 0.000000);
            PlayerTextDrawTextSize(playerid, srobTD[playerid][16], 11.000000, 10.000000);
            PlayerTextDrawAlignment(playerid, srobTD[playerid][16], 1);
            PlayerTextDrawColor(playerid, srobTD[playerid][16], -1);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][16], 0);
            PlayerTextDrawSetOutline(playerid, srobTD[playerid][16], 0);
            PlayerTextDrawBackgroundColor(playerid, srobTD[playerid][16], 255);
            PlayerTextDrawFont(playerid, srobTD[playerid][16], 4);
            PlayerTextDrawSetProportional(playerid, srobTD[playerid][16], 0);
            PlayerTextDrawSetShadow(playerid, srobTD[playerid][16], 0);
            PlayerTextDrawShow(playerid, srobTD[playerid][16]);

            // Storage Rob
            PlayerStopRob(playerid);
            StorageRob(playerid, Storage_PlayerNearRack(playerid));

            TogglePlayerControllable(playerid, true);
            SendClientMessage(playerid, COLOR_RED, "[!][ROBBERY]: Uspjesno ste provalili u gunrack safe, sada mozete ukrasti oruzje.");
        }
    }

    format(buffer, sizeof(buffer), "~y~(COMBINATION):~w~_%d_%d_%d", rob_counter[playerid][0], rob_counter[playerid][1], rob_counter[playerid][2]);
    PlayerTextDrawSetString(playerid, srobTD[playerid][8], buffer);
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    return 1;
}

StorageRob(playerid, storage_id)
{
    va_ShowPlayerDialog(playerid, DIALOG_ROB_STORAGE, DIALOG_STYLE_LIST, "[STORAGE] - Weapons", Storage_ListHouseStorage(storage_id), "Take", "Close");
    return 1;
}

PlayerStopRob(playerid)
{
    rob_combinations[playerid][0] = INVALID_PLAYER_ID;
    rob_combinations[playerid][1] = INVALID_PLAYER_ID;
    rob_combinations[playerid][2] = INVALID_PLAYER_ID;

    rob_counter[playerid][0] = INVALID_PLAYER_ID;
    rob_counter[playerid][1] = INVALID_PLAYER_ID;
    rob_counter[playerid][2] = INVALID_PLAYER_ID;

    rob_started[playerid] = false;
    rob_remaining[playerid] = INVALID_PLAYER_ID;

    stop robs_timer[playerid];
    CreateRobTextdraws(playerid, false);
    PlayerTextDrawDestroy(playerid, srobTD[playerid][14]);
    PlayerTextDrawDestroy(playerid, srobTD[playerid][15]);
    PlayerTextDrawDestroy(playerid, srobTD[playerid][16]);
    return 1;
}

PlayerStartRob(playerid, storage_id, rob_timer = MAX_ROB_TIME, house_id)
{
    rob_combinations[playerid][0] = minrand(2, 98);
    rob_combinations[playerid][1] = minrand(2, 98);
    rob_combinations[playerid][2] = minrand(2, 98);

    rob_counter[playerid][0] = 0;
    rob_counter[playerid][1] = 0;
    rob_counter[playerid][2] = 0;

    // TODO: move rob_started to this module, make a static bool variable and make a getter/setter for it
    rob_started[playerid] = true;
    PlayerJob[playerid][pFreeWorks] -= 15;
    TogglePlayerControllable(playerid, false);

    
    SendAdminMessage(COLOR_YELLOW, 
        "AdmWarn: %s has just started storage rob, storage ID: %d.", 
        GetName(playerid, false), 
        storage_id
    );

    new 
        buffer[35+5];
    PlayerTextDrawSetString(playerid, srobTD[playerid][8], "~y~(COMBINATION):~w~_??_??_??");
    format(buffer, sizeof(buffer), "~y~(time)~w~_%d_seconds_remain...", rob_timer);
    PlayerTextDrawSetString(playerid, srobTD[playerid][13], buffer);

    PlayerTextDrawHide(playerid, srobTD[playerid][6]);
    PlayerTextDrawHide(playerid, srobTD[playerid][7]);

    robs_timer[playerid] = repeat PlayerRobTimer(playerid, house_id);
    return 1;
}

PlayStorageAlarm(playerid, bool: activated)
{
    if(activated)
    {
        PlayAudioStreamForPlayer(playerid, "http://k007.kiwi6.com/hotlink/0zdonr7uhx/house_alarm.mp3");
    }
    else
    {
        StopAudioStreamForPlayer(playerid);
    }
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

timer PlayerRobTimer[1000](playerid, house_id)
{
    if(!rob_started[playerid])
    {
        return 1;
    }

    new buffer[35+5], string[128];
    rob_remaining[playerid]--;

    format(buffer, sizeof(buffer), "~y~(time)~w~_%d_seconds_remain...", rob_remaining[playerid]);
    PlayerTextDrawSetString(playerid, srobTD[playerid][13], buffer);

    if(rob_remaining[playerid] < 0)
    {
        TogglePlayerControllable(playerid, true);
        PlayerStopRob(playerid);

        SendClientMessage(playerid, COLOR_RED, "[ROBBERY]: Niste na vrjeme unesli kombinaciju za sef, alarm se aktivirao.");

        if(HouseInfo[house_id][hStorageAlarm] != 2)
        {
            format(string, sizeof(string), "*[ALARM]: Prijavljena je kradja u kuci, adresa kuce: %s.", HouseInfo[house_id][hAdress]);
            SendRadioMessage(1, COLOR_YELLOW, string);
        }

        if(HouseInfo[house_id][hStorageAlarm] != 0)
        {
            foreach(new i : Player)
            {
                if(IsPlayerInRangeOfPoint(i, 50.0, HouseInfo[house_id][hExitX], HouseInfo[house_id][hExitY], HouseInfo[house_id][hExitZ]) && GetPlayerVirtualWorld(i) == HouseInfo[house_id][hVirtualWorld])
                    PlayStorageAlarm(i, true);
            }
        }
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
    PlayerStopRob(playerid);
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_ROB_STORAGE:
        {
            if(response)
            {
                new
                    storage_id = Storage_PlayerNearRack(playerid),
                    puzavac = IsCrounching(playerid);

                if(storage_id == -1)
                    return 1;

                new
                    rack_weapon = Storage_GetRackWeaponInSlot(storage_id, listitem),
                    rack_ammo   = Storage_GetRackAmmoInSlot(storage_id, listitem);
                if(rack_weapon <= 0)
                {
                    return 1;
                }

                if(!CheckPlayerWeapons(playerid, rack_weapon)) return 1;
                AC_GivePlayerWeapon(playerid, rack_weapon, rack_ammo);
                SetAnimationForWeapon(playerid, rack_weapon, puzavac);

                Storage_SetRackWeaponInSlot(storage_id, listitem, 0);
                Storage_SetRackAmmoInSlot(storage_id, listitem, 0);
                HouseStorage_SaveWep(storage_id, listitem);

                Storage_RackRefresh(storage_id);
                HouseStorage_Save(storage_id);

                StorageRob(playerid, storage_id); // reload dialog.
            }
            return 1;
        }
    }
    return 0;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(!rob_started[playerid])
    {
        return 0;
    }

    if(playertextid == srobTD[playerid][12])
    {
        new string[128], house_id = Player_InHouse(playerid);

        PlayerStopRob(playerid);
        SendClientMessage(playerid, COLOR_RED, "[ROBBERY]: Zbog pokusaja obijanja gunrack-a, alarm se aktivirao. Policija je obavjestena.");

        if(HouseInfo[house_id][hStorageAlarm] != 2)
        {
            format(string, sizeof(string), "*[ALARM]: Prijavljena je kradja u kuci, adresa kuce: %s.", HouseInfo[house_id][hAdress]);
            SendRadioMessage(1, COLOR_YELLOW, string);
        }

        if(HouseInfo[house_id][hStorageAlarm] != 0)
        {
            foreach(new i : Player)
            {
                if(IsPlayerInRangeOfPoint(i, 50.0, HouseInfo[house_id][hExitX], HouseInfo[house_id][hExitY], HouseInfo[house_id][hExitZ]) && GetPlayerVirtualWorld(i) == HouseInfo[house_id][hVirtualWorld])
                    PlayStorageAlarm(i, true);
            }
        }
    }
    if(playertextid == srobTD[playerid][2])
    {
        new buffer[3];
        rob_counter[playerid][0]++;
        format(buffer, sizeof(buffer), "%d", rob_counter[playerid][0]);
        PlayerTextDrawSetString(playerid, srobTD[playerid][3], buffer);

        if(rob_counter[playerid][0] == rob_combinations[playerid][0])
            PlayerHitCombination(playerid, 0);
    }
    if(playertextid == srobTD[playerid][6])
    {
        new buffer[3];
        rob_counter[playerid][1]++;

        format(buffer, sizeof(buffer), "%d", rob_counter[playerid][1]);
        PlayerTextDrawSetString(playerid, srobTD[playerid][4], buffer);

        if(rob_counter[playerid][1] == rob_combinations[playerid][1])
            PlayerHitCombination(playerid, 1);
    }
    if(playertextid == srobTD[playerid][7])
    {
        new buffer[3];
        rob_counter[playerid][2]++;

        format(buffer, sizeof(buffer), "%d", rob_counter[playerid][2]);
        PlayerTextDrawSetString(playerid, srobTD[playerid][5], buffer);

        if(rob_counter[playerid][2] == rob_combinations[playerid][2])
            PlayerHitCombination(playerid, 2);
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

CMD:gunrack_rob(playerid, params[])
{
    new
        storage_id = Storage_PlayerNearRack(playerid),
        house_id = Player_InHouse(playerid);

    if(storage_id == -1)
        return SendErrorMessage(playerid, "Kako bi zapoceli storage-rob, morate biti u blizini stalka.");
    if(rob_started[playerid])
        return SendErrorMessage(playerid, "Vec ste zapoceli storage-rob, ne mozete ponovo.");

    if(HouseInfo[house_id][hStorageAlarm] == 0)      rob_remaining[playerid] = MAX_ROB_TIME;
    else if(HouseInfo[house_id][hStorageAlarm] == 1) rob_remaining[playerid] = 55;
    else if(HouseInfo[house_id][hStorageAlarm] == 2) rob_remaining[playerid] = 45;
    else if(HouseInfo[house_id][hStorageAlarm] == 3) rob_remaining[playerid] = MIN_ROB_TIME;

    CreateRobTextdraws(playerid, true);
    PlayerStartRob(playerid, storage_id, rob_remaining[playerid], house_id);
    return 1;
}
