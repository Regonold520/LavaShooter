extends Area2D

var mouse_over = false 
var prices = [0,40,60,90]

@onready var Pv = $"/root/PlayerVariables"
var pot = preload("res://pot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Pv.PotI == 1:
		var next_pot = "PotOutline" + str(Pv.PotI)
		var price_text = $"..".find_child(next_pot).find_child('Price')
		price_text.text = '[center]' + str(prices[Pv.PotI])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pot.visible = Pv.WaveIntermission
	$"Price".visible = Pv.WaveIntermission
	if Pv.WaveIntermission and mouse_over and Input.is_action_just_pressed("Input") and prices[Pv.PotI] <= Pv.EssenceStat:
		var LocalPot = pot.instantiate()
		Pv.EssenceStat -= prices[Pv.PotI]
		LocalPot.position = position
		$"..".add_child(LocalPot)
		if Pv.PotI < Pv.MaxPots:
			Pv.PotI += 1
			var next_pot = "PotOutline" + str(Pv.PotI)
			$"..".find_child(next_pot).visible = true
			var price_text = $"..".find_child(next_pot).find_child('Price')
			price_text.text = '[center]' + str(prices[Pv.PotI])
		queue_free()
	
func _on_mouse_entered():
	mouse_over = true
	GunVars.stop_shoot = true

func _on_mouse_exited():
	mouse_over = false
	GunVars.stop_shoot = false
