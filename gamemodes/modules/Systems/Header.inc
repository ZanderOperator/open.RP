// Header file where functions should be declared that can be used/accessed from other modules

// Pickups
forward bool:PickupExists(type, pickupid);

forward Player_InPickup(playerid);
forward Player_SetInPickup(playerid, v);

// Faction - Law Duty
forward bool:Player_OnLawDuty(playerid);
forward Player_SetLawDuty(playerid, bool:v);

// LSPD
#include "modules/Systems/Factions\LSPD/Header.inc"

// Bizz
forward bool: Bizz_Exists(bizzid);

forward Player_InBusiness(playerid);
forward Player_SetInBusiness(playerid, v);

forward Player_InfrontBizz(playerid);
forward Player_SetInfrontBizz(playerid, v);

forward Player_GetBizzCP(playerid);
forward Player_SetBizzCP(playerid, v);

// House
forward bool: House_Exists(houseid);

forward Player_InHouse(playerid);
forward Player_SetInHouse(playerid, v);

forward Player_InfrontHouse(playerid);
forward Player_SetInfrontHouse(playerid, v);

forward Player_GetHouseCP(playerid);
forward Player_SetHouseCP(playerid, v);

forward Player_HouseArea(playerid);
forward Player_SetHouseArea(playerid, v);

forward Player_GetRammingDoor(playerid);
forward Player_SetRammingDoor(playerid, v);

// Complex
forward bool: Complex_Exists(complex_id);

forward Player_GetComplexCP(playerid);
forward Player_SetComplexCP(playerid, v);

forward Player_InfrontComplex(playerid);
forward Player_SetInfrontComplex(playerid, v);

forward Player_InApartmentComplex(playerid);
forward Player_SetInApartmentComplex(playerid, v);

// Apartments in Complex
forward bool: ComplexRoom_Exists(room_id);

forward Player_GetApartmentCP(playerid);
forward Player_SetApartmentCP(playerid, v);

forward Player_InfrontApartment(playerid);
forward Player_SetInfrontApartment(playerid, v);

forward Player_InApartmentRoom(playerid);
forward Player_SetInApartmentRoom(playerid, v);

// Garage
forward bool: Garage_Exists(garageid);

forward Player_GarageArea(playerid);
forward Player_SetGarageArea(playerid, v);

forward Player_InfrontGarage(playerid);
forward Player_SetInfrontGarage(playerid, v);

forward Player_InGarage(playerid);
forward Player_SetInGarage(playerid, v);

// Events
#include "modules/Systems\Events/Header.inc"

// GPS
forward bool:Player_GpsActivated(playerid);
forward Player_SetGpsActivated(playerid, bool:v);

// Miscellaneous
forward bool:Player_IsDJ(playerid);
forward Player_SetIsDJ(playerid, bool:v);

forward Player_GetDJBizzKey(playerid);
forward Player_SetDJBizzKey(playerid, v);
