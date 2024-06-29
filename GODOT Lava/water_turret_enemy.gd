extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var start_finished = false

@export var finish_frame = 0

var Bullet : PackedScene = preload("res://water_bullet.tscn")

@export var speed = 75
var acceleration = 11
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "Rise"
	get_tree().current_scene.find_child("RoomHolder").get_child(0).enemy_ammount += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.animation == "Rise" and $AnimatedSprite2D.frame == finish_frame:
		$AnimatedSprite2D.animation = "Idle"
		start_finished = true
		
	if $AnimatedSprite2D.animation == "Compress" and $AnimatedSprite2D.frame == 3:
		$AnimatedSprite2D.animation = "Idle"
	
	if !start_finished:
		$Detection/CollisionShape2D.disabled = true
	if start_finished:
		$Detection/CollisionShape2D.disabled = false
	
	if start_finished:
	
		var player = get_tree().current_scene.find_child('Player')
		_update_anim(player)
		
	


func _update_anim(player):
	if player.position > position:
		$AnimatedSprite2D.scale.x = -0.184
	if player.position < position:
		$AnimatedSprite2D.scale.x = 0.184
	

func _on_detection_body_entered(body):
	if body.name == "Player":
		_on_death()
		PlayerVars.Health -= 5
	
func _essence():
	var essence = PlayerVars.Essence.instantiate()
	essence.position = position
	get_tree().current_scene.add_child(essence)
		
func _on_death():
	var audio = Enemies.enemy_audio.instantiate()
	get_tree().current_scene.add_child(audio)
	
	var player = get_tree().current_scene.find_child('Player')
	player.find_child('EnemyDeath').play()
	
	get_parent().find_child("RoomHolder").get_child(0).completed_enemies += 1
	
	queue_free()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_shoot_timer_timeout():
	var player = get_tree().current_scene.find_child('Player').global_position
	
	$AnimatedSprite2D.animation = "Compress"
	
	await get_tree().create_timer(0.5).timeout
	
	var bullet = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.look_at(player)
