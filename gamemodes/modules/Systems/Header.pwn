#include <YSI_Coding\y_hooks>

// Header file where functions should be declared that can be used/accessed from other modules

// Faction - Law Duty
forward bool:Player_OnLawDuty(playerid);
forward Player_SetLawDuty(playerid, bool:v);

// LSPD
#include "modules/Systems\LSPD/Header.pwn"

// Bizz
forward Player_InBusiness(playerid);
forward Player_SetInBusiness(playerid, v);

// House
forward Player_InHouse(playerid);
forward Player_SetInHouse(playerid, v);

forward Player_InfrontHouse(playerid);
forward Player_SetInfrontHouse(playerid, v);

forward Player_GetHouseCP(playerid);
forward Player_SetHouseCP(playerid, v);

forward Player_GetRammingDoor(playerid);
forward Player_SetRammingDoor(playerid, v);

// Apartment
forward Player_InApartmentComplex(playerid);
forward Player_SetInApartmentComplex(playerid, v);

forward Player_InApartmentRoom(playerid);
forward Player_SetInApartmentRoom(playerid, v);

// Garage
forward Player_InGarage(playerid);
forward Player_SetInGarage(playerid, v);

// Dynamic Pickup
forward Player_InPickup(playerid);
forward Player_SetInPickup(playerid, v);

// Events
#include "modules/Systems\Events/Header.pwn"


// Miscellaneous
forward bool:Player_IsDJ(playerid);
forward Player_SetIsDJ(playerid, bool:v);

forward Player_GetDJBizzKey(playerid);
forward Player_SetDJBizzKey(playerid, v);
