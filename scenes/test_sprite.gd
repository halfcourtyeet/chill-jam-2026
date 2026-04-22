extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 50 * delta

func _on_area_2d_body_entered(body: Node2D):
	print(body)
	
	if body is TileMapLayer:
		var pos = body.local_to_map(global_position - body.global_position)
			
		body.set_cell(pos, 1, Vector2i(1,1))
		queue_free()

func _on_area_2d_area_entered(area: Area2D):
	if area.owner is Player:
		queue_free()