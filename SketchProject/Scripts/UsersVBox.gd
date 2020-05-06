extends VBoxContainer

onready var player = load("res://Scenes/UserDisplay.tscn")

var numPlayers


func _ready():
	clearChildren()
	pass

func addPlayer(playerName):
	print("Added player: ", playerName)
	var child = player.instance()
	child.setName(playerName)
	add_child(child)
	pass

func removePlayer(playerName):
	for child in get_children():
		if(child.playerName == playerName):
			remove_child(child)
			print("Removed player: ", playerName)
			break
	pass

func clearChildren():
	for child in get_children():
		child.queue_free()
	pass
