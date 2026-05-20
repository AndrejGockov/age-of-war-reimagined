extends Control

@onready var bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

func _ready() -> void:
	print(get_children()) 
# setup func
func setup(max_hp: int, curr_hp: int) -> void:
	bar.max_value = max_hp
	set_hp(curr_hp)
	
# set hitpoints
func set_hp(curr_hp: int) -> void:
	bar.value = curr_hp
	label.text = str(curr_hp)+"/"+str(int(bar.max_value))
