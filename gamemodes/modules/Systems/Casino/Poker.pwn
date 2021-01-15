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

		  Developed By Dan 'GhoulSlayeR' Reed | Rewritten by Logan
			     mrdanreed@gmail.com 

===========================================================
This software was written for the sole purpose to not be
destributed without written permission from the software
developer.

Changelog:

1.1.0 - Updated Release
===========================================================

*/

#include <YSI_Coding\y_hooks>

// Card rank = (array index % 13) | Card native index = 4 * rank + suit
#define GetCardNativeIndex(%0) 			((4*((%0) % 13))+_:CardData[(%0)][E_CARD_SUIT])

native calculate_hand_worth(const hands[], count = sizeof(hands));


// Objects
#define OBJ_POKER_TABLE 					19474

// Player Poker Table Limits
#define PREMIUM_NONE_POKER_TABLES			1
#define PREMIUM_BRONZE_POKER_TABLES			2
#define PREMIUM_SILVER_POKER_TABLES			3
#define PREMIUM_GOLD_POKER_TABLES			4
#define PREMIUM_PLATINUM_POKER_TABLES		5

// Poker Misc
#define MAX_POKERTABLES 					100
#define MAX_POKERTABLEMISCOBJS				6
#define MAX_PLAYERPOKERUI					43
#define DRAWDISTANCE_POKER_TABLE 			150.0
#define DRAWDISTANCE_POKER_MISC 			50.0
#define CAMERA_POKER_INTERPOLATE_SPEED		5000 // ms (longer = slower)

// High Card Enumerator
#define	ROYAL_FLUSH			0
#define	FLUSH				1
#define	FOUR_KIND			2
#define	STRAIGHT			3
#define	THREE_KIND			4
#define	TWO_PAIR			5
#define	ONE_PAIR			6
#define	HIGH_CARD			7

static
	 Iterator: PokerTables <MAX_POKERTABLES>;

static 
	PlayerText:PlayerPokerUI[MAX_PLAYERS][MAX_PLAYERPOKERUI];

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
static 
	PokerTable[MAX_POKERTABLES][pkrInfo];

static 
	Float:PokerTableMiscObjOffsets[MAX_POKERTABLEMISCOBJS][6] = {
{-1.25, -0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 2)
{-1.25, 0.470, 0.1, 0.0, 0.0, 180.0}, // (Slot 1)
{0.01, 1.85, 0.1, 0.0, 0.0, 90.0},  // (Slot 6)
{1.25, 0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 5)
{1.25, -0.470, 0.1, 0.0, 0.0, 0.0}, // (Slot 4)
{-0.01, -1.85, 0.1, 0.0, 0.0, -90.0} // (Slot 3)
};

static 
	const HAND_RANKS[][] =
{
	{"Undefined"}, //will never occur
	{"High Card"},
	{"Pair"},
	{"Two Pair"},
	{"Three of a Kind"},
	{"Straight"},
	{"Flush"},
	{"Full House"},
	{"Four of a Kind"},
	{"Straight Flush"},
	{"Royal Flush"}
};
enum E_CARD_SUITS
{
	SUIT_SPADES,
	SUIT_HEARTS,
	SUIT_CLUBS,
	SUIT_DIAMONDS
};

enum E_CARD_DATA
{
	E_CARD_TEXTDRAW[48],
	E_CARD_NAME[48],
	E_CARD_SUITS:E_CARD_SUIT,
	E_CARD_RANK
};
static 
	const CardData[ 52 ] [E_CARD_DATA] = {

	//Spades
    {"LD_CARD:cd2s", 		"Two of Spades", 		SUIT_SPADES,		0},
    {"LD_CARD:cd3s", 		"Three of Spades", 		SUIT_SPADES,		1},
    {"LD_CARD:cd4s", 		"Four of Spades", 		SUIT_SPADES,		2},
    {"LD_CARD:cd5s", 		"Five of Spades", 		SUIT_SPADES,		3},
    {"LD_CARD:cd6s", 		"Six of Spades", 		SUIT_SPADES,		4},
    {"LD_CARD:cd7s", 		"Seven of Spades", 		SUIT_SPADES,		5},
    {"LD_CARD:cd8s", 		"Eight of Spades", 		SUIT_SPADES,		6},
    {"LD_CARD:cd9s", 		"Nine of Spades", 		SUIT_SPADES,		7},
    {"LD_CARD:cd10s",		"Ten of Spades",		SUIT_SPADES,		8},
    {"LD_CARD:cd11s",		"Jack of Spades", 		SUIT_SPADES,		9},
    {"LD_CARD:cd12s",		"Queen of Spades", 		SUIT_SPADES,		10},
    {"LD_CARD:cd13s", 		"King of Spades", 		SUIT_SPADES,		11},
    {"LD_CARD:cd1s", 		"Ace of Spades", 		SUIT_SPADES,		12},

	//Hearts
    {"LD_CARD:cd2h", 		"Two of Hearts", 		SUIT_HEARTS,		0},
    {"LD_CARD:cd3h", 		"Three of Hearts", 		SUIT_HEARTS,		1},
    {"LD_CARD:cd4h", 		"Four of Hearts", 		SUIT_HEARTS,		2},
    {"LD_CARD:cd5h", 		"Five of Hearts", 		SUIT_HEARTS,		3},
    {"LD_CARD:cd6h", 		"Six of Hearts", 		SUIT_HEARTS,		4},
    {"LD_CARD:cd7h", 		"Seven of Hearts", 		SUIT_HEARTS,		5},
    {"LD_CARD:cd8h", 		"Eight of Hearts", 		SUIT_HEARTS,		6},
    {"LD_CARD:cd9h", 		"Nine of Hearts", 		SUIT_HEARTS,		7},
    {"LD_CARD:cd10h",		"Ten of Hearts",		SUIT_HEARTS,		8},
    {"LD_CARD:cd11h",		"Jack of Hearts", 		SUIT_HEARTS,		9},
    {"LD_CARD:cd12h",		"Queen of Hearts", 		SUIT_HEARTS,		10},
    {"LD_CARD:cd13h",		"King of Hearts", 		SUIT_HEARTS,		11},
    {"LD_CARD:cd1h", 		"Ace of Hearts", 		SUIT_HEARTS,		12},

	//Clubs
    {"LD_CARD:cd2c", 		"Two of Clubs", 		SUIT_CLUBS, 		0},
    {"LD_CARD:cd3c", 		"Three of Clubs", 		SUIT_CLUBS, 		1},
    {"LD_CARD:cd4c", 		"Four of Clubs", 		SUIT_CLUBS, 		2},
    {"LD_CARD:cd5c", 		"Five of Clubs", 		SUIT_CLUBS, 		3},
    {"LD_CARD:cd6c", 		"Six of Clubs", 		SUIT_CLUBS, 		4},
    {"LD_CARD:cd7c", 		"Seven of Clubs", 		SUIT_CLUBS, 		5},
    {"LD_CARD:cd8c", 		"Eight of Clubs", 		SUIT_CLUBS, 		6},
    {"LD_CARD:cd9c", 		"Nine of Clubs", 		SUIT_CLUBS, 		7},
    {"LD_CARD:cd10c",		"Ten of Clubs",			SUIT_CLUBS, 		8},
    {"LD_CARD:cd11c",		"Jack of Clubs", 		SUIT_CLUBS, 		9},
    {"LD_CARD:cd12c",		"Queen of Clubs", 		SUIT_CLUBS, 		10},
    {"LD_CARD:cd13c",		"King of Clubs", 		SUIT_CLUBS, 		11},
    {"LD_CARD:cd1c", 		"Ace of Clubs", 		SUIT_CLUBS, 		12},

    //Diamonds
    {"LD_CARD:cd2d", 		"Two of Diamonds", 		SUIT_DIAMONDS, 		0},
    {"LD_CARD:cd3d", 		"Three of Diamonds", 	SUIT_DIAMONDS, 		1},
    {"LD_CARD:cd4d", 		"Four of Diamonds", 	SUIT_DIAMONDS, 		2},
    {"LD_CARD:cd5d", 		"Five of Diamonds", 	SUIT_DIAMONDS, 		3},
    {"LD_CARD:cd6d", 		"Six of Diamonds", 		SUIT_DIAMONDS, 		4},
    {"LD_CARD:cd7d", 		"Seven of Diamonds", 	SUIT_DIAMONDS, 		5},
    {"LD_CARD:cd8d", 		"Eight of Diamonds", 	SUIT_DIAMONDS, 		6},
    {"LD_CARD:cd9d", 		"Nine of Diamonds", 	SUIT_DIAMONDS, 		7},
    {"LD_CARD:cd10d",		"Ten of Diamonds", 		SUIT_DIAMONDS, 		8},
    {"LD_CARD:cd11d",		"Jack of Diamonds", 	SUIT_DIAMONDS, 		9},
    {"LD_CARD:cd12d",		"Queen of Diamonds", 	SUIT_DIAMONDS, 		10},
    {"LD_CARD:cd13d",		"King of Diamonds", 	SUIT_DIAMONDS, 		11},
    {"LD_CARD:cd1d", 		"Ace of Diamonds", 		SUIT_DIAMONDS, 		12}
};

