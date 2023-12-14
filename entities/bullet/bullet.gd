class_name Bullet
extends Area3D
var movement : Vector3
var target_groups : Array[String]
var damage = 25
var last_position : Vector3 =Vector3.ZERO
@onready var starting_position : Vector3
@onready var mesh_instance_3d : MeshInstance3D = $MeshInstance3D

func _ready():
	print(get_parent())
	mesh_instance_3d.reparent.call_deferred(get_parent(),true)

func _physics_process(delta) -> void:
	position += movement * delta
	var hit = raycast_direct(last_position, global_position)
	if hit.has("collider"):
		process_body(hit.get("collider"), hit.get("position"))
	last_position = global_position	

func _on_body_entered(body : Node3D) -> void:
	process_body(body)

func process_body(body : Node3D, hit_position : Vector3 = global_position) -> void:
	for target_group in target_groups:
		if body.is_in_group(target_group):
			if body.has_method("on_bullet_hit"):
				body.call("on_bullet_hit", damage)
			global_position = body["position"]
			queue_free()
		if body is CSGCombiner3D \
		or body is StaticBody3D:
			global_position = body["position"]			
			queue_free()

func raycast_direct(from, to, exclude = [self]):
	var space_state = get_world_3d().get_direct_space_state()
	var params = PhysicsRayQueryParameters3D.create(from, to, 0xFFFFFFFF, exclude)
	var hit = space_state.intersect_ray(params)
	return hit

func _on_timer_timeout():
	queue_free()
