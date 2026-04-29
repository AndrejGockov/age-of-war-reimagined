extends Node2D

@onready var startGameButton : Button = $StartGame
@onready var gameCode : LineEdit = $GameCode

func _ready() -> void:
	if multiplayer.is_server():
		gameCode.text = Multiplayer.peer.room_id
		
		multiplayer.peer_connected.connect(onPeerConnects)
		multiplayer.peer_disconnected.connect(onPeerDisconnects)
		$Players/Player_2/PlayerName.editable = false
		$Players/Player_2/FactionList.disabled = true
	else:
		gameCode.text = Multiplayer.roomCode
		$Players/Player_1/PlayerName.editable = false
		$Players/Player_1/FactionList.disabled = true
		
		# Only hosts can start the game
		startGameButton.disabled = true
	
	for player in $Players.get_children():
		var factionList = player.get_node("FactionList")
		
		for faction in Global.factions:
			factionList.add_item(faction)

# Handles game starting
func _on_start_game_pressed() -> void:
	setPlayerData.rpc()
	
	await get_tree().process_frame
	
	Global.changeLevelTo("res://Scenes/Game/Game.tscn")

# Called when either player leaves lobby
func _on_disconnect_button_pressed() -> void:
	if multiplayer.is_server():
		Multiplayer.changeSceneForClients.rpc("res://Scenes/Play/play.tscn")
		await get_tree().process_frame
		
		print("Host closing server")
		Multiplayer.peer.close()
		Global.changeLevelTo("res://Scenes/Play/play.tscn")
		return
	
	await Multiplayer.disconnectPeer()
	Global.changeLevelTo("res://Scenes/Play/play.tscn")

func _on_player_name_text_changed(new_text : String) -> void:
	updatePlayerName.rpc(Multiplayer.getSenderID(), new_text)

func _on_faction_list_item_selected(index : int) -> void:
	updateFaction.rpc(Multiplayer.getSenderID(), index)

# Send hosts data when peer connects
func onPeerConnects(id : int) -> void:
	# Gets the hosts data
	var hostName = $Players/Player_1/PlayerName.text
	var hostFaction = $Players/Player_1/FactionList.selected
	
	# Sends the hosts data to the user
	updatePlayerName.rpc_id(id, Multiplayer.getSenderID(), hostName)
	updateFaction.rpc_id(id, Multiplayer.getSenderID(), hostFaction)

# Reset fresh values when peer disconnects
func onPeerDisconnects(id : int) -> void:
	print("Player 2 disconnected")
	$Players/Player_2/PlayerName.text = "Player_2"
	$Players/Player_2/FactionList.selected = 0

# Sends updated player name to peers
@rpc("any_peer", "call_local", "reliable")
func updatePlayerName(senderID : int, playerName : String) -> void:
	var selectedCaret : int
	if senderID == 1:
		selectedCaret = $Players/Player_1/PlayerName.caret_column
		$Players/Player_1/PlayerName.text = playerName
		$Players/Player_1/PlayerName.caret_column = selectedCaret
	else:
		selectedCaret = $Players/Player_2/PlayerName.caret_column
		$Players/Player_2/PlayerName.text = playerName
		$Players/Player_2/PlayerName.caret_column = selectedCaret

# Sends updated faction to peers
@rpc("any_peer", "call_local", "reliable")
func updateFaction(senderID : int, index : int) -> void:
	if senderID == 1:
		$Players/Player_1/FactionList.selected = index
	else:
		$Players/Player_2/FactionList.selected = index

@rpc("any_peer", "call_local", "reliable")
func setPlayerData() -> void:
	var playerName : String = $Players/Player_1/PlayerName.text
	var faction : Faction = Global.setFaction($Players/Player_1/FactionList.selected)
	var direction : int = 1
	
	if !multiplayer.is_server():
		playerName = $Players/Player_2/PlayerName.text
		faction = Global.setFaction($Players/Player_2/FactionList.selected)
		direction = -1
	
	Global.setPlayerData(playerName, faction, direction)
