/*
				  _____           _     _       
				 |  __ \         | |   (_)      
				 | |  | |_ __ ___| |__  _ _ __  
				 | |  | | '__/ _ \ '_ \| | '_ \ 
				 | |__| | | |  __/ |_) | | | | |
				 |_____/|_|  \___|_.__/|_|_| |_|
							©Drebin 2013-2014
							Thanks to AIped for helping!
		http://forum.sa-mp.com/showthread.php?p=2518564#post2518564
*/

#include <a_samp>

new PlayerText:ptd_box[MAX_PLAYERS];
new PlayerText:ptd_panel[MAX_PLAYERS][8][8];
new PlayerText:ptd_indicator[MAX_PLAYERS];
new ptd_shown[MAX_PLAYERS] = -1;
new ptd_posX[MAX_PLAYERS];
new ptd_posY[MAX_PLAYERS];

new panelcolors[16][8]= {
 //new sa-mp 0.3x HEX Values car colors to set each textdraw's color, sorted by row and column
{0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF},
{0x8A4DBDFF, 0x35963AFF,0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF}, 
{0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF},
{0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,0x992E1EFF, 0x2C1E08FF},
{0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF},
{0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF},
{0x8D4C8DFF, 0x805B80FF,0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF},
{0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF},
{0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,0x2B3C99FF, 0x3A3A0BFF}, 
{0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF},
{0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF}, 
{0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF},
{0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF},
{0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF}, 
{0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF},
{0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF}
};

new carcolids[16][8] = { //Vehicle color IDs shown in the dialog sorted by row and column
{128,   129,    130,    131,    132,    133,    134,    135},
{136,   137,    138,    139,    140,    141,    142,    143},
{144,   145,    146,    147,    148,    149,    150,    151},
{152,   153,    154,    155,    156,    157,    158,    159},
{160,   161,    162,    163,    164,    165,    166,    167},
{168,   169,    170,    171,    172,    173,    174,    175},
{176,   177,    178,    179,    180,    181,    182,    183},
{184,   185,    186,    187,    188,    189,    190,    191},   
{192,   193,    194,    195,    196,    197,    198,    199},   
{200,   201,    202,    203,    204,    205,    206,    207},   
{208,   209,    210,    211,    212,    213,    214,    215},   
{216,   217,    218,    219,    220,    221,    222,    223},   
{224,   225,    226,    227,    228,    229,    230,    231},   
{232,   233,    234,    235,    236,    237,    238,    239},   
{240,   241,    242,    243,    244,    245,    246,    247},   
{248,   249,    250,    251,    252,    253,    254,    255}        
};

//Offsets used to calculate the spacing between each of the colors used in the dialog + offsets for cursor movements
#define OFFSET_COL_X		25.6 //The distance from "2" to "1" on the X axis. Y axis level doesn't change (they have an identical X axis value)
#define OFFSET_ROW_Y		24.0 //The distance from "3" to "1" on the Y axis. X axis level doesn't change (they have an identical Y axis value)
#define OFFSET_INDICATOR_X	25.6 //The X value the dialog cursor has to be moved on the X axis to get to the next color (Y value doesn't change when moving horizontally)
#define OFFSET_INDICATOR_Y	24.0 //The Y value the dialog cursor has to be moved on the Y axis to get to the next color (X value doesn't change when moving vertically)
//     OFFSETS
//	1  2  -  -  -  -  -  -
//	3  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -
//	-  -  -  -  -  -  -  -

#define CURSOR_MOVE_UP		0
#define CURSOR_MOVE_DOWN	1
#define CURSOR_MOVE_LEFT	2
#define CURSOR_MOVE_RIGHT	3

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

forward OnPlayerChangeSelectedColor(playerid, column, row);
forward OnPlayerSelectColor(playerid, column, row);

forward ShowPlayerColorSelectDialog(playerid);
forward HidePlayerColorSelectDialog(playerid);
forward MoveColorDialogCursor(playerid, direction);
forward SelectCurrentColor(playerid);
forward CreateColorSelectionDialog(playerid);
forward DestroyColorSelectionDialog(playerid);
forward GetColorFromPosition(column, row, bool:car);

//RGBA to ARGB
stock ShiftRGBAToARGB(color) {
    return color >>> 8 | color << 24;
}

