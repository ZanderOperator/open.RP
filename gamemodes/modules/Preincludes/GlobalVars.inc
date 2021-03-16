static
	bool:Registration_Enabled = false,
	Hour 					= 0,
	GMX 					= 0,
	WeatherSys 				= 10,
	HappyHours				= 0,
	HappyHoursLVL			= 0;

Hour_Get()
{
    return Hour;
}

Hour_Set(value)
{
    Hour = value;
}
bool:Reg_Enabled()
{
	return Registration_Enabled;
}

Reg_SetEnabled(bool:v)
{
	Registration_Enabled = v;
}

Weather_Get()
{
    return WeatherSys;
}

Weather_Set(value)
{
    WeatherSys = value;
}

HappyHours_Get()
{
    return HappyHours;
}

HappyHours_Set(value)
{
    HappyHours = value;
}

HappyHoursLvl_Get()
{
    return HappyHoursLVL;
}

HappyHoursLvl_Set(value)
{
    HappyHours = value;
}

GMX_Get()
{
    return GMX;
}

GMX_Set(value)
{
    GMX = value;
}