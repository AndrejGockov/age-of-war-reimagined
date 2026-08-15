extends Control

@onready var bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

func _ready() -> void:
	pass
	#hitbox.target_position.x = abs(hitbox.target_position.x) * direction

# setup func
func setup(max_hp: int, curr_hp: int) -> void:
	bar.max_value = max_hp
	set_hp(curr_hp)

# set hitpoints and change color
func set_hp(curr_hp: int) -> void:
	if not is_inside_tree(): 
		await ready

	bar.value = curr_hp
	label.text = str(curr_hp) + "/" + str(int(bar.max_value))

	var hp_percent := float(curr_hp) / bar.max_value

	var stylebox := bar.get_theme_stylebox("fill").duplicate()

	if hp_percent <= 0.2:
		stylebox.bg_color = Color.RED
	elif hp_percent <= 0.5:
		stylebox.bg_color = Color.YELLOW
	else:
		stylebox.bg_color = Color.GREEN

	bar.add_theme_stylebox_override("fill", stylebox)
