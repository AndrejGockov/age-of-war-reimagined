extends Node2D

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	Global.changeLevelTo("res://Scenes/Play/play.tscn")

func _on_options_pressed() -> void:
	Global.changeLevelTo("res://Scenes/Options/options.tscn")

func _on_credits_pressed() -> void:
	Global.changeLevelTo("res://Scenes/Credits/credits.tscn")