// Player Vars
static
	EditingTableID[MAX_PLAYERS],
	PlayingTableID[MAX_PLAYERS],
	PlayingTableSlot[MAX_PLAYERS],
	bool:ActiveHand[MAX_PLAYERS],
	bool:Status[MAX_PLAYERS],
	Chips[MAX_PLAYERS],
	FirstCard[MAX_PLAYERS],
	SecondCard[MAX_PLAYERS],
	Result[MAX_PLAYERS],
	bool:Winner[MAX_PLAYERS],
	bool:HideTD[MAX_PLAYERS],
	bool:ActivePlayer[MAX_PLAYERS],
	Time[MAX_PLAYERS],
	bool:ActionChoice[MAX_PLAYERS],
	ActionOptions[MAX_PLAYERS],
	CurrentBet[MAX_PLAYERS],
	bool:Dealer[MAX_PLAYERS],
	BigBlind[MAX_PLAYERS],
	SmallBlind[MAX_PLAYERS],
	bool:Leader[MAX_PLAYERS],
	StatusString[MAX_PLAYERS][16],
	ResultString[MAX_PLAYERS][16];
//------------------------------------------------

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

ResetPokerVariables(playerid)
{
	EditingTableID[playerid] = -1;
	PlayingTableID[playerid] = -1;
	PlayingTableSlot[playerid] = -1;
	Winner[playerid] = false;
	Chips[playerid] = 0;
	Status[playerid] = false;
	Leader[playerid] = false;
	BigBlind[playerid] = false;
	SmallBlind[playerid] = false;
	Dealer[playerid] = false;
	FirstCard[playerid] = -1;
	SecondCard[playerid] = -1;
	ActivePlayer[playerid] = false;
	ActiveHand[playerid] = false;
	HideTD[playerid] = false;
	CurrentBet[playerid] = false;
	ActionChoice[playerid] = false;
	ActionOptions[playerid] = 0;
	FirstCard[playerid] = -1;
	SecondCard[playerid] = -1;
	StatusString[playerid][0] = EOS;
	ResultString[playerid][0] = EOS;
	Time[playerid] = 0;
	return 1;
}

timer PokerExit[250](playerid)
{
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid);
	CancelSelectTextDraw(playerid);
}

