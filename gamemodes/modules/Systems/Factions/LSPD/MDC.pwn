/*
                                                     
              |         |                            
,-.-.,---.,---|,---.    |---.,   .    . . .,---.,---.
| | |,---||   ||---'    |   ||   |    | | ||   ||   |
 ' '---^---'---'    ---'---|    -'-'---'---'
                             ---'
APB % MDC
NOTES:
OBRISATI U COARP LoadAPBData()
ISKOMENTIRATI U COARP Modul apb.pwn
TRUNCATE U PHPMYADMIN APB TABLICU
ISKOMENTRATI U COARP MODUL arrestrecords.pwn
APB suspect i pdname prebaciti u VARCHAR 24
- last update: 12.11.2019 - by Logan
 */
#if defined MODULE_MDC
    #endinput
#endif
#define MODULE_MDC

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

enum E_JAIL_DATA
{
    jSuspectName[MAX_PLAYER_NAME],
    jPoliceName[MAX_PLAYER_NAME],
    jSQLID,
    jReason[24],
    jTime,
    jDate[32]
}

static
    JailInfo[MAX_PLAYERS][E_JAIL_DATA];

static
    PlayerText:MDCBg1          [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCBg2          [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCHeader       [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCSkin         [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCText1        [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCProfileText  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCText2        [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCOtherText    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCRecordButton [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCVehButton    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCTicketsButton[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCGeneralButton[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCAPBButton    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:MDCCloseButton  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

static
    TargetName      [MAX_PLAYERS][MAX_PLAYER_NAME],
    DeletingRecordID[MAX_PLAYERS],
    DeletingTicketID[MAX_PLAYERS];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

// Mobile Number
static GetPlayerPhoneNumber(sqlid)
{
    new Cache:result,
        number = 0,
        numberstr[12];

    result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT number FROM player_phones WHERE player_id = '%d' AND type = '1'", sqlid));
    cache_get_value_index_int(0, 0, number);
    cache_delete(result);

    if(number == 0)
        format(numberstr, sizeof(numberstr), "Ne postoji");
    else
        format(numberstr, sizeof(numberstr), "%d", number);
    return numberstr;
}

// MySQL Callbacks

// Player GENERAL
static OnPlayerMDCDataLoad(playerid, const playername[], sqlid)
{
    inline OnPlayerMDCLoad()
    {
        if(!cache_num_rows())
            return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, " Korisnik %s ne postoji!", playername);

        new
            loadInfo[E_PLAYER_DATA],
            jailInfo[E_P_JAIL_INFO],
            licInfo[E_LICENSES_INFO],
            lookInfo[E_PLAYER_APPEARANCE],
            housekey = INVALID_HOUSE_ID;

        // accounts table
        cache_get_value_name_int(0, "sqlid"         , loadInfo[pSQLID]);
        cache_get_value_name_int(0, "sex"           , loadInfo[pSex]);
        cache_get_value_name_int(0, "age"           , loadInfo[pAge]);

        // player_jailed table
        cache_get_value_name_int(0, "jailed"        , jailInfo[pJailed]);
        cache_get_value_name_int(0, "jailtime"      , jailInfo[pJailTime]);
        cache_get_value_name_int(0, "arrested"      , jailInfo[pArrested]);
        cache_get_value_name_int(0, "bailprice"     , jailInfo[pBailPrice]);

        // player_licenses
        cache_get_value_name_int(0, "carlic"        , licInfo[pCarLic]);
        cache_get_value_name_int(0, "gunlic"        , licInfo[pGunLic]);
        cache_get_value_name_int(0, "boatlic"       , licInfo[pBoatLic]);
        cache_get_value_name_int(0, "fishlic"       , licInfo[pFishLic]);
        cache_get_value_name_int(0, "flylic"        , licInfo[pFlyLic]);
        cache_get_value_name_int(0, "passport"      , licInfo[pPassport]);

        cache_get_value_name_int(0, "char"          , lookInfo[pTmpSkin]);
        cache_get_value_name    (0, "look"          , lookInfo[pLook]);

        housekey = GetHouseFromSQL(loadInfo[pSQLID]);

        new
            mdcString[512],
            mdcString2[2048],
            tmpString[64],
            tmpAddress[32],
            tmpLook[60],
            tmpLook2[60],
            tmpGunLic[12];

        ( housekey != INVALID_HOUSE_ID) && format(tmpAddress, 32, HouseInfo[housekey][hAdress]) || format(tmpAddress, 32, "N/A");
        if(strlen(lookInfo[pLook]) > 60)
        {
            format(tmpLook, sizeof(tmpLook), "%.60s", lookInfo[pLook]);
            format(tmpLook2, sizeof(tmpLook2), "%s", lookInfo[pLook][60]);
        }
        else
        {
            format(tmpLook, sizeof(tmpLook), "%s", lookInfo[pLook]);
            format(tmpLook2, sizeof(tmpLook2), "\n", lookInfo[pLook][60]);
        }
        
        format(mdcString, sizeof(mdcString),
            "Profile: %s~n~Address: %s~n~Phone Number: %s~n~Sex: %s~n~Age: %d~n~~g~Desc.:~l~ ~n~%s~n~%s~n~",
            playername,
            tmpAddress,
            GetPlayerPhoneNumber(loadInfo[pSQLID]),
            loadInfo[pSex] == 1 ? ("~h~~b~Male~l~") : ("~h~~p~Female~l~"),
            loadInfo[pAge],
            tmpLook,
            tmpLook2
       );

        tmpGunLic = (licInfo[pGunLic] == 1) ? ("~b~CCW~l~") : ((licInfo[pGunLic] == 2) ? ("~g~CCW~l~") : ("~r~No~l~"));
        format(mdcString2, sizeof(mdcString2),
            "~b~CURRENT STATUS~l~~n~Jailed: %s~n~Jail time: %d h~n~Arrested: %d~n~Bail price: %d~n~~n~~b~LICENSES~l~~n~Drivers: %s~n~Weapon: %s~n~Boat: %s~n~Fish: %s~n~Pilot: %s~n~Passport: %s",
            jailInfo[pJailed] == 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
            jailInfo[pJailTime],
            jailInfo[pArrested],
            jailInfo[pBailPrice],
            licInfo[pCarLic]  >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
            tmpGunLic,
            licInfo[pBoatLic] >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
            licInfo[pFishLic] >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
            licInfo[pFlyLic]  >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
            licInfo[pPassport]  >= 1 ? ("~g~Yes~l~") : ("~r~No~l~")
       );

        CreateMDCTextDraws(playerid, lookInfo[pTmpSkin], false);
        PlayerTextDrawSetString(playerid, MDCProfileText[playerid], mdcString);
        PlayerTextDrawSetString(playerid, MDCOtherText[playerid], mdcString2);
        format(tmpString, sizeof(tmpString), "MDC_PROFILE-_%s", playername);
        PlayerTextDrawSetString(playerid, MDCHeader[playerid], tmpString);
        SelectTextDraw(playerid, 0x427AF4FF);
    }
        
    MySQL_PQueryInline(SQL_Handle(),  
		using inline OnPlayerMDCLoad, 
        va_fquery(SQL_Handle(), 
            "SELECT \n\
                accounts.sqlid, accounts.sex, accounts.age \n\
                player_jail.*, \n\
                player_licenses.*, \n\
                player_appearance.char, player_appearance.look\n\
            FROM \n\
                accounts, \n\
                player_jail, \n\
                player_licenses, \n\
                player_appearance \n\
            WHERE \n\
                accounts.sqlid = player_jail.sqlid = player_licenses.sqlid = player_appearance.sqlid = '%d'",
            sqlid
       ),
		""
	);
    return 1;
}

static OnPlayerArrestDataLoad(playerid, const playername[])
{
    inline OnArrestLoad()
    {
        new buffer[2048];
        if(!cache_num_rows())
        {
            format(buffer, sizeof(buffer), "~g~There_are_no_criminal_records!");
        }
        else
        {
            new
                tmpJail[E_JAIL_DATA],
                motd[256],
                tmp[32];

            format(buffer, sizeof(buffer), "~g~ID_-_OFFICER_-_REASON_-_TIME_-_DATE~n~~l~");
            for (new i = 0; i < cache_num_rows(); i++)
            {
                cache_get_value_name_int(i, "id", tmpJail[jSQLID]);
                cache_get_value_name(i,"policeman"  , tmp, sizeof(tmp));
                format(tmpJail[jPoliceName], MAX_PLAYER_NAME, tmp);
                cache_get_value_name(i,"reason" , tmp, sizeof(tmp));
                format(tmpJail[jReason], MAX_PLAYER_NAME, tmp);
                cache_get_value_name_int(i, "jailtime", tmpJail[jTime]);

                cache_get_value_name(i, "date", tmp, sizeof(tmp));
                format(tmpJail[jDate], 30, tmp);

                format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%d_-_%s~n~",
                    tmpJail[jSQLID],
                    tmpJail[jPoliceName],
                    tmpJail[jReason],
                    tmpJail[jTime],
                    tmpJail[jDate]
               );
                strcat(buffer, motd, sizeof(buffer));
            }
        }

        new
            tmpString[64];
        UpdateMDCTextDraws(playerid);
        format(tmpString, sizeof(tmpString), "CRIMINAL_RECORD", playername);
        PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
        PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
        SelectTextDraw(playerid, 0x427AF4FF);
    }
    MySQL_PQueryInline(SQL_Handle(),  
		using inline OnArrestLoad, 
		va_fquery(SQL_Handle(), "SELECT * FROM jail WHERE suspect = '%e'", playername),
		""
	);
    return 1;
}

// PLAYER TICKETS
static OnPlayerTicketsLoad(playerid, const playername[])
{
    inline OnTicketsLoad()
    {
        new buffer[2048];
        if(!cache_num_rows())
        {
            format(buffer, sizeof(buffer), "~g~There_are_no_traffic_tickets!");
        }
        else
        {
            new
                tmpID,
                tmpOfficer[MAX_PLAYER_NAME],
                tmpRazlog[32],
                tmpNovac,
                tmpDatum[30],
                motd[256],
                tmp[32];

            format(buffer, sizeof(buffer), "~g~ID_-_OFFICER_-_REASON_-_MONEY_-_DATE~n~~l~");
            for (new i = 0; i < cache_num_rows(); i++)
            {
                cache_get_value_name_int(i, "id", tmpID);

                cache_get_value_name(i,"officer"    , tmp, sizeof(tmp));
                format(tmpOfficer, MAX_PLAYER_NAME, tmp);

                cache_get_value_name(i,"razlog" , tmp, sizeof(tmp));
                format(tmpRazlog, 32, tmp);

                cache_get_value_name_int(i, "novac", tmpNovac);

                cache_get_value_name(i, "datum", tmp, sizeof(tmp));
                format(tmpDatum, 30, tmp);

                format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%d_-_%s~n~",
                    tmpID,
                    tmpOfficer,
                    tmpRazlog,
                    tmpNovac,
                    tmpDatum
               );
                strcat(buffer, motd, sizeof(buffer));
            }
        }

        new
            tmpString[32];
        UpdateMDCTextDraws(playerid);
        format(tmpString, sizeof(tmpString), "PERSONAL_TRAFFIC_TICKETS", playername);
        PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
        PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
        SelectTextDraw(playerid, 0x427AF4FF);
    }
    MySQL_TQueryInline(SQL_Handle(),  
		using inline OnTicketsLoad, 
		va_fquery(SQL_Handle(), "SELECT * FROM tickets WHERE reciever = '%e' LIMIT 10", playername),
		""
	);
    return 1;
}

// PLAYER VEHS
static OnPlayerCoVehsLoad(playerid, playersqlid)
{
    inline OnCoVehicleLoad()
    {
        new buffer[2048];
        if(!cache_num_rows())
        {
            format(buffer, sizeof(buffer), "~g~There_are_no_CO-Vehicles!");
        }
        else
        {
            new
                tmpModelID,
                tmpNumberPlate[8],
                tmpColor1,
                tmpColor2,
                tmpImpounded,
                motd[256],
                vehName[32],
                tmp[32],
                VehModel[32];

            format(buffer, sizeof(buffer), "~g~MODEL_-_PLATES_-_COL1_-_COL2_-_IMPOUNDED~n~~l~");
            for (new i = 0; i < cache_num_rows(); i++)
            {
                cache_get_value_name_int(i, "modelid", tmpModelID);

                cache_get_value_name(i,"numberplate", tmp, sizeof(tmp));
                format(tmpNumberPlate, sizeof(tmp), tmp);

                cache_get_value_name_int(i, "color1", tmpColor1);
                cache_get_value_name_int(i, "color2", tmpColor2);
                cache_get_value_name_int(i, "impounded", tmpImpounded);

                strunpack(vehName, Model_Name(tmpModelID));
                format(VehModel, sizeof(VehModel), "%s", vehName);
                format(motd, sizeof(motd), "#_%s_-_~b~%s~l~_-_%d_-_%d_-_%s~n~",
                    VehModel,
                    tmpNumberPlate,
                    tmpColor1,
                    tmpColor2,
                    tmpImpounded ? ("~g~Yes~l~") : ("~r~No~l~")
               );
                strcat(buffer, motd, sizeof(buffer));
            }
        }

        new
            tmpString[64];
        UpdateMDCTextDraws(playerid);
        format(tmpString, sizeof(tmpString), "CO-VEHICLES_LIST");
        PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
        PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
        SelectTextDraw(playerid, 0x427AF4FF);
    }

    MySQL_PQueryInline(SQL_Handle(),  
		using inline OnCoVehicleLoad, 
		va_fquery(SQL_Handle(), 
            "SELECT  \n\
                modelid, numberplate, color1, color2, impounded \n\
            FROM \n\
                cocars\n\
            WHERE \n\
                ownerid = '%d' AND numberplate != '' AND numberplate != '0' \n\
            LIMIT %d",
            playersqlid,
            MAX_PLAYER_CARS
       ),
		""
	);

    return 1;
}

// Player APB load
static OnPlayerAPBLoad(playerid, const playername[])
{
    inline OnAPBLoad()
    {
        new buffer[2048];
        if(!cache_num_rows())
        {
            format(buffer, sizeof(buffer), "~g~Person_is_not_wanted!");
        }
        else
        {
            new
                aSqlId,
                aPDname[MAX_PLAYER_NAME],
                aDiscription[57],
                aType,
                motd[256],
                tmp[64];

            format(buffer, sizeof(buffer), "~r~ID_-_OFFICER_-_DESCRIPTION_-_CAUTION~n~~l~");
            for (new i = 0; i < cache_num_rows(); i++)
            {
                cache_get_value_name_int(i, "id", aSqlId);

                cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
                format(aPDname, MAX_PLAYER_NAME, tmp);

                cache_get_value_name(i,"description"    , tmp, sizeof(tmp));
                format(aDiscription, 57, tmp);

                cache_get_value_name_int(i, "type", aType);


                format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%s~n~",
                    aSqlId,
                    aPDname,
                    aDiscription,
                    GetAPBType(aType)
               );
                strcat(buffer, motd, sizeof(motd));
            }
        }

        new
            tmpString[64];
        UpdateMDCTextDraws(playerid);
        format(tmpString, sizeof(tmpString), "ALL_POINTS_BULLETIN", playername);
        PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
        PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
        SelectTextDraw(playerid, 0x427AF4FF);
    }
    MySQL_TQueryInline(SQL_Handle(),  
		using inline OnAPBLoad, 
		va_fquery(SQL_Handle(),  "SELECT * FROM apb WHERE suspect = '%e'", playername),
		""
	);
    return 1;
}

static GetAPBList(playerid)
{
    inline OnAPBListLoad()
    {
        if(!cache_num_rows())
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "APB lista je prazna!");

        new
            aSqlId,
            aPDname[MAX_PLAYER_NAME],
            aSuspect[MAX_PLAYER_NAME],
            aDiscription[57],
            aType,
            buffer[4096],
            motd[256],
            tmp[64],
            lenleft;

        for (new i = 0; i < cache_num_rows(); i++)
        {
            lenleft = sizeof(buffer) - strlen(buffer);
            if(lenleft < sizeof(motd))
                break;

            cache_get_value_name_int(i, "id", aSqlId);

            cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
            format(aPDname, MAX_PLAYER_NAME, tmp);

            cache_get_value_name(i,"suspect", tmp, sizeof(tmp));
            format(aSuspect, MAX_PLAYER_NAME, tmp);

            cache_get_value_name(i,"description", tmp, sizeof(tmp));
            format(aDiscription, sizeof(aDiscription), tmp);

            cache_get_value_name_int(i, "type", aType);

            format(motd, sizeof(motd), "{FF8000}APB ID:{FFFFFF} #%d | {FF8000}Suspect: {FFFFFF}%s | {FF8000}Created by: {FFFFFF}%s | {FF8000}Description: {FFFFFF}%s | {FF8000}APB Type: {FFFFFF}%s\n",
                aSqlId,
                aSuspect,
                aPDname,
                aDiscription,
                GetAPBType(aType)
           );
            strcat(buffer, motd, sizeof(buffer));
        }
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[APB List]", buffer, "Close", "");
    }
    MySQL_TQueryInline(SQL_Handle(),  
		using inline OnAPBListLoad, 
		va_fquery(SQL_Handle(),  "SELECT * FROM apb ORDER BY id DESC"),
		""
	);
    return 1;
}

static GetSuspectAPB(playerid, const playername[])
{
    inline OnAPBLoad()
    {
        if(!cache_num_rows())
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unesena osoba nije pronadjena u databazi.");

        new
            aSqlId,
            aPDname[MAX_PLAYER_NAME],
            aDiscription[57],
            aType,
            buffer[2048],
            tmp[64],
            motd[256],
            lenleft;

        format(buffer, sizeof(buffer), "\n");
        for (new i = 0; i < cache_num_rows(); i++)
        {
            lenleft = sizeof(buffer) - strlen(buffer);
            if(lenleft < sizeof(motd))
                break;

            cache_get_value_name_int(i, "id", aSqlId);

            cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
            format(aPDname, sizeof(aPDname), tmp);

            cache_get_value_name(i,"description"    , tmp, sizeof(tmp));
            format(aDiscription, sizeof(aDiscription), tmp);

            cache_get_value_name_int(i, "type", aType);

            format(motd, sizeof(motd), "{FF8000}APB ID {FFFFFF}#%d\n{FF8000}Created by: {FFFFFF}%s\n{FF8000}Description: {FFFFFF}%s\n{FF8000}APB Type: {FFFFFF}%s\n",
                aSqlId,
                aPDname,
                aDiscription,
                GetAPBType(aType)
           );
            strcat(buffer, motd, sizeof(buffer));
        }

        new
            tmpString[32];
        format(tmpString, sizeof(tmpString), "[APB - %s]", playername);
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, tmpString, buffer, "Close", "");
    }
    MySQL_TQueryInline(SQL_Handle(),  
		using inline OnAPBLoad, 
		va_fquery(SQL_Handle(),  "SELECT * FROM apb WHERE suspect = '%e'", playername),
		""
	);
    return 1;
}

// GLOBAL VEHICLE
static GetVehicleMDCInfo(playerid, vehicleid)
{
    new
        mdcString[512],
        mdcString2[2048],
        VehOwner[MAX_PLAYER_NAME],
        tmpString[32];

    if(strlen(VehicleInfo[vehicleid][vNumberPlate]) > 1)
        format(VehOwner, sizeof(VehOwner), ConvertSQLIDToName(VehicleInfo[vehicleid][vOwnerID]));
    else
        format(VehOwner, sizeof(VehOwner), "Unknown");

    strunpack(tmpString, Model_Name(GetVehicleModel(vehicleid)));
    format(tmpString, sizeof(tmpString), "%s", tmpString);

    format(mdcString, sizeof(mdcString), "Model: %s~n~Plates_number: %s~n~Owner: %s~n~Colors: %d %d~n~Impounded: %s",
        tmpString,
        VehicleInfo[vehicleid][vNumberPlate],
        VehOwner,
        VehicleInfo[vehicleid][vColor1],
        VehicleInfo[vehicleid][vColor2],
        VehicleInfo[vehicleid][vImpounded] ? ("~g~Yes~l~") : ("~r~No~l~")
   );

    new motd[128];
    for (new i = 0; i < MAX_VEHICLE_TICKETS; i++)
    {
        if(VehicleInfo[vehicleid][vTicketSQLID][i] != 0)
        {
            if(i == 0)
            {
                format(mdcString2, sizeof(mdcString2), " Ticket #1: %s - %d$", GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketSQLID][0]), VehicleInfo[vehicleid][vTickets][0]);
                strcat(mdcString2, motd, sizeof(mdcString2));
            }
            else
            {
                format(mdcString2, sizeof(mdcString2), "~n~ Ticket #%d: %s - %d$",
                    (i+1),
                    GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketSQLID][i]),
                    VehicleInfo[vehicleid][vTickets][i]
               );
                strcat(mdcString2, motd, sizeof(mdcString2));
            }
        }
    }

    SelectTextDraw(playerid, 0x427AF4FF);
    CreateVehMDCTextDraws(playerid, GetVehicleModel(vehicleid), VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2], false);

    format(TargetName[playerid], MAX_PLAYER_NAME, "%s", VehOwner);
    PlayerTextDrawSetString(playerid, MDCHeader[playerid], "MDC_VEHICLE_CHECK");
    PlayerTextDrawSetString(playerid, MDCProfileText[playerid], mdcString);
    PlayerTextDrawSetString(playerid, MDCText2[playerid], "TICKETS_LIST");
    PlayerTextDrawSetString(playerid, MDCOtherText[playerid], mdcString2);
    return 1;
}

