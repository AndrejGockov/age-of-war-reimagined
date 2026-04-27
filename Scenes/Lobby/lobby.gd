extends Node2D

var hostId : int
@onready var startGameButton : Button = $StartGame
@onready var gameCode : LineEdit = $GameCode

func _ready() -> void:
	if !multiplayer.is_server():
		startGameButton.disabled = true
	
	gameCode.text = Multiplayer.peer.room_id

func _on_start_game_pressed() -> void:
	Global.changeLevelTo("res://Scenes/Game/Game.tscn")

func _on_back_button_pressed() -> void:
	if multiplayer.is_server():
		Multiplayer.changeSceneForClients.rpc("res://Scenes/Play/play.tscn")
		await get_tree().process_frame
		
		print("Host closing server")
		Multiplayer.peer.close()
		Global.changeLevelTo("res://Scenes/Play/play.tscn")
		return
	
	await Multiplayer.disconnectPeer()
	Global.changeLevelTo("res://Scenes/Play/play.tscn")
