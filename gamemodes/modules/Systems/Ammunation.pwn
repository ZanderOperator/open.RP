// Ammunation v1.2 by Woo
// ##################################################
// koristi pAmmuTime, MySQL bazu "ammunation_weapons"

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

#define MAX_AMMU_SLOTS              (44)


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum E_AMMUNATION_DATA
{
    aiSQLID,
    aiName[20],
    aiWeapon,
    aiPrice,
    aiLicense,
    aiMaxBullets
}

static
    AmmuInfo[MAX_AMMU_SLOTS][E_AMMUNATION_DATA],
    Iterator:AmmuIterator<MAX_AMMU_SLOTS>,
    PlayerWeapPick[MAX_PLAYERS];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

Public:OnAmmuWeaponInsert(slot)
{
    AmmuInfo[slot][aiSQLID] = cache_insert_id();
    return 1;
}

Public:OnAmmuWeaponsLoaded()
{
    new
        rows = cache_num_rows();

    if(!rows)
    {
        print("MySQL Report: No Ammunation weapons data exist to load.");
        return 1;
    }

    for (new slotid = 0; slotid < rows; slotid++)
    {
        cache_get_value_name_int(slotid, "id", AmmuInfo[slotid][aiSQLID]);
        cache_get_value_name(slotid, "name", AmmuInfo[slotid][aiName], 64);
        cache_get_value_name_int(slotid, "weapon", AmmuInfo[slotid][aiWeapon]);
        cache_get_value_name_int(slotid, "price", AmmuInfo[slotid][aiPrice]);
        cache_get_value_name_int(slotid, "license", AmmuInfo[slotid][aiLicense]);
        cache_get_value_name_int(slotid, "maxbullets", AmmuInfo[slotid][aiMaxBullets]);
        Iter_Add(AmmuIterator, slotid);
    }
    printf("MySQL Report: Ammunation Weapons Loaded. [%d/%d]", rows, MAX_AMMU_SLOTS);
    return 1;
}

stock LoadAmmunation() 
{
    mysql_pquery(g_SQL, 
        "SELECT * FROM ammunation_weapons WHERE 1", 
        "OnAmmuWeaponsLoaded",
        ""
    );
    return 1;
}

static stock UpdateAmmuWeapon(slotid) // Updateanje ourzja u listi
{
    mysql_fquery(g_SQL, 
        "UPDATE ammunation_weapons SET name='%e',weapon=%d,price=%d,license=%d,maxbullets=%d WHERE id=%d",
        AmmuInfo[slotid][aiName],
        AmmuInfo[slotid][aiWeapon],
        AmmuInfo[slotid][aiPrice],
        AmmuInfo[slotid][aiLicense],
        AmmuInfo[slotid][aiMaxBullets],
        AmmuInfo[slotid][aiSQLID]
    );
    return 1;
}

static stock DeleteAmmuWeapon(slotid) // Delete oruzja iz liste
{
    mysql_fquery(g_SQL, "DELETE FROM ammunation_weapons WHERE id=%d", AmmuInfo[slotid][aiSQLID]);
    return 1;
}

static stock InsertAmmuWeapon(slotid) // Dodavanje novog oruzja
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, 
            "INSERT INTO ammunation_weapons (name, weapon, price, license, maxbullets) VALUES ('%e',%d,%d,%d,%d)",
            AmmuInfo[slotid][aiName],
            AmmuInfo[slotid][aiWeapon],
            AmmuInfo[slotid][aiPrice],
            AmmuInfo[slotid][aiLicense],
            AmmuInfo[slotid][aiMaxBullets]
        ), 
        "OnAmmuWeaponInsert", 
        "i", 
        slotid
    );
    return 1;
}

static stock PlayerAmmunationBuyTime(playerid, days)
{
    new ammutime, date[12], time[12];
    ammutime = days * 86400;
    ammutime += gettimestamp();
    // TODO: getter and setter into Player module
    PlayerCoolDown[playerid][pAmmuCool] = ammutime;
    // Also, immediately save this value into database...

    TimeFormat(Timestamp:ammutime, HUMAN_DATE, date);
    TimeFormat(Timestamp:ammutime, ISO6801_TIME, time);

    va_SendClientMessage(playerid, COLOR_YELLOW, "Next time you can buy a weapon in ammunation is after %d days. "COL_RED"(After %s %s)",
        days,
        date,
        time
    );
}


