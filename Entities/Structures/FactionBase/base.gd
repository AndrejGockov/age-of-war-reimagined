extends Area2D

@export var hitpoints : int = 5000
@export var spawnPoint : CollisionShape2D

func _ready() -> void:
	spawnPoint = $spawn_point

#@warning_ignore("unused_parameter")
#func _process(delta: float) -> void:
	#pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worker"):
		print("Depositing gold")
		body.deposit_gold(1.0)
