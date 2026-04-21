class_name Enemy extends AnimatedSprite2D

var time: float
@onready var particle = preload("res://explosion_particle.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position.x += cos(time * PI) * 200 * delta

func die():
	var p = particle.instantiate()
	get_tree().root.add_child(p)
	p.emitting = true
	p.global_position = global_position
	queue_free()