task PokerPulse[1000]()
{
	foreach(new tableid: PokerTables)
	{
		if(PokerTable[tableid][pkrPulseTimer] == true)
		{
			// Idle Animation Loop & Re-seater
			for(new i = 0; i < 6; i++) {
				new playerid = PokerTable[tableid][pkrSlot][i];

				if(playerid != -1) 
				{
					// Disable Weapons
					SetPlayerArmedWeapon(playerid,0);

					new idleRandom = random(100);
					if(idleRandom >= 90) 
					{
						SetPlayerPosObjectOffset(PokerTable[tableid][pkrObjectID], playerid, PokerTableMiscObjOffsets[i][0], PokerTableMiscObjOffsets[i][1], PokerTableMiscObjOffsets[i][2]);
						SetPlayerFacingAngle(playerid, PokerTableMiscObjOffsets[i][5]+90.0);

						// Animation
						if(ActiveHand[playerid]) 
							ApplyAnimation(playerid, "CASINO", "cards_loop", 4.1, 0, 1, 1, 1, 1, 1);
					}
				}
			}

			if(PokerTable[tableid][pkrActive] == 2)
			{
				// Count the number of active players with more than $0, activate the round if more than 1 gets counted.
				new tmpCount = 0;
				for(new i = 0; i < 6; i++) 
				{
					new playerid = PokerTable[tableid][pkrSlot][i];
					if(playerid != -1) 
					{
						if(Chips[playerid] > 0) 
							tmpCount++;
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
				if(PokerTable[tableid][pkrDelay] == 20) 
				{
					new endBetsSoundID[] = {5826, 5827};
					new randomEndBetsSoundID = random(sizeof(endBetsSoundID));
					GlobalPlaySound(endBetsSoundID[randomEndBetsSoundID], PokerTable[tableid][pkrX], PokerTable[tableid][pkrY], PokerTable[tableid][pkrZ]);

					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];
						if(playerid != -1) 
							PokerOptions(playerid, 0);
					}
				}

				if(PokerTable[tableid][pkrDelay] > 0) 
				{
					PokerTable[tableid][pkrDelay]--;
					if(PokerTable[tableid][pkrDelay] <= 5 && PokerTable[tableid][pkrDelay] > 0) 
					{
						for(new i = 0; i < 6; i++) {
							new playerid = PokerTable[tableid][pkrSlot][i];

							if(playerid != -1) PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
						}
					}
				}

				if(PokerTable[tableid][pkrDelay] == 0) 
					return ResetPokerRound(tableid);

				if(PokerTable[tableid][pkrDelay] == 19) 
				{
					// Anaylze Cards
					new resultArray[6], cards[7];

					// Community Cards/ Cards on Table
					cards[2] = GetCardNativeIndex(PokerTable[tableid][pkrCCards][0]);
					cards[3] = GetCardNativeIndex(PokerTable[tableid][pkrCCards][1]);
					cards[4] = GetCardNativeIndex(PokerTable[tableid][pkrCCards][2]);
					cards[5] = GetCardNativeIndex(PokerTable[tableid][pkrCCards][3]);
					cards[6] = GetCardNativeIndex(PokerTable[tableid][pkrCCards][4]);

					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];
						if(playerid != -1) 
						{
							if(ActiveHand[playerid]) 
							{
								cards[0] = GetCardNativeIndex(FirstCard[playerid]);
								cards[1] = GetCardNativeIndex(SecondCard[playerid]);
								Result[playerid] = calculate_hand_worth(cards, 7);
								strcpy(ResultString[playerid], HAND_RANKS[Result[playerid] >> 12], 16);
							}
						}
					}

					// Sorting Results (Highest to Lowest)
					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) 
						{
							if(ActiveHand[playerid]) 
								resultArray[i] = Result[playerid];
						}
					}
					BubbleSort(resultArray, sizeof(resultArray));

					// Determine Winner(s)
					for(new i = 0; i < 6; i++) 
					{
						if(resultArray[5] == resultArray[i])
							PokerTable[tableid][pkrWinners]++;
					}

					// Notify Table of Winner & Give Rewards
					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) 
						{
							if(PokerTable[tableid][pkrWinners] > 1) 
							{
								// Split
								if(resultArray[5] == Result[playerid]) 
								{
									new 
										splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
									
									Winner[playerid] = true;
									Chips[playerid] += splitPot;
									PlayerPlaySound(playerid, 5821, 0.0, 0.0, 0.0);
								} 
								else PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
							} 
							else 
							{
								// Single Winner
								if(resultArray[5] == Result[playerid])
								{
									Winner[playerid] = true;
									Chips[playerid] += PokerTable[tableid][pkrPot];
									PokerTable[tableid][pkrWinnerID] = playerid;

									new winnerSoundID[] = {5847, 5848, 5849, 5854, 5855, 5856};
									new randomWinnerSoundID = random(sizeof(winnerSoundID));
									PlayerPlaySound(playerid, winnerSoundID[randomWinnerSoundID], 0.0, 0.0, 0.0);
								} 
								else PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
							}
						}
					}
				}
			}

			// Game Loop
			if(PokerTable[tableid][pkrActive] == 3)
			{
				if(PokerTable[tableid][pkrActiveHands] == 1 && PokerTable[tableid][pkrRound] == 1) 
				{
					PokerTable[tableid][pkrStage] = 0;
					PokerTable[tableid][pkrActive] = 4;
					PokerTable[tableid][pkrDelay] = 20+1;

					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1) 
							if(ActiveHand[playerid]) 
								HideTD[playerid] = true;
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
					for(new i = 0; i < 6; i++) 
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1)
							Status[playerid] = true;
					}
					if(PokerTable[tableid][pkrActivePlayers] < 2)
					{
						ResetPokerRound(tableid);
						continue;
					}
					else PokerAssignBlinds(tableid);
				}

				// If no round active, start it.
				if(PokerTable[tableid][pkrRound] == 0 && PokerTable[tableid][pkrDelay] == 0 && PokerTable[tableid][pkrActivePlayers] >= 2)
				{
					PokerTable[tableid][pkrRound] = 1;

					for(new i = 0; i < 6; i++)
					{
						new playerid = PokerTable[tableid][pkrSlot][i];

						if(playerid != -1)
							StatusString[playerid][0] = EOS;
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
						if(ActivePlayer[playerid]) 
						{
							Time[playerid] -= 1;
							if(Time[playerid] <= 0) 
							{
								new name[24];
								GetPlayerName(playerid, name, sizeof(name));

								if(ActionChoice[playerid]) 
								{
									ActionChoice[playerid] = false;
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
					case 0: tmp = 0; 
					case 1: tmp = 5; 
					case 2: tmp = 10; 
					case 3: tmp = 15; 
					case 4: tmp = 20; 
					case 5: tmp = 25;
				}

				if(playerid != -1)
				{
					// Name
					new name[MAX_PLAYER_NAME+1];
					GetPlayerName(playerid, name, sizeof(name));
					for(new td = 0; td < 6; td++) 
					{
						new pid = PokerTable[tableid][pkrSlot][td];

						if(pid != -1) PlayerTextDrawSetString(pid, PlayerPokerUI[pid][0+tmp], name);
					}

					// Chips
					if(Chips[playerid] > 0) 
						format(tmpString, sizeof(tmpString), "$%d", Chips[playerid]);
					else 
						format(tmpString, sizeof(tmpString), "~r~$%d", Chips[playerid]);
					
					for(new td = 0; td < 6; td++)
					 {
						new 
							pid = PokerTable[tableid][pkrSlot][td];
						if(pid != -1) 
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][1+tmp], tmpString);
					}

					// Cards
					for(new td = 0; td < 6; td++) 
					{
						new pid = PokerTable[tableid][pkrSlot][td];
						if(pid != -1)
						{
							if(ActiveHand[playerid])
							{
								if(playerid != pid) 
								{
									if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] <= 19 && !HideTD[playerid]) 
									{
										format(tmpString, sizeof(tmpString), "%s", CardData[FirstCard[playerid]][E_CARD_TEXTDRAW]);
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], tmpString);
										format(tmpString, sizeof(tmpString), "%s", CardData[SecondCard[playerid]][E_CARD_TEXTDRAW]);
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], tmpString);
									} 
									else 
									{
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], "LD_CARD:cdback");
										PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], "LD_CARD:cdback");
									}
								} 
								else 
								{
									format(tmpString, sizeof(tmpString), "%s", CardData[FirstCard[playerid]][E_CARD_TEXTDRAW]);
									PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][2+tmp], tmpString);

									format(tmpString, sizeof(tmpString), "%s", CardData[SecondCard[playerid]][E_CARD_TEXTDRAW]);
									PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][3+tmp], tmpString);
								}
							} 
							else 
							{
								PlayerTextDrawSetString(pid, PlayerPokerUI[pid][2+tmp], " ");
								PlayerTextDrawSetString(pid, PlayerPokerUI[pid][3+tmp], " ");
							}
						}
					}

					// Status
					if(PokerTable[tableid][pkrActive] < 3) 
						format(tmpString, sizeof(tmpString), " ");

					else if(ActivePlayer[playerid] && PokerTable[tableid][pkrActive] == 3)
					{
						format(tmpString, sizeof(tmpString), "0:%s%d", 
							(Time[playerid] < 10) ? ("0") : (""),
							Time[playerid]
						);
					}
					else 
					{
						if(PokerTable[tableid][pkrActive] == 3 && PokerTable[tableid][pkrDelay] > 5) 
							StatusString[playerid][0] = EOS;

						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 19) 
						{
							if(PokerTable[tableid][pkrWinners] == 1) 
							{
								if(Winner[playerid]) 
								{
									format(tmpString, sizeof(tmpString), "+$%d", PokerTable[tableid][pkrPot]);
									strcpy(StatusString[playerid], tmpString, 16);
								} 
								else 
								{
									format(tmpString, sizeof(tmpString), "-$%d", CurrentBet[playerid]);
									strcpy(StatusString[playerid], tmpString, 16);
								}
							} 
							else 
							{
								if(Winner[playerid]) 
								{
									new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
									format(tmpString, sizeof(tmpString), "+$%d", splitPot);
									strcpy(StatusString[playerid], tmpString, 16);
								} 
								else 
								{
									format(tmpString, sizeof(tmpString), "-$%d", CurrentBet[playerid]);
									strcpy(StatusString[playerid], tmpString, 16);
								}
							}
						}

						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 19) 
						{
							if(ActiveHand[playerid] && !HideTD[playerid]) 
							{
								format(tmpString, sizeof(tmpString), "%s", ResultString[playerid]);
								strcpy(StatusString[playerid], ResultString[playerid], 16);
							}
						}
						if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] == 10) 
						{
							if(PokerTable[tableid][pkrWinners] == 1) 
							{
								if(Winner[playerid]) 
								{
									format(tmpString, sizeof(tmpString), "+$%d", PokerTable[tableid][pkrPot]);
									strcpy(StatusString[playerid], tmpString, 16);
								} 
								else 
								{
									format(tmpString, sizeof(tmpString), "-$%d", CurrentBet[playerid]);
									strcpy(StatusString[playerid], tmpString, 16);
								}
							} 
							else 
							{
								if(Winner[playerid]) 
								{
									new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
									format(tmpString, sizeof(tmpString), "+$%d", splitPot);
									strcpy(StatusString[playerid], tmpString, 16);
								} 
								else 
								{
									format(tmpString, sizeof(tmpString), "-$%d", CurrentBet[playerid]);
									strcpy(StatusString[playerid], tmpString, 16);
								}
							}
						}
						strcpy(tmpString, StatusString[playerid], 128);
					}

					for(new td = 0; td < 6; td++) 
					{
						new pid = PokerTable[tableid][pkrSlot][td];
						if(pid != -1) 
							PlayerTextDrawSetString(pid, PlayerPokerUI[pid][4+tmp], tmpString);
					}

					// Pot
					if(PokerTable[tableid][pkrDelay] > 0 && PokerTable[tableid][pkrActive] == 3) 
					{
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");
					} 
					else if(PokerTable[tableid][pkrActive] == 2) 
					{
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");
					} 
					else if(PokerTable[tableid][pkrActive] == 3) 
					{
						format(tmpString, sizeof(tmpString), "Pot: $%d", PokerTable[tableid][pkrPot]);
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
					} 
					else if(PokerTable[tableid][pkrActive] == 4 && PokerTable[tableid][pkrDelay] < 19) 
					{
						if(PokerTable[tableid][pkrWinnerID] != -1) 
						{
							new winnerName[24];
							GetPlayerName(PokerTable[tableid][pkrWinnerID], winnerName, sizeof(winnerName));
							format(tmpString, sizeof(tmpString), "%s je osvojio $%d", winnerName, PokerTable[tableid][pkrPot]);
							if(playerid != -1) PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
						} 
						else if(PokerTable[tableid][pkrWinners] > 1) 
						{
							new splitPot = PokerTable[tableid][pkrPot]/PokerTable[tableid][pkrWinners];
							format(tmpString, sizeof(tmpString), "%d pobjednika je osvojilo $%d", PokerTable[tableid][pkrWinners], splitPot);
							if(playerid != -1) 
								PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], tmpString);
						}
					} 
					else if(playerid != -1) 
						PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][37], "Texas Holdem Poker");

					// Bet
					if(PokerTable[tableid][pkrDelay] > 0 && PokerTable[tableid][pkrActive] == 3)
					{
						format(tmpString, sizeof(tmpString), "Runda pocinje za ~r~%d~w~...", PokerTable[tableid][pkrDelay]);
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} 
					else if(PokerTable[tableid][pkrActive] == 2) 
					{
						format(tmpString, sizeof(tmpString), "Cekanje na igrace...", PokerTable[tableid][pkrPot]);
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} 
					else if(PokerTable[tableid][pkrActive] == 3) 
					{
						format(tmpString, sizeof(tmpString), "Ulog: $%d", PokerTable[tableid][pkrActiveBet]);
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} 
					else if(PokerTable[tableid][pkrActive] == 4) 
					{
						format(tmpString, sizeof(tmpString), "Runda zavrsava za ~r~%d~w~...", PokerTable[tableid][pkrDelay]);
						if(playerid != -1) 
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], tmpString);
					} 
					else if(playerid != -1) 
						PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][42], "Texas Holdem Poker");

					// Community Cards
					switch(PokerTable[tableid][pkrStage]) 
					{
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
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], CardData[PokerTable[tableid][pkrCCards][0]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], CardData[PokerTable[tableid][pkrCCards][1]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], CardData[PokerTable[tableid][pkrCCards][2]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], "LD_CARD:cdback");
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], "LD_CARD:cdback");
						}
						case 2: // Turn
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], CardData[PokerTable[tableid][pkrCCards][0]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], CardData[PokerTable[tableid][pkrCCards][1]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], CardData[PokerTable[tableid][pkrCCards][2]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], CardData[PokerTable[tableid][pkrCCards][3]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], "LD_CARD:cdback");
						}
						case 3: // River
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], CardData[PokerTable[tableid][pkrCCards][0]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], CardData[PokerTable[tableid][pkrCCards][1]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], CardData[PokerTable[tableid][pkrCCards][2]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], CardData[PokerTable[tableid][pkrCCards][3]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], CardData[PokerTable[tableid][pkrCCards][4]][E_CARD_TEXTDRAW]);
						}
						case 4: // Win
						{
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][31], CardData[PokerTable[tableid][pkrCCards][0]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][32], CardData[PokerTable[tableid][pkrCCards][1]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][33], CardData[PokerTable[tableid][pkrCCards][2]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][34], CardData[PokerTable[tableid][pkrCCards][3]][E_CARD_TEXTDRAW]);
							PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][35], CardData[PokerTable[tableid][pkrCCards][4]][E_CARD_TEXTDRAW]);
						}
					}
				} 
				else 
				{
					for(new td = 0; td < 6; td++) 
					{
						new pid = PokerTable[tableid][pkrSlot][td];
						if(pid != -1) 
						{
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
	foreach(new i: Player)
	{
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
			ActionOptions[playerid] = 0;
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawHide(playerid, PlayerPokerUI[playerid][40]);
		}
		case 1: // if(CurrentBet >= ActiveBet)
		{
			ActionOptions[playerid] = 1;
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][38], "RAISE");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][39], "CHECK");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][40], "FOLD");

			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][40]);
		}
		case 2: // if(CurrentBet < ActiveBet)
		{
			ActionOptions[playerid] = 2;
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][38], "CALL");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][39], "RAISE");
			PlayerTextDrawSetString(playerid, PlayerPokerUI[playerid][40], "FOLD");

			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][38]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][39]);
			PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][40]);
		}
		case 3: // if(pkrChips < 1)
		{
			ActionOptions[playerid] = 3;

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
	if(ActiveHand[playerid]) 
		strcpy(StatusString[playerid], "Check", 16);
	
	// Animation
	ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
}

