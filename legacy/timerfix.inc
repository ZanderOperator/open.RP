/**
 * Copyright (c) 2013-2014, Dan
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met: 
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer. 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * <version>1.5</version>
 * <remarks>Supported parameters:
 * 		a, A = arrays (must be followed by an integer - array's szie);
 * 		b, B = boolean; c, C = character; d, D, i, I = integer;
 * 		s, S = string; p, P = player's ID, t, T = timer's ID
 * </remarks>
 */

/**
 * <summary>Same KillTimer is used for all types of timer.</summary>
 */
#define KillTimer_						KillTimer

/**
 * <summary>Improved GetTickCount (more accurate).</summary>
 * <returns>Current time in miliseconds.</returns>
 */
//native GetTickCount();

/**
 * <summary>Checks if a timer is still alive.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <returns>`true` if the timer is valid or `false` otherwise.</returns>
 */
native IsValidTimer(timerid);

/**
 * <summary>Gets the number of active timers.</summary>
 * <returns>The number of active timers.</returns>
 */
native GetActiveTimers();

/**
 * <summary>Kills all timers a player owns.</summary>
 * <param name="timerid">The ID of the timer.</param>
 */
native KillPlayerTimer(timerid) = KillTimer;

/**
 * <summary>Kills all timers a player owns.</summary>
 * <param name="playerid">The player that owns the timers.</param>
 */
native KillPlayerTimers(playerid);
 
/**
 * <summary>Basic SetTimer.</summary>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="repeating">Whether this timer will repeat or will execute only one time.</param>
 * <returns>The ID of the timer.</returns>
 */
//native SetTimer(func[], interval, repeating);

/**
 * <summary>Basic SetTimerEx.</summary>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="repeating">Whether this timer will repeat or will execute only one time.</param>
 * <param name="format">Special format indicating the types of values the timer will pass.</param>
 * <returns>The ID of the timer.</returns>
 */
//native SetTimerEx(func[], interval, repeating, const format[], {Float,_}:...);

/**
 * <summary>An improved version of SetTimer.</summary>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="delay">Time after this timer should be called for the first time.</param>
 * <param name="count">How many times it should repeat before it's killed (-1 for unlimited).</param>
 * <returns>The ID of the timer.</returns>
 */
native SetTimer_(func[], interval, delay, count);

/**
 * <summary>An improved version of SetTimerEx.</summary>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="delay">Time after this timer should be called for the first time.</param>
 * <param name="count">How many times it should repeat before it's killed (-1 for unlimited).</param>
 * <param name="format">Special format indicating the types of values the timer will pass.</param>
 * <returns>The ID of the timer.</returns>
 */
native SetTimerEx_(func[], interval, delay, count, format[], {Float, _}:...);

/**
 * <summary>Basic SetPlayerTimer.</summary>
 * <param name="playerid">The player that owns the timer.</param>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="repeating">Whether this timer will repeat or will execute only one time.</param>
 * <returns>The ID of the timer.</returns>
 */
native SetPlayerTimer(playerid, func[], interval, repeating);

/**
 * <summary>Basic SetPlayerTimerEx.</summary>
 * <param name="playerid">The player that owns the timer.</param>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="repeating">Whether this timer will repeat or will execute only one time.</param>
 * <param name="format">Special format indicating the types of values the timer will pass.</param>
 * <returns>The ID of the timer.</returns>
 */
native SetPlayerTimerEx(playerid, func[], interval, repeating, const format[], {Float,_}:...);

/**
 * <summary>An improved version of SetPlayerTimer.</summary>
 * <param name="playerid">The player that owns the timer.</param>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="delay">Time after this timer should be called for the first time.</param>
 * <param name="count">How many times it should repeat before it's killed (-1 for unlimited).</param>
 * <returns>The ID of the timer.</returns>
 */
native SetPlayerTimer_(playerid, func[], interval, delay, count);

/**
 * <summary>An improved version of SetPlayerTimerEx.</summary>
 * <param name="playerid">The player that owns the timer.</param>
 * <param name="func">Name of the public function to call.</param>
 * <param name="interval">Interval in milliseconds.</param>
 * <param name="delay">Time after this timer should be called for the first time.</param>
 * <param name="count">How many times it should repeat before it's killed (-1 for unlimited).</param>
 * <param name="format">Special format indicating the types of values the timer will pass.</param>
 * <returns>The ID of the timer.</returns>
 */
native SetPlayerTimerEx_(playerid, func[], interval, delay, count, format[], {Float, _}:...);

/**
 * <summary>Gets the name of the function that is called.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <param name="func">The name of the function.</param>
 */
native GetTimerFunctionName(timerid, func[]);

/**
 * <summary>Sets the interval of a timer.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <param name="interval">The new interval.</param>
 */
native SetTimerInterval(timerid, interval);

/**
 * <summary>Gets the interval of a timer.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <returns>0 for invalid timers or the interval (in miliseconds).</returns>
 */
native GetTimerInterval(timerid);

/**
 * <summary>Gets the time remaining before this timer is called again.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <returns>0 for invalid timers or the time (in miliseconds) until the execution.</returns>
 */
native GetTimerIntervalLeft(timerid);

/**
 * <summary>Sets the delay of a timer.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <param name="delay">The new delay.</param>
 */
native SetTimerDelay(timerid, delay);

/**
 * <summary>Sets the count of a timer.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <param name="count">The new count.</param>
 */
native SetTimerCount(timerid, count);

/**
 * <summary>Gets the number of remaining calls of this timer.</summary>
 * <param name="timerid">The ID of the timer.</param>
 * <returns>-1 for infinite timers, 0 for invalid ones and positive values for the others.</returns>
 */
native GetTimerCallsLeft(timerid);

// Kills a player's timers on disconnect.
public OnPlayerDisconnect(playerid, reason) {
	KillPlayerTimers(playerid);
	#if defined TIMERFIX_OnPlayerDisconnect
		return TIMERFIX_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect TIMERFIX_OnPlayerDisconnect
#if defined TIMERFIX_OnPlayerDisconnect
	forward TIMERFIX_OnPlayerDisconnect(playerid, reason);
#endif
