// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_OnPlayerSlowUpdate
    #undef _inc_OnPlayerSlowUpdate
#endif
// custom include-guard to ensure we don't duplicate
#if defined _OnPlayerSlowUpdate_included
	#endinput
#endif
#define _OnPlayerSlowUpdate_included

#include <a_samp>
#include <YSI_Coding\y_timers>

ptask _opsu_update[100](playerid) {
    CallLocalFunction("OnPlayerSlowUpdate", "d", playerid);
}
