/*



		DODATI U DIALOG ENUM u coarp.pwn:

		// Poker.pwn
		DIALOG_CGAMESADMINMENU,
		DIALOG_CGAMESSELECTPOKER,
		DIALOG_CGAMESSETUPPOKER,
		DIALOG_CGAMESSETUPPGAME,
		DIALOG_CGAMESSETUPPGAME2,
		DIALOG_CGAMESSETUPPGAME3,
		DIALOG_CGAMESSETUPPGAME4,
		DIALOG_CGAMESSETUPPGAME5,
		DIALOG_CGAMESSETUPPGAME6,
		DIALOG_CGAMESSETUPPGAME7,
		DIALOG_CGAMESBUYINPOKER,
		DIALOG_CGAMESCALLPOKER,
		DIALOG_CGAMESRAISEPOKER
		_________               .__
		\_   ___ \_____    _____|__| ____   ____
		/    \  \/\__  \  /  ___/  |/    \ /  _ \
		\     \____/ __ \_\___ \|  |   |  (  <_> )
		 \______  (____  /____  >__|___|  /\____/
		        \/     \/     \/        \/
		  ________
		 /  _____/_____    _____   ____   ______
		/   \  ___\__  \  /     \_/ __ \ /  ___/
		\    \_\  \/ __ \|  Y Y  \  ___/ \___ \
		 \______  (____  /__|_|  /\___  >____  >
		        \/     \/      \/     \/     \/

		  Developed By Dan 'GhoulSlayeR' Reed
			     mrdanreed@gmail.com

===========================================================
This software was written for the sole purpose to not be
destributed without written permission from the software
developer.

Changelog:

1.0.0 - Inital Release
===========================================================


*/

#include <YSI\y_hooks>

// Objects
#define OBJ_POKER_TABLE 					19474

// Player Poker Table Limits
#define PREMIUM_NONE_POKER_TABLES			1
#define PREMIUM_BRONZE_POKER_TABLES			2
#define PREMIUM_SILVER_POKER_TABLES			3
#define PREMIUM_GOLD_POKER_TABLES			4
#define PREMIUM_PLATINUM_POKER_TABLES		5

// GUI
#define GUI_POKER_TABLE						0

// Poker Misc
#define MAX_POKERTABLES 					100
#define MAX_POKERTABLEMISCOBJS				6
#define MAX_PLAYERPOKERUI					43
#define DRAWDISTANCE_POKER_TABLE 			150.0
#define DRAWDISTANCE_POKER_MISC 			50.0
#define CAMERA_POKER_INTERPOLATE_SPEED		5000 // ms (longer = slower)

