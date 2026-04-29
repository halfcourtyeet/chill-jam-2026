extends Node2D
var playerSprite = preload("res://assets/sprites/placeholder-galaga.png");
@onready var scoreLable = $score;

func _process(delta):
	scoreLable.text = str(Global.score);
	queue_redraw(); #ik this is ineffecient AAAH
func _draw() -> void:
	for i in Global.lives:
		draw_texture(playerSprite, Vector2(4+(4*i*4), 4));