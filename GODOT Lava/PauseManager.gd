extends Node

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if PlayerVars.is_paused == false:
			PlayerVars.is_paused = true
			get_tree().paused = PlayerVars.is_paused
		elif PlayerVars.is_paused == true:
			PlayerVars.is_paused = false
			get_tree().paused = PlayerVars.is_paused

		
