#include <YSI_Coding\y_hooks>

#define WEED_SPEED_MUL   0.3
#define COKE_SPEED_MUL   1.0
#define CRACK_SPEED_MUL  0.8
#define CMETH_SPEED_MUL  0.75
#define MAX_Z_VEL 0.02

#define DRUG_DEALER_ID			(10)

#define HCl_DILUTED				(100)
#define MURIATIC_ACID			(200)
#define HYDROGEN_CHLORIDE		(300)

#define MAX_PACKAGE_GRAMS		(200)
#define MAX_DRUG_USES			(300)

/*
	######## ##    ## ##     ## ##     ##  ######
	##       ###   ## ##     ## ###   ### ##    ##
	##       ####  ## ##     ## #### #### ##
	######   ## ## ## ##     ## ## ### ##  ######
	##       ##  #### ##     ## ##     ##       ##
	##       ##   ### ##     ## ##     ## ##    ##
	######## ##    ##  #######  ##     ##  ######
*/
enum E_PLANT_DATA
{
	wdSQLID,
	wObjectID,
	wPlanted,
	wHoursPassed,
	wReady,
	wViwo,
	wGrams,
	Float:wPlantX,
	Float:wPlantY,
	Float:wPlantZ,
	wAutor[MAX_PLAYER_NAME]
}
stock
	WeedInfo[MAX_PLANTS][E_PLANT_DATA];

enum E_METH_LAB_DATA
{
	Float:posX,
	Float:posY,
	Float:posZ
}
stock static
	PlayerMethLab[MAX_PLAYERS][E_METH_LAB_DATA];

enum E_METH_COOKING_DATA
{
	bool:HClInputed,
	bool:MuriaticAcidInputed,
	bool:HydrogenChlorideInputed
}
stock static
	MethCookingInfo[MAX_PLAYERS][E_METH_COOKING_DATA];


/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

stock
	CokeDeliveryPlace1	= 0,
	CokeDeliveryPlace2	= 0,
	CokePlaceGrams		= 0,
	Iterator:Marijuana<MAX_PLANTS>;

static stock
	bigquery[512];

// Player Vars
static stock
	HealthLostTimer[MAX_PLAYERS],
	DestroyLabTimer[MAX_PLAYERS],
	CookingTimer[MAX_PLAYERS],
	CookingRecipe[MAX_PLAYERS],
	Bit1: gr_LijekUsed			<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1: gr_CrackFistPlayer	<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1: gr_Lijek				<MAX_PLAYERS> = { Bit1: false, ... },
	Bit8: gr_SecondsPassed		<MAX_PLAYERS> = { Bit8: 0, ... },
	Bit8: gr_DrugHealthLost		<MAX_PLAYERS> = { Bit8: 0, ... },
	Bit8: gr_DrugAddictionTime	<MAX_PLAYERS> = { Bit8: 15, ... };

stock
	JohnsFader[MAX_PLAYERS],
	PlayerText:JohnsText[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

new const
	MuriaticAcidJohnString[5][] = {
	"Oh, Muriac... Kako se ovo cita? Muriatic acid, dodaj to!",
	"Acid, trebamo acid! Ulijete to!",
	"Nisam 100 posto siguran, ali ovdje pise Acid. Imamo li to?",
	"Gledam u papiric i pise Mu. Imamo li toga?",
	"Uh nije Caustic Soda... Ma ulij Muriatic Acid!"
};

new const
	CausticSodaJohnString[5][] = {
	"Caustic reakcija je potrebna.Imamo li ovdje negdje sode?",
	"Caustic chloride. Kaze u tekucini... Pricekaj malo... Zar nije to soda?",
	"Trebamo Muriatic Acid... Oh cekaj!Trebamo Caustic Soda.. Da nju trebamo.",
	"Ovaj papiric je skoro unisten.Ubaci Caustic Sodu.",
	"Ubaci Cs za nastavak procesa!"
};

new const
	HydrogenChlorideJohnString[5][] = {
	"Jebem ti sta ovdje pise? Ma ubaci klorid!",
	"Hydrogen Chloride je... CEKAJ! Ma ne samo ga stavi!",
	"Nisam 100 posto siguran, ali ovdje pise HCl.. Imamo li to?",
	"Pise hydrogen.. Imamo li ga?",
	"Nisam 100% za ovu kombinaciju ali ubaci malo klorida!"
};

/*
	######## #### ##     ## ######## ########   ######
	   ##     ##  ###   ### ##       ##     ## ##    ##
	   ##     ##  #### #### ##       ##     ## ##
	   ##     ##  ## ### ## ######   ########   ######
	   ##     ##  ##     ## ##       ##   ##         ##
	   ##     ##  ##     ## ##       ##    ##  ##    ##
	   ##    #### ##     ## ######## ##     ##  ######
*/
forward JohnTextDrawFade(playerid);
public JohnTextDrawFade(playerid)
{
	KillTimer( JohnsFader[playerid] );
	PlayerTextDrawHide(playerid, JohnsText[playerid]);
}

forward OnPlayerAddictionHealthLost(playerid, Float:healthlost, Float:healthcap);
public OnPlayerAddictionHealthLost(playerid, Float:healthlost, Float:healthcap)
{
	if(Bit8_Get(gr_DrugHealthLost, playerid))
	{
		new Float:health;
		GetPlayerHealth(playerid, health);

		if( health < healthcap ) {
			SetPlayerHealth(playerid, health-healthlost);
		}

		Bit8_Set(gr_DrugHealthLost, playerid, Bit8_Get(gr_DrugHealthLost, playerid) - 1);
		if(!Bit8_Get(gr_DrugHealthLost, playerid)) {
			KillTimer(HealthLostTimer[playerid]);
			Bit8_Set(gr_DrugHealthLost, playerid, 0);
		}
	}
	return 1;
}

forward OnMethLabDestroy(playerid);
public OnMethLabDestroy(playerid)
{
	KillTimer(DestroyLabTimer[playerid]);
	DestroyJohnsTextDraw(playerid);
	DestroyLab(playerid);
	return 1;
}

forward OnPlayerCookMeth(playerid);
public OnPlayerCookMeth(playerid)
{
	if(!IsPlayerInRangeOfPoint(playerid, 6.0, PlayerMethLab[playerid][posX], PlayerMethLab[playerid][posY],	PlayerMethLab[playerid][posZ])) return DestroyLab(playerid);

	Bit8_Set(gr_SecondsPassed, playerid, Bit8_Get(gr_SecondsPassed, playerid) + 1);
	new
		tmpString[ 80 ];
	if(Bit8_Get(gr_SecondsPassed, playerid) == 60)
	{
		new
			x = random(sizeof(CausticSodaJohnString));

		PlayerTextDrawShow(playerid, JohnsText[playerid]);
		format(tmpString, sizeof(tmpString), "~g~John:~w~ %s", CausticSodaJohnString[x]);
		PlayerTextDrawSetString(playerid, JohnsText[playerid], tmpString);

		JohnsFader[playerid] = SetTimerEx("JohnTextDrawFade", 11000, false, "i", playerid);
		CookingRecipe[playerid] = HCl_DILUTED;
	}
	else if(Bit8_Get(gr_SecondsPassed, playerid) == 120)
	{
		if(CookingRecipe[playerid] != 0) return DestroyLab(playerid);

		new
			x = random(sizeof(MuriaticAcidJohnString));
		PlayerTextDrawShow(playerid, JohnsText[playerid]);
		format(tmpString, sizeof(tmpString), "~g~John:~w~ %s", MuriaticAcidJohnString[x]);
		PlayerTextDrawSetString(playerid, JohnsText[playerid], tmpString);

		JohnsFader[playerid] = SetTimerEx("JohnTextDrawFade", 11000, false, "i", playerid);
		CookingRecipe[playerid] = MURIATIC_ACID;
	}
	else if(Bit8_Get(gr_SecondsPassed, playerid) == 180)
	{
		if(CookingRecipe[playerid] != 0) return DestroyLab(playerid);

		new
			x = random(sizeof(HydrogenChlorideJohnString));
		PlayerTextDrawShow(playerid, JohnsText[playerid]);
		format(tmpString, sizeof(tmpString), "~g~John:~w~ %s", HydrogenChlorideJohnString[x]);
		PlayerTextDrawSetString(playerid, JohnsText[playerid], tmpString);

		JohnsFader[playerid] = SetTimerEx("JohnTextDrawFade", 11000, false, "i", playerid);
		CookingRecipe[playerid] = HYDROGEN_CHLORIDE;
	}
	if(Bit8_Get(gr_SecondsPassed, playerid) > 180)
	{
		DestroyJohnsTextDraw(playerid);
		KillTimer(CookingTimer[playerid]);
		Bit8_Set(gr_SecondsPassed, playerid, 0);
	}
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

Public:LoadPlayerDrugs(playerid)
{
	new
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `player_drugs` WHERE `player_id` = '%d' LIMIT 0,5",
		PlayerInfo[playerid][pSQLID]
	);
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
	    for( new i = 0; i < cache_num_rows(); i++ ) 
		{
			cache_get_value_name_int(i, "id", PlayerDrugs[playerid][dSQLID][i]);
			cache_get_value_name_int(i, "code", PlayerDrugs[playerid][dCode][i]);
			cache_get_value_name_float(i, "amount", PlayerDrugs[playerid][dAmount][i]);
			cache_get_value_name_int(i, "effect", PlayerDrugs[playerid][dEffect][i]);
			cache_get_value_name_int(i, "timestamp", PlayerDrugs[playerid][dTimeStamp][i]);
		}
	}
	return 1;
}

Public:OnVehicleDrugInsert(vehicleid, slot)
{
	VehicleInfo[vehicleid][vDrugSQLID][slot] = cache_insert_id();
	return 1;
}


stock static GetPlayerDrugEffect(playerid, slotid)
{
	if(IsAMarijuana(PlayerDrugs[playerid][dCode][slotid]))
		return 2;
	else if(IsACocaine(PlayerDrugs[playerid][dCode][slotid]))
		return 6;
	else if(IsACrack(PlayerDrugs[playerid][dCode][slotid]))
		return 4;
	else if(IsAMethamphetamine(PlayerDrugs[playerid][dCode][slotid]))
		return 4;
	else if(IsAEcstasy(PlayerDrugs[playerid][dCode][slotid]))
		return 6;
	else if(IsAHeroin(PlayerDrugs[playerid][dCode][slotid]))
		return 5;
	return 0;
}
SavePlayerDrugSlot(playerid, slotid)
{
	if(PlayerDrugs[playerid][dCode][slotid] == 0) return 1;
	if( !SafeSpawned[playerid] )  return 1;

	PlayerDrugs[playerid][dEffect][slotid] = GetPlayerDrugEffect(playerid, slotid);
	
	if(PlayerDrugs[playerid][dSQLID][slotid] != -1 && PlayerDrugs[playerid][dAmount][slotid] >= 0.1)
	{
		new
			drugUpdate[128];
		format(drugUpdate, 128, "UPDATE `player_drugs` SET `code`='%d', `amount`='%.2f', `effect`='%d', `timestamp`='%d' WHERE `id`='%d'",
			PlayerDrugs[playerid][dCode][slotid],
			PlayerDrugs[playerid][dAmount][slotid],
			PlayerDrugs[playerid][dEffect][slotid],
			PlayerDrugs[playerid][dTimeStamp][slotid],
			PlayerDrugs[playerid][dSQLID][slotid]
		);
		mysql_tquery(g_SQL, drugUpdate, "", "");
	} 
	else if(PlayerDrugs[playerid][dSQLID][slotid] == -1)
	{		
		new
			drugInsert[170];
		format(drugInsert, 170, "INSERT INTO `player_drugs`(`player_id`,`code`,`amount`,`effect`,`timestamp`) VALUES ('%d','%d','%.2f','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerDrugs[playerid][dCode][slotid],
			PlayerDrugs[playerid][dAmount][slotid],
			PlayerDrugs[playerid][dEffect][slotid],
			PlayerDrugs[playerid][dTimeStamp][slotid]
		);
		mysql_tquery(g_SQL, drugInsert, "OnDrugInsertQuery", "ii", playerid, slotid);
	}
	else if( PlayerDrugs[playerid][dAmount][slotid] <= 0.09 && PlayerDrugs[playerid][dSQLID][slotid] != -1) 
	{
		// SQL
		new
			drugFinishQuery[128];
		format(drugFinishQuery, 128, "DELETE FROM `player_drugs` WHERE `id` = '%d'", PlayerDrugs[playerid][dSQLID][slotid]);
		mysql_tquery(g_SQL, drugFinishQuery, "", "");
		
		PlayerDrugs[playerid][dSQLID][slotid]	= -1;
		PlayerDrugs[playerid][dAmount][slotid] = 0;
		PlayerDrugs[playerid][dCode][slotid] = 0;
		PlayerDrugs[playerid][dEffect][slotid] = 0;
	}
	return 1;
}

