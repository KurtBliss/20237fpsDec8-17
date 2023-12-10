extends Node

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_F1:
				print("Setting Zombies Location")
				var zombies = get_tree().get_nodes_in_group("zombies")
				for zombie : Zombie in zombies:
					zombie.on_debug_f1()
					pass
