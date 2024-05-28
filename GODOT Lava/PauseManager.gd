extends Node

@onready var Pv = $"/root/PlayerVariables"

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if Pv.IsPaused == false:
			Pv.IsPaused = true
			get_tree().paused = Pv.IsPaused
		elif Pv.IsPaused == true:
			Pv.IsPaused = false
			get_tree().paused = Pv.IsPaused

		
