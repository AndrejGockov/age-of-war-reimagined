class_name FactionSelect
extends PanelContainer

@onready var factionList : OptionButton = %FactionList

func _ready() -> void:
	for faction : String in Global.factionList:
		factionList.add_item(faction)

func _process(delta: float) -> void:
	pass


#@rpc("any_peer", "call_local", "reliable")
