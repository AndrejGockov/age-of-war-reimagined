extends Node2D

@export var factionName : String
@export var base : Area2D
@export var units : Array[Unit]

func _ready() -> void:
	units.resize(5)
	

func _process(delta: float) -> void:
	pass
