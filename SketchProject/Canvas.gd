extends Node

onready var newLine = load("res://Line.tscn")
var currentColor
var currentWidth
var parent
var Lines = []
var eraser = false

func _ready():
	parent = get_parent().get_parent().get_parent()
	currentColor = Color("#000000")
	currentWidth = 4
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		if(parent.sav == false):
			rpc("draw")
		if(eraser == true):
			eraseLine()
	
	if Input.is_action_just_released("LeftClick"):
		if(parent.sav == false):
			var lastLine = Lines.back()
			rpc("add_line_to_clients", lastLine)
		
		
func undoLine():
	if Lines.size() > 0:
		get_node(Lines.back()).queue_free()
		Lines.pop_back()
	pass

func eraseLine():
		#return the name of the pressed line
		#remove_child(line)
	pass
	
func clearBoard():
	for child in get_children():
		child.queue_free()
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

remotesync func draw():
	var line = newLine.instance()
	line.default_color = currentColor
	line.width = currentWidth
	add_child(line)
	Lines.append(line.name)
	
remote func add_line_to_clients(lineToAdd):
	add_child(lineToAdd)
	Lines.append(lineToAdd.name)
