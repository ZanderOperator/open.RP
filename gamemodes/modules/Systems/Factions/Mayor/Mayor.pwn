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

static govskins_gov[] =
{
    20700, 20701, 20702, 20703, 20704, 20705, 20706, 20707, 20708, 20709, 20710, 20711, 20712, 20713, 
    20714, 20715, 20716, 20717, 20718
};

static
    gov_doors[11],
    gov_status[11];

static 
    VehicleEquipment[MAX_PLAYERS];
/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    if(!response)
    {
        return 1;
    }
    new index = Player_ModelToIndex(playerid, modelid);
    switch (fselectid)
    {
        case ms_GOVSKIN:
        {
            SetPlayerSkin(playerid, govskins_gov[index]);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Uzeli ste skin ID %d.", govskins_gov[index]);
        }
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    VehicleEquipment[playerid] = INVALID_VEHICLE_ID;
    return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_GOV_EQUIP:
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
                    for(new i = 0; i < sizeof(govskins_gov); i++)
                    {
                        if(govskins_gov[i] != 0)
                        {
                            fselection_add_item(playerid, govskins_gov[i]);
                            Player_ModelToIndexSet(playerid, i, govskins_gov[i]);
                        }
                    }
                    fselection_show(playerid, ms_GOVSKIN, "Government Clothes");                
                }
                case 1:
                { // Duty
                    ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
                }
                case 2:
                { // Heal
                    new
                        Float:tempheal;
                    GetPlayerHealth(playerid,tempheal);

                    if(tempheal < 100.0)
                        SetPlayerHealth(playerid,99.9);

                    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
                    SetPlayerArmour(playerid, 50);

                    new string[144];
                    format(string, sizeof(string), "* %s oblaci pancirku.", GetName(playerid, true));
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
        }
        case DIALOG_GOV_EQUIP_DUTY:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {   // On Duty
                    if(Player_OnLawDuty(playerid))
                    {
                        SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti!");
                        return 1;
                    }
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                    Player_SetLawDuty(playerid, true);

                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit FD komande.");
                    
                    new string[144];
                    format(string, sizeof(string), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_DARKYELLOW, string);

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
                    new string[144];
                    format(string, sizeof(string), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_DARKYELLOW, string);

                    format(string, sizeof(string), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
                    ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal", "Choose", "Abort");
        }
    }
    return 0;
}

hook OnGameModeInit()
{
    // Vrata u City Hall-u
    gov_doors[0] = CreateDynamicObject(19859, 1288.548217, 755.028747, -97.373825, 0.000000, 0.000000, -270.000000, -1, -1, -1, 600.00, 600.00);
    gov_doors[1] = CreateDynamicObject(19859, 1288.548217, 758.029052, -97.373825, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
    gov_doors[2] = CreateDynamicObject(19859, 1288.548217, 755.028747, -92.923904, 0.000007, -0.000000, 89.999969, -1, -1, -1, 600.00, 600.00);
    gov_doors[3] = CreateDynamicObject(19859, 1288.548217, 758.029052, -92.913902, -0.000007, 0.000000, -89.999969, -1, -1, -1, 600.00, 600.00);
    gov_doors[4] = CreateDynamicObject(19859, 1312.890625, 758.029113, -97.393829, -0.000007, 0.000000, 270.000061, -1, -1, -1, 600.00, 600.00);
    gov_doors[5] = CreateDynamicObject(19859, 1312.890625, 755.028808, -97.393829, 0.000007, 0.000000, 89.999908, -1, -1, -1, 600.00, 600.00);
    gov_doors[6] = CreateDynamicObject(19859, 1305.600341, 778.698486, -97.373817, -0.000015, 0.000007, 360.000061, -1, -1, -1, 600.00, 600.00);
    gov_doors[7] = CreateDynamicObject(19859, 1308.600708, 778.698486, -97.373817, 0.000015, -0.000007, 539.999816, -1, -1, -1, 600.00, 600.00);
    gov_doors[8] = CreateDynamicObject(19859, 1308.890136, 783.608825, -97.393829, 0.000007, 0.000000, 89.999908, -1, -1, -1, 600.00, 600.00);
    gov_doors[9] = CreateDynamicObject(19859, 1308.890136, 794.949096, -97.393829, 0.000007, 0.000000, 629.999877, -1, -1, -1, 600.00, 600.00);
    gov_doors[10] = CreateDynamicObject(19859, 1312.850585, 755.799133, -92.923858, 0.000007, 0.000000, 89.999908, -1, -1, -1, 600.00, 600.00);

    // GoV garaza - novo - by L3o
    CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 6, -1, -1, 100.00); // world 6
    CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 6, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 6, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 6, -1, -1, 100.00);

    // Pickup
    CreateDynamicPickup(19133, 2, 284.846497, -1540.948486, 24.596806, 6, -1, -1, 80.0); // garaza

    return 1;
}

