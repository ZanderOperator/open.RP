#include <YSI_Coding\y_hooks>

/*
	- defines & enumerator
*/
#define MAX_PROSTITUTE 			(20)
#define QUICK_TIMER_COOLDOWN	(5)
#define MIN_TIP_MONEY			(5)
#define MAX_TIP_MONEY			(300)

enum E_DATA_PROSTITUTE {
	prID,
	prSkin,
	TipMoney,
	prEarned,

	prName[MAX_PLAYER_NAME],
	prOwner[MAX_PLAYER_NAME],

	Float:prPos[4],
	Text3D:prShowID,
	Text3D:prShowName
};


/*
	- vars & iters
*/
new Iterator: PROSTITUTE <MAX_PROSTITUTE>,
	quick_timer[MAX_PLAYERS 	char] 			= -1,
	bool: ShowsID[MAX_PLAYERS 	char] 			= (false),
	bool: ProstituteName[MAX_PROSTITUTE] 		= (false),
	ProstituteData[MAX_PROSTITUTE][E_DATA_PROSTITUTE];

/*
	- global prostitute functions
*/
CreateProstitute(playerid, skin_id, free_id) {
	Iter_Add(PROSTITUTE, free_id);

	ProstituteData[free_id][prID] 					= (free_id);
	ProstituteData[free_id][prSkin] 				= (skin_id);
	ProstituteData[free_id][prEarned] 				= (0);
	ProstituteData[free_id][TipMoney] 				= (0);
	strcpy(ProstituteData[free_id][prName], "None");
	strcpy(ProstituteData[free_id][prOwner], "None");
	ProstituteName[free_id] 						= (false);

	GetPlayerPos(playerid, ProstituteData[free_id][prPos][0], ProstituteData[free_id][prPos][1], ProstituteData[free_id][prPos][2]);
	GetPlayerFacingAngle(playerid, ProstituteData[free_id][prPos][3]);

	ProstituteData[free_id][prID] = CreateActor(skin_id, ProstituteData[free_id][prPos][0], ProstituteData[free_id][prPos][1], ProstituteData[free_id][prPos][2], ProstituteData[free_id][prPos][3]);
	SetActorVirtualWorld(ProstituteData[free_id][prID], GetPlayerVirtualWorld(playerid));

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste kreirali prostitutku sa ID-om %d.", free_id);
	return (true);
}

ChangeProstituteSkin(playerid, prostitute_id, skin_id) {
	DestroyActor(ProstituteData[prostitute_id][prID]);

	ProstituteData[prostitute_id][prID] = CreateActor(skin_id, ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2], ProstituteData[prostitute_id][prPos][3]);
	SetActorVirtualWorld(ProstituteData[prostitute_id][prID], GetPlayerVirtualWorld(playerid));
	return (true);
}

DeleteProstitute(playerid, prostitute_id) {
	if(IsValidDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName])) {
		DestroyDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName]);
	}

	DestroyActor(ProstituteData[prostitute_id][prID]);
	Iter_Remove(PROSTITUTE, prostitute_id);

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste unistili/obrisali prostitutku sa ID-om %d.", prostitute_id);
	return (true);
}

MoveProstitute(playerid, prostitute_id) {
	DestroyActor(ProstituteData[prostitute_id][prID]);

	GetPlayerPos(playerid, ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2]);
	GetPlayerFacingAngle(playerid, ProstituteData[prostitute_id][prPos][3]);

	ProstituteData[prostitute_id][prID] = CreateActor(ProstituteData[prostitute_id][prSkin], ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2], ProstituteData[prostitute_id][prPos][3]);
	SetActorVirtualWorld(ProstituteData[prostitute_id][prID], GetPlayerVirtualWorld(playerid));

	new buffer[64];
	if(ProstituteData[prostitute_id][TipMoney] != 0 && ProstituteName[prostitute_id] == (false))
		format(buffer, (64), "(TIP: $%d)\n'Y'", ProstituteData[prostitute_id][TipMoney]);
	if(ProstituteData[prostitute_id][TipMoney] != 0 && ProstituteName[prostitute_id] == (true))
		format(buffer, (64), "[%s]\n(TIP: $%d)\n'Y'", ProstituteData[prostitute_id][prName], ProstituteData[prostitute_id][TipMoney]);
	if(ProstituteData[prostitute_id][TipMoney] == 0 && ProstituteName[prostitute_id] == (true))
		format(buffer, (64), "[%s]", ProstituteData[prostitute_id][prName]);

	if(IsValidDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName])) {
		DestroyDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName]);
	}
	ProstituteData[prostitute_id][prShowName] = CreateDynamic3DTextLabel(buffer, COLOR_WHITE, ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste promijenili poziciji prostitutki sa ID-om %d.", prostitute_id);
	return (true);
}

