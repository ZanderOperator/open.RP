// Woo ticket system
#if defined MODULE_TICKETS
    #endinput
#endif
#define MODULE_TICKETS

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
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum E_TICKET_DATA
{
    tkID,
    tkPrimatelj[MAX_PLAYER_NAME],
    tkOfficer[MAX_PLAYER_NAME],
    tkNovac,
    tkRazlog[100],
    tkDatum[30]
}

static
    TicketInfo[MAX_PLAYERS][E_TICKET_DATA];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

// TODO: make all non-API/helper functions static and make API forward declarations
// in LSPD_h.pwn header file

stock GetVehicleTicketReason(ticketsql)
{
    new
        reason[64],
        Cache:result,
        ticketQuery[128];
    // TODO: convert to threaded query?
    format(ticketQuery, sizeof(ticketQuery), "SELECT `reason` FROM `cocars_tickets` WHERE `id` = '%d'", ticketsql);
    result = mysql_query(g_SQL, ticketQuery);
    if (result == MYSQL_INVALID_CACHE)
        format(reason, sizeof(reason), "None");
    else
        cache_get_value_index(0, 0, reason);
    cache_delete(result);
    return reason;
}

stock InsertPlayerTicket(playerid, giveplayerid, money, const reason[])
{
    // TODO: use strcpy for copying strings
    format(TicketInfo[giveplayerid][tkPrimatelj], MAX_PLAYER_NAME, GetName(giveplayerid, false));
    format(TicketInfo[giveplayerid][tkOfficer] , MAX_PLAYER_NAME, GetName(playerid, false));
    TicketInfo[giveplayerid][tkNovac] = money;
    format(TicketInfo[giveplayerid][tkRazlog], 100, reason);

    new Day, Month, Year;
    getdate(Year, Month, Day);

    format(TicketInfo[giveplayerid][tkDatum], 32, "%02d.%02d.%d.", Day, Month, Year);

    new query[512];
    mysql_tquery(g_SQL, "BEGIN");

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO tickets (`primatelj`, `officer`, `novac`, `razlog`, `datum`) VALUES ('%e', '%e', '%d', '%e', '%e')",
        TicketInfo[giveplayerid][tkPrimatelj],
        TicketInfo[giveplayerid][tkOfficer],
        TicketInfo[giveplayerid][tkNovac],
        TicketInfo[giveplayerid][tkRazlog],
        TicketInfo[giveplayerid][tkDatum]
    );
    SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si dao kaznu %s! ", TicketInfo[giveplayerid][tkPrimatelj]);
    mysql_tquery(g_SQL, query, "");
    mysql_tquery(g_SQL, "COMMIT");
}

Public:OnVehicleTicketInsert(vehicleid, slot)
{
    VehicleInfo[vehicleid][vTicketsSQLID][slot] = cache_insert_id();
    return 1;
}

stock DeletePlayerTicket(playerid, sqlid, bool:notification = false)
{
    new
        query[256];
    format(query, sizeof(query), "DELETE FROM tickets WHERE `id` = '%d'", sqlid);
    mysql_tquery(g_SQL, query, "");

    if (notification)
        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kazna #%d je uspjesno izbrisana iz baze podataka.", sqlid);
}

stock LoadVehicleTickets(vehicleid)
{
    new
        query[128];
    format(query, sizeof(query), "SELECT * FROM `cocars_tickets` WHERE `vehicle_id` = '%d' LIMIT 0,%d",
        VehicleInfo[vehicleid][vSQLID],
        MAX_VEHICLE_TICKETS
    );
    mysql_pquery(g_SQL, query, "LoadingVehicleTickets", "i", vehicleid);
    return 1;
}

