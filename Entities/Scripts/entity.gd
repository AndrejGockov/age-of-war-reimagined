class_name Entity
extends CharacterBody2D

# Default values
@export var unitName : String = "Worker"
@export var price : int = 100
@export var speed : float = 500
@export var direction : float = 1.0
signal health_changed(new_health: int)
@export var hitpoints : int = 100:
	set(value):
		hitpoints = value
		health_changed.emit(hitpoints)
@export var maxHitpoints : int = 100
@onready var animated_sprite = $AnimatedSprite2D
# Tracks who spawned the entity
@export var spawnOwnerID : int = 1 

func set_direction(direction : float) -> void:
	self.direction = direction

func move() -> void:
	if animated_sprite:
		animated_sprite.play("Walk")
	
	velocity = Vector2(speed * direction, 0)
	move_and_slide()
