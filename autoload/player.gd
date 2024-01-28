class_name AutoloadPlayer
extends Node
var health = 100
var points = 0
var ammo = 20.0

func _process(delta):
	if not Ref.fetch_player_body():
		return
	ammo += delta / 4

func take_damage(dmg = 15):
	health -= dmg
	if health <= 0:
		pass