Public:LoadingVehicleTickets(vehicleid)
{
    #if defined MOD_DEBUG
        printf("DEBUG CAR WEAPONS: count(%d)", cache_num_rows());
    #endif

    if (cache_num_rows())
    {
        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i,  "id"       , VehicleInfo[vehicleid][vTicketsSQLID][i]);
            cache_get_value_name_int(i,  "isShown"  , VehicleInfo[vehicleid][vTicketShown][i]);
            cache_get_value_name_int(i,  "price"    , VehicleInfo[vehicleid][vTickets][i]);
            cache_get_value_name_int(i,  "time"     , VehicleInfo[vehicleid][vTicketStamp][i]);

            #if defined MOD_DEBUG
                printf("DEBUG CAR TICKETS: i(%d) | sqlid(%d) | isShown(%d) | price(%d) | time(%d)",
                    i,
                    VehicleInfo[vehicleid][vSQLID],
                    VehicleInfo[vehicleid][vTicketShown][i],
                    VehicleInfo[vehicleid][vTickets][i],
                    VehicleInfo[vehicleid][vTicketStamp][i]
                );
            #endif
        }
    }
    return 1;
}


stock LoadPlayerTickets(playerid, const playername[])
{
    new
        query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM tickets WHERE `primatelj` = '%e'", playername);

    inline OnTicketLoad()
    {
        if (!cache_num_rows())
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nikakvih kazni!");

        new
            buffer[2048],
            tmp[128],
            motd[256];

        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i, "id", TicketInfo[i][tkID]);
            cache_get_value_name(i,"primatelj"  , tmp, sizeof(tmp));
            format(TicketInfo[i][tkPrimatelj], MAX_PLAYER_NAME, tmp );
            cache_get_value_name(i,"officer"    , tmp, sizeof(tmp));
            format(TicketInfo[i][tkOfficer], MAX_PLAYER_NAME, tmp );
            cache_get_value_name_int(i, "novac", TicketInfo[i][tkNovac]);
            cache_get_value_name(i, "razlog", tmp, sizeof(tmp));
            format(TicketInfo[i][tkRazlog], 100, tmp );
            cache_get_value_name(i, "datum", tmp, sizeof(tmp));
            format(TicketInfo[i][tkDatum], 30, tmp );

            format(motd, sizeof(motd), "ID #%d | Datum: %s | Primatelj: %s | Officer: %s | Iznos kazne: %d$ | Razlog: %s\n",
                TicketInfo[i][tkID],
                TicketInfo[i][tkDatum],
                TicketInfo[i][tkPrimatelj],
                TicketInfo[i][tkOfficer],
                TicketInfo[i][tkNovac],
                TicketInfo[i][tkRazlog]
            );
            strcat(buffer, motd, sizeof(buffer));
        }

        new string[64];
        format(string, sizeof(string), "[%s - KAZNE]", playername);
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, string, buffer, "Close", "");
    }
    mysql_tquery_inline_new(g_SQL, query, using inline OnTicketLoad, "");
    return 1;
}

stock ShowVehicleTickets(playerid, vehicleid)
{
    new caption[50],
        motd[256],
        buffer[2048];

    for (new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if (VehicleInfo[vehicleid][vTicketsSQLID][i] != 0)
        {
            format(motd, sizeof(motd), "ID #%d | Iznos kazne: %d$ | Razlog: %s\n",
                (i+1),
                VehicleInfo[vehicleid][vTickets][i],
                GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][i])
            );
            strcat(buffer, motd, sizeof(buffer));
        }
    }
    format(caption, sizeof(caption), "[%s - KAZNE]", ReturnVehicleName(GetVehicleModel(vehicleid)));
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, caption, buffer, "Close", "");
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

