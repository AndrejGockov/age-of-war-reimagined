extends Unit

@export var healing_cooldown : Timer
@export var healing_hitbox : Area2D

func _init() -> void:
	pass
			

func _process(delta: float) -> void:
	# Only host processes this
	if !is_multiplayer_authority():
		return
	
	meelee_algorithm()

	
	if !healing_cooldown.is_stopped():
		return
		
	var all_units = healing_hitbox.get_overlapping_bodies()
	var bodies = []
	for u in all_units:
		if not (u is Base):
			bodies.append(u)
	for body in bodies:
			body.hitpoints += 30

	healing_cooldown.start()
