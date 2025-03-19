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


func load_points():
	var config = Config.new()
	print(config.get_config("general","max_score",-1))
	max_score = config.get_config("general","max_score",0)
