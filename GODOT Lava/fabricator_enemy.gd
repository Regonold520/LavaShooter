extends Enemy

var fabrication = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.animation == "Rise" and $AnimatedSprite2D.frame == finish_frame:
		$AnimatedSprite2D.animation = "Idle"
		start_finished = true
		
	if $AnimatedSprite2D.animation == "Create" and fabrication and $AnimatedSprite2D.frame == 4:
		$AnimatedSprite2D.animation = "Idle"
		speed = 50
		
		var turret = Enemies.water_turret.instantiate()
		
		get_tree().current_scene.add_child(turret)
		
		turret.global_position = global_position
	
	if !start_finished:
		$Detection/CollisionShape2D.disabled = true
	if start_finished:
		$Detection/CollisionShape2D.disabled = false
	
	if start_finished:
	
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)
			
		direction = agent.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = velocity.lerp(direction * speed, acceleration * delta)
		
		if agent.avoidance_enabled:
			agent.set_velocity(velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(velocity)
		
		move_and_slide()

func _on_turret_creation_timeout():
	get_tree().current_scene.find_child("RoomHolder").get_child(0).enemy_ammount += 1
	speed = 0
	$AnimatedSprite2D.animation = "Create"
	fabrication = true