public ShowPlayerColorSelectDialog(playerid)
{
	PlayerTextDrawShow(playerid, ptd_box[playerid]);
	PlayerTextDrawShow(playerid, ptd_indicator[playerid]);
	for(new i = 0; i < 8; i++) //Loop through every row
	{
		for(new k = 0; k < 8; k++) //Loop through every column
			PlayerTextDrawShow(playerid, ptd_panel[playerid][i][k]); //Show the textdraw
	}
	ptd_posX[playerid] = 0;
	ptd_posY[playerid] = 0;
	ptd_shown[playerid] = 1;
	return 1;
}

public HidePlayerColorSelectDialog(playerid)
{
	SetPaintTDIndicatorPos(playerid, 0, 0); //Reset the cursor to the top left corner of the dialog for next use
	PlayerTextDrawHide(playerid, ptd_box[playerid]);
	PlayerTextDrawHide(playerid, ptd_indicator[playerid]);
	for(new i = 0; i < 8; i++) //Loop through every row
	{
		for(new k = 0; k < 8; k++) //Loop through every column
			PlayerTextDrawHide(playerid, ptd_panel[playerid][i][k]); //Hide the textdraw
	}
	ptd_posX[playerid] = -1;
	ptd_posY[playerid] = -1;
	ptd_shown[playerid] = 0;
	return 1;
}

public MoveColorDialogCursor(playerid, direction)
{
	if(!ptd_shown[playerid]) return 0;
	switch(direction)
	{
		case CURSOR_MOVE_UP: //Cursor should be moved up
		{
			if(ptd_posY[playerid] != 0) //Cursor's current position is not in the top row (if it was it couldn't move up any further)
			{
				SetPaintTDIndicatorPos(playerid, ptd_posX[playerid], ptd_posY[playerid] - 1); //Move the cursor up one row (Y axis)
				OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
			}
		}
		case CURSOR_MOVE_DOWN: //Cursor should be moved down
		{
			if(ptd_posY[playerid] != 7) //Cursor's current position is not in the bottom row (if it was it couldn't move down any further)
			{
				SetPaintTDIndicatorPos(playerid, ptd_posX[playerid], ptd_posY[playerid] + 1); //Move the cursor down one row (Y axis)
				OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
			}
		}
		case CURSOR_MOVE_LEFT: //Cursor should be moved left
		{
			if(ptd_posX[playerid] == 0) //Cursor is in the very left column
			{
				if(ptd_posY[playerid] != 0) //Cursor is also not in the top row (if it was, it couldn't move up or left)
				{
					SetPaintTDIndicatorPos(playerid, 7, ptd_posY[playerid] - 1); //Move cursor up one row and set it to into the very right column
					OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
				}
			}
			else //Cursor is not in the very left column
			{
				SetPaintTDIndicatorPos(playerid, ptd_posX[playerid] - 1, ptd_posY[playerid]); //Move cursor left one column
				OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
			}
		}
		case CURSOR_MOVE_RIGHT: //Cursor should be moved right
		{
			if(ptd_posX[playerid] == 7) //Cursor is in the very right column
			{
				if(ptd_posY[playerid] != 7) //Cursor is also not in the bottom row (if it was, it couldn't move down or right)
				{
					SetPaintTDIndicatorPos(playerid, 0, ptd_posY[playerid] + 1); //Move cursor down one row and set it to into the very left column
					OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
				}
			}
			else
			{
				SetPaintTDIndicatorPos(playerid, ptd_posX[playerid] + 1, ptd_posY[playerid]); //Move cursor right one column
				OnPlayerChangeSelectedColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
			}
		}
	}
	return 1;
}

public SelectCurrentColor(playerid) //Select the color the cursor has currently selected
{
	if(ptd_shown[playerid])
		OnPlayerSelectColor(playerid, ptd_posX[playerid], ptd_posY[playerid]);
}

