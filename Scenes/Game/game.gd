extends Node2D

func _ready() -> void:
	$TextEdit.text = Global.playerName + " " + str(Global.globalDirection)
	$TextEdit2.text = Global.faction.factionName
	
	pass

func _process(delta: float) -> void:
	pass
