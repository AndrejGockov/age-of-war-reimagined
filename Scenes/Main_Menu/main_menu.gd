extends Node2D

@onready var gameButtons : VBoxContainer = $GameButtons
@onready var joinGame : VBoxContainer = $JoinGame
@onready var hostGame : VBoxContainer = $HostGame

@onready var joinGameCode : LineEdit = $JoinGame/LineEdit

@onready var hostGameCode : LineEdit = $HostGame/LineEdit

func _ready() -> void:
	pass

func _on_join_game_pressed() -> void:
	gameButtons.hide()
	joinGame.show()

func _on_host_game_pressed() -> void:
	gameButtons.hide()
	hostGame.show()
	Multiplayer.host()

func _on_connect_pressed() -> void:
	Multiplayer.join(joinGameCode.text)


func _on_start_game_pressed() -> void:
	pass
