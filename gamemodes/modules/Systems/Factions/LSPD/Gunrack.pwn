#if defined MODULE_GUNRACK
    #endinput
#endif
#define MODULE_GUNRACK

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
    bool:GunrackInUse[MAX_VEHICLES],
    GunrackWeapon    [MAX_VEHICLES][2],
    GunrackAmmo      [MAX_VEHICLES][2],
    CurrentWeaponID  [MAX_PLAYERS];


/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_GUNRACK:
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(vehicleid == INVALID_VEHICLE_ID) return 1;

            GunrackInUse[vehicleid] = false;

            if(!response)
            {
                return 1;
            }

            new
                string[128],
                weaponid = AC_GetPlayerWeapon(playerid),
                ammo = AC_GetPlayerAmmo(playerid);

            switch (listitem)
            {
                case 0: //Slot 1
                {
                    // TODO: why such complex logic and nesting? surely this can be simplified
                    if(GunrackWeapon[vehicleid][0] == 0 && weaponid == 0)
                    {
                        SendClientMessage(playerid, COLOR_RED, "Nemate oruzje u rukama niti imate oruzja u gunracku.");
                        return 1;
                    }
                    else if(GunrackWeapon[vehicleid][0] != 0 && weaponid == 0)
                    {
                        if(!CheckPlayerWeapons(playerid, GunrackWeapon[vehicleid][0]))
                            return 1;

                        AC_GivePlayerWeapon(playerid, GunrackWeapon[vehicleid][0], GunrackAmmo[vehicleid][0]);
                        GunrackWeapon[vehicleid][0] = 0;
                        GunrackAmmo[vehicleid][0] = 0;

                        format(string, sizeof(string), "> %s uzima oruzje iz gunracka Police Cruisera.", GetName(playerid));
                        SendClientMessage(playerid, COLOR_PURPLE, string);
                        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
                    }
                    else if(GunrackWeapon[vehicleid][0] == 0 && weaponid != 0)
                    {
                        GunrackWeapon[vehicleid][0] = weaponid;
                        GunrackAmmo[vehicleid][0] = ammo;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        SetPlayerArmedWeapon(playerid, 0);

                        format(string, sizeof(string), "> %s posprema oruzje u gunrack Police Cruisera.", GetName(playerid));
                        SendClientMessage(playerid, COLOR_PURPLE, string);
                        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
                    }
                    else if(GunrackWeapon[vehicleid][0] != 0 && weaponid != 0)
                    {
                        if(!CheckPlayerWeapons(playerid, GunrackWeapon[vehicleid][0]))
                            return 1;

                        AC_ResetPlayerWeapon(playerid, weaponid);
                        AC_GivePlayerWeapon(playerid, GunrackWeapon[vehicleid][0], GunrackAmmo[vehicleid][0]);
                        GunrackWeapon[vehicleid][0] = weaponid;
                        GunrackAmmo[vehicleid][0] = ammo;

                        SendClientMessage(playerid, COLOR_RED, "[!] Zamijenili ste oruzje u gunracku.");
                    }
                }
                case 1: //Slot 2
                {
                    if(GunrackWeapon[vehicleid][1] == 0 && weaponid == 0)
                    {
                        SendClientMessage(playerid, COLOR_RED, "Nemate oruzje u rukama niti imate oruzja u gunracuku.");
                        return 1;
                    }
                    else if(GunrackWeapon[vehicleid][1] != 0 && weaponid == 0)
                    {
                        if(!CheckPlayerWeapons(playerid, GunrackWeapon[vehicleid][1]))
                            return 1;

                        AC_GivePlayerWeapon(playerid, GunrackWeapon[vehicleid][1], GunrackAmmo[vehicleid][1]);
                        GunrackWeapon[vehicleid][1] = 0;
                        GunrackAmmo[vehicleid][1] = 0;

                        format(string, sizeof(string), "> %s uzima oruzje iz gunracka Police Cruisera.", GetName(playerid));
                        SendClientMessage(playerid, COLOR_PURPLE, string);
                        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
                    }
                    else if(GunrackWeapon[vehicleid][1] == 0 && weaponid != 0)
                    {
                        GunrackWeapon[vehicleid][1] = weaponid;
                        GunrackAmmo[vehicleid][1] = ammo;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        SetPlayerArmedWeapon(playerid, 0);

                        format(string, sizeof(string), "> %s posprema oruzje u gunrack Police Cruisera.", GetName(playerid));
                        SendClientMessage(playerid, COLOR_PURPLE, string);
                        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
                    }
                    else if(GunrackWeapon[vehicleid][1] != 0 && weaponid != 0)
                    {
                        if(!CheckPlayerWeapons(playerid, GunrackWeapon[vehicleid][1]))
                            return 1;

                        AC_ResetPlayerWeapon(playerid, weaponid);
                        AC_GivePlayerWeapon(playerid, GunrackWeapon[vehicleid][1], GunrackAmmo[vehicleid][1]);
                        GunrackWeapon[vehicleid][1] = weaponid;
                        GunrackAmmo[vehicleid][1] = ammo;

                        SendClientMessage(playerid, COLOR_RED, "[!] Zamijenili ste oruzje u gunracku.");
                    }
                }
            }
            return 1;
        } // case
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

