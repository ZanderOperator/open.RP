#include <YSI_Coding\y_hooks>

#define MAX_Labels                ( 200 )

enum E_RPTEXT_DATA
{
	RoadblockObject,
	LabelsModelID,
	bool:RoadblockExists,
	RoadblockPlacedBy[34],
	RoadblockLocation[40],
	Float:RoadblockPos[3],
	RoadblockWorld,
	RoadblockInterior
}
static 
	Labels[40][E_RPTEXT_DATA];

static 
	bool:AddingRoadblock[MAX_PLAYERS],
	RoadblockObject[MAX_PLAYERS],
	RoadblockModel[MAX_PLAYERS];


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
    if(AddingRoadblock[playerid])
	{
		if(response == EDIT_RESPONSE_CANCEL)
		{
			DestroyDynamicObject(RoadblockObject[playerid]);
			AddingRoadblock[playerid] = false;
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			new
				id = -1,
				str[128];

			for(new i = 0; i < sizeof(Labels); i++)
			{
				if(Labels[i][RoadblockExists])
					continue;

				id = i;
				break;
			}

			if(id == -1)
			{
				SendClientMessage(playerid, COLOR_RED, "Ne mozete vise spawnati ovdje.");

				DestroyDynamicObject(RoadblockObject[playerid]);
				AddingRoadblock[playerid] = false;
				return 1;
			}

			DestroyDynamicObject(RoadblockObject[playerid]);

			format(str, sizeof(str), "** HQ: %s %s je dodao '%s' na lokaciji %s! **", ReturnPlayerRankName(playerid), GetName(playerid), GetRoadblockNameFromModel(RoadblockModel[playerid]), GetPlayerStreet(playerid));
			SendLawMessage(COLOR_COP, str);

			format(Labels[id][RoadblockLocation], 40, "%s", GetPlayerStreet(playerid));
			format(Labels[id][RoadblockPlacedBy], 34, "%s", GetName(playerid));

			Labels[id][RoadblockExists] = true;
			Labels[id][LabelsModelID] = RoadblockModel[playerid];

			Labels[id][RoadblockPos][0] = x;
			Labels[id][RoadblockPos][1] = y;
			Labels[id][RoadblockPos][2] = z;

			Labels[id][RoadblockObject] = CreateDynamicObject(RoadblockModel[playerid], x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Labels[id][RoadblockWorld] = GetPlayerVirtualWorld(playerid);
			Labels[id][RoadblockInterior] = GetPlayerInterior(playerid);

			AddingRoadblock[playerid] = false;
			RoadblockModel[playerid] = 0;
		}
		//printf("pEditingRoadblock called for %s.", GetName(playerid));
	}
  	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	AddingRoadblock[playerid] = false;
	RoadblockObject[playerid] = 0;
	RoadblockModel[playerid] = 0;
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
	    case DIALOG_Labels:
        {
            if(response)
            {
                new
                    liststr[500];

                switch(listitem)
                {
                    case 0:
                    {
                        for(new i = 0; i < sizeof(g_aLabels); i++)
                        {
                            format(liststr, sizeof(liststr), "%s%s\n", liststr, g_aLabels[i][RoadblockName]);
                        }
                        ShowPlayerDialog(playerid, DIALOG_ROADBLOCK_LIST, DIALOG_STYLE_LIST, "Dostupne blokade:", liststr, "Choose", "<<");
                    }
                    case 1:
                    {
                        new
                            foundRoadblock;

                        for(new i = 0; i < sizeof(Labels); i++)
                        {
                            if(!Labels[i][RoadblockExists])
                                continue;

                            foundRoadblock++;
                            format(liststr, sizeof(liststr), "%s%s {AFAFAF}[%s - %s]\n", liststr, GetRoadblockNameFromModel(Labels[i][LabelsModelID]), Labels[i][RoadblockPlacedBy], Labels[i][RoadblockLocation]);
                        }

                        if(foundRoadblock) return ShowPlayerDialog(playerid, DIALOG_ACTIVE_Labels, DIALOG_STYLE_LIST, "Aktivne blokade:", liststr, "Choose", "<<");
                        else return ShowPlayerDialog(playerid, DIALOG_Labels, DIALOG_STYLE_LIST, "Labels Menu", "Postavi blokadu\nLista blokada:", "Choose", "Abort");
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

                for(new i = 0; i < sizeof(Labels); i++)
                {
                    if(!Labels[i][RoadblockExists])
                        continue;

                    count++;
                    if(count >= 29)
                        foundRoom = 0;
                }

                if(!foundRoom)
                {
                    SendClientMessage(playerid, COLOR_RED, "Dostigli ste limit roadblockova, ne mozete vise.");
                    return ShowPlayerDialog(playerid, DIALOG_Labels, DIALOG_STYLE_LIST, "Labels Menu", "Postavi blokadu\nLista blokada:", "Choose", "Abort");
                }

                new
                    Float:x,
                    Float:y,
                    Float:z, str[128];
                GetPlayerPos(playerid, x, y, z);

                RoadblockObject[playerid] = CreateDynamicObject(g_aLabels[listitem][RoadblockModel], x + 2, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
                AddingRoadblock[playerid] = true;
                RoadblockModel[playerid] = g_aLabels[listitem][RoadblockModel];
                EditDynamicObject(playerid, RoadblockObject[playerid]);

                format(str, 128, "Spawnali ste {ADC3E7}%s blokadu.  Podesite lokaciju da je spawnujete.", GetRoadblockNameFromModel(g_aLabels[listitem][RoadblockModel]));
                SendClientMessage(playerid, -1, str);
            }
            else return ShowPlayerDialog(playerid, DIALOG_Labels, DIALOG_STYLE_LIST, "Labels Menu", "Postavi blokadu\nLista blokada:", "Choose", "Abort");
            return 1;
        }
        case DIALOG_ACTIVE_Labels:
        {
            if(response)
            {
                new
                    primary[350],
                    detailstr[128];

                format(detailstr, 128, "{ADC3E7}Roadblock: %s\n", GetRoadblockNameFromModel(Labels[listitem][LabelsModelID]));
                strcat(primary, detailstr);

                format(detailstr, 128, "{ADC3E7}Lokacija: %s\n", Labels[listitem][RoadblockLocation]);
                strcat(primary, detailstr);

                format(detailstr, 128, "{ADC3E7}Postavljena: %s\n\n", Labels[listitem][RoadblockPlacedBy]);
                strcat(primary, detailstr);
/*
                strcat(primary, "Click '{ADC3E7}Yes da sklonite ovu blokadu.");

                ShowPlayerDialog(playerid, DIALOG_ACTIVE_Labels, DIALOG_STYLE_MSGBOX, "Roadblock", primary, "OnRoadblockDisband", listitem);
*/
			}
            else return ShowPlayerDialog(playerid, DIALOG_Labels, DIALOG_STYLE_LIST, "Labels Menu", "Postavi blokadu\nLista blokada:", "Choose", "Abort");
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

	for(new i = 0; i < sizeof(g_aLabels); i++)
	{
		if(model_id == g_aLabels[i][RoadblockModel])
		{
			format(modelname, 30, "%s", g_aLabels[i][RoadblockName]);
		}
	}
	return modelname;
}

stock IsPlayerNearRoadblock(playerid)
{
	for(new i = 0; i < sizeof(Labels); i++)
	{
		if(!Labels[i][RoadblockExists])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 5.0, Labels[i][RoadblockPos][0], Labels[i][RoadblockPos][1], Labels[i][RoadblockPos][2]) && GetPlayerVirtualWorld(playerid) == Labels[i][RoadblockWorld])
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
	if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid) && !IsAFM(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	if(AddingRoadblock[playerid])
		return SendClientMessage(playerid, COLOR_RED, "Prvo prestanite postavljati prepreku...");

	ShowPlayerDialog(playerid, DIALOG_Labels, DIALOG_STYLE_LIST, "Labels Menu", "Postavi Roadblock\nRoadblock List", "Choose", "Abort");
	return 1;
}

CMD:rrb(playerid, params[])
{

	if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	new
		id, str[128];

 	if((id = IsPlayerNearRoadblock(playerid)) != -1)
	{
      	format(str, sizeof(str), "** HQ: %s %s unistava roadblock '%s' sa lokacije %s! **", ReturnPlayerRankName(playerid), GetName(playerid, true),
			GetRoadblockNameFromModel(Labels[id][LabelsModelID]), Labels[id][RoadblockLocation]);
		SendRadioMessage(1, COLOR_COP, str);
		SendClientMessage(playerid, COLOR_RED, "Uspje�no ste obrisali roadblock");
		DestroyDynamicObject(Labels[id][RoadblockObject]);
		Labels[id][RoadblockExists] = false;
		for(new i = 0; i < 3; i++) Labels[id][RoadblockPos][i] = 0.0;
	}
	else return SendClientMessage(playerid, COLOR_RED, "Niste u blizni prepreke.");
	return 1;
}

CMD:removeall(playerid, params[])
{

	if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

	new
		str[128];

 	for(new i = 0; i < sizeof(Labels); i++)
  	{
		DestroyDynamicObject(Labels[i][RoadblockObject]);
		Labels[i][RoadblockExists] = false;
	}
	format(str, sizeof(str), "** HQ: %s %s je sklonio sve roadblockove! **", ReturnPlayerRankName(playerid), GetName(playerid, true));

	SendRadioMessage(1, COLOR_COP, str);
	SendRadioMessage(3, COLOR_COP, str);
	SendClientMessage(playerid, COLOR_RED, "Uspje�no ste obrisali roadblockove");
	return 1;
}
