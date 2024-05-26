extends Node2D

var bullet_scene = preload("res://bullet.tscn")

func _on_player_shoot(pos):
	var bullet = bullet_scene.instantiate()
	$"..".add_child(bullet)
	bullet.position = pos