#define IsNull(%1) \
((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

new PlayingTableID[MAX_PLAYERS],
	PlayingTableSlot[MAX_PLAYERS];

new Iterator: PokerTables <MAX_POKERTABLES>;

new PlayerText:PlayerPokerUI[MAX_PLAYERS][MAX_PLAYERPOKERUI];

enum pkrInfo
{
	pkrSQL,
	pkrActive,
	pkrPlaced,
	pkrObjectID,
	pkrMiscObjectID[MAX_POKERTABLEMISCOBJS],
	Text3D:pkrText3DID,
	Float:pkrX,
	Float:pkrY,
	Float:pkrZ,
	Float:pkrRX,
	Float:pkrRY,
	Float:pkrRZ,
	pkrVW,
	pkrInt,
	pkrPlayers,
	pkrActivePlayers,
	pkrActiveHands,
	pkrSlot[6],
	pkrPass[32],
	pkrLimit,
	bool:pkrPulseTimer,
	pkrBuyInMax,
	pkrBuyInMin,
	pkrBlind,
	pkrTinkerLiveTime,
	pkrDelay,
	pkrSetDelay,
	pkrPos,
	pkrRotations,
	pkrSlotRotations,
	pkrActivePlayerID,
	pkrActivePlayerSlot,
	pkrRound,
	pkrStage,
	pkrActiveBet,
	pkrDeck[52],
	pkrCCards[5],
	pkrPot,
	pkrWinners,
	pkrWinnerID,
};
new PokerTable[MAX_POKERTABLES][pkrInfo];

/*new Float:PokerTableMiscObjOffsets[MAX_POKERTABLEMISCOBJS][6] = {
{-1.25, 0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 1)
{-1.25, -0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 2)
{-0.01, -1.85, 0.1, 0.0, 0.0, -90.0}, // (Slot 3)
{1.25, -0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 4)
{1.25, 0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 5)
{0.01, 1.85, 0.1, 0.0, 0.0, 90.0}  // (Slot 6)
};*/

new Float:PokerTableMiscObjOffsets[MAX_POKERTABLEMISCOBJS][6] = {
{-1.25, -0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 2)
{-1.25, 0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 1)
{0.01, 1.85, 0.1, 0.0, 0.0, 90.0},  // (Slot 6)
{1.25, 0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 5)
{1.25, -0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 4)
{-0.01, -1.85, 0.1, 0.0, 0.0, -90.0} // (Slot 3)
};

new DeckTextdrw[53][] = {
"LD_CARD:cdback", // CARD BACK
"LD_CARD:cd1c", // A Clubs - 0
"LD_CARD:cd2c", // 2 Clubs - 1
"LD_CARD:cd3c", // 3 Clubs - 2
"LD_CARD:cd4c", // 4 Clubs - 3
"LD_CARD:cd5c", // 5 Clubs - 4
"LD_CARD:cd6c", // 6 Clubs - 5
"LD_CARD:cd7c", // 7 Clubs - 6
"LD_CARD:cd8c", // 8 Clubs - 7
"LD_CARD:cd9c", // 9 Clubs - 8
"LD_CARD:cd10c", // 10 Clubs - 9
"LD_CARD:cd11c", // J Clubs - 10
"LD_CARD:cd12c", // Q Clubs - 11
"LD_CARD:cd13c", // K Clubs - 12
"LD_CARD:cd1d", // A Diamonds - 13
"LD_CARD:cd2d", // 2 Diamonds - 14
"LD_CARD:cd3d", // 3 Diamonds - 15
"LD_CARD:cd4d", // 4 Diamonds - 16
"LD_CARD:cd5d", // 5 Diamonds - 17
"LD_CARD:cd6d", // 6 Diamonds - 18
"LD_CARD:cd7d", // 7 Diamonds - 19
"LD_CARD:cd8d", // 8 Diamonds - 20
"LD_CARD:cd9d", // 9 Diamonds - 21
"LD_CARD:cd10d", // 10 Diamonds - 22
"LD_CARD:cd11d", // J Diamonds - 23
"LD_CARD:cd12d", // Q Diamonds - 24
"LD_CARD:cd13d", // K Diamonds - 25
"LD_CARD:cd1h", // A Heats - 26
"LD_CARD:cd2h", // 2 Heats - 27
"LD_CARD:cd3h", // 3 Heats - 28
"LD_CARD:cd4h", // 4 Heats - 29
"LD_CARD:cd5h", // 5 Heats - 30
"LD_CARD:cd6h", // 6 Heats - 31
"LD_CARD:cd7h", // 7 Heats - 32
"LD_CARD:cd8h", // 8 Heats - 33
"LD_CARD:cd9h", // 9 Heats - 34
"LD_CARD:cd10h", // 10 Heats - 35
"LD_CARD:cd11h", // J Heats - 36
"LD_CARD:cd12h", // Q Heats - 37
"LD_CARD:cd13h", // K Heats - 38
"LD_CARD:cd1s", // A Spades - 39
"LD_CARD:cd2s", // 2 Spades - 40
"LD_CARD:cd3s", // 3 Spades - 41
"LD_CARD:cd4s", // 4 Spades - 42
"LD_CARD:cd5s", // 5 Spades - 43
"LD_CARD:cd6s", // 6 Spades - 44
"LD_CARD:cd7s", // 7 Spades - 45
"LD_CARD:cd8s", // 8 Spades - 46
"LD_CARD:cd9s", // 9 Spades - 47
"LD_CARD:cd10s", // 10 Spades - 48
"LD_CARD:cd11s", // J Spades - 49
"LD_CARD:cd12s", // Q Spades - 50
"LD_CARD:cd13s" // K Spades - 51
};

//------------------------------------------------

hook OnGameModeInit()
{
	InitPokerTables();
	return 1;
}

hook OnGameModeExit()
{
	if(Iter_Count(PokerTables) == 0)
		return 1;

	foreach(new t: PokerTables)
		ResetPokerTableEnum(t);

	Iter_Clear(PokerTables);
	return 1;
}
//------------------------------------------------

// Note: 0, 1 should be the hand, the rest are community cards.
AnaylzePokerHand(playerid, Hand[])
{
	new pokerArray[7];
	for(new i = 0; i < sizeof(pokerArray); i++) {
		pokerArray[i] = Hand[i];
	}

	new suitArray[4][13];
	new tmp = 0;
	new pairs = 0;
	new bool:isRoyalFlush = false;
	new bool:isFlush = false;
	new bool:isStraight = false;
	new bool:isFour = false;
	new bool:isThree = false;
	new bool:isTwoPair = false;
	new bool:isPair = false;

	// Convert Hand[] (AKA pokerArray) to suitArray[]
	for(new i = 0; i < sizeof(pokerArray); i++) {
		if(pokerArray[i] <= 12) { // Clubs (0 - 12)
			suitArray[0][pokerArray[i]] = 1;
		}
		if(pokerArray[i] <= 25 && pokerArray[i] >= 13) { // Diamonds (13 - 25)
			suitArray[1][pokerArray[i]-13] = 1;
		}
		if(pokerArray[i] <= 38 && pokerArray[i] >= 26) { // Hearts (26 - 38)
			suitArray[2][pokerArray[i]-26] = 1;
		}
		if(pokerArray[i] <= 51 && pokerArray[i] >= 39) { // Spades (39 - 51)
			suitArray[3][pokerArray[i]-39] = 1;
		}
	}

	// Royal Check
	for(new i = 0; i < 4; i++) {
		if(suitArray[i][0] == 1) {
			if(suitArray[i][9] == 1) {
				if(suitArray[i][10] == 1) {
					if(suitArray[i][11] == 1) {
						if(suitArray[i][12] == 1) {
							isRoyalFlush = true;
							break;
						}
					}
				}
			}
		}
	}
	tmp = 0;

	// Flush Check
	for(new i = 0; i < 4; i++) {
		for(new j = 0; j < 13; j++) {
			if(suitArray[i][j] == 1) {
				tmp++;
			}
		}

		if(tmp > 4) {
			isFlush = true;
			break;
		} else {
			tmp = 0;
		}
	}
	tmp = 0;

	// Four of a Kind Check
	// Three of a Kind Check
	for(new i = 0; i < 4; i++) {
		for(new j = 0; j < 13; j++) {
			if(suitArray[i][j] == 1) {
				for(new c = 0; c < 4; c++) {
					if(suitArray[c][j] == 1) {
						tmp++;
					}
				}
				if(tmp == 4) {
					isFour = true;
				}
				else if(tmp == 3) {
					isThree = true;
				} else {
					tmp = 0;
				}
			}
		}
	}
	tmp = 0;

	// Two Pair & Pair Check
	for(new j = 0; j < 13; j++) {
		tmp = 0;
		for(new i = 0; i < 4; i++) {
			if(suitArray[i][j] == 1) {
				tmp++;

				if(tmp >= 2) {
					isPair = true;
					pairs++;

					if(pairs >= 2) {
						isTwoPair = true;
					}
				}
			}
		}
	}
	tmp = 0;

	// Straight Check
	for(new j = 0; j < 13; j++) {
		for(new i = 0; i < 4; i++) {
			if(suitArray[i][j] == 1) {
				for(new s = 0; s < 5; s++) {
					for(new c = 0; c < 4; c++) {
						if(j+s == 13)
						{
							if(suitArray[c][0] == 1) {
								tmp++;
								break;
							}
						}
						else if (j+s >= 14)
						{
							break;
						}
						else
						{
							if(suitArray[c][j+s] == 1) {
								tmp++;
								break;
							}
						}
					}
				}
			}
			if(tmp >= 5) {
				isStraight = true;
			}
			tmp = 0;
		}
	}
	tmp = 0;

	// Convert Hand to Singles

	// Card 1
	if(pokerArray[0] > 12 && pokerArray[0] < 26) pokerArray[0] -= 13;
	if(pokerArray[0] > 25 && pokerArray[0] < 39) pokerArray[0] -= 26;
	if(pokerArray[0] > 38 && pokerArray[0] < 52) pokerArray[0] -= 39;
	if(pokerArray[0] == 0) pokerArray[0] = 13; // Convert Aces to worth 13.

	// Card 2
	if(pokerArray[1] > 12 && pokerArray[1] < 26) pokerArray[1] -= 13;
	if(pokerArray[1] > 25 && pokerArray[1] < 39) pokerArray[1] -= 26;
	if(pokerArray[1] > 38 && pokerArray[1] < 52) pokerArray[1] -= 39;
	if(pokerArray[1] == 0) pokerArray[1] = 13; // Convert Aces to worth 13.

	// 10) POKER_RESULT_ROYAL_FLUSH - A, K, Q, J, 10 (SAME SUIT) * ROYAL + FLUSH *
	if(isRoyalFlush) {
		SetPVarString(playerid, "pkrResultString", "Royal Flush");
		return 1000 + pokerArray[0] + pokerArray[1];
	}

	// 9) POKER_RESULT_STRAIGHT_FLUSH - Any five card squence. (SAME SUIT) * STRAIGHT + FLUSH *
	if(isStraight && isFlush) {
		SetPVarString(playerid, "pkrResultString", "Straight Flush");
		return 900 + pokerArray[0] + pokerArray[1];
	}

	// 8) POKER_RESULT_FOUR_KIND - All four cards of the same rank. * FOUR KIND *
	if(isFour) {
		SetPVarString(playerid, "pkrResultString", "Four of a Kind");
		return 800 + pokerArray[0] + pokerArray[1];
	}

	// 7) POKER_RESULT_FULL_HOUSE - Three of a kind combined with a pair. * THREE KIND + PAIR *
	if(isThree && isTwoPair) {
		SetPVarString(playerid, "pkrResultString", "Full House");
		return 700 + pokerArray[0] + pokerArray[1];
	}

	// 6) POKER_RESULT_FLUSH - Any five cards of the same suit, no sequence. * FLUSH *
	if(isFlush) {
		SetPVarString(playerid, "pkrResultString", "Flush");
		return 600 + pokerArray[0] + pokerArray[1];
	}

	// 5) POKER_RESULT_STRAIGHT - Five cards in sequence, but not in the same suit. * STRAIGHT *
	if(isStraight) {
		SetPVarString(playerid, "pkrResultString", "Straight");
		return 500 + pokerArray[0] + pokerArray[1];
	}

	// 4) POKER_RESULT_THREE_KIND - Three cards of the same rank. * THREE KIND *
	if(isThree) {
		SetPVarString(playerid, "pkrResultString", "Three of a Kind");
		return 400 + pokerArray[0] + pokerArray[1];
	}

	// 3) POKER_RESULT_TWO_PAIR - Two seperate pair. * TWO PAIR *
	if(isTwoPair) {
		SetPVarString(playerid, "pkrResultString", "Two Pair");
		return 300 + pokerArray[0] + pokerArray[1];
	}

	// 2) POKER_RESULT_PAIR - Two cards of the same rank. * PAIR *
	if(isPair) {
		SetPVarString(playerid, "pkrResultString", "Pair");
		return 200 + pokerArray[0] + pokerArray[1];
	}

	// 1) POKER_RESULT_HIGH_CARD - Highest card.
	SetPVarString(playerid, "pkrResultString", "High Card");
	return pokerArray[0] + pokerArray[1];
}

SetPlayerPosObjectOffset(objectid, playerid, Float:offset_x, Float:offset_y, Float:offset_z)
{
	new Float:object_px,
        Float:object_py,
        Float:object_pz,
        Float:object_rx,
        Float:object_ry,
        Float:object_rz;

    GetDynamicObjectPos(objectid, object_px, object_py, object_pz);
    GetDynamicObjectRot(objectid, object_rx, object_ry, object_rz);

    new Float:cos_x = floatcos(object_rx, degrees),
        Float:cos_y = floatcos(object_ry, degrees),
        Float:cos_z = floatcos(object_rz, degrees),
        Float:sin_x = floatsin(object_rx, degrees),
        Float:sin_y = floatsin(object_ry, degrees),
        Float:sin_z = floatsin(object_rz, degrees);

	new Float:x, Float:y, Float:z;
    x = object_px + offset_x * cos_y * cos_z - offset_x * sin_x * sin_y * sin_z - offset_y * cos_x * sin_z + offset_z * sin_y * cos_z + offset_z * sin_x * cos_y * sin_z;
    y = object_py + offset_x * cos_y * sin_z + offset_x * sin_x * sin_y * cos_z + offset_y * cos_x * cos_z + offset_z * sin_y * sin_z - offset_z * sin_x * cos_y * cos_z;
    z = object_pz - offset_x * cos_x * sin_y + offset_y * sin_x + offset_z * cos_x * cos_y;

	SetPlayerPos(playerid, x, y, z);
}

stock BubbleSort(a[], size)
{
	new tmp=0, bool:swapped;

	do
	{
		swapped = false;
		for(new i=1; i < size; i++) {
			if(a[i-1] > a[i]) {
				tmp = a[i];
				a[i] = a[i-1];
				a[i-1] = tmp;
				swapped = true;
			}
		}
	} while(swapped);
}

forward PokerExit(playerid);
public PokerExit(playerid)
{
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid);
	CancelSelectTextDraw(playerid);
}

Function: PokerPulse()
{
	foreach(new tableid: PokerTables)
	{
		if(PokerTable[tableid][pkrPulseTimer] == true)
		{
			// Idle Animation Loop & Re-seater
			for(new i = 0; i < 6; i++) {
				new playerid = PokerTable[tableid][pkrSlot][i];

				if(playerid != -1) {

					// Disable Weapons
					SetPlayerArmedWeapon(playerid,0);

					new idleRandom = random(100);
					if(idleRandom >= 90) {
						SetPlayerPosObjectOffset(PokerTable[tableid][pkrObjectID], playerid, PokerTableMiscObjOffsets[i][0], PokerTableMiscObjOffsets[i][1], PokerTableMiscObjOffsets[i][2]);
						SetPlayerFacingAngle(playerid, PokerTableMiscObjOffsets[i][5]+90.0);

						// Animation
						if(GetPVarInt(playerid, "pkrActiveHand")) {
							ApplyAnimation(playerid, "CASINO", "cards_loop", 4.1, 0, 1, 1, 1, 1, 1);
						}
					}
				}
			}

			if(PokerTable[tableid][pkrActivePlayers] >= 2 && PokerTable[tableid][pkrActive] == 2)
			{
				// Count the number of active players with more than $0, activate the round if more than 1 gets counted.
				new tmpCount = 0;
				for(new i = 0; i < 6; i++) {
					new playerid = PokerTable[tableid][pkrSlot][i];

					if(playerid != -1) {
						if(GetPVarInt(playerid, "pkrChips") > 0) {
							tmpCount++;
						}
					}
				}

				if(tmpCount > 1) {
					PokerTable[tableid][pkrActive] = 3;
					PokerTable[tableid][pkrDelay] = PokerTable[tableid][pkrSetDelay];
				}
			}

			// Winner Loop
			if(PokerTable[tableid][pkrActive] == 4)
			{
				if(PokerTable[tableid][pkrDelay] == 20) {
					new endBetsSoundID[] = {5826, 5827};
					new randomEndBetsSoundID = random(sizeof(endBetsSoundID));
					GlobalPlaySound(endBetsSoundID[randomEndBetsSoundID], PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ]);

					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) {
							PokerOptions(playerid, 0);
						}
					}
				}

				if(PokerTable[tableid][pkrDelay] > 0) {
					PokerTable[tableid][pkrDelay]--;
					if(PokerTable[tableid][pkrDelay] <= 5 && PokerTable[tableid][pkrDelay] > 0) {
						for(new i = 0; i < 6; i++) {
							new playerid = PokerTable[tableid][pkrSlot][i];

							if(playerid != -1) PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
						}
					}
				}

				if(PokerTable[tableid][pkrDelay] == 0) {
					return ResetPokerRound(tableid);
				}

				if(PokerTable[tableid][pkrDelay] == 19) {
					// Anaylze Cards
					new resultArray[6];
					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];
						new cards[7];

						if(playerid != -1) {
							if(GetPVarInt(playerid, "pkrActiveHand")) {
								cards[0] = GetPVarInt(playerid, "pkrCard1");
								cards[1] = GetPVarInt(playerid, "pkrCard2");

								new tmp = 0;
								for(new c = 2; c < 7; c++) {
									cards[c] = PokerTable[tableid][pkrCCards][tmp];
									tmp++;
								}

								SetPVarInt(playerid, "pkrResult", AnaylzePokerHand(playerid, cards));
							}
						}
					}

					// Sorting Results (Highest to Lowest)
					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) {
							if(GetPVarInt(playerid, "pkrActiveHand")) {
								resultArray[i] = GetPVarInt(playerid, "pkrResult");
							}
						}
					}
					BubbleSort(resultArray, sizeof(resultArray));

					// Determine Winner(s)
					for(new i = 0; i < 6; i++) {
						if(resultArray[5] == resultArray[i])
							PokerTable[tableid][pkrWinners]++;
					}

					// Notify Table of Winner & Give Rewards
					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) {
							if(PokerTable[tableid][pkrWinners] > 1) {
								// Split
								if(resultArray[5] == GetPVarInt(playerid, "pkrResult")) {
									new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];

									SetPVarInt(playerid, "pkrWinner", 1);
									SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")+splitPot);

									PlayerPlaySound(playerid, 5821, 0.0, 0.0, 0.0);
								} else {
									PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
								}
							} else {
								// Single Winner
								if(resultArray[5] == GetPVarInt(playerid, "pkrResult")) {
									SetPVarInt(playerid, "pkrWinner", 1);
									SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")+PokerTable[tableid][pkrPot]);
									PokerTable[tableid][pkrWinnerID] = playerid;

									new winnerSoundID[] = {5847, 5848, 5849, 5854, 5855, 5856};
									new randomWinnerSoundID = random(sizeof(winnerSoundID));
									PlayerPlaySound(playerid, winnerSoundID[randomWinnerSoundID], 0.0, 0.0, 0.0);
								} else {
									PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
								}
							}
						}
					}
				}
			}

			// Game Loop
			if(PokerTable[tableid][pkrActive] == 3)
			{
				if(PokerTable[tableid][pkrActiveHands] == 1 && PokerTable[tableid][pkrRound] == 1) {
					PokerTable[tableid][pkrStage] = 0;
					PokerTable[tableid][pkrActive] = 4;
					PokerTable[tableid][pkrDelay] = 20+1;

					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) {
							if(GetPVarInt(playerid, "pkrActiveHand")) {
								SetPVarInt(playerid, "pkrHide", 1);
							}
						}
					}
				}

				// Delay Time Controller
				if(PokerTable[tableid][pkrDelay] > 0) {
					PokerTable[tableid][pkrDelay]--;
					if(PokerTable[tableid][pkrDelay] <= 5 && PokerTable[tableid][pkrDelay] > 0) {
						for(new i = 0; i < 6; i++) {
							new playerid = PokerTable[tableid][pkrSlot][i];

							if(playerid != -1) PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
						}
					}
				}

				// Assign Blinds & Active Player
				if(PokerTable[tableid][pkrRound] == 0 && PokerTable[tableid][pkrDelay] == 5)
				{
					for(new i = 0; i < 6; i++) {
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) {
							SetPVarInt(playerid, "pkrStatus", 1);
						}
					}

					PokerAssignBlinds(tableid);
				}

				// If no round active, start it.
				if(PokerTable[tableid][pkrRound] == 0 && PokerTable[tableid][pkrDelay] == 0)
				{
					PokerTable[tableid][pkrRound] = 1;

					for(new i = 0; i < 6; i++)
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1)
							SetPVarString(playerid, "pkrStatusString", " ");
					}

					// Shuffle Deck & Deal Cards & Allocate Community Cards
					PokerShuffleDeck(tableid);
					PokerDealHands(tableid);
					PokerRotateActivePlayer(tableid);
				}

				// Round Logic

				// Time Controller
				for(new i = 0; i < 6; i++)
				{
					new playerid = PokerTable[tableid][pkrSlot][i];

					if(playerid != -1)
					{
						if(GetPVarInt(playerid, "pkrActivePlayer")) {
							SetPVarInt(playerid, "pkrTime", GetPVarInt(playerid, "pkrTime")-1);
							if(GetPVarInt(playerid, "pkrTime") == 0) {
								new name[24];
								GetPlayerName(playerid, name, sizeof(name));

								if(GetPVarInt(playerid, "pkrActionChoice")) {
									DeletePVar(playerid, "pkrActionChoice");

									ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
								}

								PokerFoldHand(playerid);
								PokerRotateActivePlayer(tableid);
							}
						}
					}
				}
			}

			// Update GUI
			for(new i = 0; i < 6; i++)
			{
				new playerid = PokerTable[tableid][pkrSlot][i];
				new tmp, tmpString[128];

				// Set Textdraw Offset
				switch(i)
				{
					case 0: { tmp = 0; }
					case 1: { tmp = 5; }
					case 2: { tmp = 10; }
					case 3: { tmp = 15; }
					case 4: { tmp = 20; }
					case 5: { tmp = 25; }
				}

				if(playerid != -1)
				{
					// Name
					new name[MAX_PLAYER_NAME+1];
					GetPlayerName(playerid, name, sizeof(name));
					for(new td = 0; td < 6; td++) {
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1) PlayerTextDrawSetString(pid, PlayerPokerUI[pid][0+tmp], name);
					}

					// Chips
					if(GetPVarInt(playerid, "pkrChips") > 0) {
						format(tmpString, sizeof(tmpString), "$%d", GetPVarInt(playerid, "pkrChips"));
					} else {
						format(tmpString, sizeof(tmpString), "~r~$%d", GetPVarInt(playerid, "pkrChips"));
					}
					for(new td = 0; td < 6; td++) {
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1) PlayerTextDrawSetString(pid, PlayerPokerUI[pid][1+tmp], tmpString);
					}

					// Cards
					for(new td = 0; td < 6; td++) {
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1)
						{
							if(GetPVarInt(playerid, "pkrActiveHand"))
							{
								if(playerid != pid) {
									if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] <= 19 && GetPVarInt(playerid, "pkrHide") != 1) {
										format(tmpString, sizeof(tmpString), "%s", DeckTextdrw[GetPVarInt(playerid, "pkrCard1")+1]);
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], tmpString);
										format(tmpString, sizeof(tmpString), "%s", DeckTextdrw[GetPVarInt(playerid, "pkrCard2")+1]);
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], tmpString);
									} else {
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], DeckTextdrw[0]);
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], DeckTextdrw[0]);
									}
								} else {
									format(tmpString, sizeof(tmpString), "%s", DeckTextdrw[GetPVarInt(playerid, "pkrCard1")+1]);
									PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][2+tmp], tmpString);

									format(tmpString, sizeof(tmpString), "%s", DeckTextdrw[GetPVarInt(playerid, "pkrCard2")+1]);
									PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][3+tmp], tmpString);
								}
							} else {
								PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], " ");
								PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], " ");
							}
						}
					}

					// Status
					if(PokerTable[tableid][pkrActive] < 3) {
						format(tmpString, sizeof(tmpString), " ");
					} else if(GetPVarInt(playerid, "pkrActivePlayer") && PokerTable[tableid][pkrActive] == 3) {
						format(tmpString, sizeof(tmpString), "0:%d", GetPVarInt(playerid, "pkrTime"));
					} else {
						if(PokerTable[tableid][pkrActive] == 3 && PokerTable[tableid][pkrDelay] > 5) {
							SetPVarString(playerid, "pkrStatusString", " ");
						}

						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 19) {
							if(PokerTable[tableid][pkrWinners] == 1) {
								if(GetPVarInt(playerid, "pkrWinner")) {
									format(tmpString, sizeof(tmpString), "+$%d", PokerTable[tableid][pkrPot]);
									SetPVarString(playerid, "pkrStatusString", tmpString);
								} else {
									format(tmpString, sizeof(tmpString), "-$%d", GetPVarInt(playerid, "pkrCurrentBet"));
									SetPVarString(playerid, "pkrStatusString", tmpString);
								}
							} else {
								if(GetPVarInt(playerid, "pkrWinner")) {
									new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
									format(tmpString, sizeof(tmpString), "+$%d", splitPot);
									SetPVarString(playerid, "pkrStatusString", tmpString);
								} else {
									format(tmpString, sizeof(tmpString), "-$%d", GetPVarInt(playerid, "pkrCurrentBet"));
									SetPVarString(playerid, "pkrStatusString", tmpString);
								}
							}
						}

						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 19) {
							if(GetPVarInt(playerid, "pkrActiveHand") && GetPVarInt(playerid, "pkrHide") != 1) {
								new resultString[64];
								GetPVarString(playerid, "pkrResultString", resultString, 64);
								format(tmpString, sizeof(tmpString), "%s", resultString);
								SetPVarString(playerid, "pkrStatusString", resultString);
							}
						}

						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 10) {
							if(PokerTable[tableid][pkrWinners] == 1) {
								if(GetPVarInt(playerid, "pkrWinner")) {
									format(tmpString, sizeof(tmpString), "+$%d", PokerTable[tableid][pkrPot]);
									SetPVarString(playerid, "pkrStatusString", tmpString);
								} else {
									format(tmpString, sizeof(tmpString), "-$%d", GetPVarInt(playerid, "pkrCurrentBet"));
									SetPVarString(playerid, "pkrStatusString", tmpString);
								}
							} else {
								if(GetPVarInt(playerid, "pkrWinner")) {
									new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
									format(tmpString, sizeof(tmpString), "+$%d", splitPot);
									SetPVarString(playerid, "pkrStatusString", tmpString);
								} else {
									format(tmpString, sizeof(tmpString), "-$%d", GetPVarInt(playerid, "pkrCurrentBet"));
									SetPVarString(playerid, "pkrStatusString", tmpString);
								}
							}
						}

						GetPVarString(playerid, "pkrStatusString", tmpString, 128);
					}

					for(new td = 0; td < 6; td++) {
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1) PlayerTextDrawSetString(pid, PlayerPokerUI[pid][4+tmp], tmpString);
					}

					// Pot
					if(PokerTable[tableid][pkrDelay] > 0 && PokerTable[tableid][pkrActive] == 3) {
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");
					} else if(PokerTable[tableid][pkrActive] == 2) {
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");
					} else if(PokerTable[tableid][pkrActive] == 3) {
						format(tmpString, sizeof(tmpString), "Pot: $%d", PokerTable[tableid][pkrPot]);
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
					} else if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] < 19) {
						if(PokerTable[tableid][pkrWinnerID] != -1) {
							new winnerName[24];
							GetPlayerName(PokerTable[tableid][pkrWinnerID], winnerName, sizeof(winnerName));
							format(tmpString, sizeof(tmpString), "%s je osvojio $%d", winnerName, PokerTable[tableid][pkrPot]);
							if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
						} else if(PokerTable[tableid][pkrWinners] > 1) {
							new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
							format(tmpString, sizeof(tmpString), "%d pobjednika je osvojilo $%d", PokerTable[tableid][pkrWinners], splitPot);
							if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
						}
					} else {
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");
					}

					// Bet
					if(PokerTable[tableid][pkrDelay] > 0 && PokerTable[tableid][pkrActive] == 3) {
						format(tmpString, sizeof(tmpString), "Runda pocinje za ~r~%d~w~...", PokerTable[tableid][pkrDelay]);
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} else if(PokerTable[tableid][pkrActive] == 2) {
						format(tmpString, sizeof(tmpString), "Cekanje na igrace...", PokerTable[tableid][pkrPot]);
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} else if(PokerTable[tableid][pkrActive] == 3) {
						format(tmpString, sizeof(tmpString), "Ulog: $%d", PokerTable[tableid][pkrActiveBet]);
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} else if(PokerTable[tableid][pkrActive] == 4) {
						format(tmpString, sizeof(tmpString), "Runda zavrsava za ~r~%d~w~...", PokerTable[tableid][pkrDelay]);
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} else {
						if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], "Texas Holdem Poker");
					}

					// Community Cards
					switch(PokerTable[tableid][pkrStage]) {
						case 0: // Opening
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], "LD_CARD:cdback");
						}
						case 1: // Flop
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], DeckTextdrw[PokerTable[tableid][pkrCCards][0]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], DeckTextdrw[PokerTable[tableid][pkrCCards][1]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], DeckTextdrw[PokerTable[tableid][pkrCCards][2]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], "LD_CARD:cdback");
						}
						case 2: // Turn
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], DeckTextdrw[PokerTable[tableid][pkrCCards][0]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], DeckTextdrw[PokerTable[tableid][pkrCCards][1]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], DeckTextdrw[PokerTable[tableid][pkrCCards][2]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], DeckTextdrw[PokerTable[tableid][pkrCCards][3]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], "LD_CARD:cdback");
						}
						case 3: // River
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], DeckTextdrw[PokerTable[tableid][pkrCCards][0]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], DeckTextdrw[PokerTable[tableid][pkrCCards][1]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], DeckTextdrw[PokerTable[tableid][pkrCCards][2]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], DeckTextdrw[PokerTable[tableid][pkrCCards][3]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], DeckTextdrw[PokerTable[tableid][pkrCCards][4]+1]);
						}
						case 4: // Win
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], DeckTextdrw[PokerTable[tableid][pkrCCards][0]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], DeckTextdrw[PokerTable[tableid][pkrCCards][1]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], DeckTextdrw[PokerTable[tableid][pkrCCards][2]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], DeckTextdrw[PokerTable[tableid][pkrCCards][3]+1]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], DeckTextdrw[PokerTable[tableid][pkrCCards][4]+1]);
						}
					}
				} else {
					for(new td = 0; td < 6; td++) {
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1) {
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][0+tmp], " ");
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][1+tmp], " ");
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], " ");
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], " ");
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][4+tmp], " ");
						}
					}
				}
			}
		}
	}
	return 1;
}

