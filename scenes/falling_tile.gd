class_name FallingTile extends Sprite2D

var body_attempting: Node2D
static var possible_tiles: Array[Vector2i] = [
	Vector2i(0,0),
	Vector2i(0,1),
	Vector2i(1,0),
	Vector2i(1,1)
]

var chosen_tile: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chosen_tile = possible_tiles.pick_random()
	texture.region.position = Vector2(chosen_tile) * 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 50 * delta
	if body_attempting != null:
		try_position(body_attempting)

func _on_area_2d_body_entered(body: Node2D):
	try_position(body)

		

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player:
		queue_free()

func try_position(body: Node2D):
	if body is PlayerTiles:
		var pos: Vector2i = body.local_to_map(global_position - body.global_position)

		var alone: bool = true
		for i in range (0, 16, 4):
			var neighbor_tile = body.get_neighbor_cell(pos, i)
			if body.get_cell_tile_data(neighbor_tile) != null:
				alone = false

		if alone == true:
			body.freeze_movement.emit()
			body_attempting = body
			return

		body.add_tile(pos, chosen_tile)
		body_attempting = null
		queue_free()

	body.unfreeze_movement.emit()
	body_attempting = null
