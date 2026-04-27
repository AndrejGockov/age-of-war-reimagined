extends Node2D

@onready var level : Node = $Level

func _ready() -> void:
	# Set up signal for changing levels
	Global.changeLevel.connect(onChangeLevel)

func onChangeLevel(levelPath : String) -> void:
	# Changes scene for other peers
	if multiplayer.is_server():
		Multiplayer.changeSceneForClients.rpc(levelPath)
	#multiplayer.peer != null && 
	
	for childNode : Node in level.get_children():
		childNode.queue_free()
	
	var resource : Resource = load(levelPath)
	if resource:
		var newLevel : Node = resource.instantiate()
		level.add_child(newLevel)
