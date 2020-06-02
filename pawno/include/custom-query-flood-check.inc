// SA-MP Custom Query Flood Check
// Version : 1.0
// Author  : Spmn
// 
// https://github.com/spmn/samp-custom-query-flood-check

forward OnQueryFloodCheck(queryType, binaryAddress); 
/*
 * Info:
 *  - called when a query is received
 *
 * Parameters:
 *  - queryType     : a single character corresponding to the packet identifier as explained here: http://wiki.sa-mp.com/wiki/Query_Mechanism#Opcodes
 *  - binaryAddress : IP address of requester as a 32-bit unsigned integer
 *
 * Returns:
 *  -   0 (ZERO)    : process the query
 *  - !=0 (NONZERO) : don't process the query
 *
 * Notes:
 *  - If any script returns NONZERO in this callback then current query won't get processed.
 *  - If this callback is missing from all loaded scripts, then the plugin will **PROCESS ALL QUERIES** and will print a warning message in server log. 
 */