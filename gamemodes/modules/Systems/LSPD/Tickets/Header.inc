// Header file where functions should be declared that can be used/accessed from other modules

forward bool:IsVehicleImpoundable(vehicleid);
forward InsertPlayerTicket(playerid, giveplayerid, money, const reason[]);
forward CheckVehicleTickets(playerid, vehicleid);
forward GetVehicleTicketReason(ticketsql);
forward DeletePlayerTicket(playerid, sqlid, bool:mdc_notification = false);
forward LoadPlayerTickets(playerid, const playername[]);
forward LoadVehicleTickets(vehicleid);
forward ShowVehicleTickets(playerid, vehicleid);