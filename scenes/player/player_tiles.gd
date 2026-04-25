class_name PlayerTiles extends TileMapLayer

signal freeze_movement
signal unfreeze_movement

@onready var tile_entity_class: PackedScene = preload("res://scenes/tile/tile_entity.tscn")
var tile_dict: Dictionary[Vector2i, TileEntity]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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

	erase_cell(pos)
	tile_dict.get(pos).queue_free()
	tile_dict.erase(pos)
	
	