stock SavePlayerDrugs(playerid)
{
	SavePlayerDrugSlot(playerid, 0);
	SavePlayerDrugSlot(playerid, 1);
	SavePlayerDrugSlot(playerid, 2);
	SavePlayerDrugSlot(playerid, 3);
	SavePlayerDrugSlot(playerid, 4);
	return 1;
}

stock DeletePlayerDrugs(playerid)
{
	new
		drugFinishQuery[128];
	format(drugFinishQuery, 128, "DELETE FROM `player_drugs` WHERE `player_id` = '%d'", PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, drugFinishQuery, "", "");
	
	for(new i = 0; i < 5; i++)
	{
		PlayerDrugs[playerid][dSQLID][i]	= -1;
		PlayerDrugs[playerid][dAmount][i] = 0;
		PlayerDrugs[playerid][dCode][i] = 0;
		PlayerDrugs[playerid][dEffect][i] = 0;
		PlayerDrugs[playerid][dTimeStamp][i] = 0;
	}
	return 1;
}

stock ListPlayerDrugs(playerid)
{
	new dinfo[1024],
		qualityString[20],
		motd[128];
		
	for (new i = 0; i < MAX_PLAYER_DRUGS; i ++)
	{
		if(IsAExcelentDrug(PlayerDrugs[playerid][dCode][i]))
			format(qualityString, sizeof(qualityString), "Odlicna");
		if(IsAGoodDrug(PlayerDrugs[playerid][dCode][i]))
			format(qualityString, sizeof(qualityString), "Dobra");
		if(IsABadDrug(PlayerDrugs[playerid][dCode][i]))
			format(qualityString, sizeof(qualityString), "Losa");
		if(IsAVeryBadDrug(PlayerDrugs[playerid][dCode][i]))
			format(qualityString, sizeof(qualityString), "Vrlo losa");

		if(i == (MAX_PLAYER_DRUGS - 1))
		{
			if(PlayerDrugs[playerid][dCode][i] != 0)
				format(motd, sizeof(motd), "\t{3C95C2}[Slot %d]: %s [%.2f g][Kvaliteta: %s]", i+1, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]), PlayerDrugs[playerid][dAmount][i], qualityString);
			else
				format(motd, sizeof(motd), "\t{3C95C2}[Slot %d]: Prazno", i+1);
		}
		else
		{
			if(PlayerDrugs[playerid][dCode][i] != 0)
				format(motd, sizeof(motd), "\t{3C95C2}[Slot %d]: %s [%.2f g][Kvaliteta: %s]\n", i+1, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]), PlayerDrugs[playerid][dAmount][i], qualityString);
			else
				format(motd, sizeof(motd), "\t{3C95C2}[Slot %d]: Prazno\n", i+1);
		}
		strcat(dinfo, motd, sizeof(dinfo));
		
	}
	return dinfo;
}

