extends Unit

@export var healing_cooldown : Timer
@export var healing_hitbox : Area2D

func _init() -> void:
	pass
			
func _ready() -> void:
	super._ready()
	healing_cooldown.timeout.connect(_on_heal_timeout)
	healing_cooldown.start()

func _on_heal_timeout() -> void:
	print("func start")
		
	var units = healing_hitbox.get_overlapping_bodies()
	print("units in range: ", units.size())
	for body in units:
		print("body: ", body)
		if !is_instance_valid(body) or body == self or body is Base:
			continue
		print("direction check: ", body.direction, " == ", direction)
		if body.direction == direction and body.has_method("heal"):
			print("healing: ", body, " for 30")
			body.heal(30)
		else: print("has no method heal or has different direction")
	

func _process(delta: float) -> void:
	# Only host processes this
	if !is_multiplayer_authority():
		return
	meelee_algorithm()
	
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
	
