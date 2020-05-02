extends Control

var scene_path_to_load
var exitPopup
var leftUI
var rightUI
var board
var sav
var fileSaver

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	if(Globals.host):
		#hostGame
		print("hosting")
		hostServer()
	elif(Globals.join):
		#joinGame
		print("joining")
		joinServer(Globals.IPtoJoin)
	else:
		print("couldn't not host or join")
	
	fileSaver = get_node("FileDialog")
	leftUI = get_node("SettingsUIHBox/SettingsUI")
	rightUI = get_node("SettingsUIHBox/UtensilEditor")
	board = get_node("SettingsUIHBox/DrawingBoard/Board")
	exitPopup = get_node("ExitPopup")
	fileSaver.add_button("CANCEL", true, "CANCEL")
	if(FilePath.loadedFile):
		board.loadData(FilePath.getFilePath())
	pass

func _player_connected(id):
	print("Player ", id, " connected to the server!")
	Globals.otherPlayerId = id

func hostServer():
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(1234,2)
	if(res != OK):
		print("Error creating server")
		return
	get_tree().set_network_peer(host)
	set_network_master(get_tree().get_network_unique_id())
	pass

func joinServer(newIP):
	var host = NetworkedMultiplayerENet.new()
	host.create_client(newIP,1234)
	get_tree().set_network_peer(host)
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

func _on_YesButton_button_up():
	_close_server()
	pass # Replace with function body.

func _close_server():
	#kick players
	for i in Globals.numPlayers:
		if i != 1:
			print(i)
			rpc_id(i,"kicked", "Server Closed")
			get_tree().network_peer.disconnect_peer(i)
	Globals.numPlayers.clear()
	#Terminate server
	get_tree().set_network_peer(null)
	emit_signal("server_stopped")
	get_tree().get_nodes_in_group("Level")[0].queue_free()
	_on_Button_pressed("res://Title.tscn")
	pass

remote func kicked(reason):
	get_tree().network_peer.disconnect_peer(Globals.otherPlayerId)
	print("You have been kicked from the server, reason: ", reason)
