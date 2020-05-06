extends Line2D

var timer

func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_released("LeftClick")):
		rpc("stopTimers")

func _on_Timer_timeout():
	if(Input.is_action_pressed("LeftClick")): #Here just for demo
		addPoint(get_global_mouse_position()) #mouse is the cause of the problem
	timer.start()
	pass # Replace with function body.

func addPoint(pos):
	rpc("addPointRPC", pos)
	pass

remotesync func stopTimers():
	timer.stop()
	pass

remotesync func addPointRPC(pos):
	if(0 < pos.x and pos.x < 1024 and 0 < pos.y and pos.y < 600):
		add_point(pos)
		print("pos: ", pos)
	pass
