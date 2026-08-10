class_name Wave
extends Resource

@export var wave : Array[PackedScene] = []

func _init(wave: Array[PackedScene] = []):
	self.wave = wave
