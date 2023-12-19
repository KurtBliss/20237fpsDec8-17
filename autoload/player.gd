class_name AutoloadPlayer
extends Node
var health = 100
var points = 0
var ammo = 20

func take_damage(dmg = 15):
	health -= dmg
	if health <= 0:
		pass
