class_name TileEntity extends AnimatedSprite2D
 
@onready var dead_tile: PackedScene = preload("res://scenes/tile/dead_tile.tscn")


func _on_timer_timeout():
	pass

func _exit_tree() -> void:
	var dt: DeadTile = dead_tile.instantiate()
	
	get_tree().root.add_child.call_deferred(dt)
	dt.global_position = global_position