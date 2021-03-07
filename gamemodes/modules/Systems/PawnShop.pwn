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

enum E_MELEE_WEAPONS
{
    mwWeaponId,
    mwName[16],
    mwPrice
}

static MeleeWeapons[][E_MELEE_WEAPONS] =
{
    {WEAPON_BRASSKNUCKLE  , "Brass Knuckles"  , 12},
    {WEAPON_GOLFCLUB      , "Golf Club"       , 20},
    {WEAPON_KNIFE         , "Knife"           , 50},
    {WEAPON_BAT           , "Bat"             , 10},
    {WEAPON_SHOVEL        , "Shovel"          , 16},
    {WEAPON_POOLSTICK     , "Pool Cue"        , 18},
    {WEAPON_KATANA        , "Katana"          , 100},
    {WEAPON_DILDO         , "Purpule Dildo"   , 150}
};


/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_WEAPONS_MELEE:
        {
            if(!response) return 1;

            if(AC_GetPlayerMoney(playerid) < MeleeWeapons[listitem][mwPrice]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca (%d$)!", MeleeWeapons[listitem][mwPrice]);

            PlayerToIllegalBudgetMoney(playerid, MeleeWeapons[listitem][mwPrice]);
            AC_GivePlayerWeapon(playerid, MeleeWeapons[listitem][mwWeaponId], 1, true, false);
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

CMD:buymelee(playerid, params[])
{
    if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Komandu mogu koristiti level 2+ igraci!");
    if(!IsPlayerInRangeOfPoint(playerid, 8.0, 2429.2859, -1953.6417, 3013.5000)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u Pawn Shopu!");

    new string[256+1] = "Oruzje\tCijena\n";
    new row[32+1];
    for (new i = 0; i < sizeof(MeleeWeapons); i++)
    {
        format(row, sizeof(row), "%s\t%d$\n", MeleeWeapons[i][mwName], MeleeWeapons[i][mwPrice]);
        strcat(string, row, sizeof(string));
    }
    ShowPlayerDialog(playerid, DIALOG_WEAPONS_MELEE, DIALOG_STYLE_TABLIST_HEADERS, "Pawn Shop", string, "Buy", "Abort");
    return 1;
}