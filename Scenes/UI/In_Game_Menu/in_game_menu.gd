extends Control

@onready var goldLabel : Label = $MarginContainer/HBoxContainer/Gold

func _ready() -> void:
	Variables.updateGold.connect(updateGoldUI)

func updateGoldUI() -> void:
	goldLabel.text = str(Variables.gold)
