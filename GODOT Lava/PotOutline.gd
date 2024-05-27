extends Area2D

var mouse_over = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pot.visible = PlayerVars.wave_intermission
	if PlayerVars.wave_intermission and mouse_over and Input.is_action_just_pressed("Input"):
		var pot = load("res://pot.tscn").instantiate()
		pot.position = position
		$"..".add_child(pot)
		if PlayerVars.pot_i < PlayerVars.max_pots:
			PlayerVars.pot_i += 1
			var next_pot = "PotOutline" + str(PlayerVars.pot_i)
			$"..".find_child(next_pot).visible = true
		queue_free()
	
func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false 
