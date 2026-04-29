class_name Enemy extends AnimatedSprite2D

var time: float
@onready var particle = preload("res://scenes/enemy/explosion_particle.tscn")
@onready var bullet = preload("res://scenes/enemy/enemy_bullet.tscn")

@onready var timer = $Timer
const speed = 0.05;

@onready var fallingTile = preload("res://scenes/tile/falling_tile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	time += randi_range(0, 500);

func _process(delta: float) -> void:
	time += delta
	position.x += cos(time * PI) * 200 * delta
	position.y += delta + speed;

func die():
	var p = particle.instantiate()
	get_tree().root.add_child(p)
	p.emitting = true
	p.global_position = global_position
	Global.score += 10;

	if randi_range(0,3) == 0:
		var tile = fallingTile.instantiate();
		tile.global_position = global_position;
		get_tree().root.add_child(tile);

	queue_free()

func shoot_bullet():
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.global_position = global_position

func _on_timer_timeout() -> void:
	shoot_bullet();
	timer.wait_time = randf_range(0.5, 0.7);

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player:
		area.owner.die()