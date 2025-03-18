extends Node


var texture_routes = {
	"automatica": [
		"res://imgs/logos/automatica y biomedica/00.jpeg",
		"res://imgs/logos/automatica y biomedica/01.jpeg",
		"res://imgs/logos/automatica y biomedica/10.jpeg",
		"res://imgs/logos/automatica y biomedica/11.jpeg"
		],
	"civil": [
		"res://imgs/logos/civil/00.png",
		"res://imgs/logos/civil/01.png",
		"res://imgs/logos/civil/10.png",
		"res://imgs/logos/civil/11.png"
		],
	"electrica": [
		"res://imgs/logos/electrica/00.jpeg",
		"res://imgs/logos/electrica/01.jpeg",
		"res://imgs/logos/electrica/10.jpeg",
		"res://imgs/logos/electrica/11.jpeg"
		],
	"industrial": [
		"res://imgs/logos/industrial/00.jpeg",
		"res://imgs/logos/industrial/01.jpeg",
		"res://imgs/logos/industrial/10.jpeg",
		"res://imgs/logos/industrial/11.jpeg"
	],
	"informatica": [
		"res://imgs/logos/informatica/00.png",
		"res://imgs/logos/informatica/01.png",
		"res://imgs/logos/informatica/10.png",
		"res://imgs/logos/informatica/11.png"
	],
	"mecanica": [
		"res://imgs/logos/mecanica/00.png",
		"res://imgs/logos/mecanica/01.png",
		"res://imgs/logos/mecanica/10.png",
		"res://imgs/logos/mecanica/11.png"
	],
	"telecomunicaciones": [
		"res://imgs/logos/telecominicaciones y electronica/00.jpeg",
		"res://imgs/logos/telecominicaciones y electronica/01.jpeg",
		"res://imgs/logos/telecominicaciones y electronica/10.jpeg",
		"res://imgs/logos/telecominicaciones y electronica/11.jpeg"
	]
}


func generate_texture()->Piece:
	var faculties = texture_routes.keys()
	var faculty_name = faculties[randi_range(0,faculties.size()-1)]
	var faculty = create_faculty(faculty_name)
	var faculty_textures = texture_routes[faculty_name]
	var faculty_position = randi_range(0,faculty_textures.size()-1)
	var faculty_route = faculty_textures[faculty_position]
	var faculty_texture = load(faculty_route)
	var region = set_region(faculty_route)
	var square: Piece = Piece.new(faculty_texture,faculty,region)
	return square

func create_faculty(faculty_name: String)->int:
	match faculty_name:
		"automatica":
			return Faculty.AUTOMATICA
		"civil":
			return Faculty.CIVIL
		"electrica":
			return Faculty.ELECTRICA
		"industrial":
			return Faculty.INDUSTRIAL
		"informatica":
			return Faculty.INFORMATICA
		"mecanica":
			return Faculty.MECANICA
		"telecomunicaciones":
			return Faculty.TELECOMUNICACIONES
		_:
			return -1

func set_region(faculty_route: String) -> int:
	# Usar una expresión regular para buscar el número antes del formato de la imagen
	var pattern = r"\d+(?=\.\w+)"
	var regex = RegEx.new()
	regex.compile(pattern)	
	var region_id = regex.search(faculty_route)
	return assign_region(region_id.get_string(0))

func assign_region(region_id: String)->int:
	match(region_id):
		"00": return PieceRegion.TOP_LEFT
		"01": return PieceRegion.BOTTOM_LEFT
		"10": return PieceRegion.TOP_RIGHT
		"11": return PieceRegion.BOTTOM_RIGHT
		_: return -1
