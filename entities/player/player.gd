class_name PlayerBody
extends PlayerBodyBase
@onready var head = $Head
@onready var camera = $Head/Camera3D
enum {STATE_DEFAULT}
var state := STATE_DEFAULT
const DEFAULT_SPEED := 600.0
const SPRINT_SPEED := 1000.0
var current_speed := DEFAULT_SPEED
var direction := Vector3()
const GRAVITY := 800.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Ref.player = self
	Ref.fetch_player_hud()

func _physics_process(delta) -> void:
	match state:
		_:
			camera_input()
			movement(delta)
			move_slide_gravity(delta)

func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
	if event is InputEventMouseMotion:
		move_camera(event.relative.x, event.relative.y)

func move_slide_gravity(delta):
	velocity.y -= GRAVITY * delta
	move_and_slide()

func movement(delta, disable_jump = false) -> void:
	var move : Vector3 =  head.global_basis * get_movement_vector3()
	velocity = move  * current_speed * delta
	if(!disable_jump and is_on_floor() and Input.is_action_just_pressed("jump")):
		velocity.y += 200

func camera_input() -> void:
	move_camera(Input.get_axis("head_left", "head_right"), Input.get_axis("head_up", "head_down"))

func move_camera(x : float, y : float, sensitivity_h := 0.1, sensitivity_v := 0.1 ) -> void:
	head.rotation_degrees.y -= x * sensitivity_h	
	camera.rotation_degrees.x = \
		clampf(camera.rotation_degrees.x - y * sensitivity_v, -98, 98)

func get_movement_vector2() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func get_movement_vector3() -> Vector3:
	var move_vect := get_movement_vector2()
	var move_vect3 := Vector3(move_vect.x, 0, move_vect.y)
	return move_vect3

func _on_interact_area_area_entered(area):
	if area is PickupAmmo:
		Player.ammo += area.ammo
		area.queue_free()
