class_name Piece extends Node

var texture: Texture2D
var faculty: int #use Faculty
var region: int #use PieceRegion to assign enum

func _init(_texture, _faculty, _region) -> void:
	texture = _texture
	faculty = _faculty
	region = _region

#debug
func print_properties():
	print("piece:",self,[texture,faculty,region])
