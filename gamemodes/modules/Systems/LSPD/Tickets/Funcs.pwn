#include <YSI_Coding\y_hooks>

#define MIN_TICKET_TIME		            (259200) // 3 days in seconds
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

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

bool:IsVehicleImpoundable(vehicleid)
{
    new 
        bool: value = true;

    for(new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if(VehicleInfo[vehicleid][vTickets][i] == 0)
        {
            value = false;
            break;
        }
        else if(VehicleInfo[vehicleid][vTicketStamp][i] > (gettimestamp() - MIN_TICKET_TIME) 
            || IsVehicleOccupied(vehicleid))
        {
            value = false;
            break;
        }
    }
    return value;
}

static SaveVehicleTicketStatus(vehicleid, ticket_slot)
{
    mysql_fquery(g_SQL, "UPDATE cocars_tickets SET isShown = '%d' WHERE id = '%d'", 
        VehicleInfo[vehicleid][vTicketShown][ticket_slot],
        VehicleInfo[vehicleid][vTicketsSQLID][ticket_slot]
   );
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
        Cache:result;

    result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT reason FROM cocars_tickets WHERE id = '%d'", ticketsql));
    if(result == MYSQL_INVALID_CACHE)
        format(reason, sizeof(reason), "None");
    else
        cache_get_value_index(0, 0, reason);
    cache_delete(result);
    return reason;
}

stock InsertPlayerTicket(playerid, giveplayerid, money, const reason[])
{
    mysql_tquery(g_SQL, "BEGIN");

    mysql_fquery_ex(g_SQL, 
        "INSERT INTO tickets (reciever, officer, money, reason, date) VALUES ('%e', '%e', '%d', '%e', '%e')",
        GetName(giveplayerid, false),
        GetName(playerid, false),
        money,
        reason,
        ReturnDate()
   );

    mysql_tquery(g_SQL, "COMMIT");

    SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "You have given a ticket to %s! ", GetName(giveplayerid, false));
    return 1;
}

Public:OnVehicleTicketInsert(vehicleid, slot)
{
    VehicleInfo[vehicleid][vTicketsSQLID][slot] = cache_insert_id();
    return 1;
}

stock DeletePlayerTicket(playerid, sqlid, bool:mdc_notification = false)
{
    mysql_fquery(g_SQL, "DELETE FROM tickets WHERE id = '%d'", sqlid);

    if(mdc_notification)
        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Ticket #%d is sucessfully removed from database.", sqlid);
}

stock LoadVehicleTickets(vehicleid)
{
    mysql_tquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM cocars_tickets WHERE vehicle_id = '%d' LIMIT 0,%d",
            VehicleInfo[vehicleid][vSQLID],
            MAX_VEHICLE_TICKETS
       ), 
        "LoadingVehicleTickets", 
        "i", 
        vehicleid
   );
    return 1;
}

Public:LoadingVehicleTickets(vehicleid)
{
    if(cache_num_rows())
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
    inline OnTicketsLoad()
    {
        if(!cache_num_rows())
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Entered citizen has no fines registered!");

        new
            buffer[2048],
            motd[256],
            tickets[E_TICKET_DATA];

        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i, "id", tickets[tkID]);
            cache_get_value_name(i,"reciever"   , tickets[tkReciever], MAX_PLAYER_NAME);
            cache_get_value_name(i,"officer"    , tickets[tkOfficer], MAX_PLAYER_NAME);
            cache_get_value_name_int(i, "money", tickets[tkMoney]);
            cache_get_value_name(i, "reason"    , tickets[tkReason], MAX_TICKET_REASON_LEN);
            cache_get_value_name(i, "date"  , tickets[tkDate], 32);

            format(motd, sizeof(motd), "ID #%d | Date: %s | Reciever: %s | Officer: %s | Fine: %s | Reason: %s\n",
                tickets[tkID],
                tickets[tkDate],
                tickets[tkReciever],
                tickets[tkOfficer],
                FormatNumber(tickets[tkMoney]),
                tickets[tkReason]
           );
            strcat(buffer, motd, sizeof(buffer));
        }

        new string[64];
        format(string, sizeof(string), "[%s - TICKETS]", playername);
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, string, buffer, "Close", "");
    }
    MySQL_TQueryInline(g_SQL,  
		using inline OnTicketsLoad, 
		va_fquery(g_SQL, "SELECT * FROM tickets WHERE reciever = '%e'", playername),
		""
	);
    return 1;
}

stock ShowVehicleTickets(playerid, vehicleid)
{
    new caption[50],
        motd[256],
        buffer[2048];

    for (new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if(VehicleInfo[vehicleid][vTicketsSQLID][i] != 0)
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