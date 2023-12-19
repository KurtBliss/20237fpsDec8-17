class_name Waves
extends Node3D
var current_wave = 0
var jam_message_on_wave = 5
@export_exp_easing("attenuation") var zombies_for_wave_easing
# TODO: @export_exp_easing("attenuation") var spawn_rate_easing
const ZOMBIE = preload("res://entities/zombie/zombie.tscn")
enum {DEFAULT, ROUND, BREAK, SPAWNING}
var state := DEFAULT
@onready var timer = $Timer

func _ready():
	timer.start() # timer that starts a new wave

func _process(_delta):
	match state:
		ROUND:
			if get_tree().get_nodes_in_group("zombies").size() == 0:
				state = BREAK
				timer.start()
		BREAK:
			pass
		SPAWNING:
			pass
		_:
			pass

func process_round(_delta):
	pass

func new_wave() -> void:
	current_wave += 1
	var points : Array[Node] = get_spawn_points()
	var current_point = 0
	# TODO: Debug to find out why zombie isn't Spawning
	for i in get_zombie_curve():
		var zombie = ZOMBIE.instantiate()
		var point : SpawnArea = points[current_point]
		add_child(zombie)
		zombie.global_position = point.get_random_point()
		current_point = wrapi(current_point + 1, 0, points.size())
	state = ROUND

func get_spawn_points() -> Array[Node]:
	return get_tree().get_nodes_in_group("spawn_points")

func get_zombie_curve() -> float:
	return ceilf(current_wave + ease(current_wave, zombies_for_wave_easing))

func _on_timer_timeout():
	new_wave()
