extends Control

var scene_path_to_load
var exitPopup
var leftUI
var rightUI
var board
var sav
var fileSaver

func _ready():
	fileSaver = get_node("FileDialog")
	leftUI = get_node("SettingsUIHBox/SettingsUI")
	rightUI = get_node("SettingsUIHBox/UtensilEditor")
	board = get_node("SettingsUIHBox/DrawingBoard/Board")
	exitPopup = get_node("ExitPopup")
	fileSaver.add_button("CANCEL", true, "CANCEL")
	var button = $ExitPopup/MarginContainer/VBoxContainer/HBoxContainer/YesButton
	button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass

func _on_Button_pressed(scene_to_load):
	board.resumeDrawing()
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
	pass

func _on_ExitButton_pressed():
	board.stopDrawing()
	exitPopup.show()
	pass # Replace with function body.

func _on_NoButton_pressed():
	board.resumeDrawing()
	exitPopup.hide()
	pass # Replace with function body.

func _on_SettingsButton_toggled(button_pressed):
	if(!button_pressed):
		leftUI.show()
		rightUI.show()
	else:
		leftUI.hide()
		rightUI.hide()
	pass # Replace with function body.

func _on_ColorPickerButton_color_changed(color):
	board.setUtensilColor(color)
	pass

func _on_SpinBox_value_changed(value):
	board.setUtensilWidth(value)
	pass # Replace with function body.

func _on_FileDialog_confirmed():
	board.saveData(fileSaver.current_path)
	board.resumeDrawing()
	pass # Replace with function body.

func _on_SaveButton_button_up():
	board.stopDrawing()
	fileSaver.show()
	fileSaver.get_cancel().hide()
	fileSaver.get_close_button().hide()
	pass # Replace with function body.

func _on_FileDialog_custom_action(action):
	if(action == "CANCEL"):
		fileSaver.hide()
		board.resumeDrawing()
	pass # Replace with function body.

func _on_VBoxContainer2_mouse_entered():
	board.stopDrawing()
	pass # Replace with function body.

func _on_VBoxContainer2_mouse_exited():
	board.resumeDrawing()
	pass # Replace with function body.

func _on_EraserButton_toggled(button_pressed):
	board.stopDrawing()
	pass # Replace with function body.
	
func _on_ClearButton_button_up():
	board.clearEverything()
	pass # Replace with function body.

func _on_UndoButton_button_up():
	board.undoALine()
	pass # Replace with function body.
