@abstract class_name Unit
extends Entity

# Default values
@export var attackDamage : int = 10
@export var attackSpeed : float = 1.0

@export var hitbox : RayCast2D
@export var attackCoolDown : Timer

# healthbar
@onready var health_bar = $HealthBar

func _init(price : int, speed : float, direction : float, 
		hitpoints : int, attackSpeed : float) -> void:
	#maxHitpoints : int,
	self.price = price
	self.speed = speed
	self.direction = direction
	self.hitpoints = hitpoints
	#self.maxHitpoints = maxHitpoints
	self.attackDamage = attackDamage
	self.attackSpeed = attackSpeed

func _ready() -> void:
	# Changes which direction it's facing
	hitbox.target_position.x = abs(hitbox.target_position.x) * direction
	# hitbox.target_position.x *= direction

func _process(delta: float) -> void:
	pass

func attack(collidedObject) -> void:
	if !attackCoolDown.is_stopped():
		return
		
	collidedObject.hitpoints -= attackDamage
	# Start cooldown after attack
	attackCoolDown.start()

func meelee_algorithm() -> void:
	# Remove dead unit
	if hitpoints <= 0:
		queue_free()
	
	# Attack enemy when in range
	if hitbox.is_colliding():
		var collidedObject = hitbox.get_collider()
		
		if !is_instance_valid(collidedObject):
			return
		
		if collidedObject is Base || collidedObject.direction != direction:
			attack(collidedObject)
			return
		
		# if we want units to not stack ontop of eachother	
		return
			
	move()

# TODO
func ranged_algorithm() -> void:
	pass

func aoe_algorithm() -> void:
	pass