// TODO: refactor this abomination and probably use dynamic areas
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    // TODO: bounds checking for PlayerFaction[playerid][pMember] and extract it to a variable
    if(PRESSED(KEY_YES))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1288.548217, 755.028747, -97.373825))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;

            if(gov_status[0] == 0)
            {
                SetDynamicObjectRot(gov_doors[0], 0.000000, 0.000000, -180.000000);
                SetDynamicObjectRot(gov_doors[1], 0.000000, 0.000000, -180.000000);
                gov_status[0] = 1;
            }
            else if(gov_status[0] == 1)
            {
                SetDynamicObjectRot(gov_doors[0], 0.000000, 0.000000, -270.000000);
                SetDynamicObjectRot(gov_doors[1], 0.000000, 0.000000, -90.000000);
                gov_status[0] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1288.548217, 755.028747, -92.923904))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;
            if(gov_status[2] == 0)
            {
                SetDynamicObjectRot(gov_doors[2], 0.000007, -0.000000, 179.999969);
                SetDynamicObjectRot(gov_doors[3], -0.000007, 0.000000, -179.999969);
                gov_status[2] = 1;
            }
            else if(gov_status[2] == 1)
            {
                SetDynamicObjectRot(gov_doors[2], 0.000007, -0.000000, 89.999969);
                SetDynamicObjectRot(gov_doors[3], -0.000007, 0.000000, -89.999969);
                gov_status[2] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1312.890625, 758.029113, -97.393829))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;
            if(gov_status[4] == 0)
            {
                SetDynamicObjectRot(gov_doors[4], -0.000007, 0.000000, 0.000053);
                SetDynamicObjectRot(gov_doors[5], 0.000007, 0.000000, 359.999908);
                gov_status[4] = 1;
            }
            else if(gov_status[4] == 1)
            {
                SetDynamicObjectRot(gov_doors[4], -0.000007, 0.000000, 270.000061);
                SetDynamicObjectRot(gov_doors[5], 0.000007, 0.000000, 89.999908);
                gov_status[4] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1305.600341, 778.698486, -97.373817))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;

            if(gov_status[6] == 0)
            {
                SetDynamicObjectRot(gov_doors[6], -0.000015, 0.000007, 90.000045);
                SetDynamicObjectRot(gov_doors[7], 0.000015, -0.000007, 449.999816);
                gov_status[6] = 1;
            }
            else if(gov_status[6] == 1)
            {
                SetDynamicObjectRot(gov_doors[6], -0.000015, 0.000007, 360.000061);
                SetDynamicObjectRot(gov_doors[7], 0.000015, -0.000007, 539.999816);
                gov_status[6] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1308.890136, 783.608825, -97.393829))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;

            if(gov_status[8] == 0)
            {
                SetDynamicObjectRot(gov_doors[8], 0.000007, 0.000000, 359.999908);
                gov_status[8] = 1;
            }
            else if(gov_status[8] == 1)
            {
                SetDynamicObjectRot(gov_doors[8], 0.000007, 0.000000, 89.999908);
                gov_status[8] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1308.890136, 794.949096, -97.393829))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;

            if(gov_status[9] == 0)
            {
                SetDynamicObjectRot(gov_doors[9], 0.000007, 0.000000, 359.999908);
                gov_status[9] = 1;
            }
            else if(gov_status[9] == 1)
            {
                SetDynamicObjectRot(gov_doors[9], 0.000007, 0.000000, 629.999877);
                gov_status[9] = 0;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1312.850585, 755.799133, -92.923858))
        {
            if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
                return 1;

            if(gov_status[10] == 0)
            {
                SetDynamicObjectRot(gov_doors[10], 0.000007, 0.000000, 359.999908);
                gov_status[10] = 1;
            }
            else if(gov_status[10] == 1)
            {
                SetDynamicObjectRot(gov_doors[10], 0.000007, 0.000000, 89.999908);
                gov_status[10] = 0;
            }
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

CMD:govgarage(playerid, params[])
{
    if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
        return SendClientMessage(playerid, COLOR_RED, "Nisi pripadnik vlade!");

    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1480.7675, -1827.8673, 13.5469)
        && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 284.8465, -1540.9485, 24.5968, 6, 0, false);
        }
        else
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 287.2799, -1537.8717, 24.5278);

            foreach (new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 6);
                }
            }

            SetPlayerVirtualWorld(playerid, 6);
            SetVehicleVirtualWorld(vehicleid, 6);
            SetVehicleZAngle(vehicleid, 325.2156);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 10.0, 284.8465, -1540.9485, 24.5968)
             && GetPlayerVirtualWorld(playerid) == 6)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 1480.7675, -1827.8673, 13.5469, 0, 0, false);
        }
        else
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 1480.6512, -1831.0182, 13.4790);
            SetVehicleVirtualWorld(vehicleid, 0);

            foreach (new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleZAngle(vehicleid, 180.1870);
        }
    }
    return 1;
}