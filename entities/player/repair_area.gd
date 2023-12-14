extends Area3D
var barrier : Barrier
@onready var timer = $Timer

func _on_body_entered(body):
	if body is Barrier:
		barrier = body
		if timer.is_stopped():
			timer.start()

func _on_body_exited(body):
	if body == barrier:
		body = null
		timer.stop()

func _on_timer_timeout():
	if is_instance_valid(barrier):
		barrier.repair_board(15)
