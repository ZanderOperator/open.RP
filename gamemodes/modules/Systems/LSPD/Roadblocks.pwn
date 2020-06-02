#include <YSI\y_hooks>

#define MAX_ROADBLOCKS                ( 200 )

enum E_ROADBLOCK_INFO
{
	RoadblockName[60],
	RoadblockModel,
}

enum E_ROADBLOCK_DATA
{
	RoadblockObject,
	RoadblocksModelID,
	bool:RoadblockExists,
	RoadblockPlacedBy[34],
	RoadblockLocation[40],
	Float:RoadblockPos[3],
	RoadblockWorld,
	RoadblockInterior
}

new Roadblocks[40][E_ROADBLOCK_DATA];

static const g_aRoadblocks[][E_ROADBLOCK_INFO] = {
	{"Kraca barijera", 1949},
	{"Velika barijera", 978},
	{"Znak usmjeravanja", 1425},
	{"Znak upozorenja", 3265},
	{"Ograda", 19313},
	{"Semafor", 1263},
	{"Semafor sa postoljem", 1351},
	{"Lezeci policajac", 2145},
	{"Kratka barijera", 1459},
	{"Saobracajna barijera", 1282},
	{"Znak za detour", 1425},
	{"Barijera trake", 3091},
	{"Barijera puta", 1237},
	{"Barijera 2", 1424},
	{"Saobracajni cunj", 1238},
	{"Policijska traka", 19834},
	{"Barijera mala", 1427},
	{"Road work znak", 1228},
	{"Barijera #3", 1424},
	{"Road work znak #2", 1459},
	{"Command Post", -2156},
    {"SD Tape", -2162}
};

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/


hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(PlayerInfo[playerid][pAddingRoadblock])
	{
		if(response == EDIT_RESPONSE_CANCEL)
		{
			DestroyDynamicObject(PlayerInfo[playerid][pRoadblockObject]);
			PlayerInfo[playerid][pAddingRoadblock] = 0;
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			new
				id = -1,
				str[128];

			for(new i = 0; i < sizeof(Roadblocks); i++)
			{
				if(Roadblocks[i][RoadblockExists])
					continue;

				id = i;
				break;
			}

			if(id == -1)
			{
				SendClientMessage(playerid, COLOR_RED, "Ne možete više spawnati ovdje.");

				DestroyDynamicObject(PlayerInfo[playerid][pRoadblockObject]);
				PlayerInfo[playerid][pAddingRoadblock] = 0;
				return 1;
			}

			DestroyDynamicObject(PlayerInfo[playerid][pRoadblockObject]);

			format(str, sizeof(str), "** HQ: %s %s je dodao '%s' na lokaciji %s! **", ReturnPlayerRankName(playerid), GetName(playerid), GetRoadblockNameFromModel(PlayerInfo[playerid][pRoadblockModel]), GetPlayerStreet(playerid));
			SendLawMessage(COLOR_COP, str);

			format(Roadblocks[id][RoadblockLocation], 40, "%s", GetPlayerStreet(playerid));
			format(Roadblocks[id][RoadblockPlacedBy], 34, "%s", GetName(playerid));

			Roadblocks[id][RoadblockExists] = true;
			Roadblocks[id][RoadblocksModelID] = PlayerInfo[playerid][pRoadblockModel];

			Roadblocks[id][RoadblockPos][0] = x;
			Roadblocks[id][RoadblockPos][1] = y;
			Roadblocks[id][RoadblockPos][2] = z;

			Roadblocks[id][RoadblockObject] = CreateDynamicObject(PlayerInfo[playerid][pRoadblockModel], x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Roadblocks[id][RoadblockWorld] = GetPlayerVirtualWorld(playerid);
			Roadblocks[id][RoadblockInterior] = GetPlayerInterior(playerid);

			PlayerInfo[playerid][pAddingRoadblock] = 0;
			PlayerInfo[playerid][pRoadblockModel] = 0;
		}
		//printf("pEditingRoadblock called for %s.", GetName(playerid));
	}
  	return 1;
}

