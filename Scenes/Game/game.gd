extends Node2D

@onready var menu : Control = $InGameMenu

@onready var playerOneBase : Base = $Player_1_Base
@onready var playerTwoBase : Base = $Player_2_Base

var units : Array[Entity]

func _ready() -> void:
	menu.get_node("PlayerName").text = Global.playerName
	setBases.rpc()
	
	instantiateUnits()
	await get_tree().process_frame
	setTroopButtons()

# Creates an instance of every unit in the faction
func instantiateUnits() -> void:
	var unitCount : int = Global.faction.units.size()
	units.resize(unitCount)
	
	for i : int in unitCount:
		units[i] = Global.faction.units[i].instantiate()

func _process(delta: float) -> void:
	pass

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
		buttons[i].pressed.connect(spawnUnit.rpc.bind(i))

@rpc("any_peer", "call_local", "reliable")
func spawnUnit(index : int) -> void:
	var unit : Entity = units[index]
	unit.set_direction(Global.globalDirection)
	
	if Multiplayer.getSenderID() == 1:
		unit.global_position = playerOneBase.spawnPoint.global_position
		$Player_1_Units.add_child(unit.duplicate())
		return
	unit.global_position = playerTwoBase.spawnPoint.global_position
	$Player_2_Units.add_child(unit.duplicate())
