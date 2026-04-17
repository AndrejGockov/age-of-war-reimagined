extends Unit

func _init() -> void:
	pass

func _process(delta: float) -> void:
	# Write whichever algorithm based on the units type (eg. meelee, ranged, aoe)
	meelee_algorithm()
