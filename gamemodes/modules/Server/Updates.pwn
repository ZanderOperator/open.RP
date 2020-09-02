#include <YSI\y_hooks>

// Server Updates Dialog by Logan - July 2019.
static 	
		page1[1280],
		page2[1280],
		page3[1280],
		page4[1280],
		updatestring[1280*4],
		updateCaption[80];

stock LoadUpdateList()
{
    new File:handle = fopen("Changelog.txt", io_read),
        buffer[200];
    
    if(handle)
    {
        while(fread(handle, buffer))
		{
			if(strlen(updatestring) < 1280)
				strcat(page1, buffer, sizeof(page1));
			else if(strlen(updatestring) >= 1280 && strlen(updatestring) < (1280*2))
				strcat(page2, buffer, sizeof(page2));
			else if(strlen(updatestring) >= (1280*2) && strlen(updatestring) < (1280*3))
				strcat(page3, buffer, sizeof(page3));
			else if(strlen(updatestring) >= (1280*3))
				strcat(page4, buffer, sizeof(page4));

            strcat(updatestring, buffer, sizeof(updatestring));
		}   
        format(updateCaption, sizeof(updateCaption), "%s Update", SCRIPT_VERSION);
        fclose(handle);
    }
    else print("The file \"changelog.txt\" does not exists, or can't be opened.");
    return 1;
}

stock ShowPlayerUpdateList(playerid)
{
	if(isnull(page2))	
		ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Izlaz", "");
	else 
		ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Dalje", "Natrag");
	PlayerUpdatePage[playerid] = 1;
	return 1;
}

stock RewardPlayer(playerid)
{
	if(PlayerInfo[playerid][pLevel] >= 3 && PlayerReward[playerid])
	{
		new rand = random(100);
		switch(rand)
		{
			case 0..49:
			{
				BudgetToPlayerMoney(playerid, 500);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 500$. Ugodnu igru zeli Vam City of Angels Team!");
			}
			case 50..89:
			{
				ExpInfo[playerid][ePoints] += 1;
				ExpInfo[playerid][eAllPoints] += 1;
				SavePlayerExperience(playerid);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 1 EXP bodom. Ugodnu igru zeli Vam City of Angels Team!");
			}
			case 90..99:
			{
				ExpInfo[playerid][ePoints] += 5;
				ExpInfo[playerid][eAllPoints] += 5;
				SavePlayerExperience(playerid);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Povodom novog updatea, nagradjeni ste sa 5 EXP bodova. Ugodnu igru zeli Vam City of Angels Team!");
			}
		}
		PlayerReward[playerid] = false;
	}
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
						format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
						RewardPlayer(playerid);
					}
					else 
					{
						if(isnull(page2))
						{
							format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
							return RewardPlayer(playerid);
						}
						else if(isnull(page3))
						{
							PlayerUpdatePage[playerid] = 2;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Izlaz", "");
						}
						else if(!isnull(page2) && !isnull(page3))
						{
							PlayerUpdatePage[playerid] = 2;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Dalje", "Natrag");
						}
					}
				}
				case 2:
				{
					if(!response)
					{	
						PlayerUpdatePage[playerid] = 1;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page1, "Dalje", "Natrag");
					}
					else 
					{
						if(isnull(page3))
						{
							format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
							return RewardPlayer(playerid);
						}
						else if(isnull(page4))
						{
							PlayerUpdatePage[playerid] = 3;	
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Izlaz", "");
						}
						else if(!isnull(page3) && !isnull(page4))
						{
							PlayerUpdatePage[playerid] = 3;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Dalje", "Natrag");
						}
					}
				}
				case 3:
				{
					if(!response)
					{
						PlayerUpdatePage[playerid] = 2;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page2, "Dalje", "Natrag");
					}
					else
					{
						if(isnull(page4))
						{
							format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
							return RewardPlayer(playerid);
						}
						else
						{
							PlayerUpdatePage[playerid] = 4;
							ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page4, "Izlaz", "Natrag");
						}
					}
				}
				case 4:
				{
					if(!response)
					{
						PlayerUpdatePage[playerid] = 3;
						ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, page3, "Dalje", "Natrag");
					}
					else
					{
						format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
						RewardPlayer(playerid);
					}
				}
			}
		}
	}
	return 1;
}

CMD:update(playerid, params[])
{
	if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0)
		PlayerReward[playerid] = true;
		
	ShowPlayerUpdateList(playerid);
	return 1;
}