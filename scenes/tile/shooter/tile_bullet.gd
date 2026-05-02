class_name TileBullet extends AnimatedSprite2D

const SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.y -= SPEED * delta
	if global_position.y < 16:
		queue_free()

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Enemy:
		area.owner.die()
		queue_free();
