class_name BombTile extends TileEntity

signal explode

func _process(delta: float) -> void:
    var remaining: float = ($Timer.wait_time - $Timer.time_left) / $Timer.wait_time
    remaining *= 15
    var m = sin(pow(remaining, 2))
    modulate = Color(m, m, m, m) * 3 + Color(1,1,1,0)

func _on_timer_timeout():
    explode.emit()