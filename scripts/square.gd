class_name  Slot extends PanelContainer

@export var panel_texture: Texture2D

@onready var texture_rect: TextureRect = $TextureRect

var square_properties: Piece


func _ready() -> void:
	texture_rect.texture = panel_texture
	

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(_get_preview())
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Slot

func _drop_data(at_position: Vector2, data) -> void:
	var temp = square_properties
	set_square_properties(data.square_properties)
	data.set_square_properties(temp)


func _get_preview():
	var preview_texture = TextureRect.new()
	
	
	#TODO crear un factory para esto ya que influyen otras variables
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.texture = texture_rect.texture
	preview_texture.size = Vector2(40,40)
	
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview


func get_texture():
	return texture_rect.texture

func set_texture(new_texture: Texture2D):
	texture_rect.texture = new_texture

func set_square_properties(square: Piece):
	square_properties = square
	if(square!=null):
		set_texture(square_properties.texture)
	else:
		set_texture(null)
