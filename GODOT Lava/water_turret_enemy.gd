extends Enemy

var Bullet : PackedScene = preload("res://water_bullet.tscn")

func _on_shoot_timer_timeout():
	var player = get_tree().current_scene.find_child('Player').global_position
	
	$AnimatedSprite2D.animation = "Compress"
	
	await get_tree().create_timer(0.5).timeout
	
	var bullet = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.look_at(player)

func _on_timer_timeout():
	pass
	
func _process(delta):
	if $AnimatedSprite2D.animation == "Rise" and $AnimatedSprite2D.frame == finish_frame:
		$AnimatedSprite2D.animation = "Idle"
		start_finished = true
		
	if $AnimatedSprite2D.animation == "Compress" and $AnimatedSprite2D.frame == 3:
		$AnimatedSprite2D.animation = "Idle"
	
	if !start_finished:
		$Detection/CollisionShape2D.disabled = true
	if start_finished:
		$Detection/CollisionShape2D.disabled = false
	
	if start_finished:
	
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)
