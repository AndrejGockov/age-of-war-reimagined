extends Node

var peer : NodeTunnelPeer
var hostID : int = -1

var roomCode : String = ""

var config = ConfigFile.new()
var err

func _process(delta: float) -> void:
	err = config.load("res://secrets.cfg")
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
	if err != OK:
		print("Failed to connect to nodetunnel")
		return
	
	# Closes old peer if it exists
	if peer:
		peer.close()
	
	# Creates new peer and connects to nodetunnel
	peer = NodeTunnelPeer.new()
	peer.connect_to_relay("eu_central.nodetunnel.io:8080", 
	config.get_value("nodetunnel", "id"))
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