hook OnPlayerConnect(playerid)
{
	
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
	    case DIALOG_ROADBLOCKS:
        {
            if(response)
            {
                new
                    liststr[500];

                switch(listitem)
                {
                    case 0:
                    {
                        for(new i = 0; i < sizeof(g_aRoadblocks); i++)
                        {
                            format(liststr, sizeof(liststr), "%s%s\n", liststr, g_aRoadblocks[i][RoadblockName]);
                        }
                        ShowPlayerDialog(playerid, DIALOG_ROADBLOCK_LIST, DIALOG_STYLE_LIST, "Dostupne blokade:", liststr, "Odaberi", "<<");
                    }
                    case 1:
                    {
                        new
                            foundRoadblock;

                        for(new i = 0; i < sizeof(Roadblocks); i++)
                        {
                            if(!Roadblocks[i][RoadblockExists])
                                continue;

                            foundRoadblock++;
                            format(liststr, sizeof(liststr), "%s%s {AFAFAF}[%s - %s]\n", liststr, GetRoadblockNameFromModel(Roadblocks[i][RoadblocksModelID]), Roadblocks[i][RoadblockPlacedBy], Roadblocks[i][RoadblockLocation]);
                        }

                        if(foundRoadblock) return ShowPlayerDialog(playerid, DIALOG_ACTIVE_ROADBLOCKS, DIALOG_STYLE_LIST, "Aktivne blokade:", liststr, "Odaberi", "<<");
                        else return ShowPlayerDialog(playerid, DIALOG_ROADBLOCKS, DIALOG_STYLE_LIST, "Roadblocks Menu", "Postavi blokadu\nLista blokada:", "Odaberi", "Odustani");
                    }
                }
            }
            return 1;
        }
        case DIALOG_ROADBLOCK_LIST:
        {
            if(response)
            {
                new
                    foundRoom = 1,
                    count;

                for(new i = 0; i < sizeof(Roadblocks); i++)
                {
                    if(!Roadblocks[i][RoadblockExists])
                        continue;

                    count++;
                    if(count >= 60)
                        foundRoom = 0;
                }

                if(!foundRoom)
                {
                    SendClientMessage(playerid, COLOR_RED, "Dostigli ste limit roadblockova, ne mozete vise.");
                    return ShowPlayerDialog(playerid, DIALOG_ROADBLOCKS, DIALOG_STYLE_LIST, "Roadblocks Menu", "Postavi blokadu\nLista blokada:", "Odaberi", "Odustani");
                }

                new
                    Float:x,
                    Float:y,
                    Float:z, str[128];
                GetPlayerPos(playerid, x, y, z);

                PlayerInfo[playerid][pRoadblockObject] = CreateDynamicObject(g_aRoadblocks[listitem][RoadblockModel], x + 2, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
                PlayerInfo[playerid][pAddingRoadblock] = 1;
                PlayerInfo[playerid][pRoadblockModel] = g_aRoadblocks[listitem][RoadblockModel];
                EditDynamicObject(playerid, PlayerInfo[playerid][pRoadblockObject]);

                format(str, 128, "Spawnali ste {ADC3E7}%s blokadu.  Podesite lokaciju da je spawnujete.", GetRoadblockNameFromModel(g_aRoadblocks[listitem][RoadblockModel]));
                SendClientMessage(playerid, -1, str);
            }
            else return ShowPlayerDialog(playerid, DIALOG_ROADBLOCKS, DIALOG_STYLE_LIST, "Roadblocks Menu", "Postavi blokadu\nLista blokada:", "Odaberi", "Odustani");
            return 1;
        }
        case DIALOG_ACTIVE_ROADBLOCKS:
        {
            if(response)
            {
                new
                    primary[350],
                    detailstr[128];

                format(detailstr, 128, "{ADC3E7}Roadblock: %s\n", GetRoadblockNameFromModel(Roadblocks[listitem][RoadblocksModelID]));
                strcat(primary, detailstr);

                format(detailstr, 128, "{ADC3E7}Lokacija: %s\n", Roadblocks[listitem][RoadblockLocation]);
                strcat(primary, detailstr);

                format(detailstr, 128, "{ADC3E7}Postavljena: %s\n\n", Roadblocks[listitem][RoadblockPlacedBy]);
                strcat(primary, detailstr);
/*
                strcat(primary, "Click '{ADC3E7}Yes da sklonite ovu blokadu.");

                ShowPlayerDialog(playerid, DIALOG_ACTIVE_ROADBLOCKS, DIALOG_STYLE_MSGBOX, "Roadblock", primary, "OnRoadblockDisband", listitem);
*/
			}
            else return ShowPlayerDialog(playerid, DIALOG_ROADBLOCKS, DIALOG_STYLE_LIST, "Roadblocks Menu", "Postavi blokadu\nLista blokada:", "Odaberi", "Odustani");
            return 1;
        }
	}
	return 0;
}

