extends Node2D

@onready var menu : Control = $InGameMenu

@onready var playerOneBase : Base = $Player_1_Base
@onready var playerTwoBase : Base = $Player_2_Base

@onready var playerOneSpawner : MultiplayerSpawner = $Player_1_MultiplayerSpawner
@onready var playerTwoSpawner : MultiplayerSpawner = $Player_2_MultiplayerSpawner

func _ready() -> void:
	menu.get_node("PlayerName").text = Global.playerName
	setBases.rpc()
	
	instantiateUnits()
	await get_tree().process_frame
	setTroopButtons()

# Creates an instance of every unit in the faction
func instantiateUnits() -> void:
	# Your units
	var unitCount : int = Global.faction.units.size()
	#units.resize(unitCount)
	
	for i : int in unitCount:
		#units[i] = Global.faction.units[i]#.instantiate()
		playerOneSpawner.add_spawnable_scene(Global.faction.units[i].resource_path)
		playerTwoSpawner.add_spawnable_scene(Global.faction.units[i].resource_path)
	
	
	# Enemy units
	var enemyUnitCount : int = Global.enemyFaction.units.size()
	#enemyUnits.resize(enemyUnitCount)
	
	for i : int in enemyUnitCount:
		#enemyUnits[i] = Global.enemyFaction.units[i]#.instantiate()
		playerOneSpawner.add_spawnable_scene(Global.enemyFaction.units[i].resource_path)
		playerTwoSpawner.add_spawnable_scene(Global.enemyFaction.units[i].resource_path)

@rpc("any_peer", "call_local", "reliable")
func setBases() -> void:
	if Multiplayer.getSenderID() == 1:
		playerOneBase.hitpoints = Global.faction.baseHP
		return
	
	playerTwoBase.hitpoints = Global.enemyFaction.baseHP

#playerOneBase.hitpoints = Global.faction.baseHP
#playerTwoBase.hitpoints = Global.enemyFaction.baseHP

func setTroopButtons() -> void:
	var buttons = get_tree().get_nodes_in_group("Troop_Buttons")
	var totalUnits : int = Global.faction.units.size()
	
	for i : int in totalUnits:
		buttons[i].text = Global.faction.units[i].instantiate().unitName
		buttons[i].pressed.connect(spawnUnit.bind(i))


# Global position is only tracked for one player, aka p1 doesnt know p2 dir
func spawnUnit(index : int) -> void:
	var direction = Global.globalDirection
	var spawnPoint : Vector2 = playerOneBase.spawnPoint.global_position
	
	if direction != 1:
		spawnPoint = playerTwoBase.spawnPoint.global_position
	
	spawnForAllPlayers.rpc(index, multiplayer.get_unique_id(), direction)

@rpc("any_peer", "call_local", "reliable")
func spawnForAllPlayers(index : int, spawnerID : int, direction : int) -> void:
	if !multiplayer.is_server():
		return
	
	var unit : Entity
	
	# Determines who spawned the unit
	if multiplayer.get_unique_id() == spawnerID:
		unit = Global.faction.units[index].instantiate()
		#unit.set_direction(direction)#Global.globalDirection)
	else:
		unit = Global.enemyFaction.units[index].instantiate()
		#unit.set_direction(direction)#Global.globalDirection * -1)
	
	unit.set_direction(direction)
	unit.spawnOwnerID = spawnerID
	
	# Determines where to spawn the unit
	if direction == 1:
		unit.global_position = playerOneBase.spawnPoint.global_position
		$Player_1_Units.add_child(unit, true)
		return
	
	unit.global_position = playerTwoBase.spawnPoint.global_position
	$Player_2_Units.add_child(unit, true)