/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

hook function LoadServerData()
{
    LoadAmmunation();
	return continue();

}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_AMMUNATION_MENU: // Igrac bira oruzje
        {
            if(!response) return 1;

            PlayerWeapPick[playerid] = listitem;
            ShowPlayerDialog(playerid, DIALOG_AMMUNATION_BUY, DIALOG_STYLE_INPUT, "MUNICIJA", "Koliko metaka?", "Buy", "Cancel");
            return 1;
        }
        case DIALOG_AMMUNATION_BUY: //Igrac bira metke
        {
            if(!response) return 1;

            new
                bullets = strval(inputtext),
                safe_bullets = floatround(floatabs(bullets)),
                index = PlayerWeapPick[playerid],
                money = AmmuInfo[index][aiPrice] * safe_bullets;

            if(safe_bullets == 0 || safe_bullets > AmmuInfo[index][aiMaxBullets])
            {
                SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalni broj metaka za %s je %d!", AmmuInfo[index][aiName], AmmuInfo[index][aiMaxBullets]);
                return 1;
            }
            if(AC_GetPlayerMoney(playerid) < money) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");
            if(LicenseInfo[playerid][pGunLic] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate licensu za oruzje!");

            if(!CheckPlayerWeapons(playerid, AmmuInfo[index][aiWeapon])) return 1;

            AC_GivePlayerWeapon(playerid, AmmuInfo[index][aiWeapon], safe_bullets);
            PlayerToBudgetMoney(playerid, money); // Budget dobiva novce
            PlayerWeapPick[playerid] = -1;

            // Lookup table instead of control structures
            static const ammu_cooldown_time[] =
            {
                7, 5, 3, 1, 1
            };
            new donate_rank = PlayerVIP[playerid][pDonateRank];
            // Postavljanje igracu zabranu na X dana kupovanja
            PlayerAmmunationBuyTime(playerid, ammu_cooldown_time[donate_rank % sizeof(ammu_cooldown_time)]);
            /* TODO: delete this once understood code above. Just make sure modulo by is equal to the size of the array.
            switch (PlayerVIP[playerid][pDonateRank])
            {
                case 0: PlayerAmmunationBuyTime(playerid, 7);
                case 1: PlayerAmmunationBuyTime(playerid, 5); // Postavljanje igracu zabranu na 7 dana kupovanja
                case 2: PlayerAmmunationBuyTime(playerid, 3); // Postavljanje igracu zabranu na 3 dana kupovanja
                case 3,4: PlayerAmmunationBuyTime(playerid, 1); // Postavljanje igracu zabranu na 1 dan kupovanja
            }
            */

            #if defined MODULE_LOGS
            Log_Write("/logfiles/ammunation_buy.txt", "%s bought %s with %d bullets for %d$.",
                GetName(playerid),
                AmmuInfo[index][aiName],
                safe_bullets,
                money
            );
            #endif

            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupili ste %s sa %d metaka za %d$!",
                AmmuInfo[index][aiName],
                safe_bullets,
                money
            );
            return 1;
        }
    }
    return 0;
}

hook OnPlayerDisconnect(playerid, reason)
{
    PlayerWeapPick[playerid] = -1;
    return 1;
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

CMD:buyweapon(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 4.0, 295.0016,-38.3526,1001.5156)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne nalazite se na mjestu za kupovinu oruzja.");

    // --- Provjera je li igracu isteklo vrijeme za kupnju  ------------
    if(PlayerCoolDown[playerid][pAmmuCool] < gettimestamp())
    {
        new string[256];
        format(string, sizeof(string), "Oruzje\tCijena\tMaxAmmo\n");
        foreach(new i : AmmuIterator)
        {
            // TODO: use strcat here, it's faster than format. Be sure to test the code afterwards!
            format(string, sizeof(string), "%s{EBD7A9}%s\t%d$\t%d\n", string, AmmuInfo[i][aiName], AmmuInfo[i][aiPrice], AmmuInfo[i][aiMaxBullets]);
        }
        ShowPlayerDialog(playerid, DIALOG_AMMUNATION_MENU, DIALOG_STYLE_TABLIST_HEADERS, "AMMUNATION", string, "Choose", "Abort");
    }
    else
    {
        new timestamp = PlayerCoolDown[playerid][pAmmuCool],
            date[12],
            time[12];

        TimeFormat(Timestamp:timestamp, HUMAN_DATE, date);
        TimeFormat(Timestamp:timestamp, ISO6801_TIME, time);

        va_SendClientMessage(playerid, COLOR_RED, "[!] Your purchase cannot be authorised until %s %s",
            date,
            time
        );
    }
    return 1;
}

