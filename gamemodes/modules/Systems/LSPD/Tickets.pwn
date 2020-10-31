#if defined MODULE_TICKETS
    #endinput
#endif
#define MODULE_TICKETS

#define MAX_TICKET_REASON_LEN           (100)
#define MAX_TICKET_MONEY_VAL            (10000)

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
    tkReciever[MAX_PLAYER_NAME],
    tkOfficer[MAX_PLAYER_NAME],
    tkMoney,
    tkReason[MAX_TICKET_REASON_LEN],
    tkDate[32]
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

stock SaveVehicleTicketStatus(vehicleid, ticket_slot)
{
    new updateQuery[ 100 ];
    
    format(updateQuery, sizeof(updateQuery), "UPDATE `cocars_tickets` SET `isShown` = '%d' WHERE `id` = '%d'", 
        VehicleInfo[vehicleid][vTicketShown][ticket_slot],
        VehicleInfo[vehicleid][vTicketsSQLID][ticket_slot]
    );
    mysql_tquery(g_SQL, updateQuery, "", "");
    return 1;
}

stock CheckVehicleTickets(playerid, vehicleid)
{
    for(new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if(!VehicleInfo[vehicleid][vTicketShown][i] && VehicleInfo[vehicleid][vTickets][i]) 
        {
            va_SendClientMessage(playerid, COLOR_ORANGE, "* You got a vehicle ticket worth %s. Reason: %s",
                FormatNumber(VehicleInfo[vehicleid][vTickets][i]),
                GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][i])
            );
            VehicleInfo[vehicleid][vTicketShown][i] = true;
            SaveVehicleTicketStatus(vehicleid, i);
        }
    }
    return 1;
}

stock GetVehicleTicketReason(ticketsql)
{
    new
        reason[MAX_TICKET_REASON_LEN],
        Cache:result,
        ticketQuery[128];

    format(ticketQuery, sizeof(ticketQuery), "SELECT `reason` FROM `cocars_tickets` WHERE `id` = '%d'", ticketsql);
    result = mysql_query(g_SQL, ticketQuery);
    if (result == MYSQL_INVALID_CACHE)
        format(reason, sizeof(reason), "None");
    else
        cache_get_value_index(0, 0, reason);
    cache_delete(result);
    return reason;
}

static stock InsertPlayerTicket(playerid, giveplayerid, money, const reason[])
{
    TicketInfo[giveplayerid][tkMoney] = money;
    strcat(TicketInfo[giveplayerid][tkReciever], GetName(giveplayerid, false), MAX_PLAYER_NAME);
    strcat(TicketInfo[giveplayerid][tkOfficer], GetName(playerid, false), MAX_PLAYER_NAME);
    strcat(TicketInfo[giveplayerid][tkReason], reason, MAX_TICKET_REASON_LEN);
    strcat(TicketInfo[giveplayerid][tkDate], ReturnDate(), 32);

    new query[512];
    mysql_tquery(g_SQL, "BEGIN");

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO tickets (`reciever`, `officer`, `money`, `reason`, `date`) VALUES ('%e', '%e', '%d', '%e', '%e')",
        TicketInfo[giveplayerid][tkReciever],
        TicketInfo[giveplayerid][tkOfficer],
        TicketInfo[giveplayerid][tkMoney],
        TicketInfo[giveplayerid][tkReason],
        TicketInfo[giveplayerid][tkDate]
    );
    mysql_tquery(g_SQL, query, "");
    mysql_tquery(g_SQL, "COMMIT");

    SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "You have given a ticket to %s! ", TicketInfo[giveplayerid][tkReciever]);
    return 1;
}

Public:OnVehicleTicketInsert(vehicleid, slot)
{
    VehicleInfo[vehicleid][vTicketsSQLID][slot] = cache_insert_id();
    return 1;
}

stock DeletePlayerTicket(playerid, sqlid, bool:mdc_notification = false)
{
    new
        query[256];
    format(query, sizeof(query), "DELETE FROM tickets WHERE `id` = '%d'", sqlid);
    mysql_tquery(g_SQL, query, "");

    if (mdc_notification)
        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Ticket #%d is sucessfully removed from database.", sqlid);
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
    if (cache_num_rows())
    {
        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i,  "id"       , VehicleInfo[vehicleid][vTicketsSQLID][i]);
            cache_get_value_name_int(i,  "isShown"  , VehicleInfo[vehicleid][vTicketShown][i]);
            cache_get_value_name_int(i,  "price"    , VehicleInfo[vehicleid][vTickets][i]);
            cache_get_value_name_int(i,  "time"     , VehicleInfo[vehicleid][vTicketStamp][i]);
        }
    }
    return 1;
}


