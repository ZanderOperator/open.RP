#include <YSI_Coding\y_hooks>

#define MAX_OBJS  		100
#define MAX_TOBJS   	29
#define MAX_RAND 		32767
#define FINAL_CP_CYCLE 	16
#define FINAL_CP_SWIM	9

#define HIDE_TEXT_TIME 20000

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//===================================//
new Float:MiniSpawns[8][4] =
{
    {1237.001343,-2031.758545,60.551205,268.0000},
	{1237.087769,-2030.034424,60.576206,268.0000},
	{1237.237793,-2027.961792,60.426197,268.0000},
	{1237.336670,-2025.825806,60.326191,268.0000},
	{1240.417236,-2031.980713,59.476139,268.0000},
	{1240.311157,-2026.085327,59.526142,268.0000},
	{1240.278809,-2028.149902,59.551144,268.0000},
	{1240.300537,-2030.038940,59.526142,268.0000}
};

new tObj[MAX_TOBJS];
new PCP[MAX_PLAYERS];
new PlayerJoined[MAX_PLAYERS];
new bool:MiniOn;
new TP;

new bool:shitstarted;
new inctimer[MAX_PLAYERS];
new MIN[MAX_PLAYERS];
new SEC[MAX_PLAYERS];
new First;
new winner[MAX_PLAYER_NAME];

new Text:Tbg;
new Text:TT[MAX_PLAYERS];
new Text:NO[MAX_PLAYERS];
new Text:BG;
new Text:TR;
new Text:C_TT[MAX_PLAYERS];
new Text:C_CP[MAX_PLAYERS];
new Text:A_TT[MAX_PLAYERS];
new Text:A_OB[MAX_PLAYERS];
new Text:A_AC[MAX_PLAYERS];
new Text:S_CP[MAX_PLAYERS];
new Text:S_TT[MAX_PLAYERS];
new Text:Cycle;
new Text:Shoot;
new Text:Swim;
new Text:T_TT[MAX_PLAYERS];
new Text:Winner;
//***************************MOUNTAIN BIKE RACE*******************************//
new Float:CRaceCPoints[17][3] =
{
	{1273.332275,-2056.174316,58.064869},
	{1389.242432,-2047.083130,54.034203},
	{1426.094849,-1988.133789,48.100159},
	{1315.031494,-1957.947998,28.298063},
	{1260.021973,-1908.830322,28.799747},
	{1422.825806,-1922.275146,14.627296},
	{1332.206909,-1853.607300,12.382813},
	{1222.804077,-1852.206665,12.382813},
	{1061.719849,-1849.264771,12.567745},
	{983.637329,-1785.176270,13.074606},
	{843.459045,-1769.413818,12.395102},
	{827.917297,-1841.450439,11.644958},
	{845.218689,-1890.641602,11.867188},
	{830.854797,-1943.510010,11.867188},
	{844.152771,-2001.475952,11.867188},
	{835.849304,-2055.608154,11.867188},
	{0.0,0.0,0.0}
};
new bool:IsPlayerRacing[MAX_PLAYERS];
new c_minutes[MAX_PLAYERS];
new c_seconds[MAX_PLAYERS];
//*******************************SHOOTING RANGE*******************************//
enum moveobjs
{
	Float:obX[MAX_PLAYERS],
	Float:obY[MAX_PLAYERS],
	Float:obZ[MAX_PLAYERS]
};

new Float:sluc_float[17] =
{0.8, 0.9, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9};

new AimObject[MAX_OBJS][moveobjs];