// Stocks
stock InsertPlayerMDCCrime(playerid, giveplayerid, reason[], jailtime)
{
    strcpy(JailInfo[giveplayerid][jSuspectName], GetName(giveplayerid, false));
    strcpy(JailInfo[giveplayerid][jPoliceName], GetName(playerid, false));
    strcpy(JailInfo[giveplayerid][jReason], reason);
    JailInfo[giveplayerid][jTime] = jailtime;
    strcpy(JailInfo[giveplayerid][jDate], ReturnDate());

    mysql_fquery_ex(SQL_Handle(), 
        "INSERT INTO \n\
            jail \n\
        (suspect, policeman, reason, jailtime, date) \n\
        VALUES \n\
            ('%e', '%e', '%e', '%d', '%e')",
        JailInfo[giveplayerid][jSuspectName],
        JailInfo[giveplayerid][jPoliceName],
        JailInfo[giveplayerid][jReason],
        JailInfo[giveplayerid][jTime],
        JailInfo[giveplayerid][jDate]
    );
    return 1;
}

static DeletePlayerMDCCrime(playerid, sqlid)
{
    mysql_fquery(SQL_Handle(), "DELETE FROM jail WHERE id = '%d'", sqlid);
    va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali dosje #%d!", sqlid);
    return 1;
}

