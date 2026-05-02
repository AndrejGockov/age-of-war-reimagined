extends Unit

func _init() -> void:
	pass

func _process(delta: float) -> void:
	# Only host processes this
	if !is_multiplayer_authority():
		return
	
	meelee_algorithm()
