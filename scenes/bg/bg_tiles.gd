extends TileMapLayer

@export var speed: float = 1

var done: bool = false

func _physics_process(delta: float) -> void:
    position.y += (1.0/3.0)

    if global_position.y > 3000 and not done and not get_tree().root.find_child("Player", true, false).gameOver:
        done = true
        var fade_out = get_tree().root.find_child("FadeOut", true, false)
        fade_out.start_end()