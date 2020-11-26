#include <YSI_Coding\y_hooks>

#define TRANSPORTER_ID	(18)

new TWorking[MAX_PLAYERS];
new TCarry[MAX_PLAYERS];
new TDone[MAX_PLAYERS];
new EarlyDeliveryTimer[MAX_PLAYERS];
new carjob[MAX_PLAYERS];

enum E_TRANSPORTER_DATA
{
	Float:LocationX,
	Float:LocationY,
	Float:LocationZ
}

static const PossibleTransports[][E_TRANSPORTER_DATA] = {
	{1314.8433,-874.8862,39.1462},
	{1428.0747,-962.0276,35.9036},
	{1085.9773,-925.4023,42.9580},
	{506.7545,-1364.4945,15.6929},
	{481.1374,-1489.8527,19.6163},
	{311.5868,-1461.5955,33.6101},
	{342.0269,-1339.4581,14.0796},
	{1489.8390,-1127.2761,23.6459},
	{983.6830,-1135.3810,23.3960}
};


new TransportSpot[MAX_PLAYERS];


hook OnPlayerDisconnect(playerid){

	TCarry[playerid] = 0;
	TDone[playerid] = 0;
	TWorking[playerid] = 0;
	carjob[playerid]= 0;
	return 1;
}

hook OnPlayerDeath(playerid){

    TCarry[playerid] = 0;
    TDone[playerid] = 0;
	TWorking[playerid] = 0;
	carjob[playerid] = 0;
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(TWorking[playerid] > 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(!IsVehicleTransproter(GetPlayerVehicleID(playerid)))
				return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");

		    if(TWorking[playerid] == 1)
	        {
				if(EarlyDeliveryTimer[playerid] == 1) return FailedToDeliver(playerid);
				TogglePlayerControllable(playerid,0);
				defer ProductDelivered(playerid);
				SendClientMessage(playerid, COLOR_RED, "[ ! ] Stigli ste na lokaciju, pricekajte istovar.");
	        }
	        else if(TWorking[playerid] == 2)
	        {
	            if(EarlyDeliveryTimer[playerid] == 1) return FailedToDeliver(playerid);
	            TDone[playerid] = 0;
		        ShowPlayerDialog(playerid, DIALOG_ADRIAPOSAO, DIALOG_STYLE_MSGBOX, "{FA5656}TRANSPORTER", "Zelis li ponovo da krenes da dostavljas proizvode?", "Yes", "No");
		        TWorking[playerid] = 0;
		        TCarry[playerid] = 0;
		        DisablePlayerCheckpoint(playerid);
				Bit1_Set(gr_IsWorkingJob, playerid, false);
		        PlayerInfo[playerid][pFreeWorks] -= 5;
		        UpgradePlayerSkill(playerid);
				
				new money;
				switch(GetPlayerSkillLevel(playerid, 7)) // Skill ID 7 - Transporter Skill
				{
					case 1: money = 600;
					case 2: money = 700;
					case 3: money = 800;
					case 4: money = 900;
					case 5: money = 1100;
				}
				BudgetToPlayerBankMoney(playerid, money);
				PlayerInfo[playerid][pPayDayMoney] += money;
				va_SendClientMessage(playerid, COLOR_GREEN, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);
	        }
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_FIRE)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
	        if(TWorking[playerid] > 0)
	        {
	            if(TWorking[playerid] == 1)
	            {
		            if(TCarry[playerid] == 0)
		            {
			            if(IsPlayerInRangeOfPoint(playerid, 15, 1368.7151,222.5176,19.5547))
			            {
			                SetPlayerAttachedObject(playerid,9,1220,1,0.227000,0.610999,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
							ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 1, 1);
							TCarry[playerid] = 1;
							SendClientMessage(playerid, -1, "{FA5656}[ ! ] Sada idite do vaseg kombija i pritisnite levi klik kako biste utovarili kutiju proizvoda.");
			            }
					}
					else if(TCarry[playerid] == 1)
					{
					    if(IsPlayerInRangeOfVehicle(playerid, carjob[playerid], 5.0))
					    {
					        ClearAnimations(playerid);
					        RemovePlayerAttachedObject(playerid, 9);
					        TCarry[playerid] = 2;
					        
					        new
								id;

							id = random(sizeof(PossibleTransports));
							TransportSpot[playerid] = id;
					        SetPlayerCheckpoint(playerid, PossibleTransports[id][LocationX], PossibleTransports[id][LocationY], PossibleTransports[id][LocationZ], 2.0);
							SendClientMessage(playerid,-1,"{FA5656}[ ! ] Sada udji u kamion i idi do markera da istovaris kutiju proizvoda firmi.");
					    }
					}
				}
			}
        }
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid )
	{
		case DIALOG_ADRIAPOSAO:
		{
			if(response)
	     	{
				if(PlayerInfo[playerid][pFreeWorks] < 1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Odradio si dovoljno za ovaj payday! Pricekaj iduci.");
	      		SendClientMessage(playerid,-1,"{FA5656}[ ! ] Idi do stovarista (kutija) da uzmes kutiju proizvoda (levi klik kada dodjete).");
	        	Bit1_Set(gr_IsWorkingJob, playerid, true);
				TWorking[playerid] = 1;
	        	carjob[playerid] = GetPlayerVehicleID(playerid);
	        	TogglePlayerControllable(playerid, 1);
	         	TDone[playerid] = 1;
	         	EarlyDeliveryTimer[playerid] = 1;
				defer JobFinish(playerid);
	        }
	        else
	        {
	            TDone[playerid] = 0;
				Bit1_Set(gr_IsWorkingJob, playerid, false);
	        	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	         	RemovePlayerFromVehicle(playerid);
	         	TogglePlayerControllable(playerid, 1);
	        }
		}
	}
	return 0;
}

