#include <YSI_Coding\y_hooks>

/*
	############################
	#		Drug System 	   #
	#	  Ver: Early Alpha	   #
	#	   Made by Runner      #
	#						   #
	# 		 Thanks to: 	   #
	#		  Khawaja,		   #
	#		   Logan 	   	   #
	############################
*/


/*
Weathers:

1897 - zbugana grafika

*/

static const
	Float:bag[][3] =
{
	{257.16684, 2883.21582, 12.73737},
	{-426.03671, 2192.42554, 41.79201},
	{-1303.73523, 2506.78735, 86.58372},
	{-485.01361, 130.93065, 12.44418},
	{-363.89691, -1482.43652, 25.22663}
};

enum e_V_DRUGS
{
	vsqlid[MAX_VEHICLE_DRUGS],
	vtype[MAX_VEHICLE_DRUGS],
	Float:vamount[MAX_VEHICLE_DRUGS],
	Float:vquality[MAX_VEHICLE_DRUGS],
}

new
	VehicleDrugs[MAX_VEHICLES][e_V_DRUGS];
	
	
enum pckg_Drugs
{	
	pcDrug,
	pcAmnt,
	pPrice,
	pobjID,
	cpID,
	orderfinished,
	Float:Xp,
	Float:Yp,
	Float:Zp
}

new
	DrugPackage[MAX_PLAYERS][pckg_Drugs];
	

hook function ResetPlayerVariables(playerid)
{
	ResetPlayerDrugs(playerid);
	PlayerDrugStatus[playerid][pDrugUsed] = 0;
    PlayerDrugStatus[playerid][pDrugSeconds] = 0;
    PlayerDrugStatus[playerid][pDrugOrder] = 0;
	return continue(playerid);
}

hook function ResetPrivateVehicleInfo(vehicleid)
{
	ResetVehicleDrugs(vehicleid);
	return continue(vehicleid);
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(DrugPackage[playerid][pcDrug] != 0)
	{
		if(DrugPackage[playerid][orderfinished])
		{
			IllegalBudgetToPlayerMoney(playerid, DrugPackage[playerid][pPrice]);
			#if defined MODULE_LOGS
			Log_Write("logfiles/drug_order.txt", "(%s) %s{%d} exited the game and didn't pick up ordered drugs, and he got refunded %d$!",
				ReturnDate(), 
				GetName(playerid),
				PlayerInfo[playerid][pSQLID],
				DrugPackage[playerid][pPrice]
			);
			#endif
		}
		ClearDrugOrder(playerid);
	}
	return 1;
}
	
Public:LoadVehicleDrugs(vehicleid)
{	
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM cocars_drugs WHERE vehicle_id = '%d'", VehicleInfo[vehicleid][vSQLID]), 
		"LoadingVehicleDrugs", 
		"i", 
		vehicleid
	);
	return 1;
}

forward LoadingVehicleDrugs(vehicleid);
public LoadingVehicleDrugs(vehicleid)
{
	if(cache_num_rows()) 
	{
	    for(new i = 0; i < cache_num_rows(); i++) 
		{
			cache_get_value_name_int(i, "id", VehicleDrugs[vehicleid][vsqlid][i]);
			cache_get_value_name_int(i, "code", VehicleDrugs[vehicleid][vtype][i]);
			cache_get_value_name_float(i, "amount", VehicleDrugs[vehicleid][vamount][i]); 
			cache_get_value_name_float(i, "quality", VehicleDrugs[vehicleid][vquality][i]);
		}
	}
	return 1;
}

LoadPlayerDrugs(playerid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM player_drugs WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]), 
		"LoadingPlayerDrugs", 
		"i", 
		playerid
	);
	return 1;
}

forward LoadingPlayerDrugs(playerid);
public LoadingPlayerDrugs(playerid)
{
	new
		numrows = cache_num_rows();
	
	if(numrows) 
	{
	    for(new i = 0; i < numrows; i++) 
		{
			cache_get_value_name_int(i, "id", PlayerDrugs[playerid][dSQLID][i]);
			cache_get_value_name_int(i, "code", PlayerDrugs[playerid][dCode][i]);
			cache_get_value_name_float(i, "amount", PlayerDrugs[playerid][dAmount][i]); 
			cache_get_value_name_float(i, "effect", PlayerDrugs[playerid][dEffect][i]);
			cache_get_value_name_int(i, "timestamp", PlayerDrugs[playerid][dTimeStamp][i]);
			
			//if((gettime() - PlayerDrugs[playerid][dTimeStamp][i]) > 86400)
			//	PlayerDrugs[playerid][dEffect][i] -= 10.0
			
			if(PlayerDrugs[playerid][dEffect][i] < 1.0 || PlayerDrugs[playerid][dAmount][i] < 0.01)
				DeletePlayerDrug(playerid, i);
		}
	}
	return 1;
}

