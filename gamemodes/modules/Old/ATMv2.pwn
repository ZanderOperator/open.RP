#include <YSI\y_hooks>

#define MAX_ATM 	(50)

enum e_atm_info
{
	atm_sql,
	atm_objid,
	bool:atm_created,
	Float:atm_x,
	Float:atm_y,
	Float:atm_z,
	Float:atm_rx,
	Float:atm_ry,
	Float:atm_rz,
	atm_virtualworld,
	atm_interior
}

static
	ATMInfo[MAX_ATM][e_atm_info];
	
new
    Iterator:Atm<MAX_ATM>,
    pEditingATM[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
	pEditingATM[playerid] = -1;

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	pEditingATM[playerid] = -1;

	return 1;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(pEditingATM[playerid] != -1)
	{
	    if(objectid == ATMInfo[pEditingATM[playerid]][atm_objid])
	    {
			if(response == EDIT_RESPONSE_FINAL)
			{
			    SetDynamicObjectPos(objectid, x, y, z);
			    SetDynamicObjectRot(objectid, rx, ry, rz);
			    
			    ATMInfo[pEditingATM[playerid]][atm_x] = x;
		        ATMInfo[pEditingATM[playerid]][atm_y] = y;
		        ATMInfo[pEditingATM[playerid]][atm_z] = z;
		        ATMInfo[pEditingATM[playerid]][atm_rx] = rx;
		        ATMInfo[pEditingATM[playerid]][atm_ry] = ry;
		        ATMInfo[pEditingATM[playerid]][atm_rz] = rz;
		        
		        ATM_Save(pEditingATM[playerid]);
		        
		        va_SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Uredio si ATM %d!", pEditingATM[playerid]);
		        pEditingATM[playerid] = -1;

				return 1;
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
			    SetDynamicObjectPos(objectid, ATMInfo[pEditingATM[playerid]][atm_x], ATMInfo[pEditingATM[playerid]][atm_y], ATMInfo[pEditingATM[playerid]][atm_z]);
			    SetDynamicObjectRot(objectid, ATMInfo[pEditingATM[playerid]][atm_rx], ATMInfo[pEditingATM[playerid]][atm_ry], ATMInfo[pEditingATM[playerid]][atm_rz]);

				va_SendClientMessage(playerid, COLOR_RED, "[INFO]: Odustao si od ureðivanja ATM-a %d!", pEditingATM[playerid]);
				pEditingATM[playerid] = -1;

				return 1;
			}
	    }
	}
	return 1;
}

LoadATMs()
{
    mysql_tquery(1, "SELECT * FROM server_atms WHERE 1", "ATM_Load");
	return 1;
}

forward ATM_Load();
public ATM_Load()
{
	new
		rows = cache_get_row_count();

	if(!rows)
		return printf("MySQL Report: No atm's exist to load.");

	for(new a = 0; a != rows; ++a)
	{
		ATMInfo[a][atm_sql] = cache_get_field_content_int(a, "id", 1);
		ATMInfo[a][atm_x] = cache_get_field_content_float(a, "x", 1);
		ATMInfo[a][atm_y] = cache_get_field_content_float(a, "y", 1);
		ATMInfo[a][atm_z] = cache_get_field_content_float(a, "z", 1);
		ATMInfo[a][atm_rx] = cache_get_field_content_float(a, "rx", 1);
		ATMInfo[a][atm_ry] = cache_get_field_content_float(a, "ry", 1);
		ATMInfo[a][atm_rz] = cache_get_field_content_float(a, "rz", 1);
		ATMInfo[a][atm_virtualworld] = cache_get_field_content_int(a, "vw", 1);
		ATMInfo[a][atm_interior] = cache_get_field_content_int(a, "a_int", 1);
		ATMInfo[a][atm_created] = true;

		ATM_Refresh(a);
		Iter_Add(Atm, a);
	}
	printf("MySQL Report: ATM's Loaded (%d)!", Iter_Count(Atm));
	return 1;
}

forward OnATMCreated(id);
public OnATMCreated(id)
{
    ATMInfo[id][atm_sql] = cache_insert_id();
	return 1;
}

ATM_Refresh(id)
{
	if(!ATMInfo[id][atm_created] && id < 0)
	    return 0;
	    
	if(IsValidDynamicObject(ATMInfo[id][atm_objid]))
	    DestroyDynamicObject(ATMInfo[id][atm_objid]);
	    
	ATMInfo[id][atm_objid] = CreateDynamicObject(
								19324,
								ATMInfo[id][atm_x],
								ATMInfo[id][atm_y],
								ATMInfo[id][atm_z],
								ATMInfo[id][atm_rx],
								ATMInfo[id][atm_ry],
								ATMInfo[id][atm_rz],
								ATMInfo[id][atm_virtualworld],
							 	ATMInfo[id][atm_interior],
							 	-1,
							 	150.0,
							 	100.0,
							 	-1
							 );
	return 1;
}