static InsertAPBInfo(playerid, const suspect[], const description[], type)
{
    mysql_fquery_ex(SQL_Handle(),
        "INSERT INTO \n\
            apb \n\
        (suspect, description, type, pdname) \n\
        VALUES \n\
            ('%e','%e','%d','%e')",
        suspect,
        description,
        type,
        GetName(playerid, true)
   );
    return 1;
}

static RemoveAPBInfo(sqlid)
{
    mysql_fquery(SQL_Handle(), "DELETE FROM apb WHERE id = '%d' LIMIT 1", sqlid);
    return 1;
}

// TODO: write this function with array of static const strings and with 'type' as index
static GetAPBType(type)
{
    new
        string[26];

    switch (type)
    {
        case 1: format(string, 26, "Ne naoruzan i nije opasan");
        case 2: format(string, 26, "Srednje opasan");
        case 3: format(string, 26, "Naoruzan i opasan");
        default: format(string, 26, "None");
    }
    return string;
}

static GetPlayerMDCRecord(playerid, const playername[])
{
    new
        tmpJail[E_JAIL_DATA],
        buffer[1024],
        tmp[32];

    inline OnSuspectLoad()
    {
        format(buffer, sizeof(buffer), "{A4BDDE}ID | IME/PREZIME | OFFICER | RAZLOG | VRIJEME KAZNE | DATUM UHICENJA"COL_WHITE"\n");
        for (new i = 0; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i, "id", tmpJail[jSQLID]);
            cache_get_value_name(i,"suspect"    , tmp, sizeof(tmp));
            format(tmpJail[jSuspectName], MAX_PLAYER_NAME, tmp);

            cache_get_value_name(i,"policeman"  , tmp, sizeof(tmp));
            format(tmpJail[jPoliceName], MAX_PLAYER_NAME, tmp);

            cache_get_value_name(i,"reason" , tmp, sizeof(tmp));
            format(tmpJail[jReason], MAX_PLAYER_NAME, tmp);
            cache_get_value_name_int(i, "jailtime", tmpJail[jTime]);

            cache_get_value_name(i, "date", tmp, sizeof(tmp));
            format(tmpJail[jDate], 30, tmp);

            format(buffer, sizeof(buffer), "%s#%d | %s | %s | %s | %d | %s\n",
                buffer,
                tmpJail[jSQLID],
                tmpJail[jSuspectName],
                tmpJail[jPoliceName],
                tmpJail[jReason],
                tmpJail[jTime],
                tmpJail[jDate]
           );
        }

        new string[64];
        format(string, sizeof(string), "%s-DOSJE", tmpJail[jSuspectName]);
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, string, buffer, "Close", "");
    }
    MySQL_PQueryInline(SQL_Handle(),  
		using inline OnSuspectLoad, 
		va_fquery(SQL_Handle(),  "SELECT * FROM jail WHERE suspect = '%e'", playername),
		""
	);
    return 1;
}

