class_name PickupAmmo
extends Area3D
var ammo = 25
@onready var mesh_instance_3d = $MeshInstance3D
const BOBBING_SPEED = 0.005 # Adjust this value to control the speed of the bobbing motion

func _process(delta):
	rotate_y(delta)
	var time_elapsed = Time.get_ticks_msec() # Get the time elapsed between each frame
	mesh_instance_3d.position.y = position.y + sin(time_elapsed * BOBBING_SPEED) / 2
	mesh_instance_3d.position.y -= mesh_instance_3d.mesh.size.y / 2
