extends Unit

@export var healing_cooldown : Timer
@export var healing_hitbox : Area2D
@export var heal_amount : int = 30
@onready var healing_orb: AnimatedSprite2D = $HealingOrb
func _init() -> void:
	pass
			
func _ready() -> void:
	super._ready()
	health_bar.setup(maxHitpoints, hitpoints)
	healing_cooldown.timeout.connect(_on_heal_timeout)
	healing_cooldown.start()

func _process(delta: float) -> void:
	# Only host processes this
	if !is_multiplayer_authority():
		return
	
	meelee_algorithm()
	update_healthbar()
	
func update_healthbar() -> void:
	health_bar.set_hp(hitpoints)
	
func meelee_algorithm() -> void:
	# Remove dead unit
	if hitpoints <= 0:
		queue_free()
		return
	
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

func _on_heal_timeout() -> void:
	if !is_multiplayer_authority():
		return
		
	for body in healing_hitbox.get_overlapping_bodies():
		print("units in range = ", healing_hitbox.get_overlapping_bodies().size())
		
		if !is_instance_valid(body) or body == self or body is Base:
			continue
		
		print("direction check: ", body.direction, " == ", direction)
		
		if body.direction == direction and body.has_method("heal"):
			print("healing: ", body, " for ", heal_amount)
			body.heal(heal_amount)
			healing_orb.play()
			print("body hp: ", body.hitpoints)
		else: 
			print("has no method heal or has different direction")
		
	healing_cooldown.start()
