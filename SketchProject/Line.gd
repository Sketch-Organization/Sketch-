extends Line2D

var timer
var pos
var posPrev

func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_released("LeftClick")):
		timer.stop()

func _on_Timer_timeout():
	posPrev = pos
	pos = getMousePos()
	rpc("addPoint", posPrev, pos)
	timer.start()
	pass # Replace with function body.

remotesync func addPoint(pointA, pointB):
	posPrev = pointA
	pos = pointB
	add_point(pos)
	pass

func getMousePos():
	return get_global_mouse_position()
