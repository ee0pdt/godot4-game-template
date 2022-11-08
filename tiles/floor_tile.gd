extends MapTileItem
@tool


@export_range(1, 3) var tile_size: int = 1:
	set(tile_size_in):
		tile_size = tile_size_in
		var radius = float(tile_size_in) / 2
		
		var mesh_node: MeshInstance3D = $MeshInstance3D
		var mesh: CylinderMesh = mesh_node.get_mesh()
		mesh.top_radius = radius
		mesh.bottom_radius = radius
		
		mesh_node.position = Vector3(position.x + radius, position.y, position.z + radius)