ATM_Create(Float:x, Float:y, Float:z, int, vw)
{
	for(new a = 0; a != MAX_ATM; ++a)
	{
	    if(!ATMInfo[a][atm_created])
	    {
			ATMInfo[a][atm_x] = x;
		    ATMInfo[a][atm_y] = y;
		    ATMInfo[a][atm_z] = z;
		    ATMInfo[a][atm_rx] = 0.0;
		    ATMInfo[a][atm_ry] = 0.0;
		    ATMInfo[a][atm_rz] = 0.0;
		    ATMInfo[a][atm_virtualworld] = vw;
		    ATMInfo[a][atm_interior] = int;
		    ATMInfo[a][atm_created] = true;
		    
		    ATM_Refresh(a);
		    
		    Iter_Add(Atm, a);

			if(mysql_tquery(1, "INSERT INTO `server_atms` (`x`, `y`, `z`, `rx`, `ry`, `rz`, `vw`, `a_int`) VALUES ('0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0', '0')", "OnATMCreated", "d", a))
				ATM_Save(a);

			return a;
		}
	}
	return -1;
}

ATM_Delete(id)
{
    if(id < 0 || id > 50)
	    return 0;

	if(!ATMInfo[id][atm_created])
 		return 0;
 		
	if(IsValidDynamicObject(ATMInfo[id][atm_objid]))
	    DestroyDynamicObject(ATMInfo[id][atm_objid]);
	    
    ATMInfo[id][atm_x] = 0.0;
    ATMInfo[id][atm_y] = 0.0;
    ATMInfo[id][atm_z] = 0.0;
    ATMInfo[id][atm_rx] = 0.0;
    ATMInfo[id][atm_ry] = 0.0;
    ATMInfo[id][atm_rz] = 0.0;
    ATMInfo[id][atm_virtualworld] = 0;
    ATMInfo[id][atm_interior] = 0;
    ATMInfo[id][atm_created] = false;
    
    Iter_Remove(Atm, id);
    
    new
        atm_query[36];
        
	mysql_format(1, atm_query, sizeof(atm_query), "DELETE FROM server_atms WHERE id=%d",
		ATMInfo[id][atm_sql]
	);
	
	if(!mysql_tquery(1, atm_query))
	    return 0;

	return 1;
}

ATM_Save(id)
{
	if(id < 0 || id > 50)
	    return 0;
	    
	if(!ATMInfo[id][atm_created])
	    return 0;
	    
	new
	    atm_query[196];
	    
	mysql_format(1, atm_query, sizeof(atm_query), "UPDATE server_atms SET x='%f', y='%f', z='%f', rx='%f', ry='%f', rz='%f', vw='%d', a_int='%d' WHERE id='%d'",
		ATMInfo[id][atm_x],
	 	ATMInfo[id][atm_y],
	 	ATMInfo[id][atm_z],
	 	ATMInfo[id][atm_rx],
	 	ATMInfo[id][atm_ry],
	 	ATMInfo[id][atm_rz],
	 	ATMInfo[id][atm_virtualworld],
	 	ATMInfo[id][atm_interior],
	 	ATMInfo[id][atm_sql]
	);

	if(!mysql_tquery(1, atm_query))
		return 0;
		
	return 1;
}

IsAtATM(playerid)
{
	new
		p_vw = GetPlayerVirtualWorld(playerid),
		p_int = GetPlayerInterior(playerid);

	foreach(new a : Atm)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.5, ATMInfo[a][atm_x], ATMInfo[a][atm_y], ATMInfo[a][atm_z]) && p_vw == ATMInfo[a][atm_virtualworld] && p_int == ATMInfo[a][atm_interior])
			return a;
	}
	return -1;
}

CMD:atm(playerid, params[])
{
	if(!Iter_Count(Atm))
	    return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Trenutno nema kreiranih ATM-ova!");

	new
	    atm_n_id;
	    
	if((atm_n_id = IsAtATM(playerid)) == -1)
		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nisi blizu ATMa te nemozes koristiti ovu komandu!");
		
	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možeš koristiti ovu komandu dok si u vozilu!");

	new
		option[9],
		amount,
		string[77];
		
    if(sscanf(params, "s[9] ", option))
	{
		SendClientMessage(playerid, -1, "KORISTI: /atm [opcija]");
		SendClientMessage(playerid, COLOR_GREY, "[OPCIJE]: withdraw, status");
		return 1;
	}
	if(!strcmp(option, "status", true))
    {
		format(string, sizeof(string), "ATM: Trenutno stanje na vašem raèunu je: %d$!", PlayerInfo[playerid][pBank]);
		SendClientMessage(playerid, COLOR_GREY, string);
		return 1;
	}
	else if(!strcmp(option, "withdraw", true))
	{
		if(sscanf(params, "s[9]i", option, amount))
		{
			SendClientMessage(playerid, COLOR_GREY, "KORISTI: /atm withdraw [iznos]");
  			format(string, sizeof(string), "ATM: Trenutno stanje na vašem raèunu je: %d$!", PlayerInfo[playerid][pBank]);
			return SendClientMessage(playerid, COLOR_GREY, string);
		}
		if(amount > PlayerInfo[playerid][pBank])
			return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate toliko novaca!");
			
		if(amount < 1)
		{
		    Log_Write("logfiles/atm_withdraw.txt", "(%s) Igrac %s[%d]{%d} je pokusao podignuti %d$ sa bankomata (%d)!", ReturnDate(), ReturnName(playerid), playerid, PlayerInfo[playerid][pSQLID], amount, atm_n_id);
		    return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nepravilan unos!");
		}
		PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);
		
		foreach(new i : Player)
		{
		    PlayerPlaySound(playerid, 43000, ATMInfo[atm_n_id][atm_x], ATMInfo[atm_n_id][atm_y], ATMInfo[atm_n_id][atm_z]);
		}

		AC_GivePlayerMoney(playerid, amount);
		PlayerInfo[playerid][pBank] -= amount;
		
		Log_Write("logfiles/atm_withdraw.txt", "(%s) Igrac %s[%d]{%d} je podignuo %d$ sa bankomata (%d)! Preostalo mu je %d$ na racunu.", ReturnDate(), ReturnName(playerid), playerid, PlayerInfo[playerid][pSQLID], amount, atm_n_id, PlayerInfo[playerid][pBank]);
		
		format(string, sizeof(string), "[ATM]: Uzeli ste %d$ s vašeg raèuna! Preostalo vam je %d$ na vasem raèunu!", amount, PlayerInfo[playerid][pBank]);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	return 1;
}