stock LoadPlayerTickets(playerid, const playername[])
{
    new
        query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM tickets WHERE `reciever` = '%e'", playername);

    inline OnTicketLoad()
    {
        if (!cache_num_rows())
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Entered citizen has no fines registered!");

        new
            buffer[2048],
            tmp[128],
            motd[256];

        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i, "id", TicketInfo[i][tkID]);
            cache_get_value_name(i,"reciever"   , tmp, sizeof(tmp));
            format(TicketInfo[i][tkReciever], MAX_PLAYER_NAME, tmp );
            cache_get_value_name(i,"officer"    , tmp, sizeof(tmp));
            format(TicketInfo[i][tkOfficer], MAX_PLAYER_NAME, tmp );
            cache_get_value_name_int(i, "money", TicketInfo[i][tkMoney]);
            cache_get_value_name(i, "reason"    , tmp, sizeof(tmp));
            format(TicketInfo[i][tkReason], MAX_TICKET_REASON_LEN, tmp );
            cache_get_value_name(i, "date"  , tmp, sizeof(tmp));
            format(TicketInfo[i][tkDate], 32, tmp );

            format(motd, sizeof(motd), "ID #%d | Date: %s | Reciever: %s | Officer: %s | Fine: %s | Reason: %s\n",
                TicketInfo[i][tkID],
                TicketInfo[i][tkDate],
                TicketInfo[i][tkReciever],
                TicketInfo[i][tkOfficer],
                FormatNumber(TicketInfo[i][tkMoney]),
                TicketInfo[i][tkReason]
            );
            strcat(buffer, motd, sizeof(buffer));
        }

        new string[64];
        format(string, sizeof(string), "[%s - TICKETS]", playername);
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
            format(motd, sizeof(motd), "ID #%d | Fine: %s | Reason: %s\n",
                (i+1),
                FormatNumber(VehicleInfo[vehicleid][vTickets][i]),
                GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][i])
            );
            strcat(buffer, motd, sizeof(buffer));
        }
    }
    format(caption, sizeof(caption), "[%s - TICKETS]", ReturnVehicleName(VehicleInfo[vehicleid][vModel]));
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, caption, buffer, "Close", "");
    return 1;
}

static bool:VehicleHasFines(vehicleid)
{
    new bool:value = false;
    for(new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if(VehicleInfo[vehicleid][vTicketsSQLID][i] != 0)
        {
            value = true;
            break;
        }
    }
    return value;
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
    if (sscanf(params, "s[12] ", param)) 
        return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket [show / vehicleshow / pay / vehiclepay ]");

    if (!strcmp(param, "show", true))
        LoadPlayerTickets(playerid, GetName(playerid, false));
    else if (!strcmp(param, "vehicleshow", true))
    {
        new vehicleid = PlayerInfo[playerid][pSpawnedCar];
        if (vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have a spawned private vehicle!");
        if(!VehicleHasFines(vehicleid))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Your %s doesn't have any fines registered!",  ReturnVehicleName(VehicleInfo[vehicleid][vModel]));

        ShowVehicleTickets(playerid, vehicleid);
    }
    else if (!strcmp(param, "pay", true))
    {
        if (!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not inside City Hall!");
        if (sscanf( params, "s[12]i", param, id)) 
            return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket pay [Ticket ID]");

        new
            ticketsQuery[84],
            tmp[64],
            reciever[MAX_PLAYER_NAME],
            Cache:result;

        format(ticketsQuery, sizeof(ticketsQuery), "SELECT id, reciever, money FROM tickets WHERE id = '%d'", id);
        result = mysql_query(g_SQL, ticketsQuery);
        if (!cache_num_rows()) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket ID #%d doesn't exist!", id);

        new ticketId, moneys;
        cache_get_value_name(0, "reciever", tmp, sizeof(tmp));
        format(reciever, MAX_PLAYER_NAME, tmp );
        cache_get_value_name_int(0, "id"        , ticketId);
        cache_get_value_name_int(0, "money"     , moneys);

        if (!strcmp(reciever, GetName(playerid,false), true) && ticketId == id)
        {
            if (AC_GetPlayerMoney(playerid) < moneys) 
                return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money, you are missing %s.", FormatNumber(moneys-AC_GetPlayerMoney(playerid)));

            PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, moneys); 
            DeletePlayerTicket(playerid, id, false);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "You paid Ticket #%d (%s).", id, FormatNumber(moneys));
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "That ticket isn't yours!"); 
        cache_delete(result);
    }
    else if (!strcmp(param, "vehiclepay", true))
    {
        if (!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not inside of City Hall!");
        new
            slot;

        if (sscanf( params, "s[12]i", param, slot)) 
            return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /payticket vehicle [slot (1-5)]");

        new vehicleid = PlayerInfo[playerid][pSpawnedCar];
        if (vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an private vehicle spawned!");
        if(!VehicleHasFines(vehicleid))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Your %s doesn't have any fines registered!",  ReturnVehicleName(VehicleInfo[vehicleid][vModel]));
        if (!(1 <= slot <= MAX_VEHICLE_TICKETS))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Ticket slot has to be greater than 0 and lesser then %d!", MAX_VEHICLE_TICKETS);

        new tmpSlot = slot - 1;

        if(!VehicleInfo[vehicleid][vTickets][tmpSlot])
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have any tickets in that slot!");
        if(AC_GetPlayerMoney(playerid) <  VehicleInfo[vehicleid][vTickets][tmpSlot]) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money, you are missing %s.", FormatNumber(VehicleInfo[vehicleid][vTickets][tmpSlot]-AC_GetPlayerMoney(playerid)));
        
        PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, VehicleInfo[vehicleid][vTickets][tmpSlot]); // Novac dolazi u faction bank

        va_SendClientMessage(playerid, COLOR_RED, "Clerk: You have paid Ticket #%d on your %s for %s.",
            slot,
            ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
            FormatNumber(VehicleInfo[vehicleid][vTickets][tmpSlot])
        );

        new query[55];
        format(query, sizeof(query), "DELETE FROM `cocars_tickets` WHERE `id` = '%d'", VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]);
        mysql_tquery(g_SQL, query, "", "");

        VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]    = 0;
        VehicleInfo[vehicleid][vTickets][tmpSlot]         = 0;
        VehicleInfo[vehicleid][vTicketShown][tmpSlot]     = false;
        VehicleInfo[vehicleid][vTicketStamp][tmpSlot]     = false;
    }
    return 1;
}