CheckProstitute(prost_id) {
	new buffer[164];
	format(buffer, sizeof(buffer), "{3C95C2}Prostitute(%d) Info:\n\nOwner: %s.\nName: %s.\nTip Price: %s.\nEarned: %s.\nSkin: %d.",
		prost_id,
		ProstituteData[prost_id][prOwner],
		ProstituteData[prost_id][prName],
		FormatNumber(ProstituteData[prost_id][TipMoney]),
		FormatNumber(ProstituteData[prost_id][prEarned]),
		ProstituteData[prost_id][prSkin]
	);
	return (buffer);
}

/*
	- prostitute functions
*/
SetProstituteName(playerid, prostitute_id, prostitute_name[]) 
{
	ProstituteName[prostitute_id] = (true);
	strcpy(ProstituteData[prostitute_id][prName], prostitute_name);
	if(!strcmp(ProstituteData[prostitute_id][prName], "None", (true))) 
		ProstituteName[prostitute_id] = (false);

	new buffer[64];
	if(ProstituteData[prostitute_id][TipMoney] != 0 && ProstituteName[prostitute_id] == (true))
		format(buffer, (64), "[%s]\n(TIP: $%d)\n'Y'", prostitute_name, ProstituteData[prostitute_id][TipMoney]);
	if(ProstituteData[prostitute_id][TipMoney] == 0 && ProstituteName[prostitute_id] == (true))
		format(buffer, (64), "[%s]", prostitute_name);

	if(IsValidDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName])) {
		DestroyDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName]);
	}
	ProstituteData[prostitute_id][prShowName] = CreateDynamic3DTextLabel(buffer, -1, ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste postavili ime prostitutki id '%d' na '%s'.", prostitute_id, prostitute_name);
	return (true);
}

