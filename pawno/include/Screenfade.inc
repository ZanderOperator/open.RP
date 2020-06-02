///////////////////////////////////////
///////////Made by Joe Staff///////////
///////////////////////////////////////

#include <a_samp>
#define _UPDATERATE 100 //milliseconds
#define _TELEPORTFADECOLORR 0
#define _TELEPORTFADECOLORG 0
#define _TELEPORTFADECOLORB 0
#define _TELEPORTFADECOLORA 255
forward _UpdateFadeTimer();
forward OnFadeComplete(playerid,beforehold);
new _pEndColor[MAX_PLAYERS][4];
new _pCurrentColor[MAX_PLAYERS][4];
new _pRateColor[MAX_PLAYERS][4];
new _pStep[MAX_PLAYERS];
new _pHold[MAX_PLAYERS];
new _OPArray[MAX_PLAYERS];
new _OnlinePlayers;
new _PlayerTeleporting[MAX_PLAYERS];
new _PlayerInterior[MAX_PLAYERS];
new Float:_pTPToPos[MAX_PLAYERS][3];
new _pTPSteps[MAX_PLAYERS];
new Text:_text; //Look, only one!

/*
native ConvertToColor(RR,GG,BB,AA);
native StopPlayerFade(playerid);
native FadeColorForPlayer(playerid,RR1,GG1,BB1,AA1,RR2,GG2,BB2,AA2,steps,hold);
native FadeInit();
native FadeExit();
native FadePlayerConnect(playerid);
native FadePlayerDisonnect(playerid);
native SetPlayerPosFade(playerid,steps,Float:x,Float:y,Float:z);
*/


