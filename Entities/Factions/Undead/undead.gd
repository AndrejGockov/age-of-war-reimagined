class_name Undead
extends Faction

func _init() -> void:
	super(
		"Undead",
		Variables.UNDEAD_HP,
		[preload("res://Entities/Factions/Castle/Spearman/spearman.tscn")]
	)

func _ready() -> void:
	pass
