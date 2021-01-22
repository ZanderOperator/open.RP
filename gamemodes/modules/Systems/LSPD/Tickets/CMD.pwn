#include <YSI_Coding\y_hooks>

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
    if(sscanf(params, "s[12] ", param)) 
        return SendClientMessage(playerid, COLOR_RED, "[?]: /ticket [show / vehicleshow / pay / vehiclepay]");

    if(!strcmp(param, "show", true))
        LoadPlayerTickets(playerid, GetName(playerid, false));
        
    else if(!strcmp(param, "vehicleshow", true))
    {
        new vehicleid = PlayerKeys[playerid][pVehicleKey];
        if(vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have a spawned private vehicle!");
        if(!VehicleHasFines(vehicleid))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Your %s doesn't have any fines registered!",  ReturnVehicleName(VehicleInfo[vehicleid][vModel]));

        ShowVehicleTickets(playerid, vehicleid);
    }
    else if(!strcmp(param, "pay", true))
    {
        if(!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not inside City Hall!");
        if(sscanf( params, "s[12]i", param, id)) 
            return SendClientMessage(playerid, COLOR_RED, "[?]: /ticket pay [Ticket ID]");

        new
            tmp[64],
            reciever[MAX_PLAYER_NAME],
            Cache:result;

        result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT id, reciever, money FROM tickets WHERE id = '%d'", id));

        if(!cache_num_rows()) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket ID #%d doesn't exist!", id);

        new ticketId, moneys;
        cache_get_value_name(0, "reciever", tmp, sizeof(tmp));
        format(reciever, MAX_PLAYER_NAME, tmp );
        cache_get_value_name_int(0, "id"        , ticketId);
        cache_get_value_name_int(0, "money"     , moneys);

        if(!strcmp(reciever, GetName(playerid,false), true) && ticketId == id)
        {
            if(AC_GetPlayerMoney(playerid) < moneys) 
                return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money, you are missing %s.", FormatNumber(moneys-AC_GetPlayerMoney(playerid)));

            PlayerToFactionMoney(playerid, FACTION_TYPE_LAW, moneys); 
            DeletePlayerTicket(playerid, id, false);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "You paid Ticket #%d (%s).", id, FormatNumber(moneys));
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "That ticket isn't for you to pay!"); 
        cache_delete(result);
    }
    else if(!strcmp(param, "vehiclepay", true))
    {
        if(!IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not inside of City Hall!");
        new
            slot;

        if(sscanf( params, "s[12]i", param, slot)) 
            return SendClientMessage(playerid, COLOR_RED, "[?]: /payticket vehicle [slot (1-5)]");

        new vehicleid = PlayerKeys[playerid][pVehicleKey];
        if(vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an private vehicle spawned!");
        if(!VehicleHasFines(vehicleid))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Your %s doesn't have any fines registered!",  ReturnVehicleName(VehicleInfo[vehicleid][vModel]));
        if(!(1 <= slot <= MAX_VEHICLE_TICKETS))
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Ticket slot has to be greater than 0 and lesser then %d!", MAX_VEHICLE_TICKETS);

        new tmpSlot = slot - 1;

        if(!VehicleInfo[vehicleid][vTickets][tmpSlot])
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have any tickets in that slot!");
        if(AC_GetPlayerMoney(playerid) <  VehicleInfo[vehicleid][vTickets][tmpSlot]) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money, you are missing %s.", FormatNumber(VehicleInfo[vehicleid][vTickets][tmpSlot]-AC_GetPlayerMoney(playerid)));
        
        PlayerToFactionMoney(playerid, FACTION_TYPE_LAW, VehicleInfo[vehicleid][vTickets][tmpSlot]); 

        va_SendClientMessage(playerid, COLOR_RED, "Clerk: You have paid Ticket #%d on your %s for %s.",
            slot,
            ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
            FormatNumber(VehicleInfo[vehicleid][vTickets][tmpSlot])
        );

        mysql_fquery(g_SQL, "DELETE FROM cocars_tickets WHERE id = '%d'", VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]);

        VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]    = 0;
        VehicleInfo[vehicleid][vTickets][tmpSlot]         = 0;
        VehicleInfo[vehicleid][vTicketShown][tmpSlot]     = false;
        VehicleInfo[vehicleid][vTicketStamp][tmpSlot]     = false;
    }
    return 1;
}

