// Header file where functions should be declared that can be used/accessed from other modules

// ANPR
forward bool:Player_HasANPRActivated(playerid);
forward Player_SetANPRActivated(playerid, bool:v);

// LSPD Core
forward bool:Player_PDVehLocked(playerid);
forward Player_SetPDVehLocked(playerid, bool:v);

forward bool:Player_OnPoliceDuty(playerid);
forward Player_SetOnPoliceDuty(playerid, bool:v);

forward bool:Player_ApprovedUndercover(playerid);
forward Player_SetApprovedUndercover(playerid, bool:v);

forward bool:Player_CanRepairGovVehicle(playerid);
forward Player_SetCanRepairGovVehicle(playerid, bool:v);

// SWAT
forward bool:Player_IsSWAT(playerid);
forward Player_SetIsSWAT(playerid, bool:v);

// Cuff
forward bool:Player_IsCuffed(playerid);
forward Player_SetIsCuffed(playerid, bool:v);

// Taser
forward bool:Player_IsTased(playerid);
forward Player_SetIsTased(playerid, bool:v);

forward bool:Player_HasTaserGun(playerid);
forward Player_SetHasTaserGun(playerid, bool:v);

forward bool:Player_BeanbagBulletsActive(playerid);
forward Player_SetBeanbagBulletsActive(playerid, bool:v);

// Wiretap
forward bool:Player_HasListeningDevice(playerid);
forward Player_SetHasListeningDevice(playerid, bool:v);

forward bool:Player_PlacedListeningDevice(playerid);
forward Player_SetPlacedListeningDevice(playerid, bool:v);

forward Player_ListeningDeviceMode(playerid);
forward Player_SetListeningDeviceMode(playerid, v);

forward Player_TappedBy(playerid);
forward Player_SetTappedBy(playerid, v);

forward bool:Player_TappingCall(playerid);
forward Player_SetTappingCall(playerid, bool:v);

forward bool:Player_TappingSMS(playerid);
forward Player_SetTappingSMS(playerid, bool:v);

forward bool:Player_TracingNumber(playerid);
forward Player_SetTracingNumber(playerid, bool:v);

// Tickets
forward bool:IsVehicleImpoundable(vehicleid);
forward InsertPlayerTicket(playerid, giveplayerid, money, const reason[]);
forward CheckVehicleTickets(playerid, vehicleid);
forward GetVehicleTicketReason(ticketsql);
forward DeletePlayerTicket(playerid, sqlid, bool:mdc_notification = false);
forward LoadPlayerTickets(playerid, const playername[]);
forward LoadVehicleTickets(vehicleid);
forward ShowVehicleTickets(playerid, vehicleid);