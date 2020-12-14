// Header file where functions should be declared that can be used/accessed from other modules

// SaveLoad/Core.pwn
forward bool:Player_SecurityBreach(playerid);
forward Player_SetSecurityBreach(playerid, bool:v);

// Updates
forward bool:Player_Reward(playerid);
forward Player_SetReward(playerid, bool:v);

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

// Mask
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
forward Player_PhoneStatus(playerid);
forward Player_SetPhoneStatus(playerid, status);

forward Player_PhoneLine(playerid);
forward Player_SetPhoneLine(playerid, v);

forward bool:Player_MobileOn(playerid);
forward Player_SetMobileOn(playerid, bool:v);
