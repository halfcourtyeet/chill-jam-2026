class_name PlayerTiles extends TileMapLayer

signal freeze_movement
signal unfreeze_movement

var perma_tiles: Array[Vector2i] = [
	Vector2i(-2,-1),
	Vector2i(1,-1),
]

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
	set_cell(pos, 0, tile)
	unfreeze_movement.emit()
	var scene = get_cell_tile_data(pos).get_custom_data("TileEntity")
	var new_tile: TileEntity
	if scene is PackedScene:
		new_tile = scene.instantiate()
	else:
		new_tile = load("res://scenes/tile/tile_entity.tscn").instantiate()
		new_tile.set_script(scene)


	add_child(new_tile)
	new_tile.position = map_to_local(pos)
	tile_dict.set(pos, new_tile)

	if new_tile is BombTile:
		new_tile.connect("explode", _on_bomb_explode.bind(pos))
		
	
func delete_tile(pos: Vector2i, wipe_glues: bool = false, even_permas: bool = false):
	var tile = get_cell_tile_data(pos)
	if not tile:
		printerr("delete_tile(): No valid tile given.")
		return

	var entity = tile_dict.get(pos)
	if entity is GlueTile and not wipe_glues:
		entity.lives -= 1
		if entity.lives > 0: return

	if pos in perma_tiles and not even_permas: return

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
			delete_tile(c, true)




func get_neighbors(pos: Vector2i) -> Array[Vector2i]:
	var neighbor_array: Array[Vector2i] = []
	for i in range (0, 16, 4):
		var neighbor_tile = get_neighbor_cell(pos, i)
		if get_cell_tile_data(neighbor_tile) != null:
			neighbor_array.append(neighbor_tile)
		
	return neighbor_array


func _on_bomb_explode(cell: Vector2i) -> void:
	print(cell)
	for i in range(-1, 2):
		for j in range(-1, 2):
			var this_tile = cell + Vector2i(i,j)
			delete_tile(this_tile, true)

	delete_bfs()
