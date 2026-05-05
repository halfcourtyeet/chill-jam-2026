extends ColorRect

func start_end():
   $AnimationPlayer.play("end")

func end():
   get_tree().change_scene_to_file("res://scenes/End.tscn")
