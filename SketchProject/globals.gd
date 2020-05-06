extends Node

var players = []

func _ready():
	get_tree().connect("network_peer_connected", self, "_playerConnected")
	get_tree().connect("network_peer_disconnected", self, "_playerDisconnected")
	pass
	
func _playerConnected(id):
	players.append(id)

func _playerDisconnected(id):
	players.erase(id)
	
