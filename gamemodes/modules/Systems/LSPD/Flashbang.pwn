/*
*	  		Flashbang Shells
*	 www.cityofangels-roleplay.com
*	    created and coded by Khawaja.
*	      All rights reserved.
*	     	   (c) 2020
*/

#include <YSI_Coding\y_hooks>

#define                     posArr{%0}                  %0[0], %0[1], %0[2]
#define                     posArrEx{%0}                %0[0], %0[1], %0[2], %0[3]

new
	PlayerText:_flashbangEffect[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(GetPVarInt(playerid, "_flashShells"))
    {
        if(weaponid == 25)
        {
             for(new i = 0; i<GetMaxPlayers(); ++i)
			 {
                if(IsPlayerInRangeOfPoint(i, 15.0, fX, fY, fZ))
                {
                    new
                        Float:iPos[3];

                    GetPlayerPos(i, posArr{iPos});
                    PlayerPlaySound(i, 1159, posArr{iPos});

                    CreateFlashTD(i);
                    SetPlayerDrunkLevel(i, 6000);
                    GameTextForPlayer(i, "~b~FLASHBANGED", 5000, 4);

					SetTimerEx("toggleFlashEffect", 2000, 0, "i", i);
                    SetTimerEx("toggleOtherFlashEffect", 5000, 0, "i", i);

                    SendClientMessage(i, COLOR_RED, "[ ! ] U tvojoj blizi je bacen flashbang. Probaj ga �to vjerodstojnije odRPati.");
                }
            }
        }

    }
    return 1;
}

forward toggleFlashEffect(playerid);
public toggleFlashEffect(playerid)
{
    DestroyFlashTD(playerid);
    return 1;
}

forward toggleOtherFlashEffect(playerid);
public toggleOtherFlashEffect(playerid)
{
    SetPlayerDrunkLevel(playerid, 0);
    return 1;
}

stock DestroyFlashTD(playerid){
    PlayerTextDrawDestroy(playerid, _flashbangEffect[ playerid ] );
	_flashbangEffect[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
}

stock static CreateFlashTD(playerid)
{
    DestroyFlashTD(playerid);

  	_flashbangEffect[playerid] = CreatePlayerTextDraw(playerid, -20.000000, 2.000000, "box");
   	PlayerTextDrawUseBox(playerid, _flashbangEffect[playerid], 1);
    PlayerTextDrawBoxColor(playerid, _flashbangEffect[playerid], 0xffffffFF);
    PlayerTextDrawTextSize(playerid, _flashbangEffect[playerid], 660.000000, 22.000000);
    PlayerTextDrawLetterSize(playerid, _flashbangEffect[playerid], 1.000000, 52.200000);
    PlayerTextDrawAlignment(playerid, _flashbangEffect[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, _flashbangEffect[playerid], 0xffffffFF);
    PlayerTextDrawFont(playerid, _flashbangEffect[playerid], 3);
    PlayerTextDrawColor(playerid, _flashbangEffect[playerid], 0xffffffFF);
    PlayerTextDrawSetOutline(playerid, _flashbangEffect[playerid], 1);
    PlayerTextDrawSetProportional(playerid, _flashbangEffect[playerid], 1);
    PlayerTextDrawSetShadow(playerid, _flashbangEffect[playerid], 1);
	PlayerTextDrawShow(playerid, _flashbangEffect[playerid]);
}

CMD:flashbangwep(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste LSPD.");
	if(!Bit1_Get(gr_PlayerIsSWAT, playerid))
		return SendClientMessage(playerid, COLOR_RED, "[ ! ] Nisi SWAT!");
    if(AC_GetPlayerWeapon(playerid) != 25)
		return SendClientMessage(playerid, COLOR_RED, "[ERROR]: Kako bi uzeli gumene metke morate imati shotgun.");

	if(GetPVarInt(playerid, "_flashShells"))
    {
        SendClientMessage(playerid, COLOR_RED, "[ ! ] Iskljucili ste flashbang metke.");
        DeletePVar(playerid, "_flashShells");
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste flashbang metke.");
        SetPVarInt(playerid, "_flashShells", 1);
    }
    return 1;
}
