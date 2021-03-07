#include <YSI_Coding\y_hooks>

new
	pnscolor1,
	pnscolor2;

stock getPriceFromVehicleHealth( vehicleid) {

	new Float:veh_HP, price = 50;
    GetVehicleHealth( vehicleid, veh_HP);

    if(veh_HP > 900 && veh_HP <= 1000) price = 1000;
	else if(veh_HP > 800 && veh_HP <= 900) price = 1000;
	else if(veh_HP > 700 && veh_HP <= 800) price = 1000;
	else if(veh_HP > 600 && veh_HP <= 700) price = 1000;
	else if(veh_HP > 500 && veh_HP <= 600) price = 1000;
    else if(veh_HP > 400 && veh_HP <= 500) price = 1000;
    else if(veh_HP > 300 && veh_HP <= 400) price = 1000;
    else if(veh_HP > 200 && veh_HP <= 300) price = 1000;
    else if(veh_HP > 0 && veh_HP <= 200) price = 1000;
	else price = 1000;
	
	return price;
}

stock Create3DandP( text[], Float:vXU, Float:vYU, Float:vZU, vIntt, vVW, pickupid, Float:radius) {
	CreateDynamic3DTextLabel(text, 0x0059FFAA, vXU, vYU, vZU, radius, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vVW, vIntt, -1, 20.0);
	CreateDynamicPickup(pickupid, 1, vXU, vYU, vZU, vVW, vIntt);
}

hook OnGameModeInit(){
	Create3DandP("{95A2AA}[/enterspray]", 1099.1404, -824.9033, 181.2554, -1, -1, 1239, 5.0);
	Create3DandP("{95A2AA}[/enterspray]", 1024.9756, -1030.7930, 32.0257, -1, -1, 1239, 5.0);
	Create3DandP("{95A2AA}[/enterspray]", 488.3819, -1733.0563, 11.1752, -1, -1, 1239, 5.0);
	Create3DandP("{95A2AA}[/enterspray]", 719.8940, -464.8272, 16.3359, -1, -1, 1239, 5.0);
	Create3DandP("{95A2AA}[/enterspray]", 2073.3811,-1831.4323,13.5469, -1, -1, 1239, 5.0);
    return (true);
}

CMD:enterspray( playerid, params[]) 
{
	if(pns_garages == false) 
		return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Admini su trenutno ugasili mogucnost koristenja ove komande.");
    if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) return SendMessage( playerid, MESSAGE_TYPE_ERROR, "Morate biti na mjestu vozaca.");
    
    new 
		vehicleid = GetPlayerVehicleID(playerid),
		price = getPriceFromVehicleHealth(vehicleid); 
		
	pnscolor1 = VehicleInfo[vehicleid][vColor1];
	pnscolor2 = VehicleInfo[vehicleid][vColor2];
	
	if(PlayerVIP[playerid][pDonateRank] != 0)
		price = 0;
		
	if(AC_GetPlayerMoney(playerid) < price) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca( %s).", FormatNumber(price));
	if(IsPlayerInRangeOfPoint( playerid, 3.0, 1099.1404, -824.9033, 181.2554)) {
	
	    // novac u proracun
		PlayerToBudgetMoney(playerid, price);
	    SetVehiclePos( vehicleid, 2062.1294, -1831.5498, 13.5469);
		SetVehicleZAngle( vehicleid, 90);
		defer SprayDone(playerid, 0, price);
		AC_SetVehicleHealth(vehicleid, 1000.0);
	}
	else if(IsPlayerInRangeOfPoint( playerid, 3.0, 1024.9756, -1030.7930, 32.0257)) {
	
	    PlayerToBudgetMoney(playerid, price);
	    SetVehiclePos( vehicleid, 1024.9763, -1021.8850, 32.1016);
		SetVehicleZAngle( vehicleid, 0);
		defer SprayDone(playerid, 1, price);
		AC_SetVehicleHealth(vehicleid, 1000.0);
	}
	else if(IsPlayerInRangeOfPoint( playerid, 3.0, 488.3819, -1733.0563, 11.1752)) {
	
	    PlayerToBudgetMoney(playerid, price);
	    SetVehiclePos( vehicleid, 487.4099, -1741.4585, 11.1330);
		SetVehicleZAngle( vehicleid, 180);
		defer SprayDone(playerid, 2, price);
		AC_SetVehicleHealth(vehicleid, 1000.0);
	}
	else if(IsPlayerInRangeOfPoint( playerid, 3.0, 719.8940, -464.8272, 16.3359)) {
	
	    PlayerToBudgetMoney(playerid, price);
	    SetVehiclePos( vehicleid, 720.3924, -456.0286, 16.3359);
		SetVehicleZAngle( vehicleid, 0);
		defer SprayDone(playerid, 3, price);
		AC_SetVehicleHealth(vehicleid, 1000.0);
	}
	else if(IsPlayerInRangeOfPoint( playerid, 3.0, 2073.3811,-1831.4323,13.5469)) {

	    PlayerToBudgetMoney(playerid, price);
	    SetVehiclePos( vehicleid, 2065.9812,-1831.3459,13.5469);
		SetVehicleZAngle( vehicleid, 85);
		defer SprayDone(playerid, 4, price);
		AC_SetVehicleHealth(vehicleid, 1000.0);
	}
	else return SendMessage( playerid, MESSAGE_TYPE_ERROR, "Morate biti pored ulaza u payspray garazu.");
	return (true);
}

timer SprayDone[5000]( playerid, sprayid, price) 
{
    new vehicleid = GetPlayerVehicleID( playerid);
    if(GetPlayerState( playerid) == PLAYER_STATE_DRIVER) {
		switch( sprayid) 
		{
		    case 0: {
		        SetVehiclePos( vehicleid, 2076.5461, -1832.5647, 13.5545);
		    }
		    case 1: {
		        SetVehiclePos( vehicleid, 1025.4225, -1033.1587, 31.8380);
		    }
		    case 2: {
		        SetVehiclePos( vehicleid, 488.3767, -1731.1235, 11.2469);
		    }
		    case 3: {
		        SetVehiclePos( vehicleid, 720.2908, -467.6113, 16.3437);
		    }
		    case 4: {
		        SetVehiclePos( vehicleid, 2077.0647,-1831.5833,13.1703);
		        SetVehicleZAngle( vehicleid, 180);
		    }
	    }
		AC_RepairVehicle(vehicleid);
		
		if(VehicleInfo[vehicleid][vNitro] != -1)
		{
			VehicleInfo[vehicleid][vNOSCap] = 100;
			ShowNosCap(playerid);
		}
		if(VehicleInfo[vehicleid][vBodyArmor] == 1)
			AC_SetVehicleHealth(vehicleid, 1600.0);		
		
		va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste popravili vase vozilo za %s.", FormatNumber(price));
		BizzInfo[110][bTill] += floatround(price / 7); 
		ChangeVehicleColor(vehicleid, pnscolor1, pnscolor2);
		
		/*if(aprilfools[playerid])
			UpdateVehicleDamageStatus(vehicleid, 16909060, 16909060, 5, 0);*/
	}
	return (true);
}
