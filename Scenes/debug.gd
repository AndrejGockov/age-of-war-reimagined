extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var base = $Base
	var worker
	
	worker = load(
		"res://Entities/DebugEntities/Worker/dummy_worker.tscn").instantiate()
	get_parent().add_child(worker)
	print(base.spawnPoint.global_position)
	
	var pos = base.spawnPoint.global_position
	#pos.y += 20
	#pos.y = pos.y*0.25 + pos.y/2
	#print(pos)

	worker.global_position = pos
