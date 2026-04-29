class_name LevelStream extends Node2D

@onready var enemy_class = preload("res://scenes/enemy/enemy.tscn")

func spawn_enemy(pos: Vector2) -> void:
    var e: Enemy = enemy_class.instantiate()
    add_child(e)
    e.position.x = clampf(e.position.x, 224/2, get_viewport_rect().size.x - 8)