CameraRadiusSetPos(playerid, Float:x, Float:y, Float:z, Float:degree = 0.0, Float:height = 3.0, Float:radius = 8.0)
{
	new Float:deltaToX = x + radius * floatsin(-degree, degrees);
	new Float:deltaToY = y + radius * floatcos(-degree, degrees);
	new Float:deltaToZ = z + height;

	SetPlayerCameraPos(playerid, deltaToX, deltaToY, deltaToZ);
	SetPlayerCameraLookAt(playerid, x, y, z);
}

GlobalPlaySound(soundid, Float:x, Float:y, Float:z)
{
	for(new i = 0; i < GetMaxPlayers(); i++) {
		if(IsPlayerInRangeOfPoint(i, 25.0, x, y, z)) {
			PlayerPlaySound(i, soundid, x, y, z);
		}
	}
}

PokerOptions(playerid, option)
{
	switch(option)
	{
		case 0:
		{
			DeletePVar(playerid, "pkrActionOptions");
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][40]);
		}
		case 1: // if(CurrentBet >= ActiveBet)
		{
			SetPVarInt(playerid, "pkrActionOptions", 1);
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][38], "RAISE");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][39], "CHECK");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][40], "FOLD");

			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][40]);
		}
		case 2: // if(CurrentBet < ActiveBet)
		{
			SetPVarInt(playerid, "pkrActionOptions", 2);
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][38], "CALL");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][39], "RAISE");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][40], "FOLD");

			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][40]);
		}
		case 3: // if(pkrChips < 1)
		{
			SetPVarInt(playerid, "pkrActionOptions", 3);

			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][38], "CHECK");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][39], "FOLD");

			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][39]);
		}
	}
}

PokerCallHand(playerid)
{
	ShowCasinoGamesMenu(playerid, DIALOG_CGAMESCALLPOKER);
}

PokerRaiseHand(playerid)
{
	ShowCasinoGamesMenu(playerid, DIALOG_CGAMESRAISEPOKER);
}

PokerCheckHand(playerid)
{
	if(GetPVarInt(playerid, "pkrActiveHand")) {
		SetPVarString(playerid, "pkrStatusString", "Check");
	}

	// Animation
	ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
}

PokerFoldHand(playerid)
{
	if(GetPVarInt(playerid, "pkrActiveHand")) {
		DeletePVar(playerid, "pkrCard1");
		DeletePVar(playerid, "pkrCard2");
		DeletePVar(playerid, "pkrActiveHand");
		DeletePVar(playerid, "pkrStatus");

		PokerTable[PlayingTableID[playerid]][pkrActiveHands]--;

		SetPVarString(playerid, "pkrStatusString", "Fold");

		// SFX
		GlobalPlaySound(5602, PokerTable[PlayingTableID[playerid]][pkrX], PokerTable[PlayingTableID[playerid]][pkrY], PokerTable[PlayingTableID[playerid]][pkrZ]);

		// Animation
		ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);
	}
}

PokerDealHands(tableid)
{
	new tmp = 0;

	// Loop through active players.
	for(new i = 0; i < 6; i++) {
		new playerid = PokerTable[tableid][pkrSlot][i];

		if(playerid != -1) {

			if(GetPVarInt(playerid, "pkrStatus") && GetPVarInt(playerid, "pkrChips") > 0) {
				SetPVarInt(playerid, "pkrCard1", PokerTable[tableid][pkrDeck][tmp]);
				SetPVarInt(playerid, "pkrCard2", PokerTable[tableid][pkrDeck][tmp+1]);

				SetPVarInt(playerid, "pkrActiveHand", 1);

				PokerTable[tableid][pkrActiveHands]++;

				// SFX
				PlayerPlaySound(playerid, 5602, 0.0, 0.0, 0.0);

				// Animation
				ApplyAnimation(playerid, "CASINO", "cards_in", 4.1, 0, 1, 1, 1, 1, 1);

				tmp += 2;
			}
		}
	}

	// Loop through community cards.
	for(new i = 0; i < 5; i++) {

		PokerTable[tableid][pkrCCards][i] = PokerTable[tableid][pkrDeck][tmp];
		tmp++;
	}
}

PokerShuffleDeck(tableid)
{
	// SFX
	GlobalPlaySound(5600, PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ]);

	// Order the deck
	for(new i = 0; i < 52; i++) {
		PokerTable[tableid][pkrDeck][i] = i;
	}

	// Randomize the array (AKA Shuffle Algorithm)
	new rand, tmp, i;
	for(i = 52; i > 1; i--) {
		rand = random(52) % i;
		tmp = PokerTable[tableid][pkrDeck][rand];
		PokerTable[tableid][pkrDeck][rand] = PokerTable[tableid][pkrDeck][i-1];
		PokerTable[tableid][pkrDeck][i-1] = tmp;
	}
}

PokerFindPlayerOrder(tableid, index)
{
	new tmpIndex = -1;
	for(new i = 0; i < 6; i++) {
		new playerid = PokerTable[tableid][pkrSlot][i];

		if(playerid != -1) {
			tmpIndex++;

			if(tmpIndex == index) {
				if(GetPVarInt(playerid, "pkrStatus") == 1)
					return playerid;
			}
		}
	}
	return -1;
}