stock DrugAddictionCheck(playerid)
{
	new picked = 1 + random(2);
	if(picked == 1) return 1;
	else if(picked == 2)
	{
		if( Bit1_Get(gr_Lijek, playerid) )
		{
			Bit1_Set(gr_Lijek, playerid, 0);
			return 1;
		}
		else
		{
			new Float:health;
			GetPlayerHealth(playerid, health);
			if(floatcmp(health, 40.0) == 1)
			{
				if(PlayerInfo[playerid][pDrugAddict] == 1) //level 1
				{
					if(PlayerInfo[playerid][pCokeAddict]) {
						SendMessage(playerid, MESSAGE_TYPE_INFO, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 2.0% HPa 10 sekundi!");
						PlayerInfo[playerid][pHunger] -= 0.5;
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[ 92 ];
						format(tmpString, sizeof(tmpString), "* %s izgleda poprilicno blijedo, ima podocnjake i dise glasno i ubrzano (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 2.0, 5.0);
					}
					else if(PlayerInfo[playerid][pCrackAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 2.5% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 0.6;
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s ima duboke podocnjake i dise veoma brzo i glasno, cini se kao da je umoran (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 2.5, 5.0);
					}
					else if(PlayerInfo[playerid][pMethAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 0.7;
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[ 111 ];
						format(tmpString, sizeof(tmpString), "* %s ima vidljive podocnjake, disanje i akcije su mu veoma ubrzane (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.0, 5.0);
					}
					return 1;
				}
				else if(PlayerInfo[playerid][pDrugAddict] == 2) //level 2
				{
					if(PlayerInfo[playerid][pCokeAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 0.8;
						SetPlayerDrunkLevel (playerid, 4000);
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[124];
						format(tmpString, sizeof(tmpString), "* %s ima duboke podocnjake, izgleda umorno i disanje mu zvuci kao psece rezanje (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.0, 5.0);
					}
					else if(PlayerInfo[playerid][pCrackAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.5% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 0.9;
						SetPlayerDrunkLevel (playerid, 5000);
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s ima zute zube, podocnjake i dise veoma glasno, i ima suh iritantni kasalj (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.5, 5.0);
					}
					else if(PlayerInfo[playerid][pMethAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 4.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.0;
						SetPlayerDrunkLevel (playerid, 5500);
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[124];
						format(tmpString, sizeof(tmpString), "* %s izgleda kao da je brzo izgubio na tezini i dise brzo i glasno (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 4.0, 5.0);
					}
					return 1;
				}
				else if(PlayerInfo[playerid][pDrugAddict] == 3) //level 3
				{
					if(PlayerInfo[playerid][pCokeAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.1;
						SetPlayerDrunkLevel (playerid, 10000);
						SetPlayerWeather(playerid, 32);
						Bit8_Set(gr_DrugHealthLost, playerid, 10);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s izgleda kao da ima ostecene sinuse, ima duboke podocnjake i znoji se brzo (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.0, 5.0);
					}
					else if(PlayerInfo[playerid][pCrackAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.5% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.2;
						SetPlayerDrunkLevel (playerid, 15000);
						SetPlayerWeather(playerid, 19);

						new
							tmpString[ 115 ];
						format(tmpString, sizeof(tmpString), "* %s ima duboke podocnjake i dise glasno i ima velike promjene na licu (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.5, 5.0);
					}
					else if(PlayerInfo[playerid][pMethAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 4.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.3;
						SetPlayerDrunkLevel (playerid, 20000);
						SetPlayerWeather(playerid, 42);

						new
							tmpString[ 95 ];
						format(tmpString, sizeof(tmpString), "* %s ima duboke podocnjake, te crne i nikakve zube (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 4.0, 5.0);
					}
					return 1;
				}
				else if(PlayerInfo[playerid][pDrugAddict] == 4) //level 4
				{
					if(PlayerInfo[playerid][pCokeAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.1;
						SetPlayerDrunkLevel (playerid, 10000);
						SetPlayerWeather(playerid, 32);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s nos i sinusi mu se cine poprilicno unisteni i ima veoma duboke podocnjake (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.0, 5.0);
					}
					else if(PlayerInfo[playerid][pCrackAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.5% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.2;
						SetPlayerDrunkLevel (playerid, 15000);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);
						SetPlayerWeather(playerid, 19);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s ima krvave oci i duboke podocnjake, oci su mu skoro pa zatvorene i kaslje veoma ucestalo (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.5, 5.0);
					}
					else if(PlayerInfo[playerid][pMethAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 4.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.3;
						SetPlayerDrunkLevel (playerid, 20000);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);
						SetPlayerWeather(playerid, 42);

						new
							tmpString[ 116 ];
						format(tmpString, sizeof(tmpString), "* %s ima crne zube i unistene desne, duboke podocnjake, veliki broj bubuljica (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 4.0, 5.0);
					}
					return 1;
				}
				else if(PlayerInfo[playerid][pDrugAddict] == 5) //level 5
				{
					if(PlayerInfo[playerid][pCokeAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.1;
						SetPlayerDrunkLevel (playerid, 10000);
						SetPlayerWeather(playerid, 32);
						StopAudioStreamForPlayer(playerid);
						PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/soaeofatfh/level5.mp3");
						GameTextForPlayer(playerid, "Trebas jos droge", 5000, 1);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);

						new
							tmpString[ 121 ];
						format(tmpString, sizeof(tmpString), "* %s ima duboke podocnjake, disanje mu zvuci kao rezanje zivotinje, te dise glasno (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.0, 5.0);
					}
					else if(PlayerInfo[playerid][pCrackAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 3.5% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.2;
						SetPlayerDrunkLevel (playerid, 15000);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);
						SetPlayerWeather(playerid, 19);
						StopAudioStreamForPlayer(playerid);
						PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/soaeofatfh/level5.mp3");
						GameTextForPlayer(playerid, "Trebas jos droge", 5000, 1);

						new
							tmpString[ 124 ];
						format(tmpString, sizeof(tmpString), "* %s ima unistene zube, krvave oci i krvave usne, rane na licu, kaslje veoma ucestalo (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 3.5, 5.0);
					}
					else if(PlayerInfo[playerid][pMethAddict]) {
						SendClientMessage(playerid, COLOR_RED, "Ovisnost je pocela djelovati, uzmite novu dozu droge ili cete svake sekunde gubiti 4.0% HPa 10 sekundi!");

						PlayerInfo[playerid][pHunger] -= 1.3;
						SetPlayerDrunkLevel (playerid, 20000);
						ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1, 0);
						SetPlayerWeather(playerid, 42);
						StopAudioStreamForPlayer(playerid);
						PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/soaeofatfh/level5.mp3");
						GameTextForPlayer(playerid, "Trebas jos droge", 5000, 1);

						new
							tmpString[ 114 ];
						format(tmpString, sizeof(tmpString), "* %s unistene zube, duboke podocnjake, veliki broj bubuljica i rane na licu (( Ovisnost )).",
							GetName(playerid, true)
						);
						ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Bit8_Set(gr_DrugHealthLost, playerid, 10);
						HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, 4.0, 5.0);
					}
					return 1;
				}
				Bit8_Set(gr_DrugAddictionTime, playerid, 15);
				if(PlayerInfo[playerid][pHunger] <= -5.0) PlayerInfo[playerid][pHunger] = -5.0;
			}
		}
	}
	return 1;
}

stock SetPlayerDrugEffect(playerid)
{
	if( PlayerInfo[playerid][pDrugUsed] ) {
		new
			lastdrug = PlayerInfo[playerid][pLastDrug];
		if( IsAMarijuana(lastdrug) ) {
		    ApplyAnimationEx(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0,1,0);
 			SetPlayerSpecialAction(playerid,21);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/vq8mxj3b0h/parrot.mp3");

		}
		else if( IsACocaine(lastdrug) ) {
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/2it0g5dtyh/heartbeat.mp3");

		}
		else if( IsACrack(lastdrug) ) {
			SetPlayerWeather(playerid, 21);
			SetPlayerDrunkLevel (playerid, 5000);
		}
		else if( IsAMethamphetamine(lastdrug) ) {
			ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerDrunkLevel (playerid, 10000);
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/7fj9ysbskh/level5.mp3");
			SetPlayerWeather(playerid, 9);
		}
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if( PlayerInfo[playerid][pDrugUsed] ) 
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			new keys, ud, lr;
			GetPlayerKeys(playerid, keys, ud, lr);

			if((ud != 0 || lr != 0) && !(keys & KEY_JUMP))
			{
				new Float:v0[3];
				GetPlayerVelocity(playerid, v0[0], v0[1], v0[2]);
				if(v0[2] >= -MAX_Z_VEL && v0[2] <= MAX_Z_VEL) 
				{
					if(IsAMarijuana(PlayerInfo[playerid][pLastDrug]))
						SetPlayerVelocity(playerid, v0[0] * WEED_SPEED_MUL, v0[1] * WEED_SPEED_MUL, v0[2] * WEED_SPEED_MUL);
					if(IsACocaine(PlayerInfo[playerid][pLastDrug]))
						SetPlayerVelocity(playerid, v0[0] * COKE_SPEED_MUL, v0[1] * COKE_SPEED_MUL, v0[2] * COKE_SPEED_MUL);
					if(IsACrack(PlayerInfo[playerid][pLastDrug]))
						SetPlayerVelocity(playerid, v0[0] * CRACK_SPEED_MUL, v0[1] * CRACK_SPEED_MUL, v0[2] * CRACK_SPEED_MUL);
					if(IsAMethamphetamine(PlayerInfo[playerid][pLastDrug]))
						SetPlayerVelocity(playerid, v0[0] * CMETH_SPEED_MUL, v0[1] * CMETH_SPEED_MUL, v0[2] * CMETH_SPEED_MUL);
				}
			}
		}
	}
	return 1;
}

stock static GetFreeWeedId()
{
	new
		plantid = -1;
	for( new x = 0; x < MAX_PLANTS; x++ ) {
		if( WeedInfo[ x ][ wPlantX ] == 0.0 && WeedInfo[ x ][ wPlantY ] == 0.0 ) {
			plantid = x;
			break;
		}
	}
	return plantid;
}

stock CreateJohnsTextDraw(playerid)
{
	JohnsText[playerid] = CreatePlayerTextDraw(playerid, 168.700012, 379.623931, "~g~John:~w~ Trebamo Muriatic Acid... Oh cekaj!~n~Trebamo Caustic Soda.. Da nju trebamo.");
	PlayerTextDrawLetterSize(playerid, 		JohnsText[playerid], 0.425799, 1.364800);
	PlayerTextDrawAlignment(playerid, 		JohnsText[playerid], 1);
	PlayerTextDrawColor(playerid,			JohnsText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		JohnsText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		JohnsText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JohnsText[playerid], 51);
	PlayerTextDrawFont(playerid, 			JohnsText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JohnsText[playerid], 1);
	return 1;
}

stock DestroyJohnsTextDraw(playerid)
{
	PlayerTextDrawDestroy(playerid, JohnsText[playerid]);
	JohnsText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock IsAExcelentDrug(drug)
{
	start:
	drug -= 1000;
	if(drug > 1000)
		goto start;
	if(750 <= drug && drug <= 999)
		return true;
	else return false;
}

stock IsAGoodDrug(drug)
{
	start:
	drug -= 1000;
	if(drug > 1000)
		goto start;
	if(750 > drug && drug >= 500)
		return true;
	else return false;
}

stock IsABadDrug(drug)
{
	start:
	drug -= 1000;
	if(drug > 1000)
		goto start;
	if(500 > drug && drug >= 250)
		return true;
	else return false;
}

stock IsAVeryBadDrug(drug)
{
	start:
	drug -= 1000;
	if(drug > 1000)
		goto start;
	if(250 > drug && drug > 0)
		return true;
	else return false;
}

stock CompareDrugQuality(dcode1, dcode2)
{
	new bool:output = false;
	if(IsAExcelentDrug(dcode1) && IsAExcelentDrug(dcode2))
		output = true; 
	else if(IsAGoodDrug(dcode1) && IsAGoodDrug(dcode2))
		output = true;
	else if(IsABadDrug(dcode1) && IsABadDrug(dcode2))
		output = true;
	else if(IsAVeryBadDrug(dcode1) && IsAVeryBadDrug(dcode2))
		output = true;
	return output;
}

stock CompareDrugs(drug1, drug2)
{
	if( IsAMarijuana(drug1) && IsAMarijuana(drug2) )
		return 1;
	else if( IsACocaine(drug1) && IsACocaine(drug2) )
		return 1;
	else if( IsACrack(drug1) && IsACrack(drug2) )
		return 1;
	else if( IsAMethamphetamine(drug1) && IsAMethamphetamine(drug2) )
		return 1;
 	else if( IsAEcstasy(drug1) && IsAEcstasy(drug2) )
		return 1;
	else if( IsAHeroin(drug1) && IsAHeroin(drug2) )
		return 1;
	return 0;
}

stock IsAMarijuana(drugid)
{
	if(drugid >= 1000 && drugid <= 1999) {
	    return true;
	}
	return false;
}

stock IsACocaine(drugid)
{
	if(drugid >= 5000 && drugid <= 5999) {
	    return true;
	}
	return false;
}

stock IsACrack(drugid)
{
	if(drugid >= 6000 && drugid <= 6999) {
	    return true;
	}
	return false;
}

stock IsAMethamphetamine(drugid)
{
	if(drugid >= 7000 && drugid <= 7999) {
	    return true;
	}
	return false;
}

stock IsAEcstasy(drugid)
{
	if(drugid >= 11000 && drugid <= 11999)
	{
	    return true;
	}
	return false;
}

stock IsAHeroin(drugid)
{
	if(drugid >= 12000 && drugid <= 12999)
	{
	    return true;
	}
	return false;
}

stock GetDrugName(drugid)
{
	new
	    name[16];
	switch(drugid)
	{
		case 1000..1999: //Marijuana
			strcat(name, "Marijuana", 16);
		case 5000..5999: //Cocaine
    		strcat(name, "Cocaine", 16);
		case 6000..6999: //Crack
    		strcat(name, "Crack", 16);
		case 7000..7999: //Methamphetamine
    		strcat(name, "Methamphetamine", 16);
  		case 8000..8999: //Ecstasy
    		strcat(name, "Ecstasy", 16);
  		case 9000..9999: //Heroin
    		strcat(name, "Heroin", 16);
		default:
			strcat(name, "Prazno", 16);
	}
	return name;
}

stock GetDrugNameByDrugID(drugid)
{
	new
		name[16];
	switch(drugid)
	{
		case 1000..1999: //Marijuana
			strcat(name, "Marijuana", 16);
		case 5000..5999: //Cocaine
    		strcat(name, "Cocaine", 16);
		case 6000..6999: //Crack
    		strcat(name, "Crack", 16);
		case 7000..7999: //Methamphetamine
    		strcat(name, "Methamphetamine", 16);
  		case 8000..8999: //Ecstasy
    		strcat(name, "Ecstasy", 16);
  		case 9000..9999: //Heroin
    		strcat(name, "Heroin", 16);
		default:
			strcat(name, "Prazno", 16);
	}
	return name;
}

stock IsPlayerNearMarijuana(playerid)
{
	new
		plantid = -1;
	foreach(new i : Marijuana)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, WeedInfo[i][wPlantX], WeedInfo[i][wPlantY], WeedInfo[i][wPlantZ])) {
			plantid = i;
			break;
		}
	}
	return plantid;
}

stock LoadWeed()
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "SELECT * FROM weed WHERE 1 LIMIT 0,%d", MAX_PLANTS);
	mysql_tquery(g_SQL, tmpQuery, "OnWeedLoaded");
	return 1;
}

Public:OnDrugInsertQuery(playerid, slotid)
{
	PlayerDrugs[playerid][dSQLID][slotid] = cache_insert_id();
	return 1;
}

forward OnWeedLoaded();
public OnWeedLoaded()
{
	new
		count = cache_num_rows(),
		tmpValue[ 24 ];
	if( !count ) return printf("MySQL Report: No weed exist to load.");
 	for( new b = 0; b < count; b++ )
	{
		cache_get_value_name_int	(b, "id"			, WeedInfo[b][wdSQLID]);
	    cache_get_value_name_int	(b, "objectid"		, WeedInfo[b][wObjectID]);
	    cache_get_value_name_int	(b, "planted"		, WeedInfo[b][wPlanted]);
	    cache_get_value_name_float	(b, "plantx"		, WeedInfo[b][wPlantX]);
	    cache_get_value_name_float	(b, "planty"		, WeedInfo[b][wPlantY]);
	    cache_get_value_name_float	(b, "plantz"		, WeedInfo[b][wPlantZ]);
	    cache_get_value_name_int	(b, "hourspassed"	, WeedInfo[b][wHoursPassed]);
	    cache_get_value_name_int	(b, "viwo"			, WeedInfo[b][wViwo]);
	    cache_get_value_name_int	(b, "grams"			, WeedInfo[b][wGrams]);
	    cache_get_value_name_int	(b, "ready"			, WeedInfo[b][wReady]);
		
	    cache_get_value_name(b, "author", tmpValue);
		format(WeedInfo[b][wAutor], 24, tmpValue);

	    WeedInfo[b][wObjectID] = CreateDynamicObject(19473, WeedInfo[b][wPlantX], WeedInfo[b][wPlantY], WeedInfo[b][wPlantZ], 0.0, 0.0, 96.0, WeedInfo[b][wViwo], -1, -1, 100.0);
		Iter_Add(Marijuana, b);
	}
	printf("MySQL Report: Weed Loaded (%d)!", Iter_Count(Marijuana));
	return 1;
}

Public:OnWeedCreated(weedid)
{
	WeedInfo[weedid][wdSQLID] = cache_insert_id();
	return 1;
}

stock static CreateWeed(weedid, Objectid, viwo, Planted, Hourspassed, Ready, Grams, Autor[], Float:X, Float:Y, Float:Z)
{
	strmid(WeedInfo[weedid][wAutor], Autor, 0, strlen(Autor), 24);

	mysql_tquery(g_SQL, "BEGIN", "");
	new
		tmpQuery[ 256 ];
	format(tmpQuery, 256, "INSERT INTO weed (`objectid`, `planted`, `hourspassed`, `ready`, `viwo`, `grams`, `plantx`, `planty`, `plantz`, `author`) VALUES ('%d', '%d', '%d', '%d', '%d','%d','%f','%f','%f','%e')",
		Objectid,
		Planted,
		Hourspassed,
		Ready,
		viwo,
		Grams,
		X,
		Y,
		Z,
		Autor
	);
	mysql_tquery(g_SQL, tmpQuery, "OnWeedCreated", "i", weedid);
	mysql_tquery(g_SQL, "COMMIT", "");
	return 1;
}

stock UpdateWeed(Ready, Hourspassed, Grams, SQLID, Float:X, Float:Y, Float:Z)
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, 256, "UPDATE weed SET hourspassed = '%d', ready = '%d', grams = '%d', plantx = '%.2f', planty = '%.2f', plantz = '%.2f' WHERE `id` = '%d'",
		Hourspassed,
		Ready,
		Grams,
		X,
		Y,
		Z,
		SQLID
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

/*
	.88b  d88. d88888b d888888b db   db
	88'YbdP`88 88'     `~~88~~' 88   88
	88  88  88 88ooooo    88    88ooo88
	88  88  88 88~~~~~    88    88~~~88
	88  88  88 88.        88    88   88
	YP  YP  YP Y88888P    YP    YP   YP
*/
stock IsAMethCooked(playerid)
{
	if(MethCookingInfo[playerid][HClInputed] == true && MethCookingInfo[playerid][MuriaticAcidInputed] == true && MethCookingInfo[playerid][HydrogenChlorideInputed]) return true;
	return 0;
}

stock CheckMethComp(playerid, playerComponent, componentInput)
{
	if(playerComponent == componentInput)
	{
		KillTimer(JohnsFader[playerid]);
		PlayerTextDrawShow(playerid, JohnsText[playerid]);
		PlayerTextDrawSetString(playerid, JohnsText[playerid], "~g~John:~w~ U redu reakcija se cini normalnom!");
		JohnsFader[playerid] = SetTimerEx("JohnTextDrawFade", 5000, false, "i", playerid);

		if(playerComponent == HCl_DILUTED) {
			MethCookingInfo[playerid][HClInputed] = true;
		}
		else if(playerComponent == MURIATIC_ACID)
			MethCookingInfo[playerid][MuriaticAcidInputed] = true;

		else if(playerComponent == HYDROGEN_CHLORIDE)
			MethCookingInfo[playerid][HydrogenChlorideInputed] = true;

		if(IsAMethCooked(playerid)) {
			PlayerTextDrawShow(playerid, JohnsText[playerid]);
			PlayerTextDrawSetString(playerid, JohnsText[playerid], "~g~John:~w~ U redu skuhao si meth!~n~~y~On je spremljen u vas inventory!");
			JohnsFader[playerid] = SetTimerEx("JohnTextDrawFade", 8000, false, "i", playerid);

			new amount = 15 + random(5),
				skill = GetPlayerSkillLevel(playerid, 8),
				drug;
			switch(skill)
			{
				case 0: drug = 7100;
				case 1: drug = 7300;
				case 2: drug = 7400;
				case 3: drug = 7600;
				case 4: drug = 7999;
			}
			UpgradePlayerSkill(playerid, 8);

			if(PlayerDrugs[playerid][dCode][0] == 0)
			{
				PlayerDrugs[playerid][dCode][0] 	= drug;
				PlayerDrugs[playerid][dAmount][0] 		= amount;
				PlayerDrugs[playerid][dTimeStamp][0] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][1] == 0)
			{
				PlayerDrugs[playerid][dCode][1] 	= drug;
				PlayerDrugs[playerid][dAmount][1] 		= amount;
				PlayerDrugs[playerid][dTimeStamp][1] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][2]== 0)
			{
				PlayerDrugs[playerid][dCode][2] 	= drug;
				PlayerDrugs[playerid][dAmount][2] 		= amount;
				PlayerDrugs[playerid][dTimeStamp][2] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][3] == 0)
			{
				PlayerDrugs[playerid][dCode][3] 	= drug;
				PlayerDrugs[playerid][dAmount][3] 		= amount;
				PlayerDrugs[playerid][dTimeStamp][3] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][4] == 0)
			{
				PlayerDrugs[playerid][dCode][4] 	= drug;
				PlayerDrugs[playerid][dAmount][4] 		= amount;
				PlayerDrugs[playerid][dTimeStamp][4] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
		}
		CookingRecipe[playerid] = 0;
	}
	else
	{
		DestroyLabTimer[playerid] = SetTimerEx("OnMethLabDestroy", 6000, false, "i", playerid);
		GameTextForPlayer(playerid, "~g~John:~w~Nismo pogodili recept! Bjezi odatle!", 2000, 1);

		if(playerComponent == HCl_DILUTED) {
			MethCookingInfo[playerid][HClInputed] = false;
		}
		else if(playerComponent == MURIATIC_ACID) {
			MethCookingInfo[playerid][MuriaticAcidInputed] = false;
		}
		else if(playerComponent == HYDROGEN_CHLORIDE) {
			MethCookingInfo[playerid][HydrogenChlorideInputed] = false;
		}
	}
	return 1;
}

stock DestroyLab(playerid)
{
	KillTimer(CookingTimer[playerid]);
	Bit8_Set(gr_SecondsPassed, playerid, 0);
	CookingRecipe[playerid] = 0;

	CreateExplosion(PlayerMethLab[playerid][posX], PlayerMethLab[playerid][posY], PlayerMethLab[playerid][posZ], 1, 15.0);

	PlayerMethLab[playerid][posX] = 0.0;
	PlayerMethLab[playerid][posY] = 0.0;
	PlayerMethLab[playerid][posZ] = 0.0;
	return 1;
}

stock Float:AmountEffectCheck(playerid, dcode)
{
	new Float:minamount = 0.0;
	if(IsAMarijuana(dcode))
	{	
		if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] < MAX_DRUG_USES)
			minamount = 0.5 + (0.5 * (PlayerInfo[playerid][pDrugUses]/50));
		else
			minamount = 0.5;
	}
	else if(IsACocaine(dcode))
	{
		if(PlayerInfo[playerid][pDrugUses] == 0)
			minamount = 0.1;
		else if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] <= 100)
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/20));
		else if ( PlayerInfo[playerid][pDrugUses] > 100 && PlayerInfo[playerid][pDrugUses] <= 200 )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/15));
		else if ( PlayerInfo[playerid][pDrugUses] > 200 && PlayerInfo[playerid][pDrugUses] <= MAX_DRUG_USES )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/10));
	}
	else if(IsACrack(dcode))
	{
		if(PlayerInfo[playerid][pDrugUses] == 0)
			minamount = 0.1;
		else if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] <= 100)
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/20));
		else if ( PlayerInfo[playerid][pDrugUses] > 100 && PlayerInfo[playerid][pDrugUses] <= 200 )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/15));
		else if ( PlayerInfo[playerid][pDrugUses] > 200 && PlayerInfo[playerid][pDrugUses] <= MAX_DRUG_USES )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/10));
	}
	else if(IsAMethamphetamine(dcode))
	{
		if(PlayerInfo[playerid][pDrugUses] == 0)
			minamount = 0.1;
		else if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] <= 100)
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/20));
		else if ( PlayerInfo[playerid][pDrugUses] > 100 && PlayerInfo[playerid][pDrugUses] <= 200 )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/15));
		else if ( PlayerInfo[playerid][pDrugUses] > 200 && PlayerInfo[playerid][pDrugUses] <= MAX_DRUG_USES )
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/10));
	}
	else if(IsAHeroin(dcode))
	{
		if(PlayerInfo[playerid][pDrugUses] == 0)
			minamount = 0.1;
		else if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] <= 100)
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/100));
		else if ( PlayerInfo[playerid][pDrugUses] > 100 && PlayerInfo[playerid][pDrugUses] <= 200 )
		    minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/75));
		else if ( PlayerInfo[playerid][pDrugUses] > 200 && PlayerInfo[playerid][pDrugUses] <= MAX_DRUG_USES )
			minamount = 0.1 + (0.1 * (PlayerInfo[playerid][pDrugUses]/50));
	}
	else if(IsAEcstasy(dcode))
	{
		if(PlayerInfo[playerid][pDrugUses] == 0)
			minamount = 1.0;
		else if(PlayerInfo[playerid][pDrugUses] > 0 && PlayerInfo[playerid][pDrugUses] <= 100)
			minamount = 1.0 + (1.0 * (PlayerInfo[playerid][pDrugUses]/100));
		else if ( PlayerInfo[playerid][pDrugUses] > 100 && PlayerInfo[playerid][pDrugUses] <= 200 )
		    minamount = 1.0 + (1.0 * (PlayerInfo[playerid][pDrugUses]/75));
		else if ( PlayerInfo[playerid][pDrugUses] > 200 && PlayerInfo[playerid][pDrugUses] <= MAX_DRUG_USES )
			minamount = 1.0 + (1.0 * (PlayerInfo[playerid][pDrugUses]/50));
	}
	return minamount;
}

