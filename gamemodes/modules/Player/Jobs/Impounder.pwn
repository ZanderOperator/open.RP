// >> Made by Runner!
#include <YSI_Coding\y_hooks>
						
enum e_ipound_info
{
	ivID,
	cc,
	cp
}

new
	ImpounderJob[MAX_PLAYERS][e_ipound_info];
	
static const
	Float:ranVehPos[][4] =
{
	{1498.2927, -1486.9863, 13.0909, -179.8800},
	{1629.4382, -1107.8986, 23.5564, -91.1400},
	{1651.8157, -1017.7477, 23.4891, -168.5399},
	{1070.4238, -900.0560, 42.9292, -3.5400},
	{1172.4240, -880.8181, 42.9278, -80.9400},
	{955.9437, -1187.1716, 16.4559, -90.6600},
	{955.9297, -1202.3613, 16.6890, -91.4400},
	{1084.9836, -1192.4370, 17.7560, -179.5800},
	{2347.2083, -1216.7719, 22.0705, 91.0800},
	{2205.4448, -1156.7567, 25.3013, -90.7800},
	{2007.6245, -1091.0660, 24.2825, 69.0600},
	{2802.7085, -1539.4326, 10.4890, 179.8201},
	{980.4104, -1434.5306, 13.1826, -179.0399},
	{2608.1970, -1127.4703, 65.8854, 22.2600},
	{2451.5225, -1788.9224, 13.2102, 0.0000}
};
	
ResetImpoundVars(playerid)
{
	if(ImpounderJob[playerid][cc] != 0)
		AC_DestroyVehicle(ImpounderJob[playerid][cc]);
		
	DisablePlayerCheckpoint(playerid);
	
	static
		e_Impound[e_ipound_info];
		
	ImpounderJob[playerid] = e_Impound;
	return 1;
}

CMD:jobimpound(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_IMPOUNDER)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas posao impoundera!");
	
	if(ImpounderJob[playerid][ivID] != 0)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vec radis posao!");
		
	if(PlayerJob[playerid][pFreeWorks] < 1)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Odradio si dovoljno za ovaj payday! Pricekaj iduci.");
	
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Trebas biti u Tow Trucku kako bi zapoceo posao!");
		
	new
		vehicleid = FindImpoundableVehicle();

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		va_SendClientMessage(playerid, COLOR_GREEN, 
			"[IMPOUNDER DISPATCH]: Vozilo s neplacenim kaznama marke %s pronadjeno!", 
			ReturnVehicleName(GetVehicleModel(vehicleid))
		);
		va_SendClientMessage(playerid, COLOR_GREEN, 
			"[IMPOUNDER DISPATCH]: Otidji do vozila i impoundaj ga! Vozilo se nalazi na %s!", 
			GetVehicleStreet(vehicleid)
		);
		SendClientMessage(playerid, COLOR_GREEN, "(( Ukoliko vozila nema na checkpointu vlasnik je uzeo isti. Koristite /stopimpound te ponovno pokrenite posao! ))");
		
		new
			Float:tX,
			Float:tY,
			Float:tZ;

		ImpounderJob[playerid][ivID] = vehicleid;
		
		GetVehiclePos(vehicleid, tX, tY, tZ);
		SetPlayerCheckpoint(playerid, tX, tY, tZ, 10.0);
	}
	else
	{
		new
			vmodel;
			
		switch(random(10))
		{
			case 0: vmodel = 401;
			case 1: vmodel = 410;
			case 2: vmodel = 436;
			case 3: vmodel = 500;
			case 4: vmodel = 527;
			case 5: vmodel = 526;
			case 6: vmodel = 529;
			case 7: vmodel = 540;
			case 8: vmodel = 546;
			case 9: vmodel = 547;
			case 10: vmodel = 549;
			default: vmodel = 550;
		}
		
		new
			rpos = random(sizeof(ranVehPos) - 1),
			vehicle = 0;
		
		vehicle = AC_CreateVehicle(vmodel, ranVehPos[rpos][0], ranVehPos[rpos][1], ranVehPos[rpos][2], ranVehPos[rpos][3], random(255), random(255), -1, 0);
		
		SetVehicleParamsEx(vehicle, 0, 0, 0, 1, 0, 0, 0);
		SetVehicleParamsForPlayer(vehicle, playerid, 1, 1);
		
		VehicleInfo[vehicle][vJob] = 99;
		VehicleInfo[vehicle][vUsage] = VEHICLE_USAGE_JOB;
		VehicleInfo[vehicle][vCanStart] = 0;
		VehicleInfo[vehicle][vLocked] = 1;
		
		ImpounderJob[playerid][cc] = vehicle;
		ImpounderJob[playerid][ivID] = vehicle;
		
		SetVehicleNumberPlate(vehicle, "FCK FIVEO");
		Vehicle_Add(VEHICLE_USAGE_JOB, vehicle);
		
		va_SendClientMessage(playerid, COLOR_GREEN, "[IMPOUNDER DISPATCH]: Vozilo s neplacenim kaznama marke %s pronadjeno!", ReturnVehicleName(vmodel));
		va_SendClientMessage(playerid, COLOR_GREEN, "[IMPOUNDER DISPATCH]: Otidji do vozila i impoundaj ga! Vozilo se nalazi na %s!", GetVehicleStreet(vehicle));
		
		SetPlayerCheckpoint(playerid, ranVehPos[rpos][0], ranVehPos[rpos][1], ranVehPos[rpos][2], 10.0);
	}
	return 1;
}

