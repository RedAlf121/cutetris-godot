class_name Board extends GridContainer


@onready var slots: Array = get_children()

var actual_texture: Slot

func  _ready() -> void:

	create_texture()

func create_texture()->void:
	if(actual_texture == null):
		var square = TextureManager.generate_texture()
		if(has_slot_in_position(0,int(columns/2.0))):
			print("game_over")
		var slot: Slot = get_slot_at_position(0,int(columns/2.0))
		slot.set_square_properties(square)
		actual_texture = slot
	else:
		print("game_over")

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

func calculate_new_position(index: int, direction_x: int, direction_y: int) -> Vector2:
	var current_x:int = int(index / columns)
	var current_y:int = index % columns
	return Vector2(current_x + direction_x, current_y + direction_y)

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
	var movement  = move_slot(actual_texture,0,1)
	if(movement is not int):
		actual_texture = movement

func move_right():
	var movement = move_slot(actual_texture,0,-1)
	if(movement is not int):
		actual_texture = movement


func move_all_down():
	for i in range(slots.size()-1,0,-1):
		if(slots[i].get_texture()!=null):
			var new_slot = move_down(slots[i])
			if(slots[i]==actual_texture):
				actual_texture = new_slot
				if(actual_texture==null):
					create_texture()
