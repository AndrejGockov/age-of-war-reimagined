extends Node2D

@onready var level : Node = $Level

func _ready() -> void:
	Global.changeLevel.connect(onChangeLevel)

func onChangeLevel(levelPath : String) -> void:
	# Deletes everything from the old scene
	for childNode : Node in level.get_children():
		childNode.queue_free()
	
	# Checks if the scene exists then loads it
	var resource : Resource = load(levelPath)
	
	if resource:
		var newLevel : Node = resource.instantiate()
		level.add_child(newLevel)
