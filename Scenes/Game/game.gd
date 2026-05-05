extends Node2D

@onready var menu : Control = $InGameMenu

@onready var playerOneBase : Base = $Player_1_Base
@onready var playerOneUnits : Node2D = $Player_1_Units
@onready var playerOneSpawner : MultiplayerSpawner = $Player_1_MultiplayerSpawner

@onready var playerTwoBase : Base = $Player_2_Base
@onready var playerTwoUnits : Node2D = $Player_2_Units
@onready var playerTwoSpawner : MultiplayerSpawner = $Player_2_MultiplayerSpawner

@export var matchIsOver : bool = false

@onready var gold : int

@onready var winner : LineEdit = $winnertext

func _ready() -> void:
	# Sets player names
	menu.get_node("PlayerName").text = Global.playerName
	
	setBases.rpc()
	
	if multiplayer.get_unique_id() == 1:
		addUnitsToSynchronizer(playerOneSpawner, Global.faction.units)
		addUnitsToSynchronizer(playerTwoSpawner, Global.enemyFaction.units)
	else:
		addUnitsToSynchronizer(playerTwoSpawner, Global.faction.units)
		addUnitsToSynchronizer(playerOneSpawner, Global.enemyFaction.units)
	
	await get_tree().process_frame
	setTroopButtons()

func _process(delta: float) -> void:
	if !multiplayer.is_server():
		return
	
	if matchIsOver:
		return
	
	if playerOneBase.hitpoints <= 0:
		endMatch.rpc(Global.enemyPlayerName)
	
	if playerTwoBase.hitpoints <= 0:
		endMatch.rpc(Global.playerName)

@rpc("any_peer", "call_local", "reliable")
func endMatch(winnerName : String):
	matchIsOver = true
	
	winner.text = winnerName + " WINS"
	
	disableTroopButtons()

# Adds units to corresponding MultiplayerSpawner
func addUnitsToSynchronizer(spawner : MultiplayerSpawner, units : Array[PackedScene]) -> void:
	for scene in units:
		spawner.add_spawnable_scene(scene.resource_path)

@rpc("any_peer", "call_local", "reliable")
func setBases() -> void:
	if multiplayer.get_remote_sender_id() == 1:
		playerOneBase.hitpoints = Global.faction.baseHP
	else:
		playerTwoBase.hitpoints = Global.enemyFaction.baseHP

# Sets the buttons to spawn the appropriate troops
func setTroopButtons() -> void:
	var buttons = get_tree().get_nodes_in_group("Troop_Buttons")
	var totalUnits : int = Global.faction.units.size()
	
	for i : int in totalUnits:
		buttons[i].text = Global.faction.units[i].instantiate().unitName
		buttons[i].pressed.connect(spawnUnit.bind(i))

func disableTroopButtons() -> void:
	var buttons = get_tree().get_nodes_in_group("Troop_Buttons")
	var totalUnits : int = Global.faction.units.size()
	
	for i : int in totalUnits:
		buttons[i].pressed.disconnect(spawnUnit.bind(i))

func spawnUnit(index : int) -> void:
	spawnForAllPlayers.rpc(
		index, 
		multiplayer.get_unique_id(), 
		Global.globalDirection
	)

@rpc("any_peer", "call_local", "reliable")
func spawnForAllPlayers(index : int, spawnerID : int, direction : int) -> void:
	if !multiplayer.is_server():
		return
	
	var unit : Entity
	
	# Determines who spawned the unit
	if multiplayer.get_unique_id() == spawnerID:
		unit = Global.faction.units[index].instantiate()
	else:
		unit = Global.enemyFaction.units[index].instantiate()
	
	unit.set_direction(direction)
	unit.spawnOwnerID = spawnerID
	
	# Determines where to spawn the unit
	if direction == 1:
		unit.global_position = playerOneBase.spawnPoint.global_position
		playerOneUnits.add_child(unit, true)
		return
	
	unit.global_position = playerTwoBase.spawnPoint.global_position
	playerTwoUnits.add_child(unit, true)
