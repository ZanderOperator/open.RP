/*
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
Contributors:
	- algorhitmically

Thanks to:
	- Incognito - streamer plugin.
	- Abagail and Crayder - modelsizes include.

Required plugins:
	- Streamer
*/

/*
	  ______   _______   ________  ______  _______   _______    ______   __       __ 
	 /      \ /       \ /        |/      |/       \ /       \  /      \ /  |  _  /  |
	/$$$$$$  |$$$$$$$  |$$$$$$$$/ $$$$$$/ $$$$$$$  |$$$$$$$  |/$$$$$$  |$$ | / \ $$ |
	$$ |  $$ |$$ |__$$ |   $$ |     $$ |  $$ |  $$ |$$ |__$$ |$$ |__$$ |$$ |/$  \$$ |
	$$ |  $$ |$$    $$/    $$ |     $$ |  $$ |  $$ |$$    $$< $$    $$ |$$ /$$$  $$ |
	$$ |  $$ |$$$$$$$/     $$ |     $$ |  $$ |  $$ |$$$$$$$  |$$$$$$$$ |$$ $$/$$ $$ |
	$$ \__$$ |$$ |         $$ |    _$$ |_ $$ |__$$ |$$ |  $$ |$$ |  $$ |$$$$/  $$$$ |
	$$    $$/ $$ |         $$ |   / $$   |$$    $$/ $$ |  $$ |$$ |  $$ |$$$/    $$$ |
	 $$$$$$/  $$/          $$/    $$$$$$/ $$$$$$$/  $$/   $$/ $$/   $$/ $$/      $$/ 
	 
*/

#if defined _optidraw_included
	#endinput
#endif

#if !defined _optidraw_included
	#tryinclude "optidraw_Data\od_entry"
#endif

#if !defined _optidraw_included
	#tryinclude "od_entry"
#endif

#if !defined _optidraw_included
	#tryinclude <od_entry>
#endif

#if !defined _optidraw_included
	#error Optidraw: Cannot find od_entry.
#endif