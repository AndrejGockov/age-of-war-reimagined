extends Camera2D

@export var pan_speed: float = 3000.0
@export var edge_margin_ratio: float = 0.15 # 15% of the screen
@export var left_marker: Marker2D
@export var right_marker: Marker2D
var left_limit: float
var right_limit: float

var mouse_x: float
var screen_width: float
var edge_margin: float

func _ready() -> void:
	_update_screen_size()
	get_viewport().size_changed.connect(_update_screen_size)
	if left_marker:
		left_limit = left_marker.global_position.x
	if right_marker:
		right_limit = right_marker.global_position.x
	# print("left_limit: ", left_limit, " right_limit: ", right_limit)

func _process(delta: float) -> void:
	mouse_x = get_viewport().get_mouse_position().x / get_viewport().get_final_transform().get_scale().x
	
	if mouse_x < edge_margin:
		var strength = 1.0 - (mouse_x / edge_margin)
		global_position.x -= pan_speed * strength * delta
	elif mouse_x > screen_width - edge_margin:
		var strength = (mouse_x - (screen_width - edge_margin)) / edge_margin
		global_position.x += pan_speed * strength * delta
	global_position.x = clamp(global_position.x, left_limit, right_limit)
	
func _update_screen_size() -> void:
	screen_width = get_viewport().get_window().size.x
	edge_margin = screen_width * edge_margin_ratio
	
