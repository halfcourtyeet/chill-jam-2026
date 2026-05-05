class_name Player extends AnimatedSprite2D

var speed: float = 2.0

@onready var size = sprite_frames.get_frame_texture("default", 0).get_size()
@onready var bullet = preload("res://scenes/player/bullet.tscn")
@onready var shootSound = preload("res://assets/audio/sounds/playerShoot.wav");

var shootQueue := 0;
var shootDelay := 0;
const shootDelayBetweenEachBullet := 5.0;
const amountOfBulletsToShoot := 1;

@onready var player_tiles: PlayerTiles = $PlayerTiles

var _movement_frozen = false

var dead := false;
var gameOver := false;
var invincibility := 3.0;
var invincibilityFlicker = true;
var direction: Vector2

@onready var gameOverScene = preload("res://scenes/gameover/gameover.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if invincibility > 0: 
		invincibility -= delta;
		invincibilityFlicker = !invincibilityFlicker;
		visible = invincibilityFlicker;
	elif !dead:
		show();

	if not _movement_frozen:
			move()
	if !dead: shoot()

	if direction.x < 0.0:
		play("left")
	elif direction.x > 0.0:
		play("right")
	else:
		play("default")
	

func move():
	direction = Input.get_vector("left", "right", "up", "down")
	position += speed * direction 

	position.x = clampf(position.x, (size.x / 2), get_viewport_rect().size.x - (size.x / 2))
	position.y = clampf(position.y, (size.y / 2), get_viewport_rect().size.y - (size.y / 2))

	position.x = clampf(position.x, -player_tiles.get_bounds().position.x + 4.0,  get_viewport_rect().size.x - player_tiles.get_bounds().end.x + 4.0)
	position.y = clampf(position.y, -player_tiles.get_bounds().position.y + 4.0,  get_viewport_rect().size.y - player_tiles.get_bounds().end.y + 4.0)


func shoot():
	if Input.is_action_just_pressed("shoot"): shootQueue = amountOfBulletsToShoot;

	if shootQueue > 0 and shootDelay <= 0 and get_tree().get_nodes_in_group("player_bullets").is_empty():
		shootQueue -= 1;
		shootDelay = shootDelayBetweenEachBullet;
		var b: Bullet = bullet.instantiate()
		get_tree().root.add_child(b)
		b.add_to_group("player_bullets")
		b.global_position = global_position
		Global.playSound(shootSound);
	else:
		shootDelay -= 0.1;

func _on_freeze_movement():
	print("+Movement frozen")
	_movement_frozen = true

func _on_unfreeze_movement():
	print("-Movement unfrozen")
	_movement_frozen = false

func die():
	if invincibility > 0: return;
	if !dead:
		dead = true;
		Global.lives -= 1;

		var explosion_particle = load("res://scenes/enemy/explosion_particle.tscn").instantiate()
		for c in $PlayerTiles.get_used_cells():
			$PlayerTiles.delete_tile(c, true)
		hide()
		
		get_tree().root.add_child(explosion_particle)
		explosion_particle.global_position = global_position
		explosion_particle.emitting = true
		$PlayerNoises.stream = load("res://assets/audio/sounds/death3.wav")
		$PlayerNoises.play()

		$PlayerTiles.collision_enabled = false

		await get_tree().create_timer(1.5).timeout
		$PlayerTiles.collision_enabled = true
		if Global.lives > 0:
			global_position = Vector2(224/2, 230);
			dead = false;
			invincibility = 3.0;
			show();
		elif !gameOver:
			var g = gameOverScene.instantiate();
			get_node("/root").add_child(g);
			queue_free();
