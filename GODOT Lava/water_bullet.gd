extends Area2D

var speed = 300

func _process(delta):
	var move_vec = Vector2(speed, 0).rotated(rotation)
	position += move_vec * delta

func _on_body_entered(body):
	if body.get_meta("type") == "player":
		PlayerVars.Health -= 5
		body.find_child("EnemyDeath").play()
		queue_free()
		
	if body.get_meta("type") != "player":
		queue_free()
