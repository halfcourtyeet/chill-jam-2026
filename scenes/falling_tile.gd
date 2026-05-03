class_name FallingTile extends Node2D

const SPEED = 50

@onready var dead_tile: PackedScene = preload("res://scenes/tile/dead_tile.tscn")

var body_attempting: Node2D
static var possible_tiles: Array[Vector2i] = [
	Vector2i(0,0),
	Vector2i(0,1),
	Vector2i(0,2),
	Vector2i(1,3)
]

var chosen_tile: Vector2i

var _d: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chosen_tile = possible_tiles.pick_random()
	$Tiles.set_cell(Vector2i(0,0), 0, chosen_tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += SPEED * delta
	if body_attempting != null:
		try_position(body_attempting)
	
	_d = delta

func _on_area_2d_body_entered(body: Node2D):
	try_position(body)


func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player or area.owner is Bullet:
		
		var dt: DeadTile = dead_tile.instantiate()
		
		get_tree().root.add_child.call_deferred(dt)
		dt.global_position = global_position
		queue_free()

		if area.owner is Bullet:
			area.owner.queue_free()

func try_position(body: Node2D):
	if body is PlayerTiles:

		var collision = global_position - body.global_position
		collision.y += SPEED * _d
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



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is PlayerTiles:
		body.unfreeze_movement.emit()
		body_attempting = null
