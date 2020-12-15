/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>


/*
    ########  ######## ######## #### ##    ## ######## 
    ##     ## ##       ##        ##  ###   ## ##       
    ##     ## ##       ##        ##  ####  ## ##       
    ##     ## ######   ######    ##  ## ## ## ######   
    ##     ## ##       ##        ##  ##  #### ##       
    ##     ## ##       ##        ##  ##   ### ##       
    ########  ######## ##       #### ##    ## ######## 
*/

#define ZONE_WIDTH          150.0
#define ZONE_HEIGHT         195.0


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static
    Timer:PlayerCMPTimer[MAX_PLAYERS],
    SelectedRoom[MAX_PLAYERS],
    InApartmentComplex[MAX_PLAYERS] = {INVALID_COMPLEX_ID, ...},
    InApartmentRoom   [MAX_PLAYERS] = {INVALID_COMPLEX_ID, ...};

static
    PlayerText:CompBcg1    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:CompBcg2    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:CompInfoText[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:CompInfoTD  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:CompCMDTD   [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

Player_InApartmentComplex(playerid)
{
    return InApartmentComplex[playerid];
}

Player_SetInApartmentComplex(playerid, v)
{
    InApartmentComplex[playerid] = v;
}

Player_InApartmentRoom(playerid)
{
    return InApartmentRoom[playerid];
}

Player_SetInApartmentRoom(playerid, v)
{
    InApartmentRoom[playerid] = v;
}

hook ResetPlayerVariables(playerid)
{
    Player_SetInApartmentComplex(playerid, INVALID_COMPLEX_ID);
    Player_SetInApartmentRoom   (playerid, INVALID_COMPLEX_ID);
    return 1;
}

stock DestroyCompInfoTD(playerid)
{
    stop PlayerCMPTimer[playerid];
    PlayerTextDrawDestroy(playerid, CompBcg1[playerid]);
    PlayerTextDrawDestroy(playerid, CompBcg2[playerid]);
    PlayerTextDrawDestroy(playerid, CompInfoText[playerid]);
    PlayerTextDrawDestroy(playerid, CompInfoTD[playerid]);
    PlayerTextDrawDestroy(playerid, CompCMDTD[playerid]);

    CompBcg1    [playerid] = PlayerText:INVALID_TEXT_DRAW;
    CompBcg2    [playerid] = PlayerText:INVALID_TEXT_DRAW;
    CompInfoText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    CompInfoTD  [playerid] = PlayerText:INVALID_TEXT_DRAW;
    CompCMDTD   [playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}

stock LoadComplexes()
{
    mysql_pquery(g_SQL,
        va_fquery(g_SQL, "SELECT * FROM server_complex WHERE 1"), 
        "OnServerComplexLoad",
        ""
    );
    return 1;
}

stock LoadComplexRooms()
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL,"SELECT * FROM server_complex_rooms WHERE 1"), 
        "OnComplexRoomsLoad",
        ""
    );
    return 1;
}

stock GetComplexRooms(sqlid)
{
    new dest[MAX_PLAYER_NAME];
    if (sqlid > 0)
    {
        new
            Cache:result,
            query[128];

        format(query, sizeof(query), "SELECT COUNT(id) FROM server_complex_rooms WHERE complex_id = '%d' AND active = 1", sqlid);
        result = mysql_query(g_SQL, query);
        cache_get_value_index(0, 0, dest);
        cache_delete(result);
    }
    else
    {
        // TODO: use strcpy or direct array assignment, dest[0] = '0', dest[1] = EOS;
        format(dest, MAX_PLAYER_NAME, "0");
    }
    return dest;
}

static stock GetComplexInfoID(ownerid)
{
    new complex_id = INVALID_COMPLEX_ID;
    foreach(new cid: ComplexRooms)
    {
        if (ComplexRoomInfo[cid][cOwnerID] == ownerid)
        {
            complex_id = cid;
            break;
        }
    }
    return complex_id;
}

static stock GetNearestRoom(playerid)
{
    new
        viwo = GetPlayerVirtualWorld(playerid),
        interior = GetPlayerInterior(playerid),
        cmID = INVALID_COMPLEX_ID;
    foreach(new c : ComplexRooms)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.0, ComplexRoomInfo[c][cEnterX], ComplexRoomInfo[c][cEnterY], ComplexRoomInfo[c][cEnterZ])
            && ComplexRoomInfo[c][cIntExit] == interior
            && ComplexRoomInfo[c][cVWExit] == viwo)
        {
            cmID = c;
            break;
        }
    }
    return cmID;
}

stock GetComplexEnumID(roomid)
{
    new value;
    foreach(new c: Complex)
    {
        if (ComplexInfo[c][cSQLID] == ComplexRoomInfo[roomid][cComplexID])
        {
            value = c;
            break;
        }
    }
    return value;
}

static stock CreateComplexEnter(complex_id)
{
    if (complex_id == INVALID_COMPLEX_ID) return 0;

    DestroyDynamicPickup(ComplexInfo[complex_id][cPickup]);
    ComplexInfo[complex_id][cPickup] = CreateDynamicPickup(1273, 2, ComplexInfo[complex_id][cEnterX], ComplexInfo[complex_id][cEnterY], ComplexInfo[complex_id][cEnterZ], -1, -1, -1, 100.0);
    return 1;
}

