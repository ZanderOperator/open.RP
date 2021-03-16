#if defined _lsfd_core_included
  #endinput
#endif
#define _lsfd_core_included

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
// DEFINES za cijene /confirmation
#define PSIHO_PRICE 800
#define ZDRAV_PRICE 750
#define RADNA_PRICE 600

// DEFINES za cijene /recover -a
#define RECOVERY_PRICE 500

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
    StretcherObj          [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    bool:bHaveOxygen      [MAX_PLAYERS] = {false, ...},
    bool:bUsingStretcher  [MAX_PLAYERS] = {false, ...},
    bool:bStretcherSpawned[MAX_PLAYERS] = {false, ...},
    VehicleEquipment[MAX_PLAYERS],
    InjectPlayer[MAX_PLAYERS];

static fdskins_selection[] =
{
    20600, 20601, 20602, 20603, 20604, 20605, 20606, 20607, 20608, 20609, 20610, 20611, 20612, 20613, 20614, 20615
};

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_HaveOxygen(playerid)
{
    return bHaveOxygen[playerid];
}

stock bool:Player_UsingStretcher(playerid)
{
    return bUsingStretcher[playerid];
}

stock bool:Player_StretcherSpawned(playerid)
{
    return bStretcherSpawned[playerid];
}

stock Player_SetHaveOxygen(playerid, bool:v)
{
   bHaveOxygen[playerid] = v;
}

stock Player_SetUsingStretcher(playerid, bool:v)
{
    bUsingStretcher[playerid] = v;
}

stock Player_SetStretcherSpawned(playerid, bool:v)
{
    bStretcherSpawned[playerid] = v;
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



hook function ResetPlayerVariables(playerid)
{
    if(Player_StretcherSpawned(playerid))
    {
        if(IsValidObject(StretcherObj[playerid]))
        {
            DestroyObject(StretcherObj[playerid]);
            StretcherObj[playerid] = INVALID_OBJECT_ID;
        }
        else if(IsValidDynamicObject(StretcherObj[playerid]))
        {
            DestroyDynamicObject(StretcherObj[playerid]);
            StretcherObj[playerid] = INVALID_OBJECT_ID;
        }
    }

    Player_SetHaveOxygen      (playerid, false);
    Player_SetUsingStretcher  (playerid, false);
    Player_SetStretcherSpawned(playerid, false);

    VehicleEquipment[playerid] = INVALID_VEHICLE_ID;
    InjectPlayer[playerid] = INVALID_PLAYER_ID;

    return continue(playerid);
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    if(!response)
    {
        return 1;
    }
    new index = Player_ModelToIndex(playerid, modelid);
    switch (fselectid)
    {
        case ms_FDSKIN:
        {
            SetPlayerSkin(playerid, fdskins_selection[index]);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Uzeli ste skin ID %d.", fdskins_selection[index]);
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new string[144];

    switch (dialogid)
    {
        case DIALOG_FD_EQUIP:
        {
            if(!response)
            {
                if(VehicleEquipment[playerid] != INVALID_VEHICLE_ID)
                {
                    new
                        engine, lights, alarm, doors, bonnet, boot, objective;
                    GetVehicleParamsEx(VehicleEquipment[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleParamsEx(VehicleEquipment[playerid], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
                }
                return 1;
            }

            switch (listitem)
            {
                case 0:
                { // Skins
                    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
                }
                case 1:
                { // Skins
                    //ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nRadnik\nCivil", "Choose", "Exit");
                    
                    for(new i = 0; i < sizeof(fdskins_selection); i++)
                    {
                        if(fdskins_selection[i] != 0)
                        {
                            fselection_add_item(playerid, fdskins_selection[i]);
                            Player_ModelToIndexSet(playerid, i, fdskins_selection[i]);
                        }
                    }
                    fselection_show(playerid, ms_FDSKIN, "FD Clothes");                 
                }
                case 2:
                { // Dodaci
                    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MISC, DIALOG_STYLE_LIST, "LSFD Equipment", "Vatrogasni aparat\nSjekira\nMotorna pila\nKisik", "Choose", "Abort");
                }
                case 3:
                { // Heal
                    SetPlayerHealth(playerid, 99.9);
                    SetPlayerArmour(playerid, 50);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                }
                case 4:
                {
                    SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
                }
            }
            return 1;
        }
        case DIALOG_FD_EQUIP_DUTY:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
                return 1;
            }

            switch (listitem)
            {
                case 0:
                {   // On Duty
                    if(Player_OnLawDuty(playerid))
                    {
                        SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti.!");
                        return 1;
                    }

                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                    Player_SetLawDuty(playerid, true);

                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit FD komande.");
                    format(string, sizeof(string), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_ALLDEPT, string);

                    format(string, sizeof(string), "* %s oblaci svoju radnu uniformu i priprema se za posao.", GetName(playerid, true));
                    ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {   // Off Duty
                    if(!Player_OnLawDuty(playerid))
                    {
                        SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
                        return 1;
                    }

                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 99.9);
                    SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
                    Player_SetLawDuty(playerid, false);

                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste van  duznosti i ne mozete koristit FD komande.");
                    format(string, sizeof(string), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_ALLDEPT, string);

                    format(string, sizeof(string), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
                    ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
            return 1;
        }
        case DIALOG_FD_EQUIP_SKIN:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
                return 1;
            }

            switch (listitem)
            {
                case 0:
                    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MD, DIALOG_STYLE_LIST, "LSFD Equipment", "Doktor\nCrnac\nLatino\nBijelac\nZenska", "Choose", "Exit");
                    //ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MD, DIALOG_STYLE_LIST, "LSFD Equipment", "Doktor\nCrnac\nLatino\nBijelac\nZenska\n20035\n20037\n20039\n20041", "Choose", "Exit");
                case 1:
                    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_FD, DIALOG_STYLE_LIST, "LSFD Equipment", "Crnac\nBijelac\nLatino", "Choose", "Exit");
                    //ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_FD, DIALOG_STYLE_LIST, "LSFD Equipment", "Crnac\nBijelac\nLatino\n20036\n20038\n20040\n20042\n20043", "Choose", "Exit");
                case 2:
                    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_RADNICI, DIALOG_STYLE_LIST, "LSFD Equipment", "Radnik 1\nRadnik 2", "Choose", "Exit");
                case 3:
                    SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
            }
            return 1;
        }
        case DIALOG_FD_EQUIP_MD:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
                return 1;
            }

            static const skins_array[] = {70, 274, 275, 276, 308};

            if(0 <= listitem <= 4)
            {
                PlayerAppearance[playerid][pTmpSkin] = skins_array[listitem];
            }
            SetPlayerSkin(playerid, PlayerAppearance[playerid][pTmpSkin]);

            PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
            return 1;
        }
        case DIALOG_FD_EQUIP_FD:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
                return 1;
            }

            switch (listitem)
            {
                case 0: PlayerAppearance[playerid][pTmpSkin] = 278;
                case 1: PlayerAppearance[playerid][pTmpSkin] = 277;
                case 2: PlayerAppearance[playerid][pTmpSkin] = 279;
            }
            SetPlayerSkin(playerid, PlayerAppearance[playerid][pTmpSkin]);
            PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
            return 1;
        }
        case DIALOG_FD_EQUIP_RADNICI:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
                return 1;
            }
            switch (listitem)
            {
                case 0: SetPlayerSkin(playerid, 8);
                case 1: SetPlayerSkin(playerid, 69);
            }
            PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
            return 1;
        }
        case DIALOG_FD_EQUIP_MISC:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
                return 1;
            }

            switch (listitem)
            {
                case 0:
                {   // Aparat
                    AC_GivePlayerWeapon(playerid, 42, 999999999);
                    format(string, sizeof(string), "* %s uzima vatrogasni aparat.", GetName(playerid, true));
                    ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {   // Sjekira
                    AC_GivePlayerWeapon(playerid, 8, 1);
                    format(string, sizeof(string), "* %s uzima sjekiru.", GetName(playerid, true));
                    ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2:
                {   // Pila
                    AC_GivePlayerWeapon(playerid, 9, 1);
                    format(string, sizeof(string), "* %s uzima motornu pilu.", GetName(playerid, true));
                    ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 3:
                { // Kisik
                    if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
                        RemovePlayerAttachedObject(playerid, 9);

                    Player_SetHaveOxygen(playerid, true);
                    SetPlayerAttachedObject(playerid, 9, 1009, 1, 0.0, -0.12, 0.0, 270.0, 180.0, 0.0, 1.1, 1.1, 1.1);
                    format(string, sizeof(string), "* %s uzima bocu s kisikom.", GetName(playerid, true));
                    ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
            PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
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

/*CMD:enablesiren(playerid, params[])
{
    new
        vehicleid = GetPlayerVehicleID(playerid),
        siren = GetVehicleParamsSirenState(vehicleid);

    if(!IsAGov(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi pripadnik vlade!");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi u vozilu.");

    siren ^= 1; // toggle

    if(siren)
        GameTextForPlayer(playerid, "SIRENA UKLJUCENA", 1000, 4);
    else
        GameTextForPlayer(playerid, "SIRENA ISKLJUCENA", 1000, 4);

    return 1;
}*/

CMD:equipment(playerid, params[])
{
    if(IsFDMember(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 1176.2422,-1344.8013,-53.6860) || IsPlayerInRangeOfPoint(playerid, 10.0, 1244.3059,-1253.0569,13.5403) || IsPlayerInRangeOfPoint(playerid, 10.0, 1068.8527,-1764.5013,-37.2122))
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
        else
        {
            new vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_FACTION, FACTION_TYPE_FD);
            if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice/FD vozila!");
            ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal\nCivil Skin", "Choose", "Abort");
        }
    }
    else if(IsACop(playerid) || IsASD(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,5.0,2040.6858,1260.2460,-11.1115) || IsPlayerInRangeOfPoint(playerid,5.0,1073.3243,1309.4116,-47.7425) || IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) || IsPlayerInRangeOfPoint(playerid, 10.0, 2097.3110,-2123.7720,-44.1565) || IsPlayerInRangeOfPoint(playerid, 10.0, 2878.4600,-844.5946,-21.6994))
            ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LAW Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
        else
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice!");
    }
    else if(IsAGov(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid,5.0,1315.3967,758.2388,-93.1678))
            ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal", "Choose", "Abort");
        else
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice!");
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFDa/LSPDa/LSSDa/LSGOVa!");
    return 1;
}

CMD:oxygen(playerid, params[])
{
    if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
    if(!Player_HaveOxygen(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate bocu s kisikom!");

    if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
        RemovePlayerAttachedObject(playerid, 9);
    else
        SetPlayerAttachedObject(playerid, 9, 1009, 1, 0.0, -0.12, 0.0, 270.0, 180.0, 0.0, 1.1, 1.1, 1.1);
    return 1;
}

CMD:createexplosion(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] <= 1337)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi ovlasten za koristenje ove komande!");
        return 1;
    }

    new Float:X, Float:Y, Float:Z,
        type;
    if(sscanf(params, "d", type)) return SendClientMessage(playerid, COLOR_RED, "[?]: /createexplosion [type]");

    GetPlayerPos(playerid, X, Y, Z);
    CreateExplosion(X, Y, Z, type, 15.0);

    return 1;
}

