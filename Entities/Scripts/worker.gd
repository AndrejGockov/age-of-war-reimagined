extends Entity

@onready var timer : Timer = $Timer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if timer.is_stopped():
		move()

func collectGold(duration : float):
	work(duration)
	changeDirection()

func depositGold(duration : float):
	work(duration)
	changeDirection()

func changeDirection():
	direction *= (-1)

func work(duration : float):
	timer.wait_time = duration
	timer.start()
