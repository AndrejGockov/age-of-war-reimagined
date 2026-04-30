class_name Artificer
extends Faction

func _init() -> void:
	super(
		"Artificer", 
		Variables.ARTIFICER_HP,
		[
			load("res://Entities/Factions/Artificer/Robot_Dog/robot_dog.tscn")
		]
	)

func _ready() -> void:
	pass
