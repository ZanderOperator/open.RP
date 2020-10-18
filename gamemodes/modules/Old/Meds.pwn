#include <YSI_Coding\y_hooks>

#define MAX_MEDS_SLOTS (5)
#define MAX_MEDS_AMOUNT (100)

#define MEDS_TYPE_NONE
#define MEDS_TYPE_TABLET

#define GetMedsNameByDrugID(%0) \
			meds[%0][dName]

static const
	meds[][E_DRUG_INFO] =
{
	{"Prazno", 		DRUG_TYPE_NONE,   0, 0},
	{"Aspirin", 	MEDS_TYPE_TABLET, 15, 35},
	{"Methadone",	DRUG_TYPE_TABLET, 15, 40},
	{"ANaltrexone", DRUG_TYPE_TABLET, 15, 50}
};

Public:LoadPlayerMeds(playerid)
{
	new
		tmpQuery[128];

	format(tmpQuery, 128, "SELECT * FROM `player_meds` WHERE `player_id` = '%d'", PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, tmpQuery, "LoadingPlayerMeds", "i", playerid);
	return 1;
}

forward LoadingPlayerMeds(playerid);
public LoadingPlayerMeds(playerid)
{

	#if defined MOD_DEBUG
		printf("DEBUG DRUGS: count(%d)", cache_num_rows());
	#endif

	if(cache_num_rows())
	{
	    for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", PlayerMeds[playerid][mSQLID][i]);
			cache_get_value_name_int(i, "code", PlayerMeds[playerid][mCode][i]);
			cache_get_value_name_float(i, "amount", PlayerMeds[playerid][mAmount][i]);
			cache_get_value_name_int(i, "effect", PlayerMeds[playerid][mEffect][i]);
		}
	}
	return 1;
}
