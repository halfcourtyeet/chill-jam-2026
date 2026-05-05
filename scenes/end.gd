extends PanelContainer


func _ready() -> void:
    $CenterContainer/VBoxContainer/Score.text = str(Global.score)

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("shoot"):
        Global.score = 0
        get_tree().change_scene_to_file("res://scenes/titleScreen.tscn")
        