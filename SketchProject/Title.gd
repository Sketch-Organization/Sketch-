extends Control

var hostPopupMenu
var joinPopupMenu
var scene_path_to_load

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hostPopupMenu = get_node("HostPopup")
	joinPopupMenu = get_node("JoinPopup")
	pass # Replace with function body.

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
	pass

func _on_HostButton_pressed():
	hostPopupMenu.show()
	pass # Replace with function body.


func _on_JoinButton_pressed():
	joinPopupMenu.show()
	pass # Replace with function body.


func _on_CloseButton_pressed():
	hostPopupMenu.hide()
	joinPopupMenu.hide()
	pass # Replace with function body.


func _on_CreateButton_pressed():
	_on_Button_pressed("res://DrawingBoard.tscn")
	pass # Replace with function body.


func _on_JoinBoardButton_pressed():
	pass # Replace with function body.
