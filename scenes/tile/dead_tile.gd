class_name DeadTile extends CharacterBody2D

var rotate_dir: int
@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		rotate_dir = (randi_range(0,1) * 2) - 1
		velocity += Vector2(randf_range(-30,30), randf_range(-60,-200))

func _physics_process(delta: float) -> void:
	velocity += Vector2(0, 9.8)
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	rotate(PI * delta * rotate_dir)
	modulate.a = $Timer.time_left / $Timer.wait_time

func _on_timer_timeout() -> void:
	queue_free()
