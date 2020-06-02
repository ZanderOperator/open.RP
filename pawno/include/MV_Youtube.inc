#include <a_http>
#include <a_json>

#define USE_VERSION   0

/*
	0 = youtubemp3script
	1 = VPS api
*/

#define MAX_YOUTUBE_SAVES	50
#define INVALID_YT_ID		-1
#define INVALID_PLAYLIST_ID	-1
#define MAX_PLAYLISTS		5

#if USE_VERSION == 0
#define API_KEY				"1234567"
#elseif USE_VERSION == 1
#define CONVERTER_PATH		"michaelbelgium.me/ytconverter"
#define REMOVE_ON_FINISHED	true 		//Remove the downloaded song when the song finished playing or not
#define MAX_SEARCH_RESULTS 	5
#endif

enum e_ytv
{
	bool:Playing,
	ytID[16],
	Duration,
	Title[256],
	Link[256],
	StreamLink[256],
	PlayFor,
	PlaylistID,
	Float:Distance,
	bool:UsePos,
	Timer
};

new Youtube[MAX_YOUTUBE_SAVES][e_ytv];

enum e_plist
{
    bool:Active,
    Name[32]
};

new Playlist[MAX_PLAYLISTS][e_plist];

enum pSearchResult
{
	Title[64],
	Link[128]
};

new SearchResults[MAX_PLAYERS][MAX_SEARCH_RESULTS][pSearchResult];

forward OnYoutubeVideoFinished(youtubeid);
forward SongFinished(youtubeid);
forward OnYtMp3Response(index, response_code, data[]);
forward OnVpsResponse(index, response_code, data[]);
forward OnSearchResponse(index, response_code, data[]);
forward OnMVYoutubeError(youtubeid, message[]);
forward OnYoutubeVideoStart(youtubeid);
forward OnPlaylistAddEntry(playerlistid, youtubeid);
forward OnPlaylistFinished(playlistid);
forward OnYoutubeSearch(playerid);


stock PlayYoutubeVideoFor(url[], playfor = INVALID_PLAYER_ID, playlist = INVALID_PLAYLIST_ID, bool:usepos = false, Float:distance = 50.0)
{
	new id = GetFreeIndex(), requestlink[128];

	if(id != INVALID_YT_ID)
	{
		Youtube[id][PlayFor] = playfor;
		Youtube[id][Distance] = distance;
		Youtube[id][UsePos] = usepos;
		Youtube[id][PlaylistID] = playlist;

		if(strfind(url,"&") != -1) strmid(url,url,0,strfind(url,"&"), 128);
		format(Youtube[id][Link],256,"%s",url);

		#if USE_VERSION == 0
		format(requestlink,sizeof(requestlink),"www.yt-mp3.com/fetch?v=%s&apikey=%s",Youtube[id][Link], API_KEY);
		HTTP(id, HTTP_GET, requestlink, "", "OnYtMp3Response");
		#else
		strmid(Youtube[id][ytID], url, strfind(url, "watch?v=", true) + strlen("watch?v="), strlen(url), 16);
		format(requestlink,sizeof(requestlink),"%s/convert.php?youtubelink=%s",CONVERTER_PATH,Youtube[id][Link]);
		HTTP(id, HTTP_GET, requestlink, "", "OnVpsResponse");
		#endif
	}
	return id;
}

stock SearchYoutubeVideos(playerid, searchquery[])
{
	new requestlink[128];
	format(requestlink, sizeof(requestlink), "%s/search.php?q=%s&max_results=%i", CONVERTER_PATH, searchquery, MAX_SEARCH_RESULTS);
	HTTP(playerid, HTTP_GET, requestlink, "", "OnSearchResponse");
}

stock GetFreeIndex()
{
	for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)
	{
		if(!Youtube[i][Playing] && Youtube[i][PlaylistID] == INVALID_PLAYLIST_ID) return i;
	}

	print("[Warning] MV_Youtube: MAX_YOUTUBE_SAVES reached!");
	return INVALID_YT_ID;
}

stock StopYoutubeVideo(youtubeid)
{
	Youtube[youtubeid][Playing] = false;
	KillTimer(Youtube[youtubeid][Timer]);

	if(Youtube[youtubeid][PlayFor] == INVALID_PLAYER_ID)
	{
		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
		{
			if(!IsPlayerConnected(i)) continue;
			StopAudioStreamForPlayer(i);
		}
	}
	else
		StopAudioStreamForPlayer(Youtube[youtubeid][PlayFor]);
}

