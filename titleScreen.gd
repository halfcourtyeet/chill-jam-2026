extends Node2D
var selection := 0;
@onready var startGame = $gui/startGame;
@onready var options = $gui/options;
@onready var quit = $gui/quit;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		selection -= 1;
		resetColor();
	if Input.is_action_just_pressed("down"):
		selection += 1;
		resetColor();
	selection = clamp(selection, 0, 2);
	print(selection);

	match selection:
		0:
			startGame.modulate = Color.YELLOW;
		1:
			options.modulate = Color.YELLOW;
		2:
			quit.modulate = Color.YELLOW;

func resetColor():
	startGame.modulate = Color.WHITE;
	options.modulate = Color.WHITE;
	quit.modulate = Color.WHITE;