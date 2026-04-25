class_name PlayerTiles extends TileMapLayer

signal freeze_movement
signal unfreeze_movement

var perma_tiles: Array[Vector2i] = [
	Vector2i(-2,-1),
	Vector2i(1,-1),
]

@onready var tile_entity_class: PackedScene = preload("res://scenes/tile/tile_entity.tscn")
@onready var dead_tile: PackedScene = preload("res://scenes/tile/dead_tile.tscn")
var tile_dict: Dictionary[Vector2i, TileEntity]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_used_cells():
		var coords = get_cell_atlas_coords(c)
		add_tile(c, coords)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for c in get_used_cells():
		var data = get_cell_tile_data(c)
			

func get_bounds() -> Rect2:
	var new_rect: Rect2

	new_rect.position = map_to_local(get_used_rect().position)
	new_rect.end = map_to_local(get_used_rect().end)
	return new_rect


func add_tile(pos: Vector2i, tile: Vector2i):
	set_cell(pos, 1, tile)
	unfreeze_movement.emit()
	var new_tile: TileEntity = tile_entity_class.instantiate()
	add_child(new_tile)
	new_tile.position = map_to_local(pos)
	tile_dict.set(pos, new_tile)
	
func delete_tile(pos: Vector2i):
	var tile = get_cell_tile_data(pos)
	if not tile:
		printerr("delete_tile(): No valid tile given.")
		return

	if pos in perma_tiles: return

	erase_cell(pos)
	tile_dict.get(pos).queue_free()
	tile_dict.erase(pos)

	var dt: DeadTile = dead_tile.instantiate()
	
	get_tree().root.add_child(dt)
	dt.global_position = to_global(map_to_local(pos))


	
	
func delete_bfs():
	var visited_array: Array[Vector2i]
	var queue: Array
	for pos in perma_tiles:
		
		queue.clear()
		visited_array.append(pos)
		queue.append(pos)
		
		while !queue.is_empty():
			var current = queue.pop_front()

			for n in get_neighbors(current):
				if n not in visited_array:
					visited_array.append(n)
					queue.append(n)
	
	for c in get_used_cells():
		if c not in visited_array:
			delete_tile(c)

		



func get_neighbors(pos: Vector2i) -> Array[Vector2i]:
	var neighbor_array: Array[Vector2i] = []
	for i in range (0, 16, 4):
		var neighbor_tile = get_neighbor_cell(pos, i)
		if get_cell_tile_data(neighbor_tile) != null:
			neighbor_array.append(neighbor_tile)
		
	return neighbor_array
