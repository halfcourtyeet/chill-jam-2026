extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.x = randi_range(0, get_viewport_rect().size.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = randi_range(0, get_viewport_rect().size.x)