PokerAssignBlinds(tableid)
{
	if(PokerTable[tableid][pkrPos] == 6) {
		PokerTable[tableid][pkrPos] = 0;
	}

	// Find where to start & distubute blinds.
	new bool:roomDealer = false, bool:roomBigBlind = false, bool:roomSmallBlind = false;

	// Find the Dealer.
	new tmpPos = PokerTable[tableid][pkrPos];
	while(roomDealer == false) {
		if(tmpPos == 6) {
			tmpPos = 0;
		}

		new playerid = PokerFindPlayerOrder(tableid, tmpPos);

		if(playerid != -1) {
			SetPVarInt(playerid, "pkrRoomDealer", 1);
			SetPVarString(playerid, "pkrStatusString", "Dealer");
			roomDealer = true;
		} else {
			tmpPos++;
		}
	}

	// Find the player after the Dealer.
	tmpPos = PokerTable[tableid][pkrPos];
	while(roomBigBlind == false) {
		if(tmpPos == 6) {
			tmpPos = 0;
		}

		new playerid = PokerFindPlayerOrder(tableid, tmpPos);

		if(playerid != -1) {
			if(GetPVarInt(playerid, "pkrRoomDealer") != 1 && GetPVarInt(playerid, "pkrRoomBigBlind") != 1 && GetPVarInt(playerid, "pkrRoomSmallBlind") != 1) {
				SetPVarInt(playerid, "pkrRoomBigBlind", 1);
				new tmpString[128];
				format(tmpString, sizeof(tmpString), "~r~BB -$%d", PokerTable[tableid][pkrBlind]);
				SetPVarString(playerid, "pkrStatusString", tmpString);
				roomBigBlind = true;

				if(GetPVarInt(playerid, "pkrChips") < PokerTable[tableid][pkrBlind]) {
					PokerTable[tableid][pkrPot] += GetPVarInt(playerid, "pkrChips");
					SetPVarInt(playerid, "pkrChips", 0);
				} else {
					PokerTable[tableid][pkrPot] += PokerTable[tableid][pkrBlind];
					SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")-PokerTable[tableid][pkrBlind]);
				}

				SetPVarInt(playerid, "pkrCurrentBet", PokerTable[tableid][pkrBlind]);
				PokerTable[tableid][pkrActiveBet] = PokerTable[tableid][pkrBlind];

			} else {
				tmpPos++;
			}
		} else {
			tmpPos++;
		}
	}

	// Small Blinds are active only if there are more than 2 players.
	if(PokerTable[tableid][pkrActivePlayers] > 2) {

		// Find the player after the Big Blind.
		tmpPos = PokerTable[tableid][pkrPos];
		while(roomSmallBlind == false) {
			if(tmpPos == 6) {
				tmpPos = 0;
			}

			new playerid = PokerFindPlayerOrder(tableid, tmpPos);

			if(playerid != -1) {
				if(GetPVarInt(playerid, "pkrRoomDealer") != 1 && GetPVarInt(playerid, "pkrRoomBigBlind") != 1 && GetPVarInt(playerid, "pkrRoomSmallBlind") != 1) {
					SetPVarInt(playerid, "pkrRoomSmallBlind", 1);
					new tmpString[128];
					format(tmpString, sizeof(tmpString), "~r~SB -$%d", PokerTable[tableid][pkrBlind]/2);
					SetPVarString(playerid, "pkrStatusString", tmpString);
					roomSmallBlind = true;

					if(GetPVarInt(playerid, "pkrChips") < (PokerTable[tableid][pkrBlind]/2)) {
						PokerTable[tableid][pkrPot] += GetPVarInt(playerid, "pkrChips");
						SetPVarInt(playerid, "pkrChips", 0);
					} else {
						PokerTable[tableid][pkrPot] += (PokerTable[tableid][pkrBlind]/2);
						SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")-(PokerTable[tableid][pkrBlind]/2));
					}

					SetPVarInt(playerid, "pkrCurrentBet", PokerTable[tableid][pkrBlind]/2);
					PokerTable[tableid][pkrActiveBet] = PokerTable[tableid][pkrBlind]/2;
				} else {
					tmpPos++;
				}
			} else {
				tmpPos++;
			}
		}
	}
	PokerTable[tableid][pkrPos]++;
}

PokerRotateActivePlayer(tableid)
{
	if(PokerTable[tableid][pkrActivePlayers] <= 1)
		return 1;

	new nextactiveid = -1, lastapid = -1, lastapslot = -1;
	if(PokerTable[tableid][pkrActivePlayerID] != -1)
	{
		lastapid = PokerTable[tableid][pkrActivePlayerID];
		for(new i = 0; i < 6; i++)
		{
			if(PokerTable[tableid][pkrSlot][i] == lastapid)
				lastapslot = i;
		}

		DeletePVar(lastapid, "pkrActivePlayer");
		DeletePVar(lastapid, "pkrTime");

		PokerOptions(lastapid, 0);
	}

	// New Round Init Block
	if(PokerTable[tableid][pkrRotations] == 0 && lastapid == -1 && lastapslot == -1) {

		// Find & Assign ActivePlayer to Dealer
		for(new i = 0; i < 6; i++) {
			new playerid = PokerTable[tableid][pkrSlot][i];

			if(GetPVarInt(playerid, "pkrRoomDealer") == 1 && playerid != -1) {
				nextactiveid = playerid;
				PokerTable[tableid][pkrActivePlayerID] = playerid;
				PokerTable[tableid][pkrActivePlayerSlot] = i;
				PokerTable[tableid][pkrRotations]++;
				PokerTable[tableid][pkrSlotRotations] = i;
			}
		}
	}
	else if(PokerTable[tableid][pkrRotations] >= 6)
	{
		PokerTable[tableid][pkrRotations] = 0;
		PokerTable[tableid][pkrStage]++;

		PokerTable[tableid][pkrActiveBet] = 0;
		for(new s = 0; s < 6; s++)
		{
			if(PokerTable[tableid][pkrSlot][s] != -1)
				SetPVarInt(PokerTable[tableid][pkrSlot][s], "pkrCurrentBet", 0);
		}

		if(PokerTable[tableid][pkrStage] > 3) {
			PokerTable[tableid][pkrActive] = 4;
			PokerTable[tableid][pkrDelay] = 20+1;
			return 1;
		}

		PokerTable[tableid][pkrSlotRotations]++;
		if(PokerTable[tableid][pkrSlotRotations] >= 6) {
			PokerTable[tableid][pkrSlotRotations] -= 6;
		}

		new playerid = PokerFindPlayerOrder(tableid, PokerTable[tableid][pkrSlotRotations]);

		if(playerid != -1) {
			nextactiveid = playerid;
			PokerTable[tableid][pkrActivePlayerID] = playerid;
			PokerTable[tableid][pkrActivePlayerSlot] = PokerTable[tableid][pkrSlotRotations];
			PokerTable[tableid][pkrRotations]++;
		} else {
			PokerTable[tableid][pkrRotations]++;
			PokerRotateActivePlayer(tableid);
			return 1;
		}
	}
	else
	{
		PokerTable[tableid][pkrSlotRotations]++;
		if(PokerTable[tableid][pkrSlotRotations] >= 6) {
			PokerTable[tableid][pkrSlotRotations] -= 6;
		}

		new playerid = PokerFindPlayerOrder(tableid, PokerTable[tableid][pkrSlotRotations]);

		if(playerid != -1)
		{
			if( (GetPVarInt(playerid, "pkrCurrentBet") < PokerTable[tableid][pkrActiveBet] && PokerTable[tableid][pkrActiveBet] != 0) || (GetPVarInt(playerid, "pkrCurrentBet") == PokerTable[tableid][pkrActiveBet] && PokerTable[tableid][pkrActiveBet] == 0) )
			{
				nextactiveid = playerid;
				PokerTable[tableid][pkrActivePlayerID] = playerid;
				PokerTable[tableid][pkrActivePlayerSlot] = PokerTable[tableid][pkrSlotRotations];
				PokerTable[tableid][pkrRotations]++;
			}
			else
			{
				PokerTable[tableid][pkrRotations]++;
				PokerRotateActivePlayer(tableid);
				return 1;
			}
		}
		else
		{
			PokerTable[tableid][pkrRotations]++;
			PokerRotateActivePlayer(tableid);
			return 1;
		}
	}

	if(nextactiveid != -1) {
		if(GetPVarInt(nextactiveid, "pkrActiveHand")) {
			new currentBet = GetPVarInt(nextactiveid, "pkrCurrentBet");
			new activeBet = PokerTable[tableid][pkrActiveBet];

			new apSoundID[] = {5809, 5810};
			new randomApSoundID = random(sizeof(apSoundID));
			PlayerPlaySound(nextactiveid, apSoundID[randomApSoundID], 0.0, 0.0, 0.0);

			if(GetPVarInt(nextactiveid, "pkrChips") < 1) {
				PokerOptions(nextactiveid, 3);
			} else if(currentBet >= activeBet) {
				PokerOptions(nextactiveid, 1);
			} else if (currentBet < activeBet) {
				PokerOptions(nextactiveid, 2);
			} else {
				PokerOptions(nextactiveid, 0);
			}

			SetPVarInt(nextactiveid, "pkrTime", 60);
			SetPVarInt(nextactiveid, "pkrActivePlayer", 1);
		}
	}
	return 1;
}

InitPokerTables()
{
	for(new i = 0; i < MAX_POKERTABLES; i++) {
		PokerTable[i][pkrSQL] = -1;
		PokerTable[i][pkrActive] = 0;
		PokerTable[i][pkrPlaced] = 0;
		PokerTable[i][pkrObjectID] = 0;

		for(new c = 0; c < MAX_POKERTABLEMISCOBJS; c++) {
			PokerTable[i][pkrMiscObjectID][c] = 0;
		}

		for(new s = 0; s < 6; s++) {
			PokerTable[i][pkrSlot][s] = -1;
		}

		PokerTable[i][pkrX] = 0.0;
		PokerTable[i][pkrY] = 0.0;
		PokerTable[i][pkrZ] = 0.0;
		PokerTable[i][pkrRX] = 0.0;
		PokerTable[i][pkrRY] = 0.0;
		PokerTable[i][pkrRZ] = 0.0;
		PokerTable[i][pkrVW] = 0;
		PokerTable[i][pkrInt] = 0;
		PokerTable[i][pkrPlayers] = 0;
		PokerTable[i][pkrLimit] = 6;
		PokerTable[i][pkrBuyInMax] = 1000;
		PokerTable[i][pkrBuyInMin] = 500;
		PokerTable[i][pkrBlind] = 100;
		PokerTable[i][pkrPos] = 0;
		PokerTable[i][pkrRound] = 0;
		PokerTable[i][pkrStage] = 0;
		PokerTable[i][pkrActiveBet] = 0;
		PokerTable[i][pkrSetDelay] = 15;
		PokerTable[i][pkrActivePlayerID] = -1;
		PokerTable[i][pkrActivePlayerSlot] = -1;
		PokerTable[i][pkrRotations] = 0;
		PokerTable[i][pkrSlotRotations] = 0;
		PokerTable[i][pkrWinnerID] = -1;
		PokerTable[i][pkrWinners] = 0;
		PokerTable[i][pkrPulseTimer] = false;
	}
	LoadPokerTables();
	return 1;
}

LoadPokerTables()
{
	new loadQuery[64];
	format(loadQuery, 64, "SELECT * FROM poker_tables");
	mysql_tquery(g_SQL, loadQuery, "OnPokerTablesLoaded", "");
	return 1;
}

Function: OnPokerTablesLoaded()
{
	new rows = cache_num_rows();
	if(!rows) return 1;
	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(i,	"sqlid"	, PokerTable[i][pkrSQL]);
		cache_get_value_name_float(i,  "X"	, PokerTable[i][pkrX]);
		cache_get_value_name_float(i,  "Y"	, PokerTable[i][pkrY]);
		cache_get_value_name_float(i,  "Z"	, PokerTable[i][pkrZ]);
		cache_get_value_name_float(i,  "RX"	, PokerTable[i][pkrRX]);
		cache_get_value_name_float(i,  "RY"	, PokerTable[i][pkrRY]);
		cache_get_value_name_float(i,  "RZ"	, PokerTable[i][pkrRZ]);
		cache_get_value_name_int(i,	"virtualworld", PokerTable[i][pkrVW]);
		cache_get_value_name_int(i,	"interior"			, PokerTable[i][pkrInt]);

		PlacePokerTable(i, 1, PokerTable[i][pkrX], PokerTable[i][pkrY], PokerTable[i][pkrZ], PokerTable[i][pkrRX], PokerTable[i][pkrRY], PokerTable[i][pkrRZ], PokerTable[i][pkrVW], PokerTable[i][pkrInt]);
	}
	return 1;
}

SavePokerTable(idx)
{
	if(PokerTable[idx][pkrSQL] == -1)
	{
		new insertQuery[ 256 ];
		format(insertQuery, sizeof(insertQuery), "INSERT INTO poker_tables (X, Y, Z, RX, RY, RZ, virtualworld, interior) VALUES ('%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d')",
			PokerTable[idx][pkrX],
			PokerTable[idx][pkrY],
			PokerTable[idx][pkrZ],
			PokerTable[idx][pkrRX],
			PokerTable[idx][pkrRY],
			PokerTable[idx][pkrRZ],
			PokerTable[idx][pkrVW],
			PokerTable[idx][pkrInt]
		);
		mysql_tquery( g_SQL, insertQuery, "OnPokerTableInsert", "i", idx);
	}
	else
	{
		new updateQuery[ 256 ];
		format(updateQuery, sizeof(updateQuery), "UPDATE poker_tables SET X = '%f', Y = '%f', Z = '%f', RX = '%f', RY = '%f', RZ = '%f', virtualworld = '%d', interior = '%d' WHERE sqlid = '%d'",
			PokerTable[idx][pkrX],
			PokerTable[idx][pkrY],
			PokerTable[idx][pkrZ],
			PokerTable[idx][pkrRX],
			PokerTable[idx][pkrRY],
			PokerTable[idx][pkrRZ],
			PokerTable[idx][pkrVW],
			PokerTable[idx][pkrInt],
			PokerTable[idx][pkrSQL]
		);
		mysql_tquery( g_SQL, updateQuery, "", "" );
	}
	return 1;
}

