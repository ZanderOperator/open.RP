/*
                                                                                            
88 888b      88   ,ad8888ba,  88         88        88 88888888ba,   88888888888 ad88888ba   
88 8888b     88  d8"'    `"8b 88         88        88 88      `"8b  88         d8"     "8b  
88 88 `8b    88 d8'           88         88        88 88        `8b 88         Y8,          
88 88  `8b   88 88            88         88        88 88         88 88aaaaa    `Y8aaaaa,    
88 88   `8b  88 88            88         88        88 88         88 88"""""      `"""""8b,  
88 88    `8b 88 Y8,           88         88        88 88         8P 88                 `8b  
88 88     `8888  Y8a.    .a8P 88         Y8a.    .a8P 88      .a8P  88         Y8a     a8P  
88 88      `888   `"Y8888Y"'  88888888888 `"Y8888Y"'  88888888Y"'   88888888888 "Y88888P"   
                                                                                            
*/

#include <YSI_Coding\y_hooks>

/*

  ,ad8888ba,   ,ad8888ba,   888b      88  ad88888ba 888888888888 ad88888ba   
 d8"'    `"8b d8"'    `"8b  8888b     88 d8"     "8b     88     d8"     "8b  
d8'          d8'        `8b 88 `8b    88 Y8,             88     Y8,          
88           88          88 88  `8b   88 `Y8aaaaa,       88     `Y8aaaaa,    
88           88          88 88   `8b  88   `"""""8b,     88       `"""""8b,  
Y8,          Y8,        ,8P 88    `8b 88         `8b     88             `8b  
 Y8a.    .a8P Y8a.    .a8P  88     `8888 Y8a     a8P     88     Y8a     a8P  
  `"Y8888Y"'   `"Y8888Y"'   88      `888  "Y88888P"      88      "Y88888P"   

*/


const MAX_ROADBLOCKS        = 50;
const MAX_ROADBLOCK_TYPES   = 14;
const DIALOG_ROADBLOCK_SELECT = 342342;

/*

                                                    
8b           d8  db        88888888ba   ad88888ba   
`8b         d8' d88b       88      "8b d8"     "8b  
 `8b       d8' d8'`8b      88      ,8P Y8,          
  `8b     d8' d8'  `8b     88aaaaaa8P' `Y8aaaaa,    
   `8b   d8' d8YaaaaY8b    88""""88'     `"""""8b,  
    `8b d8' d8""""""""8b   88    `8b           `8b  
     `888' d8'        `8b  88     `8b  Y8a     a8P  
      `8' d8'          `8b 88      `8b  "Y88888P"   

*/

enum E_ROADBLOCK_LIST
{
    rName[20],
    rObjectID
}
static RoadblockList[MAX_ROADBLOCK_TYPES][E_ROADBLOCK_LIST] = {
    {"Small blockade",      1459},
    {"Big blockade",        1052},
    {"Signaling cone",      1238},
    {"Direction sign",      1425},
    {"Warning sign",        3625},
    {"Routing block",       3091},
    {"Big signaling cone",  1237},
    {"Traffic railing",     19313},
    {"Semaphore",           1352},
    {"STOP sign",           19966},
    {"One direction sign",  19967},
    {"Road closed sign",    19972},
    {"Work zone sign",      19975},
    {"Traffic tape",        19834}
};

enum E_ROADBLOCK_DATA
{
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
    sListID
}

static
    Iterator:Roadblock<MAX_ROADBLOCKS>,
    Roadblocks[MAX_ROADBLOCKS][E_ROADBLOCK_DATA],
    EditingRoadblock[MAX_PLAYERS];

/*
                                                                 
88888888888 88        88 888b      88   ,ad8888ba,   ad88888ba   
88          88        88 8888b     88  d8"'    `"8b d8"     "8b  
88          88        88 88 `8b    88 d8'           Y8,          
88aaaaa     88        88 88  `8b   88 88            `Y8aaaaa,    
88"""""     88        88 88   `8b  88 88              `"""""8b,  
88          88        88 88    `8b 88 Y8,                   `8b  
88          Y8a.    .a8P 88     `8888  Y8a.    .a8P Y8a     a8P  
88           `"Y8888Y"'  88      `888   `"Y8888Y"'   "Y88888P"   

*/   

static DeleteRoadblock(r_id)
{
    Roadblocks[r_id][sX] = 0.0;
    Roadblocks[r_id][sY] = 0.0;
    Roadblocks[r_id][sZ] = 0.0;
    if(IsValidDynamicObject(Roadblocks[r_id][sObject]))
        DestroyDynamicObject(Roadblocks[r_id][sObject]);
    Roadblocks[r_id][sListID] = -1;
    
    return 1;
}

static CreateRoadblock(playerid, id)
{

    new 
        i = Iter_Free(Roadblock),
        Float:x,
        Float:y,
        Float:z,
        Float:Angle;
    
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, Angle);

    Roadblocks[i][sX] = x;
    Roadblocks[i][sY] = y;
    Roadblocks[i][sZ] = z-0.7;
    Roadblocks[i][sObject] = CreateDynamicObject(RoadblockList[id][rObjectID], x, y, z+2.0, 0, 0, Angle);
    Roadblocks[i][sListID] = id;

    EditDynamicObject(playerid, Roadblocks[i][sObject]);

    va_SendMessage(playerid, 
        MESSAGE_TYPE_INFO, 
        "%s has been created. Please adjust its position and save it!",
        RoadblockList[id][rName]
    );
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    return 1;
}

