// For this file, include guard generation must be disabled as it might be included more than once
#if defined _inc_funcs
    #undef _inc_funcs
#endif

#include <YSI_Coding\y_hooks>

#include "modules/Systems/LSPD\Tickets/Header.pwn"

#define MAX_TICKET_REASON_LEN           (100)   
#define MAX_TICKET_MONEY_VAL            (10000)

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

stock SaveVehicleTicketStatus(vehicleid, ticket_slot)
{
    new updateQuery[ 100 ];
    
    format(updateQuery, sizeof(updateQuery), "UPDATE `cocars_tickets` SET `isShown` = '%d' WHERE `id` = '%d'", 
        VehicleInfo[vehicleid][vTicketShown][ticket_slot],
        VehicleInfo[vehicleid][vTicketsSQLID][ticket_slot]
    );
    mysql_tquery(g_SQL, updateQuery);
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

stock InsertPlayerTicket(playerid, giveplayerid, money, const reason[])
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
    mysql_tquery(g_SQL, query);
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
    mysql_tquery(g_SQL, query);

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

stock bool:VehicleHasFines(vehicleid)
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