extends Unit

func _init() -> void:
	pass

#func _ready() -> void:
	#super._ready()
	#health_bar.setup(maxHitpoints, hitpoints)
	#health_changed.connect(_on_health_changed)

func _ready() -> void:
	hitbox.target_position.x = abs(hitbox.target_position.x) * direction
	health_changed.connect(_on_health_changed)
	
	if multiplayer.is_server():
		health_bar.setup(maxHitpoints, hitpoints)
		health_changed.connect(_on_health_changed)
	else:
		health_changed.connect(_on_first_sync, CONNECT_ONE_SHOT)
		health_changed.connect(_on_health_changed)

func _on_first_sync(new_health: int) -> void:
	health_bar.setup(maxHitpoints, new_health)

func _on_health_changed(new_health: int) -> void:
	health_bar.set_hp(new_health)

func _process(delta: float) -> void:
	# Only host processes this
	if !multiplayer.is_server():
		return
	
	unit_algorithm()
	#update_healthbar()

#func _on_health_changed(new_health: int) -> void:
	#health_bar.set_hp(new_health)

func heal(amount: int) -> void:
	hitpoints = min(hitpoints + amount, maxHitpoints)