static DeleteAllRoadblocks(playerid)
{
    foreach(new i: Roadblock)
    {
        if(IsPlayerInRangeOfPoint(playerid, 100.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
            DeleteRoadblock(i);
    }
    Iter_Clear(Roadblock);
    return 1;
}

static DeleteClosestRoadblock(playerid)
{
    foreach(new i: Roadblock)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
            DeleteRoadblock(i);
            new 
                next;
            Iter_SafeRemove(Roadblock, i, next);
            return 1;
        }
    }
    return 1;
}

/*
                                               
  ,ad8888ba,  88b           d88 88888888ba,    
 d8"'    `"8b 888b         d888 88      `"8b   
d8'           88`8b       d8'88 88        `8b  
88            88 `8b     d8' 88 88         88  
88            88  `8b   d8'  88 88         88  
Y8,           88   `8b d8'   88 88         8P  
 Y8a.    .a8P 88    `888'    88 88      .a8P   
  `"Y8888Y"'  88     `8'     88 88888888Y"'  
    
*/

CMD:rb(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, " You are not PD/SD/FD!");
    if(PlayerFaction[playerid][pRank] < 2)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You should be Rank 2+ for this action!");
    if(Iter_Free(Roadblock) == -1)
    {
        va_SendMessage(playerid, 
            MESSAGE_TYPE_ERROR, 
            "Max. limit of roadblocks has been reached! (%d)",
            MAX_ROADBLOCKS
        );
        return 1;
    }

    new 
        motd[24],
        buffer[MAX_ROADBLOCK_TYPES * 24],
        bool:broken = false;

    for(new i = 0; i < MAX_ROADBLOCK_TYPES; i++)
    {
        format(motd, 
            24, 
            "%s%s", 
            (!broken) ? ("") : ("\n"),
            RoadblockList[i][rName]  
        );
        strcat(buffer, motd);
        broken = true;
    }
    ShowPlayerDialog(playerid, 
        DIALOG_ROADBLOCK_SELECT, 
        DIALOG_STYLE_LIST, 
        "Choose roadblock type", 
        buffer, 
        "Choose", 
        "Close"
    );
    return 1;
}

CMD:rrb(playerid, params[])
{
    // TODO: reduce level of nesting
    if(IsACop(playerid) || IsFDMember(playerid) || IsASD(playerid))
    {
        if(PlayerFaction[playerid][pRank] >= 2)
        {
            DeleteClosestRoadblock(playerid);
            GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
        }
        else SendClientMessage(playerid, COLOR_RED, "Nisi Rank 3!");
    }
    return 1;
}

CMD:removeall(playerid, params[])
{
    // TODO: reduce level of nesting
    if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || PlayerInfo[playerid][pAdmin] >= 2)
    {
        if(PlayerFaction[playerid][pRank] >= 1 || PlayerInfo[playerid][pAdmin] >= 2)
        {
            if(PlayerFaction[playerid][pMember] == 1 && PlayerFaction[playerid][pRank] < 1) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are currentyl suspended!");

            DeleteAllRoadblocks(playerid);

            new
                string[100];
            format(string, 
                sizeof(string),
                "[HQ]: %s %s removed all the roadblocks currently placed, over.", 
                (PlayerInfo[playerid][pAdmin] > 0) ? ("Game Admin") :
                    ReturnRankName(PlayerFaction[playerid][pRank], playerid),
                GetName(playerid)
            );
            SendRadioMessage(1, COLOR_LIGHTBLUE, string);
            GameTextForPlayer(playerid,"~b~All ~w~Roadblocks ~r~Removed!",3000,1);
        }
    }
    return 1;
}

/*

88        88   ,ad8888ba,     ,ad8888ba,   88      a8P  ad88888ba   
88        88  d8"'    `"8b   d8"'    `"8b  88    ,88'  d8"     "8b  
88        88 d8'        `8b d8'        `8b 88  ,88"    Y8,          
88aaaaaaaa88 88          88 88          88 88,d88'     `Y8aaaaa,    
88""""""""88 88          88 88          88 8888"88,      `"""""8b,  
88        88 Y8,        ,8P Y8,        ,8P 88P   Y8b           `8b  
88        88  Y8a.    .a8P   Y8a.    .a8P  88     "88, Y8a     a8P  
88        88   `"Y8888Y"'     `"Y8888Y"'   88       Y8b "Y88888P"   

*/

hook OnGameModeInit()
{
    Iter_Init(Roadblock);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    EditingRoadblock[playerid] = -1;
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_ROADBLOCK_SELECT)
    {
        if(!response)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have aborted roadblock selection.");
        
        CreateRoadblock(playerid, listitem);
    }
    return 1;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(EditingRoadblock[playerid] != -1)
	{
        new 
			r_id = EditingRoadblock[playerid],
            list_id = Roadblocks[r_id][sListID];

		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);

		if(response == EDIT_RESPONSE_FINAL)
		{
			Roadblocks[r_id][sX] = x;
            Roadblocks[r_id][sY] = y;
            Roadblocks[r_id][sZ] = z;
		
			va_SendMessage(playerid, 
				MESSAGE_TYPE_SUCCESS, 
				"You have sucessfully placed %s.", 
				RoadblockList[list_id][rName]
			);

			EditingRoadblock[playerid] = -1;
            Iter_Add(Roadblock, r_id);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
            DeleteRoadblock(r_id);
			EditingRoadblock[playerid] = -1;
			SendMessage(playerid, MESSAGE_TYPE_INFO, "You have aborted roadblock placement.");
		}
	}
	return 1;
}