CMD:aatm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
	    return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možete koristiti ovu komandu!");
	    
	new
	    option;

	if(sscanf(params, "d", option))
	{
		SendClientMessage(playerid, -1, "KORISTI: /aatm [opcija]");
		SendClientMessage(playerid, COLOR_GREY, "[OPCIJE]: 1) create, 2) edit, 3) delete, 4) refill");
		return 1;
	}

	new
	    id;

	switch(option)
	{
	    case 1:
	    {
	        if(Iter_Count(Atm) == MAX_ATM)
	    		return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Maksimalan broj ATMova je dosegnut!");

			new
				Float:pi_x,
				Float:pi_y,
				Float:pi_z;
				
            GetXYZInFrontOfPlayer(playerid, pi_x, pi_y, pi_z, 2.0);

			new
			    ATM_id;

			if((ATM_id = ATM_Create(pi_x, pi_y, pi_z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid))) != -1)
			    return va_SendClientMessage(playerid, COLOR_RED, "[INFO]: Kreirao si ATM (%d)! Koristi /aatm 2 kako bi uredio poziciju ATM-a!", ATM_id);
			else
			    SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Nema slobodnih ATM slotova!");

			return 1;
	    }
	    case 2:
	    {
	        if(sscanf(params, "dd", option, id))
				return SendClientMessage(playerid, -1, "KORISTI: /aatm edit [id]");
				
			if(id < 0 || id > 50)
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Nepravilan ID ATM-a!");
			    
			if(!Iter_Contains(Atm, id))
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Taj ATM nije kreiran!");
				
			if(!IsPlayerInRangeOfPoint(playerid, 10.0, ATMInfo[id][atm_x], ATMInfo[id][atm_y], ATMInfo[id][atm_z]) && GetPlayerInterior(playerid) != ATMInfo[id][atm_interior] && GetPlayerVirtualWorld(playerid) != ATMInfo[id][atm_virtualworld])
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Niste blizu tog ATM-a!");
				
			pEditingATM[playerid] = id;
			EditDynamicObject(playerid, ATMInfo[id][atm_objid]);

			return 1;
	    }
	    case 3:
	    {
	        if(sscanf(params, "dd", option, id))
				return SendClientMessage(playerid, -1, "KORISTI: /aatm delete [id]");

			if(id < 0 || id > 50)
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Nepravilan ID ATM-a!");
			    
            if(!Iter_Contains(Atm, id))
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Taj ATM nije kreiran!");
			    
            if(ATM_Delete(id))
                return va_SendClientMessage(playerid, COLOR_RED, "[INFO]: Uspješno si izbrisao ATM %d sa servera!", id);
			else
			    return SendClientMessage(playerid, COLOR_RED, "[GREŠKA]: Taj ATM nije kreiran!");
	    }
	    default:
			SendClientMessage(playerid, COLOR_RED, "[OPCIJE]: 1) create, 2) edit, 3) delete");
	}
	return 1;
}

CMD:atmid(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] != 1338)
	    return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne možete koristiti ovu komandu!");

	new
	    p_vw = GetPlayerVirtualWorld(playerid),
	    p_int = GetPlayerInterior(playerid);

	foreach(new a : Atm)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, ATMInfo[a][atm_x], ATMInfo[a][atm_y], ATMInfo[a][atm_z]) && p_vw == ATMInfo[a][atm_virtualworld] && p_int == ATMInfo[a][atm_interior])
			return va_SendClientMessage(playerid, -1, "Nalazite se kraj ATM-a ID: %d!", a);
	}
	SendClientMessage(playerid, COLOR_RED, "Niste blizu nikojeg ATM-a!");

	return 1;
}
