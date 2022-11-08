extends Node3D
class_name MapTile

@tool


@export_range(1, 3) var CELL_SIZE: int = 1 # or whatever


func _process(delta: float) -> void:
	position = position.snapped(Vector3.ONE * CELL_SIZE)


func position_snapped(position: Vector3):
	return position.snapped(Vector3.ONE * CELL_SIZE)
