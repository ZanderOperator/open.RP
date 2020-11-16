#include <YSI_Coding\y_hooks>

new DCC_Channel:g_Discord_Chat;
hook OnGameModetInit()
{
	g_Discord_Chat = DCC_FindChannelById("701768161418280960");
    return 1;
}
forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == g_Discord_Chat && !IsBot)
    {
        new user_name[32 + 1], str[152];
       	DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "{FA5656}[CoA.RP] %s: %s",user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }
    return 1;
}

hook OnPlayerText(playerid, text[])
{
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    new msg[128];
    format(msg, sizeof(msg), "%s: %s", name, text);
    DCC_SendChannelMessage(g_Discord_Chat, msg);
    return 1;
}
hook OnPlayerConnect(playerid)
{
   	new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    if (_:g_Discord_Chat == 0)
    g_Discord_Chat = DCC_FindChannelById("701768161418280960");
    new string[128];
    format(string, sizeof string, " %s se pridruzio serveru. :)", name);
    DCC_SendChannelMessage(g_Discord_Chat, string);
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    if (_:g_Discord_Chat == 0)
    g_Discord_Chat = DCC_FindChannelById("701768161418280960");
    new string[128];
    format(string, sizeof string, " %s je napustio server. :(", name);
    DCC_SendChannelMessage(g_Discord_Chat, string);
    return 1;
}
