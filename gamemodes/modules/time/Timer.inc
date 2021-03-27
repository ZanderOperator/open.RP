task GlobalServerTimer[1000]()
{
	new
		tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);

	if((tmphour > Hour_Get()) || (tmphour == 0 && Hour_Get() == 23))
	{
		SetWorldTime(tmphour);
		Hour_Set(tmphour);
	}
	if(GMX_Get() != 1 && tmphour == 5 && tmpmins == 5 && tmpsecs < 10)
	{
		CheckAccountsForInactivity();
		#if defined AUTO_RESTART_SEQ
		StartGMX();
		#endif
	}
	return 1;
}