static stock CreateCRoomEnter(complex_id)
{
    if (complex_id == INVALID_COMPLEX_ID) return 0;
    if (!ComplexRoomInfo[complex_id][cActive]) return 0;

    DestroyDynamicPickup(ComplexRoomInfo[complex_id][cRPickup]);
    ComplexRoomInfo[complex_id][cRPickup] = CreateDynamicPickup(1273, 2, ComplexRoomInfo[complex_id][cEnterX], ComplexRoomInfo[complex_id][cEnterY], ComplexRoomInfo[complex_id][cEnterZ], ComplexRoomInfo[complex_id][cVWExit], ComplexRoomInfo[complex_id][cIntExit], -1, 30.0);
    return 1;
}

static stock CreateCompInfoTD(playerid)
{
    DestroyCompInfoTD(playerid);
    CompBcg1[playerid] = CreatePlayerTextDraw(playerid, 639.612121, 116.752761, "usebox");
    PlayerTextDrawLetterSize(playerid,      CompBcg1[playerid], 0.000000, 10.236042);
    PlayerTextDrawTextSize(playerid,        CompBcg1[playerid], 497.499877, 0.000000);
    PlayerTextDrawAlignment(playerid,       CompBcg1[playerid], 1);
    PlayerTextDrawColor(playerid,           CompBcg1[playerid], 0);
    PlayerTextDrawUseBox(playerid,          CompBcg1[playerid], true);
    PlayerTextDrawBoxColor(playerid,        CompBcg1[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       CompBcg1[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      CompBcg1[playerid], 0);
    PlayerTextDrawFont(playerid,            CompBcg1[playerid], 0);
    PlayerTextDrawShow(playerid,            CompBcg1[playerid]);

    CompBcg2[playerid] = CreatePlayerTextDraw(playerid, 639.575012, 116.860000, "usebox");
    PlayerTextDrawLetterSize(playerid,      CompBcg2[playerid], 0.000000, 1.238053);
    PlayerTextDrawTextSize(playerid,        CompBcg2[playerid], 497.500000, 0.000000);
    PlayerTextDrawAlignment(playerid,       CompBcg2[playerid], 1);
    PlayerTextDrawColor(playerid,           CompBcg2[playerid], 0);
    PlayerTextDrawUseBox(playerid,          CompBcg2[playerid], true);
    PlayerTextDrawBoxColor(playerid,        CompBcg2[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       CompBcg2[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      CompBcg2[playerid], 0);
    PlayerTextDrawFont(playerid,            CompBcg2[playerid], 0);
    PlayerTextDrawShow(playerid,            CompBcg2[playerid]);

    CompInfoText[playerid] = CreatePlayerTextDraw(playerid, 501.850006, 117.488006, "COMPLEX INFO");
    PlayerTextDrawLetterSize(playerid,      CompInfoText[playerid], 0.336050, 1.023200);
    PlayerTextDrawAlignment(playerid,       CompInfoText[playerid], 1);
    PlayerTextDrawColor(playerid,           CompInfoText[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       CompInfoText[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      CompInfoText[playerid], 1);
    PlayerTextDrawFont(playerid,            CompInfoText[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, CompInfoText[playerid], 51);
    PlayerTextDrawSetProportional(playerid, CompInfoText[playerid], 1);
    PlayerTextDrawShow(playerid,            CompInfoText[playerid]);

    CompInfoTD[playerid] = CreatePlayerTextDraw(playerid, 503.999877, 134.456085, "Vlasnik: Richard Collins~n~Cijena: 10.000~g~$~n~~w~Rent: 10~g~$~n~~w~Level: 16");
    PlayerTextDrawLetterSize(playerid,      CompInfoTD[playerid], 0.282599, 0.967758);
    PlayerTextDrawAlignment(playerid,       CompInfoTD[playerid], 1);
    PlayerTextDrawColor(playerid,           CompInfoTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       CompInfoTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      CompInfoTD[playerid], 0);
    PlayerTextDrawFont(playerid,            CompInfoTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, CompInfoTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, CompInfoTD[playerid], 1);
    PlayerTextDrawShow(playerid,            CompInfoTD[playerid]);

    CompCMDTD[playerid] = CreatePlayerTextDraw(playerid, 503.550079, 190.175903, "Raspolozive komande:~n~      /enter");
    PlayerTextDrawLetterSize(playerid,      CompCMDTD[playerid], 0.240599, 0.879841);
    PlayerTextDrawAlignment(playerid,       CompCMDTD[playerid], 1);
    PlayerTextDrawColor(playerid,           CompCMDTD[playerid], -5963521);
    PlayerTextDrawSetShadow(playerid,       CompCMDTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      CompCMDTD[playerid], 0);
    PlayerTextDrawFont(playerid,            CompCMDTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, CompCMDTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, CompCMDTD[playerid], 1);
    PlayerTextDrawShow(playerid,            CompCMDTD[playerid]);
    return 1;
}

forward OnComplexRoomsLoad();
public OnComplexRoomsLoad()
{
    new num_rows = cache_num_rows();
    if (!num_rows) return printf("MySQL Report: No complex rooms exist to load.");

    for (new row = 0; row < num_rows; row++)
    {
        cache_get_value_name_int  (row,    "id"         ,    ComplexRoomInfo[row][cSQLID]);
        cache_get_value_name_int  (row,    "complex_id" ,    ComplexRoomInfo[row][cComplexID]);
        cache_get_value_name_int  (row,    "active"     ,    ComplexRoomInfo[row][cActive]);
        cache_get_value_name_float(row,    "enterX"     ,    ComplexRoomInfo[row][cEnterX]);
        cache_get_value_name_float(row,    "enterY"     ,    ComplexRoomInfo[row][cEnterY]);
        cache_get_value_name_float(row,    "enterZ"     ,    ComplexRoomInfo[row][cEnterZ]);
        // TODO: "adress" is spelt with double d
        cache_get_value_name      (row,    "adress"     ,    ComplexRoomInfo[row][cAdress], 25);
        cache_get_value_name_int  (row,    "ownerid"    ,    ComplexRoomInfo[row][cOwnerID]);
        cache_get_value_name_int  (row,    "value"      ,    ComplexRoomInfo[row][cValue]);
        cache_get_value_name_int  (row,    "int"        ,    ComplexRoomInfo[row][cInt]);
        cache_get_value_name_int  (row,    "viwo"       ,    ComplexRoomInfo[row][cViwo]);
        cache_get_value_name_int  (row,    "intexit"    ,    ComplexRoomInfo[row][cIntExit]);
        cache_get_value_name_int  (row,    "viwoexit"   ,    ComplexRoomInfo[row][cVWExit]);
        cache_get_value_name_int  (row,    "lock"       ,    ComplexRoomInfo[row][cLock]);
        cache_get_value_name_int  (row,    "level"      ,    ComplexRoomInfo[row][cLevel]);
        cache_get_value_name_int  (row,    "freeze"     ,    ComplexRoomInfo[row][cFreeze]);
        cache_get_value_name_int  (row,    "gunsafe1"   ,    ComplexRoomInfo[row][cGunSafe][0]);
        cache_get_value_name_int  (row,    "gunsafe2"   ,    ComplexRoomInfo[row][cGunSafe][1]);
        cache_get_value_name_int  (row,    "gunsafe3"   ,    ComplexRoomInfo[row][cGunSafe][2]);
        cache_get_value_name_int  (row,    "gunsafe4"   ,    ComplexRoomInfo[row][cGunSafe][3]);
        cache_get_value_name_int  (row,    "gunammo1"   ,    ComplexRoomInfo[row][cGunAmmo][0]);
        cache_get_value_name_int  (row,    "gunammo2"   ,    ComplexRoomInfo[row][cGunAmmo][1]);
        cache_get_value_name_int  (row,    "gunammo3"   ,    ComplexRoomInfo[row][cGunAmmo][2]);
        cache_get_value_name_int  (row,    "gunammo4"   ,    ComplexRoomInfo[row][cGunAmmo][3]);
        cache_get_value_name_int  (row,    "opensafe"   ,    ComplexRoomInfo[row][cSafeStatus]);
        cache_get_value_name_int  (row,    "safepass"   ,    ComplexRoomInfo[row][cSafePass]);
        cache_get_value_name_int  (row,    "safe"       ,    ComplexRoomInfo[row][cSafe]);
        cache_get_value_name_int  (row,    "ormar"      ,    ComplexRoomInfo[row][cOrmar]);
        cache_get_value_name_int  (row,    "skin1"      ,    ComplexRoomInfo[row][cSkin1]);
        cache_get_value_name_int  (row,    "skin2"      ,    ComplexRoomInfo[row][cSkin2]);
        cache_get_value_name_int  (row,    "skin3"      ,    ComplexRoomInfo[row][cSkin3]);
        cache_get_value_name_int  (row,    "groceries"  ,    ComplexRoomInfo[row][cGroceries]);
        cache_get_value_name_int  (row,    "quality"    ,    ComplexRoomInfo[row][cQuality]);
        cache_get_value_name_int  (row,    "doorlevel"  ,    ComplexRoomInfo[row][cDoorLevel]);
        cache_get_value_name_int  (row,    "alarm"      ,    ComplexRoomInfo[row][cAlarm]);
        cache_get_value_name_int  (row,    "locklevel"  ,    ComplexRoomInfo[row][cLockLevel]);
        cache_get_value_name_int  (row,    "phone"      ,    ComplexRoomInfo[row][cPhone]);
        cache_get_value_name_int  (row,    "phonenumber",    ComplexRoomInfo[row][cPhoneNumber]);
        cache_get_value_name_int  (row,    "moneysafe"  ,    ComplexRoomInfo[row][cMoneySafe]);
        cache_get_value_name_int  (row,    "radio"      ,    ComplexRoomInfo[row][cRadio]);
        cache_get_value_name_int  (row,    "tv"         ,    ComplexRoomInfo[row][cTV]);
        cache_get_value_name_int  (row,    "microwave"  ,    ComplexRoomInfo[row][cMicrowave]);

        switch (ComplexRoomInfo[row][cQuality])
        {
            case 1:
            {
                ComplexRoomInfo[row][cExitX] = 244.0068;
                ComplexRoomInfo[row][cExitY] = 304.9704;
                ComplexRoomInfo[row][cExitZ] = 999.1484;
                ComplexRoomInfo[row][cInt]   = 1;
            }
            case 2:
            {
                ComplexRoomInfo[row][cExitX] = 443.8501;
                ComplexRoomInfo[row][cExitY] = 509.1825;
                ComplexRoomInfo[row][cExitZ] = 1001.4195;
                ComplexRoomInfo[row][cInt]   = 12;
            }
            case 3:
            {
                ComplexRoomInfo[row][cExitX] = -2167.9109;
                ComplexRoomInfo[row][cExitY] = 642.3528;
                ComplexRoomInfo[row][cExitZ] = 1057.5938;
                ComplexRoomInfo[row][cInt]   = 1;
            }
        }
        CreateCRoomEnter(row);
        Iter_Add(ComplexRooms, row);
    }
    printf("MySQL Report: Complex rooms Loaded (%d)!", Iter_Count(ComplexRooms));
    return 1;
}

forward OnServerComplexLoad();
public OnServerComplexLoad()
{
    new num_rows = cache_num_rows();
    if (!num_rows) return printf("MySQL Report: No complex exist to load.");

    for (new row = 0; row < num_rows; row++)
    {
        cache_get_value_name_int  (row,    "id"      ,    ComplexInfo[row][cSQLID]);
        cache_get_value_name_int  (row,    "owner_id",    ComplexInfo[row][cOwnerID]);
        cache_get_value_name_float(row,    "x"       ,    ComplexInfo[row][cEnterX]);
        cache_get_value_name_float(row,    "y"       ,    ComplexInfo[row][cEnterY]);
        cache_get_value_name_float(row,    "z"       ,    ComplexInfo[row][cEnterZ]);
        cache_get_value_name_float(row,    "exit_x"  ,    ComplexInfo[row][cExitX]);
        cache_get_value_name_float(row,    "exit_y"  ,    ComplexInfo[row][cExitY]);
        cache_get_value_name_float(row,    "exit_z"  ,    ComplexInfo[row][cExitZ]);
        cache_get_value_name      (row,    "name"    ,    ComplexInfo[row][cName], 25);
        cache_get_value_name_int  (row,    "till"    ,    ComplexInfo[row][cTill]);
        cache_get_value_name_int  (row,    "price"   ,    ComplexInfo[row][cPrice]);
        cache_get_value_name_int  (row,    "level"   ,    ComplexInfo[row][cLevel]);
        cache_get_value_name_int  (row,    "viwo"    ,    ComplexInfo[row][cViwo]);
        cache_get_value_name_int  (row,    "interior",    ComplexInfo[row][cInt]);

        CreateComplexEnter(row);
        Iter_Add(Complex, row);
    }
    printf("MySQL Report: Complex Loaded (%d)!", Iter_Count(Complex));
    return 1;
}


/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

hook LoadServerData()
{
    LoadComplexes();
    LoadComplexRooms();
    return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
    new string[128];
    foreach(new complex : Complex)
    {
        if (ComplexInfo[complex][cPickup] == pickupid)
        {
            CreateCompInfoTD(playerid);
            // TODO: refactor this BS if possible, reduce code duplication
            if (ComplexInfo[complex][cOwnerID] != -1)
            {
                format(string, sizeof(string), "Naziv: %s~n~Vlasnik: %s~n~Cijena: %d~g~$~n~~w~Broj soba: %s",
                    ComplexInfo[complex][cName],
                    GetPlayerNameFromSQL(ComplexInfo[complex][cOwnerID]),
                    ComplexInfo[complex][cPrice],
                    GetComplexRooms(ComplexInfo[complex][cSQLID])
                );
                PlayerTextDrawSetString(playerid, CompCMDTD[playerid], "Raspolozive komande:~n~      /enter");
            }
            else
            {
                format(string, sizeof(string), "Complex je na prodaju~n~Naziv: %s~n~Cijena: %d~g~$~n~~w~Level: %d~n~Broj soba: %s",
                    ComplexInfo[complex][cName],
                    ComplexInfo[complex][cPrice],
                    ComplexInfo[complex][cLevel],
                    GetComplexRooms(ComplexInfo[complex][cSQLID])
                );
                PlayerTextDrawSetString(playerid, CompCMDTD[playerid], "Raspolozive komande:~n~      /enter, /buycomplex");
            }

            PlayerTextDrawSetString(playerid, CompInfoTD[playerid], string);
            PlayerCMPTimer[playerid] = defer PlayerComplexInfo(playerid);
            break;
        }
    }

    foreach(new complex : ComplexRooms)
    {
        if (ComplexRoomInfo[complex][cRPickup] == pickupid)
        {
            CreateCompInfoTD(playerid);
            // TODO: reduce code duplication
            if (ComplexRoomInfo[complex][cOwnerID] != -1)
            {
                format(string, sizeof(string), "Vlasnik: %s~n~Adresa: %s~n~Cijena renta: %d~g~$~n~~w~Ocjena: %d",
                    GetPlayerNameFromSQL(ComplexRoomInfo[complex][cOwnerID]),
                    ComplexRoomInfo[complex][cAdress],
                    ComplexRoomInfo[complex][cValue],
                    ComplexRoomInfo[complex][cQuality]
                );
                PlayerTextDrawSetString(playerid, CompCMDTD[playerid], "Raspolozive komande:~n~      /enter");
            }
            else {
                format(string, sizeof(string), "Soba je na prodaju~n~Adresa: %s~n~Cijena renta: %d~g~$~n~~w~Level: %d~n~Ocjena: %d",
                    ComplexRoomInfo[complex][cAdress],
                    ComplexRoomInfo[complex][cValue],
                    ComplexRoomInfo[complex][cLevel],
                    ComplexRoomInfo[complex][cQuality]
                );
                PlayerTextDrawSetString(playerid, CompCMDTD[playerid], "Raspolozive komande:~n~      /enter, /rentroom");
            }

            PlayerTextDrawSetString(playerid, CompInfoTD[playerid], string);
            PlayerCMPTimer[playerid] = defer PlayerComplexInfo(playerid);
            break;
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_COMPLEX_MAIN:
        {
            if (!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterX], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterY], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svog kompleksa!");
                    // TODO: use va_ShowPlayerDialog
                    new str[48];
                    format(str, sizeof(str), "\tStanje u blagajni: %d{0BB716}$", ComplexInfo[PlayerKeys[playerid][pComplexKey]][cTill]);
                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_BANK, DIALOG_STYLE_MSGBOX, "COMPLEX INFO", str, "Withdraw", "Close");
                }
                case 1: //Promjena naziva complexa
                {
                    if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterX], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterY], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svog kompleksa!");

                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_CHANGENAME, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Molimo unesite novi naziv vaseg kompleksa:", "Enter", "Close");
                    return 1;
                }
                case 2:
                {
                    if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterX], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterY], ComplexInfo[PlayerKeys[playerid][pComplexKey]][cEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svog kompleksa!");

                    new
                        string[2048] = "Address\tQuality\tPricing\tStatus\n",
                        row[74];
                    foreach(new c : ComplexRooms)
                    {
                        if (ComplexRoomInfo[c][cComplexID] == ComplexInfo[PlayerKeys[playerid][pComplexKey]][cSQLID])
                        {
                            format(row, sizeof(row), "%s\t%d\t%d$\t%s\n",
                                ComplexRoomInfo[c][cAdress],
                                ComplexRoomInfo[c][cQuality],
                                ComplexRoomInfo[c][cValue],
                                (ComplexRoomInfo[c][cActive]) ? ("{0BB716}Active") : ("{B21A27}Inactive")
                            );
                            strcat(string, row, sizeof(string));
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOMS, DIALOG_STYLE_TABLIST_HEADERS, "COMPLEX MENU", string, "Select", "Close");
                    return 1;
                }
                case 3:
                {
                    new complex = PlayerKeys[playerid][pComplexKey];
                    if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[complex][cEnterX], ComplexInfo[complex][cEnterY], ComplexInfo[complex][cEnterZ]))
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svog kompleksa!");
                        return 1;
                    }

                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_SELL, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Molimo unesite ID igraca kome zelite prodati kompleks:", "Enter", "Close");
                    return 1;
                }
                case 4: 
                {
                    new
                        complex = PlayerKeys[playerid][pComplexKey];

                    if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[complex][cEnterX], ComplexInfo[complex][cEnterY], ComplexInfo[complex][cEnterZ]))
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svog kompleksa!");
                        return 1;
                    }

                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    PlayerKeys[playerid][pComplexKey] = INVALID_COMPLEX_ID;
                    SendClientMessage(playerid, COLOR_RED, "Prodali ste svoj COMPLEX za 40000$ drzavi i dobili ste preostale novce iz blagajne!");

                    ComplexToPlayerMoney(playerid, complex, ComplexInfo[complex][cTill]); // Sav novac iz complexa ide igracu
                    BudgetToPlayerMoney(playerid, 40000); // Novac iz budgeta ide igracu,

                    ComplexInfo[complex][cOwnerID]  = -1;

                    mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id = 0 WHERE id = '%d'",
                        ComplexInfo[complex][cSQLID]
                    );

                    PlayerInfo[playerid][pSpawnChange] = 0;
                    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                        PlayerInfo[playerid][pSpawnChange],
                        PlayerInfo[playerid][pSQLID]
                    );

                    if (GetPlayerVirtualWorld(playerid) == ComplexInfo[complex][cViwo])
                        SetPlayerPosEx(playerid, ComplexInfo[complex][cEnterX], ComplexInfo[complex][cEnterY], ComplexInfo[complex][cEnterZ]);
                    return 1;
                }
                case 5: // 27.07.2019 - L3o
                {
                    new complex = GetNearestRoom(playerid);
                    if (complex == INVALID_COMPLEX_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate se nalaziti ispred stana od stanara.");

                    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste izbacili %s iz vaseg Complex-a!", GetPlayerNameFromSQL(ComplexRoomInfo[complex][cOwnerID]));

                    mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'",
                        ComplexRoomInfo[complex][cSQLID]
                    );

                    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '0' WHERE sqlid = '%d'",
                        ComplexRoomInfo[complex][cOwnerID]
                    );
                    ComplexRoomInfo[complex][cOwnerID] = -1;
                }
            }
        }
        case DIALOG_COMPLEX_BANK:
        {
            if (!response) return 1;

            new complex = PlayerKeys[playerid][pComplexKey];
            ComplexToPlayerMoney(playerid, complex, ComplexInfo[complex][cTill]);
            SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste podigli novac sa blagajne.");
        }
        case DIALOG_COMPLEX_ROOMS:
        {
            if (!response) return 1;
            // TODO: really test this logic out and printf needed variables
            // it might be broken
            new
                complex = PlayerKeys[playerid][pComplexKey],
                item = listitem + 1,
                count = 0;
            foreach(new c : ComplexRooms)
            {
                if (ComplexRoomInfo[c][cComplexID] == ComplexInfo[complex][cSQLID])
                {
                    if (++count == item)
                    {
                        SelectedRoom[playerid] = c;
                        break;
                    }
                }
            }
            // TODO: call one va_ShowPlayerDialog and use ternary logic
            if (ComplexRoomInfo[SelectedRoom[playerid]][cActive])
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOM_INFO, DIALOG_STYLE_LIST, "COMPLEX MENU", "Promjeni cijenu\nRenoviraj interijer(7500$)", "Enter", "Close");
            else
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOM_INFO_2, DIALOG_STYLE_LIST, "COMPLEX MENU", "Promjeni cijenu\nOsposobi sobu(10000$)", "Enter", "Close");
            return 1;
        }
        case DIALOG_COMPLEX_ROOM_INFO_2:
        {
            if (!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOM_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu sobe za rent:", "Enter", "Close");
                    return 1;
                }
                case 1:
                {
                    new room_id = SelectedRoom[playerid];
                    if (ComplexRoomInfo[room_id][cActive])
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Soba je vec kreirana");
                        return 1;
                    }

                    if (AC_GetPlayerMoney(playerid) < 10000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca.");

                    PlayerToBudgetMoney(playerid, 10000); // Novac od igraca ide u proracun
                    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste kreirali novu sobu.");

                    ComplexRoomInfo[room_id][cActive] = 1;
                    ComplexRoomInfo[room_id][cRPickup] = CreateDynamicPickup(1273, 2, ComplexRoomInfo[room_id][cEnterX], ComplexRoomInfo[room_id][cEnterY], ComplexRoomInfo[room_id][cEnterZ], ComplexRoomInfo[room_id][cVWExit], ComplexRoomInfo[room_id][cIntExit], -1, 30.0);

                    mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET active = '%d' WHERE id = '%d'",
                        ComplexRoomInfo[room_id][cActive],
                        ComplexRoomInfo[room_id][cSQLID]
                    );
                }
            }
            return 1;
        }
        case DIALOG_COMPLEX_ROOM_INFO:
        {
            if (!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOM_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu sobe za rent:", "Enter", "Close");
                    return 1;
                }
                case 1:
                {
                    new room_id = SelectedRoom[playerid];
                    if (ComplexRoomInfo[room_id][cQuality] == 3)
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Soba se ne moze vise unaprijediti!");
                        return 1;
                    }
                    if (AC_GetPlayerMoney(playerid) < 7500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca.");

                    PlayerToBudgetMoney(playerid, 7500); // Novac od igraca ide u proracun
                    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste unaprijedili interior sobe.");
                    ComplexRoomInfo[room_id][cQuality]++;

                    mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET quality = '%d' WHERE id = '%d'",
                        ComplexRoomInfo[room_id][cQuality],
                        ComplexRoomInfo[room_id][cSQLID]
                    );
                }
            }
            return 1;
        }
        case DIALOG_COMPLEX_ROOM_PRICE:
        {
            if (!response) return 1;

            new value = strval(inputtext);
            if (value < 50 || value > 500)
            {
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_ROOM_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu sobe za rent:\n{ed2a37}Nepravilna cijena!", "Enter", "Close");
                return 1;
            }

            new room_id = SelectedRoom[playerid];

            ComplexRoomInfo[room_id][cValue] = value;
            mysql_fquery(g_SQL,"UPDATE server_complex_rooms SET value = '%d' WHERE id = '%d'",
                ComplexRoomInfo[room_id][cValue],
                ComplexRoomInfo[room_id][cSQLID]
            );

            SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste izmjenili cijenu renta sobe.");
            return 1;
        }
        case DIALOG_COMPLEX_CHANGENAME:
        {
            if (!response) return 1;
            if (strlen(inputtext) < 3)
            {
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_CHANGENAME, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Molimo unesite novi naziv vaseg kompleksa:\n{ed2a37}Naziv je prekratak!", "Enter", "Close");
                return 1;
            }

            new complex_id = PlayerKeys[playerid][pComplexKey];
            SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si promjenio naziv kompleksa.");
          
            // TODO: strcpy
            format(ComplexInfo[complex_id][cName], 25, inputtext);
            mysql_fquery(g_SQL, "UPDATE server_complex SET name = '%e' WHERE id = '%d'",
                ComplexInfo[complex_id][cName],
                ComplexInfo[complex_id][cSQLID]
            );
            return 1;
        }
        case DIALOG_COMPLEX_SELL:
        {
            if (!response) return 1;
            if (isnull(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_CHANGENAME, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Molimo unesite novi naziv vaseg kompleksa:\n{ed2a37}Niste unijeli ID!", "Enter", "Close");
                return 1;
            }

            new
                pID = strval(inputtext),
                complex_id = PlayerKeys[playerid][pComplexKey];
            if (!IsPlayerInRangeOfPoint(playerid, 8.0, ComplexInfo[complex_id][cEnterX], ComplexInfo[complex_id][cEnterY], ComplexInfo[complex_id][cEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti blizu vaseg kompleksa!");
            if (!IsPlayerConnected(pID) || !SafeSpawned[pID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije sigurno spawnan/online!");
            if (!ProxDetectorS(5.0, playerid, pID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
            if (PlayerKeys[pID][pComplexKey] != INVALID_COMPLEX_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac vec ima kompleks!");

            GlobalSellingPlayerID[playerid] = pID;
            ShowPlayerDialog(playerid, DIALOG_COMPLEX_SELL_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu za koju zelite prodati kompleks:", "Enter", "Close");
            return 1;
        }
        case DIALOG_COMPLEX_SELL_PRICE:
        {
            if (!response) return 1;

            new value = strval(inputtext);
            if (value < 5000 || value > 9999999)
            {
                ShowPlayerDialog(playerid, DIALOG_COMPLEX_SELL_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu za koju zelite prodati kompleks:\n{ed2a37}Cijena ne moze biti manja od 5000$!", "Enter", "Close");
                return 1;
            }

            new
                complexprice = value,
                pID = GlobalSellingPlayerID[playerid];

            if (AC_GetPlayerMoney(pID) < complexprice) return ShowPlayerDialog(playerid, DIALOG_COMPLEX_SELL_PRICE, DIALOG_STYLE_INPUT, "COMPLEX MENU", "Unesite cijenu za koju zelite prodati kompleks:\n{ed2a37}Igrac nema toliko novca!", "Enter", "Close");

            GlobalSellingPrice[pID] = complexprice;
            GlobalSellingPlayerID[pID] = playerid;
            va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste ponudili vas kompleks igracu %s za %d$", GetName(pID), complexprice);
            // TODO: va_ShowPlayerDialog
            new string[85];
            format(string, sizeof(string), "Igrac %s vam je ponudio da kupite njegov kompleks za %d", GetName(playerid), complexprice);
            ShowPlayerDialog(pID, DIALOG_COMPLEX_SELL_2, DIALOG_STYLE_MSGBOX, "PONUDA ZA KUPOVINU KOMPLEKSA", string, "Buy", "Refuse");
            return 1;
        }
        case DIALOG_COMPLEX_SELL_2:
        {
            if (response)
            {
                new
                    pID = GlobalSellingPlayerID[playerid],
                    complexprice = GlobalSellingPrice[playerid];

                PlayerKeys[playerid][pComplexKey]   = PlayerKeys[pID][pComplexKey];
                PlayerKeys[pID][pComplexKey]        = INVALID_COMPLEX_ID;

                new complex_id = PlayerKeys[playerid][pComplexKey];
                ComplexInfo[complex_id][cOwnerID] = PlayerInfo[playerid][pSQLID];

                PlayerToPlayerMoneyTAX(playerid, pID, complexprice, true, LOG_TYPE_COMPLEXSELL); // IGrac igracu TAXED transkacija za prodaju complexa
                va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste kupili kompleks od %s za %d$", GetName(pID), complexprice);
                va_SendClientMessage(pID, COLOR_RED, "[ ! ] Igrac %s je kupio od vas kompleks za %d", GetName(playerid), complexprice);

                PlayerInfo[playerid][pSpawnChange] = 3;

                mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id = '%d' WHERE id = '%d'",
                    ComplexInfo[complex_id][cOwnerID],
                    ComplexInfo[complex_id][cSQLID]
                );

                mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                    PlayerInfo[playerid][pSpawnChange],
                    PlayerInfo[playerid][pSQLID]
                );

                mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                    PlayerInfo[pID][pSpawnChange],
                    PlayerInfo[pID][pSQLID]
                );

                if ((PlayerKeys[pID][pHouseKey] != INVALID_HOUSE_ID) || (PlayerKeys[pID][pRentKey] != INVALID_HOUSE_ID))
                    PlayerInfo[pID][pSpawnChange] = 1;
                else if (PlayerFaction[pID][pMember] != 0 || PlayerFaction[pID][pLeader] != 0)
                    PlayerInfo[pID][pSpawnChange] = 2;
                else PlayerInfo[pID][pSpawnChange] = 0;

                GlobalSellingPrice[playerid]    = 0;
                GlobalSellingPlayerID[pID]      = INVALID_PLAYER_ID;

                #if defined MODULE_LOGS
                Log_Write("/logfiles/buy_complex.txt", "(%s) %s(%s) bought Complex %s[SQLID: %d] from %s(%s) for %d$.",
                    ReturnDate(),
                    GetName(playerid, false),
                    ReturnPlayerIP(playerid),
                    ComplexInfo[complex_id][cName],
                    ComplexInfo[complex_id][cSQLID],
                    GetName(pID, false),
                    ReturnPlayerIP(pID),
                    complexprice
                );
                #endif
            }
            return 1;
        }
    }
    return 0;
}


/*
    ######## #### ##     ## ######## ########   ######  
       ##     ##  ###   ### ##       ##     ## ##    ## 
       ##     ##  #### #### ##       ##     ## ##       
       ##     ##  ## ### ## ######   ########   ######  
       ##     ##  ##     ## ##       ##   ##         ## 
       ##     ##  ##     ## ##       ##    ##  ##    ## 
       ##    #### ##     ## ######## ##     ##  ######  
*/

timer PlayerComplexInfo[5000](playerid)
{
    stop PlayerCMPTimer[playerid];
    DestroyCompInfoTD(playerid);
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

CMD:buycomplex(playerid, params[])
{
    if (PlayerKeys[playerid][pComplexKey] != INVALID_COMPLEX_ID)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete kompleks!");
        return 1;
    }

    new complex = GetNearestRoom(playerid);
    if (complex == INVALID_COMPLEX_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nema soba complexa u blizini.");
    if (ComplexInfo[complex][cOwnerID] != -1) return 1;

    if (PlayerInfo[playerid][pLevel] < ComplexInfo[complex][cLevel])
    {
        va_SendClientMessage(playerid, COLOR_RED, "Moras biti level %d da bi kupio kompleks!", ComplexInfo[complex][cLevel]);
        return 1;
    }

    if (AC_GetPlayerMoney(playerid) < ComplexInfo[complex][cPrice])
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas novaca da bi kupio kompleks!");
        return 1;
    }

    PlayerKeys[playerid][pComplexKey]   = complex;
    ComplexInfo[complex][cTill]         = 0;
    ComplexInfo[complex][cOwnerID]      = PlayerInfo[playerid][pSQLID];
    PlayerInfo[playerid][pSpawnChange] = 3;
    PlayerPlayTrackSound(playerid);

    mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id = '%d' WHERE id = '%d'",
        PlayerInfo[playerid][pSQLID],
        ComplexInfo[complex][cSQLID]
    );

    PlayerToBudgetMoney(playerid, ComplexInfo[complex][cPrice]); // Novac od kupljenog complexa na buy ide u proracun
    SendClientMessage(playerid, COLOR_RED, "[ ! ] Kupili ste kompleks, koristite /help za vise informacija!");

    #if defined MODULE_LOGS
    Log_Write("/logfiles/buy_complex.txt", "(%s) %s [SQLID: %d] bought Complex %s [SQLID: %d] for %d$.",
        ReturnDate(),
        GetName(playerid, false),
        PlayerInfo[playerid][pSQLID],
        ComplexInfo[complex][cName],
        ComplexInfo[complex][cSQLID],
        ComplexInfo[complex][cPrice]
    );
    #endif
    return 1;
}

CMD:complex(playerid, params[])
{
    if (PlayerKeys[playerid][pComplexKey] == INVALID_COMPLEX_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne posjedujete kompleks.");
        return 1;
    }
    ShowPlayerDialog(playerid, DIALOG_COMPLEX_MAIN, DIALOG_STYLE_LIST, "COMPLEX MENU", "Info\nPromjeni naziv\nSobe\nProdaj igracu\nProdaj drzavi (40000$)\nIzbaci stanara", "Enter", "Close");
    return 1;
}

CMD:rentroom(playerid, params[])
{
    if (PlayerKeys[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec rentate complex sobu.");
        return 1;
    }

    new complex = GetNearestRoom(playerid);
    if (complex == INVALID_COMPLEX_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nema soba complexa u blizini.");

    if (ComplexRoomInfo[complex][cOwnerID] != -1)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Soba je zauzeta!");
        return 1;
    }

    if (AC_GetPlayerMoney(playerid) < ComplexRoomInfo[complex][cValue]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas novaca da bi zakupio sobu!");

    PlayerKeys[playerid][pComplexRoomKey] = complex;
    PlayerInfo[playerid][pSpawnChange] = 3;
    ComplexRoomInfo[complex][cOwnerID] = PlayerInfo[playerid][pSQLID];

    mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET ownerid = '%d' WHERE id = '%d'",
        PlayerInfo[playerid][pSQLID],
        ComplexRoomInfo[complex][cSQLID]
    );

    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
        PlayerInfo[playerid][pSpawnChange],
        PlayerInfo[playerid][pSQLID]
    );

    new complex_id = GetComplexEnumID(complex);
    PlayerToComplexMoneyTAX(playerid, complex_id, ComplexRoomInfo[complex][cValue]);
    SendClientMessage(playerid, COLOR_RED, "[ ! ] Zakupili ste kompleks sobu, koristite /help za vise informacija!");
    SendClientMessage(playerid, COLOR_RED, "[ ! ] Spawn Vam je automatski prebacen na iznajmljenu sobu u kompleksu.");

    #if defined MODULE_LOGS
    Log_Write("/logfiles/buy_complex.txt", "(%s) %s rented Complex Room %s[SQLID: %d] for %d$ in Complex %s.",
        ReturnDate(),
        GetName(playerid, false),
        ComplexRoomInfo[complex][cAdress],
        ComplexRoomInfo[complex][cSQLID],
        ComplexRoomInfo[complex][cValue],
        ComplexInfo[ ComplexRoomInfo[complex][cComplexID] ][cName]
    );
    #endif
    return 1;
}

CMD:unrentroom(playerid, params[])
{
    new complex_id = PlayerKeys[playerid][pComplexRoomKey];
    if (complex_id == INVALID_COMPLEX_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi nemate zakupljenu sobu!");

    mysql_fquery(g_SQL,"UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'",
        ComplexRoomInfo[complex_id][cSQLID]
    );

    ComplexRoomInfo[complex_id][cOwnerID] = -1;
    PlayerKeys[playerid][pComplexRoomKey] = INVALID_COMPLEX_ID;

    if (PlayerFaction[playerid][pMember] != 0 || PlayerFaction[playerid][pLeader] != 0)
    {
        PlayerInfo[playerid][pSpawnChange] = 2;
    }
    else
    {
        PlayerInfo[playerid][pSpawnChange] = 0;
    }

    SendClientMessage(playerid, COLOR_RED, "[ ! ] Vise ne zakupljujete sobu.");
    return 1;
}
