class_name Castle
extends Faction

func _init() -> void:
	super(
		"Castle",
		Variables.CASTLE_HP,
		[
			# REPLACE DUMMY WORKER AFTER TESTING
			load("res://Entities/Debug_Entities/Worker/dummy_worker.tscn"),
			load("res://Entities/Factions/Castle/Spearman/spearman.tscn"),
			load("res://Entities/Factions/Castle/Musketeer/musketeer.tscn")
		]
	)

func _ready() -> void:
	pass
