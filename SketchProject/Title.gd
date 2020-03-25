extends Control

var hostPopupMenu
var joinPopupMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hostPopupMenu = get_node("HostPopup")
	joinPopupMenu = get_node("JoinPopup")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
	pass # Replace with function body.


func _on_JoinBoardButton_pressed():
	pass # Replace with function body.