//Khawaja

stock GetRoadblockNameFromModel(model_id)
{
	new
		modelname[30] = "None";

	for(new i = 0; i < sizeof(g_aRoadblocks); i++)
	{
		if(model_id == g_aRoadblocks[i][RoadblockModel])
		{
			format(modelname, 30, "%s", g_aRoadblocks[i][RoadblockName]);
		}
	}
	return modelname;
}

stock IsPlayerNearRoadblock(playerid)
{
	for(new i = 0; i < sizeof(Roadblocks); i++)
	{
		if(!Roadblocks[i][RoadblockExists])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][RoadblockPos][0], Roadblocks[i][RoadblockPos][1], Roadblocks[i][RoadblockPos][2]) && GetPlayerVirtualWorld(playerid) == Roadblocks[i][RoadblockWorld])
			return i;
	}
	return -1;
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
CMD:roadblock(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid) && !IsAFM(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	if(PlayerInfo[playerid][pAddingRoadblock])
		return SendClientMessage(playerid, COLOR_RED, "Prvo prestanite postavljati prepreku...");

	ShowPlayerDialog(playerid, DIALOG_ROADBLOCKS, DIALOG_STYLE_LIST, "Roadblocks Menu", "Postavi Roadblock\nRoadblock List", "Odaberi", "Odustani");
	return 1;
}

CMD:rrb(playerid, params[])
{

	if( !IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	new
		id, str[128];

 	if( (id = IsPlayerNearRoadblock(playerid)) != -1)
	{
      	format(str, sizeof(str), "** HQ: %s %s unistava roadblock '%s' sa lokacije %s! **", ReturnPlayerRankName(playerid), GetName(playerid, true),
			GetRoadblockNameFromModel(Roadblocks[id][RoadblocksModelID]), Roadblocks[id][RoadblockLocation]);
		SendRadioMessage(1, COLOR_COP, str);
		SendClientMessage(playerid, COLOR_RED, "Uspješno ste obrisali roadblock");
		DestroyDynamicObject(Roadblocks[id][RoadblockObject]);
		Roadblocks[id][RoadblockExists] = false;
		for(new i = 0; i < 3; i++) Roadblocks[id][RoadblockPos][i] = 0.0;
	}
	else return SendClientMessage(playerid, COLOR_RED, "Niste u blizni prepreke.");
	return 1;
}

CMD:removeall(playerid, params[])
{

	if( !IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	new
		str[128];

 	for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
		DestroyDynamicObject(Roadblocks[i][RoadblockObject]);
		Roadblocks[i][RoadblockExists] = false;
	}
	format(str, sizeof(str), "** HQ: %s %s je sklonio sve roadblockove! **", ReturnPlayerRankName(playerid), GetName(playerid, true));

	SendRadioMessage(1, COLOR_COP, str);
	SendRadioMessage(3, COLOR_COP, str);
	SendClientMessage(playerid, COLOR_RED, "Uspješno ste obrisali roadblockove");
	return 1;
}
