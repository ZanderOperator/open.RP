#include <YSI_Coding\y_hooks>

// Header file where functions should be declared that can be used/accessed from other modules

// Miscelleneous
forward Player_GetLastVehicle(playerid);
forward Player_SetLastVehicle(playerid, v);

forward bool:Player_HasBlockedOOCChat(playerid);
forward Player_SetHasBlockedOOCChat(playerid, bool:v);

forward bool:Player_OnAirBlocked(playerid);
forward Player_SetOnAirBlocked(playerid, bool:v);

forward bool:Player_HasDice(playerid);
forward Player_SetHasDice(playerid, bool:v);

forward bool:Player_HasFakeGunLicense(playerid);
forward Player_SetHasFakeGunLicense(playerid, bool:v);

forward Player_GetGroceriesQuantity(playerid);
forward Player_SetGroceriesQuantity(playerid, v);

forward bool:Player_HasDrink(playerid);
forward Player_SetHasDrink(playerid, bool:v);

forward bool:Player_HasFood(playerid);
forward Player_SetHasFood(playerid, bool:v);

// TODO: mask module
forward bool:Player_UsingMask(playerid);
forward Player_SetUsingMask(playerid, bool:v);

// Systems/GPS
forward bool:Player_GpsActivated(playerid);
forward Player_SetGpsActivated(playerid, bool:v);

// Jobs
forward bool:Player_IsWorkingJob(playerid);
forward Player_SetIsWorkingJob(playerid, bool:v);

// Rope
forward bool:Player_IsTied(playerid);
forward Player_SetIsTied(playerid, bool:v);

// Mobile Phone
forward Player_PhoneLine(playerid);
forward Player_SetPhoneLine(playerid, v);
