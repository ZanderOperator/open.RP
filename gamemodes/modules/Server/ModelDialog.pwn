// Model Selection handler for fSelect.inc 

#include <YSI_Coding\y_hooks>

static 
	ModelToID[MAX_PLAYERS][MAX_MENU_ITEMS],
	Iterator: Skin<MAX_MENU_ITEMS>,
	Iterator: SelectionModel[MAX_PLAYERS]<MAX_MENU_ITEMS>;


stock ResetModelShuntVar(playerid)
{
	for(new i = 0; i < MAX_MENU_ITEMS; i++)
		ModelToID[playerid][i] = -1;

	Iter_Clear(SelectionModel[playerid]);
	return 1;
}

stock ShowSkinModelDialog(playerid)
{
    foreach(new i: Skin)
	{
		fselection_add_item(playerid, ServerSkins[sSkinID][i]);
		Player_ModelToIndexSet(playerid, i, ServerSkins[sSkinID][i]);
    }
	fselection_show(playerid, ms_SKINS, "Clothes");
    return 1;
}

Player_ModelToIndex(playerid, modelid)
{
	static index = 0;
	foreach(new mid: SelectionModel[playerid])
	{
		if(ModelToID[playerid][mid] == modelid)
		{
			index = mid;
			break;
		}
	}
	return index; 
}

Player_ModelToIndexSet(playerid, i, value)
{
	new id = Iter_Free(SelectionModel[playerid]);
	ModelToID[playerid][id] = value;
	Iter_Add(SelectionModel[playerid], i);
	return 1;
}

LoadServerSkins(f_name[])
{
	Iter_Init(Skin);

    new 
		File:f, 
		str[75];
	format(str, sizeof(str), "%s", f_name);
	f = fopen(str, io_read);
	if(!f) 
    {
		printf("WARNING: Failed to load Model List: \"%s\"", f_name);
		return 1;
	}
    new line[128], idx = 0, idxx = 0;
	while(fread(f,line,sizeof(line),false))
	{
		if(idx >= MAX_MENU_ITEMS)
		{
			printf("WARNING: Reached maximum amount of items, increase \"MAX_MENU_ITEMS\"", f_name);
			break;
		}
		if(!line[0]) continue;
		idxx = 0;
		ServerSkins[sSkinID][idx] = strval(strtok(line,idxx));
		ServerSkins[sPrice][idx] = strval(strtok(line,idxx));

		Iter_Add(Skin, idx);
        idx++;
    }
	printf("[scriptfiles/skins.txt]: Sucessfully Loaded Server Skins. [%d/%d]", idx, MAX_SERVER_SKINS);
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    ResetModelShuntVar(playerid);
    return continue(playerid);
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
	if(!response)
		ResetModelShuntVar(playerid);
	return 1;
}