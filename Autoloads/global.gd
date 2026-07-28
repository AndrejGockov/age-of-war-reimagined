extends Node

# Emits a signal to main.gd to change the scene
signal changeLevel

func changeLevelTo(path : String) -> void:
	changeLevel.emit(path)

# Setting faction before game
enum factions { Castle, Horde, Artificer, Undead }
var registrerFaction = {
	factions.Castle : Castle,
	factions.Horde: Horde,
	factions.Artificer: Artificer,
	factions.Undead: Undead
}

func setFaction(index : int) -> Faction:
	return registrerFaction[index].new()

# Variables during match
@export var playerName : String = "Player"
@export var faction : Faction = setFaction(0)
@export var globalDirection : int = 1

@export var enemyPlayerName : String = "Enemy"
@export var enemyFaction : Faction = setFaction(0)

func setPlayerData(
	playerName : String, 
	faction : Faction,
	enemyPlayerName : String,
	enemyFaction : Faction,
	globalDirection : int) -> void:
	self.playerName = playerName
	self.faction = faction
	self.enemyPlayerName = enemyPlayerName
	self.enemyFaction = enemyFaction
	self.globalDirection = globalDirection
