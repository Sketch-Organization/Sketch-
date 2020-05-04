extends Line2D

var timer
var pos

func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_released("LeftClick")):
		timer.stop()

func _on_Timer_timeout():
	pos = getMousePos()
	addPoint(pos)
	timer.start()
	pass # Replace with function body.

func addPoint(mousePos):
	add_point(mousePos)
	pass

func getMousePos():
	return get_viewport().get_mouse_position()
