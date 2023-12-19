class_name PlayerWeapon
extends Node
var bullet_scn = preload("res://entities/bullet/bullet.tscn")
@onready var player = $".."
@onready var head = $"../Head"
@onready var camera = $"../Head/Camera3D"
@onready var weapon_marker = $"../Head/Camera3D/WeaponMarker"
@onready var anim_weapon_bounce = $"../AnimWeaponBounce"

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		fire()

func fire(speed = 300):
	if Player.ammo <= 0:
		return
	Player.ammo -= 1
	var bullet_inst : Bullet = bullet_scn.instantiate()
	player.add_sibling(bullet_inst)
	bullet_inst.movement = -camera.global_basis.z * 300
	#bullet_inst.global_rotation = camera.global_rotation 
	bullet_inst.starting_position = weapon_marker.get_muzzle_position() 
	bullet_inst.global_position = weapon_marker.get_muzzle_position()  -camera.global_basis.z
	bullet_inst.last_position = weapon_marker.get_muzzle_position() 
	bullet_inst.target_groups.append("zombies")
	weapon_marker.get_weapon().fire()
	anim_weapon_bounce.play("fire", -1, 4)