PokerFoldHand(playerid)
{
	if(ActiveHand[playerid]) 
	{
		ActiveHand[playerid] = false;
		Status[playerid]= false;

		FirstCard[playerid] = -1;
		SecondCard[playerid] = -1;

		PokerTable[PlayingTableID[playerid]][pkrActiveHands]--;

		strcpy(StatusString[playerid], "Fold", 16);

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
	for(new i = 0; i < 6; i++) 
	{
		new playerid = PokerTable[tableid][pkrSlot][i];

		if(playerid != -1) 
		{

			if(Status[playerid] && Chips[playerid] > 0) 
			{
				FirstCard[playerid] = PokerTable[tableid][pkrDeck][tmp];
				SecondCard[playerid] = PokerTable[tableid][pkrDeck][tmp+1];

				ActiveHand[playerid] = true; 

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
	for(i = 52; i > 1; i--) 
	{
		rand = random(52) % i;
		tmp = PokerTable[tableid][pkrDeck][rand];
		PokerTable[tableid][pkrDeck][rand] = PokerTable[tableid][pkrDeck][i-1];
		PokerTable[tableid][pkrDeck][i-1] = tmp;
	}
}

PokerFindPlayerOrder(tableid, index)
{
	new tmpIndex = -1;
	for(new i = 0; i < 6; i++) 
	{
		new playerid = PokerTable[tableid][pkrSlot][i];
		if(playerid != -1) 
		{
			tmpIndex++;
			if(tmpIndex == index) 
			{
				if(Status[playerid])
					return playerid;
			}
		}
	}
	return -1;
}

PokerAssignBlinds(tableid)
{
	// Find where to start & distubute blinds.
	new bool:roomDealer = false, bool:roomBigBlind = false, bool:roomSmallBlind = false,
	dealerSlot = -1,
	bigBlindSlot = -1,
	smallBlindSlot = -1;

	// Find the Dealer.
	new tmpPos = PokerTable[tableid][pkrPos];
	while(roomDealer == false) 
	{
		if(tmpPos == 6)
			tmpPos = 0;

		new playerid = PokerFindPlayerOrder(tableid, tmpPos);

		if(playerid != -1) 
		{
			if(bigBlindSlot != tmpPos && dealerSlot != tmpPos && smallBlindSlot != tmpPos)
			{
				Dealer[playerid] = true;
				strcpy(StatusString[playerid], "Dealer", 16);
				roomDealer = true;
				dealerSlot = tmpPos;
			}
		} 
		else tmpPos++;
	}

	// Find the player after the Dealer.
	tmpPos = dealerSlot;
	while(roomBigBlind == false) 
	{
		if(tmpPos == 6)
			tmpPos = 0;

		new playerid = PokerFindPlayerOrder(tableid, tmpPos);
		if(playerid != -1) 
		{
			if(bigBlindSlot != tmpPos && dealerSlot != tmpPos && smallBlindSlot != tmpPos)
			{
				BigBlind[playerid] = true;
				new tmpString[128];
				format(tmpString, sizeof(tmpString), "~r~BB -$%d", PokerTable[tableid][pkrBlind]);
				strcpy(StatusString[playerid], tmpString, 16);
				roomBigBlind = true;
				bigBlindSlot = tmpPos;

				if(Chips[playerid] < PokerTable[tableid][pkrBlind]) 
				{
					PokerTable[tableid][pkrPot] += Chips[playerid];
					Chips[playerid] = 0;
				} 
				else 
				{
					PokerTable[tableid][pkrPot] += PokerTable[tableid][pkrBlind];
					Chips[playerid] -= PokerTable[tableid][pkrBlind];
				}

				CurrentBet[playerid] = PokerTable[tableid][pkrBlind];
				PokerTable[tableid][pkrActiveBet] = PokerTable[tableid][pkrBlind];

			} 
			else tmpPos++;
		} 
		else tmpPos++;
	}

	// Small Blinds are active only if there are more than 2 players.
	if(PokerTable[tableid][pkrActivePlayers] > 2) 
	{
		if(tmpPos == 6)
			tmpPos = 0;

		// Find the player after the Big Blind.
		tmpPos = bigBlindSlot;
		while(roomSmallBlind == false) 
		{
			new playerid = PokerFindPlayerOrder(tableid, tmpPos);

			if(playerid != -1) 
			{
				if(bigBlindSlot != tmpPos && dealerSlot != tmpPos && smallBlindSlot != tmpPos)
				{
					SmallBlind[playerid] = true;
					new tmpString[128];
					format(tmpString, sizeof(tmpString), "~r~SB -$%d", PokerTable[tableid][pkrBlind]/2);
					strcpy(StatusString[playerid], tmpString, 16);
					roomSmallBlind = true;
					smallBlindSlot = tmpPos;
					if(Chips[playerid] < (PokerTable[tableid][pkrBlind]/2)) 
					{
						PokerTable[tableid][pkrPot] += Chips[playerid];
						Chips[playerid] = 0;
					} 
					else 
					{
						PokerTable[tableid][pkrPot] += (PokerTable[tableid][pkrBlind]/2);
						Chips[playerid] -=  (PokerTable[tableid][pkrBlind]/2);
					}

					CurrentBet[playerid] = PokerTable[tableid][pkrBlind]/2;
					PokerTable[tableid][pkrActiveBet] = PokerTable[tableid][pkrBlind]/2;
				} 
				else tmpPos++;
			} 
			else tmpPos++;
		}
	}
	PokerTable[tableid][pkrPos] = bigBlindSlot;
	return 1;
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

		ActivePlayer[lastapid] = false;
		Time[lastapid] = 0;

		PokerOptions(lastapid, 0);
	}

	// New Round Init Block
	if(PokerTable[tableid][pkrRotations] == 0 && lastapid == -1 && lastapslot == -1) {

		// Find & Assign ActivePlayer to Dealer
		for(new i = 0; i < 6; i++) 
		{
			new playerid = PokerTable[tableid][pkrSlot][i];

			if(Dealer[playerid] && playerid != -1) 
			{
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
				CurrentBet[PokerTable[tableid][pkrSlot][s]] = 0;
		}

		if(PokerTable[tableid][pkrStage] > 3) 
		{
			PokerTable[tableid][pkrActive] = 4;
			PokerTable[tableid][pkrDelay] = 20+1;
			return 1;
		}

		PokerTable[tableid][pkrSlotRotations]++;
		if(PokerTable[tableid][pkrSlotRotations] >= 6) 
		{
			if(PokerTable[tableid][pkrActive] == 4) // Winner Loop
				return 1;
			PokerTable[tableid][pkrSlotRotations] -= 6;
		}

		new playerid = PokerFindPlayerOrder(tableid, PokerTable[tableid][pkrSlotRotations]);

		if(playerid != -1) {
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
		PokerTable[tableid][pkrSlotRotations]++;
		if(PokerTable[tableid][pkrSlotRotations] >= 6)
			PokerTable[tableid][pkrSlotRotations] -= 6;

		new playerid = PokerFindPlayerOrder(tableid, PokerTable[tableid][pkrSlotRotations]);

		if(playerid != -1)
		{
			if( (CurrentBet[playerid] < PokerTable[tableid][pkrActiveBet] && PokerTable[tableid][pkrActiveBet] != 0) 
				|| (CurrentBet[playerid] == PokerTable[tableid][pkrActiveBet] && PokerTable[tableid][pkrActiveBet] == 0) 
				&& Status[playerid] )
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

	if(nextactiveid != -1) 
	{
		if(ActiveHand[nextactiveid]) 
		{
			new currentBet = CurrentBet[nextactiveid];
			new activeBet = PokerTable[tableid][pkrActiveBet];

			new apSoundID[] = {5809, 5810};
			new randomApSoundID = random(sizeof(apSoundID));
			PlayerPlaySound(nextactiveid, apSoundID[randomApSoundID], 0.0, 0.0, 0.0);

			if(Chips[nextactiveid] < 1) 
				PokerOptions(nextactiveid, 3);
			else if(currentBet >= activeBet) 
				PokerOptions(nextactiveid, 1);
			else if (currentBet < activeBet) 
				PokerOptions(nextactiveid, 2);
			else 
				PokerOptions(nextactiveid, 0);

			Time[nextactiveid] = 60;
			ActivePlayer[nextactiveid] = true;
		}
	}
	return 1;
}

Public:InitPokerTables()
{
	for(new i = 0; i < MAX_POKERTABLES; i++) 
	{
		PokerTable[i][pkrSQL] = -1;
		PokerTable[i][pkrActive] = 0;
		PokerTable[i][pkrPlaced] = 0;
		PokerTable[i][pkrObjectID] = 0;

		for(new c = 0; c < MAX_POKERTABLEMISCOBJS; c++) 
			PokerTable[i][pkrMiscObjectID][c] = 0;

		for(new s = 0; s < 6; s++) 
			PokerTable[i][pkrSlot][s] = -1;

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

stock LoadPokerTables()
{
	mysql_pquery(g_SQL, "SELECT * FROM poker_tables WHERE 1", "OnPokerTablesLoaded", "");
	return 1;
}

Public:OnPokerTablesLoaded()
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

		PlacePokerTable(i, 1, 
			PokerTable[i][pkrX], 
			PokerTable[i][pkrY], 
			PokerTable[i][pkrZ], 
			PokerTable[i][pkrRX], 
			PokerTable[i][pkrRY], 
			PokerTable[i][pkrRZ], 
			PokerTable[i][pkrVW], 
			PokerTable[i][pkrInt]
		);
	}
	printf("MySQL Report: Poker Tables Loaded. [%d/%d]", rows, MAX_POKERTABLES);
	return 1;
}

SavePokerTable(idx)
{
	if(PokerTable[idx][pkrSQL] == -1)
	{
		mysql_pquery( g_SQL, 
			va_fquery(g_SQL, 
				"INSERT INTO poker_tables (X, Y, Z, RX, RY, RZ, virtualworld, interior) \n\
					VALUES ('%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d')",
				PokerTable[idx][pkrX],
				PokerTable[idx][pkrY],
				PokerTable[idx][pkrZ],
				PokerTable[idx][pkrRX],
				PokerTable[idx][pkrRY],
				PokerTable[idx][pkrRZ],
				PokerTable[idx][pkrVW],
				PokerTable[idx][pkrInt]
			), 
			"OnPokerTableInsert", 
			"i", 
			idx
		);
	}
	else
	{
		mysql_fquery(g_SQL, 
			"UPDATE poker_tables SET X = '%f', Y = '%f', Z = '%f', RX = '%f', RY = '%f', RZ = '%f',\n\
				virtualworld = '%d', interior = '%d' WHERE sqlid = '%d'",
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
	}
	return 1;
}

Public:OnPokerTableInsert(tableid)
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
	for(new i = 0; i < 6; i++) 
	{
		new playerid = PokerTable[tableid][pkrSlot][i];

		if(playerid != -1) 
		{
			Winner[playerid] = false;
			BigBlind[playerid] = false;
			SmallBlind[playerid] = false;
			Dealer[playerid] = true;
			FirstCard[playerid] = -1;
			SecondCard[playerid] = -1;
			ActivePlayer[playerid] = false;
			Time[playerid] = 0;
			CurrentBet[playerid] = 0;
			
			if(ActiveHand[playerid]) 
			{
				PokerTable[tableid][pkrActiveHands]--;
				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);
			}

			ActiveHand[playerid] = false;
			ResultString[playerid][0] = EOS;
			HideTD[playerid] = false;
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

ShowPokerGUI(playerid)
{
	for(new i = 0; i < MAX_PLAYERPOKERUI; i++) 
		PlayerTextDrawShow(playerid, PlayerPokerUI[playerid][i]);

	return 1;
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
	format(tmpString, sizeof(tmpString), "Poker stol\n\n Buy-In Maximum/Minimum: {00FF00}$%d{FFFFFF}/{00FF00}$%d{FFFFFF}\n\n[/poker play]", PokerTable[tableid][pkrBuyInMax], PokerTable[tableid][pkrBuyInMin]);
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
		for(new c = 0; c < MAX_POKERTABLEMISCOBJS; c++) 
			if(IsValidObject(PokerTable[tableid][pkrMiscObjectID][c])) 
				DestroyObject(PokerTable[tableid][pkrMiscObjectID][c]);
		
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
	mysql_fquery(g_SQL, "DELETE FROM poker_tables WHERE sqlid = '%d'", PokerTable[ tableid ][ pkrSQL ]);
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
				if(PokerTable[tableid][pkrPlayers] == 1) 
				{
					// Player is Room Creator
					Leader[playerid] = true;
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

				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);
				TogglePlayerControllable(playerid, 0);
				SetPlayerPosObjectOffset(PokerTable[tableid][pkrObjectID], playerid, PokerTableMiscObjOffsets[s][0], PokerTableMiscObjOffsets[s][1], PokerTableMiscObjOffsets[s][2]);
				SetPlayerFacingAngle(playerid, PokerTableMiscObjOffsets[s][5]+90.0);
				ApplyAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);

				// Create GUI
				CreatePokerGUI(playerid);
				ShowPokerGUI(playerid);

				// Hide Action Bar
				PokerOptions(playerid, 0);

				return 1;
			}
		}
	}
	else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Sva mjesta su za ovim stolom popunjena! [%d/%d]", PokerTable[tableid][pkrPlayers], PokerTable[tableid][pkrLimit]);
	return 1;
}

DoesHavePokerTablePerm(playerid, tableid)
{
	new houseid = Player_InHouse(playerid),
		bizzid  = Player_InBusiness(playerid);
	if (houseid != INVALID_HOUSE_ID && houseid >= 0)
	{
		if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID] && HouseInfo[houseid][hInt] == PokerTable[tableid][pkrInt] && HouseInfo[houseid][hVirtualWorld] == PokerTable[tableid][pkrVW])
			return 1;
	}
	else if (bizzid != INVALID_BIZNIS_ID && bizzid < MAX_BIZZES)
	{
		if( (BizzInfo[bizzid][bOwnerID] == PlayerInfo[playerid][pSQLID]) && BizzInfo[bizzid][bInterior] == PokerTable[tableid][pkrInt] && BizzInfo[bizzid][bVirtualWorld] == PokerTable[tableid][pkrVW])
			return 1;
	}
	return 0;
}

DetectPokerTable(playerid)
{
	foreach(new i: PokerTables)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, PokerTable[i][pkrX], PokerTable[i][pkrY], PokerTable[i][pkrZ]) && GetPlayerInterior(playerid) == PokerTable[i][pkrInt] && GetPlayerVirtualWorld(playerid) == PokerTable[i][pkrVW])
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
	new houseid = Player_InHouse(playerid),
		bizzid  = Player_InBusiness(playerid);

	if (houseid != INVALID_HOUSE_ID)
	{
		if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID])
		{
			new tableCount = CountHousePokerTables(houseid);
			switch(PlayerVIP[playerid][pDonateRank])
			{
				case 0:
				{
					if(tableCount < PREMIUM_NONE_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_NONE_POKER_TABLES);
				}
				case PREMIUM_BRONZE:
				{
					if(tableCount < PREMIUM_BRONZE_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_BRONZE_POKER_TABLES);
				}
				case PREMIUM_SILVER:
				{
					if(tableCount < PREMIUM_SILVER_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_SILVER_POKER_TABLES);
				}
				case PREMIUM_GOLD:
				{
					if(tableCount < PREMIUM_GOLD_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_GOLD_POKER_TABLES);
				}
				case PREMIUM_PLATINUM:
				{
					if(tableCount < PREMIUM_PLATINUM_POKER_TABLES)
						return 1;
					else SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimum Poker stolova u vasoj kuci je %d!", PREMIUM_PLATINUM_POKER_TABLES);
				}
			}
		}
		else
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vlasnik kuce u kojoj se nalazite!");
		}
	}
	else if (bizzid != INVALID_BIZNIS_ID)
	{
		if (BizzInfo[bizzid][bType] == BIZZ_TYPE_CASINO &&
			(BizzInfo[bizzid][bOwnerID] == PlayerInfo[playerid][pSQLID]))
		{
			return 1;
		}
		else
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vlasnik/suvlasnik kasina / biznis nije kasino!");
		}
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
	if(Status[playerid])
		PokerTable[tableid][pkrActivePlayers] -= 1;
	if(PokerTable[tableid][pkrActivePlayerID] == playerid)
		PokerTable[tableid][pkrActivePlayerID] = -1;
	PokerTable[tableid][pkrSlot][PlayingTableSlot[playerid]] = -1;

	// Sprijecavanje da counter igraca ide u minus/da se smanjuje vise nego sto bi se trebao
	new players = 0, activeplayers = 0;
	for(new i = 0; i < 6; i++)
	{
		if(PokerTable[tableid][pkrSlot][i] != -1)
		{	
			players++;
			if(Status[PokerTable[tableid][pkrSlot][i]])
				activeplayers++;
		}
	}
	PokerTable[tableid][pkrPlayers] = players;
	PokerTable[tableid][pkrActivePlayers] = activeplayers;


	if(PokerTable[tableid][pkrPlayers] == 0)
	{
		new tmpString[150];
		format(tmpString, sizeof(tmpString), "Poker stol\n\n Buy-In Maximum/Minimum: {00FF00}$%d{FFFFFF}/{00FF00}$%d{FFFFFF}\n\n[/poker play]", PokerTable[tableid][pkrBuyInMax], PokerTable[tableid][pkrBuyInMin]);
		UpdateDynamic3DTextLabelText(PokerTable[tableid][pkrText3DID], COLOR_YELLOW, tmpString);

		PokerTable[tableid][pkrPulseTimer] = false;
		ResetPokerTable(tableid);
	}

	if(PokerTable[tableid][pkrRound] == 0 && PokerTable[tableid][pkrDelay] < 5 && PokerTable[tableid][pkrActivePlayers] >= 2)
		ResetPokerRound(tableid);

	AC_GivePlayerMoney(playerid, Chips[playerid]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
	CancelSelectTextDraw(playerid);

	if(ActiveHand[playerid]) 
		PokerTable[tableid][pkrActiveHands]--;

	// Destroy GUI
	DestroyPokerGUI(playerid);

	ResetPokerVariables(playerid);

	// Delay Exit Call
	defer PokerExit(playerid);
	return 1;
}

