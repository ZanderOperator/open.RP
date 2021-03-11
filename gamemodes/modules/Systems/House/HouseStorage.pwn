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

#define MAX_HOUSE_STORAGE               (500)    // Maximalno posjedovanja polica(storage) za igrace (no donator rank).
#define RACK_PRICE                      (500)    // Cijena kupovine stalka za oruzja
#define MAX_WEAPON_ONRACK               (4)      // Maximalno oruzja na stalku

/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum Storage_Data
{
    storageID,
    bool:storageExists,
    storageHouse,
    Float:storagePos[4],
    storageInterior,
    storageWorld,
    storageWeapons[MAX_WEAPON_ONRACK],
    storageAmmo[MAX_WEAPON_ONRACK],
    storageObjects[MAX_WEAPON_ONRACK+1]
};
static HouseStorage[MAX_HOUSE_STORAGE][Storage_Data];

static
    p_EditRack[MAX_PLAYERS] = INVALID_PLAYER_ID,
    Iterator: HStorage_Iter <MAX_HOUSE_STORAGE>;


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

bool:Storage_Exists(storageid)
{
    if(storageid < 0 || storageid > MAX_HOUSE_STORAGE)
    {
        return false;
    }
    return HouseStorage[storageid][storageExists];
}

stock Storage_GetId(storageid)
{
    if(storageid < 0 || storageid > MAX_HOUSE_STORAGE)
    {
        return -1;
    }
    return HouseStorage[storageid][storageID];
}

HouseStorage_Save(storage_id)
{
    mysql_fquery(SQL_Handle(), 
        "UPDATE house_storage SET storageHouse = '%d', storageX = '%.4f', storageY = '%.4f', storageZ = '%.4f',\n\
            storageA = '%.4f', storageInterior = '%d', storageWorld = '%d' WHERE storageID = '%d'",
        HouseStorage[storage_id][storageHouse],
        HouseStorage[storage_id][storagePos][0],
        HouseStorage[storage_id][storagePos][1],
        HouseStorage[storage_id][storagePos][2],
        HouseStorage[storage_id][storagePos][3],
        HouseStorage[storage_id][storageInterior],
        HouseStorage[storage_id][storageWorld],
        HouseStorage[storage_id][storageID]
   );
    return 1;
}

HouseStorage_SaveWep(storage_id, wepid)
{
    mysql_fquery(SQL_Handle(), "UPDATE house_storage SET gunID%d = '%d', ammoID%d = '%d' WHERE storageID = '%d'",
        wepid,
        HouseStorage[storage_id][storageWeapons][wepid],
        wepid,
        HouseStorage[storage_id][storageAmmo][wepid],
        HouseStorage[storage_id][storageID]
   );
    return 1;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == EDIT_RESPONSE_FINAL)
    {
        if(p_EditRack[playerid] != INVALID_PLAYER_ID)
        {
            if(HouseStorage[p_EditRack[playerid]][storageExists])
            {
                HouseStorage[p_EditRack[playerid]][storagePos][0] = x;
                HouseStorage[p_EditRack[playerid]][storagePos][1] = y;
                HouseStorage[p_EditRack[playerid]][storagePos][2] = z;
                HouseStorage[p_EditRack[playerid]][storagePos][3] = rz;
                ShowPlayerDialog(playerid, DIALOG_HSTORAGE_EDIT, DIALOG_STYLE_MSGBOX, "{3C95C2}House Storage - Stalak", "\nJeste li sigurni da zelite ovdje postaviti Stalak?\n[!] - Nakon postavljanja, stalku vise ne mozete promijeniti poziciju.", "OK", "Close");
            }
        }
    }
    if(response == EDIT_RESPONSE_CANCEL)
    {
        if(p_EditRack[playerid] != INVALID_PLAYER_ID)
        {
            if(HouseStorage[p_EditRack[playerid]][storageExists])
            {
                HouseStorage[p_EditRack[playerid]][storagePos][0] = x;
                HouseStorage[p_EditRack[playerid]][storagePos][1] = y;
                HouseStorage[p_EditRack[playerid]][storagePos][2] = z;
                HouseStorage[p_EditRack[playerid]][storagePos][3] = rz;
                ShowPlayerDialog(playerid, DIALOG_HSTORAGE_EDIT, DIALOG_STYLE_MSGBOX, "{3C95C2}House Storage - Stalak", "\nJeste li sigurni da zelite ovdje postaviti Stalak?\n[!] - Nakon postavljanja, stalku vise ne mozete promijeniti poziciju.", "OK", "Close");
            }
        }
    }
    return 1;
}

