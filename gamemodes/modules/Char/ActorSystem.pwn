/*
 	Actor System
 	Autor: Khawaja
	Released: 2020
*/
#include <YSI_Coding\y_hooks>
#define MAX_LABELS 1000


enum ActorSt
{
	Dead,
	Injured
}
new ActorState[MAX_ACTORS][ActorSt];
public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float: amount, weaponid, bodypart)
{
	new Float:ahealth;
	GetActorHealth(damaged_actorid,ahealth);
 	SetActorHealth(damaged_actorid,ahealth-amount);
 	if(ActorState[damaged_actorid][Injured] == 0)
 	{
    	if(ahealth <= 30 && ahealth > 0 || bodypart == 7 || bodypart == 8)
    	{
        	ApplyActorAnimation(damaged_actorid, "SWEET", "Sweet_injuredloop", 4.1, 1, 0, 0, 0, 0);
			ApplyActorAnimation(damaged_actorid, "SWEET", "Sweet_injuredloop", 4.1, 1, 0, 0, 0, 0);
			ActorState[damaged_actorid][Injured] = 1;
			if(ahealth == 0) return ClearActorAnimations(damaged_actorid);
		}
	}
	if(ActorState[damaged_actorid][Dead] == 0)
	{
		if(bodypart == 9 || ahealth <= 0)
		{
	    	SetActorHealth(damaged_actorid,0);
	    	ApplyActorAnimation(damaged_actorid,"KNIFE","KILL_Knife_Ped_Die",4.1, 0, 0, 0, 1, 0);
	    	ActorState[damaged_actorid][Dead] = 1;
		}
	}
    return 1;
}

enum _labels
{
	Text3D: label_ID,
	label_text[128],
	Float: label_pos[3]
}
new
	aLabels[MAX_LABELS][_labels];

stock ClearLabel(e_label_id)
{
	Delete3DTextLabel(aLabels[e_label_id][label_ID]);

	aLabels[e_label_id][label_ID] = Text3D: INVALID_3DTEXT_ID;

	aLabels[e_label_id][label_pos][0] = 0.0;
	aLabels[e_label_id][label_pos][1] = 0.0;
	aLabels[e_label_id][label_pos][2] = 0.0;

	aLabels[e_label_id][label_text][0] = EOS;
	return 1;
}

new ActorText[MAX_ACTORS];
// Commands
CMD:spawnactor(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new Float:Pos[3],skinid,invulnerability,Float:Angle;
    if(sscanf(params,"il",skinid,invulnerability)) return SendClientMessage(playerid,COLOR_RED, "[?]: /spawnactor [skinid][[!] Ranjivost (0: DISABLED | 1: ENABLED)]");
    if(invulnerability != 1 && invulnerability != 0) return SendClientMessage(playerid,COLOR_RED,"[!] Ranjivost (0: DISABLED | 1: ENABLED)");
    GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
    GetPlayerFacingAngle(playerid, Angle);
	new Actor = CreateActor(skinid, Pos[0], Pos[1], Pos[2], 0);
	SetPlayerPos(playerid,Pos[0]+1,Pos[1]+1,Pos[2]);
    SetActorFacingAngle(Actor, Angle);
	va_SendClientMessage(playerid,COLOR_RED,"[!] Actor %d je spawnan Pos: x[%f], y[%f], z[%f]",Actor,Pos[0],Pos[1],Pos[2]);
 	new str2[256];
	format(str2,sizeof(str2),"Actor ID: %d",Actor);
	aLabels[Actor][label_ID] = Create3DTextLabel(str2, COLOR_YELLOW, Pos[0], Pos[1], Pos[2], 10, 0, 0);
	aLabels[Actor][label_pos][0] = Pos[0];
	aLabels[Actor][label_pos][1] = Pos[1];
	aLabels[Actor][label_pos][2] = Pos[2];
 	if(invulnerability == 0)
    {
        SetActorInvulnerable(Actor, 1);
        SendClientMessage(playerid,COLOR_RED,"[!] Ovaj actor nije ranjiv!");
	}
	else if(invulnerability == 1)
	{
	    SetActorHealth(Actor, 100);
	    SetActorInvulnerable(Actor,0);
	    SendClientMessage(playerid,COLOR_RED,"[!] Ovaj actor je ranjiv!");
	}
	for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
    {
        if(ActorText[i] == 1)
        {
			ActorText[Actor] = 1;
		}
		else if(ActorText[i] == 0)
		{
			ActorText[Actor] = 0;
			ClearLabel(Actor);
		}
    }
    ActorState[Actor][Dead] = 0;
    ActorState[Actor][Injured] = 0;
	return 1;
}

CMD:removeactor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new actorid,str[256];
    if(sscanf(params,"i",actorid)) return SendClientMessage(playerid,COLOR_RED, "[?]: /removeactor [actor id]");
    format(str,sizeof(str),"[!] Actor %d je obrisan.",actorid);
    if(IsValidActor(actorid))
    {
        SendClientMessage(playerid,COLOR_RED,str);
        DestroyActor(actorid);
        ClearLabel(actorid);
	}
	else return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor ID.");
	return 1;
}