SetProstitutePriceTip(playerid, prostitute_id, tipmoney) {
	ProstituteData[prostitute_id][TipMoney] = tipmoney;

	new buffer[64];
	if(ProstituteData[prostitute_id][TipMoney] != 0 && ProstituteName[prostitute_id] == (false))
		format(buffer, 64, "(TIP: $%d)\n'Y'", ProstituteData[prostitute_id][TipMoney]);
	if(ProstituteData[prostitute_id][TipMoney] != 0 && ProstituteName[prostitute_id] == (true))
		format(buffer, 64, "[%s]\n(TIP: $%d)\n'Y'", ProstituteData[prostitute_id][prName], ProstituteData[prostitute_id][TipMoney]);

	if(IsValidDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName])) {
		DestroyDynamic3DTextLabel(ProstituteData[prostitute_id][prShowName]);
	}
	ProstituteData[prostitute_id][prShowName] = CreateDynamic3DTextLabel(buffer, -1, ProstituteData[prostitute_id][prPos][0], ProstituteData[prostitute_id][prPos][1], ProstituteData[prostitute_id][prPos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	if(tipmoney != 0)
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste postavili 'tip money/price' prostitutki id '%d' na '$%s'.", prostitute_id, FormatNumber(tipmoney));
	if(tipmoney == 0)
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste makli 'tip money/price' prostitutki id '%d'.", prostitute_id);
	return (true);
}

SetProstituteAnim(prostitute_id, anim_id) {
	switch(anim_id) {
		case 0:
			ClearActorAnimations(prostitute_id);
		case 1:
			ApplyActorAnimation(prostitute_id, "DANCING", "bd_clap", 4.0999, 1, 1, 1, 1, 0);
		case 2:
			ApplyActorAnimation(prostitute_id, "DANCING", "bd_clap1", 4.0999, 1, 1, 1, 1, 0);
		case 3:
			ApplyActorAnimation(prostitute_id, "DANCING", "dance_loop", 4.0999, 1, 1, 1, 1, 0);
		case 4:
			ApplyActorAnimation(prostitute_id, "DANCING", "DAN_Down_A", 4.0999, 1, 1, 1, 1, 0);
		case 5:
			ApplyActorAnimation(prostitute_id, "DANCING", "DAN_Left_A", 4.0999, 1, 1, 1, 1, 0);
		case 6:
			ApplyActorAnimation(prostitute_id, "DANCING", "DAN_Loop_A", 4.0999, 1, 1, 1, 1, 0);
		case 7:
			ApplyActorAnimation(prostitute_id, "DANCING", "DAN_Right_A", 4.0999, 1, 1, 1, 1, 0);
		case 8:
			ApplyActorAnimation(prostitute_id, "DANCING", "DAN_Up_A", 4.0999, 1, 1, 1, 1, 0);
		case 9:
			ApplyActorAnimation(prostitute_id, "DANCING", "dnce_M_a", 4.0999, 1, 1, 1, 1, 0);
		case 10:
			ApplyActorAnimation(prostitute_id, "DANCING", "dnce_M_b", 4.0999, 1, 1, 1, 1, 0);
		case 11:
			ApplyActorAnimation(prostitute_id, "DANCING", "dnce_M_c", 4.0999, 1, 1, 1, 1, 0);
		case 12:
			ApplyActorAnimation(prostitute_id, "DANCING", "dnce_M_d", 4.0999, 1, 1, 1, 1, 0);
		case 13:
			ApplyActorAnimation(prostitute_id, "DANCING", "dnce_M_e", 4.0999, 1, 1, 1, 1, 0);
		case 14:
		    ApplyActorAnimation(prostitute_id, "WOP", "Dance_G1", 4.0999, 1, 1, 1, 1, 0);
		case 15:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_A", 4.0999, 1, 1, 1, 1, 0);
		case 16:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_B", 4.0999, 1, 1, 1, 1, 0);
		case 17:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_C", 4.0999, 1, 1, 1, 1, 0);
		case 18:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_D", 4.0999, 1, 1, 1, 1, 0);
		case 19:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_E", 4.0999, 1, 1, 1, 1, 0);
		case 20:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_F", 4.0999, 1, 1, 1, 1, 0);
		case 21:
			ApplyActorAnimation(prostitute_id, "STRIP", "strip_G", 4.0999, 1, 1, 1, 1, 0);
		case 22:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_A2B", 4.0999, 1, 1, 1, 1, 0);
		case 23:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_B2C", 4.0999, 1, 1, 1, 1, 0);
		case 24:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_C1", 4.0999, 1, 1, 1, 1, 0);
		case 25:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_C2", 4.0999, 1, 1, 1, 1, 0);
		case 26:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_C2B", 4.0999, 1, 1, 1, 1, 0);
		case 27:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_Loop_A", 4.0999, 1, 1, 1, 1, 0);
		case 28:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_Loop_B", 4.0999, 1, 1, 1, 1, 0);
		case 29:
			ApplyActorAnimation(prostitute_id, "STRIP", "STR_Loop_C", 4.0999, 1, 1, 1, 1, 0);
		case 30:
			ApplyActorAnimation(prostitute_id, "STRIP", "PLY_CASH", 4.0999, 0, 1, 1, 1, 0);
		case 31:
			ApplyActorAnimation(prostitute_id, "STRIP", "PUN_CASH", 4.0999, 0, 1, 1, 1, 0);
		case 32:
			ApplyActorAnimation(prostitute_id, "STRIP", "PUN_HOLLER", 4.0999, 0, 1, 1, 1, 0);
		case 33:
			ApplyActorAnimation(prostitute_id, "STRIP", "PUN_LOOP", 4.0999, 1, 1, 1, 1, 0);
		case 34:
	       	ApplyActorAnimation(prostitute_id, "BLOWJOBZ", "BJ_COUCH_START_P", 4.1, 0, 1, 1, 0, 0);
	    case 35:
	        ApplyActorAnimation(prostitute_id, "BLOWJOBZ", "BJ_COUCH_START_W", 4.1, 0, 1, 1, 0, 0);
	    case 36:
	        ApplyActorAnimation(prostitute_id, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 0, 1, 1, 0, 0);
	    case 37:
	        ApplyActorAnimation(prostitute_id, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 0, 1, 1, 0, 0);
     	case 38:
	        ApplyAnimationEx(prostitute_id, "PED", "SEAT_idle", 4.0, 1, 0, 0, 0, 0);
	}
	return (true);
}

/*
	- hooks
*/
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(PRESSED(KEY_YES)) {
		foreach(new i : PROSTITUTE) {
			if(IsPlayerInRangeOfPoint(playerid, 5.0, ProstituteData[i][prPos][0], ProstituteData[i][prPos][1], ProstituteData[i][prPos][2])) {
				if(ProstituteData[i][TipMoney] == 0)
					return (true);
				if(AC_GetPlayerMoney( playerid ) <  ProstituteData[i][TipMoney])
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate vise novca.");
				if(gettimestamp() < quick_timer[playerid])
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate sacekati %d sekundi.", QUICK_TIMER_COOLDOWN);

				ProstituteData[i][prEarned] += ProstituteData[i][TipMoney];
				AC_GivePlayerMoney(playerid, -ProstituteData[i][TipMoney]);
				
				quick_timer[playerid] = gettimestamp() + QUICK_TIMER_COOLDOWN;

				new buffer[10];
				format(buffer, sizeof(buffer), "~r~-$%s", FormatNumber(ProstituteData[i][TipMoney]));
				GameTextForPlayer(playerid, buffer, 5000, 5 );

				ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 3.0, 0, 0, 0, 0, 0);
				break;
			}
		}
	}
	return (true);
}

