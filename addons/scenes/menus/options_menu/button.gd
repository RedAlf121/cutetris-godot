extends Button

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Click")):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
