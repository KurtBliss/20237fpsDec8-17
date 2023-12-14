extends AnimationPlayer
@onready var player_body : PlayerBody = $".."

func _ready():
	play("moving", -1, 1.0)
	speed_scale = 0

func _process(_delta):
	speed_scale = player_body.velocity.length() / player_body.current_speed * 38
