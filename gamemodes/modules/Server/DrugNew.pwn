#include <YSI\y_hooks>

#define DRUG_SYSTEM_NEW 	// ne brisi

// 15352 PPHG
// 35478

/*
		else if (PlayerData[i][pDrugUsed] != 0 && PlayerData[i][pDrugTime] > 0)
		{
		    if (--PlayerData[i][pDrugTime] && 1 <= PlayerData[i][pDrugUsed] <= 3 && GetPlayerDrunkLevel(i) < 5000) {
		        SetPlayerDrunkLevel(i, 10000);

				PlayerTextDrawShow(i, PlayerData[i][pTextdraws][8]);

				if (PlayerData[i][pDrugUsed] == 3) {
				    SetPlayerWeather(i, -67);
				    SetPlayerTime(i, 12, 12); // Set the time (the drug weather is buggy at night)
				}
			}
		    if (1 <= PlayerData[i][pDrugUsed] <= 3 && ReturnHealth(i) <= 95) {
		    	SetPlayerHealth(i, ReturnHealth(i) + 5);
			}
		    if (!PlayerData[i][pDrugTime])
		    {
		        new
	        		time[3];

        		gettime(time[0], time[1], time[2]);
				SetPlayerTime(i, time[0], time[1]);

		        SetPlayerDrunkLevel(i, 500);
				PlayerTextDrawHide(i, PlayerData[i][pTextdraws][8]);

				PlayerData[i][pDrugUsed] = 0;
		        SendServerMessage(i, "The effects from the drugs have subsided.");
		    }
		}
*/

//#define MAX_DRUG_SLOTS (5)
#define MAX_VEHICLE_DRUGS (10)
#define MAX_DRUG_AMOUNT (100)

#define DRUG_TYPE_NONE 		(0)
#define DRUG_TYPE_SMOKE 	(1)
#define DRUG_TYPE_SNORT 	(2)
#define DRUG_TYPE_INJECT 	(3)
#define DRUG_TYPE_TABLET	(4)

enum E_DRUG_DATA
{
	dSQLID[5],
	dType[5],
	dAmount[5],
	dQuality[5],
	dTimeStamp[5]
}
new
	PlayerDrugs[MAX_PLAYERS][E_DRUG_DATA];


enum E_DRUG_INFO
{
	dName[10],
	dEffect,
	dPayDayT,
	dUseTime
}

/*#define GetDrugName(%0) \ Maknuto da vidim oce li bacat errore zato sta fale funkcije slicnog imena
			drugs[%0][dName]

#define GetDrugEffect(%0) \
			drugs[%0][dEffect]*/

#define GetDrugNameByDrugID(%0) \
			drugs[%0][dName]

static const
	drugs[][E_DRUG_INFO] =
{
	{"Prazno", 		DRUG_TYPE_NONE,   0, 0},
	{"Marihuana", 	DRUG_TYPE_SMOKE,  8, 25},
	{"Kokain", 		DRUG_TYPE_SNORT,  12, 30},
	{"Heroin", 		DRUG_TYPE_INJECT, 15, 35},
	{"Xanax",		DRUG_TYPE_TABLET, 15, 40},
	{"LSD", 		DRUG_TYPE_TABLET, 15, 50}
};

enum e_V_DRUGS
{
	sqlid[MAX_VEHICLE_DRUGS],
	type[MAX_VEHICLE_DRUGS],
	Float:amount[MAX_VEHICLE_DRUGS],
	quality[MAX_VEHICLE_DRUGS],
	timestamp[MAX_VEHICLE_DRUGS]
}

new
	VehicleDrugs[MAX_VEHICLES][e_V_DRUGS];

Function: LoadPlayerDrugs(playerid)
{
	new
		tmpQuery[128];

	format(tmpQuery, 128, "SELECT * FROM `player_drugs` WHERE `player_id` = '%d'", PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, tmpQuery, "LoadingPlayerDrugs", "i", playerid);
	return 1;
}

