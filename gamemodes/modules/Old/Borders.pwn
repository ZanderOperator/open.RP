#include <YSI\y_hooks>

#define PASSPORT_PRICE 4000

new 
	bool:lockedborders = false,
	borderramp[10],
	borderguard[10];
stock CreateBorderActors()
{

	borderguard[0] = CreateActor(287, 73.4370, -1272.5922, 14.4128, 36.3602);
	borderguard[1] = CreateActor(287, 84.2030, -1298.7950, 13.3521, 41.2051);
	borderguard[2] = CreateActor(287, 54.5968, -1533.8296, 8.2632, 79.6169);
	borderguard[3] = CreateActor(287, 55.2113, -1530.0137, 8.2451, 82.5819);
	borderguard[4] = CreateActor(287, 61.8641, -1530.9474, 8.1758, 255.3752);
	borderguard[5] = CreateActor(287, 61.3436, -1535.4199, 8.2006, 261.9553);
	
	SetActorPos(borderguard[5],61.3436, -1535.4199, 8.2006);
	SetActorPos(borderguard[4],61.8641, -1530.9474, 8.1758);
	SetActorPos(borderguard[3],55.2113, -1530.0137, 8.2451 );
	SetActorPos(borderguard[2], 54.5968, -1533.8296, 8.2632);
	
	ApplyActorAnimation(borderguard[0], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);
	ApplyActorAnimation(borderguard[1], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);
	ApplyActorAnimation(borderguard[2], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);
	ApplyActorAnimation(borderguard[3], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);
	ApplyActorAnimation(borderguard[4], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);
	ApplyActorAnimation(borderguard[5], "RYDER", "Van_Stand", 4.1, 0, 0, 0, 0, 0);

}
hook OnGameModeInit()
{
	CreateDynamicObject(3749, 67.16945, -1270.36194, 19.14469,   0.00000, 0.00000, 306.71490);
	borderramp[0] = CreateDynamicObject(980, 67.47943, -1270.01929, 16.06061,   0.00000, 0.00000, 308.43381);
	CreateDynamicObject(4640, 76.67612, -1272.12610, 15.13603,   0.00000, 0.00000, 218.19290);
	CreateDynamicObject(3749, 83.02790, -1291.84802, 18.24919,   0.00000, 0.00000, 307.57440);
	borderramp[1] = CreateDynamicObject(980, 82.56967, -1292.25513, 15.10538,   0.00000, 0.00000, 306.71490);
	CreateDynamicObject(4640, 82.25919, -1301.72888, 13.89943,   0.00000, 0.00000, 218.94920);
	CreateDynamicObject(8168, 58.40670, -1532.72534, 5.98080,   0.00000, 0.00000, 99.58010);
	CreateDynamicObject(966, 60.14359, -1537.15649, 4.05740,   0.00000, 0.00000, 82.00000);
	borderramp[2] = CreateDynamicObject(968, 60.16029, -1537.03564, 4.84430,   0.00000, -90.00000, 82.30301);
	CreateDynamicObject(966, 56.66054, -1528.18469, 4.05740,   0.00000, 0.00000, 262.85126);
	borderramp[3] = CreateDynamicObject(968, 56.67529, -1528.36804, 4.90545,   0.00000, -90.00000, 263.03824);
	CreateDynamicObject(16362, 1716.95251, 461.32999, 32.83850,   0.00000, -2.00000, 251.00000);
	CreateDynamicObject(8168, 1713.78992, 462.09683, 31.51242,   0.00000, 0.00000, 267.57458);
	CreateDynamicObject(8168, 1719.78992, 460.01205, 31.51242,   0.00000, 0.00000, 87.36912);
	borderramp[4] = CreateDynamicObject(980, 1705.41064, 465.35849, 32.01270,   0.00000, 0.00000, 341.09241);
	borderramp[5] = CreateDynamicObject(980, 1728.24927, 457.46753, 32.01265,   0.00000, 0.00000, 341.95181);
	CreateBorderActors();
	return 1;
}

