#include <YSI\y_hooks>

#include "modules/Systems/Factions/LSFD/Ambulance.pwn"
#include "modules/Systems/Factions/LSFD/Anamneza.pwn"
#include "modules/Systems/Factions/LSFD/Rope.pwn"

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
// DEFINES za cijene /confirmation
#define PSIHO_PRICE 800
#define ZDRAV_PRICE 750
#define RADNA_PRICE 600
// DEFINES za cijene /recover -a
#define RECOVERY_PRICE 500

#define MODEL_SELECTION_FDSKIN 939
#define MODEL_SELECTION_GOVSKIN 968
#define MODEL_SELECTION_LAWSKIN 969
#define MODEL_SELECTION_SDSKIN 989

static stock
	// 32 Bit
	Stretcher[MAX_PLAYERS] 						= {INVALID_OBJECT_ID, ...},
	// rBits
	Bit1:	gr_HaveOxygen	<MAX_PLAYERS> 		= {Bit1:false,...},
	Bit1:	gr_UsingStretcher<MAX_PLAYERS> 		= {Bit1:false,...},
	Bit1:	gr_StretcherSpawned<MAX_PLAYERS>	= {Bit1:false,...};

// PD skins
new
	lawskins_police[] =  {
	265, 267, 280, 281, 284, 306, 307, 20500, 20501, 20502, 20503, 20504, 20505, 20506, 20507, 20508, 20509, 20510, 20511, 
	20512, 20513, 20514, 20515, 20516, 20517, 20518, 20519, 20520, 20521, 20522, 20523, 20524, 20525, 20526, 20527, 20528, 
	20529, 20530, 20531, 20532, 20533, 20534, 20535, 20536, 20537, 20538, 20539, 20540, 20541, 20542, 20543, 20544, 20545, 
	20546, 20547, 20548, 20549, 20550, 20551, 20552, 20553, 20554, 20555, 20556, 20557, 20558, 20559, 20560, 20561, 20562, 
	20563, 20564, 20565, 20566, 20567, 20568, 20569, 20570, 20571, 20572
};

new
	lawskins_sheriff[] =  {
    20903, 20904, 20905, 20906, 20907, 20908, 20909, 20910, 20911, 20912, 20913, 20914, 20915, 20916,
	20917, 20918, 20919, 20920, 20921, 20922, 20923, 20924, 20925, 20926, 20927, 20928, 20929, 20930, 20931, 20932, 20933,
	20934, 20935, 20936 };

new	
	fdskins_selection[] = {
	20600, 20601, 20602, 20603, 20604, 20605, 20606, 20607, 20608, 20609, 20610, 20611, 20612, 20613, 20614, 20615 },
	fd_gate[10],
	fd_gstatus[10];


new
	govskins_gov[] = {
	20700, 20701, 20702, 20703, 20704, 20705, 20706, 20707, 20708, 20709, 20710, 20711, 20712, 20713, 20714, 20715, 20716, 20717, 20718
};

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

forward firedep_close(gate_id,  Float:X, Float:Y, Float:Z, Float:gate_speed, Float:RotX, Float:RotY, Float:RotZ);
public firedep_close(gate_id,  Float:X, Float:Y, Float:Z, Float:gate_speed, Float:RotX, Float:RotY, Float:RotZ)
{
	MoveDynamicObject(fd_gate[gate_id], X, Y, Z, gate_speed, RotX, RotY, RotZ);
	fd_gstatus[gate_id] = 0;
	return (true);
}

/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##     ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

