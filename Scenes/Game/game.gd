extends Node2D

@onready var menu : Control = $InGameMenu

@onready var playerOneBase : Base = $Player_1_Base
@onready var playerTwoBase : Base = $Player_2_Base

func _ready() -> void:
	setBases.rpc()
	
	menu.get_node("PlayerName").text = Global.playerName
	
	# TODO
	# Adding troop buttons to menu
	#for unit in Global.faction:
		#menu.create_node

func _process(delta: float) -> void:
	pass

@rpc("any_peer", "call_local", "reliable")
func setBases() -> void:
	playerOneBase.hitpoints = Global.faction.baseHP
	playerTwoBase.hitpoints = Global.enemyFaction.baseHP
