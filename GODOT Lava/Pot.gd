extends Area2D

var mouse_over = false
var cycle = false
var cycle_finished = false

var crop = ''
var count = 0
var crop_path = "res://Sprites/Farming/Crops/"

func _ready():
	pass # Replace with function body.

func _process(delta):
	if cycle == false:
		_grow_cycle()
	
	if cycle_finished:
		_finished_cycle()

func _on_mouse_entered():
	mouse_over = true
	GunVars.stop_shoot = true

func _on_mouse_exited():
	mouse_over = false 
	GunVars.stop_shoot = false
	
func _grow_cycle():
	cycle = true
	cycle_finished = false
	if GunVars.AmmoType == 'Carrot':
		crop = 'Carrot'
	
	for i in 4:
		count = count + 1
		
		$Pot/Crop.texture = load(crop_path + crop + '_' + str(count) + '.png')
		
		if count == 4:
			await get_tree().create_timer(0.35).timeout
			cycle_finished = true
			
		await get_tree().create_timer(0.35).timeout

func _finished_cycle():
	var ActiveAmmo = GunVars._get_ammo_type()
	var AmmoAmmount = GunVars.get(ActiveAmmo)
	if PlayerVars.is_paused == false:
		var AmmoChange = AmmoAmmount + 1
		GunVars.set(ActiveAmmo, AmmoChange)
	cycle = false
	cycle_finished = false
	$Pot/Crop.texture = load(crop_path + crop + '_' + str(1) + '.png')
	count = 0
