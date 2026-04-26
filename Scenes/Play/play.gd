extends Node2D

@onready var gameButtons : VBoxContainer = $GameButtons
@onready var joinGame : VBoxContainer = $JoinGame
@onready var joinGameCode : LineEdit = $JoinGame/LineEdit

func _ready() -> void:
	pass

func _on_join_game_pressed() -> void:
	gameButtons.hide()
	joinGame.show()

func _on_connect_pressed() -> void:
	if joinGameCode.text.is_empty():
		return
	
	Multiplayer.join(joinGameCode.text)
	await Multiplayer.peer.room_connected
	Global.changeLevelTo("res://Scenes/Lobby/lobby.tscn")

func _on_host_game_pressed() -> void:
	Multiplayer.host()
	await Multiplayer.peer.room_connected
	Global.changeLevelTo("res://Scenes/Lobby/lobby.tscn")

func _on_close_join_pressed() -> void:
	gameButtons.show()
	joinGame.hide()
