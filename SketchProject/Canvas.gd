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
			createLine()
			#print(line.name)
		if(eraser == true):
			eraseLine()

func createLine():
	var line = newLine.instance()
	line.default_color = currentColor
	line.width = currentWidth
	add_child(line)
	Lines.append(line.name)
	pass

func undoLine():
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