new A_Objects[MAX_OBJS][MAX_PLAYERS];
new pTobjects[MAX_PLAYERS];
new robjects[MAX_PLAYERS];
new obj_hit[MAX_PLAYERS];
new shootpick[5];
new oCount = 0;
new bool:IsPlayerShooting[MAX_PLAYERS];
new a_minutes[MAX_PLAYERS];
new a_seconds[MAX_PLAYERS];
new Float:accuracy[MAX_PLAYERS];
//********************************SWIMMING RACE*******************************//
new Float:SRaceCPoints[10][3] =
{
	{834.885010,-2094.992676,0.007755},
	{719.189026,-2094.839844,0.009658},
	{725.342163,-1969.148926,0.055709},
	{724.468750,-1887.028687,-0.014958},
	{724.574524,-1778.495361,-0.020918},
	{723.868225,-1695.539795,-0.069923},
	{724.020508,-1580.007324,0.069664},
	{723.220154,-1488.487915,0.934345},
	{728.4586,-1440.3844,17.6953},
	{0.0,0.0,0.0}
};
new bool:IsPlayerSwimmingTwo[MAX_PLAYERS];
new s_minutes[MAX_PLAYERS];
new s_seconds[MAX_PLAYERS];
//===================================//
forward StartCycleRace();
forward StopCycleRaceForPlayer(playerid);
forward TextDrawUpdate(playerid);
forward StartAccuTest(playerid);
forward StartShootingForPlayer(playerid);
forward EndShootingForPlayer(playerid);
forward StartSwimmingForPlayer(playerid);
forward StopSwimmingForPlayer(playerid);
forward EndTriathlon();
forward HideText();
//===================================//
hook OnGameModeInit()
{
    Tbg = TextDrawCreate(630.000000, 371.000000, "_");
	TextDrawBackgroundColor(Tbg, 255);
	TextDrawFont(Tbg, 1);
	TextDrawLetterSize(Tbg, 0.500000, 7.200000);
	TextDrawColor(Tbg, -1);
	TextDrawSetOutline(Tbg, 0);
	TextDrawSetProportional(Tbg, 1);
	TextDrawSetShadow(Tbg, 1);
	TextDrawUseBox(Tbg, 1);
	TextDrawBoxColor(Tbg, 252645270);
	TextDrawTextSize(Tbg, 460.000000, 40.000000);

	BG = TextDrawCreate(505.000000, 129.000000, "_");
	TextDrawBackgroundColor(BG, 255);
	TextDrawFont(BG, 1);
	TextDrawLetterSize(BG, 0.549998, 23.600002);
	TextDrawColor(BG, -1);
	TextDrawSetOutline(BG, 1);
	TextDrawSetProportional(BG, 1);
	TextDrawUseBox(BG, 1);
	TextDrawBoxColor(BG, 252645270);
	TextDrawTextSize(BG, 108.000000, 0.000000);

	TR = TextDrawCreate(204.000000, 128.000000, "Rezultati Triatlona");
	TextDrawBackgroundColor(TR, 255);
	TextDrawFont(TR, 2);
	TextDrawLetterSize(TR, 0.500000, 1.500000);
	TextDrawColor(TR, 845453000);
	TextDrawSetOutline(TR, 0);
	TextDrawSetProportional(TR, 1);
	TextDrawSetShadow(TR, 1);

	Cycle = TextDrawCreate(149.000000, 150.000000, "Biciklizam");
	TextDrawBackgroundColor(Cycle, 255);
	TextDrawFont(Cycle, 1);
	TextDrawLetterSize(Cycle, 0.480000, 1.200000);
	TextDrawColor(Cycle, -1);
	TextDrawSetOutline(Cycle, 0);
	TextDrawSetProportional(Cycle, 1);
	TextDrawSetShadow(Cycle, 1);

	Shoot = TextDrawCreate(265.000000, 150.000000, "Pucanje");
	TextDrawBackgroundColor(Shoot, 255);
	TextDrawFont(Shoot, 1);
	TextDrawLetterSize(Shoot, 0.480000, 1.200000);
	TextDrawColor(Shoot, -1);
	TextDrawSetOutline(Shoot, 0);
	TextDrawSetProportional(Shoot, 1);
	TextDrawSetShadow(Shoot, 1);

	Swim = TextDrawCreate(390.000000, 150.000000, "Plivanje");
	TextDrawBackgroundColor(Swim, 255);
	TextDrawFont(Swim, 1);
	TextDrawLetterSize(Swim, 0.480000, 1.200000);
	TextDrawColor(Swim, -1);
	TextDrawSetOutline(Swim, 0);
	TextDrawSetProportional(Swim, 1);
	TextDrawSetShadow(Swim, 1);

	Winner = TextDrawCreate(290.000000, 297.000000, "Pobjednik:");
	TextDrawAlignment(Winner, 2);
	TextDrawBackgroundColor(Winner, 255);
	TextDrawFont(Winner, 2);
	TextDrawLetterSize(Winner, 0.389999, 1.799999);
	TextDrawColor(Winner, -1);
	TextDrawSetOutline(Winner, 0);
	TextDrawSetProportional(Winner, 1);
	TextDrawSetShadow(Winner, 1);

	for(new i=0; i<MAX_PLAYERS; i++)
	{
		TT[i] = TextDrawCreate(470.000000, 381.000000, "Vrijeme: 00:00");
		TextDrawBackgroundColor(TT[i], 255);
		TextDrawFont(TT[i], 1);
		TextDrawLetterSize(TT[i], 0.500000, 1.500000);
		TextDrawColor(TT[i], -1);
		TextDrawSetOutline(TT[i], 0);
		TextDrawSetProportional(TT[i], 1);
		TextDrawSetShadow(TT[i], 1);

		NO[i] = TextDrawCreate(470.000000, 408.000000, "Checkpoint: 0/16");
		TextDrawBackgroundColor(NO[i], 255);
		TextDrawFont(NO[i], 1);
		TextDrawLetterSize(NO[i], 0.500000, 1.500000);
		TextDrawColor(NO[i], -1);
		TextDrawSetOutline(NO[i], 0);
		TextDrawSetProportional(NO[i], 1);
		TextDrawSetShadow(NO[i], 1);

		C_TT[i] = TextDrawCreate(120.000000, 170.000000, "Vrijeme:");
		TextDrawBackgroundColor(C_TT[i], 255);
		TextDrawFont(C_TT[i], 1);
		TextDrawLetterSize(C_TT[i], 0.330000, 1.199999);
		TextDrawColor(C_TT[i], -1);
		TextDrawSetOutline(C_TT[i], 0);
		TextDrawSetProportional(C_TT[i], 1);
		TextDrawSetShadow(C_TT[i], 1);

		C_CP[i] = TextDrawCreate(120.000000, 200.000000, "Checkpointi:");
		TextDrawBackgroundColor(C_CP[i], 255);
		TextDrawFont(C_CP[i], 1);
		TextDrawLetterSize(C_CP[i], 0.330000, 1.199999);
		TextDrawColor(C_CP[i], -1);
		TextDrawSetOutline(C_CP[i], 0);
		TextDrawSetProportional(C_CP[i], 1);
		TextDrawSetShadow(C_CP[i], 1);

		A_TT[i] = TextDrawCreate(250.000000, 170.000000, "Vrijeme:");
		TextDrawBackgroundColor(A_TT[i], 255);
		TextDrawFont(A_TT[i], 1);
		TextDrawLetterSize(A_TT[i], 0.330000, 1.199999);
		TextDrawColor(A_TT[i], -1);
		TextDrawSetOutline(A_TT[i], 0);
		TextDrawSetProportional(A_TT[i], 1);
		TextDrawSetShadow(A_TT[i], 1);

		A_OB[i] = TextDrawCreate(250.000000, 200.000000, "Objekti:");
		TextDrawBackgroundColor(A_OB[i], 255);
		TextDrawFont(A_OB[i], 1);
		TextDrawLetterSize(A_OB[i], 0.330000, 1.199999);
		TextDrawColor(A_OB[i], -1);
		TextDrawSetOutline(A_OB[i],	 0);
		TextDrawSetProportional(A_OB[i], 1);
		TextDrawSetShadow(A_OB[i], 1);

		A_AC[i] = TextDrawCreate(250.000000, 230.000000, "Preciznost:");
		TextDrawBackgroundColor(A_AC[i], 255);
		TextDrawFont(A_AC[i], 1);
		TextDrawLetterSize(A_AC[i], 0.330000, 1.199999);
		TextDrawColor(A_AC[i], -1);
		TextDrawSetOutline(A_AC[i], 0);
		TextDrawSetProportional(A_AC[i], 1)	;
		TextDrawSetShadow(A_AC[i], 1);

		S_CP[i] = TextDrawCreate(380.000000, 200.000000, "Checkpointi:");
		TextDrawBackgroundColor(S_CP[i], 255);
		TextDrawFont(S_CP[i], 1);
		TextDrawLetterSize(S_CP[i], 0.330000, 1.199999);
		TextDrawColor(S_CP[i], -1);
		TextDrawSetOutline(S_CP[i], 0);
		TextDrawSetProportional(S_CP[i], 1);
		TextDrawSetShadow(S_CP[i], 1);

		S_TT[i] = TextDrawCreate(380.000000, 170.000000, "Vrijeme:");
		TextDrawBackgroundColor(S_TT[i], 255);
		TextDrawFont(S_TT[i], 1);
		TextDrawLetterSize(S_TT[i], 0.330000, 1.199999);
		TextDrawColor(S_TT[i], -1);
		TextDrawSetOutline(S_TT[i], 0);
		TextDrawSetProportional(S_TT[i], 1);
		TextDrawSetShadow(S_TT[i], 1);

		T_TT[i] = TextDrawCreate(220.000000, 267.000000, "Ukupno vrijeme: 00:00");
		TextDrawBackgroundColor(T_TT[i], 255);
		TextDrawFont(T_TT[i], 2);
		TextDrawLetterSize(T_TT[i], 0.389999, 1.799999);
		TextDrawColor(T_TT[i], -1);
		TextDrawSetOutline(T_TT[i], 0);
		TextDrawSetProportional(T_TT[i], 1);
		TextDrawSetShadow(T_TT[i], 1);
	}
	return 1;
}
//===================================//
hook OnGameModeExit()
{
   	EndTriathlon();
	return 1;
}
//===================================//
hook OnPlayerDisconnect(playerid, reason)
{
	if(PlayerJoined[playerid] == 1)
    {
    	PlayerJoined[playerid] = 0;
    	PCP[playerid] = 0;
    	MIN[playerid] = 0;
    	SEC[playerid] = 0;
		c_minutes[playerid] = 0;
		c_seconds[playerid] = 0;
		s_minutes[playerid] = 0;
		s_seconds[playerid] = 0;
		a_minutes[playerid] = 0;
		a_seconds[playerid] = 0;
		pTobjects[playerid] = 0;
		obj_hit[playerid] = 0;
		robjects[playerid] = 0;
		IsPlayerShooting[playerid] = false;
		accuracy[playerid] = 0;
		AC_ResetPlayerWeapons(playerid);
		for(new i=0; i<MAX_TOBJS; i++)
		{
		    DestroyObject(tObj[i]);
		}
		if(TP == 2)
		{
		    EndTriathlon();
		}
		TP--;
	}
	return 1;
}
//===================================//
hook OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerJoined[playerid] == 1)
    {
    	PlayerJoined[playerid] = 0;
    	PCP[playerid] = 0;
    	MIN[playerid] = 0;
    	SEC[playerid] = 0;
		c_minutes[playerid] = 0;
		c_seconds[playerid] = 0;
		s_minutes[playerid] = 0;
		s_seconds[playerid] = 0;
		a_minutes[playerid] = 0;
		a_seconds[playerid] = 0;
		pTobjects[playerid] = 0;
		obj_hit[playerid] = 0;
		robjects[playerid] = 0;
		IsPlayerShooting[playerid] = false;
		accuracy[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		DisablePlayerRaceCheckpoint(playerid);
		AC_ResetPlayerWeapons(playerid);
		for(new i=0; i<MAX_TOBJS; i++)
		{
		    DestroyObject(tObj[i]);
		}
		if(TP == 2)
		{
		    EndTriathlon();
		}
		TP--;
	}
	return 1;
}
//===================================//
CMD:triatlon(playerid, params[])
{
	if(PlayerJoined[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vec ste na triatlonu.");
	if(MiniOn) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Triatlon mora biti pokrenut!");
	TP++;
	if(TP == 1)
	{
	    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
		First = 1;
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Pokrenuli ste triatlon!");
	    PlayerJoined[playerid] = 1;
	    SetTriSpawn(playerid);
	    new string[128];
	    format(string,sizeof(string), "[ ! ] %s je pokrenuo Triatlon", PlayerName(playerid));
	    SendAdminMessage(COLOR_RED, string);
	}
    else if(TP != 1 && TP < 6)
	{
		PlayerJoined[playerid] = 1;
		SetTriSpawn(playerid);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Prijavili ste se za triatlon.");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Nema slobodnih mjesta.");
	}
    return 1;
}
CMD:startrace(playerid, params[]){
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(MiniOn) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Triatlon mora biti pokrenut!");
	if(shitstarted == false){
	    shitstarted = true;
		SetTimer("StartCycleRace", 10000, false);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Pokrenutili ste Triatlon Count!");
	}
	else return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vec je pokrenut Triatlon");
	return 1;
}
//===================================//
CMD:stoptri(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if(!MiniOn) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Triatlon nije pokrenut.");
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(playerid))
        {
            if(PlayerJoined[i] == 1)
            {
	    	    PlayerJoined[i] = 0;
	    	    MiniOn = false;
	    	    shitstarted = false;
	    	    MIN[i] = 0;
	    	    SEC[i] = 0;
	    	    c_minutes[i] = 0;
				c_seconds[i] = 0;
				s_minutes[i] = 0;
				s_seconds[i] = 0;
				a_minutes[i] = 0;
				a_seconds[i] = 0;
				pTobjects[i] = 0;
				obj_hit[i] = 0;
				SetPlayerVirtualWorld(i, 0);
				SpawnPlayer(playerid);
				DisablePlayerCheckpoint(i);
				DisablePlayerRaceCheckpoint(i);
				AC_ResetPlayerWeapons(i);
				HideText();
				EndTriathlon();
				HideTriTDs(i);
				SendClientMessage(playerid, COLOR_RED, "[ ! ] Administrator je zaustavio Triatlon!");
			}
		}
	}
	for(new i = 0; i<28; i++)
	{
	    DestroyObject(tObj[i]);
	}
	return 1;
}
//===================================//
public StartCycleRace()
{
	if(TP < 1)
	{
	    for(new i = 0; i<MAX_PLAYERS; i++)
		{
	   	 	if(IsPlayerConnected(i))
	   	 	{
	   	 		if(PlayerJoined[i] == 1)
	    		{
	    	    	PlayerJoined[i] = 0;
	    	    	MiniOn = false;
	    	    	c_minutes[i] = 0;
					c_seconds[i] = 0;
					s_minutes[i] = 0;
					s_seconds[i] = 0;
					a_minutes[i] = 0;
					a_seconds[i] = 0;
					pTobjects[i] = 0;
					obj_hit[i] = 0;
					SetPlayerVirtualWorld(i, 0);
				}
			}
		}
		for(new i = 0; i<28; i++)
		{
		    DestroyObject(tObj[i]);
		}
		SendClientMessageToAll(COLOR_RED, "[ ! ] Nije dovoljno slotova, ispunjeno, Triatlon je otkazan!");
        MiniOn = false;
		return 1;
	}
    tObj[0] = CreateObject(16770,834.470886,-2061.860352,13.457747,0,0,-451.203690604705);
	tObj[1] = CreateObject(7415,1267.988037,-2047.902588,68.010406,0,0,-18.0481705425);
	tObj[2] = CreateObject(3749,827.610046,-1841.624390,17.592625,0,0,0);
	tObj[3] = CreateObject(3749,845.445862,-1890.523193,17.725601,0,0,0);
	tObj[4] = CreateObject(3749,829.592224,-1943.385376,17.725601,0,0,0);
	tObj[5] = CreateObject(3749,844.374756,-2001.207275,17.725601,0,0,0);
	tObj[6] = CreateObject(3749,836.334900,-2056.039551,17.725601,0,0,0);
	tObj[7] = CreateObject(1238,835.760986,-1845.852173,12.039591,0,0,0);
	tObj[8] = CreateObject(1238,835.740540,-1851.846680,12.185368,0,0,0);
	tObj[9] = CreateObject(1238,835.801575,-1857.624268,12.185368,0,0,0);
	tObj[10] = CreateObject(1238,836.116516,-1871.669678,12.185368,0,0,0);
	tObj[11] = CreateObject(1238,836.255249,-1877.932739,12.185368,0,0,0);
	tObj[12] = CreateObject(1238,836.524597,-1884.574951,12.185368,0,0,0);
	tObj[13] = CreateObject(1225,835.893982,-1864.494385,12.272943,0,0,0);
	tObj[14] = CreateObject(1238,838.934326,-1930.782349,12.185368,0,0,0);
	tObj[15] = CreateObject(1238,838.920349,-1938.016968,12.185368,0,0,0);
	tObj[16] = CreateObject(1238,838.900818,-1923.343140,12.185368,0,0,0);
	tObj[17] = CreateObject(1238,838.210815,-1909.989380,12.185368,0,0,0);
	tObj[18] = CreateObject(1238,838.068359,-1902.773682,12.185368,0,0,0);
	tObj[19] = CreateObject(1238,837.769714,-1896.132813,12.185368,0,0,0);
	tObj[20] = CreateObject(1225,838.749329,-1916.551147,12.272943,0,0,0);
	tObj[21] = CreateObject(1238,837.477722,-1995.682861,12.185368,0,0,0);
	tObj[22] = CreateObject(1238,837.296265,-1987.223755,12.185368,0,0,0);
	tObj[23] = CreateObject(1238,837.335876,-1978.739502,12.185368,0,0,0);
	tObj[24] = CreateObject(1238,836.794128,-1948.627075,12.185368,0,0,0);
	tObj[25] = CreateObject(1238,836.978333,-1954.809570,12.185368,0,0,0);
	tObj[26] = CreateObject(1238,837.030212,-1963.298706,12.185368,0,0,0);
	tObj[27] = CreateObject(1225,837.202026,-1970.918457,12.272943,0,0,0);
	tObj[28] = CreateObject(17068,836.163024,-2063.765869,10.699330,0,0.5,180);

	shootpick[0] = CreatePickup(1318, 23,841.6972,-2064.9282,12.8672,15);
	shootpick[1] = CreatePickup(1318, 23,838.6654,-2065.0652,12.8672,15);
	shootpick[2] = CreatePickup(1318, 23,835.5880,-2065.0959,12.8672,15);
	shootpick[3] = CreatePickup(1318, 23,832.6954,-2064.6465,12.8672,15);
	shootpick[4] = CreatePickup(1318, 23,829.8810,-2064.5100,12.8672,15);

	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(PlayerJoined[i] == 1)
	    {
	        TextDrawShowForPlayer(i, Tbg);
			TextDrawShowForPlayer(i, TT[i]);
			TextDrawShowForPlayer(i, NO[i]);
	        SendClientMessage(i, COLOR_RED, "[ ! ] Uzmi bicikl i pokreni utrku!");
	        MiniOn = true;
    		IsPlayerRacing[i] = true;
			PCP[i] = 0;
			AC_ResetPlayerWeapons(i);
			TextDrawShowForPlayer(i, TT[i]);
			TextDrawShowForPlayer(i, NO[i]);
  			SetPlayerRaceCheckpoint(i, 0, CRaceCPoints[PCP[i]][0], CRaceCPoints[PCP[i]][1], CRaceCPoints[PCP[i]][2], CRaceCPoints[PCP[i]+1][0], CRaceCPoints[PCP[i]+1][1], CRaceCPoints[PCP[i]+1][2], 8);
            inctimer[i] = SetTimerEx("TextDrawUpdate", 1000, true, "d", i);
		}
	}
	return 1;
}
//===================================//
hook TextDrawUpdate(playerid)
{
	if(IsPlayerRacing[playerid])
	{
		new string[32];
    	c_seconds[playerid]++;
    	if(c_seconds[playerid] < 10)
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:0%d", c_minutes[playerid], c_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}
		else
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:%d", c_minutes[playerid], c_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}

		if(c_seconds[playerid] == 59)
		{
		    c_minutes[playerid]++;
		    c_seconds[playerid] = 0;
		}
	}
	else if(IsPlayerShooting[playerid])
	{
		new string[32];
    	a_seconds[playerid]++;
    	if(a_seconds[playerid] == 59)
		{
		    a_minutes[playerid]++;
		    a_seconds[playerid] = 0;
		}
		if(a_seconds[playerid] < 10)
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:0%d", a_minutes[playerid], a_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}
		else
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:%d", a_minutes[playerid], a_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}
	}
	else if(IsPlayerSwimmingTwo[playerid])
	{
		new string[32];
    	s_seconds[playerid]++;
    	if(s_seconds[playerid] < 10)
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:0%d", s_minutes[playerid], s_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}
		else
		{
		    format(string,sizeof(string), "Vrijeme: 0%d:%d", s_minutes[playerid], s_seconds[playerid]);
    	    TextDrawSetString(TT[playerid], string);
		}

		if(s_seconds[playerid] == 59)
		{
		    s_minutes[playerid]++;
		    s_seconds[playerid] = 0;
		}
	}
	return 1;
}
//===================================//
public StopCycleRaceForPlayer(playerid)
{
	DisablePlayerRaceCheckpoint(playerid);
	PCP[playerid] = 0;
	IsPlayerRacing[playerid] = false;
	MIN[playerid] += c_minutes[playerid];
	SEC[playerid] += c_seconds[playerid];
	KillTimer(inctimer[playerid]);
	TextDrawHideForPlayer(playerid, Tbg);
	TextDrawHideForPlayer(playerid, TT[playerid]);
	TextDrawHideForPlayer(playerid, NO[playerid]);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Odli�no, sada kreni sa pucanjem!");
	return 1;
}
//===================================//
public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(PlayerJoined[playerid] == 1)
	{
		for(new i=0; i<5; i++)
		{
		    if(pickupid == shootpick[i])
			{
			    DestroyPickup(shootpick[i]);
			    StartShootingForPlayer(playerid);
			    break;
			}
		}
	}
	return 1;
}
//===================================//
public StartShootingForPlayer(playerid)
{
    TextDrawShowForPlayer(playerid, Tbg);
    TextDrawSetString(TT[playerid], "Vrijeme: 00:00");
	TextDrawShowForPlayer(playerid, TT[playerid]);
	TextDrawSetString(NO[playerid], "Meta: 0");
	TextDrawShowForPlayer(playerid, NO[playerid]);
    IsPlayerShooting[playerid] = true;
    AC_ResetPlayerWeapons(playerid);
    SetPlayerVirtualWorld(playerid, getIntsluc(20, 30));
    AC_GivePlayerWeapon(playerid, 34, 500);
    MoveShootingObjectsForPlayer(playerid);
	GameTextForPlayer(playerid, "~g~Kreni sa pucanjem!", 1000, 4);
	inctimer[playerid] = SetTimerEx("TextDrawUpdate", 1000, true, "d", playerid);
	return 1;
}
//===================================//
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_FIRE))
    {
        if(MiniOn && PlayerJoined[playerid] == 1)
        {
			for(new i = 0; i <MAX_OBJECTS; i++)
			{
			    if(IsValidPlayerObject(playerid, A_Objects[i][playerid]))
			    {
					new Float:X, Float:Y, Float:Z;
					GetPlayerObjectPos(playerid, A_Objects[i][playerid], X, Y, Z);
			        if(IsPlayerAimingTwo(playerid, X, Y, Z, 0.2))
			        {
			            if(pTobjects[playerid] > 0)
			            {
			            	DestroyPlayerObject(playerid, A_Objects[i][playerid]);
			            	pTobjects[playerid]--;
			            	obj_hit[playerid]++;
			            	new string[32];
							format(string,sizeof(string), "Hits: %d/20",  obj_hit[playerid]);
							TextDrawSetString(NO[playerid], string);
					 		if(pTobjects[playerid] == 0 && obj_hit[playerid] != 20)
	    	  				{
	      						robjects[playerid] = 20 - obj_hit[playerid];
	    	   	 				MoveObjectsForPlayerAgain(playerid);
							}
							else if(obj_hit[playerid] == 20)
							{
							    DestroyPlayerObject(playerid, A_Objects[i][playerid]);
			            		pTobjects[playerid]--;
			            		EndShootingForPlayer(playerid);
							}
						}
					}
				}
			}
		}
	}
	return 1;
}
//===================================//
public OnPlayerObjectMoved(playerid,objectid)
{
    for(new i = 0; i <MAX_OBJECTS; i++)
	{
	    if(objectid == A_Objects[i][playerid])
	    {
	    	if(IsValidPlayerObject(playerid, A_Objects[i][playerid]))
	    	{
          		DestroyPlayerObject(playerid, A_Objects[i][playerid]);
	    	    pTobjects[playerid]--;
				if(pTobjects[playerid] == 0 && obj_hit[playerid] != 20)
	    	  	{
	      			robjects[playerid] = 20 - obj_hit[playerid];
	    	   	 	MoveObjectsForPlayerAgain(playerid);
				}
			}
		}
	}
	return 1;
}
//===================================//
public EndShootingForPlayer(playerid)
{
 	new timetaken = (a_minutes[playerid]*60) + a_seconds[playerid];
	new objs = 20;
	SetPlayerVirtualWorld(playerid, 0);
	accuracy[playerid] = (float(objs) / float(timetaken))*100;
	for(new i=0; i<pTobjects[playerid]; i++)
	{
	    DestroyPlayerObject(playerid, A_Objects[i][playerid]);
	}
	IsPlayerShooting[playerid] = false;
	MIN[playerid] += a_minutes[playerid];
	SEC[playerid] += a_seconds[playerid];
	KillTimer(inctimer[playerid]);
	TextDrawHideForPlayer(playerid, Tbg);
	TextDrawHideForPlayer(playerid, TT[playerid]);
	TextDrawHideForPlayer(playerid, NO[playerid]);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si pogodio sve mete, kreni sa plivanjem!");
	StartSwimmingForPlayer(playerid);
	return 1;
}
//===================================//
public StartSwimmingForPlayer(playerid)
{
    AC_ResetPlayerWeapons(playerid);
    SetPlayerPos(playerid, 836.2539, -2069.1489, 10.8726);
    SetPlayerVirtualWorld(playerid, 16);
	TextDrawShowForPlayer(playerid, Tbg);
    TextDrawSetString(TT[playerid], "Vrijeme: 00:00");
	TextDrawShowForPlayer(playerid, TT[playerid]);
	TextDrawSetString(NO[playerid], "Checkpoint: 0/9");
	TextDrawShowForPlayer(playerid, NO[playerid]);
    IsPlayerSwimmingTwo[playerid] = true;
	PCP[playerid] = 0;
	TextDrawShowForPlayer(playerid, TT[playerid]);
	TextDrawShowForPlayer(playerid, NO[playerid]);
	SetPlayerRaceCheckpoint(playerid, 0, SRaceCPoints[PCP[playerid]][0], SRaceCPoints[PCP[playerid]][1], SRaceCPoints[PCP[playerid]][2], SRaceCPoints[PCP[playerid]+1][0], SRaceCPoints[PCP[playerid]+1][1], SRaceCPoints[PCP[playerid]+1][2], 8);
 	inctimer[playerid] = SetTimerEx("TextDrawUpdate", 1000, true, "d", playerid);
	return 1;
}
//===================================//
public StopSwimmingForPlayer(playerid)
{
	DisablePlayerRaceCheckpoint(playerid);
	PCP[playerid] = 0;
	IsPlayerSwimmingTwo[playerid] = false;
	MIN[playerid] += s_minutes[playerid];
	SEC[playerid] += s_seconds[playerid];
	KillTimer(inctimer[playerid]);
	TextDrawHideForPlayer(playerid, Tbg);
	TextDrawHideForPlayer(playerid, TT[playerid]);
	TextDrawHideForPlayer(playerid, NO[playerid]);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste okon�ali Triatlon. Pricekaj rezultate!");
	return 1;
}
//===================================//
public EndTriathlon()
{
	for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	    	if(PlayerJoined[i] == 1)
	    	{
	    	    new textstr[64];
	    	    PlayerJoined[i] = 0;
	    	    MiniOn = false;
	    	    format(textstr, 64, "Vrijeme: ~g~0%d:%d", c_minutes[i], c_seconds[i]);
	    	    TextDrawSetString(C_TT[i], textstr);

	    	    TextDrawSetString(C_CP[i], "Checkpointi: ~g~16/16");

	    	    format(textstr, 64, "Vrijeme: ~g~0%d:%d", a_minutes[i], a_seconds[i]);
	    	    TextDrawSetString(A_TT[i], textstr);

	    	    format(textstr, 64, "Objekti: ~g~%d/20", obj_hit[i]);
	    	    TextDrawSetString(A_OB[i], textstr);

	    	    format(textstr, 64, "Preciznost: ~g~%.2f", accuracy[i]);
	    	    TextDrawSetString(A_AC[i], textstr);

	    	    format(textstr, 64, "Vrijeme: ~g~%d:%d", s_minutes[i], s_seconds[i]);
	    	    TextDrawSetString(S_TT[i], textstr);

	    	    TextDrawSetString(S_CP[i], "Checkpointi: ~g~9/9");
	    	    if(SEC[i]>59)
	    	    {
	    	        MIN[i]++;
	    	        SEC[i] -= 60;
				}
	    	    format(textstr, 64, "Total Time: ~g~%d:%d", MIN[i], SEC[i]);
	    	    TextDrawSetString(T_TT[i], textstr);

	    	    format(textstr, 64, "Winner: ~y~%s", winner);
	    	    TextDrawSetString(Winner, textstr);

	    	    TextDrawShowForPlayer(i, BG);
	    	    TextDrawShowForPlayer(i, TR);
	    	    TextDrawShowForPlayer(i, C_TT[i]);
	    	    TextDrawShowForPlayer(i, C_CP[i]);
	    	    TextDrawShowForPlayer(i, A_TT[i]);
	    	    TextDrawShowForPlayer(i, A_OB[i]);
	    	    TextDrawShowForPlayer(i, A_AC[i]);
	    	    TextDrawShowForPlayer(i, S_CP[i]);
	    	    TextDrawShowForPlayer(i, S_TT[i]);
	    	    TextDrawShowForPlayer(i, Cycle);
	    	    TextDrawShowForPlayer(i, Shoot);
	    	    TextDrawShowForPlayer(i, Swim);
	    	    TextDrawShowForPlayer(i, T_TT[i]);
	    	    TextDrawShowForPlayer(i, Winner);
	    	    c_minutes[i] = 0;
				c_seconds[i] = 0;
				s_minutes[i] = 0;
				s_seconds[i] = 0;
				a_minutes[i] = 0;
				a_seconds[i] = 0;
				pTobjects[i] = 0;
				obj_hit[i] = 0;
				shitstarted = false;
				AC_ResetPlayerWeapons(i);
				SetTimer("HideText", HIDE_TEXT_TIME, 1);
				SetPlayerVirtualWorld(i, 0);
				PlayerJoined[i] = 0;
			}
		}
	}
	for(new i = 0; i<28; i++)
	{
	    DestroyObject(tObj[i]);
	}
	return 1;
}
//===================================//
public HideText()
{
    for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        TextDrawHideForPlayer(i, BG);
	        TextDrawHideForPlayer(i, TR);
	        TextDrawHideForPlayer(i, C_TT[i]);
	        TextDrawHideForPlayer(i, C_CP[i]);
	        TextDrawHideForPlayer(i, A_TT[i]);
	        TextDrawHideForPlayer(i, A_OB[i]);
	        TextDrawHideForPlayer(i, A_AC[i]);
	        TextDrawHideForPlayer(i, S_CP[i]);
    	    TextDrawHideForPlayer(i, S_TT[i]);
	        TextDrawHideForPlayer(i, Cycle);
	        TextDrawHideForPlayer(i, Shoot);
	        TextDrawHideForPlayer(i, Swim);
    	    TextDrawHideForPlayer(i, T_TT[i]);
	        TextDrawHideForPlayer(i, Winner);
		}
	}
	return 1;
}
//===================================//
stock SetTriSpawn(playerid)
{
	new pos;
	pos = random(sizeof(MiniSpawns));
	SetPlayerPos(playerid, MiniSpawns[pos][0], MiniSpawns[pos][1], MiniSpawns[pos][2]);
	SetPlayerFacingAngle(playerid,MiniSpawns[pos][3]);
	SetPlayerVirtualWorld(playerid, 15);
	return 1;
}
//===================================//
stock getIntsluc(ll, ul)
{
	new range = ul-ll;
	new number = ll+(sluc()%range);
	return number;
}
//===================================//
Float:getsluc(Float:ll, Float:ul)
{
    new ulv = floatround(ul, floatround_ceil);
    new llv = floatround(ll, floatround_floor);
	new range = ulv-llv;
	new Float:number = ll+(sluc()%range);
	return number;
}
//===================================//
stock CreateAimObject(playerid)
{
	oCount++;
	pTobjects[playerid]++;
	new oid = oCount;
	new Float:x = getsluc(870.8545, 875.5131);
	new Float:y = getsluc(-2128.3379, -2134.1309);
	new Float:z = getsluc(9.6219, 17.1911);

	AimObject[oid][obX][playerid] = x;
	AimObject[oid][obY][playerid] = y;
	AimObject[oid][obZ][playerid] = z;
	A_Objects[oid][playerid] = CreatePlayerObject(playerid, 1600, AimObject[oid][obX][playerid], AimObject[oid][obY][playerid], AimObject[oid][obZ][playerid], 0.00000000,16.32929716,97.11634627);
	return 1;
}
//===================================//
stock MoveShootingObjectsForPlayer(playerid)
{
    for(new i=0; i<20; i++)
	{
		CreateAimObject(playerid);
	}
    for(new i=0; i<=20; i++)
	{
		new sluc_val = random(sizeof(sluc_float));
	    MovePlayerObject(playerid, A_Objects[i][playerid], 790.6284, AimObject[i][obY][playerid], AimObject[i][obZ][playerid], sluc_float[sluc_val]);
	}
	return 1;
}
//===================================//
stock MoveObjectsForPlayerAgain(playerid)
{
	new ObjNo = robjects[playerid];
	pTobjects[playerid] = 0;
    for(new i=0; i<ObjNo; i++)
	{
		CreateAimObject(playerid);
    }
    for(new i=0; i<=ObjNo; i++)
	{
  		new sluc_val = random(sizeof(sluc_float));
	    MovePlayerObject(playerid, A_Objects[i][playerid], 790.6284, AimObject[i][obY][playerid], AimObject[i][obZ][playerid], sluc_float[sluc_val]);
	}
	return 1;
}
//===================================//
stock sluc()
{
	new sluc_num = random(MAX_RAND);
	return sluc_num;
}
//===================================//
stock HideTriTDs(playerid){
    TextDrawHideForPlayer(playerid, Tbg);
	TextDrawHideForPlayer(playerid, TT[playerid]);
	TextDrawHideForPlayer(playerid, NO[playerid]);
 	TextDrawHideForPlayer(playerid, TT[playerid]);
    TextDrawHideForPlayer(playerid, NO[playerid]);
    TextDrawHideForPlayer(playerid, BG);
    TextDrawHideForPlayer(playerid, TR);
    TextDrawHideForPlayer(playerid, C_TT[playerid]);
    TextDrawHideForPlayer(playerid, C_CP[playerid]);
    TextDrawHideForPlayer(playerid, A_TT[playerid]);
    TextDrawHideForPlayer(playerid, A_OB[playerid]);
    TextDrawHideForPlayer(playerid, A_AC[playerid]);
    TextDrawHideForPlayer(playerid, S_CP[playerid]);
    TextDrawHideForPlayer(playerid, S_TT[playerid]);
    TextDrawHideForPlayer(playerid, Cycle);
    TextDrawHideForPlayer(playerid, Shoot);
    TextDrawHideForPlayer(playerid, Swim);
    TextDrawHideForPlayer(playerid, T_TT[playerid]);
    TextDrawHideForPlayer(playerid, Winner);
}
//===================================//
Float:DisCamTargetToLoc(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
	new Float:TGTDistance;

	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}
