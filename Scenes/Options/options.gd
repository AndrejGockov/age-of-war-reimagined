extends Node2D

# Homescreen Button
func _on_back_pressed() -> void:
	Global.changeLevelTo("res://Scenes/HomeScreen/home_screen.tscn")