CMD:rtcfdcars(playerid, params[])
{
    if(PlayerFaction[playerid][pLeader] != 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi lider LSFDa!");

    for (new x = 0; x < MAX_VEHICLES; x++)
    {
        if(VehicleInfo[x][vFaction] == 2)
        {
            if(!IsVehicleOccupied(x))
                SetVehicleToRespawn(x);
        }
    }
    return 1;
}

CMD:fdlift(playerid, params[])
{
    if(IsFDMember(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1160.9481,-1331.8121,-53.6800) || IsPlayerInRangeOfPoint(playerid, 2.0, 1155.6108,-1331.7755,-53.6800) || IsPlayerInRangeOfPoint(playerid, 2.0, 1133.4607,-1330.7346,-53.6900))
            SetPlayerPosEx(playerid, 1161.7253, -1329.7349, 31.5077, 0, 0, false);
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1161.7253, -1329.7349, 31.5077))
            SetPlayerPosEx(playerid, 1160.7086, -1331.2377, -53.8716, 1, 1, true);
    }
    return 1;
}

CMD:recover(playerid, params[])
{
    if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste LSFD!");

    new giveplayerid;
    if(sscanf( params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /recover [dio imena/playerid]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan playerid!");
    if(!PlayerDeath[giveplayerid][pKilled] && !Player_IsWounded(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije ubijen/ozlijedjen!");
    if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije dovoljno blizu vas!");
    if(DeathCountStarted_Get(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Igrac je mrtav i ne moze se reviveati!");

    StopPlayerDeath(giveplayerid);
    ResetPlayerWounded(giveplayerid);
    BudgetToFactionMoney(FACTION_TYPE_FD, RECOVERY_PRICE); //dobivaju nagradu za recover od drzave
    SetPlayerHealth(giveplayerid, 50.0);
    TogglePlayerControllable(giveplayerid, true);

    mysql_fquery(SQL_Handle(), "DELETE FROM player_deaths WHERE player_id = '%d'", PlayerInfo[giveplayerid][pSQLID]);

    va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Bolnicar %s vas je izlijecio i vise niste u post death stanju!",
        GetName(playerid)
   );
    va_SendClientMessage(playerid, COLOR_RED, "[!] Izlijecili ste %s i on vise nije u post death stanju!",
        GetName(giveplayerid)
   );
    return 1;
}

CMD:stretcher(playerid, params[])
{
    if(!IsFDMember(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi clan LSFDa.");
    new
        param[10];
    if(sscanf(params, "s[16] ", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /stretcher [get/drop/pick/destroy]");
    if(!strcmp(param, "get", true, 3))
    {
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED, "Ne mozes koristiti ovo u vozilu.");
        if(Player_StretcherSpawned(playerid)) return SendClientMessage(playerid,COLOR_RED, "Vec si spawnao jedna nosila.");

        new
            Float:X, Float:Y, Float:Z, Float:angle;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, angle);

        if(IsValidDynamicObject(StretcherObj[playerid]))
        {
            DestroyDynamicObject(StretcherObj[playerid]);
            StretcherObj[playerid] = INVALID_OBJECT_ID;
        }

        StretcherObj[playerid] = CreateDynamicObject(2146, X, Y, Z, 0.0, 0.0, angle);
        AttachDynamicObjectToPlayer(StretcherObj[playerid], playerid, 0.00, 1.30, -0.50, 0.0, 0.0, 0.0);
        Streamer_UpdateEx(playerid, X, Y, Z);

        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        Player_SetUsingStretcher(playerid, true);
        Player_SetStretcherSpawned(playerid, true);
    }
    else if(!strcmp(param, "drop", true, 4))
    {
        if(!Player_UsingStretcher(playerid)) return SendClientMessage(playerid,COLOR_RED, "Ne koristis nosila.");

        new Float:X, Float:Y, Float:Z, Float:R;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, R);

        if(IsValidDynamicObject(StretcherObj[playerid]))
        {
            DestroyDynamicObject(StretcherObj[playerid]);
            StretcherObj[playerid] = INVALID_OBJECT_ID;
        }

        StretcherObj[playerid] = CreateDynamicObject(2146, X, Y, Z-0.50, 0.0, 0.0, R);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        Streamer_UpdateEx(playerid, X, Y, Z);

        Player_SetUsingStretcher(playerid, false);
        Player_SetStretcherSpawned(playerid, true);
    }
    else if(!strcmp(param, "destroy", true, 7))
    {
        if(!Player_StretcherSpawned(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi spawnao nosila.");

        if(IsValidDynamicObject(StretcherObj[playerid]))
        {
            DestroyDynamicObject(StretcherObj[playerid]);
            StretcherObj[playerid] = INVALID_OBJECT_ID;
        }

        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        Player_SetUsingStretcher(playerid, false);
        Player_SetStretcherSpawned(playerid, false);
    }
    else if(!strcmp(param, "pick", true, 4))
    {
        new
            Float:X, Float:Y, Float:Z, Float:angle;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, angle);

        if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z) && !Player_UsingStretcher(playerid))
        {
            if(IsValidDynamicObject(StretcherObj[playerid]))
            {
                DestroyDynamicObject(StretcherObj[playerid]);
                StretcherObj[playerid] = INVALID_OBJECT_ID;
            }

            StretcherObj[playerid] = CreateDynamicObject(2146, X, Y, Z, 0.0, 0.0, angle);
            AttachDynamicObjectToPlayer(StretcherObj[playerid], playerid, 0.00, 1.30, -0.50, 0.0, 0.0, 0.0);
            Streamer_UpdateEx(playerid, X, Y, Z);

            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
            Player_SetUsingStretcher(playerid, true);
        }
        else SendClientMessage(playerid,COLOR_RED, "Nisi blizu nosila ili ih koristis.");
    }
    return 1;
}

CMD:treatment(playerid, params[])
{
    new
        giveplayerid, time;

    if(!IsFDMember(playerid)) return SendClientMessage(playerid, COLOR_RED, "Niste doktor!");
    if(sscanf( params, "ui", giveplayerid, time)) return SendClientMessage(playerid, COLOR_RED, "[?]: /treatment [playerid / Part of name][minute]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Unijeli ste krivi playerid!");
    if(time < 0 || time > 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos vremena tretmana!");
    if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe stavljati na tretman!");
    if(PlayerJail[giveplayerid][pJailed]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac je vec na tretmanu ili je zatvoren!");

    PutPlayerInJail(giveplayerid, time, 5); // 5 je treatment program
    va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Postavio si %s na lijecenje.",GetName(giveplayerid, true));
    va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Postavljen si na lijecenje od strane doktora %s.",GetName(playerid, true));
    return 1;
}

CMD:confirmation(playerid, params[])
{
    new giveplayerid, option[20], string[144];
    new year, month, day;
    new rand = random(9999);

    if(!IsFDMember(playerid) || PlayerFaction[playerid][pRank] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste doktor ili ste premal rank");
    if(IsFDMember(playerid) && PlayerFaction[playerid][pRank] < 1) return SendClientMessage(playerid, COLOR_RED, "Suspendirani ste!");
    if(sscanf(params, "s[20]u", option, giveplayerid))
    {
        SendClientMessage(playerid, COLOR_RED, "|__________________ {FA5656]Davanje uvjerenja __________________|");
        SendClientMessage(playerid, COLOR_RED, "[?]: /confirmation [opcija][Ime_Igraca/ID]");
        SendClientMessage(playerid, COLOR_RED, "[!] psihicka_sposobnost, zdrav_sposobnost, radna_sposobnost");
        SendClientMessage(playerid, COLOR_RED, "|_______________________________________________________|");
        return 1;
    }

    if(strcmp(option,"psihicka_sposobnost",true) == 0)
    {
        getdate(year, month, day);
        format(string, sizeof(string), "________________ #%d Lijecnicka potvrda _________________", rand);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovom potvrdom potvrduje se da je osoba %s", GetName(giveplayerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "psiholoski sposobna i da nema psihickih poremecaja.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                               Doktor: %s ", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, "___________________________________________________");
        //
        format(string, sizeof(string), "Dali ste %s uvjerenje od psihickoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
        SendClientMessage(playerid, 0xA1C3FFFF, string);
        //
        format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o psihickoj stabilnosti. (R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, PSIHO_PRICE);

        format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", PSIHO_PRICE);
        SendClientMessage(giveplayerid, -1, string);
        PlayerToFactionMoney(giveplayerid, FACTION_TYPE_FD, PSIHO_PRICE);
    }
    else if(strcmp(option,"zdrav_sposobnost",true) == 0)
    {
        getdate(year, month, day);
        format(string, sizeof(string), "________________ #%d Lijecnicka potvrda _________________", rand);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovom potvrdom potvrduje se da je osoba %s", GetName(giveplayerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "zdravstveno sposobna i da nema zdravstvenih problema.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                                Doktor: %s ", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, "___________________________________________________");
        //
        format(string, sizeof(string), "Dali ste %s uvjerenje od zdravstvenoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
        SendClientMessage(playerid, 0xA1C3FFFF, string);
        //
        format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o psihickoj stabilnosti.(R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, ZDRAV_PRICE);
        SendRadioMessage(2, TEAM_BLUE_COLOR, string);
        format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", ZDRAV_PRICE);
        SendClientMessage(giveplayerid, -1, string);
        PlayerToFactionMoney(giveplayerid, FACTION_TYPE_FD, ZDRAV_PRICE);
    }
    else if(strcmp(option,"radna_sposobnost",true) == 0)
    {
        getdate(year, month, day);
        format(string, sizeof(string), "_____________________ #%d Lijecnicko uvjerenje _________________", rand);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovim uvjerenjem dokazuje se da je osoba %s", GetName(giveplayerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "radno sposobna te nema zdravstvenih, psiholoskih i fizioloskih problema.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                                Doktor: %s ", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, 0xA1C3FFFF, "________________________________________________________");
        //
        format(string, sizeof(string), "Dali ste %s uvjerenje od psihickoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
        SendClientMessage(playerid, 0xA1C3FFFF, string);
        //
        format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o radnoj sposobnosti. (R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, RADNA_PRICE);
        SendRadioMessage(2, TEAM_BLUE_COLOR, string);
        format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", RADNA_PRICE);
        SendClientMessage(giveplayerid, -1, string);
        PlayerToFactionMoney(giveplayerid, FACTION_TYPE_FD, RADNA_PRICE);
    }
    else SendClientMessage(playerid, COLOR_RED, "Nepoznata opcija, pokusajte ponovo!");
    return 1;
}

CMD:injectp(playerid, params[])
{
    new
        giveplayerid;

    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /injectp [playerid / Part of name]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid!");
    if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe lije�iti.");
    if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu tog igraca!");

    va_SendClientMessage(playerid, COLOR_RED, "[!] Poslali ste zahtjev za injekciju %s", GetName(giveplayerid));
    va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je poslao zahtjev za injekciju, kucajte /accept inject za lijecenje!", GetName(playerid));

    InjectPlayer[playerid]      = giveplayerid;
    InjectPlayer[giveplayerid]  = playerid;
    return 1;
}
