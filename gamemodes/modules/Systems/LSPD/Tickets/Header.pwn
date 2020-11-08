// For this file, include guard generation must be disabled as it might be included more than once
#if defined _header_included
    #undef _header_included
#endif

// Header file where functions should be declared that can be used/accessed from other modules

forward SaveVehicleTicketStatus(vehicleid, ticket_slot);
forward CheckVehicleTickets(playerid, vehicleid);
forward GetVehicleTicketReason(ticketsql);
forward DeletePlayerTicket(playerid, sqlid, bool:mdc_notification = false);
forward LoadPlayerTickets(playerid, const playername[]);
forward LoadVehicleTickets(vehicleid);
forward ShowVehicleTickets(playerid, vehicleid);