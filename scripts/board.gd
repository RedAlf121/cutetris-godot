class_name Board extends GridContainer


@onready var slots: Array = get_children()

var actual_texture: Slot
var check_texture: Texture2D

signal gameover

func  _ready() -> void:

	create_texture()


func create_texture()->void:
	var square = TextureManager.generate_texture()
	if(has_slot_in_position(0,int(columns/2.0))):
		print(collect_points())
		emit_signal("gameover")
		print("game_over")
	var slot: Slot = get_slot_at_position(0,int(columns/2.0))
	slot.set_square_properties(square)
	slot.square_properties.print_properties()
	set_actual_texture(slot)

func get_slot_at_position(x:int,y:int)->Slot:
	return slots[x*columns+y]

func move_slot(slot: Slot,direction_x: int, direction_y: int):
	var index = get_slot_index(slot)
	if index == -1:
		return
	var new_direction = calculate_new_position(index, direction_x, direction_y)
	
	if !is_within_bounds(new_direction.x, new_direction.y) or has_slot_in_position(new_direction.x,new_direction.y):
		return -1
	return update_slot_properties(slot,new_direction.x, new_direction.y)

func get_slot_index(slot:Slot) -> int:
	var index = slots.find(slot)
	if index == -1:
		print("Error: actual_texture no encontrado.")
	return index

func get_index_position(index: int):
	var current_x:int = int(index / columns)
	var current_y:int = index % columns
	return Vector2(current_x,current_y)

func calculate_new_position(index: int, direction_x: int, direction_y: int) -> Vector2:
	return Vector2(direction_x, direction_y)+get_index_position(index)

func is_within_bounds(x: int, y: int) -> bool:
	return y >= 0 and y < columns and x >= 0 and x < int(slots.size() / columns)


func has_slot_in_position(direction_x: int, direction_y: int) -> bool:
	var neighbor_slot = get_slot_at_position(direction_x, direction_y)
	return neighbor_slot != null and neighbor_slot.get_texture() != null


func update_slot_properties(prev_slot:Slot,x: int, y: int):
	var new_slot = get_slot_at_position(x, y)
	new_slot.set_square_properties(prev_slot.square_properties)
	prev_slot.set_square_properties(null)
	return new_slot

func move_down(slot):
	var movement = move_slot(slot,1,0)
	if(movement is int):
		movement=null
	return movement

func move_left():
	if GlobalTime.TIME_STOPPED == false:
		var movement  = move_slot(actual_texture,0,1)
		if(movement is not int):
			set_actual_texture(movement)

func move_right():
	if GlobalTime.TIME_STOPPED == false:
		var movement = move_slot(actual_texture,0,-1)
		if(movement is not int):
			set_actual_texture(movement)


func on_timeout():
	if(check_texture!=actual_texture.get_texture()):
		create_texture()
	move_all_down()

func move_all_down():
	for i in range(slots.size()-1,0,-1):
		if(slots[i].get_texture()!=null):
			var new_slot = move_down(slots[i])
			if(slots[i]==actual_texture):
				set_actual_texture(new_slot)
				if(new_slot==null):
					create_texture()




func set_actual_texture(slot:Slot):
	if(slot!=null):
		actual_texture = slot
		check_texture = actual_texture.get_texture()

func collect_points() -> int:
	var logos_found = 0

	# Recorremos la matriz por cada slot
	for i in range(slots.size()):
		var slot: Slot = slots[i]
		if slot.get_texture() == null or slot.square_properties == null:
			continue  # Saltar slots vacíos

		# Convertimos el índice al sistema de coordenadas (x, y)
		var position = get_index_position(i)
		var x = position.x
		var y = position.y

		# Verificar que este slot sea un TopLeft
		if slot.square_properties.region != PieceRegion.TOP_LEFT:
			continue

		# Verificar los slots necesarios para el logo
		# 1. Slot a la derecha (TopRight)
		if !is_within_bounds(x, y + 1):
			continue
		var top_right_slot = get_slot_at_position(x, y + 1)
		if top_right_slot.get_texture() == null or top_right_slot.square_properties == null or top_right_slot.square_properties.region != PieceRegion.TOP_RIGHT:
			continue

		# 2. Slot debajo (BottomLeft)
		if !is_within_bounds(x + 1, y):
			continue
		var bottom_left_slot = get_slot_at_position(x + 1, y)
		if bottom_left_slot.get_texture() == null or bottom_left_slot.square_properties == null or bottom_left_slot.square_properties.region != PieceRegion.BOTTOM_LEFT:
			continue

		# 3. Slot diagonal (BottomRight)
		if !is_within_bounds(x + 1, y + 1):
			continue
		var bottom_right_slot = get_slot_at_position(x + 1, y + 1)
		if bottom_right_slot.get_texture() == null or bottom_right_slot.square_properties == null or bottom_right_slot.square_properties.region != PieceRegion.BOTTOM_RIGHT:
			continue

		# Verificar que todas las piezas pertenezcan a la misma facultad
		var faculty = slot.square_properties.faculty
		if top_right_slot.square_properties.faculty != faculty or bottom_left_slot.square_properties.faculty != faculty or bottom_right_slot.square_properties.faculty != faculty:
			continue

		# Si se cumple todo, se encontró un logo
		logos_found += 1

		# Crear una textura dorada para las piezas del logo
		var golden_texture = Texture2D.new()

		slot.set_texture(golden_texture)
		slot.set_square_properties(null)

		top_right_slot.set_texture(golden_texture)
		top_right_slot.set_square_properties(null)

		bottom_left_slot.set_texture(golden_texture)
		bottom_left_slot.set_square_properties(null)

		bottom_right_slot.set_texture(golden_texture)
		bottom_right_slot.set_square_properties(null)

	return logos_found