Function: OnPokerTableInsert(tableid)
{
	PokerTable[tableid][pkrSQL] = cache_insert_id();
	return 1;
}

ResetPokerRound(tableid)
{
	PokerTable[tableid][pkrRound] = 0;
	PokerTable[tableid][pkrStage] = 0;
	PokerTable[tableid][pkrActiveBet] = 0;
	PokerTable[tableid][pkrActive] = 2;
	PokerTable[tableid][pkrDelay] = PokerTable[tableid][pkrSetDelay];
	PokerTable[tableid][pkrPot] = 0;
	PokerTable[tableid][pkrRotations] = 0;
	PokerTable[tableid][pkrSlotRotations] = 0;
	PokerTable[tableid][pkrWinnerID] = -1;
	PokerTable[tableid][pkrWinners] = 0;

	// Reset Player Variables
	for(new i = 0; i < 6; i++) {
		new playerid = PokerTable[tableid][pkrSlot][i];

		if(playerid != -1) {
			DeletePVar(playerid, "pkrWinner");
			DeletePVar(playerid, "pkrRoomBigBlind");
			DeletePVar(playerid, "pkrRoomSmallBlind");
			DeletePVar(playerid, "pkrRoomDealer");
			DeletePVar(playerid, "pkrCard1");
			DeletePVar(playerid, "pkrCard2");
			DeletePVar(playerid, "pkrActivePlayer");
			DeletePVar(playerid, "pkrTime");

			if(GetPVarInt(playerid, "pkrActiveHand")) {
				PokerTable[tableid][pkrActiveHands]--;

				// Animation
				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);
			}

			DeletePVar(playerid, "pkrActiveHand");
			DeletePVar(playerid, "pkrCurrentBet");
			DeletePVar(playerid, "pkrResultString");
			DeletePVar(playerid, "pkrHide");
		}
	}

	return 1;
}
ResetPokerTable(tableid)
{
	new szString[32];
	format(szString, sizeof(szString), "");
	strmid(PokerTable[tableid][pkrPass], szString, 0, strlen(szString), 64);

	PokerTable[tableid][pkrActive] = 0;
	PokerTable[tableid][pkrLimit] = 6;
	PokerTable[tableid][pkrBuyInMax] = 1000;
	PokerTable[tableid][pkrBuyInMin] = 500;
	PokerTable[tableid][pkrBlind] = 100;
	PokerTable[tableid][pkrPos] = 0;
	PokerTable[tableid][pkrRound] = 0;
	PokerTable[tableid][pkrStage] = 0;
	PokerTable[tableid][pkrActiveBet] = 0;
	PokerTable[tableid][pkrDelay] = 0;
	PokerTable[tableid][pkrPot] = 0;
	PokerTable[tableid][pkrSetDelay] = 15;
	PokerTable[tableid][pkrRotations] = 0;
	PokerTable[tableid][pkrSlotRotations] = 0;
	PokerTable[tableid][pkrWinnerID] = -1;
	PokerTable[tableid][pkrWinners] = 0;
	PokerTable[tableid][pkrPulseTimer] = false;

	return 1;
}

ResetPokerTableEnum(tableid)
{
	new szString[32];
	format(szString, sizeof(szString), "");
	strmid(PokerTable[tableid][pkrPass], szString, 0, strlen(szString), 32);

	PokerTable[tableid][pkrSQL] = -1;
	PokerTable[tableid][pkrActive] = 0;
	PokerTable[tableid][pkrPlaced] = 0;
	PokerTable[tableid][pkrObjectID] = 0;

	for(new c = 0; c < MAX_POKERTABLEMISCOBJS; c++) {
		PokerTable[tableid][pkrMiscObjectID][c] = 0;
	}

	for(new s = 0; s < 6; s++) {
		PokerTable[tableid][pkrSlot][s] = -1;
	}

	PokerTable[tableid][pkrX] = 0.0;
	PokerTable[tableid][pkrY] = 0.0;
	PokerTable[tableid][pkrZ] = 0.0;
	PokerTable[tableid][pkrRX] = 0.0;
	PokerTable[tableid][pkrRY] = 0.0;
	PokerTable[tableid][pkrRZ] = 0.0;
	PokerTable[tableid][pkrVW] = 0;
	PokerTable[tableid][pkrInt] = 0;
	PokerTable[tableid][pkrPlayers] = 0;
	PokerTable[tableid][pkrActivePlayers] = 0;
	PokerTable[tableid][pkrLimit] = 6;
	PokerTable[tableid][pkrBuyInMax] = 1000;
	PokerTable[tableid][pkrBuyInMin] = 500;
	PokerTable[tableid][pkrBlind] = 100;
	PokerTable[tableid][pkrPos] = 0;
	PokerTable[tableid][pkrRound] = 0;
	PokerTable[tableid][pkrStage] = 0;
	PokerTable[tableid][pkrActiveBet] = 0;
	PokerTable[tableid][pkrSetDelay] = 15;
	PokerTable[tableid][pkrActivePlayerID] = -1;
	PokerTable[tableid][pkrActivePlayerSlot] = -1;
	PokerTable[tableid][pkrRotations] = 0;
	PokerTable[tableid][pkrSlotRotations] = 0;
	PokerTable[tableid][pkrWinnerID] = -1;
	PokerTable[tableid][pkrWinners] = 0;

	return 1;
}

CreatePokerGUI(playerid)
{
	PlayerPokerUI[playerid][0] = CreatePlayerTextDraw(playerid, 390.000000, 263.000000, " "); // Seat 2 (SEAT 1)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][0], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][0], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][0], 0);

	PlayerPokerUI[playerid][1] = CreatePlayerTextDraw(playerid, 389.000000, 273.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][1], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][1], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][1], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][1], 0);

	PlayerPokerUI[playerid][2] = CreatePlayerTextDraw(playerid, 369.000000, 286.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][2], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][2], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][2], 20.000000, 33.000000);

	PlayerPokerUI[playerid][3] = CreatePlayerTextDraw(playerid, 392.000000, 286.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][3], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][3], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][3], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][3], 20.000000, 33.000000);

	PlayerPokerUI[playerid][4] = CreatePlayerTextDraw(playerid, 391.000000, 319.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][4], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][4], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][4], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][4], 0);

	PlayerPokerUI[playerid][5] = CreatePlayerTextDraw(playerid, 250.000000, 263.000000, " "); // Seat 1 (SEAT 2)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][5], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][5], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][5], 0.159999, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][5], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][5], 0);

	PlayerPokerUI[playerid][6] = CreatePlayerTextDraw(playerid, 250.000000, 273.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][6], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][6], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][6], 0.159999, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][6], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][6], 0);

	PlayerPokerUI[playerid][7] = CreatePlayerTextDraw(playerid, 229.000000, 286.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][7], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][7], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][7], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][7], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][7], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][7], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][7], 20.000000, 33.000000);

	PlayerPokerUI[playerid][8] = CreatePlayerTextDraw(playerid, 252.000000, 286.000000, " ");
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][8], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][8], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][8], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][8], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][8], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][8], 20.000000, 33.000000);

	PlayerPokerUI[playerid][9] = CreatePlayerTextDraw(playerid, 250.000000, 319.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][9], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][9], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][9], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][9], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][9], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][9], 0);

	PlayerPokerUI[playerid][10] = CreatePlayerTextDraw(playerid, 199.000000, 190.000000, " "); // Seat 6 (SEAT 3)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][10], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][10], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][10], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][10], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][10], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][10], 0);

	PlayerPokerUI[playerid][11] = CreatePlayerTextDraw(playerid, 199.000000, 199.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][11], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][11], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][11], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][11], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][11], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][11], 0);

	PlayerPokerUI[playerid][12] = CreatePlayerTextDraw(playerid, 179.000000, 212.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][12], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][12], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][12], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][12], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][12], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][12], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][12], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][12], 20.000000, 33.000000);

	PlayerPokerUI[playerid][13] = CreatePlayerTextDraw(playerid, 202.000000, 212.000000, " ");
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][13], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][13], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][13], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][13], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][13], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][13], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][13], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][13], 20.000000, 33.000000);

	PlayerPokerUI[playerid][14] = CreatePlayerTextDraw(playerid, 200.000000, 245.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][14], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][14], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][14], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][14], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][14], 0);

	PlayerPokerUI[playerid][15] = CreatePlayerTextDraw(playerid, 250.000000, 116.000000, " ");  // Seat 5 (SEAT 4)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][15], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][15], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][15], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][15], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][15], 0);

	PlayerPokerUI[playerid][16] = CreatePlayerTextDraw(playerid, 250.000000, 126.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][16], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][16], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][16], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][16], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][16], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][16], 0);

	PlayerPokerUI[playerid][17] = CreatePlayerTextDraw(playerid, 229.000000, 139.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][17], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][17], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][17], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][17], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][17], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][17], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][17], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][17], 20.000000, 33.000000);

	PlayerPokerUI[playerid][18] = CreatePlayerTextDraw(playerid, 252.000000, 139.000000, " ");
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][18], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][18], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][18], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][18], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][18], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][18], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][18], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][18], 20.000000, 33.000000);

	PlayerPokerUI[playerid][19] = CreatePlayerTextDraw(playerid, 250.000000, 172.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][19], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][19], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][19], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][19], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][19], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][19], 0);

	PlayerPokerUI[playerid][20] = CreatePlayerTextDraw(playerid, 390.000000, 116.000000, " "); // Seat 4 (SEAT 5)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][20], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][20], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][20], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][20], 0.159997, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][20], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][20], 0);

	PlayerPokerUI[playerid][21] = CreatePlayerTextDraw(playerid, 389.000000, 126.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][21], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][21], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][21], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][21], 0.159997, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][21], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][21], 0);

	PlayerPokerUI[playerid][22] = CreatePlayerTextDraw(playerid, 369.000000, 139.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][22], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][22], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][22], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][22], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][22], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][22], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][22], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][22], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][22], 20.000000, 33.000000);

	PlayerPokerUI[playerid][23] = CreatePlayerTextDraw(playerid, 392.000000, 139.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][23], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][23], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][23], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][23], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][23], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][23], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][23], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][23], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][23], 20.000000, 33.000000);

	PlayerPokerUI[playerid][24] = CreatePlayerTextDraw(playerid, 391.000000, 172.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][24], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][24], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][24], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][24], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][24], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][24], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][24], 0);

	PlayerPokerUI[playerid][25] = CreatePlayerTextDraw(playerid, 443.000000, 190.000000, " "); // Seat 3 (SEAT 6)
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][25], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][25], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][25], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][25], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][25], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][25], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][25], 0);

	PlayerPokerUI[playerid][26] = CreatePlayerTextDraw(playerid, 442.000000, 199.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][26], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][26], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][26], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][26], 0.159998, 1.200001);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][26], 16711935);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][26], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][26], 0);

	PlayerPokerUI[playerid][27] = CreatePlayerTextDraw(playerid, 422.000000, 212.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][27], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][27], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][27], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][27], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][27], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][27], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][27], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][27], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][27], 20.000000, 33.000000);

	PlayerPokerUI[playerid][28] = CreatePlayerTextDraw(playerid, 445.000000, 212.000000, " ");
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][28], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][28], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][28], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][28], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][28], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][28], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][28], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][28], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][28], 20.000000, 33.000000);

	PlayerPokerUI[playerid][29] = CreatePlayerTextDraw(playerid, 444.000000, 245.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][29], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][29], 100);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][29], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][29], 0.180000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][29], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][29], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][29], 0);

	PlayerPokerUI[playerid][30] = CreatePlayerTextDraw(playerid, 265.000000, 205.000000, "New Textdraw"); // Community Card Box
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][30], 0);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][30], 1);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][30], 0.539999, 2.099998);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][30], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][30], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][30], 100);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][30], 375.000000, 71.000000);

	PlayerPokerUI[playerid][31] = CreatePlayerTextDraw(playerid, 266.000000, 208.000000, "LD_CARD:cdback");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][31], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][31], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][31], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][31], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][31], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][31], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][31], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][31], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][31], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][31], 20.000000, 33.000000);

	PlayerPokerUI[playerid][32] = CreatePlayerTextDraw(playerid, 288.000000, 208.000000, "LD_CARD:cdback");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][32], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][32], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][32], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][32], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][32], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][32], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][32], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][32], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][32], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][32], 20.000000, 33.000000);

	PlayerPokerUI[playerid][33] = CreatePlayerTextDraw(playerid, 310.000000, 208.000000, "LD_CARD:cdback");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][33], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][33], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][33], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][33], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][33], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][33], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][33], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][33], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][33], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][33], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][33], 20.000000, 33.000000);

	PlayerPokerUI[playerid][34] = CreatePlayerTextDraw(playerid, 332.000000, 208.000000, "LD_CARD:cdback");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][34], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][34], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][34], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][34], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][34], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][34], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][34], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][34], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][34], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][34], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][34], 20.000000, 33.000000);

	PlayerPokerUI[playerid][35] = CreatePlayerTextDraw(playerid, 354.000000, 208.000000, "LD_CARD:cdback");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][35], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][35], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][35], 4);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][35], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][35], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][35], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][35], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][35], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][35], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][35], 255);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][35], 20.000000, 33.000000);

	PlayerPokerUI[playerid][36] = CreatePlayerTextDraw(playerid, 320.000000, 193.000000, "New Textdraw");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][36], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][36], 0);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][36], 1);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][36], 0.500000, 0.399999);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][36], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][36], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][36], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][36], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][36], 50);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][36], 390.000000, 110.000000);

	PlayerPokerUI[playerid][37] = CreatePlayerTextDraw(playerid, 318.000000, 191.000000, "Texas Holdem Poker");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][37], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][37], -1);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][37], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][37], 0.199999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][37], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][37], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][37], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][37], 0);

	PlayerPokerUI[playerid][38] = CreatePlayerTextDraw(playerid, 321.000000, 268.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][38], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][38], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][38], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][38], 0.189999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][38], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][38], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][38], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][38], 45);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][38], 10.000000, 26.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerUI[playerid][38], 1);

	PlayerPokerUI[playerid][39] = CreatePlayerTextDraw(playerid, 321.000000, 284.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][39], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][39], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][39], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][39], 0.189999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][39], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][39], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][39], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][39], 45);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][39], 10.000000, 26.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerUI[playerid][39], 1);

	PlayerPokerUI[playerid][40] = CreatePlayerTextDraw(playerid, 321.000000, 300.000000, " ");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][40], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][40], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][40], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][40], 0.189999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][40], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][40], 1);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][40], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][40], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][40], 45);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][40], 10.000000, 26.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerUI[playerid][40], 1);

	PlayerPokerUI[playerid][41] = CreatePlayerTextDraw(playerid, 318.000000, 120.000000, "NAPUSTI");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][41], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][41], 255);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][41], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][41], 0.189999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][41], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][41], 1);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][41], 1);
	PlayerTextDrawUseBox(playerid, PlayerPokerUI[playerid][41], 1);
	PlayerTextDrawBoxColor(playerid, PlayerPokerUI[playerid][41], 45);
	PlayerTextDrawTextSize(playerid, PlayerPokerUI[playerid][41], 10.000000, 36.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerPokerUI[playerid][41], 1);

	PlayerPokerUI[playerid][42] = CreatePlayerTextDraw(playerid, 318.000000, 245.000000, "Texas Holdem Poker");
	PlayerTextDrawAlignment(playerid, PlayerPokerUI[playerid][42], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerPokerUI[playerid][42], -1);
	PlayerTextDrawFont(playerid, PlayerPokerUI[playerid][42], 2);
	PlayerTextDrawLetterSize(playerid, PlayerPokerUI[playerid][42], 0.199999, 1.200000);
	PlayerTextDrawColor(playerid, PlayerPokerUI[playerid][42], -1);
	PlayerTextDrawSetOutline(playerid, PlayerPokerUI[playerid][42], 0);
	PlayerTextDrawSetProportional(playerid, PlayerPokerUI[playerid][42], 1);
	PlayerTextDrawSetShadow(playerid, PlayerPokerUI[playerid][42], 0);
}

