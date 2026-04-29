@abstract class_name Faction
extends Node

@export var factionName : String
@export var baseHP : int
@export var units : Array[String]

func _init(
	factionName : String, 
	baseHP : int, 
	units : Array[String]) -> void:
	self.factionName = factionName
	self.baseHP = baseHP
	self.units = units

func _ready() -> void:
	units.resize(5)
