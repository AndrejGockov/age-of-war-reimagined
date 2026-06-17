extends Node

# Depositing & collecting gold timers
var depositGold : float = 1.0
var collectGold : float = 3.0

# In game gold
signal updateGold(gold : int)

var startingGold : int = 100
var collectedGold : int = 100
var gold : int = startingGold:
	set(value):
		gold = value
		print(gold)
		updateGold.emit()

# Base hitpoints
var CASTLE_HP : int = 2000
var HORDE_HP : int = 2000
var ARTIFICER_HP : int = 4000
var UNDEAD_HP : int = 2500
