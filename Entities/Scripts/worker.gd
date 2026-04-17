extends Entity

@onready var timer : Timer = $Timer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if timer.is_stopped():
		move()

func collect_gold(duration : float):
	work(duration)
	change_direction()

func deposit_gold(duration : float):
	work(duration)
	change_direction()

func change_direction():
	direction *= (-1)

func work(duration : float):
	timer.wait_time = duration
	timer.start()