forward resetramps();
public resetramps()
{
	MoveDynamicObject(borderramp[0],67.47943, -1270.01929, 16.06061, 2.00);
	MoveDynamicObject(borderramp[1],82.56967, -1292.25513, 15.10538, 2.00);
	SetDynamicObjectRot(borderramp[2],0.0000, -90.0000, 82.0000);
	SetDynamicObjectRot(borderramp[3], 0.0000, 90, 82.0000);
	MoveDynamicObject(borderramp[4], 1705.41064, 465.35849, 32.01270, 3.00); 
	MoveDynamicObject(borderramp[5], 1728.24927, 457.46753, 32.01265, 3.00);
}

CMD:passport(playerid, params[])
{
	new
		pick[5];

	if(sscanf(params,"s[5]", pick))
	{	
		SendClientMessage(playerid, COLOR_WHITE, "|__________________ PASSPORT __________________|");
		SendClientMessage(playerid, COLOR_GREY, "[ ? ]: /passport [opcija]");
		SendClientMessage(playerid, COLOR_GREY, "OPCIJA: show, get");
		SendClientMessage(playerid, COLOR_WHITE, "|_______________________________________________|");
		
		return 1;
	}

	if(strcmp(pick,"show",true) == 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 4.0, 69.8609, -1268.5585, 14.2197) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			MoveDynamicObject(borderramp[0], 67.479431, -1270.019287, 10.235611, 3.000);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 4.0, 81.1532, -1293.8019, 13.2215) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			MoveDynamicObject(borderramp[1], 82.569672, -1292.255127, 9.280392, 3.000);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW2, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 4.0, 56.3443,-1540.5697,4.6808) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			SetDynamicObjectRot(borderramp[2], 0.0000, -2.0000, 82.0000);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
			SetDynamicObjectRot(borderramp[3], 0.0000, -90.0000, 82.0000);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 4.0, 60.3898,-1524.7972,4.9470) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			SetDynamicObjectRot(borderramp[3], 0.0000, 0, 82.0000);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW2, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.5, 1726.2910,451.3956,30.7800) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			MoveDynamicObject(borderramp[5], 1705.41064, 465.35849, 26.01270, 3);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.5, 1707.3743,470.7288,30.4953) && PlayerInfo[playerid][pPassport] == 1)
		{
			if(lockedborders == true) return SendClientMessage(playerid, COLOR_WHITE, "Policajac: Granice su trenutno zatvorene, odmaknite se!");
			if(AC_GetPlayerMoney(playerid) < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca kod sebe (10$)");
			MoveDynamicObject(borderramp[4], 1728.24927, 457.46753, 26.01265, 3);
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW2, 10); // Novac ide u LAW factionbank
			SendClientMessage(playerid, COLOR_WHITE, "Policajac: Sve je u redu, mozes proci.");
			SetTimer("resetramps", 7000, 0);
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu granice ili nemas pasos.");
	}
	else if(strcmp(pick,"get", true) == 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 10.0, 1472.1774, -1613.3490, -70.3896 )) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazis se u vijecnici.");
		if(PlayerInfo[playerid][pPassport] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imas pasos.");
		if(AC_GetPlayerMoney(playerid) < PASSPORT_PRICE) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca (%d$).", PASSPORT_PRICE);
		PlayerToOrgMoneyTAX(playerid, FACTION_TYPE_LAW, PASSPORT_PRICE); // Novac ide u LAW factionbank, ali je oporeziv
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si preuzeo putovnicu.");
		PlayerInfo[playerid][pPassport] = 1;
		
		// MySQL query
		new passUpdate[64];
		format(passUpdate, 64, "UPDATE `accounts` SET `passport` = '1' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pSQLID]
		);
		mysql_tquery(g_SQL, passUpdate);
	}
	return 1;
}