timer JobFinish[60000](playerid)
{
	EarlyDeliveryTimer[playerid] = 0;
	return 1;
}

timer ProductDelivered[15000](playerid)
{
	SetPlayerCheckpoint(playerid,1366.2841,258.5566,19.5630, 2);
    TogglePlayerControllable(playerid,1);
    va_SendClientMessage(playerid, -1, "{FA5656}[ ! ] Dostavljena kutija proizvoda (50 proizv.)");
    SendClientMessage(playerid,-1,"Sada se vrati u kamion, pa do skladista da bi dobio svoju platu!");
    TWorking[playerid] = 2;
    TDone[playerid] = 0;
	return 1;
}

FailedToDeliver(playerid)
{
    TogglePlayerControllable(playerid, 1);
   	TDone[playerid] = 0;
	EarlyDeliveryTimer[playerid] = 0;
   	GameTextForPlayer(playerid, "~r~Stigli ste na distanaciju prije mogu�moguceg vremena.~n~Niste dobili platu!", 10000, 3);
    new str[256];
    format(str,256,"{FA5656}[ADMIN] %s je zavrsio posao prije moguceg vremena. Provjerite ga!",GetName(playerid));
    SendAdminMessage(COLOR_RED,str);

	if(TWorking[playerid] > 0)
	{
 		RemovePlayerAttachedObject(playerid, 9);
 		ClearAnimations(playerid);
	}
	TWorking[playerid] = 0;
	TCarry[playerid] = 0;
	DisablePlayerCheckpoint(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	   	RemovePlayerFromVehicle(playerid);
	}
	return true;
}

stock IsVehicleTransproter(id)
{
	if(GetVehicleModel(id) == 499 )
	{
		return true;
	}
	return false;
}

CMD:transporter(playerid, params[])
{
	new
		param[12];
	if( sscanf(params, "s[12] ", param ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: transporter [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[OPTION]: start - stop");
		return 1;
	}
	if( !strcmp(param, "start", true) ) 
	{
		if(PlayerInfo[playerid][pJob] != TRANSPORTER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas posao dostavljaca!");
		if(TWorking[playerid] >= 1)
			return SendClientMessage( playerid, COLOR_RED, "Vec ste zapoceli voznju. Da prekinete kucajte /transporter stop!");
        if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");
        if(!IsVehicleTransproter(GetPlayerVehicleID(playerid)) || GetPlayerState(playerid) != 2)
			return SendClientMessage( playerid, COLOR_RED, "Morate biti vozac kamiona!");
		if(PlayerInfo[playerid][pFreeWorks] < 1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Odradio si dovoljno za ovaj payday! Pricekaj iduci.");

		ShowPlayerDialog(playerid, DIALOG_ADRIAPOSAO, DIALOG_STYLE_MSGBOX, "{FA5656}Transporter", "Jeste li sigurni da zelite zapoceti dostavu?", "Yes", "No");
	}
	else if( !strcmp(param, "stop", true) ) 
	{
		if( (PlayerInfo[playerid][pJob] != TRANSPORTER_ID)) return SendClientMessage( playerid, COLOR_RED, "Niste zaposleni kao kamiondzija.");
		if(TWorking[playerid] == 0) return SendClientMessage( playerid, COLOR_RED, "Nemate pokrenutu voznju!");
		if(TWorking[playerid] > 0)
  		{
    		TWorking[playerid] = 0;
      		ClearAnimations(playerid);
      		RemovePlayerAttachedObject(playerid, 9);
		    TCarry[playerid] = 0;
    	}
		TWorking[playerid] = 0;
		TCarry[playerid] = 0;
		carjob[playerid] = 0;
		EarlyDeliveryTimer[playerid] = 0;
		if(GetPlayerState(playerid) == 2)
		   	RemovePlayerFromVehicle(playerid);
	
		SendClientMessage(playerid, -1, "{FA5656}[ ! ] Uspesno ste zaustavili posao.");
		SendClientMessage(playerid, -1, "Ako ste na duznosti, ne zaboravite da odete sa nje. Takodje, ako ste uzeli opremu, nemojte zaboraviti da je ostavite.");
	}
	else {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: transporter [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[OPTION]: start - stop");
		return 1;
	}
	return 1;
}
