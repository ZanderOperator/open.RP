#include <YSI_Coding\y_hooks>

// Ball States
#define LOPTAGORE 							1
#define LOPTADOLJE 							2
#define LOPTATOKOS 							3
#define ODSKOK1 							4
#define ODSKOK2 							5
#define ODSKOK3 							6
#define ODSKOK4 							7
#define ODSKOK5 							8
#define ODSKOK6 							9
#define ODSKOK7 							10
#define ODSKOK8 							11
#define UZRAKU 								12
#define DODAVANJE 							13
#define NONE 								999

// Enumerator & Various Defines
#define MAX_BASKET          				(3)
#define MAX_BASKET_TEAM_NAME				(32)
#define MAX_BASKET_PLAYERS					(8)

forward GetBall(kosid);
forward ObjectToPoint(Float:radi, Float:radiz, objectid, Float:x, Float:y, Float:z);

enum Baskets
{
	Float:KosX,
	Float:KosY,
	Float:KosZ,
	Player[MAX_BASKET_PLAYERS],
	lopta,
	hasball,
	Text3D:bBoard3DText,
	bBoardString[84],
	pTeam1[MAX_BASKET_TEAM_NAME],
	Text3D:pTeam1Text,
	pScore1,
	pTeam2[MAX_BASKET_TEAM_NAME],
	Text3D:pTeam2Text,
	pScore2,
	Players,
	bool:BallOut,
	LoptaState,
	Float:BallDistance,
	Float:BallSpeed,
	bShooter,
	Dodavac,
	Float:LoptaHigh,
	Float:DodavanjeDistance,
};
new BasketInfo[MAX_BASKET][Baskets];

static 
	BasketID[MAX_PLAYERS];

new Text3D:PlayerBasketTeam[MAX_PLAYERS] = Text3D:INVALID_3DTEXT_ID;

timer ApplyBallAnimation[650](playerid)
{
	ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1);
	return 1;
}

timer BasketBallDnkEnd[1450](playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk_Lnd",4.1,0,1,1,0,0,1);
	    SetCameraBehindPlayer(playerid);
	}
	return 1;
}

public GetBall(kosid)
{
    MoveObject(BasketInfo[kosid][lopta], BasketInfo[kosid][KosX], BasketInfo[kosid][KosY], BasketInfo[kosid][KosZ]-0.6, 12.5);
}

public ObjectToPoint(Float:radi, Float:radiz, objectid, Float:x, Float:y, Float:z)
{
	if(IsValidObject(objectid))
    {
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetObjectPos(objectid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radiz) && (tempposz > -radiz)))
		{
			return 1;
		}
	}
	return 0;
}

timer BasketBallPickup[650](playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:pX, Float:pY, Float:Z;
		GetPlayerPos(playerid, pX, pY, Z);
		GetXYInFrontOfPlayer(playerid, pX, pY, 0.6);
		BasketInfo[BasketID[playerid]][BallSpeed] = 4.0;
		BasketInfo[BasketID[playerid]][BallDistance] = 0.6;
		BasketInfo[BasketID[playerid]][hasball] = playerid;
		ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
		ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
		MoveObject(BasketInfo[BasketID[playerid]][lopta], pX, pY, Z-0.8, BasketInfo[BasketID[playerid]][BallSpeed]);
		Bit1_Set(PlayingBBall, playerid, true);
		BasketInfo[BasketID[playerid]][LoptaState] = LOPTAGORE;
	}
	return 1;
}

task BallOutTask[1000]()
{	
	// East Los Santos tereni
	if(IsValidObject(BasketInfo[0][lopta]) && BasketInfo[0][hasball] == NONE)
	{
		new Float:otX, Float:otY, Float:otZ;
		GetObjectPos(BasketInfo[0][lopta], otX, otY, otZ);
		if(otX < 2306.7295)
		{
			ClearBasketAnim(0);
			BasketInfo[0][hasball] = NONE;
			BasketInfo[0][LoptaState] = 0;
			BasketInfo[0][bShooter] = NONE;
			BasketInfo[0][Dodavac] = NONE;
			SetObjectPos(BasketInfo[0][lopta], 2306.7295, otY, 24.50041);
		}
		if(otX > 2326.7322)
		{
			ClearBasketAnim(0);
			BasketInfo[0][hasball] = NONE;
			BasketInfo[0][LoptaState] = 0;
			BasketInfo[0][bShooter] = NONE;
			BasketInfo[0][Dodavac] = NONE;
			SetObjectPos(BasketInfo[0][lopta], 2326.7322, otY, 24.50041);
		}
		if(otY < -1542.3517)
		{
			ClearBasketAnim(0);
			BasketInfo[0][hasball] = NONE;
			BasketInfo[0][LoptaState] = 0;
			BasketInfo[0][bShooter] = NONE;
			BasketInfo[0][Dodavac] = NONE;
			SetObjectPos(BasketInfo[0][lopta], otX, -1542.3517, 24.50041);
		}
		if(otY > -1513.5808)
		{
			ClearBasketAnim(0);
			BasketInfo[0][hasball] = NONE;
			BasketInfo[0][LoptaState] = 0;
			BasketInfo[0][bShooter] = NONE;
			BasketInfo[0][Dodavac] = NONE;
			SetObjectPos(BasketInfo[0][lopta], otX, -1513.5808, 24.50041);
		}
		if(otZ < 24.50041)
		{
			ClearBasketAnim(0);
			BasketInfo[0][hasball] = NONE;
			BasketInfo[0][LoptaState] = 0;
			BasketInfo[0][bShooter] = NONE;
			BasketInfo[0][Dodavac] = NONE;
			SetObjectPos(BasketInfo[0][lopta], otX, otY, 24.50041);
		}
	}
	// Sevilla tereni
	if(IsValidObject(BasketInfo[2][lopta]) && BasketInfo[2][hasball] == NONE)
	{
		new Float:otX2, Float:otY2, Float:otZ2;
		GetObjectPos(BasketInfo[2][lopta], otX2, otY2, otZ2);
		if(otX2 < 2767.2166)
		{
			ClearBasketAnim(2);
			BasketInfo[2][hasball] = NONE;
			BasketInfo[2][LoptaState] = 0;
			BasketInfo[2][bShooter] = NONE;
			BasketInfo[2][Dodavac] = NONE;
			SetObjectPos(BasketInfo[2][lopta], 2767.2166, otY2, 12.7144);
		}
		if(otX2 > 2796.4238)
		{
			ClearBasketAnim(2);
			BasketInfo[2][hasball] = NONE;
			BasketInfo[2][LoptaState] = 0;
			BasketInfo[2][bShooter] = NONE;
			BasketInfo[2][Dodavac] = NONE;
			SetObjectPos(BasketInfo[2][lopta], 2796.4238, otY2, 12.7144);
		}
		if(otY2 > -2009.1941)
		{
			ClearBasketAnim(2);
			BasketInfo[2][hasball] = NONE;
			BasketInfo[2][LoptaState] = 0;
			BasketInfo[2][bShooter] = NONE;
			BasketInfo[2][Dodavac] = NONE;
			SetObjectPos(BasketInfo[2][lopta], otX2, -2009.1941, 12.7144);
		}
		if(otY2 < -2029.6168)
		{
			ClearBasketAnim(2);
			BasketInfo[2][hasball] = NONE;
			BasketInfo[2][LoptaState] = 0;
			BasketInfo[2][bShooter] = NONE;
			BasketInfo[2][Dodavac] = NONE;
			SetObjectPos(BasketInfo[2][lopta], otX2, -2029.6168, 12.7144);
		}
		if(otZ2 < 12.5)
		{
			ClearBasketAnim(2);
			BasketInfo[2][hasball] = NONE;
			BasketInfo[2][LoptaState] = 0;
			BasketInfo[2][bShooter] = NONE;
			BasketInfo[2][Dodavac] = NONE;
			SetObjectPos(BasketInfo[2][lopta], otX2, otY2, 12.7144);
		}
	}
	return 1;
}

