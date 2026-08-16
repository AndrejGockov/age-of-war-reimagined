extends Node2D

# Time between units
@onready var unitBuffer : Timer = $UnitBuffer
# Time between waves
@onready var waveTimer : Timer = $WaveTimer

@export var unitNode : Node2D
@export var base : Base
@export var spawnpoint : Vector2
@export var direction : int = -1

# Units
var Spearman : PackedScene = load("res://Entities/Factions/Castle/Spearman/spearman.tscn")
var Musketeer : PackedScene = load("res://Entities/Factions/Castle/Musketeer/musketeer.tscn")
var Knight : PackedScene = load("res://Entities/Factions/Castle/Knight/knight.tscn")
var Priest : PackedScene = load("res://Entities/Factions/Castle/Priest/priest.tscn")
var Cavalry : PackedScene = load("res://Entities/Factions/Castle/Cavalry/cavalry.tscn")

# Waves
@export var waves : Array[Wave] = []

@export var currentWaveIndex : int = 0
@export var currentWave : Wave

func _ready() -> void:
	# Starting values
	unitBuffer.wait_time = 5.0
	waveTimer.wait_time = 20.0
	
	# Set unit spawnpoint
	spawnpoint = base.spawnPoint.global_position
	
	waves.append(
		Wave.new(
			[
				Spearman,
				Spearman,
				Spearman,
				Spearman,
			]
		)
	)
	
	waves.append(
		Wave.new(
			[
				Spearman,
				Spearman,
				Spearman,
				Musketeer,
				Musketeer,
				Musketeer,
				Musketeer,
			]
			)
		)
	
	waves.append(
		Wave.new(
			[
				Spearman,
				Knight,
				Spearman,
				Knight,
				Spearman,
				Knight,
				Musketeer,
				Musketeer,
			]
			)
		)
	
	waves.append(
		Wave.new(
			[
				Spearman,
				Knight,
				Spearman,
				Knight,
				Spearman,
				Knight,
				Musketeer,
				Musketeer,
			]
			)
		)
	
	waves.append(
		Wave.new(
			[
				Knight,
				Knight,
				Knight,
				Priest,
				Musketeer,
				Musketeer,
			]
			)
		)
	
	waves.append(
		Wave.new(
			[
				Knight,
				Knight,
				Knight,
				Musketeer,
				Musketeer,
			]
			)
		)
	
	waves.append(
		Wave.new(
			[
				Cavalry,
				Cavalry,
				Priest,
				Musketeer,
				Musketeer
			]
			)
		)
	
	
	currentWave = waves[0]
	spawn_wave()

func spawn_wave() -> void:
	waveTimer.start()
	await waveTimer.timeout
	
	for currentUnit : PackedScene in currentWave.wave:
		var unit : Entity = currentUnit.instantiate()
		unit.global_position = spawnpoint
		unit.set_direction(direction)
		unitNode.add_child(unit, true)
		unit.animated_sprite.flip_h = true
		unitBuffer.start()
		await unitBuffer.timeout
	
	# Decreases time between how long units spawn in next wave
	if unitBuffer.wait_time <=  1.5:
		unitBuffer.wait_time -= 0.5
	
	# Decreases time between waves
	if waveTimer.wait_time <=  5.0:
		waveTimer.wait_time -= 0.25
	
	# Loops through waves
	if currentWaveIndex < 1:
		currentWaveIndex += 1
	else:
		currentWaveIndex = 0
	
	currentWave = waves[currentWaveIndex]
	spawn_wave()