CMD:ammunation(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste ovlasteni!");

    new pick[8], id, weapon, price, license, maxbullets, name[32], freeslot;
    if(sscanf(params, "s[8]", pick)) return SendClientMessage(playerid, -1, "KORISTENJE /ammunation [list/add/edit/delete/rpt (resetplayertime)]");

    if(!strcmp(pick, "add", true))
    {
        if(sscanf(params, "s[8]iiiis[32]", pick, weapon, price, license, maxbullets, name)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ammu add [weapon_id][cijena po metku][licenca (1/2)][max bullets][ime oruzja]");
        if(1 > weapon > 44) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Krivi weapon ID!");
        if(1 > price > 9999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Cijena po metku moze biti od 1 - 9999");
        if(1 > license > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Licenca moze biti 1 (CCW) ili 2 (OCW)!");
        if(1 > maxbullets > 9999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalno metaka po kupovini u 7 dana je 1 - 9999");

        freeslot = Iter_Free(AmmuIterator);

        // TODO: use strcpy for copying strings
        format(AmmuInfo[freeslot][aiName], 32, name);
        AmmuInfo[freeslot][aiWeapon] = weapon;
        AmmuInfo[freeslot][aiPrice] = price;
        AmmuInfo[freeslot][aiLicense] = license;
        AmmuInfo[freeslot][aiMaxBullets] = maxbullets;
        Iter_Add(AmmuIterator, freeslot);
        InsertAmmuWeapon(freeslot);

        va_SendClientMessage(playerid, COLOR_RED, "[!] (ADD) SlotID [%d] - %s[%d] | %d$ | license: %d | maxbullets: %d",
            freeslot,
            name,
            weapon,
            price,
            license,
            maxbullets
        );
    }
    else if(!strcmp(pick, "delete", true))
    {
        new slotid;
        if(sscanf(params, "s[8]i", pick, slotid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ammunation delete [slotid]");
        if(slotid < 0 && slotid > MAX_AMMU_SLOTS) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID (0-%d).", MAX_AMMU_SLOTS-1);

        AmmuInfo[slotid][aiSQLID] = 0;
        AmmuInfo[slotid][aiName] = EOS;
        AmmuInfo[slotid][aiWeapon] = 0;
        AmmuInfo[slotid][aiPrice] = 0;
        AmmuInfo[slotid][aiLicense] = 0;
        AmmuInfo[slotid][aiMaxBullets] =0;
        Iter_Remove(AmmuIterator, slotid);
        DeleteAmmuWeapon(slotid);

        va_SendClientMessage(playerid, COLOR_RED, "[!] (DELETE) Obrisali ste ID[%d] %s!", slotid, name);
    }
    else if(!strcmp(pick, "edit", true))
    {
        if(sscanf(params, "s[8]iiiiis[32]", pick, id, weapon, price, license, maxbullets, name)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ammunation edit [slotID][weapon_id][cijena po metku][licenca (1/2)][max bullets][ime oruzja]");
        if(1 > weapon > 44) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Krivi weapon ID!");
        if(1 > price > 9999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Cijena po metku moze biti od 1 - 9999");
        if(1 > license > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Licenca moze biti 1 (CCW) ili 2 (OCW)!");
        if(1 > maxbullets > 9999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalno metaka po kupovini u 7 dana je 1 - 9999");
        if(!Iter_Contains(AmmuIterator, id)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Taj slot je prazan!");

        // TODO: use strcpy
        format(AmmuInfo[id][aiName], 32, name);
        AmmuInfo[id][aiWeapon] = weapon;
        AmmuInfo[id][aiPrice] = price;
        AmmuInfo[id][aiLicense] = license;
        AmmuInfo[id][aiMaxBullets] = maxbullets;
        UpdateAmmuWeapon(id);

        va_SendClientMessage(playerid, COLOR_RED, "[!] (EDIT) SlotID [%d] - %s[%d] | %d$ | license: %d | maxbullets: %d",
            id,
            name,
            weapon,
            price,
            license,
            maxbullets
        );
    }
    else if(!strcmp(pick, "list", true))
    {
        if(sscanf(params, "s[8]", pick)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ammunation list");
        if(Iter_Count(AmmuIterator) == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Baza je prazna!");

        SendClientMessage( playerid, COLOR_SAMP_BLUE, "--------- AMMUNATION LISTA ORUZJA --------");
        foreach(new i : AmmuIterator)
        {
            va_SendClientMessage(playerid, -1, "SlotID: [%d]: %s[%d] Cijena: %d  Licenca: %d  MaxBullets: %d",
                i,
                AmmuInfo[i][aiName],
                AmmuInfo[i][aiWeapon],
                AmmuInfo[i][aiPrice],
                AmmuInfo[i][aiLicense],
                AmmuInfo[i][aiMaxBullets]
            );
        }
    }
    else if(!strcmp(pick, "rpt", true))
    {
        new giveplayerid;
        if(sscanf(params, "s[8]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ammunation rpt [ID/PlayerName]");

        PlayerCoolDown[giveplayerid][pAmmuCool] = 0;

        mysql_fquery(g_SQL, "UPDATE player_cooldowns SET ammutime = '0' WHERE sqlid=%d", PlayerInfo[giveplayerid][pSQLID]);

        va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Admin %s ti je resetirao vrijeme kupovine oruzja u Ammunationu!", GetName(playerid));
        va_SendClientMessage(playerid, COLOR_RED, "[!] Resetirao si igracu %s vrijeme kupovine oruzja u Ammunationu!", GetName(giveplayerid));
        return 1;
    }
    else
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznat izbor!");
    }
    return 1;
}

CMD:buyarmour(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 4.0, 295.0016, -38.3526, 1001.5156)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne nalazite se na mjestu za kupovinu armoura.");
    if(LicenseInfo[playerid][pGunLic] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate licensu za oruzje!");
    if(AC_GetPlayerMoney(playerid) < 6000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");

    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
    SetPlayerArmour(playerid, 50);
    PlayerCrash[playerid][pCrashArmour]  = 50;
    PlayerToBudgetMoney(playerid, 6000);

    SendClientMessage(playerid, COLOR_RED, "[!] Kupili ste pancirku!");
    return 1;
}

CMD:issueweaplic(playerid, params[])
{
    new giveplayerid;
    if(sscanf(params, "u", giveplayerid))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /issueweaplicense [playerid/name]");
        return 1;
    }
    if(LicenseInfo[giveplayerid][pGunLic] == 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Osoba vec ima dozvolu za oruzje!");
        return 1;
    }
    if(!(IsACop(playerid) && PlayerFaction[playerid][pRank] > 5) || PlayerFaction[playerid][pLeader] != 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
        return 1;
    }

    LicenseInfo[giveplayerid][pGunLic] = 1;
    PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);

    new string[120];
    format(string, sizeof(string), "*[HQ] %s %s je izdao weapon licensu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);
    return 1;
}

CMD:revokeweaplic(playerid, params[])
{
    new giveplayerid;
    if(sscanf(params, "u", giveplayerid))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /revokeweaplic [playerid/name]");
        return 1;
    }
    if(LicenseInfo[giveplayerid][pGunLic] == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Osoba nema dozvolu za oruzje!");
        return 1;
    }
    if(!IsACop(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
        return 1;
    }

    LicenseInfo[giveplayerid][pGunLic] = 0;
    PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);

    new string[120];
    format(string, sizeof(string), "*[HQ] %s %s je oduzeo weapon licensu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);
    return 1;
}
