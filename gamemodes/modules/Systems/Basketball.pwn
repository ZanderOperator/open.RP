#include <a_samp>

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

enum E_BB_DATA
{
	HaveBall[MAX_PLAYERS],
	Animation[MAX_PLAYERS],
	Ball,
	BallStatus,
	BallHolder,
	BallShooting,
	BallBouncing,
	TimerOut
}
new BasketballInfo[ E_BB_DATA ];

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/


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

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

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

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{

	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;

}

forward BallDown(playerid, Float:oldz);
public BallDown(playerid, Float:oldz)
{
    new Float:bbX, Float:bbY, Float:bbZ;
	GetObjectPos(BasketballInfo[Ball], bbX, bbY, bbZ);
	new Float:a;
	new Float:x2, Float:y2;
	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);
	x2 += (16 * floatsin(-a, degrees));
	y2 += (16 * floatcos(-a, degrees));
	MoveObject(BasketballInfo[Ball], x2, y2, oldz-0.8, 10.0+random(3));
	BasketballInfo[BallHolder] = -1;
	BasketballInfo[BallShooting] = 0;
	BasketballInfo[BallBouncing] = 1;
	return 1;
}

forward BallDown2(playerid);
public BallDown2(playerid)
{
	BasketballInfo[BallBouncing] = 0;
	MoveObject(BasketballInfo[Ball], 2316.9814, -1541.4727, 24.50041, 10.0+random(3));
	BasketballInfo[BallHolder] = -1;
	BasketballInfo[BallShooting] = 0;
	GameTextForPlayer(playerid, "HIT", 3000, 3);
	return 1;
}

forward BallDown3(playerid);
public BallDown3(playerid)
{
	BasketballInfo[BallBouncing] = 0;
	MoveObject(BasketballInfo[Ball], 2316.8914, -1514.5521, 24.50041, 10.0+random(3));
	BasketballInfo[BallHolder] = -1;
	BasketballInfo[BallShooting] = 0;
	GameTextForPlayer(playerid, "HIT", 3000, 3);
	return 1;
}

forward BallDown4(playerid);
public BallDown4(playerid)
{
	BasketballInfo[BallBouncing] = 0;
	MoveObject(BasketballInfo[Ball], 2316.9814+random(5), -1541.4727+random(5), 24.50041, 10.0+random(3));
	BasketballInfo[BallHolder] = -1;
	BasketballInfo[BallShooting] = 0;
	GameTextForPlayer(playerid, "MISS!", 3000, 3);
	return 1;
}

forward BallDown5(playerid);
public BallDown5(playerid)
{
	BasketballInfo[BallBouncing] = 0;
	MoveObject(BasketballInfo[Ball], 2316.8914+random(5), -1514.5521+random(5), 24.50041, 10.0+random(3));
	BasketballInfo[BallHolder] = -1;
	BasketballInfo[BallShooting] = 0;
	GameTextForPlayer(playerid, "MISS", 3000, 3);
	return 1;
}

forward ShootMiss(playerid);
public ShootMiss(playerid)
{
	MoveObject(BasketballInfo[Ball], 2316.9814+random(2), -1541.4727+random(2), 24.50041+random(2), 12.5+random(4));
	ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
	BasketballInfo[BallShooting] = 4;
	BasketballInfo[HaveBall][playerid] = 0;
	return 1;
}

forward ShootMiss2(playerid);
public ShootMiss2(playerid)
{
	MoveObject(BasketballInfo[Ball], 2316.8914+random(2), -1514.5521+random(2), 24.50041+random(2), 12.5+random(4));
	ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
	BasketballInfo[BallShooting] = 5;
	BasketballInfo[HaveBall][playerid] = 0;
	return 1;
}

forward ClearAnim(playerid);
public ClearAnim(playerid)
{
	ClearAnimations(playerid);
	return 1;
}

forward ResetBall();
public ResetBall()
{
	BasketballInfo[BallHolder] = -1;
	DestroyObject(BasketballInfo[Ball]);
	BasketballInfo[Ball] = CreateObject(2114, 2316.96802, -1527.50842, 24.50041,   0.00000, 0.00000, 0.00000);
	KillTimer(BasketballInfo[TimerOut]);
	BasketballInfo[TimerOut] = SetTimer("OutTimer", 1200, true);
	return 1;
}

