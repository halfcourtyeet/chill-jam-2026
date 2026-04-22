class_name FallingTile extends Sprite2D

var body_attempting: Node2D
@export var possible_tiles: Array[PackedScene]
@export var tile_to_atlas: Dictionary

var chosen_tile: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func setup():
	chosen_tile = possible_tiles.pick_random().instantiate()
	texture = chosen_tile.texture

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
		var pos = body.local_to_map(global_position - body.global_position)

		var alone: bool = true
		for i in range (0, 16, 4):
			var neighbor_tile = body.get_neighbor_cell(pos, i)
			if body.get_cell_tile_data(neighbor_tile) != null:
				alone = false

		if alone == true:
			body.freeze_movement.emit()
			body_attempting = body
			return

		body.set_cell(pos, 1, Vector2i(1,1))
		body.unfreeze_movement.emit()
		body_attempting = null
		queue_free()

	body.unfreeze_movement.emit()
	body_attempting = null
