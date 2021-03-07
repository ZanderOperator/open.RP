#include <YSI_Coding\y_hooks>

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

static
	bool: MechanicDuty[MAX_PLAYERS] = false,
	bool: Repairing[MAX_PLAYERS] = false,
	vgate[4],
	vgatestatus[4],
	vrampa[5],
	vrampastatus[3],
	Timer:MechanicTimer[MAX_PLAYERS],
	PlayerRepairVehicle[MAX_PLAYERS],
	PlayerMechanicVehicle[MAX_PLAYERS],
	PlayerText:MechanicTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

bool:Player_MechanicDuty(playerid)
{
	return MechanicDuty[playerid];
}

stock ResetMechanicVariables(playerid)
{
	Repairing[playerid] = (false);
	MechanicDuty[playerid] = (false);
	DestroyMechanicTextDraw(playerid);
	Bit8_Set( gr_MechanicSecs, 		playerid, 0);
	Bit16_Set( gr_IdMehanicara, playerid, INVALID_PLAYER_ID);
	Bit4_Set( gr_TipUsluge, 	playerid, 0);
	return 1;
}

stock DestroyMechanicTextDraw(playerid)
{
	if(MechanicTD[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy( playerid, MechanicTD[playerid]);
		MechanicTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 0;
}

stock CreateMechanicTextDraw(playerid)
{
	DestroyMechanicTextDraw(playerid);
	MechanicTD[playerid] = CreatePlayerTextDraw(playerid, 100.0, 310.0, "              ");
    PlayerTextDrawFont(playerid, 		MechanicTD[playerid], 2);
    PlayerTextDrawLetterSize(playerid, 	MechanicTD[playerid], 0.249, 1.000000);
    PlayerTextDrawSetShadow(playerid, 	MechanicTD[playerid], 1);
	PlayerTextDrawShow(playerid, 		MechanicTD[playerid]);
	return 1;
}

StartMechanicService(playerid)
{
	new
		repairman 		= Bit16_Get( gr_IdMehanicara, playerid),
		givevehicleid 	= GetPlayerVehicleID(repairman),
		price 			= ServicePrice[playerid];
	
	if(repairman == 999) 							
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nitko vam nije ponudio mehanicarsku uslugu!");
	if(Bit1_Get( gr_UsingMechanic, playerid)) 	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec koristite mehanicarsku uslugu!");
	if(Bit1_Get( gr_UsingMechanic, repairman)) 	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mehanicar je vec u poslu!");
	if(!IsPlayerInAnyVehicle(playerid)) 			
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
	if(!IsPlayerConnected(repairman)) 				
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru!");
	if(!ProxDetectorS(5.0, playerid, repairman)) 	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mehanicara!");
	if(!Bit4_Get( gr_TipUsluge, playerid)) 		
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nitko vam nije ponudio uslugu!");
	if(AC_GetPlayerMoney(playerid) < price)		
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");
	
	PlayerToPlayerMoneyTAX(playerid, repairman, price, false);
	PaydayInfo[repairman][pPayDayMoney] += price; 
	
	switch(Bit4_Get( gr_TipUsluge, playerid)) 
	{
		case 1: 
		{
			if(PlayerInventory[repairman][pParts] < 3) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");

			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);
			
			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			
			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");
			
			Bit8_Set( gr_MechanicSecs, playerid, 15);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 1);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 		playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 2: 
		{
			if(PlayerInventory[repairman][pParts] < 3)
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");

			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);
			
			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			
			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");
			
			Bit8_Set( gr_MechanicSecs, playerid, 15);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 2);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 	playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 3: 
		{
			if(PlayerInventory[repairman][pParts] < 3) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");

			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);
			
			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			
			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");
			
			Bit8_Set( gr_MechanicSecs, playerid, 15);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 3);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 	playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 4: 
		{
			if(PlayerInventory[repairman][pParts] < 3) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");

			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);
			
			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~15");
			
			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");
			
			Bit8_Set( gr_MechanicSecs, playerid, 15);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 4);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 	playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 6: 
		{
			if(PlayerInventory[repairman][pParts] < 2000) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");
			
			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);

			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~300");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~300");

			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");

			Bit8_Set( gr_MechanicSecs, playerid, 300);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 6);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 		playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 7: 
		{
			if(PlayerInventory[repairman][pParts] < 3500) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");
			
			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);

			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~500");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~500");

			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");

			Bit8_Set( gr_MechanicSecs, playerid, 500);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 7);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 		playerid, 	999);
			Repairing[repairman] = (true);
		}
		case 8: 
		{
			if(PlayerInventory[repairman][pParts] < 5) 
				return SendErrorMessage(playerid, "Mehanicar nema dovoljno mehanicarskih djelova.");

			CreateMechanicTextDraw(playerid);
			CreateMechanicTextDraw(repairman);

			PlayerTextDrawSetString(playerid, 	MechanicTD[playerid], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~300");
			PlayerTextDrawSetString(repairman, 	MechanicTD[repairman], 	"~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~300");

			SendClientMessage(repairman, COLOR_ORANGE, "(( Izadjite iz vozila i krenite rp-ati popravljanje, nemojte se previse udaljavati od vozila))");

			Bit8_Set( gr_MechanicSecs, playerid, 300);
			MechanicTimer[playerid] = repeat MechCountForPlayer(playerid, repairman, 8);
			PlayerRepairVehicle[playerid] = givevehicleid;
			PlayerMechanicVehicle[playerid] = GetPlayerVehicleID(playerid);
			Bit1_Set( gr_UsingMechanic, 	repairman, 	true);
			Bit1_Set( gr_UsingMechanic, 	playerid, 	true);
			Bit4_Set( gr_TipUsluge, 		playerid, 	0);
			Bit16_Set( gr_IdMehanicara, 		playerid, 	999);
			Repairing[repairman] = (true);
		}
	}
	return 1;
}

