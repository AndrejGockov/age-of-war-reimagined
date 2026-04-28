@abstract class_name Faction
extends Node

@export var factionName : String
@export var base : String
@export var units : Array[String]

func _init(factionName : String, 
			base : String, units : Array[String]) -> void:
	self.factionName = factionName
	self.base = base
	self.units = units

func _ready() -> void:
	units.resize(5)
