extends Camera2D

@export var pan_speed: float = 1000.0
@export var edge_margin: float = 150.0
@export var left_limit: float = -2000.0
@export var right_limit: float = 2000.0
# camera lol
func _process(delta: float) -> void:
	var mouse_x = get_viewport().get_mouse_position().x
	var screen_width = get_viewport().get_visible_rect().size.x
	
	if mouse_x < edge_margin:
		var str = 1.0 - (mouse_x / edge_margin)
		global_position.x -= pan_speed * str * delta
	elif mouse_x > screen_width - edge_margin:
		var str = (mouse_x - (screen_width - edge_margin)) / edge_margin
		global_position.x += pan_speed * str * delta
	global_position.x = clamp(global_position.x, left_limit, right_limit)

func _ready() -> void:
	pass 
