#include <YSI_Coding\y_hooks>

#define NEXT_DELIVERY_TIMESTAMP		(604800) // Tjedan dana u sekundama. 7 dana * 24h * 60 min * 60 sec
#define DELIVERY_TYPE_COKE			(0)
#define DELIVERY_TYPE_HEROIN		(1)
#define DELIVERY_TYPE_ECSTASY		(2)
#define MAX_DELIVERY_TYPES			(3)

#define COCAINE_DELIVERY_AMOUNT		(200)
#define HEROIN_DELIVERY_AMOUNT		(200)
#define ECSTASY_DELIVERY_AMOUNT		(200)

new Cocaine = 0,
	Heroin = 0,
	Ecstasy = 0,
	NextDrugDelivery = 0;
	
enum E_DRUG_DELIVERY_DATA
{
	dTaken,
	dLimit
}
new	FactionDrugs[MAX_FACTIONS][E_DRUG_DELIVERY_DATA][MAX_DELIVERY_TYPES];

stock LoadDrugDelivery()
{
	new loadQuery[100];
	format(loadQuery, sizeof(loadQuery), "SELECT * FROM `drug_deliveries`");
	mysql_tquery(g_SQL, loadQuery, "LoadingDrugDelivery", "");
	return 1;
}

Public:LoadingDrugDelivery()
{
	if(!cache_num_rows()) return 0;
	cache_get_value_name_int(0,		"coke"			, Cocaine);
	cache_get_value_name_int(0, 	"heroin"		, Heroin);
	cache_get_value_name_int(0, 	"ecstasy"		, Ecstasy);
	cache_get_value_name_int(0, 	"nextdelivery"	, NextDrugDelivery);
	SetDrugLimitPerFaction();
	return 1;
}

stock UpdateDrugDelivery()
{
	new updateQuery[128];
	format(updateQuery, 128, "UPDATE `drug_deliveries` SET `coke`='%d', `heroin`='%d', `ecstasy`='%d', `nextdelivery`='%d' WHERE `id`='1'", 
		Cocaine,
		Heroin,
		Ecstasy,
		NextDrugDelivery
	);
	mysql_tquery(g_SQL, updateQuery, "", "");
	return 1;
}

Public:SetDrugLimitPerFaction()
{
	if( gettimestamp() >= DrugDistributionStamp )
	{
		new count = 1, f;
		DrugDistributionStamp = gettimestamp() + 3600;
		foreach(f: Factions)
		{
			if(FactionInfo[f][fType] == 4) // FACTION_TYPE_MAFIA
				count++;
		}
		new cokelimit = Cocaine / count,
			heroinlimit = Heroin / count,
			exlimit = Ecstasy / count;
			
		foreach(new fid: Factions)
		{
			FactionDrugs[fid][dLimit][DELIVERY_TYPE_COKE] = cokelimit;
			FactionDrugs[fid][dLimit][DELIVERY_TYPE_HEROIN] = heroinlimit;
			FactionDrugs[fid][dLimit][DELIVERY_TYPE_ECSTASY] = exlimit;
		}
	}
	return 1;
}

stock ResetFactionDrugsUptake()
{
	new resetQuery[128];
	foreach(new factionid: Factions)
	{
		format(resetQuery, sizeof(resetQuery), "UPDATE `server_factions` SET `coke_taken` = '0', `heroin_taken` = '0', `ecstasy_taken` = '0' WHERE id = '%d'",
			FactionInfo[factionid][fID]
		);
		mysql_tquery(g_SQL, resetQuery, "", "");
		
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_COKE] = 0;
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_HEROIN] = 0;
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_ECSTASY] = 0;
	}
	return 1;
}

stock UpdateFactionDrugsUptake(factionid)
{
	new updateQuery[128];
	format(updateQuery, sizeof(updateQuery), "UPDATE `server_factions` SET `coke_taken` = '%d', `heroin_taken` = '%d', `ecstasy_taken` = '%d' WHERE id = '%d'",
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_COKE],
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_HEROIN],
		FactionDrugs[factionid][dTaken][DELIVERY_TYPE_ECSTASY],
		FactionInfo[factionid][fID]
	);
	mysql_tquery(g_SQL, updateQuery, "", "");
	return 1;
}

stock CheckDrugDelivery()
{
	if(gettimestamp() >= NextDrugDelivery && NextDrugDelivery != 0)
	{
		Cocaine = COCAINE_DELIVERY_AMOUNT;
		Heroin = HEROIN_DELIVERY_AMOUNT;
		Ecstasy = ECSTASY_DELIVERY_AMOUNT;
		NextDrugDelivery = gettimestamp() + NEXT_DELIVERY_TIMESTAMP;
		SendDrugLordsMessage("[SMS] Mole: Roba je stigla na lokacije.");
		UpdateDrugDelivery();
		ResetFactionDrugsUptake();
		SetDrugLimitPerFaction();
	}
	return 1;
}