class_name Enemy extends AnimatedSprite2D

var time: float
@onready var particle = preload("res://scenes/enemy/explosion_particle.tscn")
@onready var bullet = preload("res://scenes/enemy/enemy_bullet.tscn")
@onready var timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position.x += cos(time * PI) * 200 * delta

func die():
	var p = particle.instantiate()
	get_tree().root.add_child(p)
	p.emitting = true
	p.global_position = global_position
	Global.score += 10;
	queue_free()

func shoot_bullet():
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.global_position = global_position

func _on_timer_timeout() -> void:
	shoot_bullet()