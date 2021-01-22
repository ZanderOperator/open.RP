#include <YSI_Coding\y_hooks>


static
	bool:SellingFish[MAX_PLAYERS],
	bool:GotRod[MAX_PLAYERS],
	FishingStamp[MAX_PLAYERS],
	FishSellStamp[MAX_PLAYERS];

/*
                                                                      
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'              

*/

LoadPlayerFishes(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_fishes WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerFishes", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerFishes(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_fishes(sqlid, fishworks, fishweight, fishingskill) \n\
                VALUES('%d', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,  "fishworks"	    , PlayerFish[playerid][pFishWorks]);
    cache_get_value_name_int(0,  "fishweight"	    , PlayerFish[playerid][pFishWeight]);
    cache_get_value_name_int(0,  "fishingskill"     , PlayerFish[playerid][pFishingSkill]);
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerFishes(playerid);
	return continue(playerid);
}

SavePlayerFishes(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_fishes SET fishworks = '%d', fishweight = '%d', fishingskill = '%d' WHERE sqlid = '%d'",
        PlayerFish[playerid][pFishWorks],
        PlayerFish[playerid][pFishWeight],
        PlayerFish[playerid][pFishingSkill],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerFishes(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerFish[playerid][pFishWorks] = 0;
    PlayerFish[playerid][pFishWeight] = 0;
    PlayerFish[playerid][pFishingSkill] = 0;

	SellingFish[playerid] = false;
	FishingStamp[playerid] = 0;
	FishSellStamp[playerid] = 0;
	return continue(playerid);
}

hook OnPlayerEnterCheckpoint(playerid) 
{
    if(SellingFish[playerid])
    {
        DisablePlayerCheckpoint(playerid);
        SellingFish[playerid] = false;
        SendClientMessage(playerid, COLOR_RED, "[!] Stigli ste na destinaciju. Kucajte /sellfish [kolicina] da prodate ribu.");
    }
    return 1;
}

stock IsAFBoat(carid) 
{
	switch(GetVehicleModel(carid)) 
	{
		case 472, 473, 493, 484, 430, 454, 453, 452, 446, 595: return 1;
	}
	return 0;
}

stock IsAtFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,1.0,403.8266,-2088.7598,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,398.7553,-2088.7490,7.8359))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,396.2197,-2088.6692,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,391.1094,-2088.7976,7.8359))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,383.4157,-2088.7849,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,374.9598,-2088.7979,7.8359))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,369.8107,-2088.7927,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,367.3637,-2088.7925,7.8359))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,362.2244,-2088.7981,7.8359) || IsPlayerInRangeOfPoint(playerid,1.0,354.5382,-2088.7979,7.8359))
		{
			return 1;
		}
	}
	return 0;
}

UpgradeFishingLevel(playerid) 
{
    PlayerFish[playerid][pFishingSkill] += 1;
    return 1;
}

