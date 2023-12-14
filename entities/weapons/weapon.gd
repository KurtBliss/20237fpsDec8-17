extends Node3D
@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D
@onready var muzzle = $Muzzle

func _ready():
	#sprite.connect("animation_finished", fire)
	sprite.animation_finished.connect(anim_finished)

func anim_finished():
	sprite.visible = false
	sprite.stop()

func fire():
	sprite.play("default", 7.0)
	sprite.frame = 0
	sprite.visible = true

func get_muzzle_position():
	return muzzle.global_position
