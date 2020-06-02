#if !defined VC_PLUGIN_INC
	#define VC_PLUGIN_INC
	#if !defined __cplusplus

		#define VC_VERSION 0

		enum VC_Frequency {
			FREQUENCY_BEST	= 0,
			FREQUENCY_8K	= 8000,
			FREQUENCY_12K	= 12000,
			FREQUENCY_16K	= 16000,
			FREQUENCY_24K	= 24000,
			FREQUENCY_48K	= 48000
		};

		enum VC_Config {
			CONFIG_GSTREAM_VOL
		}

		native SendVoice(playerid, BitStream:bs, global);
		native StartVoice(playerid);
		native StopVoice(playerid);
		native HasVoice(playerid);
		native HasMicro(playerid);
		native SetConfig(playerid, VC_Config:configid, value);
		native GetVersion(playerid);
		native InitVoice(VC_Frequency:frequency, bitrate, Float:radius);

		forward OnPlayerVoice(playerid, BitStream:bs, Float:amplitude);

	#endif
#endif