static UpdateMDCTextDraws(playerid)
{
    DestroyUpdatedMDCTextDraws(playerid);

    MDCOtherText[playerid] = CreatePlayerTextDraw(playerid, 165.333343, 201.888565, "N-A");
    PlayerTextDrawLetterSize(playerid, MDCOtherText[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawSetShadow(playerid, MDCOtherText[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawFont(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawShow(playerid, MDCOtherText[playerid]);

    MDCText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
    PlayerTextDrawLetterSize(playerid, MDCText2[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCText2[playerid], 1);
    PlayerTextDrawColor(playerid, MDCText2[playerid], 35071);
    PlayerTextDrawSetShadow(playerid, MDCText2[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCText2[playerid], 255);
    PlayerTextDrawFont(playerid, MDCText2[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCText2[playerid], 1);
    PlayerTextDrawShow(playerid, MDCText2[playerid]);
}

static DestroyUpdatedMDCTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, MDCOtherText[playerid]);
    MDCOtherText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCText2[playerid]);
    MDCText2[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

static DestroyMDCTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, MDCBg1[playerid]);
    MDCBg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCBg2[playerid]);
    MDCBg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCHeader[playerid]);
    MDCHeader[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCSkin[playerid]);
    MDCSkin[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCText1[playerid]);
    MDCText1[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCText2[playerid]);
    MDCText2[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCOtherText[playerid]);
    MDCOtherText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCProfileText[playerid]);
    MDCProfileText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCRecordButton[playerid]);
    MDCRecordButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCVehButton[playerid]);
    MDCVehButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCTicketsButton[playerid]);
    MDCTicketsButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCGeneralButton[playerid]);
    MDCGeneralButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCAPBButton[playerid]);
    MDCAPBButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCCloseButton[playerid]);
    MDCCloseButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

