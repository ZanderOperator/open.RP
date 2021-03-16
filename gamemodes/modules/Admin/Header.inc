// Admin Module related functions used outside core modules

forward bool:Admin_OnDuty(playerid);
forward bool:Helper_OnDuty(playerid);
forward bool:Player_NeedsHelp(playerid);

forward bool:Player_BlockedReport(playerid);
forward Player_SetBlockedReport(playerid, bool:v);

forward Player_ReportID(playerid);
forward Player_SetReportID(playerid, id);

forward bool: Player_Frozen(playerid);
