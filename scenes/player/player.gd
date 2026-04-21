class_name Player extends AnimatedSprite2D

var speed: float = 3.0

@onready var size = sprite_frames.get_frame_texture("default", 0).get_size()
@onready var bullet = preload("res://scenes/player/bullet.tscn")
@onready var shootSound = preload("res://assets/audio/sounds/playerShoot.wav");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move()
	shoot()


func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	position += speed * direction

	position.x = clampf(position.x, 0 + (size.x / 2), get_viewport_rect().size.x - (size.x / 2))
	position.y = clampf(position.y, 0 + (size.y / 2), get_viewport_rect().size.y - (size.y / 2))

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instantiate()
		get_tree().root.add_child(b)
		b.global_position = global_position
		Global.playSound(shootSound);