Public:HouseStorage_Load()
{
    new 
        rows = cache_num_rows();

    if(!rows)
    {
        print("MySQL Report: There are no House Storage Racks to load from database!");
        return 1;
    }

    for (new i = 0; i < cache_num_rows(); i++)
    {
        HouseStorage[i][storageExists] = true;

        cache_get_value_name_int(i, "storageID", HouseStorage[i][storageID]);
        cache_get_value_name_int(i, "storageHouse", HouseStorage[i][storageHouse]);
        cache_get_value_name_int(i, "storageInterior", HouseStorage[i][storageInterior]);
        cache_get_value_name_int(i, "storageWorld", HouseStorage[i][storageWorld]);

        cache_get_value_name_int(i, "gunID0", HouseStorage[i][storageWeapons][0]);
        cache_get_value_name_int(i, "gunID1", HouseStorage[i][storageWeapons][1]);
        cache_get_value_name_int(i, "gunID2", HouseStorage[i][storageWeapons][2]);
        cache_get_value_name_int(i, "gunID3", HouseStorage[i][storageWeapons][3]);

        cache_get_value_name_int(i, "ammoID0", HouseStorage[i][storageAmmo][0]);
        cache_get_value_name_int(i, "ammoID1", HouseStorage[i][storageAmmo][1]);
        cache_get_value_name_int(i, "ammoID2", HouseStorage[i][storageAmmo][2]);
        cache_get_value_name_int(i, "ammoID3", HouseStorage[i][storageAmmo][3]);

        cache_get_value_name_float(i, "storageX", HouseStorage[i][storagePos][0]);
        cache_get_value_name_float(i, "storageY", HouseStorage[i][storagePos][1]);
        cache_get_value_name_float(i, "storageZ", HouseStorage[i][storagePos][2]);
        cache_get_value_name_float(i, "storageA", HouseStorage[i][storagePos][3]);

        Storage_RackRefresh(i);
        Iter_Add(HStorage_Iter, i);
    }
    printf("MySQL Report: House Storage Racks Loaded. [%d/%d]", Iter_Count(HStorage_Iter), MAX_HOUSE_STORAGE);
    return 1;
}

GetRackLimit(playerid)
{
    return (PlayerVIP[playerid][pDonateRank] + 1);
}

stock LoadHouseStorages()
{
    mysql_pquery(SQL_Handle(), "SELECT * FROM house_storage WHERE 1", "HouseStorage_Load", "");
    return 1;
}

Storage_RackRefresh(storageid)
{
    if(!Storage_Exists(storageid))
    {
        return 1;
    }

    if(IsValidDynamicObject(HouseStorage[storageid][storageObjects][4]))
    {
        DestroyDynamicObject(HouseStorage[storageid][storageObjects][4]);
    }
    Storage_Refresh(storageid);
    HouseStorage[storageid][storageObjects][4] = CreateDynamicObject(2475, HouseStorage[storageid][storagePos][0], HouseStorage[storageid][storagePos][1], HouseStorage[storageid][storagePos][2], 0.0, 0.0, HouseStorage[storageid][storagePos][3], HouseStorage[storageid][storageWorld], HouseStorage[storageid][storageInterior]);
    return 1;
}

