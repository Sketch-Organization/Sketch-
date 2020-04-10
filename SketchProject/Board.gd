extends Control

onready var canvas = get_node("ViewportContainer/Viewport/Canvas")

var sav = false
var fileSaver

func _ready():
#	fileSaver = get_node("FileDialog")
	pass # Replace with function body.

func _on_Button_button_up():
	sav = true
	fileSaver.show()
	pass # Replace with function body.

func _on_ViewportContainer_resized():
#	viewport.set_size(get_size())
	pass # Replace with function body.

func setUtensilColor(newColor):
	canvas.setColor(newColor)
	pass

func setUtensilWidth(newWidth):
	canvas.setWidth(newWidth)
	pass

func saveData(path):
	var img = get_node("ViewportContainer/Viewport").get_texture().get_data()
	img.save_png(path)
	pass

func stopDrawing():
	sav = true

func resumeDrawing():
	sav = false

func clearEverything():
	canvas.clearBoard()
	pass

func undoALine():
	canvas.undoLine()
	pass

func _on_ClearButton_button_up():
	clearEverything()
	pass # Replace with function body.

func _on_UndoButton_button_up():
	undoALine()
	pass # Replace with function body.
