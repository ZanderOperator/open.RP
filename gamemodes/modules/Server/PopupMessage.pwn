#include <YSI_Coding\y_hooks>

/*
	- Consts & Enums
*/

const MAX_LINE_MESSAGE_LENGTH =  90; // 90 chars in 1 line of TextDraw

enum 
{
	MESSAGE_TYPE_NONE = 0,
	MESSAGE_TYPE_ERROR,
	MESSAGE_TYPE_INFO,
	MESSAGE_TYPE_SUCCESS
};

/*
	- Vars(32bit)
*/

static
	bool: _PopUpActivated[MAX_PLAYERS] = { false, ... },
	Timer: PopUpTimer[MAX_PLAYERS],
	PlayerText:MessageTextdraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	- Functions
*/

static CreateMessage(playerid, bool: status) 
{
	if(status == false)
		PlayerTextDrawHide(playerid, MessageTextdraw[playerid]);

	else if(status == true) 
	{
		MessageTextdraw[playerid] = CreatePlayerTextDraw(playerid, 328.000091, 350.947723, "");
		PlayerTextDrawLetterSize(playerid, MessageTextdraw[playerid], 0.248749, 1.020959);
		PlayerTextDrawAlignment(playerid, MessageTextdraw[playerid], 2);
		PlayerTextDrawColor(playerid, MessageTextdraw[playerid], -1);
		PlayerTextDrawSetShadow(playerid, MessageTextdraw[playerid], 1);
		PlayerTextDrawSetOutline(playerid, MessageTextdraw[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MessageTextdraw[playerid], 255);
		PlayerTextDrawFont(playerid, MessageTextdraw[playerid], 1);
		PlayerTextDrawSetProportional(playerid, MessageTextdraw[playerid], true);
		PlayerTextDrawShow(playerid, MessageTextdraw[playerid]);
	}
	return 1;
}

static GetMessagePrefix(MESSAGE_TYPE = MESSAGE_TYPE_NONE) 
{
	new 
		prefix[10];
	switch(MESSAGE_TYPE) 
	{
		case MESSAGE_TYPE_ERROR: prefix = "~r~~h~!";
		case MESSAGE_TYPE_INFO: prefix = "~y~!";
		case MESSAGE_TYPE_SUCCESS: prefix = "~g~~h~!";
	}
	return prefix;
}

static DetermineMessageDuration(const message[])
{
    // Calculate the amount of time needed to read the notification '''
    new wpm = 180, // Readable words per minute
		word_length = 5, // Standardized number of chars in calculable word
		words = strlen(message)/word_length, // word_length
		words_time = ((words/wpm)*60)*1000,
		delay = 1500,  // Milliseconds before user starts reading the notification
		bonus = 2500;  // Extra time

    return delay + words_time + bonus;
}

timer RemoveMessage[1000](playerid) 
{
	if(_PopUpActivated[playerid] == true)
		PlayerTextDrawHide(playerid, MessageTextdraw[playerid]);
		
	_PopUpActivated[playerid] = false;
	CreateMessage(playerid, false);
	stop PopUpTimer[playerid];
	return 1;
}

static SendTextDrawMessage(playerid, MESSAGE_TYPE, const message[])
{
    new 
		len = strlen(message),
		final_msg[256];
	
	if(_PopUpActivated[playerid] == true)
		PlayerTextDrawHide(playerid, MessageTextdraw[playerid]);
	
	CreateMessage(playerid, true);	
    if(len >= MAX_LINE_MESSAGE_LENGTH)
    {
		new	
			spacepos = 0, 
			broken = false;
			
		for(new j = MAX_LINE_MESSAGE_LENGTH - 20; j < len; j++)
		{
			if(message[j] == ' ')
				spacepos = j;

			if(j >= MAX_LINE_MESSAGE_LENGTH && spacepos >= MAX_LINE_MESSAGE_LENGTH - 20)
			{
				broken = true;
				break;
			}
		}
		if(broken)
		{			
			format(final_msg, 
				sizeof(final_msg), 
				"%s: ~w~%.*s~n~%s~n~", 
				GetMessagePrefix(MESSAGE_TYPE),
				spacepos,
				message, 
				message[spacepos + 1]
			);
		}
	}
    else format(final_msg, sizeof(final_msg), "%s: ~w~%s", GetMessagePrefix(MESSAGE_TYPE), message);
	stop PopUpTimer[playerid];

	new 
		messagetime = DetermineMessageDuration(message);
	PopUpTimer[playerid] = defer RemoveMessage[messagetime](playerid);
	return PlayerTextDrawSetString(playerid, MessageTextdraw[playerid], final_msg);
}

stock va_SendMessage(playerid, MESSAGE_TYPE = MESSAGE_TYPE_NONE, const message[], va_args<>) 
{	
	if(MESSAGE_TYPE == MESSAGE_TYPE_NONE)
		return 1;

	new 
		format_message[256];
	_PopUpActivated[playerid] = true;
	va_format(format_message, sizeof (format_message), message, va_start<3>);
	return SendTextDrawMessage(playerid, MESSAGE_TYPE, format_message);
}

stock SendMessage(playerid, MESSAGE_TYPE = MESSAGE_TYPE_NONE, message[])  
{	
	if(MESSAGE_TYPE == MESSAGE_TYPE_NONE)
		return 1;
	
	_PopUpActivated[playerid] = true;	
	return SendTextDrawMessage(playerid, MESSAGE_TYPE, message);
}

/*
	- Hooks
*/

hook OnPlayerDisconnect(playerid, reason) 
{
	_PopUpActivated[playerid] = false;
	CreateMessage(playerid, false);
	stop PopUpTimer[playerid];
	return 1;
}