Storage_Refresh(storageid)
{
    if(!Storage_Exists(storageid))
    {
        return 1;
    }

    new
        Float:x,
        Float:y,
        Float:z;

    z = HouseStorage[storageid][storagePos][2] + 2.19;
    for (new i = 0; i < MAX_WEAPON_ONRACK; i++) if(IsValidDynamicObject(HouseStorage[storageid][storageObjects][i]))
    {
        DestroyDynamicObject(HouseStorage[storageid][storageObjects][i]);

        HouseStorage[storageid][storageObjects][i] = INVALID_OBJECT_ID;
    }
    for (new i = 0; i < MAX_WEAPON_ONRACK; i++)
    {
        if(HouseStorage[storageid][storageWeapons][i])
        {
            x = HouseStorage[storageid][storagePos][0] - (0.2 * floatsin(-HouseStorage[storageid][storagePos][3], degrees) + (0.45 * floatsin(-HouseStorage[storageid][storagePos][3] - 90, degrees)));
            y = HouseStorage[storageid][storagePos][1] - (0.2 * floatcos(-HouseStorage[storageid][storagePos][3], degrees) + (0.45 * floatcos(-HouseStorage[storageid][storagePos][3] - 90, degrees)));

            HouseStorage[storageid][storageObjects][i] = CreateDynamicObject(GetWeaponModel(HouseStorage[storageid][storageWeapons][i]), x, y, z, 94.7, 93.7, (22 <= HouseStorage[storageid][storageWeapons][i] <= 38) ? (HouseStorage[storageid][storagePos][3] + 90.0) : (HouseStorage[storageid][storagePos][3]), HouseStorage[storageid][storageWorld], HouseStorage[storageid][storageInterior]);
        }
        else
        {
            HouseStorage[storageid][storageObjects][i] = INVALID_OBJECT_ID;
        }
        z = z - 0.69;
    }
    return 1;
}

Storage_RackCreate(playerid, houseid)
{
    new
        Float:x,
        Float:y,
        Float:z,
        Float:angle;

    if(!IsPlayerConnected(playerid))
    {
        return -1;
    }

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    new i = Iter_Free(HStorage_Iter);
    x += 1.5 * floatsin(-angle, degrees);
    y += 1.5 * floatcos(-angle, degrees);

    HouseStorage[i][storageExists] = true;
    HouseStorage[i][storageHouse] = houseid;

    HouseStorage[i][storagePos][0] = x;
    HouseStorage[i][storagePos][1] = y;
    HouseStorage[i][storagePos][2] = z;
    HouseStorage[i][storagePos][3] = angle;
    HouseStorage[i][storageInterior] = GetPlayerInterior(playerid);
    HouseStorage[i][storageWorld] = GetPlayerVirtualWorld(playerid);

    Storage_RackRefresh(i);
    HouseStorage_Save(i);
    
    mysql_tquery(SQL_Handle(), "INSERT INTO house_storage (storageCreated) VALUES(1)", "OnRackCreated", "d", i);
    return i;
}

Storage_PlayerNearRack(playerid)
{
    new storageid = -1;
    foreach(new i: HStorage_Iter)
    {
        if(!Storage_Exists(i))
        {
            continue;
        }
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, HouseStorage[i][storagePos][0], HouseStorage[i][storagePos][1], HouseStorage[i][storagePos][2]))
        {
            continue;
        }

        if(GetPlayerInterior(playerid) == HouseStorage[i][storageInterior] && GetPlayerVirtualWorld(playerid) == HouseStorage[i][storageWorld])
        {
            storageid = i;
            break;
        }
    }
    return storageid;
}

Storage_DeleteHouseRacks(playerid)
{
    foreach(new i: HStorage_Iter)
    {
        if(!Storage_Exists(i))
        {
            continue;
        }

        if(GetPlayerInterior(playerid) == HouseStorage[i][storageInterior] && GetPlayerVirtualWorld(playerid) == HouseStorage[i][storageWorld])
        {
            Storage_RackDelete(i);
        }
    }
    return -1;
}

Storage_RackDelete(storageid)
{
    if(!Iter_Contains(HStorage_Iter, storageid))
    {
        return 1;
    }

    if(!Storage_Exists(storageid))
    {
        return 1;
    }

    mysql_fquery(SQL_Handle(), "DELETE FROM house_storage WHERE storageID = '%d'", HouseStorage[storageid][storageID]);

    for (new i = 0; i < (MAX_WEAPON_ONRACK + 1); i++)
    {
        if(IsValidDynamicObject(HouseStorage[storageid][storageObjects][i]))
        {
            DestroyDynamicObject(HouseStorage[storageid][storageObjects][i]);
            HouseStorage[storageid][storageWeapons][i] = 0;
            HouseStorage[storageid][storageAmmo][i] = 0;
        }
    }
    HouseStorage[storageid][storageExists] = false;
    HouseStorage[storageid][storageID] = 0;
    HouseStorage[storageid][storageHouse] = 0;

    Iter_Remove(HStorage_Iter, storageid);
    return 1;
}