CMD:giveticket(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not law enforcement member!");
    if(!Player_OnLawDuty(playerid)) 
        return SendClientMessage(playerid,COLOR_RED, "You are not on duty!");
    if(IsPlayerInAnyVehicle(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be outside of the vehicle!");

    new giveplayerid, pick[8];

    if(sscanf(params, "s[8] ", pick)) 
        return SendClientMessage(playerid, COLOR_RED, "[?]: /giveticket [person/vehicle]");

    new reason[MAX_TICKET_REASON_LEN], moneys;
    if(!strcmp(pick, "person", true))
    {
        if(sscanf( params, "s[8]uis[99]", pick, giveplayerid, moneys, reason)) 
            return SendClientMessage(playerid, COLOR_RED, "[?]: /giveticket person [playerid/part of name][amount][reason]");
        if(giveplayerid == INVALID_PLAYER_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "The player isn't online!");
        if(!ProxDetectorS(5.0, playerid, giveplayerid)) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "The player is not near you!");
        if(strlen(reason) >= MAX_TICKET_REASON_LEN) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Reason can have max %d chars!", MAX_TICKET_REASON_LEN);
        if(49 > moneys > MAX_TICKET_MONEY_VAL) 
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Minimal fine amount is 50$, maximal %s!", FormatNumber(MAX_TICKET_MONEY_VAL));

        InsertPlayerTicket(playerid, giveplayerid, moneys, reason);

        new
            tmpString[120];
        format(tmpString, sizeof(tmpString), "*[HQ] %s %s issued a %s ticket to %s.", ReturnPlayerRankName(playerid), GetName(playerid), FormatNumber(moneys), GetName(giveplayerid,false));
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

        format(tmpString, sizeof(tmpString), "*[HQ] Reason: %s.", reason);
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

        va_SendClientMessage(giveplayerid, COLOR_RED, "[!]  Officer %s gave you a %s ticket. Reason: %s", GetName(playerid,false), FormatNumber(moneys), reason);
        SendClientMessage(giveplayerid, COLOR_RED, "(( Use /ticket to view and pay your tickets. ))");
    }
    else if(!strcmp(pick, "vehicle", true))
    {
        if(sscanf( params, "s[8]is[64]", pick, moneys, reason)) 
            return SendClientMessage(playerid, COLOR_RED, "[?]: /giveticket vehicle [amount][reason]");
        new vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_PRIVATE);
        if(vehicleid == INVALID_VEHICLE_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be near private vehicle in order to issue a ticket!");
        if(strlen(reason) < 1 || strlen(reason) > MAX_TICKET_REASON_LEN)
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket reason can't be shorter than 1 or longer than %d chars!", MAX_TICKET_REASON_LEN);
        if(moneys < 1 || moneys > MAX_TICKET_MONEY_VAL)    
            return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ticket price can't be less than 1 or more than %d chars!", MAX_TICKET_MONEY_VAL);
        new
            tkts = -1;

        for (new t = 0; t < MAX_VEHICLE_TICKETS; t++)
        {
            if(!VehicleInfo[vehicleid][vTickets][t])
            {
                VehicleInfo[vehicleid][vTickets][t]     = moneys;
                VehicleInfo[vehicleid][vTicketShown][t] = false;
                VehicleInfo[vehicleid][vTicketStamp][t] = gettime();

                mysql_pquery(g_SQL, 
                    va_fquery(g_SQL, 
                        "INSERT INTO cocars_tickets(vehicle_id, isShown, price, reason, time) \n\
                            VALUES ('%d','0','%d','%e','%d')",
                        VehicleInfo[vehicleid][vSQLID],
                        VehicleInfo[vehicleid][vTickets][t],
                        reason,
                        gettime()
                    ), 
                    "OnVehicleTicketInsert", 
                    "ii", 
                    vehicleid, 
                    t
                );
                
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
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

        format(tmpString, sizeof(tmpString), "*[HQ] Reason: %s.", reason);
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);
    }
    return 1;
}