forward LoadingPlayerDrugs(playerid);
public LoadingPlayerDrugs(playerid)
{

	#if defined MOD_DEBUG
		printf("DEBUG DRUGS: count(%d)", cache_num_rows());
	#endif

	if(cache_num_rows())
	{
	    for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", PlayerDrugs[playerid][dSQLID][i]);
			cache_get_value_name_int(i, "code", PlayerDrugs[playerid][dType][i]);
			cache_get_value_name_float(i, "amount", PlayerDrugs[playerid][dAmount][i]);
			cache_get_value_name_int(i, "effect", PlayerDrugs[playerid][dQuality][i]);
			//cache_get_value_name_int(i, "timestamp", PlayerDrugs[playerid][dTimeStamp][i]);
		}
	}
	return 1;
}

ResetVehicleDrugs(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;

	static const
		e_vDrugs[e_V_DRUGS];

	VehicleDrugs[vehicleid] = e_vDrugs;

	return 1;
}

ResetPlayerDrugs(playerid)
{
	static const
		e_pDrugs[E_DRUG_DATA];

	PlayerDrugs[playerid] = e_pDrugs;

	return 1;
}

ListPlayerDrugs(playerid, owner)
{
	new
		dstring[59],
		drugall[174],
		titled[MAX_PLAYER_NAME + 10],
		d = 0;

	for(new s = 0; s < MAX_PLAYER_DRUGS; ++s)
	{
		if(PlayerDrugs[owner][dCode][s] != 0)
		{
			format(dstring, sizeof(dstring), "%sSLOT %d: %s [%d %s]", (!d) ? ("") : ("\n"), s+1, drugs[PlayerDrugs[owner][dCode][s]][dName], PlayerDrugs[owner][dAmount][s], (drugs[PlayerDrugs[owner][dCode][s]][dEffect] < 4) ? ("grama") : ("tableta"));

			strcat(drugall, dstring, sizeof(drugall));

			++d;
		}
	}

	if(!d && playerid == owner)
		return SendClientMessage(playerid, COLOR_RED, "Nemas droge!");
	else if(!d && playerid != owner)
		return SendClientMessage(playerid, COLOR_RED, "Igrac nema droge!");

	format(titled, 37, "Droga od %s", GetName(owner));
	Dialog_Open(playerid, empty, DIALOG_STYLE_MSGBOX, titled, drugall, "Izlaz", "");

	return 1;
}
/*
enum e_V_DRUGS
{
	sqlid[MAX_VEHICLE_DRUGS],
	type[MAX_VEHICLE_DRUGS],
	amount[[MAX_VEHICLE_DRUGS],
	quality[MAX_VEHICLE_DRUGS],
	timestamp[MAX_VEHICLE_DRUGS]
}

new
	VehicleDrugs[MAX_VEHICLES][e_V_DRUGS];
*/
ListVehicleDrugs(playerid, vehicleid)
{
	new
		dstring[59],
		drugall[174],
		titled[MAX_PLAYER_NAME + 10],
		y = 0;

	for(new d = 0; d < MAX_VEHICLE_DRUGS; ++d)
	{
		if(VehicleDrugs[vehicleid][type][d] != 0)
		{
			format(dstring, sizeof(dstring), "%sSLOT %d: %s [%f %s]", (!y) ? ("") : ("\n"), d+1, drugs[VehicleDrugs[vehicleid][type][d]][dName], VehicleDrugs[vehicleid][amount][d], (drugs[VehicleDrugs[vehicleid][type][d]][dEffect] < 4) ? ("grama") : ("tableta"));

			strcat(drugall, dstring, sizeof(drugall));

			++y;
		}
	}

	if(!y && PlayerInfo[playerid][pSQLID] == VehicleInfo[vehicleid][vOwnerID])
		return SendClientMessage(playerid, COLOR_RED, "Nemas droge u vozilu!");
	else if(!y)
		return SendClientMessage(playerid, COLOR_RED, "U ovom vozilu nema droge!");

	new
		vName[MAX_VEHICLE_NAME];

	GetVehicleNameByModel(GetVehicleModel(vehicleid), vName, MAX_VEHICLE_NAME);

	format(titled, 37, "Droga u %s[%d]{%d}", vName, vehicleid, VehicleInfo[vehicleid][vSQLID]);
	Dialog_Open(playerid, empty, DIALOG_STYLE_MSGBOX, titled, drugall, "Izlaz", "");
	return 1;
}

