class_name WindowLink
extends NavigationLink3D
@export_node_path("Barrier") var barrier_node_path : NodePath
@onready  var barrier = get_node(barrier_node_path)

func _ready():
	add_to_group("window_links")
