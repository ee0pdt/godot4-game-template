extends Node3D
class_name MapTileItem

@tool


@export_range(1, 3) var CELL_SIZE: int = 1 # or whatever


func _process(_delta: float) -> void:
	position = position.snapped(Vector3.ONE * CELL_SIZE)