public CreateColorSelectionDialog(playerid) //Create the color dialog
{
	ptd_box[playerid] = CreatePlayerTextDraw(playerid, 132.0, 147.0, "_");
	PlayerTextDrawAlignment(playerid, ptd_box[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ptd_box[playerid], 0.5, 20.900007);
	PlayerTextDrawSetProportional(playerid, ptd_box[playerid], 1);
	PlayerTextDrawUseBox(playerid, ptd_box[playerid], 1);
	PlayerTextDrawBoxColor(playerid, ptd_box[playerid], 0x00000078);
	PlayerTextDrawTextSize(playerid, ptd_box[playerid], 2.0, 201.0);
	
	ptd_indicator[playerid] = CreatePlayerTextDraw(playerid, 42.000000, 147.000000, "_");
	PlayerTextDrawAlignment(playerid, ptd_indicator[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ptd_indicator[playerid], 0.500000, 2.199999);
	PlayerTextDrawSetProportional(playerid, ptd_indicator[playerid], 1);
	PlayerTextDrawUseBox(playerid, ptd_indicator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, ptd_indicator[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, ptd_indicator[playerid], 0.000000, 21.000000);
	
	for(new row = 0; row < 8; row++)
	{
		for(new col = 0; col < 8; col++)
		{
			ptd_panel[playerid][row][col] = CreatePlayerTextDraw(playerid, 42.0 + (col * OFFSET_COL_X), 150.0 + (row * OFFSET_ROW_Y), "_");
			PlayerTextDrawAlignment(playerid, ptd_panel[playerid][row][col], 2);
			PlayerTextDrawLetterSize(playerid, ptd_panel[playerid][row][col], 0.5, 1.5);
			PlayerTextDrawSetProportional(playerid, ptd_panel[playerid][row][col], 1);
			PlayerTextDrawUseBox(playerid, ptd_panel[playerid][row][col], 1);
			PlayerTextDrawBoxColor(playerid, ptd_panel[playerid][row][col], panelcolors[row][col]);
			PlayerTextDrawTextSize(playerid, ptd_panel[playerid][row][col], 0.00, 15.0);
		}
	}
	return 1;
}

public DestroyColorSelectionDialog(playerid) //Destroy the dialog
{
	PlayerTextDrawDestroy(playerid, ptd_box[playerid]);
	PlayerTextDrawDestroy(playerid, ptd_indicator[playerid]);
	for(new i = 0; i < 8; i++)
	{
		for(new k = 0; k < 8; k++)
			PlayerTextDrawDestroy(playerid, ptd_panel[playerid][i][k]);
	}
	return 1;
}

public GetColorFromPosition(column, row, bool:car) //Get the color ID from the column and row the cursor is in
	return car ? carcolids[row][column] : panelcolors[row][column];
	
	
//Internal function
stock SetPaintTDIndicatorPos(playerid, column, row) //Set the exact position of the cursor
{
	PlayerTextDrawDestroy(playerid, ptd_indicator[playerid]);
	ptd_indicator[playerid] = CreatePlayerTextDraw(playerid, 42.000000 + (column * OFFSET_INDICATOR_X), 147.000000 + (row * OFFSET_INDICATOR_Y), "_");
	PlayerTextDrawAlignment(playerid, ptd_indicator[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ptd_indicator[playerid], 0.500000, 2.199999);
	PlayerTextDrawSetProportional(playerid, ptd_indicator[playerid], 1);
	PlayerTextDrawUseBox(playerid, ptd_indicator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, ptd_indicator[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, ptd_indicator[playerid], 0.000000, 21.000000);
	
	PlayerTextDrawDestroy(playerid, ptd_panel[playerid][row][column]);
	ptd_panel[playerid][row][column] = CreatePlayerTextDraw(playerid, 42.0 + (column * OFFSET_COL_X), 150.0 + (row * OFFSET_ROW_Y), "_");
	PlayerTextDrawAlignment(playerid, ptd_panel[playerid][row][column], 2);
	PlayerTextDrawLetterSize(playerid, ptd_panel[playerid][row][column], 0.5, 1.5);
	PlayerTextDrawSetProportional(playerid, ptd_panel[playerid][row][column], 1);
	PlayerTextDrawUseBox(playerid, ptd_panel[playerid][row][column], 1);
	PlayerTextDrawBoxColor(playerid, ptd_panel[playerid][row][column], panelcolors[row][column]);
	PlayerTextDrawTextSize(playerid, ptd_panel[playerid][row][column], 0.00, 15.0);
	
	PlayerTextDrawShow(playerid, ptd_indicator[playerid]);
	PlayerTextDrawShow(playerid, ptd_panel[playerid][row][column]);
	
	ptd_posX[playerid] = column;
	ptd_posY[playerid] = row;
	return 1;
}