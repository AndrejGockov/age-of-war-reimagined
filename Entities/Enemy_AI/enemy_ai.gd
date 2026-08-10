extends Node2D

# Time between units
@onready var unitBuffer : Timer = $UnitBuffer
# Time between waves
@onready var waveTimer : Timer = $WaveTimer

@export var units : Array[PackedScene]
@export var unitNode : Node2D
@export var spawnPoint : Base
@export var direction : int = -1

func _ready() -> void:
	# Starting values
	unitBuffer.wait_time = 3.0
	waveTimer.wait_time = 10.0
	
	units = [
			load("res://Entities/Factions/Castle/Spearman/spearman.tscn"),
			load("res://Entities/Factions/Castle/Musketeer/musketeer.tscn"),
			load("res://Entities/Factions/Castle/Knight/knight.tscn"),
			load("res://Entities/Factions/Castle/Priest/priest.tscn"),
			load("res://Entities/Factions/Castle/Cavalry/cavalry.tscn")
		]
	#await get_tree().process_frame
	var unit : Entity = units[0].instantiate()
	unit.global_position = spawnPoint.spawnPoint.global_position
	unit.set_direction(direction)
	unitNode.add_child(unit, true)

func _process(delta: float) -> void:
	pass
