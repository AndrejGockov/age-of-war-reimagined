extends Node

# Emits a signal to main.gd to change the scene
signal changeLevel

func changeLevelTo(path : String) -> void:
	changeLevel.emit(path)

enum factions { Castle, Horde, Artificer, Undead }

func setFaction(index : int) -> Faction:
	var registry = {
		factions.Castle : Castle,
		factions.Horde: Horde,
		factions.Artificer: Artificer,
		factions.Undead: Undead
	}
	
	return registry[index].new()

# For tracking choices during game
@export var playerName : String
@export var faction : Faction
@export var globalDirection : int

func setPlayerData(playerName : String, 
faction : Faction, globalDirection : int) -> void:
	self.playerName = playerName
	self.faction = faction
	self.globalDirection = globalDirection
