class_name Artificer
extends Faction

func _init() -> void:
	super(
		"Artificer", 
		Variables.ARTIFICER_HP,
		[load("res://Entities/Factions/Castle/Spearman/spearman.tscn")]
	)

func _ready() -> void:
	pass
