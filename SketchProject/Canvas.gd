extends Node

onready var newLine = load("res://Line.tscn")
var currentColor
var currentWidth
var parent

func _ready():
	parent = get_parent().get_parent().get_parent()
	currentColor = Color("#000000")
	currentWidth = 4
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		var line = newLine.instance()
		if(parent.sav == false):
			line.default_color = currentColor
			line.width = currentWidth
			add_child(line)
			
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
