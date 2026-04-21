extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worker"):
		print("Collecting gold")
		body.collect_gold(3.0)
