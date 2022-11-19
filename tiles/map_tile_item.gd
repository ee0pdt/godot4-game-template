extends Node3D
class_name MapTileItem

@tool


@export var CELL_SIZE: float = 1.0 # or whatever


func _process(_delta: float) -> void:
	position = position.snapped(Vector3.ONE * CELL_SIZE)
