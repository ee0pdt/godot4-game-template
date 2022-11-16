extends MapTileItem
@tool


@export_range(1, 3) var tile_size: int = 1:
	set(tile_size_in):
		tile_size = tile_size_in
		var radius = float(tile_size_in) / 2
		
		var mesh_node: MeshInstance3D = $MeshInstance3D
		var mesh: BoxMesh = mesh_node.get_mesh()
		mesh.size.x = tile_size
		mesh.size.z = tile_size
		mesh.size.y = 1
		
		print(global_position)
		
		mesh_node.global_position = Vector3(global_position.x + radius, global_position.y, global_position.z + radius)
