extends Node2D

var hostId : int
@onready var startGameButton : Button = $StartGame
@onready var gameCode : LineEdit = $GameCode

func _ready() -> void:
	if Multiplayer.peer.get_unique_id() != Multiplayer.hostID:
		startGameButton.disabled = true
	
	gameCode.text = Multiplayer.peer.room_id

func _process(delta: float) -> void:
	pass

# WIP 
# Only changes for the host 
func _on_start_game_pressed() -> void:
	Global.changeLevelTo("res://Scenes/Game/Game.tscn")
