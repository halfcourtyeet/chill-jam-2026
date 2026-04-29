class_name EnemyBullet extends Sprite2D

const SPEED = 100

var _d: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.y += SPEED * delta
	if global_position.y < 0 + (texture.get_size().y / 2):
		queue_free()
	_d = delta

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player:
		area.owner.die()
	
	if area.owner is ProtectorTile:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	try_position(body)

func try_position(body: Node2D):
	if body is PlayerTiles:
		var collision = global_position - body.global_position
		collision.y += (SPEED * _d)
		var rounded = round(collision)
		var pos: Vector2i = body.local_to_map(rounded)

		print(collision)
		print(rounded)
		print(pos)

		if body.get_cell_tile_data(pos) != null:
			body.delete_tile(pos)
			queue_free()
			body.delete_bfs()
				