//===================================//
stock Float:GetPointAngleToPointTwo(Float:x2, Float:y2, Float:X, Float:Y)
{
	new Float:DX, Float:DY;
  	new Float:angle;

  	DX = floatabs(floatsub(x2,X));
  	DY = floatabs(floatsub(y2,Y));

  	if (DY == 0.0 || DX == 0.0)
	{
		if(DY == 0 && DX > 0) angle = 0.0;
    	else if(DY == 0 && DX < 0) angle = 180.0;
    	else if(DY > 0 && DX == 0) angle = 90.0;
    	else if(DY < 0 && DX == 0) angle = 270.0;
    	else if(DY == 0 && DX == 0) angle = 0.0;
  	}
  	else
  	{
		angle = atan(DX/DY);
    	if(X > x2 && Y <= y2) angle += 90.0;
    	else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    	else if(X < x2 && Y >= y2) angle -= 90.0;
    	else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  	}
  	return floatadd(angle, 90.0);
}
//===================================//
stock GetXYInFrontOfPointTwo(&Float:x, &Float:y, Float:angle, Float:distance)
{
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}
//===================================//
stock IsPlayerAimingTwo(playerid, Float:x, Float:y, Float:z, Float:radius)
{
	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
  	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
  	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid))
	{
	  	case 34,35,36:
 		{
	  		if (DisCamTargetToLoc(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
	  		return false;
	  	}
	  	case 30,31:
	  	{
		  	vertical = 4.0;
			horizontal = -1.6;
	  	}
	  	case 33:
	  	{
	  		vertical = 2.7;
			horizontal = -1.0;
	  	}
	  	default:
 		{
		 	vertical = 6.0;
			horizontal = -2.2;
 		}
	}
  	new Float:angle = GetPointAngleToPointTwo(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
  	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
  	GetXYInFrontOfPointTwo(resize_x, resize_y, GetPointAngleToPointTwo(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

  	if (DisCamTargetToLoc(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
}
//===================================//
stock PlayerName(playerid)
{
	new n[MAX_PLAYER_NAME];
	GetPlayerName(playerid, n, MAX_PLAYER_NAME);
	return n;
}