forward OutTimer();
public OutTimer()
{
	new Float:bbX, Float:bbY, Float:bbZ;
	GetObjectPos(BasketballInfo[Ball], bbX, bbY, bbZ);
    new playID2 = BasketballInfo[BallHolder];
    if(bbX < 2306.7295)
	{
	    BasketballInfo[BallHolder] = -1;
	    BasketballInfo[BallShooting] = 0;
	    BasketballInfo[BallBouncing] = 0;
	    if(playID2 != INVALID_PLAYER_ID && IsPlayerConnected(playID2)) BasketballInfo[HaveBall][playID2] = 0;
		SetObjectPos(BasketballInfo[Ball], 2306.7295, bbY, 24.50041);
	}
	if(bbX > 2326.7322)
	{
	    BasketballInfo[BallHolder] = -1;
	    BasketballInfo[BallShooting] = 0;
	    BasketballInfo[BallBouncing] = 0;
	    if(playID2 != INVALID_PLAYER_ID && IsPlayerConnected(playID2)) BasketballInfo[HaveBall][playID2] = 0;
		SetObjectPos(BasketballInfo[Ball], 2326.7322, bbY, 24.50041);
	}
	if(bbY < -1542.3517)
	{
	    BasketballInfo[BallHolder] = -1;
	    BasketballInfo[BallShooting] = 0;
	    BasketballInfo[BallBouncing] = 0;
	    if(playID2 != INVALID_PLAYER_ID && IsPlayerConnected(playID2)) BasketballInfo[HaveBall][playID2] = 0;
		SetObjectPos(BasketballInfo[Ball], bbX, -1542.3517, 24.50041);
	}
	if(bbY > -1513.5808)
	{
	    BasketballInfo[BallHolder] = -1;
	    BasketballInfo[BallShooting] = 0;
	    BasketballInfo[BallBouncing] = 0;
	    if(playID2 != INVALID_PLAYER_ID && IsPlayerConnected(playID2)) BasketballInfo[HaveBall][playID2] = 0;
		SetObjectPos(BasketballInfo[Ball], bbX, -1513.5808, 24.50041);
	}
	if(bbZ < 24.50041)
	{
	    BasketballInfo[BallShooting] = 0;
	    BasketballInfo[BallBouncing] = 0;
		MoveObject(BasketballInfo[Ball], bbX, bbY, 24.50041, 4);
		BasketballInfo[BallStatus] = 0;
	}
	return 1;
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


hook OnObjectMoved(objectid)
{
	new Float:bbX, Float:bbY, Float:bbZ;
	GetObjectPos(BasketballInfo[Ball], bbX, bbY, bbZ);
    new playID = BasketballInfo[BallHolder];
	if(playID != INVALID_PLAYER_ID && IsPlayerConnected(playID))
	{
		if(BasketballInfo[BallShooting] == 2)
		{
			BallDown2(playID);
			return 1;
		}
		else if(BasketballInfo[BallShooting] == 3)
		{
			BallDown3(playID);
			return 1;
		}
		else if(BasketballInfo[BallShooting] == 4)
		{
			BallDown4(playID);
			return 1;
		}
		else if(BasketballInfo[BallShooting] == 5)
		{
			BallDown5(playID);
			return 1;
		}
		else if(BasketballInfo[BallShooting] == 6)
		{
			ApplyAnimationEx(playID,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1,1,0);
			BasketballInfo[HaveBall][playID] = 1;
			BasketballInfo[Animation][playID] = 0;
		}
		if(BasketballInfo[BallBouncing] == 1)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+1.2, 4);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 2)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-1.2, 4);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 3)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.8, 3);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 4)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.8, 3);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 5)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.5, 2);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 6)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.5, 2);
			BasketballInfo[BallBouncing] = 7;
		}
		else if(BasketballInfo[BallBouncing] == 7)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.2, 1);
			BasketballInfo[BallBouncing] = 8;
		}
		else if(BasketballInfo[BallBouncing] == 8)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.2, 1);
			BasketballInfo[BallBouncing] = 0;
		}
		if(BasketballInfo[HaveBall][playID] < 1) return 1;
		new Keys, ud, lr;
		GetPlayerKeys(playID, Keys, ud, lr);
		if(BasketballInfo[Animation][playID])
		{
			switch(BasketballInfo[BallStatus])
			{
				case 0:
				{
					BasketballInfo[BallStatus] = 1;
					StopObject(BasketballInfo[Ball]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(playID, x2, y2, 0.4);
					MoveObject(BasketballInfo[Ball], x2, y2, bbZ+0.8, 5.5);
				}
				case 1:
				{
					BasketballInfo[BallStatus] = 0;
					StopObject(BasketballInfo[Ball]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(playID, x2, y2, 0.4);
					MoveObject(BasketballInfo[Ball], x2, y2, bbZ-0.8, 5.5);
				}
			}
			return 1;
		}
		if(Keys & KEY_SPRINT)
		{
			ApplyAnimationEx(playID,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1,1,0);
			switch(BasketballInfo[BallStatus])
			{
				case 0:
				{
					BasketballInfo[BallStatus] = 1;
					StopObject(BasketballInfo[Ball]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(playID, x2, y2, 1.5);
					MoveObject(BasketballInfo[Ball], x2, y2, bbZ+0.8, 8);
				}
				case 1:
				{
					BasketballInfo[BallStatus] = 0;
					StopObject(BasketballInfo[Ball]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(playID, x2, y2, 1.5);
					MoveObject(BasketballInfo[Ball], x2, y2, bbZ-0.8, 8);
				}
			}
			return 1;
		}
		else
		{
			ApplyAnimationEx(playID,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1,1,0);
		}
		switch(BasketballInfo[BallStatus])
		{
			case 0:
			{
				BasketballInfo[BallStatus] = 1;
				StopObject(BasketballInfo[Ball]);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(playID, x2, y2, 1.2);
				MoveObject(BasketballInfo[Ball], x2, y2, bbZ+0.8, 5);
			}
			case 1:
			{
				BasketballInfo[BallStatus] = 0;
				StopObject(BasketballInfo[Ball]);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(playID, x2, y2, 1.2);
				MoveObject(BasketballInfo[Ball], x2, y2, bbZ-0.8, 5);
			}
		}
	}
	else 
	{		
		if(BasketballInfo[BallBouncing] == 1)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+1.2, 4);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 2)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-1.2, 4);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 3)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.8, 3);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 4)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.8, 3);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 5)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.5, 2);
			BasketballInfo[BallBouncing] = 2;
		}
		else if(BasketballInfo[BallBouncing] == 6)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.5, 2);
			BasketballInfo[BallBouncing] = 7;
		}
		else if(BasketballInfo[BallBouncing] == 7)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ+0.2, 1);
			BasketballInfo[BallBouncing] = 8;
		}
		else if(BasketballInfo[BallBouncing] == 8)
		{
			MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ-0.2, 1);
			BasketballInfo[BallBouncing] = 0;
		}
	}
    return 1;
}

