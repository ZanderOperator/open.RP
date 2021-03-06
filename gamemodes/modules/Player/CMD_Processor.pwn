// Main CMD processor callback - when server recieves command that player wrote

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	if(strlen(cmdtext) > 128)
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Command can't be more than 128 chars long!");
		return COMMAND_ZERO_RET;
	}
	switch(success)
	{
		case COMMAND_OK:
		{
			if(!IsPlayerConnected(playerid))
				return COMMAND_ZERO_RET;

			if(!Player_SafeSpawned(playerid) || Player_SecurityBreach(playerid))
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR,"You're not safely spawned, you can't use commands!");
				return COMMAND_ZERO_RET;
			}
			if(!cmdtext[0])
			{
				Kick(playerid); // Because it's impossible to send valid NULL command
				return COMMAND_ZERO_RET;
			}

			#if defined MODULE_LOGS
			if(!IsPlayerAdmin(playerid))
			{
				Log_Write("logfiles/cmd_timestamp.txt", 
					"(%s)Player %s[%d]{%d}(%s) used command '%s'.",
					ReturnDate(),
					GetName(playerid, false),
					playerid,
					PlayerInfo[playerid][pSQLID],
					ReturnPlayerIP(playerid),
					cmdtext
				);
			}
			#endif
			
			return COMMAND_OK;
		}
		case COMMAND_UNDEFINED:
		{
			va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Command '%s' does not exist!", cmdtext);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/cmd_unknown.txt", 
				"(%s)Player %s[%d]{%d}(%s) used non-existing command '%s'.",
				ReturnDate(),
				GetName(playerid, false),
				playerid,
				PlayerInfo[playerid][pSQLID],
				ReturnPlayerIP(playerid),
				cmdtext
			);
			#endif
			
			return COMMAND_ZERO_RET;
		}
		case COMMAND_NO_PLAYER:
		{
			#if defined MODULE_LOGS
			Log_Write("logfiles/cmd_timestamp.txt",
				 "(%s)Player %s unsucessfuly used command %s [Error: He shouldn't exist?].",
				ReturnDate(),
				GetName(playerid, false),
				cmdtext
			);
			#endif
			return COMMAND_ZERO_RET;
		}
		case COMMAND_BAD_PREFIX, COMMAND_INVALID_INPUT:
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR,"You have entered wrong prefix / format of the command!");
			return COMMAND_ZERO_RET;
		}
	}
	if(!success)
	{
		#if defined MODULE_LOGS
		Log_Write("logfiles/cmd_timestamp.txt", 
			"(%s)Player %s used a command %s and it wasn't executed.",
			ReturnDate(),
			GetName(playerid, false),
			cmdtext
		);
		#endif
		return COMMAND_ZERO_RET;
	}
	return COMMAND_OK;
}

hook OnGameModeInit()
{
		// Alternative Commands
	Command_AddAltNamed("whisper"		, 	"w");
	Command_AddAltNamed("hangup"		, 	"h");
	Command_AddAltNamed("speakerphone"	, 	"sf");
	Command_AddAltNamed("doorshout"		, 	"ds");
	Command_AddAltNamed("close"			, 	"c");
	Command_AddAltNamed("shout"			, 	"s");
	Command_AddAltNamed("carwhisper"	, 	"cw");
	Command_AddAltNamed("backup"		, 	"bk");
	Command_AddAltNamed("admin"			, 	"a");
    Command_AddAltNamed("clearchat"		, 	"cc");
	Command_AddAltNamed("pocketsteal"	, 	"psteal");
	Command_AddAltNamed("animations"	, 	"anims");
	Command_AddAltNamed("cryptotext"	, 	"ct");
    Command_AddAltNamed("experience"	, 	"exp");
	Command_AddAltNamed("radio"			, 	"r");
	Command_AddAltNamed("radiolow"		, 	"rlow");
	Command_AddAltNamed("beanbag"		, 	"bb");
	Command_AddAltNamed("tazer"			, 	"ta");
	Command_AddAltNamed("acceptreport"	, 	"ar");
	Command_AddAltNamed("disregardreport", 	"dr");
	Command_AddAltNamed("unblacklist"	, 	"unbl");
	Command_AddAltNamed("blacklist"		, 	"bl");
	
	print("Report: Alternative Commands Added.");
	return 1;
}