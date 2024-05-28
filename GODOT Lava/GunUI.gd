extends CanvasLayer

var idle_finished = false

var is_mouseover_area = false
var is_mouseover_smg = false
var is_mouseover_pistol = false

var smg_bought = false

var gun_active = false

@onready var Pv = $"/root/PlayerVariables"

# Called when the node enters the scene tree for the first time.
func _ready():
	_gun_idle() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !idle_finished:
		_gun_idle()
		idle_finished = true
	if !Pv.WaveIntermission:
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1223,470.25),0.25).set_ease(Tween.EASE_OUT)
		
	if Pv.WaveIntermission and is_mouseover_area and Input.is_action_just_pressed("Input") and !gun_active:
		gun_active = true
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1011,470.25),0.25).set_ease(Tween.EASE_OUT)
	elif Pv.WaveIntermission and is_mouseover_area and Input.is_action_just_pressed("Input") and gun_active:
		gun_active = false
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1223,470.25),0.25).set_ease(Tween.EASE_OUT)
		
	if gun_active and is_mouseover_smg and Input.is_action_just_pressed("Input") and smg_bought:
		$"../../Player".find_child('GunPoint').find_child('Gun').cooldown = 0.35
		$"../../Player".find_child('GunPoint').find_child('Gun').Active_gun = "Smg"
		
	if gun_active and is_mouseover_smg and Input.is_action_just_pressed("Input") and !smg_bought and Pv.EssenceStat >= 100:
		Pv.EssenceStat -= 100
		smg_bought = true
		$Container/ReloadHolder/SmgArea/Label.visible = false
		
	$Container/TextureHolder/GunTexture.texture = $"../../Player".find_child('GunPoint').find_child('Gun').find_child('GunSprite').texture
		
	if gun_active and is_mouseover_pistol and Input.is_action_just_pressed("Input"):
		$"../../Player".find_child('GunPoint').find_child('Gun').cooldown = 1
		$"../../Player".find_child('GunPoint').find_child('Gun').Active_gun = "Pistol"
		
		
func _gun_idle():
	var tween = create_tween()
	tween.tween_property($Container/TextureHolder/GunTexture,'rotation_degrees',25,3.75)
	await get_tree().create_timer(3.75).timeout
	
	tween = create_tween()
	tween.tween_property($Container/TextureHolder/GunTexture,'rotation_degrees',-25,7.5)
	await get_tree().create_timer(7.5).timeout
	
	tween.tween_property($Container/TextureHolder/GunTexture,'rotation_degrees',0,3.75)
	
	idle_finished = false


func _on_texture_holder_mouse_entered():
	is_mouseover_area = true
	GunVars.stop_shoot = true

func _on_texture_holder_mouse_exited():
	is_mouseover_area = false
	GunVars.stop_shoot = false




func _on_smg_area_mouse_entered():
	is_mouseover_smg = true
	GunVars.stop_shoot = true


func _on_smg_area_mouse_exited():
	is_mouseover_smg = false
	GunVars.stop_shoot = false


func _on_pistol_area_mouse_entered():
	is_mouseover_pistol = true
	GunVars.stop_shoot = true


func _on_pistol_area_mouse_exited():
	is_mouseover_pistol = false
	GunVars.stop_shoot = false