/*
	- commands
*/
CMD:prostitute(playerid, const params[]) {
	new action[25],
		prostitute_id,
		skin_id;

	if(PlayerInfo[playerid][pAdmin] < 1338)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dozvolu za koristenje ove komande.");

	if(sscanf(params, "s[25] ", action)) {
		SendClientMessage(playerid, COLOR_WHITE, "(COMMAND): /prostitute [option].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): create, setanim, showids, setname, move, tipmoney, delete.");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): check, earned, changeskin.");
		return (true);
	}

	if(strcmp(action,"create", (true)) == 0) {
		new p_i = Iter_Free(PROSTITUTE);

		if(sscanf(params, "s[25]i", action, skin_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute create [skin_id].");
			return (true);
		}
		CreateProstitute(playerid, skin_id, p_i);
	}

	if(strcmp(action,"changeskin", (true)) == 0) {

		if(sscanf(params, "s[25]ii", action, prostitute_id, skin_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute changeskin [prostitute_id][skin_id].");
			return (true);
		}
		ChangeProstituteSkin(playerid, prostitute_id, skin_id);
	}

	if(strcmp(action,"check", (true)) == 0) {

		if(sscanf(params, "s[25]i", action, prostitute_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute check [prostitute_id].");
			return (true);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}* Prostitute - Check", CheckProstitute(prostitute_id), "Close", "");
	}

	if(strcmp(action,"earned", (true)) == 0) {
		new alt_command[15];

		if(sscanf(params, "s[25]s[15]", action, alt_command)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute earned [stats/withdraw].");
			return (true);
		}

		if(strcmp(alt_command,"stats",(true)) == 0) {
			foreach(new i : PROSTITUTE) {
				if(IsPlayerInRangeOfPoint(playerid, 5.0, ProstituteData[i][prPos][0], ProstituteData[i][prPos][1], ProstituteData[i][prPos][2])) {
					if(!strcmp(GetName(playerid), ProstituteData[i][prOwner], (false)))
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR,"Ne mozete provijeriti tu prostitutku, nije u vasem posjedu.");

					va_SendClientMessage(playerid, COLOR_RED, "[!] Prostitute Name: %s, Prostitute Earned: %s, Prostitute Tip Price: %s.",
						ProstituteData[i][prName],
						FormatNumber(ProstituteData[i][prEarned]),
						FormatNumber(ProstituteData[i][TipMoney])
					);
				}
			}
		}
		if(strcmp(alt_command,"withdraw",(true)) == 0) {
			foreach(new i : PROSTITUTE) {
				if(IsPlayerInRangeOfPoint(playerid, 5.0, ProstituteData[i][prPos][0], ProstituteData[i][prPos][1], ProstituteData[i][prPos][2])) {

					if(!strcmp(GetName(playerid), ProstituteData[i][prOwner], (false)))
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR,"Ne mozete uzeti novac od te prostitutke, nije u vasem posjedu.");

					if(ProstituteData[i][prEarned] == 0)
						return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR,"Ta prostitutka nije nista zaradila.");

					va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste uzeli novac(%s) koji je vasa prostitutka ('%s') zaradila.",
						FormatNumber(ProstituteData[i][prEarned]),
						ProstituteData[i][prName]
					);
					AC_GivePlayerMoney(playerid, ProstituteData[i][prEarned]);
					ProstituteData[i][prEarned] = 0;
				}
			}
		}
	}

	if(strcmp(action,"setname", (true)) == 0) {
		new prostitute_name[MAX_PLAYER_NAME];

		if(sscanf(params, "s[25]is[24]", action, prostitute_id, prostitute_name)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute setname [prostitute_id][name].");
			SendClientMessage(playerid, COLOR_WHITE, "[HINT]: Da maknete ime, pod 'name' upisite 'None'.");
			return (true);
		}
		SetProstituteName(playerid, prostitute_id, prostitute_name);
	}

	if(strcmp(action,"tipmoney", (true)) == 0) {
		new tipmoney;

		if(sscanf(params, "s[25]ii", action, prostitute_id, tipmoney)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute tipmoney [prostitute_id][price].");
			SendClientMessage(playerid, COLOR_WHITE, "[HINT]: Da maknete mogucnost dobivanja baksisa, stavite cijenu na '0'.");
			return (true);
		}
		if(tipmoney < MIN_TIP_MONEY || tipmoney > MAX_TIP_MONEY)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete staviti 'tip' manje od %s ili vise od %s.", FormatNumber(MIN_TIP_MONEY), FormatNumber(MAX_TIP_MONEY));

		SetProstitutePriceTip(playerid, prostitute_id, tipmoney);
	}

	if(strcmp(action,"delete", (true)) == 0) {
		if(sscanf(params, "s[25]i", action, prostitute_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute delete [prostitute_id].");
			return (true);
		}
		DeleteProstitute(playerid, prostitute_id);
	}

	if(strcmp(action,"move", (true)) == 0) {

		if(sscanf(params, "s[25]i", action, prostitute_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute move [prostitute_id].");
			return (true);
		}
		MoveProstitute(playerid, prostitute_id);
	}
	if(strcmp(action,"setanim", (true)) == 0) {
		new anim_id;

		if(sscanf(params, "s[25]ii", action, prostitute_id, anim_id)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /prostitute setanim [prostitute_id][anim_id].");
			SendClientMessage(playerid, 0xAFAFAFAA, "[DANCE ANIM] 1..=>..14");
			SendClientMessage(playerid, 0xAFAFAFAA, "[STRIP ANIM] 15..=>..33");
			SendClientMessage(playerid, 0xAFAFAFAA, "[BLOWJOB ANIM] 34..=>..37");
			SendClientMessage(playerid, 0xAFAFAFAA, "[SIT ANIM] 38");
			SendClientMessage(playerid, 0xAFAFAFAA, "=> Da maknete animaciju unesite '0'.");
			return (true);
		}
		SetProstituteAnim(ProstituteData[prostitute_id][prID], anim_id);
	}
	if(strcmp(action,"showids", (true)) == 0) {
		new buff[12];
		if(ShowsID[playerid] == (false)) {
			foreach(new i : PROSTITUTE) {
				format(buff, sizeof(buff), "(pID: %d)", i);

				ProstituteData[i][prShowID] = CreateDynamic3DTextLabel(buff, COLOR_GREEN, ProstituteData[i][prPos][0], ProstituteData[i][prPos][1], ProstituteData[i][prPos][2], 5.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
			}
			ShowsID[playerid] = (true);
		}
		else if(ShowsID[playerid] == (true)) {
			foreach(new i : PROSTITUTE) {
				if(IsValidDynamic3DTextLabel(ProstituteData[i][prShowID])) {
					DestroyDynamic3DTextLabel(ProstituteData[i][prShowID]);
				}
			}
			ShowsID[playerid] = (false);
		}
	}
	return (true);
}

