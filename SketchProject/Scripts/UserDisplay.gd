extends Label


var playerName

func _ready():
	pass # Replace with function body.

func setName(newName):
	playerName = newName
	text = "Sketcher " + playerName
	pass