CMD:removeallactors(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
    {
        if(IsValidActor(i))
        {
            DestroyActor(i);
            ClearLabel(i);
        }
    }
    return 1;
}

CMD:gotoactor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    new Float:Pos[3],actorid;
    if(sscanf(params,"i",actorid)) return SendClientMessage(playerid,COLOR_RED,"[?]: /gotoactor [actor id]");
    if(IsValidActor(actorid))
	{
		GetActorPos(actorid,Pos[0],Pos[1],Pos[2]);
		SetPlayerPos(playerid,Pos[0]+1,Pos[1],Pos[2]);
		va_SendClientMessage(playerid,COLOR_RED,"[!] Portali ste se do Actora ID: %d!",actorid);
	}
	else return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor ID.");
	return 1;
}

CMD:allactors(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	SendClientMessage(playerid,COLOR_RED,"_______________________________________________");
    for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
    {
        if(IsValidActor(i))
        {
            va_SendClientMessage(playerid,COLOR_RED,"[!] Actor: %d | ranjivost: %d",i,!IsActorInvulnerable(i));
        }
        else
		{
		    SendClientMessage(playerid,COLOR_RED,"-");
		    continue;
		}
    }
    SendClientMessage(playerid,COLOR_RED,"_______________________________________________");
    return 1;
}