stock IsValidYoutubeURL(string[])			return (strfind(string,"youtube.com") != -1 && strfind(string,"watch?v=") != -1);
stock IsYouTubeVideoPlaying(youtubeid)		return youtubeid == INVALID_YT_ID ? false : Youtube[youtubeid][Playing];
stock GetPlaylistFromVideo(youtubeid)		return youtubeid == INVALID_YT_ID ? INVALID_PLAYLIST_ID : Youtube[youtubeid][PlaylistID];
stock GetVideoDuration(youtubeid)			return youtubeid == INVALID_YT_ID ? 0 : Youtube[youtubeid][Duration];
stock GetVideoTarget(youtubeid)				return youtubeid == INVALID_YT_ID ? -1 : Youtube[youtubeid][PlayFor];
stock GetVideoTitle(youtubeid)
{
    new str[256];
    strins(str, Youtube[youtubeid][Title], 0);
    return str;
}

stock GetVideoLink(youtubeid)
{
    new str[256];
    strins(str, Youtube[youtubeid][Link], 0);
    return str;
}

stock GetVideoStreamLink(youtubeid)
{
	new str[256];
	strins(str, Youtube[youtubeid][StreamLink], 0);
	return str;
}

stock CreatePlaylist(name[])
{
	for(new i = 0; i < MAX_PLAYLISTS; i++)
	{
		if(Playlist[i][Active]) continue;
		Playlist[i][Active] = true;
		format(Playlist[i][Name], 32, "%s", name);
		return i;
	}

	print("[Warning] MV_Youtube: MAX_PLAYLISTS reached!");
	return INVALID_PLAYLIST_ID;
}

stock RemovePlaylist(playlistid)
{
	if(playlistid != INVALID_PLAYLIST_ID)
	{
		Playlist[playlistid][Active] = false;
		Playlist[playlistid][Name] = EOS;

		for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)
			if(Youtube[i][PlaylistID] == playlistid)
				Youtube[i][PlaylistID] = INVALID_PLAYLIST_ID;
	}
}

stock GetPlaylistName(playlistid)
{
	new str[32];
	strins(str, Playlist[playlistid][Name], 0);
	return str;
}

stock GetPlaylistSongs(playlistid)
{
	new songs[MAX_YOUTUBE_SAVES], pointer = 0;

	for(new i = 0; i < MAX_YOUTUBE_SAVES; i++) songs[i] = INVALID_YT_ID;
	for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)
	{
		if(Youtube[i][PlaylistID] != playlistid) continue;
		songs[pointer] = i;
		pointer++;
	}
	return songs;
}

stock GetPlaylistSongsCount(playlistid)
{
	new count = 0;

	for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)
	{
		if(Youtube[i][PlaylistID] != playlistid) continue;
		count++;
	}

	return count;
}

PlayYoutubeVideo(youtubeid) //shouldn't use this function outside of the include.
{
	new Float:pos[3];

	Youtube[youtubeid][Playing] = true;

	CallLocalFunction("OnYoutubeVideoStart", "i", youtubeid);

	if(Youtube[youtubeid][PlayFor] == INVALID_PLAYER_ID)
	{
		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(Youtube[youtubeid][UsePos]) GetPlayerPos(i, pos[0], pos[1], pos[2]);
				PlayAudioStreamForPlayer(i, Youtube[youtubeid][StreamLink], pos[0], pos[1], pos[2], Youtube[youtubeid][Distance], Youtube[youtubeid][UsePos]);
			}
		}
	}
	else
	{
		if(Youtube[youtubeid][UsePos]) GetPlayerPos(Youtube[youtubeid][PlayFor], pos[0], pos[1], pos[2]);
		PlayAudioStreamForPlayer(Youtube[youtubeid][PlayFor], Youtube[youtubeid][StreamLink], pos[0], pos[1], pos[2], Youtube[youtubeid][Distance], Youtube[youtubeid][UsePos]);
	}

	Youtube[youtubeid][Timer] = SetTimerEx("SongFinished",GetVideoDuration(youtubeid)*1000,false,"i",youtubeid);
}

