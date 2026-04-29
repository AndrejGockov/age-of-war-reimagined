class_name Castle
extends Faction

func _init() -> void:
	super(
		"Castle",
		Variables.CASTLE_HP,
		["res://Entities/Factions/Castle/Spearman/spearman.tscn"]
	)

func _ready() -> void:
	pass
