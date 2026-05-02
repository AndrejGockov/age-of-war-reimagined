@abstract class_name Unit
extends Entity

# Default values
@export var hitpoints : int = 100
@export var attackDamage : int = 10
@export var attackSpeed : float = 1.0

@export var hitbox : RayCast2D
@export var attackCoolDown : Timer

func _init(price : int, speed : float, direction : float, 
		hitpoints : int, attackDamage : int, attackSpeed : float) -> void:
	self.price = price
	self.speed = speed
	self.direction = direction
	self.hitpoints = hitpoints
	self.attackDamage = hitpoints
	self.attackSpeed = attackSpeed

func _ready() -> void:
	# Changes which direction it's facing
	hitbox.target_position.x *= direction

func _process(delta: float) -> void:
	pass

func attack() -> void:
	if !attackCoolDown.is_stopped():
		return
	
	var enemy : Entity = hitbox.get_collider()
	enemy.hitpoints -= attackDamage
	
	# Start cooldown after attack
	attackCoolDown.start()

func meelee_algorithm() -> void:
	# Remove dead unit
	if hitpoints <= 0:
		queue_free()
	
	# Attack enemy when in range
	if hitbox.is_colliding():
		attack()
		return
	
	move()

# TODO
func ranged_algorithm() -> void:
	pass

func aoe_algorithm() -> void:
	pass
