#include <YSI_Coding\y_hooks>

static
	Text3D:NameText[MAX_PLAYERS],
    bool:UsingMask[MAX_PLAYERS];

stock bool:Player_UsingMask(playerid)
{
    return UsingMask[playerid];
}

stock Player_SetUsingMask(playerid, bool:v)
{
    UsingMask[playerid] = v;
}

CheckPlayerMasks(playerid)
{
	foreach(new i : Player) 
	{
		if(Player_UsingMask(i))
			ShowPlayerNameTagForPlayer(playerid, i, 0);
	}
	return 1;
}

RemovePlayerMask(playerid)
{
    if(IsValidDynamic3DTextLabel(NameText[playerid]))
	{
		DestroyDynamic3DTextLabel(NameText[playerid]);
		NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
	}
	Player_SetUsingMask(playerid, false);
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    RemovePlayerMask(playerid);
	return continue(playerid);
}

hook OnPlayerStreamIn(playerid, forplayerid)
{
    if(Player_UsingMask(forplayerid))
    {
        if(PlayerInfo[playerid][pAdmin] > 0 && Admin_OnDuty(playerid))
            ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
        else
            ShowPlayerNameTagForPlayer(playerid, forplayerid, false);
    }
    else
        ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
    
	return 1;
}

CMD:mask(playerid, params[])
{
	if(PlayerInventory[playerid][pMaskID] == -1 || PlayerInventory[playerid][pMaskID] == 0 )
		return SendClientMessage( playerid, COLOR_RED, "[GRESKA]: Ne posjedujes masku!" );

	new buffer[80];
	if(!Player_UsingMask(playerid))
	{
		foreach(new i : Player)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Stavili ste masku na glavu. Korsitite /mask opet ukoliko je zelite skinuti.");
		Player_SetUsingMask(playerid, true);
		format(buffer, sizeof(buffer), "* %s stavlja masku na glavu.", GetName(playerid, true));
		SendClientMessage(playerid, COLOR_PURPLE, buffer);
		SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 20, 10000);

		GameTextForPlayer(playerid, "~b~STAVILI STE MASKU", 5000, 4);

		#if defined MODULE_LOGS
		if(PlayerInventory[playerid][pMaskID] == 0) 
		{
			Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
				ReturnDate(),
				GetName(playerid, false),
				ReturnPlayerIP(playerid),
				PlayerInventory[playerid][pMaskID]
			);
		}
		#endif

		new
			maskName[24];
		format(maskName, sizeof(maskName), "Maska_%d", PlayerInventory[playerid][pMaskID]);
		if(IsValidDynamic3DTextLabel(NameText[playerid]))
		{
			DestroyDynamic3DTextLabel(NameText[playerid]);
			NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
		}
		NameText[playerid] = CreateDynamic3DTextLabel(maskName, 0xB2B2B2AA, 0, 0, -20, 25, playerid, INVALID_VEHICLE_ID, 1);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameText[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
	}
	else
	{
		foreach(new i : Player)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}

		Player_SetUsingMask(playerid, false);
		format(buffer, sizeof(buffer), "* %s skida masku sa glave.", GetName(playerid, true));
		SendClientMessage(playerid, COLOR_PURPLE, buffer);
		SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 20, 10000);
		GameTextForPlayer(playerid, "~b~SKINULI STE MASKU", 5000, 4);

		if(IsValidDynamic3DTextLabel(NameText[playerid]))
		{
			DestroyDynamic3DTextLabel(NameText[playerid]);
			NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
		}
	}
	return 1;
}