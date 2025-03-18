extends Node


var TIME_STOPPED = false

func stop_time():
	TIME_STOPPED = false

func start_time():
	TIME_STOPPED = true

func touch_time():
	TIME_STOPPED = !TIME_STOPPED
