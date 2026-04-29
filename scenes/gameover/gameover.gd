extends Control
@onready var selectionSound = preload("res://assets/audio/sounds/popperDeath2.wav");
@onready var score = $CanvasLayer/VBoxContainer/score;
func _process(delta: float) -> void:
	var scoreTxt = "score: " + str(Global.score);
	score.text = scoreTxt;


	if Input.is_action_just_pressed("shoot"):
		Global.playSound(selectionSound);
		get_tree().change_scene_to_packed(load("res://scenes/titleScreen.tscn"));
		queue_free();