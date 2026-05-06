extends Unit

func _init() -> void:
	pass

func _process(delta: float) -> void:
	# Whichever algorithm based on the units type (eg. meelee, ranged, aoe)
	if !is_multiplayer_authority():
		return
		
	meelee_algorithm()