stock Float:AmountEffectMax(dcode)
{
	new Float:maxamount = 0.0;
	if(IsAMarijuana(dcode))
		maxamount = 0.5;
	else if(IsACocaine(dcode))
		maxamount = 0.3;
	else if(IsACrack(dcode))
		maxamount = 0.4;
	else if(IsAMethamphetamine(dcode))
		maxamount = 0.2;
	else if(IsAHeroin(dcode))
		maxamount = 0.2;
	else if(IsAEcstasy(dcode))
		maxamount = 2.0;
	else if(dcode >= 8000 && dcode <= 10999)
		maxamount = 1.0;
	return maxamount;
}

/*

stock GetDrugForm(dcode)
{
	new string[10];
 if(IsAEcstasy(dcode) || IsAAspirin(dcode) || IsANaltrexone(dcode) || IsAMethadone(dcode))
		format(string, sizeof(string), "tableta");
	else format(string, sizeof(string), "g");
	return string;
}

*/

CheckDrugQualities()
{
	HouseDrugTask();
	WarehouseDrugTask();
	VehicleDrugTask();
	return 1;
}

Public:HouseDrugTask()
{
	foreach(new h: Houses)
		CheckHouseDrugTimeStamps(h);
		
	return 1;
}

Public:VehicleDrugTask()
{
	foreach(new vehicleid : COVehicles)
	{
		foreach(new dslot: CODrugs[vehicleid])
			CheckVehicleDrugTimeStamp(vehicleid, dslot);
	}
	CheckVehicleDrugsInBase();
	return 1;
}

CheckVehicleDrugsInBase()
{
	new drugtimestamp = gettimestamp() - DRUG_TIMESTAMP;
	
	new
		loadString[ 128 ];
	format(loadString, 128, "SELECT * FROM `cocars_drugs` WHERE timestamp <= '%d'",drugtimestamp);
	mysql_pquery(g_SQL, loadString, "OnVehicleDrugsCheck", "");
	return 1;
}

Public:OnVehicleDrugsCheck()
{
	if( !cache_num_rows() ) return 1;
	new sqlid, dcode, timestamp, updateQuery[128];
	for( new i=0; i < cache_num_rows(); i++ ) 
	{
		cache_get_value_name_int(i, "id", sqlid);
		cache_get_value_name_int(i, "code", dcode);
		cache_get_value_name_int(i, "timestamp", timestamp);
		
		if(!IsAVeryBadDrug(dcode))
		{
			dcode -= DRUG_QUALITY_DECREASE;
			timestamp = gettimestamp() + DRUG_TIMESTAMP;
			
			format(updateQuery, 128, "UPDATE `cocars_drugs` SET `code` = '%d', `timestamp` = '%d' WHERE `id` = '%d'", 
				dcode,
				timestamp,
				sqlid
			);
			mysql_tquery(g_SQL, updateQuery, "", "");
		}
	}
	return 1;
}

Public:CheckVehicleDrugTimeStamp(vehicleid, slotid)
{
	if(gettimestamp() >= VehicleInfo[vehicleid][vDrugTimeStamp][slotid])
	{
		if(!IsAVeryBadDrug(VehicleInfo[vehicleid][vDrugCode][slotid]))
		{
			VehicleInfo[vehicleid][vDrugCode][slotid] -= DRUG_QUALITY_DECREASE;
			VehicleInfo[vehicleid][vDrugTimeStamp][slotid] = gettimestamp() + DRUG_TIMESTAMP;
			UpdateDrugInVehicle(vehicleid, slotid);
			return 1;
		}
	}
	return 1;
}

Public:CheckPlayerDrugTimeStamp(playerid, slotid) // ODEDEGENU
{
	if(PlayerDrugs[playerid][dCode][slotid] != 0)
	{		
		if(gettimestamp() >= PlayerDrugs[playerid][dTimeStamp][slotid])
		{
			if(!IsAVeryBadDrug(PlayerDrugs[playerid][dCode][slotid]))
			{
				PlayerDrugs[playerid][dCode][slotid] -= DRUG_QUALITY_DECREASE;
				PlayerDrugs[playerid][dTimeStamp][slotid] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
				SavePlayerDrugSlot(playerid, slotid);
				return 1;
			}
		}
	}
	return 1;
}

stock ReturnNormalDrugTimeStamp(timestamp) // Za kola i kuce
{
	new maxtimestamp = gettimestamp() + PLAYER_DRUG_TIMESTAMP + DRUG_TIMESTAMP;
	if(timestamp > maxtimestamp)
		return maxtimestamp;
	else return timestamp;
}

