/*******************************************************************************
Function Set

GitHub Link: https://github.com/YashasSamaga/function_set
*******************************************************************************/
#include <a_samp>
/******************************************************************************/
#define function_set:%0<%1> fset:%0[%1]
#define pass_ref<%0> _FS_GetVariableAddress(%0)

#define MAX_PUBLIC_FUNCTIONS 2000
#define MAX_FUNC_NAME 32
/******************************************************************************/
stock _FS_GetVariableAddress(&var)
{
	#emit LOAD.S.pri var
	#emit RETN
	return 0;
}
/******************************************************************************/
ExecuteFunctionSet(fset:funcs[], ...)
{
	new argsize, argstart, argend;

	#emit LCTRL 5
	#emit ADD.C 12
	#emit STOR.S.pri argstart

 	#emit LOAD.S.pri  8
	#emit CONST.alt 4
	#emit SUB
	#emit STOR.S.pri argsize

	#emit LOAD.S.alt argstart
	#emit ADD
	#emit STOR.S.pri argend

	for(new i = 0, addr = funcs[0]; addr; addr = funcs[++i])
	{
     	new argpos = argend;
	    while(argpos > argstart)
	    {
	        #emit LREF.S.pri argpos
	        #emit LOAD.I
	        #emit PUSH.pri
	        argpos -= 4;
	    }

		#emit PUSH.S argsize

		#emit LCTRL 6
		#emit ADD.C 28
		#emit PUSH.pri
		#emit LOAD.S.pri addr
		#emit SCTRL 6
	}
	return 1;
}
AddAddressToFunctionSet(fset:funcs[], address)
{
    new pos = GetFunctionSetSize(funcs);
    funcs[pos] = fset:address;
    return true;
}
AddPublicToFunctionSet(fset:funcs[], funcname[])
{
	new fidx = funcidx(funcname);
	if(fidx == -1)
		return false;

	new address;
    #emit LCTRL 1
	#emit NEG
	#emit ADD.C 32
	#emit STOR.S.pri address
	#emit LREF.S.alt address
	#emit LCTRL 1
	#emit NEG
	#emit ADD
	#emit LOAD.S.alt idx
	#emit SHL.C.alt 3
	#emit ADD
	#emit STOR.S.pri address
	#emit LREF.S.pri address
	#emit STOR.S.pri address

   	return AddAddressToFunctionSet(funcs, address);
}
RemovePublicFromFunctionSet(fset:funcs[], funcname[])
{
	new fidx = funcidx(funcname);
	if(fidx == -1)
		return false;

    new address;
    #emit LCTRL 1
	#emit NEG
	#emit ADD.C 32
	#emit STOR.S.pri address
	#emit LREF.S.alt address
	#emit LCTRL 1
	#emit NEG
	#emit ADD
	#emit LOAD.S.alt idx
	#emit SHL.C.alt 3
	#emit ADD
	#emit STOR.S.pri address
	#emit LREF.S.pri address
	#emit STOR.S.pri address
	
	return RemoveAddressFromFunctionSet(funcs, address)
}
RemoveAddressFromFunctionSet(fset:funcs[], search_addr)
{
	for(new i = 0, addr = funcs[0]; addr; addr = funcs[++i])
	{
	    if(search_addr == addr)
	    {
	    	while(funcs[i]);
	            funcs[i] = funcs[++i];
      		return true;
      	}
	}
	return false;
}
GetFunctionSetSize(fset:funcs[])
{
	new size = 0;
   	while(funcs[size])
   		size++;
	return size;
}
