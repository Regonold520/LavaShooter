extends Area2D

var speed = 350

func _ready():
	$Sprite2D.texture = load("res://Sprites/Weapons/Ammo/" + GunVars.AmmoType + '_Ammo.png')
func _process(delta):
	var move_vec = Vector2(speed, 0).rotated(rotation)
	position += move_vec * delta


func _on_area_entered(area):
	area.get_parent().OnHit()
	queue_free()
