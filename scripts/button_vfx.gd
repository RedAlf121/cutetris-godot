extends Button


func _ready() -> void:
	pass

func _on_Button_pressed():
	$TextureRect.modulate = Color(1, 1, 1,0.8)  # Cambiar color al presionar

func _on_Button_released():
	$TextureRect.modulate = Color(1, 1, 1,1)  # Restaurar color
