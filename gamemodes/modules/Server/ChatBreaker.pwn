// ChatBreaker include v1.3 by Zander Operator 
#include <YSI_Coding\y_va>

const LINE_BREAKING_LENGTH = 90;

stock SendSplitMessage(playerid, color, const msgstring[])
{
    new 
		len = strlen(msgstring);
    if(len >= LINE_BREAKING_LENGTH)
    {
		new 
			colorstring[9] = EOS, 
			colorstart = 0, 
			colorend = 0,	
			spacepos = 0, 
			bool:broken = false;

		for(new j = (LINE_BREAKING_LENGTH - 20); j < len; j++)
		{
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(msgstring[j] == ' ')
				spacepos = j;

			if(j >= LINE_BREAKING_LENGTH && spacepos >= (LINE_BREAKING_LENGTH - 20) && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;

				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));

				va_SendClientMessage(playerid, color, "%.*s...", spacepos, msgstring);
				va_SendClientMessage(playerid, color, "%s...%s", colorstring, msgstring[spacepos+1]);
				return 1;
			}
		}
		if(!broken)
			SendClientMessage(playerid, color, msgstring);
	}
    else return SendClientMessage(playerid, color, msgstring);
	return 1;
}

AC_SendClientMessage(playerid, color, const message[])
{
	SendSplitMessage(playerid, color, message);
	return 1;
}
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage AC_SendClientMessage

stock SendSplitMessageToAll(color, const msgstring[])
{
    new 
		len = strlen(msgstring);
    if(len >= LINE_BREAKING_LENGTH)
    {
		new 
			colorstring[9] = EOS, 
			colorstart = 0, 
			colorend = 0,	
			spacepos = 0, 
			bool:broken=false;

		for(new j = 60; j < len; j++)
		{
			if(msgstring[j] == ' ')
				spacepos = j;
			
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(j >= LINE_BREAKING_LENGTH && spacepos >= (LINE_BREAKING_LENGTH - 20) && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;
                
				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));

				va_SendClientMessageToAll(color, "%.*s...", spacepos, msgstring);
				va_SendClientMessageToAll(color, "%s...%s", colorstring, msgstring[spacepos+1]);
				return 1;
			}
		}
		if(!broken)
			SendClientMessageToAll(color, msgstring);
	}
    else return SendClientMessageToAll(color, msgstring);
	return 1;
}

AC_SendClientMessageToAll(color, const message[])
{
	SendSplitMessageToAll(color, message);
	return 1;
}
#if defined _ALS_SendClientMessageToAll
    #undef SendClientMessageToAll
#else
    #define _ALS_SendClientMessageToAll
#endif
#define SendClientMessageToAll AC_SendClientMessageToAll