extends Enemy

func _on_death():
	health -= 1
	
	if health == 0:
		death_count += 1
		
		if death_count == 1:
			var player = get_tree().current_scene.find_child('Player')
			player.find_child('EnemyDeath').play()
			
			get_parent().find_child("RoomHolder").get_child(0).completed_enemies += 1
			
			var pipe_scene : PackedScene = load("res://small_pipe_floor.tscn")
			
			var pipe = pipe_scene.instantiate()
			
			get_tree().current_scene.find_child("RoomHolder").get_child(0).add_child(pipe)
			
			pipe.global_position = global_position
			
			pipe.enemy_pool = [Enemies.drop]
			pipe.wait_time = 0.0
			pipe.total_enemies = 3
			
			pipe.find_child("WaterSprite").play()
			
			pipe.find_child("PipeSprite").queue_free()
			
			queue_free()