ShowCasinoGamesMenu(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_CGAMESCALLPOKER:
		{
			if(Chips[playerid] > 0) 
			{
				ActionChoice[playerid] = true;

				new tableid = PlayingTableID[playerid];
				new actualBet = PokerTable[tableid][pkrActiveBet] - CurrentBet[playerid];

				new szString[128];
				if(actualBet > Chips[playerid]) {
					format(szString, sizeof(szString), "{FFFFFF}Jeste li sigurni da zelite pratiti zvanje za $%d (All-In)?:", actualBet);
					return ShowPlayerDialog(playerid, DIALOG_CGAMESCALLPOKER, DIALOG_STYLE_MSGBOX, "{FFFFFF}Texas Holdem Poker - (Call)", szString, "All-In", "Cancel");
				}
				format(szString, sizeof(szString), "{FFFFFF}Jeste li sigurni da zelite pratiti zvanje za $%d?:", actualBet);
				return ShowPlayerDialog(playerid, DIALOG_CGAMESCALLPOKER, DIALOG_STYLE_MSGBOX, "{FFFFFF}Texas Holdem Poker - (Call)", szString, "Call", "Cancel");
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
			ActionChoice[playerid] = true;
			
			if( (CurrentBet[playerid] + Chips[playerid]) 
				> (PokerTable[tableid][pkrActiveBet] + (PokerTable[tableid][pkrBlind]/2) )) 
			{
				new szString[128];
				format(szString, sizeof(szString), "{FFFFFF}Za koji iznos zelite dignuti ulog? ($%d-$%d):", 
					(PokerTable[tableid][pkrActiveBet] + (PokerTable[tableid][pkrBlind]/2)), 
					(CurrentBet[playerid]+Chips[playerid])
				);
				return ShowPlayerDialog(playerid, DIALOG_CGAMESRAISEPOKER, DIALOG_STYLE_INPUT, "{FFFFFF}Texas Holdem Poker - (Raise)", szString, "Raise", "Cancel");
			} 
			else if( (CurrentBet[playerid] + Chips[playerid]) 
				== (PokerTable[tableid][pkrActiveBet]+ (PokerTable[tableid][pkrBlind]/2)) ) 
			{
				new szString[128];
				format(szString, sizeof(szString), "{FFFFFF}Za koji iznos zelite dignuti ulog? (All-In):", 
					(PokerTable[tableid][pkrActiveBet] + PokerTable[tableid][pkrBlind]/2), 
					(CurrentBet[playerid] + Chips[playerid])
				);
				return ShowPlayerDialog(playerid, DIALOG_CGAMESRAISEPOKER, DIALOG_STYLE_INPUT, "{FFFFFF}Texas Holdem Poker - (Raise)", szString, "All-In", "Cancel");
			} 
			else 
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "DEALER: Nemate dovoljno novaca da bi dignuli ulog.");
				new noFundsSoundID[] = {5823, 5824, 5825};
				new randomNoFundsSoundID = random(sizeof(noFundsSoundID));
				PlayerPlaySound(playerid, noFundsSoundID[randomNoFundsSoundID], 0.0, 0.0, 0.0);
			}
		}
		case DIALOG_CGAMESBUYINPOKER:
		{
			new szString[386];
			format(szString, sizeof(szString), "{FFFFFF}Molimo Vas unesite Buy-In iznos za stol:\n\nTrenutno vasih Poker Chipova: {00FF00}$%d{FFFFFF}\nBuy-In Maximum/Minimum: {00FF00}$%d{FFFFFF}/{00FF00}$%d{FFFFFF}", Chips[playerid], PokerTable[PlayingTableID[playerid]][pkrBuyInMax], PokerTable[PlayingTableID[playerid]][pkrBuyInMin]);
			return ShowPlayerDialog(playerid, DIALOG_CGAMESBUYINPOKER, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Buy-In Menu)", szString, "Buy In", "Leave");
		}
		case DIALOG_CGAMESSETUPPOKER:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
			{
				if(!GetPokerTableLimit(playerid))
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in house/casino!");

				return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPOKER, DIALOG_STYLE_LIST, "{FFFFFF}Poker - (Setup Poker Minigame)", "{FFFFFF}Postavljanje stola...", "Pick", "Back");
			}
			else return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPOKER, DIALOG_STYLE_LIST, "{FFFFFF}Poker - (Setup Poker Minigame)", "{FFFFFF}Promjena polozaja stola...\nBrisanje stola...", "Pick", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			new szString[512];

			if(PokerTable[tableid][pkrPass][0] == EOS)
			{
				format(szString, sizeof(szString), "{FFFFFF}Buy-In Max\t({00FF00}$%d{FFFFFF})\nBuy-In Min\t({00FF00}$%d{FFFFFF})\nBlind\t\t({00FF00}$%d{FFFFFF} / {00FF00}$%d{FFFFFF})\nLimit\t\t(%d)\nPassword\t(%s)\nPauza izmedju rundi\t(%d)\nPocetak igre",
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
				format(szString, sizeof(szString), "{FFFFFF}Buy-In Max\t({00FF00}$%d{FFFFFF})\nBuy-In Min\t({00FF00}$%d{FFFFFF})\nBlind\t\t({00FF00}$%d{FFFFFF} / {00FF00}$%d{FFFFFF})\nLimit\t\t(%d)\nPassword\t(%s)\nPauza izmedju rundi\t(%d)\nPocetak igre",
					PokerTable[tableid][pkrBuyInMax],
					PokerTable[tableid][pkrBuyInMin],
					PokerTable[tableid][pkrBlind],
					PokerTable[tableid][pkrBlind]/2,
					PokerTable[tableid][pkrLimit],
					PokerTable[tableid][pkrPass],
					PokerTable[tableid][pkrSetDelay]
				);
			}
			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME, DIALOG_STYLE_LIST, "{FFFFFF}Poker - (Postavljanje igre)", szString, "Pick", "Exit");
		}
		case DIALOG_CGAMESSETUPPGAME2:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME2, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Buy-In Max)", "{FFFFFF}Molimo Vas postavite Buy-In Max iznos:", "Change", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME3:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME3, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Buy-In Min)", "{FFFFFF}Molimo Vas postavite Buy-In Min iznos:", "Change", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME4:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME4, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Blindovi)", "{FFFFFF}Molimo Vas unesite Blindove:\n\nNote: Mali blindovi su automatski polovica velikog blinda.", "Change", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME5:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME5, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Limit igraca)", "{FFFFFF}Molimo Vas unesite limit broja igraca (2-6):", "Change", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME6:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME6, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Password)", "{FFFFFF}Molimo Vas unesite Password:\n[!]: Ostavite praznim ukoliko ne zelite lozinku za pridruzivanje!", "Change", "Back");
		}
		case DIALOG_CGAMESSETUPPGAME7:
		{
			new tableid = DetectPokerTable(playerid);
			if(tableid == -1)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near poker table!");

			return ShowPlayerDialog(playerid, DIALOG_CGAMESSETUPPGAME7, DIALOG_STYLE_INPUT, "{FFFFFF}Poker - (Round Delay)", "{FFFFFF}Molimo Vas unesite duljinu pauze izmedju dvije runde (15-120sec):", "Change", "Back");
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

hook function LoadServerData()
{
	InitPokerTables();
	return continue();

}

hook function ResetPlayerVariables(playerid)
{
	ResetPokerVariables(playerid);
	CancelSelectTextDraw(playerid);
	return continue(playerid);
}

hook OnPlayerDisconnect(playerid)
{
	LeavePokerTable(playerid);
	return 1;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(EditingTableID[playerid] != -1)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);

		if(response == EDIT_RESPONSE_FINAL)
		{

			new tableid = EditingTableID[playerid];

			PlacePokerTable(tableid, 1, x, y, z, rx, ry, rz, 
				GetPlayerVirtualWorld(playerid), 
				GetPlayerInterior(playerid)
			);

			EditingTableID[playerid] = -1;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili poker stol! Koristite /poker play da bi zapoceli sa igrom.");
			return 1;
		}

		if(response == EDIT_RESPONSE_CANCEL)
		{
			new 
				tableid = EditingTableID[playerid];

			PlacePokerTable(tableid, 0, 
				PokerTable[tableid][pkrX],
				PokerTable[tableid][pkrY],
				PokerTable[tableid][pkrZ],
				PokerTable[tableid][pkrRX],
				PokerTable[tableid][pkrRY],
				PokerTable[tableid][pkrRZ],
				GetPlayerVirtualWorld(playerid), 
				GetPlayerInterior(playerid)
			);

			EditingTableID[playerid] = -1;
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

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	new tableid = PlayingTableID[playerid];

    if(playertextid == PlayerPokerUI[playerid][38])
    {
         switch(ActionOptions[playerid])
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
		switch(ActionOptions[playerid])
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
        switch(ActionOptions[playerid])
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
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not in house/casino!");

					tableid = Iter_Free(PokerTables);
					ResetPokerTable(tableid);
				}
				if(PokerTable[tableid][pkrPlaced] == 0)
				{
					switch(listitem)
					{
						case 0: // Place Poker Table
						{
							new Float:x, Float:y, Float:z;
							GetPlayerPos(playerid, x, y, z);

							PokerTable[tableid][pkrObjectID] = PlacePokerTable(tableid, 0, x, y, z+2.0, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

							EditingTableID[playerid] = tableid;
							EditDynamicObject(playerid, PokerTable[tableid][pkrObjectID]);

							SendClientMessage(playerid, COLOR_WHITE, "Postavio si stol za poker, sada namjesti njegovu poziciju/rotaciju.");
							SendClientMessage(playerid, COLOR_WHITE, "Pritisni '{3399FF}~k~~PED_SPRINT~{FFFFFF}' da bi pomicao kameru.");
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
							EditingTableID[playerid] = tableid;
							EditDynamicObject(playerid, PokerTable[tableid][pkrObjectID]);
							SendClientMessage(playerid, COLOR_YELLOW, "Namjestite zeljenu poziciju poker stola!");
						}
						case 1: // Destroy Poker Table
						{
							if(PokerTable[tableid][pkrPlayers] > 0)
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
			if(response) 
			{
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
			if(response) 
			{
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
				Chips[playerid] += strval(inputtext);
				AC_GivePlayerMoney(playerid, -strval(inputtext));

				if(PokerTable[PlayingTableID[playerid]][pkrActive] == 3 && PokerTable[PlayingTableID[playerid]][pkrRound] == 0 && PokerTable[PlayingTableID[playerid]][pkrDelay] >= 6) 
					Status[playerid] = true;
				
				else if(PokerTable[PlayingTableID[playerid]][pkrActive] < 3) 
					Status[playerid] = true;
			
				if(PokerTable[PlayingTableID[playerid]][pkrActive] == 1 && Leader[playerid]) 
				{
					PokerTable[PlayingTableID[playerid]][pkrActive] = 2;
					SelectTextDraw(playerid, COLOR_YELLOW);
				}
			}
			else LeavePokerTable(playerid);
		}
		case DIALOG_CGAMESCALLPOKER:
		{
			if(response) 
			{
				new 
					tableid = PlayingTableID[playerid],
					actualBet = PokerTable[tableid][pkrActiveBet] - CurrentBet[playerid];

				if(actualBet > Chips[playerid]) 
				{
					PokerTable[tableid][pkrPot] += Chips[playerid];
					Chips[playerid] = 0;
					CurrentBet[playerid] = PokerTable[tableid][pkrActiveBet];
				} 
				else 
				{
					PokerTable[tableid][pkrPot] += actualBet;
					Chips[playerid] -= actualBet;
					CurrentBet[playerid] = PokerTable[tableid][pkrActiveBet];
				}

				strcpy(StatusString[playerid], "Call", 16);
				PokerRotateActivePlayer(tableid);

				ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
			}

			ActionChoice[playerid] = false;
		}
		case DIALOG_CGAMESRAISEPOKER:
		{
			if(response) 
			{
				new 
					tableid = PlayingTableID[playerid],
					actualRaise = strval(inputtext) - CurrentBet[playerid];

				if( strval(inputtext) >= (PokerTable[tableid][pkrActiveBet] + (PokerTable[tableid][pkrBlind]/2)) 
					&& strval(inputtext) <= (CurrentBet[playerid] + Chips[playerid]) ) 
				{
					PokerTable[tableid][pkrPot] += actualRaise;
					Chips[playerid] -= actualRaise;

					PokerTable[tableid][pkrActiveBet] = strval(inputtext);
					CurrentBet[playerid] = PokerTable[tableid][pkrActiveBet];
					strcpy(StatusString[playerid], "Raise", 16);

					PokerTable[tableid][pkrRotations] = 0;
					PokerRotateActivePlayer(tableid);

					ApplyAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);
				} 
				else ShowCasinoGamesMenu(playerid, DIALOG_CGAMESRAISEPOKER);
			}

			ActionChoice[playerid] = false;
		}
	}
	return 1;
}
