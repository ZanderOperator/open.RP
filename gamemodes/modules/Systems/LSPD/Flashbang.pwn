#if defined MODULE_FLASHBANG
    #endinput
#endif
#define MODULE_FLASHBANG

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
    PlayerText:FlashbangEffectTd[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    bool:FlashbangShellsActive  [MAX_PLAYERS] = {false, ...};


/*
    ##     ##  #######   #######  ##    ## 
    ##     ## ##     ## ##     ## ##   ##  
    ##     ## ##     ## ##     ## ##  ##   
    ######### ##     ## ##     ## #####    
    ##     ## ##     ## ##     ## ##  ##   
    ##     ## ##     ## ##     ## ##   ##  
    ##     ##  #######   #######  ##    ## 
*/

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(!FlashbangShellsActive[playerid]) return 1;

    if(weaponid != 25) return 1;

    foreach(new i : Player)
    {
        if(IsPlayerInRangeOfPoint(i, 15.0, fX, fY, fZ))
        {
            new Float:pX, Float:pY, Float:pZ;

            GetPlayerPos(i, pX, pY, pZ);
            PlayerPlaySound(i, 1159, pX, pY, pZ);

            CreateFlashTD(i);
            SetPlayerDrunkLevel(i, 6000);
            GameTextForPlayer(i, "~b~FLASHBANGED", 5000, 4);

            defer ClearFlashEffect(i);
            defer ResetPlayerDrunkLevel(i);

            SendClientMessage(i, COLOR_RED, "[!] U tvojoj blizi je bacen flashbang. Probaj ga sto vjerodostojnije odRPati.");
        }
    }

    return 1;
}


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

timer ClearFlashEffect[2000](playerid)
{
    DestroyFlashTD(playerid);
    return 1;
}

timer ResetPlayerDrunkLevel[7500](playerid)
{
    SetPlayerDrunkLevel(playerid, 0);
    return 1;
}

stock DestroyFlashTD(playerid)
{
    PlayerTextDrawDestroy(playerid, FlashbangEffectTd[playerid]);
    FlashbangEffectTd[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

static stock CreateFlashTD(playerid)
{
    DestroyFlashTD(playerid);

    FlashbangEffectTd[playerid] = CreatePlayerTextDraw(playerid, -20.000000, 2.000000, "box");
    PlayerTextDrawUseBox(playerid, FlashbangEffectTd[playerid], 1);
    PlayerTextDrawBoxColor(playerid, FlashbangEffectTd[playerid], 0xffffffFF);
    PlayerTextDrawTextSize(playerid, FlashbangEffectTd[playerid], 660.000000, 22.000000);
    PlayerTextDrawLetterSize(playerid, FlashbangEffectTd[playerid], 1.000000, 52.200000);
    PlayerTextDrawAlignment(playerid, FlashbangEffectTd[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, FlashbangEffectTd[playerid], 0xffffffFF);
    PlayerTextDrawFont(playerid, FlashbangEffectTd[playerid], 3);
    PlayerTextDrawColor(playerid, FlashbangEffectTd[playerid], 0xffffffFF);
    PlayerTextDrawSetOutline(playerid, FlashbangEffectTd[playerid], 1);
    PlayerTextDrawSetProportional(playerid, FlashbangEffectTd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, FlashbangEffectTd[playerid], 1);
    PlayerTextDrawShow(playerid, FlashbangEffectTd[playerid]);
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

CMD:flashbangwep(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendClientMessage(playerid, COLOR_RED, "[!] Niste LSPD.");

    if(!Player_IsSWAT(playerid))
        return SendClientMessage(playerid, COLOR_RED, "[!] Nisi SWAT!");

    if(AC_GetPlayerWeapon(playerid) != 25)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR]: Kako bi uzeli gumene metke morate imati shotgun.");

    FlashbangShellsActive[playerid] = !FlashbangShellsActive[playerid]; // toggle
    if(FlashbangShellsActive[playerid])
        SendClientMessage(playerid, COLOR_RED, "[!] Ukljucili ste flashbang metke.");
    else
        SendClientMessage(playerid, COLOR_RED, "[!] Iskljucili ste flashbang metke.");

    return 1;
}
