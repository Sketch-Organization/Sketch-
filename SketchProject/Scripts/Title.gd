extends Control

var hostPopupMenu
var joinPopupMenu
var fileOpenner
var scene_path_to_load
const PORT = 1234
const MAX_PLAYERS = 4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hostPopupMenu = get_node("HostPopup")
	joinPopupMenu = get_node("JoinPopup")
	fileOpenner = get_node("FileDialog")
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	FilePath.loadedFile = false
	pass # Replace with function body.

func _client_connected(id):
	print("Player ", id, " connected to the server!")
	Globals.playerIDs.append(id)
	if(get_tree().is_network_server()):
		rpc_id(id, "register_player", Globals.playerIDs, Globals.boardName)
	pass

func _client_disconnected(id):
	print("Player: ", id, " disconnected from the server!")
	Globals.playerIDs.erase(id)
	if(get_tree().is_network_server()):
		rpc_id(id, "register_player", Globals.playerIDs, Globals.boardName)
	pass

func _connected_ok():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

remote func register_player(info, newBoardName):
	Globals.playerIDs = info
	Globals.boardName = newBoardName

func hostServer():
	print("hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(PORT,MAX_PLAYERS)
	if(res != OK):
		print("Error creating server")
		return
	get_tree().set_network_peer(host)
	Globals.playerIDs.append(get_tree().get_network_unique_id())
	pass

func joinServer():
	var newIP = get_node("JoinPopup/Form/LineEdit").text
	if(newIP.is_valid_ip_address()):
		print("joining network")
		var peer = NetworkedMultiplayerENet.new()
		peer.create_client(newIP, PORT)
		get_tree().set_network_peer(peer)
	pass

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
	Globals.boardName = get_node("HostPopup/Form/LineEdit").text
	hostServer()
	_on_Button_pressed("res://Scenes/DrawingBoard.tscn")
	pass # Replace with function body.

func _on_JoinBoardButton_pressed():
	joinServer()
	_on_Button_pressed("res://Scenes/DrawingBoard.tscn")
	pass # Replace with function body.

func _on_LoadButton_pressed():
	fileOpenner.show()
	pass # Replace with function body.

func _on_FileDialog_confirmed():
	FilePath.setFilePath(fileOpenner.current_path)
	_on_CreateButton_pressed()
	pass # Replace with function body.
