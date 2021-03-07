#include <YSI_Coding\y_hooks>

/*
	- Defines & Enums
*/

#define DEFAULT_TAXI_FARE		 (2)
#define DEFAULT_TAXI_METERS_FARE (500)
#define TAXI_MAX_SKILL			 (400)
/*
	- Vars
*/

enum E_DATA_TAXI 
{
	bool: eTaxiDuty,
	bool: eTaxiActive,
	eTaxiDriver,
	eTaxiPassanger,
	eTaxiMetersFare,
	eTaxiTraveled,
	eTaxiFare,
	eTaxiPayment,
	Float: eTaxiStartPos[3],
}
static 
	TaxiData[MAX_PLAYERS][E_DATA_TAXI];

enum E_P_TAXI_INFO
{
	pTaxiPoints,
	pTaxiVoted
}
static 	
	TaxiInfo[MAX_PLAYERS][E_P_TAXI_INFO];

static	
	PlayerText:Taximeter[MAX_PLAYERS][10];

ptask TaxiMeter[1000](playerid)
{
	if(SafeSpawned[playerid] && TaxiData[playerid][eTaxiActive]) 
		_TaximeterCount(playerid);
	return 1;
}

/*
                                                                      
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'                             

*/

LoadPlayerTaxiStats(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_savings WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerSavings", 
        "i", 
        playerid
   );
    return 1;
}

Public: LoadingPlayerTaxiStats(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_taxi(sqlid, taxiPoints, taxiVoted) \n\
                VALUES('%d', '0', '0')",
            PlayerInfo[playerid][pSQLID]
       );
        return 1;
    }
    cache_get_value_name_int(0, "taxiPoints"	, TaxiInfo[playerid][pTaxiPoints]);
	cache_get_value_name_int(0, "taxiVoted"		, TaxiInfo[playerid][pTaxiVoted]);
   
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerTaxiStats(playerid);
	return continue(playerid);
}

SavePlayerTaxiStats(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_taxi SET taxiPoints = '%d', taxiVoted = '%d' WHERE sqlid = '%d'",
        TaxiInfo[playerid][pTaxiPoints],
        TaxiInfo[playerid][pTaxiVoted],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerTaxiStats(playerid);
	return continue(playerid);
}

/*
	- Functions
*/

bool: Player_TaxiDuty(playerid)
{
	return TaxiData[playerid][eTaxiDuty];
}

Player_TaxiPoints(playerid)
{
	return TaxiInfo[playerid][pTaxiPoints];
}

Player_TaxiVoted(playerid)
{
	return TaxiInfo[playerid][pTaxiVoted];
}

IsATaxi(model)
{
    if(model == 420 || model == 438)
		return (true);
	return (false);
}

