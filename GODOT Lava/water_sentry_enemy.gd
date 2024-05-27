extends Area2D

var detected = false
var rand_vector : Vector2
var rng = RandomNumberGenerator.new()
var SPEED : float
var start_finished = false
var is_start

var possible_spawns = [Enemies.drop]

var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = randf_range(15,25)
	
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
	if start_finished == false:
		$CollisionShape2D.disabled = true
	if detected == true and start_finished == true:
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D,'modulate:a', 1, 0.4).set_ease(Tween.EASE_OUT)
		$Signal.modulate.a8 = 0
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)

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
	PlayerVars.Health -= 5
	
func _on_death():
	health -= 1
	var player = get_tree().current_scene.find_child('Player')
	player.find_child('EnemyDeath').play()
	
	if health == 0:
		queue_free()

func _essence():
	if health == 0:
		for i in 3:
			var essence = PlayerVars.Essence.instantiate()
			essence.position = position
			get_tree().current_scene.add_child(essence)
	

func _on_spawn_timer_timeout():
	possible_spawns.shuffle()
	var spawn = possible_spawns[0].instantiate()
	get_tree().current_scene.add_child(spawn)
	spawn.position = position
	
	var signal1 = spawn.find_child('Signal')
	
	signal1.modulate.r8 = 0
	signal1.modulate.g8 = 140
	signal1.modulate.b8 = 255
	
	signal1.position.y = 4
	signal1.scale = Vector2(0.202,0.162)
