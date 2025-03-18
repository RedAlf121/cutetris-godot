extends Timer


func touch_time():
	GlobalTime.touch_time()
	stop() if GlobalTime.TIME_STOPPED else start()
