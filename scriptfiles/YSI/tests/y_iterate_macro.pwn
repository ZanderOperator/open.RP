#define RUN_TESTS 
#include <YSI\y_testing> 
#include <YSI\y_iterate> 

#define CHILD 	(10)
#define PARENT	(CHILD+1)

Test:ForeachLoop() 
{
	new
		Iterator:Testcase[PARENT]<CHILD>,
		total = 0;
		
	Iter_Init(Testcase);
	for(new i = 0; i != PARENT; ++i) 
	{
		for(new j = 0; j != CHILD; ++j) 
		{
			Iter_Add(Testcase[i], j);
		}
		total += Iter_Count(Testcase[i]);
	}
	ASSERT(total == (CHILD*PARENT));
}