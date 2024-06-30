extends Node2D

var Bullet = preload("res://bullet.tscn")
var can_shoot = true

@export var cooldown = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ActiveAmmo = GunVars._get_ammo_type()
	var AmmoAmmount = GunVars.get(ActiveAmmo)
	if Input.is_action_just_pressed("Input") and AmmoAmmount > 0 and can_shoot and GunVars.stop_shoot == false:
		$"../../AudioStreamPlayer2D".play()
		$Cooldown.wait_time = cooldown
		_shoot()
		var AmmoDeduction = AmmoAmmount - 1
		GunVars.set(ActiveAmmo, AmmoDeduction)
		can_shoot = false

func _shoot():
	
	$Cooldown.start()
	# Bullet Logic
	var bullet = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $FirePoint.global_position
	bullet.rotation_degrees = global_rotation_degrees - 180
	
	# Anim
	var tween = create_tween()
	tween.tween_property($GunSprite, 'rotation_degrees', 45.0, 0.035).from_current()
	await get_tree().create_timer(0.035).timeout
	tween = create_tween()
	tween.tween_property($GunSprite, 'rotation_degrees', 0.0, 0.5).from_current().set_ease(Tween.EASE_OUT)


func _on_cooldown_timeout():
	can_shoot = true
