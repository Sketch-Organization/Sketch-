extends Control

var hostPopupMenu
var joinPopupMenu
var fileOpenner
var connFailPopupMenu
var scene_path_to_load
var connStatus

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hostPopupMenu = get_node("HostPopup")
	joinPopupMenu = get_node("JoinPopup")
	fileOpenner = get_node("FileDialog")
	connFailPopupMenu = get_node("connFailPop")
	FilePath.loadedFile = false
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
	connFailPopupMenu.hide()
	pass # Replace with function body.


func _on_CreateButton_pressed():
	_on_Button_pressed("res://DrawingBoard.tscn")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(4242, 4)
	get_tree().set_network_peer(peer)
	pass # Replace with function body.

func _on_JoinBoardButton_pressed():
	var IP = $JoinPopup/Form/inputIP.text
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(IP, 4242)
	connStatus = peer.get_connection_status()
	if connStatus == 0:
		connFailPopupMenu.show()
	else:
		_on_Button_pressed("res://DrawingBoard.tscn")
		get_tree().set_network_peer(peer)
	pass # Replace with function body.

func _on_LoadButton_pressed():
	fileOpenner.show()
	pass # Replace with function body.

func _on_FileDialog_confirmed():
	FilePath.setFilePath(fileOpenner.current_path)
	_on_CreateButton_pressed()
	pass # Replace with function body.
