class_name SpawnArea
extends MeshInstance3D
@onready var box : BoxMesh = get_area_mesh()

func get_random_point() -> Vector3:
	var random_position : Vector3 = global_position
	random_position.x += randf_range(-box.size.x / 2, box.size.x / 2)
	random_position.z += randf_range(-box.size.z / 2, box.size.z / 2)
	# TODO: Raycast y w/ offset of half of zombie height
	return random_position

func get_area_mesh() -> BoxMesh:
	return mesh
