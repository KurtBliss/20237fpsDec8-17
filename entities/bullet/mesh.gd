extends MeshInstance3D
@onready var bullet : Bullet = $".."

func _ready():
	reparent(bullet.get_parent())

func _process(delta):
	if is_instance_valid(bullet):
		if bullet.starting_position == null:
			return
		mesh = ImmediateMesh.new()
		mesh.clear_surfaces()
		mesh.surface_begin(Mesh.PRIMITIVE_LINES, material_override)
		mesh.surface_add_vertex(bullet.starting_position)
		mesh.surface_add_vertex(bullet.global_position)
		mesh.surface_end()
	else:
		transparency += delta
		material_override.albedo_color.a -= delta
		if material_override.albedo_color.a <= 0:
			queue_free()
	
