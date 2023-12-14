extends Node
var player : PlayerBody
var hud : Hud

func fetch_player_body():
	if is_instance_valid(player):
		return true
	var players = get_tree().get_nodes_in_group("player_body")
	if players.size() > 0:
		player = players[0]
		return true
	return false

func fetch_player_hud():
	if is_instance_valid(hud):
		return true
	var hud = get_tree().get_first_node_in_group("huds")
	if !is_instance_valid(hud):
		hud = preload("res://entities/hud/hud.tscn").instantiate()
		var level = get_tree().get_first_node_in_group("levels")
		if is_instance_valid(level):
			level.add_child.call_deferred(hud)
		else:
			hud.queue_free()
	return true
