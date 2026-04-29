extends Control
@onready var selectionSound = preload("res://assets/audio/sounds/popperDeath2.wav");
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		Global.playSound(selectionSound);
		get_tree().change_scene_to_packed(load("res://scenes/titleScreen.tscn"));
		queue_free();