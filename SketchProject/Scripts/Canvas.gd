extends Control

onready var newLine = load("res://Scenes/Line.tscn")
var currentColor
var currentWidth
var parent
var Lines = []
var eraser = false
var currentName = 0

func _ready():
	parent = get_parent().get_parent().get_parent()
	currentColor = Color("#000000")
	currentWidth = 4
	pass
	
func _process(delta):
	if(Input.is_action_just_pressed("LeftClick")):
		if(parent.sav == false):
			createLine()
			#print(line.name)
		if(eraser == true):
			eraseLine()

#not used
func checkPos(): 
	var mousePos = get_local_mouse_position()
	if(0 < mousePos.x and mousePos.x < 1024 and 0 < mousePos.y and mousePos.y < 600):
		return true
	return false
	pass

func createLine():
	if(checkPos()):
		var line = newLine.instance()
		line.name = str(get_tree().get_network_unique_id()) + str(currentName)
		currentName = currentName + 1
		line.default_color = currentColor
		line.width = currentWidth
		add_child(line)
		Lines.append(line.name)
		rpc("drawLine", line.name, currentColor, currentWidth)
	pass

remote func drawLine(newName, newColor, newWidth):
	var line = newLine.instance()
	line.name = newName
	line.default_color = newColor
	line.width = newWidth
	add_child(line)
	Lines.append(line.name)
	pass

func undoLine():
	rpc("undoLineRPC")
	pass

remotesync func undoLineRPC():
	if(Lines.size() >= 1):
		get_node(Lines.back()).queue_free()
		Lines.pop_back()
	pass

func eraseLine():
		#return the name of the pressed line
		#remove_child(line)
	pass
	
func clearBoard():
	rpc("clearBoardRPC")
	pass

remotesync func clearBoardRPC():
	for child in get_children():
		child.queue_free()
		Lines.pop_back()
	pass

func setColor(newColor):
	currentColor = newColor
	pass
	
func setWidth(newWidth):
	currentWidth = newWidth
	pass

func getColor():
	return currentColor
	
func getWidth():
	return currentWidth
