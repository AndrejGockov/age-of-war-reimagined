extends Node

var peer : NodeTunnelPeer
var hostID : int = -1

var roomCode : String = ""

func _process(delta: float) -> void:
	pass
	# Uncomment for debugging purpouses
	#if multiplayer.multiplayer_peer == null:
		#return
	#
	#if !multiplayer.is_server():
		#return
	#
	#await get_tree().create_timer(5.0).timeout
	#var total_participants = multiplayer.get_peers().size() + 1
	#print("Connected clients: ", total_participants)

func setupNewPeer() -> void:
	# Closes old peer if it exists
	if peer:
		peer.close()
	
	# Creates new peer and connects to nodetunnel
	peer = NodeTunnelPeer.new()
	peer.connect_to_relay("eu_central.nodetunnel.io:8080", "xxxxx")
	multiplayer.multiplayer_peer = peer
	
	# DO NOT TRY HOSTING OR CONNECTING BEFORE THIS PRINTS -Andrej
	await peer.authenticated
	print("Peer authenticated")

func disconnectPeer() -> void:
	Multiplayer.peer.close()
	multiplayer.multiplayer_peer = null
	setupNewPeer()
	#Multiplayer.peer.disconnect_peer(Multiplayer.peer.get_unique_id())

func join(roomID : String):
	await setupNewPeer()
	peer.join_room(roomID)
	print("Joining room...")
	
	await peer.room_connected
	
	roomCode = roomID
	print(peer.get_unique_id())
	print("Connected to room: ", peer.room_id)

func host():
	await setupNewPeer()
	peer.host_room(false, "")
	print("Hosting room...")
	
	await peer.room_connected
	print("Connected to room: ", peer.room_id)
	
	hostID = peer.get_unique_id()

@rpc("authority", "call_remote", "reliable")
func changeSceneForClients(scene_path: String) -> void:
	Global.changeLevelTo(scene_path)

func getSenderID() -> int:
	var senderID = multiplayer.get_remote_sender_id()
	if senderID == 0: 
		senderID = multiplayer.get_unique_id()
	return senderID
