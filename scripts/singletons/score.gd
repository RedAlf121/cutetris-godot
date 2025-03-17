extends Node


var score: int
var max_score: int

func increase_score(value: int)->void:
	score+=value
	if max_score<=score:
		max_score=score
