# How to create units

## 1. Go to Entities folder

1.1 Find the folder with the faction the unit belongs to

1.2 Create folder with the unit's name


## 2. Create a new scene

2.1 Go to Scene > New Scene

2.2 Search for the CharacterBody2D node and click create


## 3. CharacterBody2D 

3.1 Name the CharacterBody2D after the unit

3.2 Click CharacterBody2D > Go to Inspector > Script > New Script

3.3 Delete everything in the new script and replace it with this:


```
extends Unit

func _init() -> void:
	pass

func _process(delta: float) -> void:
	# Whichever algorithm based on the units type (eg. meelee, ranged, aoe)
	pass
```

NOTE: You will have to write more in _process for units with special abilities


## 4. Child Nodes

4.1 Go to folder Shared > Unit > Select all the files and add them as child nodes to the CharacterBody2D

unit_timer - Cooldown timer between each attack

unit_raycast - How far the unit reaches for it's attack

unit_collision_shape_2d - The hurtbox e.g  what needs to be collide with the raycast for a unit to take damage

3.4 Select CharacterBody2D > Go to Inspector

&emsp;3.4.1 Find the Hitbox > Set it to be unit_raycast

&emsp;3.4.2 Find the Hitbox > Set it to be unit_timer

## 5. Customize

From here you can customize each unit based on what you want it's behavior to behaviour to be.

### Cheatsheet for customization

You can change the units attack range by selecting it's unit_raycast, going Target Position and x axis bigger

You can change the attack cooldown by selecting it's unit_timer and changing Wait Time
