extends Line2D

var timer

func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_released("LeftClick")):
		timer.stop()

func _on_Timer_timeout():
	addPoint(get_global_mouse_position())
	timer.start()
	pass # Replace with function body.

func addPoint(pos):
	if(0 < pos.x and pos.x < 1024 and 0 < pos.y and pos.y < 600):
		add_point(pos)
		pass
	pass
