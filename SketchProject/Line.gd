extends Line2D

var timer

func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_released("LeftClick")):
		timer.stop()

func _on_Timer_timeout():
	addPoint()
	timer.start()
	pass # Replace with function body.
	
func addPoint():
	add_point(get_global_mouse_position())
	pass
