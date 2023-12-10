class_name Zombie
extends CharacterBody3D
enum {DEFAULT, CHASE}
var state := DEFAULT
var current_speed = 700
const GRAVITY = 800
@onready var agent : NavigationAgent3D = $NavigationAgent3D
var perform_jump = false

func _ready():
	pass

func _physics_process(delta):
	match state:
		CHASE:
			move_to_player(delta)
			move_slide_gravity(delta)
		_:
			move_slide_gravity(delta)

func move_slide_gravity(delta):
	velocity.y -= GRAVITY * delta
	move_and_slide()

func move_to_player(delta):
	var vector_to_position : Vector3 = (agent.get_next_path_position() - global_position)
	#var max_dist = max(vector_to_position.length(),0) # use later to avoid over stepping target.
	var direction = vector_to_position.normalized()
	direction.y = 0
	look_at(direction)
	velocity = direction * current_speed * delta
	if perform_jump:
		perform_jump = false
		velocity.y += 125

func on_debug_f1():
	if !Ref.fetch_player():
		return
	agent.target_position = Ref.player.global_position
	state = CHASE
	


func _on_navigation_agent_3d_link_reached(details):
	global_position.x = details["link_exit_position"].x
	global_position.z = details["link_exit_position"].z
