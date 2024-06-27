extends Area2D

var speed = 350

func _ready():
	$Sprite2D.texture = load("res://Sprites/Weapons/Ammo/" + GunVars.AmmoType + '_Ammo.png')
func _process(delta):
	var move_vec = Vector2(speed, 0).rotated(rotation)
	position += move_vec * delta


func _on_body_entered(body):
	if body.name != "Player":
		body._on_death()
		body._essence()
		queue_free()
