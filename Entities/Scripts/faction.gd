class_name Faction
extends Node2D

@export var factionName : String
@export var base : String
@export var units : Array[Unit]

func _init(factionName : String, 
			base : String, units : Array[Unit]) -> void:
	self.factionName = factionName
	self.base = base
	self.units = units

func _ready() -> void:
	units.resize(1)

func _process(delta: float) -> void:
	pass
