class_name GlueTile extends TileEntity

var lives: int = 2

func _process(delta: float) -> void:
    if lives == 1:
        var m = sin(Time.get_ticks_msec() / 300.0) 
        modulate = Color(m, m, m, m) * 1.5 + Color(1,1,1,0)
