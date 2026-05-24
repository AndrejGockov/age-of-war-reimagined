# Workers

All workers inherit from the Entity class and all use the worker.gd script.
The only thing that changes between the different workers is the animation.


## Worker AI

The workers AI uses a form of the observer design pattern, with the following loop:

1. The worker is spawned at the player's base and doesn't have any gold (this is so it doesn't start depositing gold it doesn't have)

```
func _ready() -> void:
	hasGold = false
```

2. The worker starts going to the gold mine
3. When the worker enters the Area2D for a goldmine, in gold_mine.gd _on_body_entered(body: Node2D) is triggered
4. That function calls collect_gold(duration : float) which does the following:
   1. Tells the worker to collect gold by calling: work(duration : float), which starts a timer and makes the unit wait in place for the duration.
   2. When the timer finishes, the unit does the following:
      - Changes it's direction: change_direction()
      - It now has gold deliver back: hasGold = true
      - It starts moving back to the base
      
      <br>
5. When the worker returns to the base it triggers _on_body_entered(body: Node2D) and the unit starts depositing the gold it's collected deposit_gold(duration : float)
6. deposit_gold(duration : float) checks if the worker has gold to deposit, if yes it does the opposite of collect_gold(duration : float):
   - Starts a timer for how long it'll take for the worker to deposit the gold
   - Sets: hasGold = false
   - Changes it's direction: change_direction()

   <br>
7. Repeat from step 2

### gold_mine.gd

```
func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Worker"):
        body.collect_gold(3.0)
```

### base.gd

```
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worker"):
		print("Depositing gold")
		body.deposit_gold(1.0)
```

### worker.gd

```
func _process(delta: float) -> void:
	if is_multiplayer_authority() && timer.is_stopped():
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
```