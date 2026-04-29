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
@export var playerName : String
@export var faction : Faction
@export var globalDirection : int
@export var gold : int

@export var enemyPlayerName : String
@export var enemyFaction : Faction

func setPlayerData(playerName : String, 
faction : Faction, globalDirection : int) -> void:
	self.playerName = playerName
	self.faction = faction
	self.globalDirection = globalDirection