CMD:ticket(playerid, params[])
{
    new param[12], id;
    if (sscanf(params, "s[12] ", param)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket [show / vehicleshow / pay / vehiclepay ]");

    // TODO: use YHash instead of slow strcmp matching: switch (_YHash(param)) { case _H<show>: } etc
    // https://web.archive.org/web/20190419205838/https://forum.sa-mp.com/showthread.php?t=571305
    if (!strcmp(param, "show", true))
    {
        LoadPlayerTickets(playerid, GetName(playerid, false));
    }
    if (!strcmp(param, "vehicleshow", true))
    {
        new vehicleid = PlayerInfo[playerid][pSpawnedCar];

        if (vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano svoje vozilo!");

        if (!VehicleInfo[vehicleid][vTickets][0] && !VehicleInfo[vehicleid][vTickets][1] && !VehicleInfo[vehicleid][vTickets][2] && !VehicleInfo[vehicleid][vTickets][3] && !VehicleInfo[vehicleid][vTickets][4] )
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno vozilo nema kazna na sebi!");

        ShowVehicleTickets(playerid, vehicleid);
    }
    if (!strcmp(param, "pay", true))
    {
        if (!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar City Hall-a!");
        if (sscanf( params, "s[12]i", param, id)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket pay [ID kazne]");

        new
            ticketsQuery[62],
            tmp[64],
            prima[MAX_PLAYER_NAME],
            Cache:result;

        format(ticketsQuery, 62, "SELECT id, primatelj, novac FROM tickets WHERE id = '%d'", id);
        result = mysql_query(g_SQL, ticketsQuery);
        if (!cache_num_rows()) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji kazna sa ID-em #%d !", id);

        new ticketId, moneys;
        cache_get_value_name(0, "primatelj", tmp, sizeof(tmp));
        format(prima, MAX_PLAYER_NAME, tmp );
        cache_get_value_name_int(0, "id"        , ticketId);
        cache_get_value_name_int(0, "novac"     , moneys);

        if (!strcmp(prima, GetName(playerid,false), true) && ticketId == id)
        {
            if (AC_GetPlayerMoney(playerid) < moneys) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca, fali vam %d$.", moneys-AC_GetPlayerMoney(playerid));

            PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, moneys); // Novac dolazi u faction bank
            DeletePlayerTicket(playerid, id, false);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Platili ste kaznu #%d (%d$).", id, moneys);
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, " To nije vasa kazna!"); // provjera ima li sta u bazi
        cache_delete(result);
    }
    else if (!strcmp(param, "vehiclepay", true))
    {
        if (!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar City Hall-a!");
        new
            vehicleid, slot;
        if (sscanf( params, "s[12]i", param, slot)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /payticket vehicle [slot (1-5)]");

        vehicleid = PlayerInfo[playerid][pSpawnedCar];
        if (vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano svoje vozilo!");

        if (!VehicleInfo[vehicleid][vTickets][0] && !VehicleInfo[vehicleid][vTickets][1] && !VehicleInfo[vehicleid][vTickets][2] && !VehicleInfo[vehicleid][vTickets][3] && !VehicleInfo[vehicleid][vTickets][4] )
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno vozilo nema kazna na sebi!");

        if (!(1 <= slot <= 5))
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, " Slot mora biti izmedju 1 i 5!");
            return 1;
        }

        new
            tmpSlot = slot - 1;
        if (!VehicleInfo[vehicleid][vTickets][tmpSlot])
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, " U tome slotu nemate kaznu!");

        PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, VehicleInfo[vehicleid][vTickets][tmpSlot]); // Novac dolazi u faction bank

        va_SendClientMessage(playerid, COLOR_RED, "Sluzbenica: Platili ste kaznu #%d vaseg vozila za %d$.",
            slot,
            VehicleInfo[vehicleid][vTickets][tmpSlot]
        );

        new query[55];
        format(query, sizeof(query), "DELETE FROM `cocars_tickets` WHERE `id` = '%d'", VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]);
        mysql_tquery(g_SQL, query, "", "");

        VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]    = 0;
        VehicleInfo[vehicleid][vTickets][tmpSlot]         = 0;
        VehicleInfo[vehicleid][vTicketShown][tmpSlot]     = 0;
        VehicleInfo[vehicleid][vTicketStamp][tmpSlot]     = 0;
    }
    return 1;
}

