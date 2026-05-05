class_name ShooterTile extends TileEntity

@onready var tile_bullet = preload("res://scenes/tile/shooter/tile_bullet.tscn")

func _on_timer_timeout():
    
    var b: TileBullet = tile_bullet.instantiate()
    get_tree().root.add_child(b)
    b.global_position = global_position
    play("shoot")
    $ShootNoise.play()
