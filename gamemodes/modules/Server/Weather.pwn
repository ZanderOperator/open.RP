#include <YSI_Coding\y_hooks>

static
	WeatherTimer 			= 0,
    WeatherSys 				= 10;

Weather_Get()
{
    return WeatherSys;
}

Weather_Set(value)
{
    WeatherSys = value;
}

task GlobalWeatherTask[1000]()
{
    DynamicWeather();
    return 1;
}

static DynamicWeather()
{
	if(gettimestamp() >= WeatherTimer)
	{
		WeatherTimer = gettimestamp() + 6000;
		new tmphour,
			tmpminute,
			tmpsecond;

		gettime(tmphour, tmpminute, tmpsecond);

		if(tmphour >= 6 && tmphour <= 20)
		{
			new RandomWeather;
			RandomWeather = randomEx(0,6);
			switch(RandomWeather)
			{
				case 0:
				{
					SetWeather(1);
					Weather_Set(1);
				}
				case 1:
				{
					SetWeather(7);
					Weather_Set(7);
				}
				case 2:
				{
					SetWeather(8);
					Weather_Set(8);
				}
				case 3:
				{
					SetWeather(13);
					Weather_Set(13);
				}
				case 4:
				{
					SetWeather(15);
					Weather_Set(15);
				}
				case 5:
				{
					SetWeather(17);
					Weather_Set(17);
				}
				case 6:
				{
					SetWeather(10);
					Weather_Set(10);
				}
			}
		}
		else if(tmphour >= 21 && tmphour <= 5)
		{
			SetWeather(10);
			Weather_Set(10);
		}
	}
	return 1;
}

hook OnGameModeInit()
{
    Weather_Set(10);
	SetWeather(10);
    return 1;
}