CMD:giveticket(playerid, params[])
{
    // TODO: reduce level of nesting
    if (!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste autorizovani!");
    if (PlayerInfo[playerid][pLawDuty] == 0) return SendClientMessage(playerid,COLOR_RED, "Niste na du�nosti!");
    if (IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti izvan vozila!");

    new giveplayerid, pick[8];

    if (sscanf(params, "s[8] ", pick)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket [person/vehicle]");

    // TODO: use YSI YHash
    new reason[100], moneys;
    if (!strcmp(pick, "person", true))
    {
        if (sscanf( params, "s[8]uis[99]", pick, giveplayerid, moneys, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket person [playerid/dio imena] [novci] [razlog]");
        if (giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
        if (!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije blizu vas!");
        if (strlen(reason) >= 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Razlog moze imati max 100 znakova!");
        if (49 > moneys > 20001) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalno 20000$, minimalno 50$!");

        InsertPlayerTicket(playerid, giveplayerid, moneys, reason);

        new
            tmpString[120];
        format(tmpString, sizeof(tmpString), "*[HQ] %s %s je izdao kaznu %s, od %d$ za %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid,false), moneys, reason);
        SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

        va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ]  Officer %s vam je dao kaznu u iznosu od %d$, razlog: %s", GetName(playerid,false), moneys, reason);
        SendClientMessage(giveplayerid, COLOR_RED, "(( Koristite /ticket za pregled i placanje kazni ))");
    }
    else if (!strcmp(pick, "vehicle", true))
    {
        new vehicleid;
        if (sscanf( params, "s[8]iis[64]", pick, vehicleid, moneys, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket vehicle [vehicleid ((/DL))][iznos kazne][razlog]");
        if (vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo nije spawnano! (( ID vozila na /DL! ))");
        if (VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Mozete kazniti samo privatna vozila!");

        // TODO: helper function PlayerInRangeOfVehicle(playerid, vehicleid, Float:range)
        new
            Float:vx,
            Float:vy,
            Float:vz;

        GetVehiclePos(vehicleid, vx, vy, vz);

        if (!IsPlayerInRangeOfPoint(playerid, 5.0, vx, vy, vz))
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu vozila!");

        if (1 <= strlen(reason) <= 63)
        {
            if (1 <= moneys <= 10000)
            {
                new
                    tkts = -1;

                for (new t = 0; t <= 4; ++t)
                {
                    if (!VehicleInfo[vehicleid][vTickets][t])
                    {
                        VehicleInfo[vehicleid][vTickets][t]     = moneys;
                        VehicleInfo[vehicleid][vTicketShown][t] = 0;
                        VehicleInfo[vehicleid][vTicketStamp][t] = gettime();

                        // MySQL Query
                        new
                            ticketInsertQuery[256];
                        mysql_format(g_SQL, ticketInsertQuery, 256, "INSERT INTO `cocars_tickets`(`vehicle_id`, `isShown`, `price`, `reason`, `time`) VALUES ('%d','0','%d','%e','%d')",
                            VehicleInfo[vehicleid][vSQLID],
                            VehicleInfo[vehicleid][vTickets][t],
                            reason,
                            gettime()
                        );
                        mysql_tquery(g_SQL, ticketInsertQuery, "OnVehicleTicketInsert", "ii" , vehicleid, t);
                        tkts = t;
                        break;
                    }
                }
                if (tkts != -1)
                {
                    new
                        tmpString[120];

                    format(tmpString, sizeof(tmpString), "*[HQ] %s %s je izdao %d kaznu na vozilo (ID: %d) od %d$ za: %s.", ReturnPlayerRankName(playerid), GetName(playerid), tkts+1, vehicleid, moneys, reason);
                    SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
                }
                else return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo vec ima previse ne placenih kazni!");
            }
            else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Kazna mora biti izmedju 1 i 10.000$!");
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Duzina razloga mora biti izmedju 1 i 63 znaka!");
    }
    return 1;
}
