#include <YSI_Coding\y_hooks>

public OnPlayerRequestDownload(playerid, type, crc)
{
    return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}