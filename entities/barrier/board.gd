class_name Board
extends MeshInstance3D
var health = 100

func _process(_delta):
	if not visible:
		return
	var mat : StandardMaterial3D = mesh.surface_get_material(0)
	mat.albedo_color.r = min(0.7, health / 100)
	mat.albedo_color.g = min(0.7, health / 100)
	mat.albedo_color.b = min(0.7, health / 100)
	mat.albedo_color.a = max(0.2, health / 100)

func take_damage(dmg):
	health = max(health - dmg, 0)
	if health == 0:
		visible = false

func repair(ammount):
	health = min(health + ammount, 100)	
	if health >= 50:
		visible = true

