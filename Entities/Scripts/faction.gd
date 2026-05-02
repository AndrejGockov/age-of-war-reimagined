@abstract class_name Faction
extends Node

@export var factionName : String
@export var baseHP : int
@export var units : Array[PackedScene]

func _init(
	factionName : String,
	baseHP : int, 
	units : Array[PackedScene]) -> void:
	self.factionName = factionName
	self.baseHP = baseHP
	self.units = units

func _ready() -> void:
	units.resize(5)