CMD:gunrack(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid == INVALID_VEHICLE_ID) return 1;

    if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_FACTION && (VehicleInfo[vehicleid][vFaction] == 1 || VehicleInfo[vehicleid][vFaction] == 3))
    {
        if(GunrackInUse[vehicleid]) return SendClientMessage(playerid, COLOR_RED, "Pokusaj kasnije.");
        GunrackInUse[vehicleid] = true;

        new 
            str[156];

        format(str, sizeof(str), 
            "Weapon\tAmmo\n\%s\t%i\n%s\t%i", 
            GetWeaponNameEx(GunrackWeapon[vehicleid][0]),
            GunrackAmmo[vehicleid][0], 
            GetWeaponNameEx(GunrackWeapon[vehicleid][1]),
            GunrackAmmo[vehicleid][1]
       );
        ShowPlayerDialog(playerid, DIALOG_GUNRACK, DIALOG_STYLE_TABLIST_HEADERS, "Police Gunrack", str, "Choose", "Abort");
    }
    else SendClientMessage(playerid, COLOR_RED, "Niste u vozilu LSPDa.");
    return 1;
}

SetPlayerArmedWeaponEx(playerid, weaponid)
{
    CurrentWeaponID[playerid] = weaponid;
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
    return SetPlayerArmedWeapon(playerid, weaponid);
}

// TODO: would be nice to have a file with weapon helper functions with more of these functions, defines etc
bool:IsBulletWeapon(weaponid)
{
    return (WEAPON_COLT45 <= weaponid < WEAPON_SNIPER);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_PASSENGER)
    {
        CurrentWeaponID[playerid] = GetPlayerWeapon(playerid);
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER &&
        IsBulletWeapon(CurrentWeaponID[playerid]) == false &&
        GetPlayerCameraMode(playerid) == 55)
    {
        return 1;
    }

    if(newkeys & KEY_LOOK_RIGHT)
    {
        new
            curWeap = CurrentWeaponID[playerid],
            weapSlot = GetWeaponSlot(curWeap),
            weapID, weapAmmo;

        for (new i = weapSlot + 1; i <= 7; i++)
        {
            GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
            if(IsBulletWeapon(weapID) && weapID != curWeap)
            {
                SetPlayerArmedWeaponEx(playerid, weapID);
                break;
            }
        }
    }

    if(newkeys & KEY_LOOK_LEFT)
    {
        new
            curWeap = CurrentWeaponID[playerid],
            weapSlot = GetWeaponSlot(curWeap),
            weapID, weapAmmo;

        for (new i = weapSlot - 1; i >= 2; i--)
        {
            GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
            if(IsBulletWeapon(weapID) && weapID != curWeap)
            {
                SetPlayerArmedWeaponEx(playerid, weapID);
                break;
            }
        }
    }

    return 1;
}