ReturnDrugQuality(drugquality)
{
	new
		dq[6];

	switch(drugquality)
	{
		case 0 .. 9: strcat(dq, "Vrlo Losa", sizeof(dq));
		case 10 .. 19: strcat(dq, "Losa", sizeof(dq));
		case 20 .. 29: strcat(dq, "Dobra", sizeof(dq));
		case 30 .. 39: strcat(dq, "Vrlo Dobra", sizeof(dq));
		case 40 .. 49: strcat(dq, "Odlicna", sizeof(dq));
	}
	return dq;
}

CMD:drug(playerid, params[]) // FindEmptyCarDrugSlot(vehicleid) << put/take
{
	new
		item[8],
		Float:damnt,
		slot,
		slot2,
		giveplayerid;

	new
			dcode,
			dq;

	if(sscanf(params, "s[8] ", item))
	{
		SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug [opcija]");
		SendClientMessage(playerid, COLOR_WHITE, "[OPCIJE]: give, view, use, put, take, vehinfo, combine, taste, plant"); //taste//view//use//vehinfo//combine

		return 0;
	}
	if(!strcmp(item, "give", true))
	{
		if(sscanf(params, "s[8]udf", item, giveplayerid, slot, damnt))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug give [playerid] [slot] [kolicina]");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid) && !Bit1_Get(gr_PlayerLoggedIn, giveplayerid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilan ID igraca!");

		if(slot > 5 || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug give playerid [1 - 5] [0 - %d]", MAX_DRUG_AMOUNT);

		--slot;

		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");

		if(damnt < 0 || damnt > MAX_DRUG_AMOUNT)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dobar meme, steta sta ovo nije benzinska.");

		if((PlayerDrugs[playerid][dAmount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");

		dcode = PlayerDrugs[playerid][dCode][slot],
		dq = PlayerDrugs[playerid][dEffect][slot];

		if(GivePlayerDrug(giveplayerid, dcode, damnt, dq) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Igrac nema praznih drug slotova!");

		PlayerDrugs[playerid][dAmount][slot] -= damnt;

		if(PlayerDrugs[playerid][dAmount][slot] == 0)
			DeletePlayerDrug(playerid, slot);

		Log_Write("logfiles/cmd_druggive.txt", "(%s) %s{%d} je dao igracu %s{%d} drogu %s kolicine %.2f %s i kvalitete %s[%d]!",
			ReturnDate(),
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			GetName(giveplayerid),
			PlayerInfo[giveplayerid][pSQLID],
			drugs[dcode][dName],
			damnt,
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"),
			ReturnDrugQuality(dq),
			dq
		);

		return 1;
	}
	else if(!strcmp(item, "put", true))
	{
		if(sscanf(params, "s[8]df", item, slot, damnt))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug put [slot] [kolicina]");
			return 1;
		}

		new
			vehid;

		if((vehid = GetPlayerVehicleID(playerid)) == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi u vozilu!");

		if(!Iter_Contains(COVehicles, vehid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nije CO vozilo!");

		printf("VEHID%d PUT", vehid);

		if(slot > 5 || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug put [1 - 5] [0 - %d]", MAX_DRUG_AMOUNT);

		--slot;

		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");

		if(damnt < 0 || damnt > MAX_DRUG_AMOUNT || damnt > PlayerDrugs[playerid][dAmount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dobar meme, steta sta ovo nije benzinska.");

		if((PlayerDrugs[playerid][dAmount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");

		dcode = PlayerDrugs[playerid][dCode][slot],
		dq = PlayerDrugs[playerid][dEffect][slot];

		if(GiveVehicleDrug(vehid, dcode, damnt, dq) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nema praznih drug slotova!");

		PlayerDrugs[playerid][dAmount][slot] -= damnt;

		if(PlayerDrugs[playerid][dAmount][slot] <= 0)
			DeletePlayerDrug(playerid, slot);

		Log_Write("logfiles/cmd_drugput.txt", "(%s) %s{%d} je stavio u vozilo {%d} drogu %s kolicine %.2f %s i kvalitete %s[%d]!",
			ReturnDate(),
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			VehicleInfo[vehid][vSQLID],
			drugs[dcode][dName],
			damnt,
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"),
			ReturnDrugQuality(dq),
			dq
		);

		return 1;
	}
	/*
	VehicleDrugs[vehicleid][sqlid][emptyslot] = 99999;
	VehicleDrugs[vehicleid][type][emptyslot] = type;
	VehicleDrugs[vehicleid][damnt][emptyslot] = damnt;
	VehicleDrugs[vehicleid][quality][emptyslot] = quality;
	VehicleDrugs[vehicleid][timestamp][emptyslot] = gettime();
	*/
	else if(!strcmp(item, "take", true))
	{
		if(sscanf(params, "s[8]df", item, slot, damnt))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug take [slot] [kolicina]");
			return 1;
		}

		new
			vehid;

		if((vehid = GetPlayerVehicleID(playerid)) == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi u vozilu!");

		if(!Iter_Contains(COVehicles, vehid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nije CO vozilo!");

		printf("VEHID%d PUT", vehid);

		if(slot > MAX_VEHICLE_DRUGS || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug put [1 - %d] [0 - %d]", MAX_VEHICLE_DRUGS, MAX_DRUG_AMOUNT);

		--slot;

		if(VehicleDrugs[vehid][amount][slot] == 0) // car drugs
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot je prazan! Koristi /drug vehinfo.");

		if(damnt <= 0 || damnt > MAX_DRUG_AMOUNT || damnt > VehicleDrugs[vehid][amount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dobar meme, steta sta ovo nije benzinska.");

		if((VehicleDrugs[vehid][amount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");


		dcode = VehicleDrugs[vehid][type][slot],
		dq = VehicleDrugs[vehid][quality][slot];

		if(GivePlayerDrug(playerid, dcode, damnt, dq) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas praznih drug slotova!");

		VehicleDrugs[vehid][amount][slot] -= damnt;

		if(VehicleDrugs[vehid][amount][slot] <= 0)
			DeleteVehicleDrug(vehid, slot);

		Log_Write("logfiles/cmd_drugput.txt", "(%s) %s{%d} je uzeo iz vozila {%d} drogu %s kolicine %.2f %s i kvalitete %s[%d]!",
			ReturnDate(),
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			VehicleInfo[vehid][vSQLID],
			drugs[dcode][dName],
			damnt,
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"),
			ReturnDrugQuality(dq),
			dq
		);

		return 1;
	}
	else if(!strcmp(item, "taste", true))
	{
		if(sscanf(params, "s[8]d", item, slot))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug taste [slot]");
			return 1;
		}
		if(slot > 5 || slot < 1)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug taste [1 - 5]");

		--slot;

		new
			druq[6];

		switch(PlayerDrugs[playerid][dEffect][slot])
		{
			case 0 .. 9: strcat(druq, "Vrlo Losa", sizeof(druq));
			case 10 .. 19: strcat(druq, "Losa", sizeof(druq));
			case 20 .. 29: strcat(druq, "Dobra", sizeof(druq));
			case 30 .. 39: strcat(druq, "Vrlo Dobra", sizeof(druq));
			case 40 .. 49: strcat(druq, "Odlicna", sizeof(druq));
		}
		va_SendClientMessage(playerid, COLOR_GREEN, "Kvaliteta droge %s u slotu %d je %s!", drugs[PlayerDrugs[playerid][dCode][slot]][dName], slot+1, druq);
		return 1;
	}
	else if(!strcmp(item, "view", true))
	{
		ListPlayerDrugs(playerid, playerid);
		return 1;
	}
	else if(!strcmp(item, "use", true))
	{
		if(PlayerInfo[playerid][pDrugSeconds] != 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možete još koristiti drogu!");

		if(sscanf(params, "s[8]if", item, slot, damnt))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug use [slot] [kolicina]");
			return 1;
		}
		if(slot > 5 || slot < 1)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug use [1 - 5] [kolicina]");

		--slot;

		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");

		new
			//drugeffect,
			//time,
			drugQ = PlayerDrugs[playerid][dEffect][slot],
			dtyp = PlayerDrugs[playerid][dCode][slot];

		if(damnt > PlayerDrugs[playerid][dAmount][slot])
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate toliko droge! U slotu: %d imate %s[%.2f %s]", slot+1, drugs[PlayerDrugs[playerid][dCode][slot]][dName], PlayerDrugs[playerid][dAmount][slot], (drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] < 4) ? ("grama") : ("tableta"));

		new
			Float:limit = 0.0;

		if(drugs[dtyp][dEffect] == DRUG_TYPE_TABLET)
			limit = 1;
		else
			limit = 0.3;

		if(damnt > limit)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možete toliko droge koristiti! Predozirat æete se!");

		if(damnt < 0.1)
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možete koristiti manje od 0.1 %s!", (drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] < 4) ? ("grama") : ("tablete"));

		time = CalculatePayDayTime(dtyp, drugQ); //drugs[dtyp][dPayDayT];

		SendMessage(playerid, MESSAGE_TYPE_INFO, "[INFO]: Obavezno RP-ajte efekte i koristenje droge kako ne bi dobili kaznu od admina.");
		SetPlayerTime(playerid, 12, 0);

		switch(drugs[dtyp][dEffect])
		{
			case DRUG_TYPE_SMOKE:
			{
				ApplyAnimation(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0, 1);
				SetPlayerSpecialAction(playerid,21);
				SetPlayerDrunkLevel(playerid, 10000);

				if(PlayerInfo[playerid][pHunger] < 4.5)
					PlayerInfo[playerid][pHunger] += 0.5;
				else
					PlayerInfo[playerid][pHunger] = 5.0;

				SetPlayerWeather(playerid, -66);
			}
			case DRUG_TYPE_SNORT:
			{
				SetPlayerDrunkLevel(playerid, 20000);
				SetPlayerWeather(playerid, 1998);
			}
			case DRUG_TYPE_INJECT:
			{
				SetPlayerWeather(playerid, 1765);
				SetPlayerDrunkLevel(playerid, 50000);
			}
			case DRUG_TYPE_TABLET:
			{
				SetPlayerDrunkLevel(playerid, 12000);
				SetPlayerWeather(playerid, 1724);
			}
			case 0:
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
		}

		GivePlayerHealth(playerid, float(time));

		// debug
		va_SendClientMessage(playerid, COLOR_YELLOW, "Iskoristili ste %.2f grama/tableta droge %s te ste oduzeli %d minuta sa payday vremena, %d hp-a i možete opet koristit za %d minuta.", damnt, drugs[dtyp][dName], time, time, drugs[dtyp][dUseTime]);
		va_SendClientMessage(playerid, COLOR_YELLOW, "Droga je imala %d kvalitetu!", ReturnDrugQuality(drugQ));
		//

		PlayerDrugs[playerid][dAmount][slot] -= damnt;

		if(PlayerDrugs[playerid][dAmount][slot] == 0)
			DeletePlayerDrug(playerid, slot);

		//PlayerInfo[playerid][pDrugUsed] = dtyp;
		//PlayerInfo[playerid][pDrugSeconds] = drugs[dtyp][dUseTime];

		//PlayerInfo[playerid][pDrugUses] ++;
		//PlayerInfo[playerid][pLastDrug] = dtyp;
	}
	else if(!strcmp(item, "vehinfo", true))
	{
		vehicleid = GetPlayerVehicleID(playerid);

		if(!IsPlayerInAnyVehicle(playerid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar vozila!");

		if(!Iter_Contains(COVehicles, vehicleid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u privatnome vozilu!");

		ListVehicleDrugs(playerid, vehicleid);
		return 1;
	}
	else if(!strcmp(item, "combine", true))
	{
		if(sscanf(params, "s[8]ddf", item, slot, slot2, damnt))
		{
			SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /drug combine [slot] [sa slotom] [kolicina]");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Kombiniranjem droge upropaštavate kvalitetu iste za veæu kolièinu.");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Prvi slot vam je slot iz kojeg cete prebaciti drogu.");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Nakon prebacivanja koristi /drug taste kako bi vidio kvalitetu droge!");
			SendClientMessage(playerid, COLOR_RED, "[TIP]: Kombiniranjem postoji rizik da skroz uništite drogu!");
			return 1;
		}
		if((slot > 5 || slot < 1) || (slot2 > 5 || slot2 < 1))
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug combine [1 - 5] [1 - 5] [kolicina]");

		--slot;
		--slot2;

		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");

		if(PlayerDrugs[playerid][dCode][slot2] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Slot u koji želite prebacit drogu je prazan!");

		if(PlayerDrugs[playerid][dCode][slot] != PlayerDrugs[playerid][dCode][slot2])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete spojiti %s sa %s!", drugs[PlayerDrugs[playerid][dCode][slot]][dName], drugs[PlayerDrugs[playerid][dCode][slot2]][dName]);

		if(damnt < 0 || damnt > PlayerDrugs[playerid][dAmount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemaš tolko droge u tom slotu!");

		if((PlayerDrugs[playerid][dAmount][slot2] + damnt) > MAX_DRUG_AMOUNT)
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozes imati toliko droge u jednom slotu! Možeš imat maksimalno %d u jednom slotu!", MAX_DRUG_AMOUNT);

		if(PlayerDrugs[playerid][dEffect][slot] != PlayerDrugs[playerid][dEffect][slot2])
		{
			if(PlayerDrugs[playerid][dEffect][slot2] > 1)
			{
				if(damnt < PlayerDrugs[playerid][dEffect][slot2])
					PlayerDrugs[playerid][dEffect][slot2] -= damnt;
				else
				{
					if(PlayerDrugs[playerid][dEffect][slot] > 1)
						PlayerDrugs[playerid][dEffect][slot2] = PlayerDrugs[playerid][dEffect][slot] - 1;
					else
						PlayerDrugs[playerid][dEffect][slot2] = 0;
				}
			}
			else
				PlayerDrugs[playerid][dEffect][slot2] = 0;
		}

		if(PlayerDrugs[playerid][dEffect][slot2] <= 0)
		{
			SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Kombiniranjem droge si upropastio istu!");

			if((PlayerDrugs[playerid][dAmount][slot] - damnt) <= 0)
				DeletePlayerDrug(playerid, slot);
			else
				PlayerDrugs[playerid][dAmount][slot] -= damnt;

			DeletePlayerDrug(playerid, slot2);
			return 1;
		}

		va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Pomjesao si %d %s droge %s i sad imaš %.2f %s u slotu %d!",
			damnt,
			(drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] < 4) ? ("grama") : ("tablete"),
			drugs[PlayerDrugs[playerid][dCode][slot]][dName],
			PlayerDrugs[playerid][dAmount][slot2] + damnt,
			(drugs[PlayerDrugs[playerid][dCode][slot2]][dEffect] < 4) ? ("grama") : ("tableta"),
			slot2+1
		);

		PlayerDrugs[playerid][dAmount][slot] -= damnt;
		PlayerDrugs[playerid][dAmount][slot2] += damnt;

		if(PlayerDrugs[playerid][dAmount][slot] <= 0)
			DeletePlayerDrug(playerid, slot);

		return 1;
	}
	return 1;
}

CalculatePayDayTime(dtyp, drugQ, amount)
{
	new
		paydayT = drugs[dtyp][dPayDayT],
		result;

	if(amount >= 0.25)
	{
		switch(drugQ)
		{
			case 0 .. 9: result = paydayT - 7;
			case 10 .. 19: result = paydayT - 6;
			case 20 .. 29: result = paydayT - 4;
			case 30 .. 39: result = paydayT - 2;
			case 40 .. 49: result = paydayT;
		}
	}
	else
	{
		switch(drugQ)
		{
			case 0 .. 9: result = paydayT - 9;
			case 10 .. 19: result = paydayT - 7;
			case 20 .. 29: result = paydayT - 6;
			case 30 .. 39: result = paydayT - 5;
			case 40 .. 49: result = paydayT - 4;
		}
	}

	if(result <= 0)
		result = 0;

	return result;
}

DeletePlayerDrug(playerid, slot = -1) // pripazi kako koristis, slot -1 znaci da ce obrisat komplet drogu igracu
{
	if(slot > MAX_PLAYER_DRUGS || slot < -1)
		return 0;

	new
		sqlstring[70];

	if(slot == -1)
	{
		mysql_format(g_SQL, sqlstring, sizeof(sqlstring), "DELETE FROM `player_drugs` WHERE `player_id` = '%d'", PlayerInfo[playerid][pSQLID]);
		mysql_tquery(g_SQL, sqlstring, "", "");

		for(new d = 0; d != MAX_PLAYER_DRUGS; ++d)
		{
			PlayerDrugs[playerid][dSQLID][d] = -1;
			PlayerDrugs[playerid][dCode][d] = 0;
			PlayerDrugs[playerid][dAmount][d] = 0;
			PlayerDrugs[playerid][dEffect][d] = 0;
			PlayerDrugs[playerid][dTimeStamp][d] = 0;
		}
	}
	else
	{
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return 0;

		mysql_format(g_SQL, sqlstring, sizeof(sqlstring), "DELETE FROM `player_drugs` WHERE `id` = '%d'", PlayerDrugs[playerid][dSQLID][slot]);
		mysql_tquery(g_SQL, sqlstring, "", "");

		PlayerDrugs[playerid][dSQLID][slot] = -1;
		PlayerDrugs[playerid][dCode][slot] = 0;
		PlayerDrugs[playerid][dAmount][slot] = 0;
		PlayerDrugs[playerid][dEffect][slot] = 0;
		PlayerDrugs[playerid][dTimeStamp][slot] = 0;
	}
	return 1;
}

FindEmptyCarDrugSlot(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID || VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE)
		return -2;

	for(new s = 0; s < MAX_VEHICLE_DRUGS; ++s)
	{
		if(VehicleDrugs[vehicleid][type][s] == 0)
			return s;
	}
	return -1;
}

FindEmptyDrugSlot(playerid)
{
	if(playerid == INVALID_PLAYER_ID)
		return -2;

	for(new s = 0; s >= MAX_PLAYER_DRUGS; ++s)
	{
		if(PlayerDrugs[playerid][dCode][s] == 0)
			return s;
	}
	return -1;
}

CMD:agivedrug(playerid, params[])
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi Admin!");

	new
		giveplayerid,
		drug,
		amnt,
		quality;

	if(sscanf(params, "udfd", giveplayerid, drug, amnt, quality))
	{
		new
			drugsall[256],
			dline[76];

		for(new i = 0; i != sizeof(drugs); ++i)
		{
			format(dline, sizeof(dline), "%d) %s ", drugs[i][dName]);
			strcat(drugsall, dline, sizeof(drugsall));
		}
		SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /agivedrug [id/ime igraca] [id droge] [kolicina] [kvaliteta]");
		va_SendClientMessage(playerid, COLOR_WHITE, "DROGE: %s", drugsall);
		SendClientMessage(playerid, COLOR_WHITE, "KVALITETA: 1 - 9 VRLO LOSA, 10 - 19 LOSA, 20 - 29 DOBRA, 30 - 39 VRLO DOBRA, 40 - 49 ODLICNA");
		return 1;
	}
	if(giveplayerid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Neispravan ID igraca!");

	if(GivePlayerDrug(playerid, drug, amount, quality) == -1)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Igrac nema praznih drug slotova!");

	va_SendClientMessage(playerid, COLOR_YELLOW, "[!] Dao si %s[%d] %s kolicine %d i kvalitete %s[%d]!", GetName(giveplayerid), giveplayerid, drugs[drug][dName], amnt, ReturnDrugQuality(quality), quality);
	Log_Write("logfiles/adm_givedrug.txt", "(%s) Admin %s je dao igracu %s drogu %s kolicine %.2f i kvalitete %s[%d]!", ReturnDate(), GetName(playerid), GetName(giveplayerid), drugs[drug][dName], amnt, ReturnDrugQuality(quality), quality);

	return 1;
}

GivePlayerDrug(playerid, type, Float:amount, quality)
{
	if(playerid == INVALID_PLAYER_ID)
		return 0;

	new
		emptyslot = FindEmptyDrugSlot(playerid);

	if(emptyslot == -1)
		return -1;

	PlayerDrugs[playerid][dSQLID][emptyslot] = 99999;
	PlayerDrugs[playerid][dCode][emptyslot] = type;
	PlayerDrugs[playerid][dAmount][emptyslot] = amount;
	PlayerDrugs[playerid][dEffect][emptyslot] = quality;
	PlayerDrugs[playerid][dTimeStamp][emptyslot] = gettime();

	new
		drugsql[250];

	mysql_format(g_SQL, drugsql, sizeof(drugsql), "INSERT INTO `player_drugs` (`player_id`, `code`, `amount`, `effect`, `timestamp`) VALUES ('%d', '%d', '%.2f', '%d', '%d')",
		PlayerInfo[playerid][pSQLID],
		type,
		amount,
		quality,
		gettime()
	);
	mysql_tquery(g_SQL, "GetDrugSQLID", "dd", playerid, emptyslot);

	return emptyslot;
}

/*
enum e_V_DRUGS
{
	sqlid[MAX_VEHICLE_DRUGS],
	type[MAX_VEHICLE_DRUGS],
	amount[[MAX_VEHICLE_DRUGS],
	quality[MAX_VEHICLE_DRUGS],
	timestamp[MAX_VEHICLE_DRUGS]
}

new
	VehicleDrugs[MAX_VEHICLES][e_V_DRUGS];
*/

GiveVehicleDrug(vehicleid, type, Float:amount, quality)
{
	if(vehicleid == INVALID_PLAYER_ID)
		return 0;

	new
		emptyslot = FindEmptyCarDrugSlot(vehicleid);

	if(emptyslot == -1)
		return -1;

	VehicleDrugs[vehicleid][sqlid][emptyslot] = 99999;
	VehicleDrugs[vehicleid][type][emptyslot] = type;
	VehicleDrugs[vehicleid][amount][emptyslot] = amount;
	VehicleDrugs[vehicleid][quality][emptyslot] = quality;
	VehicleDrugs[vehicleid][timestamp][emptyslot] = gettime();

	new
		drugsql[250];

	mysql_format(g_SQL, drugsql, sizeof(drugsql), "INSERT INTO `cocars_drugs` (`vehicle_id`, `code`, `amount`, `quality`, `timestamp`) VALUES ('%d', '%d', '%.2f', '%d', '%d')",
		VehicleInfo[vehicleid][vSQLID],
		type,
		amount,
		quality,
		gettime()
	);
	mysql_tquery(g_SQL, "GetDrugSQLID", "ddd", vehicleid, emptyslot, 1);

	return emptyslot;
}

DeleteVehicleDrug(vehicleid, slot = -1) // pripazi kako koristis, slot -1 znaci da ce obrisat komplet drogu u tom vozilu
{
	if(slot > MAX_VEHICLE_DRUGS || slot < -1)
		return 0;

	new
		sqlstring[70];

	if(slot == -1)
	{
		mysql_format(g_SQL, sqlstring, sizeof(sqlstring), "DELETE FROM `cocars_drugs` WHERE `vehicle_id` = '%d'", VehicleInfo[vehicleid][vSQLID]);
		mysql_tquery(g_SQL, sqlstring, "", "");

		ResetVehicleDrugs(vehicleid);
	}
	else
	{
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return 0;

		mysql_format(g_SQL, sqlstring, sizeof(sqlstring), "DELETE FROM `player_drugs` WHERE `id` = '%d'", PlayerDrugs[playerid][dSQLID][slot]);
		mysql_tquery(g_SQL, sqlstring, "", "");

		PlayerDrugs[playerid][dSQLID][slot] = -1;
		PlayerDrugs[playerid][dCode][slot] = 0;
		PlayerDrugs[playerid][dAmount][slot] = 0;
		PlayerDrugs[playerid][dEffect][slot] = 0;
		PlayerDrugs[playerid][dTimeStamp][slot] = 0;
	}
	return 1;
}

forward GetDrugSQLID(playerid, emptyslot, type = 0);
public GetDrugSQLID(playerid, emptyslot, type = 0)
{
	if(type == 1)
		VehicleDrugs[playerid][sqlid][emptyslot] = cache_insert_id();
	else
		PlayerDrugs[playerid][dSQLID][emptyslot] = cache_insert_id();

	return 1;
}

/*
enum E_DRUG_DATA
{
	dSQLID[5],
	dType[5],//dCode[5],
	dAmount[5],//Float:dAmount[5],
	dQuality[5],//dEffect[5],
	dTimeStamp[5]
}
new
	PlayerDrugs[MAX_PLAYERS][E_DRUG_DATA];

*/

/*
	pDrugUsed,
	pDrugSeconds,
	pDrugUses,
	pLastDrug,*/

