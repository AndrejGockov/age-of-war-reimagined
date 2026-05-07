# How to create factions

## 1. Go to Entities folder

1.1 Create a folder with the factions name


## 2. Faction Script

2.1 Right-click the folder > Create New > Script > -faction_name-.gd

2.2 Add the following code inside the new script

```
class_name FACTION
extends Faction

func _init() -> void:
	super(
		"FACTION", 
		Variables.FACTION_HP,
		[
			load("WORKER"),
			load("UNIT"),
			load("UNIT")
			...
		]
	)

func _ready() -> void:
	pass

```
<br>
This inherits from the Faction class that has the following variables:

```
@export var factionName : String - the faction's name
@export var baseHP : int - the base's hitpoints
@export var units : Array[PackedScene] - an array of all the units for that faction 
```


NOTE: Use the other faction scripts as reference