CMD:setactoranim(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new animation[256],actorid;
	if(sscanf(params,"is[100]",actorid,animation)) return SendClientMessage(playerid,COLOR_RED,"[?]:/setactoranim [actor id][animation]");
	if(IsValidActor(actorid))
	{
		if(!strcmp(animation, "injured"))
		{
			ApplyActorAnimation(actorid, "SWEET", "Sweet_injuredloop", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "handsup"))
		{
			ApplyActorAnimation(actorid, "SHOP", "SHP_Rob_HandsUp", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
  		}
		if(!strcmp(animation, "sit"))
		{
			ApplyActorAnimation(actorid, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "lean"))
		{
			ApplyActorAnimation(actorid, "GANGS", "leanIDLE", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "dance"))
		{
			ApplyActorAnimation(actorid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "dealstance"))
		{
			ApplyActorAnimation(actorid, "DEALER", "DEALER_IDLE", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "riotchant"))
		{
			ApplyActorAnimation(actorid, "RIOT", "RIOT_CHANT", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "wave"))
		{
			ApplyActorAnimation(actorid, "ON_LOOKERS", "wave_loop", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "hide"))
		{
			ApplyActorAnimation(actorid, "ped", "cower", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "crossarms"))
		{
			ApplyActorAnimation(actorid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "laugh"))
		{
			ApplyActorAnimation(actorid, "RAPPING", "Laugh_01", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "talk"))
		{
			ApplyActorAnimation(actorid, "PED", "IDLE_CHAT", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "fucku"))
		{
			ApplyActorAnimation(actorid, "PED", "fucku", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "tired"))
		{
			ApplyActorAnimation(actorid, "PED", "IDLE_tired", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
			
		}
		if(!strcmp(animation, "chairsit"))
		{
			ApplyActorAnimation(actorid, "PED", "SEAT_idle", 4.1, 1, 0, 0, 0, 0);
			va_SendClientMessage(playerid,COLOR_RED,"[!] Postavljena je animacija '%s' na Actora %d",animation,actorid);
		}
	}
	else return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor ID.");
	return 1;
}

CMD:cancelactoranim(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new actorid;
	if(sscanf(params,"i",actorid)) return SendClientMessage(playerid,COLOR_RED,"[?]: /cancelactoranim [actor id]");
	if(IsValidActor(actorid))
	{
		ClearActorAnimations(actorid);
		SendClientMessage(playerid,COLOR_RED,"[!] Animacija prekinuta");
	}
	else return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor ID.");
	return 1;
}

CMD:cancelallactorsanim(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
    {
    	ClearActorAnimations(i);
	}
	SendClientMessage(playerid,COLOR_RED,"[!] Iskljucili ste animacije svih actora.");
	return 1;
}

CMD:getactor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new actorid,str[256],Float:pPos[3],Float:aPos[3],Float:newPos[3];
	if(sscanf(params,"i",actorid)) return SendClientMessage(playerid,COLOR_RED,"[?]: /getactor [actor id]");
	if(IsValidActor(actorid))
	{
	    ClearLabel(actorid);
	    GetActorPos(actorid,aPos[0],aPos[1],aPos[2]);
	    GetPlayerPos(playerid,pPos[0],pPos[1],pPos[2]);
	    SetActorPos(actorid,pPos[0],pPos[1],pPos[2]);
	    GetActorPos(actorid,newPos[0],newPos[1],newPos[2]);
	    SetPlayerPos(playerid,pPos[0]+1,pPos[1]+1,pPos[2]);
	    format(str,sizeof(str),"[!] Actor ID: %d",actorid);
	    aLabels[actorid][label_ID]  = Create3DTextLabel(str, COLOR_YELLOW, newPos[0], newPos[1], newPos[2], 10, 0, 0);
		for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
    	{
        	if(ActorText[i] == 1)
        	{
				ActorText[actorid] = 1;
			}
			else if(ActorText[i] == 0)
			{
				ActorText[actorid] = 0;
				ClearLabel(actorid);
			}
    	}
	}
	else return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor.");
	return 1;
}

CMD:actorstext(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
	{
		if(ActorText[i] == 0)
    	{
			ActorText[i] = 1;
			new Float:Pos[3],str2[256];
			format(str2,sizeof(str2),"Actor ID: %d",i);
			GetActorPos(i,Pos[0],Pos[1],Pos[2]);
			aLabels[i][label_ID] = Create3DTextLabel(str2, COLOR_YELLOW, Pos[0], Pos[1], Pos[2], 10, 0, 0);
		}
		else if(ActorText[i] == 1)
		{
			ActorText[i] = 0;
			ClearLabel(i);
		}
	}
	return 1;
}


CMD:updateactor(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    new actorid,skinid,invulnerability,Float:Pos[3],Float:Angle,str2[256];
    if(sscanf(params,"iil",actorid,skinid,invulnerability)) return SendClientMessage(playerid,COLOR_RED,"[!][?]: /updateactor [actor id][skin id][ranjivost]");
    if(!IsValidActor(actorid)) return SendClientMessage(playerid,COLOR_RED,"Pogre�an actor ID");
    if(invulnerability > 1 || invulnerability < 0) return SendClientMessage(playerid,COLOR_RED,"[!] Ranjivost (0: DISABLED / 1: ENABLED)");
    GetPlayerFacingAngle(playerid, Angle);
    GetActorPos(actorid,Pos[0],Pos[1],Pos[2]);
    DestroyActor(actorid);
    new actorid2 = CreateActor(skinid, Pos[0], Pos[1], Pos[2], 0);
    SetActorFacingAngle(actorid2, Angle);
    format(str2,sizeof(str2),"Actor ID: %d",actorid2);
    ClearLabel(actorid);
    aLabels[actorid2][label_ID] = Create3DTextLabel(str2, COLOR_YELLOW, Pos[0], Pos[1], Pos[2], 10, 0, 0);
    va_SendClientMessage(playerid,COLOR_RED,"[!] Updateali ste actora %i. (new info: skin: %i, Vul: %i, ID: %i)",actorid,skinid,invulnerability,actorid2);
	for(new i = 0, j = GetActorPoolSize(); i <= j; i++)
	{
    	if(ActorText[i] == 1)
    	{
			ActorText[actorid2] = 1;
		}
		else if(ActorText[i] == 0)
		{
			ActorText[actorid2] = 0;
			ClearLabel(actorid2);
		}
	}
 	if(invulnerability == 0)
	{
    	SetActorInvulnerable(actorid2, 1);
    	SendClientMessage(playerid,COLOR_RED,"Ovaj actor nije ranjiv.");
	}
	else if(invulnerability == 1)
	{
	    SetActorHealth(actorid2, 100);
    	SetActorInvulnerable(actorid2,0);
    	SendClientMessage(playerid,COLOR_RED,"Ovaj actor je ranjiv.");
	}
	return 1;
}
CMD:actorhelp(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    new text[500],text2[500],text3[500],everything[1000];
    format(text,sizeof(text),"{A9A9A9}** {ff0000}/spawnactor [skin id][Ranjivost (0: DISABLED / 1: ENABLED)] > Spawna Actora tamo gdje igrac gleda\n{A9A9A9}** {ff0000}/removeactor [actor id] > Uklanja odredjenog actora.\n{A9A9A9}** {ff0000}/removeallactors > Uklanja sve actore");
    format(text2,sizeof(text2),"\n{A9A9A9}** {ff0000}/gotoactor [actor id] > Porta vas do actora\n{A9A9A9}** {ff0000}/setactoranim [anim] > Postavlja animaciju na actora\n{ff0000}    ANIMACIJE: handsup / lean / sit / injured / dance / laugh / hide / dealstance / crossarms / riotchant / wave / talk / fucku / tired");
    format(text3,sizeof(text3),"\n{A9A9A9}** {ff0000}/cancelactoranim [actor id] > Prekida zadatu animaciju actora\n{A9A9A9}** {ff0000}/actorstext > Prikazuje/Uklanja text na actoru\n{A9A9A9}** {ff0000}/updateactor [actor id][skin id][ranjivost] > Updatea specificnog aktora (ID, Skin, Ranjvist, te mu postavlja rotaciju.)");
    format(everything,sizeof(everything),"%s %s %s",text,text2,text3);
    ShowPlayerDialog(playerid, DIALOG_ACTORHELP, DIALOG_STYLE_MSGBOX, "Actor Commands",everything,"OK","");
    return 1;
}
