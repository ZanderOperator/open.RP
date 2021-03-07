#include <YSI_Coding\y_hooks>
				
// Server Updates Dialog by Logan - Last Updated November 2020.

static 	
		page1[1280],
		page2[1280],
		page3[1280],
		page4[1280],
		updatestring[1280*4],
		updateCaption[80],
		PlayerUpdatePage[MAX_PLAYERS],
		bool:PlayerReward[MAX_PLAYERS];

stock bool:Player_Reward(playerid)
{
	return PlayerReward[playerid];
}

stock Player_SetReward(playerid, bool:v)
{
	PlayerReward[playerid] = v;
}

stock LoadUpdateList()
{
    new File:handle = fopen("Changelog.txt", io_read),
        buffer[256];
    
    if(handle)
    {
        while(fread(handle, buffer))
		{
			if(strlen(updatestring) < DIALOG_UPDATE_LIST_CHAR)
				strcat(page1, buffer, sizeof(page1));
			else if(strlen(updatestring) >= DIALOG_UPDATE_LIST_CHAR && strlen(updatestring) < (DIALOG_UPDATE_LIST_CHAR*2))
				strcat(page2, buffer, sizeof(page2));
			else if(strlen(updatestring) >= (DIALOG_UPDATE_LIST_CHAR*2) && strlen(updatestring) < (DIALOG_UPDATE_LIST_CHAR*3))
				strcat(page3, buffer, sizeof(page3));
			else if(strlen(updatestring) >= (DIALOG_UPDATE_LIST_CHAR*3))
				strcat(page4, buffer, sizeof(page4));

            strcat(updatestring, buffer, sizeof(updatestring));
		}   
        format(updateCaption, sizeof(updateCaption), "%s Update", SCRIPT_VERSION);
        fclose(handle);
    }
    else print("The file \"Changelog.txt\" does not exists, or can't be opened.");
    return 1;
}

stock ShowPlayerUpdateList(playerid)
{
	if(isnull(page2))	
		ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Exit", "");
	else 
		ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Next", "Back");
	PlayerUpdatePage[playerid] = 1;
	return 1;
}

stock RewardPlayer(playerid)
{
	if(PlayerInfo[playerid][pLevel] >= 3 && Player_Reward(playerid))
	{
		new rand = random(100);
		switch(rand)
		{
			case 0..49:
			{
				BudgetToPlayerMoney(playerid, 500);
				va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 500$. Ugodnu igru zeli Vam %s Team!", SERVER_NAME);
			}
			case 50..89:
			{
				ExpInfo[playerid][ePoints] += 1;
				ExpInfo[playerid][eAllPoints] += 1;
				SavePlayerExperience(playerid);
				va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 1 EXP bodom. Ugodnu igru zeli Vam %s Team!", SERVER_NAME);
			}
			case 90..99:
			{
				ExpInfo[playerid][ePoints] += 5;
				ExpInfo[playerid][eAllPoints] += 5;
				SavePlayerExperience(playerid);
				va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 5 EXP bodova. Ugodnu igru zeli Vam %s Team!", SERVER_NAME);
			}
		}
		Player_SetReward(playerid, false);
	}
	return 1;
}

hook OnGameModeInit()
{
	LoadUpdateList();
	return 1;
}
	
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case DIALOG_UPDATE_LIST:
		{
			switch(PlayerUpdatePage[playerid])
			{
				case 1:
				{
					if(!response)
					{
						strcpy(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION);
						RewardPlayer(playerid);
					}
					else 
					{
						if(isnull(page2) && isnull(page3))
						{
							strcpy(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION);
					 		RewardPlayer(playerid);
						}
						else if(!isnull(page2) && isnull(page3))
						{
							PlayerUpdatePage[playerid] = 2;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Exit", "");
						}
						else if(!isnull(page2) && !isnull(page3))
						{
							PlayerUpdatePage[playerid] = 2;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Next", "Back");
						}
					}
				}
				case 2:
				{
					if(!response)
					{	
						PlayerUpdatePage[playerid] = 1;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Next", "Back");
					}
					else 
					{
						if(isnull(page3) && isnull(page4))
						{
							strcpy(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION);
							RewardPlayer(playerid);
						}
						else if(!isnull(page3) && isnull(page4))
						{
							PlayerUpdatePage[playerid] = 3;	
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Exit", "");
						}
						else if(!isnull(page3) && !isnull(page4))
						{
							PlayerUpdatePage[playerid] = 3;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Next", "Back");
						}
					}
				}
				case 3:
				{
					if(!response)
					{
						PlayerUpdatePage[playerid] = 2;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Next", "Back");
					}
					else
					{
						if(isnull(page4))
						{
							strcpy(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION);
							RewardPlayer(playerid);
						}
						else
						{
							PlayerUpdatePage[playerid] = 4;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page4, "Exit", "Back");
						}
					}
				}
				case 4:
				{
					if(!response)
					{
						PlayerUpdatePage[playerid] = 3;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Next", "Back");
					}
					else
					{
						strcpy(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION);
						RewardPlayer(playerid);
					}
				}
			}
		}
	}
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	Player_SetReward(playerid, false);
	PlayerUpdatePage[playerid] = 0;
	return continue(playerid);
}

CMD:update(playerid, params[])
{
	if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0)
		Player_SetReward(playerid, true);
		
	ShowPlayerUpdateList(playerid);
	return 1;
}