ShowPokerGUI(playerid, guitype)
{
	switch(guitype)
	{
		case GUI_POKER_TABLE:
		{
			SetPVarInt(playerid, "pkrTableGUI", 1);
			for(new i = 0; i < MAX_PLAYERPOKERUI; i++) {
				PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][i]);
			}
		}
	}
}

DestroyPokerGUI(playerid)
{
	for(new i = 0; i < MAX_PLAYERPOKERUI; i++) {
		PlayerTextDrawDestroy(playerid, PlayerPokerUI[playerid][i]);
	}
}

PlacePokerTable(tableid, skipmisc, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, virtualworld, interior)
{
	PokerTable[tableid][pkrPlaced] = 1;
	PokerTable[tableid][pkrX] = x;
	PokerTable[tableid][pkrY] = y;
	PokerTable[tableid][pkrZ] = z;
	PokerTable[tableid][pkrRX] = rx;
	PokerTable[tableid][pkrRY] = ry;
	PokerTable[tableid][pkrRZ] = rz;
	PokerTable[tableid][pkrVW] = virtualworld;
	PokerTable[tableid][pkrInt] = interior;
	PokerTable[tableid][pkrPlayers] = 0;
	PokerTable[tableid][pkrLimit] = 6;

	for(new s = 0; s < 6; s++)
		PokerTable[tableid][pkrSlot][s] = -1;

	// Create Table
	if(IsValidDynamicObject(PokerTable[tableid][pkrObjectID]))
		DestroyDynamicObject(PokerTable[tableid][pkrObjectID]);

	PokerTable[tableid][pkrObjectID] = CreateDynamicObject(OBJ_POKER_TABLE, x, y, z, rx, ry, rz, virtualworld, interior, -1, DRAWDISTANCE_POKER_TABLE);

	if(skipmisc != 0) {
	}

	// Create 3D Text Label
	new tmpString[256];
	format(tmpString, sizeof(tmpString), "Poker stol\n\n Buy-In Maximum/Minimum: {00FF00}$%d/{00FF00}$%d\n\n[/poker play]", PokerTable[tableid][pkrBuyInMax], PokerTable[tableid][pkrBuyInMin]);
	if( !IsValidDynamic3DTextLabel(PokerTable[tableid][pkrText3DID]) )
		PokerTable[tableid][pkrText3DID] = CreateDynamic3DTextLabel(tmpString, COLOR_YELLOW, PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ], 25.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID, 0, PokerTable[tableid][pkrVW], PokerTable[tableid][pkrInt], -1);
	else
	{
		DestroyDynamic3DTextLabel(PokerTable[tableid][pkrText3DID]);
		PokerTable[tableid][pkrText3DID] = CreateDynamic3DTextLabel(tmpString, COLOR_YELLOW, PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ], 25.0, INVALID_PLAYER_ID,INVALID_VEHICLE_ID, 0, PokerTable[tableid][pkrVW], PokerTable[tableid][pkrInt], -1);
	}
	if(!Iter_Contains(PokerTables, tableid))
		Iter_Add(PokerTables, tableid);
	SavePokerTable(tableid);

	return PokerTable[tableid][pkrObjectID];
}

DestroyPokerTable(tableid)
{
	if(PokerTable[tableid][pkrPlaced] == 1) {

		// Delete Table
		if(IsValidDynamicObject(PokerTable[tableid][pkrObjectID]))
			DestroyDynamicObject(PokerTable[tableid][pkrObjectID]);

		// Delete 3D Text Label
		if( IsValidDynamic3DTextLabel(PokerTable[tableid][pkrText3DID]) )
			DestroyDynamic3DTextLabel(PokerTable[tableid][pkrText3DID]);

		// Delete Misc Obj
		for(new c = 0; c < MAX_POKERTABLEMISCOBJS; c++) {
			if(IsValidObject(PokerTable[tableid][pkrMiscObjectID][c])) DestroyObject(PokerTable[tableid][pkrMiscObjectID][c]);
		}
	}

	for(new s = 0; s < 6; s++)
		PokerTable[tableid][pkrSlot][s] = -1;

	Iter_Remove(PokerTables, tableid);
	RemovePokerTable(tableid);
	PokerTable[tableid][pkrSQL] = -1;
	return tableid;
}

RemovePokerTable(tableid)
{
	new destroyQuery[ 128 ];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM poker_tables WHERE `sqlid` = '%d'", PokerTable[ tableid ][ pkrSQL ]);
	mysql_tquery(g_SQL, destroyQuery, "");
	return 1;
}

JoinPokerTable(playerid, tableid)
{
	// Check if there is room for the player
	if(PokerTable[tableid][pkrPlayers] < PokerTable[tableid][pkrLimit])
	{
		// Check if table is not joinable.
		if(PokerTable[tableid][pkrActive] == 1)
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Stol se jos uvijek postavlja, molimo pokusajte kasnije!");
			return 1;
		}
		// Find an open seat
		for(new s = 0; s < 6; s++)
		{
			if(PokerTable[tableid][pkrSlot][s] == -1)
			{
				UpdateDynamic3DTextLabelText(PokerTable[tableid][pkrText3DID], COLOR_YELLOW, " ");

				PlayingTableID[playerid] = tableid;
				PlayingTableSlot[playerid] = s;

				// Occuply Slot
				PokerTable[tableid][pkrPlayers] += 1;
				PokerTable[tableid][pkrSlot][s] = playerid;

				// Check & Start Game Loop if Not Active
				if(PokerTable[tableid][pkrPlayers] == 1) {

					// Player is Room Creator
					SetPVarInt(playerid, "pkrRoomLeader", 1);
					ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);

					PokerTable[tableid][pkrActive] = 1; // Warmup Phase
					PokerTable[tableid][pkrPulseTimer] = true;
				}
				else
				{ // Execute code for Non-Room Creators
					ShowCasinoGamesMenu(playerid, DIALOG_CGAMESBUYINPOKER);
					SelectTextDraw(playerid, COLOR_YELLOW);
				}

				CameraRadiusSetPos(playerid, PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ], 90.0, 4.7, 0.1);

				new Float:tmpPos[3];
				GetPlayerPos(playerid, tmpPos[0], tmpPos[1], tmpPos[2]);

				SetPVarFloat(playerid, "pkrTableJoinX", tmpPos[0]);
				SetPVarFloat(playerid, "pkrTableJoinY", tmpPos[1]);
				SetPVarFloat(playerid, "pkrTableJoinZ", tmpPos[2]);

				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);
				TogglePlayerControllable(playerid, 0);
				SetPlayerPosObjectOffset(PokerTable[tableid][pkrObjectID], playerid, PokerTableMiscObjOffsets[s][0], PokerTableMiscObjOffsets[s][1], PokerTableMiscObjOffsets[s][2]);
				SetPlayerFacingAngle(playerid, PokerTableMiscObjOffsets[s][5]+90.0);
				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);

				// Create GUI
				CreatePokerGUI(playerid);
				ShowPokerGUI(playerid, GUI_POKER_TABLE);

				// Hide Action Bar
				PokerOptions(playerid, 0);

				return 1;
			}
		}
	}
	else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Sva mjesta su za ovim stolom popunjena! (%d / %d)", PokerTable[tableid][pkrPlayers], PokerTable[tableid][pkrLimit]);
	return 1;
}

DoesHavePokerTablePerm(playerid, tableid)
{
	if( Bit16_Get( gr_PlayerInHouse, playerid ) != INVALID_HOUSE_ID && Bit16_Get( gr_PlayerInHouse, playerid ) >= 0 )
	{
		new houseid = Bit16_Get( gr_PlayerInHouse, playerid );
		if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID] && HouseInfo[houseid][hInt] == PokerTable[tableid][pkrInt] && HouseInfo[houseid][hVirtualWorld] == PokerTable[tableid][pkrVW])
			return 1;
	}
	else if( Bit16_Get( gr_PlayerInBiznis, playerid ) != INVALID_BIZNIS_ID && Bit16_Get( gr_PlayerInBiznis, playerid ) < MAX_BIZZS)
	{
		new bizzid = Bit16_Get( gr_PlayerInBiznis, playerid );
		if( (BizzInfo[bizzid][bOwnerID] == PlayerInfo[playerid][pSQLID] || BizzInfo[bizzid][bco_OwnerID] == PlayerInfo[playerid][pSQLID]) && BizzInfo[bizzid][bInterior] == PokerTable[tableid][pkrInt] && BizzInfo[bizzid][bVirtualWorld] == PokerTable[tableid][pkrVW])
			return 1;
	}
	return 0;
}

DetectPokerTable(playerid)
{
	foreach(new i: PokerTables)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, PokerTable[i][pkrX], PokerTable[i][pkrY], PokerTable[i][pkrZ]))
			return i;
	}
	return -1;
}

CountHousePokerTables(houseid)
{
	new tablecount = 0;
	foreach(new t: PokerTables)
	{
		if(HouseInfo[houseid][hInt] == PokerTable[t][pkrInt] && HouseInfo[houseid][hVirtualWorld] == PokerTable[t][pkrVW])
			tablecount++;
	}
	return tablecount;
}

GetPokerTableLimit(playerid)
{
	if( Bit16_Get( gr_PlayerInHouse, playerid ) != INVALID_HOUSE_ID && Bit16_Get( gr_PlayerInHouse, playerid ) >= 0 )
	{
		new houseid = Bit16_Get( gr_PlayerInHouse, playerid );
		if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID])
		{
			new tableCount = CountHousePokerTables(houseid);
			switch(PlayerInfo[playerid][pDonateRank])
			{
				case 0:
				{
					if(tableCount < PREMIUM_NONE_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_NONE_POKER_TABLES);
				}
				case 1:
				{
					if(tableCount < PREMIUM_BRONZE_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_BRONZE_POKER_TABLES);
				}
				case 2:
				{
					if(tableCount < PREMIUM_SILVER_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_SILVER_POKER_TABLES);
				}
				case 3:
				{
					if(tableCount < PREMIUM_GOLD_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_GOLD_POKER_TABLES);
				}
				case 4:
				{
					if(tableCount < PREMIUM_PLATINUM_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_PLATINUM_POKER_TABLES);
				}
			}
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vlasnik kuce u kojoj se nalazite!");
	}
	else if( Bit16_Get( gr_PlayerInBiznis, playerid ) != INVALID_BIZNIS_ID && Bit16_Get( gr_PlayerInBiznis, playerid ) < MAX_BIZZS)
	{
		new bizzid = Bit16_Get( gr_PlayerInBiznis, playerid );
		if( (BizzInfo[bizzid][bOwnerID] == PlayerInfo[playerid][pSQLID] || BizzInfo[bizzid][bco_OwnerID] == PlayerInfo[playerid][pSQLID]) && BizzInfo[bizzid][bType] == BIZZ_TYPE_CASINO)
			return 1;
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vlasnik/suvlasnik kasina / biznis nije kasino!");
	}
	return 0;
}

