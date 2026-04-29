extends CharacterBody2D

class_name Entity

# Default values
@export var unitName : String = "Worker"
@export var price : int = 100
@export var speed : float = 500
@export var direction : float = 1.0

func set_direction(direction : float) -> void:
	self.direction = direction

func move() -> void:
	velocity = Vector2(speed * direction, 0)
	move_and_slide()
