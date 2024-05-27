extends CanvasLayer

var idle_finished = false

var is_mouseover_area = false
var is_mouseover_reload = false

var gun_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_gun_idle() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !idle_finished:
		_gun_idle()
		idle_finished = true
	if !PlayerVars.wave_intermission:
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1223,470.25),1)
		
	if PlayerVars.wave_intermission and is_mouseover_area and Input.is_action_just_pressed("Input") and !gun_active:
		gun_active = true
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1011,470.25),1)
	elif PlayerVars.wave_intermission and is_mouseover_area and Input.is_action_just_pressed("Input") and gun_active:
		gun_active = false
		var tween = create_tween()
		tween.tween_property($Container/ReloadHolder,'position',Vector2(1223,470.25),1)
		
	print(is_mouseover_reload)
	if gun_active and is_mouseover_reload and Input.is_action_just_pressed("Input"):
		$"../../Player".find_child('GunPoint').find_child('Gun').cooldown = 0.1
		
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


func _on_reload_holder_mouse_entered():
	is_mouseover_reload = true
	GunVars.stop_shoot = true


func _on_reload_holder_mouse_exited():
	is_mouseover_reload = false
	GunVars.stop_shoot = false
