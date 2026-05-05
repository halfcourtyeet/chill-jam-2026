class_name Enemy extends AnimatedSprite2D

var dead = false

var time: float
@onready var particle = preload("res://scenes/enemy/explosion_particle.tscn")
@onready var bullet = preload("res://scenes/enemy/enemy_bullet.tscn")

@onready var timer = $Timer

var h_speed: float 
var y_speed: float

@onready var fallingTile = preload("res://scenes/tile/falling_tile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	time += randi_range(0, 500);
	h_speed = randi_range(100, 250)
	y_speed = randi_range(10, 30)

func _process(delta: float) -> void:
	if dead: return
	time += delta
	var direction: float = cos(time * PI) * h_speed * delta
	position.x += direction
	position.y += delta * y_speed;

	if direction < -1.5:
		play("left")
	elif direction > 1.5:
		play("right")
	else:
		play("default")

	if position.y > get_viewport_rect().size.y + 16:
		queue_free()

func die():
	dead = true
	var p = particle.instantiate()
	get_tree().root.add_child.call_deferred(p)
	p.emitting = true
	p.global_position = global_position

	var pt: PlayerTiles = get_tree().root.find_child("PlayerTiles", true, false)
	if pt.get_num_tiles() == 0:
		Global.score += 10;
	else:
		Global.score += 10 * (pt.get_num_tiles()) * (pt.get_num_tiles())

	var tile = fallingTile.instantiate();
	tile.global_position = global_position;
	get_tree().root.add_child.call_deferred(tile);

	hide()
	$Area2D.queue_free()
	$DeathNoise.play()
	await get_tree().create_timer(3.0).timeout
	queue_free()


func shoot_bullet():	
	if dead: return
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.global_position = global_position
	$ShootNoise.play()

func _on_timer_timeout() -> void:
	shoot_bullet();
	timer.wait_time = randf_range(0.5, 0.9);

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player:
		area.owner.die()
