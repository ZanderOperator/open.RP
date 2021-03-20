static
	bool:Registration_Enabled = false,
	
	GMX 					= 0;




bool:Reg_Enabled()
{
	return Registration_Enabled;
}

Reg_SetEnabled(bool:v)
{
	Registration_Enabled = v;
}


GMX_Get()
{
    return GMX;
}

GMX_Set(value)
{
    GMX = value;
}