extends MapTileItem
@tool


@export_range(1, 3) var tile_size: int = 1:
	set(tile_size_in):
		tile_size = tile_size_in
		CELL_SIZE = tile_size_in


func _process(delta: float) -> void:
	super._process(delta)
