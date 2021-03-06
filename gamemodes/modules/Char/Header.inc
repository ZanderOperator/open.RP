// Header file where functions should be declared that can be used/accessed from other modules

// Burglar
forward bool:Player_BreakingSafe(playerid);

// Speedo
forward Float:GetPlayerVehicleSpeed(playerid, pvid = 0);

forward bool:Player_UsingSpeedometer(playerid);
forward Player_SetSpeedometer(playerid, bool:v);

// Rentveh
//forward Player_RentVehicle(playerid);
//forward Player_SetRentVehicle(playerid, vehicleid);