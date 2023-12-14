class_name Zombie
extends CharacterBody3D
enum {DEFAULT, CHASE, WINDOW}
var state := CHASE
var current_speed = 400
const GRAVITY = 800
@onready var agent : NavigationAgent3D = $NavigationAgent3D
var perform_jump = false
var grab_body : PlayerBody
@onready var attack_timer : Timer = $Attack
var health = 100
@onready var anim_hurt = $AnimHurt
var link  : Dictionary = {}

func _physics_process(delta):
	match state:
		CHASE:
			move_to_player(delta)
			update_target_position()
			move_slide_gravity(delta)
		WINDOW:
			if not link.is_empty():
				process_window(link["owner"])
		_:
			move_slide_gravity(delta)

func process_window(window : WindowLink):
	var barrier : Barrier = window.barrier
	if barrier.is_active():
		if attack_timer.is_stopped():
			attack_timer.start()
	else:
		print("returning...")
		global_position.x = link["link_exit_position"].x
		global_position.z = link["link_exit_position"].z
		link = {}
		if not is_instance_valid(grab_body):
			attack_timer.stop()
		state = CHASE

func move_slide_gravity(delta):
	velocity.y -= GRAVITY * delta
	move_and_slide()

func move_to_player(delta):
	var vector_to_position : Vector3 = (agent.get_next_path_position() - global_position)
	#var max_dist = max(vector_to_position.length(),0) # use later to avoid over stepping target.
	var direction = vector_to_position.normalized()
	direction.y = 0
	look_at(global_position+direction)
	velocity = direction * current_speed * delta
	if perform_jump:
		perform_jump = false
		velocity.y += 125

func on_debug_f1():
	if !Ref.fetch_player_body():
		return
	agent.target_position = Ref.player.global_position
	state = CHASE

func update_target_position():
	if !Ref.fetch_player_body():
		return
	agent.target_position = Ref.player.global_position

func _on_navigation_agent_3d_link_reached(details):
	print(details)
	print(details["owner"])
	print(details["owner"] is WindowLink)
	if details["owner"] is WindowLink:
		link = details
		state = WINDOW

func _on_area_3d_body_entered(body):
	if body is PlayerBody:
		grab_body = body
		attack_timer.start()

func _on_area_3d_body_exited(body):
	if body is PlayerBody:
		grab_body = null
		attack_timer.stop()

func _on_attack_timeout():
	if is_instance_valid(grab_body):
		Player.health -= 15
	if not link.is_empty():
		var window : WindowLink = link["owner"]
		var barrier : Barrier = window.barrier
		barrier.break_board(10)

func on_bullet_hit(dmg):
	health -= dmg
	anim_hurt.play("hurt")
	if health <= 0:
		queue_free()