hook OnPlayerConnect(playerid)
{
    BasketballInfo[HaveBall][playerid] = 0;
    BasketballInfo[Animation][playerid] = 0;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    BasketballInfo[HaveBall][playerid] = 0;
    BasketballInfo[Animation][playerid] = 0;
    if(BasketballInfo[HaveBall][playerid]) BasketballInfo[BallHolder] = -1;
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    BasketballInfo[HaveBall][playerid] = 0;
    if(BasketballInfo[HaveBall][playerid]) BasketballInfo[BallHolder] = -1;
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new Float:playX, Float:playY, Float:playZ;
	GetPlayerPos(playerid, playX, playY, playZ);
    if ((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH) && !IsPlayerInAnyVehicle(playerid))
	{
    	if(playX >= 2306.5295 && playX <= 2326.5322 && playY >= -1542.5517 && playY <= -1513.6008 && playZ > 23.2743)
    	{
			if(BasketballInfo[HaveBall][playerid])
			{
	            ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1,1,0);
			}
			else
			{
	            ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0,1,0);
			}
			BasketballInfo[Animation][playerid] = 1;
		}
	}
	if (!(newkeys & KEY_CROUCH) && (oldkeys & KEY_CROUCH) && !IsPlayerInAnyVehicle(playerid))
	{
    	if(playX >= 2306.5295 && playX <= 2326.5322 && playY >= -1542.5517 && playY <= -1513.6008 && playZ > 23.2743)
    	{
			ClearAnimations(playerid);
			BasketballInfo[Animation][playerid] = 0;
		}
	}
	if(newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
	{
        if(!BasketballInfo[HaveBall][playerid])
		{
			new Float:bbX, Float:bbY, Float:bbZ;
			GetObjectPos(BasketballInfo[Ball], bbX, bbY, bbZ);
			if(IsPlayerInRangeOfPoint(playerid, 2.0, bbX, bbY, bbZ))
			{
				BasketballInfo[HaveBall][playerid] = 1;
				ApplyAnimationEx(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0,1,0);
				if(BasketballInfo[BallHolder] > 0)
				{
					BasketballInfo[HaveBall][BasketballInfo[BallHolder]] = 0;
					ClearAnimations(BasketballInfo[BallHolder]);
					ApplyAnimationEx(BasketballInfo[BallHolder], "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1, 0);
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1,1,0);
				}
				BasketballInfo[BallHolder] = playerid;
				BasketballInfo[BallStatus] = 1;
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(playerid, x2, y2, 0.8);
				GetPlayerPos(playerid, bbX, bbY, bbZ);
				StopObject(BasketballInfo[Ball]);
				MoveObject(BasketballInfo[Ball], x2, y2, bbZ, 2.5);
				BasketballInfo[Animation][playerid] = 0;
				BasketballInfo[BallBouncing] = 0;
			}
		}
		else
		{
            if(IsPlayerInRangeOfPoint(playerid, 2, 2316.9814, -1541.4727, 25.2309))
			{
				MoveObject(BasketballInfo[Ball], 2317.0176, -1541.1520, 27.5176, 7.5);
				SetPlayerPos(playerid, 2316.9814, -1541.4727, 25.2309);
				ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0,1,0);
				BasketballInfo[HaveBall][playerid] = 0;
				SetTimerEx("ClearAnim", 1100, 0, "d", playerid);
				SetTimerEx("BallDown2", 1100, 0, "d", playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 4, 2316.9814, -1541.4727, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.9814, -1541.4727, 25.2309))
			{
				new rand = random(1);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2317.0176, -1541.1520, 27.5176, 10.5+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 2;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 7, 2316.9814, -1541.4727, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.9814, -1541.4727, 25.2309))
			{
				new rand = random(2);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2317.0176, -1541.1520, 27.5176, 11.0+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 2;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10, 2316.9814, -1541.4727, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.9814, -1541.4727, 25.2309))
			{
				new rand = random(3);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2317.0176, -1541.1520, 27.5176, 11.5+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 2;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2, 2316.8914, -1514.5521, 25.2309))
			{
				MoveObject(BasketballInfo[Ball], 2316.8914, -1514.5521, 27.4292, 7.5);
				SetPlayerPos(playerid, 2316.8914, -1514.5521, 25.2309);
				ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0,1,0);
				BasketballInfo[HaveBall][playerid] = 0;
				SetTimerEx("ClearAnim", 800, 0, "d", playerid);
				SetTimerEx("BallDown3", 1100, 0, "d", playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 4, 2316.8914, -1514.5521, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.8914, -1514.5521, 25.2309))
			{
				new rand = random(1);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2316.8914, -1514.5521, 27.4292, 10.5+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 3;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
				ShootMiss2(playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 7, 2316.8914, -1514.5521, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.8914, -1514.5521, 25.2309))
			{
				new rand = random(2);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2316.8914, -1514.5521, 27.4292, 11.0+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 3;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
				ShootMiss2(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10, 2316.8914, -1514.5521, 25.2309) && IsPlayerFacingPoint(playerid, 20, 2316.8914, -1514.5521, 25.2309))
			{
				new rand = random(3);
				if(rand == 0)
				{
					MoveObject(BasketballInfo[Ball], 2316.8914, -1514.5521, 27.4292, 11.5+random(4));
					ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
					BasketballInfo[BallShooting] = 3;
					BasketballInfo[HaveBall][playerid] = 0;
					return 1;
				}
                ShootMiss2(playerid);
				return 1;
			}
			foreach(new i : Player)
			{
				if(IsPlayerFacingPlayer(playerid, i, 15))
				{
					new Float:bbX, Float:bbY, Float:bbZ;
					GetPlayerPos(i, bbX, bbY, bbZ);
					if(IsPlayerInRangeOfPoint(playerid, 20.0, bbX, bbY, bbZ))
					{
						BasketballInfo[BallHolder] = i;
						BasketballInfo[HaveBall][playerid] = 0;
						ClearAnimations(playerid);
						ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0,1,0);
						SetTimerEx("ClearAnim", 700, 0, "d", playerid);
						MoveObject(BasketballInfo[Ball], bbX, bbY, bbZ, 13+random(4));
						BasketballInfo[Animation][i] = 0;
						BasketballInfo[BallShooting] = 6;
						ApplyAnimationEx(i,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0,1,0);
						return 1;
					}
				}
			}
			new Float:bbX, Float:bbY, Float:bbZ;
			GetPlayerPos(playerid, bbX, bbY, bbZ);
			BasketballInfo[HaveBall][playerid] = 0;
			new Float:x2, Float:y2;
			GetXYInFrontOfPlayer(playerid, x2, y2, 6.0);
			SetTimerEx("BallDown", 600, 0, "df", playerid, bbZ);
			MoveObject(BasketballInfo[Ball], x2, y2, bbZ+random(8)+3, 10.0+random(4));
			ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0,1,0);
			BasketballInfo[BallShooting] = 0;
		}
	}
	return 1;
}

CMD:resetball(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	ResetBall();
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Resetirao si kosarkasku loptu na startnu poziciju!");
	return 1;
}
