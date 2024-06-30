extends Area2D

var speed = 350
var expiration = 20


func _ready():
	$Sprite2D.texture = load("res://Sprites/Weapons/Ammo/" + GunVars.AmmoType + '_Ammo.png')
	$Timer.wait_time = expiration
	$Timer.start()

func _process(delta):
	var move_vec = Vector2(speed, 0).rotated(rotation)
	position += move_vec * delta


func _on_body_entered(body):
	if body.get_meta("type") == "enemy":
		body._on_death()
		body._essence()
		
	queue_free()
	


func _on_timer_timeout():
	queue_free()
