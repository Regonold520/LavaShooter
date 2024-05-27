extends Area2D

var detected = false
var rand_vector : Vector2
var rng = RandomNumberGenerator.new()
var SPEED : float
var start_finished = false

var drop_scene : PackedScene = preload("res://drop_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = 34
	
	var rand_pos_x = rng.randf_range(-348,1432)
	var rand_pos_y = rng.randf_range(795,-253)
	
	global_position = Vector2(rand_pos_x,rand_pos_y)
	_animation_sequence()

func _animation_sequence():
	var tween = create_tween()
	if PlayerVars.is_paused == false:
		$Signal.modulate.a8 = 0
	$AnimatedSprite2D.modulate.a = 0
	$CollisionShape2D.disabled = true
	
	tween.tween_property($Signal,'modulate:a', 1, 1)
	await get_tree().create_timer(2).timeout
	$CollisionShape2D.disabled = false 
	start_finished = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if detected == true and start_finished == true:
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D,'modulate:a', 1, 0.4).set_ease(Tween.EASE_OUT)
		$Signal.modulate.a8 = 0
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)
		var distance := position.distance_to(player.position)
		var tween_time = distance / SPEED
		
		tween.tween_property($".",'position', player.position,tween_time)



func _update_anim(player):
	if player.position > position:
		$AnimatedSprite2D.scale.x = -0.184
	if player.position < position:
		$AnimatedSprite2D.scale.x = 0.184
	

func _on_detection_body_entered(body):
	detected = true


func _on_detection_body_exited(body):
	detected = false


func _on_body_entered(body):
	_on_death()
	PlayerVars.Health -= 10
	
func _essence():
	for i in 2:
		var essence = PlayerVars.Essence.instantiate()
		essence.position = position
		get_tree().current_scene.add_child(essence)
		
func _on_death():
	var audio = Enemies.enemy_audio.instantiate()
	get_tree().current_scene.add_child(audio)
	
	queue_free()
	
	var drop1 = drop_scene.instantiate()
	var drop2 = drop_scene.instantiate()
	get_tree().current_scene.add_child(drop1)
	get_tree().current_scene.add_child(drop2)
	
	drop1.position = position + Vector2(45,0)
	drop2.position = position + Vector2(-45,0)
	
	var signal1 = drop1.find_child('Signal')
	var signal2 = drop2.find_child('Signal')
	
	signal1.modulate.r8 = 0
	signal1.modulate.g8 = 140
	signal1.modulate.b8 = 255
	
	signal2.modulate.r8 = 0
	signal2.modulate.g8 = 140
	signal2.modulate.b8 = 255
