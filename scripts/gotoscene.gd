extends Button

@export var nextScene: PackedScene



func _on_pressed() -> void:
	if(nextScene!=null):
		get_tree().change_scene_to_packed(nextScene)