public OnVpsResponse(index, response_code, data[])
{
	new string[256];

	if(response_code != 200)
	{
		format(string, sizeof(string), "%s - response code: %i", GetError(response_code), response_code);
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	new JSONNode:response = json_parse_string(data);

	if(index == 9999)
	{
		if(json_get_bool(response, "error"))
		{
			json_get_string(response, string, sizeof(string), "message");
			CallLocalFunction("OnMVYoutubeError", "is", index, string);
		}
		return 0;
	}

	if(json_get_bool(response, "error"))
	{
		json_get_string(response, string, sizeof(string), "message");
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	json_get_string(response, Youtube[index][Title], 256, "title");
	Youtube[index][Duration] = json_get_int(response, "duration");
	json_get_string(response, Youtube[index][StreamLink], 512, "file");

	json_close(response);

	if(Youtube[index][PlaylistID] != INVALID_PLAYLIST_ID)
	{
		CallLocalFunction("OnPlaylistAddEntry", "ii", Youtube[index][PlaylistID], index);

		if(GetPlaylistSongsCount(Youtube[index][PlaylistID]) != 1)
			return 0;
	}

	PlayYoutubeVideo(index);
	return 1;
}

public OnYtMp3Response(index, response_code, data[])
{
	new string[256];

	if(response_code != 200)
	{
		format(string, sizeof(string), "%s - response code: %i", GetError(response_code), response_code);
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	new JSONNode:response = json_parse_string(data), status[8];

	json_get_string(response, status, sizeof(status), "status");

	if(!strcmp(status, "error", true))
	{
		json_get_string(response, string, sizeof(string), "message");
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	json_get_string(response, Youtube[index][Title], 256, "title");
	Youtube[index][Duration] = json_get_int(response, "length");
	json_get_string(response, Youtube[index][StreamLink], 512, "url");
	strins(Youtube[index][StreamLink], "http:", 0);

	json_close(response);

	if(Youtube[index][PlaylistID] != INVALID_PLAYLIST_ID)
	{
		CallLocalFunction("OnPlaylistAddEntry", "ii", Youtube[index][PlaylistID], index);

		if(GetPlaylistSongsCount(Youtube[index][PlaylistID]) != 1)
			return 0;
	}

	PlayYoutubeVideo(index);
	return 1;
}

public OnSearchResponse(index, response_code, data[])
{
	new JSONNode:response = json_parse_string(data), JSONArray:results, string[128];

	if(response_code != 200)
	{
		format(string, sizeof(string), "%s - response code: %i", GetError(response_code), response_code);
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	if(json_get_bool(response, "error"))
	{
		json_get_string(response, string, sizeof(string), "message");
		CallLocalFunction("OnMVYoutubeError", "is", index, string);
		return 0;
	}

	results = json_get_array(response, "results");

	new title[128], link[256];
	for(new i = 0; i < json_array_count(results); i++)
	{
		new JSONNode:node = json_array_at(results, i);

		json_get_string(node, title, sizeof(title), "title");
		json_get_string(node, link, sizeof(link), "full_link");

		format(SearchResults[index][i][Title], sizeof(title), "%s", title);
		format(SearchResults[index][i][Link], sizeof(link), "%s", link);
	}

	CallLocalFunction("OnYoutubeSearch", "i", index);
	return 1;
}

public SongFinished(youtubeid)
{
	StopYoutubeVideo(youtubeid);

	#if USE_VERSION == 1
		#if REMOVE_ON_FINISHED
		new string[128];
		format(string,sizeof(string),"%s/convert.php?delete=%s",CONVERTER_PATH,Youtube[youtubeid][ytID]);
		HTTP(9999, HTTP_GET, string, "", "OnVpsResponse");
		#endif
	#endif

	CallLocalFunction("OnYoutubeVideoFinished","i",youtubeid);

	if(Youtube[youtubeid][PlaylistID] != INVALID_PLAYLIST_ID)
	{
		new plist = Youtube[youtubeid][PlaylistID], bool:finished = true;
		Youtube[youtubeid][PlaylistID] = INVALID_PLAYLIST_ID;

		for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)
		{
			if(Youtube[i][PlaylistID] != plist) continue;
			PlayYoutubeVideo(i);
			finished = false;
			break;
		}

		if(finished)
			CallLocalFunction("OnPlaylistFinished", "i", plist);
	}
}

stock GetError(val)
{
	new error[32];
	switch(val)
	{
		case 1: error = "Bad host";
		case 2: error = "No socket";
		case 3: error = "Can't connect";
		case 4: error = "Can't write";
		case 5: error = "Content too big";
		case 6: error = "Malformed response";
		case 300..308: error = "Redirection";
		case 400..499: error = "Client error";
		case 500..599: error = "Server error";
	}
	return error;
}

public OnGameModeInit()
{
	for(new i = 0; i < MAX_YOUTUBE_SAVES; i++)	Youtube[i][PlaylistID] = INVALID_PLAYLIST_ID;

	#if defined MV_OnGameModeInit
		return MV_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit MV_OnGameModeInit
#if defined MV_OnGameModeInit
	forward MV_OnGameModeInit();
#endif
