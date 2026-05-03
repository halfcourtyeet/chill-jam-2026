extends TileMapLayer

@export var speed: float = 12


func _physics_process(delta: float) -> void:
    position.y += speed * delta