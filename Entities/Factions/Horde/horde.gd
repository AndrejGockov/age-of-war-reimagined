class_name Horde
extends Faction

func _init() -> void:
	super(
		"Horde", 
		Variables.HORDE_HP,
		[preload("res://Entities/Factions/Castle/Spearman/spearman.tscn")]
	)

func _ready() -> void:
	pass