stock ReturnWarehouseDrugTimeStamp(timestamp)
{
	new maxtimestamp = gettimestamp() + PLAYER_DRUG_TIMESTAMP + WAREHOUSE_DRUG_TIMESTAMP;
	if(timestamp > maxtimestamp)
		return maxtimestamp;
	else return timestamp;
}
	
	
stock CombineDrugTimeStamp(Float:damount1, Float:damount2, dtimestamp1, dtimestamp2)
{
	new Float:formula = 0,
		Float:ratio = 0.0,
		output;
	if(damount1 > damount2)
	{
		ratio = damount2 / damount1;
		formula = ratio * dtimestamp2 + (1 - ratio) * dtimestamp1;
	}
	else
	{
		ratio = damount1 / damount2;
		formula = ratio * dtimestamp1 + (1 - ratio) * dtimestamp2;
	}
	output = floatround(formula, floatround_ceil);
	return output;
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
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_VEH_TAKEDRUG:
		{
			if(!response)
			{
				ResetPlayerDrugList(playerid);
				return 1;
			}
			new vehicleid = GetPlayerVehicleID(playerid),
				dslot = DrugToList[playerid][listitem],
				dcode = VehicleInfo[vehicleid][vDrugCode][dslot],
				Float:total = VehicleInfo[vehicleid][vDrug][dslot];
			
			DrugSlot[playerid] = dslot;
			new dstring[64];
			format(dstring, sizeof(dstring), "Upisite koliko %s(od %.2f g) zelis uzeti.", GetDrugNameByDrugID(dcode), total);
			ShowPlayerDialog(playerid, DIALOG_VEH_DAMOUNT, DIALOG_STYLE_INPUT, "Kolicina droge", dstring, "Input", "Exit");
			return 1;
		}
		case DIALOG_VEH_DAMOUNT:
		{
			if(!response)
			{
				ResetPlayerDrugList(playerid);
				return 1;
			}
			new vehicleid = GetPlayerVehicleID(playerid),
				Float:amount = floatstr(inputtext),
				dslot = DrugSlot[playerid],
				freeslot = -1,
				string[64];
			
			if(amount <= 0)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kolicina droge ne moze biti manja od 0!");
			if((VehicleInfo[vehicleid][vDrug][dslot] - amount) < 0.00)
				return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nema toliko %s u vozilu. Raspolozivo je %.2f g.", GetDrugNameByDrugID(VehicleInfo[vehicleid][vDrugCode][dslot]), VehicleInfo[vehicleid][vDrug][dslot]);
			
			for(new i=0; i < 5; i++)
			{
				if(CompareDrugQuality(PlayerDrugs[playerid][dCode][i], VehicleInfo[vehicleid][vDrugCode][dslot]))
				{
					freeslot = i;
					PlayerDrugs[playerid][dAmount][i] += amount;
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %.2f g %s iz vozila.", amount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]));
					SavePlayerDrugSlot(playerid, i);
					VehicleInfo[vehicleid][vDrug][dslot] -= amount;
					if(VehicleInfo[vehicleid][vDrug][dslot] <= 0.1)
						RemoveDrugFromVehicle(vehicleid, dslot);
					else UpdateDrugInVehicle(vehicleid, dslot);
					format( string, sizeof(string), "** %s uzima nesto iz vozila.", GetName(playerid, true) );
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
					#if defined MODULE_LOGS
					new
						log[128];
					format(log,128, "%s | %s je uzeo %.2f grama %s iz vozila MySQL ID %d.", ReturnDate(), GetName(playerid, false), amount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]), VehicleInfo[vehicleid][vSQLID]);
					LogDrugTake(log);
					#endif
					return 1;
				}
				else if(PlayerDrugs[playerid][dCode][i] == 0)
				{
					freeslot = i;
					PlayerDrugs[playerid][dCode][i] = VehicleInfo[vehicleid][vDrugCode][dslot];
					PlayerDrugs[playerid][dAmount][i] += amount;
					PlayerDrugs[playerid][dTimeStamp][i] = VehicleInfo[vehicleid][vDrugTimeStamp][dslot];
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %.2f g %s iz vozla.", amount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]));
					SavePlayerDrugSlot(playerid, i);
					VehicleInfo[vehicleid][vDrug][dslot] -= amount;
					if(VehicleInfo[vehicleid][vDrug][dslot] <= 0.1)
						RemoveDrugFromVehicle(vehicleid, dslot);
					else UpdateDrugInVehicle(vehicleid, dslot);
					format( string, sizeof(string), "** %s uzima nesto iz vozila.", GetName(playerid, true) );
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
					#if defined MODULE_LOGS
					new
						log[128];
					format(log,128, "%s | %s je uzeo %.2f grama %s iz vozila MySQL ID %d.", ReturnDate(), GetName(playerid, false), amount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][i]), VehicleInfo[vehicleid][vSQLID]);
					LogDrugTake(log);
					#endif
					return 1;
				}
			}
			if(freeslot == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Neuspjesno ste uzeli drogu iz vozila. Nemate vise slobodnih drug slotova(/drug view).");
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	BakingSoda[playerid]	= 0;
	CookingRecipe[playerid] = 0;
	JohnsText[playerid] 	= PlayerText:INVALID_TEXT_DRAW;

	KillTimer(CookingTimer[playerid]);
	KillTimer(JohnsFader[playerid]);
	KillTimer(HealthLostTimer[playerid]);
	KillTimer(DestroyLabTimer[playerid]);

	Bit1_Set( gr_LijekUsed			, playerid, false );
	Bit1_Set( gr_CrackFistPlayer	, playerid, false );
	Bit1_Set( gr_Lijek				, playerid, false );
	Bit8_Set( gr_SecondsPassed		, playerid, 0 );
	Bit8_Set( gr_DrugHealthLost		, playerid, 0 );
	Bit8_Set( gr_DrugAddictionTime	, playerid, 15 );
	
	
	static const
		e_pDrugs[E_DRUG_DATA];
		
	PlayerDrugs[playerid] = e_pDrugs;
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	Bit8_Set(gr_DrugAddictionTime, playerid, 15);
	return 1;
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
CMD:drug(playerid, params[])
{
	new item[16], giveplayerid, opcija[20], slot, kolicina, vehicleid, slot2, Float:ammount, ammountstr[8];
	new Float:x, Float:y, Float:z;
	if (sscanf(params, "s[16] ", item))
	{
		SendClientMessage(playerid, COLOR_RED, "___________________________________________________________________");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug [opcija]");
     	SendClientMessage(playerid, COLOR_RED, "[ ! ] give, view, use, put, take, vehinfo, test, slotreplace");
     	SendClientMessage(playerid, COLOR_RED, "[ ! ] produce, harvest, destroy, cut");
     	SendClientMessage(playerid, COLOR_RED, "[ ! ] buyseeds, test, ingredients, giveingredients");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] startcooking, putcomp");
        SendClientMessage(playerid, COLOR_RED, "___________________________________________________________________");
		return 1;
	}
    else if(strcmp(item,"buyseeds",true) == 0)
	{
	    new cijena;
	    if(PlayerInfo[playerid][pJob] != DRUG_DEALER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi diler droge!");
	    if(sscanf(params, "s[16]i", item, kolicina)) 	return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug buyseeds [kolicina]");
	    if(kolicina < 1 || kolicina > 100) 			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete uzeti vise od 100 sjemenki odjednom!");
		if(PlayerInfo[playerid][pSeeds] >= 100) 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete imati vise od 100 sjemenki kod sebe!");
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2485.8137, -1328.7324, 38.6563)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini mjesta za kupovinu sjemenki!");

		cijena = kolicina * 100;
	    if(AC_GetPlayerMoney(playerid) < cijena) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca! Jedna sjemenka marihuane kosta $65");

		PlayerInfo[playerid][pSeeds] += kolicina;
        PlayerToIllegalBudgetMoney(playerid, cijena);

        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupili ste %d sjemenki marihuane.", kolicina);
		return 1;
    }
    else if(strcmp(item,"test",true) == 0)
	{
		if( PlayerInfo[playerid][pJob] != DRUG_DEALER_ID && PlayerInfo[playerid][pDrugUses] < 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste diler droge/iskusnjara s drogom!");
	    if( sscanf( params, "s[16]i", item, slot ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug test [slot]");
	    if(slot < 1 || slot > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi broj slota!");
	    slot2 = slot-1;
	    if( !PlayerDrugs[playerid][dCode][slot2] ) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj slot vam je prazan!");
		
		if(IsAExcelentDrug(PlayerDrugs[playerid][dCode][slot2])) 
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kvaliteta %s: Odlicna", GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		if(IsAGoodDrug(PlayerDrugs[playerid][dCode][slot2]))
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kvaliteta %s: Dobra", GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		if(IsABadDrug(PlayerDrugs[playerid][dCode][slot2]))
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kvaliteta %s: Losa", GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		if(IsAVeryBadDrug(PlayerDrugs[playerid][dCode][slot2]))
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kvaliteta %s: Vrlo losa", GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		return 1;
    }
	else if(strcmp(item,"give",true) == 0)
    {
		if (sscanf(params, "s[16]uis[8] ", item, giveplayerid, slot, ammountstr))
		{
			SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug give [playerid/dio imena][slot][kolicina]");
	     	SendClientMessage(playerid, COLOR_WHITE, "[Pomoc] Slot znaci broj vaseg mjesta droge, moze biti od 1 do 5.");
	     	SendClientMessage(playerid, COLOR_WHITE, "[Pomoc] Ukucajte /drug view ako zelite slot vase droge!");
	        SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
			return 1;
		}
		ammount = floatstr(ammountstr);
		if(giveplayerid == INVALID_PLAYER_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos playerida!");

		if(ammount < 0.1)
	        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kolicina droge ne moze biti manja od 0.1g!");

		if(giveplayerid == playerid)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi davati drogu!");

		if( !ProxDetectorS(5.0, playerid, giveplayerid) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu igraca!");

		if(PlayerDrugs[giveplayerid][dCode][0] != 0 && PlayerDrugs[giveplayerid][dCode][1] != 0 && PlayerDrugs[giveplayerid][dCode][2] != 0 && PlayerDrugs[giveplayerid][dCode][3] != 0 && PlayerDrugs[giveplayerid][dCode][4] != 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nema slobodnih drug slotova!");

		if(slot < 1 || slot > 5)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Broj slota ne moze biti manji od 1 i veci od 5!");


		slot2 = slot-1;
		new
		    drugName[16];

		format(drugName, 16, GetDrugName(PlayerDrugs[playerid][dCode][slot2]));

		if( PlayerDrugs[playerid][dCode][slot2] == 0 || PlayerDrugs[playerid][dAmount][slot2] == 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj drug slot vam je prazan!");

		if( (PlayerDrugs[playerid][dAmount][slot2] - ammount) < 0 )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas toliko droge u tom slotu.");

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] %s vam je dao %.2f g %s.",
			GetName(playerid, true),
			ammount,
			drugName
		);
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s %.2f g %s.",
			GetName(giveplayerid, true),
			ammount,
			drugName
		);
		
		new
			log[128];
		format(log,128, "%s | %s je dao %s %.2f grama %s.", ReturnDate(), GetName(playerid, false), GetName(giveplayerid, false), ammount, drugName);
		LogDrugGive(log);
		
		ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0, 1, 0); // Deal Drugs

		new
			slotid = -1;
		if(!PlayerDrugs[giveplayerid][dCode][0])		slotid = 0;
		else if(!PlayerDrugs[giveplayerid][dCode][1])	slotid = 1;
		else if(!PlayerDrugs[giveplayerid][dCode][2])	slotid = 2;
		else if(!PlayerDrugs[giveplayerid][dCode][3]) 	slotid = 3;
		else if(!PlayerDrugs[giveplayerid][dCode][4]) 	slotid = 4;

		if(slotid != -1)
		{
			PlayerDrugs[giveplayerid][dSQLID][slotid]    	= -1;
			PlayerDrugs[giveplayerid][dCode][slotid] 		= PlayerDrugs[playerid][dCode][slot2];
			PlayerDrugs[giveplayerid][dAmount][slotid] 		+= ammount;
			PlayerDrugs[giveplayerid][dEffect][slotid]		= GetPlayerDrugEffect(playerid, slotid);
			PlayerDrugs[giveplayerid][dTimeStamp][slotid] 	= PlayerDrugs[playerid][dTimeStamp][slot2];
			
			SavePlayerDrugSlot(giveplayerid, slotid);
		}
		PlayerDrugs[playerid][dAmount][slot2] = PlayerDrugs[playerid][dAmount][slot2] - ammount;
		SavePlayerDrugSlot(playerid, slot2);
		return 1;
	}
	else if(strcmp(item,"view",true) == 0)
    {
  		ShowPlayerDialog(playerid, DIALOG_ALERT, DIALOG_STYLE_MSGBOX, "\tVase droge:", ListPlayerDrugs(playerid), "Close","");
		return 1;
	}
	else if(strcmp(item,"use",true) == 0)
    {
		new Float:amount;
        if (sscanf(params, "s[16]if", item, slot, amount)) {
			SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug use [slot] [kolicina]");
	     	SendClientMessage(playerid, COLOR_RED, "[ ! ] Slot znaci broj vaseg mjesta droge, moze biti od 1 do 5.");
	     	SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukucajte /drug view ako zelite vidjeti slot vase droge!");
	        SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
			return 1;
		}
		if (slot < 1 || slot > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Broj slota ne moze biti manji od 1 i veci od 5!");
		if(PlayerInfo[playerid][pDrugUsed] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec si nadrogiran. Ne mozes koristiti drogu dok si nadrogiran!");
		slot2 = slot-1;
		if(PlayerDrugs[playerid][dCode][slot2] <= 0 || !PlayerDrugs[playerid][dAmount][slot2]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate droge pod tim slotom!");
		if(IsAMarijuana(PlayerDrugs[playerid][dCode][slot2]) && PlayerInfo[playerid][pLighter] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas upaljac!");
		if(IsACrack(PlayerDrugs[playerid][dCode][slot2]) && PlayerInfo[playerid][pLighter] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas upaljac!");
  		new Float:amountcheck = AmountEffectCheck(playerid, PlayerDrugs[playerid][dCode][slot2]),
			Float:amountmax = AmountEffectMax(PlayerDrugs[playerid][dCode][slot2]),
			Float:maxamount = amountcheck + amountmax;
		new drug = PlayerDrugs[playerid][dCode][slot2];
		if(amount < 0.1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete uzeti manje od 0.1g droge posto ona nece imati efekat!");
		if((amountcheck > amount))
		{
			if(IsAEcstasy(PlayerDrugs[playerid][dCode][slot2]))
			{
				new tabamount = floatround(amountcheck, floatround_round);
				return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Potrebno je %d tableta g da bi droga imala ucinak!", tabamount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
			}
			else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Potrebno je %.2f g %s da bi droga imala ucinak!", amountcheck, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		}
		if(amount > maxamount)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Predozirat cete se! Maksimalno %.2f g %s je vise nego dovoljno za ucinak droge!", maxamount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]));
		if(amount > PlayerDrugs[playerid][dAmount][slot2])
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate %2.f g %s u slotu %d!", amount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]), slot);
			
		if(PlayerInfo[playerid][pLijekTimer] != 0 && (PlayerDrugs[playerid][dCode][slot2] >= 8000 && PlayerDrugs[playerid][dCode][slot2] <= 10999)) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Moras cekati %d sat(a/i) da mozes koristiti lijek!", PlayerInfo[playerid][pLijekTimer]);
		
		PlayerInfo[playerid][pDrugUsed] 	= 1;
		PlayerInfo[playerid][pDrugSeconds] 	= 20; // Svakih 20 min se moze /drug use
		
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste %.2f g %s.", amount, GetDrugNameByDrugID(drug));
		if((PlayerDrugs[playerid][dCode][slot2] < 8000 || PlayerDrugs[playerid][dCode][slot2] > 10999))
		{
			new paydaymin = PlayerInfo[playerid][pPayDay], rest = 0;
			
			if(IsAExcelentDrug(drug)) 	PlayerInfo[playerid][pPayDay] += 8;
			if(IsAGoodDrug(drug))		PlayerInfo[playerid][pPayDay] += 6;
			if(IsABadDrug(drug))		PlayerInfo[playerid][pPayDay] += 4;
			if(IsAVeryBadDrug(drug))	PlayerInfo[playerid][pPayDay] += 2; 
			
			rest = PlayerInfo[playerid][pPayDay] - paydaymin;
			va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Radi efekta i kvalitete droge, vase vrijeme do place je smanjeno za %d min!", rest);

			PlayerInfo[playerid][pLastDrug] = drug;
			if( PlayerInfo[playerid][pHunger] <= -5.0)    PlayerInfo[playerid][pHunger] = -5.0;
			if( PlayerInfo[playerid][pHunger] >= 5.0)    PlayerInfo[playerid][pHunger] = 5.0;
		}
		PlayerDrugs[playerid][dAmount][slot2] -= amount;
		SavePlayerDrugSlot(playerid, slot2);
		
		// drug_use logs.
		new
			tmpLog[ 128 ];
		format( tmpLog, 128, "%s je uzeo %.2f g %s.",
			GetName(playerid, false),
			amount, 
			GetDrugNameByDrugID(drug)
		);
		LogDrugUse(tmpLog);
		
		if(IsAMarijuana(drug)) //marihuana
		{
		    ApplyAnimationEx(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0, 1,0);
 			SetPlayerSpecialAction(playerid,21);

			PlayerInfo[playerid][pHunger] 	-= 0.5;
			if( PlayerInfo[playerid][pHunger] <= -5.0 )
				PlayerInfo[playerid][pHunger] = -5.0;
			SetPlayerDrunkLevel(playerid, 4000);
			GivePlayerHealth(playerid, 10.0);

			PlayerDrugs[playerid][dEffect][slot2] = 2;
			PlayerInfo[playerid][pDrugUses]++;
			new
				tmpString[ 60 ];
			format(tmpString, sizeof(tmpString), "** %s stavlja joint u usta i pali ga.",
				GetName(playerid, true)
			);
			ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else if(IsACocaine(drug)) //kokain
		{
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/2it0g5dtyh/heartbeat.mp3");

			PlayerInfo[playerid][pDrugAddict] 	= 4;

			new
				tmpString[ 42 ];
			format(tmpString, sizeof(tmpString), "** %s smrce kokain.",
				GetName(playerid, true)
			);
			ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			SetPlayerArmour(playerid, 30.0);
			PlayerInfo[playerid][pHunger] += 5.0;
			PlayerInfo[playerid][pDrugUses]++;
			if( PlayerInfo[playerid][pHunger] > 5.0 )
				PlayerInfo[playerid][pHunger] = 5.0;
			PlayerDrugs[playerid][dEffect][slot2] = 6;
		}
		else if(IsACrack(drug)) //crack
		{
			if(PlayerInfo[playerid][pDrugUses] == 0) {
				PlayerInfo[playerid][pHunger] += 2.5;
				if( PlayerInfo[playerid][pHunger] > 5.0 )
					PlayerInfo[playerid][pHunger] = 5.0;
			} 
			else  
				PlayerInfo[playerid][pHunger] += 0.5;

			PlayerInfo[playerid][pDrugUses]++;
			SetPlayerWeather(playerid, 21);
			SetPlayerDrunkLevel (playerid, 5000);
			PlayerInfo[playerid][pDrugAddict] = 5;

			new
				tmpString[ 50 ];
		    format(tmpString, sizeof(tmpString), "** %s pocinje pusiti crack.",
				GetName(playerid, true)
			);
		    ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			SetPlayerArmour(playerid, 20.0);
			PlayerDrugs[playerid][dEffect][slot2] = 4;
		}
		else if(IsAMethamphetamine(drug)) //meth
		{
			ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerDrunkLevel (playerid, 10000);
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/7fj9ysbskh/level5.mp3");
			SetPlayerWeather(playerid, 9);

			PlayerInfo[playerid][pHunger] 		+= 3.0;
			if( PlayerInfo[playerid][pHunger] > 5.0 )
				PlayerInfo[playerid][pHunger] = 5.0;

			PlayerInfo[playerid][pDrugUses]++;	
			PlayerInfo[playerid][pDrugAddict] 	= 4;

			new
				tmpString[ 56 ];
			format(tmpString, sizeof(tmpString), "** %s pocinje pusiti metamfetamin.",
				GetName(playerid, true)
			);
			ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			GivePlayerHealth(playerid, 20.0);
			PlayerDrugs[playerid][dEffect][slot2] = 4;
		}
		else if(IsAHeroin(drug)) //heroin
		{
			ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerDrunkLevel (playerid, 10000);
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/7fj9ysbskh/level5.mp3");
			SetPlayerWeather(playerid, 9);

			PlayerInfo[playerid][pHunger] 		+= 4.2;
			if( PlayerInfo[playerid][pHunger] > 5.0 )
				PlayerInfo[playerid][pHunger] = 5.0;

			Bit8_Set( gr_DrugHealthLost, playerid, 8);
			PlayerInfo[playerid][pDrugAddict] 	= 4;
			HealthLostTimer[playerid] = SetTimerEx("OnPlayerAddictionHealthLost", 1000, true, "iff", playerid, -0.9, 115.0);

			new
				tmpString[ 56 ];
			format(tmpString, sizeof(tmpString), "** %s si brizga heroin u venu.",
				GetName(playerid, true)
			);
			ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerArmour(playerid, 50.0);
			PlayerInfo[playerid][pDrugUses]++;
			PlayerDrugs[playerid][dEffect][slot2] = 5;
		}
		else if(IsAEcstasy(drug)) //ecstasy
		{
			if(PlayerInfo[playerid][pDrugUses] == 0) {
				Bit1_Set(gr_CrackFistPlayer, playerid, true);

				PlayerInfo[playerid][pHunger] += 2.5;
				if( PlayerInfo[playerid][pHunger] > 5.0 )
					PlayerInfo[playerid][pHunger] = 5.0;
			} 
			else  
				PlayerInfo[playerid][pHunger] += 0.5;
			
			PlayerInfo[playerid][pDrugUses]++;
			SetPlayerWeather(playerid, 21);
			SetPlayerDrunkLevel (playerid, 5000);
			PlayerInfo[playerid][pDrugAddict] = 3;

			new
				tmpString[ 50 ];
		    format(tmpString, sizeof(tmpString), "** %s uzima tabletu Ecstasya.",
				GetName(playerid, true)
			);
		    ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			PlayerDrugs[playerid][dEffect][slot2] = 3;
			GivePlayerHealth(playerid, 20.0);
		}
		return 1;
	}
	else if(strcmp(item,"put",true) == 0)
    {
        vehicleid = GetPlayerVehicleID(playerid);
        if (sscanf(params, "s[16]if", item, slot, ammount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug put [slot][kolicina]");
		if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovu komandu mozete pisati samo dok ste u vozilu!");
		if( !Iter_Contains(COVehicles, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u privatnome vozilu!");
		if( !CheckVehicleDrugCapacities(playerid, vehicleid) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U vozilu vise nema mjesta za droge.");
		if( !LimitBikeDrugCapacity(vehicleid, ammount) )
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "U bicikle mozete pohraniti maksimalno %d g!", MAX_BIKE_DRUG_AMOUNT);
		if(slot < 1 || slot > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi broj slota!");
		slot2 = slot-1;
		if(PlayerDrugs[playerid][dCode][slot2] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate droge pod tim slotom!");
		if( vehicleid == rentedVehID[playerid] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete spremati drogu u rentana vozila!");
        if( VehicleInfo[vehicleid][vDrugCode][0] != 0 && VehicleInfo[vehicleid][vDrugCode][1] != 0 && VehicleInfo[vehicleid][vDrugCode][2] != 0 && VehicleInfo[vehicleid][vDrugCode][3] != 0 && VehicleInfo[vehicleid][vDrugCode][4] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svih 5 slotova vozila su zauzeti!");
		if(ammount > PlayerDrugs[playerid][dAmount][slot2] || ammount < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko droge pod tim slotom!");
		PlayerDrugs[playerid][dAmount][slot2] -= ammount;

		new
			tmpString[ 64 ];
		format(tmpString, sizeof(tmpString), "** %s stavlja nesto u vozilo.",
			GetName(playerid, true)
		);
		SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 8000);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste stavili %.2f g %s u vozilo.",
			ammount, 
			GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2])
		);

		#if defined MODULE_LOGS
		new
			log[128];
		format(log,128, "%s | %s je stavio %.2f grama %s u vozilo MySQL ID %d.", ReturnDate(), GetName(playerid, false), ammount, GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot2]), VehicleInfo[vehicleid][vSQLID]);
		LogDrugPut(log);
		#endif

		new index = Iter_Free(CODrugs[vehicleid]),
			timestamp = PlayerDrugs[playerid][dTimeStamp][slot2] + DRUG_TIMESTAMP;
			
		// Save Drugs
		VehicleInfo[vehicleid][vDrugSQLID][index]			= -1;
		VehicleInfo[vehicleid][vDrugCode][index] 			= PlayerDrugs[playerid][dCode][slot2];
		VehicleInfo[vehicleid][vDrug][index]			   += ammount;
		VehicleInfo[vehicleid][vDrugTimeStamp][index] 		= ReturnNormalDrugTimeStamp(timestamp);
		
		if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_PRIVATE) 
		{
			new
				insertVehDrugQuery[180];
				
			format(insertVehDrugQuery, sizeof(insertVehDrugQuery), "INSERT INTO `cocars_drugs`(`vehicle_id`, `code`, `amount`, `timestamp`) VALUES ('%d','%d','%.2f','%d')",
				VehicleInfo[vehicleid][vSQLID],
				VehicleInfo[vehicleid][vDrugCode][index],
				VehicleInfo[vehicleid][vDrug][index],
				VehicleInfo[vehicleid][vDrugTimeStamp][index]
			);
			mysql_pquery(g_SQL, insertVehDrugQuery, "OnVehicleDrugInsert", "ii", vehicleid, index);
			Iter_Add(CODrugs[vehicleid], index);
			CheckVehicleDrugTrunkSpace(playerid, vehicleid);
		}
		// Remove Player Drugs
		if(PlayerDrugs[playerid][dAmount][slot2] <= 0) {
			// SQL
			new
				drugRemove[128];
			format(drugRemove, 128, "DELETE FROM `player_drugs` WHERE `id` = '%d'", PlayerDrugs[playerid][dSQLID][slot2]);
			mysql_tquery(g_SQL, drugRemove, "", "");
			
			// Drug Dump
			PlayerDrugs[playerid][dSQLID][slot2] 		= -1;
			PlayerDrugs[playerid][dAmount][slot2] 		= 0;
			PlayerDrugs[playerid][dCode][slot2] 		= 0;
			PlayerDrugs[playerid][dEffect][slot2] 		= 0;
		}
		return 1;
	}
	else if(strcmp(item,"take",true) == 0)
    {
		if(PlayerDrugs[playerid][dCode][0] != 0 && PlayerDrugs[playerid][dCode][1] != 0 && PlayerDrugs[playerid][dCode][2] != 0 && PlayerDrugs[playerid][dCode][3] != 0 && PlayerDrugs[playerid][dCode][4] != 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svih vasih 5 slotova za droge su puni!");
        vehicleid = GetPlayerVehicleID(playerid);
        if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovu komandu mozete pisati samo dok ste u vozilu!");
		if( !Iter_Contains(COVehicles, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u privatnome vozilu!");
		ShowPlayerDialog(playerid, DIALOG_VEH_TAKEDRUG, DIALOG_STYLE_LIST, "Vozilo - uzimanje droge", ListPlayerVehicleDrugs(playerid, vehicleid), "Choose", "Abort");
        return 1;
    }
    else if(strcmp(item,"produce",true) == 0)
	{
	    if (sscanf(params, "s[16]s[20] ", item, opcija))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTI: /drug produce [droga]");
			SendClientMessage(playerid, COLOR_WHITE, "[DROGA]: Marijuana, Crack");
			return 1;
		}
		if(strcmp(opcija,"marijuana",true) == 0)
		{
		    if(PlayerInfo[playerid][pJob] != DRUG_DEALER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo dileri droge  mogu proizvoditi marihuanu!");
		    if(PlayerInfo[playerid][pSeeds] < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da biste zapoceli proizvodnju marihuane,potrebno vam je 10 sjemenki marihuane!");
		    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			{
		    	GetPlayerPos(playerid, x, y, z);
		    	new name[MAX_PLAYER_NAME];
		    	GetPlayerName(playerid, name, sizeof(name));

				new
					plants = GetFreeWeedId();

				if(plants == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Previse je biljaka posadjeno! Sacekaj malo!");
				Iter_Add(Marijuana, plants);

				WeedInfo[plants][wPlantX]	= x;
				WeedInfo[plants][wPlantY]	= y;
				WeedInfo[plants][wPlantZ]	= z-1.7;
				WeedInfo[plants][wViwo] 	= GetPlayerVirtualWorld(playerid);
				WeedInfo[plants][wPlanted]   = 1;
				WeedInfo[plants][wReady]     = 0;
				WeedInfo[plants][wHoursPassed]  = 0;
				
				CreateWeed(plants, 19473, WeedInfo[plants][wViwo], 1, 0, 0, 0, name, WeedInfo[plants][wPlantX], WeedInfo[plants][wPlantY], WeedInfo[plants][wPlantZ]);
				WeedInfo[plants][wObjectID] = CreateDynamicObject(19473, WeedInfo[plants][wPlantX], WeedInfo[plants][wPlantY], WeedInfo[plants][wPlantZ], 0.0, 0.0, 96.0, WeedInfo[plants][wViwo], -1, -1, 100.0);

				PlayerPlaySound(playerid, 2000, 0, 0, 0);
				PlayerInfo[playerid][pSeeds] -= 10;
				ApplyAnimationEx(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,0,1,0);

				new
					tmpString[ 72 ];
				format(tmpString, sizeof(tmpString), "** %s uzima sjemenke za marihuanu, i posadjuje ih.",
					GetName(playerid, true)
				);
				ProxDetector(10.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes posaditi drogu dok si u vozilu!");
		}
		else if(strcmp(opcija,"crack",true) == 0)
		{
		    new kuca = Bit16_Get(gr_PlayerInHouse, playerid), soda, formula;
		    if (sscanf(params, "s[32]s[20]ii", item, opcija, slot, soda)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug produce crack [slot kokaina] [kolicina sode u gramima]");
		    if(kuca == 9999) return SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			if (IsPlayerInRangeOfPoint(playerid,20,HouseInfo[kuca][hExitX], HouseInfo[kuca][hExitY], HouseInfo[kuca][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[kuca][hVirtualWorld])
			{
				if(slot < 1 || slot > 5) return SendClientMessage(playerid, COLOR_RED, "Krivi broj slota!");
				slot2 = slot-1;
				if(!IsACocaine(PlayerDrugs[playerid][dCode][slot2])) return SendClientMessage(playerid, COLOR_RED, "U tom slotu nemate kokain!");
				if(soda < 3 || soda > BakingSoda[playerid]) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko sode bikarbone kod sebe/Premalo ste stavili!");
				if(soda > floatround(PlayerDrugs[playerid][dAmount][slot2])) return SendClientMessage(playerid,COLOR_RED,"Ne mozes staviti vise sode nego sto imas droge!");
				formula = PlayerDrugs[playerid][dCode][slot2]-soda;
				if(IsACocaine(formula))
				{
                    PlayerDrugs[playerid][dCode][slot2] = formula+1000;
                    PlayerDrugs[playerid][dAmount][slot2] += float(soda)/2;
                    BakingSoda[playerid] -= soda;

                    SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Napravili ste %.2f grama cracka.", PlayerDrugs[playerid][dAmount][slot2]);
					UpgradePlayerSkill(playerid, 8);
				}
				else
				{
                    SendMessage(playerid, MESSAGE_TYPE_INFO, "Stavili ste previse sode i crack nije ispao kako treba.Propala vam je droga.");
                    BakingSoda[playerid] -= soda;
                    PlayerDrugs[playerid][dCode][slot2] = 0;
                    PlayerDrugs[playerid][dAmount][slot2] = 0;
				}
			}
			else SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			return 1;
		}
	}
	/*else if(strcmp(item,"cut",true) == 0)
	{
	    new kuca = Bit16_Get(gr_PlayerInHouse, playerid), soda, formula;
	    if (sscanf(params, "s[32]s[20] ", item, opcija))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTI: /drug cut [droga]");
			SendClientMessage(playerid, COLOR_WHITE, "Droge: Cocaine, Heroin");
			return 1;
		}
		if(strcmp(opcija,"cocaine",true) == 0)
		{
		    if (sscanf(params, "s[32]s[20]ii", item, opcija, slot, soda)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug cut cocaine [slot kokaina] [kolicina sode u gramima]");
		    if(kuca == 9999) return SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			if (IsPlayerInRangeOfPoint(playerid,20,HouseInfo[kuca][hExitX], HouseInfo[kuca][hExitY], HouseInfo[kuca][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[kuca][hVirtualWorld])
			{
				if(slot < 1 || slot > 5) return SendClientMessage(playerid, COLOR_RED, "Krivi broj slota!");
				slot2 = slot-1;
				
				if(!IsACocaine(PlayerDrugs[playerid][dCode][slot2])) return SendClientMessage(playerid, COLOR_RED, "U tom slotu nemate kokain!");
				if(soda > floatround(PlayerDrugs[playerid][dAmount][slot2])) return SendClientMessage(playerid,COLOR_RED,"Ne mozes staviti vise sode nego sto imas droge!");
				if(soda < 3 || soda > BakingSoda[playerid]) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko sode bikarbone kod sebe/Premalo ste stavili!");
				formula = PlayerDrugs[playerid][dCode][slot2]-soda;
				if(IsACocaine(formula))
				{
                    PlayerDrugs[playerid][dCode][slot2] = formula;
                    PlayerDrugs[playerid][dAmount][slot2] += float(soda)/4;
					PlayerDrugs[playerid][dTimeStamp][slot2] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
                    BakingSoda[playerid] -= soda;

                    SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Napravili ste %.2f grama kokaina.", PlayerDrugs[playerid][dAmount][slot2]);
					UpgradePlayerSkill(playerid, 8);
				}
				else
				{
                    SendMessage(playerid, MESSAGE_TYPE_INFO, "Stavili ste previse sode.Propala vam je droga.");
                    BakingSoda[playerid] -= soda;
                    PlayerDrugs[playerid][dCode][slot2] = 0;
					PlayerDrugs[playerid][dAmount][slot2] = 0;
				}
			}
			else SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			return 1;
		}
		else if(strcmp(opcija,"heroin",true) == 0)
		{
		    if (sscanf(params, "s[32]s[20]ii", item, opcija, slot, soda)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug cut heroin [slot heroina] [kolicina sode u gramima]");
		    if(kuca == 9999) return SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			if (IsPlayerInRangeOfPoint(playerid,20,HouseInfo[kuca][hExitX], HouseInfo[kuca][hExitY], HouseInfo[kuca][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[kuca][hVirtualWorld])
			{
				if(slot < 1 || slot > 5) return SendClientMessage(playerid, COLOR_RED, "Krivi broj slota!");
				slot2 = slot-1;
				if(!IsAHeroin(PlayerDrugs[playerid][dCode][slot2])) return SendClientMessage(playerid, COLOR_RED, "U tom slotu nemate heroin!");
				if(soda < 3 || soda > BakingSoda[playerid]) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko sode bikarbone kod sebe/Premalo ste stavili!");
				if(soda > floatround(PlayerDrugs[playerid][dAmount][slot2])) return SendClientMessage(playerid,COLOR_RED,"Ne mozes staviti vise sode nego sto imas droge!");
				formula = PlayerDrugs[playerid][dCode][slot2]-soda; //skoci
				if(IsAHeroin(formula))
				{
                    PlayerDrugs[playerid][dCode][slot2] = formula;
                    PlayerDrugs[playerid][dAmount][slot2] += float(soda)/2;
					PlayerDrugs[playerid][dTimeStamp][slot2] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
                    BakingSoda[playerid] -= soda;
					
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Napravili ste %.2f grama heroina.", PlayerDrugs[playerid][dAmount][slot2]);
					UpgradePlayerSkill(playerid, 8);
				}
				else
				{
                    SendMessage(playerid, MESSAGE_TYPE_INFO, "Stavili ste previse sode. Propala vam je droga.");
                    BakingSoda[playerid] -= soda;
                    PlayerDrugs[playerid][dCode][slot2] = 0;
                    PlayerDrugs[playerid][dAmount][slot2] = 0;
				}
			}
			else SendClientMessage(playerid, COLOR_RED, "Niste u kuci!");
			return 1;
		}
		return 1;
	}*/
	else if(strcmp(item,"slotreplace",true) == 0)
	{
	    new
			slot1;
	    if (sscanf(params, "s[16]iif", item, slot1, slot2, ammount))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug slotreplace [slot u koji prebacujes] [slot iz kojeg prebacujes] [kolicina]");
			return 1;
		}
		if(slot1 < 1 || slot1 > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi broj slota 1!");
		if(slot2 < 1 || slot2 > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi broj slota 2!");
		if(slot1 == slot2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete odabrati dva identicna slota!");
		if(ammount < 0.1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete premjestati kolicinu manju od 0.1g!");
		if(( PlayerDrugs[playerid][dAmount][slot1-1] + ammount ) > 100 ) 
			return SendClientMessage(playerid,COLOR_RED, "Zbroj kolicine i droge iz slota u koji stavljate ne smije biti veci od 100g!");
			
		if( !CompareDrugs(PlayerDrugs[playerid][dCode][slot1-1], PlayerDrugs[playerid][dCode][slot2-1]) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U objim slotovima moraju biti iste droge(s istom formulom) da bi ih mogli mjesati!");
		if(!CompareDrugQuality(PlayerDrugs[playerid][dCode][slot1-1], PlayerDrugs[playerid][dCode][slot2-1])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U objim slotovima moraju biti droge ISTE KVALITETE da bi ih mogli mjesati!");
		if(PlayerDrugs[playerid][dAmount][slot2-1] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U odabranomm slotu nemate droge!");
		if((ammount + PlayerDrugs[playerid][dAmount][slot1-1]) > 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Zbroj ovih slotova prelazi 100g!");
		if((PlayerDrugs[playerid][dAmount][slot2-1] - ammount) < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Razlika slota iz kojeg uzimas i kolicine je manja od 0g!");

		PlayerDrugs[playerid][dAmount][slot1-1] += ammount;
		PlayerDrugs[playerid][dTimeStamp][slot1-1] = CombineDrugTimeStamp(PlayerDrugs[playerid][dAmount][slot1-1], PlayerDrugs[playerid][dAmount][slot2-1], PlayerDrugs[playerid][dTimeStamp][slot1-1], PlayerDrugs[playerid][dTimeStamp][slot2-1]);
		
		PlayerDrugs[playerid][dAmount][slot2-1] -= ammount;

		new sslot1 = slot1 - 1,
			sslot2 = slot2 - 1;
			
		SavePlayerDrugSlot(playerid, sslot1);
		SavePlayerDrugSlot(playerid, sslot2);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prebacili ste %.2f g %s iz slota %d u slot %d.",
			ammount,
			GetDrugNameByDrugID(PlayerDrugs[playerid][dCode][slot1-1]),
			slot2,
			slot1
		);
		
		return 1;
	}
	else if(strcmp(item,"harvest",true) == 0)
	{
		if(PlayerDrugs[playerid][dCode][0] != 0 && PlayerDrugs[playerid][dCode][1] != 0 && PlayerDrugs[playerid][dCode][2] != 0 && PlayerDrugs[playerid][dCode][3] != 0 && PlayerDrugs[playerid][dCode][4] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svih vasih 5 slotova za droge su puni!");
		new
			plantid = IsPlayerNearMarijuana(playerid);
	    if(plantid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu posadjene marihuane.");

	    if(WeedInfo[plantid][wReady] == 1)
		{
			new skill = GetPlayerSkillLevel(playerid, 8),
				dcodeq;
			switch(skill)
			{
				case 0: dcodeq = 1200;
				case 1: dcodeq = 1400;
				case 2: dcodeq = 1600;
				case 3: dcodeq = 1800;
				case 4: dcodeq = 1950;
			}
			UpgradePlayerSkill(playerid, 8);
			new
				tmpQuery[ 256 ];
			format(tmpQuery, sizeof(tmpQuery), "DELETE FROM `weed` WHERE `id` = '%d'", WeedInfo[plantid][wdSQLID]);
            mysql_tquery(g_SQL, tmpQuery, "");
			
	        if(PlayerDrugs[playerid][dCode][0] == 0)
			{
				PlayerDrugs[playerid][dSQLID][0]	= -1;
                PlayerDrugs[playerid][dCode][0] 	= dcodeq;
                PlayerDrugs[playerid][dAmount][0] 		= float(WeedInfo[plantid][wGrams]);
				PlayerDrugs[playerid][dTimeStamp][0] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][1] == 0)
			{
				PlayerDrugs[playerid][dSQLID][1]	= -1;
                PlayerDrugs[playerid][dCode][1] 	= dcodeq;
                PlayerDrugs[playerid][dAmount][1] 		= float(WeedInfo[plantid][wGrams]);
				PlayerDrugs[playerid][dTimeStamp][1] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][2] == 0)
			{
				PlayerDrugs[playerid][dSQLID][2]	= -1;
                PlayerDrugs[playerid][dCode][2] 	= dcodeq;
                PlayerDrugs[playerid][dAmount][2] 		= float(WeedInfo[plantid][wGrams]);
				PlayerDrugs[playerid][dTimeStamp][2] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][3] == 0)
			{
				PlayerDrugs[playerid][dSQLID][3]	= -1;
                PlayerDrugs[playerid][dCode][3] 	= dcodeq;
                PlayerDrugs[playerid][dAmount][3] 		= float(WeedInfo[plantid][wGrams]);
				PlayerDrugs[playerid][dTimeStamp][3] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}
			else if(PlayerDrugs[playerid][dCode][4] == 0)
			{
				PlayerDrugs[playerid][dSQLID][4]	= -1;
                PlayerDrugs[playerid][dCode][4] 	= dcodeq;
                PlayerDrugs[playerid][dAmount][4] 		= float(WeedInfo[plantid][wGrams]);
				PlayerDrugs[playerid][dTimeStamp][4] = gettimestamp() + PLAYER_DRUG_TIMESTAMP;
			}

	        DestroyDynamicObject(WeedInfo[plantid][wObjectID]);
			ApplyAnimationEx(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,0,1,0);

			new
				tmpString[ 45 ];
			format(tmpString, sizeof(tmpString), "** %s ubire marihuanu.",
				GetName(playerid, true)
			);
			ProxDetector(10.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			WeedInfo[plantid][wReady] 		= false;
			WeedInfo[plantid][wGrams] 		= 0;
			WeedInfo[plantid][wPlantX] 		= 0.0;
			WeedInfo[plantid][wPlantY] 		= 0.0;
			WeedInfo[plantid][wPlantZ] 		= 0.0;
			WeedInfo[plantid][wObjectID] 	= -1;
			WeedInfo[plantid][wPlanted] 	= 0;
			WeedInfo[plantid][wHoursPassed] = 0;
			WeedInfo[plantid][wReady] 		= 0;
			WeedInfo[plantid][wViwo] 		= 0;
			Iter_Remove(Marijuana, plantid);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Biljka nije jos spremna za berbu!");
		return 1;
	}
	else if(strcmp(item,"destroy",true) == 0)
	{
	    if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac!");
	    new
			plantid = IsPlayerNearMarijuana(playerid);
	    if(plantid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu posadjene marihuane.");
		if(WeedInfo[plantid][wPlanted] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu posadjene marihuane.");
		DestroyDynamicObject(WeedInfo[plantid][wObjectID]);
		ApplyAnimationEx(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,0,1,0);

		new
			tmpString[ 58 ];
		format(tmpString, sizeof(tmpString), "** %s unistava stabiljke marihuane.",
			GetName(playerid, true)
		);
		ProxDetector(10.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		new
			tmpQuery[ 128 ];
		format(tmpQuery, sizeof(tmpQuery), "DELETE FROM weed WHERE `id` = '%d'", WeedInfo[plantid][wdSQLID]);
		mysql_tquery(g_SQL, tmpQuery, "");

		WeedInfo[plantid][wReady] 		= false;
		WeedInfo[plantid][wGrams] 		= 0;
		WeedInfo[plantid][wPlantX] 		= 0.0;
		WeedInfo[plantid][wPlantY] 		= 0.0;
		WeedInfo[plantid][wPlantZ] 		= 0.0;
		WeedInfo[plantid][wObjectID] 	= -1;
		WeedInfo[plantid][wPlanted] 	= 0;
		WeedInfo[plantid][wHoursPassed] = 0;
		WeedInfo[plantid][wReady] 		= 0;
		WeedInfo[plantid][wViwo] 		= 0;

		Iter_Remove(Marijuana, plantid);
		return 1;
	}
	else if(strcmp(item,"ingredients", true) == 0)
	{
		new
			string[3], printstring[32];

		SendClientMessage(playerid, COLOR_LIGHTBLUE,"|________________ * Ingredients * ________________|");
		if(PlayerInfo[playerid][pHCl]) string="Da";
		else string="Ne";
		format(printstring, sizeof(printstring), "Caustic soda: %s", string);
		SendClientMessage(playerid, COLOR_GREY, printstring);
		if(PlayerInfo[playerid][pMuAc]) string = "Da";
		else string="Ne";
		format(printstring, sizeof(printstring), "Muriatic acid: %s", string);
		SendClientMessage(playerid, COLOR_GREY, printstring);
		if(PlayerInfo[playerid][pHc]) string = "Da";
		else string="Ne";
		format(printstring, sizeof(printstring), "Hydrogen chloride: %s", string);
		SendClientMessage(playerid, COLOR_GREY, printstring);
		format(printstring, sizeof(printstring), "Baking soda: %d g", BakingSoda[playerid]);
		SendClientMessage(playerid, COLOR_GREY, printstring);
		return 1;
	}
	else if(strcmp(item,"giveingredients", true) == 0)
	{
		new
			ingredient, tmpString[ 80 ];
		if(sscanf(params, "s[16]ui", item, giveplayerid, ingredient)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /drug giveingredients [Playerid/DioImena][ID Sastojka]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] (1 - Caustic Soda), (2 - Muriatic Acid), (3- Hydrogen Chloride), (4 - Baking soda)");
			return 1;
		}
		switch(ingredient)
		{
			case 1: {
				if(!PlayerInfo[playerid][pHCl]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas sastojak Caustic Soda!");
				PlayerInfo[giveplayerid][pHCl] = true;
				PlayerInfo[playerid][pHCl] = false;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				format(tmpString, sizeof(tmpString), "%s ti je dao sastojak po imenu Caustic Soda!", GetName(playerid, false));
				SendMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, tmpString);
				format(tmpString, sizeof(tmpString), "Dao si %s sastojak po imenu Caustic Soda!", GetName(giveplayerid, false));
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, tmpString);
			}
			case 2:
			{
				if(!PlayerInfo[playerid][pMuAc]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas sastojak Muriatic Acid!");
				PlayerInfo[giveplayerid][pMuAc] = true;
				PlayerInfo[playerid][pMuAc] = false;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				format(tmpString, sizeof(tmpString), "%s ti je dao sastojak po imenu Muriatic Acid!", GetName(playerid, false));
				SendMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, tmpString);
				format(tmpString, sizeof(tmpString), "Dao si %s sastojak po imenu Muriatic Acid!", GetName(giveplayerid, false));
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, tmpString);
			}
			case 3:
			{
				if(!PlayerInfo[playerid][pHc]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas sastojak Hydrogen Chloride!");
				PlayerInfo[giveplayerid][pHc] = true;
				PlayerInfo[playerid][pHc] = false;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				format(tmpString, sizeof(tmpString), "%s ti je dao sastojak po imenu Hydrogen Chloride!", GetName(playerid, false));
				SendMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, tmpString);
				format(tmpString, sizeof(tmpString), "Dao si %s sastojak po imenu Hydrogen Chloride!", GetName(giveplayerid, false));
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, tmpString);
			}
			case 4:
			{
				if(!BakingSoda[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas sastojak Baking Soda!");
				BakingSoda[giveplayerid] += BakingSoda[playerid];
				new sodagiven = BakingSoda[playerid];
				BakingSoda[playerid] = 0;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				format(tmpString, sizeof(tmpString), "%s ti je dao %d g sode bikarbone(Baking Soda)", GetName(playerid, false), sodagiven);
				SendMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, tmpString);
				format(tmpString, sizeof(tmpString), "Dao si %s %d g sode bikarbone(Baking Soda)!", GetName(giveplayerid, false), sodagiven);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, tmpString);
			}
		}
		return 1;
	}
	else if(strcmp(item,"startcooking",true) == 0)
	{
		if( PlayerDrugs[playerid][dCode][0] != 0 && PlayerDrugs[playerid][dCode][1] != 0 && PlayerDrugs[playerid][dCode][2]!= 0 && PlayerDrugs[playerid][dCode][3] != 0 && PlayerDrugs[playerid][dCode][4] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi su vam slotovi zauzeti!");
		if(Bit8_Get(gr_SecondsPassed, playerid) > 0) return SendClientMessage(playerid,COLOR_RED, "Vec kuhas methamphetamin!");
		new kuca = Bit16_Get(gr_PlayerInHouse, playerid);
		if(kuca == 9999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
		if(!IsPlayerInRangeOfPoint(playerid,20,HouseInfo[kuca][hExitX], HouseInfo[kuca][hExitY], HouseInfo[kuca][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[kuca][hVirtualWorld]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
		if( PlayerInfo[playerid][pJob] == DRUG_DEALER_ID ) {
			SendClientMessage(playerid, COLOR_RED, "John: Uredu, zapoceo si s kuhanjem Methamphetamina. Ne brini ja cu ti pomagati putem!");
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "[NOTE]: Pricekaj jednu minutu za upute!");

			new Float:px, Float:py, Float:pz;
			GetPlayerPos(playerid, px, py, pz);
			GetXYInFrontOfPlayer(playerid, px, py, 2.0);

			PlayerMethLab[playerid][posX] = px;
			PlayerMethLab[playerid][posY] = py;
			PlayerMethLab[playerid][posZ] = pz;

			Bit8_Set(gr_SecondsPassed, playerid, 0);
			KillTimer(DestroyLabTimer[playerid]);
			DestroyJohnsTextDraw(playerid);
			CreateJohnsTextDraw(playerid);
			CookingTimer[playerid] = SetTimerEx("OnPlayerCookMeth", 1000, true, "i", playerid);
		} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo dileri droge mogu proizvoditi metamfetamin!");
		return 1;
	}
	else if(strcmp(item,"putcomp",true) == 0)
	{
		new comp;
		if(sscanf(params, "s[16]i", item, comp))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /cookmeth putcomp [odabir]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] 1 - Custic Soda, 2 - Muriatic Acid, 3 - Hydrogen Chloride");
			return 1;
		}
		switch(comp)
		{
			case 1: {
				if(!PlayerInfo[playerid][pHCl]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate Custic Soda!");
				CheckMethComp(playerid, CookingRecipe[playerid], HCl_DILUTED);
				PlayerInfo[playerid][pHCl] = false;
				return 1;
			}
			case 2: {
				if(!PlayerInfo[playerid][pMuAc]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate Muriatic Acid!");
				CheckMethComp(playerid, CookingRecipe[playerid], MURIATIC_ACID);
				PlayerInfo[playerid][pMuAc] = false;
				return 1;
			}
			case 3: {
				if(!PlayerInfo[playerid][pHc]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate Hydrogen Chloride!");
				CheckMethComp(playerid, CookingRecipe[playerid], HYDROGEN_CHLORIDE);
				PlayerInfo[playerid][pHc] = false;
				return 1;
			}
			default: SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi odabir!");
		}
		return 1;
	}
	else if(strcmp(item,"vehinfo",true) == 0)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		// Rest
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar vozila!");
		if( !Iter_Contains(COVehicles, vehicleid) ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u privatnome vozilu!");

		if( Iter_Count(CODrugs[vehicleid]) == 0 ) return SendClientMessage(playerid,COLOR_RED, "Nemate droge pohranjene u vozilu!");
        ShowPlayerDialog(playerid, DIALOG_ALERT, DIALOG_STYLE_MSGBOX, "\tDroge u vozilu:", ListPlayerVehicleDrugs(playerid, vehicleid), "Close","");
		return 1;
	}
    return 1;
}
CMD:agivedrug(playerid, params[])
{
	new giveplayerid, item, Float:amount, drug, name[MAX_PLAYER_NAME+1], gname[MAX_PLAYER_NAME+1];
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(1337+).");
	if(sscanf(params, "uif", giveplayerid, item, amount))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /agivedrug [Playerid/DioImena][Vrsta][Amount]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Marijuana), (2 - Cocaine), (3 - Crack), (4 - Methamphetamine), (5 - Ecstasy), (6 - Heroin)");
		return 1;
	}
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(giveplayerid, gname, sizeof(gname));

	if(item == 1) drug = 1999; else if(item == 2) drug = 5999; else if(item == 3) drug = 6999; else if(item == 4) drug = 7999; else if(item == 5) drug = 8999; else if(item == 6) drug = 9999;
	else SendClientMessage(playerid, COLOR_RED, "Nepoznata vrsta!");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
	
	new	index = -1;	
	if(PlayerDrugs[giveplayerid][dCode][0] == 0)		index = 0;
	else if(PlayerDrugs[giveplayerid][dCode][1] == 0)	index = 1;
	else if(PlayerDrugs[giveplayerid][dCode][2]== 0) 	index = 2;
	else if(PlayerDrugs[giveplayerid][dCode][3] == 0) 	index = 3;
	else if(PlayerDrugs[giveplayerid][dCode][4] == 0)	index = 4;	
	if(index != -1)
	{
		PlayerDrugs[giveplayerid][dSQLID][index]    = -1;
		PlayerDrugs[giveplayerid][dCode][index] 	= drug;
		PlayerDrugs[giveplayerid][dAmount][index]	= amount;
		PlayerDrugs[playerid][dTimeStamp][index] 	= gettimestamp() + PLAYER_DRUG_TIMESTAMP;
		SavePlayerDrugSlot(playerid, index);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "Admin %s vam je dao %.2f g %s.", name, amount, GetDrugNameByDrugID(drug));
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dao si %s %.2f g %s.", gname, amount, GetDrugNameByDrugID(drug));
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nazalost, svi drug slotovi su popunjeni!");
	return 1;
}
