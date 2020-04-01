extends Control

var scene_path_to_load
var exitPopup
var gameUI

func _ready():
	gameUI = get_node("SettingsUIHBox")
	exitPopup = get_node("ExitPopup")
	var button = $ExitPopup/MarginContainer/VBoxContainer/HBoxContainer/YesButton
	button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
	pass

func _on_ExitButton_pressed():
	exitPopup.show()
	pass # Replace with function body.


func _on_NoButton_pressed():
	exitPopup.hide()
	pass # Replace with function body.

func _on_SettingsButton_toggled(button_pressed):
	if(button_pressed):
		gameUI.show()
	else:
		gameUI.hide()
	pass # Replace with function body.
