extends Node
class_name Network

var server_port := 2608
var server_ip := "127.0.0.1"


func start_client() -> int:
	var peer := StreamPeerTCP.new()

	var err := peer.connect_to_host(server_ip, server_port)
	if err != OK:
		return err

	#get_tree().set_network_peer(peer)

	return OK

func start_server() -> int:
	var peer := TCP_Server.new()

	var err := peer.listen(server_port, server_ip)

	if err != OK:
		return err

	#get_tree().set_network_peer(peer)

	return OK

func stop() -> void:
	if get_tree().network_peer != null:
		if get_tree().network_peer is WebSocketClient:
			get_tree().network_peer.disconnect_from_host()
		elif get_tree().network_peer is WebSocketServer:
			get_tree().network_peer.stop()

