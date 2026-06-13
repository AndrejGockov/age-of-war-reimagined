extends Unit

@export var bonus_damage : int = 50
@export var charge_timer : float = 1.0

var normal_speed : float
var charge_speed : float
var charge_ready := false
var time_since_last_attack := 0.0

func _ready() -> void:
	super._ready()
	normal_speed = speed
	charge_speed = speed * 2.0
	health_bar.setup(maxHitpoints, hitpoints)

func _init() -> void:
	pass

func _process(delta: float) -> void:
	# Whichever algorithm based on the units type (eg. meelee, ranged, aoe)
	if !is_multiplayer_authority():
		return	
	time_since_last_attack += delta
	update_healthbar()
	
	if time_since_last_attack >= charge_timer: 
		speed = charge_speed
		charge_ready = true
	
	unit_algorithm()

# attack logic for this unit
func attack(collidedObject) -> void:
	if charge_ready:
		charge_ready = false
		speed = normal_speed
		time_since_last_attack = 0.0
		
		if !attackCoolDown.is_stopped():
			return
			
		collidedObject.hitpoints -= attackDamage + bonus_damage
		attackCoolDown.start()
		
	
	if !attackCoolDown.is_stopped():
		return
	
	collidedObject.hitpoints -= attackDamage
	attackCoolDown.start()

func update_healthbar() -> void:
	health_bar.set_hp(hitpoints)
	
func heal(amount: int) -> void:
	hitpoints = min(hitpoints + amount, maxHitpoints)
	update_healthbar()
	print(name, " healed to ", hitpoints)
