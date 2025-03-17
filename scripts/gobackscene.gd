extends Node
@export_file("*.tscn") var prev_scene



func go_back() -> void:
	if(prev_scene!=null):
		get_tree().change_scene_to_file(prev_scene)
