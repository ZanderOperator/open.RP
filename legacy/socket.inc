#if defined socket_included
	#endinput
#endif
#define socket_included

#define MAX_SOCKETS 10
#define INVALID_SOCKET (-1)
#define NO_IP_RETURN "0.0.0.0"

enum pType {
	TCP = 1,
	UDP = 2
};

native Socket:socket_create(pType:TCP); // udp & tcp
native socket_bind(Socket:id, ip[]); // udp & tcp
native socket_connect(Socket:id, host[], port); // udp & tcp
native socket_listen(Socket:id, port); // udp & tcp
native socket_stop_listen(Socket:id); // udp & tcp
native socket_destroy(Socket:id); // udp & tcp
native socket_send(Socket:id, data[], len); // udp & tcp
native is_socket_valid(Socket:id); // udp & tcp
native socket_set_max_connections(Socket:id, max_remote_clients); // tcp only
native socket_close_remote_client(Socket:id, remote_clientid); // tcp only
native socket_sendto_remote_client(Socket:id, remote_clientid, data[]); // tcp only
native socket_remote_client_connected(Socket:id, remote_clientid); // tcp only
native get_remote_client_ip(Socket:id, remote_clientid, ip[]); // tcp only


// client & server (udp)
forward onUDPReceiveData(Socket:id, data[], data_len, remote_client_ip[], remote_client_port);
// client only (tcp)
forward onSocketAnswer(Socket:id, data[], data_len); // called when socket_connect() has been used and the server sends data
forward onSocketClose(Socket:id);
// server only (tcp)
forward onSocketReceiveData(Socket:id, remote_clientid, data[], data_len); // called when a remote client sends data
forward onSocketRemoteConnect(Socket:id, remote_client[], remote_clientid); // called when a remote client connects to our socket server
forward onSocketRemoteDisconnect(Socket:id, remote_clientid); // called when a remote client disconnects from our socket server