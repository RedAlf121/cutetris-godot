class_name GameTimer extends Timer

@export var fast_wait_time: float = 0.3
@onready var temp_wait_time = self.wait_time
var amount_time_stopped = 0

signal stopping_time

func touch_time():
	GlobalTime.touch_time()
	emit_signal("stopping_time")
	if GlobalTime.TIME_STOPPED:
		stop()
		amount_time_stopped+=1  
	else: 
		start()
	


func accelerate() -> void:
	wait_time = fast_wait_time

func normalize():
	wait_time = temp_wait_time
