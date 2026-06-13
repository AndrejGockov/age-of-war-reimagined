extends Unit

func _init() -> void:
	pass

func _ready() -> void:
	super._ready()
	health_bar.setup(maxHitpoints, hitpoints)

func _process(delta: float) -> void:
	# Only host processes this
	if !is_multiplayer_authority():
		return
	
	print(multiplayer.get_unique_id(), " ",  hitpoints)
	
	unit_algorithm()
	update_healthbar()

func update_healthbar() -> void:
	health_bar.set_hp(hitpoints)

func heal(amount: int) -> void:
	hitpoints = min(hitpoints + amount, maxHitpoints)