static CreateMDCTextDraws(playerid, skin, bool:type=false)
{
    DestroyMDCTextDraws(playerid);

    MDCBg1[playerid] = CreatePlayerTextDraw(playerid, 158.999938, 60.162940, "blue_bg");
    PlayerTextDrawLetterSize(playerid, MDCBg1[playerid], 0.000000, 37.633335);
    PlayerTextDrawTextSize(playerid, MDCBg1[playerid], 466.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawColor(playerid, MDCBg1[playerid], -1);
    PlayerTextDrawUseBox(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCBg1[playerid], 9471);
    PlayerTextDrawSetShadow(playerid, MDCBg1[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCBg1[playerid], 255);
    PlayerTextDrawFont(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawShow(playerid, MDCBg1[playerid]);

    MDCHeader[playerid] = CreatePlayerTextDraw(playerid, 309.599945, 64.966629, "POLICE_MDC");
    PlayerTextDrawLetterSize(playerid, MDCHeader[playerid], 0.326332, 1.376001);
    PlayerTextDrawTextSize(playerid, MDCHeader[playerid], 0.000000, 101.000000);
    PlayerTextDrawAlignment(playerid, MDCHeader[playerid], 2);
    PlayerTextDrawColor(playerid, MDCHeader[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MDCHeader[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCHeader[playerid], 255);
    PlayerTextDrawFont(playerid, MDCHeader[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCHeader[playerid], 1);
    PlayerTextDrawShow(playerid, MDCHeader[playerid]);

    MDCBg2[playerid] = CreatePlayerTextDraw(playerid, 163.266708, 86.481460, "box");
    PlayerTextDrawLetterSize(playerid, MDCBg2[playerid], 0.000000, 34.100013);
    PlayerTextDrawTextSize(playerid, MDCBg2[playerid], 461.599975, 0.000000);
    PlayerTextDrawAlignment(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawColor(playerid, MDCBg2[playerid], -1);
    PlayerTextDrawUseBox(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCBg2[playerid], -1061109505);
    PlayerTextDrawSetShadow(playerid, MDCBg2[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCBg2[playerid], 255);
    PlayerTextDrawFont(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawShow(playerid, MDCBg2[playerid]);

    MDCSkin[playerid] = CreatePlayerTextDraw(playerid, 165.566406, 89.277763, "");
    PlayerTextDrawTextSize(playerid, MDCSkin[playerid], 84.679931, 95.000000);
    PlayerTextDrawAlignment(playerid, MDCSkin[playerid], 1);
    PlayerTextDrawColor(playerid, MDCSkin[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MDCSkin[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCSkin[playerid], -2139062017);
    PlayerTextDrawFont(playerid, MDCSkin[playerid], 5);
    PlayerTextDrawSetProportional(playerid, MDCSkin[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, MDCSkin[playerid], skin);
    PlayerTextDrawSetPreviewRot(playerid, MDCSkin[playerid], 0.000000, 0.000000, 20.000000, 0.899999);
    PlayerTextDrawShow(playerid, MDCSkin[playerid]);

    MDCText1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 87.833366, "PROFILE");
    PlayerTextDrawLetterSize(playerid, MDCText1[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCText1[playerid], 1);
    PlayerTextDrawColor(playerid, MDCText1[playerid], 35071);
    PlayerTextDrawSetShadow(playerid, MDCText1[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCText1[playerid], 255);
    PlayerTextDrawFont(playerid, MDCText1[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCText1[playerid], 1);
    PlayerTextDrawShow(playerid, MDCText1[playerid]);

    MDCProfileText[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 100.133178, "N-A");
    PlayerTextDrawLetterSize(playerid, MDCProfileText[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawColor(playerid, MDCProfileText[playerid], 255);
    PlayerTextDrawSetShadow(playerid, MDCProfileText[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCProfileText[playerid], 255);
    PlayerTextDrawFont(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawShow(playerid, MDCProfileText[playerid]);

    MDCText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
    PlayerTextDrawLetterSize(playerid, MDCText2[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCText2[playerid], 1);
    PlayerTextDrawColor(playerid, MDCText2[playerid], 35071);
    PlayerTextDrawSetShadow(playerid, MDCText2[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCText2[playerid], 255);
    PlayerTextDrawFont(playerid, MDCText2[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCText2[playerid], 1);
    PlayerTextDrawShow(playerid, MDCText2[playerid]);

    MDCOtherText[playerid] = CreatePlayerTextDraw(playerid, 165.333343, 201.888565, "N-A");
    PlayerTextDrawLetterSize(playerid, MDCOtherText[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawSetShadow(playerid, MDCOtherText[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawFont(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawShow(playerid, MDCOtherText[playerid]);

    if(!type)
    {
        MDCRecordButton[playerid] = CreatePlayerTextDraw(playerid, 195.566970, 382.118652, "CRIMINAL_RECORD");
        PlayerTextDrawLetterSize(playerid, MDCRecordButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCRecordButton[playerid], 18.000000, 63.000000);
        PlayerTextDrawAlignment(playerid, MDCRecordButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCRecordButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCRecordButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCRecordButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCRecordButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCRecordButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCRecordButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCRecordButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCRecordButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCRecordButton[playerid]);

        MDCVehButton[playerid] = CreatePlayerTextDraw(playerid, 250.234573, 382.108551, "VEHICLES");
        PlayerTextDrawLetterSize(playerid, MDCVehButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCVehButton[playerid], 18.000000, 35.000000);
        PlayerTextDrawAlignment(playerid, MDCVehButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCVehButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCVehButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCVehButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCVehButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCVehButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCVehButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCVehButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCVehButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCVehButton[playerid]);

        MDCTicketsButton[playerid] = CreatePlayerTextDraw(playerid, 304.066436, 382.157867, "TRAFFIC_TICKETS");
        PlayerTextDrawLetterSize(playerid, MDCTicketsButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCTicketsButton[playerid], 18.000000, 62.000000);
        PlayerTextDrawAlignment(playerid, MDCTicketsButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCTicketsButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCTicketsButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCTicketsButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCTicketsButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCTicketsButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCTicketsButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCTicketsButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCTicketsButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCTicketsButton[playerid]);

        MDCGeneralButton[playerid] = CreatePlayerTextDraw(playerid, 357.269683, 382.157867, "GENERAL");
        PlayerTextDrawLetterSize(playerid, MDCGeneralButton[playerid], 0.178000, 1.139554);
        PlayerTextDrawTextSize(playerid, MDCGeneralButton[playerid], 18.000000, 34.000000);
        PlayerTextDrawAlignment(playerid, MDCGeneralButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCGeneralButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCGeneralButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCGeneralButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCGeneralButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCGeneralButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCGeneralButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCGeneralButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCGeneralButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCGeneralButton[playerid]);

        MDCAPBButton[playerid] = CreatePlayerTextDraw(playerid, 391.271759, 382.157867, "APB");
        PlayerTextDrawLetterSize(playerid, MDCAPBButton[playerid], 0.178000, 1.139554);
        PlayerTextDrawTextSize(playerid, MDCAPBButton[playerid], 18.000000, 24.000000);
        PlayerTextDrawAlignment(playerid, MDCAPBButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCAPBButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCAPBButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCAPBButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCAPBButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCAPBButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCAPBButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCAPBButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCAPBButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCAPBButton[playerid]);
    }

    MDCCloseButton[playerid] = CreatePlayerTextDraw(playerid, 449.633178, 381.828002, "CLOSE");
    PlayerTextDrawLetterSize(playerid, MDCCloseButton[playerid], 0.178000, 1.139555);
    PlayerTextDrawTextSize(playerid, MDCCloseButton[playerid], 18.000000, 22.000000);
    PlayerTextDrawAlignment(playerid, MDCCloseButton[playerid], 2);
    PlayerTextDrawColor(playerid, MDCCloseButton[playerid], -2147483393);
    PlayerTextDrawUseBox(playerid, MDCCloseButton[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCCloseButton[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, MDCCloseButton[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCCloseButton[playerid], 255);
    PlayerTextDrawFont(playerid, MDCCloseButton[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCCloseButton[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, MDCCloseButton[playerid], true);
    PlayerTextDrawShow(playerid, MDCCloseButton[playerid]);
}

static CreateVehMDCTextDraws(playerid, model, color1, color2, bool:type=false)
{
    DestroyMDCTextDraws(playerid);

    MDCBg1[playerid] = CreatePlayerTextDraw(playerid, 158.999938, 60.162940, "blue_bg");
    PlayerTextDrawLetterSize(playerid, MDCBg1[playerid], 0.000000, 37.633335);
    PlayerTextDrawTextSize(playerid, MDCBg1[playerid], 466.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawColor(playerid, MDCBg1[playerid], -1);
    PlayerTextDrawUseBox(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCBg1[playerid], 9471);
    PlayerTextDrawSetShadow(playerid, MDCBg1[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCBg1[playerid], 255);
    PlayerTextDrawFont(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCBg1[playerid], 1);
    PlayerTextDrawShow(playerid, MDCBg1[playerid]);

    MDCHeader[playerid] = CreatePlayerTextDraw(playerid, 309.599945, 64.966629, "POLICE_MDC");
    PlayerTextDrawLetterSize(playerid, MDCHeader[playerid], 0.326332, 1.376001);
    PlayerTextDrawTextSize(playerid, MDCHeader[playerid], 0.000000, 101.000000);
    PlayerTextDrawAlignment(playerid, MDCHeader[playerid], 2);
    PlayerTextDrawColor(playerid, MDCHeader[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MDCHeader[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCHeader[playerid], 255);
    PlayerTextDrawFont(playerid, MDCHeader[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCHeader[playerid], 1);
    PlayerTextDrawShow(playerid, MDCHeader[playerid]);

    MDCBg2[playerid] = CreatePlayerTextDraw(playerid, 163.266708, 86.481460, "box");
    PlayerTextDrawLetterSize(playerid, MDCBg2[playerid], 0.000000, 34.100013);
    PlayerTextDrawTextSize(playerid, MDCBg2[playerid], 461.599975, 0.000000);
    PlayerTextDrawAlignment(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawColor(playerid, MDCBg2[playerid], -1);
    PlayerTextDrawUseBox(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCBg2[playerid], -1061109505);
    PlayerTextDrawSetShadow(playerid, MDCBg2[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCBg2[playerid], 255);
    PlayerTextDrawFont(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCBg2[playerid], 1);
    PlayerTextDrawShow(playerid, MDCBg2[playerid]);

    MDCSkin[playerid] = CreatePlayerTextDraw(playerid, 165.566406, 89.277763, "");
    PlayerTextDrawTextSize(playerid, MDCSkin[playerid], 84.679931, 95.000000);
    PlayerTextDrawAlignment(playerid, MDCSkin[playerid], 1);
    PlayerTextDrawColor(playerid, MDCSkin[playerid], -1);
    PlayerTextDrawSetShadow(playerid, MDCSkin[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCSkin[playerid], -2139062017);
    PlayerTextDrawFont(playerid, MDCSkin[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, MDCSkin[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, MDCSkin[playerid], model);
    PlayerTextDrawSetPreviewVehCol(playerid, MDCSkin[playerid], color1, color2);
    PlayerTextDrawSetPreviewRot(playerid, MDCSkin[playerid], 0.000000, 0.000000, 30.000000, 0.899999);
    PlayerTextDrawShow(playerid, MDCSkin[playerid]);

    MDCText1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 87.833366, "PROFILE");
    PlayerTextDrawLetterSize(playerid, MDCText1[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCText1[playerid], 1);
    PlayerTextDrawColor(playerid, MDCText1[playerid], 35071);
    PlayerTextDrawSetShadow(playerid, MDCText1[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCText1[playerid], 255);
    PlayerTextDrawFont(playerid, MDCText1[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCText1[playerid], 1);
    PlayerTextDrawShow(playerid, MDCText1[playerid]);

    MDCProfileText[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 100.133178, "N-A");
    PlayerTextDrawLetterSize(playerid, MDCProfileText[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawColor(playerid, MDCProfileText[playerid], 255);
    PlayerTextDrawSetShadow(playerid, MDCProfileText[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCProfileText[playerid], 255);
    PlayerTextDrawFont(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCProfileText[playerid], 1);
    PlayerTextDrawShow(playerid, MDCProfileText[playerid]);

    MDCText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
    PlayerTextDrawLetterSize(playerid, MDCText2[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCText2[playerid], 1);
    PlayerTextDrawColor(playerid, MDCText2[playerid], 35071);
    PlayerTextDrawSetShadow(playerid, MDCText2[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCText2[playerid], 255);
    PlayerTextDrawFont(playerid, MDCText2[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCText2[playerid], 1);
    PlayerTextDrawShow(playerid, MDCText2[playerid]);

    MDCOtherText[playerid] = CreatePlayerTextDraw(playerid, 165.333343, 201.888565, "N-A");
    PlayerTextDrawLetterSize(playerid, MDCOtherText[playerid], 0.191999, 1.093927);
    PlayerTextDrawAlignment(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawSetShadow(playerid, MDCOtherText[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCOtherText[playerid], 255);
    PlayerTextDrawFont(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawSetProportional(playerid, MDCOtherText[playerid], 1);
    PlayerTextDrawShow(playerid, MDCOtherText[playerid]);

    if(!type)
    {
        MDCRecordButton[playerid] = CreatePlayerTextDraw(playerid, 195.566970, 382.118652, "CRIMINAL_RECORD");
        PlayerTextDrawLetterSize(playerid, MDCRecordButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCRecordButton[playerid], 18.000000, 63.000000);
        PlayerTextDrawAlignment(playerid, MDCRecordButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCRecordButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCRecordButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCRecordButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCRecordButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCRecordButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCRecordButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCRecordButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCRecordButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCRecordButton[playerid]);

        MDCVehButton[playerid] = CreatePlayerTextDraw(playerid, 250.234573, 382.108551, "VEHICLES");
        PlayerTextDrawLetterSize(playerid, MDCVehButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCVehButton[playerid], 18.000000, 35.000000);
        PlayerTextDrawAlignment(playerid, MDCVehButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCVehButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCVehButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCVehButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCVehButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCVehButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCVehButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCVehButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCVehButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCVehButton[playerid]);

        MDCTicketsButton[playerid] = CreatePlayerTextDraw(playerid, 304.066436, 382.157867, "TRAFFIC_TICKETS");
        PlayerTextDrawLetterSize(playerid, MDCTicketsButton[playerid], 0.178000, 1.139555);
        PlayerTextDrawTextSize(playerid, MDCTicketsButton[playerid], 18.000000, 62.000000);
        PlayerTextDrawAlignment(playerid, MDCTicketsButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCTicketsButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCTicketsButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCTicketsButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCTicketsButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCTicketsButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCTicketsButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCTicketsButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCTicketsButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCTicketsButton[playerid]);

        MDCGeneralButton[playerid] = CreatePlayerTextDraw(playerid, 357.269683, 382.157867, "GENERAL");
        PlayerTextDrawLetterSize(playerid, MDCGeneralButton[playerid], 0.178000, 1.139554);
        PlayerTextDrawTextSize(playerid, MDCGeneralButton[playerid], 18.000000, 34.000000);
        PlayerTextDrawAlignment(playerid, MDCGeneralButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCGeneralButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCGeneralButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCGeneralButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCGeneralButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCGeneralButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCGeneralButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCGeneralButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCGeneralButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCGeneralButton[playerid]);

        MDCAPBButton[playerid] = CreatePlayerTextDraw(playerid, 391.271759, 382.157867, "APB");
        PlayerTextDrawLetterSize(playerid, MDCAPBButton[playerid], 0.178000, 1.139554);
        PlayerTextDrawTextSize(playerid, MDCAPBButton[playerid], 18.000000, 24.000000);
        PlayerTextDrawAlignment(playerid, MDCAPBButton[playerid], 2);
        PlayerTextDrawColor(playerid, MDCAPBButton[playerid], -1);
        PlayerTextDrawUseBox(playerid, MDCAPBButton[playerid], 1);
        PlayerTextDrawBoxColor(playerid, MDCAPBButton[playerid], -2139062017);
        PlayerTextDrawSetShadow(playerid, MDCAPBButton[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, MDCAPBButton[playerid], 255);
        PlayerTextDrawFont(playerid, MDCAPBButton[playerid], 2);
        PlayerTextDrawSetProportional(playerid, MDCAPBButton[playerid], 1);
        PlayerTextDrawSetSelectable(playerid, MDCAPBButton[playerid], true);
        PlayerTextDrawShow(playerid, MDCAPBButton[playerid]);
    }

    MDCCloseButton[playerid] = CreatePlayerTextDraw(playerid, 449.633178, 381.828002, "CLOSE");
    PlayerTextDrawLetterSize(playerid, MDCCloseButton[playerid], 0.178000, 1.139555);
    PlayerTextDrawTextSize(playerid, MDCCloseButton[playerid], 18.000000, 22.000000);
    PlayerTextDrawAlignment(playerid, MDCCloseButton[playerid], 2);
    PlayerTextDrawColor(playerid, MDCCloseButton[playerid], -2147483393);
    PlayerTextDrawUseBox(playerid, MDCCloseButton[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MDCCloseButton[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, MDCCloseButton[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, MDCCloseButton[playerid], 255);
    PlayerTextDrawFont(playerid, MDCCloseButton[playerid], 2);
    PlayerTextDrawSetProportional(playerid, MDCCloseButton[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, MDCCloseButton[playerid], true);
    PlayerTextDrawShow(playerid, MDCCloseButton[playerid]);
}


/*
    ##     ##  #######   #######  ##    ## 
    ##     ## ##     ## ##     ## ##   ##  
    ##     ## ##     ## ##     ## ##  ##   
    ######### ##     ## ##     ## #####    
    ##     ## ##     ## ##     ## ##  ##   
    ##     ## ##     ## ##     ## ##   ##  
    ##     ##  #######   #######  ##    ## 
*/

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(MDCBg1[playerid] != PlayerText:INVALID_TEXT_DRAW)
        {
            DestroyMDCTextDraws(playerid);
            CancelSelectTextDraw(playerid);
        }
    }
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid != PlayerText:INVALID_TEXT_DRAW)
    {
        if(playertextid == MDCCloseButton[playerid])
        {
            DestroyMDCTextDraws(playerid);
            CancelSelectTextDraw(playerid);
        }
        if(playertextid == MDCGeneralButton[playerid])
        {
            new player_sqlid = ConvertNameToSQLID(TargetName[playerid]);
            if(player_sqlid == -1)
                return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "%s ne postoji registriran u bazi!", 
                    TargetName[playerid]
               );

            OnPlayerMDCDataLoad(playerid, TargetName[playerid], player_sqlid);
        }
        if(playertextid == MDCTicketsButton[playerid])
        {
            OnPlayerTicketsLoad(playerid, TargetName[playerid]);
        }
        if(playertextid == MDCAPBButton[playerid])
        {
            OnPlayerAPBLoad(playerid, TargetName[playerid]);
        }
        if(playertextid == MDCVehButton[playerid])
        {
            new player_sqlid = ConvertNameToSQLID(TargetName[playerid]);
            if(player_sqlid == -1)
                return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "%s ne postoji registriran u bazi!", 
                    TargetName[playerid]
               );

            OnPlayerCoVehsLoad(playerid, player_sqlid);
        }
        if(playertextid == MDCRecordButton[playerid])
        {
            OnPlayerArrestDataLoad(playerid, TargetName[playerid]);
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_MDC_MAIN:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0: // Player
                    ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "MDC - PERSON", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
                case 1: // Vehicle
                    ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Da biste dobili vehicleid koristite komandu /dl!", "Input", "Abort");
                case 2: // Dosije
                    ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_LIST, "MDC - DOSJE", "Provjera dosjea\nObrisi dosje", "Choose", "Abort");
                case 3: // Kazne
                    ShowPlayerDialog(playerid, DIALOG_MDC_TICKET, DIALOG_STYLE_LIST, "MDC - TICKET", "Provjera kazni\nObrisi kaznu", "Choose", "Abort");
                case 4: // Provjera vlasnika mobitela
                    ShowPlayerDialog(playerid, DIALOG_MDC_PHONE, DIALOG_STYLE_INPUT, "MDC - MOBITEL", "Unesite broj mobitela koji zelite provjeriti:", "Choose", "Abort");
            }
        }
        case DIALOG_MDC_PHONE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");

            if(strlen(inputtext) != 6)
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unijeli ste krivi broj mobitela!");
                return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
            }

            new mobilenumber = strval(inputtext);
            inline OnMobileNumberCheck()
            {
                if(!cache_num_rows())
                    return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, " Korisnik sa brojem %d ne postoji!", mobilenumber);

                new playersql,
                    modelid;

                cache_get_value_name_int(0, "player_id", playersql);
                cache_get_value_name_int(0, "model", modelid);

                new motd[150];
                format(motd, sizeof(motd), "\t\tLS Telefonica - %s\nBroj mobitela: %d\nModel mobitela: %s\nVlasnik mobitela: %s", ReturnDate(), mobilenumber, GetMobileName(modelid), ConvertSQLIDToName(playersql));
                ShowPlayerDialog(playerid, DIALOG_MDC_PHONE_INFO, DIALOG_STYLE_MSGBOX, "MDC - MOBILE", motd, "Close", "");
            }
            MySQL_TQueryInline(SQL_Handle(),  
                using inline OnMobileNumberCheck, 
                va_fquery(SQL_Handle(), "SELECT player_id, model FROM player_phones WHERE number = '%d'", mobilenumber),
                ""
           );
        }
        case DIALOG_MDC_PLAYER:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");

            if(strfind(inputtext, "_", true) == -1) 
                return ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
            
            new player_sqlid = ConvertNameToSQLID(TargetName[playerid]);
            if(player_sqlid == -1)
                return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "%s ne postoji registriran u bazi!", 
                    TargetName[playerid]
               );

            format(TargetName[playerid], MAX_PLAYER_NAME, "%s", inputtext);
            OnPlayerMDCDataLoad(playerid, TargetName[playerid], player_sqlid);

        }
        case DIALOG_MDC_VEHICLE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");

            if(1 <= strval(inputtext) <= MAX_VEHICLES)
            {
                if(!Vehicle_Exists(VEHICLE_USAGE_PRIVATE, strval(inputtext))) 
                    return ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Vozilo mora biti CO!", "Input", "Abort");
                GetVehicleMDCInfo(playerid, strval(inputtext));
            }
            else ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Da biste dobili vehicleid koristite komandu /dl!", "Input", "Abort");
        }
        case DIALOG_MDC_RECORD:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                { // Provjera
                    ShowPlayerDialog(playerid, DIALOG_MDC_CRECORD, DIALOG_STYLE_INPUT, "MDC - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
                }
                case 1:
                { // Brisanje
                    if(PlayerFaction[playerid][pRank] < 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo PD officeri rank 4+ mogu ovdje!");
                    ShowPlayerDialog(playerid, DIALOG_MDC_DRECORD_ID, DIALOG_STYLE_INPUT, "MDC - PLAYER", "Unesite ID dosjea kojeg zelite obrisati:", "Input", "Abort");
                }
            }
        }
        case DIALOG_MDC_CRECORD:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");

            if(1 <= strlen(inputtext) <= MAX_PLAYER_NAME)
            {
                if(strfind(inputtext, "_", true) == -1) return ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");

                GetPlayerMDCRecord(playerid, inputtext);
            }
            else ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
        }
        case DIALOG_MDC_DRECORD_ID:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_LIST, "MDC - PLAYER", "Provjera dosjea\nObrisi dosje", "Choose", "Abort");

            DeletingRecordID[playerid] = strval(inputtext);
            va_ShowPlayerDialog(playerid, DIALOG_MDC_DRECORD, DIALOG_STYLE_MSGBOX, "MDC - PLAYER", "Zelite li obrisati dosje ID %d?", "Da", "Ne", DeletingRecordID[playerid]);
        }
        case DIALOG_MDC_DRECORD:
        {
            if(!response) return 1;

            DeletePlayerMDCCrime(playerid, DeletingRecordID[playerid]);
        }
        //kazne
        case DIALOG_MDC_TICKET:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                { // Provjera
                    ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
                }
                case 1:
                { // Brisanje
                    if(PlayerFaction[playerid][pRank] < 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo PD officeri rank 4+ mogu ovdje!");

                    ShowPlayerDialog(playerid, DIALOG_MDC_DTICKET_ID, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ID dosjea kojeg zelite obrisati:", "Input", "Abort");
                }
            }
        }
        case DIALOG_MDC_CTICKET:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");

            if(1 <= strlen(inputtext) <= MAX_PLAYER_NAME)
            {
                if(strfind(inputtext, "_", true) == -1) return ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");

                LoadPlayerTickets(playerid, inputtext);
            }
            else ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "Mobile Data Computer - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
        }
        case DIALOG_MDC_DTICKET_ID:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_MDC_TICKET, DIALOG_STYLE_LIST, "MDC - TICKET", "Provjera kazni\nObrisi kaznu", "Choose", "Abort");

            DeletingTicketID[playerid] = strval(inputtext);
            va_ShowPlayerDialog(playerid, DIALOG_MDC_DTICKET, DIALOG_STYLE_MSGBOX, "MDC - TICKET", "Zelite li obrisati ticket ID %d?", "Da", "Ne", DeletingTicketID[playerid]);
        }
        case DIALOG_MDC_DTICKET:
        {
            if(!response) return 1;

            DeletePlayerTicket(playerid, DeletingTicketID[playerid], true);
        }
        case DIALOG_APB_CHECK:
        {
            if(strfind(inputtext, "_", true) == -1) return ShowPlayerDialog(playerid, DIALOG_APB_CHECK, DIALOG_STYLE_INPUT, "* APB - CHECK", "Ispod unesite ime osobe kojoj zelite provjeriti APB\n[WARNING]: Ime mora biti napisano Ime_Prezime.", "Input", "Abort");

            // TODO: use strcpy for copying strings
            format(TargetName[playerid], MAX_PLAYER_NAME, "%s", inputtext);
            GetSuspectAPB(playerid, TargetName[playerid]);
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

CMD:mdc(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
    if(!IsInStateVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");

    ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni\nProvjera broja mobitela", "Choose", "Abort");
    return 1;
}

CMD:apb(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
    if(!IsInStateVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");

    new
        pick[7],
        suspect[24],
        desc[57],
        type;
    if(sscanf( params, "s[7] ", pick)) return SendClientMessage( playerid, -1, "KORISTENJE /apb [list / add / delete / check]");

    if(!strcmp(pick, "list", true))
    {
        return GetAPBList(playerid);
    }
    if(!strcmp(pick, "add", true))
    {
        if(sscanf( params, "s[7]is[24]s[57]", pick, type, suspect, desc))
        {
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTI: /apb add [tip 1/2/3][Ime_Prezime][PenalCode-Zlocin]");
            SendClientMessage(playerid, COLOR_WHITE, "Tip: 1. Ne naoruzan i nije opasan | 2. Srednje opasan | 3. Naoruzan i opasan");
            return 1;
        }
        if(1 <= strlen(suspect) <= MAX_PLAYER_NAME)
        {
            if(strfind(suspect, "_", true) == -1) return SendClientMessage(playerid, COLOR_RED, "NAPOMENA: Mora biti s znakom '_'! ");

            InsertAPBInfo(playerid, suspect, desc, type);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "*** APB RECORD ADDED ***");
            va_SendClientMessage(playerid, COLOR_WHITE, "Name: %s", suspect);
            va_SendClientMessage(playerid, COLOR_WHITE, "Type: %s", GetAPBType(type));
            va_SendClientMessage(playerid, COLOR_WHITE, "Description: %s", desc);

            new string[128];
            format(string, sizeof(string), "** [HQ] ** APB ** %s je dodao APB zapis na %s **", GetName(playerid,true), suspect);
            SendRadioMessage(PlayerFaction[playerid][pMember], TEAM_YELLOW_COLOR, string);
        }
    }
    else if(!strcmp(pick, "check", true))
        ShowPlayerDialog(playerid, DIALOG_APB_CHECK, DIALOG_STYLE_INPUT, "* APB - CHECK", "Ispod unesite ime osobe kojoj zelite provijeriti APB\n[WARNING]: Ime mora biti napisano Ime_Prezime.", "Input", "Abort");
    else if(!strcmp(pick, "delete", true))
    {
        new
            sqlid;
        if(sscanf(params, "s[7]i", pick, sqlid)) return SendClientMessage( playerid, -1, "[?]: /apb delete [id]");
        RemoveAPBInfo(sqlid);
        va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[APB] Obrisali ste APB slot %d!", sqlid);
    }
    return 1;
}