extends Entity

@onready var timer : Timer = $Timer
@export var hasGold : bool

func _ready() -> void:
	hasGold = false

func _process(delta: float) -> void:
	if timer.is_stopped():
		move()

func collect_gold(duration : float):
	work(duration)
	change_direction()
	hasGold = true
	print(hasGold)

func deposit_gold(duration : float):
	print(hasGold)
	if !hasGold:
		return
	
	work(duration)
	change_direction()
	hasGold = false

func change_direction():
	direction *= (-1)

func work(duration : float):
	timer.wait_time = duration
	timer.start()
