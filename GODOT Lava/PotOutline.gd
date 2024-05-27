extends Area2D

var mouse_over = false 
var prices = [0,40,60,90]

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerVars.pot_i == 1:
		var next_pot = "PotOutline" + str(PlayerVars.pot_i)
		var price_text = $"..".find_child(next_pot).find_child('Price')
		price_text.text = '[center]' + str(prices[PlayerVars.pot_i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pot.visible = PlayerVars.wave_intermission
	$"Price".visible = PlayerVars.wave_intermission
	if PlayerVars.wave_intermission and mouse_over and Input.is_action_just_pressed("Input") and prices[PlayerVars.pot_i] <= PlayerVars.Essence_stat:
		PlayerVars.Essence_stat -= prices[PlayerVars.pot_i]
		var pot = load("res://pot.tscn").instantiate()
		pot.position = position
		$"..".add_child(pot)
		if PlayerVars.pot_i < PlayerVars.max_pots:
			PlayerVars.pot_i += 1
			var next_pot = "PotOutline" + str(PlayerVars.pot_i)
			$"..".find_child(next_pot).visible = true
			var price_text = $"..".find_child(next_pot).find_child('Price')
			price_text.text = '[center]' + str(prices[PlayerVars.pot_i])
		queue_free()
	
func _on_mouse_entered():
	mouse_over = true
	GunVars.stop_shoot = true

func _on_mouse_exited():
	mouse_over = false
	GunVars.stop_shoot = false
