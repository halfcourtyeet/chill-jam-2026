extends Node

func _process(delta: float) -> void:
	fullscreenCode();
	closeGameCode();

func fullscreenCode():##fullscreen
	if Input.is_action_just_pressed("f11") or (Input.is_action_pressed("alt") and Input.is_action_just_pressed("enter")): 
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);

func closeGameCode():
	if Input.is_action_just_pressed("f5"): get_tree().quit();

func playSound(Sound: Resource, Volume: float = 1.0, Pitch: float = 1.0):
	var soundNode = AudioStreamPlayer.new();
	soundNode.script = preload("res://playSound.gd");
	soundNode.stream = Sound;
	soundNode.pitch_scale = Pitch;
	soundNode.volume_db = Volume;
	soundNode.autoplay = true;
	soundNode.bus = "Sounds";
	get_node("/root").add_child(soundNode);
	return soundNode;