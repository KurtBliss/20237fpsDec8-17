extends Node

var player : PlayerBody

func fetch_player():
	if is_instance_valid(player):
		return true
	var players = get_tree().get_nodes_in_group("player_body")
	if players.size() > 0:
		player = players[0]
		return true
	return false