Storage_HouseRackCount(playerid)
{
    new count = 0;
    foreach(new i: HStorage_Iter)
    {
        if(HouseStorage[i][storageExists] && HouseStorage[i][storageHouse] == PlayerKeys[playerid][pHouseKey])
            count++;
    }
    return count;
}

Storage_GetRackWeaponInSlot(storageid, slot)
{
    if(!Storage_Exists(storageid) || slot < 0 || slot > MAX_WEAPON_ONRACK)
    {
        return -1;
    }

    return HouseStorage[storageid][storageWeapons][slot];
}

Storage_GetRackAmmoInSlot(storageid, slot)
{
    if(!Storage_Exists(storageid) || slot < 0 || slot > MAX_WEAPON_ONRACK)
    {
        return 0;
    }

    return HouseStorage[storageid][storageAmmo][slot];
}

Storage_SetRackWeaponInSlot(storageid, slot, weapon)
{
    if(!Storage_Exists(storageid) || slot < 0 || slot > MAX_WEAPON_ONRACK)
    {
        return 0;
    }

    HouseStorage[storageid][storageWeapons][slot] = weapon;
    return 1;
}

Storage_SetRackAmmoInSlot(storageid, slot, ammo)
{
    if(!Storage_Exists(storageid) || slot < 0 || slot > MAX_WEAPON_ONRACK)
    {
        return 0;
    }

    HouseStorage[storageid][storageAmmo][slot] = ammo;
    return 1;
}

Storage_ListHouseStorage(storageid)
{
    new
        winfo[256],
        motd[64];
    format(motd, sizeof(motd), "\n");
    strcat(winfo, motd, sizeof(winfo));

    if(!Storage_Exists(storageid))
    {
        return winfo;
    }

    for (new i = 0; i < MAX_WEAPON_ONRACK; i++)
    {
        if(HouseStorage[storageid][storageWeapons][i] != 0)
        {
            format(motd, sizeof(motd), "\t{3C95C2}[slot %d]: %s [%d/500 metaka].\n", i+1, GetWeaponNameEx(HouseStorage[storageid][storageWeapons][i]), HouseStorage[storageid][storageAmmo][i]);
            strcat(winfo, motd, sizeof(winfo));
        }
    }
    return winfo;
}

