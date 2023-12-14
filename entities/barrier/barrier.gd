class_name Barrier
extends StaticBody3D
var default_board_health = 30
@onready var boards = $Boards
@onready var collision : CollisionShape3D = $CollisionShape3D

func activate(): 
	collision.disabled = false

func deactivate():
	collision.disabled = true

func is_active():
	return is_instance_valid(get_active_board())

func break_board(dmg):
	if not is_active():
		return
	var board : Board = get_active_board()
	board.take_damage(35)

func repair_board(repair):
	for board : Board in boards.get_children():
		if board.health < 100:
			board.repair(repair)
			return

func get_active_board():
	for board : Board in boards.get_children():
		if board.visible:
			return board
	
func get_inactive_board():
	for board : Board in boards.get_children():
		if not board.visible:
			return board
