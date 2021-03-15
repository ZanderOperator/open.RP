/**
 * y_inline support include for BlueG's MySQL plugin
 */

#if defined a_mysql_yinline_included
	#endinput
#endif
#define a_mysql_yinline_included

#tryinclude <a_mysql>

#if !defined mysql_tquery
	#error You have to include the MySQL plugin include before this one!
#endif

#tryinclude <YSI_Coding\y_inline>
#tryinclude <YSI\y_inline>
#include <YSI_Internal\y_addons>

#if !defined E_CALLBACK_DATA
	#error You have to include the y_inline include before this one!
#endif


/*
native mysql_tquery_inline(MySQL:handle, const query[], callback:Callback, const format[], {Float,_}:...);
native MySQL_TQueryInline(MySQL:handle, const query[], callback:Callback, const format[], {Float,_}:...);
*/

/*
native orm_select_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
native orm_update_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
native orm_insert_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
native orm_delete_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
native orm_load_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
native orm_save_inline(ORM:id, callback:Callback, const format[], {Float,_}:...);
*/


forward __int_MysqlInline_Invoke();
public __int_MysqlInline_Invoke()
{
	mysql_tquery(MYSQL_INVALID_HANDLE, "");
	mysql_pquery(MYSQL_INVALID_HANDLE, "");
	
	orm_select(MYSQL_INVALID_ORM);
	orm_update(MYSQL_INVALID_ORM);
	orm_insert(MYSQL_INVALID_ORM);
	orm_delete(MYSQL_INVALID_ORM);
	orm_load(MYSQL_INVALID_ORM);
	orm_save(MYSQL_INVALID_ORM);
}

stock mysql_tquery_inline(MySQL:handle, const query[], callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 4;
	const num_const_args_native = 7;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S query
	#emit PUSH.S handle
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C mysql_tquery
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock MySQL_TQueryInline(MySQL:handle, const query[], callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 4;
	const num_const_args_native = 7;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad";
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S query
	#emit PUSH.S handle
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C mysql_pquery
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_select_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_select
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_update_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_update
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_insert_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_insert
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_delete_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_delete
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_load_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_load
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

stock orm_save_inline(ORM:orm_id, callback:inline_callback, const format[] = "", {Float,_}:...)
{
	const num_const_args = 3;
	const num_const_args_native = 6;
	
	new cb_data[E_CALLBACK_DATA];
	if(!Callback_Get(inline_callback, cb_data))
		return false;
	
	new cb_format[33] = "sad"; // :(
	strcat(cb_format, format);
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;
	new inline_res_cb[] = "__MysqlInlineProcessCallback";
	new cb_data_size = sizeof cb_data;
	new return_val;
	
	new first_vparam_addr;
	
	//write address of 'format' into 'first_vparam_addr'
	#emit ADDR.PRI format // PRI = FRM + format
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//load vararg into PRI
		#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
		
		//variable arguments are always references, so we have 
		//to dereference it to get the actual value
		#emit LOAD.I //PRI = [PRI]
		
		#emit PUSH.pri
	}
	
	
	#emit PUSH.ADR cb_data_size
	#emit PUSH.ADR cb_data
	#emit PUSH.S format
	#emit PUSH.ADR cb_format
	#emit PUSH.ADR inline_res_cb
	#emit PUSH.S orm_id
	
	#emit PUSH.S args_count_native_byte
	
	#emit SYSREQ.C orm_save
	
	#emit STOR.S.pri return_val
	
	#emit STACK 4 //args_count_native_byte
	
	for(; args_count_native_byte > 0; args_count_native_byte -= 4)
	{
		#emit STACK 4
	}
	
	return return_val;
}

forward __MysqlInlineProcessCallback(const params_format[], cb_data[E_CALLBACK_DATA], cb_data_size, ...);
public __MysqlInlineProcessCallback(const params_format[], cb_data[E_CALLBACK_DATA], cb_data_size, ...)
{
	const num_const_args = 3;
	const num_const_args_native = 1;
	
	new args_count = numargs();
	new args_count_byte = args_count * 4;
	new args_count_native_byte = (args_count - num_const_args + num_const_args_native) * 4;

	new first_vparam_addr;

	//write address of 'cb_data_size' into 'first_vparam_addr'
	#emit ADDR.PRI cb_data_size // PRI = FRM + cb_data_size
	#emit STOR.S.pri first_vparam_addr //[FRM + first_vparam_addr] = PRI
	
	new param_addr = first_vparam_addr + (args_count_byte - num_const_args * 4);
	new idx = strlen(params_format);
	for (; param_addr > first_vparam_addr; param_addr -= 4)
	{
		//variable arguments are always references, however,
		//we DON'T dereference here because we told the MySQL plugin
		//via the callback format parameter, that we pushed literal
		//values, NOT references
		//...unless the parameter is a string/array, then we
		//have to dereference it
		
		idx--;
		if(params_format[idx] == 's' || params_format[idx] == 'a')
		{
			#emit LOAD.S.pri param_addr //PRI = [FRM + param_addr]
			#emit LOAD.I //PRI = [PRI]
			#emit PUSH.pri
		}
		else
		{
			#emit PUSH.S param_addr
		}
	}
	
	#emit PUSH.S cb_data
	
	#emit PUSH.S args_count_native_byte
	
	#emit LCTRL 6
	#emit ADD.C 28 // (4+4) + 4 + (4+4) + (4+4)
	#emit PUSH.pri
	#emit CONST.pri Callback_Call
	#emit SCTRL 6
	
	Callback_Release(cb_data);
	return 1;
}