LoadPlayerDrugStats(playerid)
{
	inline LoadingPlayerDrugStats()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO player_drug_stats(sqlid, drugused, drugseconds, drugorder) \n\
					VALUES ('%d', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name_int(0, "drugused"		, PlayerDrugStatus[playerid][pDrugUsed]);
		cache_get_value_name_int(0, "drugseconds"	, PlayerDrugStatus[playerid][pDrugSeconds]);
		cache_get_value_name_int(0, "drugorder"		, PlayerDrugStatus[playerid][pDrugOrder]);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline LoadingPlayerDrugStats, 
		va_fquery(g_SQL, "SELECT * FROM player_drug_stats WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
		"i", 
		playerid
	);
	return 1;
}

hook function LoadPlayerStats(playerid)
{
	LoadPlayerDrugs(playerid);
	LoadPlayerDrugStats(playerid);
	return continue(playerid);
}

SavePlayerDrugStats(playerid)
{
	mysql_fquery_ex(g_SQL, 
		"UPDATE player_drug_stats SET drugused = '%d', drugseconds = '%d', drugorder = '%d' \n\
			WHERE sqlid = '%d'",
		PlayerDrugStatus[playerid][pDrugUsed],
        PlayerDrugStatus[playerid][pDrugSeconds],
        PlayerDrugStatus[playerid][pDrugOrder],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

hook function SavePlayerStats(playerid)
{
	SavePlayerDrugStats(playerid);
	return continue(playerid);
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
		drugall[274],
		titled[MAX_PLAYER_NAME + 10],
		d = 0;
		
	for(new s = 0; s < MAX_PLAYER_DRUGS; ++s)
	{
		if(PlayerDrugs[owner][dCode][s] != 0)
		{
			format(dstring, sizeof(dstring), "%sSLOT %d: %s [%.2f %s]", (!d) ? ("") : ("\n"), s+1, drugs[PlayerDrugs[owner][dCode][s]][dName], PlayerDrugs[owner][dAmount][s], (drugs[PlayerDrugs[owner][dCode][s]][dEffect] < 4) ? ("grama") : ("tableta"));

			strcat(drugall, dstring, sizeof(drugall));
			
			++d;
		}
	}
	
	if(!d && playerid == owner)
		return SendClientMessage(playerid, COLOR_RED, "Nemas droge!");
	else if(!d && playerid != owner)
		return SendClientMessage(playerid, COLOR_RED, "Igrac nema droge!");
		
	format(titled, 37, "Droga od %s", GetName(owner));
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, titled, drugall, "Exit", "");
	
	return 1;
}

ListVehicleDrugs(playerid, vehicleid)
{
	new
		dstring[79],
		drugall[79 * 10],
		titled[MAX_PLAYER_NAME + 10],
		y = 0;
		
	for(new d = 0; d < MAX_VEHICLE_DRUGS; ++d)
	{
		if(VehicleDrugs[vehicleid][vtype][d] != 0)
		{
			format(dstring, sizeof(dstring), "%sSLOT %d: %s [%.2f %s]", (!y) ? ("") : ("\n"), d+1, drugs[VehicleDrugs[vehicleid][vtype][d]][dName], VehicleDrugs[vehicleid][vamount][d], (drugs[VehicleDrugs[vehicleid][vtype][d]][dEffect] < 4) ? ("grama") : ("tableta"));
		
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
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, titled, drugall, "Exit", "");
	return 1;
}

ReturnDrugQuality(Float:dqf)
{
	new
		dq[11];

	if(dqf >= 1.0 && dqf <= 9.9)
		strcpy(dq, "Vrlo Losa", sizeof(dq));
	else if(dqf >= 10.0 && dqf <= 19.9)
		strcpy(dq, "Losa", sizeof(dq));
	else if(dqf >= 20.0 && dqf <= 29.9)
		strcpy(dq, "Dobra", sizeof(dq));
	else if(dqf >= 30.0 && dqf <= 39.9)
		strcpy(dq, "Vrlo Dobra", sizeof(dq));
	else if(dqf >= 40.0 && dqf <= 50.0)
		strcpy(dq, "Odlicna", sizeof(dq));
	
	return dq;
}

Float:CombineDrugQuality(Float:damount1, Float:damount2, Float:quality, Float:quality2) // Big thanks to Logan#3033! // dodana provjera ako je isti amount zato sta bi izbacio quality od prvog amounta
{
    new Float:formula = 0,
        Float:ratio = 0.0,
        Float:output;
	
    if(damount1 > damount2)
    {
        ratio = damount2 / damount1;
        formula = ratio * quality2 + (1 - ratio) * quality;
    }
    else if(damount1 < damount2)
    {
        ratio = damount1 / damount2;
        formula = ratio * quality + (1 - ratio) * quality2;
    }
	else if(damount1 == damount2)
	{
		formula = (quality + quality2) / 2;
	}
    output = formula;
    return output;
}

CMD:drug(playerid, params[])
{
	new
		item[8],
		Float:damnt,
		slot,
		slot2,
		giveplayerid;
		
	new
		dcode,
		Float:dq;

	if(sscanf(params, "s[8] ", item))
	{
		SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug [opcija]");
		SendClientMessage(playerid, COLOR_GREY, "[OPCIJE]: give, view, use, put, take, vehinfo, combine, taste");
		return 0;
	}
	if(!strcmp(item, "give", true))
	{
		if(sscanf(params, "s[8]udf", item, giveplayerid, slot, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug give [playerid][slot][kolicina]");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid) && !Bit1_Get(gr_PlayerLoggedIn, giveplayerid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilan ID igraca!");

		if(!ProxDetectorS(5.0, playerid, giveplayerid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");

		if(slot > 5 || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug give playerid [1 - 5][0 - %d]", MAX_DRUG_AMOUNT);
			
		if(giveplayerid == playerid)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozes dati drogu samome sebi!");
			
		--slot;
			
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
			
		if(drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] == DRUG_TYPE_TABLET)
		{
			if(damnt != floatround(damnt, floatround_floor))
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Tablete moraju biti bez decimalnog broja! npr 1.0, 2.0 ..");
		}
		
		if(damnt <= 0.1 || damnt > MAX_DRUG_AMOUNT)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");
				
		if((PlayerDrugs[playerid][dAmount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina");
		
		dcode = PlayerDrugs[playerid][dCode][slot],
		dq = PlayerDrugs[playerid][dEffect][slot];
			
		if(GivePlayerDrug(giveplayerid, dcode, damnt, dq) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Igrac nema praznih drug slotova!");
		
		PlayerDrugs[playerid][dAmount][slot] -= damnt;
				
		if(PlayerDrugs[playerid][dAmount][slot] < 0.01)
			DeletePlayerDrug(playerid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
			
		va_SendClientMessage(playerid, COLOR_YELLOW, "Dao si %.2f %s droge %s igracu %s!", damnt, (drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), drugs[dcode][dName], GetName(giveplayerid, false));
		va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "Igrac %s vam je dao %.2f %s droge %s!", GetName(playerid, false), damnt, (drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), drugs[dcode][dName]);
			
		ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0, 1, 0);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_give.txt", "(%s) %s{%d} gave %s{%d} drug %s(amount: %.2f %s) quality %s[%.3f] from slot %d!", 
			ReturnDate(), 
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			GetName(giveplayerid),
			PlayerInfo[giveplayerid][pSQLID],
			drugs[dcode][dName],
			damnt,
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), 
			ReturnDrugQuality(dq),
			dq,
			slot+1
		);
		#endif
		return 1;
	}
	else if(!strcmp(item, "put", true))
	{
		if(sscanf(params, "s[8]df", item, slot, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug put [slot][kolicina]");
			return 1;
		}
		
		new
			vehid;
		
		if((vehid = GetPlayerVehicleID(playerid)) == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi u vozilu!");
			
		if(!Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vehid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nije CO vozilo!");

		if(slot > 5 || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug put [1 - 5][0 - %d]", MAX_DRUG_AMOUNT);
			
		--slot;
			
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
			
		if(drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] == DRUG_TYPE_TABLET)
		{
			if(damnt != floatround(damnt, floatround_floor))
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Tablete moraju biti bez decimalnog broja! npr 1.0, 2.0 ..");
		}
			
		if(damnt < 0.1 || damnt > MAX_DRUG_AMOUNT || damnt > PlayerDrugs[playerid][dAmount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina");
				
		if((PlayerDrugs[playerid][dAmount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");
		
		dcode = PlayerDrugs[playerid][dCode][slot],
		dq = PlayerDrugs[playerid][dEffect][slot];
		
		new
			vdslot = -1;
		
		if((vdslot = GiveVehicleDrug(vehid, dcode, damnt, dq)) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nema praznih drug slotova!");
		
		PlayerDrugs[playerid][dAmount][slot] -= damnt;
				
		if(PlayerDrugs[playerid][dAmount][slot] < 0.01)
			DeletePlayerDrug(playerid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
			
		va_SendClientMessage(playerid, COLOR_YELLOW, "Stavio si %.2f %s droge %s u slot %d u vozilo %s!", damnt, (drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), drugs[dcode][dName], vdslot+1, ReturnVehicleName(GetVehicleModel(vehid)));
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_put.txt", "(%s) Player put %.2f %s of %s in slot %d of %s[SQLID: %d]!", 
			ReturnDate(),
			GetName(playerid, false),
			damnt, 
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), 
			drugs[dcode][dName], 
			vdslot+1, 
			ReturnVehicleName(GetVehicleModel(vehid)),
			VehicleInfo[vehid][vSQLID]
		);
		#endif
		return 1;
	}
	else if(!strcmp(item, "take", true))
	{
		if(sscanf(params, "s[8]df", item, slot, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug take [slot][kolicina]");
			return 1;
		}
		
		new
			vehid;
		
		if((vehid = GetPlayerVehicleID(playerid)) == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi u vozilu!");
			
		if(!Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vehid))
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Vozilo nije CO vozilo!");
			
		if(slot > MAX_VEHICLE_DRUGS || slot < 1)
			return va_SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug take [1 - %d][0 - %d]", MAX_VEHICLE_DRUGS, MAX_DRUG_AMOUNT);
			
		--slot;
			
		if(VehicleDrugs[vehid][vamount][slot] == 0) // car drugs
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot je prazan! Koristi /drug vehinfo.");
			
		if(drugs[VehicleDrugs[vehid][vtype][slot]][dEffect] == DRUG_TYPE_TABLET)
		{
			if(damnt != floatround(damnt, floatround_floor))
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Tablete moraju biti bez decimalnog broja! npr 1.0, 2.0 ..");
		}
			
		if(damnt <= 0.1 || damnt > MAX_DRUG_AMOUNT || damnt > VehicleDrugs[vehid][vamount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina");
				
		if((VehicleDrugs[vehid][vamount][slot] - damnt) < 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilna kolicina.");
		
		
		dcode = VehicleDrugs[vehid][vtype][slot],
		dq = VehicleDrugs[vehid][vquality][slot];
		
		if(GivePlayerDrug(playerid, dcode, damnt, dq) == -1)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas praznih drug slotova!");
		
		VehicleDrugs[vehid][vamount][slot] -= damnt;
				
		if(VehicleDrugs[vehid][vamount][slot] < 0.01)
			DeleteVehicleDrug(vehid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE cocars_drugs SET amount = '%f' WHERE id = '%d'", VehicleDrugs[vehid][vamount][slot], VehicleDrugs[vehid][vsqlid][slot]);
			
		va_SendClientMessage(playerid, COLOR_YELLOW, "Uzeo si %.2f %s droge %s iz slota %d iz vozila %s!", damnt, (drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), drugs[dcode][dName], slot+1, ReturnVehicleName(GetVehicleModel(vehid)));
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_take.txt", "(%s) Player took %.2f %s of %s from slot %d of %s[SQLID: %d]!", 
			ReturnDate(),
			GetName(playerid, false),
			damnt, 
			(drugs[dcode][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), 
			drugs[dcode][dName], 
			slot+1, 
			ReturnVehicleName(GetVehicleModel(vehid)),
			VehicleInfo[vehid][vSQLID]
		);
		#endif
		return 1;
	}
	else if(!strcmp(item, "taste", true))
	{
		if(sscanf(params, "s[8]d", item, slot)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug taste [slot]");
			return 1;
		}
		if(slot > 5 || slot < 1)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug taste [1 - 5]");
			
		--slot;
		
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot je prazan!");
		
		new
			Float:def = PlayerDrugs[playerid][dEffect][slot];
		
		va_SendClientMessage(playerid, COLOR_GREEN, "Kvaliteta droge %s u slotu %d je %s!", 
			drugs[PlayerDrugs[playerid][dCode][slot]][dName], 
			slot+1, 
			ReturnDrugQuality(def)
		);
		return 1;
	}
	else if(!strcmp(item, "view", true))
	{
		ListPlayerDrugs(playerid, playerid);
		return 1;
	}
	else if(!strcmp(item, "use", true))
	{
		if(PlayerDrugStatus[playerid][pDrugSeconds] != 0)
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete jos koristiti drogu! Pricekajte jos %d minuta.", PlayerDrugStatus[playerid][pDrugSeconds]);
        
		if(sscanf(params, "s[8]if", item, slot, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug use [slot][kolicina]");
			return 1;
		}
		if(slot > 5 || slot < 1)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug use [1 - 5][kolicina]");
			
		--slot;
		
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
			
		new
			Float:drugQ = PlayerDrugs[playerid][dEffect][slot],
			dtyp = PlayerDrugs[playerid][dCode][slot];
			
			
		if(damnt > PlayerDrugs[playerid][dAmount][slot])
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate toliko droge! U slotu: %d imate %s[%.2f %s]", slot+1, drugs[PlayerDrugs[playerid][dCode][slot]][dName], PlayerDrugs[playerid][dAmount][slot], (drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] < 4) ? ("grama") : ("tableta"));
		
		new
			Float:limit = 0.0,
			time = 0;
			
		if(drugs[dtyp][dEffect] == DRUG_TYPE_TABLET)
			limit = 1.0;
		else
			limit = 0.3;
		
		if(damnt > limit)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete toliko droge koristiti! Predozirat cete se!");
			
		if(drugs[dtyp][dEffect] != DRUG_TYPE_TABLET)
		{
			if(damnt < 0.1)
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete koristiti manje od 0.1 grama!");
		}
		else
		{
			if(damnt < 1.0)
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete koristiti manje od 1 tablete!");
		}
			
		time = CalculatePayDayTime(dtyp, drugQ, damnt);
		
		SendMessage(playerid, MESSAGE_TYPE_INFO, "[INFO]: Obavezno RP-ajte efekte i koristenje droge kako ne bi dobili kaznu od admina.");

		new
			Float:pHP = 0.0,
			Float:nHP = 0.0,
			Float:tarmour = 0.0;
		
		GetPlayerHealth(playerid, pHP);
		GetPlayerArmour(playerid, tarmour);
		
		switch(drugs[dtyp][dEffect])
		{
			case DRUG_TYPE_SMOKE:
			{
				if((pHP + 10.0) > 150.0)
					nHP = 150.0;
				else
					nHP = pHP + 10.0;
					
				SetPlayerHealth(playerid, nHP);
				
				ApplyAnimation(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0, 1);
				SetPlayerSpecialAction(playerid,21);
				
				PlayerHealth[playerid][pHunger] = 5.0;
			}
			case DRUG_TYPE_SNORT:
			{
				if((pHP + 20.0) > 150.0)
					nHP = 150.0;
				else
					nHP = pHP + 20.0;
					
				SetPlayerHealth(playerid, nHP);
				
				if(tarmour < 15.0)
					SetPlayerArmour(playerid, 15.0);
			}
			case DRUG_TYPE_INJECT:
			{
				if(tarmour < 25.0)
					SetPlayerArmour(playerid, 25.0);
			}
			case DRUG_TYPE_TABLET:
			{
				if((pHP + 30.0) > 150.0)
					nHP = 150.0;
				else
					nHP = pHP + 30.0;
					
				SetPlayerHealth(playerid, nHP);
			}
			case 0:
				return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
		}
		
		// debug
		va_SendClientMessage(playerid, COLOR_YELLOW, "Iskoristili ste %.2f %s droge %s te ste oduzeli %d minuta sa payday vremena, drogu mozete opet koristit za %d minuta!", damnt, (drugs[dtyp][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), drugs[dtyp][dName], time, drugs[dtyp][dUseTime]);
		//va_SendClientMessage(playerid, COLOR_YELLOW, "Droga je imala kvalitetu %s!", ReturnDrugQuality(drugQ)); // LuL
		//
		
		PlayerDrugs[playerid][dAmount][slot] -= damnt;
				
		if(PlayerDrugs[playerid][dAmount][slot] < 0.01)
			DeletePlayerDrug(playerid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
		
		PlayerDrugStatus[playerid][pDrugUsed] = dtyp;
		PlayerDrugStatus[playerid][pDrugSeconds] = drugs[dtyp][dUseTime];
		
		//PlayerInfo[playerid][pDrugUses] ++;
		//PlayerInfo[playerid][pLastDrug] = dtyp;
		
		PaydayInfo[playerid][pPayDay] += time;
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_use.txt", "(%s) %s{%d} used %.2f %s of %s from slot %d and shortened his payday by %d min. Quality: %.3f.", 
			ReturnDate(), 
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			damnt,
			(drugs[dtyp][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), 
			drugs[dtyp][dName],
			slot+1,
			time,
			drugQ
		);
		#endif
	}
	else if(!strcmp(item, "vehinfo", true))
	{
		new
			vid = GetPlayerVehicleID(playerid);

		if(!IsPlayerInAnyVehicle(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar vozila!");
		
		if(!Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u privatnome vozilu!");

		ListVehicleDrugs(playerid, vid);
		return 1;
	}
	else if(!strcmp(item, "combine", true))
	{
		if(sscanf(params, "s[8]ddf", item, slot, slot2, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug combine [slot][sa slotom][kolicina]");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Kombiniranjem droge mjenjate kvalitetu iste sa drogom koju dodajete.");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Prvi slot vam je slot iz kojeg cete prebaciti drogu.");
			SendClientMessage(playerid, COLOR_YELLOW, "[TIP]: Nakon prebacivanja koristi /drug taste kako bi vidio kvalitetu droge!");
			SendClientMessage(playerid, COLOR_RED, "[TIP]: Kombiniranjem postoji rizik da skroz unistite drogu!");
			return 1;
		}
		if((slot > 5 || slot < 1) || (slot2 > 5 || slot2 < 1))
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug combine [1 - 5][1 - 5][kolicina]");
			
		if(slot == slot2)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug combine [1 - 5][1 - 5][kolicina]");
			
		--slot;
		--slot2;
		
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
			
		if(PlayerDrugs[playerid][dCode][slot2] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Slot u koji zelite prebacit drogu je prazan!");
			
		if(PlayerDrugs[playerid][dCode][slot] != PlayerDrugs[playerid][dCode][slot2])
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozete spojiti %s sa %s!", drugs[PlayerDrugs[playerid][dCode][slot]][dName], drugs[PlayerDrugs[playerid][dCode][slot2]][dName]);
			
		if(damnt < 0.1 || damnt > PlayerDrugs[playerid][dAmount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas tolko droge u tom slotu!");

		if((PlayerDrugs[playerid][dAmount][slot2] + damnt) > MAX_DRUG_AMOUNT)
			return va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne mozes imati toliko droge u jednom slotu! Mozes imat maksimalno %d u jednom slotu!", MAX_DRUG_AMOUNT);

		if(PlayerDrugs[playerid][dEffect][slot] != PlayerDrugs[playerid][dEffect][slot2])
		{
			if(PlayerDrugs[playerid][dEffect][slot] > 1.0 && PlayerDrugs[playerid][dEffect][slot2] > 1.0)
			{
				new
					Float:getnewq = CombineDrugQuality(damnt, PlayerDrugs[playerid][dAmount][slot2], PlayerDrugs[playerid][dEffect][slot], PlayerDrugs[playerid][dEffect][slot2]);
			
				PlayerDrugs[playerid][dEffect][slot2] = getnewq;
			}
			else
				PlayerDrugs[playerid][dEffect][slot2] = 0;
		}
		
		dcode = PlayerDrugs[playerid][dCode][slot2];
		
		new
			dcode1 = PlayerDrugs[playerid][dCode][slot];
		
		if(PlayerDrugs[playerid][dEffect][slot2] <= 1.0)
		{
			SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Kombiniranjem droge si upropastio istu!");
			
			if((PlayerDrugs[playerid][dAmount][slot] - damnt) < 0.1)
				DeletePlayerDrug(playerid, slot);
			else
			{
				PlayerDrugs[playerid][dAmount][slot] -= damnt;
				mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
			}
			DeletePlayerDrug(playerid, slot2);
			return 1;
		}
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET effect = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dEffect][slot2], PlayerDrugs[playerid][dSQLID][slot2]);
		
		va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Pomjesao si %.2f %s droge %s i sad imaš %.2f %s u slotu %d!", 
			damnt, 
			(drugs[dcode1][dEffect] < 4) ? ("grama") : ("tablete"),
			drugs[dcode1][dName],
			PlayerDrugs[playerid][dAmount][slot2] + damnt,
			(drugs[PlayerDrugs[playerid][dCode][slot2]][dEffect] < 4) ? ("grama") : ("tableta"),
			slot2+1	
		);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_combine.txt", "(%s) %s{%d} combined %.2f %s of %s(quality: %.3f) from slot %d with %s from slot %d(quality: %.3f) and now has %.2f drugs in slot %d(quality: %.3f)!", 
			ReturnDate(), 
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			damnt,
			(drugs[PlayerDrugs[playerid][dCode][slot]][dEffect] == DRUG_TYPE_TABLET) ? ("tableta") : ("grama"), 
			drugs[PlayerDrugs[playerid][dCode][slot]][dName],
			PlayerDrugs[playerid][dEffect][slot],
			slot+1,
			drugs[dcode][dName],
			slot2+1,
			oldq,
			PlayerDrugs[playerid][dAmount][slot2] + damnt,
			slot2+1,
			PlayerDrugs[playerid][dEffect][slot2]
		);
		#endif
		
		PlayerDrugs[playerid][dAmount][slot] -= damnt;
		PlayerDrugs[playerid][dAmount][slot2] += damnt;
				
		if(PlayerDrugs[playerid][dAmount][slot] < 0.01)
			DeletePlayerDrug(playerid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
			
		mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot2], PlayerDrugs[playerid][dSQLID][slot2]);
		return 1;
	}
	else if(!strcmp(item, "drop", true)) // MapAndreas_FindZ_For2DCoord(Float:X, Float:Y, &Float:Z);//// COMMENTAJ TOKOM TESTA
	{
		if(sscanf(params, "s[8]if", item, slot, damnt)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /drug drop [slot][kolicina]");
			return 1;
		}
		
		if(slot > 5 || slot < 1)
			return SendClientMessage(playerid, COLOR_RED, "KORISTI: /drug use [1 - 5][kolicina]");
		
		--slot;
		
		if(PlayerDrugs[playerid][dCode][slot] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj slot vam je prazan!");
			
		if(damnt < 0.1 || damnt > PlayerDrugs[playerid][dAmount][slot])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemas tolko droge u tom slotu!");
		
			
		PlayerDrugs[playerid][dAmount][slot] -= damnt;
		
		dcode = PlayerDrugs[playerid][dCode][slot];
		
		va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Bacio si %.2f %s droge %s i sad imaš %.2f %s u slotu %d!", 
			damnt, 
			(drugs[dcode][dEffect] < 4) ? ("grama") : ("tablete"),
			drugs[dcode][dName],
			PlayerDrugs[playerid][dAmount][slot],
			(drugs[dcode][dEffect] < 4) ? ("grama") : ("tableta"),
			slot+1	
		);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/drug_drop.txt", "(%s) %s{%d} threw away %.2f %s of %s and now has %.2f %s in slot %d!",
			ReturnDate(), 
			GetName(playerid),
			PlayerInfo[playerid][pSQLID],
			damnt, 
			(drugs[dcode][dEffect] < 4) ? ("grama") : ("tablete"),
			drugs[dcode][dName],
			PlayerDrugs[playerid][dAmount][slot],
			(drugs[dcode][dEffect] < 4) ? ("grama") : ("tableta"),
			slot+1
		);
		#endif
		
		if(PlayerDrugs[playerid][dAmount][slot] < 0.01)
			DeletePlayerDrug(playerid, slot);
		else
			mysql_fquery(g_SQL, "UPDATE player_drugs SET amount = '%f' WHERE id = '%d'", PlayerDrugs[playerid][dAmount][slot], PlayerDrugs[playerid][dSQLID][slot]);
		
		return 1;
	}
	return 1;
}

static CalculatePayDayTime(dtyp, Float:drugQ, Float:camnt)
{
	new
		paydayT = drugs[dtyp][dPayDayT],
		result;
	
	if(camnt >= 0.25 && drugs[dtyp][dEffect] != DRUG_TYPE_TABLET)
	{
		if(drugQ >= 1.0 && drugQ <= 9.9)
			result = paydayT - 7;
		else if(drugQ >= 10.0 && drugQ <= 19.9)
			result = paydayT - 6;
		else if(drugQ >= 20.0 && drugQ <= 29.9)
			result = paydayT - 4;
		else if(drugQ >= 30.0 && drugQ <= 39.9)
			result = paydayT - 2;
		else if(drugQ >= 40.0 && drugQ <= 50.0)
			result = paydayT;
	}
	else
	{
		if(drugQ >= 1.0 && drugQ <= 9.9)
			result = paydayT - 9;
		else if(drugQ >= 10.0 && drugQ <= 19.9)
			result = paydayT - 7;
		else if(drugQ >= 20.0 && drugQ <= 29.9)
			result = paydayT - 6;
		else if(drugQ >= 30.0 && drugQ <= 39.9)
			result = paydayT - 5;
		else if(drugQ >= 40.0 && drugQ <= 50.0)
			result = paydayT - 4;
	}
	
	if(result <= 0)
		result = 2;
	
	return result;
}

DeletePlayerDrug(playerid, slot = -1) // pripazi kako koristis, slot -1 znaci da ce obrisat komplet drogu igracu
{
	if(slot > MAX_PLAYER_DRUGS || slot < -1)
		return 0;
	
	if(slot == -1)
	{
		mysql_fquery(g_SQL, "DELETE FROM player_drugs WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]);

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
			
		mysql_fquery(g_SQL, "DELETE FROM player_drugs WHERE id = '%d'", PlayerDrugs[playerid][dSQLID][slot]);
				
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
		if(VehicleDrugs[vehicleid][vtype][s] == 0)
			return s;
	}
	return -1;
}

FindEmptyDrugSlot(playerid)
{
	if(playerid == INVALID_PLAYER_ID)
		return -2;
		
	for(new s = 0; s < MAX_PLAYER_DRUGS; ++s)
	{
		if(PlayerDrugs[playerid][dCode][s] == 0)
			return s;
	}
	return -1;
}

GivePlayerDrug(playerid, typ, Float:dmnt, Float:dq)
{
	if(playerid == INVALID_PLAYER_ID)
		return 0;
	
	new 
		emptyslot = FindEmptyDrugSlot(playerid);
	
	if(emptyslot == -1)
		return -1;
		
	PlayerDrugs[playerid][dSQLID][emptyslot] = 99999;
	PlayerDrugs[playerid][dCode][emptyslot] = typ;
	PlayerDrugs[playerid][dAmount][emptyslot] = dmnt;
	PlayerDrugs[playerid][dEffect][emptyslot] = dq;
	PlayerDrugs[playerid][dTimeStamp][emptyslot] = gettime();
	
	
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, 
			"INSERT INTO player_drugs (player_id, code, amount, effect, timestamp) \n\
				VALUES ('%d', '%d', '%f', '%f', '%d')",
			PlayerInfo[playerid][pSQLID],
			typ,
			dmnt,
			dq,
			gettime()
		), 
		"GetDrugSQLID", 
		"iii", 
		playerid, 
		emptyslot, 
		0
	);
	
	return emptyslot;
}

GiveVehicleDrug(vehicleid, dtyp, Float:damnt, Float:dqua)
{
	if(vehicleid == INVALID_PLAYER_ID)
		return 0;
	
	new 
		emptyslot = FindEmptyCarDrugSlot(vehicleid);
	
	if(emptyslot == -1)
		return -1;
		
	VehicleDrugs[vehicleid][vsqlid][emptyslot] = 99999;
	VehicleDrugs[vehicleid][vtype][emptyslot] = dtyp;
	VehicleDrugs[vehicleid][vamount][emptyslot] = damnt;
	VehicleDrugs[vehicleid][vquality][emptyslot] = dqua;
	
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, 
			"INSERT INTO cocars_drugs (vehicle_id, code, amount, quality, timestamp) \n\
				VALUES ('%d', '%d', '%f', '%f', '%d')",
			VehicleInfo[vehicleid][vSQLID],
			dtyp,
			damnt,
			dqua,
			gettime()
		), 
		"GetDrugSQLID", 
		"iii", 
		vehicleid, 
		emptyslot, 
		1
	);
	
	return emptyslot;
}

DeleteVehicleDrug(vehicleid, slot = -1) 
{
	if(slot > MAX_VEHICLE_DRUGS || slot < -1)
		return 0;
	
	if(slot == -1)
	{
		mysql_fquery(g_SQL, "DELETE FROM cocars_drugs WHERE vehicle_id = '%d'", VehicleInfo[vehicleid][vSQLID]);
		ResetVehicleDrugs(vehicleid);
	}
	else
	{
		if(VehicleDrugs[vehicleid][vsqlid][slot] == 0)
			return 0;
			
		mysql_fquery(g_SQL,"DELETE FROM cocars_drugs WHERE id = '%d'", VehicleDrugs[vehicleid][vsqlid][slot]);
		
		VehicleDrugs[vehicleid][vsqlid][slot] = 0;
		VehicleDrugs[vehicleid][vtype][slot] = 0;
		VehicleDrugs[vehicleid][vamount][slot] = 0;
		VehicleDrugs[vehicleid][vquality][slot] = 0;
	}
	return 1;
}

forward GetDrugSQLID(playerid, emptyslot, swtch);
public GetDrugSQLID(playerid, emptyslot, swtch)
{
	if(swtch == 1)
		VehicleDrugs[playerid][vsqlid][emptyslot] = cache_insert_id();
	else
		PlayerDrugs[playerid][dSQLID][emptyslot] = cache_insert_id();
		
	return 1;
}

CMD:checkplayerdrugs(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi Admin!");
		
	new
		giveplayerid;
		
	if(sscanf(params, "u", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "KORISTI: /checkplayerdrugs [playerid/ime]");
		
	if(!IsPlayerConnected(giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "Neispravan igrac.");
		
		
	ListPlayerDrugs(playerid, giveplayerid);
	return 1;
}


CMD:checkvehdrugs(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi Admin!");
		
	new
		veh;
		
	if(sscanf(params, "d", veh))
		return SendClientMessage(playerid, COLOR_RED, "KORISTI: /checkvehdrugs [vehicleid]");
		
	ListVehicleDrugs(playerid, veh);
	return 1;
}


CMD:agivedrug(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi Admin!");

	new
		giveplayerid,
		drug,
		Float:amnt,
		Float:qlty;
	
	if(sscanf(params, "udff", giveplayerid, drug, amnt, qlty)) 
	{
		new
			drugsall[256],
			dline[76];
			
		for(new i = 1; i != sizeof(drugs); ++i)
		{
			format(dline, sizeof(dline), "%d) %s ", i, drugs[i][dName]);
			strcat(drugsall, dline, sizeof(drugsall));
		}
		SendClientMessage(playerid, COLOR_GREY, "KORISTI: /agivedrug [id/ime igraca][id droge][kolicina 0.1-x][kvaliteta]");
		va_SendClientMessage(playerid, COLOR_GREY, "DROGE: %s", drugsall);
		SendClientMessage(playerid, COLOR_GREY, "KVALITETA: 1.0 - 9.0 VRLO LOSA, 10.0 - 19.0 LOSA, 20.0 - 29.0 DOBRA, 30.0 - 39.0 VRLO DOBRA, 40.0 - 50.0 ODLICNA");
		return 1;
	}
	if(giveplayerid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Neispravan ID igraca!");
		
	if(drug > sizeof(drugs) || drug < 0)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Neispravan ID droge!");
		
	if(qlty < 1.0 || qlty > 50.0)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Neispravna kvaliteta droge!");
		
	if(amnt < 0.1 || amnt > 1000.0)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Neispravna kolicina droge!");
		
	if(GivePlayerDrug(giveplayerid, drug, amnt, qlty) == -1)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Igrac nema praznih drug slotova!");
		
	va_SendClientMessage(playerid, COLOR_YELLOW, "[!] Dao si %s[%d] %s kolicine %.2f i kvalitete %s[%.2f]!", GetName(giveplayerid), giveplayerid, drugs[drug][dName], amnt, ReturnDrugQuality(qlty), qlty);
	#if defined MODULE_LOGS
	Log_Write("logfiles/adm_givedrug.txt", "(%s) Game Admin %s gave %s %.2f %s of %s quality[%.3f]!", ReturnDate(), GetName(playerid), GetName(giveplayerid), amnt, drugs[drug][dName], ReturnDrugQuality(qlty), qlty);
	#endif
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DRUG_ORDER_CONFIRM:
		{
			if(response)
			{
				if(AC_GetPlayerMoney(playerid) < DrugPackage[playerid][pPrice])
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Nemas ni para, a u neke bi vece sheme, hah.");
					PlayerHangup(playerid);
					ClearDrugOrder(playerid);
					
					return 0;
				}
				
				if(DrugPackage[playerid][orderfinished] == 1)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Evo zasto ne pricam s glupim ljudima.. Narucio si vec jebeni paket, isuse boze pomozi.");
					PlayerHangup(playerid);
					ClearDrugOrder(playerid);
					
					return 0;
				}
				
				PlayerToIllegalBudgetMoney(playerid, DrugPackage[playerid][pPrice]);
				
				new
					ttDrug = DrugPackage[playerid][pcDrug];
				
				new 
					ran = random(sizeof(bag));
					
				va_SendClientMessage(playerid, COLOR_YELLOW, "Narucili ste %d %s droge %s za $%d! Lokacija paketa: %s.",
					DrugPackage[playerid][pcAmnt],
					(drugs[ttDrug][dEffect] < 4) ? ("grama") : ("tableta"), 
					drugs[ttDrug][dName], 
					DrugPackage[playerid][pPrice], 
					GetZoneFromXYZ(bag[ran][0], bag[ran][1], bag[ran][2])
				);
				
				SetPlayerCheckpoint(playerid, bag[ran][0], bag[ran][1], bag[ran][2] - 1, 6.0);
				DrugPackage[playerid][pobjID] = CreateDynamicObject(2919, bag[ran][0], bag[ran][1], bag[ran][2], 0.0, 0.0, 0.0, -1, -1, playerid);
				
				DrugPackage[playerid][Xp] = bag[ran][0];
				DrugPackage[playerid][Yp] = bag[ran][1];
				DrugPackage[playerid][Zp] = bag[ran][2];
				
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Paket cu izbaciti kroz par minuta te ce biti na dogovorenoj lokaciji.");
				
				#if defined MODULE_LOGS
				Log_Write("logfiles/drug_order.txt", "(%s) %s{%d} ordered %d %s of %s for $%d!",
					ReturnDate(), 
					GetName(playerid),
					PlayerInfo[playerid][pSQLID],
					DrugPackage[playerid][pcAmnt],
					(drugs[ttDrug][dEffect] < 4) ? ("grama") : ("tableta"), 
					drugs[ttDrug][dName],
					DrugPackage[playerid][pPrice]
				);
				#endif
				
				DrugPackage[playerid][orderfinished] = 1;
				PlayerHangup(playerid);
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Sta me drkas koju picku materinu, daj odjebi!");
				PlayerHangup(playerid);
				
				ClearDrugOrder(playerid);
				
				return 0;
			}
		}
		case DRUG_ORDER_PACKAGE:
		{
			if(response)
			{
				if(DrugPackage[playerid][orderfinished] == 1)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Evo zasto ne pricam s glupim ljudima.. Narucio si vec jebeni paket, isuse boze pomozi.");
					PlayerHangup(playerid);
					//ClearDrugOrder(playerid);
					
					return 0;
				}
			
				if(listitem > sizeof(drugs) || listitem < 0)
					return 0;

				va_ShowPlayerDialog(playerid, DRUG_ORDER_AMOUNT, DIALOG_STYLE_INPUT, "{3C95C2}* PACKAGE - AMOUNT", "Odabrali ste drogu %s! Upisite koliko grama zelite naruciti!\nCijena po gramu: %d$", "Select", "Close", drugs[listitem+1][dName], drugs[listitem+1][dPricePG]);
				
				//dPackage_OrderID[playerid] = x;
				//dPackage_OrderAMNT[playerid] = x;
				
				DrugPackage[playerid][pcDrug] = listitem + 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Sta me drkas koju picku materinu, daj odjebi!");
				PlayerHangup(playerid);
				
				return 0;
			}
		}
		case DRUG_ORDER_AMOUNT:
		{
			if(response)
			{
				new
					val = strval(inputtext),
					tDrug = DrugPackage[playerid][pcDrug];
				
				if(val < 1 || val > 100)
				{
					SendClientMessage(playerid, COLOR_RED, "Nemozete kupiti manje od 1 ni vise od 100 grama!");
					va_ShowPlayerDialog(playerid, DRUG_ORDER_AMOUNT, DIALOG_STYLE_INPUT, "{3C95C2}* PACKAGE - AMOUNT", "Odabrali ste drogu %s! Upisite koliko grama zelite naruciti!\nCijena po gramu: %d$", "Select", "Close", drugs[tDrug][dName], drugs[tDrug][dPricePG]);
					return 1;
				}
				DrugPackage[playerid][pcAmnt] = val;
					
				DrugPackage[playerid][pPrice] = drugs[tDrug][dPricePG] * val;
				
				va_ShowPlayerDialog(playerid, DRUG_ORDER_CONFIRM, DIALOG_STYLE_MSGBOX, "{3C95C2}* PACKAGE - CONFIRM", "Odabrali ste paket od:\n%d %s droge %s za cijenu %d!\n\nJeste li sigurni da zelite naruciti paket?", "Naruci", "Abort", val, (drugs[tDrug][dEffect] < 4) ? ("grama") : ("tableta"), drugs[tDrug][dName], DrugPackage[playerid][pPrice]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Sta me drkas koju picku materinu, daj odjebi!");
				PlayerHangup(playerid);
				
				ClearDrugOrder(playerid);
				
				return 0;
			}
		}
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(DrugPackage[playerid][pcDrug] != 0)
	{
		if(DrugPackage[playerid][orderfinished] == 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, DrugPackage[playerid][Xp], DrugPackage[playerid][Yp], DrugPackage[playerid][Zp]))
			{
				// stigao je igrac
				new
					slot = -1,
					tDrug = DrugPackage[playerid][pcDrug],
					Float:qua = float(randomEx(35,50));
				
				if((slot = GivePlayerDrug(playerid, DrugPackage[playerid][pcDrug], float(DrugPackage[playerid][pcAmnt]), qua)) == -1)
					return SendClientMessage(playerid, COLOR_RED, "Nemas praznih slotova!");
					
				DrugPackage[playerid][orderfinished] = 0;
				
				va_SendClientMessage(playerid, COLOR_YELLOW, "Dobio si %d %s droge %s u slot %d!",
					DrugPackage[playerid][pcAmnt],
					(drugs[tDrug][dEffect] < 4) ? ("grama") : ("tableta"), 
					drugs[tDrug][dName],
					slot+1
				);
				
				#if defined MODULE_LOGS
				Log_Write("logfiles/drug_order.txt", "(%s) %s{%d} picked up ordered drug package(%d %s of %s). Quality:[%.2f(%s)]",
					ReturnDate(), 
					GetName(playerid),
					PlayerInfo[playerid][pSQLID],
					DrugPackage[playerid][pcAmnt],
					(drugs[tDrug][dEffect] < 4) ? ("grama") : ("tableta"), 
					drugs[tDrug][dName],
					qua,
					ReturnDrugQuality(qua)
				);
				#endif
				
				PlayerDrugStatus[playerid][pDrugOrder] = 120;
				
				ClearDrugOrder(playerid);
			}
		}
	}
	return 1;
}

/*
	pcDrug,
	pcAmnt,
	Float:pDx,
	Float:pDy,
	Float:pDz,
	pPrice,
	pobjID,
	cpID
*/
/*
CMD:cdorder(playerid, params[])
{
	ClearDrugOrder(playerid);
	return 1;
}
*/
ClearDrugOrder(playerid)
{
	DestroyDynamicObject(DrugPackage[playerid][pobjID]);
	DisablePlayerCheckpoint(playerid);
	
	static
		e_DP[pckg_Drugs];
		
	DrugPackage[playerid] = e_DP;
	return 1;
}

// 2903 - BAG WITH PARACHUTE + z: 7
// 11745 - BAG
// bag biger - 2919
