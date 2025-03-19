extends Node


var score: int
var max_score: int

func increase_score(value: int)->void:
	score+=value
	if max_score<=score:
		max_score=score
		var config = ConfigFile.new()
		config.set_value("general","max_score",max_score)
		config.save("user://settings.cfg")

func debug_score():
	print(max_score," ", Config.new().get_config("general","max_score",-1))

func load_points():
	var config = Config.new()
	var stored_score = config.get_config("general","max_score",-1)
	if(max_score<stored_score):
		max_score=stored_score
