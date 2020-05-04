extends Node

var players = []

func _ready():
	get_tree().connect("network_peer_connected", self, "_playerConnected")
	pass
	
func _playerConnected(id):
	players.append(id)