DockFishing(playerid)
{
    new fstring[512];
    if(GotRod[playerid])
	{
		if(PlayerFish[playerid][pFishWeight] <= 100)
		{
			if(FishingStamp[playerid] < gettimestamp())
			{
				switch(PlayerFish[playerid][pFishingSkill])
				{
					case 0 .. 79:
					{
						switch(random(3))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					case 80 .. 129:
					{
						switch(random(5))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					default:
					{
						switch(random(6))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 5:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Bocaccio.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 10;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
				}
			}
			else SendClientMessage(playerid, COLOR_GRAD2, "  Morate cekati dvije sekunde prije iduceg lovljenja!");
		}
		else return  SendClientMessage(playerid, COLOR_RED, "[!] Dostigli ste maksimalnu kolicinu ulova. Otidjite, i prodajte ga.");
	}
	else return SendClientMessage(playerid, COLOR_RED, "[!] Nemate stap za pecanje, morate ga iznajmiti!");
	return 1;
}

BoatFishing(playerid)
{
    new fstring[512];
    if(IsPlayerInRangeOfPoint(playerid, 250.0, 580.4959,-2114.1504,5.4900) || IsPlayerInRangeOfPoint(playerid, 250.0, 93.3936,-2086.8057,-0.3839))
	{
  		if(PlayerFish[playerid][pFishWeight] <= 200)
		{
			if(FishingStamp[playerid] < gettimestamp())
			{
				switch(PlayerFish[playerid][pFishingSkill])
				{
					case 0 .. 79:
					{
						switch(random(3))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					case 80 .. 129:
					{
						switch(random(5))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					case 130 .. 239:
					{
						switch(random(9))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								PlayerFish[playerid][pFishWeight] += 2;
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 5:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Bocaccio.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								PlayerFish[playerid][pFishWeight] += 10;
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 6:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Red Snapper.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 13;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 7:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Mackerel.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 15;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 8:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Salema.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 18;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					case 240 .. 439:
					{
						switch(random(12))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);
								PlayerFish[playerid][pFishWeight] += 2;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 5:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Bocaccio.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 10;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 6:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Red Snapper.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 13;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 7:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Mackerel.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 15;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 8:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Salema.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 18;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 9:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci swordfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 31;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 10:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Raza.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 35;
								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 11:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Lemon shark.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 37;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
					default:
					{
						switch(random(13))
						{
							case 0:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, ne izvlaceci plijen.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 1:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Sheep Head.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 2;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 2:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci White Fish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 3;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 3:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Rockfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 6;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 4:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci catfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 8;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 5:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Bocaccio.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 10;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 6:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Red Snapper.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 13;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 7:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Mackerel.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 15;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 8:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Salema.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 18;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 9:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci swordfish.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 31;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 10:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Raza.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 35;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 11:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Lemon shark.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 37;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
							case 12:
							{
								format(fstring, sizeof fstring, "{C2A2DA}* %s zabacuju mamac nazad u vodu, te izvlaci Kraken.", GetName( playerid, false ));
								SetPlayerChatBubble(playerid, fstring, COLOR_PURPLE, 30.0, 4000);
								SendClientMessage(playerid, COLOR_PURPLE, fstring);

								PlayerFish[playerid][pFishWeight] += 90;

								FishingStamp[playerid] = gettimestamp() + 3;
								UpgradeFishingLevel(playerid);
							}
						}
					}
				}
			}
			else SendClientMessage(playerid, COLOR_RED, " [!] Morate cekati dvije sekunde prije iduceg lovljenja!");
		}
		else return  SendClientMessage(playerid, COLOR_RED, "[!] Dostigli ste maksimalnu kolicinu ulova. Otidjite, i prodajte ga.");
	}
	else return SendClientMessage(playerid, COLOR_RED, "[!] Ribu mo�ete loviti samo na teritoriji Santa Maria Beacha");
	return 1;
}

CMD:fishinghelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_RED,"_______________________________________");
    SendClientMessage(playerid, COLOR_RED,"          *** FISH HELP ***");
    SendClientMessage(playerid, COLOR_GREY,"*** FISHING *** /fish || /myfish");
    SendClientMessage(playerid, COLOR_GREY,"*** FISHING *** /sellfish || /fishingskills");
    return 1;
}

CMD:fishingskills(playerid, params[])
{
    new level = PlayerFish[playerid][pFishingSkill], string[61];
   	if(level >=0 && level < 80) SendClientMessage(playerid, COLOR_RED, "Fishing skill = 1"), format(string, sizeof(string), "Morate uspje�no pecati jo� %d puta da bi dobili skill-up.", 50 - level), SendClientMessage(playerid, COLOR_RED, string);
    else if(level >= 80 && level < 130) SendClientMessage(playerid, COLOR_RED, "Fishing skill = 2"), format(string, sizeof(string), "Morate uspje�no pecati jo� %d puta da bi dobili skill-up.", 100 - level), SendClientMessage(playerid, COLOR_RED, string);
	else if(level >=130 && level < 240) SendClientMessage(playerid, COLOR_RED, "Fishing skill = 3"), format(string, sizeof(string), "Morate uspje�no pecati jo� %d puta da bi dobili skill-up.", 200 - level), SendClientMessage(playerid, COLOR_RED, string);
	else if(level >=240 && level < 440) SendClientMessage(playerid, COLOR_RED, "Fishing skill = 4"), format(string, sizeof(string), "Morate uspje�no pecati jo� %d puta da bi dobili skill-up.", 400 - level), SendClientMessage(playerid, COLOR_RED, string);
	else if(level >=440) SendClientMessage(playerid, COLOR_RED, "Fishing skill = 5");
	return 1;
}

CMD:fish(playerid, params[])
{
    if(IsAtFishPlace(playerid))
	{
 		if(GotRod[playerid])
		{
        	DockFishing(playerid);
		}
		else return SendClientMessage(playerid, COLOR_RED, "[!] Nemate stap za pecanje, morate ga iznajmiti.");
	}
   	else if(IsAFBoat(GetPlayerVehicleID(playerid)))
	{
        BoatFishing(playerid);
    }
    else return SendClientMessage(playerid, COLOR_RED, "[!] Niste na mjestu za pecanje ribe");
	return 1;
}

CMD:myfish(playerid, params[]) {
    new fstring[512];
	format(fstring, sizeof(fstring), "[!] Kolicina ribe: %d kg.", PlayerFish[playerid][pFishWeight]);
	SendClientMessage(playerid, COLOR_RED, fstring);
	return 1;
}

CMD:sellfish(playerid, params[]) 
{

	new amount;
	new fstring[512];
    if(FishSellStamp[playerid] < gettimestamp())
    {
        if(PlayerFish[playerid][pFishWeight] < 20) return SendClientMessage(playerid, COLOR_GREY, "Morate imati minimalno 20kg, kako bi ih mogli prodati.");
        if(IsPlayerInRangeOfPoint(playerid, 30.0, 2623.5898,-2470.8184,3.0000))
        {
        	if(sscanf(params, "d", amount))
			{
				SendClientMessage(playerid, COLOR_GREY, "[?]: /sellfish [amount]");
				format(fstring, sizeof fstring, "[!] Kolicina ribe: %d kg.", PlayerFish[playerid][pFishWeight]);
				return SendClientMessage(playerid, COLOR_RED, fstring);
			}

            if(amount < 20) return SendClientMessage(playerid, COLOR_RED, "[!] Morate imati minimalno 20, kako bi ih mogli prodati.");
        	if(PlayerFish[playerid][pFishWeight] >= amount && PlayerFish[playerid][pFishWeight] != 0)
       		{
          		new paycheck = amount * randomEx(1,3);

                PlayerFish[playerid][pFishWeight] -= amount;
				format(fstring, sizeof(fstring), "[!] Prodao si %d kg mesa za %d$.", amount, paycheck);
				BudgetToPlayerMoney(playerid, paycheck);

				SendClientMessage(playerid, COLOR_RED, fstring);

				FishSellStamp[playerid] = gettimestamp() + 300;
			}
			else return SendClientMessage(playerid, COLOR_RED, " [!] Nemate toliku kolicu ribe!");
		}
		else
		{
            DisablePlayerCheckpoint(playerid);

		    GameTextForPlayer(playerid, "~b~WAYPOINT SET", 5000, 4);
            SellingFish[playerid] = true;
		    SetPlayerCheckpoint(playerid, 2623.5898,-2470.8184,3.0000, 10.0);
			return SendClientMessage(playerid, COLOR_RED, "[!] Uputite se ka mjestu za prodaju ribe");
		}
    }
    else SendClientMessage(playerid, COLOR_RED, "[!]Morate sacekati pet minuta do sljedece prodaje ribe.");
	return 1;
}

CMD:rentarod(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 375.0699,-2069.2192,7.8359))
	{
        PlayerToBudgetMoney(playerid, 150);
        SendClientMessage(playerid, COLOR_RED, "[!] Iznajmili ste stap za pecanje. (150$)");
        SendClientMessage(playerid, COLOR_RED, "[!] Upamtite da ce log out obrisati ovu funkciju.");
        GotRod[playerid] = true;
	}
    else return SendClientMessage(playerid, COLOR_RED, "[!] Niste na mjestu za iznajmljivanje stapa za pecanje.");
	return 1;
}

