class_name Player extends AnimatedSprite2D

var speed: float = 3.0

@onready var size = sprite_frames.get_frame_texture("default", 0).get_size()
@onready var bullet = preload("res://scenes/player/bullet.tscn")
@onready var shootSound = preload("res://assets/audio/sounds/playerShoot.wav");

var shootQueue := 0;
var shootDelay := 0;
const shootDelayBetweenEachBullet := 3.0;
const amountOfBulletsToShoot := 3;

@onready var player_tiles: PlayerTiles = $PlayerTiles

var _movement_frozen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not _movement_frozen:
		move()
	shoot()


func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	position += speed * direction 

	position.x = clampf(position.x, (size.x / 2), get_viewport_rect().size.x - (size.x / 2))
	position.y = clampf(position.y, (size.y / 2), get_viewport_rect().size.y - (size.y / 2))

	position.x = clampf(position.x, -player_tiles.get_bounds().position.x + 4.0,  get_viewport_rect().size.x - player_tiles.get_bounds().end.x + 4.0)
	position.y = clampf(position.y, -player_tiles.get_bounds().position.y + 4.0,  get_viewport_rect().size.y - player_tiles.get_bounds().end.y + 4.0)


func shoot():
	if Input.is_action_just_pressed("shoot"): shootQueue = amountOfBulletsToShoot;

	if shootQueue > 0 and shootDelay <= 0:
		shootQueue -= 1;
		shootDelay = shootDelayBetweenEachBullet;
		var b = bullet.instantiate()
		get_tree().root.add_child(b)
		b.global_position = global_position
		Global.playSound(shootSound);
	else:
		shootDelay -= 0.1;

func _on_freeze_movement():
	_movement_frozen = true

func _on_unfreeze_movement():
	_movement_frozen = false