CreateTaximeter(playerid, bool: status) {
	if(status == false) {
		for(new i = 0; i < 10; i++) {
		    PlayerTextDrawHide(playerid, Taximeter[playerid][i]);
		}
	}
	else if(status == true) {
		Taximeter[playerid][0] = CreatePlayerTextDraw(playerid, 527.333312, 137.636199, "box");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][0], 0.000000, 1.233332);
		PlayerTextDrawTextSize(playerid, Taximeter[playerid][0], 610.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][0], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, Taximeter[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, Taximeter[playerid][0], 255);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][0], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][0], 0);

		Taximeter[playerid][1] = CreatePlayerTextDraw(playerid, 527.333312, 151.837066, "box");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][1], 0.000000, 5.166666);
		PlayerTextDrawTextSize(playerid, Taximeter[playerid][1], 610.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][1], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, Taximeter[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, Taximeter[playerid][1], 170);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][1], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][1], 0);

		Taximeter[playerid][2] = CreatePlayerTextDraw(playerid, 537.366027, 104.203643, "");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Taximeter[playerid][2], 63.000000, 51.000000);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][2], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][2], 1090519040);
		PlayerTextDrawFont(playerid, Taximeter[playerid][2], 5);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][2], 0);
		PlayerTextDrawSetPreviewModel(playerid, Taximeter[playerid][2], 19308);
		PlayerTextDrawSetPreviewRot(playerid, Taximeter[playerid][2], 0.000000, 0.000000, 90.000000, 1.000000);

		Taximeter[playerid][3] = CreatePlayerTextDraw(playerid, 567.799743, 138.148117, "Taximeter");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][3], 0.198666, 0.936296);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][3], 2);
		PlayerTextDrawColor(playerid, Taximeter[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][3], 1);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][3], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][3], 3);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][3], 0);

		Taximeter[playerid][4] = CreatePlayerTextDraw(playerid, 527.333251, 198.711135, "box");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][4], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Taximeter[playerid][4], 609.701660, 0.000000);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][4], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][4], -1);
		PlayerTextDrawUseBox(playerid, Taximeter[playerid][4], 1);
		PlayerTextDrawBoxColor(playerid, Taximeter[playerid][4], 255);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][4], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][4], 0);

		Taximeter[playerid][5] = CreatePlayerTextDraw(playerid, 529.666748, 166.456283, "Destination:_None");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][5], 0.143666, 0.932592);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][5], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][5], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][5], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][5], 0);

		Taximeter[playerid][6] = CreatePlayerTextDraw(playerid, 529.366821, 158.955825, "Fare:_~g~0$");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][6], 0.143666, 0.932592);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][6], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][6], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][6], 0);

		Taximeter[playerid][7] = CreatePlayerTextDraw(playerid, 529.366821, 151.255355, "Taxist:_None");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][7], 0.143666, 0.932592);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][7], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][7], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][7], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][7], 0);

		Taximeter[playerid][8] = CreatePlayerTextDraw(playerid, 567.532043, 185.036987, "~y~Current_Fare:_0$");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][8], 0.173999, 1.044148);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][8], 2);
		PlayerTextDrawColor(playerid, Taximeter[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][8], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][8], 0);

		Taximeter[playerid][9] = CreatePlayerTextDraw(playerid, 529.666748, 173.856735, "Passenger:_None");
		PlayerTextDrawLetterSize(playerid, Taximeter[playerid][9], 0.143666, 0.932592);
		PlayerTextDrawAlignment(playerid, Taximeter[playerid][9], 1);
		PlayerTextDrawColor(playerid, Taximeter[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, Taximeter[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, Taximeter[playerid][9], 255);
		PlayerTextDrawFont(playerid, Taximeter[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, Taximeter[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, Taximeter[playerid][9], 0);
		
		for(new i = 0; i < 10; i++) {
		    PlayerTextDrawShow(playerid, Taximeter[playerid][i]);
		}
	}
	return (true);
}

ResetTaxiVariables(playerid) 
{
	TaxiData[playerid][eTaxiDuty] = (false);
	TaxiData[playerid][eTaxiActive] = (false);
	
	TaxiData[playerid][eTaxiFare] = (-1);
	TaxiData[playerid][eTaxiPayment] = (-1);
	TaxiData[playerid][eTaxiTraveled] = (0);
	TaxiData[playerid][eTaxiPassanger] = INVALID_PLAYER_ID;
	TaxiData[playerid][eTaxiDriver] = INVALID_PLAYER_ID;
	
	TaxiData[playerid][eTaxiStartPos][0] = 0.0;
	TaxiData[playerid][eTaxiStartPos][1] = 0.0;
	TaxiData[playerid][eTaxiStartPos][2] = 0.0;
	
	CreateTaximeter(playerid, false);
	return (true);
}

Public:_TaximeterCount(playerid) {
	new 
		Float: Distance = GetPlayerDistanceFromPoint(playerid,TaxiData[playerid][eTaxiStartPos][0], TaxiData[playerid][eTaxiStartPos][1], TaxiData[playerid][eTaxiStartPos][2] / TaxiData[playerid][eTaxiMetersFare]),
		next_payment = TaxiData[playerid][eTaxiMetersFare],
		checker, traveled = floatround(Distance),
		buffer[32];
	
	checker = next_payment * TaxiData[playerid][eTaxiTraveled];
	if(traveled >= checker) {	
		TaxiData[playerid][eTaxiTraveled]++;
		TaxiData[playerid][eTaxiPayment] += TaxiData[playerid][eTaxiFare];
		
		format(buffer, sizeof(buffer), "~y~Current_Fare:_%s", FormatNumber(TaxiData[playerid][eTaxiPayment]));
		PlayerTextDrawSetString(playerid, Taximeter[playerid][8], buffer);
	}
	return (true);
}

Taxi_Biznis(playerid, taxi_points, fare) {
	new bonuses = 0,
		final_bonus = 0;
	
	switch(taxi_points) {
		case 1..80: bonuses = minrand(50, 80); 
		case 81..160: bonuses = minrand(80, 120); 
		case 161..240: bonuses = minrand(120, 160); 
		case 241..320: bonuses = minrand(160, 200); 
		case 321..TAXI_MAX_SKILL: bonuses = minrand(200, 250); 
	}
		
	// calculate
	final_bonus = fare+bonuses;
	BudgetToPlayerBankMoney(playerid, final_bonus);
	PaydayInfo[playerid][pPayDayMoney] += final_bonus;
	return (true);
}

/*
	- hooks
*/

hook function ResetPlayerVariables(playerid)
{
	TaxiInfo[playerid][pTaxiPoints] = 0;
    TaxiInfo[playerid][pTaxiVoted] = 0;
	ResetTaxiVariables(playerid);
	return continue(playerid);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) 
	{
		if(IsATaxi(GetVehicleModel(GetPlayerVehicleID(playerid)))) 
		{
			if(PlayerJob[playerid][pJob] == JOB_TAXI) 
			{
				if(TaxiData[playerid][eTaxiDuty] == true)
					return CreateTaximeter(playerid, true);
			}
		}
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	switch(dialogid)
	{
		case DIALOG_TAXI_RATING: 
		{
			new taxist = TaxiData[playerid][eTaxiDriver],
				rating = listitem+1;

			if(!response)
			{ 
				ResetTaxiVariables(playerid);
				return SendMessage(playerid, MESSAGE_TYPE_INFO, "Odustali ste od davanja ocjene taxisti.");
			}
	
			TaxiInfo[taxist][pTaxiPoints] += rating;
			TaxiInfo[taxist][pTaxiVoted] += 1;
			
			new Float: t_overall = float(TaxiInfo[taxist][pTaxiPoints]) / (TaxiInfo[taxist][pTaxiVoted]);
			
			va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali Taxisti %s ocjenu %d za voznju.", GetName(taxist), rating);
			va_SendMessage(taxist, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dobili ocjenu %d za vasu taxi voznju, sada imate ukupnu ocjenu %.1f", rating, t_overall);
			
			SavePlayerTaxiStats(playerid);
			Taxi_Biznis(taxist, TaxiInfo[taxist][pTaxiPoints], TaxiData[playerid][eTaxiPayment]);
			
			ResetTaxiVariables(playerid);
		}
	}
	return 0;
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	if(IsATaxi(GetVehicleModel(vehicleid))) {
		if(TaxiData[playerid][eTaxiDuty] == true) {
			CreateTaximeter(playerid, false);
		}
		else if(TaxiData[playerid][eTaxiDuty] == false) {
			if(TaxiData[playerid][eTaxiActive] == true) {
				new taxist = TaxiData[playerid][eTaxiDriver];
					
				va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zavrsili sa vasom taxi voznjom, voznju ste naplatili %s.", 
					FormatNumber(TaxiData[playerid][eTaxiPayment])
				);
				va_SendMessage(taxist, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zavrsili sa vasom taxi voznjom, zaradili ste %s.", 
					FormatNumber(TaxiData[playerid][eTaxiPayment])
				);
				if(TaxiData[playerid][eTaxiTraveled] > 1)
					ShowPlayerDialog(playerid, DIALOG_TAXI_RATING, DIALOG_STYLE_LIST, "{F3FF02}* Taxi - Rating", "1\n2\n3\n4\n5", "Rate", "Exit");
				
				PlayerToPlayerMoney(playerid, taxist, TaxiData[playerid][eTaxiPayment]);
					
				TaxiData[taxist][eTaxiActive] = (false);
				TaxiData[taxist][eTaxiPassanger] = INVALID_PLAYER_ID;
				TaxiData[taxist][eTaxiPayment] = 0;
				TaxiData[taxist][eTaxiTraveled] = 0;
					
				TaxiData[taxist][eTaxiStartPos][0] = 0.0;
				TaxiData[taxist][eTaxiStartPos][1] = 0.0;
				TaxiData[taxist][eTaxiStartPos][2] = 0.0;
					
				PlayerTextDrawSetString(taxist, Taximeter[taxist][9], "Passenger:_None");
				PlayerTextDrawSetString(taxist, Taximeter[taxist][5], "Destination:_None");
				PlayerTextDrawSetString(taxist, Taximeter[taxist][8], "~y~Current_Fare:_0$");
			}
		}
	}
	return (true);
}

/*
	- Commands
*/

CMD:taxi(playerid, params[]) 
{		
	if(PlayerJob[playerid][pJob] != JOB_TAXI) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti clan taxi sluzbe da bi mogao koristiti komandu!");
			
	new action[18],
		string[128];
		
	if(sscanf(params, "s[18] ", action)) 
	{
		SendClientMessage(playerid, COLOR_WHITE, "[KORISTI]: /taxi [opcija].");
		SendClientMessage(playerid, COLOR_RED, "[!] start, stop, duty, setfare, myrating.");
		return (true);
    }
	
	if(strcmp(action,"myrating",true) == 0) 
	{
		if(TaxiInfo[playerid][pTaxiPoints] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi jos uvijek nemate Taxi Rating!");
			
		new Float: t_overall = float(TaxiInfo[playerid][pTaxiPoints]) / float(TaxiInfo[playerid][pTaxiVoted]);
		va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Vas trenutni rating je: %.1f", t_overall);
	}
	
    if(strcmp(action,"start",true) == 0) {
		
		new passanger_id, destination[32], Float: X, Float: Y, Float: Z,
			buffer_l[32], buffer_p[MAX_PLAYER_NAME], buffer_t[MAX_PLAYER_NAME], buffer_f[12];
		
        if(PlayerJob[playerid][pFreeWorks] < 1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes vise raditi!");
			
    	if(TaxiData[playerid][eTaxiDuty] == false) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na Taxi duznosti!");
			
		if(!IsATaxi(GetVehicleModel(GetPlayerVehicleID(playerid)))) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u taksiju!");
		
		if(sscanf( params, "s[18]is[32]", action, passanger_id, destination)) 
			return SendClientMessage( playerid, -1, "[KORISTI]: /taxi start [targetid][destination].");
		
		if(passanger_id == INVALID_PLAYER_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unijeli ste pogresan id.");
		
		if(passanger_id == playerid) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe odabrati za voznju!");
		
		if(!IsPlayerInVehicle(passanger_id, GetPlayerVehicleID(playerid))) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac mora biti u taxi vozilu.");
		
		if(PlayerInfo[passanger_id][pLevel] == 1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igraca level 1 ne mozete voziti.");
			
		if(TaxiData[playerid][eTaxiActive] == true) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate aktiviranu voznju.");
		
		// Taximeter
		CreateTaximeter(passanger_id, true);
		format(buffer_l, sizeof(buffer_l), "Destination:_%s", destination);
		format(buffer_p, sizeof(buffer_p), "Passenger:_%s", GetName(passanger_id));
		format(buffer_t, sizeof(buffer_t), "Taxist:_%s", GetName(playerid));
		format(buffer_f, sizeof(buffer_f), "Fare:_~g~%s", FormatNumber(TaxiData[playerid][eTaxiFare]));
		
        format(string, sizeof(string), "** Taximetar je upaljen, spreman je za brojanje udaljenosti (( %s)).", GetName(playerid));
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		// format
		PlayerTextDrawSetString(passanger_id, Taximeter[passanger_id][9], buffer_p);
		PlayerTextDrawSetString(playerid, Taximeter[playerid][9], buffer_p);
		
		PlayerTextDrawSetString(passanger_id, Taximeter[passanger_id][5], buffer_l);
		PlayerTextDrawSetString(playerid, Taximeter[playerid][5], buffer_l);
		
		PlayerTextDrawSetString(passanger_id, Taximeter[passanger_id][8], "~y~Current_Fare:_0$");
		PlayerTextDrawSetString(playerid, Taximeter[playerid][8], "~y~Current_Fare:_0$");
		
		PlayerTextDrawSetString(passanger_id, Taximeter[passanger_id][7], buffer_t);
		PlayerTextDrawSetString(passanger_id, Taximeter[passanger_id][6], buffer_f);
		
		va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Zapoceli ste sa voznjom %s, taximeter je ukljucen (FARE: %s po %dm).", 
			GetName(playerid, false), FormatNumber(TaxiData[playerid][eTaxiFare], TaxiData[playerid][eTaxiMetersFare])
		);
		
		// Vars
		GetPlayerPos(playerid, X, Y, Z);
	
		TaxiData[playerid][eTaxiActive] = (true);
		TaxiData[playerid][eTaxiPassanger] = passanger_id;
		TaxiData[playerid][eTaxiPayment] = 0;
		TaxiData[playerid][eTaxiTraveled] = 1;
		PlayerJob[playerid][pFreeWorks] -= 1;
		
		TaxiData[passanger_id][eTaxiDriver] = playerid;
		TaxiData[passanger_id][eTaxiActive] = (true);
		TaxiData[passanger_id][eTaxiPayment] = 0;
		TaxiData[passanger_id][eTaxiTraveled] = 1;
		TaxiData[passanger_id][eTaxiMetersFare] = TaxiData[playerid][eTaxiMetersFare];
		TaxiData[passanger_id][eTaxiFare] = TaxiData[playerid][eTaxiFare];	
		
		TaxiData[playerid][eTaxiStartPos][0] = X;
		TaxiData[playerid][eTaxiStartPos][1] = Y;
		TaxiData[playerid][eTaxiStartPos][2] = Z;
		TaxiData[passanger_id][eTaxiStartPos][0] = X;
		TaxiData[passanger_id][eTaxiStartPos][1] = Y;
		TaxiData[passanger_id][eTaxiStartPos][2] = Z;
    }
	if(strcmp(action,"setfare",true) == 0) {
		new fare, buffer_f[12], meters;
		
        if(PlayerJob[playerid][pFreeWorks] < 1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes vise raditi!");
			
    	if(TaxiData[playerid][eTaxiDuty] == false) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na Taxi duznosti!");
			
		if(!IsATaxi(GetVehicleModel(GetPlayerVehicleID(playerid)))) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u taksiju!");
		
		if(sscanf( params, "s[14]ii", action, fare, meters)) 
			return SendClientMessage( playerid, -1, "[KORISTI]: /taxi setfare [fare][meters]."), SendClientMessage(playerid, 0xAFAFAFAA, "=> Fare je koliko cete zaraditi dolara svakih '?' metara."), 
				SendClientMessage(playerid, 0xAFAFAFAA, "=> 'Meters' je na koliko odvozenih metara ce te dobiti novac.");
		
		if(fare < DEFAULT_TAXI_FARE) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Fare ne smije biti manji od defualt postavljenog (%s = defualt).", DEFAULT_TAXI_FARE);		
		if(meters < 500) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Meters ne smije biti manji od 500(m).");	
		if(fare > 10) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Fare ne smije biti veci od 10$.");	
				
		TaxiData[playerid][eTaxiFare] = fare;
		TaxiData[playerid][eTaxiMetersFare] = meters;
		
		format(buffer_f, sizeof(buffer_f), "Fare:_~g~%s", FormatNumber(TaxiData[playerid][eTaxiFare]));
		PlayerTextDrawSetString(playerid, Taximeter[playerid][6], buffer_f);
		
		va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavavili novu cijenu, sada po kilometru zaradujete %s.", FormatNumber(fare));
	}
	if(strcmp(action,"duty",true) == 0) {
		if(!IsATaxi(GetVehicleModel(GetPlayerVehicleID(playerid)))) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u taksiju!");
			
  		if(TaxiData[playerid][eTaxiDuty] == false) {
			if(PlayerJob[playerid][pFreeWorks] < 1) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes vise raditi!");
			
			// Vars
			new buffer_t[MAX_PLAYER_NAME], buffer_f[12];
			TaxiData[playerid][eTaxiDuty] = true;
			TaxiData[playerid][eTaxiMetersFare] = DEFAULT_TAXI_METERS_FARE;
			TaxiData[playerid][eTaxiFare] = DEFAULT_TAXI_FARE;
			CreateTaximeter(playerid, true);
			
			// format
			format(buffer_t, sizeof(buffer_t), "Taxist:_%s", GetName(playerid));
			format(buffer_f, sizeof(buffer_f), "Fare:_~g~%s", FormatNumber(TaxiData[playerid][eTaxiFare]));
		
			PlayerTextDrawSetString(playerid, Taximeter[playerid][9], "Passenger:_None");
			PlayerTextDrawSetString(playerid, Taximeter[playerid][5], "Destination:_None");
			PlayerTextDrawSetString(playerid, Taximeter[playerid][8], "~y~Current_Fare:_0$");
			
			PlayerTextDrawSetString(playerid, Taximeter[playerid][7], buffer_t);
			PlayerTextDrawSetString(playerid, Taximeter[playerid][6], buffer_f);
			
			// Msg
			SendMessage(playerid, MESSAGE_TYPE_INFO,"Sada si na duznosti kao taxi vozac, postavite vasu cijenu na /taxi setfare!");
			format(string, sizeof(string), "* Taxist %s je sada na duznosti. (( /jobduty))", GetName(playerid, false));
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else if(TaxiData[playerid][eTaxiDuty] == true) {		
			SendMessage(playerid, MESSAGE_TYPE_INFO,"Viste niste na duznosti kao taxi vozac!");
			ResetTaxiVariables(playerid);
		}
    }
 	return (true);
}