LeavePokerTable(playerid)
{
	new tableid = PlayingTableID[playerid];
	if(!Iter_Contains(PokerTables, tableid))
		return 1;

	// SFX
	new leaveSoundID[2] = {5852, 5853};
	new randomLeaveSoundID = random(sizeof(leaveSoundID));
	PlayerPlaySound(playerid, leaveSoundID[randomLeaveSoundID], 0.0, 0.0, 0.0);

	// De-occuply Slot
	PokerTable[tableid][pkrPlayers] -= 1;
	if(GetPVarInt(playerid, "pkrStatus"))
		PokerTable[tableid][pkrActivePlayers] -= 1;
	if(PokerTable[tableid][pkrActivePlayerID] == playerid)
		PokerTable[tableid][pkrActivePlayerID] = -1;
	PokerTable[tableid][pkrSlot][PlayingTableSlot[playerid]] = -1;

	// Check & Stop the Game Loop if No Players at the Table
	if(PokerTable[tableid][pkrPlayers] == 1)
	{
		for(new i = 0; i < 6; i++)
		{
			if(PokerTable[tableid][pkrSlot][i] != -1)
				LeavePokerTable(PokerTable[tableid][pkrSlot][i]);
		}
	}

	if(PokerTable[tableid][pkrPlayers] == 0)
	{
		SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")+PokerTable[tableid][pkrPot]);

		new tmpString[128];
		format(tmpString, sizeof(tmpString), "Poker stol\n\n Buy-In Maximum/Minimum: {00FF00}$%d/{00FF00}$%d\n\n[/poker play]", PokerTable[tableid][pkrBuyInMax], PokerTable[tableid][pkrBuyInMin]);
		UpdateDynamic3DTextLabelText(PokerTable[tableid][pkrText3DID], COLOR_YELLOW, tmpString);

		PokerTable[tableid][pkrPulseTimer] = false;
		ResetPokerTable(tableid);
	}

	if(PokerTable[tableid][pkrRound] == 0 && PokerTable[tableid][pkrDelay] < 5) {
		ResetPokerRound(tableid);
	}

	// Convert prkChips to money
	AC_GivePlayerMoney(playerid, GetPVarInt(playerid, "pkrChips"));

	SetPlayerPos(playerid, GetPVarFloat(playerid, "pkrTableJoinX"), GetPVarFloat(playerid, "pkrTableJoinY"), GetPVarFloat(playerid, "pkrTableJoinZ")+0.1);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
	CancelSelectTextDraw(playerid);

	if(GetPVarInt(playerid, "pkrActiveHand")) {
		PokerTable[tableid][pkrActiveHands]--;
	}

	// Destroy Poker Memory
	PlayingTableID[playerid] = -1;
	PlayingTableSlot[playerid] = -1;

	DeletePVar(playerid, "pkrWinner");
	DeletePVar(playerid, "pkrCurrentBet");
	DeletePVar(playerid, "pkrChips");
	DeletePVar(playerid, "pkrTableJoinX");
	DeletePVar(playerid, "pkrTableJoinY");
	DeletePVar(playerid, "pkrTableJoinZ");
	DeletePVar(playerid, "pkrStatus");
	DeletePVar(playerid, "pkrRoomLeader");
	DeletePVar(playerid, "pkrRoomBigBlind");
	DeletePVar(playerid, "pkrRoomSmallBlind");
	DeletePVar(playerid, "pkrRoomDealer");
	DeletePVar(playerid, "pkrCard1");
	DeletePVar(playerid, "pkrCard2");
	DeletePVar(playerid, "pkrActivePlayer");
	DeletePVar(playerid, "pkrActiveHand");
	DeletePVar(playerid, "pkrHide");

	// Destroy GUI
	DestroyPokerGUI(playerid);

	// Delay Exit Call
	SetTimerEx("PokerExit", 250, false, "d", playerid);

	return 1;
}

ShowCasinoGamesMenu(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_CGAMESCALLPOKER:
		{
			if(GetPVarInt(playerid, "pkrChips") > 0) {
				SetPVarInt(playerid, "pkrActionChoice", 1);

				new tableid = PlayingTableID[playerid];
				new actualBet = PokerTable[tableid][pkrActiveBet]-GetPVarInt(playerid, "pkrCurrentBet");

				new szString[128];
				if(actualBet > GetPVarInt(playerid, "pkrChips")) {
					format(szString, sizeof(szString), "Jeste li sigurni da zelite pratiti zvanje za $%d (All-In)?:", actualBet);
					return ShowPlayerDialog(playerid, DIALOG_CGAMESCALLPOKER, DIALOG_STYLE_MSGBOX, "Texas Holdem Poker - (Call)", szString, "All-In", "Cancel");
				}
				format(szString, sizeof(szString), "Jeste li sigurni da zelite pratiti zvanje za $%d?:", actualBet);
				return ShowPlayerDialog(playerid, DIALOG_CGAMESCALLPOKER, DIALOG_STYLE_MSGBOX, "Texas Holdem Poker - (Call)", szString, "Call", "Cancel");
			} else {
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "DEALER: Nemate dovoljno novaca da bi pratili zvanje.");
				new noFundsSoundID[] = {5823, 5824, 5825};
				new randomNoFundsSoundID = random(sizeof(noFundsSoundID));
				PlayerPlaySound(playerid, noFundsSoundID[randomNoFundsSoundID], 0.0, 0.0, 0.0);
			}
		}
		case DIALOG_CGAMESRAISEPOKER:
		{
			new tableid = PlayingTableID[playerid];

			SetPVarInt(playerid, "pkrActionChoice", 1);

			if(GetPVarInt(playerid, "pkrCurrentBet")+GetPVarInt(playerid, "pkrChips") > PokerTable[tableid][pkrActiveBet]+PokerTable[tableid][pkrBlind]/2) {
				SetPVarInt(playerid, "pkrActionChoice", 1);

				new szString[128];
				format(szString, sizeof(szString), "Za koji iznos zelite dignuti ulog? ($%d-$%d):", PokerTable[tableid][pkrActiveBet]+PokerTable[tableid][pkrBlind]/2, GetPVarInt(playerid, "pkrCurrentBet")+GetPVarInt(playerid, "pkrChips"));
				return ShowPlayerDialog(playerid, DIALOG_CGAMESRAISEPOKER, DIALOG_STYLE_INPUT, "Texas Holdem Poker - (Raise)", szString, "Raise", "Cancel");
			} else if(GetPVarInt(playerid, "pkrCurrentBet")+GetPVarInt(playerid, "pkrChips") == PokerTable[tableid][pkrActiveBet]+PokerTable[tableid][pkrBlind]/2) {
				SetPVarInt(playerid, "pkrActionChoice", 1);

				new szString[128];
				format(szString, sizeof(szString), "Za koji iznos zelite dignuti ulog? (All-In):", PokerTable[tableid][pkrActiveBet]+PokerTable[tableid][pkrBlind]/2, GetPVarInt(playerid, "pkrCurrentBet")+GetPVarInt(playerid, "pkrChips"));
				return ShowPlayerDialog(playerid, DIALOG_CGAMESRAISEPOKER, DIALOG_STYLE_INPUT, "Texas Holdem Poker - (Raise)", szString, "All-In", "Cancel");
			} else {
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "DEALER: Nemate dovoljno novaca da bi dignuli ulog.");
				new noFundsSoundID[] = {5823, 5824, 5825};
				new randomNoFundsSoundID = random(sizeof(noFundsSoundID));
				PlayerPlaySound(playerid, noFundsSoundID[randomNoFundsSoundID], 0.0, 0.0, 0.0);
			}

		}
		case DIALOG_CGAMESBUYINPOKER:
		{
			new szString[386];
			format(szString, sizeof(szString), "Molimo Vas unesite Buy-In iznos za stol:\n\nTrenutno vasih Poker Chipova: {00FF00}$%d\nBuy-In Maximum/Minimum: {00FF00}$%d/{00FF00}$%d", GetPVarInt(playerid, "pkrChips"), PokerTable[PlayingTableID[playerid]][pkrBuyInMax], PokerTable[PlayingTableID[playerid]][pkrBuyInMin]);
			return ShowPlayerDialog(playerid, DIALOG_CGAMESBUYINPOKER, DIALOG_STYLE_INPUT, "Poker - (Buy-In Menu)", szString, "Buy In", "Leave");
		}
		case DIALOG_CGAMESSETUPPOKER:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
			{
				if(!GetPokerTableLimit(playerid))
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci/kasinu!");

				return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPOKER, DIALOG_STYLE_LIST, "Poker - (Setup Poker Minigame)", "Postavljanje stola...", "Odabir", "Natrag");
			}
			else return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPOKER, DIALOG_STYLE_LIST, "Poker - (Setup Poker Minigame)", "Promjena polozaja stola...\nBrisanje stola...", "Odabir", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			new szString[512];

			if(PokerTable[tableid][pkrPass][0] == EOS)
			{
				format(szString, sizeof(szString), "Buy-In Max\t({00FF00}$%d)\nBuy-In Min\t({00FF00}$%d)\nBlind\t\t({00FF00}$%d / {00FF00}$%d)\nLimit\t\t(%d)\nPassword\t(%s)\nPauza izmedju rundi\t(%d)\nPocetak igre",
					PokerTable[tableid][pkrBuyInMax],
					PokerTable[tableid][pkrBuyInMin],
					PokerTable[tableid][pkrBlind],
					PokerTable[tableid][pkrBlind]/2,
					PokerTable[tableid][pkrLimit],
					"None",
					PokerTable[tableid][pkrSetDelay]
				);
			}
			else
			{
				format(szString, sizeof(szString), "Buy-In Max\t({00FF00}$%d)\nBuy-In Min\t({00FF00}$%d)\nBlind\t\t({00FF00}$%d / {00FF00}$%d)\nLimit\t\t(%d)\nPassword\t(%s)\nPauza izmedju rundi\t(%d)\nPocetak igre",
					PokerTable[tableid][pkrBuyInMax],
					PokerTable[tableid][pkrBuyInMin],
					PokerTable[tableid][pkrBlind],
					PokerTable[tableid][pkrBlind]/2,
					PokerTable[tableid][pkrLimit],
					PokerTable[tableid][pkrPass],
					PokerTable[tableid][pkrSetDelay]
				);
			}
			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME, DIALOG_STYLE_LIST, "Poker - (Postavljanje igre)", szString, "Odabir", "Izlaz");
		}
		case DIALOG_CGAMESSETUPPGAME2:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME2, DIALOG_STYLE_INPUT, "Poker - (Buy-In Max)", "Molimo Vas postavite Buy-In Max iznos:", "Promjeni", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME3:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME3, DIALOG_STYLE_INPUT, "Poker - (Buy-In Min)", "Molimo Vas postavite Buy-In Min iznos:", "Promjeni", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME4:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME4, DIALOG_STYLE_INPUT, "Poker - (Blindovi)", "Molimo Vas unesite Blindove:\n\nNote: Mali blindovi su automatski polovica velikog blinda.", "Promjeni", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME5:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME5, DIALOG_STYLE_INPUT, "Poker - (Limit igraca)", "Molimo Vas unesite limit broja igraca (2-6):", "Promjeni", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME6:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME6, DIALOG_STYLE_INPUT, "Poker - (Password)", "Molimo Vas unesite Password:\n[!]: Ostavite praznim ukoliko ne zelite lozinku za pridruzivanje!", "Promjeni", "Natrag");
		}
		case DIALOG_CGAMESSETUPPGAME7:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu poker stola!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME7, DIALOG_STYLE_INPUT, "Poker - (Round Delay)", "Molimo Vas unesite duljinu pauze izmedju dvije runde (15-120sec):", "Promjeni", "Natrag");
		}
	}
	return 1;
}

CMD:poker(playerid, params[])
{
	new pick[10];
	if( sscanf( params, "s[10] ", pick ) ) return SendClientMessage( playerid, -1, "KORISTENJE /poker [ play / leave / table ]");

	if( !strcmp(pick, "play", true) )
	{
		if(PlayingTableID[playerid] == -1)
		{
			foreach(new t: PokerTables)
			{
				if(IsPlayerInRangeOfPoint(playerid, 5.0, PokerTable[t][pkrX], PokerTable[t][pkrY], PokerTable[t][pkrZ]))
				{
					if(PokerTable[t][pkrPass][0] != EOS)
					{
						new password[32];
						if( sscanf( params, "s[10]s[32]", pick, password ) )
							return SendClientMessage( playerid, -1, "KORISTENJE /poker play [password]");
						if(!strcmp(password, PokerTable[t][pkrPass], false, 32))
							return JoinPokerTable(playerid, t);
					}
					else return JoinPokerTable(playerid, t);
				}
			}
		}
		else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec igrate poker za stolom! Morate koristiti /poker leave da odlazak iz trenutne igre!");
	}
	if( !strcmp(pick, "leave", true) )
		return LeavePokerTable(playerid);

	if( !strcmp(pick, "table", true) )
		return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPOKER);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	PlayingTableID[playerid] = -1;
	PlayingTableSlot[playerid] = -1;
	CancelSelectTextDraw(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	LeavePokerTable(playerid);
	return 1;
}

