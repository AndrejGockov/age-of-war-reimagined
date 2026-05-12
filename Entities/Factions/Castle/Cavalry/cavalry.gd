extends Unit

@export var bonus_damage : int = 50
@export var charge_timer : float = 1.0
@export var health_bar : ProgressBar
@export var health_label : Label

var normal_speed : float
var charge_speed : float
var charge_ready := false
var time_since_last_attack := 0.0

func _ready() -> void:
	super._ready()
	normal_speed = speed
	charge_speed = speed * 2.0
	health_bar.max_value = hitpoints
	health_bar.value = hitpoints
	health_label.text = str(hitpoints)+"/"+str(maxHitpoints)

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
	
	meelee_algorithm()
	
#func take_damage(amount: int) -> void:
	#hitpoints -= amount
	#if health_bar:
		#health_bar.value = hitpoints
	#if health_label:
		#health_label.text = str(hitpoints)+"/"+str(maxHitpoints)

func attack(collidedObject) -> void:
	#print("attacking: ", collidedObject)
	if charge_ready:
		charge_ready = false
		speed = normal_speed
		time_since_last_attack = 0.0
		
		if !attackCoolDown.is_stopped():
			return		
			
		collidedObject.hitpoints -= attackDamage + bonus_damage
		#if(collidedObject is Base):
			#collidedObject.hitpoints -= attackDamage + bonus_damage
		#else:
			#collidedObject.hitpoints.take_damage(attackDamage + bonus_damage)
		attackCoolDown.start()	
		
		
	if !attackCoolDown.is_stopped():
		return
	collidedObject.hitpoints -= attackDamage
	#if(collidedObject is Base):
		#collidedObject.hitpoints -= attackDamage
	#else:
		#collidedObject.hitpoints.take_damage(attackDamage)
	attackCoolDown.start()
	
func update_healthbar() -> void:	
	if !health_bar or !health_label:
		print("health_bar or health_label is null, returning")
		return
	
	health_bar.value = hitpoints
	health_label.text = str(hitpoints)+"/"+str(maxHitpoints)
	
func heal(amount: int) -> void:
	hitpoints = min(hitpoints + amount, maxHitpoints)
	update_healthbar()
	print(name, " healed to ", hitpoints)


	




		
		
		

	