Public:OnRackCreated(storageid, playerid)
{
    if(!Storage_Exists(storageid))
    {
        return 0;
    }

    HouseStorage[storageid][storageID] = cache_insert_id();
    Iter_Add(HStorage_Iter, storageid);
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

hook function LoadServerData()
{
    LoadHouseStorages();
	return continue();

}

hook OnPlayerConnect(playerid, reason)
{
    p_EditRack[playerid] = INVALID_PLAYER_ID;
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_HOUSE_PUT:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak\n{3C95C2}[6] - Sef za novac.","Pick","Exit");
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {
                    if(IsACop(playerid) || IsASD(playerid))
                        return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete to koristiti!");

                    new storageid = Storage_PlayerNearRack(playerid);
                    if(storageid == -1)
                        return SendErrorMessage(playerid, "Morate biti u blizini Rack-a u vasoj kuci.");

                    if(Storage_Exists(storageid))
                    {
                        new string[256];
                        for (new i = 0; i < MAX_WEAPON_ONRACK; i++)
                        {
                            if(!HouseStorage[storageid][storageWeapons][i])
                            {
                                format(string, sizeof(string), "%s{3C95C2}[SLOT %d]: EMPTY SLOT\n", string, i + 1);
                            }
                            else
                            {
                                format(string, sizeof(string), "%s{3C95C2}[SLOT %d]:  %s  [ammo: %d/500]\n", string, i + 1, GetWeaponNameEx(HouseStorage[storageid][storageWeapons][i]), HouseStorage[storageid][storageAmmo][i]);
                            }
                        }
                        ShowPlayerDialog(playerid, DIALOG_WSTORAGE_PUT, DIALOG_STYLE_LIST, "[HOUSE] - Stalak Ostavi", string, "Pick", "Exit");
                    }
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_TAKE:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak","Pick","Exit");
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {
                    new storageid = Storage_PlayerNearRack(playerid);
                    if(storageid == -1)
                        return SendErrorMessage(playerid, "Morate biti u blizini Rack-a u vasoj kuci.");

                    if(Storage_Exists(storageid))
                    {
                        new string[256];
                        for (new i = 0; i < MAX_WEAPON_ONRACK; i++)
                        {
                            if(!HouseStorage[storageid][storageWeapons][i])
                                format(string, sizeof(string), "%s{3C95C2}[SLOT %d]: EMPTY SLOT\n", string, i + 1);

                            else format(string, sizeof(string), "%s{3C95C2}[SLOT %d]:  %s  [ammo: %d/500]\n", string, i + 1,GetWeaponNameEx( HouseStorage[storageid][storageWeapons][i]), HouseStorage[storageid][storageAmmo][i]);
                        }
                        ShowPlayerDialog(playerid, DIALOG_WSTORAGE_TAKE, DIALOG_STYLE_LIST, "[HOUSE] - Stalak Uzmi", string, "Pick", "Exit");
                    }
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_STORAGE:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_MAIN,DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu($10000)","Pick","Exit");
                return 1;
            }

            switch (listitem)
            {
                case 0:
                { // put
                    ShowPlayerDialog(playerid,  DIALOG_HOUSE_PUT, DIALOG_STYLE_LIST, "Odaberite sto zelite pohraniti:", "Oruzje", "Pick", "Exit");
                }
                case 1:
                { // take
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_TAKE, DIALOG_STYLE_LIST, "Odaberite sto zelite uzeti:", "Oruzje", "Pick", "Exit");
                }
                case 2:
                { // buy rack
                    new buffer[210+10];
                    format(buffer, sizeof(buffer), "\nZelite li kupiti 'Stalak' za vasu kucu?\nKupovinom Stalka dobivate (+)4 slota za ostavu oruzija.\n\nCijena Stalka je {3C95C2}%d$, a vi mozete kupiti jos {3C95C2}%d. komad/a.", RACK_PRICE, GetRackLimit(playerid));
                    ShowPlayerDialog(playerid, DIALOG_HSTORAGE_BUYRACK, DIALOG_STYLE_MSGBOX, "{3C95C2}House Storage - Stalak", buffer, "Buy", "Exit");
                }
                case 3:
                { // info
                    new storageid = Storage_PlayerNearRack(playerid);
                    if(storageid == -1)
                        return SendErrorMessage(playerid, "Morate biti u blizini Stalka u vasoj kuci.");

                    ShowPlayerDialog(playerid, DIALOG_HSTORAGE_INFO, DIALOG_STYLE_MSGBOX, "{3C95C2}[Stalak - Statistika]", Storage_ListHouseStorage(storageid), "Ok", "");
                }
                case 4:
                { // Izbrisi Stalak
                    new storageid = Storage_PlayerNearRack(playerid);
                    if(storageid == -1)
                        return SendErrorMessage(playerid, "Niste u blizini stalka u vasoj kuci.");

                    Storage_RackDelete(storageid);
                    va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali stalak iz vase kuce.");
                }
                case 5:
                { // Sef za novac.
                    new house = PlayerKeys[playerid][pHouseKey];
                    if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema sef!");

                    ShowPlayerDialog(playerid, DIALOG_HOUSE_SEF, DIALOG_STYLE_LIST, "{3C95C2}[Safe - Money]","{3C95C2}[1] - Ostavi novac.\n{3C95C2}[2] - Uzmi novac.","Pick","Exit");
                }
            }
            return 1;
        }
        case DIALOG_HSTORAGE_EDIT:
        {
            if(response)
            {
                HouseStorage_Save(p_EditRack[playerid]);
                Storage_RackRefresh(p_EditRack[playerid]);
                p_EditRack[playerid] = INVALID_PLAYER_ID;

                PlayerToBudgetMoney(playerid, RACK_PRICE);
                SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste kupili stalak za vasu kucu, da ga kontrolirate (/house -> house storage).");
            }
            else if(!response)
            {
                EditDynamicObject(playerid, HouseStorage[p_EditRack[playerid]][storageObjects][4]);
            }
            return 1;
        }
        case DIALOG_WSTORAGE_TAKE:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak","Pick","Exit");
                return 1;
            }

            new id = Storage_PlayerNearRack(playerid),
                house = PlayerKeys[playerid][pHouseKey],
                puzavac = IsCrounching(playerid); // TODO: rename, crouching

            if(id == -1)
            {
                return 1;
            }

            // TODO: check if listitem in range
            if(HouseStorage[id][storageWeapons][listitem])
            {
                if(house == INVALID_HOUSE_ID && HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID])
                    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo vlasnik kuce moze uzeti oruzje iz sefa!");

                if(!CheckPlayerWeapons(playerid, HouseStorage[id][storageWeapons][listitem])) return 1;
                AC_GivePlayerWeapon(playerid, HouseStorage[id][storageWeapons][listitem], HouseStorage[id][storageAmmo][listitem]);
                SetAnimationForWeapon(playerid, HouseStorage[id][storageWeapons][listitem], puzavac);

                Log_Write("/logfiles/gunrack.txt", "(%s) %s took a weapon %s(Ammo:%d) from gunrack ID %d[SQLID: %d].",
                    ReturnDate(),
                    GetName(playerid, false),
                    GetWeaponNameEx(HouseStorage[id][storageWeapons][listitem]),
                    HouseStorage[id][storageAmmo][listitem],
                    id,
                    HouseStorage[id][storageID]
               );

                HouseStorage[id][storageWeapons][listitem] = 0;
                HouseStorage[id][storageAmmo][listitem] = 0;
                HouseStorage_SaveWep(id, listitem);

                Storage_RackRefresh(id);
                HouseStorage_Save(id);
            }
            return 1;
        }
        case DIALOG_HSTORAGE_BUYRACK:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak","Pick","Exit");
                return 1;
            }

            if(Storage_HouseRackCount(playerid) >= GetRackLimit(playerid))
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Kuca vec posjeduje stalak, da mozete imati vise morate biti donator.");

            new id = Storage_RackCreate(playerid, PlayerKeys[playerid][pHouseKey]);
            if(id == -1)
                return SendErrorMessage(playerid, "Trenutno nije moguce kupiti stalak za kucu.");

            p_EditRack[playerid] = id;
            EditDynamicObject(playerid, HouseStorage[id][storageObjects][4]);

            SendClientMessage(playerid, COLOR_RED, "[!] Sada morate namjestiti poziciju vaseg stalka u kuci...");
            return 1;
        }
        case DIALOG_WSTORAGE_PUT:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak","Pick","Exit");
                return 1;
            }

            new id = Storage_PlayerNearRack(playerid),
            weapon = AC_GetPlayerWeapon(playerid),
            ammo = AC_GetPlayerAmmo(playerid);

            if(id == -1)
            {
                return 1;
            }
            // TODO: check if listitem in range
            if(!HouseStorage[id][storageWeapons][listitem])
            {
                if(weapon == 0 || ammo == 0)
                    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nikakvo oruzje u ruci/oruzje nema municije.");

                if(ammo > 500)
                    return SendErrorMessage(playerid, "Ne mozete ostaviti vise od 500 metaka na stalak.");

                HouseStorage[id][storageWeapons][listitem] = weapon;
                HouseStorage[id][storageAmmo][listitem] = ammo;

                AC_ResetPlayerWeapon(playerid, weapon);

                Log_Write("/logfiles/gunrack.txt", "(%s) %s put a weapon %s(Ammo:%d) on gunrack ID %d[SQLID: %d].",
                    ReturnDate(),
                    GetName(playerid, false),
                    GetWeaponNameEx(HouseStorage[id][storageWeapons][listitem]),
                    HouseStorage[id][storageAmmo][listitem],
                    id,
                    HouseStorage[id][storageID]
               );

                Storage_RackRefresh(id);
                HouseStorage_SaveWep(id, listitem);
                HouseStorage_Save(id);

                ApplyAnimation(playerid, "WEAPONS", "SHP_Ar_Lift", 4.1, 0, 0, 0, 0, 0, 1);
            }
            return 1;
        }
    }
    return 0;
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

CMD:check_gunrack(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
        return 1;
    }

    new storageid = Storage_PlayerNearRack(playerid);
    if(storageid == -1)
    {
        SendErrorMessage(playerid, "Morate biti u blizini Stalka.");
        return 1;
    }

    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}[Stalak - Statistika]", Storage_ListHouseStorage(storageid), "Ok", "");
    return 1;
}
