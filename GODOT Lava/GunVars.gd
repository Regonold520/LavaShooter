extends Node

@export var AmmoType = 'Carrot'

@export var Carrots = 99999

var stop_shoot = false

func _get_ammo_type():
	if AmmoType == 'Carrot':
		return 'Carrots'
