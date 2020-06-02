#include <YSI\y_hooks>

// Server Updates Dialog by Logan - July 2019.
static 	updateString[4096],
		updateCaption[80];

stock LoadUpdateList()
{
	new File:handle = fopen("Changelog.txt", io_read),
		buffer[200];
	
	if(handle)
	{
		while(fread(handle, buffer))
			strcat(updateString, buffer, sizeof(updateString));
			
		format(updateCaption, sizeof(updateCaption), "%s Update", SCRIPT_VERSION);
		fclose(handle);
	}
	else print("The file \"changelog.txt\" does not exists, or can't be opened.");
	return 1;
}

stock ShowPlayerUpdateList(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_UPDATE_LIST, DIALOG_STYLE_MSGBOX, updateCaption, updateString, "Zatvori", "");
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
			format(PlayerInfo[playerid][pLastUpdateVer], 24, "%s", SCRIPT_VERSION);
			RewardPlayer(playerid);
			return 1;
		}
	}
	return 1;
}

CMD:update(playerid, params[])
{
	ShowPlayerUpdateList(playerid);
	return 1;
}