hook OnGameModeInit()
{
	CreateBaskets();
	return 1;
}

hook OnObjectMoved(objectid)
{
	new found = 0, basketid;
	new Float:X,Float:Y,Float:Z;
	new Float:pX,Float:pY;
    for(new i = 0; i < MAX_BASKET; i++)
	{
	    if(BasketInfo[i][lopta] == objectid)
	    {
	       found = 1;
	       basketid = i;
	       break;
		}
	}
	if(found == 1)
	{
        if(BasketInfo[basketid][hasball] != NONE)//Ako netko ima loptu
		{
            if(BasketInfo[basketid][LoptaState] == LOPTADOLJE)//Lopta se mice dole
			{
				GetPlayerPos(BasketInfo[basketid][hasball], X, Y, Z);
				GetXYInFrontOfPlayer(BasketInfo[basketid][hasball], pX, pY, BasketInfo[basketid][BallDistance]);
				MoveObject(BasketInfo[basketid][lopta], pX, pY, Z, BasketInfo[basketid][BallSpeed]);
				SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
				BasketInfo[basketid][LoptaState] = LOPTAGORE;
			}
			else if(BasketInfo[basketid][LoptaState] == LOPTAGORE)//Lopta se mice gore
			{
				GetPlayerPos(BasketInfo[basketid][hasball], X, Y, Z);
				GetXYInFrontOfPlayer(BasketInfo[basketid][hasball], pX, pY, BasketInfo[basketid][BallDistance]);
				MoveObject(BasketInfo[basketid][lopta], pX, pY, Z-0.8, BasketInfo[basketid][BallSpeed]);
				SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
				BasketInfo[basketid][LoptaState] = LOPTADOLJE;
			}
		}
		else
		{
			switch(BasketInfo[basketid][LoptaState])
			{
				case ODSKOK1:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z+1, 5);
					BasketInfo[basketid][LoptaState] = ODSKOK2;
				}
				case ODSKOK2:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z-1, 5);
					BasketInfo[basketid][LoptaState] = ODSKOK3;
				}
				case ODSKOK3:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z+0.8, 4);
					BasketInfo[basketid][LoptaState] = ODSKOK4;
				}
				case ODSKOK4:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z-0.8, 4);
					BasketInfo[basketid][LoptaState] = ODSKOK5;
				}
				case ODSKOK5:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z+0.5, 3);
					BasketInfo[basketid][LoptaState] = ODSKOK6;
				}
				case ODSKOK6:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z-0.5, 3);
					BasketInfo[basketid][LoptaState] = ODSKOK7;
				}
				case ODSKOK7:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z+0.3, 2);
					BasketInfo[basketid][LoptaState] = ODSKOK8;
				}
				case ODSKOK8:
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z-0.3, 2);
					SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
					BasketInfo[basketid][LoptaState] = 0;
				}
				case LOPTATOKOS: //Ako je lopta dosla do kosa
				{
					GetObjectPos(BasketInfo[basketid][lopta], X, Y, Z);
					MapAndreas_FindAverageZ(X, Y, Z);
					MoveObject(BasketInfo[basketid][lopta], X, Y, Z+0.2, 6);
					SetObjectRot(BasketInfo[basketid][lopta], 0, 0, random(50));
					BasketInfo[basketid][hasball] = NONE;
					BasketInfo[basketid][LoptaState] = ODSKOK1;
					foreach (new i : Player)
					{
						if(IsPlayerConnected(i))
						{
							if(BasketID[i] == basketid && Bit1_Get(PlayingBBall, i))
							{
								GameTextForPlayer(i, "KOS!!!", 2500, 4);
							}
						}
					}
				}
			}
			switch(BasketInfo[basketid][LoptaState])
			{
				case UZRAKU:
				{
					if(ObjectToPoint(1.5, 5, BasketInfo[basketid][lopta], 2316.9099,-1514.1183,25.3438))//EAST LS KOS 1
					{
						MoveObject(BasketInfo[basketid][lopta], 2316.9099,-1514.1183,25.3438, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = LOPTATOKOS;
						new Float:z;
						MapAndreas_FindAverageZ(2316.9099, -1514.1183, z);
						new Float:distance = GetPlayerDistanceFromPoint(BasketInfo[basketid][bShooter], 2316.9099,-1514.1183,z);
						GiveBasketTeamScore(BasketID[BasketInfo[basketid][bShooter]], 2, distance); 
						
					}
					else if(ObjectToPoint(1.5, 5, BasketInfo[basketid][lopta], 2316.9814, -1541.4727, 25.2309))//EAST LS KOS 2
					{
						MoveObject(BasketInfo[basketid][lopta], 2316.9814, -1541.4727, 25.2309, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = LOPTATOKOS;
						new Float:z;
						MapAndreas_FindAverageZ(2316.9099, -1514.1183, z);
						new Float:distance = GetPlayerDistanceFromPoint(BasketInfo[basketid][bShooter], 2316.9099,-1514.1183,z);
						GiveBasketTeamScore(BasketID[BasketInfo[basketid][bShooter]], 1, distance);
					}
					else if(ObjectToPoint(1.5, 5, BasketInfo[basketid][lopta], 2534.0366,-1667.5900,15.1655))//Grove Street KOS
					{
						MoveObject(BasketInfo[basketid][lopta], 2534.0366,-1667.5900,15.1655, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = LOPTATOKOS;
					}

					else if(ObjectToPoint(1.5, 5, BasketInfo[basketid][lopta], 2768.0012,-2019.6448,13.5547))//Seville KOS 1
					{
						MoveObject(BasketInfo[basketid][lopta], 2768.0012,-2019.6448,13.5547, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = LOPTATOKOS;
						new Float:z;
						MapAndreas_FindAverageZ(2768.0012, -2019.6448, z);
						new Float:distance = GetPlayerDistanceFromPoint(BasketInfo[basketid][bShooter], 2768.0012,-2019.6448,z);
						GiveBasketTeamScore(BasketID[BasketInfo[basketid][bShooter]], 2, distance); 
					}
					else if(ObjectToPoint(1.5, 5, BasketInfo[basketid][lopta], 2795.0542,-2019.5787,13.5547))//Seville KOS 2
					{
						MoveObject(BasketInfo[basketid][lopta], 2795.0542,-2019.5787,13.5547, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = LOPTATOKOS;
						new Float:z;
						MapAndreas_FindAverageZ(2768.0012, -2019.6448, z);
						new Float:distance = GetPlayerDistanceFromPoint(BasketInfo[basketid][bShooter], 2795.0542,-2019.5787,z);
						GiveBasketTeamScore(BasketID[BasketInfo[basketid][bShooter]], 1, distance); 
					}				
					else
					{
						new Float:X2, Float:Y2, Float:Z2;
						new distance = (5+random(4)) + (3+random(5));
						GetObjectPos(BasketInfo[basketid][lopta], X2, Y2, Z);
						GetXYInFrontOfPlayer(BasketInfo[basketid][bShooter], X2, Y2, distance);
						MapAndreas_FindAverageZ(X2, Y2, Z2);
						MoveObject(BasketInfo[basketid][lopta], X2, Y2, Z2+0.2, 12.5+random(4));
						BasketInfo[basketid][LoptaState] = ODSKOK1;
						foreach(new i: Player)
						{
							if(IsPlayerConnected(i))
							{
								if(BasketID[i] == basketid && Bit1_Get(PlayingBBall, i))
								{
									GameTextForPlayer(i, "PROMASAJ!!!", 2500, 4);
								}
							}
						}
					}
				}
				case DODAVANJE:
				{
					new Float:mapZ;
					MapAndreas_FindAverageZ(X, Y, mapZ);
					BasketInfo[basketid][LoptaState] = ODSKOK3;
					MoveObject(BasketInfo[basketid][lopta], X, Y, mapZ+0.2, 12.5+random(4));
				}
			}
		}
	}
	return 1;
}

stock ClearAnim(playerid)
{
	ClearAnimations(playerid);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1);
	return 1;
}

stock ClearBasketAnim(basketid)
{
	new animlib[32],
		animname[32];
	foreach(new i: Player)
	{
		if(Bit1_Get(PlayingBBall, i) && BasketID[i] == basketid)
		{
			GetAnimationName(GetPlayerAnimationIndex(i), animlib, 32, animname, 32);
			if(strcmp(animlib, "BSKTBALL", true) == 0)
				ClearAnim(i);
		}
	}
	return 1;
}

stock SetBasket(basketid)
{
	if(basketid != 1) // East Los Santos & Seville Basket Labeli (Scoreboard & Team Labels)
	{
		if(BasketInfo[basketid][bBoard3DText] != Text3D:INVALID_3DTEXT_ID)
			Delete3DTextLabel(BasketInfo[basketid][bBoard3DText]);
			
		new motd[60];
		format(motd, sizeof(motd), "Basketball Board");
		BasketInfo[basketid][bBoard3DText] = Create3DTextLabel(motd, -1, BasketInfo[basketid][KosX], BasketInfo[basketid][KosY], BasketInfo[basketid][KosZ]+5.0, 20.0, 0);
		BasketInfo[basketid][pTeam1][0] = EOS;
		BasketInfo[basketid][pScore1] = 0;
		
		BasketInfo[basketid][pTeam2][0] = EOS;
		BasketInfo[basketid][pScore2] = 0; 
		if(basketid == 0)
		{
			if(BasketInfo[0][pTeam1Text] != Text3D:INVALID_3DTEXT_ID)
				Delete3DTextLabel(BasketInfo[0][pTeam1Text]);
			BasketInfo[0][pTeam1Text] = Create3DTextLabel("Team 1", -1, 2316.9099, -1514.1183, 25.3438+1.75, 20.0, 0);
			if(BasketInfo[0][pTeam2Text] != Text3D:INVALID_3DTEXT_ID)
				Delete3DTextLabel(BasketInfo[0][pTeam2Text]);
			BasketInfo[0][pTeam2Text] = Create3DTextLabel("Team 2", -1, 2316.9814, -1541.4727, 25.2309+1.75, 20.0, 0);
		}
		else
		{
			if(BasketInfo[2][pTeam1Text] != Text3D:INVALID_3DTEXT_ID)
				Delete3DTextLabel(BasketInfo[2][pTeam1Text]);
			BasketInfo[2][pTeam1Text] = Create3DTextLabel("Team 1", -1, 2768.5520, -2019.6656, 13.5547+1.75, 20, 0);
			if(BasketInfo[2][pTeam2Text] != Text3D:INVALID_3DTEXT_ID)
				Delete3DTextLabel(BasketInfo[2][pTeam2Text]);
			BasketInfo[2][pTeam2Text] = Create3DTextLabel("Team 2", -1, 2795.0542, -2019.5787, 13.5547+1.75, 20, 0);
		}
	}
	BasketInfo[basketid][Players] = 0;
	if(IsValidObject(BasketInfo[basketid][lopta]))
		DestroyObject(BasketInfo[basketid][lopta]);
	BasketInfo[basketid][lopta] = CreateObject(2114, BasketInfo[basketid][KosX],BasketInfo[basketid][KosY],BasketInfo[basketid][KosZ],0,0,96);
	BasketInfo[basketid][BallOut] = false;
	BasketInfo[basketid][hasball] = NONE;
	BasketInfo[basketid][LoptaState] = 0;
	BasketInfo[basketid][bShooter] = NONE;
	BasketInfo[basketid][Dodavac] = NONE;
	for(new i=0; i < MAX_BASKET_PLAYERS; i++)
	{
		if(Bit1_Get(PlayingBBall, BasketInfo[basketid][Player][i]))
		{
			ClearAnim(BasketInfo[basketid][Player][i]);
			BasketID[BasketInfo[basketid][Player][i]] = NONE;
			Bit1_Set(PlayingBBall, BasketInfo[basketid][Player][i], false);
			if(PlayerBasketTeam[BasketInfo[basketid][Player][i]] != Text3D:INVALID_3DTEXT_ID)
				DestroyDynamic3DTextLabel(PlayerBasketTeam[BasketInfo[basketid][Player][i]]);
			PlayerBasketTeam[BasketInfo[basketid][Player][i]] = Text3D:INVALID_3DTEXT_ID;
			BasketInfo[basketid][Player][i] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

stock CreateBaskets()
{
	BasketInfo[0][KosX] = 2316.96802;
	BasketInfo[0][KosY] = -1527.50842;
	BasketInfo[0][KosZ] = 24.50041;
	BasketInfo[0][bBoard3DText] = Text3D:INVALID_3DTEXT_ID;
	BasketInfo[0][pTeam1Text] = Text3D:INVALID_3DTEXT_ID;
	BasketInfo[0][pTeam2Text] = Text3D:INVALID_3DTEXT_ID;
	
	BasketInfo[1][KosX] = 2533.1482;
	BasketInfo[1][KosY] = -1667.4529;
	BasketInfo[1][KosZ] = 15.1647;

	BasketInfo[2][KosX] = 2782.2070;
	BasketInfo[2][KosY] = -2019.5822;
	BasketInfo[2][KosZ] = 12.7144;
	BasketInfo[2][bBoard3DText] = Text3D:INVALID_3DTEXT_ID;
	BasketInfo[2][pTeam1Text] = Text3D:INVALID_3DTEXT_ID;
	BasketInfo[2][pTeam2Text] = Text3D:INVALID_3DTEXT_ID;
	
	for(new i = 0; i < MAX_BASKET; i++)
		SetBasket(i);

	new motd[60];
	format(motd, sizeof(motd),"Koristite /playbasket kako bi igrali kosarku");
	CreateDynamic3DTextLabel(motd,-1,BasketInfo[0][KosX],BasketInfo[0][KosY],BasketInfo[0][KosZ]+0.5,20);
	CreateDynamic3DTextLabel(motd,-1,BasketInfo[1][KosX],BasketInfo[1][KosY],BasketInfo[1][KosZ]+0.5,20);
	CreateDynamic3DTextLabel(motd,-1,BasketInfo[2][KosX],BasketInfo[2][KosY],BasketInfo[2][KosZ]+0.5,20);
}

stock ListBasketTeams(basketid)
{
	new teamstring[100];
	format(teamstring, sizeof(teamstring), "Team 1:%s\nTeam 2:%s",  BasketInfo[basketid][pTeam1], BasketInfo[basketid][pTeam2]);
	return teamstring;
}

stock GiveBasketTeamScore(basketid, team, Float:distance)
{
	if(team == 1)
	{
		if(distance >= 8.0) // Trica
			BasketInfo[basketid][pScore1] += 3;
		else BasketInfo[basketid][pScore1] += 2;
	}
	else
	{
		if(distance >= 8.0) // Trica
			BasketInfo[basketid][pScore2] += 3;
		else BasketInfo[basketid][pScore2] += 2;
	}
	
	new scoreboard[100];
	format(scoreboard, sizeof(scoreboard), "%s vs %s\n%d : %d", 
		BasketInfo[basketid][pTeam1], 
		BasketInfo[basketid][pTeam2], 
		BasketInfo[basketid][pScore1], 
		BasketInfo[basketid][pScore2]
	);
	Update3DTextLabelText(BasketInfo[basketid][bBoard3DText], -1, scoreboard);
	return 1;
}
	
stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset)
{

	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:pA,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;
		
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if(Y > pY) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if(Y < pY && X < pX) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if(Y < pY) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

}
stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{

	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;

}
stock IsPlayerFacingPoint(playerid, Float:dOffset, Float:pX, Float:pY, Float:pZ)
{
	#pragma unused pZ
	new
		Float:X,
		Float:Y,
		Float:Z,
		Float:pA,
		Float:ang;

	if(!IsPlayerConnected(playerid)) return 0;

	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if(Y > pY) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if(Y < pY && X < pX) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if(Y < pY) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;
}

hook function ResetPlayerVariables(playerid)
{
	if(Bit1_Get(PlayingBBall, playerid))
	{
		if(PlayerBasketTeam[playerid] != Text3D:INVALID_3DTEXT_ID)
			DestroyDynamic3DTextLabel(PlayerBasketTeam[playerid]);
		PlayerBasketTeam[playerid] = Text3D:INVALID_3DTEXT_ID;
	    for(new p=0; p < MAX_BASKET_PLAYERS; p++)
		{
			if(BasketInfo[BasketID[playerid]][Player][p] == playerid)
			{
				BasketInfo[BasketID[playerid]][Player][p] = INVALID_PLAYER_ID;
				BasketInfo[BasketID[playerid]][Players] --;
			}
		}
	    for(new i = 0; i < MAX_BASKET; i++)
		{
		    if(BasketInfo[i][hasball] == playerid)
		        BasketInfo[i][hasball] = NONE;
		}
		BasketID[playerid] = NONE;
		Bit1_Set(PlayingBBall, playerid, false);
	}
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_BASKET_CHOOSE:
		{
			if(!response) 
				return 1;
			
			new basket;
			for(new i=0; i < MAX_BASKET; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 10.0, BasketInfo[i][KosX],BasketInfo[i][KosY],BasketInfo[i][KosZ]))
				{
					if(BasketInfo[i][Players] >= MAX_BASKET_PLAYERS) 
						return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum igraca po igralistu je %d.", MAX_BASKET_PLAYERS);
					for(new j=0; j < MAX_BASKET_PLAYERS; j++)
					{
						if(BasketInfo[i][Player][j] == INVALID_PLAYER_ID)
						{
							basket = i;
							BasketInfo[i][Player][j] = playerid;
							break;
						}
					}
				}
			}
			BasketInfo[basket][Players] ++;
			Bit1_Set(PlayingBBall, playerid, true);
			BasketID[playerid] = basket;
			if(IsValidDynamic3DTextLabel(PlayerBasketTeam[playerid]))
				DestroyDynamic3DTextLabel(PlayerBasketTeam[playerid]);
			PlayerBasketTeam[playerid] = Text3D:INVALID_3DTEXT_ID;			
			switch(listitem)
			{
				case 0:
				{
					PlayerBasketTeam[playerid] = CreateDynamic3DTextLabel(BasketInfo[basket][pTeam1], 0x18B4C0FF, 0, 0, -20, 25, playerid);
					Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBasketTeam[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Igrate kosarku za %s.", BasketInfo[basket][pTeam1]);
				}
				case 1:
				{
					PlayerBasketTeam[playerid] = CreateDynamic3DTextLabel(BasketInfo[basket][pTeam2], 0xFF8040FF, 0, 0, -20, 25, playerid);
					Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBasketTeam[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
					va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Igrate kosarku za %s.", BasketInfo[basket][pTeam2]);
				}
			}
		}
		case DIALOG_BASKET_TEAM:
		{
			new len = strlen(inputtext);
			if(len <= 0 || len > 32)
				return SendErrorMessage(playerid, "Naziv vaseg Teama je predug(vise od 32 znaka) ili prekratak!");
			
			for(new i = 0; i < MAX_BASKET; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 10.0, BasketInfo[i][KosX],BasketInfo[i][KosY],BasketInfo[i][KosZ]))
				{					
					if(IsValidDynamic3DTextLabel(PlayerBasketTeam[playerid]))
						DestroyDynamic3DTextLabel(PlayerBasketTeam[playerid]);
					PlayerBasketTeam[playerid] = Text3D:INVALID_3DTEXT_ID;
					
					if(BasketInfo[i][pTeam1][0] == EOS)
					{
						strcpy(BasketInfo[i][pTeam1], inputtext);
						Update3DTextLabelText(BasketInfo[i][pTeam1Text], -1, BasketInfo[i][pTeam1]);
						PlayerBasketTeam[playerid] = CreateDynamic3DTextLabel(BasketInfo[i][pTeam1], 0x18B4C0FF, 0, 0, -20, 25, playerid);
						Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBasketTeam[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
					}
					else
					{
						strcpy(BasketInfo[i][pTeam2], inputtext);
						Update3DTextLabelText(BasketInfo[i][pTeam2Text], -1, BasketInfo[i][pTeam2]);
						PlayerBasketTeam[playerid] = CreateDynamic3DTextLabel(BasketInfo[i][pTeam2], 0xFF8040FF, 0, 0, -20, 25, playerid);
						Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBasketTeam[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
					}
					BasketInfo[i][Players] ++;
					Bit1_Set(PlayingBBall, playerid, true);
					BasketID[playerid] = i;
					va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste stvorili Team pod nazivom %s!", inputtext);
					return 1;
				}
			}
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{			
	if(Bit1_Get(PlayingBBall, playerid))
	{		
		if(Player_IsWounded(playerid) || AC_GetPlayerWeapon(playerid) != 0)
			return 1;
		new Float:X, Float:Y, Float:Z, Float:pX, Float:pY, Float:pX2, Float:pY2, Float:pZ2;
		if(BasketInfo[BasketID[playerid]][hasball] == playerid)
		{
		    if(HOLDING(KEY_SPRINT))
		    {
				BasketInfo[BasketID[playerid]][BallSpeed] = 11;
				BasketInfo[BasketID[playerid]][BallDistance] = 1.4;
				GetPlayerPos(playerid, X, Y, Z);
				GetXYInFrontOfPlayer(playerid, pX, pY, BasketInfo[BasketID[playerid]][BallDistance]);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.5,1,1,1,1,1,1);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.5,1,1,1,1,1,1);
				MoveObject(BasketInfo[BasketID[playerid]][lopta], pX, pY, Z-0.8, BasketInfo[BasketID[playerid]][BallSpeed]);
				BasketInfo[BasketID[playerid]][LoptaState] = LOPTAGORE;
			}
		    else if(HOLDING(KEY_WALK))
		    {
				BasketInfo[BasketID[playerid]][BallSpeed] = 4.2;
				BasketInfo[BasketID[playerid]][BallDistance] = 1;
				GetPlayerPos(playerid, X, Y, Z);
				GetXYInFrontOfPlayer(playerid, pX, pY, BasketInfo[BasketID[playerid]][BallDistance]);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1,1);
				MoveObject(BasketInfo[BasketID[playerid]][lopta], pX, pY, Z-0.8, BasketInfo[BasketID[playerid]][BallSpeed]);
				BasketInfo[BasketID[playerid]][LoptaState] = LOPTAGORE;
	    	}
			else if(!HOLDING(KEY_WALK) || !HOLDING(KEY_SPRINT))
			{
				BasketInfo[BasketID[playerid]][BallSpeed] = 4.0;
				BasketInfo[BasketID[playerid]][BallDistance] = 0.6;
				GetPlayerPos(playerid, X, Y, Z);
				GetXYInFrontOfPlayer(playerid, pX, pY, BasketInfo[BasketID[playerid]][BallDistance]);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
				MoveObject(BasketInfo[BasketID[playerid]][lopta], pX, pY, Z-0.8, BasketInfo[BasketID[playerid]][BallSpeed]);
				BasketInfo[BasketID[playerid]][LoptaState] = LOPTAGORE;
		 	}
			if(PRESSED(KEY_HANDBRAKE))
			{
				new basketid = BasketID[playerid];
				foreach(new i: Player)
				{
					if(Bit1_Get(PlayingBBall, i) && BasketID[i] == basketid)
					{
						GetPlayerPos(i, pX2, pY2, pZ2);
						if(IsPlayerFacingPlayer(playerid, i, 12.5) && IsPlayerFacingPlayer(i, playerid, 80.0) && IsPlayerInRangeOfPoint(playerid, 9.0, pX2, pY2, pZ2))
						{	
							BasketInfo[basketid][LoptaHigh] = 1.05;
							BasketInfo[basketid][DodavanjeDistance] = 6+random(3);
							BasketInfo[basketid][BallSpeed] = 11+random(3);
							GetPlayerPos(i, pX, pY, Z);
							GetXYInFrontOfPlayer(i, pX, pY, 0.6);
							BasketInfo[basketid][BallSpeed] = 15.0;
							BasketInfo[basketid][BallDistance] = 0.6;
							BasketInfo[basketid][hasball] = i;
							BasketInfo[basketid][LoptaState] = LOPTAGORE;
							MoveObject(BasketInfo[basketid][lopta], pX, pY, Z+BasketInfo[basketid][LoptaHigh], BasketInfo[basketid][BallSpeed]);
							
							ApplyAnimation(playerid,"GRENADE","WEAPON_start_throw",4.1,0,0,0,0,0,1);
							defer ApplyBallAnimation(i);
						}
					}
				}
			}
			if(PRESSED(KEY_SECONDARY_ATTACK))
			{
				new basketid = BasketID[playerid];
				foreach(new i: Player)
				{
					if(Bit1_Get(PlayingBBall, i) && BasketID[i] == basketid)
					{
						GetPlayerPos(i, pX2, pY2, pZ2);
						if(IsPlayerFacingPlayer(playerid, i, 12.5) && IsPlayerFacingPlayer(i, playerid, 80.0) && IsPlayerInRangeOfPoint(playerid, 18.0, pX2, pY2, pZ2))
						{
							
							BasketInfo[basketid][LoptaHigh] = 1.2;
							BasketInfo[basketid][DodavanjeDistance] = 10+random(3);
							BasketInfo[basketid][BallSpeed] =  14.5+random(3);
							
							GetPlayerPos(i, pX, pY, Z);
							GetXYInFrontOfPlayer(i, pX, pY, 0.6);
							BasketInfo[basketid][BallDistance] = 0.6;
							BasketInfo[basketid][hasball] = i;
							BasketInfo[basketid][LoptaState] = LOPTAGORE;
							MoveObject(BasketInfo[basketid][lopta], pX, pY, Z+BasketInfo[basketid][LoptaHigh], BasketInfo[basketid][BallSpeed]);
							
							ApplyAnimation(playerid,"GRENADE","WEAPON_start_throw",4.1,0,0,0,0,0,1);
							defer ApplyBallAnimation(i);
						}
					}
				}
            }
		 	if(PRESSED(KEY_FIRE))
			{
		 	    if(IsPlayerInRangeOfPoint(playerid, 3.2, 2316.9099,-1514.1183,25.3438) && IsPlayerFacingPoint(playerid, 20, 2316.9099,-1514.1183,25.3438))//EAST LS KOS
				{
				    if(HOLDING(KEY_SPRINT) || IsPlayerInRangeOfPoint(playerid, 2.0, 2316.9099,-1514.1183,25.3438))
				    {
						MoveObject(BasketInfo[BasketID[playerid]][lopta], 2316.9099,-1514.1183,27.3438, 10);//EAST LS KOS
						new camera = random(4);
						switch(camera)
						{
							case 0:
							{
								SetPlayerCameraPos(playerid, 2312.4131,-1514.9980,25.3438);
								SetPlayerCameraLookAt(playerid, 2316.9099,-1514.1183,25.3438);
							}
							case 1:
							{
								SetPlayerCameraPos(playerid, 2321.5977,-1514.6129,25.3438);
								SetPlayerCameraLookAt(playerid, 2316.9099,-1514.1183,25.3438);
							}
							case 2:
							{
								SetPlayerCameraPos(playerid, 2316.7964,-1518.9149,25.3438);
								SetPlayerCameraLookAt(playerid, 2316.9099,-1514.1183,25.3438);
							}
						}
						SetPlayerPos(playerid, 2316.8376,-1514.6727,25.3438);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,0,0,0,0,0,1);
						defer BasketBallDnkEnd(playerid);
						BasketInfo[BasketID[playerid]][hasball] = NONE;
						BasketInfo[BasketID[playerid]][LoptaState] = LOPTATOKOS;
						new Float:distance = GetPlayerDistanceFromPoint(playerid, 2316.9099,-1514.1183,25.3438);
						GiveBasketTeamScore(BasketID[playerid], 2, distance);
							
					}
					else
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
						new Float:X2, Float:Y2;
						new distance = 2+random(4);
						BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
						GetPlayerPos(playerid, X2, Y2, Z);
						GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
						MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
      					BasketInfo[BasketID[playerid]][hasball] = NONE;
						BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.2, 2316.9814, -1541.4727, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.9814, -1541.4727, 25.2309))//EAST LS KOS
				{
				    if(HOLDING(KEY_SPRINT) || IsPlayerInRangeOfPoint(playerid, 2.0, 2316.9814, -1541.4727, 25.2309))
				    {
						MoveObject(BasketInfo[BasketID[playerid]][lopta], 2316.9814, -1541.4727, 27.2309, 10);//EAST LS KOS
						new camera = random(4);
						switch(camera)
						{
							case 0:
							{
								SetPlayerCameraPos(playerid, 2312.4131, -1541.4727, 25.2309);
								SetPlayerCameraLookAt(playerid, 2316.9814, -1541.4727, 25.2309);
							}
							case 1:
							{
								SetPlayerCameraPos(playerid, 2321.5977, -1541.4727, 25.2309);
								SetPlayerCameraLookAt(playerid, 2316.9814, -1541.4727, 25.2309);
							}
							case 2:
							{
								SetPlayerCameraPos(playerid, 2316.7964, -1535.4727, 25.2309);
								SetPlayerCameraLookAt(playerid, 2316.9814, -1541.4727, 25.2309);
							}
						}
						SetPlayerPos(playerid, 2316.9814, -1541.4727, 25.2309);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,0,0,0,0,0,1);
						defer BasketBallDnkEnd(playerid);
						BasketInfo[BasketID[playerid]][hasball] = NONE;
						BasketInfo[BasketID[playerid]][LoptaState] = LOPTATOKOS;
						new Float:distance = GetPlayerDistanceFromPoint(playerid, 2316.9814, -1541.4727, 25.2309);
						GiveBasketTeamScore(BasketID[playerid], 1, distance);
					}
					else
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
						new Float:X2, Float:Y2;
						new distance = 2+random(4);
						BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
						GetPlayerPos(playerid, X2, Y2, Z);
						GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
						MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
      					BasketInfo[BasketID[playerid]][hasball] = NONE;
						BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.2, 2534.0366,-1667.5900,15.1655)  && IsPlayerFacingPoint(playerid, 20, 2534.0366,-1667.5900,15.1655))//Grove ST kos
				{
                    if(HOLDING(KEY_SPRINT) || IsPlayerInRangeOfPoint(playerid, 2.0, 2534.0366,-1667.5900,15.1655))
				    {
				        MoveObject(BasketInfo[BasketID[playerid]][lopta], 2534.0366,-1667.5900,17.1655, 10);//Grove ST KOS
						new camera = random(4);
						switch(camera)
						{
						    case 0:
							{
						    	SetPlayerCameraPos(playerid, 2529.8499,-1667.5822,18.1688);
						    	SetPlayerCameraLookAt(playerid, 2534.0366,-1667.5900,18.1655);
							}
							case 1:
							{
						    	SetPlayerCameraPos(playerid, 2533.1714,-1664.4470,18.1665);
						    	SetPlayerCameraLookAt(playerid, 2534.0366,-1667.5900,18.1655);
							}
							case 2:
							{
						    	SetPlayerCameraPos(playerid, 2533.0684,-1670.7021,18.1717);
						    	SetPlayerCameraLookAt(playerid, 2534.0366,-1667.5900,18.1655);
							}
						}
					    SetPlayerPos(playerid,2533.4053,-1667.5361,15.1650);
		                ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,0,0,0,0,0,1);
		                defer BasketBallDnkEnd(playerid);
		                BasketInfo[BasketID[playerid]][hasball] = NONE;
		                BasketInfo[BasketID[playerid]][LoptaState] = LOPTATOKOS;
				    }
				    else
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
						new Float:X2, Float:Y2;
						new distance = 2+random(4);
						BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
						GetPlayerPos(playerid, X2, Y2, Z);
						GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
						MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
      					BasketInfo[BasketID[playerid]][hasball] = NONE;
      					BasketInfo[BasketID[playerid]][bShooter] = playerid;
						BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.2, 2768.0012,-2019.6448,13.5547)  && IsPlayerFacingPoint(playerid, 20, 2768.0012,-2019.6448,13.5547)) //Seville kos 1
				{
				    if(HOLDING(KEY_SPRINT) || IsPlayerInRangeOfPoint(playerid, 3.2, 2768.0012,-2019.6448,13.5547))//Seville kos 1
				    {
					    MoveObject(BasketInfo[BasketID[playerid]][lopta], 2768.0012,-2019.6448,15.5547, 10);//Seville kos 1
						new camera = random(4);
						switch(camera)
						{
						    case 0:
							{
						    	SetPlayerCameraPos(playerid, 2768.7454,-2024.1191,16.5547);
						    	SetPlayerCameraLookAt(playerid, 2768.0012,-2019.6448,16.5547);
							}
							case 1:
							{
						    	SetPlayerCameraPos(playerid, 2772.9734,-2019.6182,16.5547);
						    	SetPlayerCameraLookAt(playerid, 2768.0012,-2019.6448,16.5547);
							}
							case 2:
							{
						    	SetPlayerCameraPos(playerid, 2768.6895,-2014.3008,16.5547);
						    	SetPlayerCameraLookAt(playerid, 2768.0012,-2019.6448,16.5547);
							}
						}
					    SetPlayerPos(playerid, 2768.6841,-2019.6881,13.5547	);
		                ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,0,0,0,0,0,1);
		                defer BasketBallDnkEnd(playerid);
		                BasketInfo[BasketID[playerid]][hasball] = NONE;
		                BasketInfo[BasketID[playerid]][LoptaState] = LOPTATOKOS;
						new Float:distance = GetPlayerDistanceFromPoint(playerid, 2768.0012,-2019.6448,13.5547);
						GiveBasketTeamScore(BasketID[playerid], 2, distance); 
					}
					else
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
						new Float:X2, Float:Y2;
						new distance = 2+random(4);
						BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
						GetPlayerPos(playerid, X2, Y2, Z);
						GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
						MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
      					BasketInfo[BasketID[playerid]][hasball] = NONE;
      					BasketInfo[BasketID[playerid]][bShooter] = playerid;
						BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.2, 2795.0542,-2019.5787,13.5547)  && IsPlayerFacingPoint(playerid, 20, 2795.0542,-2019.5787,13.5547))
				{
					if(HOLDING(KEY_SPRINT) || IsPlayerInRangeOfPoint(playerid, 3.2, 2795.0542,-2019.5787,13.5547)) // Seville kos 2
				    {
					    MoveObject(BasketInfo[BasketID[playerid]][lopta], 2795.0542,-2019.5787,15.5547, 10);//Seville kos 2
						new camera = random(4);
						switch(camera)
						{
						    case 0:
							{
						    	SetPlayerCameraPos(playerid, 2798.0542,-2019.5787,15.5547);
						    	SetPlayerCameraLookAt(playerid, 2795.0542,-2019.5787,15.5547);
							}
							case 1:
							{
						    	SetPlayerCameraPos(playerid, 2791.9734,-2019.6182,15.5547);
						    	SetPlayerCameraLookAt(playerid, 2795.0542,-2019.5787,15.5547);
							}
							case 2:
							{
						    	SetPlayerCameraPos(playerid, 2795.0542,-2015.5787,15.5547);
						    	SetPlayerCameraLookAt(playerid, 2795.0542,-2019.5787,15.5547);
							}
						}
					    SetPlayerPos(playerid, 2795.0542,-2019.5787,13.5547);
		                ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,0,0,0,0,0,1);
		                defer BasketBallDnkEnd(playerid);
		                BasketInfo[BasketID[playerid]][hasball] = NONE;
		                BasketInfo[BasketID[playerid]][LoptaState] = LOPTATOKOS;
						new Float:distance = GetPlayerDistanceFromPoint(playerid, 2795.0542,-2019.5787,13.5547);
						GiveBasketTeamScore(BasketID[playerid], 1, distance); 
					}
					else
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
						new Float:X2, Float:Y2;
						new distance = 2+random(4);
						BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
						GetPlayerPos(playerid, X2, Y2, Z);
						GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
						MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
      					BasketInfo[BasketID[playerid]][hasball] = NONE;
      					BasketInfo[BasketID[playerid]][bShooter] = playerid;
						BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
					}
				}
				else
				{
				    ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1);
					new Float:X2, Float:Y2;
					new distance = 5+random(4);
					BasketInfo[BasketID[playerid]][LoptaHigh] = 3+random(3);
					if(IsPlayerInRangeOfPoint(playerid, 5, 2316.9099,-1514.1183,25.3438) || IsPlayerInRangeOfPoint(playerid, 5, 2534.0366,-1667.5900,15.1655) || IsPlayerInRangeOfPoint(playerid, 5, 2768.0012,-2019.6448,13.5547)){distance = 1+random(4);}
					GetPlayerPos(playerid, X2, Y2, Z);
					GetXYInFrontOfPlayer(playerid, X2, Y2, distance);
					MoveObject(BasketInfo[BasketID[playerid]][lopta], X2, Y2, Z+BasketInfo[BasketID[playerid]][LoptaHigh], 12+random(3));
					BasketInfo[BasketID[playerid]][hasball] = NONE;
      				BasketInfo[BasketID[playerid]][bShooter] = playerid;
					BasketInfo[BasketID[playerid]][LoptaState] = UZRAKU;
				}
			}
		}
		else
		{
			GetObjectPos(BasketInfo[BasketID[playerid]][lopta], X, Y, Z);
			if(IsPlayerInRangeOfPoint(playerid, 1.2, X, Y, Z))
			{
				if(BasketInfo[BasketID[playerid]][hasball] == NONE)
			    {
			    	if(PRESSED(KEY_CROUCH))
					{
						ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0,1);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0,1);
						new Float:RotX, Float:RotY, Float:RotZ;
						GetObjectRot(BasketInfo[BasketID[playerid]][lopta], RotX, RotY, RotZ);
						SetPlayerFacingAngle(playerid, RotZ);
						defer BasketBallPickup(playerid);
					}
				}
				else
				{
				    if(PRESSED(KEY_LOOK_BEHIND))
				    {
					    new lucky = random(10);
						if(lucky == 2 || lucky == 5 || lucky == 6 || lucky == 8 || lucky == 9)
						{
							new Float:BallerX, Float:BallerY, Float:BallerZ;
							GetPlayerPos(BasketInfo[BasketID[playerid]][hasball], BallerX, BallerY, BallerZ);
							if(IsPlayerInRangeOfPoint(playerid, 3.0, BallerX, BallerY, BallerZ))
							{
								GetPlayerPos(playerid, X, Y, Z);
								GetXYInFrontOfPlayer(playerid, pX, pY, 0.6);
								ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
								ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1);
								BasketInfo[BasketID[playerid]][BallSpeed] = 4.0;
								MoveObject(BasketInfo[BasketID[playerid]][lopta], pX, pY, Z-0.8, BasketInfo[BasketID[playerid]][BallSpeed]);
								BasketInfo[BasketID[playerid]][LoptaState] = LOPTAGORE;
                                ApplyAnimation(BasketInfo[BasketID[playerid]][hasball],"GRENADE","WEAPON_start_throw",4.1,0,0,0,0,0,1);
								BasketInfo[BasketID[playerid]][hasball] = playerid;
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

CMD:playbasket(playerid, params[])
{
	if(Bit1_Get(PlayingBBall, playerid)) return SendErrorMessage(playerid, "Vec igrate kosarku, upisite /quitbasket!");
    for(new i = 0; i < MAX_BASKET; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, BasketInfo[i][KosX],BasketInfo[i][KosY],BasketInfo[i][KosZ]))
	    {
			if(i != 1) // Seville i East Los Santos Tereni - 2 kosa
			{
				if(BasketInfo[i][Players] >= MAX_BASKET_PLAYERS) 
					return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum igraca po igralistu je %d.", MAX_BASKET_PLAYERS);
				if(BasketInfo[i][pTeam1][0] == EOS || BasketInfo[i][pTeam2][0] == EOS)
					ShowPlayerDialog(playerid, DIALOG_BASKET_TEAM, DIALOG_STYLE_INPUT, "Naziv ekipe:", "Molimo Vas unesite naziv svoje ekipe\nMaksimalan unos naziva: 32 znaka.", "Input", "Exit"); 
				else
					ShowPlayerDialog(playerid, DIALOG_BASKET_CHOOSE, DIALOG_STYLE_LIST, "Odabir ekipe", ListBasketTeams(i), "Pick", "Exit");
				return 1;
			}
			else
			{
				if(BasketInfo[i][Players] >= 2) return SendClientMessage(playerid, COLOR_RED, "Ovdje vec igraju 2 igraca!");
				for(new j=0; j < MAX_BASKET_PLAYERS; j++)
				{
					if(BasketInfo[i][Player][j] == INVALID_PLAYER_ID)
					{
						BasketInfo[i][Player][j] = playerid;
						break;
					}
				}
				BasketInfo[i][Players] ++;
				Bit1_Set(PlayingBBall, playerid, true);
				BasketID[playerid] = i;
				SendClientMessage(playerid,-1,""COL_RED"[!] Mozete igrati "COL_ORANGE"kosarku "COL_LIGHTBLUE"1vs1!");
				return 1;
			}
		}
	}
	return 1;
}
CMD:quitbasket(playerid, params[])
{
	if(!Bit1_Get(PlayingBBall, playerid)) return SendClientMessage(playerid, COLOR_RED, "Vi ne igrate kosarku!");
	
	for(new p=0; p < MAX_BASKET_PLAYERS; p++)
	{
		if(BasketInfo[BasketID[playerid]][Player][p] == playerid)
			BasketInfo[BasketID[playerid]][Player][p] = INVALID_PLAYER_ID;
	}
	BasketInfo[BasketID[playerid]][Players] --;
	if(BasketInfo[BasketID[playerid]][Players] <= 1)
		SetBasket(BasketID[playerid]);
	
	if(BasketInfo[BasketID[playerid]][hasball] == playerid)
		BasketInfo[BasketID[playerid]][hasball] = NONE;
		
	ClearAnim(playerid);
	Bit1_Set(PlayingBBall, playerid, false);
	BasketID[playerid] = NONE;
	if(PlayerBasketTeam[playerid] != Text3D:INVALID_3DTEXT_ID)
		DestroyDynamic3DTextLabel(PlayerBasketTeam[playerid]);
	PlayerBasketTeam[playerid] = Text3D:INVALID_3DTEXT_ID;
	SendClientMessage(playerid,-1,""COL_LIGHTBLUE"Prestali ste igrati kosarku "COL_ORANGE"kosarku!");
	return 1;
}

CMD:endmatch(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	for(new i = 0; i < MAX_BASKET; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 40.0, BasketInfo[i][KosX],BasketInfo[i][KosY],BasketInfo[i][KosZ]))
	    {
			SetBasket(i);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zavrsili kosarkasku utakmicu!");
		}
	}
	return 1;
}
	
CMD:getball(playerid, params[])
{
	new Float:X, Float:Y, Float:Z;
	if(PlayerInfo[playerid][pAdmin] < 1338) return 1;
	if(!Bit1_Get(PlayingBBall, playerid)) return SendClientMessage(playerid, COLOR_RED, "Vi ne igrate kosarku!");
	GetPlayerPos(playerid, X, Y, Z);
	MoveObject(BasketInfo[BasketID[playerid]][lopta], X, Y, Z-0.8, 8);
	return 1;
}