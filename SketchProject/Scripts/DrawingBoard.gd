extends Control

var scene_path_to_load
var exitPopup
var leftUI
var rightUI
var board
var sav
var fileSaver
var playerList
var usersShown = false

func _ready():
	fileSaver = get_node("FileDialog")
	leftUI = get_node("SettingsUIHBox/SettingsUI")
	rightUI = get_node("SettingsUIHBox/UtensilEditor")
	board = get_node("SettingsUIHBox/DrawingBoard/Board")
	exitPopup = get_node("ExitPopup")
	playerList = get_node("WindowDialog/MarginContainer/ScrollContainer/UsersVBox")
	fileSaver.add_button("CANCEL", true, "CANCEL")
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	if(FilePath.loadedFile):
		board.loadData(FilePath.getFilePath())
	updateUsers()
	pass

func _client_connected(id):
	print("Player ", id, " connected to the server!")
	Globals.playerIDs.append(id)
	if(get_tree().is_network_server()):
		rpc("updatePlayers", Globals.playerIDs, Globals.boardName)
		updateUsers()
	pass

func _client_disconnected(id):
	print("Player: ", id, " disconnected from the server!")
	Globals.playerIDs.erase(id)
	if(get_tree().is_network_server()):
		rpc("updatePlayers", Globals.playerIDs, Globals.boardName)
		updateUsers()
	pass

func _connected_ok():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

remote func updatePlayers(info, newBoardName):
	Globals.playerIDs = info
	Globals.boardName = newBoardName
	updateUsers()

func updateUsers():
	playerList.clearChildren()
	for player in Globals.playerIDs:
		playerList.addPlayer(str(player))
	pass

func _close_server():
	print("closed server")
	#kick players
	for i in Globals.playerIDs:
		if(i == null):
			break
		if i != 1:
			print(i)
			rpc_id(i,"kicked", "Server Closed")
			get_tree().network_peer.disconnect_peer(i)
	Globals.playerIDs.clear()
	#Terminate server
	get_tree().network_peer.close_connection(100)
	get_tree().set_network_peer(null)
	pass

remote func kicked(reason):
	get_tree().network_peer.disconnect_peer(get_tree().get_network_unique_id())
	print("You have been kicked from the server, reason: ", reason)

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

func _on_UsersButton_button_up():
	if(usersShown == false):
		get_node("WindowDialog").show()
		usersShown = true
	else:
		get_node("WindowDialog").hide()
		usersShown = false
	pass # Replace with function body.

func _on_YesButton_button_up():
	if(is_network_master()):
		_close_server()
	else:
		get_tree().network_peer.close_connection(100)
		get_tree().set_network_peer(null)
	get_tree().change_scene("res://Scenes/Title.tscn")
	pass # Replace with function body.

func _on_WindowDialog_mouse_entered():
	board.stopDrawing()
	pass # Replace with function body.

func _on_WindowDialog_mouse_exited():
	board.resumeDrawing()
	pass # Replace with function body.

func _on_Control_mouse_exited():
	get_viewport().warp_mouse(Vector2(0,0))
	print("Gmouse pos: ", get_global_mouse_position())
	pass # Replace with function body.