CMD:giveticket(playerid, params[])
{
    if (!IsACop(playerid) && !IsASD(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not law enforcement member!");
    if (PlayerInfo[playerid][pLawDuty] == 0) 
        return SendClientMessage(playerid,COLOR_RED, "You are not on duty!");
    if (IsPlayerInAnyVehicle(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be outside of the vehicle!");

    new giveplayerid, pick[8];

    if (sscanf(params, "s[8] ", pick)) 
        return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket [person/vehicle]");

    new reason[MAX_TICKET_REASON_LEN], moneys;
    if (!strcmp(pick, "person", true))
    {
        if (sscanf( params, "s[8]uis[99]", pick, giveplayerid, moneys, reason)) 
            return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket person [playerid/part of name] [amount] [reason]");
        if (giveplayerid == INVALID_PLAYER_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "The player isn't online!");
        if (!ProxDetectorS(5.0, playerid, giveplayerid)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "The player is not near you!");
        if (strlen(reason) >= MAX_TICKET_REASON_LEN) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Reason can have max %d chars!", MAX_TICKET_REASON_LEN);
        if (49 > moneys > MAX_TICKET_MONEY_VAL) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Minimal fine amount is 50$, maximal %s!", FormatNumber(MAX_TICKET_MONEY_VAL));

        InsertPlayerTicket(playerid, giveplayerid, moneys, reason);

        new
            tmpString[120];
        format(tmpString, sizeof(tmpString), "*[HQ] %s %s issued a %s ticket to %s.", ReturnPlayerRankName(playerid), GetName(playerid), FormatNumber(moneys), GetName(giveplayerid,false));
        SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

        format(tmpString, sizeof(tmpString), "*[HQ] Reason: %s.", reason);
        SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

        va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ]  Officer %s gave you a %s ticket. Reason: %s", GetName(playerid,false), FormatNumber(moneys), reason);
        SendClientMessage(giveplayerid, COLOR_RED, "(( Use /ticket to view and pay your tickets. ))");
    }
    else if (!strcmp(pick, "vehicle", true))
    {
        if (sscanf( params, "s[8]is[64]", pick, moneys, reason)) 
            return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket vehicle [amount][reason]");
        new vehicleid = GetPlayerNearestPrivateVehicle(playerid);
        if (vehicleid == INVALID_VEHICLE_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be near private vehicle in order to issue a ticket!");
        if(strlen(reason) < 1 || strlen(reason) > MAX_TICKET_REASON_LEN)
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket reason can't be shorter than 1 or longer than %d chars!", MAX_TICKET_REASON_LEN);
        if(moneys < 1 || moneys > MAX_TICKET_MONEY_VAL)    
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket price can't be less than 1 or more than %d chars!", MAX_TICKET_MONEY_VAL);
        new
            tkts = -1;

        for (new t = 0; t <= 4; ++t)
        {
            if (!VehicleInfo[vehicleid][vTickets][t])
            {
                VehicleInfo[vehicleid][vTickets][t]     = moneys;
                VehicleInfo[vehicleid][vTicketShown][t] = false;
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
        if(tkts == -1)
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "%s already has %d tickets!", ReturnVehicleName(VehicleInfo[vehicleid][vModel]), MAX_VEHICLE_TICKETS);
        
        new
            tmpString[144];

        format(tmpString, sizeof(tmpString), "*[HQ] %s %s issued %d. ticket on %s[Owner: %s]. Fine: %s.", 
            ReturnPlayerRankName(playerid), 
            GetName(playerid), 
            tkts+1, 
            ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
            VehicleInfo[vehicleid][vOwner],
            FormatNumber(moneys) 
        );
        SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

        format(tmpString, sizeof(tmpString), "*[HQ] Reason: %s.", reason);
        SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
    }
    return 1;
}