CMD:stopimpound(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_IMPOUNDER)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas posao impoundera!");

	ResetImpoundVars(playerid);
	DisablePlayerCheckpoint(playerid);
	
	SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Prekinuo si impound posao!");
	return 1;
}

OPTowIV(playerid, veh)
{
	if(ImpounderJob[playerid][ivID] == 0)
		return 0;
	
	if(ImpounderJob[playerid][ivID] != veh)
	{	
		SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ovo vozilo nije na tvojoj impound listi!");
		DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		
		DisablePlayerCheckpoint(playerid);
	}
	else
	{
		DisablePlayerCheckpoint(playerid);
		
		SendClientMessage(playerid, COLOR_GREEN, "[IMPOUND DISPATCH]: Towao si vozilo, odvezi ga na impound lot! (( Na ulazu u Los Santos Airport ))");
		SetPlayerCheckpoint(playerid, 1962.2467, -2193.0901, 12.5427, 10.0);
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(ImpounderJob[playerid][ivID] != 0 && IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
	{
		if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) == ImpounderJob[playerid][ivID])
		{
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_GREEN, "[IMPOUND DISPATCH]: Stigao si na Impound Lot! Uparkiraj vozilo lijevo od ulaza te ukucaj /tow kad budes gotov!");
		}
		else
			SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ovo vozilo nije vozilo koje trebas impoundati!");
	}
	return 1;
}

OPUnTowIV(playerid, veh)
{
	if(ImpounderJob[playerid][ivID] == 0)
		return 0;
		
	if(!IsPlayerInRangeOfPoint(playerid, 20.0, 1983.6637, -2186.1553, 12.5415))
		return 0;
		
	if(ImpounderJob[playerid][ivID] != veh)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ovo vozilo nije vozilo koje trebas impoundati!");
		
	if(ImpounderJob[playerid][cc] == ImpounderJob[playerid][ivID])
	{
		AC_DestroyVehicle(ImpounderJob[playerid][cc]);
	}
	else if(ImpounderJob[playerid][cc] == 0 && ImpounderJob[playerid][ivID] == veh)
	{
		new
			Float:X, Float:Y, Float:Z,
			Float:z_rot;
		
		GetVehiclePos(veh, X, Y, Z);
		GetVehicleZAngle(veh, z_rot);
	
		VehicleInfo[ veh ][ vParkX ]		= X;
		VehicleInfo[ veh ][ vParkY ]		= Y;
		VehicleInfo[ veh ][ vParkZ ]		= Z;
		VehicleInfo[ veh ][ vAngle ] 		= z_rot;
		VehicleInfo[ veh ][ vImpounded ] 	= 1;
	
		mysql_fquery(g_SQL,
			"UPDATE cocars SET parkX = '%f', parkY = '%f', parkZ = '%f', angle = '%f', impounded = '%d' WHERE id = '%d'",
			X,
			Y,
			Z,
			z_rot,
			VehicleInfo[veh][vImpounded],
			VehicleInfo[veh][vSQLID]
		);
	
		new
			engine, lights, alarm, doors, bonnect, boot, objective;
		GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnect, boot, objective);
		SetVehicleParamsEx(veh, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, bonnect, boot, objective);
	}
	PlayerJob[playerid][pFreeWorks] -= 5;
	
	new 
		money = minrand(350, 450);
		
	va_SendClientMessage(playerid, COLOR_GREEN, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);
	BudgetToPlayerBankMoney(playerid, money);
	PaydayInfo[playerid][pPayDayMoney] += money;
	
	ResetImpoundVars(playerid);
	
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{	
	ResetImpoundVars(playerid);
	return 1;
}