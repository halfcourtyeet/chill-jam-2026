class_name ShooterTile extends TileEntity

@onready var bullet = preload("res://scenes/player/bullet.tscn")

func _on_timer_timeout():
    
    var b: Bullet = bullet.instantiate()
    get_tree().root.add_child(b)
    b.global_position = global_position
    