/*
	##     ##  #######   #######  ##    ##  ######
	##     ## ##     ## ##     ## ##   ##  ##    ##
	##     ## ##     ## ##     ## ##  ##   ##
	######### ##     ## ##     ## #####     ######
	##     ## ##     ## ##     ## ##  ##         ##
	##     ## ##     ## ##     ## ##   ##  ##    ##
	##     ##  #######   #######  ##    ##  ######
*/

timer MechCountForPlayer[1000](playerid, giveplayerid, service)
{
	new Float:X, Float:Y, Float:Z;
	GetVehiclePos( PlayerMechanicVehicle[giveplayerid] , X, Y, Z);

	if(!IsPlayerInVehicle(playerid, PlayerMechanicVehicle[playerid])) {
		DestroyMechanicTextDraw(playerid);
		DestroyMechanicTextDraw(giveplayerid);
		stop MechanicTimer[playerid];

		Bit1_Set( gr_UsingMechanic, playerid, 		false);
		Bit1_Set( gr_UsingMechanic, giveplayerid, 	false);
		Repairing[giveplayerid] = (false);

		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Izasli ste iz vozila i time prekinuli mehanicarsku uslugu/niste u radioni!");
		return 1;
	}
	if(Bit8_Get( gr_MechanicSecs, playerid) > 0) {
		new
			tmpSecs[74];
		format(tmpSecs, sizeof(tmpSecs), "~w~Mehanicarska usluga u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d",
			Bit8_Get( gr_MechanicSecs, playerid)-1
		);
		PlayerTextDrawSetString( playerid, 		MechanicTD[playerid], 	tmpSecs);
		PlayerTextDrawSetString( giveplayerid, 	MechanicTD[giveplayerid], tmpSecs);
		PlayerPlaySound( playerid, 		1056, 0.0, 0.0, 0.0);
		PlayerPlaySound( giveplayerid, 	1056, 0.0, 0.0, 0.0);
		Bit8_Set( gr_MechanicSecs, playerid, Bit8_Get( gr_MechanicSecs, playerid)-1);
	}
	else
	{
		DestroyMechanicTextDraw(playerid);
		DestroyMechanicTextDraw(giveplayerid);
		stop MechanicTimer[playerid];

		Bit1_Set( gr_UsingMechanic, playerid, false);
		Bit1_Set( gr_UsingMechanic, giveplayerid, false);
		Repairing[giveplayerid] = (false);

		new
			vehicleid = GetPlayerVehicleID(playerid),
			engine, lights, alarm, doors, bonnet, boot, objective;

		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		switch(service) 
		{
			case 1: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 3) 
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				VehicleInfo[vehicleid][vCanStart] = 1;
				if(VehicleInfo[GetPlayerVehicleID(playerid)][vBodyArmor] == 1) AC_SetVehicleHealth(vehicleid, 1600.0);
				else AC_SetVehicleHealth(vehicleid, 1000.0);
				SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
				VehicleInfo[vehicleid][vEngineRunning] = 0;

				VehicleInfo[vehicleid][vOverHeated] = 0;

				VehicleInfo[vehicleid][vCanStart] = 1;
				VehicleInfo[vehicleid][vDestroyed] = false;

				new
					engineString[79];
				format(engineString, sizeof(engineString), "[!] Vas motor je popravljen od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);
				SendClientMessage(playerid, COLOR_RED, engineString);
				GameTextForPlayer( giveplayerid, "~g~Popravljen motor!", 1000, 1);
				
				if(VehicleInfo[vehicleid][vNitro] != -1)
				{
					VehicleInfo[vehicleid][vNOSCap] = 100;
					ShowNosCap(playerid);
				}

				PlayerInventory[giveplayerid][pParts] -= 3;
			}
			case 2: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 3)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), 0, 0, 0, 0);

				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

				new
					bodyString[81];

				format(bodyString, sizeof(bodyString), "[!] Vas bodykit je popravljen od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);
				SendClientMessage(playerid, COLOR_RED, bodyString);
				GameTextForPlayer( giveplayerid, "~g~Popravljen bodykit!", 1000, 1);

				PlayerInventory[giveplayerid][pParts] -= 3;
			}
			case 3: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 5)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				new
					destroyString[92];
				format(destroyString, sizeof(destroyString), "[!] Skinuta vam je jedna steta na vozilu od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);
				Bit1_Set( gr_HaveOffer, playerid, false);
				SendClientMessage(playerid, COLOR_RED, destroyString);
				GameTextForPlayer( giveplayerid, "~g~Maknuo si jedno unistenje!", 1000, 1);
				if(--VehicleInfo[GetPlayerVehicleID(playerid)][vDestroys] < 2)
					VehicleInfo[GetPlayerVehicleID(playerid)][vDestroys] = 0;

				PlayerInventory[giveplayerid][pParts] -= 5;

				mysql_fquery(g_SQL, "UPDATE cocars SET destroys = '%d' WHERE id = '%d'",
					VehicleInfo[GetPlayerVehicleID(playerid)][vDestroys],
					VehicleInfo[GetPlayerVehicleID(playerid)][vSQLID]
				);
			}
			case 4:
			{
			    if(PlayerInventory[giveplayerid][pParts] < 2)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				VehicleInfo[GetPlayerVehicleID(playerid)][vStereo] = 1086;

				new
					stereoString[87];
				format(stereoString, sizeof(stereoString), "[!] Ugradjen vam je stereo u vozilo od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);
				SendClientMessage(playerid, COLOR_RED, stereoString);
				GameTextForPlayer( giveplayerid, "~g~Ugradili ste stereo!", 1000, 1);

				PlayerInventory[giveplayerid][pParts] -= 2;

				mysql_fquery(g_SQL, "UPDATE cocars SET stereo = '%d' WHERE id = '%d'",
					VehicleInfo[GetPlayerVehicleID(playerid)][vStereo],
					VehicleInfo[GetPlayerVehicleID(playerid)][vSQLID]
				);
			}
			case 6: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 4000)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				VehicleInfo[GetPlayerVehicleID(playerid)][vTireArmor] = 1;
				vTireHP[GetPlayerVehicleID(playerid)][0] = 100;
				vTireHP[GetPlayerVehicleID(playerid)][1] = 100;
				vTireHP[GetPlayerVehicleID(playerid)][2] = 100;
				vTireHP[GetPlayerVehicleID(playerid)][3] = 100;

				AddVehicleComponent(vehicleid, 1025);

				new
					tireString[87];
				format(tireString, sizeof(tireString), "[!] Blindirane su vam gume na vozilu od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);

				SendClientMessage(playerid, COLOR_RED, tireString);
				GameTextForPlayer( giveplayerid, "~g~Blindirali ste gume vozila!", 1000, 1);


				PlayerInventory[giveplayerid][pParts] -= 4000;

				mysql_fquery(g_SQL, "UPDATE cocars SET tirearmor = '%d' WHERE id = '%d'",
					VehicleInfo[GetPlayerVehicleID(playerid)][vTireArmor],
					VehicleInfo[GetPlayerVehicleID(playerid)][vSQLID]
				);
			}
			case 7: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 7000)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				VehicleInfo[GetPlayerVehicleID(playerid)][vBodyArmor] = 1;

				AC_SetVehicleHealth(vehicleid, 1600.0);

				new
					bodyaString[87];
				format(bodyaString, sizeof(bodyaString), "[!] Blindirana vam je karoserija na vozilu od strane mehanicara %s.",
					GetName( giveplayerid, true)
				);
				SendClientMessage(playerid, COLOR_RED, bodyaString);
				GameTextForPlayer( giveplayerid, "~g~Blindirali ste karoseriju vozila!", 1000, 1);

				PlayerInventory[giveplayerid][pParts] -= 7000;

				mysql_fquery(g_SQL, "UPDATE cocars SET bodyarmor = '%d' WHERE id = '%d'",
					VehicleInfo[GetPlayerVehicleID(playerid)][vBodyArmor],
					VehicleInfo[GetPlayerVehicleID(playerid)][vSQLID]
				);
			}
			case 8: 
			{
			    if(PlayerInventory[giveplayerid][pParts] < 5)
				{
					SendErrorMessage(playerid, "Mehanicar nema dovoljno djelova!");
					SendErrorMessage(giveplayerid, "Nemate dovoljno djelova!");
					return 1;
				}
				VehicleInfo[GetPlayerVehicleID(playerid)][vGPS] = true;
				new
					bodyaString[100];
				format(bodyaString, sizeof(bodyaString), "[!] Mehanicar %s je uspjesno popravio GPS lokator na vasem vozilu.",
					GetName( giveplayerid, true)
				);
				SendClientMessage(playerid, COLOR_RED, bodyaString);
				GameTextForPlayer( giveplayerid, "~g~GPS online!", 1000, 1);

				PlayerInventory[giveplayerid][pParts] -= 5;
			}
		}
		return 1;
	}
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetMechanicVariables(playerid);
	MechanicDuty[playerid] = (false);
	return continue(playerid);
}

