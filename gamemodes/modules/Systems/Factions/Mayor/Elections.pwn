#if defined MODULE_MAYOR_ELECTION
    #endinput
#endif
#define MODULE_MAYOR_ELECTION

/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static bool:lockvotes = true;


/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

// TODO: convert to threaded queries, use y_inline
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_FOR_ELECTIONS:
        {
            if(!response) return 1;

            ShowPlayerDialog(playerid, DIALOG_ELECTIONS_VOTE, DIALOG_STYLE_LIST, "Glasanje", "Za\nProtiv", "Zaokruzi", "Izadji");
            return 1;
        }
        case DIALOG_ELECTIONS_VOTE:
        {
            if(!response) return 1;

            new string[256];
            switch (listitem)
            {
                case 0:
                {
                    // TODO: translate fields and text in database to English
                    format(string, sizeof(string), "SELECT glasovi FROM elections WHERE opcija = 'Za'");
                    mysql_query(g_SQL, string);

                    new votes;
                    cache_get_value_name_int(0, "glasovi", votes);
                    votes++;

                    PlayerInfo[playerid][pVoted] = 1;
                    va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno si dao svoj glas, trenutno je %d glasova ZA.", votes);

                    format(string, sizeof(string), "%s ubacuje svoj listic u glasacku kutiju.", GetName(playerid, false));
                    ProxDetector(25.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);

                    mysql_fquery(g_SQL,"UPDATE elections SET glasovi = '%d' WHERE opcija = 'Za'", votes);
                }
                case 1:
                {
                    format(string, sizeof(string), "SELECT glasovi FROM elections WHERE opcija = 'Protiv'");
                    mysql_query(g_SQL, string);

                    new votes;
                    cache_get_value_name_int(0, "glasovi", votes);
                    votes++;

                    PlayerInfo[playerid][pVoted] = 1;
                    va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno si dao svoj glas, trenutno je %d glasova PROTIV.", votes);

                    format(string, sizeof(string), "%s ubacuje svoj listic u glasacku kutiju.", GetName(playerid, false));
                    ProxDetector(25.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);

                    mysql_fquery(g_SQL, "UPDATE elections SET glasovi = '%d' WHERE opcija = 'Protiv'", votes);
                }
            }
            return 1;
        }
    }
    return 0;
}

/*
     ######  ##     ## ########
    ##    ## ###   ### ##     ##
    ##       #### #### ##     ##
    ##       ## ### ## ##     ##
    ##       ##     ## ##     ##
    ##    ## ##     ## ##     ##
     ######  ##     ## ########
*/

CMD:vote(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3, 1299.5887, 764.5737, -98.6427)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazis se pored kutije za glasanje.(vijecnica)");
    if(PlayerInfo[playerid][pLevel] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 3+ da bi mogao koristiti ovu komandu");
    if(lockvotes == true) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Glasanje je trenutno zatvoreno.");
    if(PlayerInfo[playerid][pVoted] == 1) return SendClientMessage(playerid, COLOR_RED, "Vec si dao svoj glas");

    ShowPlayerDialog(playerid, DIALOG_FOR_ELECTIONS, DIALOG_STYLE_MSGBOX, "Glasanje", "Referendumom Los Santos vrsi zadnji korak prema ocjepljenju od\n drzave San Andreas, ukoliko podrzavate referendum zaokruzite 'Za'\n a ukoliko ste protiv ocjepljenja zaokruzite 'Protiv'.", "Ok", "Izadji");
    return 1;
}
CMD:votes(playerid, params[])
{
    new option[32];
    if(sscanf(params, "s[32]", option)) return SendClientMessage(playerid, COLOR_WHITE, "[?]: /votes [lock, check]");

    if(!strcmp(option, "lock", true))
    {
        if(PlayerFaction[playerid][pLeader] != 4)
        {
             SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo gradonacelnik moze koristiti ovu komandu.");
             return 1;
        }

        lockvotes = !lockvotes;
        va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno si %s glasovanje.",
            (lockvotes) ? ("zakljucao") : ("otkljucao")
       );
        return 1;
    }
    else if(!strcmp(option, "check", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 4)
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
            return 1;
        }

        new
            query[60],
            votes;

        // Votes FOR
        format(query, sizeof(query), "SELECT glasovi FROM elections WHERE opcija = 'Za'");
        mysql_query(g_SQL, query);
        cache_get_value_name_int(0, "glasovi", votes);

        SendClientMessage(playerid, COLOR_ORANGE, "*__________________________VOTE STATUS__________________________");
        va_SendClientMessage(playerid, COLOR_GREY, "Glasovi ZA: %d", query);

        // Votes AGAINST
        format(query, sizeof(query), "SELECT glasovi FROM elections WHERE opcija = 'Protiv'");
        mysql_query(g_SQL, query);
        cache_get_value_name_int(0, "glasovi", votes);

        SendClientMessage(playerid, COLOR_ORANGE, "*__________________________VOTE STATUS__________________________");
        va_SendClientMessage(playerid, COLOR_GREY, "Glasovi PROTIV: %d", query);
        return 1;
    }
    return 1;
}
