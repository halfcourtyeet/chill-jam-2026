extends Node2D

var selection := 0;
@onready var selectionSound = preload("res://assets/audio/sounds/popperDeath1.wav");
@onready var selectionSound2 = preload("res://assets/audio/sounds/popperDeath2.wav");
@onready var startGame = $gui/startGame;
@onready var options = $gui/options;
@onready var quit = $gui/quit;

@onready var playerSprite = $playerSprite;
var t := 0.0;

@onready var mainGameScene = preload("res://scenes/main.tscn");

func _ready() -> void:
	for c in get_tree().root.get_children(true):
		if c is EnemyBullet:
			c.queue_free()

func _process(delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		Global.playSound(selectionSound2);
		match selection:
			0: 
				#start game
				Global.lives = Global.startLives;
				get_tree().change_scene_to_packed(mainGameScene);
			2:
				#quit game
				get_tree().quit();

	#graphics
	match selection:
		0:
			startGame.modulate = Color.RED;
		1:
			options.modulate = Color.RED;
		2:
			quit.modulate = Color.RED;

	t += delta;
	playerSprite.global_position.x = 224/2 + sin(t*2)*50;
	playerSprite.global_position.y = 200 + cos(t*7)*5;

func optionSwitchCode():
	Global.playSound(selectionSound);
	startGame.modulate = Color.WHITE;
	options.modulate = Color.WHITE;
	quit.modulate = Color.WHITE;
