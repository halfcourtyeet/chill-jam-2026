extends Node2D
@export var player_sprite: Texture2D
@onready var scoreLable = $score;

func _process(delta):
	scoreLable.text = "Score: " + str(Global.score);
	queue_redraw(); #ik this is ineffecient AAAH
func _draw() -> void:
	for i in Global.lives:
		draw_texture(player_sprite, Vector2(4+(4*i*4), 4));