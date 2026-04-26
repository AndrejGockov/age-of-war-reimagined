extends Node

signal changeLevel

# Emits a signal to main.gd to change the level
func changeLevelTo(path : String) -> void:
	changeLevel.emit(path)