hook OnGameModeInit() {
	// vrata na vrhu - L3o
	CreateDynamicObject(11714, 1161.67944, -1330.46667, 31.70260,   0.00000, 0.00000, 90.00000);
	fd_gate[0] = CreateDynamicObject(11313, 1277.762573, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[0], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[1] = CreateDynamicObject(11313, 1269.862304, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[1], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[2] = CreateDynamicObject(11313, 1261.960449, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[2], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[3] = CreateDynamicObject(11313, 1254.079467, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[3], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[4] = CreateDynamicObject(11313, 1246.167724, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[4], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[5] = CreateDynamicObject(11313, 1277.482299, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[5], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[6] = CreateDynamicObject(11313, 1269.582031, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[6], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[7] = CreateDynamicObject(11313, 1261.680175, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[7], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[8] = CreateDynamicObject(11313, 1253.799194, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(fd_gate[8], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
	fd_gate[9] = CreateDynamicObject(968, 1327.863159, -1235.412109, 13.384195, 0.000000, 90.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	
	// LSFD garaza - novo - by L3o
	CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 5, -1, -1, 100.00); // world 5
	CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 5, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 5, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 5, -1, -1, 100.00);
	
	// Pickup
	CreateDynamicPickup(19133, 2, 284.846497, -1540.948486, 24.596806, 5, -1, -1, 80.0); // garaza
	return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{ // provjeriti to
	if( Bit1_Get( gr_StretcherSpawned, playerid ) ) {
		if(IsValidObject(Stretcher[playerid])) {
			DestroyObject(Stretcher[playerid]);
			Stretcher[playerid] = INVALID_OBJECT_ID;
		}
		else if(IsValidDynamicObject(Stretcher[playerid])) {
			DestroyDynamicObject(Stretcher[playerid]);
			Stretcher[playerid] = INVALID_OBJECT_ID;
		}
	}
	Bit1_Set( gr_HaveOxygen, 		playerid, false );
	Bit1_Set( gr_UsingStretcher, 	playerid, false );
	Bit1_Set( gr_StretcherSpawned, 	playerid, false );
	Bit1_Set( gr_WeaponAllowed, 	playerid, false );
	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( PRESSED(KEY_YES) ) // Tipka Y
	{
		//======================== [LSFD NEW ] =========================
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1277.762573, -1269.913208, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[0] == 0) {
				MoveDynamicObject(fd_gate[0], 1277.7626, -1269.9132, 10.0307, 1.4, 0.0000, 0.0000, 90.0000);

				fd_gstatus[0] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 0, 1277.762573, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1269.862304, -1269.913208, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[1] == 0) {
				MoveDynamicObject(fd_gate[1], 1269.862304, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[1] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 1, 1269.862304, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1261.960449, -1269.913208, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[2] == 0) {
				MoveDynamicObject(fd_gate[2], 1261.960449, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[2] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 2, 1261.960449, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1254.079467, -1269.913208, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[3] == 0) {
				MoveDynamicObject(fd_gate[3], 1254.079467, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[3] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 3, 1254.079467, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1246.167724, -1269.913208, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[4] == 0) {
				MoveDynamicObject(fd_gate[4], 1246.167724, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[4] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 4, 1246.167724, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1277.482299, -1252.062744, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[5] == 0) {
				MoveDynamicObject(fd_gate[5], 1277.482299, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[5] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 5, 1277.482299, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1269.582031, -1252.062744, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[6] == 0) {
				MoveDynamicObject(fd_gate[6], 1269.582031, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[6] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 6, 1269.582031, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1261.680175, -1252.062744, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[7] == 0) {
				MoveDynamicObject(fd_gate[7], 1261.680175, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[7] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 7, 1261.680175, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1253.799194, -1252.062744, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[8] == 0) {
				MoveDynamicObject(fd_gate[8], 1253.799194, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[8] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 8, 1253.799194, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1253.799194, -1252.062744, 14.500725)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[8] == 0) {
				MoveDynamicObject(fd_gate[8], 1253.799194, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

				fd_gstatus[8] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 8, 1253.799194, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 8.0, 1327.863159, -1235.412109, 13.384195)) {
			if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
			if(fd_gstatus[9] == 0) {
				MoveDynamicObject(fd_gate[9], 1327.863159, -1235.412109, 13.384195, 1.4, 0.000000, 0.000000, 270.000000);

				fd_gstatus[9] = 1;
				SetTimerEx("firedep_close", 10000, false, "dfffffff", 9, 1327.863159, -1235.412109, 13.384195, 1.4, 0.000000, 90.000000, 270.000000);
				GameTextForPlayer(playerid, "~w~LSFD~n~~g~RAMP OPENING...", 5000, 3);
			}
		}
	}
	return 1;
}

hook OnModelSelResponse( playerid, extraid, index, modelid, response ) {
    if ((response) && (extraid == MODEL_SELECTION_FDSKIN )) {
		SetPlayerSkin(playerid, fdskins_selection[index]);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uzeli ste skin ID %d.", fdskins_selection[index]);
	}
	if ((response) && (extraid == MODEL_SELECTION_LAWSKIN )) {
		SetPlayerSkin(playerid, lawskins_police[index]);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uzeli ste skin ID %d.", lawskins_police[index]);
	}
	if ((response) && (extraid == MODEL_SELECTION_GOVSKIN )) {
		SetPlayerSkin(playerid, govskins_gov[index]);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uzeli ste skin ID %d.", govskins_gov[index]);
	}
	if ((response) && (extraid == MODEL_SELECTION_SDSKIN )) {
		SetPlayerSkin(playerid, lawskins_sheriff[index]);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uzeli ste skin ID %d.", lawskins_sheriff[index]);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
	case DIALOG_GOV_EQUIP: {
			if( !response ) {
				if( VehicleEquipment[ playerid ] != INVALID_VEHICLE_ID ) {
					new
						engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
				}
				return 1;
			}
			switch( listitem ) {
				case 0: {	// Skins
					ShowModelESelectionMenu(playerid, "GOV Skins", MODEL_SELECTION_GOVSKIN, govskins_gov, sizeof(govskins_gov), 0.0, 0.0, 0.0, 1.0, -1, true, govskins_gov);
				}
				case 1: { // Duty
					ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
				}
				case 2: { // Heal
					new
						Float:tempheal;
					GetPlayerHealth(playerid,tempheal);
					if(tempheal < 100.0)
						SetPlayerHealth(playerid,99.9);

					PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
					SetPlayerArmour(playerid, 50);

					new
						tmpString[60];
					format(tmpString, sizeof(tmpString), "* %s oblaci pancirku.", GetName(playerid, true));
					ProxDetector(30.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			return 1;
		}
		case DIALOG_GOV_EQUIP_DUTY: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");

			switch( listitem ) {
				case 0: { 	// Onduty
                    // Onduty
                    if(PlayerInfo[playerid][pLawDuty] == 1) return  SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti!");

					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					PlayerInfo[playerid][pLawDuty] = 1;

					//Poruke
					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit FD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_DARKYELLOW, duString);

					new
					tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s oblaci svoju radnu uniformu i priprema se za posao.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 1: { 	// Offduty
     				if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");

					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					SetPlayerArmour(playerid, 0.0);
					SetPlayerHealth(playerid, 99.9);
					SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ]);
					PlayerInfo[playerid][pLawDuty] = 0;

					//Poruke

					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste van  duznosti i ne mozete koristit FD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_DARKYELLOW, duString);

					new
						tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal", "Choose", "Abort");
			return 1;
		}
		case DIALOG_FD_EQUIP: {
			if( !response ) {
				if( VehicleEquipment[ playerid ] != INVALID_VEHICLE_ID ) {
					new
						engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
				}
				return 1;
			}
			
			switch( listitem ) {
			
                case 0: { 	// Skins
					ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
				}
				case 1: { 	// Skins
					//ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nRadnik\nCivil", "Choose", "Exit");
					ShowModelESelectionMenu(playerid, "FD Skins", MODEL_SELECTION_FDSKIN, fdskins_selection, sizeof(fdskins_selection), 0.0, 0.0, 0.0, 1.0, -1, true, fdskins_selection);
				}
				case 2: {	// Dodaci
					ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MISC, DIALOG_STYLE_LIST, "LSFD Equipment", "Vatrogasni aparat\nSjekira\nMotorna pila\nKisik", "Choose", "Abort");
				}
				case 3: {	// Heal
					SetPlayerHealth(playerid, 99.9);
					SetPlayerArmour(playerid, 50);
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				}
				case 4:
					SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ]);
			}
			return 1;
		}
				case DIALOG_FD_EQUIP_DUTY: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");

			switch( listitem ) {
				case 0:
				{ 	// Onduty
                    if(PlayerInfo[playerid][pLawDuty] == 1) return  SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti.!");

					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					PlayerInfo[playerid][pLawDuty] = 1;

					//Poruke
					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit FD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_ALLDEPT, duString);

					new
					tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s oblaci svoju radnu uniformu i priprema se za posao.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 1: { 	// Offduty
				    if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
                    
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					SetPlayerArmour(playerid, 0.0);
					SetPlayerHealth(playerid, 99.9);
					SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ]);
					PlayerInfo[playerid][pLawDuty] = 0;

					//Poruke

					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste van  duznosti i ne mozete koristit FD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_ALLDEPT, duString);

					new
						tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			return 1;
		}
		case DIALOG_FD_EQUIP_SKIN: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			switch( listitem ) {
				case 0:
					ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MD, DIALOG_STYLE_LIST, "LSFD Equipment", "Doktor\nCrnac\nLatino\nBijelac\nZenska", "Choose", "Exit");
					//ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_MD, DIALOG_STYLE_LIST, "LSFD Equipment", "Doktor\nCrnac\nLatino\nBijelac\nZenska\n20035\n20037\n20039\n20041", "Choose", "Exit");
				case 1:
					ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_FD, DIALOG_STYLE_LIST, "LSFD Equipment", "Crnac\nBijelac\nLatino", "Choose", "Exit");
					//ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_FD, DIALOG_STYLE_LIST, "LSFD Equipment", "Crnac\nBijelac\nLatino\n20036\n20038\n20040\n20042\n20043", "Choose", "Exit");
				case 2:
				    ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_RADNICI, DIALOG_STYLE_LIST, "LSFD Equipment", "Radnik 1\nRadnik 2", "Choose", "Exit");
				case 3:
					SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ]);
			}
			return 1;
		}
		case DIALOG_FD_EQUIP_MD: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
			switch(listitem) 
			{
				case 0:  PlayerInfo[playerid][pSkin] = 70;
				case 1:  PlayerInfo[playerid][pSkin] = 274;
				case 2:	 PlayerInfo[playerid][pSkin] = 275;	
				case 3:  PlayerInfo[playerid][pSkin] = 276;
				case 4:  PlayerInfo[playerid][pSkin] = 308;
			}
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			return 1;
		}
		case DIALOG_FD_EQUIP_FD: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
			switch(listitem) 
			{
				case 0:  PlayerInfo[playerid][pSkin] = 278;
				case 1:  PlayerInfo[playerid][pSkin] = 277;
				case 2:	 PlayerInfo[playerid][pSkin] = 279;	
			}
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			return 1;
		}
		case DIALOG_FD_EQUIP_RADNICI:
		{
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP_SKIN, DIALOG_STYLE_LIST, "LSFD Equipment", "Bolnicar\nVatrogasac\nCivil", "Choose", "Exit");
 			switch(listitem)
			{
				case 0:
					SetPlayerSkin(playerid, 8);
				case 1:
					SetPlayerSkin(playerid, 69);
			}
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		}
		case DIALOG_FD_EQUIP_MISC: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			new
				tmpString[ 64 ];
			switch( listitem ) {
				case 0: { 	// Aparat
					AC_GivePlayerWeapon(playerid, 42, 999999999);
					format(tmpString, sizeof(tmpString), "* %s uzima vatrogasni aparat.", GetName(playerid, true));
					ProxDetector(5.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 1: { 	// Sjekira
					AC_GivePlayerWeapon(playerid, 8, 1);
					format(tmpString, sizeof(tmpString), "* %s uzima sjekiru.", GetName(playerid, true));
					ProxDetector(5.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 2: { 	// Pila
					AC_GivePlayerWeapon(playerid, 9, 1);
					format(tmpString, sizeof(tmpString), "* %s uzima motornu pilu.", GetName(playerid, true));
					ProxDetector(5.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 3: { // Kisik
					if( IsPlayerAttachedObjectSlotUsed(playerid, 9) )
						RemovePlayerAttachedObject(playerid, 9);
					
					Bit1_Set( gr_HaveOxygen, playerid, true );
					SetPlayerAttachedObject(playerid, 9, 1009, 1, 0.0, -0.12, 0.0, 270.0, 180.0, 0.0, 1.1, 1.1, 1.1);
					format(tmpString, sizeof(tmpString), "* %s uzima bocu s kisikom.", GetName(playerid, true));
					ProxDetector(5.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			return 1;
		}
		case DIALOG_PD_EQUIP: {
			if( !response ) {
				if( VehicleEquipment[ playerid ] != INVALID_VEHICLE_ID ) {
					new
						engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(VehicleEquipment[ playerid ], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
				}
				return 1;
			}
			switch( listitem ) {
				case 0: {	// Skins
					//ShowPlayerDialog(playerid, DIALOG_PD_SKIN, DIALOG_STYLE_LIST, "ODABIR SKINA", "71\n93\n211\n217\n265\n267\n280\n281\n282\n283\n284\n288\nCivilni skin", "Choose", "Abort");
					if(IsACop(playerid))
					{
						ShowModelESelectionMenu(playerid, "Police Skins", MODEL_SELECTION_LAWSKIN, lawskins_police, sizeof(lawskins_police), 0.0, 0.0, 0.0, 1.0, -1, true, lawskins_police);
					}
					else if(IsASD(playerid))
					{
					    ShowModelESelectionMenu(playerid, "Sheriff Skins", MODEL_SELECTION_SDSKIN, lawskins_sheriff, sizeof(lawskins_sheriff), 0.0, 0.0, 0.0, 1.0, -1, true, lawskins_sheriff);
					}
					return 1;
				}
				case 1: { // Duty
					ShowPlayerDialog(playerid, DIALOG_PD_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
				}
				case 2: { // Heal
					new
						Float:tempheal;
					GetPlayerHealth(playerid,tempheal);
					if(tempheal < 100.0) 
						SetPlayerHealth(playerid,99.9);
					
					PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
					SetPlayerArmour(playerid, 99);
					
					new 
						tmpString[60];
					format(tmpString, sizeof(tmpString), "* %s oblaci pancirku.", GetName(playerid, true));
					ProxDetector(30.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 3: { // Buygun
					if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete koristiti ovu komandu dok ste level 1!"), ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
					if(IsACop(playerid) && PlayerInfo[playerid][pRank] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste rank 2!"), ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
					ShowPlayerDialog(playerid,DIALOG_PD_BUYGUN,DIALOG_STYLE_LIST,"POLICE ARMOURY","Desert Eagle - 50 metaka\nShotgun - 50 metaka\nMP5 - 150 metaka\nM4 - 200 metaka\nSniper Rifle - 50 metaka\nKnife\nTeargas - 10\nColt45 - 50\nSilenced - 50 metaka\nSpraycan\nNitestick\nBean Bag - 50 metaka\nRifle - 50 komanda","Choose","Exit");
				}
			}
			return 1;
		}
		case DIALOG_PD_EQUIP_DUTY: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
			
			switch( listitem ) {
				case 0:
				{ 	// Onduty
                    if(PlayerInfo[playerid][pLawDuty] == 1) return  SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti.!");
					if (! CheckPlayerWeapons(playerid, 24) ) return 1;
            		AC_ResetPlayerWeapons(playerid); // da se ne skuplja po 1000+ metaka digla
				
					Bit1_Set(gr_Taser, playerid, false);
					Bit1_Set( gr_PDOnDuty, playerid, true );
		        	AC_GivePlayerWeapon(playerid, 3, 1);
				    AC_GivePlayerWeapon(playerid, 24, 50);
				    AC_GivePlayerWeapon(playerid, 41, 1000);
					AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 500);
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					PlayerInfo[playerid][pLawDuty] = 1;
					
					//Poruke
					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit PD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, duString);

					new
					tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s oblaci svoju radnu uniformu i priprema se za posao.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 1: { 	// Offduty
				    if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
					AC_ResetPlayerWeapons(playerid);
					Bit1_Set( gr_PDOnDuty, playerid, false );
					PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
					SetPlayerArmour(playerid, 0.0);
					SetPlayerHealth(playerid, 99.9);
					SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ]);
					PlayerInfo[playerid][pLawDuty] = 0;
					format(PlayerInfo[playerid][pCallsign], 128, "");
					
					//Poruke
					
					new duString[70];
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste van  duznosti i ne mozete koristit PD komande.");
  					format(duString, sizeof(duString), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, duString);
					
					new 
						tmpString[80];
					format(tmpString, sizeof(tmpString), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
					ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
			return 1;
		}
	}
	return 0;
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
/*
CMD:enablesiren(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid),
 		siren = GetVehicleParamsSirenState(vehicleid);
	if(!IsAGov(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi pripadnik vlade!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi u vozilu.");
	{
	if(siren == 1)
		{
			siren = 0;
			GameTextForPlayer(playerid, "SIRENA UKLJUCENA", 1000, 4);
			return 1;
		}
	else
	    {
			siren = 1;
			GameTextForPlayer(playerid, "SIRENA ISKLJUCENA", 1000, 4);
			return 1;
		}
	}
	return 1;
}
*/

CMD:equipment(playerid, params[])
{
    if( IsFDMember(playerid) )
	{
		if( IsPlayerInRangeOfPoint(playerid, 10.0, 1176.2422,-1344.8013,-53.6860) || IsPlayerInRangeOfPoint(playerid, 10.0, 1244.3059,-1253.0569,13.5403) || IsPlayerInRangeOfPoint(playerid, 10.0, 1068.8527,-1764.5013,-37.2122))
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal", "Choose", "Abort");
		else {
			new
				Float:X, Float:Y, Float:Z, vehicleid = -1;
			foreach(new i : Vehicles) {
				GetVehiclePos(i, X, Y, Z);
				if(VehicleInfo[i][vFaction] == 2 && IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z)) {
					vehicleid = i;
					break;
				}		
			}
			if(vehicleid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice/FD vozila!");
			ShowPlayerDialog(playerid, DIALOG_FD_EQUIP, DIALOG_STYLE_LIST, "LSFD Equipment", "Duty\nSkin\nDodaci\nHeal\nCivil Skin", "Choose", "Abort");
		}
	}
	else if( IsACop(playerid) || IsASD(playerid))
	{
 		if( IsPlayerInRangeOfPoint(playerid,5.0,2040.6858,1260.2460,-11.1115) || IsPlayerInRangeOfPoint(playerid,5.0,1073.3243,1309.4116,-47.7425) || IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) || IsPlayerInRangeOfPoint(playerid, 10.0, 2097.3110,-2123.7720,-44.1565) || IsPlayerInRangeOfPoint(playerid, 10.0, 2878.4600,-844.5946,-21.6994))
			ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LAW Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice!");
	}
	else if( IsAGov(playerid) )
	{
 		if( IsPlayerInRangeOfPoint(playerid,5.0,1315.3967,758.2388,-93.1678))
			ShowPlayerDialog(playerid, DIALOG_GOV_EQUIP, DIALOG_STYLE_LIST, "GOV Equipment", "Skin\nDuty\nHeal", "Choose", "Abort");
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu svlacionice!");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFDa/LSPDa/LSSDa/LSGOVa!");
	return 1;
}

CMD:oxygen(playerid, params[])
{
	if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSFD!");
	if( !Bit1_Get( gr_HaveOxygen, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate bocu s kisikom!");
	
	if( IsPlayerAttachedObjectSlotUsed(playerid, 9) )
		RemovePlayerAttachedObject(playerid, 9);
	else
		SetPlayerAttachedObject(playerid, 9, 1009, 1, 0.0, -0.12, 0.0, 270.0, 180.0, 0.0, 1.1, 1.1, 1.1);
	return 1;
}

CMD:createexplosion(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new Float:X, Float:Y, Float:Z,
			type;
		if(sscanf(params, "d", type)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /createexplosion [type]");
		
		GetPlayerPos(playerid, X, Y, Z);
		CreateExplosion(X, Y, Z, type, 15.0);
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi ovlasten za koristenje ove komande!");
	return 1;
}

CMD:rtcfdcars(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] != 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi lider LSFDa!");
	for(new x=0; x < MAX_VEHICLES; x++) {
		if(VehicleInfo[x][vFaction] == 2) {
			if(!IsVehicleOccupied(x))
				SetVehicleToRespawn(x);
		}
	}
	return 1;
}

CMD:fdlift(playerid, params[])
{
	if( IsFDMember(playerid) )
	{
		if( IsPlayerInRangeOfPoint(playerid, 2.0, 1160.9481,-1331.8121,-53.6800) || IsPlayerInRangeOfPoint(playerid, 2.0, 1155.6108,-1331.7755,-53.6800) || IsPlayerInRangeOfPoint(playerid, 2.0, 1133.4607,-1330.7346,-53.6900))
			SetPlayerPosEx(playerid, 1161.7253, -1329.7349, 31.5077, 0, 0, false );
		else if( IsPlayerInRangeOfPoint(playerid, 3.0, 1161.7253, -1329.7349, 31.5077) )
			SetPlayerPosEx(playerid, 1160.7086, -1331.2377, -53.8716, 1, 1, true );
	}
	return 1;
}

CMD:recover(playerid, params[])
{
	if( !IsFDMember(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste LSFD!");

	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /recover [dio imena/playerid]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan playerid!");
	if( !PlayerInfo[ giveplayerid ][ pKilled ] && !PlayerWounded[giveplayerid] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije ubijen/ozlijedjen!");
	if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije dovoljno blizu vas!");
	if(DeathCountStarted_Get(giveplayerid)) return SendClientMessage( playerid, COLOR_RED, "Igrac je mrtav i ne moze se reviveati!");
	DestroyDeathInfo(giveplayerid);
	DestroyDeathTDs(giveplayerid);
	KillTimer(DeathTimer[giveplayerid]);

	DeathCountStarted_Set(giveplayerid, false);
	DeathCountSeconds_Set(giveplayerid, 0);

	PlayerInfo[ giveplayerid ][ pDeath ][ 0 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 1 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 2 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeathInt ] 	= 0;
	PlayerInfo[ giveplayerid ][ pDeathVW ] 		= 0;
	PlayerInfo[ giveplayerid ][ pKilled ] 	 	= 0;
	
	ResetPlayerWounded(giveplayerid);
	
	BudgetToOrgMoney(FACTION_TYPE_FD, RECOVERY_PRICE); //dobivaju nagradu za recover od drzave

	SetPlayerHealth(giveplayerid, 50.0);
	TogglePlayerControllable(giveplayerid, true);
	
	new
		deleteQuery[128];
	format(deleteQuery, 128, "DELETE FROM `player_deaths` WHERE `player_id` = '%d'", PlayerInfo[giveplayerid][pSQLID]);
	mysql_tquery(g_SQL, deleteQuery, "", "");

	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Bolnicar %s vas je izlijecio i vise niste u post death stanju!",
		GetName(playerid)
	);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Izlijecili ste %s i on vise nije u post death stanju!",
		GetName(giveplayerid)
	);
	return 1;
}

CMD:stretcher(playerid, params[])
{
	if(!IsFDMember(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi clan LSFDa.");
	new 
		param[10];
	if(sscanf(params, "s[16] ", param)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /stretcher [get/drop/pick/destroy]");
	if(!strcmp(param, "get", true, 3)) {
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED, "Ne mozes koristiti ovo u vozilu.");
		if(Bit1_Get(gr_StretcherSpawned, playerid)) return SendClientMessage(playerid,COLOR_RED, "Vec si spawnao jedna nosila.");

		new 
			Float:X, Float:Y, Float:Z, Float:angle;
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, angle);
		
		if(IsValidDynamicObject(Stretcher[playerid])) {
			DestroyDynamicObject(Stretcher[playerid]);
			Stretcher[playerid] = INVALID_OBJECT_ID;
		}
		
		Stretcher[playerid] = CreateDynamicObject(2146, X, Y, Z, 0.0, 0.0, angle);
		AttachDynamicObjectToPlayer(Stretcher[playerid], playerid, 0.00, 1.30, -0.50, 0.0, 0.0, 0.0);
		Streamer_UpdateEx(playerid, X, Y, Z);
		
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		Bit1_Set(gr_UsingStretcher, playerid, 1);
		Bit1_Set(gr_StretcherSpawned, playerid, 1);
	}
	else if(!strcmp(param, "drop", true, 4)) {
		if(!Bit1_Get(gr_UsingStretcher, playerid)) return SendClientMessage(playerid,COLOR_RED, "Ne koristis nosila.");
    	
		new Float:X, Float:Y, Float:Z, Float:R;
        GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, R);
		
		if(IsValidDynamicObject(Stretcher[playerid])) {
			DestroyDynamicObject(Stretcher[playerid]);
			Stretcher[playerid] = INVALID_OBJECT_ID;
		}
		
		Stretcher[playerid] = CreateDynamicObject(2146, X, Y, Z-0.50, 0.0, 0.0, R);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		Streamer_UpdateEx(playerid, X, Y, Z);
       	
		Bit1_Set(gr_UsingStretcher, playerid, false);
		Bit1_Set(gr_StretcherSpawned, playerid, true);
	}
	else if(!strcmp(param, "destroy", true, 7)) {
		if(!Bit1_Get(gr_StretcherSpawned, playerid)) return SendClientMessage(playerid,COLOR_RED, "Nisi spawnao nosila.");
        
		if(IsValidDynamicObject(Stretcher[playerid])) {
			DestroyDynamicObject(Stretcher[playerid]);
			Stretcher[playerid] = INVALID_OBJECT_ID;
		}
		
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		Bit1_Set(gr_UsingStretcher, playerid, 0);
		Bit1_Set(gr_StretcherSpawned, playerid, 0);
	}
	else if(!strcmp(param, "pick", true, 4)) {
		new
			Float:X, Float:Y, Float:Z, Float:angle;
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, angle);
		
        if( IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z) && !Bit1_Get(gr_UsingStretcher, playerid) )
		{
        	if(IsValidDynamicObject(Stretcher[playerid])) {
				DestroyDynamicObject(Stretcher[playerid]);
				Stretcher[playerid] = INVALID_OBJECT_ID;
			}
			
			Stretcher[playerid] = CreateDynamicObject(2146, X, Y, Z, 0.0, 0.0, angle);
			AttachDynamicObjectToPlayer(Stretcher[playerid], playerid, 0.00, 1.30, -0.50, 0.0, 0.0, 0.0);
			Streamer_UpdateEx(playerid, X, Y, Z);
			
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	  		Bit1_Set(gr_UsingStretcher, playerid, 1);
        }
        else SendClientMessage(playerid,COLOR_RED, "Nisi blizu nosila ili ih koristis.");
	}
	return 1;
}

CMD:treatment(playerid, params[])
{
	if(!IsFDMember(playerid)) return SendClientMessage(playerid, COLOR_RED, "Niste doktor!");
	new
		giveplayerid, time;
	if( sscanf( params, "ui", giveplayerid, time ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /treatment [playerid/dio imena][minute]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Unijeli ste krivi playerid!");
	if( time < 0 || time > 100 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos vremena tretmana!");
	if( giveplayerid == playerid ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe stavljati na tretman!");
	if( PlayerInfo[ giveplayerid ][ pJailed ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac je vec na tretmanu ili je zatvoren!");
	
	PutPlayerInJail(giveplayerid, time, 5); // 5 je treatment program
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Postavio si %s na lijecenje.",GetName(giveplayerid, true));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Postavljen si na lijecenje od strane doktora %s.",GetName(playerid, true));
	return 1;
}

CMD:confirmation(playerid, params[])
{
	new giveplayerid, opcija[20],string[100];
	new year, month, day;
	new rand = random(9999);
	if(!IsFDMember(playerid) || PlayerInfo[playerid][pRank] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste doktor ili ste premal rank");
    if(IsFDMember(playerid) && PlayerInfo[playerid][pRank] < 1) return SendClientMessage(playerid, COLOR_RED, "Suspendirani ste!");
	if (sscanf(params, "s[20]u", opcija, giveplayerid))
		{
			SendClientMessage(playerid, COLOR_RED, "|__________________ {FA5656]Davanje uvjerenja __________________|");
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /confirmation [opcija] [Ime_Igraca/ID]");
	  		SendClientMessage(playerid, COLOR_RED, "[ ! ] psihicka_sposobnost, zdrav_sposobnost, radna_sposobnost");
			SendClientMessage(playerid, COLOR_RED, "|_______________________________________________________|");
			return 1;
		}
  	if(strcmp(opcija,"psihicka_sposobnost",true) == 0)
	{
	    getdate(year, month, day);
    	format(string, sizeof(string), "________________ #%d Lijecnicka potvrda _________________", rand);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovom potvrdom potvrduje se da je osoba %s", GetName(giveplayerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "psiholoski sposobna i da nema psihickih poremecaja.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                               Doktor: %s ", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, "___________________________________________________");
		//
		format(string, sizeof(string), "Dali ste %s uvjerenje od psihickoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
		SendClientMessage(playerid, 0xA1C3FFFF, string);
		//
		format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o psihickoj stabilnosti. (R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, PSIHO_PRICE);
		
		format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", PSIHO_PRICE);
		SendClientMessage(giveplayerid, -1, string);
		PlayerToOrgMoney(giveplayerid, FACTION_TYPE_FD, PSIHO_PRICE);
		
	}
	else if(strcmp(opcija,"zdrav_sposobnost",true) == 0)
	{
		getdate(year, month, day);
    	format(string, sizeof(string), "________________ #%d Lijecnicka potvrda _________________", rand);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovom potvrdom potvrduje se da je osoba %s", GetName(giveplayerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "zdravstveno sposobna i da nema zdravstvenih problema.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                                Doktor: %s ", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, "___________________________________________________");
		//
		format(string, sizeof(string), "Dali ste %s uvjerenje od zdravstvenoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
		SendClientMessage(playerid, 0xA1C3FFFF, string);
		//
		format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o psihickoj stabilnosti.(R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, ZDRAV_PRICE);
  		SendRadioMessage(2, TEAM_BLUE_COLOR, string);
		format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", ZDRAV_PRICE);
		SendClientMessage(giveplayerid, -1, string);
		PlayerToOrgMoney(giveplayerid, FACTION_TYPE_FD, ZDRAV_PRICE);
	}
	else if(strcmp(opcija,"radna_sposobnost",true) == 0)
	{
		getdate(year, month, day);
    	format(string, sizeof(string), "_____________________ #%d Lijecnicko uvjerenje _________________", rand);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, string);
        format(string, sizeof(string), "Ovim uvjerenjem dokazuje se da je osoba %s", GetName(giveplayerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        SendClientMessage(giveplayerid, COLOR_WHITE, "radno sposobna te nema zdravstvenih, psiholoskih i fizioloskih problema.");
        format(string, sizeof(string), "Los Santos Ambulance, Datum: %d.%d.%d.", day,month,year);
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
        format(string, sizeof(string), "                                                Doktor: %s ", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_WHITE, string);
		SendClientMessage(giveplayerid, 0xA1C3FFFF, "________________________________________________________");
		//
		format(string, sizeof(string), "Dali ste %s uvjerenje od psihickoj stabilnosti. Broj uvjerenja: %d", GetName(giveplayerid), rand);
		SendClientMessage(playerid, 0xA1C3FFFF, string);
		//
		format(string, sizeof(string), "[HQ] %s %s je dao %s uvjerenje o radnoj sposobnosti. (R.br.: %d) [+%d$]", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), rand, RADNA_PRICE);
  		SendRadioMessage(2, TEAM_BLUE_COLOR, string);
		format(string, sizeof(string), "[INFO] Za uvjerenje platili ste %d$.", RADNA_PRICE);
		SendClientMessage(giveplayerid, -1, string);
		PlayerToOrgMoney(giveplayerid, FACTION_TYPE_FD, RADNA_PRICE);
	}
	else SendClientMessage(playerid, COLOR_RED, "Nepoznata opcija, pokusajte ponovo!");
    return 1;
}

CMD:injectp(playerid, params[])
{
 	new
    	giveplayerid;
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /injectp [playerid/dio imena]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid!");
    if( giveplayerid == playerid ) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe lije�iti.");
	if( !ProxDetectorS(5.0, playerid, giveplayerid) ) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu tog igraca!");

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Poslali ste zahtjev za injekciju %s", GetName(giveplayerid));
    va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] %s vam je poslao zahtjev za injekciju, kucajte /accept inject za lijecenje!", GetName(playerid));

    InjectPlayer[playerid] 		= giveplayerid;
    InjectPlayer[giveplayerid] 	= playerid;
	return 1;
}