hook OnGameModeInit() 
{
	// Vrata Garaze HQ
	vgate[0] = CreateDynamicObject(19906, 2313.87354, -1342.76282, 26.31350,   0.00000, 0.00000, 90.00000);
	vgate[1] = CreateDynamicObject(19906, 2313.97339, -1351.76880, 26.31350,   0.00000, 0.00000, 90.00000);
	vgate[2] = CreateDynamicObject(19906, 2314.09351, -1360.75024, 26.31350,   0.00000, 0.00000, 90.00000);
	vgate[3] = CreateDynamicObject(19906, 2314.15674, -1369.75586, 26.31350,   0.00000, 0.00000, 90.00000);
	
	// Rampe garaza HQ
	vrampa[0] = CreateDynamicObject(19872, 2321.979736, -1342.699462, 21.290500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(vrampa[0], 0, 9514, "711_sfw", "shingles2", 0x00000000);
	
	vrampa[1] = CreateDynamicObject(19872, 2321.979736, -1351.880493, 21.290500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(vrampa[1], 0, 9514, "711_sfw", "shingles2", 0x00000000);
	
	vrampa[2] = CreateDynamicObject(19817, 2320.264648, -1360.612182, 22.046480, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(vrampa[2], 0, 9514, "711_sfw", "shingles2", 0x00000000);
	
	vrampa[3] = CreateDynamicObject(2893, 2319.196533, -1368.971313, 23.190799, -16.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(vrampa[3], 0, 9514, "711_sfw", "shingles2", 0x00000000);
	vrampa[4] = CreateDynamicObject(2893, 2319.330322, -1371.272949, 23.190799, -16.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(vrampa[4], 0, 9514, "711_sfw", "shingles2", 0x00000000);
	return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(PRESSED(KEY_YES)) {
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2313.87354, -1342.76282, 26.31350)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			
			if(vgatestatus[0] == 0) {
				SetDynamicObjectRot(vgate[0], 91.0000, 0.0000, 90.0000);
				vgatestatus[0] = 1;
			}
			else if(vgatestatus[0] == 1) {
				SetDynamicObjectRot(vgate[0], 0.0000, 0.0000, 90.0000);
				vgatestatus[0] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2313.97339, -1351.76880, 26.31350)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			
			if(vgatestatus[1] == 0) {
				SetDynamicObjectRot(vgate[1], 91.0000, 0.0000, 90.0000);
				vgatestatus[1] = 1;
			}
			else if(vgatestatus[1] == 1) {
				SetDynamicObjectRot(vgate[1], 0.0000, 0.0000, 90.0000);
				vgatestatus[1] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2314.09351, -1360.75024, 26.31350)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			
			if(vgatestatus[2] == 0) {
				SetDynamicObjectRot(vgate[2], 91.0000, 0.0000, 90.0000);
				vgatestatus[2] = 1;
			}
			else if(vgatestatus[2] == 1) {
				SetDynamicObjectRot(vgate[2], 0.0000, 0.0000, 90.0000);
				vgatestatus[2] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2314.15674, -1369.75586, 26.31350)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			
			if(vgatestatus[3] == 0) {
				SetDynamicObjectRot(vgate[3], 91.0000, 0.0000, 90.0000);
				vgatestatus[3] = 1;
			}
			else if(vgatestatus[3] == 1) {
				SetDynamicObjectRot(vgate[3], 0.0000, 0.0000, 90.0000);
				vgatestatus[3] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2321.979736, -1342.699462, 21.290500)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			if(vrampastatus[0] == 0) {
				MoveDynamicObject(vrampa[0], 2321.9797, -1342.6995, 22.9415,1.4, 0.0000, 0.0000, 90.0000);
				vrampastatus[0] = 1;
			}
			else if(vrampastatus[0] == 1) {
				MoveDynamicObject(vrampa[0], 2321.979736, -1342.699462, 21.290500,1.4, 0.000000, 0.000000, 90.000000);
				vrampastatus[0] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.5, 2321.979736, -1351.880493, 21.290500)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			if(vrampastatus[1] == 0) {
				MoveDynamicObject(vrampa[1], 2321.9797, -1351.8805, 23.0373,1.4, 0.0000, 0.0000, 90.0000);
				vrampastatus[1] = 1;
			}
			else if(vrampastatus[1] == 1) {
				MoveDynamicObject(vrampa[1], 2321.979736, -1351.880493, 21.290500,1.4, 0.000000, 0.000000, 90.000000);
				vrampastatus[1] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 2322.4639, -1367.4045, 23.0931)) {
			if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return (true);
			if(vrampastatus[2] == 0) {
				MoveDynamicObject(vrampa[3], 2319.1965, -1368.9713, 25.0708, 1.4, -16.0000, 0.0000, 90.0000);
				MoveDynamicObject(vrampa[4], 2319.3303, -1371.2729, 25.0708, 1.4, -16.0000, 0.0000, 90.0000);
				vrampastatus[2] = 1;
			}
			else if(vrampastatus[2] == 1) {
				MoveDynamicObject(vrampa[3], 2319.196533, -1368.971313, 23.190799, 1.4, -16.000000, 0.000000, 90.000000);
				MoveDynamicObject(vrampa[4], 2319.330322, -1371.272949, 23.190799, 1.4,-16.000000, 0.000000, 90.000000);
				vrampastatus[2] = 0;
			}
		}
	}
	return (true);
}

/*
	 ######  ##     ## ########
	##    ## ###   ### ##     ##
	##       #### #### ##     ##
	##       ## ### ## ##     ##
	##       ##     ## ##     ##
	##    ## ##     ## ##     ##
	 ######  ##     ## ########
*/

CMD:armorcar(playerid, params[]) {
	if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Mehanicar!");
	if(MechanicDuty[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi na duznosti kao mehanicar!");
	new
		item[12], playa, price;

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 2321.9822, -1355.6526, 23.3999)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u mehanicarskoj garazi.");
    if(sscanf(params, "s[12] ", item)) {
	 	SendClientMessage(playerid, COLOR_RED, "[?]: /armorcar [opcija]");
	 	SendClientMessage(playerid, COLOR_GREY, "OPCIJE: tires, body");
	 	return 1;
	}
	if(strcmp(item,"tires",true) == 0) {
		if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /armorcar tires [ID igraca][Cijena nadogradnje]");
	    if(PlayerInventory[playerid][pParts] < 4000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za blindiranje guma potrebno je najmanje 4000 mehanicarskih dijelova kod sebe ili tow trucku!");
		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
   		if(price > 70000 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-70.000$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");

		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi blindiranje vozila!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s blindiranje guma za %d$.",
			GetName( playa, true),
			price
		);
		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam blindirati gume na vozilu za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);
		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge, 	playa, 6);
	}
	else if(strcmp(item,"body",true) == 0) {
		if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /armorcar body [ID igraca][Cijena nadogradnje]");
	    if(PlayerInventory[playerid][pParts] < 7000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za blindiranje karoserije potrebno je najmanje 7000 mehanicarskih dijelova kod sebe ili tow trucku!");
		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
   		if(price > 100000 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-100.000$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");

		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi blindiranje vozila!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s blindiranje karoserije za %d$.",
			GetName( playa, true),
			price
		);
		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam blindirati karoseriju na vozilu za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);

		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge, 	playa, 7);
	}
	return 1;
}

CMD:repair(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Mehanicar!");
	if(MechanicDuty[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi na duznosti kao mehanicar!");
	if(Repairing[playerid] == (true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec popravljate vozilo, sacekajte da prvo popravite vozilo.");
	new
		item[12], playa, givevehicleid, model, price;

	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 2321.9822, -1355.6526, 23.3999) || GetVehicleModel(GetPlayerVehicleID(playerid)) == 525) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u mehanicarskoj garazi ili u towtrucku.");
    if(sscanf(params, "s[12] ", item)) {
	 	SendClientMessage(playerid, COLOR_RED, "[?]: /repair [opcija]");
	 	SendClientMessage(playerid, COLOR_GREY, "OPCIJE: engine, bodykit, destroys, gps");
	 	return 1;
	}
	if(strcmp(item,"engine",true) == 0) {
	    if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /repair engine [ID igraca][Cijena popravka]");
	    if(PlayerInventory[playerid][pParts] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za popravak motora potrebno je najmanje 3 mehanicarska dijela kod sebe!");
		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
   		if(price > 250 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-250$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");

   		givevehicleid = GetPlayerVehicleID(playa);
 		model = GetVehicleModel(givevehicleid);

		if(!VehicleInfo[givevehicleid][vBonnets] && !IsABike(model) && !IsAPlane(model) && !IsABoat(model)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Otvorite haubu prvo!!");
 		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi popravak motora vozila!");
 		if(VehicleInfo[givevehicleid][vEngineRunning])
 		    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Motor vozila mora biti izgaSen kako bi ga mogli popraviti!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s popravak enginea vozila za %d$.",
			GetName( playa, true),
			price
		);
		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam popravit engine od vozila za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);

		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge, 	playa, 1);
	}
    else if(strcmp(item,"bodykit",true) == 0)
	{
        if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /repair bodykit [ID igraca][Cijena bodikita]");
	    if(PlayerInventory[playerid][pParts] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za popravak motora potrebno je najmanje 3 mehanicarska dijela kod sebe!");
   		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
   		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
		if(price > 250 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-250$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");

		givevehicleid = GetPlayerVehicleID(playa);
 		model = GetVehicleModel(givevehicleid);
		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi popravak bodykita na vozilu!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s popravak bodykita na vozilu za %d$.",
			GetName( playa, true),
			price
		);

		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam popravit bodykit na vozilu za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);

		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge,		playa, 2);
    }
    else if(strcmp(item,"destroys",true) == 0)
	{
        if(PlayerJob[playerid][pContractTime] < 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno iskustva!");
        if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /repair destroys [ID igraca][Cijena skidanja]");
	    if(PlayerInventory[playerid][pParts] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za popravak motora potrebno je najmanje 3 mehanicarska dijela kod sebe!");
   		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
		if(Bit1_Get( gr_HaveOffer, playa, false)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igracu je vec ponudjena mehanicarska usluga.");
		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
		if(price > 250 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-250$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");
   		if(VehicleInfo[GetPlayerVehicleID(playa)][vDestroys] <= 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo ima 2 ili manje unistenja i ne mozete ih vise brisati!");

		givevehicleid = GetPlayerVehicleID(playa);
 		model = GetVehicleModel(givevehicleid);

		if(VehicleInfo[givevehicleid][vBonnets] == 0 && !IsABike(model) && !IsAPlane(model) && !IsABoat(model)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Otvorite haubu prvo!!");
 		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi ovu uslugu!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s brisanje unistenja na vozilu za %d$.",
			GetName( playa, true),
			price
		);
		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam pobrisati unistenja na vozilu za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);
		Bit1_Set( gr_HaveOffer, 	playa, true);
		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge, 	playa, 3);
    }
	 else if(strcmp(item,"gps",true) == 0)
	{
        if(sscanf(params, "s[12]ui", item, playa, price)) return SendClientMessage(playerid, COLOR_RED, "[?]: /repair gps [ID igraca][Cijena popravka]");
	    if(PlayerInventory[playerid][pParts] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Za popravak motora potrebno je najmanje 3 mehanicarska dijela kod sebe!");
   		if(playa == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije na serveru!");
		if(Bit1_Get( gr_HaveOffer, playa, false)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igracu je vec ponudjena mehanicarska usluga.");
		if(PlayerInfo[playa][pLevel] < 2) return SendClientMessage( playerid, COLOR_RED, "Igrac mora biti veci od level 1!");
		if(price > 250 || price < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos cijene! (10$-250$)");
   		if(!ProxDetectorS(5.0, playerid, playa) || !IsPlayerInAnyVehicle(playa)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas / nije u autu.");
   		if(VehicleInfo[GetPlayerVehicleID(playa)][vGPS]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo ima ispravan GPS lokator!");

		givevehicleid = GetPlayerVehicleID(playa);
 		model = GetVehicleModel(givevehicleid);

		if(VehicleInfo[givevehicleid][vBonnets] == 0 && !IsABike(model) && !IsAPlane(model) && !IsABoat(model)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo otvorite haubu!");
 		if(playa == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi ponuditi ovu uslugu!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Ponudili ste %s popravak GPS-a na vozilu za %d$.",
			GetName( playa, true),
			price
		);
		va_SendClientMessage(playa, COLOR_RED, "[!] Automehanicar %s zeli vam popraviti GPS na vozilu za %d$, (ukucajte /accept mechanic) da bi ste prihvatili.",
			GetName( playerid, true),
			price
		);
		Bit1_Set( gr_HaveOffer, 	playa, true);
		ServicePrice[playa] = price;
		Bit16_Set( gr_IdMehanicara, playa, playerid);
		Bit4_Set( gr_TipUsluge, 	playa, 8);
    }
	return 1;
}
CMD:parts(playerid, params[])
{
	new
		item[16], ammount, price, vehicleid;
    if(sscanf(params, "s[16] ", item))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /parts [opcija]");
		SendClientMessage(playerid, -1, "OPCIJE: buy, put, take, check, give");
        return 1;
    }
    if(strcmp(item,"buy",true) == 0)
	{
        if(sscanf(params, "s[16]i", item, ammount)) return SendClientMessage(playerid, COLOR_RED, "[?]: /parts buy [kolicina]");
		if(ammount < 1 || ammount > 500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes uzeti manje od 1 i vise od 500 paketa odjednom!");
		if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi mehanicar!");
		//if(MechanicDuty[playerid] == false) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi na duznosti kao mehanicar!");
		if(!IsPlayerInRangeOfPoint(playerid,5.0, 2075.6326,-2033.3313,13.5469)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mjesta za kupovinu dijelova!");

		price = ammount * 8;
		if(AC_GetPlayerMoney(playerid) < price) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes si priustiti toliko djelova !");

		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Kupio si %d mehanicarskih djelova za $%d.",
			ammount,
			price
		);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Koristi /parts check da vidis koliko imas djelova kod sebe");
		
		PlayerToBudgetMoney(playerid, price); // novac ide u proracun
		PlayerInventory[playerid][pParts] += ammount;
	}
	else if(strcmp(item,"give",true) == 0)
	{
	    if(Bit1_Get( gr_UsingMechanic, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mo�eS davati dijelove dok popravljaS vozilo!");
		if(Repairing[playerid] == (true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno popravljate vozilo, sacekajte da prvo popravite vozilo.");

	    new
			giveplayerid;
	    if(sscanf(params, "s[16]ui", item, giveplayerid, ammount)) return SendClientMessage(playerid, COLOR_RED, "[?]: /parts give [ID/Ime][kolicina]");
        if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi dovoljno blizu tog igraca!");
	    if(ammount < 1 || ammount > PlayerInventory[playerid][pParts]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko mehanicarskih dijelova kod sebe !");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage( playerid, COLOR_RED, "Igrac nije online!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Dali ste %s %d mehanicarskih djelova.",
			GetName( giveplayerid, true),
			ammount
		);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dao %d mehanicarskih djelova.",
			GetName( playerid, true),
			ammount
		);

		new
			tmpString[64];
		format(tmpString, sizeof(tmpString), "* %s daje nesto %s.",
			GetName( playerid, true),
			GetName( giveplayerid, true)
		);
        SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 5000);

		PlayerInventory[giveplayerid][pParts] += ammount;
		PlayerInventory[playerid][pParts] -= ammount;
	}
	else if(strcmp(item,"put",true) == 0)
	{
	    if(Bit1_Get( gr_UsingMechanic, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes davati dijelove dok popravljas vozilo!");
		if(Repairing[playerid] == (true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno popravljate vozilo, sacekajte da prvo popravite vozilo.");

	    vehicleid = GetPlayerVehicleID(playerid);

		if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu !");
	    if(GetVehicleModel(vehicleid) != 525) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u towtrucku !");
	    if(sscanf(params, "s[16]i", item, ammount)) return SendClientMessage(playerid, COLOR_RED, "[?]: /parts put [kolicina]");
	    if(ammount < 1 || ammount > PlayerInventory[playerid][pParts]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko mehanicarskih dijelova kod sebe !");
		va_GameTextForPlayer( playerid, "~g~+%d dijelova u trucku", 1500, 1, ammount);

		VehicleInfo[vehicleid][vParts] += ammount;
		PlayerInventory[playerid][pParts] -= ammount;
	}
	else if(strcmp(item,"take",true) == 0)
	{
	    if(Bit1_Get( gr_UsingMechanic, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nesmijes vaditi dijelove ako popravljas auto!");
        if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu !");
		vehicleid = GetPlayerVehicleID(playerid);
        if(GetVehicleModel(vehicleid) != 525) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u towtrucku !");
        if(sscanf( params, "s[16]i", item, ammount))
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /parts take [kolicina]");
			va_SendMessage(playerid, MESSAGE_TYPE_INFO, "U ovom vozilu ima %d mehanicarskih djelova.",
				VehicleInfo[vehicleid][vParts]
			);
			return 1;
		}
        if(ammount < 1 || ammount > VehicleInfo[vehicleid][vParts]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U ovom vozilu nema toliko mehanicarskih dijelova !");

		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste %d mehanicarskih djelova iz vozila.",
			ammount
		);

		VehicleInfo[vehicleid][vParts] 	-= ammount;
		PlayerInventory[playerid][pParts] 	+= ammount;
	}
	else if(strcmp(item,"check",true) == 0)
	{
		if(PlayerJob[playerid][pJob] != JOB_MECHANIC) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi mehanicar!");
		SendClientMessage(playerid, COLOR_RED, "[!] Mehanicarski djelovi **");
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Imate %d mehanicarskih djelova kod sebe.",
			PlayerInventory[playerid][pParts]
		);
	}
	return 1;
}

CMD:mechanic(playerid, params[]) {		
	if(PlayerJob[playerid][pJob] != JOB_MECHANIC) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti zaposlen kao mehanicar da bi mogao koristiti komandu!");
			
	new action[18];
		
	if(sscanf(params, "s[18] ", action)) {
		SendClientMessage(playerid, COLOR_WHITE, "[KORISTI]: /mechanic [opcija].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(opcije): duty.");
		return (true);
    }
	
	if(strcmp(action,"duty",true) == 0) {	
		new string[128];
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2325.5754, -1340.4479, 23.0942)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate se nalaziti u mehanicarskoj radionici!");
			
  		if(MechanicDuty[playerid] == false) {
			MechanicDuty[playerid] = true;
			
			SendMessage(playerid, MESSAGE_TYPE_INFO,"Sada si na duznosti kao Mehanicar!");
			format(string, sizeof(string), "* Mehanicar %s je sada na duznosti. (( /jobduty))", GetName(playerid, false));
			SendClientMessageToAll(COLOR_YELLOW, string);
			
			if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 50);
			else if(PlayerInfo[playerid][pSex] == 2) SetPlayerSkin(playerid, 69);
		}
		else if(MechanicDuty[playerid] == true) {		
			MechanicDuty[playerid] = false;
			
			SendMessage(playerid, MESSAGE_TYPE_INFO,"Vise niste na duznosti kao Mehanicar!");
			SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
		}
	}
	return (true);
}
