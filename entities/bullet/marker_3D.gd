@tool
extends Marker3D
@onready var bullet : Bullet = $".."

@onready var starting_position_edit = global_position

func _process(_delta):
	var starting_position = bullet.starting_position if !Engine.is_editor_hint() else starting_position_edit
	var pos = bullet.global_position if !Engine.is_editor_hint() else global_position
	scale.z = (starting_position - pos).length()
