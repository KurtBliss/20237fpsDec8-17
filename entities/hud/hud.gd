class_name Hud
extends CanvasLayer
@onready var health_bar = $HealthBar

func _ready():
	Ref.hud = self

func _process(_delta):
	health_bar.value = Player.health


