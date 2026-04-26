extends Node

var peer: NodeTunnelPeer = NodeTunnelPeer.new()
var hostID : int = -1

func _ready() -> void:
	peer.connect_to_relay("eu_central.nodetunnel.io:8080", "xxxx")
	multiplayer.multiplayer_peer = peer
	
	# DO NOT TRY HOSTING OR CONNECTING BEFORE THIS HAPPENS
	await peer.authenticated
	print("Authenticated")

func join(roomId : String):
	peer.join_room(roomId)
	print("Joining room...")
	
	await peer.room_connected
	print(peer.get_unique_id())
	print("Connected to room: ", peer.room_id)

func host():
	peer.host_room(false, "")
	
	print("Hosting room...")
	
	await peer.room_connected
	print(peer.get_unique_id())
	print("Connected to room: ", peer.room_id)
	hostID = peer.get_unique_id()