Function: PokerTableEdit(playerid, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(GetPVarFloat(playerid, "tmpPkrX") != 0.0)
	{
		SetDynamicObjectPos(objectid, fX, fY, fZ);
		SetDynamicObjectRot(objectid, fRotX, fRotY, fRotZ);

		if(response == EDIT_RESPONSE_FINAL)
		{
			if(GetPVarType(playerid, "tmpEditPokerTableID"))
			{
				new tableid = GetPVarInt(playerid, "tmpEditPokerTableID");

				PlacePokerTable(tableid, 1, fX, fY, fZ, fRotX, fRotY, fRotZ, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

				DeletePVar(playerid, "tmpEditPokerTableID");
				DeletePVar(playerid, "tmpPkrX");
				DeletePVar(playerid, "tmpPkrY");
				DeletePVar(playerid, "tmpPkrZ");
				DeletePVar(playerid, "tmpPkrRX");
				DeletePVar(playerid, "tmpPkrRY");
				DeletePVar(playerid, "tmpPkrRZ");

				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili poker stol! Koristite /poker play da bi zapoceli sa igrom.");
			}
			return 1;
		}

		if(response == EDIT_RESPONSE_CANCEL)
		{
			if(GetPVarType(playerid, "tmpEditPokerTableID"))
			{
				new tableid = GetPVarInt(playerid, "tmpEditPokerTableID");

				PlacePokerTable(tableid, 0, GetPVarFloat(playerid, "tmpPkrX"), GetPVarFloat(playerid, "tmpPkrY"), GetPVarFloat(playerid, "tmpPkrZ"), GetPVarFloat(playerid, "tmpPkrRX"), GetPVarFloat(playerid, "tmpPkrRY"), GetPVarFloat(playerid, "tmpPkrRZ"), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

				DeletePVar(playerid, "tmpEditPokerTableID");
				DeletePVar(playerid, "tmpPkrX");
				DeletePVar(playerid, "tmpPkrY");
				DeletePVar(playerid, "tmpPkrZ");
				DeletePVar(playerid, "tmpPkrRX");
				DeletePVar(playerid, "tmpPkrRY");
				DeletePVar(playerid, "tmpPkrRZ");
			}
			return 1;
		}
	}
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(Text:INVALID_TEXT_DRAW == clickedid && PlayingTableID[playerid] != -1)
		LeavePokerTable(playerid);

	return 1;
}

Function: PokerTextDrawCheck(playerid, PlayerText:playertextid)
{
	new tableid = PlayingTableID[playerid];

    if(playertextid == PlayerPokerUI[playerid][38])
    {
         switch(GetPVarInt(playerid, "pkrActionOptions"))
		 {
			case 1: // Raise
			{
				PokerRaiseHand(playerid);
				PokerTable[tableid][pkrRotations] = 0;
			}
			case 2: // Call
			{
				PokerCallHand(playerid);
			}
			case 3: // Check
			{
				PokerCheckHand(playerid);
				PokerRotateActivePlayer(tableid);
			}
		 }
    }
	if(playertextid == PlayerPokerUI[playerid][39])
    {
		switch(GetPVarInt(playerid, "pkrActionOptions"))
		{
			case 1: // Check
			{
				PokerCheckHand(playerid);
				PokerRotateActivePlayer(tableid);
			}
			case 2: // Raise
			{
				PokerRaiseHand(playerid);
				PokerTable[tableid][pkrRotations] = 0;
			}
			case 3: // Fold
			{
				PokerFoldHand(playerid);
				PokerRotateActivePlayer(tableid);
			}
		}
    }
	if(playertextid == PlayerPokerUI[playerid][40])
    {
         switch(GetPVarInt(playerid, "pkrActionOptions"))
		{
			case 1: // Fold
			{
				PokerFoldHand(playerid);
				PokerRotateActivePlayer(tableid);
			}
			case 2: // Fold
			{
				PokerFoldHand(playerid);
				PokerRotateActivePlayer(tableid);
			}
		}
    }
	if(playertextid == PlayerPokerUI[playerid][41]) // LEAVE
		LeavePokerTable(playerid);

    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_CGAMESSETUPPOKER:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
				{
					if(!GetPokerTableLimit(playerid))
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci/kasinu!");

					tableid = Iter_Free(PokerTables);
					ResetPokerTable(tableid);
				}
				if(PokerTable[tableid][pkrPlaced] == 0)
				{
					switch(listitem)
					{
						case 0: // Place Poker Table
						{
							DeletePVar(playerid, "tmpPlacePokerTable");

							new Float:x, Float:y, Float:z;
							GetPlayerPos(playerid, x, y, z);

							PokerTable[tableid][pkrObjectID] = PlacePokerTable(tableid, 0, x, y, z+2.0, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

							SetPVarFloat(playerid, "tmpPkrX", PokerTable[tableid][pkrX]);
							SetPVarFloat(playerid, "tmpPkrY", PokerTable[tableid][pkrY]);
							SetPVarFloat(playerid, "tmpPkrZ", PokerTable[tableid][pkrZ]);
							SetPVarFloat(playerid, "tmpPkrRX", PokerTable[tableid][pkrRX]);
							SetPVarFloat(playerid, "tmpPkrRY", PokerTable[tableid][pkrRY]);
							SetPVarFloat(playerid, "tmpPkrRZ", PokerTable[tableid][pkrRZ]);

							SetPVarInt(playerid, "tmpEditPokerTableID", tableid);
							EditDynamicObject(playerid, PokerTable[tableid][pkrObjectID]);

							SendClientMessage(playerid, COLOR_WHITE, "Postavio si stol za poker, sada namjesti njegovu poziciju/rotaciju.");
							SendClientMessage(playerid, COLOR_WHITE, "Pritisni '{3399FF}~k~~PED_SPRINT~' da bi pomicao kameru.");
						}
					}
				}
				else
				{
					if(!DoesHavePokerTablePerm(playerid, tableid))
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate permisije nad ovim poker stolom!");

					switch(listitem)
					{
						case 0: // Edit Poker Table
						{
							SetPVarFloat(playerid, "tmpPkrX", PokerTable[tableid][pkrX]);
							SetPVarFloat(playerid, "tmpPkrY", PokerTable[tableid][pkrY]);
							SetPVarFloat(playerid, "tmpPkrZ", PokerTable[tableid][pkrZ]);
							SetPVarFloat(playerid, "tmpPkrRX", PokerTable[tableid][pkrRX]);
							SetPVarFloat(playerid, "tmpPkrRY", PokerTable[tableid][pkrRY]);
							SetPVarFloat(playerid, "tmpPkrRZ", PokerTable[tableid][pkrRZ]);

							SetPVarInt(playerid, "tmpEditPokerTableID", tableid);
							EditDynamicObject(playerid, PokerTable[tableid][pkrObjectID]);
							SendClientMessage(playerid, COLOR_YELLOW, "Namjestite zeljenu poziciju poker stola!");
						}
						case 1: // Destroy Poker Table
						{
							if(PokerTable[tableid][pkrActive] > 0)
								return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Poker stol je aktivan, ne mozete ga obrisati dok ima igraca!");
							DestroyPokerTable(tableid);
							ResetPokerTableEnum(tableid);
							SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste izbrisali poker stol.");
						}
					}
				}
			}
		}
		case DIALOG_CGAMESSETUPPGAME:
		{
			if(response) {
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");

				switch(listitem)
				{
					case 0: // Buy-In Max
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME2);
					case 1: // Buy-In Min
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME3);
					case 2: // Blind
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME4);
					case 3: // Limit
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME5);
					case 4: // Password
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME6);
					case 5: // Round Delay
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME7);
					case 6: // Play Poker
						ShowCasinoGamesMenu(playerid, DIALOG_CGAMESBUYINPOKER);
				}
			}
			else LeavePokerTable(playerid);
		}
		case DIALOG_CGAMESSETUPPGAME2:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");

			if(response)
			{
				if(strval(inputtext) < 1 || strval(inputtext) > 1000000000) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME2);
				}

				if(strval(inputtext) <= PokerTable[tableid][pkrBuyInMin]) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME2);
				}

				PokerTable[tableid][pkrBuyInMax] = strval(inputtext);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			} else {
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
		}
		case DIALOG_CGAMESSETUPPGAME3:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");

				if(strval(inputtext) < 1 || strval(inputtext) > 1000000000) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME3);
				}

				if(strval(inputtext) >= PokerTable[tableid][pkrBuyInMax]) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME3);
				}

				PokerTable[tableid][pkrBuyInMin] = strval(inputtext);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			} else {
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
		}
		case DIALOG_CGAMESSETUPPGAME4:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");

				if(strval(inputtext) < 1 || strval(inputtext) > 1000000000) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME4);
				}

				PokerTable[tableid][pkrBlind] = strval(inputtext);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			} else {
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
		}
		case DIALOG_CGAMESSETUPPGAME5:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");
				if(strval(inputtext) < 2 || strval(inputtext) > 6) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME5);
				}

				PokerTable[tableid][pkrLimit] = strval(inputtext);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			} else {
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
		}
		case DIALOG_CGAMESSETUPPGAME6:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");

				strmid(PokerTable[tableid][pkrPass], inputtext, 0, strlen(inputtext), 32);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			} else {
				ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
		}
		case DIALOG_CGAMESSETUPPGAME7:
		{
			if(response)
			{
				new tableid = DetectPokerTable(playerid);
				if(tableid == -1)
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu Poker stola!");
				if(strval(inputtext) < 15 || strval(inputtext) > 120) {
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME7);
				}

				PokerTable[tableid][pkrSetDelay] = strval(inputtext);
				return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
			}
			else return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESSETUPPGAME);
		}
		case DIALOG_CGAMESBUYINPOKER:
		{
			if(response) {
				if(strval(inputtext) < 1)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Buy-In ne moze biti manji od 1$!");
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESBUYINPOKER);
				}
				if(strval(inputtext) < PokerTable[PlayingTableID[playerid]][pkrBuyInMin] || strval(inputtext) > PokerTable[PlayingTableID[playerid]][pkrBuyInMax] || strval(inputtext) > AC_GetPlayerMoney(playerid))
				{
					SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Unijeli ste premali/preveliki Buy-In/nemate %d$!", strval(inputtext));
					return ShowCasinoGamesMenu(playerid, DIALOG_CGAMESBUYINPOKER);
				}

				PokerTable[PlayingTableID[playerid]][pkrActivePlayers]++;
				SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")+strval(inputtext));
				AC_GivePlayerMoney(playerid, -strval(inputtext));


				if(PokerTable[PlayingTableID[playerid]][pkrActive] == 3 && PokerTable[PlayingTableID[playerid]][pkrRound] == 0 && PokerTable[PlayingTableID[playerid]][pkrDelay] >= 6) {
					SetPVarInt(playerid, "pkrStatus", 1);
				}
				else if(PokerTable[PlayingTableID[playerid]][pkrActive] < 3) {
					SetPVarInt(playerid, "pkrStatus", 1);
				}

				if(PokerTable[PlayingTableID[playerid]][pkrActive] == 1 && GetPVarInt(playerid, "pkrRoomLeader")) {
					PokerTable[PlayingTableID[playerid]][pkrActive] = 2;
					SelectTextDraw(playerid, COLOR_YELLOW);
				}
			}
			else LeavePokerTable(playerid);
		}
		case DIALOG_CGAMESCALLPOKER:
		{
			if(response) {
				new tableid = PlayingTableID[playerid];

				new actualBet = PokerTable[tableid][pkrActiveBet]-GetPVarInt(playerid, "pkrCurrentBet");

				if(actualBet > GetPVarInt(playerid, "pkrChips")) {
					PokerTable[tableid][pkrPot] += GetPVarInt(playerid, "pkrChips");
					SetPVarInt(playerid, "pkrChips", 0);
					SetPVarInt(playerid, "pkrCurrentBet", PokerTable[tableid][pkrActiveBet]);
				} else {
					PokerTable[tableid][pkrPot] += actualBet;
					SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")-actualBet);
					SetPVarInt(playerid, "pkrCurrentBet", PokerTable[tableid][pkrActiveBet]);
				}

				SetPVarString(playerid, "pkrStatusString", "Call");
				PokerRotateActivePlayer(tableid);

				ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
			}

			DeletePVar(playerid, "pkrActionChoice");
		}
		case DIALOG_CGAMESRAISEPOKER:
		{
			if(response) {
				new tableid = PlayingTableID[playerid];

				new actualRaise = strval(inputtext)-GetPVarInt(playerid, "pkrCurrentBet");

				if(strval(inputtext) >= PokerTable[tableid][pkrActiveBet]+PokerTable[tableid][pkrBlind]/2 && strval(inputtext) <= GetPVarInt(playerid, "pkrCurrentBet")+GetPVarInt(playerid, "pkrChips")) {
					PokerTable[tableid][pkrPot] += actualRaise;
					PokerTable[tableid][pkrActiveBet] = strval(inputtext);
					SetPVarInt(playerid, "pkrChips", GetPVarInt(playerid, "pkrChips")-actualRaise);
					SetPVarInt(playerid, "pkrCurrentBet", PokerTable[tableid][pkrActiveBet]);

					SetPVarString(playerid, "pkrStatusString", "Raise");

					PokerTable[tableid][pkrRotations] = 0;
					PokerRotateActivePlayer(tableid);

					ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
				} else {
					ShowCasinoGamesMenu(playerid, DIALOG_CGAMESRAISEPOKER);
				}
			}

			DeletePVar(playerid, "pkrActionChoice");
		}
	}
	return 1;
}