stock SetPlayerPosFade(playerid,steps,interior,Float:x,Float:y,Float:z)
{
	_PlayerTeleporting[playerid]=1;
	_pTPToPos[playerid][0]=x;
	_pTPToPos[playerid][1]=y;
	_pTPToPos[playerid][2]=z;
	_pTPSteps[playerid]=steps;
	_PlayerInterior[playerid]=interior;
	FadeColorForPlayer(playerid,0,0,0,0,_TELEPORTFADECOLORR,_TELEPORTFADECOLORG,_TELEPORTFADECOLORB,_TELEPORTFADECOLORA,steps,1);
}
stock ConvertToColor(RR,GG,BB,AA)return (RR*16777216)+(GG*65536)+(BB*256)+AA;
stock _UpdateOPA(playerid=INVALID_PLAYER_ID) //my version of foreach (I made it before Y_Less did! publicly anyway)
{
	_OnlinePlayers=0;
	for(new ply;ply<MAX_PLAYERS;ply++)
	{
		if(IsPlayerConnected(ply)&&(ply!=playerid))
		{
			_OPArray[_OnlinePlayers]=ply;
			_OnlinePlayers++;
		}
	}
}
stock FadeColorForPlayer(playerid,RR1,GG1,BB1,AA1,RR2,GG2,BB2,AA2,steps,hold)
{
	_pStep[playerid]=steps;//countdown, sorta
	new tmpsteps; //This will have to be added to incase the math is messed up (programming annoyance)
	_pHold[playerid]=hold;//How long the last color is held before disappearing (Divide this by UPDATERATE to get the time Ex:hold=10, in milliseconds that's 1000)
	_pEndColor[playerid][0]=RR2;
	_pEndColor[playerid][1]=GG2;
	_pEndColor[playerid][2]=BB2;
	_pEndColor[playerid][3]=AA2;
	_pCurrentColor[playerid][0]=RR1;
	_pCurrentColor[playerid][1]=GG1;
	_pCurrentColor[playerid][2]=BB1;
	_pCurrentColor[playerid][3]=AA1;
	_pRateColor[playerid][0]=(RR1-RR2)/steps;
	_pRateColor[playerid][1]=(GG1-GG2)/steps;
	_pRateColor[playerid][2]=(BB1-BB2)/steps;
	_pRateColor[playerid][3]=(AA1-AA2)/steps;
	//No dividing by 0!
	if(_pRateColor[playerid][0]!=0)if(((RR1-RR2)/_pRateColor[playerid][0])>steps)tmpsteps=((RR1-RR2)/_pRateColor[playerid][0])-steps;
	if(_pRateColor[playerid][1]!=0)if(((GG1-GG2)/_pRateColor[playerid][1])>steps+tmpsteps)tmpsteps=((GG1-GG2)/_pRateColor[playerid][1])-steps;
	if(_pRateColor[playerid][2]!=0)if(((BB1-BB2)/_pRateColor[playerid][2])>steps+tmpsteps)tmpsteps=((BB1-BB2)/_pRateColor[playerid][2])-steps;
	if(_pRateColor[playerid][3]!=0)if(((AA1-AA2)/_pRateColor[playerid][3])>steps+tmpsteps)tmpsteps=((AA1-AA2)/_pRateColor[playerid][3])-steps;
	if(tmpsteps)_pStep[playerid]+=tmpsteps+1;
}
FadeInit()
{
	_text=TextDrawCreate(0.0,0.0,"~r~");
	TextDrawTextSize(_text,640,480);
	TextDrawLetterSize(_text,0.0,50.0);
	TextDrawUseBox(_text,1);
	SetTimer("_UpdateFadeTimer",_UPDATERATE,1);
	_UpdateOPA();
	return 1;
}
FadeExit()
{
	TextDrawDestroy(_text);
	return 1;
}
FadePlayerConnect(playerid)
{
	_UpdateOPA();
	_pHold[playerid]=-1;
	_pStep[playerid]=-1;
	_PlayerTeleporting[playerid]=0;
	return 1;
}
FadePlayerDisconnect(playerid)
{
	_UpdateOPA(playerid);
	return 1;
}
stock StopPlayerFade(playerid)
{
	_pStep[playerid]=0;
	_pHold[playerid]=0;
}
public _UpdateFadeTimer()
{
	new playerid;
	for(new opa;opa<_OnlinePlayers;opa++)
	{
		playerid=_OPArray[opa];
		if(_pStep[playerid])
		{
			_pStep[playerid]--;
			for(new color;color<4;color++)
			{
				_pCurrentColor[playerid][color]-=_pRateColor[playerid][color];
				if(_pRateColor[playerid][color]>0)
				{
					if(_pCurrentColor[playerid][color]<_pEndColor[playerid][color])_pCurrentColor[playerid][color]=_pEndColor[playerid][color];
				}
				if(_pRateColor[playerid][color]<0)
				{
					if(_pCurrentColor[playerid][color]>_pEndColor[playerid][color])_pCurrentColor[playerid][color]=_pEndColor[playerid][color];
				}
				if(_pCurrentColor[playerid][color]<0)_pCurrentColor[playerid][color]=0;
				if(_pCurrentColor[playerid][color]>255)_pCurrentColor[playerid][color]=255;
			}
			TextDrawBoxColor(_text,ConvertToColor(_pCurrentColor[playerid][0],_pCurrentColor[playerid][1],_pCurrentColor[playerid][2],_pCurrentColor[playerid][3]));
			TextDrawShowForPlayer(playerid,_text);
		}
		else if(_pStep[playerid]==0)
		{
			_pStep[playerid]=-1;
			if(_PlayerTeleporting[playerid]==1)
			{
				SetPlayerPos(playerid,_pTPToPos[playerid][0],_pTPToPos[playerid][1],_pTPToPos[playerid][2]);
				SetPlayerInterior(playerid,_PlayerInterior[playerid]);
				FadeColorForPlayer(playerid,_TELEPORTFADECOLORR,_TELEPORTFADECOLORG,_TELEPORTFADECOLORB,_TELEPORTFADECOLORA,0,0,0,0,_pTPSteps[playerid],1);
				_PlayerTeleporting[playerid]=2;
			}else if(_PlayerTeleporting[playerid]==2)
			{
				_PlayerTeleporting[playerid]=0;
			}
			else			
			{
				CallLocalFunction("OnFadeComplete","ii",playerid,1);
			}
		}
		else if(_pHold[playerid])
		{
			_pHold[playerid]--;
		}
		else if(_pHold[playerid]==0)
		{
			_pHold[playerid]=-1;
			TextDrawHideForPlayer(playerid,_text);
			CallLocalFunction("OnFadeComplete","ii",playerid,0);
		}
	}
}