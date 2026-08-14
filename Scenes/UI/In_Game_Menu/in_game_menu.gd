extends Control

@onready var goldLabel : Label = $MarginContainer/HBoxContainer/Gold
@onready var pause_menu = $PauseMenu
@onready var game_over = $GameOver
@onready var result_label = $GameOver/ResultLabel

func _ready() -> void:
	Variables.updateGold.connect(updateGoldUI)
	pause_menu.hide()
	game_over.hide()

func updateGoldUI() -> void:
	goldLabel.text = str(Variables.gold)

func _on_menu_pressed() -> void:
	# $PauseMenu.visible = true
	pause_menu.show()
	get_tree().paused = true

func _on_continue_pressed() -> void:
	# $PauseMenu.visible = false
	pause_menu.hide()
	get_tree().paused = false

func _on_close_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			_on_continue_pressed()
		else:
			_on_menu_pressed()
func show_game_over(losing_player: int) -> void:
	pause_menu.hide()
	game_over.show()
	if multiplayer.get_unique_id() == losing_player:
		result_label.text = "YOU LOSE!"
	else:
		result_label.text = "YOU WIN!"
	get_tree().paused = true
	
func _on_game_over_close_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
