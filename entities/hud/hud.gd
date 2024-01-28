class_name Hud
extends CanvasLayer
@onready var health_bar = $HealthBar
@onready var wave = $Wave
@onready var points = $Points
@onready var ammo = $Ammo

func _ready():
	Ref.hud = self

func _process(_delta):
	health_bar.value = Player.health
	if Ref.fetch_wave():
		wave.text = str(Ref.waves.current_wave)
	points.text = str(Player.points)
	ammo.text = str(floor(Player.ammo))


